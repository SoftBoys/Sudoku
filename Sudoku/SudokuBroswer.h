//
//  SudokuBroswer.h
//  SudokuDemo
//
//  Created by dfhb@rdd on 2017/12/26.
//  Copyright © 2017年 SoftBoys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuDelegate.h"


@interface SudokuBroswer : UIView <SudokuDelegate>
/** 宽度 */
@property (nonatomic, assign) CGFloat broswerW;

/** 横向间距 */
@property (nonatomic, assign) CGFloat paddingW;
/** 纵向间距 */
@property (nonatomic, assign) CGFloat paddingH;
/** 左侧间距 */
@property (nonatomic, assign) CGFloat paddingX;
/** 顶部间距 */
@property (nonatomic, assign) CGFloat paddingY;

@property (nonatomic, weak) id<SudokuDelegate> delegate;

@property (nonatomic, weak) id<SudokuDataSource> dataSource;

/** 刷新页面 */
- (void)reloadData;

@end
