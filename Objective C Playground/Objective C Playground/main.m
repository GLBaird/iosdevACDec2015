//
//  main.m
//  Objective C Playground
//
//  Created by Leon Baird on 08/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "BetterPerson.h"

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        
        char *myCString = "My String";
        NSString *myString = @"My String";
        
        NSString *manualString = [[NSString alloc] initWithString:@"My String"];
        
        NSLog(@"Hi there, %@", [manualString uppercaseString]);
        
        
        NSArray *myArray = @[@"Bob", @"Mary", @"Frank", @"Betty"];
        
        
        NSLog(@"Number of records %lu", [myArray count]);
        
        NSString *name = [myArray objectAtIndex:0];
        
        NSDictionary *myDictionary = @{
            @"surname": @"Baird",
            @"forname": @"Leon",
            @"age": [NSNumber numberWithInt:40]
        };
        
        int myAge = [[myDictionary valueForKey:@"age"] intValue];
        
        NSLog(@"Surname is %@ and age is %d", [myDictionary valueForKey:@"surname"], myAge);
        
        
        Person *newPerson = [[Person alloc] init];
        
        [newPerson setSurname:@"Baird"];
        
        
        NSLog(@"Person name is %@", [newPerson getFullName]);
        
        BetterPerson *bob = [[BetterPerson alloc] initWithSurname:@"Bob" andForename:@"Bob"];
        
        BetterPerson *example = [BetterPerson personWithtWithSurname:@"Bob" andForename:@"Bob"];
                
    }
    
    return 0;
}
