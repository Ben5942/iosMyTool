//
//  ViewController.m
//  MyTool
//
//  Created by Y on 2020/8/3.
//  Copyright © 2020 张亚鹏. All rights reserved.
//

#import "ViewController.h"
#import "view/ItemCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.itemArrs addObject:@"下载工具"];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(50, 50);
    
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ItemCell *acell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    [acell setTitle:self.itemArrs[indexPath.row]];
    
    return acell;
}


-(NSMutableArray *)itemArrs{
    if (_itemArrs == nil) {
        _itemArrs = [NSMutableArray new];
    }
    return _itemArrs;
}


@end
