//
//  ProfileViewController.h
//  Prototype
//
//  Created by Derik Oliver on 3/10/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *UserName;


@property (weak, nonatomic) IBOutlet UILabel *UserSchool;


@property (weak, nonatomic) IBOutlet UILabel *UserCity;

@property (weak, nonatomic) IBOutlet UIImageView *UserImage;
@end
