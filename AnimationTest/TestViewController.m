//
//  TestViewController.m
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/22.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import "TestViewController.h"
#import "UIView+LQPanScale.h"

@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton* __backButton;
}

//@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *table;
@end

@implementation TestViewController

- (void)setImagePath:(NSString *)imagePath {
 
    _imagePath = imagePath;
    self.imageView.image = [UIImage imageNamed:imagePath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.table.tableHeaderView = self.imageView;
    
    UIButton *back = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    back.frame = CGRectMake(20, 120, 100, 40);
    back.backgroundColor = [UIColor redColor];
    [back setTitle:@"返回" forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    __backButton = back;
    
    __weak typeof(self)ws = self;
    [self.table panToScaleViewWithHandler:^{
        self->__backButton.hidden = YES;
        [ws dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testid"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"testid"];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (void) backAction {
 
    __backButton.hidden = YES;
    [self.table setContentOffset:CGPointZero animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImageView *)imageView {
 
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor greenColor];
        _imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300);
//        [self.view addSubview:_imageView];
//        [self.view insertSubview:_imageView atIndex:0];
    }
    
    return _imageView ;
}

- (UITableView *)table {
    
    if (_table == nil) {
        _table = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        
        _table.delegate = self;
        _table.dataSource = self;
        
        [self.view addSubview:_table];
    }
    
    return _table ;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
