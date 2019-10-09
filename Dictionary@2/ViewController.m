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

    NSMutableArray*mainArray = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];

    [self array:mainArray block:^(NSString *string, NSArray *array, int i, int j, NSArray *arrayMain) {
        if([string integerValue] && [string integerValue]>11){
            //NSLog(@"j = %d,  i = %d, string = %@",j,i,string);
            //[self printArrayObject:array];
        }
            }];

    //[self printArray:mainArray]; //171,179

}

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


-(void)array:(NSArray*)arrayMain block: (void(^)(NSString*string,NSArray*array,int i,int j,NSArray*arrayMain))block{

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
