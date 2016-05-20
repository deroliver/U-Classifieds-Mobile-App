//
//  SavedProductsViewController.m
//  Prototype
//
//  Created by Derik Oliver on 5/19/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "SavedProductsViewController.h"
#import "Parse/Parse.h"
#import "TableCell.h"
#import "ItemDetailsViewController.h"

@interface SavedProductsViewController ()

@property (nonatomic, strong)NSMutableArray *productsArray;
@property (nonatomic, strong)NSDictionary *product;
@property (nonatomic, strong)NSMutableArray *objectIDs;
@property NSInteger skipNumber;

@end


@implementation SavedProductsViewController

@synthesize productsArray;
@synthesize product;
@synthesize objectIDs;
@synthesize skipNumber;



- (void)viewDidLoad {
    [super viewDidLoad];
    productsArray = [[NSMutableArray alloc] init];
    objectIDs = [[NSMutableArray alloc] init];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView
    *tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WhiteBackground"]];
    
    [tableBackgroundView setFrame:self.tableView.frame];
    
    [self.tableView setBackgroundView:tableBackgroundView];
    
    self.navigationController.navigationBar.topItem.title = @"Saved Items";
    
    
    PFUser *user = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"SavedProducts"];
    [query whereKey:@"userID" equalTo:user.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            for(PFObject *object in objects) {
                NSString *IDD = object[@"productID"];
                NSLog(@"ID: %@", IDD);
                [objectIDs addObject:IDD];
            }
            
            PFQuery *objectQuery = [PFQuery queryWithClassName:@"Product"];
            [objectQuery whereKey:@"objectId" containedIn:objectIDs];
            NSLog(@"%@", objectIDs);
            
            [objectQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if(!error && array != nil) {
                    productsArray = [[NSArray alloc] initWithArray:array];
                    [self.tableView reloadData];
                } else {
                    
                }
            }];
        }
        
    }];
}

- (void)getMoreProducts {
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"SavedProducts"];
    [query whereKey:@"userID" equalTo:user.objectId];
    query.skip = skipNumber;
    skipNumber += 10;
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            // Found data
            NSLog(@"Successfully retrieved %lu products", (unsigned long)objects.count);
            for(PFObject *object in objects) {
                NSString *IDD = object[@"productID"];
                NSLog(@"ID: %@", IDD);
                [objectIDs addObject:IDD];
            }
            
            
            PFQuery *objectQuery = [PFQuery queryWithClassName:@"Product"];
            [objectQuery whereKey:@"objectId" containedIn:objectIDs];
            NSLog(@"%@", objectIDs);
            
            [objectQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if(!error && array != nil) {
                    for(PFObject *product in array) {
                        [productsArray addObject:product];
                    }
                    
                    [self.tableView reloadData];
                } else  {
                    
                }
            }];
        }
    }];
}

     
     
                
             


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"SavedToDetails" sender:indexPath];
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
    
    PFFile *image = [tempObject objectForKey:@"productImage"];
    if(image != nil) {
        [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!data) {
                
            } else {
                cell.ItemImage.image = [UIImage imageWithData:data];
            }
        }];
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.156 * [UIScreen mainScreen].bounds.size.height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"SavedToDetails"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        PFObject *temp = [productsArray objectAtIndex:indexPath.row];
        NSLog(@"%ld", (long)indexPath.row);
        NSLog(@"Item ID: %@", temp.objectId);
        
        ItemDetailsViewController *IDT = [segue destinationViewController];
        IDT.objectID = temp.objectId;
    }
}


@end


