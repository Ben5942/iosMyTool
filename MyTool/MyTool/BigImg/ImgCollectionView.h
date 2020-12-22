//
//  ImgCollectionView.h
//  Taoke
//
//  Created by xindu on 2020/12/1.
//  Copyright © 2020 LGL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImgCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
-(void)showBigImgArrsInWindowWith:(NSMutableArray<NSString*>*)imageUrlStrArrs andNowIndex:(NSInteger)imgIndex;
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewFlowLayout*)flowLayout originView:(UIView*)originView;
@property(assign,nonatomic)CGRect startFrame;
@property(copy,nonatomic)NSMutableArray *imgArr;
@end

NS_ASSUME_NONNULL_END
