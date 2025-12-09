+++
date = '2025-12-09T17:01:28+08:00'
draft = false
title = 'Github指南:1'
tags = ['git']
categories = ['还是要学习一个']
+++
在学习github的使用前，我们得先掌握git。

### 1.1 git与 git commit
git仓库的提交记录保存的是你的目录下所有文件的快照。就像复制了整个目录，再黏贴。
有几个特点
* git希望提交记录轻量，因此每次提交后，他只会打包所有更新的部分作为一个提交记录。
* git会保存每一次历史记录。因此可以维护提交历史，对大家都有好处。
使用`git commit`即可提交。
### 1.2 git branch
> 当你搭建炒股bot的时候，你可能会尝试100种策略，但最终你只会使用最赚钱的那个。因此你得回到历史某一个提交节点上。

Git 的分支也非常轻量。它们只是简单地指向某个提交记录.
`git branch {随便起个名字。比如说 richbot}`
这样就创建好了一个指向当前状态的节点了！

-----
为了回到我们想要的节点，我们需要使用
`git checkout (你取的那个名字）`
### 1.3 git merge
> 我一个trading bot出问题了！我要修复这个bug，但是我的同事正在进一步开发bot，因此我需要在分支上写一个bugfix，再回到main，让主线也包含这个修复bug的插件。

```git
git checkout main
git pull origin main
git merge bugFix ###这个是在main主线上把bugfix的内容merge进去。
git push origin main
```

### 1.4 rebase
merge虽然好，但是我们有时候想要线性的维护记录，我们希望在主线上这就是一个修复bug的更新，而不是什么莫名其妙的branch，这个时候就可以用rebase。

```git
git branch bugFix | git checkout bugFix
git commit
git rebase main
git checkout main
git rebase bugFix
```

------------
2.0: HEAD
> 当然，给每一个节点一个branch，可以随时回归，很不错，但是这个设计哲学也太烂了吧！
> 所以说，我们得掌握在提交树上移动的办法。

HEAD 是一个对当前所在分支的符号引用 —— 也就是指向你正在其基础上进行工作的提交记录。

HEAD 总是指向当前分支上最近一次提交记录。大多数修改提交树的 Git 命令都是从改变 HEAD 的指向开始的。

HEAD 通常情况下是指向分支名的（如 bugFix）。在你提交时，改变了 bugFix 的状态，这一变化通过 HEAD 变得可见。

----------
好在哪怕你不给每一个节点起名，节点自己也有一个40位的哈希值`fed2da64c0efc5293610bdd892f82a58e8cbc5d8`像这样，你只要输入`git checkout fed2`然后tab自动补全就好啦！

----
其实不好。
这tm谁记得住哈希值
还好我们有**相对引用**
使用`git checkout HEAD^`即可回到上一条。
`^`表示上一条。系统的讲，你可以选中一个已有的好记的节点，然后移动到附近。
一条一条返回也有点慢，不如用`~`批量返回。
还可以用`git branch -f (branch名) （位置）`来改变分支的指向。

### 2.1 撤回！
> 不是Ctrl Z
两套方法。
1. 用git reset,直接在本地取消一次提交，回到上一个节点。不过在远端没人知道。
2. 用git revert，同样是取消，但是是以新的节点的形式，*我的母节点的母节点是我*这样方便提交到远端。
