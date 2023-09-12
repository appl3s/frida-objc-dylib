# frida-objc-dylib

[English](README.md)

---

在[大胡子叔叔的项目](https://github.com/oleavr/ios-inject-custom)的基础上, 本项目允许注入的 dylib 执行 Objective-C

主要的工作原理是通过动态读取 dylib 自身的 section 并动态注册类和函数来实现的

## 准备工作

* Xcode / CLion
* 越狱 iOS 设备

## 编译

```bash
$ make
```

此命令将自动编译并在当前目录生成可执行文件`agent.dylib`

然后根据[大胡子叔叔的项目](https://github.com/oleavr/ios-inject-custom)将此dylib注入iOS设备，可以在console中看到

```log
Hello World from BTSandbox
```

**玩的开心～**

## License

MIT

