//
//  ViewController.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 29/09/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "ViewController.h"
#import "AVMakeBASE.h"
#import "AVSeparateStringAtComma.h"


#define NSLOGSTRING NSLog(@"- - - - - - -  object j = %d  i = %d, string = %@",j,i,string);
#define NSLOGS NSLog(@"- - - - - - -  object j = %d  string = %@",j,string);
#define PRINT_OBJECT [self printArrayObject:array];
#define PRINT_OBJECT_SELECT [weakSelf printArrayObject:array andSelectRow:i];
#define PRINT_OBJECT_COUNT_ATTEMP_countAttemp int i = 0; for(NSString*string in array){if(countAttemp <= i) break; NSLog(@"%@",string);i++;}

#define AVL NSLog(@"");
#define AV NSLog(@"-------------------------------");

@interface ViewController ()

@property NSMutableArray*arrayEnObjects;

@end


@implementation ViewController

@synthesize manager = _manager,sharedMeaningShortWords = _sharedMeaningShortWords;

-(void)dealloc{
    NSLog(@"dealloc ViewController");
}


#pragma mark - JSON1

-(NSArray*)makeJSONFromArrayObjectsAVEngWord1: (NSArray<AVEnglWord*>*) arrayEngWordObjects{

    NSMutableArray*tempJSON = [NSMutableArray new];

    int count = 0;

    for(AVEnglWord *objectEngWord in arrayEngWordObjects){

        count++;

        NSMutableArray* arrayRusMeaningObject = [NSMutableArray new];

        if(objectEngWord.arrayRusMeaning.count > 0){

            for(AVRusMeaning *rusMeaning in objectEngWord.arrayRusMeaning){

                if(rusMeaning == nil)
                    continue;

                NSMutableDictionary*dictionaryRusMeaning = [NSMutableDictionary new];

                NSMutableArray* arrayExample = [NSMutableArray new];

                if(rusMeaning.arrayExample != nil && rusMeaning.arrayExample.count > 0){

                    for(AVExample *example in rusMeaning.arrayExample){

                        if(example == nil)
                            continue;

                        NSMutableDictionary*dictionaryExample = [NSMutableDictionary new];

                        if(example.meaning != nil && ![example.meaning isEqualToString:@""])
                            [dictionaryExample setObject: example.meaning forKey: meaningExampleKey];

                        if(example.accessory != nil && ![example.accessory isEqualToString:@""])
                            [dictionaryExample setObject: example.accessory forKey: accessoryExampleKey];

                        if(dictionaryExample != nil)
                            [arrayExample addObject: [NSDictionary dictionaryWithDictionary: dictionaryExample] ];

                    }
                }


                if(arrayExample.count > 0 )
                    [dictionaryRusMeaning setObject:arrayExample forKey:arrayExampleRusMeaningKey];

                if(rusMeaning.arrayMeaning != nil && rusMeaning.arrayMeaning.count > 0)
                    [dictionaryRusMeaning setObject: [NSArray arrayWithArray:rusMeaning.arrayMeaning] forKey: arrayMeaningRusMeaningKey];

                if(rusMeaning.accessory != nil && rusMeaning.accessory.count > 0)
                    [dictionaryRusMeaning setObject: [NSArray arrayWithArray:rusMeaning.accessory] forKey: accessoryRusMeaningKey];

                if(rusMeaning.dereviative != nil && ![rusMeaning.dereviative isEqualToString:@""])
                    [dictionaryRusMeaning setObject: rusMeaning.dereviative forKey: dereviativeRusMeaningKey];

                if(dictionaryRusMeaning != nil)
                    [arrayRusMeaningObject addObject: [NSMutableDictionary dictionaryWithDictionary: dictionaryRusMeaning] ];

            }
        }

        NSMutableDictionary*dictionaryObjectEngWord = [NSMutableDictionary new];

        [dictionaryObjectEngWord setObject: [NSNumber numberWithInteger: objectEngWord.indexPathMeaningWord.numberGlobalMeaning] forKey: indexPathGlobalKey];
        [dictionaryObjectEngWord setObject: [NSNumber numberWithInteger: objectEngWord.indexPathMeaningWord.numberLocalMeaning] forKey: indexPathLocalKey];
        [dictionaryObjectEngWord setObject: [NSNumber numberWithInteger: objectEngWord.indexPathMeaningWord.countMeaningInObject] forKey: indexPathCountKey];

        if(objectEngWord.selfType != nil && ![objectEngWord.selfType isEqualToString: @""])
            [dictionaryObjectEngWord setObject:objectEngWord.selfType forKey:typeObjectKey];

        if(objectEngWord.engMeaningObject != nil && ![objectEngWord.engMeaningObject isEqualToString: @""])
            [dictionaryObjectEngWord setObject:objectEngWord.engMeaningObject forKey:engMeaningObjectKey];

        if(objectEngWord.engTranscript != nil && ![objectEngWord.engTranscript isEqualToString: @""])
            [dictionaryObjectEngWord setObject:objectEngWord.engTranscript forKey:engTranscriptKey];

        if(objectEngWord.grammaticType != nil && objectEngWord.grammaticType.count > 0)
            [dictionaryObjectEngWord setObject:objectEngWord.grammaticType forKey:grammaticTypeKey];

        if(objectEngWord.grammaticForm != nil && objectEngWord.grammaticForm.count > 0)
            [dictionaryObjectEngWord setObject:objectEngWord.grammaticForm forKey:grammaticFormKey];

        if(objectEngWord.arrayIdiom != nil && objectEngWord.arrayIdiom.count > 0)
            [dictionaryObjectEngWord setObject:objectEngWord.arrayIdiom forKey:arrayIdiomKey];

        if(arrayRusMeaningObject != nil && arrayRusMeaningObject.count > 0)
            [dictionaryObjectEngWord setObject:[NSArray arrayWithArray:arrayRusMeaningObject] forKey:arrayRusMeaningKey];

        //[self printObjectJSON: [NSDictionary dictionaryWithDictionary: dictionaryObjectEngWord]];

        [tempJSON addObject: [NSDictionary dictionaryWithDictionary: dictionaryObjectEngWord] ];

    }

    return [NSArray arrayWithArray:tempJSON];

}

