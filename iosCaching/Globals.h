//
//  Globals.h
//  iosCaching
//
//  Created by Tânia Alves on 30/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Globals : NSObject

+(PFObject*) get_User;
+(void) set_User:(PFObject *)user;

@end
