//
//  AVExample.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 11/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "AVExample.h"

@implementation AVExample

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.meaning = [NSString new];
        self.accessory = [NSString new];
    }
    return self;
}

@end
