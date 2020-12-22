//
//  ImgCollectionView.m
//  Taoke
//
//  Created by xindu on 2020/12/1.
//  Copyright © 2020 LGL. All rights reserved.
//

#import "ImgCollectionView.h"
#import "AppDelegate.h"
#import "ImgCollectCell.h"

@implementation ImgCollectionView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSMutableArray *)imgArr{
    if (_imgArr == nil) {
        _imgArr = [NSMutableArray new];
    }
    return _imgArr;
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewFlowLayout*)flowLayout originView:(UIView*)originView{
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.pagingEnabled = YES;
        [self registerClass:[ImgCollectCell class] forCellWithReuseIdentifier:@"ImgCollectCell"];
        
        self.alwaysBounceHorizontal = YES;
        
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        CGRect startFrame = [originView convertRect:originView.bounds toView:delegate.window];
        self.startFrame = startFrame;
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.blackColor;
    }
    return self;
}

-(void)showBigImgArrsInWindowWith:(NSMutableArray<NSString*>*)imageUrlStrArrs andNowIndex:(NSInteger)imgIndex{
    
    
    
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self];
    
    self.frame = self.startFrame;
    
//    [self reloadData];
    
    [UIView animateWithDuration:.38 animations:^{
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            self.imgArr = [NSMutableArray arrayWithArray:imageUrlStrArrs];
            [self reloadData];
            [self layoutIfNeeded];
            [self scrollRectToVisible:CGRectMake(self.frame.size.width*imgIndex, 0, self.frame.size.width, self.frame.size.height) animated:NO];
        }
    } ];
    
}


#pragma mark - collectView代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImgCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgCollectCell" forIndexPath:indexPath];
    [cell setImgUrl:self.imgArr[indexPath.row]];
    __weak typeof(self) selfWeak = self;
    cell.imgBgV.imgTapBlock = ^{
        selfWeak.imgArr = nil;
        [selfWeak reloadData];
        [UIView animateWithDuration:.38 animations:^{
            selfWeak.frame = selfWeak.startFrame;
        } completion:^(BOOL finished) {
            if (finished) {
                [selfWeak removeFromSuperview];
            }
        }];
    };
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.width, self.height);
    
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end
