/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "ContactNameViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface ContactNameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *contactListing;

@end

@implementation ContactNameViewController

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
    [self createRecord];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self createRecord];
}
-(void)createRecord{
    NSString *first = @"John";
    NSString *last = @"Locke";
    
    self.firstName.text = first;
    self.lastName.text = last;
    
    ABRecordRef  record = ABPersonCreate();
    ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFStringRef)first, NULL);
    ABRecordSetValue(record, kABPersonLastNameProperty, (__bridge CFStringRef)last, NULL);
    
    //Need to change the language, not the region setting
    //Name 'swap' occurs with Japanese, Chinese Traditional, Chinese Simplified, and Korean
    self.contactListing.text = (__bridge NSString *)ABRecordCopyCompositeName(record);
    CFRelease(record);
}

@end
