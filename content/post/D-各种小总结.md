---
title: "This is a hidden post."
date: 2018-03-08T17:40:19+08:00
lastmod: 2018-03-08T22:01:19+08:00
draft: true
author: "Cheney"

hiddenFromHomePage: true
---

note: 各种小总结 每个汇集多了之后 单独拿出

#### 大数据技术栈
##### 实时流
kafuka => python /hadoop streaming / ...(etl/数据清洗/数据统一整合）=> 存储（hdfs文件/clickhouse/。。。）=>presto / 。。。 读取查询
##### 离线流
kafuka /定时文件 => python / hadoop / ...（etl +  聚合） => 存储（hdfs文件，clickhouse, drid。。。） =》读取


#### SSR
https://github.com/makedary/shadowsocksr.git
https://github.com/shadowsocks/shadowsocks/wiki/Optimizing-Shadowsocks
防密码破解：python autoban.py -c 10 < /var/log/shadowsocks.log

#### 前端问题
```
ERROR in ./node_modules/css-loader?{"minimize":true,"sourceMap":false}!./node_modules/vue-loader/lib/style-compiler?{"vue":true,"id":"data-v-e1a0d586","scoped":false,"hasInlineConfig":false}!./node_modules/sass-loader/lib/loader.js?{"sourceMap":false}!./node_modules/vue-loader/lib/selector.js?type=styles&index=0!./src/page/link/linkList.vue
Module build failed: Error: Node Sass does not yet support your current environment: Linux 64-bit with Unsupported runtime (64)
For more information on which environments are supported please see:
https://github.com/sass/node-sass/releases/tag/v4.5.3
    at module.exports (/vagrant/project/mex-web-project/cpaMob/node_modules/node-sass/lib/binding.js:13:13)
    at Object.<anonymous> (/vagrant/project/mex-web-project/cpaMob/node_modules/node-sass/lib/index.js:14:35)
    at Module._compile (internal/modules/cjs/loader.js:689:30)
```

解决: 卸载当前版本node sass, 重新安装
```
npm uninstall --save node-sass
npm install --save node-sass
```


#### 读书笔记
读书list
穷爸爸富爸爸
半小时经济学
半小时历史
图解经济

读书笔记
庞氏骗局   没有任何产品和投资   收下一个人的钱发给上一个人做利润  只要源源不断有人  就可以维持下去  一旦没人进来就爆雷   传销就是最好的一个例子
次贷危机  优贷 发放的贷款都有能力偿还  次贷 发放的贷款有很大的风险不能偿还
经济危机 产品太多 出现问题
金融危机 钱太多出现问题  排除战争和饥荒  经济危机基本都是金融危机引起

人民币升值
升值后  出口贸易赚到的人民币就会变少  利润降低 就会导致很多出口企业经营困难
升值后人民币在国内没变化 在海外能买到更多的货物 会导致进口产品价格低于国内本土产品 大家都买进口 会导致国内财富流入国外  这也是国家增加关税保护本土企业的原因

穷爸爸富爸爸
工作是为别人和政府打工 你工作挣的越多 你扣掉的越多 大部分都交给了公司和政府
要有自己的事业  让钱为你打工
学会投资  靠运气和祈祷 不是投资是赌博  你应该具有分析和针对现实做调整的能力
投资不是靠运气得的钱 是靠能力
世界上很多才华横溢的穷人 并不是在专业领域很高就能富有 你需要获取更多的综合能力



