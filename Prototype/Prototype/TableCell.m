//
//  TableCell.m
//  Prototype
//
//  Created by Derik Oliver on 3/11/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

@synthesize ItemImage;
@synthesize ItemTitle;
@synthesize EditionNumber;
@synthesize ItemAuthor;
@synthesize ItemPrice;
@synthesize ItemSeller;
@synthesize DistanceAway;
@synthesize SelectArrow;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
