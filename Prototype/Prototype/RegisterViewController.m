//
//  RegisterViewController.m
//  Prototype
//
//  Created by Derik Oliver on 3/9/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)RegisterButton:(id)sender {
    /*
    PFObject *user = [PFObject objectWithClassName:@"User"];
    user[@"username"] = @"deroliver";
    user[@"password"] = @"seahawks12";
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
            NSLog(@"Successfull Account Creation");
        } else {
            NSLog(error.description);
        }
    }];
     */
    
    PFUser *user = [PFUser user];
    user.username = self.UsernameTextField.text;
    user.password = self.PasswordTextField.text;
    user.email = self.EmailAddressTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error) {
            NSLog(@"Successfull Account Creation");
        } else {
            NSLog(error.description);
        }
    }];
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
