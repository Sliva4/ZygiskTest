if [[ ${ARCH} != "arm64" ]]; then
	ui_print '- Only arm64 is supported!'
    exit 1
fi

echo "- Path: $MODPATH"
cd $MODPATH
sha256sum --status -c sha256
rm -f sha256
chmod +x zh
if [ $? -eq 0 ]; then
    ui_print "- All checksums matched successfully."
    touch sha256ok
else
    ui_print "- Some checksums failed or an error occurred."
fi
ui_print "- Welcome to ZygiskHide!"