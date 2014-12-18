/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "RightToLeftVC.h"

@interface RightToLeftVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation RightToLeftVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.textAlignment = NSTextAlignmentNatural;
    
}

@end
