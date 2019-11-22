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
    AVStatusPreviosAdditionBase,
    AVStatusPreviosArrayRusMeaning,
    AVStatusPreviosExamle,
    AVStatusPreviosIdiom,
    AVStatusPreviosPhrasalVerb,
    AVStatusPreviosNumberLatMakeNewRusObj,
    AVStatusPreviosNumberRom,
    AVStatusPreviosRoundBrackets,
    AVStatusPreviosForm
};

typedef NS_ENUM(NSInteger, AVDefineObjectType) {
    AVDefineObjectTypeWord = 0,
    AVDefineObjectTypePhraseVerb
};

typedef NS_ENUM(NSInteger, AVCurrentState) {
    AVCurrentStateBuildingBegin = 0,
    AVCurrentStateBuildingEngMeanEnd,
    AVCurrentStateBuildingTranscriptEnd,
    AVCurrentStateBuildingObjectGlobal,
    AVCurrentStateBuildingObjectLocal,
    AVCurrentStateBuildingDerevativeObjectGlobal,
    AVCurrentStateBuildingDerevativeObjectLocal
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
    AVDefineStringNumberLat,
    AVDefineStringNumberRom,
    AVDefineStringDerevative

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
    currentStateBuildingObject = AVCurrentStateBuildingBegin;
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

        //определяем вид обекта и запускаем цикл построчно , создаем обжект

    if([array[0] isEqualToString:@"[■]"])
        defineObjectType = AVDefineObjectTypePhraseVerb;
    for(int i = 0; i < array.count - 1; i++){
        NSString*string = array[i];
        if([string isEqualToString:@""] || [string isEqualToString:@" "])
            i++;
        if(defineObjectType == AVDefineObjectTypeWord){

//определяем статус строки

            stateCurrentDefineString = [self defineString:string];

//изменяем статус строки если проходим

            if(([string isEqualToString:@"pl"] && [array[i+1] isEqualToString:@"от"]) ||
                ([string isEqualToString:@"superl"] && [array[i+1] isEqualToString:@"от"]) ||
                ([string isEqualToString:@"compare"] && [array[i+1] isEqualToString:@"от"]) ||
                ([string isEqualToString:@"past"] && [array[i+1] isEqualToString:@"от"]) ||
                ([string isEqualToString:@"p"] && [array[i+1] isEqualToString:@"p"] && [array[i+2] isEqualToString:@"от"])){

                    currentStateBuildingObject = (currentStateBuildingObject == AVCurrentStateBuildingObjectGlobal) ? AVCurrentStateBuildingDerevativeObjectGlobal : AVCurrentStateBuildingDerevativeObjectLocal;

                }

//изменяем статус строки если проходим

            if(currentStateBuildingObject == AVCurrentStateBuildingObjectGlobal &&
               (statePreviosLink == AVStatusPreviosRoundBrackets || statePreviosLink == AVStatusPreviosTranscript || statePreviosLink == AVStatusPreviosGrammaticEng || statePreviosLink == AVStatusPreviosAdditionBase ||
                statePreviosLink == AVStatusPreviosNumberRom || statePreviosLink == AVStatusPreviosForm ) &&
               ([string isEqualToString:@"от"] || [string isEqualToString:@"="]) ) {
                    if(i < array.count - 1){
                        if( [array[i+1] isContaintEngChars ]){
                            currentStateBuildingObject = AVCurrentStateBuildingDerevativeObjectGlobal;
                        }
                    }
               }

            if(currentStateBuildingObject == AVCurrentStateBuildingDerevativeObjectLocal || currentStateBuildingObject == AVCurrentStateBuildingDerevativeObjectGlobal)
                stateCurrentDefineString = AVDefineStringDerevative;

//изменяем статус строки если проходим

            if( ([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2)){
                rusMeaning = [[AVRusMeaning alloc]init];
                statePreviosLink = AVStatusPreviosNumberLatMakeNewRusObj;
                currentStateBuildingObject = AVCurrentStateBuildingObjectLocal;
                [objEngWord nextIndexPathCountMeaningInObject];
                objEngWord.arrayRusMeaning = [objEngWord.arrayRusMeaning arrayByAddingObject:rusMeaning];
                break;
            }


            [self makeObjectEngWord:string];

        }

// если обьект фразовый глагол

        else
            [self makeObjectPhraseVerb:string];

    }


//слдфдываем в массив готовые обьекты

    if(defineObjectType == AVDefineObjectTypeWord)
       [tempMainArray addObject:objEngWord];

    else if(defineObjectType == AVDefineObjectTypePhraseVerb){
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
            case AVDefineStringEngWithCommaAtEnding:
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
        return;
    }

#pragma mark - Previos English Word and string is english(may be with number at ending) and  current status dont ending meanining------------------------------------------------------------------------------------

     if(statePreviosLink == AVStatusPreviosMeaningEng && (stateCurrentDefineString == AVDefineStringEng || stateCurrentDefineString == AVDefineStringEngWithCommaAtEnding)  && currentStateBuildingObject == AVCurrentStateBuildingBegin){
         objEngWord.engMeaningObject = [objEngWord.engMeaningObject stringByAppendingFormat:@" %@",string];
         statePreviosLink = AVStatusPreviosMeaningEng;
         return;
     }
    if(statePreviosLink == AVStatusPreviosMeaningEng && stateCurrentDefineString == AVDefineStringEngWithNumberAtEnding && currentStateBuildingObject == AVCurrentStateBuildingBegin){
        NSString *stringTemp = [string substringToIndex:string.length-2];
        objEngWord.engMeaningObject = [objEngWord.engMeaningObject stringByAppendingFormat:@" %@",stringTemp];
        if([string lastCharString].intValue > 0){
            setIndexPathGlobal(objEngWord.indexPathMeaningWord, string.intValue-1);
        }
        else
            NSLog(@"Error string.intValue < 1  ");
        statePreviosLink = AVStatusPreviosMeaningEng;
        return;
    }

#pragma mark - Previos English Word and string is number Roma and  current status dont ending meanining
    if(statePreviosLink == AVStatusPreviosMeaningEng && stateCurrentDefineString == AVDefineStringNumberRom && currentStateBuildingObject == AVCurrentStateBuildingBegin){
        setIndexPathLocal(objEngWord.indexPathMeaningWord, [string makeNumFromRomaNum]);
        statePreviosLink = AVStatusPreviosNumberRom;
        currentStateBuildingObject = AVCurrentStateBuildingObjectGlobal;
        return;
    }

#pragma mark - String is squarte brackspase

    if ( stateCurrentDefineString == AVDefineStringSquareBrackets){
        objEngWord.engTranscript = string;
        currentStateBuildingObject = AVCurrentStateBuildingObjectGlobal;
        statePreviosLink = AVStatusPreviosTranscript;
        return;
    }else if(stateCurrentDefineString == AVDefineStringSquareBrackets)
         NSLog(@"Error squarte bracket  ");

#pragma mark - Previos transcript or english grammatic   and string is English and curent state Build is AVCurrentStateBuildingBaseObject

    if((statePreviosLink == AVStatusPreviosTranscript || statePreviosLink == AVStatusPreviosGrammaticEng)  && stateCurrentDefineString == AVDefineStringEng && currentStateBuildingObject == AVCurrentStateBuildingObjectGlobal){

        if([managerShortWords.arrayShortWordGrammaticProperty containsObject:string]){
            objEngWord.grammaticType = [objEngWord.grammaticType arrayByAddingObject:string];
            statePreviosLink = AVStatusPreviosGrammaticEng;
            return;

        }else
             NSLog(@"Error Previos transcript or english grammatic   and string is English and curent state Build is AVCurrentStateBuildingBaseObject  ");
    }

#pragma mark - Previos transcript or english grammatic  and string is English with ending comma and curent state Build is AVCurrentStateBuildingBaseObject

    if((statePreviosLink == AVStatusPreviosTranscript || statePreviosLink == AVStatusPreviosGrammaticEng)  && stateCurrentDefineString == AVDefineStringEngWithCommaAtEnding  && currentStateBuildingObject == AVCurrentStateBuildingObjectGlobal){

        if([managerShortWords.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbolIfSibolComma]]){
            objEngWord.grammaticType = [objEngWord.grammaticType arrayByAddingObject:[string stringWithoutLastSimbolIfSibolComma]];
            statePreviosLink = AVStatusPreviosGrammaticEng;
            return;
        }else
            NSLog(@"Error Previos transcript or english grammatic  and string is English with ending comma and curent state Build is AVCurrentStateBuildingBaseObject  ");
    }

#pragma mark - Previos english grammatic  and string is round and curent state Build is AVCurrentStateBuildingBaseObject

    if((statePreviosLink == AVStatusPreviosTranscript || statePreviosLink == AVStatusPreviosGrammaticEng || statePreviosLink == AVStatusPreviosRoundBrackets)  && stateCurrentDefineString == AVDefineStringRoundBrackets &&
       currentStateBuildingObject == AVCurrentStateBuildingObjectGlobal){

        statePreviosLink = AVStatusPreviosRoundBrackets;
        if(![string containsString:@"обычно"] && [string containsString:@"множ.число"]){
            objEngWord.grammaticForm = [objEngWord.grammaticForm arrayByAddingObject:string];
            return;
        }

        NSMutableCharacterSet*set = [[NSMutableCharacterSet alloc]init];
        [set addCharactersInString:@"(),; "];
        NSArray*arraySeparatedString = [string componentsSeparatedByCharactersInSet:set];
        BOOL isEqualSeparatedStringInBracetsWithEnglishPredlog = NO;
        for(NSString* oneSeparatedString in arraySeparatedString){
            for(NSString *oneStringFromManagerEngPredlog in self.managerMeaningShort.arrayEngPredlog){
                if([oneSeparatedString isEqualToString:oneStringFromManagerEngPredlog])
                    isEqualSeparatedStringInBracetsWithEnglishPredlog = YES;  //разделяем стринг и проверяем каждую часть на вхождение в массив предлогов
            }
        }
        if(isEqualSeparatedStringInBracetsWithEnglishPredlog){
            NSString *stringAccessoryWithPredlog = [ @"сочетание с " stringByAppendingString: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol]];
            objEngWord.additionBase = [objEngWord.additionBase arrayByAddingObject:stringAccessoryWithPredlog];
            return;
        }

        if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && ![string isContaintRusChars] && [string isContaintEngChars]){
            objEngWord.grammaticForm = [objEngWord.grammaticForm arrayByAddingObject:string];
            statePreviosLink = AVStatusPreviosRoundBrackets;
            return;
        }
        if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && ![string isContaintEngChars]){
            objEngWord.additionBase = [objEngWord.additionBase arrayByAddingObject:string];
            return;
        }
        if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && [string isContaintEngChars]){
            objEngWord.additionBase = [objEngWord.additionBase arrayByAddingObject:string];
            return;
        }

            NSLog(@"Error Previos english grammatic  and string is round and curent state Build is AVCurrentStateBuildingBaseObject  ");
    }

