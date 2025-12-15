use std::env;
mod utils;
const MONITOR_VERSION_CODE: i32 = 2;
const MODULE_VERSION: &str = "0.02";
enum Argument {
    Status
}
fn info() -> String {
    let value: String = "Monitor: ".to_owned()+&MONITOR_VERSION_CODE.to_string();
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
        }
    }
}
