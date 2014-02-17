//
//  ViewController.m
//  StudyplusSDKDemo
//
//  Created by akitsukada on 2014/02/17.
//  Copyright (c) 2014年 studyplus.jp. All rights reserved.
//

#import "ViewController.h"
#import "SPLStudyplus.h"

static NSString * const ConsumerKey = @"Your Studyplus consumer key";
static NSString * const ConsumerSecret = @"Your Studyplus consumer secret";

@interface ViewController ()

@end

static SPLStudyplus *studyplus;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)auth:(id)sender {
    [self doAuth];
}

- (IBAction)login:(id)sender {
    [self doLogin];
}

- (IBAction)post:(id)sender {
    // Create new study record.
    SPLStudyplusRecord *studyplusRecord =
    [SPLStudyplusRecord
     recordWithDuration:3600
     /** You can add optional info.
      options:@{
      // @see SPLStudyplusRecordAmount
      @"recordedAt" : [NSDate date],
      // Time the learning is ended. 学習を終えた日時。
      @"comment" : @"アプリ◯◯で勉強しました！！",
      // Studyplus timeline comment. Studyplusのタイムライン上で表示されるコメント。
      @"amount" : [SPLStudyplusRecordAmount amount:100],
      }
      */
     ];
    
    // post
    [self.studyplus postStudyRecord:studyplusRecord];
}

-(SPLStudyplus*)studyplus
{
    studyplus = [SPLStudyplus studyplusWithConsumerKey:ConsumerKey
                                     andConsumerSecret:ConsumerSecret];
    studyplus.delegate = self;
    return studyplus;
}

-(void) doAuth {
    [self.studyplus auth];
}

-(void) doLogin
{
    [self.studyplus login];
}

// Called by AppDelegate
-(BOOL) openURL:(NSURL*)url
{
    return [self.studyplus openURL:url];
}

// callback methods
-(void)studyplusDidConnect:(SPLStudyplus*)studyplus
{
    NSLog(@"Auth or Login succeeded");
}

-(void)studyplusDidFailToConnect:(SPLStudyplus*)studyplus withError:(NSError*)error
{
    NSLog(@"Auth or Login failed");
}

- (void)studyplusDidCancel:(SPLStudyplus*)studyplus
{
    NSLog(@"Auth or Login canceled");
}

-(void)studyplusDidPostStudyRecord:(SPLStudyplus*)studyplus
{
    NSLog(@"Post to Studyplus succeeded");
}

-(void)studyplusDidFailToPostStudyRecord:(SPLStudyplus*)studyplus withError:(NSError*)error
{
    NSLog(@"Post to Studyplus failed:%@", error);
}

@end
