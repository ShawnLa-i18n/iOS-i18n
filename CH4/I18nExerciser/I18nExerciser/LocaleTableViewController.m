/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "LocaleTableViewController.h"
#import "QuotesAndScriptViewController.h"
#import "CalendarAndDateComponentsViewController.h"
#import "CurrencyAndGroupingViewController.h"
#import "ContactNameViewController.h"
#import "SortingViewController.h"
#import "DateAndTimeViewController.h"
#import "NumberFormatterViewController.h"
#import "MeasurementsViewController.h"
#import "StringsUpperLowerViewController.h"
#import "DateFormatterViewController.h"
#import "ExemplarCharacterSetViewController.h"

@interface LocaleTableViewController ()<UITableViewDelegate>
@property (nonatomic, strong) NSArray *listing;

@end

@implementation LocaleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    
    self.listing = @[@"Measurement System",
                     @"Quotes and Scripts",
                     @"Date Components and Calendar",
                     @"Date Formatter",
                     @"Date - String to Object", //JSON response
                     @"Number Formatting",
                     @"Contact Names",
                     @"String Case",
                     @"Sorting",
                     @"Exemplar Character Set"];
}

#pragma mark - UITableView delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listing count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.listing objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
         case 0:
            [self loadMeasurementsVC];
            break;
            
        case 1:
            [self loadQuotesAndScriptsVC];
            break;
            
        case 2:
            [self loadCalendarAndDateComponentsVC];
            break;
            
        case 3:
            [self loadDateFormatterVC];
            break;
            
        case 4:
            [self loadDateAndTimeVC];
            break;
            
        case 5:
            [self loadNumberFormattingVC];
            break;
            
        case 6:
            [self loadContactNameViewController];
            break;
            
        case 7:
            [self loadStringsUpperLowerVC];
            break;
            
        case 8:
            [self loadSortingViewController];
            break;
            
        case 9:
            [self loadExemplarCharSetVC];
            break;
            
        default:
            break;
    }
}

#pragma mark - Load View Controllers Methods
-(void)loadDateAndTimeVC{
    DateAndTimeViewController *dateAndTimeVC = [[DateAndTimeViewController alloc] init];
    [self.navigationController pushViewController:dateAndTimeVC animated:YES];
}

-(void)loadQuotesAndScriptsVC{
    QuotesAndScriptViewController *quotesAndScriptVC = [[QuotesAndScriptViewController alloc] init];
    [self.navigationController pushViewController:quotesAndScriptVC animated:YES];
}

-(void)loadCalendarAndDateComponentsVC{
    CalendarAndDateComponentsViewController *calendarAndDateComponentsVC = [[CalendarAndDateComponentsViewController alloc] init];
    [self.navigationController pushViewController:calendarAndDateComponentsVC animated:YES];
}

-(void)loadCurrencyAndGroupingViewController{
    CurrencyAndGroupingViewController *currencyAndGroupingVC = [[CurrencyAndGroupingViewController alloc] init];
    [self.navigationController pushViewController:currencyAndGroupingVC animated:YES];
}
-(void)loadContactNameViewController{
    ContactNameViewController *contactNameVC = [[ContactNameViewController alloc] init];
    [self.navigationController pushViewController:contactNameVC animated:YES];
}
-(void)loadSortingViewController{
    SortingViewController *sortingVC = [[SortingViewController alloc] init];
    [self.navigationController pushViewController:sortingVC animated:YES];
}
-(void)loadNumberFormattingVC{
    NumberFormatterViewController *numberFormattingVC = [[NumberFormatterViewController alloc] init];
    [self.navigationController pushViewController:numberFormattingVC animated:YES];
}

-(void)loadMeasurementsVC{
    MeasurementsViewController *measurementsVC = [[MeasurementsViewController alloc] init];
    [self.navigationController pushViewController:measurementsVC animated:YES];
}

-(void)loadStringsUpperLowerVC{
    StringsUpperLowerViewController *stringCaseVC = [[StringsUpperLowerViewController alloc] init];
    [self.navigationController pushViewController:stringCaseVC animated:YES];
}

-(void)loadDateFormatterVC{
    DateFormatterViewController *dateFormatterVC = [[DateFormatterViewController alloc] init];
    [self.navigationController pushViewController:dateFormatterVC animated:YES];
}

-(void)loadExemplarCharSetVC{
    ExemplarCharacterSetViewController *exemplarCharacterSetVC = [[ExemplarCharacterSetViewController alloc] init];
    [self.navigationController pushViewController:exemplarCharacterSetVC animated:YES];
}

@end
