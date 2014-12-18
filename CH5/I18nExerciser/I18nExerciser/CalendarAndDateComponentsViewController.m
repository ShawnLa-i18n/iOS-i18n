/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "CalendarAndDateComponentsViewController.h"

@interface CalendarAndDateComponentsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentCalendar;
@property (weak, nonatomic) IBOutlet UILabel *currentDate;
@property (weak, nonatomic) IBOutlet UILabel *componentDay;
@property (weak, nonatomic) IBOutlet UILabel *componentMonth;
@property (weak, nonatomic) IBOutlet UILabel *componentYear;

@end

@implementation CalendarAndDateComponentsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshListing) name:NSCurrentLocaleDidChangeNotification object:nil];
    [self currentCalendarAndDate];
}

-(void)viewDidLayoutSubviews{
    [_currentDate setNumberOfLines:0];
    [_currentDate sizeToFit];
}

-(void)currentCalendarAndDate{
    NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"EEEE, MMM dd, yyyy"];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if ([[[[NSLocale currentLocale] objectForKey:NSLocaleCalendar] calendarIdentifier] isEqualToString:@"gregorian"]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    } else if ([[[[NSLocale currentLocale] objectForKey:NSLocaleCalendar] calendarIdentifier] isEqualToString:@"japanese"]){
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSJapaneseCalendar];
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    } else if ([[[[NSLocale currentLocale] objectForKey:NSLocaleCalendar] calendarIdentifier] isEqualToString:@"buddhist"]){
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSBuddhistCalendar];
        components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    }
    
    self.currentCalendar.text =  [[[NSLocale autoupdatingCurrentLocale] objectForKey:NSLocaleCalendar] calendarIdentifier];
    self.currentDate.text = [formatter stringFromDate:date];
    self.componentDay.text = [NSString stringWithFormat:@"%ld", (long)[components day]];
    self.componentMonth.text = [NSString stringWithFormat:@"%ld", (long)[components month]];
    self.componentYear.text = [NSString stringWithFormat:@"%ld", (long)[components year]];
}

-(void)refreshListing{
    [self currentCalendarAndDate];
}

@end
