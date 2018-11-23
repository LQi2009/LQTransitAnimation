//
//  ViewController.m
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/21.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import "PushTestViewController.h"
#import "TestTableViewCell.h"
#import "UITableViewCell+LQScaleAnimate.h"
#import "TestViewController.h"
#import "UIViewController+LQPush.h"

@interface PushTestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation PushTestViewController

- (void) hiddenCardNumber:(NSString *) cardNumber {
    
    NSString *last = [cardNumber substringFromIndex:cardNumber.length - 4];
    
    NSString *showStr = [NSString stringWithFormat:@"**** **** **** %@", last];
    
    NSLog(@"%@", showStr);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 1; i < 5; i++) {
        
        NSString *name = [NSString stringWithFormat:@"%d.jpg", i];
        [self.dataSource addObject:name];
    }
    
    [self.table registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"TestTableViewCellID"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCellID" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    cell.image.image = image;
    return cell ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count ;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell startAnimate];
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell endAnimate];
}

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
    // 设置present时的代理
    //    test.transitioningDelegate = self;
//    [self presentViewController:test animated:YES completion:nil];
}

- (UITableView *)table {
    
    if (_table == nil) {
        _table = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 300 ;
        [self.view addSubview:_table];
    }
    
    return _table;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}
@end
