//
//  JSDAssistColorViewController.h
//  MaterialColor
//
//  Created by ada on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDBaseViewController.h"

#import "JSDAssistColorModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JSDAssistColorViewController : JSDBaseViewController

@property (nonatomic, strong) NSArray<JSDAssistColorModel* >* colorModelArray;

@end

NS_ASSUME_NONNULL_END
