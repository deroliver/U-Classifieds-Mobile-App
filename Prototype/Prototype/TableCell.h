//
//  TableCell.h
//  Prototype
//
//  Created by Derik Oliver on 3/11/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI/ParseUI.h"

@interface TableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet PFImageView *ItemImage;

@property (weak, nonatomic) IBOutlet UILabel *ItemTitle;

@property (weak, nonatomic) IBOutlet UILabel *EditionNumber;

@property (weak, nonatomic) IBOutlet UILabel *ItemAuthor;

@property (weak, nonatomic) IBOutlet UILabel *ItemPrice;

@property (weak, nonatomic) IBOutlet UILabel *ItemSeller;

@property (weak, nonatomic) IBOutlet UILabel *DistanceAway;

@property (weak, nonatomic) IBOutlet UIImageView *SelectArrow;

@end
