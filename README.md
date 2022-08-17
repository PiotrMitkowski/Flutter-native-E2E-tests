# native_test_demo

A Flutter project demonstrating how to write native E2E tests for a Flutter app

## Running E2E tests for Android

1. Switch current directory to `android`
2. run `./gradlew app:connectedAndroidTest -Ptarget=`pwd`/../test_driver/example.dart`

## Running E2E tests for iOS
1. Switch current directory to `ios`
2. run `xcodebuild test -workspace Runner.xcworkspace -scheme Runner -destination 'platform=iOS Simulator,name=iPhone 13'

*Note:* Custom location for iOS tests can be set only manually in running simulator. It can't be achieved through CLI.

## Adding native E2E tests to an existing project

### Android
1. Right click on `android` directory -> `Flutter` -> `Open Android module in Android Studio`
2. In `android/app/src` add `androidTest` directory
3. Under `androidTest`, add `java` or `kotlin` directory (depending on selected language to write the tests)
4. Under directory from 3., add a new package with name reflecting your app's package
5. Add first test file, e.g. `MainActivityTest.java`

### iOS
1. Right click on `ios` directory -> `Flutter` -> `Open iOS module in Xcode`
2. In Xcode, select top level `Runner` entry (for `Runner.xcodeproj`), select `General` tab and click on `+` button under `TARGETS`
3. Search for `UI Testing Bundle`, then select it and click `Next`
4. Set Product Name to `RunnerUITests` and Organization Identifier to your app's identifier
5. Click `Finish`