//
//  ViewController.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 29/09/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "ViewController.h"
#import "AVMakeBASE.h"

#define NSLOGSTRING NSLog(@"- - - - - - -  object j = %d  i = %d, string = %@",j,i,string);
#define NSLOGS NSLog(@"- - - - - - -  object j = %d  string = %@",j,string);
#define PRINT_OBJECT [self printArrayObject:array];
#define PRINT_OBJECT_SELECT [weakSelf printArrayObject:array andSelectRow:i];

#define AVL NSLog(@"");

@interface ViewController ()



@property NSMutableArray*arrayEnObjects;
@end


@implementation ViewController

@synthesize manager = _manager,sharedMeaningShortWords = _sharedMeaningShortWords;

-(AVMeaningShortWords*)sharedMeaningShortWords{
    if(!_sharedMeaningShortWords)
        _sharedMeaningShortWords = [AVMeaningShortWords sharedShortWords];
    return _sharedMeaningShortWords;
}

-(id)init{
    self = [super init];
    if(self){
        UIBarButtonItem*barButtonInTable = [[UIBarButtonItem alloc]initWithTitle:@"InputTable" style:UIBarButtonItemStylePlain target:self action:@selector(inputTable)];
        [self.navigationItem setRightBarButtonItem:barButtonInTable];
        self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    }
    return self;
}

-(void)inputTable{
    TableViewController*tvc = [[TableViewController alloc]initWithStyle:UITableViewStylePlain];
    [self showViewController:tvc sender:nil];

//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//        [self printArrayMain:self.manager.mainArray];
//    });

}

- (void)viewDidLoad {
    [super viewDidLoad];


    //__weak ViewController*weakSelf = self;

    //NSMutableArray*mainArrayMut = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];

    //void(^blockInMainArray)(NSArray*,int,NSArray*) = ^(NSArray*array,int j,NSArray*mainArray){};

    //__block NSString*stringCheck = [NSString new];
   //__block BOOL flagInset = NO;

    void(^block1)(NSArray *, int , NSArray *) = ^(NSArray *array, int j, NSArray *arrayMain) {
        int countClog = 0;
        BOOL flagInsertClosur = NO;
        BOOL flagInsertQuart = NO;

        for(NSString*string in array){
            countClog = ( [[string firstCharString] isEqualToString:@"["]) ? countClog+1 : countClog;
            flagInsertQuart = ( [string  isEqualToString:@"[■]"] ) ? YES : flagInsertQuart;
        }
        if(flagInsertQuart && countClog > 1 ){
            AVL
            NSLog(@"j = %d",j);
            PRINT_OBJECT
        }

    };

    [self array:self.manager.mainArray block:nil andBlockExecutInExternCycle:block1];

}


    #pragma mark - Check at ziro ArrayString - need incommiting and array.count = 0

    //for(stringCheck in self.sharedMeaningShortWords.arrayShortRusProperty){
    //flagInset = NO;

    //if(!flagInset)
    //NSLog(@"str = %@",stringCheck);
    //}

    //self.manager.mainArray = [NSArray arrayWithArray:mainArrayMut];


