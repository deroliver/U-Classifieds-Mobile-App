//
//  LoginViewController.m
//  Prototype
//
//  Created by Derik Oliver on 3/9/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.LoginLabelWidth.constant = 129 * ([UIScreen mainScreen].bounds.size.width / 414);
    
    self.LoginLabelWidth.constant = 306 * ([UIScreen mainScreen].bounds.size.width / 414);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)LoginButtonClicked:(id)sender {
    NSString *username = self.EmailTextField.text;
    NSString *password = self.PasswordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        if(error != nil)
            NSLog(error.localizedDescription);
        else
            NSLog(@"Successfully Logged in");
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
