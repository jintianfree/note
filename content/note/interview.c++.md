## static
1. static全局函数和变量只在本文件中生效  其他文件可定义同名的static变量或函数 不会出现命名冲突； 会在程序刚开始运行时就完成初始化，调用构造函数，也是唯一的一次初始化，多个全局static变量的初始化顺序不能保证。
2. static局部变量，本{}内有效  在第一次使用时初始化，调用构造函数。
3. static成员变量，可以通过类名访问，需要在类中声明，类外面定义，在程序运行时完成初始化


## 虚函数 纯虚函数 虚基类
类的成员函数前加virtual就是虚函数，声明成员函数加，定义不用加，虚函数主要实现多态性。
成员函数只有声明没有实现，可以在最后加一个=0，这样就是纯虚函数，纯虚函数可以在继承类中实现。纯虚函数往往用来定义接口。
虚继承 class B: virtual public A， 主要解决派生类中保留多份父父类成员的问题，父父类称为虚基类。

## 重载 重写 覆盖
重载overload，是指同一可访问区内可以声明几个具有不同参数列表（参数的类型，个数，顺序不同）的同名函数，和函数返回值没有关系。
覆盖override,派生类中存在重新定义的函数。其函数名，参数列表，返回值类型，所有都必须同基类中被重写的函数一致。重写的基类中被重写的函数必须有virtual修饰。
重写Overwrite（隐藏）是指派生类的函数屏蔽了与其同名的基类函数，因此在派生类对象中无法再调用基类中被隐藏的函数，如果派生类的函数与基类的函数同名，但是参数不同。此时，不论有无virtual关键字，基类的函数将被隐藏； 如果派生类的函数与基类的函数同名，并且参数也相同，但是基类函数没有virtual关键字。此时，基类的函数被隐藏。

## OOP设计五项原则
单一职责原则
接口隔离原则
  多接口代替一个胖接口
开放-封闭原则
  支持扩展 不支持修改
替换原则
依赖倒置原则
  高层不应该依赖于底层，两者都应该依赖于抽象

## 指针和引用
（1）非空区别。在任何情况下都不能使用指向空值的引用。因此如果你使用一个变量并让它指向一个对象，但是该变量在某些时候也可能不指向任何对象，这时你应该把变量声明为指针，因为这样你可以赋空值给该变量。相反，如果变量肯定指向一个对象，例如你的设计不允许变量为空，这时你就可以把变量声明为引用。不存在指向空值的引用这个事实意味着使用引用的代码效率比使用指针要高。
（2）合法性区别。在使用引用之前不需要测试它的合法性。相反，指针则应该总是被测试，防止其为空。
（3）可修改区别。指针与引用的另一个重要的区别是指针可以被重新赋值以指向另一个不同对象。但是引用则总是指向在初始化时被指定的对象，以后不能改变，但是指定的对象其内容可以改变。

C++ 11

5 、请你说说工厂模式的优点？
6 、请你说一下观察者模式

14 、说一说C++中四种 cast 转换
44 、请你来说一说隐式类型转换
45 、说说你了解的类型转换

16 、给定三角形 ABC 和一点 P ( x , y , z ) ，判断点 P 是否在 ABC 内，给出思路并手写代码


18 、怎么判断一个数是二的倍数，怎么求一个数中有几个1，说一下你的思路并手写代码


17 、请你说一下你理解的C++中的 smart pointer 四个智能指针：shared_ptr , unique_ptr , weak_ptr , auto_ptr
39 、请你来说一下智能指针 shared _ ptr 的实现
25 、请你来说一下C++中的智能指针
22 、请你回答一下智能指针有没有内存泄露的情况
23 、请你来说一下智能指针的内存泄漏如何解决


29 、请你来说一下C++中析构函数的作用
26 、请你回答一下为什么析构函数必须是虚函数？为什么C++默认的析构函数不是虚函数

27 、请你来说一下函数指针

28 、请你来说一下 fork 函数


