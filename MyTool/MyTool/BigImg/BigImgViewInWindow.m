//
//  BigImgViewInWindow.m
//  Taoke
//
//  Created by xindu on 2020/11/19.
//  Copyright © 2020 LGL. All rights reserved.
//

#import "BigImgViewInWindow.h"
#import "AppDelegate.h"

@implementation BigImgViewInWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame startFrame:(CGRect)startFrame{
    if (self= [super initWithFrame:frame]) {
        self.bounces = YES;
        self.bouncesZoom = YES;
        [self setMinimumZoomScale:0.01];
        [self setMaximumZoomScale:2];
        self.delegate = self;
        self.startFrame = startFrame;
        self.backgroundColor = UIColor.blackColor ;
        self.imgV = [UIImageView new];
        self.imgV.contentMode = UIViewContentModeScaleAspectFit;
        _imgV.userInteractionEnabled = YES;
        [self addSubview:self.imgV];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self.imgV addGestureRecognizer:ges];
    }
    return self;
}

-(void)showBigImgInWindowWith:(NSString*)imageUrl {
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self];
    
//    [self.imgV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.frame = self.startFrame;
    self.imgV.frame = CGRectMake(0, 0, self.startFrame.size.width, self.startFrame.size.height);
    
    [UIView animateWithDuration:.38 animations:^{
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width+1, [UIScreen mainScreen].bounds.size.height+1);
        self.imgV.frame = self.bounds;
    }];
    
}
-(void)tap{
    [UIView animateWithDuration:.38 animations:^{
        self.frame = self.startFrame;
        self.imgV.frame = self.bounds;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imgV;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    [UIView animateWithDuration:.38 animations:^{
        self->_imgV.frame = CGRectMake(0, 0, self.bounds.size.width-1, self.bounds.size.height-1);
    }];
    NSLog(@"缩放比例:%f",scale);
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width+1, [UIScreen mainScreen].bounds.size.height+1);
    _imgV.center = self.center;
    NSLog(@"缩放中的调用~");
}
@end
