#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// Hook IGOAuthManager.accessToken to return a fake token
// Hook isLoggedIn/isAuthenticated/hasAccessToken/isAuthorized to return YES

static NSString *fakeToken = @"bypass_token_12345";

// Original implementations
static IMP orig_accessToken = NULL;
static IMP orig_isLoggedIn = NULL;
static IMP orig_isAuthenticated = NULL;
static IMP orig_hasAccessToken = NULL;
static IMP orig_isAuthorized = NULL;

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
    
    // Hook accessToken
    Method m = class_getInstanceMethod(cls, sel_registerName("accessToken"));
    if (m) {
        orig_accessToken = method_setImplementation(m, (IMP)hook_accessToken);
        NSLog(@"[iGameGodBypass] Hooked accessToken");
    }
    
    // Hook boolean methods
    const char *boolMethods[] = {"isLoggedIn", "isAuthenticated", "hasAccessToken", "isAuthorized"};
    for (int i = 0; i < 4; i++) {
        SEL sel = sel_registerName(boolMethods[i]);
        Method bm = class_getInstanceMethod(cls, sel);
        if (bm) {
            IMP hook = NULL;
            if (i == 0) hook = (IMP)hook_isLoggedIn;
            else if (i == 1) hook = (IMP)hook_isAuthenticated;
            else if (i == 2) hook = (IMP)hook_hasAccessToken;
            else hook = (IMP)hook_isAuthorized;
            method_setImplementation(bm, hook);
            NSLog(@"[iGameGodBypass] Hooked %s", boolMethods[i]);
        }
    }
    
    NSLog(@"[iGameGodBypass] Loaded successfully");
}
PYEOF
echo "written"