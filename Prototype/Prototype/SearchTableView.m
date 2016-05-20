//
//  SearchTableView.m
//  Prototype
//
//  Created by Derik Oliver on 5/5/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "SearchTableView.h"
#import "TableCell.h"

@implementation SearchTableView




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    cell.ItemAuthor.text = @"Joseph H. Silverman";
    cell.ItemPrice.text = @"$124.00";
    cell.ItemTitle.text = @"Elementary Differential Equations";
    cell.ItemSeller.text = @"Derik Oliver";
    cell.EditionNumber.text = @"4th Edition";
    cell.DistanceAway.text = @"2.1 Miles Away";
    
    cell.ItemImage.image = [UIImage imageNamed:@"DifferentialSearch"];
    cell.SelectArrow.image = [UIImage imageNamed:@"Arrow"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.156 * [UIScreen mainScreen].bounds.size.height;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
