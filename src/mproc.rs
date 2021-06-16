use anyhow::Result;
use std::process::Command;
use std::path::PathBuf;

/// Currently use m4 language for macro processing
/// This might change later.
pub struct MProc {
    includes: Vec<PathBuf>,
    out_dir: PathBuf,
}

impl MProc {
    fn prep(target_file : &PathBuf) -> Result<()> {

        // M4 macro process
        Command::new("sh")
            .arg("-c")
            .arg("")
            .output()
            .expect("failed to execute process");

        Ok(())
    }
}
