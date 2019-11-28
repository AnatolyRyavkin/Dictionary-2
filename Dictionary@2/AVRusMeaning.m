//
//  AVRusMeaning.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 14/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "AVRusMeaning.h"

@implementation AVRusMeaning

-(id)init{
    self = [super init];
    if(self){
        self.arrayMeaning = [NSArray new];
        self.accessory = [NSArray new];
        self.dereviative = [NSString new];
        self.arrayExample = [NSArray new];
        
        //self.arrayIdiom = [NSArray new];
        //self.arrayPhrasalVerb = [NSArray new];
    }
    return self;
}

@end
