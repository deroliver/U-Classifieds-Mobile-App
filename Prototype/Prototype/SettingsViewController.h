//
//  SettingsViewController.h
//  Prototype
//
//  Created by Derik Oliver on 5/13/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage;


@property (weak, nonatomic) IBOutlet UITextField *FirstNameTextView;

@property (weak, nonatomic) IBOutlet UITextField *LastNameTextView;


@property (weak, nonatomic) IBOutlet UITextField *CityTextView;


@property (weak, nonatomic) IBOutlet UITextField *YearSchoolTextView;

@end
