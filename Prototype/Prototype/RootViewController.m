//
//  RootViewController.m
//  Prototype
//
//  Created by Derik Oliver on 3/9/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "RootViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface RootViewController ()

@end

@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupDefaults];
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
    
    if(currentUser) {
        NSLog(@"PERFORM SEGUE");
        [self performSegueWithIdentifier:@"LoginToProfile" sender:nil];
    } else {
        NSLog(@"User not logged in");
    }
}

- (void)setupDefaults {
    
    self.viewControllerIDArr = @[@"LoginPage", @"RegisterPage"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIDArr[0]];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    
    [self.view addSubview:_pageViewController.view];
    
    [self.pageViewController didMoveToParentViewController:self];
     
}


- (UIViewController *)getViewControllerFromClass:(UIViewController*)class isNext:(BOOL)next {
    NSInteger index;
    if([class isKindOfClass:[LoginViewController class]]) {
        index = 0;
    }
    else if([class isKindOfClass:[RegisterViewController class]]) {
        index = 1;
    }
    
    if(next)
        index += 1;
    else
        index -= 1;
    
    
    
    if(index < 0 || index >= self.viewControllerIDArr.count)
        return nil;
    else
        return [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIDArr[index]];
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [self getViewControllerFromClass:viewController isNext:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [self getViewControllerFromClass:viewController isNext:NO];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
