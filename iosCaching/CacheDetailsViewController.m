//
//  CacheDetailsViewController.m
//  iosCaching
//
//  Created by Tânia Alves on 28/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import "CacheDetailsViewController.h"
#import "CompassViewController.h"

@interface CacheDetailsViewController ()

@end

@implementation CacheDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PFQuery *query = [PFQuery queryWithClassName:@"Cache"];
    PFObject* cache = [query getObjectWithId:self.cacheId];

    self.titleLabel.text = cache[@"title"];
    self.descriptionText.text = cache[@"description"];
    self.categoryLabel.text = cache[@"category"];
    
    query = [PFQuery queryWithClassName:@"Found"];
    NSArray* founds = [query findObjects];
    
    NSMutableString *comments = [[NSMutableString alloc] init];
    query = [PFQuery queryWithClassName:@"User"];
    
    for(PFObject* curr in founds)   {
        if([self.cacheId compare:curr[@"cacheId"]] == NSOrderedSame)    {
            PFObject *user = [query getObjectWithId:curr[@"userId"]];
            [comments appendFormat:@"%@: %@ (%@/5)\n", user[@"username"], curr[@"comment"], curr[@"rating"]];
        }
    }
    
    self.commentsText.text = comments;
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

- (IBAction)navigateBtn:(id)sender {
    CompassViewController *compass = [[CompassViewController alloc]
                                                initWithNibName:@"CompassViewController" bundle:nil];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Cache"];
    PFObject* cache = [query getObjectWithId:self.cacheId];
    
    compass.cacheLocation = cache[@"coordinates"];
    [self.navigationController pushViewController:compass animated:YES];
}

- (IBAction)markAsFoundBtn:(id)sender {
    
    self.markAsFoundView.hidden = NO;
    [self.view bringSubviewToFront:self.markAsFoundView];
    NSLog(@"Added popupView!");
}

- (IBAction)foundItBtn:(id)sender {
    PFObject *cache = [PFObject objectWithClassName:@"Found"];
    NSLog(@"Created cache object");
    [self.view endEditing:YES];
    int rating;
    
    if([self.ratingText.text length] == 0)
        rating = 0;
    else
        rating = [self.ratingText.text intValue];
    
    NSLog(@"rating: %i", rating);
    cache[@"rating"] = [NSNumber numberWithInt:rating];
    cache[@"cacheId"] = self.cacheId;
    PFObject *user = [Globals get_User];
    cache[@"userId"] = user.objectId;
    cache[@"comment"] = self.commentText.text;
    
    NSLog(@"Saving object");
    [cache save];
    NSLog(@"removeAnimate");
    self.markAsFoundView.hidden = YES;
}
@end
