//
//  AVMainManager.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 01/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVEnglWord.h"

NS_ASSUME_NONNULL_BEGIN


@interface AVMainManager : NSObject

@property (atomic) NSArray*mainArray;

@property NSArray<AVEnglWord*>* arrayObjectWords;

+(id)managerData;

-(void)removeStringAtIndexPath:(NSIndexPath*)indexPath;



@end;

NS_ASSUME_NONNULL_END
