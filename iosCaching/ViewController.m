//
//  ViewController.m
//  iosCaching
//
//  Created by Tânia Alves on 20/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnPressed:(UIButton *)sender {
    if([self.emailInsertTextField.text length] == 0 &&
       [self.pwdInsertTextField.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                    message:@"Please fill all the fields before loging in."
                    delegate:nil
                    cancelButtonTitle:@"OK"
                    otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if([self  checkCredentials:self.emailInsertTextField.text and:self.pwdInsertTextField.text])
    {
        UIStoryboard *storyboard = self.storyboard;
        //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (Boolean)checkCredentials: (NSString*)userEmail and:(NSString*)password {
    __block bool verified = FALSE;
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"email" equalTo: userEmail];
    
    NSArray* users = [query findObjects];
    
    if([users count] != 0)  {
        for(PFObject* user in users)   {
            if([userEmail compare:user[@"email"]] == NSOrderedSame)    {
                NSString *resultPassword = [user objectForKey:@"password"];
                if([password compare:resultPassword] == NSOrderedSame)  {
                    [Globals set_User:user];
                    verified = TRUE;
                    break;
                }
            }
        }
    }
    
    return verified;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.emailInsertTextField isFirstResponder] && (self.emailInsertTextField != touch.view))
    {
        // textField1 lost focus
        [self.emailInsertTextField resignFirstResponder];
    }
    
    if ([self.pwdInsertTextField isFirstResponder] && (self.pwdInsertTextField != touch.view))
    {
        // textField2 lost focus
        [self.pwdInsertTextField resignFirstResponder];
    }
}

@end
