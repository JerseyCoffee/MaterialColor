//
//  JSDColorPaletteView.m
//  MaterialColor
//
//  Created by ada on 2019/7/20.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDColorPaletteView.h"

#import "JSDPublic.h"
#import <MaterialButtons.h>

@interface JSDColorPaletteView () <MDCSliderDelegate>

@property (strong, nonatomic) UIColor *currentColor;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (strong, nonatomic) UILabel *opacityLabel;
@property (strong, nonatomic) UILabel *opacityTitleLabel;
@property (assign, nonatomic) CGFloat red;
@property (assign, nonatomic) CGFloat green;
@property (assign, nonatomic) CGFloat blue;
@property (assign, nonatomic) CGFloat opacity;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
@property (weak, nonatomic) IBOutlet UILabel *jOpacityLabel;
@property (copy, nonatomic) NSString *hexString;
@property (weak, nonatomic) IBOutlet UILabel *hexLabel;
@property (strong, nonatomic) UIImageView *touchPointImageView;
@property (weak, nonatomic) IBOutlet MDCButton *colorButton;
@property (weak, nonatomic) IBOutlet MDCButton *colorButton2;
@property (weak, nonatomic) IBOutlet MDCButton *colorButton3;
@property (weak, nonatomic) IBOutlet MDCButton *colorButton4;
@property (weak, nonatomic) IBOutlet MDCButton *colorButton5;

@end

@implementation JSDColorPaletteView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self initData];
    
    [self setupShowTextView];
    [self setupOperationView];
    [self setupOpacityView];
    [self setupImageView];
    [self setupRGBAValue];
    
    NSArray* colorButtons = @[self.colorButton, self.colorButton2, self.colorButton3, self.colorButton4, self.colorButton5];
    for (NSInteger i = 0 ; i < colorButtons.count; i++) {
        MDCButton* btn = colorButtons[i];
        btn.tag = i;
        [btn addTarget:self action:@selector(onTouchChangeImage:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:nil forState:UIControlStateNormal];
        NSString* imageName = [NSString stringWithFormat:@"color%ld", i];
        [btn setBackgroundImage:[UIImage imageWithNamed:imageName inBundle:[NSBundle mainBundle]] forState:UIControlStateNormal];
    }
    
}

- (void)initData {
    
    self.red = 237;
    self.green = 237;
    self.blue = 237;
    self.opacity = 1.0;
    self.hexString = [self hexStringForRed:self.red / 255.0 green:self.green / 255.0 blue:self.blue / 255.0];
    self.showBackgroundView.backgroundColor = [UIColor jsd_grayColor];
    self.backgroundColor = [UIColor jsd_grayColor];
    
}
// 设置展示块
- (void)setupShowTextView {
    
    self.showTextView.backgroundColor = [UIColor whiteColor];
    self.showTextView.layer.cornerRadius = 10;
    self.showTextView.layer.masksToBounds = YES;
    
    self.showTextView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.showTextView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.showTextView.layer.shadowOpacity = 0.5f;
    self.showTextView.layer.shadowRadius = 3;
}

- (void)setupOperationView {
    
    self.lightOperationView.backgroundColor = [UIColor whiteColor];
    self.lightOperationView.layer.cornerRadius = 10;
    self.lightOperationView.layer.masksToBounds = YES;
}
//  设置透明度操作器
- (void)setupOpacityView {
    
    _operationView = [[MDCSlider alloc] init];
    [self addSubview:self.operationView];
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_equalTo(-65);
        make.top.mas_equalTo(self.lightOperationView.mas_bottom).mas_equalTo(30);
    }];
    [self.operationView addTarget:self
               action:@selector(didChangeSliderValue:)
     forControlEvents:UIControlEventValueChanged];
    self.operationView.value = 1;
    
    self.opacityTitleLabel = [[UILabel alloc] init];
    self.opacityTitleLabel.text = @"Opacity";
    
    self.opacityLabel = [[UILabel alloc] init];
    self.opacityLabel.text = @"100%";
    
    [self.showBackgroundView addSubview:self.opacityTitleLabel];
    [self.showBackgroundView addSubview:self.opacityLabel];
    
    [self.opacityTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.operationView.mas_left).mas_equalTo(0);
        make.top.mas_equalTo(self.operationView.mas_bottom).mas_equalTo(0);
    }];
    
    [self.opacityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.operationView.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(self.operationView).mas_equalTo(0);
    }];
    
    
    _operationView.delegate = self;
}
//设置图像
- (void)setupImageView {
    
    self.imageViewHeight.constant = ScreenWidth - 120;
    self.imageView.layer.cornerRadius = (ScreenWidth - 120) / 2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.backgroundColor = [UIColor jsd_grayColor];
    
    self.imageView.image = [UIImage imageWithNamed:@"color1" inBundle:[NSBundle mainBundle]];
    self.imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchImageView:)];
    
    [self.imageView addGestureRecognizer:tap];

}

