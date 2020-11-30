//
//  ItemCell.m
//  MyTool
//
//  Created by Y on 2020/8/4.
//  Copyright © 2020 张亚鹏. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [_titleLb setText:title];
    
    
//    self.layer.borderWidth = .5;
//    self.layer.borderColor = UIColor.grayColor.CGColor;
}
@end
