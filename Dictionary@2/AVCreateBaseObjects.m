//
//  AVCreateBaseObjects.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 26/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//
#define LLL  if(self.arrayEngWords.count > 0){AVEnglWord*ew = [self.arrayEngWords lastObject];NSLog(@"eng mean = %@",ew.engMeaningObject);NSLog(@"eng index = %@",ew.indexPathMeaningWord);NSLog(@"eng index = %@",ew.engTranscript);NSLog(@"eng index = %@",ew.grammaticForm);NSLog(@"eng index = %@",ew.arrayRusMeaning);NSLog(@"eng index = %@",ew.arrayPhrasalVerb);}


#import "AVCreateBaseObjects.h"

typedef NS_ENUM(NSInteger, AVState) {
        AVStateBegin = 0,
        AVStateWork,
        AVStateEnd
};

    typedef NS_ENUM(NSInteger, AVTypeObject) {
        AVTypeObjectSingle = 0,
        AVTypeObjectCompose,
        AVTypeObjectPhraseVerbSingle,
        AVTypeObjectPhraseVerbCompose
    };

    typedef NS_ENUM(NSInteger, AVStringType) {

        AVStringTypeInition = 0,

        AVStringTypeEng = (1 << 0),
        AVStringTypeRus = (1 << 1),

        AVStringTypeSquareBrackets = (1 << 2),
        AVStringTypeParenthesis = (1 << 3),
        AVStringTypeParenthesisWithEndSimbol = (1 << 4),

        AVStringTypeEndComma = (1 << 5),
        AVStringTypeEndPoint = (1 << 6),
        AVStringTypeEndSemicolon = (1 << 7),
        AVStringTypeEndColon = (1 << 8),
        AVStringTypeEndDash = (1 << 9),
        AVStringTypeEndNum = (1 << 10),

        AVStringTypeEngEndNumberLatWithColon = (1 << 11),
        AVStringTypeEngEndNumberLat = (1 << 12),

        AVStringTypeEngEndNumberRoma = (1 << 13),

        AVStringTypeNumberLatWithEndColon = (1 << 14),

        AVStringTypeNumberLatClearLess34 = (1 << 15),
        AVStringTypeNumberLatClearMore33 = (1 << 16),
        AVStringTypeNumberRom = (1 << 17),

        AVStringTypeMarkIdiom = (1 << 18),
        AVStringTypeMarkPhraseVerb = (1 << 19),

        AVStringTypeDash = (1 << 20),
        AVStringTypeEquality = 1 << 21,

        AVStringTypeAtEndWhitespace = (1 << 22)
    };



@interface AVCreateBaseObjects ()
    {
    NSArray<AVEnglWord*>*tempArrayEngWords;
    AVStringType typeString;
    AVTypeObject typeObject;
    AVPhrasalVerb *phrasalVerb;
    AVRusMeaning *rusMeaningObject;
    AVExample*example;
    int numberObjectJ;

    NSMutableArray<NSString *> * arrayIdiomTemp;
    NSMutableArray<NSString *> * arrayRusMean;
    AVExample*tempExample;

    //flags

    AVState engMeaning;
    AVState engTranscript;
    AVState accessory;
    AVState grammatic;
    AVState dereviative;
    AVState grammaticForm;
    AVState rusMeaning;
    AVState arrayIdiom;
    AVState arrayExample;

    BOOL checkPrint;

    }

    @end

@implementation AVCreateBaseObjects

#pragma mark - Print Object

-(void)printArrayObject:(NSArray*)array andSelectRow:(int)row{
    int i = 0;
    for(NSString*str in array){
        if([str isEqualToString:@" "])
            NSLog(@"------------------------------- ");
        else if(i == row)
            NSLog(@"-----------------------------------------------%@",str);
        else
            NSLog(@"----%@",str);
        i++;
    }
}

#pragma mark - set inithinal meaning

    -(void)setBeginMeaning{

        self.arrayEngWords = [NSArray new];
        self.managerMeaningShort = [AVMeaningShortWords sharedShortWords];
        self.manager = [AVMainManager managerData];
        tempArrayEngWords = [NSArray new];
        numberObjectJ = 0;
        engMeaning = engTranscript = accessory = grammatic = dereviative = grammaticForm = rusMeaning = arrayIdiom = arrayExample = AVStateBegin;

    }

#pragma mark - Cycle Objects

-(NSArray<AVEnglWord*>*)makeArrayEngFromMainArrayAtArrayWords: (NSArray*)mainArray{

    [self setBeginMeaning];
    for(NSArray*array in mainArray){
        if(numberObjectJ == 10 ){
            break;
        }
        checkPrint = NO;
        typeObject = [self typeForArray:array];
        if(typeObject == AVTypeObjectSingle){
            [self makeEngObjTypeSingle:array];
            AVEnglWord*ew = [self.arrayEngWords lastObject];
            //[ew printObject:numberObjectJ];
            [ew insteadShortWord];
            [ew insteadShortWord];
            [ew deleteSemicolon];
            [ew instadEtc];
            //[ew printObject:numberObjectJ];


        }else if(typeObject == AVTypeObjectCompose){
            [self makeEngObjTypeCompose:array];
            AVEnglWord*ew = [self.arrayEngWords lastObject];
            //[ew printObject:numberObjectJ];
            [ew insteadShortWord];
            [ew insteadShortWord];
            [ew deleteSemicolon];
            [ew instadEtc];
            //[ew printObject:numberObjectJ];


        }else if(typeObject == AVTypeObjectPhraseVerbSingle){
            [self makePhraseVerbSingle:array];
            AVEnglWord*ew = [self.arrayEngWords lastObject];
            //[ew printObject:numberObjectJ];
            [ew insteadShortWord];
            [ew insteadShortWord];
            [ew deleteSemicolon];
            [ew instadEtc];
            //[ew printObject:numberObjectJ];


        }else if(typeObject == AVTypeObjectPhraseVerbCompose){
            [self makePhraseVerbCompose:array];
            AVEnglWord*ew = [self.arrayEngWords lastObject];
            //[ew printObject:numberObjectJ];
            [ew insteadShortWord];
            [ew insteadShortWord];
            [ew deleteSemicolon];
            [ew instadEtc];
            //[ew printObject:numberObjectJ];


        }else{
            NSLog(@"error type object");
        }


//
//        if(checkPrint){
//
//        }
//        if(numberObjectJ == 100000)
//            break;
//
//        if(numberObjectJ == 100000){
//            AVEnglWord*ew = [self.arrayEngWords lastObject];
//            [ew printObject:numberObjectJ];
//        }

        numberObjectJ++;
    }

    return self.arrayEngWords;
}

#pragma mark - define Type Object

-(AVTypeObject)typeForArray:(NSArray *)array{
    if([array[0] isEqualToString:@"[■]"]){
        for(NSString *string in array){
            if( ([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2) ){
                return AVTypeObjectPhraseVerbCompose;
            }
            if( ( ([string intValue] > 0 && [string intValue] < 10 && string.length == 2) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 3) ) &&
               [[string lastCharString] isEqualToString:@":"] ){
                return AVTypeObjectPhraseVerbCompose;
            }
        }
        return AVTypeObjectPhraseVerbSingle;
    }

    for(NSString *string in array){
        if( ([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2) ){
            return AVTypeObjectCompose;
        }
        if( ( ([string intValue] > 0 && [string intValue] < 10 && string.length == 2) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 3) ) &&
           [[string lastCharString] isEqualToString:@":"] ){
            return AVTypeObjectCompose;
        }
    }
    return AVTypeObjectSingle;
}

#pragma mark - define Type String

-(AVStringType)defineString:(NSString *)string{

    AVStringType type = AVStringTypeInition;

    if([string isEqualToString:@"◊"])
        type = type | AVStringTypeMarkIdiom;

    if([string isEqualToString:@"="])
        type = type | AVStringTypeEquality;

    if([string isEqualToString:@"–"]  || [string isEqualToString:@"—"] || [string isEqualToString:@"-"])
        type = type | AVStringTypeDash;

    if([string isEqualToString:@"I"] || [string isEqualToString:@"II"] || [string isEqualToString:@"III"] || [string isEqualToString:@"IV"] || [string isEqualToString:@"V"] || [string isEqualToString:@"VI"] || [string isEqualToString:@"VII"] || [string isEqualToString:@"VIII"]){
        type = type | AVStringTypeNumberRom;
    }

    if( ([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2))
        type = type | AVStringTypeNumberLatClearLess34;

    if([string intValue] > 33)
        type = type | AVStringTypeNumberLatClearMore33;

    if( ( ([string intValue] > 0 && [string intValue] < 10 && string.length == 2) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 3) ) &&
       [[string lastCharString] isEqualToString:@":"])
       type = type | AVStringTypeNumberLatWithEndColon;

    if([[string firstCharString] isEqualToString:@"["] && [[string lastCharString] isEqualToString:@"]"])
       type = type | AVStringTypeSquareBrackets;

    if([[string firstCharString] isEqualToString:@"("] && [[string lastCharString] isEqualToString:@")"])
        type = type | AVStringTypeParenthesis;

    if([[string firstCharString] isEqualToString:@"("] && [[string charStringAtNumber: (int)string.length - 2] isEqualToString:@")"])
        type = type | AVStringTypeParenthesisWithEndSimbol;

    for(int i = 0; i < string.length; i++){

        int ch = [string charIntAtNumber:i];

        if( (ch > 64 && ch < 123) && !(ch == 91 || ch == 92 || ch == 93 || ch == 94 || ch == 95 || ch == 96))
            type = type | AVStringTypeEng;
         if(  (ch >= 1040 && ch <= 1103) || (ch == 1025 || ch == 1105))
            type = type | AVStringTypeRus;
    }

    NSString *strLastChar = [string lastCharString];
    NSString *strLastChar2 = (string.length > 1) ? [string substringWithRange:NSMakeRange(string.length - 2, 2)] : @" ";
    NSString *strLastChar3 = (string.length > 2) ? [string substringWithRange:NSMakeRange(string.length - 3, 3)] : @" ";
    NSString *strLastChar4 = (string.length > 3) ? [string substringWithRange:NSMakeRange(string.length - 4, 4)] : @" ";

        if([strLastChar integerValue] > 0)
            type = type | AVStringTypeEndNum;
        else if([strLastChar isEqualToString:@","])
            type = type | AVStringTypeEndComma;
        else if([strLastChar isEqualToString:@";"])
            type = type | AVStringTypeEndSemicolon;
        else if([strLastChar isEqualToString:@"."])
            type = type | AVStringTypeEndPoint;
        else if([strLastChar isEqualToString:@"-"])
            type = type | AVStringTypeEndDash;
        else if([strLastChar isEqualToString:@":"])
            type = type | AVStringTypeEndColon;
        else if( ([strLastChar isEqualToString:@"I"] || [strLastChar2 isEqualToString:@"II"] || [strLastChar3 isEqualToString:@"III"] || [strLastChar2 isEqualToString:@"IV"] || [strLastChar isEqualToString:@"V"] || [strLastChar2 isEqualToString:@"VI"] ||
                  [strLastChar3 isEqualToString:@"VII"] || [strLastChar4 isEqualToString:@"VIII"] || [strLastChar2 isEqualToString:@"IX"] || [strLastChar isEqualToString:@"X"]) ){
            type = type | AVStringTypeEngEndNumberRoma;
        }

        if(type == (AVStringTypeEndNum | AVStringTypeEng) )
            type = type | AVStringTypeEngEndNumberLat;

    if(type ==  AVStringTypeInition && [[string lastCharString] isEqualToString:@" "])
        type = AVStringTypeAtEndWhitespace;


    return type;
}


