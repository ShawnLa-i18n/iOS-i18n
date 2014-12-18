/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "Chapter03Snippets.h"

@implementation Chapter03Snippets
//Listing 3.1 Logging Out a Given Character Set
-(void) logCharacterSet:(NSCharacterSet*)characterSet{
    unichar charsetCharacters[10];
    int index = 0;
    
    // Loop through Unicode values
    for (unichar ucValue = 0; ucValue < (0xFFFF); ucValue ++){
        if ([characterSet characterIsMember:ucValue]){
            charsetCharacters[index] = ucValue;
            index ++;
            
            if (index == 5){
                NSString * characters = [NSString stringWithCharacters:charsetCharacters length:index];
                NSLog(@"%@", characters);
                index = 0;
            }
        }
    }
    
    if (index != 0){
        NSString * charactersFromLocale = [NSString stringWithCharacters:charsetCharacters length:index];
        NSLog(@"%@", charactersFromLocale);
    }
}

//Listing 3.2 Adding Observer to Update the Country Setting
- (void)viewDidLoad
{
	[super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCountryCode) name:NSCurrentLocaleDidChangeNotification object:nil];
}

-(void) refreshCountryCode {
	NSLocale *locale = [NSLocale currentLocale];
	NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
	NSLog(@"Country : %@",countryCode);
}

//Listing 3.3 Contact Name Order with Respect to Locale
-(void)createNewContactRecord{
	NSString *firstName = @"George";
	NSString *lastName = @"Washington";
    
	ABRecordRef  record = ABPersonCreate();
	ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFStringRef)firstName, NULL);
	ABRecordSetValue(record, kABPersonLastNameProperty, (__bridge CFStringRef)lastName, NULL);
    
	NSString *displayName = (__bridge_transfer NSString *)ABRecordCopyCompositeName(record);
	NSLog(@"Display name is: %@", displayName);
	CFRelease(record);
}

//Listing 3.4 NSNumberFormatter Example
-(void)numberFormatting{
	NSNumber *number = @15234.89;
	NSString *numberStr = [number stringValue];
	NSString *currencyNumber = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterCurrencyStyle];
	NSString *decimalNumber = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterDecimalStyle];
	NSString *percentSymbol = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterPercentStyle];
	NSString *spelledOutNumber = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterSpellOutStyle];
    
	NSLog(@"Formatting applied to the number '%@':\nCurrency format: %@\nDecimal format: %@\nPercent format: %@\nSpelled Out format: %@\n", numberStr,currencyNumber,decimalNumber,percentSymbol,spelledOutNumber);
}

//Listing 3.5 Demoing Date Format Constants
-(void)workWithDateFormatConstants{
    
    NSDate *date = [NSDate date];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hant"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:locale];
    
    NSString *dateAsString = [[NSString alloc] init];
    NSString *timeAsString = [[NSString alloc] init];
    
    int dateStyle[] = {NSDateFormatterShortStyle, NSDateFormatterNoStyle, NSDateFormatterFullStyle, NSDateFormatterLongStyle, NSDateFormatterMediumStyle};
    int timeStyle[] = {NSDateFormatterShortStyle, NSDateFormatterNoStyle, NSDateFormatterFullStyle, NSDateFormatterLongStyle, NSDateFormatterMediumStyle};
    
    for (int i = 0; i < 5;i++){
        [dateFormatter setDateStyle:dateStyle[i]];
        dateAsString = [dateFormatter stringFromDate:date];
        NSLog(@"Date: %@", dateAsString);
    }
    
    for (int i = 0; i < 5;i++){
        [dateFormatter setTimeStyle:timeStyle[i]];
        timeAsString = [dateFormatter stringFromDate:date];
        NSLog(@"Time: %@", timeAsString);
    }
}

//Listing 3.6 Applying a New Date Format
-(void)dateFromAString{
    NSString *dateString = @"08-27-2014";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // First you have to convert the string to a date object
    //and that date format needs to match
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSDate *dateFromDateString = [formatter dateFromString:dateString];
    
    // Now convert it to desired format
    [formatter setDateFormat:@"MMMM d, y"];
    
    NSString *stringFromDate = [formatter stringFromDate:dateFromDateString];
    
    NSLog(@"Date is: %@", dateFromDateString);
    NSLog(@"Date from string is: %@", stringFromDate);
}

