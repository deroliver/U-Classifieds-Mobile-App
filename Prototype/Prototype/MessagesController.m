//
//  MessagesController.m
//  Prototype
//
//  Created by Derik Oliver on 3/15/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "MessagesController.h"
#import "MessagesCell.h"

@interface MessagesController ()

@end

@implementation MessagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessagesCell" forIndexPath:indexPath];
    
    cell.ProfilePic.image = [UIImage imageNamed:@"MessagesPicture"];
    cell.Name.text = @"Bryan Xiong";
    cell.Time.text = @"1:23";
    cell.TitleOfItem.text = @"Elementary Differential Equations";
    cell.Arrow.image = [UIImage imageNamed:@"Arrow"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
