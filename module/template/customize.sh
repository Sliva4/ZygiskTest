echo "Path: $MODPATH"
sha256sum -c $MODPATH/sha256
if [ $? -eq 0 ]; then
    ui_print "All checksums matched successfully."
else
    ui_print "Some checksums failed or an error occurred."
fi
ui_print "Welcome to ZygiskHide!"
rm -f $MODPATH/sha256