#import <Foundation/Foundation.h>
#import <mach-o/ldsyms.h>

@interface BTSandbox : NSObject

- (void)printHelloWorld;

@end

extern "C" {
void getLocalImages();
void agent_main(const void *data, bool *stay_resident);
};