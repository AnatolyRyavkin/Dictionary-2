//
//  TableViewController.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 01/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//
//nameTextFileInBandle

#import "TableViewController.h"

static NSString* identifaerHeader = @"IdentifaerHeader";
NSString* const identifaerCell = @"identifaerCell";
static NSInteger rectObjects = 4;
NSString* const keyOffset = @"keyOffset";
NSString* const keyStartingPoint = @"keyStartingPoint";
NSInteger const offsetConst = 100;


@implementation UITableView (ReloadData)



-(void)reloadData:(UITextField*)textField{
    if(textField)
        textField.text = @"";
    [self reloadData];
}

@end

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize manager = _manager;


#pragma mark search


-(void)dealloc{
    NSLog(@"dealloc");
}

-(void)viewDidLoad{
    [super viewDidLoad];
}


-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if(self){
        UIBarButtonItem*barButtonEdit = [[UIBarButtonItem alloc]initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(beginEdit)];
        UIBarButtonItem*barDuttonSearch = [[UIBarButtonItem alloc]initWithTitle:@"SearchShow" style:UIBarButtonItemStylePlain target:self action:@selector(actionSearth:)];
        UIBarButtonItem*barBattonSaveArray = [[UIBarButtonItem alloc]initWithTitle:@"SaveArrayToFile" style:UIBarButtonItemStylePlain target:self action:@selector(saveArray)];
        barBattonSaveArray.tintColor = [UIColor redColor];
        UIBarButtonItem*empty = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        empty.width = 100;
        [self.navigationItem setRightBarButtonItems:@[barButtonEdit,barDuttonSearch,empty,barBattonSaveArray]];
        self.barDuttonSearch = barDuttonSearch;
        self.numberObject = 0;
        self.pointZiro = 0;
        self.flagGoUp = NO;
        [self loadTableAroundingForPoint:0 atOffset:offsetConst atStartingPoint:0];
    }
    return self;
}

-(void)saveArray{
    NSError*errorData = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self.manager.mainArray format:NSPropertyListXMLFormat_v1_0 options:0 error:&errorData];
    if(errorData!=nil)
        NSLog(@"error :%@",[errorData description]);

    NSString* nameFileForArrayWork = @"/Users/ryavkinto/Documents/Objective C/Dictionary@2/Dictionary@2/arrayCommit.txt";

//for real devace ->
    //NSString* nameTextFileInBandle = [[NSBundle mainBundle] pathForResource:@"arrayCommit.txt" ofType:nil];

    [[NSFileManager defaultManager] createFileAtPath:nameFileForArrayWork contents:nil attributes:nil];

    [data writeToFile:nameFileForArrayWork atomically:YES];

}

#pragma mark - New metod

-(void)loadForInputPoint:(NSInteger)inputPoint{
    NSDictionary*dictionary = [self prepareLoadTableAtPointInput:inputPoint];
    NSInteger offsetIntrestic = [[dictionary objectForKey:keyOffset] integerValue];
    NSInteger startingPoint = [[dictionary objectForKey:keyStartingPoint] integerValue];
    [self loadTableAroundingForPoint:inputPoint atOffset:offsetIntrestic atStartingPoint:startingPoint];
}

-(void)loadTableAroundingForPoint:(NSInteger) pointInput atOffset:(NSInteger)offset atStartingPoint:(NSInteger)startingPoint{
        self.arrayVisible = [NSArray arrayWithArray:[self.manager.mainArray subarrayWithRange:NSMakeRange(startingPoint, offset)]];
        [self.tableView reloadData];
    if(!self.flagGoUp)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:pointInput-startingPoint] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    else
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:pointInput-startingPoint] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self.tableView reloadData];
};

-(NSDictionary*)prepareLoadTableAtPointInput:(NSInteger)pointInput{
    NSInteger startPredPoint = pointInput - offsetConst/2;
    NSInteger startPoint = (startPredPoint < 0) ? 0 : startPredPoint;
    self.pointZiro = startPoint;
    NSInteger offsetIntrist = (startPoint + offsetConst > self.manager.mainArray.count) ? self.manager.mainArray.count - startPoint : offsetConst;
    NSDictionary*dictionary = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInteger:startPoint], keyStartingPoint, @(offsetIntrist), keyOffset, nil];
    return dictionary;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
         self.numberObject = [searchText integerValue];
         if(self.numberObject >=0 && self.numberObject <=37793){
             [self loadForInputPoint:self.numberObject];
        }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.placeholder = @"input number at object";
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.barDuttonSearch.title = @"SearchShow";
    self.barDuttonSearch.tintColor = [[UIColor blueColor]colorWithAlphaComponent:0.8];
    [searchBar removeFromSuperview];
    [self.tableView reloadData];
}


