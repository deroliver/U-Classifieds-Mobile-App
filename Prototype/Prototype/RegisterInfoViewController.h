//
//  RegisterInfoViewController.h
//  Prototype
//
//  Created by Derik Oliver on 5/12/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>>
@interface RegisterInfoViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *FirstNameTextField;


@property (weak, nonatomic) IBOutlet UITextField *LastNameTextField;


@property (weak, nonatomic) IBOutlet UITextField *SchoolTextField;


@property (weak, nonatomic) IBOutlet UITextField *CityTextField;

@end
