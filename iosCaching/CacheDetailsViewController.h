//
//  CacheDetailsViewController.h
//  iosCaching
//
//  Created by Tânia Alves on 28/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Globals.h"

@interface CacheDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) IBOutlet UITextView *commentsText;
- (IBAction)navigateBtn:(id)sender;
- (IBAction)markAsFoundBtn:(id)sender;
@property(nonatomic) NSString* cacheId;
@property (strong, nonatomic) IBOutlet UIView *markAsFoundView;
- (IBAction)foundItBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *commentText;
@property (strong, nonatomic) IBOutlet UITextField *ratingText;

@end
