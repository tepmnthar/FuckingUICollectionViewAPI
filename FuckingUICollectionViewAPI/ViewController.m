//
//  ViewController.m
//  FuckingUICollectionViewAPI
//
//  Created by tepmnthar on 2018/8/29.
//  Copyright © 2018 Benqumark. All rights reserved.
//

#import "ViewController.h"

#import "TestCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) UICollectionView* collectionView;

@end

@implementation ViewController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = ({
            UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
            
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.itemSize = CGSizeMake(50, 50);
            
            layout;
        });
        _collectionView = ({
            UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            
            [self.view addSubview:collectionView];
            [collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
            [collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
            [collectionView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
            [collectionView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
            [collectionView.heightAnchor constraintEqualToConstant:50].active = YES;
            collectionView.translatesAutoresizingMaskIntoConstraints = NO;
            
            collectionView.backgroundColor = UIColor.blackColor;
            collectionView.showsVerticalScrollIndicator = NO;
            collectionView.showsHorizontalScrollIndicator = NO;
            [collectionView registerClass:TestCell.class forCellWithReuseIdentifier:NSStringFromClass(TestCell.class)];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            
            collectionView;
        });
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self collectionView];
    
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCell* cell = (TestCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TestCell.class) forIndexPath:indexPath];
        
    return cell;
}

// 1. 1st situation: selection lost during <long press then scrolling>
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@", indexPath);
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}

// 2. 2nd situation: selection lost when <clicking another cell> and <long press then scrolling>
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@", indexPath);
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}

// 3. 3rd situation: selection lost when <clicking another cell>, seems correct when <long press then scrolling>
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@", indexPath);
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//    if ([collectionView.indexPathsForSelectedItems containsObject:indexPath]) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

// 4. 4th situation: hacky fix
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView.indexPathsForSelectedItems containsObject:indexPath]) {
        return YES;
    } else {
        [collectionView performBatchUpdates:^{
            
        } completion:^(BOOL finished) {
            [collectionView cellForItemAtIndexPath:collectionView.indexPathsForSelectedItems.firstObject].selected = YES;
        }];
        return NO;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView.indexPathsForSelectedItems containsObject:indexPath]) {

    } else {
        [collectionView performBatchUpdates:^{
            
        } completion:^(BOOL finished) {
            [collectionView cellForItemAtIndexPath:collectionView.indexPathsForSelectedItems.firstObject].selected = YES;
        }];
    }

    return YES;
}

@end
