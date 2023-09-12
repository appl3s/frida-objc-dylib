#import <Foundation/Foundation.h>
#import <mach-o/ldsyms.h>

@interface BTSandbox : NSObject

- (void)printHelloWorld;

@end

extern "C" {
void registerSection(mull::objc::Runtime* runtime, struct section_64* sec, uintptr_t secPtr);
void getLocalImages();
void agent_main(const void *data, bool *stay_resident);
};