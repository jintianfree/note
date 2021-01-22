
# 面试点
*** 算法
设计模式、多线程、redis、zk、**mysql调优
网络 三步、四步、滑动窗口
分布式微服务
架构 亿级流量

# 动态规划
https://www.zhihu.com/question/39948290
分治 动态规划 贪心 回溯 分支限届
滑动窗口 字符串匹配

# 后端面试合集
https://github.com/AobingJava/JavaFamily
https://www.xiaoheidiannao.com/191048.html

# C++
## C++大厂面试题
## epoll select

# go
## go ch
## go 调度
## go 内存回收

# k8s


# volatie内存屏障

# DDD

# 多线程
线程状态转化与通信机制 
线程同步与互斥
线程池

# 数据结构与算法
二叉搜索树到B+树
经典问题之字符串
经典问题之TOPK
分治、动态规划、贪心算法


# etcd

# 分布式csp  分布式锁 raft协议
# 分布式事务
2pc   耗资源，1pc执行事务，不提交，然后保持资源等待，都执行完没问题，一起提交，释放资源。
3pc   
tcc try confirm cancel ，try先预分配数据，锁定，不被其他事务占用，锁定不耗数据库资源，然后如果都可以，执行confirm真正执行事务并提交；不耗数据库资源 程序员实现复杂，自己写
可靠消息服务  各自处理自己都事务，然后放到消息队列，后面的服务进行消费。解决宕机问题带来的稳定性问题，如果后面的事务资源不够，前面的服务无法回滚，这样的场景不适用。
seta  各个服务处理自己的事务，不需要关心回滚，由框架负责回滚。


# 线程安全的本质  原子性、有序性、可见性 
# 并发锁
# 秒杀设计
# 网络模型nio netty
# volatile synchronize 




# redis 
https://zhuanlan.zhihu.com/p/91539644 
### 五种基本类型 操作 使用场景 底层实现 跳表
TODO：
数据结构 string hash list set sortedset
### redis做mysql缓存 怎么更新 多个用户访问一个数据 怎么保证不是都访问数据库去更新？
TODO:
### redis雪崩 击穿 穿透
TODO:
热key  大key  
### redis QPS 主从复制 哨兵 集群 数据同步 一致性
TODO:
redis集群？ 什么场景使用，解决了什么问题，阿里/腾讯云的redis集群原理
主从复制，延迟问题怎么解决？
哨兵 集群 同步机制
### redis为什么快  使用场景 过期策略
### redis 分布式锁
### 不隆过滤器  hyperloglog
# 缓存
redis基础
redis中的雪崩 缓存击穿 缓存穿透
集群高可用、哨兵、持久化、LRU
分布式锁、并发竞争、双写一致性

# 线程池原理

# mysql
## mysql索引
innodb都是使用b+树存储数据和索引， myisam数据和索引分开存储，索引使用B+树存储，memory引擎使用hash表
- 为什么说B+树比B树更适合数据库索引？
  B+树非叶子结点只存储了索引和指针，没有存数据，这样一层存放的数据更多，树的深度就少，查询路径短，在搜索IO次数就会少
  B+树叶子结点上放数据，并且像链表一样连接起来，方便范围查找

- mysql索引类型
  **主键索引**
    主键尽量小，尽量自增。有符号int(11) 4个字节，可以支持20亿数据，bigint可以支持更多。分布式环境可以使用雪花算法生成主键id。
  **唯一索引**
    唯一的，不重复的，unique
  **普通索引**
    非主键，唯一列上建的索引。
  **联合索引**
    多列联合索引，查询时注意最左匹配原则
    如果经常查a,b，可以建一个联合索引(a,b)，查(a,b)可以用索引，查a也会用索引所以不需要单独对a建索引，但查b不会用索引，如果经常查b需要对b单独建索引。
    所以在建立索引时，尽量把经常查的字段放到联合索引的前面，不经常查的放到联合索引的后面，存在联合索引(a,b)的情况下，不需要单独对a建立索引
  **全文索引**
    用的少，现在一般用ES

