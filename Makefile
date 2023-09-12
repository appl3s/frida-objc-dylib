host_arch := arm64
host_machine := arm64

INC := -I/usr/include
CC := $(shell xcrun --sdk iphoneos -f clang) -isysroot $(shell xcrun --sdk iphoneos --show-sdk-path) -miphoneos-version-min=8.0
CXX := $(shell xcrun --sdk iphoneos -f clang++) -isysroot $(shell xcrun --sdk iphoneos --show-sdk-path) -miphoneos-version-min=8.0
CFLAGS := -Wall -pipe -Os -framework Foundation -I./include
LDFLAGS := -Wl,-dead_strip
STRIP := $(shell xcrun --sdk iphoneos -f strip) -Sx
CODESIGN := $(shell xcrun --sdk iphoneos -f codesign) -f -s "iPhone Developer"
LIPO := $(shell xcrun --sdk iphoneos -f lipo)

.PHONY: all
all: agent.dylib

.PHONY: agent.dylib
agent.dylib:
	$(CXX) -arch arm64 -ObjC++ -std=c++11 $(CFLAGS) -c lib/Runtime.mm -o obj/runtime.o
	$(CXX) -arch arm64 -ObjC++ -std=c++11 -shared -Wl,-exported_symbol,_agent_main $(CFLAGS) -I$(@D)/include obj/runtime.o main.mm -o $@ $(LDFLAGS)

.PHONY: clean
clean:
	rm -rf agent.dylib
	rm -rf obj/*.o


