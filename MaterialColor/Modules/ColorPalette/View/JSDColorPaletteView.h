//
//  JSDColorPaletteView.h
//  MaterialColor
//
//  Created by ada on 2019/7/20.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MaterialSlider.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDColorPaletteView : UIView

@property (weak, nonatomic) IBOutlet UIView *showTextView;
@property (weak, nonatomic) IBOutlet UIView *lightOperationView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) MDCSlider *operationView;
@property (weak, nonatomic) IBOutlet UIView *showBackgroundView;

@end

NS_ASSUME_NONNULL_END
