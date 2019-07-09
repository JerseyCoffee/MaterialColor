//
//  JSDMainColorViewController.m
//  MaterialColor
//
//  Created by ada on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDMainColorViewController.h"

#import <MaterialButtons.h>
#import "JSDMainColorTableViewCell.h"
#import "JSDMainColorModel.h"
#import "JSDPublic.h"
#import "JSDHomeViewController.h"

@interface JSDMainColorViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, copy) NSArray<JSDMainColorModel* >* colorModelArray;

@end

@implementation JSDMainColorViewController

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
    
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
        if (@available(iOS 11.0,*)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.bottom.mas_equalTo(0);
        }
    }];
    
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.colorModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JSDMainColorTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell && cell.flatButton.tag == indexPath.section) {
        
        return cell;
    } else {
        cell = [[JSDMainColorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        if (self.colorModelArray[indexPath.section].colorValue) {
            cell.flatButton.backgroundColor = [UIColor jsd_colorWithHexString:self.colorModelArray[indexPath.section].colorValue];
            cell.flatButton.tag = indexPath.section;
            [cell.flatButton addTarget:self action:@selector(onTouchColor:) forControlEvents:UIControlEventTouchUpInside];
            if ([self.colorModelArray[indexPath.section].colorName isEqualToString:@"Amber"]) {
                // TODO: 异常 Bug
                NSLog(@"%@", self.colorModelArray[indexPath.section].colorValue);
                cell.flatButton.backgroundColor = [UIColor jsd_colorWithHexString:@"#FF7E00"];
            }
        } else {
            cell.flatButton.backgroundColor = [UIColor blackColor];
        }
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView* footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    
    return footerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 5;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    return headerView;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section ? 0 : 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 5.Event Response

- (void)onTouchColor:(MDCButton *)sender {
    

    NSString* colorName = self.colorModelArray[sender.tag].colorName;
    
    NSDictionary* object = @{
        @"colorName": colorName ? colorName : @"",
        @"index": @(sender.tag)
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:kJSDNavigationTitleNotification object:object];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSArray<JSDMainColorModel *> *)colorModelArray {
    
    if (!_colorModelArray) {
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"JSDMainColor" ofType:@"plist"];
        _colorModelArray = [JSDMainColorModel mj_objectArrayWithFile:path];
    }
    return _colorModelArray;
}

@end