#pragma mark - Print Object JSON


-(void)printObjectJSON: (NSDictionary*) objectDictionaryJSON{
    AV AVL

    if([objectDictionaryJSON objectForKey:typeObjectKey]){
        NSLog(@"type object - %@",[objectDictionaryJSON objectForKey:typeObjectKey]);
    }

    NSLog(@"numberGlobalMeaning= %ld", [[objectDictionaryJSON objectForKey:indexPathGlobalKey] integerValue]);
    NSLog(@"numberLocalMeaning= %ld", [[objectDictionaryJSON objectForKey:indexPathLocalKey] integerValue]);
    NSLog(@"countMeaningInObject= %ld", [[objectDictionaryJSON objectForKey:indexPathCountKey] integerValue]);

    if( [objectDictionaryJSON objectForKey:engMeaningObjectKey]){
        NSLog(@"english meaning - %@",[objectDictionaryJSON objectForKey:engMeaningObjectKey]);
    }

    if( [objectDictionaryJSON objectForKey:engTranscriptKey]){
        NSLog(@"english transcription - %@",[objectDictionaryJSON objectForKey:engTranscriptKey]);
    }

    if( [objectDictionaryJSON objectForKey:grammaticTypeKey]){
        NSArray *arrayTemp = [objectDictionaryJSON objectForKey:grammaticTypeKey];
        int i = 1;
        for(NSString *stringTemp in arrayTemp){
            NSLog(@"grammatic Type (%d) - %@",i,stringTemp);
            i++;
        }
    }

    if( [objectDictionaryJSON objectForKey:grammaticFormKey]){
        NSArray *arrayTemp = [objectDictionaryJSON objectForKey:grammaticFormKey];
        int i = 1;
        for(NSString *stringTemp in arrayTemp){
            NSLog(@"grammatic Form (%d) - %@",i,stringTemp);
            i++;
        }
    }

    if( [objectDictionaryJSON objectForKey:arrayIdiomKey]){
        NSArray *arrayTemp = [objectDictionaryJSON objectForKey:arrayIdiomKey];
        int i = 1;
        for(NSString *stringTemp in arrayTemp){
            NSLog(@"idiom (%d) - %@",i,stringTemp);
            i++;
        }
    }

    if( [objectDictionaryJSON objectForKey:arrayRusMeaningKey]){
        
        NSArray *arryaTempRusObject = [objectDictionaryJSON objectForKey:arrayRusMeaningKey];
        int j = 1;
        for(NSDictionary *dictionaryTemp in arryaTempRusObject){

            if([dictionaryTemp objectForKey:arrayExampleRusMeaningKey]){
                NSArray *arrayExample = [dictionaryTemp objectForKey:arrayExampleRusMeaningKey];
                int i = 1;
                for(NSDictionary *dictionaryExample in arrayExample){

                    if( [dictionaryExample objectForKey: meaningExampleKey]){
                        NSLog(@"example (%d : %d) - %@",j,i,[dictionaryExample objectForKey: meaningExampleKey]);
                    }

                    if( [dictionaryExample objectForKey: accessoryExampleKey]){
                        NSLog(@"accessory for example (%d : %d) - %@",j,i,[dictionaryExample objectForKey: accessoryExampleKey]);
                    }
                    i++;
                }
            }

            if( [dictionaryTemp objectForKey:arrayMeaningRusMeaningKey]){
                NSArray *arrayTemp = [dictionaryTemp objectForKey:arrayMeaningRusMeaningKey];
                int i = 1;
                for(NSString *stringTemp in arrayTemp){
                    NSLog(@"rus meaning (%d : %d) - %@",j,i,stringTemp);
                    i++;
                }
            }

            if( [dictionaryTemp objectForKey:accessoryRusMeaningKey]){
                NSArray *arrayTemp = [dictionaryTemp objectForKey:accessoryRusMeaningKey];
                int i = 1;
                for(NSString *stringTemp in arrayTemp){
                    NSLog(@"accessory rus meaning (%d : %d) - %@",j,i,stringTemp);
                    i++;
                }
            }

            if( [dictionaryTemp objectForKey:dereviativeRusMeaningKey]){
                    NSLog(@"derevative (%d) - %@",j,[dictionaryTemp objectForKey:dereviativeRusMeaningKey]);
            }

            j++;

        }
    }
}

#pragma mark - Print Object JSON Onle Eng Meaning And RusMeaning

-(void)printObjectJSONOnleEngMeaningAndRusMeaning: (NSDictionary*) objectDictionaryJSON{
    AV AVL

    if( [objectDictionaryJSON objectForKey:engMeaningObjectKey]){
        NSLog(@"english meaning - %@",[objectDictionaryJSON objectForKey:engMeaningObjectKey]);
    }

    if( [objectDictionaryJSON objectForKey:arrayRusMeaningKey]){

        NSArray *arryaTempRusObject = [objectDictionaryJSON objectForKey:arrayRusMeaningKey];
        int j = 1;
        for(NSDictionary *dictionaryTemp in arryaTempRusObject){


            if( [dictionaryTemp objectForKey:arrayMeaningRusMeaningKey]){
                NSArray *arrayTemp = [dictionaryTemp objectForKey:arrayMeaningRusMeaningKey];
                int i = 1;
                for(NSString *stringTemp in arrayTemp){
                    NSLog(@"                                  rus meaning (%d : %d) - %@",j,i,stringTemp);
                    i++;
                }
            }

            j++;

        }
    }
}

#pragma mark - Print Object JSON


