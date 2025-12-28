FILES := zh boot-completed.sh customize.sh post-fs-data.sh old.prop module.prop zygisk/arm64-v8a.so
ZIP_NAME := ZygiskHide.zip
all: build-module
build-module: configure-template build-zh copy-zh build-zygisk copy-zygisk-files hash zip-all
build-zygisk:
	@cd module && ndk-build && cd ..
build-zh:
	@cd zh && make build && cd ..
copy-zh:
	@cp zh/zh module/template
copy-zygisk-files: 
	@mv module/libs/arm64-v8a/libZygiskHide.so module/template/zygisk/arm64-v8a.so
hash:
	@for f in $(FILES); do \
		cd module/template; \
		sha256sum $$f >> sha256; \
		cd ..; \
		cd ..; \
	done
zip-all:
	@cd module/template && zip -r9 $(ZIP_NAME) $(FILES) sha256 && mv $(ZIP_NAME) .. && cd .. && cd ..
configure-template:
	@cat module/template/module.prop > module/template/old.prop
clean:
	@cat /dev/null > module/template/old.prop
	@rm -rf module/libs
	@rm -rf module/template/zygisk/arm64-v8a.so
	@rm -f module/$(ZIP_NAME)
	@rm -f module/template/zh
	@cat /dev/null > module/template/sha256
	@cd zh && make full-clean && cd ..