- 索引原则
  尽量要少，尽量索引对应的数据要少，索引字段尽量小。在varchar字段上建立索引，尽量指定索引长度，没必要多全字段建立索引。
  innodb一定要设置主键，主键要尽量小，一定要自增。innodb存储数据时是和主键一起存储的，如果主键不自增，再插入新数据时，为了维持B+树的排序特性，可能会引起页分裂和页合并，导致IO压力很大，影响数据库整体性能。
  or 可能会导致索引失效，可以使用union代替or
  where 如果有范围尽量前面使用=，访问放后面，如果范围再前面会导致后面的=不使用索引

- 聚集索引和非聚集索引
  innode的主键索引属于聚集索引，即索引和数据存放在一起，当然数据只存储在叶子结点。innode表在有主键的情况下，数据和主键存一起，没有主键的情况下，数据和唯一键存一起，此时唯一键是聚集索引，没有主键和唯一键情况下，数据库会使用一个6字节自增rowid作为聚集索引。
  非聚集索引就是数据和索引不存储在一起，myisam本身数据和索引不存储在一起，所以都是非聚集索引。inodb中，普通索引、联合索引都是非聚集索引，非聚集索引的叶子结点存储的是主键ID，使用非聚集索引查询时， 先查询到主键ID，然后到聚集索引中根据主键ID查询读取数据，这个过程称为回表。

- 最左匹配
  比如有联合索引： INDEX (zipcode, lastname, firstname)
  使用索引的情况：
  where zipcode=xxx
  where zipcode=xxx and lastname=xx 
  where zipcode=xxx and lastname=xxx and firstname=xxx
  where lastname=xxx and zipcode=xxx    ## 理论上不会使用 但mysql查询优化器会调整zipcode在前 所以实际上也会使用索引
  不使用索引的情况：
  where lastname=xxx
  where firstname=xxx
  where lastname=xxx and firstname=xxx 

- 覆盖索引
  查询的数据可以直接在索引中拿到，不需要通过主键ID回表，称为覆盖索引。

- 回表
  在非聚集索引中查询到主键ID，然后根据主键ID在聚集索引中查询数据到过程，称为回表。使用非聚集索引查询数据时，如果不是覆盖索引，都会回表，回表会增加IO次数。

- 索引下推
  官方介绍：https://dev.mysql.com/doc/refman/5.6/en/index-condition-pushdown-optimization.html#:~:text=Index%20Condition%20Pushdown%20%28ICP%29%20is%20an%20optimization%20for,which%20evaluates%20the%20WHERE%20condition%20for%20the%20rows.
  在联合索引上生效， 
  比如有联合索引： INDEX (zipcode, lastname, firstname)
  SELECT * FROM people WHERE zipcode='95054'AND lastname LIKE '%etrunia%' AND address LIKE '%Main Street%';
  这句查询，索引只会用到zipcode，因为lastname， address，头上有%，无法使用索引
  在没有ICP的情况下，引擎会把zipcode=95054索引出的所有数据进行回表查询，把数据给到server，有server进行 lastname和 address的like判断，这样会导致很多无效回表。
  有ICP的情况下，引擎在索引出zipcode=95054的索引之后，在引擎中进行name和address的过滤，因为联合索引中有这些数据，过滤之后再进行回表把数据取出来，这样大大降低回表次数。

## mysql调优
- 性能监控
  - show profiles，可以看cpu、内存情况等
  - performance schema库，内存型的数据库，存储各种性能指标，会替代掉show profiles
  - show processlist or select * from information_schema.processlist 查看当前执行的连接数
