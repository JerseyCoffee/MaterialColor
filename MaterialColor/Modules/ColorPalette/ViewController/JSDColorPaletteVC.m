//
//  JSDColorPaletteVC.m
//  MaterialColor
//
//  Created by ada on 2019/7/20.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDColorPaletteVC.h"

#import "JSDColorPaletteView.h"
#import "JSDPublic.h"
#import <UIImageView+AXGetColor.h>
#import "JSDMyCenterVC.h"

@interface JSDColorPaletteVC ()

@property (strong, nonatomic) JSDColorPaletteView *cycloColorPaletteView;

@end

@implementation JSDColorPaletteVC

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
    
    self.navigationItem.title = @"Color Palette";
    
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"关于" style:UIBarButtonItemStylePlain target:self action:@selector(onTouchLeftBar:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.cycloColorPaletteView];
    [self.cycloColorPaletteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (void)onTouchLeftBar:(id)sender {
    
    JSDMyCenterVC* myVC = JSDMyCenterVC.new;
    
    [self.navigationController pushViewController:myVC animated:YES];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (JSDColorPaletteView *)cycloColorPaletteView {
    
    if (!_cycloColorPaletteView) {
        
        _cycloColorPaletteView = [[NSBundle mainBundle] loadNibNamed:@"JSDColorPaletteView" owner:nil options:nil].lastObject;
    }
    return _cycloColorPaletteView;
}

@end
