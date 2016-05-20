//
//  CustomTableViewCell.h
//  Prototype
//
//  Created by Derik Oliver on 5/19/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <ParseUI/ParseUI.h>

@interface CustomTableViewCell : PFTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ItemImage;

@property (weak, nonatomic) IBOutlet UILabel *ItemTitle;

@property (weak, nonatomic) IBOutlet UILabel *ItemAuthor;

@property (weak, nonatomic) IBOutlet UILabel *ItemPrice;

@property (weak, nonatomic) IBOutlet UILabel *ItemSeller;


@end
