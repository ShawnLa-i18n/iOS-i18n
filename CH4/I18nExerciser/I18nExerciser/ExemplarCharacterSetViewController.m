/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "ExemplarCharacterSetViewController.h"

@interface ExemplarCharacterSetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *localeIdentifier;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSString *entireList;
@end

@implementation ExemplarCharacterSetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.localeIdentifier.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self.view setMultipleTouchEnabled:YES];
    self.textView.text = @"Enter a valid locale identifier.";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:self.localeIdentifier.text];
    NSCharacterSet *exemplarCharacterSet = [locale objectForKey: NSLocaleExemplarCharacterSet];
    [self logCharacterSet:exemplarCharacterSet];
    self.textView.text = self.entireList;
    
    UIFont *systemFont = [UIFont systemFontOfSize:12.0f];
    UIFont *newFont =     [systemFont fontWithSize:18.0f];
    self.textView.font = newFont;
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void) logCharacterSet:(NSCharacterSet*)characterSet{
    NSMutableArray *charSetArray = [NSMutableArray new];
    self.entireList = @"";
    
    // Loop through Unicode values
    for (unichar ucValue = 0; ucValue < (0xFFFF); ucValue ++)
    {
        if ([characterSet characterIsMember:ucValue])
        {
            NSString * characters = [NSString stringWithCharacters:&ucValue length:1];
            [charSetArray addObject:characters];
            self.entireList = [self.entireList stringByAppendingString:characters];
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)aNotification{
    // the keyboard is showing so resize the table's height
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y -= 140;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification{
    // the keyboard is hiding reset the table's height
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y += 140;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

@end

