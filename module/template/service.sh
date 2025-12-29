MODPATH="${0%/*}"
. $MODPATH/common_func.sh

if ! $SKIPVBMETA; then
    resetprop_if_diff "ro.boot.vbmeta.avb_version" "1.2"
    resetprop_if_diff "ro.boot.vbmeta.hash_alg" "sha256"
    resetprop_if_diff "ro.boot.vbmeta.size" "4096"
fi