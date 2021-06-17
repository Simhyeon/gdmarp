use anyhow::Result;
use clap::clap_app;
use fs_extra::dir::{CopyOptions, copy};
use std::path::PathBuf;
use std::process::Command;
use std::io::{self, Write};

use crate::env::Env;
use crate::mproc::MProc;
use crate::consts::*;
use crate::config::{Module, Config};

pub struct Cli {
    env : Env,
}

impl Cli {
    pub fn new() -> Self {
        Self {
            env : Env::new(),
        }
    }
    pub fn parse(&mut self) -> Result<()>{
        let cli_args = self.args_builder();
        self.parse_subcommands(&cli_args)?;
        Ok(())
    }

    fn parse_subcommands(&self, args: &clap::ArgMatches) -> Result<()> {
        self.subcommand_init(args)?;
        self.subcommand_prep(args)?;
        self.subcommand_repr(args)?;
        Ok(())
    }

    // TODO 
    // List of subcommands
    // init
    // --docker, --container
    // prep
    // render - html
    // render - pdf
    // render - pptx
    // check - dependencies
    // install - Install docker image
    // Miscellaneous flags
    // --preserve, --no default
    fn args_builder(&self) -> clap::ArgMatches {
        clap_app!(Rif =>
            (version: "0.0.2")
            (author: "Simon Creek <simoncreek@tutanota.com>")
            (about: "Gdmarp is a automation script executor for various game design formats")
            (@setting ArgRequiredElseHelp)
            (@subcommand init =>
             (about: "Init gdmarp project")
             (@arg git: --git "Also init git project")
             (@arg code: --code "Also create vs code tasks.json file")
             (@arg make: --make "Also create Makefile")
             (@arg modules: --modules ... +takes_value "Modules to include in config file")
            )
            (@subcommand prep =>
             (about: "Only expand macros and don't render")
            )
            (@subcommand repr =>
             (about: "Render to representation format using marp-cli")
             (@arg pptx: --pptx "Render to pptx")
             (@arg pdf: --pdf "Render to pdf")
             (@arg html: --html "Render to html")
             (@arg preserve: -p --preserve "Render to html")
             (@arg nodefault: --nodefault "Don't use any default macros")
             (@arg noprep: --noprep "Don't preprocess")
            )
            (@subcommand wiki =>
             (about: "Render to wiki page")
             (@arg documize: --documize "Use documize backend")
            )
        ).get_matches()
    }

    fn subcommand_init(&self, matches: &clap::ArgMatches) -> Result<()>{
        if let Some(sub_match) = matches.subcommand_matches("init") {
            // Copy all default basic files into working directory
            let src_dir = self.env.default_basic();

            let mut copy_option = CopyOptions::new();
            copy_option.content_only = true;

            copy(src_dir, &self.env.cwd(), &copy_option)?;

            // Git option
            if sub_match.is_present("git") {
                // Git init
                Command::new("sh")
                    .arg("-c")
                    .arg("git init")
                    .output()
                    .expect("failed to execute process");
                // Create .gitignore
                std::fs::write(self.env.cwd().join(".gitignore"), "build")?;
            }

            // Extra default files options
            if sub_match.is_present("code") {
                std::fs::copy(&self.env.default_extra().join("tasks.json"), &self.env.cwd().join("tasks.json"))?;
            } 
            if sub_match.is_present("make") {
                std::fs::copy(&self.env.default_extra().join("Makefile"), &self.env.cwd().join("Makefile"))?;
            } 

            // Make a new config
            let config_path = self.env.config();
            let mut config = Config::new();

            // Modules
            if let Some(modules) = sub_match.values_of("modules") {
                for item in modules {
                    // If module name is correct then add module to config
                    let module = Module::from_str(item)?;
                    if module != Module::None {
                        config.modules.push(module);
                    }
                }
            }
            config.save_config(&config_path)?;
        }

        Ok(())
    }

    fn subcommand_prep(&self, matches: &clap::ArgMatches) -> Result<()> {
        if let Some(_) = matches.subcommand_matches("prep") {
            self.preprocess()?;
        }

        Ok(())
    }

    fn preprocess(&self) -> Result<()> {
        let config = Config::read_config(&self.env.config())?;
        let mut includes = vec![
            self.env.m4(), 
            self.env.gnu(), 
            self.env.cwd()
        ];
        let mut sources = vec![];

        // Add default 
        sources.push(self.env.m4().join("default.m4"));
        // Include module paths
        for item in config.modules {
            sources.push(self.env.module().join(item.to_path()).join("macro.m4"));
        }

        // Execute macro processing
        MProc::new(
            self.env.cwd().join(INDEX_FILE),
            self.env.cwd().join(MIDDLE_FILE),
            includes,
            sources
        ).execute(&self.env)?;
        Ok(())
    }

    /// Render to representation form using marp command
    fn subcommand_repr(&self, matches: &clap::ArgMatches) -> Result<()> {
        if let Some(sub_match) = matches.subcommand_matches("repr") {
            // Original command 
            // docker run --rm -v "$INPUT":/home/marp/app/ -e LANG="$LANG" marpteam/marp-cli out.md --$FORMAT --allow-local-files --html -o build/out.$FORMAT

            if !sub_match.is_present("noprep") {
                self.preprocess()?;
            }
            let mut format: &str = "pptx";
            if sub_match.is_present("pptx") {
                format = "pptx";
            } else if sub_match.is_present("pdf") {
                format = "pdf";
            } else if sub_match.is_present("html") {
                format = "html";
            }
            if !sub_match.is_present("container") {
                // Gdmarp container usage
                Command::new("sh")
                    .env("marp", "node /home/marp/.cli/marp-cli.js")
                    .env("INPUT", self.env.cwd())
                    .env("FORMAT", format)
                    .arg("-c")
                    .arg("$marp --allow-local-files --$FORMAT --html \"$INPUT\"/out.md -o \"$INPUT\"/build/out.$FORMAT")
                    .output()
                    .expect("failed to execute process");
            } else {
                // This is for marp image usage
                Command::new("sh")
                    .env("INPUT", self.env.cwd())
                    .env("FORMAT", format)
                    .arg("-c")
                    .arg("docker run --rm -v \"$INPUT\":/home/marp/app/ -e LANG=\"$LANG\" -e MARP_USER=\"$(id -u):$(id -g)\" marpteam/marp-cli out.md --$FORMAT --allow-local-files --html -o build/out.$FORMAT")
                    .output()
                    .expect("failed to execute process");
            }

            if !sub_match.is_present("preserve") {
                std::fs::remove_file(self.env.cwd().join(MIDDLE_FILE))?;
            }

        }

        Ok(())
    }

    /// Render to wiki page
    ///
    /// This also includes web interaction which varies by backend wiki
    fn subcommand_wiki(&self, matches: &clap::ArgMatches) -> Result<()> {
        if let Some(sub_match) = matches.subcommand_matches("wiki") {

        }

        Ok(())
    }
}
