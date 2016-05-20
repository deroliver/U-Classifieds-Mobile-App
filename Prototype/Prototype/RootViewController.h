//
//  RootViewController.h
//  Prototype
//
//  Created by Derik Oliver on 3/9/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (nonatomic) NSArray *viewControllerIDArr;

@end
