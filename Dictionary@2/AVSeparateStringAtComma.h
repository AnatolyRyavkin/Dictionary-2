//
//  AVSeparateStringAtComma.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 22.01.2020.
//  Copyright © 2020 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVSeparateStringAtComma : NSObject

@property NSString *stringInput;
@property UINavigationController* nc;
@property UIViewController* vc;

-(id)initNavigationController:(UINavigationController*) nc  andViewController:(UIViewController*) vc;

-(NSArray*)mutatingString: (NSString*) inputString;


@end

NS_ASSUME_NONNULL_END
