//
//  SearchViewController.h
//  Prototype
//
//  Created by Derik Oliver on 5/5/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableView.h"
#import "Parse/Parse.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate , UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;


@property (weak, nonatomic) IBOutlet SearchTableView *tableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Spinner;

@end
