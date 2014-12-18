/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "MeasurementsViewController.h"

@interface MeasurementsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *measurementSystem;
@property (weak, nonatomic) IBOutlet UILabel *usesMetricSystem;

@end

@implementation MeasurementsViewController

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
    [self measurementSystems];
}

-(void)measurementSystems{
    self.measurementSystem.text = [[NSLocale autoupdatingCurrentLocale] objectForKey:NSLocaleMeasurementSystem];
    if([[[NSLocale autoupdatingCurrentLocale] objectForKey:NSLocaleUsesMetricSystem]  isEqual: @0]){
        self.usesMetricSystem.text = @"NO";
    }else{
        self.usesMetricSystem.text = @"YES";
    }
}

@end
