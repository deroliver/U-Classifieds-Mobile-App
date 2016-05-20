//
//  MessagesCell.h
//  Prototype
//
//  Created by Derik Oliver on 3/15/16.
//  Copyright © 2016 Derik Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ProfilePic;

@property (weak, nonatomic) IBOutlet UILabel *Name;

@property (weak, nonatomic) IBOutlet UILabel *TitleOfItem;

@property (weak, nonatomic) IBOutlet UILabel *Time;

@property (weak, nonatomic) IBOutlet UIImageView *Arrow;
@end
