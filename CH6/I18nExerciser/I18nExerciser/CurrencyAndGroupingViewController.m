/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "CurrencyAndGroupingViewController.h"

@interface CurrencyAndGroupingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currencySymbol;
@property (weak, nonatomic) IBOutlet UILabel *currencyCode;
@property (weak, nonatomic) IBOutlet UILabel *thousandsSeparator;
@property (weak, nonatomic) IBOutlet UILabel *decimalCharacter;

@end

@implementation CurrencyAndGroupingViewController

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
    [self currencyAndSeparators];
}

-(void)currencyAndSeparators{
    self.currencySymbol.text = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
    self.currencyCode.text = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode];
    self.thousandsSeparator.text = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator] isEqual:@" "] ? @"<space>" : [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    self.decimalCharacter.text = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
}

@end