- schema与数据类型优化
  - 数据类型优化  
  长度尽量小，避免NULL，能用int不用字符串，能用自建时间类型，不用字符串； char 最长255，检索和写效率要比varchar高，短并且经常更新的字符串选择char；
  datetime8个字节，与时区无关，可以保存到毫秒，可保存时间范围大；timestamp占用四个字节，时间范围1970-2038，精确到秒，采用整形存储，依赖数据库设置的时区，可以自动更新；date占用3个字节，保存1000-9999之间的日期。
  - 合理使用范式和反范式
  mysql范式目的是消除数据冗余
  **第一范式**
  确保数据表中每列（字段）的原子性。 如果数据表中每个字段都是不可再分的最小数据单元，则满足第一范式。
  例如：user用户表，包含字段id,username,password
  **第二范式**
  在第一范式的基础上更进一步，目标是确保表中的每列都和主键相关。 如果一个关系满足第一范式，并且除了主键之外的其他列，都依赖于该主键，则满足第二范式。
  例如：一个用户只有一种角色，而一个角色对应多个用户。则可以按如下方式建立数据表关系，使其满足第二范式。
  user用户表，字段id,username,password,role_id
  role角色表，字段id,name
  用户表通过角色id（role_id）来关联角色表
  **第三范式**
  在第二范式的基础上更进一步，目标是确保表中的列都和主键直接相关，而不是间接相关。 例如：一个用户可以对应多个角色，一个角色也可以对应多个用户。则可以按如下方式建立数据表关系，使其满足第三范式。
  user用户表，字段id,username,password
  role角色表，字段id,name
  user_role用户-角色中间表，id,user_id,role_id
  像这样，通过第三张表（中间表）来建立用户表和角色表之间的关系，同时又符合范式化的原则，就可以称为第三范式。
  **反范式化**
  反范式化指的是通过增加冗余或重复的数据来提高数据库的读性能。 例如：在上例中的user_role用户-角色中间表增加字段role_name。 反范式化可以减少关联查询时，join表的次数。

  - 主键选择
  主键尽量小，尽量自增。有符号int(11) 4个字节，可以支持20亿数据，bigint可以支持更多。分布式环境可以使用雪花算法生成主键id。 
  - 字符集选择
  确定拉丁字符可以满足，就要拉丁字符，确定utf8可以满足就使用utf8，否则utf8mb4。 表的不同字段可以设置不同的编码。
  - 存储引擎选择
  ![](../../img/innodb-vs-myisam.png)
  - 适当的数据冗余
  适当冗余减少join操作，减少io，冗余字段注意修改的时候要保持一致。
  
- 执行计划
  这个说的很明白：https://segmentfault.com/a/1190000021458117?utm_source=tag-newest
explain
    | Column | Meaning|
    |---|---|
    | id | 执行顺序，id相同，执行顺序从上至下 id不同：值大的先执行|
    |select_type| 查询类型 <br> **SIMPLE** 单层select，不包含union和子查询 ， <br> **PRIMARY** 最外层select, <br> **SUBQUERY** select或者where中包含的子查询<br>  **DERIVED** from列表中包含的子查询，mysql会递归执行这些子查询把结果放到临时表  <br> **UNION** 若第二个select出现在union之后则为union，注意如果union是包含在了from的子查询中会标记为DERIVED<br>  **UNION RESULT** 从union查询中获取结果的select <br>|
    |table| 数据来自哪张表的 有时候不是表名 是derivde<id> 是标示为id的子查询的结果 |
    |partitions| 使用的分区|
    |type| 访问类型 <br> **null** 在执行阶段不用访问表或者索引， <br> **system** 表只有一行 基本不会用到 <br> **const** where 使用primary key或者unique索引出一行数据，很快<br> **eq_ref**  前表join我时，使用我的primary key或者unique key，join我的这条子操作，就是eq_ref<br> **ref** 使用索引查找，非primary和unique key， 注意只能说明查找语句快，ref如果返回大量数据，涉及太多IO，一样慢。 <br> **ref_or_null** 和ref一样，只是有null判断 <br> **range** 使用索引查找某个范围  <br> **index** 和ALL类似，也是全扫，不过扫的是索引（应避免) <br> **all** 全表扫描（应避免）<br> |
    |possible_keys	| 可能使用到的索引|
    |key	 | 使用的索引|
    |key_len |索引长度 越短IO越少|
    |ref	 |
    |rows    |大致估算出找到所需的记录所需读取的行数 越少越好|
    |filtered|查询的表行占表的百分比  越小IO越少  越好|
    |Extra	 ||

