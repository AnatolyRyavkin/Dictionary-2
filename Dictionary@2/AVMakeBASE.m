//
//  AVMakeBASE.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 14/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//


#import "AVMakeBASE.h"



typedef NS_ENUM(NSInteger, AVStatusPrevios) {
    AVStatusPreviosBegin = 0,
    AVStatusPreviosMeaningEng,
    AVStatusPreviosTranscript,
    AVStatusPreviosGrammaticEng,
    AVStatusPreviosAddition,
    AVStatusPreviosArrayRusMeaning,
    AVStatusPreviosExamle,
    AVStatusPreviosIdiom,
    AVStatusPreviosPhrasalVerb,
    AVStatusPreviosNumberLat,
    AVStatusPreviosNumberRom

};

typedef NS_ENUM(NSInteger, AVDefineObjectType) {
    AVDefineObjectTypeWord = 0,
    AVDefineObjectTypePhraseVerb
};

typedef NS_ENUM(NSInteger, AVCurrentState) {
    AVCurrentStateBegin = 0,
    AVCurrentStateEngMeanEnd,
    AVCurrentStateTranscriptEnd,
    AVCurrentStateWorkBaseLinks
};

typedef NS_ENUM(NSInteger, AVDefineString) {
    AVDefineStringEng = 0,
    AVDefineStringRus,
    AVDefineStringSquareBrackets,
    AVDefineStringRoundBrackets,
    AVDefineStringEngWithNumberAtEnding,
    AVDefineStringEngWithCommaAtEnding,
    AVDefineStringEngWithPointCommaAtEnding,
    AVDefineStringEngWithPointAtEnding,
    AVDefineStringRusWithNumberAtEnding,
    AVDefineStringRusWithCommaAtEnding,
    AVDefineStringRusWithPointCommaAtEnding,
    AVDefineStringRusWithPointAtEnding,
    AVDefineStringRusNumberLat,
    AVDefineStringRusNumberRom

};


@interface AVMakeBASE ()
{

    AVStatusPrevios statePreviosLink;
    AVCurrentState currentStateBuildingObject;
    AVDefineObjectType defineObjectType;
    AVEnglWord *objEngWord;
    AVPhrasalVerb *phrasalVerb;
    AVRusMeaning *rusMeaning;
    NSMutableArray<AVEnglWord *>*tempMainArray;
    AVDefineString stateCurrentDefineString;
    AVMeaningShortWords*managerShortWords;
    int j;


}

@end

@implementation AVMakeBASE

-(void)setBeginMeaning{

    self.managerMeaningShort =[[AVMeaningShortWords alloc]init];
    objEngWord = [[AVEnglWord alloc] init];
    phrasalVerb = [[AVPhrasalVerb alloc]init];
    rusMeaning = [[AVRusMeaning alloc]init];
    currentStateBuildingObject = AVCurrentStateBegin;
    statePreviosLink = AVStatusPreviosBegin;
    defineObjectType = AVDefineObjectTypeWord;
    tempMainArray = [NSMutableArray arrayWithArray:self.manager.mainArray];
    managerShortWords = [AVMeaningShortWords sharedShortWords];
    j = 0;

}

#pragma mark - Cycle Objects

-(NSArray<AVEnglWord*>*)makeArrayEngWordFromArrayArrray: (NSArray*)mainArray{
    [self setBeginMeaning];
    for(NSArray*array in mainArray){
        [self makeEngWordsObjFromArrayStrings:array];
        j++;
    }
    self.arrayEngWords = [NSArray arrayWithArray:tempMainArray];
    return self.arrayEngWords;
}

#pragma mark -  Cycle Words

-(void)makeEngWordsObjFromArrayStrings:(NSArray*) array{
    if([array[0] isEqualToString:@"[■]"])
        defineObjectType = AVDefineObjectTypePhraseVerb;
    for(int i = 0; i < array.count - 1; i++){
        NSString*string = array[i];
        if([string isEqualToString:@""] || [string isEqualToString:@" "])
            i++;
        if(defineObjectType == AVDefineObjectTypeWord){
            stateCurrentDefineString = [self defineString:string];
            [self makeObjectEngWord:string];
        }
        else
            [self makeObjectPhraseVerb:string];
        //cycle end
    }
    if(objEngWord)
       [tempMainArray addObject:objEngWord];
    else if(phrasalVerb){
        if(j != arc4random()){
            NSMutableArray *mutArrayVerbal = [NSMutableArray arrayWithArray:tempMainArray[j-1].arrayPhrasalVerb];
            [mutArrayVerbal addObject:phrasalVerb];
            AVEnglWord *objEngWord = tempMainArray[j-1];
            objEngWord.arrayPhrasalVerb = [NSArray arrayWithArray:mutArrayVerbal];
        }
    }


}