-(void)printObjectJSONWithShortWord: (NSDictionary*) objectDictionaryJSON{
    AV AVL

    if( [objectDictionaryJSON objectForKey:engMeaningObjectKey]){
        NSLog(@"                            english meaning - %@",[objectDictionaryJSON objectForKey:engMeaningObjectKey]);
    }

    if( [objectDictionaryJSON objectForKey:grammaticTypeKey]){
        NSArray *arrayTemp = [objectDictionaryJSON objectForKey:grammaticTypeKey];
        int i = 1;
        for(NSString *stringTemp in arrayTemp){
            NSLog(@"grammatic Type (%d) - %@",i,stringTemp);
            i++;
        }
    }

    if( [objectDictionaryJSON objectForKey:grammaticFormKey]){
        NSArray *arrayTemp = [objectDictionaryJSON objectForKey:grammaticFormKey];
        int i = 1;
        for(NSString *stringTemp in arrayTemp){
            NSLog(@"grammatic Form (%d) - %@",i,stringTemp);
            i++;
        }
    }

    if( [objectDictionaryJSON objectForKey:arrayRusMeaningKey]){

        NSArray *arryaTempRusObject = [objectDictionaryJSON objectForKey:arrayRusMeaningKey];
        int j = 1;
        for(NSDictionary *dictionaryTemp in arryaTempRusObject){

            if([dictionaryTemp objectForKey:arrayExampleRusMeaningKey]){
                NSArray *arrayExample = [dictionaryTemp objectForKey:arrayExampleRusMeaningKey];
                int i = 1;
                for(NSDictionary *dictionaryExample in arrayExample){

                    if( [dictionaryExample objectForKey: accessoryExampleKey]){
                        NSLog(@"accessory for example (%d : %d) - %@",j,i,[dictionaryExample objectForKey: accessoryExampleKey]);
                    }
                    i++;
                }
            }


            if( [dictionaryTemp objectForKey:accessoryRusMeaningKey]){
                NSArray *arrayTemp = [dictionaryTemp objectForKey:accessoryRusMeaningKey];
                int i = 1;
                for(NSString *stringTemp in arrayTemp){
                    NSLog(@"accessory rus meaning (%d : %d) - %@",j,i,stringTemp);
                    i++;
                }
            }

            j++;

        }
    }
}


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

        UIBarButtonItem*barButtonSeparateComma = [[UIBarButtonItem alloc]initWithTitle:@"BeginSeparateComma" style:UIBarButtonItemStylePlain target:self action:@selector(beginSeparateComma)];
        self.barButtonSeparateComma = barButtonSeparateComma;
        self.barButtonSeparateComma.enabled = NO;

        UIBarButtonItem*barButtonPrintRusMeaning = [[UIBarButtonItem alloc]initWithTitle:@"PrintRusMeaning" style:UIBarButtonItemStylePlain target:self action:@selector(outputRusMeaning)];
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: barButtonSeparateComma,barButtonPrintRusMeaning, nil]];
        self.barButtonPrintRusMeaning = barButtonPrintRusMeaning;
        self.barButtonPrintRusMeaning.enabled = NO;
        
    }
    return self;
}

#pragma mark - outputRusMeaning


-(void)outputRusMeaning{

    UITableView*tableRusMeaning = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableRusMeaning.delegate = self;
    tableRusMeaning.dataSource = self;

    tableRusMeaning.sectionHeaderHeight = 100;

    tableRusMeaning.rowHeight = 70;

    [self.view addSubview:tableRusMeaning];

}

#pragma mark - Table dataSourse and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger countRusObjects = 0;
    NSInteger countRusStrings = 0;
    if([self.JSONObjects[section] objectForKey:arrayRusMeaningKey]){
        NSArray *arrayRusObject = [self.JSONObjects[section] objectForKey:arrayRusMeaningKey];
        countRusObjects = arrayRusObject.count;
        for(NSDictionary *dictionaryRusObject in arrayRusObject){
            if([dictionaryRusObject objectForKey:arrayMeaningRusMeaningKey]){
                NSArray *arrayStrings = [dictionaryRusObject objectForKey:arrayMeaningRusMeaningKey];
                countRusStrings += arrayStrings.count;
            }
        }
    }
    return countRusObjects + countRusStrings;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierCell];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierCell];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor] ;


    NSInteger numberOutput = indexPath.row;
    NSInteger countRusObjects = 0;
    NSInteger countRusStrings = 0;

    NSString *stringOutput;

    if([self.JSONObjects[indexPath.section] objectForKey:arrayRusMeaningKey]){
        NSArray *arrayRusObject = [self.JSONObjects[indexPath.section] objectForKey:arrayRusMeaningKey];
        for(NSDictionary *dictionaryRusObject in arrayRusObject){
            if(countRusObjects + countRusStrings == numberOutput){
                stringOutput = [NSString stringWithFormat:@"                                                                                                                           %ld",countRusObjects];
                cell.textLabel.font = [UIFont systemFontOfSize:20];
                cell.textLabel.text = stringOutput;
                cell.contentView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.025];
                return  cell;
            }
            countRusObjects++;
            if([dictionaryRusObject objectForKey:arrayMeaningRusMeaningKey]){
                NSArray *arrayStrings = [dictionaryRusObject objectForKey:arrayMeaningRusMeaningKey];
                for(NSString*string in arrayStrings){
                    if(countRusObjects + countRusStrings == numberOutput){
                        cell.textLabel.font = [UIFont systemFontOfSize:30];
                        cell.textLabel.text = string;
                        cell.contentView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.05];
                        return  cell;
                    }
                    countRusStrings++;
                }
            }
        }
    }
    cell.contentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:1];
    cell.textLabel.text = @"      empty!!!!!!!!";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.JSONObjects.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView*viewHeader;
    UILabel *label;
    viewHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifierHeader];
    if(!viewHeader){
        viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1000, 100)];
        viewHeader.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.1];
        [viewHeader addSubview:[[UILabel alloc]initWithFrame:viewHeader.frame]];
    }
    label = viewHeader.subviews[0];
    [label setFont:[UIFont systemFontOfSize:50]];
    [label setText: ([self.JSONObjects[section] objectForKey:engMeaningObjectKey])
    ? [NSString stringWithFormat:@"%ld                       %@",section+0,[self.JSONObjects[section] objectForKey:engMeaningObjectKey]]
    :  [NSString stringWithFormat:@"%ld                    object have not england meaning",section]];

    return viewHeader;
}