//
//void(^blockInArrayWordAddition)(NSString *string, NSArray *array, int i, int j, NSArray *arrayMain) = ^(NSString *string, NSArray *array, int i, int j, NSArray *arrayMain) {
//
//        //NSString *stringWithoutLastChar = ([string length]>1) ? [string substringToIndex:string.length-1] : string;
//
//        //NSString *stringLastChar = ([string length]>1) ? [string substringFromIndex:string.length-1] : @"";
//        //if([stringLastChar integerValue] && !([string intValue])){
//    if(([string isEqualToString:@"I"] || [string isEqualToString:@"II"] || [string isEqualToString:@"III"] || [string isEqualToString:@"IV"] || [string isEqualToString:@"V"] || [string isEqualToString:@"VI"]) && i == i){
//        NSString *stringNext = (i < array.count - 1) ? array[i+1] : @" ";
//        unichar firstChar = [stringNext characterAtIndex:0];
//        NSString*stringNextAtFirstChar = [NSString stringWithCharacters:&firstChar length:1];
//        if(![stringNextAtFirstChar isEqualToString:@"["]){
//            NSLOGSTRING
//            AVL
//            PRINT_OBJECT_SELECT
//        }
//
//    }
//
//
//        //        if(([stringWithoutLastChar isEqualToString:stringCheck]) )
//        //            NSLog(@"--------str = %@",string);
//
//        //if(([stringWithoutLastChar isEqualToString:stringCheck] && [stringLastChar isEqualToString:@","]) && !flagInset)
//        //flagInset = YES;
//
//
//};
//
//void(^blockInArrayWord)(NSString *string, NSArray *array, int i, int j, NSArray *arrayMain) = ^(NSString *string, NSArray *array, int i, int j, NSArray *arrayMain) {
//
//        //NSString*strState = @"амер";
//        //        if(i>1){
//    NSString*stringPred = (i > 1) ? arrayMain[j][i-1] : @" ";
//        //            NSString*stringKeyPred = nil;
//        //            NSString*objetAtKeyPred = nil;
//        //            if([stringPred length]>1){
//        //                stringKeyPred = [stringPred substringToIndex:stringPred.length-1];
//        //                objetAtKeyPred = [dicRus objectForKey:stringKeyPred];
//        //            }
//        //for(NSString*stringCheck in self.sharedMeaningShortWords.arrayShortRusProperty){
//        //            if( [string isEqualToString:stringCheck] && ([string isEqualToString:[NSString stringWithFormat:@",%@",strState]] || [string isEqualToString:[NSString stringWithFormat:@"%@,",strState]] ||
//        //                                                           [string isEqualToString:[NSString stringWithFormat:@"%@;",strState]] || [string isEqualToString:[NSString stringWithFormat:@"%@",strState]]) ){
//        //if([string isEqualToString:stringCheck]){
//
//        //if([self.sharedMeaningShortWords.arrayShortRusProperty containsObject:string]){
//    NSString *stringWithoutLastChar = ([string length]>1) ? [string substringToIndex:string.length-1] : string;
//    NSString *stringLastChar = ([string length]>1) ? [string substringFromIndex:string.length-1] : string;
//    stringCheck = @",";
//    NSString *stringNext = (i < array.count - 1) ? array[i+1] : @" ";
//    int firstChar = [stringNext characterAtIndex:0];
//
//    if(i > 1 ){
//        if([stringLastChar isEqualToString:stringCheck] && !(firstChar > 64 && firstChar < 123)){
//                // && !( stringPred.intValue || ([self.sharedMeaningShortWords.arrayEngPredlog containsObject:stringPred] || [self.sharedMeaningShortWords.arrayShortRusReduct containsObject:stringPred] || [self.sharedMeaningShortWords.arrayShortWordGrammatic containsObject:stringPred] || [stringPred isEqualToString:@"p"] ))){// || [stringWithoutLastChar isEqualToString:stringCheck])){
//                //&& [stringLastChar isEqualToString:@","]
//                //                if([string isEqualToString:stringCheck] &&![self.sharedMeaningShortWords.arrayShortWordGrammaticProperty containsObject:array[i-1]] && ![array[i-1] intValue] && ![self.sharedMeaningShortWords.arrayShortRusProperty containsObject:array[i-1]]){
//                //
//                //                    if(i>1){
//                //                        NSString*stringPred = arrayMain[j][i-1];
//                //                        NSString*stringPredWithoutLastChar= nil;
//                //                        stringPredWithoutLastChar = ([stringPred length]>1) ? [stringPred substringToIndex:stringPred.length-1] : @"";
//                //
//                //                        if(![self.sharedMeaningShortWords.arrayShortRusProperty containsObject:stringPredWithoutLastChar]){
//            NSLOGSTRING
//            PRINT_OBJECT_SELECT
//
//            AVL
//            /*
//             if(i > 0){
//             NSLog(@"--------------------------           pred =                          %@",array[i-1]);
//             //NSLOGSTRING
//             }
//             else
//             NSLog(@"--------------------------          ----------------------- firs!!!!!");
//
//
//             NSLog(@"-------------------------            present =     %@",array[i]);
//
//             if(i < array.count-1)
//             NSLog(@"-------------------------            post =                          %@",array[i+1]);
//             else
//             NSLog(@"-------------------------            ---------------------------------------last!!!!!");
//             //                PRINT_OBJECT
//
//             */
//                //                        }
//                //                    }
//                //
//        }
//    }
//    else  if([string isEqualToString:stringCheck]){
//        NSLOGSTRING
//        NSLog(@"--------------------------          ----------------------- firs!!!!!");
//
//    }
//
//};



    //        BOOL f = NO;
    //
    //        unichar chFirst = [string characterAtIndex:0];
    //        NSString*strFirst = [NSString stringWithCharacters:&chFirst length:1];

    //        if( [string isEqualToString:@"="]){
    //
    //            int chSecond = [string characterAtIndex:1];
    //            int chDoLast = [string characterAtIndex:string.length-2];
    //
    //            if(chSecond > 64 && chSecond < 123 && chDoLast > 64 && chDoLast < 123 ){
    //                if(i>1){
    //                    NSString*stringPred = arrayMain[j][i-1];
    //                    if( ([self.sharedMeaningShortWords.arrayShortWordGrammaticProperty containsObject:stringPred] || [stringPred integerValue]) ){
    //                        for(NSString*stringCheck in self.sharedMeaningShortWords.arrayEngPredlog){
    //                            if([string containsString:stringCheck]){
    //                                f = YES;
    //                            }
    //                        }
    //                        if(!f){
    //                            NSLOGSTRING
    //                            PRINT_OBJECT
    //                            AVL
    //                        }
    //                    }
    //                }
    //            }
    //        }



    //       for(NSString*stringCheck in self.sharedMeaningShortWords.arrayShortRusProperty){

    //unichar chFirst = [string characterAtIndex:0];
    //NSString*strFirst = [NSString stringWithCharacters:&chFirst length:1];

    //unichar chLast = [string characterAtIndex:string.length-1];
    //NSString*strLast = [NSString stringWithCharacters:&chLast length:1];

    //                NSDictionary*dicRus = self.sharedMeaningShortWords.dictionaryRusKeyShortObjLongProperty;
    //
    //                if(i>1){
    //                    NSString*stringPred = arrayMain[j][i-1];
    //                    NSString*stringKeyPred = nil;
    //                    NSString*objetAtKeyPred = nil;
    //                    if([stringPred length]>1){
    //                        stringKeyPred = [stringPred substringToIndex:stringPred.length-1];
    //                        objetAtKeyPred = [dicRus objectForKey:stringKeyPred];
    //                    }
    //
    //                    NSString*stringKey = nil;
    //                    NSString*objetAtKey = nil;
    //                    if([string length]>1){
    //                        stringKey = [string substringToIndex:string.length-1];
    //                        objetAtKey = [dicRus objectForKey:stringKey];
    //                    }

    //NSString*stringCheck = @"p p";

    //if(   ([string isEqualToString:stringCheck] || ([stringKey isEqualToString:stringCheck] && [string hasSuffix:@","])) ){
    //                      if( ([string containsString:[NSString stringWithFormat:@" %@ ", stringCheck]] || [string containsString:[NSString stringWithFormat:@"(%@ ", stringCheck]] ||
    //                           [string containsString:[NSString stringWithFormat:@" %@)", stringCheck]] ) && ![stringCheck isEqualToString:@"о"] && ![stringCheck isEqualToString:@"м"] && ![stringCheck isEqualToString:@"амер"]
    //                         && ![stringCheck isEqualToString:@"текст"]) {//&&
    //if([string containsString:stringCheck]){



    //if(  (  ([dicRus objectForKey:stringPred] || ([stringPred hasSuffix:@","] && objetAtKeyPred) ) || [self.sharedMeaningShortWords.arrayShortWordGrammaticProperty containsObject:stringPred]  || [stringPred integerValue])   ){
    //                          if([stringCheck isEqualToString:@"геогр"]){


    //NSLog(@"checkString -------------------------------------------------------------------------------%@",stringCheck);
    //AVL
    //NSLOGSTRING
    //AVL
    //[self printArrayObject:array andNumCheck:i];
    //
    //                              NSRange rangeCheckStringInString = [string rangeOfString:stringCheck];
    //
    //                              NSMutableArray*arrayMut = [NSMutableArray arrayWithArray:array];
    //
    //                              NSMutableString*mutString = [NSMutableString stringWithString:string];
    //
    //                              string = [mutString stringByReplacingCharactersInRange:rangeCheckStringInString withString:@"причастие прошед. времени"];
    //
    //                //[self.sharedMeaningShortWords.dictionaryRusKeyShortObjLongProperty objectForKey:stringCheck]];
    //
    //                              [arrayMut replaceObjectAtIndex:i withObject:string];
    //
    //                              [mainArrayMut replaceObjectAtIndex:j withObject:[NSArray arrayWithArray:arrayMut]];

