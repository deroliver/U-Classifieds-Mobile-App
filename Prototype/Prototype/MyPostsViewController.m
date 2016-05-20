//
//  MyPostsViewController.m
//  Prototype
//
//  Created by Derik Oliver on 3/11/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import "MyPostsViewController.h"
#import "ItemDetailsViewController.h"
#import "TableCell.h"
#import "Parse/Parse.h"

@interface MyPostsViewController ()

@property (nonatomic, strong)NSMutableArray *productsArray;
@property (nonatomic, strong)NSDictionary *product;
@property (nonatomic, strong)NSMutableArray *objectIDs;
@property NSInteger skipNumber;

@end

@implementation MyPostsViewController

@synthesize productsArray;
@synthesize product;
@synthesize objectIDs;
@synthesize skipNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    productsArray = [[NSMutableArray alloc] init];
    objectIDs = [[NSMutableArray alloc] init];
    skipNumber = 0;
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView
    *tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WhiteBackground"]];
    
    [tableBackgroundView setFrame:self.tableView.frame];
    
    [self.tableView setBackgroundView:tableBackgroundView];
    
    self.navigationController.navigationBar.topItem.title = @"My Posts";
    
    
    [self getMoreProducts];
}

- (void)getMoreProducts {
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Product"];
    [query whereKey:@"seller" equalTo:user.objectId];
    query.skip = skipNumber;
    skipNumber += 10;
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            // Found data
            NSLog(@"Successfully retrieved %lu products", (unsigned long)objects.count);
            for(PFObject *object in objects) {
                [productsArray addObject:object];
            }
        }
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"MyPostsToDetails" sender:indexPath];
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
    if([[segue identifier] isEqualToString:@"MyPostsToDetails"]) {
        
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
    
    if(maximumOffset - currentOffset <= 10.0) {
        [self getMoreProducts];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
