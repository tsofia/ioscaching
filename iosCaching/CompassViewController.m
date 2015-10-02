//
//  CompassViewController.m
//  iosCaching
//
//  Created by Tânia Alves on 30/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import "CompassViewController.h"

@interface CompassViewController () <CLLocationManagerDelegate>
@property(retain, nonatomic) CLLocationManager *locationManager;
@property(retain, nonatomic) CLHeading *currentHeading;
@end

@implementation CompassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.currentHeading = [[CLHeading alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.headingFilter = 1;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingHeading];
    CLLocation* temp = [self.locationManager location];
    CLLocationCoordinate2D myLocation = temp.coordinate;
    
    CLLocationCoordinate2D cacheLocation = CLLocationCoordinate2DMake(self.cacheLocation.latitude, self.cacheLocation.longitude);
    double radians_overlay = [self getHeadingForDirectionFromCoordinate:myLocation toCoordinate:cacheLocation];
    self.overlay.transform = CGAffineTransformMakeRotation(-radians_overlay);
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

#pragma mark CLLocationManagerDelegate methods
-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error  {
    NSLog(@"An error occurred: %@", error);
}

-(void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading   {
    self.currentHeading = newHeading;
    double degrees = newHeading.magneticHeading;
    self.headingLabel.text = [NSString stringWithFormat:@"%d", (int) degrees];
    
    double radians = degrees * M_PI / 180;
    self.underlay.transform = CGAffineTransformMakeRotation(-radians);
    self.overlay.transform = CGAffineTransformMakeRotation(-radians);
    
}

-(BOOL) locationManagerShouldDisplayHeadingCalibration: (CLLocationManager *)manager
{
    if(self.currentHeading == nil)  {
        return YES;
    }
    
    return NO;
}

- (double) getHeadingForDirectionFromCoordinate:(CLLocationCoordinate2D)fromLoc toCoordinate:(CLLocationCoordinate2D)toLoc
{
    double fLat = (fromLoc.latitude * M_PI) / 180.0;
    double fLng = (fromLoc.longitude * M_PI) / 180.0;
    double tLat = (toLoc.latitude * M_PI) / 180.0;
    double tLng = (toLoc.longitude * M_PI) / 180.0;
    
    return atan2(sin(tLng-fLng)*cos(tLat), cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(tLng-fLng));
}

@end
