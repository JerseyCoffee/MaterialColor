//
//  JSDAssistColorCell.h
//  MaterialColor
//
//  Created by ada on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MaterialButtons.h>
#import "JSDAssistColorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDAssistColorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MDCButton *colorButton;
@property (nonatomic, strong) JSDAssistColorModel* model;

@end

NS_ASSUME_NONNULL_END
