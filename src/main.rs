use anyhow::Result;

mod cli;
mod mproc;
mod modules;
mod env;
mod consts;
mod config;

fn main() -> Result<()> {
    cli::Cli::new().parse()?;
    Ok(())
}
