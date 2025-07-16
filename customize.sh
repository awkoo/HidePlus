
if [ -z "$KSU" ]; then
  installer="magisk --install-module"
else
  installer="ksud module install"
fi

files=$(find "$MODPATH/wj/rj" -maxdepth 1 -type f -name "[0-9]*-*" | sort -n -t '-' -k1)
[ -z "$files" ] && ui_print "- 没有要安装的软件"
for file in $files; do
  ui_print "- 正在安装软件：$(basename "$file")"
  pm install "$file" 2>&1 | tee /proc/self/fd/2 | { IFS= read -r line && { echo "$line"; cat; } >&2; } || :
done

files=$(find "$MODPATH/wj/mk" -maxdepth 1 -type f -name "[0-9]*-*" | sort -n -t '-' -k1)
[ -z "$files" ] && ui_print "- 没有要安装的模块"
for file in $files; do
  ui_print "- 正在安装模块：$(basename "$file")"
  $installer "$file" 2>&1 | tee /proc/self/fd/2 | { IFS= read -r line && { echo "$line"; cat; } >&2; } || :
done

files=$(find "$MODPATH/wj/jb" -maxdepth 1 -type f -name "[0-9]*-*" | sort -n -t '-' -k1)
[ -z "$files" ] && ui_print "- 没有要执行的脚本"
for file in $files; do
  ui_print "- 正在执行脚本：$(basename "$file")"
  sh "$file"
done

ui_print "- 安装完成"