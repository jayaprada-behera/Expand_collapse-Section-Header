//
//  UserFavViewController.m
//  FAQ
//
//  Created by jayaprada on 09/03/16.
//  Copyright © 2016 Aravind. All rights reserved.
//

#import "UserFavViewController.h"

@interface UserFavViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray      *sectionTitleArray;
    NSMutableDictionary *sectionContentDict;
    NSMutableArray      *arrayForBool;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic)NSMutableArray *mainArray;
@end

@implementation UserFavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialiseArray];
    [self.myTableView setTableHeaderView:[self tableViewHeader]];
    if (!sectionTitleArray) {
        sectionTitleArray = [NSMutableArray arrayWithObjects:@"Aachen", @"Berlin", @"Düren", @"Essen", @"Münster", nil];
    }
    if (!arrayForBool) {
        arrayForBool    = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO] , nil];
    }
    if (!sectionContentDict) {
        sectionContentDict  = [[NSMutableDictionary alloc] init];
        NSArray *array1     = [NSArray arrayWithObjects:@"bla 1", @"bla 2", @"bla 3", @"bla 4", nil];
        [sectionContentDict setValue:array1 forKey:[sectionTitleArray objectAtIndex:0]];
        NSArray *array2     = [NSArray arrayWithObjects:@"wurst 1", @"käse 2", @"keks 3", nil];
        [sectionContentDict setValue:array2 forKey:[sectionTitleArray objectAtIndex:1]];
        NSArray *array3     = [NSArray arrayWithObjects:@"banane", @"auto2", @"haus", @"eidechse", nil];
        [sectionContentDict setValue:array3 forKey:[sectionTitleArray objectAtIndex:2]];
        NSArray *array4     = [NSArray arrayWithObjects:@"hoden", @"pute", @"eimer", @"wichtel", @"karl", @"dreirad", nil];
        [sectionContentDict setValue:array4 forKey:[sectionTitleArray objectAtIndex:3]];
        NSArray *array5     = [NSArray arrayWithObjects:@"Ei", @"kanone", nil];
        [sectionContentDict setValue:array5 forKey:[sectionTitleArray objectAtIndex:4]];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)initialiseArray{
    
    
    
    self.mainArray = [[NSMutableArray alloc] initWithObjects:@"HOME",
                      @"INDIAN RECIPES",
                      @"INDIAN CUISINES",
                      @"INTERNATIONAL RECIPES",
                      @"POST RECIPE",
                      @"POST RECIEPE", nil];
    
    
}

#pragma mark - UITABLEVIEW DATASOURCE
-(UIView *)tableViewHeader{
    UILabel   *la = [[UILabel alloc]initWithFrame:CGRectMake(320, 100, 200, 60)];
    
    la.text = @"This is my music line";
   
    return la;
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sectionTitleArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[arrayForBool objectAtIndex:section] boolValue]) {
        return [[sectionContentDict valueForKey:[sectionTitleArray objectAtIndex:section]] count];
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    headerView.tag                  = section;
    headerView.backgroundColor      = [UIColor whiteColor];
    UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20-50, 50)];
    BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];
    if (!manyCells) {
        headerString.text = @"click to enlarge";
    }else{
        headerString.text = @"click again to reduce";
    }
    headerString.textAlignment      = NSTextAlignmentLeft;
    headerString.textColor          = [UIColor blackColor];
    [headerView addSubview:headerString];
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    
    //up or down arrow depending on the bool
    UIImageView *upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"upArrowBlack"] : [UIImage imageNamed:@"downArrowBlack"]];
    upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
    upDownArrow.frame               = CGRectMake(self.view.frame.size.width-40, 10, 30, 30);
    [headerView addSubview:upDownArrow];
    
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 50;
    }
    return 1;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
    if (!manyCells) {
        cell.textLabel.text = @"click to enlarge";
    }
    else{
        NSArray *content = [sectionContentDict valueForKey:[sectionTitleArray objectAtIndex:indexPath.section]];
        cell.textLabel.text = [content objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}

#pragma mark - gesture tapped
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.myTableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
