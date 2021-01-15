

### centos7 安装mysql客户端
```
rpm -ivh https://repo.mysql.com//mysql57-community-release-el7-11.noarch.rpm
yum search mysql-community
yum install mysql-community-client.x86_64
```

### 导出数据和表结构
mysqldump　-h host -uroot　-p　数据库名 [表名]

### 导出结构不导出数据 -d
mysqldump　-h host -u root -p -d　数据库名　[表名]

### 导出数据不导出结构 -t
mysqldump　-h host -u root -p -t　数据库名　[表名]




### join另一个表数据进行更新
mysql update join
update aff_postback 
    left join aff_advertiser on aff_postback.advertiser = aff_advertiser.advertiser 
    set aff_postback.sales = aff_advertiser.sales;  

### mysql查看正在执行的sql语句
有2个方法：
1、使用processlist，但是有个弊端，就是只能查看正在执行的sql语句，对应历史记录，查看不到。好处是不用设置，不会保存。
-- use information_schema;
-- show processlist;

或者：
-- select * from information_schema.`PROCESSLIST` where info is not null;

2、开启日志模式
-- 1、设置
-- SET GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'ON';
-- SET GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'OFF';

-- 2、查询
SELECT * from mysql.general_log ORDER BY    event_time DESC

-- 3、清空表（delete对于这个表，不允许使用，只能用truncate）
-- truncate table mysql.general_log;

### Mysql时间函数汇总：timediff、timestampdiff、datediff

#### 时间差函数：timestampdiff
　　语法：timestampdiff(interval, datetime1,datetime2)
　　结果：返回（时间2-时间1）的时间差，结果单位由interval参数给出。
frac_second 毫秒（低版本不支持，用second，再除于1000）
second 秒
minute 分钟
hour 小时
day 天
week 周
month 月
quarter 季度
year 年
　　注意：MySQL 5.6之后才支持毫秒的记录和计算，如果是之前的版本，最好是在数据库除datetime类型之外的字段，再建立用于存储毫秒的int字段，然后自己进行转换计算。

所有格式
SELECT TIMESTAMPDIFF(FRAC_SECOND,'2012-10-01','2013-01-13'); # 暂不支持
SELECT TIMESTAMPDIFF(SECOND,'2012-10-01','2013-01-13'); # 8985600
SELECT TIMESTAMPDIFF(MINUTE,'2012-10-01','2013-01-13'); # 149760
SELECT TIMESTAMPDIFF(HOUR,'2012-10-01','2013-01-13'); # 2496
SELECT TIMESTAMPDIFF(DAY,'2012-10-01','2013-01-13'); # 104
SELECT TIMESTAMPDIFF(WEEK,'2012-10-01','2013-01-13'); # 14
SELECT TIMESTAMPDIFF(MONTH,'2012-10-01','2013-01-13'); # 3
SELECT TIMESTAMPDIFF(QUARTER,'2012-10-01','2013-01-13'); # 1
SELECT TIMESTAMPDIFF(YEAR,'2012-10-01','2013-01-13'); # 0

 
#### 时间差函数：datediff
 　　语法：传入两个日期参数，比较DAY天数，第一个参数减去第二个参数的天数值。
SELECT DATEDIFF('2013-01-13','2012-10-01'); # 104
 
#### 时间差函数：timediff
　　语法：timediff(time1,time2)
　　结果：返回两个时间相减得到的差值，time1-time2
SELECT TIMEDIFF('2018-05-21 14:51:43','2018-05-19 12:54:43');	# 49:57:00
 
四、其他日期函数
now()函数返回的是当前时间的年月日时分秒
curdate()函数返回的是年月日信息
curtime()函数返回的是当前时间的时分秒信息
对一个包含年月日时分秒日期格式化成年月日日期，可以使用DATE(time)函数

其他日期函数
SELECT NOW(); # 2018-05-21 14:41:00
SELECT CURDATE(); # 2018-05-21
SELECT CURTIME(); # 14:41:38
SELECT DATE(NOW()); # 2018-05-21
SELECT SYSDATE(); # 2018-05-21 14:47:11
SELECT CURRENT_TIME(); # 14:51:30
SELECT CURRENT_TIMESTAMP; # 2018-05-21 14:51:37
SELECT CURRENT_TIMESTAMP(); # 2018-05-21 14:51:43

注意：now()与sysdate()类似，只不过now()在执行开始时就获取，而sysdate()可以在函数执行时动态获取。
