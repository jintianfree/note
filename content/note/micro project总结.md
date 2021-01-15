### go安装
https://golang.google.cn/dl/ 下载bin文件
```
# 解压到 /usr/local
tar -C /usr/local -xzf go1.14.3.linux-amd64.tar.gz
# 配置环境变量
export PATH=$PATH:/usr/local/go/bin
# 运行
go version
```

### go环境变量
```
GOROOT
# go的安装路径， 安装好go之后，这个变量就有了 不需要配置

GOPATH
# 在不使用go modules时，GOPATH是项目路径，
# 在使用go modules后， 只存放go get获取的包，有src\pkg\bin
# 需要把bin放到PATH目录中，这样go get下载的工具可以直接运行使用

go env -w GOPROXY=https://goproxy.cn,direct
# go 代理
# 设置go代理 go env -w 配置用户级别环境变量

go env -w GOPRIVATE=gitlab.xxx.com
# 配置私有仓库不走代理

go env -w GO111MODULE=on
# 打开go modules

go env -w GOSUMDB=off
# 关闭包到安全性校验 如果使用了不靠谱的代理 需要打开校验
```

### go get 使用
配置好以上环境变量

初始化一个moudle，模块名为你项目名
go mod init 模块名

下载项目依赖
go get ./...

拉取最新的版本(优先择取 tag)
go get golang.org/x/text@latest

拉取 master 分支的最新 commit
go get golang.org/x/text@master

拉取 tag 为 v0.3.2 的 commit
go get golang.org/x/text@v0.3.2

拉取 hash 为 342b231 的 commit，最终会被转换为 v0.3.2：
go get golang.org/x/text@342b2e

指定版本拉取，拉取v3版本
go get github.com/smartwalle/alipay/v3

更新
go get -u


下载modules到本地cache 目前所有模块版本数据均缓存在 $GOPATH/pkg/mod和 ​$GOPATH/pkg/sum 下
go mod download

编辑go.mod文件 选项有-json、-require和-exclude，可以使用帮助go help mod edit
go mod edit

以文本模式打印模块需求图
go mod graph

删除错误或者不使用的modules
go mod tidy

生成vendor目录
go mod vendor

验证依赖是否正确
go mod verify

查找依赖
go mod why

更新到最新版本
go get github.com/gogf/gf@version
如果没有指明 version 的情况下，则默认先下载打了 tag 的 release 版本，比如 v0.4.5 或者 v1.2.3；如果没有 release 版本，则下载最新的 pre release 版本，比如 v0.0.1-pre1。如果还没有则下载最新的 commit

更新到某个分支最新的代码
go get github.com/gogf/gf@master

更新到最新的修订版（只改bug的版本）
go get -u=patch github.com/gogf/gf

替代只能翻墙下载的库
go mod edit -replace=golang.org/x/crypto@v0.0.0=github.com/golang/crypto@latest
go mod edit -replace=golang.org/x/sys@v0.0.0=github.com/golang/sys@latest

清理moudle 缓存
go clean -modcache

查看可下载版本
go list -m -versions github.com/gogf/gf

### go micro服务的几种架构 
参考http://note.youdao.com/s/DsvXH0Rd，这里简单介绍http代理网关的方式
api gateway ： http代理，转发到聚合层
api 聚合     ： 使用web框架开发，正常http交互，通过grpc与后端服务交互，完成业务逻辑，响应
srv 服务     ： 提供grpc服务 与数据库交互 完成简单的逻辑 给api聚合层提供数据