//AVL

//NSLOGSTRING

    //                        }
    //}
    //}
    // }

    //        //if(!strFirst.integerValue && strLast.integerValue){
    //        if([string isEqualToString:@"[■]"] && ![arrayMain[j-1][0] isEqualToString:@"[■]"] && ![arrayMain[j][1] isEqualToString:arrayMain[j-1][0]]){
    //
    //            NSLog(@"-------------------------------strNamePredic = %@",arrayMain[j-1][0]);
    //
    //            AVL
    //            NSLOGSTRING
    //            PRINT_OBJECT
    //
    //        }


    //
    //        BOOL isContaint = NO;
    //        BOOL isContaintMoreSecond = NO;
    //
    //        NSString*str1;
    //        NSString*str2;
    //        for(NSString*string in array){
    //
    //            for(NSString*stringCheck in self.sharedMeaningShortWords.arrayShortWordGrammatic){
    //                if(isContaint && [string isEqualToString:stringCheck]){
    //                    isContaintMoreSecond = YES;
    //                    str2 = stringCheck;
    //                }
    //                if([string isEqualToString:stringCheck] && !isContaint){
    //                    isContaint = YES;
    //                    str1 = stringCheck;
    //                }
    //
    //            }
    //        }
    //
    //        if(isContaint && isContaintMoreSecond ){
    //            NSLog(@"object j = %d , str1 = %@ , str2 = %@  ",j,str1,str2);
    //            AVL
    //            PRINT_OBJECT
    //        }


    //
    //        BOOL isContaint = NO;
    //        BOOL isContaintMoreSecond = NO;
    //
    //        NSString*str1;
    //        NSString*str2;
    //
    //            for(NSString*stringCheck in self.sharedMeaningShortWords.arrayShortWordGrammatic){
    ////                if([string containsString:[NSString stringWithFormat:@" %@ ", stringCheck]] || [string containsString:[NSString stringWithFormat:@"(%@ ", stringCheck]] ||
    ////                     [string containsString:[NSString stringWithFormat:@" %@)", stringCheck]] || [string containsString:[NSString stringWithFormat:@"[%@ ", stringCheck]] ||
    ////                     [string containsString:[NSString stringWithFormat:@" %@]", stringCheck]])
    //                if([string isEqualToString:stringCheck] && !isContaint){
    //                    isContaint = YES;
    //                    str1 = stringCheck;
    //                }
    //                if(isContaint && [string isEqualToString:stringCheck]){
    //                    isContaintMoreSecond = YES;
    //                    str2 = stringCheck;
    //                }
    //            }
    //        unichar simbol = [string characterAtIndex:0];
    //        NSString*strSimbol = [NSString stringWithCharacters:&simbol length:1];
    //
    //        if(isContaint && isContaintMoreSecond ){
    //            NSLog(@"object j = %d  i = %d, str1 = %@ , str2 = %@  ",j,i,str1,str2);
    //            PRINT_OBJECT
    //        }


    //||
    //[string containsString:[NSString stringWithFormat:@" %@]", stringCheck]]) && [stringCheck isEqualToString:@"pl"] && ![stringCheck isEqualToString:@"v"] && ![stringCheck isEqualToString:@"n"] ){
    //                     && ![stringCheck isEqualToString:@"pl"] &&
    //                    ![stringCheck isEqualToString:@"v"] &&
    //                    ![stringCheck isEqualToString:@"n"] &&
    //                    ![stringCheck isEqualToString:@"sg"] &&
    //                    ![stringCheck isEqualToString:@"superl"] &&
    //                    ![stringCheck isEqualToString:@"int"] &&
    //                    ![stringCheck isEqualToString:@"pass"]){

        //        unichar simbolCheck = [string characterAtIndex:0];
        //        NSString*strSimbolCheck = [NSString stringWithCharacters:&simbolCheck length:1];
        //
        //        NSString*strSimbol = @"!!!";
        //
        //        BOOL isNum = NO;
        //        if(i>0){
        //            isNum = [array[i-1] integerValue];
        //            unichar simbol = [array[i-1] characterAtIndex:0];
        //            strSimbol = [NSString stringWithCharacters:&simbol length:1];
        //        }



        //        if([strSimbolCheck isEqualToString:@"("]){// && ![strSimbol isEqualToString:@"["] && !isNum){
        //             NSLog(@"--------------------------------");
        //            NSLOGSTRING;
        //             NSLog(@"");
        //            PRINT_OBJECT
        //        }
    //            if(string.length > 1){
    //                unichar simbol = [string characterAtIndex:1];
    //                int simInt = [string characterAtIndex:1];
    //                NSString*strSimbol = [NSString stringWithCharacters:&simbol length:1];
    //
    //                if([strSimbol isEqualToString:@"■"] && i == 0)
    //                    flagBrartIncloud = YES;
    //            }


