//
//  ImgCollectCell.h
//  Taoke
//
//  Created by xindu on 2020/12/1.
//  Copyright © 2020 LGL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigImgViewInWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImgCollectCell : UICollectionViewCell
@property(strong,nonatomic)BigImgViewInWindow *imgBgV;
@property(strong,nonatomic)NSString * imgUrl;
-(void)reset;
@end

NS_ASSUME_NONNULL_END