//Listing 3.7 Sample Date Template to Display Month–Date Order
-(NSString *)localeMonthOrder:(NSString *)localeIdentifier{
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
	return [NSDateFormatter dateFormatFromTemplate:@"MMMMd" options:0 locale:locale];
}

//Listing 3.8 Creating Calendars
-(void)calendarTypes{
	NSCalendar *buddhist = [[NSCalendar alloc] initWithCalendarIdentifier:NSBuddhistCalendar];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendar *japanese = [[NSCalendar alloc] initWithCalendarIdentifier:NSJapaneseCalendar];
	NSLog(@"%@", buddhist.calendarIdentifier);
	NSLog(@"%@", gregorian.calendarIdentifier);
	NSLog(@"%@", japanese.calendarIdentifier);
}

//Listing 3.9 Converting a Date to Individual Components
-(void)datesToComponents{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:now];
    NSLog(@"Dates To Components");
    NSLog(@"Day: %ld", (long)[components day]);
    NSLog(@"Month: %ld", (long)[components month]);
    NSLog(@"Year: %ld", (long)[components year]);
}

//Listing 3.10 Converting Components to a Date
-(void)componentsToDates{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:2014];
    [components setMonth:7];
    [components setDay:19];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSLog(@"%0.0f seconds between Jan 1st, 2001 and July 19th, 2014", [date timeIntervalSinceReferenceDate]);
}

//Listing 3.11 Returning Time Zones from Specified Locales
-(void)timeZones{
    
	// UTC/GMT -7 hours
    NSTimeZone *mountainStandardTime = [NSTimeZone timeZoneWithAbbreviation:@"MST"];
    
	// UTC/GMT +8 hours
	NSTimeZone *perthTime = [NSTimeZone timeZoneWithName:@"Australia/Perth"];
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	// Hard coding values below to work with known values
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
	[formatter setLocale:locale];
	[formatter setDateFormat:@"yyyy-MM-dd h:mm a"];
	NSString *dateString = @"2014-02-02 8:35 PM";
    
	[formatter setTimeZone:mountainStandardTime];
	NSDate *eightPMInBillings = [formatter dateFromString:dateString];
	NSLog(@"GMT w/ Billings timezone: %@", eightPMInBillings);
    
	[formatter setTimeZone:perthTime];
	NSDate *eightInPerth = [formatter dateFromString:dateString];
	NSLog(@"GMT w/ Perth timezone: %@", eightInPerth);
}

//Listing 3.12 Calculating Time Difference Between Two Locales
-(void)timeZones{
	// UTC/GMT -7 hours
	NSTimeZone *mountainStandardTime = [NSTimeZone timeZoneWithAbbreviation:@"MST"];
    
	// UTC/GMT +8 hours
	NSTimeZone *perthTime = [NSTimeZone timeZoneWithName:@"Australia/Perth"];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	// Hard coding values below to work with known values
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
	[formatter setDateFormat:@"yyyy-MM-dd h:mm a"];
	NSString *dateString = @"2014-02-02 8:35 PM";
    
	[formatter setTimeZone:mountainStandardTime];
	NSDate *eightPMInBillings = [formatter dateFromString:dateString];
	NSLog(@"GMT w/ Billings timezone: %@", eightPMInBillings);
    
	[formatter setTimeZone:perthTime];
	NSDate *eightInPerth = [formatter dateFromString:dateString];
	NSLog(@"GMT w/ Perth timezone: %@", eightInPerth);
    
	//Date math to calculate hours.
	NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [[NSDateComponents alloc] init];
    
	if ([eightPMInBillings compare:eightInPerth] == NSOrderedAscending) {
        components = [calendar components:NSHourCalendarUnit fromDate:eightPMInBillings toDate:eightInPerth options:0];
        
	}else if ([eightPMInBillings compare:eightInPerth] == NSOrderedDescending) {
        components = [calendar components:NSHourCalendarUnit fromDate:eightInPerth toDate:eightPMInBillings options:0];
        
	}else{
        NSLog(@"Times are same!");
        return;
	}
    
	NSLog(@"Time difference is: %ld hours", (long)[components hour]);
}

//Listing 3.13 NSString initWithFormat:locale: Example
-(void)initFormattingTest:(float)num localeIdentifier:(NSString *) identifier{
	NSLocale *testLocale = [[NSLocale alloc] initWithLocaleIdentifier: identifier];
	NSString *formattedString = [[NSString alloc] initWithFormat:@"The number %1.3f respects our \"%@\" locale setting!" locale:testLocale, num, identifier ];
	NSLog(@"%@", formattedString);
}

