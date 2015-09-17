# iOS笔试题


----------
很抱歉
最近面试安排比较紧密，题目答完后一直没有比较连续的时间来完成代码部分，提交的时间较晚。

*Demo*还比较粗糙，ReactiveCocoa的使用也比较初级。

https://github.com/zqtian/iOSInterviewQuiz
https://www.zybuluo.com/zqtian/note/171975



----------


>1 . 简要描述观察者模式，并运用此模式编写一段代码；

观察者模式（Observer）是指一个或多个对象对另一个对象进行观察，当被观察对象发生变化时，观察者可以直接或间接地得到通知，从而能自动地更新观察者的数据，或者进行一些操作。

具体到iOS的开发中，实现观察者模式常用的方式有KVO和Notification两种。

两者的不同在于，KVO是被观察者主动向观察者发送消息；Notification是被观察者向NotificationCenter发送消息，再由NotificationCenter post通知到每个注册的观察者。

----------


>2 . 如何理解MVVM框架，它的优点和缺点在哪？运用此框架编写一段代码，建议采用ReactiveCocoa库实现；

MVVM框架相对于传统的MVC来说，主要区别在于把原本在C中（ViewController）的业务逻辑、网络请求、数据存储等操作和表现逻辑，分离到ViewModel中，从而使ViewController得到精简

MVC中，Controller同时操作Model和View；MVVM中，ViewModel作为一个过渡，Model的数据获取和加工由ViewModel负责，得到适合View的数据，利用绑定机制，使得View得以自动更新。


优点：
层次更加分明清晰
代码简洁优雅
减少VC的复杂性
代码和界面完全分离
方便测试

缺点：
MVVM需要使用数据绑定机制，对于OS X 开发，可以直接使用Coocoa Binding，对于iOS，没有太好的数据绑定方法，可以使用KVO，但如果需要绑定的属性太多的话，需要编写大量的selector代码。

ReactiveCocoa提供了一种很方便优雅的绑定机制。

----------


>3 . 解释以下代码的内存泄漏原因
 

``` objective-c
@implementation HJTestViewController
     
... ...
     
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       
    HJTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];
    [cell setTouchBlock:^(HJTestCell *cell) {
        [self refreshData];
    }];
       
   return cell;
}
     
... ...
     
@end
    
```

原因：
``` objective-c
[cell setTouchBlock:^(HJTestCell *cell) {
    [self refreshData];
}];
```
产生内存泄露的原因是因为循环引用

在给cell设置的TouchBlock中，使用了`__strong` 修饰的`self`，由于Block的原理，当touchBlock从栈复制到堆中时，`self`会一同复制到堆中，retain一次，被touchBlock持有，而touchBlock又是被cell持有的，cell又被tableView持有，tableView又被self持有，因此形成了循环引用：self间接持有touchBlock，touchBlock持有self

一旦产生了循环引用，由于两个object都被强引用，所以retainCount始终不能为0，无发释放，产生内存泄漏

解决办法：
使用weakSelf解除touchBlock对self的强引用
``` objective-c
__weak __typeof__(self) weakSelf = self;
[cell setTouchBlock:^(HJTestCell *cell) {
    [weakSelf refreshData];
}];
```

如果在block中多次使用 weakSelf的话，可以在block中先使用strongSelf，防止block执行时weakSelf被意外释放
对于非ARC，将 __weak 改用为 __block 即可

----------