//self.block = ^(NSString *string, NSArray *array, int i, int j, NSArray *arrayMain) {
//
//    NSMutableArray<AVEnglWord*>*arrayMutWords = [NSMutableArray arrayWithArray:weakSelf.manager.arrayObjectWords];
//
//    unichar simbol = [string characterAtIndex:0];
//    int simInt = [string characterAtIndex:0];
//    NSString*strSimbol = [NSString stringWithCharacters:&simbol length:1];
//
//    if([strSimbol isEqualToString:@"["])
//        weakSelf.flagName = NO;
//    if(weakSelf.flagName){
//        arrayMutWords[j].engNameObject = [arrayMutWords[j].engNameObject stringByAppendingString:string];
//            //NSLog(@" name = %@",arrayMutWords[j].engNameObject);
//    }
//
//};

//void(^blockExt)(NSArray*,int,NSArray*) = ^(NSArray*array,int j,NSArray*mainArray){

        //weakSelf.manager.arrayObjectWords = [weakSelf.manager.arrayObjectWords arrayByAddingObject:[[AVEnglWord alloc]init]];
        //weakSelf.flagName = YES;
        //NSLog(@"j = %d",j);
//};



    ////        unichar simbol = [string characterAtIndex:0];
    //        int simInt = [string characterAtIndex:0];
    //        NSString*strSimbol = [NSString stringWithCharacters:&simbol length:1];

    //    for(int i = 0; i < 1; i++){
    //        int numberObject = 0;
    //        for(NSArray*array in self.manager.mainArray){
    //            if(array.count == i){
    //                [self printArrayObject:array];
    //                NSLog(@" numberObject = %d i = %d",numberObject,i);
    //                //[mainArrayMut removeObjectAtIndex:numberObject];
    //            }
    //            numberObject++;
    //        }
    //    }
    //
    #pragma mark - Check at ziro String
    //
    //    int numberObject = 0;
    //    for(NSArray*array in self.manager.mainArray){
    //        for(NSString*string in array){
    //            if([string isEqualToString:@""])
    //                NSLog(@" string equal - ziro:  numberObject = %d ",numberObject);
    //        }
    //        numberObject++;
    //    }






