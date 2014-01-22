StudyplusSDK
=======

Studyplus iOS SDK

## Requirements

 * iOS 6.0 or above
 * Xcode command line tools
 * ARC
 * [Studyplus iOS App 3.10.0 or adove](https://itunes.apple.com/jp/app/mian-qiangga-leshiku-xuku!/id505410049?mt=8)
 * CocoaPods
 
## Dependency
 * [UICKeyChainStore](https://github.com/kishikawakatsumi/UICKeyChainStore)

## Install

### CocoaPods (recommended)

```ruby
# Edit your podfile
platform :ios, '6.0'
pod 'StudyplusSDK'
```
and run
```pod install ```

### Manual install

#### By library and headers 

1. Get StudyplusSDK.
  * ```git clone https://github.com/studyplus/Studyplus-iOS-SDK``` or download zip from [this page](https://github.com/studyplus/Studyplus-iOS-SDK/releases).
2. Copy ```build/Release/deliverables/StudyplusSDK``` to your project.
3. Add required frameworks(i.e. ```Security.framework, SystemConfiguration.framework, MobileCoreServices, CoreGraphics``` etc). see [UICKeyChainStore](https://github.com/kishikawakatsumi/UICKeyChainStore) and [AFNetworking](https://github.com/AFNetworking/AFNetworking).

#### By source copy (iOS 7 required)

1. Get StudyplusSDK
  * ```git clone https://github.com/studyplus/Studyplus-iOS-SDK``` or download zip from [this page](https://github.com/studyplus/Studyplus-iOS-SDK/releases).
2. Copy Studyplus-iOS-SDK/StudyplusSDK directory to your project.
3. Install [UICKeyChainStore](https://github.com/kishikawakatsumi/UICKeyChainStore) and [AFNetworking](https://github.com/AFNetworking/AFNetworking) too.

## Usage

### Set up custom URL schema

set "studyplus-*{your consumer key}*" to URL Types.

![xcode](https://raw.github.com/studyplus/Studyplus-iOS-SDK/master/docs/set_url_schema.png)

### Initialize

```Objective-C
#import "Studyplus.h"

static NSString * const ConsumerKey = @"Your Studyplus consumer key";
static NSString * const ConsumerSecret = @"Your Studyplus consumer secret";

@implementation YourClass
{
    Studyplus *studyplus;
}

-(id) init {

    if (self = [super init]) {
        studyplus = [Studyplus studyplusWithConsumerKey:ConsumerKey
                                      andConsumerSecret:ConsumerSecret];
        studyplus.delegate = self;
    }
    return self;
}
```

### Auth or Login 
```Objective-C
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [yourClassObject openURL:url];
}
```

```Objective-C
@interface YourClass
-(BOOL)openURL:(NSURL*)url;
@end
```

```Objective-C
@implementation YourClass

-(void) doAuth {
    [studyplus auth];
}

-(void) doLogin
{
    [studyplus login];
}

// Called by AppDelegate
-(BOOL) openURL:(NSURL*)url
{
    return [studyplus openURL:url];
}

// callback methods
-(void)studyplusDidConnect:(Studyplus*)studyplus
{
    NSLog(@"Auth or Login succeeded");
}

-(void)studyplusDidFailToConnect:(Studyplus*)studyplus withError:(NSError*)error
{
    NSLog(@"Auth or Login failed");
}

- (void)studyplusDidCancel:(Studyplus*)studyplus
{
    NSLog(@"Auth or Login canceled");
} 
```

### Post study record to Studyplus

```Objective-C
-(void)post
{

    // Create new study record.
    StudyplusRecord *studyplusRecord =
      [StudyplusRecord
       recordWithDuration:3600
       /** You can add optional info.
       options:@{
           @"recordedAt" : [NSDate date],
           @"comment" : @"アプリ◯◯で勉強しました！！",
           @"amount" : [StudyplusRecordAmount amount:100],
       }
       */
      ];

    // post
    [studyplus postStudyRecord:studyplusRecord];

}

// callback methods
-(void)studyplusDidPostStudyRecord:(Studyplus*)studyplus
{
    NSLog(@"Post to Studyplus succeeded");
}

-(void)studyplusDidFailToPostStudyRecord:(Studyplus*)studyplus withError:(NSError*)error
{
    NSLog(@"Post to Studyplus failed");
}
```

### More info about SDK interface

 * StudyplusSDK/Classes/Studyplus.h
 * StudyplusSDK/Classes/StudyplusDelegate.h
 * StudyplusSDK/Classes/StudyplusRecord.h
 * StudyplusSDK/Classes/StudyplusRecordAmount.h

## License

[MIT License.](http://opensource.org/licenses/mit-license.php)
