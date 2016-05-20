//
//  ItemDetailsViewController.h
//  Prototype
//
//  Created by Derik Oliver on 3/20/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *ItemTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *ItemAuthorLabel;

@property (weak, nonatomic) IBOutlet UILabel *ItemPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *SellerNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *SellerDistanceAwayLabel;

@property (weak, nonatomic) IBOutlet UILabel *ItemEditionTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *ItemEdition;

@property (weak, nonatomic) IBOutlet UILabel *ItemConditionTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *ItemCondition;

@property (weak, nonatomic) IBOutlet UILabel *ItemDescriptionTitle;

@property (weak, nonatomic) IBOutlet UILabel *ItemDescription;

@property (weak, nonatomic) NSString *objectID;

@property (nonatomic) BOOL isFavorited;

@property (weak, nonatomic) IBOutlet UIButton *FavoriteButton;

@property (weak, nonatomic) IBOutlet UIImageView *ItemImage;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Spinner;


@end
