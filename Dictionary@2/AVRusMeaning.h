//
//  AVRusMeaning.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 14/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVExample.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVRusMeaning : NSObject

@property NSArray<NSString *>* arrayMeaning;
@property NSArray<NSString *> *accessory;
@property NSString *dereviative;
@property NSArray<AVExample*>*arrayExample;

-(id)initForCompose;

//@property NSArray<AVPhrasalVerb*>*arrayPhrasalVerb;
//@property NSArray<NSString*>*arrayIdiom;

@end

NS_ASSUME_NONNULL_END