//Listing 3.14 uppercaseStringWithLocale Example
-(void)capitalizedTestString:(NSString *)string localeIdentifer:(NSString *)identifier{
	NSLocale *testLocale = [[NSLocale alloc] initWithLocaleIdentifier: identifier];
	NSString *result = [string uppercaseString];
	NSString *resultWithLocale = [string uppercaseStringWithLocale:testLocale];
	
	NSLog(@"No locale argument: %@", result);
	NSLog(@"With locale argument: %@", resultWithLocale);
}


//Listing 3.15 Sample Code for the Locale Options of Searching Strings
-(BOOL)searchingString:(NSString *)sourceString searchString:(NSString *)searchString options:(NSStringCompareOptions)options localeIdentifer:(NSString *)localeIdentifier{
	NSRange range = NSMakeRange(0, [sourceString length]);
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
	if ([sourceString rangeOfString:searchString options:options range:range locale:locale].length > 0){
		NSLog(@"Substring found.");
		return YES;
	}else{
		NSLog(@"No substring found in source string.");
		return NO;
	};
}

//Listing 3.16 String Folding Example—Turkish “I”
-(void)folding{
    NSString *inputString = @"IŞIK";
    NSLog(@"Original string: %@", inputString);
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"];
    NSString *result = [inputString stringByFoldingWithOptions:NSCaseInsensitiveSearch locale:locale];
    NSLog(@"Unfolded string: %@", result);
}

//Listing 3.17 String Folding Example with Ligature Character
-(void)folding{
    NSString *inputString = @"ﬄ";
    NSLog(@"Original string: %@", inputString);
	NSString *result = [inputString stringByFoldingWithOptions:NSCaseInsensitiveSearch locale:nil];
    NSLog(@"Unfolded string: %@", result);
}

//Listing 3.18 Sorting with localizedCompare:
-(void)sortingLocalizedCompare{
	NSArray *plArray = @[@"Labirynt", @"Łódź", @"Magia", @"Ucho"];
	NSArray *sortedArray= [NSArray new];
	NSArray *sortedArrayLocalized= [NSArray new];
	
	sortedArray = [plArray sortedArrayUsingSelector:@selector(compare:)];
    
	sortedArrayLocalized = [plArray sortedArrayUsingSelector:@selector(localizedCompare:)];
	
	NSLog(@"Sorted: %@", sortedArray);
	NSLog(@"Sorted - Localized: %@", sortedArrayLocalized);
    
	for (id obj in sortedArray) {
		NSLog(@"Sorted item, not localized: %@\n", obj);
	}
	for (id obj in sortedArrayLocalized) {
		NSLog(@"Sorted item, localized: %@\n", obj);
	}
}

//Listing 3.19 Sorting via compare:options:range:locale: for a Specified Locale
-(void)sortingWithCompareAndLocale{
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"pl_PL"];
	
	NSMutableArray *plArray = [[NSMutableArray alloc] initWithObjects:@"Labirynt", @"Łódź", @"Magia", @"Ucho", nil];
    
	NSArray *sortedWithCaseInsensitive = [plArray sortedArrayWithOptions:0
                                                         usingComparator:^(NSString  *v1, NSString *v2) {
                                                             return [v1 compare:v2
                                                                        options:NSCaseInsensitiveSearch
                                                                          range:NSMakeRange(0, [v1 length])
                                                                         locale:locale];
                                                         }];
    
	NSArray *sortedWithDiacritic = [plArray sortedArrayWithOptions:0
                                                   usingComparator:^(NSString  *v1, NSString *v2) {
                                                       return [v1 compare:v2 
                                                                  options:NSDiacriticInsensitiveSearch
                                                                    range:NSMakeRange(0, [v1 length])
                                                                   locale:locale];
                                                   }];
	
	NSLog(@"Sorting result with supplied locale: %@", sortedWithCaseInsensitive);
	for (id obj in sortedWithCaseInsensitive) {
		NSLog(@"Sorted item: %@\n", obj);
	}
	for (id obj in sortedWithDiacritic) {
		NSLog(@"Sorted item, Diacritic Insensitive: %@\n", obj);
	}
}

@end
