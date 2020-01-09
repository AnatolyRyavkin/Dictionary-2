//
//  AVConstants.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 25/12/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* indexPathGlobalKey;
extern NSString* indexPathLocalKey;
extern NSString* indexPathCountKey;
extern NSString* engMeaningObjectKey;
extern NSString* engTranscriptKey;
extern NSString* grammaticTypeKey;
extern NSString* grammaticFormKey;
extern NSString* arrayRusMeaningKey;
extern NSString* arrayIdiomKey;
extern NSString* arrayPhrasalVerbKey;

extern NSString* arrayMeaningRusMeaningKey;
extern NSString* accessoryRusMeaningKey;
extern NSString* dereviativeRusMeaningKey;
extern NSString* arrayExampleRusMeaningKey;

extern NSString*meaningExampleKey;
extern NSString*accessoryExampleKey;

extern NSString*typeObjectKey;

//
//@property AVIndexPathMeaning indexPathMeaningWord;
//@property NSString*engMeaningObject;
//@property NSString*engTranscript;
//@property NSArray<NSString*>*grammaticType;
//@property NSArray<NSString*>*grammaticForm;
//@property NSArray<AVRusMeaning *>*arrayRusMeaning;
//@property NSArray<NSString*>*arrayIdiom;
//@property NSArray <AVPhrasalVerb*>*arrayPhrasalVerb;

//@property NSArray<NSString *>* arrayMeaning;
//@property NSArray<NSString *> *accessory;
//@property NSString *dereviative;
//@property NSArray<AVExample*>*arrayExample;

//@property NSString*meaning;
//@property NSString*accessory;

@interface AVConstants : NSObject

@end

NS_ASSUME_NONNULL_END