#pragma mark - building Single object


-(void)makeEngObjTypeSingle:(NSArray*) array{

    AVEnglWord*objectEng = [[AVEnglWord alloc] init];
    self.arrayEngWords = [self.arrayEngWords arrayByAddingObject:objectEng];
    rusMeaningObject = [[AVRusMeaning alloc]init];
    objectEng.arrayRusMeaning = [objectEng.arrayRusMeaning arrayByAddingObject:rusMeaningObject];
    engMeaning = engTranscript = accessory = grammatic = dereviative = grammaticForm = rusMeaning = arrayIdiom = arrayExample = AVStateBegin;


#pragma mark - cycle Begin



    for(int numString = 0; numString < array.count; numString++){

        if(numberObjectJ == 8707 && numString == 5){
            numString = numString;
        }

        NSString * string = array[numString];

        if([string isEqualToString:@"текст"]){
            
        }

        if(!string || [string isEqualToString:@""] || [string isEqualToString:@" "])
            continue;

        AVStringType typeString = [self defineString:string];

#pragma mark - Exeption

        if( (numberObjectJ == 886 || numberObjectJ == 15022 || numberObjectJ == 17518) && numString == 0 ){
            arrayRusMean = [NSMutableArray arrayWithObject:@""];
        }

        if( (numberObjectJ == 886 || numberObjectJ == 15022 || numberObjectJ == 17518) && engTranscript == AVStateEnd ){
            NSString* tempString = [[arrayRusMean lastObject] stringByAppendingFormat:@" %@",string];
            [arrayRusMean replaceObjectAtIndex:arrayRusMean.count -1 withObject:tempString];
            rusMeaningObject.arrayMeaning = [NSArray arrayWithArray:arrayRusMean];
            continue;
        }



#pragma mark - Derevative Continios
        if(dereviative == AVStateWork){
            NSString *stringDer = (typeString & ( AVStringTypeEndComma | AVStringTypeEndPoint | AVStringTypeEndSemicolon)) ? [string stringWithoutLastSimbol] :string;
            rusMeaningObject.dereviative = [rusMeaningObject.dereviative stringByAppendingFormat:@" %@",stringDer];
            continue;
        }

#pragma mark - Idiom

        if(arrayIdiom == AVStateWork){

            if( (typeString & AVStringTypeEng) && ([array[numString-1] isContaintRusChars]) ){
                [arrayIdiomTemp addObject:[NSString new]];
            }

            if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] || ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
               (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) )
               ){
                NSString *stringTemp = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                [NSString stringWithFormat:@"(%@) %@",string, [arrayIdiomTemp lastObject]]:
                [NSString stringWithFormat:@"(%@) %@",[string stringWithoutLastSimbol], [arrayIdiomTemp lastObject]];

                [arrayIdiomTemp replaceObjectAtIndex:arrayIdiomTemp.count - 1 withObject:stringTemp];
                objectEng.arrayIdiom = [NSArray arrayWithArray:arrayIdiomTemp];
                continue;

            }

            NSString *stringTemp = (!(typeString & AVStringTypeEndSemicolon)) ? [[arrayIdiomTemp lastObject] stringByAppendingString:[NSString stringWithFormat:@" %@",string]] :
            [[arrayIdiomTemp lastObject] stringByAppendingString:[NSString stringWithFormat:@" %@",[string stringWithoutLastSimbol]]];

            [arrayIdiomTemp replaceObjectAtIndex:arrayIdiomTemp.count - 1 withObject:stringTemp];
            objectEng.arrayIdiom = [NSArray arrayWithArray:arrayIdiomTemp];
            continue;
        }

        if(typeString & AVStringTypeMarkIdiom){
            arrayIdiom = AVStateWork;
            arrayIdiomTemp = [NSMutableArray arrayWithObject:[NSString new]];
            continue;
        }


#pragma mark - English Meaning

        if( engMeaning == AVStateBegin || engMeaning == AVStateWork){
            if( (typeString & AVStringTypeEng) & !(typeString & AVStringTypeEngEndNumberLat) & !(typeString & AVStringTypeSquareBrackets) & !(typeString & AVStringTypeEngEndNumberRoma)){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",string];
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }
            if(typeString & AVStringTypeEngEndNumberLat){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",[string stringWithoutLastSimbol]];
                objectEng.indexPathMeaningWord = setIndexPathGlobal(objectEng.indexPathMeaningWord, [[string lastCharString] intValue]);
                continue;
            }
            if( (typeString & AVStringTypeEngEndNumberRoma) && !(typeString & AVStringTypeNumberRom) ){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",[string stringWithoutAtEndRomaNum]];
                objectEng.indexPathMeaningWord = setIndexPathLocal(objectEng.indexPathMeaningWord, [string makeDefaneNumFromRomaNumAtEndEngWord]);
                continue;
            }
        }

#pragma mark - Roma Number

        if(engMeaning == AVStateWork && (typeString & AVStringTypeNumberRom) ){
            objectEng.indexPathMeaningWord = setIndexPathLocal(objectEng.indexPathMeaningWord, [string makeNumFromRomaNum]);
            continue;
        }

#pragma mark - Transcription

        if(engMeaning == AVStateWork && (typeString & AVStringTypeSquareBrackets) ){
            objectEng.engTranscript = string;
            engMeaning = AVStateEnd;
            engTranscript = AVStateEnd;
            continue;
        }

#pragma mark - derevative

        if(([string isEqualToString:@"pl"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"superl"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"compare"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"compar"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"и"]) ||
           ([string isEqualToString:@"p"] && [array[numString+1] isEqualToString:@"p"] && [array[numString+2] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"косв"] && [array[numString+1] isEqualToString:@"падеж"] && [array[numString+2] isEqualToString:@"от"]) ||
            [string isEqualToString:@"="]){
            rusMeaningObject.dereviative = string;
            dereviative = AVStateWork;
            continue;
        }

#pragma mark - Grammatic

        if( (typeString & AVStringTypeEng)  && !(typeString & AVStringTypeParenthesis) && !(typeString & AVStringTypeRus) ){

            if( (typeString & AVStringTypeEndColon) && [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol] ] ) {

                objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:[string stringWithoutLastSimbol]];
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
                continue;
            }
        }

        if( (typeString & AVStringTypeEng)  && !(typeString & AVStringTypeParenthesis) && !(typeString & AVStringTypeRus) &&
           (engTranscript == AVStateEnd || grammatic == AVStateWork || accessory == AVStateWork) ){

            if( typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndDash) ) {

                if([self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol]]){
                    objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:[string stringWithoutLastSimbol]];
                    grammatic = AVStateWork;
                    continue;
                }
            }else{
                if( [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:string] ){

                    objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:string];
                    grammatic = AVStateWork;

                    continue;
                }

            }
        }