- 通过索引进行优化
上面<mysql索引类型>
- 硬件优化

分库分表 mycat 底层原理
## mysql锁
myisam只支持表锁

innodb支持行锁和表锁
InnoDB 实现了以下两种类型的行锁：
**共享锁（S）**：允许一个事务去读一行，阻止其他事务获得相同数据集的排他锁。
**排他锁（X）**：允许获得排他锁的事务更新数据，阻止其他事务取得相同数据集的共享读锁和排他写锁。

为了允许行锁和表锁共存，实现多粒度锁机制，InnoDB 还有两种内部使用的意向锁（Intention Locks），这两种意向锁都是表锁：
**意向共享锁（IS）**：事务打算给数据行加行共享锁，事务在给一个数据行加共享锁前必须先取得该表的 IS 锁。
**意向排他锁（IX）**：事务打算给数据行加行排他锁，事务在给一个数据行加排他锁前必须先取得该表的 IX 锁。
意向锁是 InnoDB 自动加的， 不需用户干预。为了防止行锁时没有判断表锁，导致没有有效锁定。

innodb行锁是建立在索引上的，如果表没有索引，会直接锁表。
如果一个索引索引了多行，这些行都会加上锁。只有执行计划真正使用了索引，才能使用行锁，如果explain发现没有使用索引，innode直接会使用表锁。

RC级别下，索引存在，select * for update 只会给现有记录加行锁，其他session是可以插入数据的。而在RR级别，其他session不可以插入数据。

**隐式锁定**
对于 UPDATE、 DELETE 和 INSERT 语句， InnoDB会自动给涉及数据集加排他锁（X)；
对于普通 SELECT 语句，InnoDB 不会加任何锁；

**显示锁定**
select ... lock in share mode // 共享锁S
select ... for update         // 排他锁X

***行锁细分**
Record lock     单条索引记录上加锁
Gap lock        某一条索引记录之前或者之后加锁，并不包括该索引记录本身 
next-key locks  就是Record lock和gap lock的结合，即除了锁住记录本身，还要再锁住索引之间的间隙。

**乐观锁**
总是假设最好的情况，每次去拿数据的时候都认为别人不会修改，所以不会上锁，但是在更新的时候会判断一下在此期间别人有没有去更新这个数据，可以使用版本号机制和CAS算法实现。乐观锁适用于多读的应用类型，这样可以提高吞吐量。

**悲观锁**
总是假设最坏的情况，每次去拿数据的时候都认为别人会修改，所以每次在拿数据的时候都会上锁，这样别人想拿这个数据就会阻塞直到它拿到锁。

乐观锁悲观锁是一个设计理念，实际使用过程中，根据场景选择是乐观还是悲观，对于mysql中悲观就是使用select ... for update，先上锁查询。


## mysql事务
事务特性ACID
A 原子性  一组操作要么全部成功  要么全部失败 undo log实现
C 一致性  AID共同保证了一致性
I 隔离性  事务之间隔离，读写锁+MVCC实现
D 持久性  redo log实现

**持久性** 
持久性通过redo log来保证，redo log是物理日志，记录的是数据页的物理修改，它用来恢复提交后的物理数据页(恢复数据页，且只能恢复到最后一次提交的位置)。
redo log包括两部分：一是内存中的日志缓冲(redo log buffer)，该部分日志是易失性的；二是磁盘上的重做日志文件(redo log file)，该部分日志是持久的。redo log提过三个级别的写入，1是性能最差的，也是安全性最高的，其他两种在数据库服务重启和数据库机器宕机都有丢数据的可能。
![](../../img/redologlevel.png)
为什么不直接写数据表文件，而提供一个redo log，直接写表文件，涉及索引更新，数据更新，B+树更新（页合并页分裂），是一个耗时较长的过程，直接写redo log会很快，然后在数据库不忙的情况下更新表文件； redo log是有大小的，如果满了，会停止其他处理，强制刷新redo log到页文件。
redo log 是innodb层级的日志，不同于bin log，bin log是mysql 服务层级的日志，不区分是哪种引擎，另外bin log记录操作的方法是逻辑性的语句，在事务提交时一次性写入。
数据库双1设置，bin log设置sync_binlog=1，即每提交一次事务同步写到磁盘中。redo log设置innodb_flush_log_at_trx_commit=1，即每提交一次事务都写到磁盘中。这种情况下，丢日志的概率很小，但性能会很低。

