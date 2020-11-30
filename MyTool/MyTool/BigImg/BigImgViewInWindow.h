//
//  BigImgViewInWindow.h
//  Taoke
//
//  Created by xindu on 2020/11/19.
//  Copyright © 2020 LGL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BigImgViewInWindow : UIScrollView<UIScrollViewDelegate>
-(void)showBigImgInWindowWith:(NSString*)imageUrl;
-(instancetype)initWithFrame:(CGRect)frame startFrame:(CGRect)startFrame;
@property(assign,nonatomic)CGRect startFrame;
@property(strong,nonatomic)UIImageView * imgV;
@end

NS_ASSUME_NONNULL_END
