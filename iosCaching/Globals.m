//
//  Globals.m
//  iosCaching
//
//  Created by Tânia Alves on 30/09/15.
//  Copyright (c) 2015 Tânia Alves. All rights reserved.
//

#import "Globals.h"

static PFObject* user;

@implementation Globals

+(PFObject*) get_User {
    return user;
}

+(void) set_User:(PFObject *) newUser    {
    user = newUser;
    return;
}

@end