#pragma mark - Accessory brackets && dont Example

        if( (typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)) &&
           !(arrayExample == AVStateWork) && !(arrayIdiom == AVStateWork)  && !(rusMeaning == AVStateWork)){

            if(![string containsString:@"обычно"] && [string containsString:@"множ.число"]){
                objectEng.grammaticForm = [objectEng.grammaticForm arrayByAddingObject:string];
                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
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
                NSString *stringAccessoryWithPredlog = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [ @"сочетание: " stringByAppendingString: [[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol] ]:
                [ @"сочетание: " stringByAppendingString: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];
                rusMeaningObject.accessory = [rusMeaningObject.accessory arrayByAddingObject:stringAccessoryWithPredlog];
                accessory = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && (typeString & AVStringTypeEng) && !(typeString & AVStringTypeRus) ){
                objectEng.grammaticForm = (typeString & AVStringTypeParenthesisWithEndSimbol) ? [objectEng.grammaticForm arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]] :
                                                                                                               [objectEng.grammaticForm arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];

                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && ![string isContaintEngChars]){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ? [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]];
                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }
            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && [string isContaintEngChars]){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ? [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[ [string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];
                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            NSLog(@"Error Previos english grammatic  and string is round and curent state Build is AVCurrentStateBuildingBaseObject  ");
        }


#pragma mark - Rus accessory

        if( ([self.managerMeaningShort.arrayShortRusProperty containsObject:string]) &&
           (grammatic == AVStateWork || grammaticForm == AVStateWork || accessory == AVStateWork || rusMeaning == AVStateBegin || rusMeaning == AVStateWork)
          ){
           rusMeaningObject.accessory =  [rusMeaningObject.accessory arrayByAddingObject:string];
            accessory = AVStateWork;

           continue;
       }

        if( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
           (grammatic == AVStateWork || grammaticForm == AVStateWork || accessory == AVStateWork || rusMeaning == AVStateBegin || rusMeaning == AVStateWork) &&
           (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))
           ){
            rusMeaningObject.accessory =  [rusMeaningObject.accessory arrayByAddingObject:[string stringWithoutLastSimbol]];
            accessory = AVStateWork;
            if(typeString & AVStringTypeEndColon){
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }

            continue;
        }

        if( rusMeaning == AVStateWork && (typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol) ) ){

            rusMeaningObject.accessory = ( typeString & AVStringTypeParenthesisWithEndSimbol ) ? [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol] ] :
            [rusMeaningObject.accessory arrayByAddingObject: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];

            accessory = AVStateWork;

            if(typeString & AVStringTypeEndColon){
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }
            if(typeString & AVStringTypeEndSemicolon && numString < array.count - 1){
                    if([array[numString+1] isContaintRusChars])
                        [arrayRusMean addObject:@""];
            }

            continue;
        }




#pragma mark -  Status Rus Meaning OR Example

        if(rusMeaning == AVStateWork && arrayExample == AVStateBegin && !(typeString & AVStringTypeRus) && [array[numString-1] isContaintRusChars]){
            arrayExample = AVStateWork;
            rusMeaning = AVStateEnd;
            rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
            tempExample = rusMeaningObject.arrayExample.lastObject;
        }

        if( (engMeaning  == AVStateEnd && engTranscript == AVStateEnd && rusMeaning == AVStateBegin ) &&
           (  typeString & (AVStringTypeRus | AVStringTypeEngEndNumberRoma) ) ) {
                rusMeaning = AVStateWork;
                arrayRusMean = [NSMutableArray arrayWithArray: @[[NSString new]]];
        }

#pragma mark - Example

        if( arrayExample ==AVStateWork){

            if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] && !([tempExample.meaning isEqual:@""] && [tempExample.accessory isEqual:@""]) &&
               !([[array[numString-1] firstCharString] isEqualToString:@"("]) ){
                 rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                 tempExample = rusMeaningObject.arrayExample.lastObject;
            }

            else if(typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)){
                 tempExample.accessory = (typeString & AVStringTypeParenthesis) ? [tempExample.accessory stringByAppendingFormat:@" %@",[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]] :
                 [tempExample.accessory stringByAppendingFormat:@" %@",[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]];
             }

            else if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] || ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
                 (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) ) ){

                 NSString *stringTemp = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                 [NSString stringWithFormat:@"%@ %@",string, tempExample.accessory] :
                 [NSString stringWithFormat:@"%@ %@",[string stringWithoutLastSimbol], tempExample.accessory];
                 tempExample.accessory = stringTemp;
             }

            else
                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];

             if( typeString & AVStringTypeEndSemicolon){
                 rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                 tempExample = rusMeaningObject.arrayExample.lastObject;
             }

            continue;
        }

#pragma mark - Rus Meaning

        if( rusMeaning == AVStateWork){
                NSString* tempString = [[arrayRusMean lastObject] stringByAppendingFormat:@" %@",string];
                [arrayRusMean replaceObjectAtIndex:arrayRusMean.count -1 withObject:tempString];
                rusMeaningObject.arrayMeaning = [NSArray arrayWithArray:arrayRusMean];
            if(typeString & AVStringTypeEndSemicolon)
                [arrayRusMean addObject:[NSString new]];
                continue;
        }

//        NSLog(@"Dont! --- j = %d",numberObjectJ);
//        [self printArrayObject:array andSelectRow:numString];

#pragma mark - End cycle

    }

}

#pragma mark - Building compose object


-(void)makeEngObjTypeCompose:(NSArray*) array{


    AVEnglWord*objectEng = [[AVEnglWord alloc] init];
    self.arrayEngWords = [self.arrayEngWords arrayByAddingObject:objectEng];
    engMeaning = engTranscript = accessory = grammatic = dereviative = grammaticForm = rusMeaning = arrayIdiom = arrayExample = AVStateBegin;


#pragma mark - cycle Begin

    for(int numString = 0; numString < array.count; numString++){

        if(numberObjectJ == 9 && numString == 1){
            numString = numString;
        }

        NSString * string = array[numString];

        if([string isEqualToString:@"текст"]){

        }

        if([string containsString:@"л ед ч"]  || [string isEqualToString:@"л"]){

        }

       // NSLog(@"str = %@ ",string);

        if([string isEqualToString:@"aaaaaaaaa"]){

        }

        if(!string || [string isEqualToString:@""] || [string isEqualToString:@" "])
            continue;

        AVStringType typeString = [self defineString:string];

#pragma mark - check Nonstandart

        if( (engTranscript == AVStateWork || engMeaning == AVStateWork ) && [string isContaintRusChars] && !(typeString & AVStringTypeSquareBrackets))    //checking!!!
 //           NSLog(@"Nonstandart obj = %d",numberObjectJ);

#pragma mark - AccessoryStateWork

        if(accessory == AVStateWork){
            rusMeaningObject.accessory = (typeString & (AVStringTypeEndComma    |
                                                             AVStringTypeEndPoint      |
                                                             AVStringTypeEndSemicolon |
                                                             AVStringTypeEndColon      |
                                                             AVStringTypeEndDash ) ) ? [rusMeaningObject.accessory arrayByAddingObject:[string stringWithoutLastSimbol]] :
                                                                                           [rusMeaningObject.accessory arrayByAddingObject: string] ;

            if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
               ([self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] ||
                [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ||
                [self.managerMeaningShort.arrayEngPredlog containsObject:[array[numString + 1] stringWithoutLastSimbol] ] ||
                [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[array[numString + 1] stringWithoutLastSimbol] ])
               ){
                accessory = AVStateWork;
            }else
                accessory = AVStateBegin;

            if(typeString & AVStringTypeEndColon){
                arrayExample = AVStateWork;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }
            if(typeString & (AVStringTypeEndComma | AVStringTypeEndPoint | AVStringTypeEndSemicolon | AVStringTypeEndDash )){

            }
            continue;
        }

#pragma mark - Latine number

        if(typeString & AVStringTypeNumberLatClearLess34){

            rusMeaningObject = [[AVRusMeaning alloc]initForCompose];
            objectEng.arrayRusMeaning = [objectEng.arrayRusMeaning arrayByAddingObject:rusMeaningObject];

            engMeaning = engTranscript  = grammatic = grammaticForm = AVStateEnd;
            arrayExample = dereviative = rusMeaning = accessory = arrayIdiom = AVStateBegin;

            //setIndexPathCount([objectEng getAdressStr], string.intValue);
            if(numString < array.count -1){
                BOOL isNextWordRus = [array[numString+1] isContaintRusChars];
                BOOL isNextWordEng = [array[numString+1] isContaintEngChars];
                if(isNextWordRus && !isNextWordEng){
                    rusMeaning = AVStateWork;
                }

                if( [[array[numString+1] firstCharString] isEqualToString:@"="]){
                    
                }

                if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
                   ![self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] &&
                   ![self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ){
                    rusMeaning = AVStateEnd;
                    arrayExample = AVStateWork;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }

                if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
                   ([self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] ||
                   [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ||
                   [self.managerMeaningShort.arrayEngPredlog containsObject:[array[numString + 1] stringWithoutLastSimbol] ] ||
                   [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[array[numString + 1] stringWithoutLastSimbol] ])
                   ){
                       accessory = AVStateWork;
                }

                if(typeString & AVStringTypeNumberLatClearMore33){
                    NSLog(@"error type string - number!");
                }
            }

            continue;
        }

        if(typeString & AVStringTypeNumberLatWithEndColon ){

            rusMeaningObject = [[AVRusMeaning alloc]init];
            objectEng.arrayRusMeaning = [objectEng.arrayRusMeaning arrayByAddingObject:rusMeaningObject];

            engMeaning = engTranscript  = grammatic = grammaticForm = AVStateEnd;
            arrayExample = dereviative = rusMeaning = accessory = arrayIdiom = AVStateBegin;

            //setIndexPathCount([objectEng getAdressStr], [string stringWithoutLastSimbol].intValue);

            arrayExample = AVStateWork;

            rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];

            tempExample = rusMeaningObject.arrayExample.lastObject;
            continue;
        }

#pragma mark - Derevative Continios
        if(dereviative == AVStateWork){

            NSString *stringDer = (typeString & ( AVStringTypeEndComma | AVStringTypeEndPoint | AVStringTypeEndSemicolon)) ? [string stringWithoutLastSimbol] :string;
            rusMeaningObject.dereviative = [rusMeaningObject.dereviative stringByAppendingFormat:@" %@",stringDer];
            if(typeString & AVStringTypeEndColon){
                dereviative = AVStateBegin;
                arrayExample = AVStateWork;
            }
            continue;
        }

#pragma mark - Idiom

        if(arrayIdiom == AVStateWork){

            if( (typeString & AVStringTypeEng) && ([array[numString-1] isContaintRusChars]) ){
                [arrayIdiomTemp addObject:[NSString new]];
            }

            if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] || ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
                                                                                           (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) )
               ){
                NSString *stringTemp = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                [NSString stringWithFormat:@"(%@) %@",string, [arrayIdiomTemp lastObject]]:
                [NSString stringWithFormat:@"(%@) %@",[string stringWithoutLastSimbol], [arrayIdiomTemp lastObject]];

                [arrayIdiomTemp replaceObjectAtIndex:arrayIdiomTemp.count - 1 withObject:stringTemp];
                objectEng.arrayIdiom = [NSArray arrayWithArray:arrayIdiomTemp];
                continue;

            }

            NSString *stringTemp = (!(typeString & AVStringTypeEndSemicolon)) ? [[arrayIdiomTemp lastObject] stringByAppendingString:[NSString stringWithFormat:@" %@",string]] :
            [[arrayIdiomTemp lastObject] stringByAppendingString:[NSString stringWithFormat:@" %@",[string stringWithoutLastSimbol]]];

            [arrayIdiomTemp replaceObjectAtIndex:arrayIdiomTemp.count - 1 withObject:stringTemp];
            objectEng.arrayIdiom = [NSArray arrayWithArray:arrayIdiomTemp];
            continue;
        }

        if(typeString & AVStringTypeMarkIdiom){
            arrayIdiom = AVStateWork;
            arrayIdiomTemp = [NSMutableArray arrayWithObject:[NSString new]];
            continue;
        }


