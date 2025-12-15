/* Copyright 2022-2023 John "topjohnwu" Wu
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
 * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

#include <cstdlib>
#include <unistd.h>
#include <fcntl.h>
#include <android/log.h>
#include <fstream>
#include "zygisk.hpp"

using zygisk::Api;
using zygisk::AppSpecializeArgs;
using zygisk::ServerSpecializeArgs;

#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, "ZygiskHide", __VA_ARGS__)

class ZygiskHide : public zygisk::ModuleBase {
public:
    void onLoad(Api *api, JNIEnv *env) override {
        this->api = api;
        this->env = env;
    }

    void preAppSpecialize(AppSpecializeArgs *args) override {
		api->setOption(zygisk::Option::DLCLOSE_MODULE_LIBRARY);
        LOGD("[ZygiskHide] Creating Zygisk Check");
        std::ofstream check("/data/adb/modules/zygisk_hide/zygisk_check");
        check.close();
        uint32_t flags = api->getFlags();
        bool isRoot = (flags & zygisk::StateFlag::PROCESS_GRANTED_ROOT) != 0;
        bool isOnDenylist = (flags & zygisk::StateFlag::PROCESS_ON_DENYLIST) != 0;
        bool isChildZygote = args->is_child_zygote != NULL && *args->is_child_zygote;
        if (isRoot || !isOnDenylist)
        {
            LOGD("[ZygiskHide] Skipping ppid=%d uid=%d isChildZygote=%d, isRoot=%d, isOnDenylist=%d", getppid(), args->uid, isChildZygote, isRoot, isOnDenylist);
            return;
        }
        LOGD("[ZygiskHide] Processing ppid=%d uid=%d isChildZygote=%d, isRoot=%d, isOnDenylist=%d", getppid(), args->uid, isChildZygote, isRoot, isOnDenylist);
        // Use JNI to fetch our process name
        const char *process = env->GetStringUTFChars(args->nice_name, nullptr);
        preSpecialize(process);
        env->ReleaseStringUTFChars(args->nice_name, process);
    }

    void preServerSpecialize(ServerSpecializeArgs *args) override {
        preSpecialize("system_server");
    }

private:
    Api *api;
    JNIEnv *env;

    void preSpecialize(const char *process) {
        // Demonstrate connecting to to companion process
        LOGD("[ZygiskHide] package name [%s]\n",process);
    }

};

static void companion_handler(int i) {
    LOGD("[ZygiskHide] companion r=[100]\n");
}

// Register our module class and the companion handler function
REGISTER_ZYGISK_MODULE(ZygiskHide)
REGISTER_ZYGISK_COMPANION(companion_handler)
