#!/bin/sh

# generate .tags
ctags -R --fields=+niazS --extras=+q --c++-kinds=+px --c-kinds=+px \
    --exclude=node_modules --exclude=dist --exclude=venv/lib64 -f .tags .

# generate .filenametags
# "!_TAG_FILE_SORTED"，表明此tag文件是经过排序的
# find找到的文件按 "文件名\t文件路径\t1" 的格式输出
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > .filenametags
find . ! -path "*node_modules*" ! -path "*dist*" \
    -regex '.*\.\(md\|sh\|h\|c\|cc\|cpp\|java\|py\|go\|js\|ts\|tsx\|vue\|html\|css\|json\|yml\|yaml\)' \
    -type f -exec sh -c 'printf "%s\t%s\t1\n" "$(basename "{}")" "{}"' \; | sort -f >> .filenametags
    #-type f -printf "%f\t%p\t1\n" | sort -f >> .filenametags

while getopts "c" OPTION; do
    case $OPTION in
    c)
        # generate .cscope.files
        find . ! -path "*node_modules*" ! -path "*dist*" \
            -regex '.*\.\(h\|c\|cc\|cpp\|java\|py\|go\)' \
            -type f > .cscope.files
        # 没有使用"-R"参数递归查找子目录，因为在.cscope.files中已经包含了
        cscope -bq -i .cscope.files -f .cscope.out
        ;;
    esac
done
