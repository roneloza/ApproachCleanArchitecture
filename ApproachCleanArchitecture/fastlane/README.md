fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios increment_build_and_version_numbers
```
fastlane ios increment_build_and_version_numbers
```

### ios archive_adhoc
```
fastlane ios archive_adhoc
```

### ios refresh_dsyms
```
fastlane ios refresh_dsyms
```

### ios upload_to_crashlytics
```
fastlane ios upload_to_crashlytics
```

### ios commit_beta_version
```
fastlane ios commit_beta_version
```

### ios fabric_beta
```
fastlane ios fabric_beta
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
