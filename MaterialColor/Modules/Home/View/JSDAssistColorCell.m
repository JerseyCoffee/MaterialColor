//
//  JSDAssistColorCell.m
//  MaterialColor
//
//  Created by ada on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDAssistColorCell.h"

#import "JSDPublic.h"

@interface JSDAssistColorCell ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorNameLabel;

@end

@implementation JSDAssistColorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.colorButton.layer.cornerRadius = 12.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JSDAssistColorModel *)model {
    
    self.colorButton.backgroundColor = [UIColor jsd_colorWithHexString:model.colorValueName];
    self.numberLabel.text = model.numberName;
    self.colorValueLabel.text = model.colorValueName;
    self.colorNameLabel.text = model.RGBName;
    if (model.textColor) {
        self.numberLabel.textColor = [UIColor jsd_colorWithHexString:@"#000000"];
        self.colorValueLabel.textColor = [UIColor jsd_colorWithHexString:@"#000000"];
        self.colorNameLabel.textColor = [UIColor jsd_colorWithHexString:@"#000000"];
        self.colorCopyButton.titleLabel.textColor = [UIColor jsd_colorWithHexString:@"#000000"];
    } else {
        self.numberLabel.textColor = [UIColor jsd_colorWithHexString:@"#ffffff"];
        self.colorValueLabel.textColor = [UIColor jsd_colorWithHexString:@"#ffffff"];
        self.colorNameLabel.textColor = [UIColor jsd_colorWithHexString:@"#ffffff"];
        self.colorCopyButton.titleLabel.textColor = [UIColor jsd_colorWithHexString:@"#ffffff"];
    }
}

@end
