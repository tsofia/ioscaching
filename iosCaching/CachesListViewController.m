//
//  CachesListViewController.m
//  iosCaching
//
//  Created by Tânia Alves on 23/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import "CachesListViewController.h"

@interface CachesListViewController ()

@end

@implementation CachesListViewController

NSMutableArray *cacheTitles;
NSMutableArray *caches;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cacheTitles = [[NSMutableArray alloc] init];
    caches = [[NSMutableArray alloc] init];
    
    //Get caches for map
    PFQuery *query = [PFQuery queryWithClassName:@"Cache"];
    
    NSArray* results = [query findObjects];
    if([results count] != 0)  {
        for(PFObject* cache in results)   {
            [cacheTitles addObject: cache[@"title"]];
            [caches addObject: cache.objectId];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cacheTitles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [cacheTitles objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"box.png"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    CacheDetailsViewController *cacheDetails = [[CacheDetailsViewController alloc]
                                                initWithNibName:@"CacheDetailsViewController" bundle:nil];
    
    cacheDetails.cacheId = [caches objectAtIndex: indexPath.row];
    [self.navigationController pushViewController:cacheDetails animated:YES];
}


- (IBAction)foundCachesSwChanged:(id)sender {
    PFObject* user = [Globals get_User];

    //Get caches for map
    PFQuery *query = [PFQuery queryWithClassName:@"Found"];
    [query whereKey:@"userId" equalTo: user.objectId];
    NSArray* foundCaches = [query findObjects];
    
    if(self.foundCachesSwitch.on)    {
        
        for(PFObject* curr in foundCaches)   {
            if(![caches containsObject:curr.objectId])    {
                PFQuery* query = [PFQuery queryWithClassName:@"Cache"];
                PFObject *c = [query getObjectWithId:curr[@"cacheId"]];
                
                [cacheTitles addObject:c[@"title"]];
                [caches addObject:c.objectId];
            }
        }
    }
    else    {
        for(PFObject* curr in foundCaches)   {
            if([caches containsObject:curr[@"cacheId"]])    {
                NSUInteger index = [caches indexOfObject:curr[@"cacheId"]];
                
                [caches removeObjectAtIndex:index];
                [cacheTitles removeObjectAtIndex:index];
            }
        }
    }
    
    [self.tableView reloadData];
}

- (IBAction)myCachesSwChanged:(id)sender {
    PFObject* user = [Globals get_User];
    
    //Get caches for map
    PFQuery *query = [PFQuery queryWithClassName:@"Cache"];
    [query whereKey:@"author" equalTo: user.objectId];
    
    NSArray* myCaches = [query findObjects];
    
    if(self.myCachesSwitch.on)    {
        for(PFObject* curr in myCaches)   {
            if(![caches containsObject:curr.objectId])    {
                [cacheTitles addObject:curr[@"title"]];
                [caches addObject:curr.objectId];
            }
        }
    }
    else    {
        for(PFObject* curr in myCaches)   {
            if([caches containsObject:curr.objectId])    {
                NSUInteger index = [caches indexOfObject:curr.objectId];
                
                [caches removeObjectAtIndex:index];
                [cacheTitles removeObjectAtIndex:index];
            }
        }
    }
    
    [self.tableView reloadData];
}
@end
