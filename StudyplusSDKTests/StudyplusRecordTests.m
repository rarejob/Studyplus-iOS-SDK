//  Copyright (c) 2013年 studyplus.jp. All rights reserved.

#import "Kiwi.h"
#import "StudyplusRecord.h"
#import "StudyplusRecordAmount.h"

SPEC_BEGIN(StudyplusRecordTest)

describe(@"StudyplusRecord", ^{
    describe(@"toRequestParam", ^{
        
        it(@"returns NSDictionary", ^{
            StudyplusRecord *record = [StudyplusRecord recordWithDuration:100];
            [[record.toRequestParam should] beKindOfClass:[NSDictionary class]];
        });
        
        context(@"record has duration only", ^{
            StudyplusRecord *record = [StudyplusRecord recordWithDuration:100];
            NSDictionary *requestParams = record.toRequestParam;
            
            it(@"returns specified duration with default recordedAt", ^{
                [[[requestParams should] have:2] items];
                [[requestParams[@"duration"] should] equal:@100];
                [[requestParams[@"recorded_at"] should] matchPattern:@"\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"];
                
            });
        });
        
        context(@"record has duration and comment", ^{
            StudyplusRecord *record = [StudyplusRecord recordWithDuration:100
                                                                  options:@{
                                                                            @"comment":
                                                                                @" (＿｀Д´), ○＝(ﾟ皿´ﾒ), (○`⊿´)"
                                                                            }];
            NSDictionary *requestParams = record.toRequestParam;
            
            it(@"returns specified duration with specified comment", ^{
                [[[requestParams should] have:3] items];
                [[requestParams[@"duration"] should] equal:@100];
                [[requestParams[@"recorded_at"] should] matchPattern:@"\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"];
                [[requestParams[@"comment"] should] equal:@" (＿｀Д´), ○＝(ﾟ皿´ﾒ), (○`⊿´)"];
            });
        });
        
        context(@"record has duration and amount", ^{
            StudyplusRecord *record = [StudyplusRecord recordWithDuration:100
                                                                  options:@{
                                                                            @"amount":[StudyplusRecordAmount amount:999],
                                                                            }];
            NSDictionary *requestParams = record.toRequestParam;
            
            it(@"returns specified duration with specified amount", ^{
                [[[requestParams should] have:3] items];
                [[requestParams[@"duration"] should] equal:@100];
                [[requestParams[@"recorded_at"] should] matchPattern:@"\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"];
                [[requestParams[@"amount"] should] equal:@999];
            });
        });
        
        context(@"record has duration and amount as range", ^{
            StudyplusRecord *record = [StudyplusRecord recordWithDuration:100
                                                                  options:@{
                                                                            @"amount":[StudyplusRecordAmount
                                                                                       amountAsRangeWithFrom:90 to:91],
                                                                            }];
            NSDictionary *requestParams = record.toRequestParam;
            
            it(@"returns specified duration with specified amount", ^{
                [[[requestParams should] have:4] items];
                [[requestParams[@"duration"] should] equal:@100];
                [[requestParams[@"recorded_at"] should] matchPattern:@"\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"];
                [[requestParams[@"start_position"] should] equal:@90];
                [[requestParams[@"end_position"] should] equal:@91];
            });
        });
        
    });
});

SPEC_END
