#include "Runtime.h"
#include "main.h"




@implementation BTSandbox

- (void)printHelloWorld {
    NSLog(@"Hello World from BTSandbox");
}

@end

void registerSection(mull::objc::Runtime* runtime, struct section_64* sec, uintptr_t secPtr) {
    void * ptr = reinterpret_cast<void *>(secPtr);
    if(strstr(sec->sectname, "__objc_selrefs")!=nullptr) {
        NSLog(@"__objc_selrefs");
        runtime->registerSelectors(ptr, sec->size);
    }else if(strstr(sec->sectname, "__objc_classlist")!=nullptr){
        NSLog(@"__objc_classlist");
        runtime->addClassesFromSection(ptr, sec->size);
    }else if(strstr(sec->sectname, "__objc_classrefs")!=nullptr){
        NSLog(@"__objc_classrefs");

        runtime->addClassesFromClassRefsSection(ptr, sec->size);
    }else if(strstr(sec->sectname, "__objc_superrefs")!=nullptr){
        NSLog(@"__objc_superrefs");

        runtime->addClassesFromSuperclassRefsSection(ptr, sec->size);
    }else if(strstr(sec->sectname, "__objc_catlist")!=nullptr){
        NSLog(@"__objc_catlist");
        runtime->addCategoriesFromSection(ptr, sec->size);
    }
}

void getLocalImages()
{
    const struct mach_header_64* header = &_mh_dylib_header;
    struct load_command* cmd = (struct load_command*)((uintptr_t)header + sizeof(struct mach_header_64));
    for(uint32_t j=0; j<header->ncmds; j++) {
        NSLog(@"ncmds: %u",j);
        if(cmd->cmd == LC_SEGMENT_64) {
            mull::objc::Runtime* runtime = new mull::objc::Runtime();
            struct segment_command_64* sgCmd = (struct segment_command_64*) cmd;
            struct section_64* sec = (struct section_64*) ((uintptr_t)sgCmd+sizeof (struct segment_command_64));
            for(uint32_t k=0; k<sgCmd->nsects; k++) {
                NSLog(@"sections: %s", sec->sectname);
                uintptr_t secPtr = ((uintptr_t) header)+sec->offset;
                NSLog(@"addr: %lx", secPtr);
                registerSection(runtime, sec, secPtr);
                sec++;
            }
            runtime->registerClasses();
            //break;
        }
        cmd = (struct load_command*)((uintptr_t)cmd+cmd->cmdsize);
    }
}


void agent_main(const void *data, bool *stay_resident) {
    NSLog(@"init from example_agent_main");
    *stay_resident = TRUE;

    NSLog(@"before: %@", objc_getClass("BTSandbox"));
    getLocalImages();
    NSLog(@"after: %@", objc_getClass("BTSandbox"));

//    [[[BTSandbox alloc] init] printHelloWorld];
}