//
                                   //    int j = 0;
                                   //    for(NSArray*array in self.manager.mainArray){
                                   //        int i = 0;
                                   //        for(NSString*string in array){
                                   //            if([string isEqualToString:@""]){
                                   //                NSLog(@"");
                                   //                [self printArrayObject: mainArrayMut[j]];
                                   //                NSMutableArray*arrayMut = [NSMutableArray arrayWithArray:array];
                                   //                [arrayMut removeObjectAtIndex:i];
                                   //                [mainArrayMut replaceObjectAtIndex:j withObject:[NSArray arrayWithArray:arrayMut]];
                                   //                NSLog(@" j = %d i = %d",j,i);
                                   //                [self printArrayObject:mainArrayMut[j]];
                                   //            }
                                   //            i++;
                                   //        }
                                   //        j++;
                                   //    }


//
//void (^blockWithotString) (NSArray *, int, NSArray *) = ^(NSArray *array, int j, NSArray *arrayMain){
//    for(NSString*string in array){
//        if([string isEqualToString:@""]){
//            NSLog(@" j = %d ",j);
//            [weakSelf printArrayObject:array];
//        }
//    }
//};


//
//[self arrayWithoutString:self.manager.mainArray block:blockWithotString];
//
//[self arrayWithoutString:self.manager.mainArray block:^(NSArray *array, int j, NSArray *arrayMain) {
//    for(NSString*string in array){
//        if([string isEqualToString:@""]){
//            NSLog(@" j = %d ",j);
//            [weakSelf printArrayObject:array];
//        }
//    }
//}];

    //////////////////////////

    //        if(i == 0)
    //            [mainArrayMut addObject:array];
    //
    //
    //        BOOL firstInsert = YES;
    //
    //        for(int k = 0; k < string.length; k++){
    //            unichar simbol = [string characterAtIndex:k];
    //            int simInt = [string characterAtIndex:k];
    //            NSString*strSimbol = [NSString stringWithCharacters:&simbol length:1];
    //
    //            if([strSimbol isEqualToString:@"#"]){
    //                if(firstInsert){
    //                    NSLog(@"");
    //                    NSLog(@"object j = %d  i = %d, string = %@",j,i,string);
    //                }
    //                firstInsert = NO;
    //
    //                NSMutableArray*arrayMut = [NSMutableArray arrayWithArray:mainArrayMut[j]];
    //                NSMutableString*stringMut = [NSMutableString stringWithString:arrayMut[i]];
    //                [stringMut replaceCharactersInRange:NSMakeRange(k, 1) withString:@" "];
    //                [arrayMut replaceObjectAtIndex:i withObject:[NSString stringWithString:stringMut]];
    //                [mainArrayMut replaceObjectAtIndex:j withObject:[NSArray arrayWithArray:arrayMut]];
    //
    //                if([stringMut componentsSeparatedByString:@"#"].count == 1){
    //                    NSLog(@"object j = %d  i = %d, string = %@",j,i,stringMut);
    //                    [weakSelf printArrayObject:array];
    //                    [weakSelf printArrayObject:arrayMut];
    //                }
    //            }
    //        }

//if(i == 0)
//[mainArrayMut addObject:array];
//BOOL firstIn = YES;
//
//for(int k = 0; k < string.length; k++){
//
//    unichar simbol = [string characterAtIndex:k];
//    int simInt = [string characterAtIndex:k];
//    NSString*strSimbol = [NSString stringWithCharacters:&simbol length:1];
//
//    unichar firstSimbol = [string characterAtIndex:0];
//    int firstSimInt = [string characterAtIndex:0];
//    NSString*strFirstSimbol = [NSString stringWithCharacters:&firstSimbol length:1];
//
//    unichar lastSimbol = [string characterAtIndex:string.length-1];
//    int lastSimInt = [string characterAtIndex:string.length-1];
//    NSString*strLastSimbol = [NSString stringWithCharacters:&lastSimbol length:1];
//
//    NSLog(@"object j = %d  i = %d, string = %@",j,i,string);
//    [weakSelf printArrayObject:array];
//    NSLog(@"");
//}

