---
title: "note@mex@2020"
draft: true
author: "Cheney"
hiddenFromHomePage: true
---

## 学习TODO
1. go macro   （服务并发模型？  负载均衡机制？ 熔断重试机制？  json rpc怎么转的pb   pdf）
   go micro  api网关 向后转发  是用的ui/bs阻塞模型  还是nginx 非阻塞模型 web 直接使用了  go自带的反向代理   httputil.NewSingleHostReverseProxy(rp).ServeHTTP(w, r) 反向代理怎么处理的？ 待研究 rpc/ api 使用了什么方式？
2. k8s
3. 分布式系统设计 CSP 各种理论模型 
4. 区块链

## 工作TODO
- [x] 积分独立
- [x] 游戏升级积分
- [x] 发版平台
- [ ] 打包平台  https://kdocs.cn/l/ckSka768U [金山文档] 版本管理系统.docx
- [ ] APP交叉推广 时间地域过滤

# 日常

## 2020-10-30
游戏 上架  
平台 下周
红包活动  下周一上    
小程序
聚合特殊版本号不出广告
走走趣 && 调研小程序  
聚合测试
趣拼

## 2020-10-23
平台情况
游戏情况
红包活动
CPA上传重复数据 #done

测试： 熟悉APP和数据库  熟悉平台  下周发清理  测一下
下周要上架appstroe  申请广告位

## 2020-10-16
聚合  发版&过滤  
平台 ？ 还剩一个需求  
游戏  
趣拼 下周
走走趣
红包活动
CPA上传重复数据
聚合特殊版本号不出广告

## 2020-10-09

转团团  刘伟
   分享 https://www.processon.com/view/link/5f7fc2115653bb06eff03563
     问题：普通h5登陆后 校验是否是全民走路用户  做不到
         邀请码放在app里面？ 是否放到h5里面更合适
   https://kdocs.cn/l/cedqwgc0ND8d  [金山文档] 20201010-需求-趣拼.docx

聚合 刘伟   聚合sdk   ** 固定排序 如果没广告出下一个的  ** 升级快手SDK 
游戏 金锁
趣走走小程序  彭博
红包活动  彭博  服务端  刘伟
清理服务端  刘伟
CPA 上传重复数据   金锁
聚合特殊版本号 不出广告  刘伟 


## 2020-09-27
转团团项目：  1、唤起支付宝支付   2、用户打通  避免二次登陆  3、拼团结果的推送
   1.整个功能以H5的形式嵌入全民走路。
   2.用户打通。
   3.支持支付宝唤起付款和退款。
   4.H5的底部tab栏我们的需要保留。
   5.我们有分享功能会引导用户下载全民走路APP，所有拼团的入口需要显眼一点，类似全民走路的一个子玩法。这样用户下载时不会懵逼。

**** 趣走走  申请抖音小程序 上线抖音



## 2020-09-21
支持Low high两个配置   节后第二周上线
sass_id 服务  数据流支持saas  文件上传支持saas
sass支持 
京东api
小黑交接  聚合服务  /  升级服务
转团团


## 2020-09-14
1、iOS全民走路买量
2、ios找什么茬 买量
3、成语游戏开发
4、平台开发  国内 & 海外
5、h5游戏聚合

聚合          完成   
国内程序化     
海外程序化     周二
SAAS   周一   测试域名

## 2020-09-07
1、iOS全民走路买量
2、ios找什么茬 买量
3、成语游戏开发
4、平台开发  国内 & 海外
5、h5游戏聚合


## 2020-08-31 -
1、人生赢家买量
2、ios 开户、申请广告位
3、游戏开发上线


## 2020-08-15 -
1、ios发全民走路
2、找茬申请广告位
3、互动广告

### 调用原生视频广告
 安卓调用 step.showAd(p1);
苹果调用 window.webkit.messageHandlers.showAd.postMessage(p1);

