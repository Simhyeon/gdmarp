use anyhow::Result;
use serde::{Serialize, Deserialize};
use std::path::PathBuf;

// TODO ::: This should be serializable if I don't want to handle string conversion
#[derive(Serialize, Deserialize)]
pub struct Config {
    pub modules: Vec<Module>,
}

impl Config {
    pub fn new() -> Self {
        Self {
            modules: vec![],
        }
    }

    pub fn read_config(config_path: &PathBuf) -> Result<Self> {
        Ok(serde_json::from_str(&std::fs::read_to_string(config_path)?)?)
    }

    pub fn save_config(&self, config_path: &PathBuf) -> Result<()> {
        let config = serde_json::to_string_pretty(self)?;
        std::fs::write(config_path, config)?;

        Ok(())
    }
}

// TODO ::: This should be serializable if I don't want to handle string conversion
#[derive(Serialize, Deserialize, PartialEq)]
pub enum Module {
    Repr,
    Documize,
    None,
}

impl Module {
    pub fn to_path(&self) -> PathBuf {
        match self {
            Module::Repr => {
                PathBuf::from("Repr")
            },
            Module::Documize => {
                PathBuf::from("Wiki").join("Documize")
            },
            Module::None => {
                PathBuf::from("")
            },
        }
    }

    pub fn from_str(value: &str) -> Result<Self> {
        match value {
             "Repr" => Ok(Self::Repr),
             "Documize" => Ok(Self::Documize),
             _ => Ok(Self::None),
        }
    }
}
