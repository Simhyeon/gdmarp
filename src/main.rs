use anyhow::Result;

mod cli;
mod mproc;

fn main() -> Result<()> {
    cli::Cli::new().parse()?;
    Ok(())
}
