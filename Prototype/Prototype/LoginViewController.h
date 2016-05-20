//
//  LoginViewController.h
//  Prototype
//
//  Created by Derik Oliver on 3/9/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginLabelWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginAppWidth;

@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;

@end