P1为JSON格式的对象字符串，必传参数为posid和关闭视频回调的方法，示例（假设回调方法名为closeVideo，可以自定义）：
p1=JSON.stringify{
	posid: 12345,
	closeVideo: fn
}
其中fn需要根据环境传不同的形式 苹果为javascript:closeVideo()  安卓为closeVideo() 
另外回调函数需在全局事先注册，如 window.closeAdVideo = this.closeAdVideo

### cocos学习笔记
#### 几个比较重要的窗口
1. 层级管理器
   管理各node的父子关系，节点（Node）是承载组件的实体，我们通过将具有各种功能的 组件（Component） 挂载到节点上，来让节点具有各式各样的表现和功能。
2. 场景编辑器
   游戏开发以场景为基础 所有组件都是放到场景上
3. 资源管理器
   图片、音乐、代码包括场景文件，都在这里保存，这里只是静态文件
   需要用到的图片 需要放到场景上 变成一个node（场景本身是一个node，图片放到场景上之后也是一个node）  才可以做逻辑处理
   脚本需要挂到node上，才会有生命，在node的各个声明周期上 调用脚本对应的函数
4. 属性检查器
   设置node的属性

#### 脚本
使用ctor声明构造函数
ctor: function () {）

获得组件所在的节点
this.node

获得组件所在节点上的其他组件
this.getComponent(cc.Label)  或者this.getComponent("SigRotage") 这种方式是使用类名 对于组件而言 类名就是脚本的文件名
this.getComponent = this.node.getCompent

获得组件后 可以设置组件的属性

获得其他组件上的node
可以在属性上 定义一个cc.Node的属性  然后将其他组件拖到这里 给他赋值   这样就能拿到这个组件了

#### 移动背景
https://zhuanlan.zhihu.com/p/98918590
其实是移动背景图片
```
        var child = this.node.getChildByName("hillnear");
        child.y -= 1
```

## 2020-08-11 -
cocos
   http://docs.cocos.com/creator/manual/zh/getting-started/install.html
   https://www.cocos.com/docs#creator

高尔夫球游戏：
   https://forum.cocos.org/t/cocos-creator-2d-3d/76094

快手切量
   08-11 数据快手
   请求	42,151	填充 10,133	 展现 6,524	 点击798
   填充到请求 23%   展现到请求 15%


   调了超时时间 明天再看下数据
   开屏+信息流 ARPU 0.05
   快手25   填充5   ARPU  0.125  
   穿山甲14 填充5   ARPU  0.07
   ARPU = 0.245

   快手填充50%
   周平均留40  0.4 * 7 * 0.245  = 0.686
   2周平均留30 0.3 * 14 * 0.245 = 1.029
   月平均留20  0.2 * 30 * 0.245 = 1.47
   
   快手填充100%
   周平均留40  0.4 * 7 * 0.3  = 0.84
   2周平均留30 0.3 * 14 * 0.3 = 1.26
   月平均留20  0.2 * 30 * 0.3 = 1.8 

小额提现
   清理人均 8   走走人均11  没增长

诗词

美丽天气买量 

小程序

布局小游戏

官网

CPS

   openapp.jdmobile://virtual?params={"category":"jump","sourceType":"sourceType_test","des":"m","url":"https://u.jd.com/c1II9R","unionSource":"Awake","channel":"b34704de95c14c7ca6696333cdcac8f7","union_open":"union_cps"}

   <a href="openapp.jdmobile://virtual?params=%7b%22category%22%3a%22jump%22%2c%22sourceType%22%3a%22sourceType_test%22%2c%22des%22%3a%22m%22%2c%22url%22%3a%22https%3a%2f%2fu.jd.com%2fc1II9R%22%2c%22unionSource%22%3a%22Awake%22%2c%22channel%22%3a%22b34704de95c14c7ca6696333cdcac8f7%22%2c%22union_open%22%3a%22union_cps%22%7d"> 打开</a>

## 2020-07-30 -
看下这个域名请求量gdtrafficad.com  确定证书是否需要付费
   enge确认不用
快手切量
   量级上差不多
   ecpm 激励视频 快手11  穿山甲10   信息流穿山甲6  快手3
   明天再看下数据
   [ ] 数据流加上 快手变现数据
[ ] 聚合灌es
积分过关发包
修改提现  小额提现  https://kdocs.cn/l/ckisGAfOyHWI
   埋点 task_withdrawal_click 
平台
   上传下载 
   平台SSO梳理 有问题， 没权限就不能登陆    跳转问题
美丽天气买量 
小程序
官网
布局小游戏
常见谚语：
   https://baijiahao.baidu.com/s?id=1606846004255981341&wfr=spider&for=pc
   https://zhidao.baidu.com/question/589305434156509805.html
小学诗词：
   https://www.shicimingju.com/shicimark/xiaoxue.html

我的圈子:
   user_data: 
   circle: [ {id: xxx, owner: 1/0}  ]
   habit_list: { circle: [] }
圈子：
   id : { status: xx, date:xx, name:xx, owner:openid, user: [ openid ], 开放加入: false / true, max: 100}
圈子记录：
   id, circle_id, date, time, habit_name, habit_img, openid

我的圈子
加入圈子
删除圈子
查看圈子  人数 当日打卡数  当日打卡人数



## 2020-07-27 -
- 买量消耗
  - 1030 / 好天气_android    1033.60	roi低  为什么在买
  - 2052 / 走走赚钱_ios    	997.19	
  - 1026 / 走走赚钱_android	300.00	消耗赠款
- [ ] 发包平台
- [x] 官网 蒲公英
- [ ] CPA 数据上传  如果日期格式是日期 无法识别并上传
- [ ] CPA 数据上传  没有做数据去重
- [ ] 快手
- [ ] 导流
- [ ] 聚合报表
- [ ] 小程序    https://shimo.im/docs/zYmBtD27P3QWbnGH/read
- [ ] 找来找趣 
      找隐藏167个图片  签到领放大镜/时间  大转盘转体力/时间/放大镜  玩一关消耗一个体力 不论玩完还是没玩完  没时间限制  可使用放大镜
      找茬 玩一次消耗一个体力 不论过不过关  有时间限制  可以加时间  可以使用放大镜   看视频免费加时间 看视频免费用放大镜  看不到有几关
      故事 目前只有一关  找隐藏 找的东西笔记多
      火眼金睛  给一个名字  在一堆图片找   有时间限制   看视频用放大镜  看视频加时间   到时间看视频复活

- [ ] 王者拼图
      无尽模式  一直拼  免费三个放大镜 和自动拼  用完了金币买           金币1.看视频获取  2.内购
      选关模式  自己选图片  图片需要用金币换

      广告怎么打点？  多广告方式   还是玩法为主   少广告方式？

## 2020-07-20 - 
- [ ] 每天关注 买量数据 变现数据  ROI数据
- [ ] 几个平台距离产品化还差什么
      1. 加一个买量表     之前只在头条 现在加了快手  需要区分    买量和留存是否需要挂钩？
- [ ] 平台第二版 https://kdocs.cn/l/cd2NNdZmO 
   - [x] 聚合组添加广告来源 只显示已经添加的广告源
   - [x] 名字-ID搜索功能
   - [x] 应用搜索 可以选择
- [ ] 报表数据准确性
- [ ] 聚合
- [ ] 发包平台
- [x] 报表  1. VPN报表迁移   2. 业务线总表  https://kdocs.cn/l/sbaVHnUUH?f=101 [文档] 平台待完善列表20200629.xlsx
- [ ] 官网 蒲公英

----

- [ ] CPA 数据上传   如果日期格式是日期 无法识别并上传
- [ ] CPA 数据上传  没有做数据去重

## 邮件

各位好：
   技术部在六月底完成了三大平台的上线，也和相关运营同学做了使用方面的分享，目前试运行了两周已经趋于成熟。

### 1. 流量变现平台
   - 流量聚合功能: 集成了穿山甲、广电通、admob三大主流变现SDK和自有程序化SDK; 已经投入使用并满足推广条件；
   - 国内程序化渠道管理功能: 服务于国内程序化业务; 在6月30日上线后开始使用。

### 2. 广告主投放平台
   - 服务于国内程序化的DSP管理,在6月30日上线开始使用。

### 3. BI报表系统
   - 国内产品业务线报表，新增、活跃、买量、变现多维度数据
   - 国内程序化业务线报表
   - 订阅业务线报表
 
国内产品业务线限于快手的流程没有走完，数据有缺失；会在走完流程后补充齐全。
订阅业务线限于数据在海外访问要慢一些，会根据需求决定是否在海外机器搭建一套。


http://pub.findwxapp.com
http://publisher.findwxapp.com


广告主
http://adv.findwxapp.com


BI报表系统
http://bi.findwxapp.com



## 5备份

      "id": 5,
      "name": "",
      "jump_type": 4,
      "android_jump_url": "https://cdn.findwxapp.com/apk/zouzouapp-yanfa-release_107_jiagu_sign.apk",
      "android_pkg_name": "com.mobi.zzzq.app",
      "android_app_name": "zzzq",
      "ios_jump_url": "",
      "points": -1,
      "min": 100,
      "max": 110,
      "pop_type": 1003,
      "double_count": 1

      "id": 1,
      "name": "",
      "jump_type": 5,
      "android_jump_url": "pages/home/home",
      "android_pkg_name": "",
      "android_app_name": "小程序",
      "android_params": "gh_417c962cf76d",
      "ios_jump_url": "",
      "ios_pkg_name": "",
      "ios_app_name": "",
      "points": -1,
      "min": 10,
      "max": 15,
      "pop_type": 1001,
      "double_count": 1

      "id": 5,
      "name": "",
      "jump_type": 5,
      "android_jump_url": "pages/today/today",
      "android_pkg_name": "",
      "android_app_name": "zzzq",
      "android_params": "gh_aa8e0fa77238",
      "ios_jump_url": "",
      "points": -1,
      "min": 100,
      "max": 110,
      "pop_type": 1003,
      "double_count": 1


## 20200713
TODO: 
- [ ] 报表  1. VPN报表迁移   2. 业务线总表  https://kdocs.cn/l/sbaVHnUUH?f=101 [文档] 平台待完善列表20200629.xlsx
- [ ] 

## 通用官网
https://cdn.findwxapp.com/offcial/index.html?title=%E7%BE%8E%E4%B8%BD%E5%A4%A9%E6%B0%94&url=mltq.png&target=https://apps.apple.com/cn/app/id1522034581


## 20200706 - 
TODO:
- [ ] 平台第二版 https://kdocs.cn/l/cd2NNdZmO 
   - [ ] 聚合组添加广告来源 只显示已经添加的广告源
   - [ ] 名字-ID搜索功能
   - [ ] 应用搜索 可以选择
- [ ] 报表数据准确性
- [ ] 聚合
- [ ] 发包平台
- [ ] 走走发版  看穿山甲视频数是否上升

----

- [ ] CPA 数据上传   如果日期格式是日期 无法识别并上传
- [ ] CPA 数据上传  没有做数据去重
- [x] 平台培训
- [x] 鹏博转正

#### 系统平台半年规划
- 运营平台（PUB/ADV/BI）        
  - 迭代优化对外输出    7月
  - 总表移动版         9月
  - 输出财务表         10月

- 应用升级平台          8月

- 积分服务
   - 积分任务SDK       7月
   - 游戏升级任务       7月
  
   - 工具聚合小程序      8月
   - 游戏聚合小程序      8月

- 交叉推广  
   - 直客投放、自投DSP  10月

- 打包平台  11月
 
- 积分平台 （积分任务配置平台，支持对外开放）   12月

----  

## 20200703
TODO:
- [ ] CPA 数据上传   如果日期格式是日期 无法识别并上传
- [ ] CPA 数据上传  没有做数据去重
- [ ] 平台待完善列表 https://kdocs.cn/l/cd2NNdZmO 
- [ ] 平台培训


## 趣旅行
一些想法
1. 狗狗考考你    字符游戏
2. 滑板车道具   滑板跑酷    横向跑跳跃   或者竖向跑 左右躲避障碍
3. 狗狗跳一跳  参考驴子跳一跳
4. 狗拉车  需要偷别人的狗