-(void)inputTable{
    TableViewController*tvc = [[TableViewController alloc]initWithStyle:UITableViewStylePlain];
    [self showViewController:tvc sender:nil];

//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//        [self printArrayMain:self.manager.mainArray];
//    });

}

#pragma mark - BeginSeparateComma

-(void)beginSeparateComma{
    self.objectSeparateStringAtComma = [[AVSeparateStringAtComma alloc] initNavigationController:[self navigationController] andViewController:self];
    [self.objectSeparateStringAtComma changeJSON: self.JSONObjects];
}



#pragma mark - WriteInFile

-(void)writeJSONInFile:(NSArray *) arrayWriting{

    NSError*errorData = nil;

    NSData *data = [NSPropertyListSerialization dataWithPropertyList:arrayWriting format:NSPropertyListXMLFormat_v1_0 options:0 error:&errorData];

    if(errorData!=nil)
        NSLog(@"error :%@",[errorData description]);

    NSString* pathFileBase = @"/Users/ryavkinto/Documents/baseEnglishDictionary/fileBaseReady.txt";

    [[NSFileManager defaultManager] createFileAtPath:pathFileBase contents:nil attributes:nil];

    [data writeToFile:pathFileBase atomically:YES];

}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];

    //__weak ViewController*weakSelf = self;

    //NSMutableArray*mainArrayMut = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];

    //void(^blockInMainArray)(NSArray*,int,NSArray*) = ^(NSArray*array,int j,NSArray*mainArray){};

    //__block NSString*stringCheck = [NSString new];
   //__block BOOL flagInset = NO;

//    typeof(self) weakSelf = self;

//    __block int countVerb = 0;


    void(^block1)(NSArray *, int , NSArray *) = ^(NSArray *array, int j, NSArray *arrayMain) {

                for(NSString*string in array){
                    if(string.intValue > 100){
                        NSLog(@"j= %d",j);
                        PRINT_OBJECT
                        AVL
                    }
                }

    };


    dispatch_queue_t  _Nonnull d = dispatch_queue_create(NULL, DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_async(d, ^{

        AVCreateBaseObjects*cb = [[AVCreateBaseObjects alloc]init];

        NSArray<AVEnglWord*>* arrayObjects = [cb makeArrayEngFromMainArrayAtArrayWords:self.manager.mainArray];

//        NSArray *JSONMain = [self makeJSONFromArrayObjectsAVEngWord1:arrayObjects];
//
//        self.JSONObjects = JSONMain;
//
//        NSError*errorData = nil;
//
//        NSData *data = [NSPropertyListSerialization dataWithPropertyList:JSONMain format:NSPropertyListXMLFormat_v1_0 options:0 error:&errorData];
//
//        if(errorData!=nil)
//            NSLog(@"error :%@",[errorData description]);
//
//        NSString* pathFileBase = @"/Users/ryavkinto/Documents/baseEnglishDictionary/fileBase.txt";
//
//            //for real devace ->
//            //NSString* nameTextFileInBandle = [[NSBundle mainBundle] pathForResource:@"arrayCommit.txt" ofType:nil];
//
//        [[NSFileManager defaultManager] createFileAtPath:pathFileBase contents:nil attributes:nil];
//
//        [data writeToFile:pathFileBase atomically:YES];
//
//        dispatch_queue_main_t  _Nonnull d1 = dispatch_get_main_queue();
//        dispatch_async(d1, ^{
//            self.barButtonSeparateComma.enabled = YES;
//            self.barButtonPrintRusMeaning.enabled = YES;
//        });

    });



//    [self array:self.manager.mainArray block:nil andBlockExecutInExternCycle:block1];

}

