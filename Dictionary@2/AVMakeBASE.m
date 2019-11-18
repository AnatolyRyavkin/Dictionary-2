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
    AVStatusPreviosPhrasalVerb
};

typedef NS_ENUM(NSInteger, AVDefineObjectType) {
    AVDefineObjectTypeWord = 0,
    AVDefineObjectTypePhraseVerb
};

typedef NS_ENUM(NSInteger, AVCurrentState) {
    AVCurrentStateBegin = 0,
    AVCurrentStateEngMeanEnd,
    AVCurrentStateTranscriptEnd,
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

};



@interface AVMakeBASE ()
{

    AVStatusPrevios statePrevios;
    AVCurrentState currentState;
    AVDefineObjectType defineObjectType;
    AVEnglWord *objEngWord;
    AVPhrasalVerb *phrasalVerb;
    AVRusMeaning *rusMeaning;
    NSMutableArray<AVEnglWord *>*tempMainArray;
    AVDefineString defineString;
    int j;


}

@end

@implementation AVMakeBASE

-(void)setBeginMeaning{

    self.managerMeaningShort =[[AVMeaningShortWords alloc]init];
    objEngWord = [[AVEnglWord alloc] init];
    phrasalVerb = [[AVPhrasalVerb alloc]init];
    rusMeaning = [[AVRusMeaning alloc]init];
    currentState = AVCurrentStateBegin;
    statePrevios = AVStatusPreviosBegin;
    defineObjectType = AVDefineObjectTypeWord;
    tempMainArray = [NSMutableArray arrayWithArray:self.manager.mainArray];
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
            defineString = [self defineString:string];
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

    if(statePrevios == AVStatusPreviosBegin){

        NSString *stringTemp;

        switch (defineString) {
            case AVDefineStringEng:
                stringTemp = string;
                break;
            case AVDefineStringEngWithNumberAtEnding:
                stringTemp = [string substringToIndex:string.length-2];
                break;
            default:
                break;
        }
        objEngWord.engMeaningObject = stringTemp;
        statePrevios = AVStatusPreviosMeaningEng;
    }


    if(statePrevios == AVStatusPreviosMeaningEng){
        NSString* stringTemp;
        switch (defineString) {
            case AVDefineStringEng:
                objEngWord.engMeaningObject = [objEngWord.engMeaningObject stringByAppendingFormat:@" %@",string];
                statePrevios = AVStatusPreviosMeaningEng;
                break;
            case AVDefineStringEngWithNumberAtEnding:
                stringTemp = [string substringToIndex:string.length-2];
                objEngWord.engMeaningObject = [objEngWord.engMeaningObject stringByAppendingFormat:@" %@",stringTemp];
                statePrevios = AVStatusPreviosMeaningEng;
                break;
            case AVDefineStringSquareBrackets:
                objEngWord.engTranscript = string;
                statePrevios = AVStatusPreviosTranscript;
                break;
            default:
                NSLog(@"AVDefineString!!!");
                break;
        }

    }

    if(statePrevios == AVStatusPreviosTranscript){
        switch (defineString) {
            case AVDefineStringEng:

                break;
            case AVDefineStringEngWithCommaAtEnding:

                break;
            case AVDefineStringEngWithPointCommaAtEnding:

                break;
            case AVDefineStringEngWithPointAtEnding:

                break;
            case AVDefineStringRus:

                break;
            case AVDefineStringRusWithCommaAtEnding:

                break;
            case AVDefineStringRusWithPointCommaAtEnding:

                break;
            case AVDefineStringRusWithPointAtEnding:

                break;
            case AVDefineStringRoundBrackets:

                break;
            default:
                NSLog(@"AVDefineString!!!");
                break;
        }

    }

        if(statePrevios == AVStatusPreviosGrammaticEng){
            switch (defineString) {
                case AVDefineStringEng:

                    break;
                case AVDefineStringEngWithCommaAtEnding:

                    break;
                case AVDefineStringEngWithPointCommaAtEnding:

                    break;
                case AVDefineStringEngWithPointAtEnding:

                    break;
                case AVDefineStringRus:

                    break;
                case AVDefineStringRusWithCommaAtEnding:

                    break;
                case AVDefineStringRusWithPointCommaAtEnding:

                    break;
                case AVDefineStringRusWithPointAtEnding:

                    break;
                case AVDefineStringRoundBrackets:

                    break;
                default:
                    NSLog(@"AVDefineString!!!");
                    break;
            }

    }

    if(statePrevios == AVStatusPreviosAddition){
        switch (defineString) {
            case AVDefineStringEng:

                break;
            case AVDefineStringEngWithCommaAtEnding:

                break;
            case AVDefineStringEngWithPointCommaAtEnding:

                break;
            case AVDefineStringEngWithPointAtEnding:

                break;
            case AVDefineStringRus:

                break;
            case AVDefineStringRusWithCommaAtEnding:

                break;
            case AVDefineStringRusWithPointCommaAtEnding:

                break;
            case AVDefineStringRusWithPointAtEnding:

                break;
            case AVDefineStringRoundBrackets:

                break;
            default:
                NSLog(@"AVDefineString!!!");
                break;
        }

    }


    if(statePrevios == AVStatusPreviosArrayRusMeaning){
        switch (defineString) {
            case AVDefineStringEng:

                break;
            case AVDefineStringEngWithCommaAtEnding:

                break;
            case AVDefineStringEngWithPointCommaAtEnding:

                break;
            case AVDefineStringEngWithPointAtEnding:

                break;
            case AVDefineStringRus:

                break;
            case AVDefineStringRusWithCommaAtEnding:

                break;
            case AVDefineStringRusWithPointCommaAtEnding:

                break;
            case AVDefineStringRusWithPointAtEnding:

                break;
            case AVDefineStringRoundBrackets:

                break;
            default:
                NSLog(@"AVDefineString!!!");
                break;
        }

    }

    if(statePrevios == AVStatusPreviosExamle){
        switch (defineString) {
            case AVDefineStringEng:

                break;
            case AVDefineStringEngWithCommaAtEnding:

                break;
            case AVDefineStringEngWithPointCommaAtEnding:

                break;
            case AVDefineStringEngWithPointAtEnding:

                break;
            case AVDefineStringRus:

                break;
            case AVDefineStringRusWithCommaAtEnding:

                break;
            case AVDefineStringRusWithPointCommaAtEnding:

                break;
            case AVDefineStringRusWithPointAtEnding:

                break;
            case AVDefineStringRoundBrackets:

                break;
            default:
                NSLog(@"AVDefineString!!!");
                break;
        }

    }

    if(statePrevios == AVStatusPreviosIdiom){
        switch (defineString) {
            case AVDefineStringEng:

                break;
            case AVDefineStringEngWithCommaAtEnding:

                break;
            case AVDefineStringEngWithPointCommaAtEnding:

                break;
            case AVDefineStringEngWithPointAtEnding:

                break;
            case AVDefineStringRus:

                break;
            case AVDefineStringRusWithCommaAtEnding:

                break;
            case AVDefineStringRusWithPointCommaAtEnding:

                break;
            case AVDefineStringRusWithPointAtEnding:

                break;
            case AVDefineStringRoundBrackets:

                break;
            default:
                NSLog(@"AVDefineString!!!");
                break;
        }

    }

    if(statePrevios == AVStatusPreviosPhrasalVerb){
        switch (defineString) {
            case AVDefineStringEng:

                break;
            case AVDefineStringEngWithCommaAtEnding:

                break;
            case AVDefineStringEngWithPointCommaAtEnding:

                break;
            case AVDefineStringEngWithPointAtEnding:

                break;
            case AVDefineStringRus:

                break;
            case AVDefineStringRusWithCommaAtEnding:

                break;
            case AVDefineStringRusWithPointCommaAtEnding:

                break;
            case AVDefineStringRusWithPointAtEnding:

                break;
            case AVDefineStringRoundBrackets:

                break;
            default:
                NSLog(@"AVDefineString!!!");
                break;
        }

    }


}

#pragma mark - Check word at AVDefineString

-(AVDefineString)defineString:(NSString *)string{
//    const char* chars = string.UTF8String;
    BOOL flagEng = YES;
    BOOL flagRus = YES;

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
