//
//  ViewController.m
//  MyTool
//
//  Created by Y on 2020/8/3.
//  Copyright © 2020 张亚鹏. All rights reserved.
//

#import "ViewController.h"
#import "view/ItemCell.h"
#import "BigImgTbVC.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.itemArrs addObject:@"下载工具"];
    [self.itemArrs addObject:@"图片缩放效果"];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 3;
    flowLayout.minimumInteritemSpacing = 3;
//    flowLayout.itemSize = CGSizeMake(50, 50);
    
    self.itemCollectionview = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.itemCollectionview.delegate = self;
    self.itemCollectionview.dataSource = self;
    self.itemCollectionview.backgroundColor = UIColor.whiteColor;
//    self.itemCollectionview.collectionViewLayout = flowLayout;
    [self.itemCollectionview registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil] forCellWithReuseIdentifier:@"ItemCell"];
    [self.view addSubview:self.itemCollectionview];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArrs.count;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.view.frame.size.width/3-5,height = width;
    return CGSizeMake(width, height);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ItemCell *acell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    [acell setTitle:self.itemArrs[indexPath.row]];
    
    return acell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.itemArrs[indexPath.row] isEqualToString:@"下载工具"]) {
        
    }else if ([self.itemArrs[indexPath.row] isEqualToString:@"图片缩放效果"]) {
        BigImgTbVC *vc = [BigImgTbVC new];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(NSMutableArray *)itemArrs{
    if (_itemArrs == nil) {
        _itemArrs = [NSMutableArray new];
    }
    return _itemArrs;
}


@end