#pragma mark - End












    //-(void)beginSeparateComma{
    //    NSLog(@"beginSeparateComma");
    //
    //    NSMutableArray *arrayMutableJSONNew = [NSMutableArray new];
    //
    //    NSDictionary*objectDictionaryJSON = self.JSONObjects[self.numberObjectRus];
    //    //for(NSDictionary*objectDictionaryJSON in self.JSONObjects){
    //
    //        NSMutableDictionary *objectMutableDictionaryJSON = [NSMutableDictionary new];
    //
    //        if([objectDictionaryJSON objectForKey:typeObjectKey]){
    //            [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:typeObjectKey]
    //                                            forKey:typeObjectKey];
    //        }
    //
    //        [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:indexPathGlobalKey]
    //                                        forKey:indexPathGlobalKey];
    //        [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:indexPathLocalKey]
    //                                        forKey:indexPathLocalKey];
    //        [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:indexPathCountKey]
    //                                        forKey:indexPathCountKey];
    //
    //
    //        if( [objectDictionaryJSON objectForKey:engMeaningObjectKey]){
    //            [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:engMeaningObjectKey]
    //                                            forKey:engMeaningObjectKey];
    //        }
    //
    //        if( [objectDictionaryJSON objectForKey:engTranscriptKey]){
    //            [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:engTranscriptKey]
    //                                            forKey:engTranscriptKey];
    //        }
    //
    //        if( [objectDictionaryJSON objectForKey:grammaticTypeKey]){
    //            [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:grammaticTypeKey]
    //                                            forKey:grammaticTypeKey];
    //        }
    //
    //        if( [objectDictionaryJSON objectForKey:grammaticFormKey]){
    //            [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:grammaticFormKey]
    //                                            forKey:grammaticFormKey];
    //        }
    //
    //        if( [objectDictionaryJSON objectForKey:arrayIdiomKey]){
    //            [objectMutableDictionaryJSON setObject:[objectDictionaryJSON objectForKey:arrayIdiomKey]
    //                                            forKey:arrayIdiomKey];
    //        }
    //
    //
    //        if( [objectDictionaryJSON objectForKey:arrayRusMeaningKey]){
    //
    //            NSArray *arryaRusObject = [objectDictionaryJSON objectForKey:arrayRusMeaningKey];
    //
    //            NSMutableArray *arrayMutableRusObject = [NSMutableArray new];
    //
    //            for(NSDictionary *dictionaryRusMeaning in arryaRusObject){
    //
    //                NSMutableDictionary *dictionaryMutableRusMeaning = [NSMutableDictionary dictionaryWithDictionary:dictionaryRusMeaning];
    //
    //                if( [dictionaryRusMeaning objectForKey:arrayMeaningRusMeaningKey]){
    //
    //                    NSArray *arrayMeaningRusMeaningOld = [dictionaryRusMeaning objectForKey:arrayMeaningRusMeaningKey];
    //
    //                    NSArray *arrayMeaningRusMeaningNew = [self separateArrayRusMeaning:arrayMeaningRusMeaningOld];
    //
    //                    [dictionaryMutableRusMeaning setObject:arrayMeaningRusMeaningNew forKeyedSubscript:arrayMeaningRusMeaningKey];
    //
    //                }
    //
    //                [arrayMutableRusObject addObject:[NSDictionary dictionaryWithDictionary:dictionaryMutableRusMeaning]];
    //
    //            }
    //
    //            [objectMutableDictionaryJSON setObject:[NSArray arrayWithArray:arrayMutableRusObject]
    //                                            forKey:arrayRusMeaningKey];
    //        }
    //
    //        [arrayMutableJSONNew addObject: [NSDictionary dictionaryWithDictionary:objectMutableDictionaryJSON]];
    //
    //    //}
    //
    //    //self.JSONObjectsReady = [NSArray arrayWithArray:arrayMutableJSONNew];
    //
    //    //[self writeJSONInFile: self.JSONObjectsReady];
    //
    //}
    //
    //#pragma mark - !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //
    //#pragma mark - SeparateArrayAtPoint
    //
    //-(NSArray *)separateArrayRusMeaning: (NSArray *) arrayOld{
    //
    //    NSMutableArray *arrayMutableNew = [NSMutableArray new];
    //
    //    NSString *stringOrigin = arrayOld[0];
    //    //for(NSString *stringOrigin in arrayOld){                                        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //        NSString* string = [NSString stringWithString:stringOrigin];
    //        if([[string lastCharString] isEqualToString:@","])
    //            string =  [string stringWithoutLastSimbol];
    //        if([[string firstCharString] isEqualToString:@","])
    //            string = [string stringWithoutFirstSimbol];
    //        NSArray *arraySeparateComma = [string componentsSeparatedByString:@","];
    //        if(arraySeparateComma.count == 1){
    //            [arrayMutableNew addObject:string];
    //        }else if(arraySeparateComma.count != 0){
    //            BOOL allStringIsSingle = YES;
    //            for(NSString *stringSeparateComma in arraySeparateComma){
    //                if( ([stringSeparateComma componentsSeparatedByString:@" "]).count != 1)
    //                    allStringIsSingle = NO;
    //            }
    //            if(allStringIsSingle){
    //               [arrayMutableNew addObjectsFromArray:arraySeparateComma];
    //            }else{
    //                AVSeparateStringAtComma *separStringComma = [[AVSeparateStringAtComma alloc] initNavigationController:[self navigationController] andViewController:self];
    //                arrayMutableNew = [NSMutableArray arrayWithArray: [separStringComma mutatingString:string]];
    //            }
    //        }
    //        return [NSArray arrayWithArray: arrayMutableNew];
    //    //}
    //    return arrayOld;
    //}

    //
    //-(NSArray*)makeJSONFromArrayObjectsAVEngWord: (NSArray<AVEnglWord*>*) arrayEngWordObjects{
    //
    //    NSMutableArray*tempJSON = [NSMutableArray new];
    //
    //    for(AVEnglWord *objectEngWord in arrayEngWordObjects){
    //
    //        NSMutableArray* arrayRusMeaningObject = [NSMutableArray new];
    //
    //        if(objectEngWord.arrayRusMeaning.count > 0){
    //        for(AVRusMeaning *rusMeaning in objectEngWord.arrayRusMeaning){
    //
    //            NSMutableArray* arrayExample = [NSMutableArray new];
    //
    //            if(rusMeaning.arrayExample.count > 0){
    //            for(AVExample *example in rusMeaning.arrayExample){
    //
    //                example.meaning = (example.meaning == nil) ? @"" : example.meaning;
    //                example.accessory = (example.accessory == nil) ? @"" : example.accessory;
    //
    //                NSDictionary*dictionaryExample = [NSDictionary dictionaryWithObjectsAndKeys:
    //
    //                                                example.meaning, meaningExampleKey,
    //                                                example.accessory, accessoryExampleKey,
    //
    //                                                     nil];
    //
    //                [arrayExample addObject: dictionaryExample];
    //
    //            }
    //            }else
    //                [arrayExample addObject:@""];
    //
    //            rusMeaning.arrayMeaning = (rusMeaning.arrayMeaning == nil) ? @[@""] : rusMeaning.arrayMeaning;
    //            rusMeaning.accessory = (rusMeaning.accessory == nil) ? @[@""] : rusMeaning.accessory;
    //            rusMeaning.dereviative = (rusMeaning.dereviative == nil) ? @"" : rusMeaning.dereviative;
    //
    //            NSDictionary*dictionaryRusMeaning = [NSDictionary dictionaryWithObjectsAndKeys:
    //
    //                                         rusMeaning.arrayMeaning, arrayMeaningRusMeaningKey,
    //                                         rusMeaning.accessory, accessoryRusMeaningKey,
    //                                         rusMeaning.dereviative, dereviativeRusMeaningKey,
    //                                         [NSArray arrayWithArray: arrayExample], arrayExampleRusMeaningKey,
    //
    //                                                 nil];
    //            [arrayRusMeaningObject addObject: dictionaryRusMeaning];
    //
    //        }
    //        }
    //
    //        objectEngWord.engMeaningObject = (objectEngWord.engMeaningObject == nil) ? @"" : objectEngWord.engMeaningObject;
    //        objectEngWord.engTranscript = (objectEngWord.engTranscript == nil) ? @"" : objectEngWord.engTranscript;
    //        objectEngWord.grammaticType = (objectEngWord.grammaticType == nil) ? @[@""] : objectEngWord.grammaticType;
    //        objectEngWord.grammaticForm = (objectEngWord.grammaticForm == nil) ? @[@""] : objectEngWord.grammaticForm;
    //        arrayRusMeaningObject = (arrayRusMeaningKey == nil) ? [NSMutableArray arrayWithArray: @[@""]] : arrayRusMeaningObject;
    //        objectEngWord.arrayIdiom = (objectEngWord.arrayIdiom == nil) ? @[@""] : objectEngWord.arrayIdiom;
    //        objectEngWord.arrayPhrasalVerb = (objectEngWord.arrayPhrasalVerb == nil) ? @[@""] : objectEngWord.arrayPhrasalVerb;
    //
    //        NSDictionary*dictionaryObjectEngWord = [NSDictionary dictionaryWithObjectsAndKeys:
    //
    //                            [NSNumber numberWithInteger: objectEngWord.indexPathMeaningWord.numberGlobalMeaning], indexPathGlobalKey,
    //                            [NSNumber numberWithInteger: objectEngWord.indexPathMeaningWord.numberLocalMeaning], indexPathLocalKey,
    //                            [NSNumber numberWithInteger: objectEngWord.indexPathMeaningWord.countMeaningInObject], indexPathCountKey,
    //                            objectEngWord.engMeaningObject, engMeaningObjectKey,
    //                            objectEngWord.engTranscript, engTranscriptKey,
    //                            objectEngWord.grammaticType, grammaticTypeKey,
    //                            objectEngWord.grammaticForm, grammaticFormKey,
    //                            [NSArray arrayWithArray:arrayRusMeaningObject], arrayRusMeaningKey,
    //                            objectEngWord.arrayIdiom, arrayIdiomKey,
    //                            @"", arrayPhrasalVerbKey,
    //
    //                                                    nil];
    //
    //        [tempJSON addObject:dictionaryObjectEngWord];
    //
    //    }
    //
    //    return [NSArray arrayWithArray:tempJSON];
    //
    //}


    #pragma mark - Check at ziro ArrayString - need incommiting and array.count = 0
