//  Copyright (c) 2013年 studyplus.jp. All rights reserved.

#import "Kiwi.h"
#import "Studyplus.h"

SPEC_BEGIN(StudyplusTest)

describe(@"Studyplus", ^{
    describe(@"studyplusWithConsumerKey:consumerSecret:", ^{
        
        context(@"consumerKey and consumerSecret are specified", ^{
            Studyplus *sp = [Studyplus studyplusWithConsumerKey:@"cKey" andConsumerSecret:@"cSecret"];

            it(@"returns Studyplus object with specified values", ^{
                [[sp should] beKindOfClass:[Studyplus class]];
                [[sp.consumerKey should] equal:@"cKey"];
                [[sp.consumerSecret should] equal:@"cSecret"];
            });
        });
        
        context(@"consumerKey is not specified", ^{
            Studyplus *sp = [Studyplus studyplusWithConsumerKey:nil andConsumerSecret:@"cSecret"];
            
            it(@"returns Studyplus object with nil consumerKey", ^{
                [[sp should] beKindOfClass:[Studyplus class]];
                [[sp.consumerKey should] beNil];
                [[sp.consumerSecret should] equal:@"cSecret"];
            });
        });
        
        context(@"consumerSecret is not specified", ^{
            Studyplus *sp = [Studyplus studyplusWithConsumerKey:@"cKey" andConsumerSecret:nil];
            
            it(@"returns Studyplus object with nil consumerSecret", ^{
                [[sp should] beKindOfClass:[Studyplus class]];
                [[sp.consumerKey should] equal:@"cKey"];
                [[sp.consumerSecret should] beNil];
            });
        });

    });
});

SPEC_END
