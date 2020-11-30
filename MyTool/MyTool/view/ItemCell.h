//
//  ItemCell.h
//  MyTool
//
//  Created by Y on 2020/8/4.
//  Copyright © 2020 张亚鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property(strong,nonatomic)NSString *title;

@end

NS_ASSUME_NONNULL_END
