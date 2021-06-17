use anyhow::Result;
use std::process::Command;
use crate::env::Env;
use std::path::PathBuf;

/// Currently use m4 language for macro processing
/// This might change in future
pub struct MProc {
    includes: Vec<PathBuf>,
    sources: Vec<PathBuf>,
    out_file: PathBuf,
    target_file: PathBuf,
}

impl MProc {
    pub fn new(target_file : PathBuf, out_file: PathBuf, includes: Vec<PathBuf>, sources: Vec<PathBuf>) -> Self {
        Self {
            includes,
            out_file,
            target_file,
            sources
        }
    }

    pub fn debug(&self) -> Result<()> {
        let mut args = String::from("m4 -I ");
        let includes = self.includes
            .clone()
            .into_iter()
            .map(|inc| inc.to_str().unwrap().to_owned())
            .collect::<Vec<String>>().join(" -I ");
        args.push_str(&includes); // Push includes
        args.push_str(&format!(" {}", self.target_file.display() ));
        args.push_str(&format!(" > {}", self.out_file.display()));

        Ok(())
    }

    pub fn execute(&self, env: &Env) -> Result<()> {
        let mut args = String::from("m4 -I ");
        let includes = self.includes
            .clone()
            .into_iter()
            .map(|inc| inc.to_str().unwrap().to_owned())
            .collect::<Vec<String>>().join(" -I ");

        let sources = self.sources
            .clone()
            .into_iter()
            .map(|inc| inc.to_str().unwrap().to_owned())
            .collect::<Vec<String>>().join(" ");

        args.push_str(&includes); // Push includes
        args.push_str(" ");
        args.push_str(&sources); // Push includes
        args.push_str(&format!(" {}", self.target_file.display() ));

        let output = Command::new("sh")
            .env("MODULE", env.module())
            .env("SCRIPTS", env.m4().join("scripts"))
            .arg("-c")
            .arg(args)
            .output()
            .expect("failed to execute process");

        // Redirect all output into the out file
        std::fs::write(self.out_file.clone(), &output.stdout)?;

        Ok(())
    }
}