//
//void(^block1)(NSArray *, int , NSArray *) = ^(NSArray *array, int j, NSArray *arrayMain) {
//    BOOL isNumberQueue = YES;
//    int firstNumber = 0;
//    int secondNumber = -1;
//    for(NSString*string in array){
//        secondNumber = string.intValue;
//        if( ((secondNumber > 0 && secondNumber < 10 && string.length == 1) || (secondNumber > 9 && secondNumber < 34 && string.length == 2)) ||
//           (((secondNumber > 0 && secondNumber < 10 && string.length == 2) || (secondNumber > 9 && secondNumber < 34 && string.length == 3)) && [[string lastCharString] isEqualToString:@":"])
//           ){
//            if(secondNumber - firstNumber == 1){
//                firstNumber = secondNumber;
//            }
//            else{
//                isNumberQueue = NO;
//                break;
//            }
//        }
//
//    }
//
//    if(!isNumberQueue){
//        NSLog(@"j= %d",j);
//        PRINT_OBJECT
//        AVL
//    }

    //
    //if( ([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2))
    //b = true;
    //
    //if(!b && ([string isEqualToString:@"от"] || [string isEqualToString:@"="]) && [array[numString - 1] isContaintEngChars]){
    //        //            if(([string isEqualToString:@"pl"] && [array[numString+1] isEqualToString:@"от"]) ||
    //        //            ([string isEqualToString:@"superl"] && [array[numString+1] isEqualToString:@"от"]) ||
    //        //            ([string isEqualToString:@"compare"] && [array[numString+1] isEqualToString:@"от"]) ||
    //        //            ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"от"]) ||
    //        //            ([string isEqualToString:@"p"] && [array[numString+1] isEqualToString:@"p"] && [array[numString+2] isEqualToString:@"от"]) ||
    //        //            ([string isEqualToString:@"косв"] && [array[numString+1] isEqualToString:@"падеж"] && [array[numString+2] isEqualToString:@"от"])){
    //    NSLog(@"               j=%d",j);



    //
    //                BOOL isNumberQueue = YES;
    //                int firstNumber = 0;
    //                int secondNumber = -1;
    //                for(NSString*string in array){
    //                    secondNumber = string.intValue;
    //                    if( ((secondNumber > 0 && secondNumber < 10 && string.length == 1) || (secondNumber > 9 && secondNumber < 340 && string.length == 2) ||
    //                       (secondNumber > 99 && secondNumber < 1000 && string.length == 3)) ||
    //                       (((secondNumber > 0 && secondNumber < 10 && string.length == 2) || (secondNumber > 9 && secondNumber < 340 && string.length == 3) ||
    //                         (secondNumber > 99 && secondNumber < 1000 && string.length == 4)) &&     [[string lastCharString] isEqualToString:@":"])
    //                       ){
    //                        if(secondNumber - firstNumber == 1){
    //                            firstNumber = secondNumber;
    //                        }
    //                        else{
    //                            isNumberQueue = NO;
    //                            break;
    //                        }
    //                    }
    //
    //                }
    //
    //                if(!isNumberQueue){
    //                    NSLog(@"j= %d",j);
    //                    PRINT_OBJECT
    //                    AVL
    //                }





    //    if( ([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2))
    //        b = true;
    //
    //    if([string isEqualToString:@"косв"]
    //
    //       ){
    //        a = true;
    //
    //            //if(!b && a && i == array.count - 1 ){
    //        PRINT_OBJECT_SELECT
    //        AVL
    //        AVL
    //            //}
    //    }

    //
    //    int i = 0;
    //        //typeof(self) weakSelf = self;
    //
    //    NSArray* arrayExeption =@[@"            "];
    //
    //    BOOL b = NO;
    //
    //    for(NSString*string in array){
    //
    //        if( ([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2))
    //            b = true;
    //        if(!b ){
    //
    //                //                    if([[string firstCharString] isEqualToString:@"("]){
    //                //
    //                //                        if(array.count  > i )
    //                //                            NSLog(@"        %@",array[i-1]);
    //                //
    //                //                            NSLog(@"    %@",array[i]);
    //                //
    //                //                        if(array.count  > i + 1)
    //                //                            NSLog(@"        %@",array[i+1]);
    //                //
    //                //                        if(array.count  > i + 2)
    //                //                            NSLog(@"        %@",array[i+2]);
    //                //
    //                //                        if(array.count  > i + 3)
    //                //                            NSLog(@"        %@",array[i+3]);
    //                //
    //                //                        NSLog(@"            j= %d",j);
    //                //                        AVL
    //                //                        AV
    //                //                        AVL
    //                //                    }
    //        }
    //
    //            // bool b = false;
    //            //            if( ([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2))
    //            //                b = true;
    //            //            if(!b){
    //        NSString *stringPost = (i < array.count - 1) ? array[i+1] : @" ";
    //            //
    //            //                NSString *stringPostPost = (i < array.count - 2) ? array[i+1] : @" ";
    //            //
    //            //
    //
    //            //                if( ([self.sharedMeaningShortWords.arrayShortRusPropertyAndWords containsObject:[stringPost stringWithoutLastSimbolIfSibolComma]] || [self.sharedMeaningShortWords.arrayShortRusPropertyAndWords containsObject: stringPost])) &&
    //            //                   ([self.sharedMeaningShortWords.arrayShortRusPropertyAndWords[1] isEqualToString:stringPost] ||
    //            //                    [self.sharedMeaningShortWords.arrayShortRusPropertyAndWords[1] isEqualToString:[stringPost stringWithoutLastSimbolIfSibolComma]]) )
    //
    //        if( (([string intValue] > 0 && [string intValue] < 10 && string.length == 1) || ([string intValue] > 9 && [string intValue] < 34 && string.length == 2) ||
    //             [ self.sharedMeaningShortWords.arrayShortWordGrammaticProperty containsObject:string] )){
    //
    //            if( [arrayExeption containsObject:[stringPost stringWithoutLastSimbolIfSibolComma]] || [arrayExeption containsObject: stringPost] ){
    //
    //
    //
    //                NSLog(@"        %@",array[i]);
    //                NSLog(@"  %@",array[i+1]);
    //                if(array.count  > i + 2)
    //                    NSLog(@"        %@",array[i+2]);
    //                if(array.count  > i + 3)
    //                    NSLog(@"        %@",array[i+3]);
    //                NSLog(@"            j= %d",j);
    //                AVL
    //                AV
    //                AVL
    //
    //            }
    //
    //                //проверить все на :!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //
    //
    //
    //        }
    //        i++;
    //    }

    //    void(^block1)(NSArray *, int , NSArray *) = ^(NSArray *array, int j, NSArray *arrayMain) {

    //
    //                    int i = 0;
    //                    typeof(self) weakSelf = self;
    //                    for(NSString*string in array){
    //                        if( i > 1){
    //                            if( ![array[i-1] intValue] && ![array[i-2] intValue]){
    //                                if(i < array.count - 2){
    //                                    if([string isEqualToString:@"pl"]){// && ![array[i+1] isContaintEngChars] && [array[i+1] isContaintRusChars]){
    //                                        AVL
    //                                        NSLog(@"--- j = %d",j);
    //                                        PRINT_OBJECT_SELECT
    //                                    }
    //                                }
    //                            }
    //                        }
    //                        i++;
    //                        }
    //    };


