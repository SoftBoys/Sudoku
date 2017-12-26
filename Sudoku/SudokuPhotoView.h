//
//  SudokuPhotoView.h
//  SudokuDemo
//
//  Created by dfhb@rdd on 2017/12/26.
//  Copyright © 2017年 SoftBoys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SudokuPhotoView : UIView
/** 右上角是否显示删除按钮（默认YES） */
@property (nonatomic, assign) BOOL showDelBtn;

@property (nonatomic, copy) void (^tapBlock)(SudokuPhotoView *photo);
@property (nonatomic, copy) void (^longBlock)(SudokuPhotoView *photo);
@property (nonatomic, copy) void (^deleteBlock)(SudokuPhotoView *photo);

@property (nonatomic, strong) UIImage *image;

@end