// BOOL beginReplaseWhiteInClosurRound = NO;
//BOOL beginReplaseWhiteInClosurQuarte = NO;
//if([strSimbol isEqualToString:@"("])
//beginReplaseWhiteInClosurRound = YES;
//if([strSimbol isEqualToString:@")"])
//beginReplaseWhiteInClosurRound = NO;
//if([strSimbol isEqualToString:@"["])
//beginReplaseWhiteInClosurQuarte = YES;
//if([strSimbol isEqualToString:@"]"])
//beginReplaseWhiteInClosurQuarte = NO;
//if(beginReplaseWhiteInClosurRound || beginReplaseWhiteInClosurQuarte){
//    if([strSimbol isEqualToString:@" "]){
//
//        NSMutableString*stringMut = [NSMutableString stringWithString:mainArrayMut[j][i] ];
//        [stringMut replaceCharactersInRange:NSMakeRange(k, 1) withString:@"#"];
//        NSMutableArray*arrayMut = [NSMutableArray arrayWithArray:mainArrayMut[j] ];
//        [arrayMut replaceObjectAtIndex:i withObject:[NSString stringWithString: stringMut]];
//        [mainArrayMut replaceObjectAtIndex:j withObject:[NSArray arrayWithArray:arrayMut]];


//if(firstIn && [strFirstSimbol isEqualToString:@"["] && i == 2 && ((NSString*)array[0]).length + ((NSString*)array[1]).length > string.length){
//    firstIn = NO;
    //        if(i==0 && ![string isEqualToString:@""]){
    //            unichar simbol = [string characterAtIndex:0];
    //            int simInt = [string characterAtIndex:0];
    //            NSString*strSimbol = [NSString stringWithCharacters:&simbol length:1];
    //
    //            unichar simbolNext;
    //            int simIntNext;
    //            NSString*strSimbolNext;
    //
    //            if(1 < string.length){
    //                simbolNext = [string characterAtIndex:1];
    //                simIntNext = [string characterAtIndex:1];
    //                strSimbolNext = [NSString stringWithCharacters:&simbolNext length:1];
    //            }
    //
    //            if([strSimbol isEqualToString:@"["]  && ![strSimbolNext isEqualToString:@"■"]){
    //                NSMutableArray*arrayMut = [NSMutableArray arrayWithArray:mainArrayMut[j-1]];
    //                [arrayMut addObjectsFromArray:array];
    //                mainArrayMut[j-1] = [NSArray arrayWithArray:arrayMut];
    //                [mainArrayMut replaceObjectAtIndex:j withObject:[NSArray new]];
    //
    //                //self.manager.mainArray = [NSArray arrayWithArray:mainArrayMut];
    //
    //                NSLog(@"object j = %d  i = %d, string = %@",j,i,string);
    //
    //                NSLog(@" [self printArrayObject:arrayMain[j-1]]");
    //                [self printArrayObject:mainArrayMut[j-1]];
    //                NSLog(@" [self printArrayObject:arrayMain[j]]");
    //                [self printArrayObject:mainArrayMut[j]];
    //                NSLog(@" [self printArrayObject:array");
    //                [self printArrayObject:array];
    //                NSLog(@"");
    //            }
    //        }



    //                                    BOOL firstIn = YES;
    //                                    //BOOL oneYesFirst = NO;
    //                                    //BOOL oneYesLast = NO;
    //                                    BOOL flagRus = YES;
    //
    //                                    for(int k = 0; k < string.length; k++){
    //
    //                                        unichar simbol = [string characterAtIndex:k];
    //                                        int simInt = [string characterAtIndex:k];
    //                                        NSString*strSimbol = [NSString stringWithCharacters:&simbol length:1];
    //
    //                                        unichar simbolNext;
    //                                        int simIntNext;
    //                                        NSString*strSimbolNext;
    //
    //                                        if(k+1 < string.length){
    //                                            simbolNext = [string characterAtIndex:k+1];
    //                                            simIntNext = [string characterAtIndex:k+1];
    //                                            strSimbolNext = [NSString stringWithCharacters:&simbolNext length:1];
    //                                        }
    //
    //                                        unichar firstSimbol = [string characterAtIndex:0];
    //                                        int firstSimInt = [string characterAtIndex:0];
    //                                        NSString*strFirstSimbol = [NSString stringWithCharacters:&firstSimbol length:1];
    //
    //                                        unichar lastSimbol = [string characterAtIndex:string.length-1];
    //                                        int lastSimInt = [string characterAtIndex:string.length-1];
    //                                        NSString*strLastSimbol = [NSString stringWithCharacters:&lastSimbol length:1];
    //
    //                                        //if(k == 1 && simbol > 64 && simbol < 123)
    //                                            //flagRus = NO;
    //
    //
    //                                        if([strSimbol isEqualToString:@"-"] && ![strFirstSimbol isEqualToString:@"["] && ![strFirstSimbol isEqualToString:@"("]
    //                                                && [strFirstSimbol isEqualToString:@"«"]){ //&& flagRus && [strSimbolNext isEqualToString:@" "] ){
    //                                                    //firstIn = NO;
    //                                                    NSLog(@"object j = %d  i = %d, string = %@",j,i,string);
    //                                                    //[self printArrayObject:array];
    //                                                    NSLog(@"");
    //
    ////                                            NSMutableString*mutString = [NSMutableString stringWithString:string];
    ////                                            [mutString deleteCharactersInRange:NSMakeRange(k, 2)];
    ////
    ////                                            NSMutableArray*arrayMut = [NSMutableArray arrayWithArray:array];
    ////                                            arrayMut[i] = [NSString stringWithString: [NSMutableString stringWithString: mutString]];
    ////
    ////                                            [mainArrayMut replaceObjectAtIndex:j withObject:[NSArray arrayWithArray:arrayMut]];
    ////
    ////
    ////
    ////                                            NSLog(@"object j = %d  i = %d, string = %@",j,i,mutString);
    ////                                                //[self printArrayObject:array];
    ////                                            NSLog(@"");
    //
    //                                        }
    //                                    }

    // if([strSimbol isEqualToString:@"]"] && ![strFirstSimbol isEqualToString:@"("] && ![strFirstSimbol isEqualToString:@"["] && firstIn){
    //if([strSimbol isEqualToString:@"="] && ![strFirstSimbol isEqualToString:@"("] && ![strFirstSimbol isEqualToString:@"["] && firstIn
