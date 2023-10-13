# Randomize - Randomice

## SnapKit
https://github.com/SnapKit/SnapKit

```
$ brew update
$ brew install carthage
$ carthage update --use-xcframeworks


????
carthage help
carthage update --platform iOS --no-use-binaries  --use-xcframeworks
Building universal frameworks with common architectures is not possible. The device and simulator slices for "SnapKit" both build for: arm64
Rebuild with --use-xcframeworks to create an xcframework bundle instead.





```

```
# Cartfile
github "SnapKit/SnapKit" ~> 5.0.0
```


## problems

Could not find module 'SnapKit' for target 'x86_64-apple-ios-simulator'; found: arm64-apple-ios, at: /usr/local/var/www/repos/fc/projects/randomice/Carthage/Build/iOS/SnapKit.framework/Modules/SnapKit.swiftmodule

https://cocoapods.org/pods/SnapKit



