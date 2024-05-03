#!/bin/bash

# 检查是否提供了工作目录参数
if [ $# -ne 1 ]; then
    echo "使用方法: $0 <工作目录>"
    exit 1
fi

# 检查工作目录是否存在
work_dir="$1"
if [ ! -d "$work_dir" ]; then
    echo "错误：工作目录 '$work_dir' 不存在"
    exit 1
fi

# 获取最新版本号
latest_version=$(curl -s https://api.github.com/repos/biliup/biliup-rs/releases/latest | grep -o -E "v[0-9]+\.[0-9]+\.[0-9]+" | head -n 1)
if [ -z "$latest_version" ]; then
    echo "无法获取最新版本号"
    exit 1
fi

echo "最新版本号：$latest_version"

# 下载最新版本的biliupR
download_url="https://github.com/biliup/biliup-rs/releases/download/$latest_version/biliupR-$latest_version-x86_64-linux.tar.xz"
echo "下载链接：$download_url"
wget -P "$work_dir" "$download_url"

# 创建archive目录
archive_dir="$work_dir/biliup/archive"
mkdir -p "$archive_dir"

# 将下载的文件移动到archive目录
mv "$work_dir/biliupR-$latest_version-x86_64-linux.tar.xz" "$archive_dir"

# 删除latest目录
rm -rf "$work_dir/biliup/latest"

# 解压到latest目录
mkdir -p "$work_dir/biliup/latest"
tar -xf "$archive_dir/biliupR-$latest_version-x86_64-linux.tar.xz" -C "$work_dir/biliup/latest" --strip-components=1

echo "操作完成，已更新至最新版本 $latest_version"
