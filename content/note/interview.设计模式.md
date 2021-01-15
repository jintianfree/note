# 装饰器模式
Decorator 别名Wrapper包装器
层层包装，动态的给一个对象增强功能。装饰器一般会有多个，一个对象可以使用全部装饰器，也可以只使用一个。
动态增强是指装饰的对象是在运行的时候传给装饰器的，使用哪个装饰器也可以根据条件动态的判断。
这一点有别于代理模式，但代理模式也有个动态代理，也是运行阶段指定代理哪一个对象。所以区别装饰器和代理，我认为1.装饰器一般是增强，代理一般是控制对被代理的访问， 2.装饰器支持多层套装，可以套用多个装饰器。

看代码。

-
|继承图 |       |   
| ---- | ----  | 
|Interface|    | 
|Demo  |Wrapper| 
|      |WA WB WC|

-
|只有一个装饰器情况下的|简化继承图|   
| ---- | ----  | 
|Interface|    | 
|Demo  |WA| 

``` c++
#include <iostream>

// 定义一个接口 装饰器和被装饰的类都需要继承这个接口
class Interface
{
public:
	virtual void func() = 0;
};

// 定义一个要被装饰的类
class Demo : public Interface
{
public:
	virtual void func() { std::cout << "这是我的基本功能" <<std::endl; }
};

// 定义装饰器接口
// 如果只有一个装饰器的情况下 可不定义装饰器接口 直接继承Interface实现装饰器类
class DemoWrapper : public Interface
{
public:
	DemoWrapper(Interface *demo): d(demo) {}
	virtual void func() {d->func();}
private:
	Interface *d;
};

// 定义装饰器A 实现装饰器接口
class DemoWrapperA: public DemoWrapper
{
public:
	DemoWrapperA(Interface *d): DemoWrapper(d) {}
	virtual void func() { std::cout << "增强了功能A"  << std::endl; DemoWrapper::func();  }
};

// 定义装饰器B 实现装饰器接口
class DemoWrapperB: public DemoWrapper
{
public:
	DemoWrapperB(Interface *d): DemoWrapper(d) {}
	virtual void func() { std::cout << "增强了功能B"  << std::endl; DemoWrapper::func();  }
};

// 定义装饰器C 实现装饰器接口
class DemoWrapperC: public DemoWrapper
{
public:
	DemoWrapperC(Interface *d): DemoWrapper(d) {}
	virtual void func() { std::cout << "增强了功能C"  << std::endl; DemoWrapper::func();  }
};

int main()
{
	// 忽略内存泄漏
	// 声明一个被装饰的对象
	Interface *d = new Demo();
	d->func();

	// 装饰
	d = new DemoWrapperA(d);
	// 装饰后增强
	d->func();

	// 装饰
	d = new DemoWrapperB(d);
	// 装饰后增强
	d->func();

	// 装饰
	d = new DemoWrapperC(d);
	// 装饰后增强
	d->func();

	return 0;
}
```

# 代理模式
Proxy， 别名委托模式，代理模式通常是控制对被代理对象对访问，封装一些被代理对象的细节或者复杂操作，与装饰器不同，装饰器模式通常是对被增强对象进行多个功能的增强。智能指针就是一个代理模式。
代理类可以和被代理类继承自同一个接口，代理类内部调用被代理类的方法；代理类也可以是被代理类的一个封装，提过另一套接口对外服务，内部也是调用被代理类的方法。

# 单例模式
``` c++
// C++11 之前静态对象的访问不是线程安全的，可以使用双锁检查+内存栅栏  C++11之后可以使用这种方式 保证线程安全
class SingleDemo
{
private:
	SingleDemo();

public:
	static SingleDemo *Instance();
};

SingleDemo *SingleDemo::Instance()
{
    static SingleDemo demo;
    return &demo;
}

SingleDemo::SingleDemo()
{
}

```