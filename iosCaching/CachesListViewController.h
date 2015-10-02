//
//  CachesListViewController.h
//  iosCaching
//
//  Created by Tânia Alves on 23/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheDetailsViewController.h"
#import <Parse/Parse.h>
#import "Globals.h"

@interface CachesListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UISwitch *foundCachesSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *myCachesSwitch;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)foundCachesSwChanged:(id)sender;
- (IBAction)myCachesSwChanged:(id)sender;
@end
