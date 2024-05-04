#!/bin/bash

# 定义目录,biliupR和视频文件目录
BILIUP_DIR=/opt/biliup
OUTPUT_BASE=/opt/biliup

# 创建一个空数组来存储文件路径
files=()

# 查找所有符合条件的文件，并将它们的路径添加到数组中
IFS=$'\n'
for file in $(find "$OUTPUT_BASE" -type f -name "*.mp4" -mtime 0)
do
  files+=("$file")
done

# 检查是否找到了文件
if [ ${#files[@]} -eq 0 ]; then
  echo "没有找到文件"
  exit 1
fi

# 用数组中的所有文件路径一次调用上传命令
echo "上传 ${#files[@]} 个文件"

# 获取当前日期并格式化为"年-月-日"的形式
current_date=$(date +%Y-%m-%d)

# 将标题中的日期部分替换为当前日期
title="【彩六录播】MacieJay-${current_date}[1080P60帧]"

# 使用替换后的标题进行上传
${BILIUP_DIR}/biliup/latest/biliup upload --copyright 2 \
--cover cover.png \
--desc "投稿：https://tg.r6siege.c\u000d备案号：ICP-2022006460号\u000d录播来自MacieJay的直播间 twitch.tv/maciejay\u000d\u000d合作邮箱：jackf7499@gmail.com\u000d\u000dLiscensed Under Creative Commons" \
--title "$title" \
--dynamic "#彩虹六号##彩虹六号：围攻##录播#\u000d新鲜的录播来咯~" \
--source "https://twitch.tv/maciejay" \
--tid 65 \
--tag "彩虹六号","彩虹六号:围攻","MacieJay","网络游戏","FPS","集锦" \
"${files[@]}"

