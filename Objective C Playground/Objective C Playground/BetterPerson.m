//
//  BetterPerson.m
//  Objective C Playground
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

#import "BetterPerson.h"

@interface BetterPerson ()



@end

@implementation BetterPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.surname = @"Person";
        self.forename = @"New";
        self.joinDate = [NSDate date];
    }
    return self;
}

- (instancetype)initWithSurname: (NSString *)surname andForename: (NSString *)forename {
    self = [super init];
    if (self) {
        self.surname = surname;
        self.forename = forename;
        self.joinDate = [NSDate date];
    }
    return self;
}

-(instancetype)initWithSurname:(NSString *)surname andForename:(NSString *)forename andAge:(NSUInteger)age {
    self = [self initWithSurname:surname andForename:forename];
    if (self) {
        self.age = age;
    }
    return  self;
}

+ (BetterPerson *) personWithtWithSurname: (NSString *)surname andForename: (NSString *)forename {
    BetterPerson *newPerson = [[BetterPerson alloc] initWithSurname:surname andForename:forename];
    return newPerson;
}

@end

@implementation BetterPerson (Networking)

- (NSString *)getFullName {
    return [NSString stringWithFormat:@"%@ %@", self.forename, self.surname];
}

@end
