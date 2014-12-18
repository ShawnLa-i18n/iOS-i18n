/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "DateFormatterViewController.h"

@interface DateFormatterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *noFormatDate;
@property (nonatomic, weak) IBOutlet UILabel *shortFormatDate;
@property (nonatomic, weak) IBOutlet UILabel *mediumFormatDate;
@property (nonatomic, weak) IBOutlet UILabel *longFormatDate;
@property (nonatomic, weak) IBOutlet UILabel *fullFormatDate;
@property (nonatomic, weak) IBOutlet UILabel *noFormatTime;
@property (nonatomic, weak) IBOutlet UILabel *shortFormatTime;
@property (nonatomic, weak) IBOutlet UILabel *mediumFormatTime;
@property (nonatomic, weak) IBOutlet UILabel *longFormatTime;
@property (nonatomic, weak) IBOutlet UILabel *fullFormatTime;
@end

@implementation DateFormatterViewController

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
    [self setDateFormatExamples];
    [self setTimeFormatExamples];
}

-(void)viewDidLayoutSubviews{
    [_fullFormatDate setNumberOfLines:0];
    [_fullFormatDate sizeToFit];
    [_fullFormatTime setNumberOfLines:0];
    [_fullFormatTime sizeToFit];    
}

-(void)setDateFormatExamples{
    self.noFormatDate.text = [self formattedDateTime:0 justTime:NO];
    self.shortFormatDate.text = [self formattedDateTime:1 justTime:NO];
    self.mediumFormatDate.text = [self formattedDateTime:2 justTime:NO];
    self.longFormatDate.text = [self formattedDateTime:3 justTime:NO];
    self.fullFormatDate.text = [self formattedDateTime:4 justTime:NO];
}

-(NSString *)formattedDateTime:(int)dateStyleIndex justTime:(BOOL)justTime{
    int dateStyle[] = {NSDateFormatterNoStyle, NSDateFormatterShortStyle, NSDateFormatterMediumStyle, NSDateFormatterLongStyle, NSDateFormatterFullStyle};

    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
    
    if (justTime) {
        [dateFormatter setTimeStyle:dateStyle[dateStyleIndex]];
        
    }else{
        [dateFormatter setDateStyle:dateStyle[dateStyleIndex]];
    }
    return [dateFormatter stringFromDate:date];
}

-(void)setTimeFormatExamples{
    self.noFormatTime.text = [self formattedDateTime:0 justTime:YES];
    self.shortFormatTime.text = [self formattedDateTime:1 justTime:YES];
    self.mediumFormatTime.text = [self formattedDateTime:2 justTime:YES];
    self.longFormatTime.text = [self formattedDateTime:3 justTime:YES];
    self.fullFormatTime.text = [self formattedDateTime:4 justTime:YES];
}

@end