**原子性**
原子性要么都成功，要么都失败，成功好说，如果失败的话，需要把之前的修改回滚，innodb通过undo log来实现回滚，undo log和redo log记录物理日志不一样，它是逻辑日志。可以认为当delete一条记录时，undo log中会记录一条对应的insert记录，反之亦然，当update一条记录时，它记录一条对应相反的update记录, 这样rollback时，可以根据undo log回滚。系统崩溃时，可能有些事务还没有COMMIT，在系统恢复时，这些没有COMMIT的事务就借助undo log来进行回滚。
undo log两个作用：提供回滚和多个行版本控制(MVCC)。

**隔离性**
隔离性下四个级别及问题：
|级别|脏读|不可重复读|幻读|
|---|---|--|---|
|READ_UNCOMMITTED|Y|Y|Y|
|READ_COMMITTED ||Y|Y|
|REPEATABLE_READ|||Y|
|SERIALIZABLE||||
脏读：在READ_UNCOMMITTED级别下，一个事务会读到另一个事务未提交的数据，称为脏读。
不可重复读：READ_UNCOMMITTED，READ_COMMITTED级别下，一个事务开启后会读到另一个事务提交的数据，这样事务多次读取会出现读取的值不一致的情况，称为不可重复读。
幻读：该级别下，事务开启后，读不到另一个事务提交的数据，但会出现，这个插入数据失败的情况（主键或者唯一键冲突），但重新查询看不到该数据，插入却失败，这就是幻读。 [还有一种说法是事务启动后，看不到另一个事务插入提交的数据，但count数却多了一条。]
mysql解决幻读可以可以加间隙锁，通过 select * from xx where id>xx for update 加锁后，其他事务插入数据就会阻塞。

级别越高，性能越差，隔离性越高，mysql默认是REPEATABLE_READ，但阿里云的mysql给设置成了READ_COMMITTED。
 
MVCC:
MVCC通过保存数据在某个时间点的快照来实现的。这意味着一个事务无论运行多长时间，在同一个事务里能够看到数据一致的视图。而Innodb是通过undo log保存了已更改行的旧版本的信息的快照。
MVCC只在READ COMMITED 和 REPEATABLE READ 两个隔离级别下工作。
事务执行时，会在undo log中保存历史版本，select 时，会生成一个record view，记录当前正在执行的所有事务及状态，然后在record view中选择要读取哪个事务提交的数据，读取时在undo log中读取。

## mysql集群
主从复制
mysql支持主从复制，slave使用master的bin log进行回放，同步数据。
在写少读多场景下，可以master写,slave读。会存在刚写完读不到的情况，主从不一致，这样的场景可以强制读主。或者设置半同步，主从同步默认异步，配置成半同步是指写主时，主同步到slave的relay log中，主才返回成功。这样会牺牲性能，提升一致性。业务中通常根据不同的场景选择不同的同步方式，一个项目中会使用多个主从复制库，每个库的同步方式不同。
读写分离，可以支持多个slave。

mycat
使用mycat做代理，可以实现分片集群。每个主从复制小集群作为一个分片，形成一个大集群，分片之间采用垂直分或者水平分。
水平分库，多行拆分到多库，不好扩展，加库会导致数据重新排。
垂直分库，多列拆分到多库。




