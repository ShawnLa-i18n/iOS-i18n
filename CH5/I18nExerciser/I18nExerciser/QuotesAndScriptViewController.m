/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "QuotesAndScriptViewController.h"

@interface QuotesAndScriptViewController ()
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *scriptCode;
@property (weak, nonatomic) IBOutlet UILabel *variantCode;
@property (nonatomic, strong) NSLocale *locale;

@end

@implementation QuotesAndScriptViewController

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
    self.locale = [NSLocale currentLocale];
    [self quotedText];
    [self scriptAndVariantCodes];
}

-(void)viewDidLayoutSubviews{
    [_quoteLabel setNumberOfLines:0];
    [_quoteLabel sizeToFit];
}

-(void)quotedText{
    NSString *quotedString = NSLocalizedString(@"Remember a panda eats shoots and leaves.", @"String used to demo quotation marks");
    NSString *beginningQuote = [self.locale objectForKey:NSLocaleQuotationBeginDelimiterKey];
    NSString *endingQuote = [self.locale objectForKey:NSLocaleQuotationEndDelimiterKey] ;
    self.quoteLabel.text = [quotedString stringByAppendingString:endingQuote];
    self.quoteLabel.text = [beginningQuote stringByAppendingString:self.quoteLabel.text];
}

-(void)scriptAndVariantCodes{
    if (![self.locale objectForKey: NSLocaleScriptCode]) {
        self.scriptCode.text = NSLocalizedString(@"No Script code for current locale.", @"Error message if there is no script code");
    }else{
        self.scriptCode.text = [self.locale objectForKey: NSLocaleScriptCode];
    }
    if (![self.locale objectForKey: NSLocaleVariantCode]) {
        self.variantCode.text = NSLocalizedString(@"No Variant code for current locale.", @"Error message if there is no variant code");
    }else{
       self.variantCode.text = [self.locale objectForKey: NSLocaleVariantCode];
    }
}

@end