#pragma mark - Previos english grammatic or round brackets or transcription  and string is inter in arrayShortRusProperty and curent state Build is AVCurrentStateBuildingBaseObject

    if((statePreviosLink == AVStatusPreviosTranscript || statePreviosLink == AVStatusPreviosGrammaticEng || statePreviosLink == AVStatusPreviosRoundBrackets )
       && (stateCurrentDefineString == AVDefineStringRus )
       && currentStateBuildingObject == AVCurrentStateBuildingObjectGlobal){
            if([self.managerMeaningShort.arrayShortRusProperty containsObject:string]){
                statePreviosLink = AVStatusPreviosAdditionBase;
                objEngWord.additionBase =  [objEngWord.additionBase arrayByAddingObject:string];
                return;
            }
    }

    if((statePreviosLink == AVStatusPreviosTranscript || statePreviosLink == AVStatusPreviosGrammaticEng || statePreviosLink == AVStatusPreviosRoundBrackets )
       && (stateCurrentDefineString == AVDefineStringRusWithCommaAtEnding)
       && currentStateBuildingObject == AVCurrentStateBuildingObjectGlobal){
        if([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbolIfSibolComma]]){
            statePreviosLink = AVStatusPreviosAdditionBase;
            objEngWord.additionBase = [objEngWord.additionBase arrayByAddingObject: [string stringWithoutLastSimbol]];
            return;
        }
    }

