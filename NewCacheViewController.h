//
//  NewCacheViewController.h
//  iosCaching
//
//  Created by Tânia Alves on 01/10/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "Globals.h"

@interface NewCacheViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *titleText;
@property (strong, nonatomic) IBOutlet UITextField *categoryText;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) IBOutlet UITextField *latitudeText;
@property (strong, nonatomic) IBOutlet UITextField *longitudeText;
- (IBAction)useMyLocation:(id)sender;
- (IBAction)addNewCachePressed:(id)sender;

@end
