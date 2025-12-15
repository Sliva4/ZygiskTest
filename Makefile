all: configure-template build-zygisk build-monitor copy-monitor zip-all
build-zygisk:
	@cd module && ndk-build && cd ..
build-monitor:
	@cd monitor && make build && cd ..
copy-monitor:
	@cp monitor/monitor module/template
zip-all:
	@mv module/libs/arm64-v8a/libZygiskHide.so module/template/zygisk/arm64-v8a.so
	@mv module/libs/armeabi-v7a/libZygiskHide.so module/template/zygisk/armeabi-v7a.so
	@cd module/template && zip -r9 ZygiskHide.zip monitor post-fs-data.sh old.prop module.prop zygisk/arm64-v8a.so zygisk/armeabi-v7a.so && mv ZygiskHide.zip .. && cd .. && cd ..
configure-template:
	@cat module/template/module.prop > module/template/old.prop
clean:
	@echo "" > module/template/old.prop
	@rm -rf module/libs
	@rm -rf module/template/zygisk/arm64-v8a.so
	@rm -rf module/template/zygisk/armeabi-v7a.so
	@rm -f module/ZygiskHide.zip
	@rm -f module/template/monitor
	@cd monitor && make full-clean && cd ..