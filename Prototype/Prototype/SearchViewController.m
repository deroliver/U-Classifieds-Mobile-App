//
//  SearchViewController.m
//  Prototype
//
//  Created by Derik Oliver on 5/5/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "SearchViewController.h"
#import "TableCell.h"
#import "ItemDetailsViewController.h"
#import <Parse/Parse.h>

@interface SearchViewController ()

@property (nonatomic, strong)NSArray *productsArray;
@property (nonatomic, strong)NSDictionary *product;

@end

@implementation SearchViewController

@synthesize productsArray;
@synthesize product;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            // Found data
            NSLog(@"Successfully retrieved %lu products", (unsigned long)objects.count);
            productsArray = [[NSArray alloc] initWithArray:objects];
        }
        [tableView reloadData];
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"SearchToProductPage" sender:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return productsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    PFObject *tempObject = [productsArray objectAtIndex:indexPath.row];
    
    cell.ItemAuthor.text = [tempObject objectForKey:@"author"];
    cell.ItemPrice.text = [tempObject objectForKey:@"price"];
    cell.ItemTitle.text = [tempObject objectForKey:@"title"];
    cell.ItemSeller.text = [tempObject objectForKey:@"seller"];
    //cell.EditionNumber.text = @"4th Edition";
    //cell.DistanceAway.text = @"2.1 Miles Away";
    
    //cell.ItemImage.image = [UIImage imageNamed:@"DifferentialSearch"];
    //cell.SelectArrow.image = [UIImage imageNamed:@"Arrow"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.156 * [UIScreen mainScreen].bounds.size.height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"SearchToProductPage"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        PFObject *temp = [productsArray objectAtIndex:indexPath.row];
        NSLog(@"%ld", (long)indexPath.row);
        NSLog(@"Item ID: %@", temp.objectId);
        
        ItemDetailsViewController *IDT = [segue destinationViewController];
        IDT.objectID = temp.objectId;
    }
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
