//
//  ItemDetailsViewController.m
//  Prototype
//
//  Created by Derik Oliver on 3/20/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "ItemDetailsViewController.h"
#import "Parse/Parse.h"

@interface ItemDetailsViewController ()

@end

@implementation ItemDetailsViewController

@synthesize objectID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ItemTitleLabel.adjustsFontSizeToFitWidth = YES;
    _ItemAuthorLabel.adjustsFontSizeToFitWidth = YES;
    _ItemPriceLabel.adjustsFontSizeToFitWidth = YES;
    _SellerNameLabel.adjustsFontSizeToFitWidth = YES;
    _SellerDistanceAwayLabel.adjustsFontSizeToFitWidth = YES;
    _ItemEditionTitleLabel.adjustsFontSizeToFitWidth = YES;
    _ItemEdition.adjustsFontSizeToFitWidth = YES;
    _ItemConditionTitleLabel.adjustsFontSizeToFitWidth = YES;
    _ItemCondition.adjustsFontSizeToFitWidth = YES;
    _ItemDescriptionTitle.adjustsFontSizeToFitWidth = YES;
    _ItemDescription.adjustsFontSizeToFitWidth = YES;
    
    NSLog(@"Object ID: %@", objectID);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query whereKey:@"objectId" equalTo:objectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        PFObject *object = [objects firstObject];
        NSLog(@"%@", object);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