// 设置展示样板数值
- (void)setupRGBAValue {
    
    self.redLabel.text = @(self.red).stringValue;
    self.greenLabel.text = @(self.green).stringValue;
    self.blueLabel.text = @(self.blue).stringValue;
    self.jOpacityLabel.text = [NSString stringWithFormat:@"%.2f", self.opacity];
    self.hexLabel.text = self.hexString;
}

#pragma mark Response
// 点击图片
- (void)onTouchImageView:(UITapGestureRecognizer *)sender {
    
    @weakify(self)
    CGPoint point = [sender locationInView:self.imageView];
    [self.imageView ax_getRGBAWithPoint:point completion:^(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
        @strongify(self)
        self.touchPointImageView.frame = CGRectMake(point.x - self.touchPointImageView.jsd_width / 2, point.y - self.touchPointImageView.jsd_height / 2, self.touchPointImageView.jsd_width, self.touchPointImageView.jsd_height);
        self.showBackgroundView.backgroundColor = [UIColor colorWithRed: red green: green blue: blue alpha: 1.0];
        self.red = red * 255.0;
        self.green = green * 255.0;
        self.blue = blue * 255.0;
        self.opacity = 1.0;
        self.hexString = [self hexStringForRed:red green:green blue: blue];
        self.operationView.value = 1.0;
        self.opacityLabel.text = @"100%";
        [self setupRGBAValue];
    }];
    
}

// 选择透明度
- (void)didChangeSliderValue:(MDCSlider *)slider {
    
    int value = slider.value * 100;
    self.opacityLabel.text = [NSString stringWithFormat:@"%d%%", value];
//    self.alpha = slider.value;
//    NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
    CGFloat valueFloat = value;
    self.opacity = valueFloat / 100;
    NSLog(@"%f--%f---%f---%f", self.red, self.green, self.blue, self.opacity);
    self.showBackgroundView.backgroundColor = [UIColor colorWithRed: self.red / 255.0 green: self.green / 255.0 blue: self.blue / 255.0 alpha: self.opacity];
    //    self.hexString = [self hexStringForRed:self.red green:self.green blue:self.blue];
    [self setupRGBAValue];
}

// 拷贝
- (IBAction)onTouchCopy:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.hexString;
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Copy to the clipboard!" message:[NSString stringWithFormat:@"ColorHex: %@", self.hexString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)onTouchChangeImage:(MDCButton *)sender {
    
    NSString* colorName = @"color";
    
    [self settingImageName:[NSString stringWithFormat:@"%@%ld", colorName, sender.tag]];
}

//转换
- (NSString *)hexStringForColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    
    return hexString;
}

- (NSString *)hexStringForRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    
    NSString* hexString = [NSString stringWithFormat:@"#%02X%02X%02X", (int)(red * 255), (int)(green * 255), (int)(blue * 255)];
    return hexString;
}

#pragma mark -- Privete

- (void)settingImageName:(NSString* )imageName {
    
    self.imageView.image = [UIImage imageWithNamed:imageName inBundle: [NSBundle mainBundle]];
    
    [self.touchPointImageView removeFromSuperview];
    self.touchPointImageView = nil;
    
    [self initData];
    [self setupRGBAValue];
}



#pragma mark -- Set && Get

- (UIImageView *)touchPointImageView {
    
    if (!_touchPointImageView) {
        _touchPointImageView = [[UIImageView alloc] init];
        _touchPointImageView.image = [UIImage imageNamed:@"location"];
        [self.imageView addSubview:_touchPointImageView];
        [_touchPointImageView sizeToFit];
    }
    return _touchPointImageView;
}

@end
