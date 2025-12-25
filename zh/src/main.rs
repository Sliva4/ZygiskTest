use std::env;
mod utils;
mod vars;
enum Argument {
    Status
}
fn info() -> String {
    let value: String = "[KERNEL]\nVersion: ".to_owned()+&utils::get_kernel_version()+"[VERSION]\nzh: "+vars::zh_VERSION+"\nModule: "+vars::MODULE_VERSION;
    return value;
}
fn main() {
    let args: Vec<String> = env::args().collect();
    let mut arg_type: Argument;
    for arg in &args[1..] {
        match arg_type {
            Argument::Status => utils::update_status(arg)
        }
        if arg == "status" {
            arg_type = Argument::Status;
            continue;
        } else if arg == "info" {
            println!("{}", info());
        } else if arg == "ok" {
            utils::update_status(emojis::get("✅").unwrap().as_str())
        }
    }
}
