//
//  JSDHomeViewController.m
//  MaterialColor
//
//  Created by Jersey on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDHomeViewController.h"

#import "JSDMainColorViewController.h"
#import "JSDAssistColorViewController.h"
#import "JSDAssistColorModel.h"
#import "JSDPublic.h"
#import "JSDEditColorViewController.h"

NSString* kJSDNavigationTitleNotification = @"JSDNavigationTitleNotification";
NSString* kJSDCopyColorValueNotification = @"kJSDCopyColorValueNotification";
NSString* kJSDEditColorValueNotification = @"kJSDEditColorValueNotification";

@interface JSDHomeViewController ()

@property (strong, nonatomic) JSDMainColorViewController* mainColorVC;
@property (strong, nonatomic) JSDAssistColorViewController* assistColorVC;
@property (nonatomic, strong) NSArray<NSArray <JSDAssistColorModel* >* >* assitColorData;

@end

@implementation JSDHomeViewController

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
    
    self.navigationItem.title = @"Red";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mainColorVC = [[JSDMainColorViewController alloc] init];
    [self addChildViewController:_mainColorVC];
    [self.view addSubview:_mainColorVC.view];
    
    CGFloat mainWidth = 65;
    _mainColorVC.view.frame = CGRectMake(0, 0, mainWidth, View_Height);
    
    _assistColorVC = [[JSDAssistColorViewController alloc] init];
    [self addChildViewController:_assistColorVC];
    [self.view addSubview:_assistColorVC.view];
    _assistColorVC.view.frame = CGRectMake(mainWidth + 5, 0, View_Width - mainWidth - 5, self.view.jsd_height);
    
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
    [self.assistColorVC setColorModelArray: self.assitColorData.firstObject];
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigationTitleNotification:) name:kJSDNavigationTitleNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(copyColorValueNotification:) name:kJSDCopyColorValueNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editColorValueNotification:) name:kJSDEditColorValueNotification object:nil];
    
}

- (void)navigationTitleNotification:(NSNotification *)notification {
    
    
    NSDictionary* object = notification.object;
    NSString* colorName = [object objectForKey:@"colorName"];
    NSNumber* indexNumber = [object objectForKey:@"index"];
    NSInteger index = indexNumber.integerValue;
    
    [self.assistColorVC setColorModelArray:self.assitColorData[index]];
//    self.navigationItem.title = [NSString stringWithFormat:@"%@--index:%ld", colorName, index];
    self.navigationItem.title = colorName;
    
}

- (void)copyColorValueNotification:(NSNotification *)notification {
    
    NSString* colorValueName = notification.object;

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = colorValueName;
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Copy to the clipboard!" message:[NSString stringWithFormat:@"colorValue: %@", colorValueName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)editColorValueNotification:(NSNotification *)notification {
    
    JSDAssistColorModel* model = notification.object;
    
    JSDEditColorViewController* editViewController = [[JSDEditColorViewController alloc] init];
//    [self.navigationController pushViewController:editViewController animated:YES];
}

#pragma mark - 7.GET & SET

- (NSArray<NSArray<JSDAssistColorModel *> *> *)assitColorData {
    
    if (!_assitColorData) {
        _assitColorData = [JSDAssistColorModel mj_objectArrayWithFilename:@"JSDAssistColor.plist"];
    }
    return _assitColorData;
}

@end