//    //     && [strLastSimbol isEqualToString:@"="]){
//if([strSimbol isEqualToString:@"["])
//oneYesFirst = !oneYesFirst;
//if([strSimbol isEqualToString:@"]"])
//oneYesLast = !oneYesLast;


//if(oneYesFirst != oneYesLast){
//    NSLog(@"object j = %d  i = %d, string = %@",j,i,string);
//    [self printArrayObject:array];
//    NSLog(@"");
//}


    //                                                unichar firstSimbol = [string characterAtIndex:0];
    //                                                int firstSimInt = [string characterAtIndex:0];
    //
    //                                                NSString*strFirstSimbol = [NSString stringWithCharacters:&firstSimbol length:1];
    //
    //                                                unichar lastSimbol = [string characterAtIndex:string.length-1];
    //                                                int lastSimInt = [string characterAtIndex:string.length-1];
    //
    //                                                NSString*strLastSimbol = [NSString stringWithCharacters:&lastSimbol length:1];
    //
    //
    //
    //                                                if(firstSimbol > 1040 && firstSimbol < 1103 && lastSimbol > 64 && lastSimbol < 123){
    //                                                    if(j==7355)
    //                                                        j=7355;
    //
    //                                                    NSLog(@"object j = %d  i = %d, string = %@",j,i,string);
    //                                                    [self printArrayObject:array];
    //                                                    NSLog(@"");
    //
    //                                                }


//if(j==25550)
//j=25550;

//unichar firstSimbol = [string characterAtIndex:0];
//
//NSString*strFirstSimbol = [NSString stringWithCharacters:&firstSimbol length:1];
//
//unichar lastSimbol = [string characterAtIndex:string.length-1];
//
//NSString*strLastSimbol = [NSString stringWithCharacters:&lastSimbol length:1];
//
//
//
//if(firstSimbol > 64 && firstSimbol < 123 && lastSimbol > 1040 && lastSimbol < 1103){
//        // >= 1040 &&  <= 1103
//        //( > 64 && < 123)



//сделать с нечетными так же-

