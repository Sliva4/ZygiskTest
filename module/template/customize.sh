sha256sum -c sha256
if [ $? -eq 0 ]; then
    ui_print "All checksums matched successfully."
else
    ui_print "Some checksums failed or an error occurred."
fi
rm -f sha256
ui_print "Welcome to ZygiskHide!"