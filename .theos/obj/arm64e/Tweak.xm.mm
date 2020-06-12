#line 1 "Tweak.xm"
#include <RemoteLog.h>

@interface _UIStatusBarStringView: UILabel {
}
@property (nonatomic,copy) NSString * originalText;
-(void)didMoveToWindow;
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class _UIStatusBarStringView; 
static void (*_logos_orig$_ungrouped$_UIStatusBarStringView$setText$)(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$_UIStatusBarStringView$setText$(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$_UIStatusBarStringView$didMoveToWindow)(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$_UIStatusBarStringView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST, SEL); 

#line 9 "Tweak.xm"

static void _logos_method$_ungrouped$_UIStatusBarStringView$setText$(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	NSString *text = arg1;
	if([text containsString:@":"]) {
		
		NSDate *now = [NSDate date];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"EEEEEE d.M"];
		NSString *shortDate = [dateFormatter stringFromDate:now];
		
		NSCalendar *lunar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
		NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit;
		NSDateComponents *components = [lunar components:unitFlags fromDate: now];
		NSInteger day = [components day];
		NSInteger month = [components month];
		NSString *lunarDate = [NSString stringWithFormat:@"%li.%li", day , month];
		NSString *newString = [NSString stringWithFormat:@"%@\n%@-%@", text, shortDate, lunarDate];
		self.numberOfLines = 2;
		self.textAlignment = 3;
		self.adjustsFontSizeToFitWidth = true;
		[self setFont: [UIFont systemFontOfSize:10 weight:UIFontWeightMedium]];
		_logos_orig$_ungrouped$_UIStatusBarStringView$setText$(self, _cmd, newString);
	}
	else {
		_logos_orig$_ungrouped$_UIStatusBarStringView$setText$(self, _cmd, text);
	}
}
static void _logos_method$_ungrouped$_UIStatusBarStringView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL _UIStatusBarStringView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSString *text = self.originalText;
	if([text containsString:@":"]) {
		self.numberOfLines = 2;
		self.textAlignment = 3;
		self.adjustsFontSizeToFitWidth = true;
		[self setFont: [UIFont systemFontOfSize:10 weight:UIFontWeightMedium]];
	}
	_logos_orig$_ungrouped$_UIStatusBarStringView$didMoveToWindow(self, _cmd);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$_UIStatusBarStringView = objc_getClass("_UIStatusBarStringView"); MSHookMessageEx(_logos_class$_ungrouped$_UIStatusBarStringView, @selector(setText:), (IMP)&_logos_method$_ungrouped$_UIStatusBarStringView$setText$, (IMP*)&_logos_orig$_ungrouped$_UIStatusBarStringView$setText$);MSHookMessageEx(_logos_class$_ungrouped$_UIStatusBarStringView, @selector(didMoveToWindow), (IMP)&_logos_method$_ungrouped$_UIStatusBarStringView$didMoveToWindow, (IMP*)&_logos_orig$_ungrouped$_UIStatusBarStringView$didMoveToWindow);} }
#line 47 "Tweak.xm"