//if([string integerValue] && [string integerValue] >= 20 && [string integerValue] < 500 )
    //    NSInteger num1 = [string integerValue];
    //    NSInteger num = [[array lastObject] integerValue];
    //    if(num % 2 != 0 && num > 0 ){
    //        NSString *word = arrayMain[j+1][3];
    //        unichar asciiCode = [word characterAtIndex:0];
    //        NSString*str = [NSString stringWithCharacters:&asciiCode length:1];
    //        if([str isEqualToString:@"["]){
    //            NSLog(@"object j = %d  i = %d, string = %@",j,i,string);
    //            [self printArrayObject:array];
    //            NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-----num = %ld",(long)num1);
    //            [self printArrayObject:arrayMain[j+1]];
    //            NSLog(@"--------------------------------------------");
    //            NSLog(@"");
    //            NSLog(@"");
    //
    //
    //            NSMutableArray*arrayTempMain = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];
    //            NSMutableArray*arrayWordsTempAtMain = [NSMutableArray arrayWithArray:array];
    //            [arrayWordsTempAtMain removeLastObject];
    //            [arrayTempMain replaceObjectAtIndex:j withObject:arrayWordsTempAtMain];
    //
    //            NSMutableArray*arrayWordsTempAtMain1 = [NSMutableArray arrayWithArray:arrayTempMain[j+1]];
    //            [arrayWordsTempAtMain1 removeObjectAtIndex:0];
    //            [arrayTempMain replaceObjectAtIndex:j+1 withObject:arrayWordsTempAtMain1];
    //
    //            self.manager.mainArray = arrayTempMain;
    //
    //        }
    //    }
    //                                                  NSString*strPred2 = array[array.count-3];
    //                                                    int k = [strPred2 characterAtIndex:0];
    //                                                  if(k>64 && k<123){
    //                                                    NSLog(@"object j = %d  i = %d, string = %@",j,i,string);
    //                                                    NSLog(@" ");
    //                                                    [self printArrayObject:array];
    //                                                    NSLog(@"--------------------------------------------");
    //                                                        //[self printArrayObject:arrayMain[j+1]];
    //
    //                                                    NSMutableArray*arrayTempMain = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];
    //                                                    NSMutableArray*arrayWordsTempAtMain = [NSMutableArray arrayWithArray:array];
    //                                                    [arrayWordsTempAtMain removeLastObject];
    //                                                    [arrayWordsTempAtMain removeLastObject];
    //                                                    [arrayTempMain replaceObjectAtIndex:j withObject:arrayWordsTempAtMain];
    //                                                    self.manager.mainArray = arrayTempMain;
//                                                        [self printArray:mainArray]; //171,179
//if(j == 4932 && [string isEqualToString:@"17поддерживать"]){
//    [self printArrayObject:array];
//    NSMutableArray*arrayTempMain = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];
//    NSMutableArray*arrayWordsTempAtMain = [NSMutableArray arrayWithArray:array];
//    arrayWordsTempAtMain[140] = @"17";
//    [arrayWordsTempAtMain insertObject:@"поддерживать" atIndex:141];
//    [arrayTempMain replaceObjectAtIndex:j withObject:arrayWordsTempAtMain];
//    self.manager.mainArray = arrayTempMain;
//}


/*
-(void)saveArray{
    NSError*errorData = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self.manager.mainArray format:NSPropertyListXMLFormat_v1_0 options:0 error:&errorData];
    if(errorData!=nil)
        NSLog(@"error :%@",[errorData description]);
    NSString *fileNameData = @"arrayCommit.txt";
    NSString *pathData = [@"/Users/ryavkinto/Documents/Objective C/1" stringByAppendingPathComponent:fileNameData];
    [[NSFileManager defaultManager] createFileAtPath:@"/Users/ryavkinto/Documents/Objective C/1/arrayCommit.txt" contents:nil attributes:nil];
    [data writeToFile:pathData atomically:YES];
}
*/

-(AVMainManager*)manager{
    if(!_manager)
        _manager = [AVMainManager managerData];
    return _manager;
}


-(void)printArrayMain:(NSArray*)arrayMain{
    int i = 0;
    for(NSArray*array in arrayMain){
        NSLog(@"-----------------------object %d",i);
        i++;
        for(NSString*str in array){
            if([str isEqualToString:@" "])
                NSLog(@"------------------------------- ");
            else
                NSLog(@"-----%@",str);
        }
    }
}


-(void)printArrayObject:(NSArray*)array{
        for(NSString*str in array){
            if([str isEqualToString:@" "])
                NSLog(@"------------------------------- ");
            else
                NSLog(@"-----%@",str);
        }
}


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


-(void)printArrayObject:(NSArray*)array andNumCheck:(int) numCheck{
    int i = 0;
    for(NSString*str in array){
        if([str isEqualToString:@" "] || [str isEqualToString:@""] )
            NSLog(@"------------------------------- ");
        else if(i==numCheck)
            NSLog(@"-------------------------------------------%@",str);
        else
            NSLog(@"-----%@",str);
        i++;
    }
}


//-(void)array:(NSArray*)arrayMain block: (void(^)(NSString*string,NSArray*array,int i,int j,NSArray*arrayMain)) block{

-(void)array:(NSArray*)arrayMain block: (BlockExecution) block andBlockExecutInExternCycle: (void(^)(NSArray*array,int j,NSArray*mainArray)) blockEnt{
    int j = 0;
    for(NSArray*array in arrayMain){
         if(blockEnt)
            blockEnt(array,j,arrayMain);
        int i = 0;
        for(NSString*str in array){
            if(block)
                block(str,array,i,j,arrayMain);
            i++;
        }
        j++;
    }
}

-(void)arrayWithoutString:(NSArray*)arrayMain block:(void(^)(NSArray *array, int j, NSArray *arrayMain)) block{
    int j = 0;
    for(NSArray*array in arrayMain){
        block(array,j,arrayMain);
        j++;
    }
}

@end
