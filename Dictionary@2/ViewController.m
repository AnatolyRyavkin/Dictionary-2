//
//  ViewController.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 29/09/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSMutableArray*arrayEnObjects;
@end

@implementation ViewController

@synthesize manager = _manager;

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

    //dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        //[self printArray:self.manager.mainArray];
    //});
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray*mainArray = [[NSArray alloc]initWithArray:self.manager.mainArray];
        NSMutableArray*mainArrayMut = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];

    [self array:self.manager.mainArray block: ^(NSString *string, NSArray *array, int i, int j, NSArray *arrayMain) {



    }];

    //self.manager.mainArray = [NSArray arrayWithArray:mainArrayMut];
}


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


-(void)printArray:(NSArray*)arrayMain{
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


-(void)array:(NSArray*)arrayMain block: (void(^)(NSString*string,NSArray*array,int i,int j,NSArray*arrayMain)) block{

    int j = 0;
    for(NSArray*array in arrayMain){
        int i = 0;
        for(NSString*str in array){
            block(str,array,i,j,arrayMain);
            i++;
        }
        j++;
    }
}

@end
