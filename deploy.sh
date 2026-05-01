#!/bin/bash
cd ~/projects/daniu-niuma-game

# 先检查远端是否存在
git ls-remote https://github.com/lzhao8956-glitch/daniu-niuma-game.git 2>/dev/null
if [ $? -ne 0 ]; then
  echo "Remote repo doesn't exist, need to create it via API"
  curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    https://api.github.com/user/repos \
    -d '{"name":"daniu-niuma-game","description":"🐂 大厂牛马模拟器 - 打工人文字冒险游戏","private":false,"auto_init":false}' 2>&1 | head -5
fi

# 安全推送（不把token写进git remote）
git push "https://lzhao8956-glitch:${GITHUB_TOKEN}@github.com/lzhao8956-glitch/daniu-niuma-game.git" main 2>&1