#pragma once

@interface Assertion
+ (void)failWithFile:(const char*)file andLine:(int)line andMessage:(const char*)message, ...;
@end

#if !defined(NS_BLOCK_ASSERTIONS)
	#define Assert(test, msg, ...) do {if (!(test)) [Assertion failWithFile:__FILE__ andLine:__LINE__ andMessage:"Assertion failed: %s\n\n" msg, #test, ## __VA_ARGS__];} while (0)
	#define Ensure(test) do {if (!(test)) [Assertion failWithFile:__FILE__ andLine:__LINE__ andMessage:"Assertion failed: %s\n\n", #test];} while (0)
#else
	#define Assert(test, msg, ...)			((void)0)
	#define Ensure(test)					((void)0)
#endif
