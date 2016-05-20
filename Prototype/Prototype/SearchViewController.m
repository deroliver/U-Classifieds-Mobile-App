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

@property (nonatomic, strong)NSMutableArray *productsArray;
@property (nonatomic, strong)NSDictionary *product;
@property NSInteger skipNumber;
@property BOOL loadingData;
@property (nonatomic, strong)NSString *searchTerm;

@end

@implementation SearchViewController

@synthesize productsArray;
@synthesize product;
@synthesize tableView;
@synthesize skipNumber;
@synthesize loadingData;
@synthesize searchTerm;
@synthesize Spinner;

- (void)viewDidLoad {
    [super viewDidLoad];
    skipNumber = 0;
    loadingData = false;
    productsArray = [[NSMutableArray alloc] init];
    [Spinner setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchTerm = nil;
    searchTerm = searchBar.text;
    skipNumber = 0;
    
    [productsArray removeAllObjects];
    
    [Spinner setHidden:NO];
    [Spinner startAnimating];

    [self getMoreProducts];
}

- (void)getMoreProducts {
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query whereKeyExists:@"title"];
    NSLog(@"Search %@", searchTerm);
    [query whereKey:@"title" matchesRegex:searchTerm modifiers:@"i"];
    query.skip = skipNumber;
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            // Found data
            NSLog(@"Successfully retrieved %lu products", (unsigned long)objects.count);
            for(PFObject *object in objects) {
                [productsArray addObject:object];
            }
            [Spinner stopAnimating];
            [Spinner setHidden:YES];
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
    cell.ItemPrice.text = [NSString stringWithFormat:@"$%@", [tempObject objectForKey:@"price"]];
    cell.ItemTitle.text = [tempObject objectForKey:@"title"];
    cell.ItemSeller.text = [tempObject objectForKey:@"seller"];
    
    cell.ItemImage.layer.backgroundColor = [[UIColor clearColor] CGColor];
    cell.ItemImage.layer.cornerRadius = 5;
    cell.ItemImage.layer.borderWidth = 1.0;
    cell.ItemImage.layer.masksToBounds = YES;
    cell.ItemImage.layer.borderColor = [[UIColor blackColor] CGColor];
    
    PFFile *file = [tempObject objectForKey:@"productImage"];
    cell.ItemImage.file = file;
    [cell.ItemImage loadInBackground];
    
    /*
    PFFile *image = [tempObject objectForKey:@"productImage"];
    if(image != nil) {
        [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!data) {
                
            } else {
                cell.ItemImage.file = data;
                [cell.ItemImage loadInBackground];
            }
        }];
    }
     */
    
    
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    skipNumber += 10;
    if(maximumOffset - currentOffset <= 10.0) {
        [self getMoreProducts];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(TableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.ItemImage.file cancel];
    cell.ItemImage.image = nil;
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
