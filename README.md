# frida-objc-dylib

[简体中文](README.zh.md)

Based on [oleavr's project](https://github.com/oleavr/ios-inject-custom), this project allows injection of dylib to execute Objective-C.

The main idea is to dynamically read the sections of the dylib and dynamically register classes and functions.

## Prerequisites

* Xcode / CLion
* Jailbreak iOS device

## Compilation

```bash
$ make
```

This command will automatically compile and generate the executable file agent.dylib in the current directory.

Then, follow the instructions in [oleavr's project](https://github.com/oleavr/ios-inject-custom) to inject this dylib into an iOS device. You will see the following message in the console:

```log
Hello World from BTSandbox
```

**Have fun!**

## License

MIT