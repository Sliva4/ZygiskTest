all: configure-template build-zygisk build-zh copy-zh zip-all
build-zygisk:
	@cd module && ndk-build && cd ..
build-zh:
	@cd zh && make build && cd ..
copy-zh:
	@cp zh/zh module/template
zip-all:
	@mv module/libs/arm64-v8a/libZygiskHide.so module/template/zygisk/arm64-v8a.so
	@cd module/template && zip -r9 ZygiskHide.zip zh boot-completed.sh service.sh post-fs-data.sh old.prop module.prop zygisk/arm64-v8a.so && mv ZygiskHide.zip .. && cd .. && cd ..
configure-template:
	@cat module/template/module.prop > module/template/old.prop
clean:
	@echo "" > module/template/old.prop
	@rm -rf module/libs
	@rm -rf module/template/zygisk/arm64-v8a.so
	@rm -f module/ZygiskHide.zip
	@rm -f module/template/zh
	@cd zh && make full-clean && cd ..