# 限流 熔断 降级
熔断：通过超时、失败率等参数，判断后端服务是否可用，如果不可用，执行熔断不再请求后端服务，客户端需要处理默认操作，并通过少量请求试探，后端服务恢复正常后，关闭熔断。
限流：限制对后端服务的请求频率，有令牌桶算法和漏桶算法，被限制的请求不再请求后端，执行默认操作。
降级：从服务整体上降级，关闭掉一些不重要的功能，降低资源使用，保障主要功能的使用， 次要功能需要有默认操作，比如提示稍后再来等等。可以代码自动判断，也可以人工根据突发情况切换。
（还有一种解释是，就是降低不可用服务的资源，防止他耗尽资源，影响其他服务。 对于golang来说，就是防止不可用的服务占用过多的M，导致其他G调度不了。对于java来说，降低不可用服务使用的线程池资源，留给可用的服务使用）

### 雪崩利器 hystrix-go 
支持限流、熔断 hystrix的go版本
原理很简单，在客户端使用，客户端提供两个函数A\B：正常调用A，在A中进行远程服务调用，
触发限流或者熔断时，调用B执行默认处理，B中不会调用远程服务，
hystrix会异步调用A，并统计其状态，需要熔断或者限流时，不再调用A, 调用B进行处理。
``` go
err := hystrix.Do("my_command", func() error {
   // A 在这里调用服务接口
   return nil
}, func(err error) error {
   // B fallback 限流或者熔断后的默认动作，此时不会调用远程服务，客户端需要处理情况下的默认操作
   return nil
})
```

可以看下hystrix-go的配置

``` go
/*
 * Timeout: 执行command的超时时间。默认时间是1000毫秒
 * MaxConcurrentRequests：command的最大并发量 默认值是10
 * SleepWindow：当熔断器被打开后，SleepWindow的时间就是控制过多久后去尝试服务是否可用了。默认值是5000毫秒
 * RequestVolumeThreshold： 一个统计窗口10秒内请求数量。达到这个请求数量后才去判断是否要开启熔断。默认值是20
 * ErrorPercentThreshold：错误百分比，请求数量大于等于RequestVolumeThreshold并且错误率到达这个百分比后就会启动熔断 默认值是50
*/
	hystrix.ConfigureCommand("mycommand", hystrix.CommandConfig{
		Timeout:                int(time.Second * 3),
		MaxConcurrentRequests:  100,
		SleepWindow:            int(time.Second * 5),
		RequestVolumeThreshold: 30,
		ErrorPercentThreshold: 50,
	})

	err := hystrix.DoC(context.Background(), "mycommand", func(ctx context.Context) error {
		// ...
		return nil
	}, func(i context.Context, e error) error {
		// ...
		return e
	})
```

熔断：
每一个Command都会有一个默认统计控制器，当然也可以添加多个自定义的控制器，默认的统计控制器DefaultMetricCollector保存着熔断器的所有状态，调用次数，失败次数，被拒绝次数等等。
hystrix-go根据失败次数/调用次数的比例、或者被拒绝次数，计算出是否触发熔断，熔断后会定时少量调用，发现服务恢复正常后，关闭熔断

限流：
hystrix-go对流量控制的代码是很简单的。用了一个简单的令牌算法，能得到令牌的就可以执行后继的工作，执行完后要返还令牌。得不到令牌就拒绝，拒绝后调用用户设置的callback方法，如果没有设置就不执行。

信息上报：
hystrix-go 使用StreamHandler把所有断路器的状态以流的方式的推送到dashboard，可以在dashboard中查看。

# 简单算法总结
### 三大排序
* 选择排序
算法如其名，每次选择一个最大的或者最小的插入到第1,2,..n，排序完成，时间复杂度O(n^2)
不稳定 插入的同时 会有交换 会导致乱序
* 冒泡排序
相邻两两交换，正序排的话，1、2比较，大的后移，2、3比较，大的后移...，比较一轮之后，最大的被交换到最后。这样交换n轮，完成排序。每执行一轮，比较的元素可以减1，因为后面的元素都是有序的了。
稳定 只是两两交换  总体上不会乱序