//
//if([string isEqualToString:@"pl"] && [array[i+1] isEqualToString:@"от"]){
//    AVL
//    NSLog(@"------------------------------------------ j = %d",j);
//        //                                                    NSLog(@" pred = %@",array[i-1]);
//        //                                                    NSLog(@" str = %@",array[i]);
//        //                                                    NSLog(@" post = %@",array[i+1]);
//    PRINT_OBJECT_SELECT
//}
//if([string isEqualToString:@"superl"] && [array[i+1] isEqualToString:@"от"]){
//    AVL
//    NSLog(@"------------------------------------------ j = %d",j);
//        //                                                    NSLog(@" pred = %@",array[i-1]);
//        //                                                    NSLog(@" str = %@",array[i]);
//        //                                                    NSLog(@" post = %@",array[i+1]);
//    PRINT_OBJECT_SELECT
//}
//if([string isEqualToString:@"compare"] && [array[i+1] isEqualToString:@"от"]){
//    AVL
//    NSLog(@"------------------------------------------ j = %d",j);
//        //                                                    NSLog(@" pred = %@",array[i-1]);
//        //                                                    NSLog(@" str = %@",array[i]);
//        //                                                    NSLog(@" post = %@",array[i+1]);
//    PRINT_OBJECT_SELECT
//}
//
//if([string isEqualToString:@"past"] && [array[i+1] isEqualToString:@"от"]){
//    AVL
//    NSLog(@"------------------------------------------ j = %d",j);
//        //                                                    NSLog(@" pred = %@",array[i-1]);
//        //                                                    NSLog(@" str = %@",array[i]);
//        //                                                    NSLog(@" post = %@",array[i+1]);
//    PRINT_OBJECT_SELECT
//}
//
//if([string isEqualToString:@"p"] && [array[i+1] isEqualToString:@"p"] && [array[i+2] isEqualToString:@"от"]){
//    AVL
//    NSLog(@"------------------------------------------ j = %d",j);
//        //                                                    NSLog(@" pred = %@",array[i-1]);
//        //                                                    NSLog(@" str = %@",array[i]);
//        //                                                    NSLog(@" post = %@",array[i+1]);
//    PRINT_OBJECT_SELECT
//}
//
//if([string isEqualToString:@"past"] && [array[i+1] isEqualToString:@"и"] && [array[i+2] isEqualToString:@"p"]){
//    AVL
//    NSLog(@"------------------------------------------ j = %d",j);
//        //                                                    NSLog(@" pred = %@",array[i-1]);
//        //                                                    NSLog(@" str = %@",array[i]);
//        //                                                    NSLog(@" post = %@",array[i+1]);
//    PRINT_OBJECT_SELECT
//}
//
//
//for(NSString*string in array){
//
//    if(string.intValue > 0 && string.intValue < 10 && string.length == 1){
//
//        if(string.intValue - num != 1 && num != 1){
//
//            AVL
//            NSLog(@"------------------------------------------ j = %d",j);
//            NSLog(@" pred = %@",array[i-1]);
//            NSLog(@" str = %@",array[i]);
//            NSLog(@" post = %@",array[i+1]);
//        }
//            //PRINT_OBJECT_SELECT
//        num = string.intValue;
//    }

        //                        unichar firstChar = [string characterAtIndex:0];
        //                        NSString*stringChar = [NSString stringWithCharacters:&firstChar length:1];
        //                        unichar firstPrevChar = (i > 0 ) ? [array[i-1] characterAtIndex:0] : ' ';
        //                        NSString*stringPrevChar = [NSString stringWithCharacters:&firstPrevChar length:1];
        //
        //                        if( [stringChar isEqualToString:@"("]  && [array[i-1] intValue]){
        //                            NSMutableCharacterSet*set = [[NSMutableCharacterSet alloc]init];
        //                            [set addCharactersInString:@"(),; "];
        //                            NSArray*ar = [string componentsSeparatedByCharactersInSet:set];
        //                            BOOL b = NO;
        //                            for(NSString* stCheck in ar){
        //                                for(NSString *st in self.sharedMeaningShortWords.arrayEngPredlog){
        //                                    if([stCheck isEqualToString:st]){
        //                                        b = YES;
        //                                    }
        //                                }
        //                            }
        //                            if(b && [string isContaintEngChars] && ![string isContaintRusChars] ){
        //                                AVL
        //                                NSLog(@"j = %d",j);
        //                                PRINT_OBJECT_SELECT
        //                            }
        //                        }

