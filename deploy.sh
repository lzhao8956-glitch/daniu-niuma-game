#!/bin/bash
# 大厂牛马模拟器 - 一键部署脚本
# 使用说明：从 GitHub Settings > Personal Access Token 获取 token，运行时传入
# 用法: GITHUB_TOKEN=xxx bash deploy.sh

TOKEN=${GITHUB_TOKEN:-$1}
if [ -z "$TOKEN" ]; then
  echo "❌ 请设置 GITHUB_TOKEN 环境变量或作为参数传入"
  echo "   用法: GITHUB_TOKEN=your_token bash deploy.sh"
  exit 1
fi

REPO="lzhao8956-glitch/daniu-niuma-game"

# 检查远程仓库是否存在
git ls-remote "https://github.com/$REPO.git" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "📦 创建远程仓库..."
  curl -s -H "Authorization: Bearer $TOKEN" \
       -H "Accept: application/vnd.github+json" \
       https://api.github.com/user/repos \
       -d "{\"name\":\"daniu-niuma-game\",\"description\":\"🐂 大厂牛马模拟器 - 打工人文字冒险游戏\",\"private\":false,\"has_issues\":true,\"has_wiki\":true}" > /dev/null
  echo "✅ 仓库已创建"
fi

# 推送到 GitHub
echo "🚀 正在部署到 GitHub Pages..."
git push "https://lzhao8956-glitch:$TOKEN@github.com/$REPO.git" main 2>&1
echo "✅ 部署完成！访问 https://lzhao8956-glitch.github.io/daniu-niuma-game/"