38 、有段代码写成了下边这样，如果在只修改一个字符的前提下，使代码输出 20 个 hello ? for ( int i = 0; i < 20; i++） cout < < " hello " < < endl ;

41 、请你来说一下 C + ＋里是怎么定义常量的？常量存放在内存的哪个位置？
42 、请你来回答一下 const 修饰成员函数的目的是什么？
43 、如果同时定义了两个函数，一个带 const ，一个不带，会有问题吗？



46 、请你来说一说 C++函数栈空间的最大值

47 、请你来说一说 extern " C "

48 、请你回答一下 new / delete 与 malloc / free 的区别是什么

49 、请你说说你了解的 RTTI

50 、请你说说虚函数表具体是怎样实现运行时多态的?

51 、请你说说 C 语言是怎么进行函数调用的？
52 、请你说说 C 语言参数压栈顺序？

53 、请你说说 C++如何处理返回值？

54 、请你回答一下 C++中拷贝赋值函数的形参能否进行值传递？


56 、请你说一说 select
70 、请你说一说 epoll 原理

57 、请你说说 fork，wait，exec 函数

58 、请你回答一下静态函数和虚函数的区别


62 、请你来说一下 map 和 set 有什么区别，分别又是怎么实现的？

63 、请你来介绍一下 STL 的 allocaotr

64 、请你来说一说 STL 迭代器删除元素

65 、请你说一说 STL 中 map 数据存放形式

66 、请你讲讲 STL 有什么基本组成

67 、请你说说 STL 中 map 与 unordered_map

68 、请你说一说 vector 和 list 的区别，应用，越详细越好

69 、请你来说一下 STL 中迭代器的作用，有指针为何还要迭代器


71 、请你说一说 STL 迭代器是怎么删除元素的呢

72 、请你说一说 STL 中 map 数据存放形式

73 、 n 个整数的无序数组，找到每个元素后面比它大的第一个数，要求时间复杂度为 O(N)

74 、请你回答一下 STL 里 resize 和 reserve 的区别

75 、请你来说一说 STL 迭代器删除元素

76 、请你说一说 STL 中 MAP 数据存放形式

77 、请你讲讲 STL 有什么基本组成

78 、请你说说 STL 中 map 与 unordered_map

79 、请你说一说 vector 和 list 的区别，应用，越详细越好

80 、请你来说一下 STL 中迭代器的作用，有指针为何还要迭代器


82 、请你说一说 STL 迭代器是怎么删除元素的呢

83 、请你说一说 STL 中 MAP 数据存放形式

84 、 n 个整数的无序数组，找到每个元素后面比它大的第一个数，要求时间复杂度为 O(N)

85 、请你回答一下 STL 里 resize 和 reserve 的区别

86 、请你说一说 STL 里面 set 和 map 怎么实现的

87、请你来说一下 C++ 中类成员的访问权限

88 、请你来说一下 C++ 中 struct 和 c } ass 的区别

89 、请你回答一下 C++ 类内可以定义引用数据成员吗个

90 、请你回答一下什么是右值引用，跟左值又有什么区别？

91 、请你来说一下一个 C++ 源文件从文本到可执行文件经历的过程？

92 、请你来回答一下 include 头文件的顺序以及双引号" "和尖括号＜＞的区别？

93 、请你回答一下 malloc 的原理，另外 brk 系统调用和 mmap 系统调用的作用分别是什么？

94 、请你说一说 C++的内存管理是怎样的？

95 、请你来说一下 C++ / C 的内存分配

96 、请你回答一下如何判断内存泄漏？

97 、请你来说一下什么时候会发生段错误

98 、请你来回答一下什么是 memory leak ，也就是内存泄漏

99 、请你来回答一下 new 和 malloc 的区别

100 、请你来说一下共享内存相关 api

101 、请你来说一下 reactor 模型组成

102 、请自己设计一下如何采用单线程的方式处理高并发

103 、请你说一说 C++ STL 的内存优化

104 、请你说说 select , epoll 的区别，原理，性能，限制都说一说

105 、请你说说 C++如何处理内存泄漏？

106 、请问 C++ 11 有哪些新特性？

107 、请你详细介绍一下 C++ 11 中的可变参数模板、右值引用和 lambda 这几个新特性。

108 、请你说一下进程与线程的概念，以及为什么要有进程线程，其中有什么区别，他们各自又是怎么同步的

109 、请你说一说 Linux 虚拟地址空间

110 、请你说一说操作系统中的程序的内存结构

111 、请你说一说操作系统中的缺页中断

112 、请你回答一下 fork 和 vfork 的区别

113 、请问如何修改文件最大句柄数？

114 、请你说一说并发（ concurrency ）和并行 ( parallelism )

115 、请问 MySQL 的端口号是多少，如何修改这个端口号

116 、请你说一说操作系统中的页表寻址

117 、请你说一说有了进程，为什么还要有线程？

118 、请问单核机器上写多线程程序，是否需要考虑加锁，为什么？

119 、请问线程需要保存哪些上下文， SP 、 PC 、 EAX 这些寄存器是干嘛用的

120 、请你说一说线程间的同步方式，最好说出具体的系统调用