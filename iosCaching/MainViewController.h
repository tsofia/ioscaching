//
//  MainViewController.h
//  iosCaching
//
//  Created by Tânia Alves on 20/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Globals.h"
#import <Parse/Parse.h>
#import "CacheDetailsViewController.h"

@interface MainViewController : UIViewController <GMSMapViewDelegate>
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@end
