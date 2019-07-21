//
//  JSDMyCenterVC.m
//  MaterialColor
//
//  Created by ada on 2019/7/21.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDMyCenterVC.h"

#import "JSDPublic.h"
#import <MaterialSnackbar.h>
#import "JSDFeedbackVC.h"

@interface JSDMyCenterVC ()

@end

@implementation JSDMyCenterVC

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - 1.View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //4.设置通知
    [self setupNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"About US";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_grayColor];
    
    [self.collectionView registerClass:[MDCCollectionViewTextCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MDCCollectionViewTextCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"App Version";
        cell.detailTextLabel.text = @"1.0.0";
        
    } else if (indexPath.row == 1) {
        
        cell.textLabel.text = @"Feedback";
        cell.detailTextLabel.numberOfLines = 4;
        cell.detailTextLabel.text = @"Thank you very much for using it. If you have any questions or comments during the use, I hope to get your feedback!";
    } else {
        
        cell.detailTextLabel.numberOfLines = 2;
        cell.textLabel.text = @"Website";
        cell.detailTextLabel.text = @"https://www.jianshu.com/p/469c02b6dc15";
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    if (indexPath.row == 1) {
        
        JSDFeedbackVC* feedbackVC = [[JSDFeedbackVC alloc] init];
        [self.navigationController pushViewController:feedbackVC animated:YES];
        
    } else if (indexPath.row == 2) {
        MDCSnackbarManager* snackbar = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"The official website has been copied to the clipboard"];
        UIPasteboard* pasterboard = [[UIPasteboard alloc] init];
        //TODO:官网
        pasterboard.string = @"https://www.jianshu.com/p/469c02b6dc15";
        [snackbar showMessage:message];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    
    return CGSizeMake(size.width, 100);
}

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end

