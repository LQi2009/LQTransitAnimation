# LQTransitAnimation
仿AppStore首页转场动画，自定义Present/dismiss与push/pop动画

根据自己需要，是present/dismiss还是使用导航的push/pop，分别引入相应头文件：
```
#import "UIViewController+LQPresentAnimate.h"

// 或者
#import "UIViewController+LQPush.h"
```

使用present/dismiss
```
// 见 ViewController.m

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TestViewController *test = [[TestViewController alloc]init];
    
#warning 两个控制器都要赋值
    test.originView = cell.bgView;
    self.originView = cell.bgView;
    
    test.imagePath = [self.dataSource objectAtIndex:indexPath.row];
    // 设置代理
    test.transitioningDelegate = self;
    [self presentViewController:test animated:YES completion:nil];
}

```
在返回的时候直接dismiss即可；

使用导航push/pop
```
// 见 PushTestViewController.m
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TestViewController *test = [[TestViewController alloc]init];
    
#warning 两个控制器都要赋值
    test.originView = cell.bgView;
    self.originView = cell.bgView;
    
    test.imagePath = [self.dataSource objectAtIndex:indexPath.row];
    
    // 设置push时的代理
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:test animated:YES];
}

```

上面的originView属性，如果动画方式不是使用的 LQTransitAnimationTypeScale，可以不赋值；
示意图
![LQTransitAnimationTypeScale](https://github.com/LQi2009/LQTransitAnimation/blob/master/scale.gif)

![LQTransitAnimationTypeCircle](https://github.com/LQi2009/LQTransitAnimation/blob/master/scale.gif)
