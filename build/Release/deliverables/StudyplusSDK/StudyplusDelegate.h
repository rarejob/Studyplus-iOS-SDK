//  The MIT License (MIT)
//
//  Copyright (c) 2014 Studyplus inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

@class Studyplus;

/**
 The delegate to receive callbacks from Studyplus.
 
 Studyplusオブジェクトに対する各種操作後のコールバックを受けるdelegateです。
 */
@protocol StudyplusDelegate <NSObject>

/**
 Will be called after the Studyplus#login or Studyplus#auth was successful.<br>
 Studyplus#auth または Studyplus#login が成功した後に呼ばれます。
 
 @param studyplus Studyplus object.<br>
 Studyplusオブジェクトです。
 */
- (void)studyplusDidConnect:(Studyplus*)studyplus;

/**
 Will be called after the Studyplus#login or Studyplus#auth was failure.<br>
 Studyplus#auth または Studyplus#login が失敗した後に呼ばれます。

 @param studyplus Studyplus object.<br>
 Studyplusオブジェクトです。
 @param error Error object including failure reason.<br>
 失敗の理由を持つエラーオブジェクトです。
 @see NSError+StudyplusError.h
 */
- (void)studyplusDidFailToConnect:(Studyplus*)studyplus withError:(NSError*)error;

@optional

/**
 Will be called after the Studyplus#login or Studyplus#auth was cancelled.<br>
 Studyplus#auth または Studyplus#login がキャンセルされた後に呼ばれます。
 
 @param studyplus Studyplus object.<br>
 Studyplusオブジェクトです。
 */
- (void)studyplusDidCancel:(Studyplus*)studyplus;

/**
 Will be called after the Studyplus#postStudyRecord was successful.<br>
 Studyplus#postStudyRecord: が成功した後に呼ばれます。
 
 @param studyplus Studyplus object.<br>
 Studyplusオブジェクトです。
 */
- (void)studyplusDidPostStudyRecord:(Studyplus*)studyplus;

/**
 Will be called after the Studyplus#postStudyRecord was failure. If this method is called, study record was not posted.<br>
 Studyplus#postStudyRecord: が失敗した後に呼ばれます。このメソッドが呼ばれた場合、勉強ログは投稿されていません。

 @param error Error object including failure reason.<br>
 失敗の理由を持つエラーオブジェクトです。
 @see NSError+StudyplusError.h
 */
- (void)studyplusDidFailToPostStudyRecord:(Studyplus*)studyplus withError:(NSError*)error;

@end