#pragma mark - English Meaning

        if( engMeaning == AVStateBegin || engMeaning == AVStateWork){
            if( (typeString & AVStringTypeEng) & !(typeString & AVStringTypeEngEndNumberLat) & !(typeString & AVStringTypeSquareBrackets) & !(typeString & AVStringTypeEngEndNumberRoma)){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",string];
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }
            if(typeString & AVStringTypeEngEndNumberLat){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",[string stringWithoutLastSimbol]];
                objectEng.indexPathMeaningWord = setIndexPathGlobal(objectEng.indexPathMeaningWord, [[string lastCharString] intValue]);
                continue;
            }
            if( (typeString & AVStringTypeEngEndNumberRoma) && !(typeString & AVStringTypeNumberRom) ){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",[string stringWithoutAtEndRomaNum]];
                objectEng.indexPathMeaningWord = setIndexPathLocal(objectEng.indexPathMeaningWord, [string makeDefaneNumFromRomaNumAtEndEngWord]);
                continue;
            }
        }

#pragma mark - Roma Number

        if(engMeaning == AVStateWork && (typeString & AVStringTypeNumberRom) ){
            objectEng.indexPathMeaningWord = setIndexPathLocal(objectEng.indexPathMeaningWord, [string makeNumFromRomaNum]);
            continue;
        }

#pragma mark - Transcription

        if(engMeaning == AVStateWork && (typeString & AVStringTypeSquareBrackets) ){
            objectEng.engTranscript = string;
            engMeaning = AVStateEnd;
            engTranscript = AVStateWork;
            continue;
        }

#pragma mark - derevative

        if(([string isEqualToString:@"pl"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"superl"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"compare"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"compar"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"и"]) ||
           ([string isEqualToString:@"p"] && [array[numString+1] isEqualToString:@"p"] && [array[numString+2] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"косв"] && [array[numString+1] isEqualToString:@"падеж"] && [array[numString+2] isEqualToString:@"от"]) ||
           [string isEqualToString:@"="]){
            rusMeaningObject.dereviative = string;
            dereviative = AVStateWork;
            accessory = AVStateBegin;
            continue;
        }

#pragma mark - Grammatic

        if( (typeString & AVStringTypeEng)  && !(typeString & AVStringTypeParenthesis) && !(typeString & AVStringTypeRus) && !(grammatic == AVStateEnd) ){

            if( (typeString & AVStringTypeEndColon) && [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol] ] ) {

                objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:[string stringWithoutLastSimbol]];
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
                continue;
            }
        }

        if( (typeString & AVStringTypeEng)  && !(typeString & AVStringTypeParenthesis) && !(typeString & AVStringTypeRus) &&
           (engTranscript == AVStateEnd || engTranscript == AVStateWork || grammatic == AVStateWork || accessory == AVStateWork) && !(grammatic == AVStateEnd) ){

            if( typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndDash) ) {

                if([self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol]]){
                    objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:[string stringWithoutLastSimbol]];
                    grammatic = AVStateWork;
                    engTranscript = AVStateEnd;
                    continue;
                }
            }else{
                if( [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:string] ){

                    objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:string];
                    grammatic = AVStateWork;
                    engTranscript = AVStateEnd;
                    continue;
                }

            }
        }

#pragma mark - Accessory brackets && dont Example

        if( (typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)) &&
           !(arrayExample == AVStateWork) && !(arrayIdiom == AVStateWork)  && !(rusMeaning == AVStateWork) ){

            if(![string containsString:@"обычно"] && [string containsString:@"множ.число"]){
                objectEng.grammaticForm = [objectEng.grammaticForm arrayByAddingObject:string];
                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
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
                NSString *stringAccessoryWithPredlog = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [ @"сочетание: " stringByAppendingString: [[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol] ]:
                [ @"сочетание: " stringByAppendingString: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];
                rusMeaningObject.accessory = [rusMeaningObject.accessory arrayByAddingObject:stringAccessoryWithPredlog];

                if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
                   ([self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] ||
                    [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ||
                    [self.managerMeaningShort.arrayEngPredlog containsObject:[array[numString + 1] stringWithoutLastSimbol] ] ||
                    [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[array[numString + 1] stringWithoutLastSimbol] ])
                   ){
                    accessory = AVStateWork;
                }


                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && (typeString & AVStringTypeEng) && !(typeString & AVStringTypeRus) && grammatic != AVStateEnd ){
                objectEng.grammaticForm = (typeString & AVStringTypeParenthesisWithEndSimbol) ? [objectEng.grammaticForm arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]] :
                [objectEng.grammaticForm arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];

                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && (typeString & AVStringTypeEng) && !(typeString & AVStringTypeRus) && grammatic == AVStateEnd ){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]];

                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && ![string isContaintEngChars]){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]];
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }
            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && [string isContaintEngChars]){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[ [string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            NSLog(@"Error Previos english grammatic  and string is round and curent state Build is AVCurrentStateBuildingBaseObject  ");
        }


#pragma mark - Rus accessory



        if([self.managerMeaningShort.arrayShortRusProperty containsObject:string]){
            if(arrayExample == AVStateWork)
                tempExample.accessory = [tempExample.accessory stringByAppendingFormat:@" %@",string];
            else
                rusMeaningObject.accessory =  [rusMeaningObject.accessory arrayByAddingObject:string];
            continue;
        }

        if( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]])  &&
//           (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) )
           (typeString & (AVStringTypeEndComma | AVStringTypeEndColon) )
           ){
            if(arrayExample == AVStateWork){
                tempExample.accessory = [tempExample.accessory stringByAppendingFormat:@" %@",[string stringWithoutLastSimbol]];
                if(typeString & AVStringTypeEndSemicolon){
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
            }
            else
                rusMeaningObject.accessory =  [rusMeaningObject.accessory arrayByAddingObject:[string stringWithoutLastSimbol]];

            if(typeString & AVStringTypeEndColon){

                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }
            if(typeString & AVStringTypeEndSemicolon){
                
            }
            continue;
        }

        if( rusMeaning == AVStateWork && (typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol) ) ){

            rusMeaningObject.accessory = ( typeString & AVStringTypeParenthesisWithEndSimbol ) ?
            [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol] ] :
            [rusMeaningObject.accessory arrayByAddingObject: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];

            if(typeString & AVStringTypeEndColon){
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }

            if( ((typeString & AVStringTypeEndSemicolon) || (typeString & AVStringTypeEndComma) ) && numString < array.count - 1){  ///???colon
                if([array[numString+1] isContaintRusChars]){
                    rusMeaningObject.arrayMeaning = [rusMeaningObject.arrayMeaning arrayByAddingObject:@""];
                }
            }

            continue;
        }


#pragma mark -  Status Rus Meaning OR Example

        if(rusMeaning == AVStateWork && arrayExample == AVStateBegin && !(typeString & AVStringTypeRus) && [array[numString-1] isContaintRusChars]){
            arrayExample = AVStateWork;
            rusMeaning = AVStateEnd;
            rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
            tempExample = rusMeaningObject.arrayExample.lastObject;
            if([rusMeaningObject.arrayMeaning.lastObject isEqualToString:@""]){
                NSMutableArray*arrayTemp = [NSMutableArray arrayWithArray:rusMeaningObject.arrayMeaning];
                [arrayTemp removeLastObject];
                rusMeaningObject.arrayMeaning = [NSArray arrayWithArray: arrayTemp];
            }
        }

        if( (engMeaning  == AVStateEnd && (engTranscript == AVStateEnd || engTranscript == AVStateWork)  && rusMeaning == AVStateBegin ) && // edit
           (  typeString & (AVStringTypeRus | AVStringTypeEngEndNumberRoma) ) ) {
            rusMeaning = AVStateWork;
            engTranscript = AVStateEnd;
        }

#pragma mark - Example

        if( arrayExample ==AVStateWork){

            if(typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)){
                tempExample.accessory = (typeString & AVStringTypeParenthesis) ? [tempExample.accessory stringByAppendingFormat:@" %@",[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]] :
                [tempExample.accessory stringByAppendingFormat:@" %@",[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]];
            }

            else if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] ||
                    ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
                    (typeString & (AVStringTypeEndComma | AVStringTypeEndColon) ) ) ) {

                tempExample.accessory = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                [NSString stringWithFormat:@"%@ %@",string, tempExample.accessory] :
                [NSString stringWithFormat:@"%@ %@",[string stringWithoutLastSimbol], tempExample.accessory];
            }
            else if( [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:string] ||
                    ( ([self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol]]) &&
                     (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) ) ) {

                        tempExample.accessory = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                        [NSString stringWithFormat:@"%@ %@",string, tempExample.accessory] :
                        [NSString stringWithFormat:@"%@ %@",[string stringWithoutLastSimbol], tempExample.accessory];
                    }
