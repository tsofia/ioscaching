//
//  MapsContainerViewController.m
//  iosCaching
//
//  Created by Tânia Alves on 22/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import "MapsContainerViewController.h"
@import GoogleMaps;

@interface MapsContainerViewController ()

@end

@implementation MapsContainerViewController

GMSMapView *mapView_;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
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




@end
