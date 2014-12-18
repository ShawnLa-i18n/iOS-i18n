/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "DateAndTimeViewController.h"
NSString *const dateURL = @"http://date.jsontest.com/";

@interface DateAndTimeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *jsonTime;
@property (weak, nonatomic) IBOutlet UILabel *jsonDate;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeZone;
@property (nonatomic, strong) NSMutableDictionary *dateDictionary;
@property (weak, nonatomic) IBOutlet UILabel *timeZoneTime;

@end

@implementation DateAndTimeViewController

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
    [self setTimeZone];
    [self JSONRequest];
    [self calculateCurrentTime];
}

-(void)JSONRequest{
    
    NSData *dateData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:dateURL]];
    NSError *error;
    self.dateDictionary = [NSJSONSerialization JSONObjectWithData:dateData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"Error %@", error);
    } else{
        self.jsonDate.text = self.dateDictionary[@"date"];
        self.jsonTime.text = self.dateDictionary[@"time"];
    }
}

-(void)setTimeZone{
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    self.currentTimeZone.text = [currentTimeZone name];
}

-(void)calculateCurrentTime{
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]];

    NSString *dateStr1 = [self.dateDictionary[@"date"] stringByAppendingString:@" "];
    NSString *dateStr = [dateStr1 stringByAppendingString:self.dateDictionary[@"time"]];
    
    NSDateFormatter *dateFormatterUS = [[NSDateFormatter alloc] init];
    [dateFormatterUS setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatterUS setDateFormat:@"MM-dd-yyyy hh:mm:ss a"];
    NSDate *dateUS = [dateFormatterUS dateFromString:dateStr];
    
    NSDate *date = [NSDate date];
    date = dateUS;
    
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    
    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date] ;
    
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setLocale:locale];
    [dateFormatters setDateFormat:@"hh:mm:ss a"];
    [dateFormatters setDateStyle:NSDateFormatterShortStyle];
    [dateFormatters setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatters setDoesRelativeDateFormatting:YES];
    [dateFormatters setTimeZone:[NSTimeZone systemTimeZone]];
    
    self.timeZoneTime.text = [dateFormatters stringFromDate: destinationDate];
}

@end