-(void)actionSearth:(UIBarButtonItem*)sender{
    if([sender.title isEqual: @"SearchShow"]){
        sender.title = @"SearchDown";
        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(200, 75, 400, 27)];
        searchBar.delegate = self;
        [[self.tableView superview] addSubview:searchBar];
        [searchBar becomeFirstResponder];
        self.searchBar = searchBar;
    }else{
        sender.title = @"SearchShow";
        sender.tintColor = [[UIColor blueColor]colorWithAlphaComponent:0.8];
    }
}


-(void)beginEdit{
    [self.textFieldEditRow removeFromSuperview];
    if(!self.tableView.indexPathForSelectedRow)
        self.tableView.editing = !self.tableView.editing;
    else
        self.tableView.editing = NO;
}

-(AVMainManager*)manager{
    if(!_manager)
        _manager = [AVMainManager managerData];
    return _manager;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayVisible.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray*arrTemp = (NSArray*)self.arrayVisible[section];
    NSInteger num = arrTemp.count;
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifaerCell];
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifaerCell];
    UIFont*font = [UIFont systemFontOfSize:22];
    cell.textLabel.font = font;
    cell.textLabel.text = [(NSArray*)self.self.arrayVisible[indexPath.section] objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.01];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *nameObject = [NSString stringWithFormat:@"Object %ld",(long)section+self.pointZiro];
    return nameObject;
}

- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    UITableViewHeaderFooterView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifaerHeader];
    if(!header)
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifaerHeader];
    if(section == self.numberObject - self.pointZiro)
        header.backgroundColor = [[UIColor purpleColor]colorWithAlphaComponent:1];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    if(section == self.numberObject - self.pointZiro && self.numberObject != 0){
        UILabel *myLabel = [[UILabel alloc] init];
        myLabel.frame = CGRectMake(10, 5, self.tableView.frame.size.width, 27);
        myLabel.font = [UIFont boldSystemFontOfSize:16];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
        myLabel.backgroundColor=[UIColor greenColor];
        [headerView addSubview:myLabel];
        return headerView;
    }
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(10, 5, CGRectGetWidth(self.tableView.frame), 27);
    myLabel.font = [UIFont boldSystemFontOfSize:16];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    myLabel.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.2];
    [headerView addSubview:myLabel];
    NSInteger x = CGRectGetMaxX(self.tableView.frame);
    AVButton*buttonAddRow = [[AVButton alloc]initWithFrame:CGRectMake(x-100, 5, 90, 27)];
    [buttonAddRow setTitle:@"addRow" forState:UIControlStateNormal];
    [buttonAddRow setTintColor: [UIColor blueColor]];
    buttonAddRow.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:0.7];
    [headerView addSubview:buttonAddRow];
    [buttonAddRow addTarget:self action:@selector(addRow:) forControlEvents:UIControlEventTouchDown];
    buttonAddRow.section = section;
    return headerView;
}


-(void)addRow:(AVButton*)button{

    NSMutableArray*arrVisTemp = [NSMutableArray arrayWithArray:self.arrayVisible];
    NSMutableArray*arrTemp = [NSMutableArray arrayWithArray:arrVisTemp[button.section]];
    [arrTemp insertObject:@"" atIndex:0];
    [arrVisTemp replaceObjectAtIndex:button.section withObject:arrTemp];
    self.arrayVisible = [NSArray arrayWithArray:arrVisTemp];

    NSMutableArray*arrayTempMain = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];
    NSMutableArray*arrayWordsTempAtMain = [NSMutableArray arrayWithArray:arrayTempMain[button.section + self.pointZiro]];
    [arrayWordsTempAtMain insertObject:@"" atIndex:0];
    [arrayTempMain replaceObjectAtIndex:button.section+self.pointZiro withObject:arrayWordsTempAtMain];
    self.manager.mainArray = arrayTempMain;
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:button.section]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];

}


