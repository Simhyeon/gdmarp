use std::path::PathBuf;

pub struct Env{
    cwd : PathBuf,
    bin : PathBuf,
}

impl Env {
    pub fn new() -> Self {
        // Only gets binary directory without real path, program name
        let mut bin = std::env::current_exe().expect("Failed to get binary path. This is mostly IO or permission error");
        bin.pop();

        Self {
            cwd: std::env::current_dir().expect("Failed to get current working directory. Do you have permission?"),
            bin : bin,

        }
    }

    pub fn cwd(&self) -> PathBuf {
        self.cwd.clone()
    }

    pub fn bin(&self) -> PathBuf {
        self.bin.clone()
    }

    pub fn config(&self) -> PathBuf {
        self.cwd().join("config")
    }

    pub fn default(&self) -> PathBuf {
        self.bin.join("default")
    }

    pub fn default_basic(&self) -> PathBuf {
        self.bin.join("default").join("basic")
    }

    pub fn default_extra(&self) -> PathBuf {
        self.bin.join("default").join("extra")
    }

    pub fn m4(&self) -> PathBuf {
        self.bin.join("m4")
    }
    pub fn gnu(&self) -> PathBuf {
        self.m4().join("GNU")
    }
    pub fn module(&self) -> PathBuf {
        self.bin().join("modules")
    }
}
