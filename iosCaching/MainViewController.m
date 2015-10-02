//
//  MainViewController.m
//  iosCaching
//
//  Created by Tânia Alves on 20/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Controls whether the My Location dot and accuracy circle is enabled.
    self.mapView.myLocationEnabled = YES;
    //Controls the type of map tiles that should be displayed.
    self.mapView.mapType = kGMSTypeNormal;
    //Shows the compass button on the map
    self.mapView.settings.compassButton = YES;
    //Shows the my location button on the map
    self.mapView.settings.myLocationButton = YES;
    //Sets the view controller to be the GMSMapView delegate
    self.mapView.delegate = self;
    
    //Get caches for map
    PFQuery *query = [PFQuery queryWithClassName:@"Cache"];
    
    NSArray* caches = [query findObjects];
    
    if([caches count] != 0)  {
        for(PFObject* cache in caches)   {
            PFGeoPoint* l = cache[@"coordinates"];
            //CLLocationCoordinate2D position = CLLocationCoordinate2DMake(l.latitude, l.longitude);
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(l.latitude, l.longitude);
            marker.title = cache[@"title"];
            marker.snippet = cache.objectId;
            marker.map = self.mapView;
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


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    CacheDetailsViewController *cacheDetails = [[CacheDetailsViewController alloc]
                                                initWithNibName:@"CacheDetailsViewController" bundle:nil];
    cacheDetails.cacheId = marker.snippet;
    [self.navigationController pushViewController:cacheDetails animated:YES];
    
    return YES;
}



@end
