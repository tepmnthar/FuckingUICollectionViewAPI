//
//  TestCell.m
//  FuckingUICollectionViewAPI
//
//  Created by tepmnthar on 2018/8/29.
//  Copyright © 2018 Benqumark. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = UIColor.redColor;
    
    return self;

}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.backgroundColor = selected ? UIColor.greenColor : UIColor.redColor;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.backgroundColor = UIColor.redColor;
}

@end
