//
//  NewCacheViewController.m
//  iosCaching
//
//  Created by Tânia Alves on 01/10/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import "NewCacheViewController.h"

@interface NewCacheViewController () <CLLocationManagerDelegate>

@end

@implementation NewCacheViewController  {
    CLLocationManager *manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    manager = [[CLLocationManager alloc] init];
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

- (IBAction)useMyLocation:(id)sender {
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [manager startUpdatingLocation];
    [manager stopUpdatingLocation];
    
    CLLocation* myLocation = [manager location];
    
    self.latitudeText.text = [NSString stringWithFormat:@"%0.8f", myLocation.coordinate.latitude];
    self.longitudeText.text = [NSString stringWithFormat:@"%0.8f", myLocation.coordinate.longitude];
    
    
}

- (IBAction)addNewCachePressed:(id)sender {
    if([self.titleText.text length] == 0 || [self.categoryText.text length] == 0
       || [self.latitudeText.text length] == 0 || [self.longitudeText.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please fill all the fields to add the cache."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    PFObject* user = [Globals get_User];
    PFObject* newCache = [PFObject objectWithClassName:@"Cache"];
    newCache[@"title"] = self.titleText.text;
    newCache[@"description"] = self.descriptionText.text;
    newCache[@"author"] = user.objectId;
    newCache[@"category"] = self.categoryText.text;
    double lat = [self.latitudeText.text doubleValue];
    double longi = [self.longitudeText.text doubleValue];
    newCache[@"coordinates"] = [PFGeoPoint geoPointWithLatitude:lat longitude:longi];
    
    [newCache save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark CLLocationManagerDelegate methods
-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error  {
    NSLog(@"An error occurred: %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation    {
    CLLocation* currentLocation = newLocation;
    
    if(currentLocation != nil)    {
        self.latitudeText.text = [NSString stringWithFormat:@"%0.8f", currentLocation.coordinate.latitude];
        self.longitudeText.text = [NSString stringWithFormat:@"%0.8f", currentLocation.coordinate.longitude];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.titleText isFirstResponder] && [touch view] != self.titleText) {
        [self.titleText resignFirstResponder];
    }
    if ([self.categoryText isFirstResponder] && [touch view] != self.categoryText) {
        [self.categoryText resignFirstResponder];
    }
    if ([self.descriptionText isFirstResponder] && [touch view] != self.descriptionText) {
        [self.descriptionText resignFirstResponder];
    }
    if ([self.latitudeText isFirstResponder] && [touch view] != self.latitudeText) {
        [self.latitudeText resignFirstResponder];
    }
    if ([self.longitudeText isFirstResponder] && [touch view] != self.longitudeText) {
        [self.longitudeText resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


@end
