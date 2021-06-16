use anyhow::Result;
use clap::clap_app;
use fs_extra::{copy_items, dir::CopyOptions};
use std::path::PathBuf;
use std::process::Command;

pub struct Cli {
    working_path : PathBuf,
    bin_path : PathBuf,
}
impl Cli {
    pub fn new() -> Self {
        Self {
            working_path: std::env::current_dir().expect("Failed to get current working directory. This is critical failure ahdn should not happen."),
            bin_path : std::env::current_exe().expect("Failed to get binary path. This is critical failure ahdn should not happen."),

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
             (@arg nodefault: --no-default "Don't use any default macros")
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
            let src_dir = self.bin_path.join("default").join("basic");
            let src_dir = src_dir.to_str().unwrap_or_default();

            let mut copy_option = CopyOptions::new();
            copy_option.copy_inside = true;

            copy_items(&[src_dir], &self.working_path, &copy_option)?;

            // Git option
            if sub_match.is_present("git") {
                // Git init
                Command::new("sh")
                    .arg("-c")
                    .arg("git init")
                    .output()
                    .expect("failed to execute process");
                // Create .gitignore
                std::fs::write(self.working_path.join(".gitignore"), "build")?;
            }

            // Extra default files options
            if sub_match.is_present("code") {
                std::fs::copy(&self.bin_path.join("default").join("extra").join("tasks.json"), &self.working_path)?;
            } 
            if sub_match.is_present("make") {
                std::fs::copy(&self.bin_path.join("default").join("extra").join("Makefile"), &self.working_path)?;
            } 

            // Modules
            if let Some(modules) = sub_match.values_of("modules") {
                // TODO
                // Create new config file 
            } else {
                // TODO
                // Create it anyway
            }
        }

        Ok(())
    }

    fn subcommand_prep(&self, matches: &clap::ArgMatches) -> Result<()> {
        if let Some(sub_match) = matches.subcommand_matches("prep") {

        }

        Ok(())
    }

    /// Render to representation form using marp command
    fn subcommand_repr(&self, matches: &clap::ArgMatches) -> Result<()> {
        if let Some(sub_match) = matches.subcommand_matches("repr") {

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
