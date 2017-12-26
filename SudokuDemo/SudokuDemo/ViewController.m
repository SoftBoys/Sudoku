//
//  ViewController.m
//  Sudoku
//
//  Created by dfhb@rdd on 2017/12/26.
//  Copyright © 2017年 SoftBoys. All rights reserved.
//

#import "ViewController.h"

#import "SudokuBroswer.h"

@interface ViewController () <SudokuDelegate, SudokuDataSource>
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) SudokuBroswer *broswer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _photos = @[@"list_index_01", @"list_index_02", @"list_index_03",@"list_index_04", @"list_index_05", @"list_index_06",@"list_index_01", @"list_index_02", @"list_index_03",@"list_index_04", @"list_index_05", @"list_index_06"].mutableCopy;
    
    SudokuBroswer *broswer = [SudokuBroswer new];
    broswer.frame = CGRectMake(0, 100, 320, 0);
    [self.view addSubview:broswer];
    _broswer = broswer;
    broswer.backgroundColor = [UIColor grayColor];
    
    broswer.delegate = self;
    broswer.dataSource = self;
    
    [broswer reloadData];
    
}

#pragma mark - SudokuDelegate
- (void)broswer:(SudokuBroswer *)broswer tapIndex:(NSInteger)index {
    NSLog(@"tapIndex:%@",@(index));
}
- (void)broswer:(SudokuBroswer *)broswer longIndex:(NSInteger)index {
    NSLog(@"longIndex:%@",@(index));
}
- (void)broswer:(SudokuBroswer *)broswer deleteIndex:(NSInteger)index {
    NSLog(@"deleteIndex:%@",@(index));
    if (index < _photos.count) {
        [_photos removeObjectAtIndex:index];
        [broswer reloadData];
    }
}
- (void)didSeleteCameraInBroswer:(SudokuBroswer *)broswer {
    NSLog(@"camera");
}
#pragma mark - SudokuDataSource
- (UIImage *)broswer:(SudokuBroswer *)broswer imageWithIndex:(NSInteger)index {
    NSString *imageNamed = _photos[index];
    return [UIImage imageNamed:imageNamed];
}
- (NSInteger)numberOfBroswer:(SudokuBroswer *)broswer {
    return _photos.count;
}
- (BOOL)showCameraButtonInBroswer:(SudokuBroswer *)broswer {
    
    return _photos.count < 9;
}
@end
