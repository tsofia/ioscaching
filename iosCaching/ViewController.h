//
//  ViewController.h
//  iosCaching
//
//  Created by Tânia Alves on 20/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Globals.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailInsertTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdInsertTextField;
- (IBAction)loginBtnPressed:(UIButton *)sender;

@end