* 插入排序  
从0-n遍历元素，插入到合适的位置，使插入后的元素有序。
稳定 元素总体有序的情况下  效率比较高  较常用
2-1比较 交换
3-2比较 交换 2-1比较 交换
4-3比较 交换 3-2比较 交换 2-1比较 交换
...

### 希尔排序
不稳定

### 计数排序

### 基数排序

### 桶排序

### 快速排序
每次随机选择一个值，将小于这个值的放到左边，大于这个值的放到右边。然后对这个值两边的数组分别执行以上操作。
理想情况下，选择的值每次都在中间，这样只需要选logn次，然后每次执行n次移动，时间复杂度nlogn，
最差情况下，每次选的值都是最小值或者最大值，导致每次分完的数组相当于每分，这样需要选择n次，每次执行n次移动，时间复杂度 n^2
不稳定，存在两个重复值的情况下，不确定基准值会选中哪一个，这样就会导致两个重复值存在位置交换的情况
快速排序有一个很大不足就是对于比较有序的数组排序效率很低，而且当数组较短时快速排序并不是最快的
``` go
func quickSort(num []int, start, length int) {
    if length < 2 {
        return
    }

    fmt.Println(num[start: start + length], start, length)

    key := num[start + length / 2]

    i := start
    j := start + length - 1

    for i < j {
        for num[i] < key {
            i++
        }
        for num[j] > key {
            j--
        }

        if i < j {
            if num[i] == num[j] {  // num[i] == num[j] == key 的情况 这块很容易陷入死循环
                i++
            } else {
                num[i], num[j] = num[j], num[i]
            }
        }
    }

    quickSort(num, start, i - start)
    quickSort(num, j + 1, length - j - 1)
}
```
### 归并排序
排序的空间代价比较大，需要开一个与原数组同样大小的数组。
时间复杂度nlogn
稳定排序
``` go
func merge(num1, num2 []int) []int {
    num := []int{}
    i := 0
    j := 0
    for i < len(num1) && j < len(num2) {
        if num1[i] <= num2[j] {  // 如果不加= 就不稳定了
            num = append(num, num1[i])
            i++
        } else {
            num = append(num, num2[j])
            j++
        }
    }

    for i < len(num1) {
        num = append(num, num1[i])
        i++
    }

    for j < len(num2) {
        num = append(num, num2[j])
        j++
    }

    return num
}

func mergeSort(num []int) []int {
    length := len(num)
    if length < 2 {
        return num
    }

    return merge(mergeSort(num[0: length/2]), mergeSort(num[length/2:]))
}
```

### 堆排序
理解堆排序需要先了解二叉树
- 平衡二叉树  
  Balanced Binary Tree  非页结点的左右高度差不超过1 也叫AVL树
![](../../img/bbt.png)
- 完全二叉树  
  Complete Binary Tree  首先是一颗平衡二叉树 在平衡二叉树基础上 不满的结点都集中在右边   完全二叉树存在的意义 就是用数组按层存储 不会有空位置  不会浪费存储空间
![](../../img/cbt.png)
- 满二叉树
  非页结点的左右都不为空  满二叉树即是完全二叉树 也是平衡二叉树
![](../../img/fbt.png)
- 二叉搜索树
  Binary Search Tree，又称二叉查找树或二叉排序树。若其左子树存在，则其左子树中每个节点的值都不大于该节点值；若其右子树存在，则其右子树中每个节点的值都不小于该节点值。
  二叉搜索树存在两个极端，1.完全二叉树(logn)，2.链表(n)。