//            else if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] && !([tempExample.meaning isEqual:@""] && [tempExample.accessory isEqual:@""]) && !([[array[numString-1] firstCharString] isEqualToString:@"("]) && [[string lastCharString] isEqualToString:@";"] ){
//                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
//                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
//                tempExample = rusMeaningObject.arrayExample.lastObject;
//            }
//            else if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] &&
//                    !([tempExample.meaning isEqual:@""] && [tempExample.accessory isEqual:@""]) && !([[array[numString-1] firstCharString] isEqualToString:@"("]) &&
//                    ![[string lastCharString] isEqualToString:@";"]){
//
//                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
//                tempExample = rusMeaningObject.arrayExample.lastObject;
//                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
//            }

            else
                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];

            if( typeString & AVStringTypeEndSemicolon){
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }

            continue;
        }


//        if( arrayExample ==AVStateWork){
//
//            if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] && !([tempExample.meaning isEqual:@""] && [tempExample.accessory isEqual:@""]) && !([[array[numString-1] firstCharString] isEqualToString:@"("]) && [[string lastCharString] isEqualToString:@";"] ){
//                    tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
//                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
//                    tempExample = rusMeaningObject.arrayExample.lastObject;
//            }
//
//            else if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] && !([tempExample.meaning isEqual:@""] &&
//            [tempExample.accessory isEqual:@""]) && !([[array[numString-1] firstCharString] isEqualToString:@"("]) && ![[string lastCharString] isEqualToString:@";"]){
////                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
////                    tempExample = rusMeaningObject.arrayExample.lastObject;
//                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
//            }
//
//            else if(typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)){
//                tempExample.accessory = (typeString & AVStringTypeParenthesis) ? [tempExample.accessory stringByAppendingFormat:@" %@",[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]] :
//                [tempExample.accessory stringByAppendingFormat:@" %@",[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]];
//            }
//
//            else if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] || ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
//                                                                                                (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) ) ){
//
//                NSString *stringTemp = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
//                [NSString stringWithFormat:@"%@ %@",string, tempExample.accessory] :
//                [NSString stringWithFormat:@"%@ %@",[string stringWithoutLastSimbol], tempExample.accessory];
//                tempExample.accessory = stringTemp;
//            }
//
//            else
//                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
//
//            if( typeString & AVStringTypeEndSemicolon){
//                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
//                tempExample = rusMeaningObject.arrayExample.lastObject;
//            }
//
//            continue;
//        }

#pragma mark - Rus Meaning

        if( rusMeaning == AVStateWork){

            NSString* tempString = [[rusMeaningObject.arrayMeaning lastObject] stringByAppendingFormat:@" %@",string];
            NSMutableArray* arrayTemp = [NSMutableArray arrayWithArray:rusMeaningObject.arrayMeaning];
            [arrayTemp removeLastObject];
            [arrayTemp addObject:[NSString stringWithString:tempString]];
            rusMeaningObject.arrayMeaning = [NSArray arrayWithArray:arrayTemp];

            if(typeString & AVStringTypeEndSemicolon)
                rusMeaningObject.arrayMeaning = [rusMeaningObject.arrayMeaning arrayByAddingObject:[NSString new]];
            continue;
        }

//        NSLog(@"Dont! --- j = %d",numberObjectJ);
//        checkPrint = YES;
//        [self printArrayObject:array andSelectRow:numString];

#pragma mark - End cycle

    }

    tempArrayEngWords = [tempArrayEngWords arrayByAddingObject:objectEng];

}


#pragma mark - building Single phraseVerb


-(void)makePhraseVerbSingle:(NSArray*) array{

    AVPhrasalVerb*objectEng = [[AVPhrasalVerb alloc] init];
    self.arrayEngWords = [self.arrayEngWords arrayByAddingObject:objectEng];
    rusMeaningObject = [[AVRusMeaning alloc]init];
    objectEng.arrayRusMeaning = [objectEng.arrayRusMeaning arrayByAddingObject:rusMeaningObject];
    engMeaning = engTranscript = accessory = grammatic = dereviative = grammaticForm = rusMeaning = arrayIdiom = arrayExample = AVStateBegin;


#pragma mark - cycle Begin



    for(int numString = 0; numString < array.count; numString++){

        if(numberObjectJ == 34905 && numString == 1){
            numString = numString;
        }

        NSString * string = array[numString];

        if([string isEqualToString:@"текст"]){

        }

        if([string isEqualToString:@"v"]){
            continue;
        }

        if(numString == 0){
            if([string isEqualToString:@"[■]"])
                continue;
            else
                NSLog(@"Error");
        }

        if(!string || [string isEqualToString:@""] || [string isEqualToString:@" "])
            continue;

        AVStringType typeString = [self defineString:string];

#pragma mark - check First Meaning Rus

        if([string isContaintRusChars] && engMeaning == AVStateWork && engTranscript == AVStateBegin){
            engMeaning = engTranscript = AVStateEnd;
//            rusMeaning = AVStateWork;
//            arrayRusMean = [NSMutableArray arrayWithArray: @[[NSString new]]];
        }


#pragma mark - Derevative Continios
        if(dereviative == AVStateWork){
            NSString *stringDer = (typeString & ( AVStringTypeEndComma | AVStringTypeEndPoint | AVStringTypeEndSemicolon)) ? [string stringWithoutLastSimbol] :string;
            rusMeaningObject.dereviative = [rusMeaningObject.dereviative stringByAppendingFormat:@" %@",stringDer];
            continue;
        }

#pragma mark - Idiom

        if(arrayIdiom == AVStateWork){

            if( (typeString & AVStringTypeEng) && ([array[numString-1] isContaintRusChars]) ){
                [arrayIdiomTemp addObject:[NSString new]];
            }

            if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] || ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
                                                                                           (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) )
               ){
                NSString *stringTemp = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                [NSString stringWithFormat:@"(%@) %@",string, [arrayIdiomTemp lastObject]]:
                [NSString stringWithFormat:@"(%@) %@",[string stringWithoutLastSimbol], [arrayIdiomTemp lastObject]];

                [arrayIdiomTemp replaceObjectAtIndex:arrayIdiomTemp.count - 1 withObject:stringTemp];
                objectEng.arrayIdiom = [NSArray arrayWithArray:arrayIdiomTemp];
                continue;

            }

            NSString *stringTemp = (!(typeString & AVStringTypeEndSemicolon)) ? [[arrayIdiomTemp lastObject] stringByAppendingString:[NSString stringWithFormat:@" %@",string]] :
            [[arrayIdiomTemp lastObject] stringByAppendingString:[NSString stringWithFormat:@" %@",[string stringWithoutLastSimbol]]];

            [arrayIdiomTemp replaceObjectAtIndex:arrayIdiomTemp.count - 1 withObject:stringTemp];
            objectEng.arrayIdiom = [NSArray arrayWithArray:arrayIdiomTemp];
            continue;
        }

        if(typeString & AVStringTypeMarkIdiom){
            arrayIdiom = AVStateWork;
            arrayIdiomTemp = [NSMutableArray arrayWithObject:[NSString new]];
            continue;
        }


#pragma mark - English Meaning

        if( engMeaning == AVStateBegin || engMeaning == AVStateWork){
            if( (typeString & AVStringTypeEng) & !(typeString & AVStringTypeEngEndNumberLat) & !(typeString & AVStringTypeSquareBrackets) & !(typeString & AVStringTypeEngEndNumberRoma)){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",string];
                if(typeString & AVStringTypeEndColon){
                    engMeaning = AVStateEnd;
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }
            if(typeString & AVStringTypeEngEndNumberLat){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",[string stringWithoutLastSimbol]];
                objectEng.indexPathMeaningWord = setIndexPathGlobal(objectEng.indexPathMeaningWord, [[string lastCharString] intValue]);
                continue;
            }
            if( (typeString & AVStringTypeEngEndNumberRoma) && !(typeString & AVStringTypeNumberRom) ){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",[string stringWithoutAtEndRomaNum]];
                objectEng.indexPathMeaningWord = setIndexPathLocal(objectEng.indexPathMeaningWord, [string makeDefaneNumFromRomaNumAtEndEngWord]);
                continue;
            }
        }

#pragma mark - Roma Number

        if(engMeaning == AVStateWork && (typeString & AVStringTypeNumberRom) ){
            objectEng.indexPathMeaningWord = setIndexPathLocal(objectEng.indexPathMeaningWord, [string makeNumFromRomaNum]);
            continue;
        }

#pragma mark - Transcription

        if(engMeaning == AVStateWork && (typeString & AVStringTypeSquareBrackets) ){
            objectEng.engTranscript = string;
            engMeaning = AVStateEnd;
            engTranscript = AVStateEnd;
            continue;
        }

#pragma mark - derevative

        if(([string isEqualToString:@"pl"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"superl"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"compare"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"compar"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"и"]) ||
           ([string isEqualToString:@"p"] && [array[numString+1] isEqualToString:@"p"] && [array[numString+2] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"косв"] && [array[numString+1] isEqualToString:@"падеж"] && [array[numString+2] isEqualToString:@"от"]) ||
           [string isEqualToString:@"="]){
            rusMeaningObject.dereviative = string;
            dereviative = AVStateWork;
            continue;
        }

#pragma mark - Grammatic

        if( (typeString & AVStringTypeEng)  && !(typeString & AVStringTypeParenthesis) && !(typeString & AVStringTypeRus) ){

            if( (typeString & AVStringTypeEndColon) && [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol] ] ) {

                objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:[string stringWithoutLastSimbol]];
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
                continue;
            }
        }

        if( (typeString & AVStringTypeEng)  && !(typeString & AVStringTypeParenthesis) && !(typeString & AVStringTypeRus) &&
           (engTranscript == AVStateEnd || grammatic == AVStateWork || accessory == AVStateWork) ){

            if( typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndDash) ) {

                if([self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol]]){
                    objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:[string stringWithoutLastSimbol]];
                    grammatic = AVStateWork;
                    continue;
                }
            }else{
                if( [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:string] ){

                    objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:string];
                    grammatic = AVStateWork;

                    continue;
                }

            }
        }

