/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "StringsUpperLowerViewController.h"

@interface StringsUpperLowerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *upperCaseResult;
@property (weak, nonatomic) IBOutlet UILabel *lowercaseResult;
@property (weak, nonatomic) IBOutlet UILabel *capitalizeResult;

@end

@implementation StringsUpperLowerViewController

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
    [self makeYourCase];
}

-(void)viewDidLayoutSubviews{
    [_upperCaseResult setNumberOfLines:0];
    [_upperCaseResult sizeToFit];
    [_lowercaseResult setNumberOfLines:0];
    [_lowercaseResult sizeToFit];
    [_capitalizeResult setNumberOfLines:0];
    [_capitalizeResult sizeToFit];
}

-(void)makeYourCase{
    NSString *subjectString = @"The boy threw the ball.";
    NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
    
    self.upperCaseResult.text = [subjectString uppercaseStringWithLocale:locale];
    self.lowercaseResult.text = [subjectString lowercaseStringWithLocale:locale];
    self.capitalizeResult.text = [subjectString capitalizedStringWithLocale:locale];
}

@end
