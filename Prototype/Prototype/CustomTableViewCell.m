//
//  CustomTableViewCell.m
//  Prototype
//
//  Created by Derik Oliver on 5/19/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

@synthesize ItemSeller;
@synthesize ItemImage;
@synthesize ItemAuthor;
@synthesize ItemPrice;
@synthesize ItemTitle;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