#pragma mark - Accessory brackets && dont Example

        if( (typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)) &&
           !(arrayExample == AVStateWork) && !(arrayIdiom == AVStateWork)  && !(rusMeaning == AVStateWork)){

            if(![string containsString:@"обычно"] && [string containsString:@"множ.число"]){
                objectEng.grammaticForm = [objectEng.grammaticForm arrayByAddingObject:string];
                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
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
                NSString *stringAccessoryWithPredlog = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [ @"сочетание: " stringByAppendingString: [[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol] ]:
                [ @"сочетание: " stringByAppendingString: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];
                rusMeaningObject.accessory = [rusMeaningObject.accessory arrayByAddingObject:stringAccessoryWithPredlog];
                accessory = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && (typeString & AVStringTypeEng) && !(typeString & AVStringTypeRus) ){
                objectEng.grammaticForm = (typeString & AVStringTypeParenthesisWithEndSimbol) ? [objectEng.grammaticForm arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]] :
                [objectEng.grammaticForm arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];

                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && ![string isContaintEngChars]){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ? [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]];
                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }
            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && [string isContaintEngChars]){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ? [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[ [string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];
                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            NSLog(@"Error Previos english grammatic  and string is round and curent state Build is AVCurrentStateBuildingBaseObject  ");
        }


#pragma mark - Rus accessory

        if( ([self.managerMeaningShort.arrayShortRusProperty containsObject:string])
           ){
            rusMeaningObject.accessory =  [rusMeaningObject.accessory arrayByAddingObject:string];
            continue;
        }

        if( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
           (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))
           ){
            rusMeaningObject.accessory =  [rusMeaningObject.accessory arrayByAddingObject:[string stringWithoutLastSimbol]];
            if(typeString & AVStringTypeEndColon){
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }
            continue;
        }

        if( rusMeaning == AVStateWork && (typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol) ) ){

            rusMeaningObject.accessory = ( typeString & AVStringTypeParenthesisWithEndSimbol ) ? [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol] ] :
            [rusMeaningObject.accessory arrayByAddingObject: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];

            if(typeString & AVStringTypeEndColon){
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }

            if(typeString & AVStringTypeEndSemicolon && numString < array.count - 1){
                if([array[numString+1] isContaintRusChars])
                    [arrayRusMean addObject:@""];
            }

            continue;
        }




#pragma mark -  Status Rus Meaning OR Example

        if(rusMeaning == AVStateWork && arrayExample == AVStateBegin && !(typeString & AVStringTypeRus) && [array[numString-1] isContaintRusChars]){
            arrayExample = AVStateWork;
            rusMeaning = AVStateEnd;
            rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
            tempExample = rusMeaningObject.arrayExample.lastObject;
        }

        if( (engMeaning  == AVStateEnd && engTranscript == AVStateEnd && rusMeaning == AVStateBegin ) &&
           (  typeString & (AVStringTypeRus | AVStringTypeEngEndNumberRoma) ) ) {
            rusMeaning = AVStateWork;
            arrayRusMean = [NSMutableArray arrayWithArray: @[[NSString new]]];
        }

#pragma mark - Example

        if( arrayExample ==AVStateWork){

            if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] && !([tempExample.meaning isEqual:@""] && [tempExample.accessory isEqual:@""]) &&
               !([[array[numString-1] firstCharString] isEqualToString:@"("]) ){
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }

            else if(typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)){
                tempExample.accessory = (typeString & AVStringTypeParenthesis) ? [tempExample.accessory stringByAppendingFormat:@" %@",[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]] :
                [tempExample.accessory stringByAppendingFormat:@" %@",[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]];
            }

            else if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] || ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
                                                                                                (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) ) ){

                NSString *stringTemp = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                [NSString stringWithFormat:@"%@ %@",string, tempExample.accessory] :
                [NSString stringWithFormat:@"%@ %@",[string stringWithoutLastSimbol], tempExample.accessory];
                tempExample.accessory = stringTemp;
            }

            else
                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];

            if( typeString & AVStringTypeEndSemicolon){
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }

            continue;
        }

#pragma mark - Rus Meaning

        if( rusMeaning == AVStateWork){
            NSString* tempString = [[arrayRusMean lastObject] stringByAppendingFormat:@" %@",string];
            [arrayRusMean replaceObjectAtIndex:arrayRusMean.count -1 withObject:tempString];
            rusMeaningObject.arrayMeaning = [NSArray arrayWithArray:arrayRusMean];
            if(typeString & AVStringTypeEndSemicolon)
                [arrayRusMean addObject:[NSString new]];
            continue;
        }

//        NSLog(@"Dont! --- j = %d",numberObjectJ);
//        [self printArrayObject:array andSelectRow:numString];

#pragma mark - End cycle

    }

}



#pragma mark - Building compose phraseVerb


-(void)makePhraseVerbCompose:(NSArray*) array{


    AVPhrasalVerb*objectEng = [[AVPhrasalVerb alloc] init];
    self.arrayEngWords = [self.arrayEngWords arrayByAddingObject:objectEng];
    engMeaning = engTranscript = accessory = grammatic = dereviative = grammaticForm = rusMeaning = arrayIdiom = arrayExample = AVStateBegin;


#pragma mark - cycle Begin

    for(int numString = 0; numString < array.count; numString++){

        if(numberObjectJ == 24269 && numString == 0){
            numString = numString;
        }

        NSString * string = array[numString];

        if([string isEqualToString:@"текст"]){

        }

        if([string isEqualToString:@"v"]){
            continue;
        }

        if(numString == 0){
            if([string isEqualToString:@"[■]"])
                continue;
            else
                NSLog(@"Error");
        }

            // NSLog(@"str = %@ ",string);

        if([string isEqualToString:@"aaaaaaaaa"]){

        }

        if(!string || [string isEqualToString:@""] || [string isEqualToString:@" "])
            continue;

        AVStringType typeString = [self defineString:string];

#pragma mark - check Nonstandart

        if( (engTranscript == AVStateWork || engMeaning == AVStateWork ) && [string isContaintRusChars] && !(typeString & AVStringTypeSquareBrackets))    //checking!!!
//            NSLog(@"Nonstandart obj = %d",numberObjectJ);

#pragma mark - check first MeaningRu

        if(typeString & AVStringTypeNumberLatClearLess34){

            rusMeaningObject = [[AVRusMeaning alloc]initForCompose];
            objectEng.arrayRusMeaning = [objectEng.arrayRusMeaning arrayByAddingObject:rusMeaningObject];

            engMeaning = engTranscript  = grammatic = grammaticForm = AVStateEnd;
            arrayExample = dereviative = rusMeaning = accessory = arrayIdiom = AVStateBegin;

            //setIndexPathCount([objectEng getAdressStr], string.intValue);
            if(numString < array.count -1){
                BOOL isNextWordRus = [array[numString+1] isContaintRusChars];
                BOOL isNextWordEng = [array[numString+1] isContaintEngChars];
                if(isNextWordRus && !isNextWordEng){
                    rusMeaning = AVStateWork;
                }

                if( [[array[numString+1] firstCharString] isEqualToString:@"="]){

                }

                if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
                   ![self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] &&
                   ![self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ){
                    rusMeaning = AVStateEnd;
                    arrayExample = AVStateWork;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }

                if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
                   ([self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] ||
                    [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ||
                    [self.managerMeaningShort.arrayEngPredlog containsObject:[array[numString + 1] stringWithoutLastSimbol] ] ||
                    [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[array[numString + 1] stringWithoutLastSimbol] ])
                   ){
                    accessory = AVStateWork;
                }

                if(typeString & AVStringTypeNumberLatClearMore33){
                    NSLog(@"error type string - number!");
                }
            }

            continue;
        }

        if(typeString & AVStringTypeNumberLatWithEndColon ){

            rusMeaningObject = [[AVRusMeaning alloc]init];
            objectEng.arrayRusMeaning = [objectEng.arrayRusMeaning arrayByAddingObject:rusMeaningObject];

            engMeaning = engTranscript  = grammatic = grammaticForm = AVStateEnd;
            arrayExample = dereviative = rusMeaning = accessory = arrayIdiom = AVStateBegin;

            //setIndexPathCount([objectEng getAdressStr], [string stringWithoutLastSimbol].intValue);

            arrayExample = AVStateWork;

            rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];

            tempExample = rusMeaningObject.arrayExample.lastObject;
            continue;
        }

//        if( string.intValue > 0 && engMeaning == AVStateWork && engTranscript == AVStateBegin){
//            engMeaning = engTranscript = AVStateEnd;
//            setIndexPathCount([objectEng getAdressStr], string.intValue);
//
//            continue;
//        }

        if( [string isContaintRusChars] && engMeaning == AVStateWork && engTranscript == AVStateBegin){
            engMeaning = engTranscript = AVStateEnd;

        }

#pragma mark - AccessoryStateWork

        if(accessory == AVStateWork){
            rusMeaningObject.accessory = (typeString & (AVStringTypeEndComma    |
                                                        AVStringTypeEndPoint      |
                                                        AVStringTypeEndSemicolon |
                                                        AVStringTypeEndColon      |
                                                        AVStringTypeEndDash ) ) ? [rusMeaningObject.accessory arrayByAddingObject:[string stringWithoutLastSimbol]] :
            [rusMeaningObject.accessory arrayByAddingObject: string] ;

            if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
               ([self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] ||
                [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ||
                [self.managerMeaningShort.arrayEngPredlog containsObject:[array[numString + 1] stringWithoutLastSimbol] ] ||
                [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[array[numString + 1] stringWithoutLastSimbol] ])
               ){
                accessory = AVStateWork;
            }else
                accessory = AVStateBegin;

            if(typeString & AVStringTypeEndColon){
                arrayExample = AVStateWork;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }
            if(typeString & (AVStringTypeEndComma | AVStringTypeEndPoint | AVStringTypeEndSemicolon | AVStringTypeEndDash )){

            }
            continue;
        }

#pragma mark - Latine number

        if(typeString & AVStringTypeNumberLatClearLess34){

            rusMeaningObject = [[AVRusMeaning alloc]initForCompose];
            objectEng.arrayRusMeaning = [objectEng.arrayRusMeaning arrayByAddingObject:rusMeaningObject];

            engMeaning = engTranscript  = grammatic = grammaticForm = AVStateEnd;
            arrayExample = dereviative = rusMeaning = accessory = arrayIdiom = AVStateBegin;

            //setIndexPathCount([objectEng getAdressStr], string.intValue);
            if(numString < array.count -1){
                BOOL isNextWordRus = [array[numString+1] isContaintRusChars];
                BOOL isNextWordEng = [array[numString+1] isContaintEngChars];
                if(isNextWordRus && !isNextWordEng){
                    rusMeaning = AVStateWork;
                }

                if( [[array[numString+1] firstCharString] isEqualToString:@"="]){

                }

                if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
                   ![self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] &&
                   ![self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ){
                    rusMeaning = AVStateEnd;
                    arrayExample = AVStateWork;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }

                if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
                   ([self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] ||
                    [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ||
                    [self.managerMeaningShort.arrayEngPredlog containsObject:[array[numString + 1] stringWithoutLastSimbol] ] ||
                    [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[array[numString + 1] stringWithoutLastSimbol] ])
                   ){
                    accessory = AVStateWork;
                }

                if(typeString & AVStringTypeNumberLatClearMore33){
                    NSLog(@"error type string - number!");
                }
            }

            continue;
        }

        if(typeString & AVStringTypeNumberLatWithEndColon ){

            rusMeaningObject = [[AVRusMeaning alloc]init];
            objectEng.arrayRusMeaning = [objectEng.arrayRusMeaning arrayByAddingObject:rusMeaningObject];

            engMeaning = engTranscript  = grammatic = grammaticForm = AVStateEnd;
            arrayExample = dereviative = rusMeaning = accessory = arrayIdiom = AVStateBegin;

            //setIndexPathCount([objectEng getAdressStr], [string stringWithoutLastSimbol].intValue);

            arrayExample = AVStateWork;

            rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];

            tempExample = rusMeaningObject.arrayExample.lastObject;
            continue;
        }

