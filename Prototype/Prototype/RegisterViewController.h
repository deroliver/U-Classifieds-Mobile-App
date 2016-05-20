//
//  RegisterViewController.h
//  Prototype
//
//  Created by Derik Oliver on 3/9/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;


@property (weak, nonatomic) IBOutlet UITextField *EmailAddressTextField;

@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;


@property (weak, nonatomic) IBOutlet UITextField *ConfirmPasswordTextField;

@end
