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

@property (nonatomic, weak)NSString *sellerID;

@property (nonatomic, weak)PFObject *item;

@end

@implementation ItemDetailsViewController

@synthesize item;

@synthesize objectID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    NSLog(@"Object ID: %@", objectID);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query getObjectInBackgroundWithId:objectID block:^(PFObject *product, NSError *error) {
        if(!error) {
            self.sellerID = [product objectForKey:@"seller"];
            item = product;
            self.ItemTitleLabel.text = [product objectForKey:@"title"];
            self.ItemAuthorLabel.text = [product objectForKey:@"author"];
            self.ItemPriceLabel.text = [NSString stringWithFormat:@"$%@", [product objectForKey:@"price"]];
            self.ItemCondition.text = [product objectForKey:@"condition"];
            self.ItemEdition.text = [product objectForKey:@"edition"];
            self.ItemDescription.text = [product objectForKey:@"description"];
            
            NSLog(@"Seller ID: %@", self.sellerID);
            
            PFQuery *userQuery = [PFUser query];
            [userQuery whereKey:@"objectId" equalTo:self.sellerID];
            PFObject *user = [userQuery getFirstObject];
            
            self.SellerNameLabel.text = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"firstname"], [user objectForKey:@"lastname"]];
        }
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
