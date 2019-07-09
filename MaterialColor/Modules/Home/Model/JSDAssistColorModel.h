//
//  JSDAssistColorModel.h
//  MaterialColor
//
//  Created by Jersey on 2019/7/9.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDAssistColorModel : NSObject

@property (nonatomic, copy) NSString* numberName;
@property (nonatomic, copy) NSString* colorValueName;
@property (nonatomic, copy) NSString* RGBName;
@property (nonatomic, assign) BOOL textColor;

@end

NS_ASSUME_NONNULL_END
