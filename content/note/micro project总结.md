### go micro服务的几种架构 
参考http://note.youdao.com/s/DsvXH0Rd，这里简单介绍http代理网关的方式
api gateway ： http代理，转发到聚合层
api 聚合     ： 使用web框架开发，正常http交互，通过grpc与后端服务交互，完成业务逻辑，响应
srv 服务     ： 提供grpc服务 与数据库交互 完成简单的逻辑 给api聚合层提供数据

### go micro聚合层

### go micro服务层

### protobuf
首先安装 protoc
然后根据项目需要先获取micro的版本，
go get github.com/micro/micro/v2
go get -u github.com/golang/protobuf/protoc-gen-go
go get github.com/micro/micro/v2/cmd/protoc-gen-micro

生成go代码
protoc --proto_path=user/proto --micro_out=user/proto --go_out=user/proto user/proto/user.proto

要注意micro的版本，如果有多个版本，可能protoc生成的go源码使用的不是你项目需要的版本
比如项目使用的micro/v2， protoc生成的代码可能使用的最新micro，导致代码无法编译通过
这时候把micro清理下 重新get micro/v2，重新get protoc-gen-go 和protoc-gen-micro

### etcd 安装
```
docker run --rm -itd --name etcd --env ETCD_LISTEN_CLIENT_URLS=http://0.0.0.0:2379 --env ALLOW_NONE_AUTHENTICATION=yes  -p 2379:2379 -p 2380:2380  -v /home/vagrant/etcd_data:/bitnami/etcd/ bitnami/etcd
```
通过挂载本地目录 etcd数据放到宿主机/home/vagrant/etcd_data目录 

etcd数据备份与恢复/线上环境导入测试环境，导入后重启etcd
```
ETCDCTL_API=3 etcdctl snapshot save snapshot.db
ETCDCTL_API=3 etcdctl snapshot restore snapshot.db --data-dir=/home/vagrant/etcd_data/data
```


### etcdkeeper安装
```
docker run --rm -it --name etcdkeeper -p 8080:8080 evildecay/etcdkeeper 
```
安装好之后 打开浏览器输入etcd地址 就可以使用了  注意因为使用的docker 不能使用127.0.0.1:2319 而要使用docker网关的ip地址

如果etcd有密码使用--entrypoint 覆盖启动命令 加上-auth true参数
```
docker run --rm -itd --name etcdkeeper -p 8080:8080 --env ETCD_HOST=172.17.0.1 --env ETCD_PORT=2379  --entrypoint  '/bin/sh' evildecay/etcdkeeper '-c ./etcdkeeper.bin -h $HOST -p $PORT -auth true'
```

### micro api 网关
micro支持多种模式，详情看（http://note.youdao.com/s/DsvXH0Rd），这里我们使用http方式，网关做http代理，源格式转发到后端api层，api层可以使用任意http框架
```
# 启动api网关
./micro api --handler http  --address 0.0.0.0:8088
# 使用etcd启动api网关  不支持etcd密码， 注意registry参数要在api前面
./micro   --registry etcd --registry_address 127.0.0.1:2379  api --handler http  --address 0.0.0.0:8088
```
micro可以添加插件，比如加入token校验插件、slb健康响应插件、跨域插件等。

添加插件Example
```
package main

import (
	"log"
	"github.com/urfave/cli/v2"
	"github.com/micro/micro/plugin"
)

func init() {
	plugin.Register(plugin.NewPlugin(
		plugin.WithName("example"),
		plugin.WithFlag(&cli.StringFlag{
			Name:   "example_flag",
			Usage:  "This is an example plugin flag",
			EnvVars: []string{"EXAMPLE_FLAG"},
			Value: "avalue",
		}),
		plugin.WithInit(func(ctx *cli.Context) error {
			log.Println("Got value for example_flag", ctx.String("example_flag"))
			return nil
		}),
	))
}
```

插件build到micro
```
go build -o micro ./main.go ./plugin.go
```

