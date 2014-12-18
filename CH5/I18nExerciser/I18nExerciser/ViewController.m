/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *currentLanguage;
@property (weak, nonatomic) IBOutlet UILabel *currentLocale;
@property (weak, nonatomic) IBOutlet UILabel *currentCalendar;
@property (weak, nonatomic) IBOutlet UILabel *currentDate;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshListing) name:NSCurrentLocaleDidChangeNotification object:nil];
    [self setUpHomeScreen];
}

-(void)viewDidAppear:(BOOL)animated{
    [self setUpHomeScreen];
}

-(void)viewDidLayoutSubviews{
    [_currentDate setNumberOfLines:0];
    [_currentDate sizeToFit];
}

-(void)setUpHomeScreen{
    [self refreshListing];
    
    UIImage *myImage = [UIImage imageNamed:@"HomeScreen.jpg"];
    UIImage *flippedImage = [UIImage imageWithCGImage:myImage.CGImage
                                        scale:myImage.scale
                                  orientation:UIImageOrientationUpMirrored];
    
    if ([[[NSLocale preferredLanguages] firstObject]  isEqual: @"he"]) {
        self.imageView.image = flippedImage;
    }else{
        self.imageView.image = myImage;
    }
    
    NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:locale];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    self.currentDate.text = [formatter stringFromDate:date];
}

-(void)refreshListing{
    self.currentLanguage.text = [[NSLocale preferredLanguages] firstObject];
    self.currentLocale.text = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    self.currentCalendar.text = [[[[NSLocale currentLocale] objectForKey:NSLocaleCalendar] calendarIdentifier] capitalizedString];
}

@end
