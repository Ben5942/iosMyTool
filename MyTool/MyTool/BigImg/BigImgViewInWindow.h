//
//  BigImgViewInWindow.h
//  zyp
//
//  Created by zyp on 2020/11/19.
//  Copyright © 2020 LGL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BigImgViewInWindow : UIScrollView<UIScrollViewDelegate>
-(void)showBigImgInWindowWith:(NSString*)imageUrl;
-(instancetype)initWithFrame:(CGRect)frame originView:(UIView*)originView;
@property(assign,nonatomic)CGRect startFrame;
@property(strong,nonatomic)UIImageView * imgV;
-(void)showBigImg:(NSString*)imageUrl;
-(void)reset;
@property(copy,nonatomic)void(^imgTapBlock)();
@end

NS_ASSUME_NONNULL_END