#pragma mark - Previos english grammatic or round brackets or transcription  and string isEqual "pl" or "past" ... "=" ... "от" and curent state Build is AVCurrentStateBuildingBaseObject

    if(stateCurrentDefineString == AVDefineStringDerevative
       && currentStateBuildingObject == AVCurrentStateBuildingDerevativeObjectGlobal){
        objEngWord.dereviative = [objEngWord.dereviative stringByAppendingFormat:@" %@",string];
        return;
    }

#pragma mark - state building is Lokal

        // проверить если ранее была цифра с : то пример (сделать еще один статус AVStatusPreviosTranscript) !!!

////   stoping ----------- на лат цифре!!!


}







#pragma mark - Check word at AVDefineString

-(AVDefineString)defineString:(NSString *)string{
//    const char* chars = string.UTF8String;
    BOOL flagEng = YES;
    BOOL flagRus = YES;

    if([string isEqualToString:@"I"] || [string isEqualToString:@"II"] || [string isEqualToString:@"III"] || [string isEqualToString:@"IV"] || [string isEqualToString:@"V"] || [string isEqualToString:@"VI"] || [string isEqualToString:@"VII"] || [string isEqualToString:@"VIII"]){
        return AVDefineStringNumberRom;
    }

    if(string.intValue)
        return AVDefineStringNumberLat;

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
