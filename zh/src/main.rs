use std::env;
mod utils;
mod vars;
mod config;
enum Argument {
    None,
    Status,
    Config,
    ConfigGet
}

fn info() -> String {
    let sha256ok = format!("Successful installation: {}",utils::sha256ok_exists());
    let vbmeta = format!("Hide vbmeta props: {}",utils::vbmeta_exists());
    let value: String = format!("[KERNEL]\nVersion: {}[VERSION]\nzh: {}\nModule: {}\n[CONFIG]\n{}\n[OTHER]\n{}\n{}",&utils::get_kernel_version(),vars::ZH_VERSION,vars::MODULE_VERSION,&config::get_config_txt(),sha256ok,vbmeta);
    return value;
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let mut arg_type: Argument = Argument::None;
    for arg in &args[1..] {
        match arg_type {
            Argument::None => (),
            Argument::Status => {
                utils::update_status(arg);
                continue;
            },
            Argument::Config => {
                if arg == "get" {
                    arg_type = Argument::ConfigGet;
                    continue;
                } else if arg == "create" {
                    config::create_config();
                    continue;
                } else {
                    println!("Unknown command.");
                    continue;
                }
            },
            Argument::ConfigGet => {
                config::get_config_cli(arg);
                continue;
            }
        }
        if arg == "status" {
            arg_type = Argument::Status;
            continue;
        } else if arg == "info" {
            println!("{}", info());
        } else if arg == "boot-completed" {
            utils::update_status(emojis::get("✅").unwrap().as_str())
        } else if arg == "config" {
            arg_type = Argument::Config;
            continue;
        } else {
            println!("Unknown command.")
        }
    }
}
