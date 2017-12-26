//
//  SudokuBroswer.m
//  SudokuDemo
//
//  Created by dfhb@rdd on 2017/12/26.
//  Copyright © 2017年 SoftBoys. All rights reserved.
//

#import "SudokuBroswer.h"
#import "SudokuPhotoView.h"

@interface SudokuBroswer ()
@property (nonatomic, strong) UIButton *button_camera;
@property (nonatomic, strong) NSMutableArray *photoList;
@property (nonatomic, assign) NSInteger numberOfPhotos;
@end
@implementation SudokuBroswer
- (instancetype)init {
    if (self = [super init]) {
        [self initSelf];
    }
    return self;
}
- (void)initSelf {
    
//    _maxCount = 9;
    _broswerW = [UIScreen mainScreen].bounds.size.width;
    _photoList = @[].mutableCopy;
    _paddingW = 10;
    _paddingH = 10;
    _paddingX = 10;
    _paddingY = 10;
//    _showCamera = YES;
    
}
- (void)setupUI {
    
    //
    if (_photoList.count < _numberOfPhotos) {
        for (NSInteger i = _photoList.count; i < _numberOfPhotos; i++) {
            __weak __typeof(self) weakself = self;
            SudokuPhotoView *photoView = [SudokuPhotoView new];
            photoView.tapBlock = ^(SudokuPhotoView *photo) {
                __strong __typeof(weakself) strongself = weakself;
                [strongself changePhotoView:photo type:1];
            };
            photoView.longBlock = ^(SudokuPhotoView *photo){
                __strong __typeof(weakself) strongself = weakself;
                [strongself changePhotoView:photo type:2];
            };
            photoView.deleteBlock = ^(SudokuPhotoView *photo){
                __strong __typeof(weakself) strongself = weakself;
                [strongself changePhotoView:photo type:3];
            };
            [self addSubview:photoView];
            [_photoList addObject:photoView];
        }
    }
    
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _broswerW = frame.size.width;
    
}

- (void)changePhotoView:(SudokuPhotoView *)photoView type:(NSInteger)type {
    // type 1 单击 2 长按 3 删除 4 拍照
    NSInteger index = photoView.tag - 100;
    if (type == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(broswer:tapIndex:)]) {
            [_delegate broswer:self tapIndex:index];
        }
    } else if (type == 2) {
        if (_delegate && [_delegate respondsToSelector:@selector(broswer:longIndex:)]) {
            [_delegate broswer:self longIndex:index];
        }
    } else if (type == 3) {
        if (_delegate && [_delegate respondsToSelector:@selector(broswer:deleteIndex:)]) {
            [_delegate broswer:self deleteIndex:index];
        }
    } else if (type == 4) {
        if (_delegate && [_delegate respondsToSelector:@selector(didSeleteCameraInBroswer:)]) {
            [_delegate didSeleteCameraInBroswer:self];
        }
    }
    
}

#pragma mark -
- (void)reloadData {
    // 1.创建视图
    _numberOfPhotos = [_dataSource numberOfBroswer:self];
    [self setupUI];
    
    // 2.设置Frame
    CGFloat photoW = (_broswerW-_paddingW*2-_paddingX*2)/3;
    CGFloat photoH = photoW;
    
//    NSInteger maxcount = MIN(_numberOfPhotos, _maxCount);
    __block UIView *lastView = nil;
    [_photoList enumerateObjectsUsingBlock:^(SudokuPhotoView *photoView, NSUInteger idx, BOOL * _Nonnull stop) {
        photoView.tag = 100 + idx;
//        NSInteger
        if (idx < _numberOfPhotos) {
            photoView.hidden = NO;
            CGFloat photoX = (idx % 3) * (photoW+_paddingW) + _paddingX;
            CGFloat photoY = (idx / 3) * (photoH+_paddingH) + _paddingY;
            photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
            
            photoView.image = [_dataSource broswer:self imageWithIndex:idx];
            lastView = photoView;
        } else {
            photoView.hidden = YES;
        }
    }];
    
    if ([_dataSource respondsToSelector:@selector(showCameraButtonInBroswer:)]) {
        BOOL showCamera = [_dataSource showCameraButtonInBroswer:self];
        
        if (showCamera) {
            CGFloat photoX = (_numberOfPhotos % 3) * (photoW+_paddingW) + _paddingX;
            CGFloat photoY = (_numberOfPhotos / 3) * (photoH+_paddingH) + _paddingY;
            self.button_camera.frame = CGRectMake(photoX, photoY, photoW, photoH);
            lastView = self.button_camera;
        }
        
    }
    
    
    
    CGFloat height = lastView ? CGRectGetMaxY(lastView.frame) + _paddingY : 0;
    CGRect frame = self.frame;
    frame.size.width = _broswerW;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark -
- (UIButton *)button_camera {
    if (!_button_camera) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _button_camera = button;
    }
    return _button_camera;
}
- (void)cameraClick {
    [self changePhotoView:nil type:4];
}

@end
