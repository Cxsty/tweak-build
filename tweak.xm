#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static NSString *fakeToken = @"bypass_token_12345";

static id hook_accessToken(id self, SEL _cmd) {
    return fakeToken;
}

static BOOL hook_isLoggedIn(id self, SEL _cmd) { return YES; }
static BOOL hook_isAuthenticated(id self, SEL _cmd) { return YES; }
static BOOL hook_hasAccessToken(id self, SEL _cmd) { return YES; }
static BOOL hook_isAuthorized(id self, SEL _cmd) { return YES; }

__attribute__((constructor))
static void init() {
    Class cls = objc_getClass("IGOAuthManager");
    if (!cls) {
        NSLog(@"[iGameGodBypass] IGOAuthManager not found");
        return;
    }
    
    Method m = class_getInstanceMethod(cls, sel_registerName("accessToken"));
    if (m) {
        method_setImplementation(m, (IMP)hook_accessToken);
        NSLog(@"[iGameGodBypass] Hooked accessToken");
    }
    
    const char *boolMethods[] = {"isLoggedIn", "isAuthenticated", "hasAccessToken", "isAuthorized"};
    IMP hooks[] = {(IMP)hook_isLoggedIn, (IMP)hook_isAuthenticated, (IMP)hook_hasAccessToken, (IMP)hook_isAuthorized};
    for (int i = 0; i < 4; i++) {
        SEL sel = sel_registerName(boolMethods[i]);
        Method bm = class_getInstanceMethod(cls, sel);
        if (bm) {
            method_setImplementation(bm, hooks[i]);
            NSLog(@"[iGameGodBypass] Hooked %s", boolMethods[i]);
        }
    }
    
    NSLog(@"[iGameGodBypass] Loaded successfully");
}
