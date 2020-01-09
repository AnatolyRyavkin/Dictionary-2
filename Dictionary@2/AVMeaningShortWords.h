//
//  AVMeaningShortWords.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 01/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define INT_ENUM_IN_NSNUMBER(x) [NSNumber numberWithInt:x]

typedef enum{
    EnumShort_adj = 0,
    EnumShort_adv,
    EnumShort_cj,
    EnumShort_int,
    EnumShort_n,
    EnumShort_num,
    EnumShort_pl,
    EnumShort_predic,
    EnumShort_pref,
    EnumShort_prep,
    EnumShort_pron,
    EnumShort_refl,
    EnumShort_suff,
    EnumShort_v
    }EnumShortWordsGrammatic;


@interface AVMeaningShortWords : NSObject

@property NSArray *arrayShortWordGrammaticProperty;
@property NSArray *arrayLongWordGrammaticProperty;
@property NSArray *arrayMeaningWordGrammaticProperty;
@property NSDictionary<NSString*,NSString*>*dictionaryFromKeysAsShortAndMeaningAsLongGrammatic;

@property NSArray* arrayShortRusProperty;
@property NSArray* arrayLongRusProperty;
@property NSDictionary<NSString*,NSString*>*dictionaryFromKeysAsShortAndMeaningAsLongRusProperty;

@property NSArray*arrayEngPredlog;

+(id)sharedShortWords;

@end

NS_ASSUME_NONNULL_END

    //@property NSArray* arrayLongWordGrammaticProperty;
    //@property NSArray* arrayMeaningWordGrammaticProperty;
    //
    //@property NSDictionary<NSNumber*,NSString*>*dictionaryKeyShortObjLongWordGrammaticProperty;
    //@property NSDictionary<NSNumber*,NSString*>*dictionaryKeyShortObjMeaningWordGrammaticProperty;
    //


    //@property NSArray* arrayShortRusPropertyAndWords;

    //@property NSArray* arrayLongRusProperty;
    //
    //@property NSDictionary<NSString*,NSString*>*dictionaryRusKeyShortObjLongProperty;
    //
    //@property NSArray* arrayShortRusReduct;
    //@property NSArray* arrayLongRusReduct;
    //
    //@property NSDictionary<NSString*,NSString*>*dictionaryRusKeyShortObjLongReduct;
    //
    //@property NSArray*arrayShortWordGrammatic;
    //
