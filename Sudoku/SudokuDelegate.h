//
//  SudokuDelegate.h
//  SudokuDemo
//
//  Created by dfhb@rdd on 2017/12/26.
//  Copyright © 2017年 SoftBoys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class SudokuBroswer;
@protocol SudokuDelegate <NSObject>

@optional

- (void)broswer:(SudokuBroswer *)broswer tapIndex:(NSInteger)index;
- (void)broswer:(SudokuBroswer *)broswer longIndex:(NSInteger)index;
- (void)broswer:(SudokuBroswer *)broswer deleteIndex:(NSInteger)index;

- (void)didSeleteCameraInBroswer:(SudokuBroswer *)broswer;

@end

@protocol SudokuDataSource <NSObject>

@optional

- (UIImage *)broswer:(SudokuBroswer *)broswer imageWithIndex:(NSInteger)index;

- (NSString *)broswer:(SudokuBroswer *)broswer urlWithIndex:(NSInteger)index;

- (NSInteger)numberOfBroswer:(SudokuBroswer *)broswer;

- (BOOL)showCameraButtonInBroswer:(SudokuBroswer *)broswer;
/** 返回拍照按钮 */
//- (UIButton *)cameraButtonInBroswer:(SudokuBroswer *)broswer;

//- (void)didSeleteCameraInBroswer:(SudokuBroswer *)broswer;

@end
