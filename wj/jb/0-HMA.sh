pm list packages -3 | awk -F: 'BEGIN {
    printf "{\"configVersion\":90,\"detailLog\":false,\"maxLogSize\":512,\"forceMountData\":true,\"templates\":{\"1\":{\"isWhitelist\":false,\"appList\":[\"com.tsng.hidemyapplist\"]}},\"scope\":{"
    first = 1
}
{
    package = $2
    if (package == "com.tsng.hidemyapplist") {
        next
    }
    if (!first) {
        printf ","
    } else {
        first = 0
    }
    printf "\"%s\":{\"useWhitelist\":false,\"excludeSystemApps\":false,\"applyTemplates\":[\"1\"],\"extraAppList\":[]}",package
}
END {
    print "}}"
}' > /sdcard/HMA.json
echo "隐藏应用列表配置已生成至/sdcard/HMA.json"