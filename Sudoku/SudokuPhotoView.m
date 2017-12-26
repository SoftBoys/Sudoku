//
//  SudokuPhotoView.m
//  SudokuDemo
//
//  Created by dfhb@rdd on 2017/12/26.
//  Copyright © 2017年 SoftBoys. All rights reserved.
//

#import "SudokuPhotoView.h"

@interface SudokuPhotoView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button_delete;
@end

@implementation SudokuPhotoView
- (instancetype)init {
    if (self = [super init]) {
        [self initSelf];
    }
    return self;
}
- (void)initSelf {
    [self addSubview:self.imageView];
    [self addSubview:self.button_delete];
    
    self.imageView.backgroundColor = [UIColor orangeColor];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
    CGFloat buttonW = 18,buttonH = buttonW;
    self.button_delete.frame = CGRectMake(CGRectGetWidth(self.bounds)-buttonW/2, -buttonH/2, buttonW, buttonH);
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 点击区域是否在删除按钮上
    BOOL contains = CGRectContainsPoint(self.button_delete.frame, point);
    if (contains) {
        return self.button_delete;
    }
    return [super hitTest:point withEvent:event];
}
#pragma mark -
- (void)tapClick:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        
    } else if (tapGesture.state == UIGestureRecognizerStateEnded) {
        __weak __typeof(self) weakself = self;
        self.tapBlock ? self.tapBlock(weakself) : nil;
    }
}
- (void)longClick:(UILongPressGestureRecognizer *)longGesture {
    
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        __weak __typeof(self) weakself = self;
        self.longBlock ? self.longBlock(weakself) : nil;
    }
}
- (void)deleteClick {
    __weak __typeof(self) weakself = self;
    self.deleteBlock ? self.deleteBlock(weakself) : nil;
}

- (void)setImage:(UIImage *)image {
    
    _imageView.image = image;
}
#pragma mark -
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.borderColor = [UIColor colorWithWhite:243/255.0 alpha:1].CGColor;
        _imageView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _imageView.userInteractionEnabled = YES;
        
        // 添加单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_imageView addGestureRecognizer:tapGesture];
        
        // 添加长按手势
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick:)];
        [_imageView addGestureRecognizer:longGesture];
    }
    return _imageView;
}
- (UIButton *)button_delete {
    if (!_button_delete) {
        _button_delete = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_delete.backgroundColor = [UIColor colorWithRed:252/255.0 green:51/255.0 blue:97/255.0 alpha:1];
        [_button_delete addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_delete;
}
@end
