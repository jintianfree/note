---
title: "mongo常用查询"
date: 2010-07-10T00:00:00+08:00
lastmod: 2010-07-10T00:00:00+08:00
draft: false
tags: ["mongo"]
categories: ["烂笔头", "技术"]

weight: 10
contentCopyright: GPL
mathjax: true
autoCollapseToc: true
---


### 基础 
```
# 连接
mongo  123.57.61.83:27017/admin -uroot -p'********'
# 设置缓存条数 不设置的话 shell查询返回数据会比较少
DBQuery.shellBatchSize = 50000000;
# 设置库
use log2
```

### 查询

#### 过滤
```
# shell中执行的话 $需要转义
db.ad_log.aggregate(
  [
    { \$match: 
      { 
        "created_at": { \$gt: ISODate("2020-04-01T08:00:00.000+08:00"), \$lt: ISODate("2020-04-14T08:00:00.000+08:00")}, 
        "content.network": "gdt2" 
      } 
    },
    {\$project: {"content":1}}

    ]
)
```

$eq  $ne
其他： https://docs.mongodb.com/manual/reference/operator/aggregation/eq/

#### 分组统计
```
db.user_behavior.aggregate(
    [
        {
            $match: 
            {
                "content.day": "2020-05-20",
                "header.Package-Name": "com.mobi.step",
                "content.eventId": "Event_page_aaao"
            }
        },
        {
            $group: {
                _id: "$content.userID",
                num_tutorial: {
                    $sum: 1
                },
            }
        },
        {
            $match: 
            {
                "num_tutorial": 2
            }
        }
    ]
)
```

#### 字符串转时间 计算间隔
```
$dateFromString: {
  dateString: '2019-07-22',
  timezone: 'Asia/Shanghai'
}

#计算间隔时间
$subtract:[
	{$dateFromString: {
			dateString: '2019-07-22',
			timezone: 'Asia/Shanghai'
		}}, 
		{$dateFromString: {
			dateString: '$time',
			timezone: 'Asia/Shanghai'
		}}
		
	]
}

#计算间隔天数
db.col.aggregate([{
    $project: {
        title: 2,
        likes: 1,
        startDay: "$time",
        endDay: new ISODate('2019-07-22 00:00:00'),
        days: {
            $floor:{
                $divide:[
                    {$subtract:[
                        {$dateFromString: {
                                dateString: '2019-07-22',
                                timezone: 'Asia/Shanghai'
                            }}, 
                            {$dateFromString: {
                                dateString: '$time',
                                timezone: 'Asia/Shanghai'
                            }}
                            
                        ]
                    }, 60 * 60 * 24 * 1000
                ]
             }
         }
    }
}])
```



#### 相同用户的两次时间，找出最大值，最小值相减
```
db.user_behavior.aggregate(
    [
        {
            $match: 
            {
                "content.day": "2020-05-20",
                "header.Package-Name": "com.mobi.step",
                "content.eventId": "Event_page_aaao"
            }
        },
        {
            $group: {
                _id: "$content.userID",
                num_tutorial: {
                    $sum: 1
                },
                max_value: {
                    "$max": "$content.time"
                },
                min_value: {
                    "$min": "$content.time"
                },
                
            }
        },
        {
            $match: 
            {
                "num_tutorial": 2
            }
        },
        {
            $project: {
                _id: 1,
                num_tutorial: 1,
                min_value: 1,
                max_value: 1,
                diff: {
                    $divide: [
                        {
                            $subtract: [
                                {
                                    $dateFromString: {
                                        dateString: '$max_value',
                                        timezone: 'Asia/Shanghai'
                                    }
                                },
                                {
                                    $dateFromString: {
                                        dateString: '$min_value',
                                        timezone: 'Asia/Shanghai'
                                    }
                                }
                            ]
                        },
                        1000*60*60
                    ]
                },
                
            }
        }
    ]
)
```



#### 包含 不包含
```
db.ad_log.aggregate(
    [
        {
            $match: 
            {
                "content.day": "2020-06-06",
                "content.network": "gdt2",
                "content.posid": {
                    $in: ["1026016", "1026058", "1026065"]
                },
                "content.click": 1
            }
        },
        {
            $project: {
                "content.posid": 1,
                "content.pv": 1,
                "content.click": 1,
                "ip": 1,
                "content.deviceid": 1
            }
        }
    ]
)
```


#### 分组求和
\$group \$sum
_id: null 不分组
```
db.ad_log.aggregate(
    [
        {
            $match: 
            {
                "content.day": "2020-06-30",
                "content.network": "gdt2",
                "content.posid": {
                    $in: ["1026006", "1026011"]
                }
            }
        },
        {
            $group: {
                _id: "$content.posid",
                "pv": {
                    $sum: "$content.pv"
                },
                "show": {
                    $sum: "$content.show"
                },
                "click": {
                    $sum: "$content.click"
                }
            }
        }
    ]
)
```