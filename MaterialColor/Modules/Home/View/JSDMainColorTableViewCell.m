//
//  JSDMainColorTableViewCell.m
//  MaterialColor
//
//  Created by ada on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDMainColorTableViewCell.h"

@interface JSDMainColorTableViewCell ()

@property (nonatomic, strong) UIButton* button;

@end

@implementation JSDMainColorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.flatButton = [[MDCButton alloc] init];
        _flatButton.frame = CGRectMake(5, 0, 50, 50);
        _flatButton.layer.cornerRadius = 25;
        _flatButton.layer.masksToBounds = YES;
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 60, 50);
        
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:_flatButton];
    }
    return self;
}

@end