### go micro聚合层
``` go
service := web.NewService()
service.Init()
    router := gin.New()
    gin.SetMode(gin.ReleaseMode)
    router.Use(gin.Logger(), middlewares.ErrorHandler, middlewares.Tracer)
	InitRouter(router)
	service.Handle("/", router)
	service.Run()

	func InitRouter(router *gin.Engine) {
    userHandler := handler.NewUserHandler()

    userRoute := router.Group("/all-walking/v1/user")
    {
        userRoute.POST("/login", userHandler.Login)
	}
	

	type userHandler struct {
    smsCli    protosms.SmsService
    userCli   protouser.UserService
    pointsCli protopoints.PointsService
}

func NewUserHandler() *userHandler {
    name := baseutils.GenMicroName("go.%s.srv.share")
    return &userHandler{
        userCli:   protouser.NewUserService(name, client.DefaultClient),

    }
}

func (u *userHandler) Login(ctx *gin.Context) {
    c, span, err := gin2micro.GetSpan(ctx)
    if err != nil {
        panic(err)
    }

    //获取参数
    deviceId := ctx.GetHeader("Device-ID")
    platformNo := ctx.GetHeader("Platform-No")
    systemId := helper.GetSystemId(ctx)
    if deviceId == "" || platformNo == "" || systemId == 0 {
        span.LogKV("err", "device或platform或systemId为空")
        panic(baseerror.ParamsIllegal)
    }

    rsp, err := u.userCli.Login(c, &protouser.LoginRequest{
        DeviceId:        deviceId,
        Imei:            ctx.GetHeader("IMEI"),
        Mac:             ctx.GetHeader("Mac"),
        AndroidId:       ctx.GetHeader("Android-ID"),
        PlatformNo:      platformNo,
        Imsi:            ctx.GetHeader("Imsi"),
        Version:         ctx.GetHeader("Version"),
        DeviceType:      ctx.GetHeader("Device-Type"),
        Channel:         ctx.GetHeader("Channel"),
        DeviceModel:     ctx.GetHeader("Device-Model"),
        DeviceBrand:     ctx.GetHeader("Device-Brand"),
        Idfa:            ctx.GetHeader("Idfa"),
        NetworkType:     ctx.GetHeader("Network-Type"),
        NetworkOperator: ctx.GetHeader("Network-Operator"),
        SystemId:        helper.GetSystemId(ctx),
    })
    if err != nil {
        span.LogKV("调用user服务失败", err.Error())
        panic(baseerror.SystemError)
    }

    var reply response.Reply
    reply.NewOkReply()
    reply.Data = LoginResponse{
        UserId:    rsp.UserId,
        Token:     rsp.Token,
        IsNewUser: rsp.IsNewUser,
        Nickname:  rsp.Nickname,
        HeadImg:   rsp.HeadImg,
    }

    ctx.JSON(http.StatusOK, reply)
}

```

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
docker run --rm -itd --name etcdkeeper -p 8080:8080 --env ETCD_HOST=172.17.0.1 --env ETCD_PORT=2379  --entrypoint  '/bin/sh' evildecay/etcdkeeper -c './etcdkeeper.bin -h $HOST -p $PORT -auth true'
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

### go micro wrapper
类似gin中间键的作用

``` go
package main

import (
    "context"
    "fmt"
    "github.com/micro/go-micro"
    "github.com/micro/go-micro/client"
    "github.com/micro/go-micro/registry"
    "github.com/micro/go-micro/web"
    "github.com/micro/go-plugins/registry/consul"
    "go-micro/Services"
    "go-micro/Weblib"
)

type logWrapper struct { //官方提供的例子，创建自己的struct，嵌套go-micro的client
    client.Client
}

//重写Call方法
func (this *logWrapper) Call(ctx context.Context, req client.Request, rsp interface{}, opts ...client.CallOption) error {
    fmt.Println("调用接口") //这样每一次调用调用接口时都会
    return this.Client.Call(ctx, req, rsp)
}

func NewLogWrapper(c client.Client) client.Client {
    return &logWrapper{c}
}

func main() {
    //下面两局代码是注册rpcserver调用客户端
    myService := micro.NewService(
        micro.Name("prodservice.client"),
        micro.WrapClient(NewLogWrapper), //在注册时只需要传入方法名即可，底层会自动给这个方法传入client
    )
    prodService := Services.NewProdService("prodservice", myService.Client())//生成的这个客户端绑定consul中存储的prodservice服务，只要调用了prodservice接口就会调用我们上面注册的中间件

    consulReg := consul.NewRegistry( //新建一个consul注册的地址，也就是我们consul服务启动的机器ip+端口
        registry.Addrs("localhost:8500"),
    )

    //其实下面这段代码的作用就是启动webserver的同事的时候把服务注册进去
    httpserver := web.NewService( //go-micro很灵性的实现了注册和反注册，我们启动后直接ctrl+c退出这个server，它会自动帮我们实现反注册
        web.Name("httpprodservice"),                   //注册进consul服务中的service名字
        web.Address(":8001"),                          //注册进consul服务中的端口,也是这里我们gin的server地址
        web.Handler(Weblib.NewGinRouter(prodService)), //web.Handler()返回一个Option，我们直接把ginRouter穿进去，就可以和gin完美的结合
        web.Registry(consulReg),                       //注册到哪个服务器上的consul中
    )
    httpserver.Init() //加了这句就可以使用命令行的形式去设置我们一些启动的配置
    httpserver.Run()
}
```