#pragma mark - Make object word

-(void)makeObjectEngWord:(NSString *) string{

#pragma mark - begin----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    if(statePreviosLink == AVStatusPreviosBegin){
        NSString *stringTemp;
        switch (stateCurrentDefineString) {
            case AVDefineStringEng:
                stringTemp = string;
                break;
            case AVDefineStringEngWithNumberAtEnding:
                stringTemp = [string substringToIndex:string.length-2];
                if(string.intValue > 0)
                    setIndexPathGlobal(objEngWord.indexPathMeaningWord, string.intValue-1);
                else
                     NSLog(@"Error string.intValue < 1  ");

                break;
            default:
                break;
        }
        objEngWord.engMeaningObject = stringTemp;
        statePreviosLink = AVStatusPreviosMeaningEng;
    }

#pragma mark - Previos English Word and string is english(may be with number at ending) and  current status dont ending meanining------------------------------------------------------------------------------------

     if(statePreviosLink == AVStatusPreviosMeaningEng && stateCurrentDefineString == AVDefineStringEng && currentStateBuildingObject == !AVCurrentStateEngMeanEnd){
         objEngWord.engMeaningObject = [objEngWord.engMeaningObject stringByAppendingFormat:@" %@",string];
         statePreviosLink = AVStatusPreviosMeaningEng;
     }
    if(statePreviosLink == AVStatusPreviosMeaningEng && stateCurrentDefineString == AVDefineStringEngWithNumberAtEnding && currentStateBuildingObject == !AVCurrentStateEngMeanEnd){
        NSString *stringTemp = [string substringToIndex:string.length-2];
        objEngWord.engMeaningObject = [objEngWord.engMeaningObject stringByAppendingFormat:@" %@",stringTemp];
        if(string.intValue > 0)
            setIndexPathGlobal(objEngWord.indexPathMeaningWord, string.intValue-1);
        else
            NSLog(@"Error string.intValue < 1  ");
        statePreviosLink = AVStatusPreviosMeaningEng;
    }

#pragma mark - Previos English Word and string is number Roma and  current status dont ending meanining
    if(statePreviosLink == AVStatusPreviosMeaningEng && stateCurrentDefineString == AVDefineStringRusNumberRom && currentStateBuildingObject == !AVCurrentStateEngMeanEnd){
        currentStateBuildingObject = AVCurrentStateEngMeanEnd;
        setIndexPathLocal(objEngWord.indexPathMeaningWord, [string makeNumFromRomaNum]);
        statePreviosLink = AVStatusPreviosNumberRom;
    }

#pragma mark - String is squarte brackspase

    if (currentStateBuildingObject == !AVCurrentStateTranscriptEnd && stateCurrentDefineString == AVDefineStringSquareBrackets){
        objEngWord.engTranscript = string;
        currentStateBuildingObject = AVCurrentStateTranscriptEnd;
        statePreviosLink = AVStatusPreviosTranscript;
    }else if(stateCurrentDefineString == AVDefineStringSquareBrackets)
         NSLog(@"Error squarte bracket  ");

#pragma mark - Previos transcript  and string is English

    if((statePreviosLink == AVStatusPreviosTranscript || statePreviosLink == AVStatusPreviosGrammaticEng)  && stateCurrentDefineString == AVDefineStringEng){

        if([managerShortWords.arrayShortWordGrammaticProperty containsObject:string]){
            objEngWord.grammaticType = [objEngWord.grammaticType arrayByAddingObject:string];
            statePreviosLink = AVStatusPreviosGrammaticEng;
            currentStateBuildingObject = AVCurrentStateWorkBaseLinks;
        }else
             NSLog(@"Error Previos transcript  and string is English  ");
    }


////   stoping -----------


}






#pragma mark - Check word at AVDefineString

