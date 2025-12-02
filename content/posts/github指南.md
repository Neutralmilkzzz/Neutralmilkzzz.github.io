+++
date = '2025-12-02T19:19:16+08:00'
draft = false
title = 'Github指南'
categories = ['还是要学习一个']
+++
虽然HKU CS大一用到github的机会不多，但是早点掌握肯定不是个坏事。
MIT大名鼎鼎的Missing Semester里就有一节课讲了git和版本控制
{{<bilibili id="BV1Wh4y1s7Lj"  >}}
但是根据我对本篇博客的受众的推测(假定真的有受众)，多半是还没搞明白git和版本控制到底有啥用，所以我要开始碎碎念了。
# 碎碎念
我真正意识到需要版本控制的经历来自于玩polymarket。
我从github上clone了一个跟单bot，调好了api，用自己电脑跑了一个晚上赚了7美刀。
我爽飞了。开始设置止盈止损，这个时候还能赚一点钱。
然后我开始排列组合各种alpha因子，反弹率，订单簿。抢尾盘。
然后我跑了一个晚上亏了50美元。
这个悲剧告诉了我两个道理：
* 别用自己电脑跑bot，用服务器
* 放心修改bot的前提是，你得再爆亏之后，随时回到赚钱版本的老bot
That's why we need version control.
# Github指北
鉴于我会的也不多，我只教最最简单的操作。

如你所见，我有一个账号，上面有很多东西。以**CS61A**为例，我给你示范一下**如何下载**。

我们发现这个项目的网址，于是在linux的命令行中输入

`git clone https://github.com/Neutralmilkzzz/CS61A-2025-Fall`

我就把他克隆了下来。

## 2 修改

`touch change.py`之后，我成功地做到了在原文件夹捏造了一个python文件。
你也可以干别的坏事。
## 3 同步更新

`git pull --rebase origin main`
其实pull就行了，--rebase是处理冲突的
## 4 上传新文件

`git add sth`
一般来说我们也不在意上传哪部分，一股脑全扔上去得了，那么就用
`git add .`就行

## 5 提交说明
解释一下你为啥要更新
`git commit -m "upload IntList.java"`

## 6 认证身份
<del>臭名昭著</del>大名鼎鼎的cc好课CCST9017教会了我们RSA，也告诉了我们：一对私钥与公钥可以用于鉴别身份，因为只有私钥的拥有者能生成一个数字签名（Digital Signature）。任何拥有公钥的人，都无法通过公钥推算出私钥，但可以使用公钥来验证该数字签名是否确实由匹配的私钥所创建。因此，公钥的使用者可以确认签名者（即私钥拥有者）的身份是真实的。
github为了保证绝对安全，在2021年之后不再能用账号密码登录，而是转为ssh key
首先你需要在本地生成一对ed25519的密钥，把公钥上传到github/settings/ssh key，加入一个新的key。
这串代码我忘了，keygen什么的，问问ai，他肯定知道。
然后登录
`ssh -T git@github.com`
收到这个
`Hi XXXXXX! You've successfully authenticated, but GitHub does not provide shell access.`
就说明你成功了

## 7 设置远程仓库为ssh模式

`git remote set-url origin git@github.com:Neutralmilkzzz/XXXXXXXXX.git`

## 8 推送

`git push origin main`

这就是github基本操作了。下次我们仔细讲讲git