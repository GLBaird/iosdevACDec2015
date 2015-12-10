//
//  Person.m
//  Objective C Playground
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize age=privateAge;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.surname = @"Person";
        self.forename = @"New";
        self.age = 0;
    }
    return self;
}

- (NSString *)surname {
    return _surname;
}

- (void)setSurname:(NSString *)surname {
    NSString *copy = [surname copy];
    _surname = copy;
}


-(NSString *)getFullName {
    return [NSString stringWithFormat:@"%@ %@", _forename, _surname];
}

@end
