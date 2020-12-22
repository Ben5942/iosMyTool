//
//  ImgCollectCell.m
//  Taoke
//
//  Created by xindu on 2020/12/1.
//  Copyright © 2020 LGL. All rights reserved.
//

#import "ImgCollectCell.h"

@implementation ImgCollectCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgBgV = [[BigImgViewInWindow alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.imgBgV];
    }
    return self;
}

-(void)reset{
    [self.imgBgV reset];
}
-(void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    [self reset];
    [self.imgBgV showBigImg:_imgUrl];
}

@end
