//
//  AVMakeBASE.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 14/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVMainManager.h"

@interface NSString  (FirstEndLastChar)

@end

NS_ASSUME_NONNULL_BEGIN
@implementation NSString (FirstEndLastChar)

-(NSString*)stringWithoutLastSimbol{
    return ([self length]>1) ? [self substringToIndex:self.length-1] : @"";
}

-(NSString*)stringWithoutLastSimbolIfSibolComma{
    return ([[self lastCharString] isEqualToString:@","]) ? [self stringWithoutLastSimbol] : @"";
}

-(NSString*)firstCharString{
    unichar ch = [self characterAtIndex:0];
    return [NSString stringWithCharacters:&ch length:1];
}

-(NSString*_Nullable)lastCharString{
    unichar ch = [self characterAtIndex:self.length-1];
    return [NSString stringWithCharacters:&ch length:1];
}

-(int)firstCharInt{
    int chInt = [self characterAtIndex:0];
    return chInt;
}

-(int)lastCharInt{
    int chInt = [self characterAtIndex:self.length-1];
    return chInt;
}


-(NSString*)charStringAtNumber:(int) num{
    unichar ch = [self characterAtIndex:num];
    return [NSString stringWithCharacters:&ch length:1];
}

-(int)charIntAtNumber:(int) num{
    int chInt = [self characterAtIndex:num];
    return chInt;
}

@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface AVMakeBASE : NSObject

@property AVMeaningShortWords *managerMeaningShort;

@property AVMainManager *manager;
@property NSArray<AVEnglWord*>* arrayEngWords;


-(void)makeEngWordsObjFromArrayStrings:(NSArray*) array;
-(NSArray<AVEnglWord*>*)makeArrayEngWordFromArrayArrray: (NSArray*)mainArray;
@end

NS_ASSUME_NONNULL_END