#pragma mark - Derevative Continios
        if(dereviative == AVStateWork){
            NSString *stringDer = (typeString & ( AVStringTypeEndComma | AVStringTypeEndPoint | AVStringTypeEndSemicolon)) ? [string stringWithoutLastSimbol] :string;
            rusMeaningObject.dereviative = [rusMeaningObject.dereviative stringByAppendingFormat:@" %@",stringDer];
            continue;
        }

#pragma mark - Idiom

        if(arrayIdiom == AVStateWork){

            if( (typeString & AVStringTypeEng) && ([array[numString-1] isContaintRusChars]) ){
                [arrayIdiomTemp addObject:[NSString new]];
            }

            if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] || ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
                                                                                           (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) )
               ){
                NSString *stringTemp = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                [NSString stringWithFormat:@"(%@) %@",string, [arrayIdiomTemp lastObject]]:
                [NSString stringWithFormat:@"(%@) %@",[string stringWithoutLastSimbol], [arrayIdiomTemp lastObject]];

                [arrayIdiomTemp replaceObjectAtIndex:arrayIdiomTemp.count - 1 withObject:stringTemp];
                objectEng.arrayIdiom = [NSArray arrayWithArray:arrayIdiomTemp];
                continue;

            }

            NSString *stringTemp = (!(typeString & AVStringTypeEndSemicolon)) ? [[arrayIdiomTemp lastObject] stringByAppendingString:[NSString stringWithFormat:@" %@",string]] :
            [[arrayIdiomTemp lastObject] stringByAppendingString:[NSString stringWithFormat:@" %@",[string stringWithoutLastSimbol]]];

            [arrayIdiomTemp replaceObjectAtIndex:arrayIdiomTemp.count - 1 withObject:stringTemp];
            objectEng.arrayIdiom = [NSArray arrayWithArray:arrayIdiomTemp];
            continue;
        }

        if(typeString & AVStringTypeMarkIdiom){
            arrayIdiom = AVStateWork;
            arrayIdiomTemp = [NSMutableArray arrayWithObject:[NSString new]];
            continue;
        }


#pragma mark - English Meaning

        if( engMeaning == AVStateBegin || engMeaning == AVStateWork){

            if( (typeString & AVStringTypeEng) & !(typeString & AVStringTypeEngEndNumberLat) & !(typeString & AVStringTypeSquareBrackets) & !(typeString & AVStringTypeEngEndNumberRoma)){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",string];
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }
            if(typeString & AVStringTypeEngEndNumberLat){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",[string stringWithoutLastSimbol]];
                objectEng.indexPathMeaningWord = setIndexPathGlobal(objectEng.indexPathMeaningWord, [[string lastCharString] intValue]);
                continue;
            }
            if( (typeString & AVStringTypeEngEndNumberRoma) && !(typeString & AVStringTypeNumberRom) ){
                engMeaning = AVStateWork;
                objectEng.engMeaningObject = [objectEng.engMeaningObject stringByAppendingFormat:@" %@",[string stringWithoutAtEndRomaNum]];
                objectEng.indexPathMeaningWord = setIndexPathLocal(objectEng.indexPathMeaningWord, [string makeDefaneNumFromRomaNumAtEndEngWord]);
                continue;
            }
        }

#pragma mark - Roma Number

        if(engMeaning == AVStateWork && (typeString & AVStringTypeNumberRom) ){
            objectEng.indexPathMeaningWord = setIndexPathLocal(objectEng.indexPathMeaningWord, [string makeNumFromRomaNum]);
            continue;
        }

#pragma mark - Transcription

        if(engMeaning == AVStateWork && (typeString & AVStringTypeSquareBrackets) ){
            objectEng.engTranscript = string;
            engMeaning = AVStateEnd;
            engTranscript = AVStateWork;
            continue;
        }

#pragma mark - derevative

        if(([string isEqualToString:@"pl"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"superl"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"compare"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"compar"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"и"]) ||
           ([string isEqualToString:@"p"] && [array[numString+1] isEqualToString:@"p"] && [array[numString+2] isEqualToString:@"от"]) ||
           ([string isEqualToString:@"косв"] && [array[numString+1] isEqualToString:@"падеж"] && [array[numString+2] isEqualToString:@"от"]) ||
           [string isEqualToString:@"="]){
            rusMeaningObject.dereviative = string;
            dereviative = AVStateWork;
            accessory = AVStateBegin;
            continue;
        }

#pragma mark - Grammatic

        if( (typeString & AVStringTypeEng)  && !(typeString & AVStringTypeParenthesis) && !(typeString & AVStringTypeRus) && !(grammatic == AVStateEnd) ){

            if( (typeString & AVStringTypeEndColon) && [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol] ] ) {

                objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:[string stringWithoutLastSimbol]];
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
                continue;
            }
        }

        if( (typeString & AVStringTypeEng)  && !(typeString & AVStringTypeParenthesis) && !(typeString & AVStringTypeRus) &&
           (engTranscript == AVStateEnd || engTranscript == AVStateWork || grammatic == AVStateWork || accessory == AVStateWork) && !(grammatic == AVStateEnd) ){

            if( typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndDash) ) {

                if([self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol]]){
                    objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:[string stringWithoutLastSimbol]];
                    grammatic = AVStateWork;
                    engTranscript = AVStateEnd;
                    continue;
                }
            }else{
                if( [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:string] ){

                    objectEng.grammaticType = [objectEng.grammaticType arrayByAddingObject:string];
                    grammatic = AVStateWork;
                    engTranscript = AVStateEnd;
                    continue;
                }

            }
        }

