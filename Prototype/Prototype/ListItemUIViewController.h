//
//  ListItemUIViewController.h
//  Prototype
//
//  Created by Derik Oliver on 5/6/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListItemUIViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *DescriptionTextField;

@property (weak, nonatomic) IBOutlet UITextField *ConditionTextField;


@property (weak, nonatomic) IBOutlet UITextField *EditionTextField;

@property (weak, nonatomic) IBOutlet UITextField *AuthorTextField;

@property (weak, nonatomic) IBOutlet UITextField *TitleTextField;

@end
