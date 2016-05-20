//
//  ProfileViewController.m
//  Prototype
//
//  Created by Derik Oliver on 3/10/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO];
    
    PFUser *curUser = [PFUser currentUser];
    
    self.UserName.text = [NSString stringWithFormat:@"%@ %@", [curUser objectForKey:@"firstname"], [curUser objectForKey:@"lastname"]];
    self.UserCity.text = [curUser objectForKey:@"city"];
    self.UserSchool.text = [curUser objectForKey:@"school"];
    
    self.UserImage.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.UserImage.layer.cornerRadius = 58;
    self.UserImage.layer.borderWidth = 2.0;
    self.UserImage.layer.masksToBounds = YES;
    self.UserImage.layer.borderColor = [[UIColor blackColor] CGColor];
    
    PFFile *image = [curUser objectForKey:@"profilePicture"];
    if(image != nil) {
        [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!data) {
                
            } else {
                self.UserImage.image = [UIImage imageWithData:data];
            }
        }];

    
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
