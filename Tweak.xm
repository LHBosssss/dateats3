#include <RemoteLog.h>

@interface _UIStatusBarStringView: UILabel {
}
@property (nonatomic,copy) NSString * originalText;
@end

%hook _UIStatusBarStringView
-(void)setText:(id)arg1 {
	NSString *text = arg1;
	if([text containsString:@":"]) {
		// date
		NSDate *now = [NSDate date];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"EEEEEE d.M"];
		NSString *shortDate = [dateFormatter stringFromDate:now];
		// lunar
		NSCalendar *lunar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
		NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit;
		NSDateComponents *components = [lunar components:unitFlags fromDate: now];
		NSInteger day = [components day];
		NSInteger month = [components month];
		NSString *lunarDate = [NSString stringWithFormat:@"%li.%li", day , month];
		NSString *newString = [NSString stringWithFormat:@"%@\n%@-%@", text, shortDate, lunarDate];
		self.numberOfLines = 2;
		self.textAlignment = 1;
		[self setFont: [UIFont systemFontOfSize:11 weight:UIFontWeightMedium]];
		%orig(newString);
	}
	else {
		%orig(text);
	}
}
-(void)didMoveToWindow {
	NSString *text = self.originalText;
	if([text containsString:@":"]) {
		[self setFont: [UIFont systemFontOfSize:11 weight:UIFontWeightMedium]];
	}
	%orig;
}

%end
