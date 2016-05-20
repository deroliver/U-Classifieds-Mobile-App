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
@synthesize isFavorited;
@synthesize Spinner;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Spinner setHidden:NO];
    [Spinner startAnimating];
    
    self.tabBarController.tabBar.hidden = YES;
    
    NSLog(@"Object ID: %@", objectID);
    
    self.ItemImage.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.ItemImage.layer.cornerRadius = 10;
    self.ItemImage.layer.borderWidth = 2.0;
    self.ItemImage.layer.masksToBounds = YES;
    self.ItemImage.layer.borderColor = [[UIColor blackColor] CGColor];
    
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
            NSLog(@"Title: %@", self.ItemTitleLabel.text); 
            
            PFQuery *userQuery = [PFUser query];
            [userQuery whereKey:@"objectId" equalTo:self.sellerID];
            PFObject *user = [userQuery getFirstObject];
            
            self.SellerNameLabel.text = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"firstname"], [user objectForKey:@"lastname"]];
            [Spinner stopAnimating];
            [Spinner setHidden:YES];
            
            PFFile *image = [product objectForKey:@"productImage"];
            if(image != nil) {
                [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if(!data) {
                        
                    } else {
                        self.ItemImage.image = [UIImage imageWithData:data];
                    }
                }];
            }
        } else {
            NSLog(@"ERROR");
        }
    }];
    
    
    PFUser *user = [PFUser currentUser];
    
    PFQuery *productFavoritedQuery = [PFQuery queryWithClassName:@"SavedProducts"];
    [productFavoritedQuery whereKey:@"userID" equalTo:user.objectId];
    [productFavoritedQuery whereKey:@"productID" equalTo:objectID];
    
    [productFavoritedQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!error && object != nil) {
            UIImage *btnImage = [UIImage imageNamed:@"StarFilled"];
            [self.FavoriteButton setImage:btnImage forState:UIControlStateNormal];
            isFavorited = true;
            
        } else {
            UIImage *btnImage = [UIImage imageNamed:@"Star"];
            [self.FavoriteButton setImage:btnImage forState:UIControlStateNormal];
            isFavorited = false;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)FavoriteItemClicked:(id)sender {
    PFUser *user = [PFUser currentUser];
    if(isFavorited) {
        UIImage *btnImage = [UIImage imageNamed:@"Star"];
        [self.FavoriteButton setImage:btnImage forState:UIControlStateNormal];
        isFavorited = false;
        
        PFQuery *favoritedProduct = [PFQuery queryWithClassName:@"SavedProducts"];
        [favoritedProduct whereKey:@"userID" equalTo:user.objectId];
        [favoritedProduct whereKey:@"productID" equalTo:objectID];
        
        [favoritedProduct getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if(object != nil) {
                [object deleteInBackground];
            } else {
                NSLog(@"Could not delete object!");
            }
        }];
        
    } else if(!isFavorited) {
        UIImage *btnImage = [UIImage imageNamed:@"StarFilled"];
        [self.FavoriteButton setImage:btnImage forState:UIControlStateNormal];
        isFavorited = true;
        
        
        PFObject *favoritedProduct = [PFObject objectWithClassName:@"SavedProducts"];
        favoritedProduct[@"userID"] = user.objectId;
        favoritedProduct[@"productID"] = objectID;
        
        NSLog(@"%@ %@", user.objectId, objectID);
        
        [favoritedProduct saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded) {
           
            } else {
                
            }
        }];
    }
}


- (IBAction)ContactSellerClicked:(id)sender {
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
