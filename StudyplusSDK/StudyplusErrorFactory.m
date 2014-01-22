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

#import "StudyplusErrorFactory.h"
#import "StudyplusLogger.h"

static NSString* const ErrorDomain = @"jp.studyplus.sdk";

@implementation StudyplusErrorFactory

+ (NSError*)errorFromStudyplusErrorCode:(StudyplusError)studyplusErrorCode
{
    NSError *error;
    switch (studyplusErrorCode) {
        case StudyplusErrorGetAppDescription:
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:@"Failed to get information about application. (400 bad request)"];
            break;
            
        case StudyplusErrorAuthFailed:
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:@"Failed to authorize Studyplus user. (400 bad request)"];
            break;
            
        case StudyplusErrorLoginFailed:
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:@"Failed to login to Studyplus. (400 bad request)"];
            break;
            
        case StudyplusErrorStudyplusInMaintenance:
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:@"Maybe Studyplus is in temporary maintenance."];
            break;
            
        case StudyplusErrorInvalidStudyplusSession:
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:@"Studyplus session is invalid."];
            break;
            
        case StudyplusErrorNetworkUnavailable:
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:@"Network is not available."];
            break;
            
        case StudyplusErrorServerError:
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:@"Some error(s) occurred in Studyplus server."];
            break;
            
        case StudyplusErrorPostRecordFailed:
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:@"Failed to post study record. (400 bad request)"];
            break;
            
        case StudyplusErrorUnknown:
            error = [StudyplusErrorFactory errorWithCode:StudyplusErrorUnknown
                         localizedDescription:@"Unknown Error."];
            break;
        default:
            StudyplusSDKLog(@"Unexpected Studyplus status:[%ld]", (long)studyplusErrorCode);
            error = [StudyplusErrorFactory errorWithCode:studyplusErrorCode
                         localizedDescription:[NSString
                                               stringWithFormat:@"Unexpected Error(errorCode:[%ld]).",
                                               (long)studyplusErrorCode]];
            break;
    }
    return error;
}

+ (NSError*)errorFromStudyRecordPostStatusCode:(NSInteger)httpStatusCode
{
    if (httpStatusCode < 400 || 599 < httpStatusCode) {
        // no error
        return nil;
    }
    
    NSError *error;
    switch (httpStatusCode) {
        case 400:
            error = [StudyplusErrorFactory
                     errorFromStudyplusErrorCode:StudyplusErrorPostRecordFailed];
            break;
            
        case 401:
            error = [StudyplusErrorFactory
                     errorFromStudyplusErrorCode:StudyplusErrorInvalidStudyplusSession];
            
        case 500:
            error = [StudyplusErrorFactory
                     errorFromStudyplusErrorCode:StudyplusErrorServerError];
            
        case 503:
            error = [StudyplusErrorFactory
                     errorFromStudyplusErrorCode:StudyplusErrorStudyplusInMaintenance];
            
        default:
            StudyplusSDKLog(@"Unexpected http status:[%ld]", (long)httpStatusCode);
            error = [StudyplusErrorFactory
                     errorFromStudyplusErrorCode:StudyplusErrorUnknown];
            break;
    }
    return error;
}

+ (NSError*)errorWithCode:(StudyplusError)errorCode localizedDescription:(NSString*)localizedDescription
{
    return [NSError errorWithDomain:ErrorDomain
                               code:errorCode
                           userInfo:@{NSLocalizedDescriptionKey:localizedDescription}];
}

@end
