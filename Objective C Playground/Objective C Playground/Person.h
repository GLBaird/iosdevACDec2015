//
//  Person.h
//  Objective C Playground
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSString *_surname;
}

- (NSString *)surname;
- (void)setSurname:(NSString *)surname;

@property (assign) int age;
@property (copy) NSString *forename;


- (NSString *)getFullName;

@end
