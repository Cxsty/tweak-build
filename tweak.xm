#import <Foundation/Foundation.h>
#import <objc/runtime.h>

%hook IGOAuthManager

- (NSString *)accessToken {
    return @"bypass_token_12345";
}

- (BOOL)isLoggedIn {
    return YES;
}

- (BOOL)isAuthenticated {
    return YES;
}

- (BOOL)hasAccessToken {
    return YES;
}

- (BOOL)isAuthorized {
    return YES;
}

%end

%ctor {
    NSLog(@"[iGameGodBypass] Loaded successfully");
}