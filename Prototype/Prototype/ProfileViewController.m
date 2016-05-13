//
//  ProfileViewController.m
//  Prototype
//
//  Created by Derik Oliver on 3/10/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = NO;
    
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