-(AVDefineString)defineString:(NSString *)string{
//    const char* chars = string.UTF8String;
    BOOL flagEng = YES;
    BOOL flagRus = YES;

    if([string isEqualToString:@"I"] || [string isEqualToString:@"II"] || [string isEqualToString:@"III"] || [string isEqualToString:@"IV"] || [string isEqualToString:@"V"] || [string isEqualToString:@"VI"] || [string isEqualToString:@"VII"] || [string isEqualToString:@"VIII"]){
        return AVDefineStringRusNumberRom;
    }

    if(string.intValue)
        return AVDefineStringRusNumberLat;

    if([[string firstCharString] isEqualToString:@"["] && [[string lastCharString] isEqualToString:@"]"])
        return AVDefineStringSquareBrackets;

    if([[string firstCharString] isEqualToString:@"("] && [[string lastCharString] isEqualToString:@"}"])
        return AVDefineStringRoundBrackets;


    for(int i = 0; i < string.length; i++){
//        char chr = chars[i];
//        char chr1 = string.UTF8String[i];

        int ch = [string charIntAtNumber:i];
        NSString *strChar = [string charStringAtNumber:i];

        if( (ch <= 64 || ch >= 123) && flagEng && i != string.length - 1)
            flagEng = NO;

        if( ( ch < 1040 || ch > 1103) && flagRus)
            flagRus = NO;

        if(i == string.length - 1 && flagEng){
            if(strChar.intValue)
                return AVDefineStringEngWithNumberAtEnding;
            else if( ( ch > 64 || ch < 123) && flagEng)
                return AVDefineStringEng;
            else if([strChar isEqualToString:@","])
                return AVDefineStringEngWithCommaAtEnding;
            else if([strChar isEqualToString:@";"])
                return AVDefineStringEngWithPointCommaAtEnding;
            else if([strChar isEqualToString:@"."])
                return AVDefineStringEngWithPointAtEnding;
        }else if(i == string.length - 1 && flagRus){
            if(strChar.intValue)
                return AVDefineStringRusWithNumberAtEnding;
            else if( ( ch > 64 || ch < 123) && flagEng)
                return AVDefineStringRus;
            else if([strChar isEqualToString:@","])
                return AVDefineStringRusWithCommaAtEnding;
            else if([strChar isEqualToString:@";"])
                return AVDefineStringRusWithPointCommaAtEnding;
            else if([strChar isEqualToString:@"."])
                return AVDefineStringRusWithPointAtEnding;
        }







    }

    return AVDefineStringEng;
}



#pragma mark - Make object phrase verb

-(void)makeObjectPhraseVerb:(NSString *) string{
    phrasalVerb.name = @"name";
    phrasalVerb.accessory = @"accessory";
}

#pragma mark -  Cycle Chars


@end

    //
    //#pragma mark - check then this is string is transkription
    //
    //        if([[string firstCharString] isEqualToString:@"["] && ![string  isEqualToString:@"[■]"]){
    //            flagEngMeaningEnd = YES;
    //            objEngWord.engTranscript = [NSString stringWithString:string];
    //            flagEngTranscriptEnd = YES;
    //        }
    //
    //#pragma mark - check thet engMeaningObject dont end fill.
    //
    //        if(!flagEngMeaningEnd)
    //            objEngWord.engMeaningObject = [NSString stringWithFormat:@"%@ %@",objEngWord.engMeaningObject,string];
    //
    //#pragma mark - check thet engMeaningObject engTranscript end fill.
    //
    //
    //        if(flagEngTranscriptEnd && flagEngMeaningEnd){
    //
    //#pragma mark - check string is england
    //
    //            if([string firstCharInt] > 64 && [string firstCharInt] < 123){
    //
    //#pragma mark - check thet string is grammatic
    //                if([self.managerMeaningShort.arrayShortWordGrammatic containsObject:string] || [self.managerMeaningShort.arrayShortWordGrammatic containsObject:[string stringWithoutLastSimbolIfSibolComma]]){
    //
    //                }
    //            }
    //            else if([string firstCharInt] > 1040 && [string firstCharInt] < 1103){
    //
    //            }
    //            else{
    //                NSLog(@"Error!!!!!!!!!!!!!! dont know this simbol");
    //            }
    //        }
    //
    //
