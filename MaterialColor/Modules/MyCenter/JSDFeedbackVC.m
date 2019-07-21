//
//  JSDFeedbackVC.m
//  MaterialColor
//
//  Created by ada on 2019/7/21.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDFeedbackVC.h"

#import <MessageUI/MessageUI.h>
#import "JSDPublic.h"
#import <MaterialSnackbar.h>
#import <MaterialButtons.h>

@interface JSDFeedbackVC () <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UILabel* tipLabel;
@property (nonatomic, strong) MDCRaisedButton* senderEmail;
@property (nonatomic, copy) NSString* emailText;

@end

@implementation JSDFeedbackVC

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
    self.navigationItem.title = @"Feedback";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_grayColor];
    
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    self.senderEmail = [[MDCRaisedButton alloc] init];
    [self.senderEmail setTitle:@"Sender Email" forState:UIControlStateNormal];
    [self.senderEmail addTarget:self action:@selector(onTouchSendEmail:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.senderEmail];
    [self.senderEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_equalTo(30);
    }];
    
    //判断用户是否已设置邮件账户
    if ([MFMailComposeViewController canSendMail]) {
        [self setupEmailAction]; // 调用发送邮件的代码
    }else{
        //给出提示,设备未开启邮件服务
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"Warm prompt" message:@"Please open \"(email App)\" and set up your email account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
    }
}

-(void)setupEmailAction{
    // 创建邮件发送界面
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置收件人
    [mailCompose setToRecipients:@[@"zexi0625@gmail.com"]];
    // 设置邮件主题
    [mailCompose setSubject:@"App usage feedback"];
    //设置邮件的正文内容
    NSString *emailContent = @"Hi. Jersey \n I found some problems in using the App.";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    
    
    [self presentViewController:mailCompose animated:YES completion:nil];
}


- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - MFMailComposeViewControllerDelegate的代理方法：

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled: 用户取消编辑");
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent: 用户点击发送");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@ : 用户尝试保存或发送邮件失败", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    MDCSnackbarManager* snackbar = [MDCSnackbarManager defaultManager];
    MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"Thank you very much for using mnemonic. We will carefully check your feedback and try to improve it."];
    
    [self dismissViewControllerAnimated:YES completion: ^{
        [snackbar showMessage:message];
    }];
}

#pragma mark - 5.Event Response

- (void)onTouchSendEmail:(id) sender {
    
    //判断用户是否已设置邮件账户
    if ([MFMailComposeViewController canSendMail]) {
        [self setupEmailAction]; // 调用发送邮件的代码
    }else{
        //给出提示,设备未开启邮件服务
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请打开\"(邮件App)\"设置你的邮箱账号" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
    }
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:20];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = @"感谢您的使用助记, 欢迎您给我们提供任何建议!";
    }
    return _tipLabel;
}

@end
