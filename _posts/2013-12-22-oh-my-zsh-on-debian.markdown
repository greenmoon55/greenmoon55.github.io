---
layout: post
title: Debian Wheezy 使用 oh-my-zsh 的小问题
---

最近发现默认的 Shell（应该是 bash）有点小问题，果断换成 zsh，装了 oh-my-zsh 之后发现每次开启终端都会显示类似环境变量的东西

查了半天问题在哪，发现是在 `~/.oh-my-zsh/oh-my-zsh.sh` 里：

```sh
# Check for updates on initial load...
if [ "$DISABLE_AUTO_UPDATE" != "true" ]; then
  /usr/bin/env ZSH=$ZSH DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT zsh $ZSH/tools/check_for_upgrade.sh
fi
```

执行 `/usr/bin/env` 的时候会输出这些东西。解决办法就是在第三行重定向输出：

```sh
/usr/bin/env ZSH=$ZSH DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT zsh $ZSH/tools/check_for_upgrade.sh &>/dev/null
```
