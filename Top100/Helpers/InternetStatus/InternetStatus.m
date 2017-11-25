//
//  InternetStatus.m
//  Top100
//
//  Created by Jitesh Middha on 25/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "InternetStatus.h"

@implementation InternetStatus

+(BOOL)internetAvailable {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        return NO;
    }
    
    else
    {
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        [reachability startNotifier];
        
        NetworkStatus status = [reachability currentReachabilityStatus];
        
        if(status == NotReachable)
        {
            return NO;
        }
        else if (status == ReachableViaWiFi)
        {
            //Connected to WiFi
            return YES;
        }
        else if (status == ReachableViaWWAN)
        {
            //Connected to Phone Network
            return YES;
        }
    }
    return NO;
}

@end