//    i++;
//}
    //
    //        //NSLog(@"str =  %@     %@",[@"012345" stringWithoutLastSimbol],[@"012345" stringWithoutFirstSimbol]);
    ////        int countClog = 0;
    ////        BOOL flagInsertClosur = NO;
    ////        BOOL flagInsertQuart = NO;
    //        int i = 0;
    //        typeof(self) weakSelf = self;
    //        for(NSString*string in array){
    //
    ////            unichar lastChar = [string characterAtIndex:string.length - 1];
    ////            NSString*stringlastChar = [NSString stringWithCharacters:&lastChar length:1];
    ////            //if([string isEqualToString:@"pres"] || [[string stringWithoutLastSimbolIfSibolComma] isEqualToString:@"pres"] ){
    ////            if([stringlastChar intValue] && string.length != 1 && i != 0 && ![string intValue]){
    //            unichar firstChar = [string characterAtIndex:0];
    //            NSString*stringChar = [NSString stringWithCharacters:&firstChar length:1];
    //            unichar firstPrevChar = (i > 0 ) ? [array[i-1] characterAtIndex:0] : ' ';
    //            NSString*stringPrevChar = [NSString stringWithCharacters:&firstPrevChar length:1];
    //                //if([string isEqualToString:@"pres"] || [[string stringWithoutLastSimbolIfSibolComma] isEqualToString:@"pres"] ){
    //            if(![string containsString:@"обычно"] && ![string containsString:@"множ.число"] && [stringChar isEqualToString:@"("] && ![stringPrevChar isEqualToString:@"["] && [self.sharedMeaningShortWords.arrayShortWordGrammaticProperty containsObject: array[i-1]]){
    //                NSMutableCharacterSet*set = [[NSMutableCharacterSet alloc]init];
    //                [set addCharactersInString:@"(),; "];
    //                NSArray*ar = [string componentsSeparatedByCharactersInSet:set];
    //                BOOL b = NO;
    //                for(NSString* stCheck in ar){
    //                    for(NSString *st in self.sharedMeaningShortWords.arrayEngPredlog){
    //                        if([stCheck isEqualToString:st]){
    //                            b = YES;
    ////                            AVL
    ////                            NSLog(@"j = %d",j);
    ////                            PRINT_OBJECT_SELECT
    //                        }
    //                    }
    //                }
    //                if(!b && ![string isContaintEngChars] && [string isContaintRusChars] ){
    //                    AVL
    //                    NSLog(@"j = %d",j);
    //                    PRINT_OBJECT_SELECT
    //                }
    //            }
    //
    //            i++;
    //        }

//
//if(([string isEqualToString:@"I"] || [string isEqualToString:@"II"] || [string isEqualToString:@"III"] || [string isEqualToString:@"IV"] || [string isEqualToString:@"V"] || [string isEqualToString:@"VI"]) && i == i){
//        //                NSString *stringNext = (i < array.count - 1) ? array[i+1] : @" ";
//        //                unichar firstChar = [stringNext characterAtIndex:0];
//        //                NSString*stringNextAtFirstChar = [NSString stringWithCharacters:&firstChar length:1];
//        //                if([stringNextAtFirstChar isEqualToString:@"["]){
//    NSString *stringPrev = (i > 0) ? array[i-1] : @" ";
//    unichar firstChar = [stringPrev characterAtIndex:0];
//    NSString*stringPrevAtFirstChar = [NSString stringWithCharacters:&firstChar length:1];
//    if([stringPrevAtFirstChar isEqualToString:@"["]){
//        NSLOGSTRING
//        AVL
//        PRINT_OBJECT_SELECT
//    }
//
//}

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