#pragma mark - TableEdit

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!tableView.editing){

        self.indexPathForEditRow = indexPath;

        [self.textFieldEditRow removeFromSuperview];

        UITableViewCell*cell = [self.tableView cellForRowAtIndexPath:indexPath];

        self.cellEdit = cell;

        CGRect rect = cell.frame;

        self.textFieldEditRow = [[UITextField alloc]initWithFrame:rect];

        self.textFieldEditRow.autocapitalizationType = UITextAutocapitalizationTypeNone;

        UIFont*font = [UIFont systemFontOfSize:22];
        [self.textFieldEditRow setFont:font];

        self.textFieldEditRow.text = [NSString stringWithFormat:@"    %@",cell.textLabel.text];

        self.textFieldEditRow.textColor = [[UIColor redColor]colorWithAlphaComponent:0.8];

        [self.tableView addSubview:self.textFieldEditRow];

        self.textFieldEditRow.delegate = self;

        [self.textFieldEditRow becomeFirstResponder];
    }
}


-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return @"REMOVE";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSLog(@"indexPath = %@  pointZero = %li", indexPath,self.pointZiro);

        
        NSMutableArray*arrVisTemp = [NSMutableArray arrayWithArray:self.arrayVisible];
        NSMutableArray*arrTemp = [NSMutableArray arrayWithArray:arrVisTemp[indexPath.section]];
        [arrTemp removeObjectAtIndex:indexPath.row];
        [arrVisTemp replaceObjectAtIndex:indexPath.section withObject:arrTemp];
        self.arrayVisible = [NSArray arrayWithArray:arrVisTemp];

        NSMutableArray*arrayTempMain = [[NSMutableArray alloc]initWithArray:self.manager.mainArray];
        NSMutableArray*arrayWordsTempAtMain = [NSMutableArray arrayWithArray:arrayTempMain[indexPath.section + self.pointZiro]];
        [arrayWordsTempAtMain removeObjectAtIndex:indexPath.row];
        [arrayTempMain replaceObjectAtIndex:indexPath.section+self.pointZiro withObject:arrayWordsTempAtMain];
        self.manager.mainArray = arrayTempMain;
        [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        

    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
}

#pragma mark - UIScrollViewDelegat


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textFieldEditRow removeFromSuperview];
        NSInteger countVisibleFirst = self.tableView.indexPathsForVisibleRows.firstObject.section;
        NSInteger rectRealDown = offsetConst - countVisibleFirst;
        if(rectRealDown == rectObjects){
            [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
            NSInteger pointInput = self.pointZiro + countVisibleFirst;
            [self loadForInputPoint:pointInput];
        }
        if(countVisibleFirst == rectObjects && self.pointZiro > 0 ){
            [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
            self.flagGoUp = YES;
            NSInteger pointInput = self.pointZiro + countVisibleFirst;
            [self loadForInputPoint:pointInput];
        }
        self.flagGoUp = NO;
}

#pragma mark - textFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(range.location>3){
        self.cellEdit.textLabel.text = [self.cellEdit.textLabel.text stringByReplacingCharactersInRange:NSMakeRange(range.location-4, range.length) withString:string];
        return YES;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    UITableViewCell*cell = [self.tableView cellForRowAtIndexPath:self.indexPathForEditRow];
    [cell setSelected:YES];
}

-(UITableViewCell*)superCell:(UIView*)view{

    UIView*superView = [view superview];
    if(superView){
        if([superView isMemberOfClass:[UITableViewCell class]])
            return (UITableViewCell*)superView;
        else
            return [self superCell:superView];
    }
        return nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString*string = self.cellEdit.textLabel.text;

    NSLog(@"str1 = %@",self.manager.mainArray[0][0]);

    self.arrayVisible[self.indexPathForEditRow.section][self.indexPathForEditRow.row] = string;  ///!!!!!!! mutate main

    NSLog(@"str1 = %@",self.manager.mainArray[0][0]);


    [textField resignFirstResponder];

    UITableViewCell*cell = [self.tableView cellForRowAtIndexPath:self.indexPathForEditRow];
    [cell setSelected:NO];

    [self.tableView reloadData:textField];
    return YES;
}


@end
