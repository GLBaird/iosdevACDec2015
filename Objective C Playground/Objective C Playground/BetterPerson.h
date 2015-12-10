//
//  BetterPerson.h
//  Objective C Playground
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetterPerson : NSObject

@property (copy, nonatomic) NSString *surname, *forename;
@property (assign, nonatomic) NSUInteger age;
@property (strong, nonatomic) NSDate *joinDate;

- (instancetype)initWithSurname: (NSString *)surname andForename: (NSString *)forename;
- (instancetype)initWithSurname: (NSString *)surname andForename: (NSString *)forename andAge: (NSUInteger)age;

+ (BetterPerson *) personWithtWithSurname: (NSString *)surname andForename: (NSString *)forename;


@end

@interface BetterPerson (Networking)

- (NSString *)getFullName;

@end
