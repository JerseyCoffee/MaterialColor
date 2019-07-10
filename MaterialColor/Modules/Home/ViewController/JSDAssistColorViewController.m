//
//  JSDAssistColorViewController.m
//  MaterialColor
//
//  Created by ada on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDAssistColorViewController.h"

#import "JSDAssistColorCell.h"
#import "JSDPublic.h"
#import "JSDHomeViewController.h"

NSString* const kJSDAssistColorCell = @"JSDAssistColorCell";
@interface JSDAssistColorViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView* tableView;

@end

@implementation JSDAssistColorViewController

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
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
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
    
    JSDAssistColorCell* cell = [tableView dequeueReusableCellWithIdentifier:kJSDAssistColorCell];
    JSDAssistColorModel* model = [self.colorModelArray objectAtIndex:indexPath.section];
    [cell setModel:model];
    cell.colorButton.tag = indexPath.section;
    cell.colorCopyButton.tag = indexPath.section;
    [cell.colorCopyButton removeTarget:self action:@selector(onTouchColorCopy:) forControlEvents:UIControlEventTouchUpInside];
    [cell.colorCopyButton addTarget:self action:@selector(onTouchColorCopy:) forControlEvents:UIControlEventTouchUpInside];
    [cell.colorButton removeTarget:self action:@selector(onTouchColorEdit:) forControlEvents:UIControlEventTouchUpInside];
    [cell.colorButton addTarget:self action:@selector(onTouchColorEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
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

- (void)onTouchColorCopy:(MDCButton *)sender {
    
    NSString* colorValueName = self.colorModelArray[sender.tag].colorValueName;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kJSDCopyColorValueNotification object:colorValueName];
}

- (void)onTouchColorEdit:(MDCButton *)sender {
    
    JSDAssistColorModel* colorModel = self.colorModelArray[sender.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:kJSDEditColorValueNotification object:colorModel];
    
    /*建立音效檔關聯性*/
//    NSURL *soundURL =[[NSBundle mainBundle] URLForResource:@"5080" withExtension:@"wav"];
//
//    /*將程式中的音效檔與systemId對應在一起*/
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(soundURL), &(_soundFileObject));
//
//    /*soundFileObject對應到所播放的音效*/
//    AudioServicesPlaySystemSound(_soundFileObject);
//    if (@available(iOS 10.0, *)) {
//        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
//        [feedBackGenertor impactOccurred];
//    } else {
//        // Fallback on earlier versions
//        AudioServicesPlaySystemSound(1520);
//    }
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
        [_tableView registerNib:[UINib nibWithNibName:@"JSDAssistColorCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kJSDAssistColorCell];
    }
    return _tableView;
}

- (void)setColorModelArray:(NSArray *)colorModelArray {
    
    _colorModelArray = colorModelArray;
    [self.tableView reloadData];
}

@end
