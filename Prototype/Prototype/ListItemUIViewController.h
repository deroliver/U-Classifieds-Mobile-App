//
//  ListItemUIViewController.h
//  Prototype
//
//  Created by Derik Oliver on 5/6/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListItemUIViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
extern CGFloat animatedDistance;
extern const CGFloat KEYBOARD_ANIMATION_DURATION;
extern const CGFloat MINIMUM_SCROLL_FRACTION;
extern const CGFloat MAXIMUM_SCROLL_FRACTION;
extern const CGFloat PORTRAIT_KEYBOARD_HEIGHT;


@property (weak, nonatomic) IBOutlet UITextView *DescriptionTextField;

@property (weak, nonatomic) IBOutlet UITextField *ConditionTextField;


@property (weak, nonatomic) IBOutlet UITextField *EditionTextField;

@property (weak, nonatomic) IBOutlet UITextField *AuthorTextField;

@property (weak, nonatomic) IBOutlet UITextField *TitleTextField;

@property (weak, nonatomic) IBOutlet UITextField *PriceTextField;
@end
