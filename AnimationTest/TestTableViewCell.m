//
//  TestTableViewCell.m
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/21.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.image.frame = self.contentView.bounds ;
    
     self.bgView.frame = CGRectInset(self.contentView.bounds, 10, 10) ;
//    self.image.contentMode;
}

- (UIImageView *)image {
    
    if (_image == nil) {
        _image = [[UIImageView alloc]init];
        
//        _image.layer.cornerRadius = 8;
//        _image.layer.masksToBounds = YES;
        [self.bgView addSubview:_image];
    }
    
    return _image ;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
//        _bgView.frame = CGRectInset(self.contentView.bounds, 10, 10) ;
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
    }
    
    return _bgView;
}
@end
