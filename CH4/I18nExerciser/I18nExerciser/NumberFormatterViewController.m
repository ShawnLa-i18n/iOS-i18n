/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "NumberFormatterViewController.h"

@interface NumberFormatterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *decimalFormat;
@property (weak, nonatomic) IBOutlet UILabel *currencyFormat;
@property (weak, nonatomic) IBOutlet UILabel *spelledOutFormat;
@property (weak, nonatomic) IBOutlet UILabel *percentFormat;

@end

@implementation NumberFormatterViewController

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
    [self setNumberFormats];
}

-(void)viewDidLayoutSubviews{
    [_spelledOutFormat setNumberOfLines:0];
    [_spelledOutFormat sizeToFit];
}

-(void)setNumberFormats{
    NSNumber *number = @4815.1623;
    NSNumber *percentNumber = @0.2342;
    
    self.currencyFormat.text = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterCurrencyStyle];
    self.decimalFormat.text  = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterDecimalStyle];

    self.percentFormat.text = [NSNumberFormatter localizedStringFromNumber:percentNumber numberStyle:NSNumberFormatterPercentStyle];
    self.spelledOutFormat.text  = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterSpellOutStyle];
}

@end
