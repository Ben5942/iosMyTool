//
//  ViewController.h
//  MyTool
//
//  Created by Y on 2020/8/3.
//  Copyright © 2020 张亚鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)  UICollectionView *itemCollectionview;


@property(strong,nonatomic) NSMutableArray *itemArrs;

@end

