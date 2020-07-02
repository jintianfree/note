---
title: "小记将md笔记发布到GitHub"
date: 2010-07-10T00:00:00+08:00
lastmod: 2010-07-10T00:00:00+08:00
draft: false
tags: ["md", "hugo", "github", "markdown"]
categories: ["烂笔头"]

weight: 10
contentCopyright: GPL
mathjax: true
autoCollapseToc: true

---

![](../../img/github.jpg)
### GitHub Pages
GitHub有个Pages功能可以托管静态html页面，通过浏览器访问，免费，无流量限制。Pages分两类，一类是用户层级，可通过域名直接访问，可以作为个人博客； 一类是项目层级，需要通过域名+路径访问，通常用项目文档、项目介绍。<br>
用户层级的必须是"用户名.github.io"命名的项目，可以直接在浏览器用域名"用户名.github.io"打开访问，用户层级的项目只能使用master分支，需要将静态页面放到项目跟目录;项目层级的pages，需要"用户名.github.io/项目名字"方式打开, 项目层级的pages可以使用非!master分支，静态页面可以放到项目根目录，也可以放到docs文件夹。<br>

**GitHub Pages打开方式**<br>
```
Settings => GitHub Pages => Source 
  => select source (master branch OR master branch docs folder)
```

### Hugo
GitHub可以存放html静态页面，静态页面怎么产生呢，我使用的是Hugo。Hugo是一个静态网页生成工具，具体我就不介绍了，只记录下自己的操作。 <br>
**新建项目**
``` bash
hugo new note
```
Hugo官网找一个自己喜欢的主题下载，解压拷贝到note/themes下, 一般皮肤文件夹下面有exampleSite文件夹，将里面的config.toml、content拷贝到note/ <br>
在note/content/post 存放md笔记
**生成静态文件**
```
hugo
```
hugo将md文件生成静态Html放到public文件夹下,hugo自带http server，可以本地运行，http://localhost:1313/， 打开进行预览。

```
hugo server
```

如果需要本地图片，我会在note/static新建img图片，并同时建立软链接到note/img
```
ln note/static/img img -s 
```
这样md中用(../img/xx.png)的方式引入本地图片，可以保证md笔记能正常显示，发布的html中也能正常显示。

此处在用vs code时遇到点问题，vs code引入本地图片使用相对路径绝对路径都无法显示，上网查说时vs code如果打开的是一个md文件，则只能引入和md文件同级的图片，如果打开的是一个workspace，则可以引入该workspace下的目录的图片。

### 发布
我建立了两个项目，一个管理note，在note/content/post下存放md笔记，使用vs code编辑。一个项目管理hugo发布之后的publish文件夹下的静态页面，这个项目开启GitHub Pages功能，提交之后，可以通过域名直接访问。

![](../../img/hugo.png)