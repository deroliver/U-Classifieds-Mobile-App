//
//  SettingsViewController.m
//  Prototype
//
//  Created by Derik Oliver on 5/13/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "SettingsViewController.h"
#import "ListItemUIViewController.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "Parse/Parse.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize ProfileImage;
@synthesize FirstNameTextView;
@synthesize LastNameTextView;
@synthesize CityTextView;
@synthesize YearSchoolTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tap];
    
    ProfileImage.layer.backgroundColor = [[UIColor clearColor] CGColor];
    ProfileImage.layer.cornerRadius = 76;
    ProfileImage.layer.borderWidth = 2.0;
    ProfileImage.layer.masksToBounds = YES;
    ProfileImage.layer.borderColor = [[UIColor blackColor] CGColor];
    
    PFUser *curUser = [PFUser currentUser];
    
    LastNameTextView.text = [curUser objectForKey:@"lastname"];
    FirstNameTextView.text = [curUser objectForKey:@"firstname"];
    CityTextView.text = [curUser objectForKey:@"city"];
    YearSchoolTextView.text = [curUser objectForKey:@"school"];
    
    PFFile *image = [curUser objectForKey:@"profilePicture"];
    if(image != nil) {
        [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!data) {
                
            } else {
                ProfileImage.image = [UIImage imageWithData:data];
            }
        }];
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LogoutClicked:(id)sender {
    [PFUser logOut];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RootViewController *initView = (RootViewController*)[storyboard instantiateViewControllerWithIdentifier:@"initialView"];
    
    [initView setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:initView animated:NO completion:nil];
}


- (IBAction)ConfirmChangesButto:(id)sender {
    PFUser *curUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    
    if(FirstNameTextView.text != nil) {
        curUser[@"firstname"] = FirstNameTextView.text;
    }
    if(LastNameTextView.text != nil) {
        curUser[@"lastname"] = LastNameTextView.text;
    }
    if(CityTextView.text != nil) {
        curUser[@"city"] = CityTextView.text;
    }
    if(YearSchoolTextView.text != nil) {
        curUser[@"school"] = YearSchoolTextView.text;
    }
    if(ProfileImage.image != nil) {
        NSData *imageData = UIImagePNGRepresentation(ProfileImage.image);
        PFFile *fileData = [PFFile fileWithData:imageData];
        curUser[@"profilePicture"] = fileData;
    }
    [curUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
            NSLog(@"User updated");
        }
    }];
    /*
    NSLog(@"%@", curUser.objectId);
    [query getObjectInBackgroundWithId:curUser.objectId block:^(PFObject *object, NSError *error) {
        if(FirstNameTextView.text != nil) {
            object[@"firstname"] = FirstNameTextView.text;
        }
        if(LastNameTextView.text != nil) {
            object[@"lastname"] = LastNameTextView.text;
        }
        if(CityTextView.text != nil) {
            object[@"city"] = CityTextView.text;
        }
        if(YearSchoolTextView.text != nil) {
            object[@"school"] = YearSchoolTextView.text;
        }
        if(ProfileImage.image != nil) {
            NSData *imageData = UIImagePNGRepresentation(ProfileImage.image);
            PFFile *fileData = [PFFile fileWithData:imageData];
            object[@"profilePicture"] = fileData;
        }
        [object saveInBackground];
    }];
     */
}


- (IBAction)SelectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (IBAction)TakePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.ProfileImage.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    CGRect textFieldRect = [self.view.window convertRect:textView.bounds fromView:textView];
    
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if(heightFraction < 0.0) {
        heightFraction = 0.0;
    }
    else if(heightFraction > 1.0) {
        heightFraction = 1.0;
    }
    
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if(heightFraction < 0.0) {
        heightFraction = 0.0;
    }
    else if(heightFraction > 1.0) {
        heightFraction = 1.0;
    }
    
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


- (BOOL)textViewShouldReturn:(UITextView *)textView {
    [textView resignFirstResponder];
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
