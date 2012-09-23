#import "Assert.h"

#import <Foundation/Foundation.h>

@implementation Assertion

+ (void)failWithFile:(const char*)file andLine:(int)line andMessage:(const char*)message, ... {
	va_list args;
	va_start(args, message);
	
	char buffer[2048];
	__attribute__((unused)) int sz = vsnprintf(buffer, 2048, message, args);
	
	@throw [NSException exceptionWithName:@"AssertionFailed" reason:[NSString stringWithUTF8String:buffer] userInfo:nil];
	
	va_end(args);
}

@end
