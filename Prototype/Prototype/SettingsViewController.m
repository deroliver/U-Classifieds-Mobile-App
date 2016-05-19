//
//  SettingsViewController.m
//  Prototype
//
//  Created by Derik Oliver on 5/13/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "SettingsViewController.h"
#import "Parse/Parse.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)LogoutClicked:(id)sender {
    [PFUser logOut];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
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