#pragma mark - Accessory brackets && dont Example

        if( (typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)) &&
           !(arrayExample == AVStateWork) && !(arrayIdiom == AVStateWork)  && !(rusMeaning == AVStateWork) ){

            if(![string containsString:@"обычно"] && [string containsString:@"множ.число"]){
                objectEng.grammaticForm = [objectEng.grammaticForm arrayByAddingObject:string];
                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
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
                NSString *stringAccessoryWithPredlog = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [ @"сочетание: " stringByAppendingString: [[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol] ]:
                [ @"сочетание: " stringByAppendingString: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];
                rusMeaningObject.accessory = [rusMeaningObject.accessory arrayByAddingObject:stringAccessoryWithPredlog];

                if( [array[numString+1] isContaintEngChars] && ![[array[numString+1] firstCharString] isEqualToString:@"("] &&
                   ([self.managerMeaningShort.arrayEngPredlog containsObject:array[numString + 1] ] ||
                    [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:array[numString + 1] ] ||
                    [self.managerMeaningShort.arrayEngPredlog containsObject:[array[numString + 1] stringWithoutLastSimbol] ] ||
                    [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[array[numString + 1] stringWithoutLastSimbol] ])
                   ){
                    accessory = AVStateWork;
                }


                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && (typeString & AVStringTypeEng) && !(typeString & AVStringTypeRus) && grammatic != AVStateEnd ){
                objectEng.grammaticForm = (typeString & AVStringTypeParenthesisWithEndSimbol) ? [objectEng.grammaticForm arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]] :
                [objectEng.grammaticForm arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];

                grammatic = AVStateWork;
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && (typeString & AVStringTypeEng) && !(typeString & AVStringTypeRus) && grammatic == AVStateEnd ){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]];

                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && ![string isContaintEngChars]){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]];
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }
            if(!isEqualSeparatedStringInBracetsWithEnglishPredlog && [string isContaintRusChars] && [string isContaintEngChars]){
                rusMeaningObject.accessory = (typeString & AVStringTypeParenthesisWithEndSimbol) ?
                [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]]:
                [rusMeaningObject.accessory arrayByAddingObject:[ [string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];
                if(typeString & AVStringTypeEndColon){
                    arrayExample = AVStateWork;
                    rusMeaning = AVStateEnd;
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
                continue;
            }

            NSLog(@"Error Previos english grammatic  and string is round and curent state Build is AVCurrentStateBuildingBaseObject  ");
        }


#pragma mark - Rus accessory



        if([self.managerMeaningShort.arrayShortRusProperty containsObject:string]){
            if(arrayExample == AVStateWork)
                tempExample.accessory = [tempExample.accessory stringByAppendingFormat:@" %@",string];
            else
                rusMeaningObject.accessory =  [rusMeaningObject.accessory arrayByAddingObject:string];
            continue;
        }

        if( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]])  &&
           //           (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) )
           (typeString & (AVStringTypeEndComma | AVStringTypeEndColon) )
           ){
            if(arrayExample == AVStateWork){
                tempExample.accessory = [tempExample.accessory stringByAppendingFormat:@" %@",[string stringWithoutLastSimbol]];
                if(typeString & AVStringTypeEndSemicolon){
                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                    tempExample = rusMeaningObject.arrayExample.lastObject;
                }
            }
            else
                rusMeaningObject.accessory =  [rusMeaningObject.accessory arrayByAddingObject:[string stringWithoutLastSimbol]];

            if(typeString & AVStringTypeEndColon){

                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }
            continue;
        }

        if( rusMeaning == AVStateWork && (typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol) ) ){

            rusMeaningObject.accessory = ( typeString & AVStringTypeParenthesisWithEndSimbol ) ?
            [rusMeaningObject.accessory arrayByAddingObject:[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol] ] :
            [rusMeaningObject.accessory arrayByAddingObject: [[string stringWithoutLastSimbol] stringWithoutFirstSimbol] ];

            if(typeString & AVStringTypeEndColon){
                arrayExample = AVStateWork;
                rusMeaning = AVStateEnd;
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }
            if( ((typeString & AVStringTypeEndSemicolon) || (typeString & AVStringTypeEndComma) ) && numString < array.count - 1){  ///???colon
                if([array[numString+1] isContaintRusChars]){
                    rusMeaningObject.arrayMeaning = [rusMeaningObject.arrayMeaning arrayByAddingObject:@""];
                    if(typeString & AVStringTypeEndComma){
                        NSLog(@"");
                    }
                }
            }
            continue;
        }


#pragma mark -  Status Rus Meaning OR Example

        if(rusMeaning == AVStateWork && arrayExample == AVStateBegin && !(typeString & AVStringTypeRus) && [array[numString-1] isContaintRusChars]){
            arrayExample = AVStateWork;
            rusMeaning = AVStateEnd;
            rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
            tempExample = rusMeaningObject.arrayExample.lastObject;
            if([rusMeaningObject.arrayMeaning.lastObject isEqualToString:@""]){
                NSMutableArray*arrayTemp = [NSMutableArray arrayWithArray:rusMeaningObject.arrayMeaning];
                [arrayTemp removeLastObject];
                rusMeaningObject.arrayMeaning = [NSArray arrayWithArray: arrayTemp];
            }
        }

        if( (engMeaning  == AVStateEnd && (engTranscript == AVStateEnd || engTranscript == AVStateWork)  && rusMeaning == AVStateBegin ) && // edit
           (  typeString & (AVStringTypeRus | AVStringTypeEngEndNumberRoma) ) ) {

            rusMeaning = AVStateWork;
            engTranscript = AVStateEnd;

        }

#pragma mark - Example

        if( arrayExample ==AVStateWork){

            if(typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)){
                tempExample.accessory = (typeString & AVStringTypeParenthesis) ? [tempExample.accessory stringByAppendingFormat:@" %@",[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]] :
                [tempExample.accessory stringByAppendingFormat:@" %@",[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]];
            }

            else if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] ||
                    ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
                     (typeString & (AVStringTypeEndComma | AVStringTypeEndColon) ) ) ) {

                        tempExample.accessory = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                        [NSString stringWithFormat:@"%@ %@",string, tempExample.accessory] :
                        [NSString stringWithFormat:@"%@ %@",[string stringWithoutLastSimbol], tempExample.accessory];
                    }
            else if( [self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:string] ||
                    ( ([self.managerMeaningShort.arrayShortWordGrammaticProperty containsObject:[string stringWithoutLastSimbol]]) &&
                     (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) ) ) {

                        tempExample.accessory = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
                        [NSString stringWithFormat:@"%@ %@",string, tempExample.accessory] :
                        [NSString stringWithFormat:@"%@ %@",[string stringWithoutLastSimbol], tempExample.accessory];
                    }
                //            else if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] && !([tempExample.meaning isEqual:@""] && [tempExample.accessory isEqual:@""]) && !([[array[numString-1] firstCharString] isEqualToString:@"("]) && [[string lastCharString] isEqualToString:@";"] ){
                //                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
                //                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                //                tempExample = rusMeaningObject.arrayExample.lastObject;
                //            }
                //            else if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] &&
                //                    !([tempExample.meaning isEqual:@""] && [tempExample.accessory isEqual:@""]) && !([[array[numString-1] firstCharString] isEqualToString:@"("]) &&
                //                    ![[string lastCharString] isEqualToString:@";"]){
                //
                //                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                //                tempExample = rusMeaningObject.arrayExample.lastObject;
                //                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
                //            }

            else
                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];

            if( typeString & AVStringTypeEndSemicolon){
                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
                tempExample = rusMeaningObject.arrayExample.lastObject;
            }

            continue;
        }


            //        if( arrayExample ==AVStateWork){
            //
            //            if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] && !([tempExample.meaning isEqual:@""] && [tempExample.accessory isEqual:@""]) && !([[array[numString-1] firstCharString] isEqualToString:@"("]) && [[string lastCharString] isEqualToString:@";"] ){
            //                    tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
            //                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
            //                    tempExample = rusMeaningObject.arrayExample.lastObject;
            //            }
            //
            //            else if( !(typeString & AVStringTypeRus) && (typeString & AVStringTypeEng) && [array[numString-1] isContaintRusChars] && !([tempExample.meaning isEqual:@""] &&
            //            [tempExample.accessory isEqual:@""]) && !([[array[numString-1] firstCharString] isEqualToString:@"("]) && ![[string lastCharString] isEqualToString:@";"]){
            ////                    rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
            ////                    tempExample = rusMeaningObject.arrayExample.lastObject;
            //                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
            //            }
            //
            //            else if(typeString & (AVStringTypeParenthesis | AVStringTypeParenthesisWithEndSimbol)){
            //                tempExample.accessory = (typeString & AVStringTypeParenthesis) ? [tempExample.accessory stringByAppendingFormat:@" %@",[[string stringWithoutLastSimbol] stringWithoutFirstSimbol]] :
            //                [tempExample.accessory stringByAppendingFormat:@" %@",[[[string stringWithoutLastSimbol] stringWithoutFirstSimbol] stringWithoutLastSimbol]];
            //            }
            //
            //            else if( [self.managerMeaningShort.arrayShortRusProperty containsObject:string] || ( ([self.managerMeaningShort.arrayShortRusProperty containsObject:[string stringWithoutLastSimbol]]) &&
            //                                                                                                (typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon) ) ) ){
            //
            //                NSString *stringTemp = ( !(typeString & (AVStringTypeEndComma | AVStringTypeEndSemicolon | AVStringTypeEndColon))) ?
            //                [NSString stringWithFormat:@"%@ %@",string, tempExample.accessory] :
            //                [NSString stringWithFormat:@"%@ %@",[string stringWithoutLastSimbol], tempExample.accessory];
            //                tempExample.accessory = stringTemp;
            //            }
            //
            //            else
            //                tempExample.meaning = [tempExample.meaning stringByAppendingFormat:@" %@",string];
            //
            //            if( typeString & AVStringTypeEndSemicolon){
            //                rusMeaningObject.arrayExample = [rusMeaningObject.arrayExample arrayByAddingObject: [[AVExample alloc]init]];
            //                tempExample = rusMeaningObject.arrayExample.lastObject;
            //            }
            //
            //            continue;
            //        }

#pragma mark - Rus Meaning

        if( rusMeaning == AVStateWork){

            NSString* tempString = [[rusMeaningObject.arrayMeaning lastObject] stringByAppendingFormat:@" %@",string];
            NSMutableArray* arrayTemp = [NSMutableArray arrayWithArray:rusMeaningObject.arrayMeaning];
            [arrayTemp removeLastObject];
            [arrayTemp addObject:[NSString stringWithString:tempString]];
            rusMeaningObject.arrayMeaning = [NSArray arrayWithArray:arrayTemp];

            if(typeString & AVStringTypeEndSemicolon)
                rusMeaningObject.arrayMeaning = [rusMeaningObject.arrayMeaning arrayByAddingObject:[NSString new]];
            continue;
        }

//        NSLog(@"Dont! --- j = %d",numberObjectJ);
//        checkPrint = YES;
//        [self printArrayObject:array andSelectRow:numString];

#pragma mark - End cycle

    }

    tempArrayEngWords = [tempArrayEngWords arrayByAddingObject:objectEng];

}
@end