下面说堆排序，每个结点的值都大于其左孩子和右孩子结点的值，称之为大根堆；每个结点的值都小于其左孩子和右孩子结点的值，称之为小根堆。
1.首先将待排序的数组构造成一个大根堆，此时，整个数组的最大值就是堆结构的顶端
2.将顶端的数与末尾的数交换，此时，末尾的数为最大值，剩余待排序数组个数为n-1
3.将剩余的n-1个数再构造成大根堆，再将顶端数与n-1位置的数交换，如此反复执行，便能得到有序数组
如何构建大根堆：
主要思路：第一次保证0~0位置大根堆结构（废话），第二次保证0~1位置大根堆结构，第三次保证0~2位置大根堆结构...直到保证0~n-1位置大根堆结构。
``` c++
void create_max_heap(int *array, int length)
{
	if (array == NULL || length <= 1) {
		return;
	}

	// 首先将[0, length-2] 建成堆
	create_max_heap(array, length - 1);

    // 完全二叉树用数组存 left=2*root+1 right=2*root+2  root=(left-1)/2 = (right-1)/2
	// 把length-1插入到最后 然后一直与父节点对比 直到<负结点 或者自己成为根结点
	for (int child = length - 1, root = (child - 1) / 2; root >= 0; child = root, root = (root - 1) / 2) {
		if (array[child] > array[root]) {
			int tmp = array[child];
			array[child] = array[root];
			array[root] = tmp;
		} else {
			break;
		}
	}

    // 堆构建完成
}

void heap_sort(int *array, int length)
{
	for (int i = 0; i < length; i++) {
		// 构建最大堆
		create_max_heap(array, length - i);

		// 根结点拿出 与最后一个结点交换 这样后面的结点就是排好序的
		int tmp = array[0];
		array[0] = array[length - i - 1];
		array[length - i - 1] = tmp;
	}
}
```

# 图
### 广度优先遍历
优先遍历第一层连接的结点，然后遍历所有第二层连接的结点，然后遍历所有第三层连接的结点
可用来
1、判断是否可达
2、找最短路径
``` go
// Breadth First Search
// map存图 => 结点：这个结点可达的结点
// start 起点， end 结束， 判断start是否可达end
func bfs(nodes map[int][]int, start, end int) bool {
    queue := []int{} // 队列记录要访问的结点
    record := map[int]bool{} // 记录是否访问过，访问过的不再访问，否则会死循环

    queue = append(queue, nodes[start]...)

    for i := 0; i < len(queue); i++ {
        if _, ok := record[queue[i]]; ok {
            continue
        }

        if queue[i] == end {
            return true
        }

        queue = append(queue, nodes[queue[i]]...)
        record[queue[i]] = true
    }

    return false
}

func TestBfs(t *testing.T) {
    nodes := map[int][]int{}
    nodes[1] = []int{2, 3, 4}
    nodes[2] = []int{2, 3, 4}
    nodes[3] = []int{2, 3, 4}
    nodes[4] = []int{2, 3, 4, 6}
    nodes[5] = []int{}
    nodes[6] = []int{4}

    t.Log(bfs(nodes, 1, 5))
    t.Log(bfs(nodes, 1, 6))
}
```

### 狄克斯特拉算法
找出加权图中的最短路径，只适用于有向无环图（directed acyclic graph，DAG），并且不能有负权重的边，如果有负权重的边，需要使用贝尔曼-福德算法（Bellman-Ford 
algorithm）。
对于有向负权无环图，对Bellman-Ford可以稍加修改，也可以适应： 如果已经出队/处理的结点，如果上面的值被更新，可以重新入队处理。
TODO: 
实现 场景

# 机器学习简单知识
分类就是编组，比如这个水果是橘子还是柚子
回归是预测结果，比如打分，广告系统ctr
K近邻算法KNN，根据最近的K个结点，计算结果。
K近邻算法分类： 根据最近的k个结点是哪一类，作为分类结果
K近邻算法回归预测： 根据最近的K个结点的值，算平均或者通过其他算法算出一个值，作为预测的结果值

数据采集->数据清洗->特征提取->模型创建 选择学习算法->模型训练/评估->模型预测

# 小点
网卡指标:
 100Mbps 1000Mbps 1Gbps  M bit per second
磁盘指标:
参数     |SSD 云盘|高效云盘  |普通云盘
---     |---     |---     |---
最大IOPS |20000   |3000    |数百
最大吞吐量|256 MBps|80 MBps	|30 MBps
IOPS 每秒读写次数，小文件看重
MBps M Byte per second 大文件看重