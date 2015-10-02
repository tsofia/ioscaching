//
//  CompassViewController.h
//  iosCaching
//
//  Created by Tânia Alves on 30/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CompassViewController : UIViewController
@property(nonatomic) PFGeoPoint *cacheLocation;
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;
@property (strong, nonatomic) IBOutlet UIImageView *underlay;
@property (strong, nonatomic) IBOutlet UIImageView *overlay;

- (double) getHeadingForDirectionFromCoordinate:(CLLocationCoordinate2D)fromLoc toCoordinate:(CLLocationCoordinate2D)toLoc;

@end
