
#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

int main (int argc, const char * argv[]) {

    TISInputSourceRef input = TISCopyCurrentKeyboardInputSource();
    CFStringRef inputName = TISGetInputSourceProperty(input, kTISPropertyLocalizedName);

    CFStringRef switchTo = CFSTR("U.S.");
    if (argc > 1) {
        switchTo = (CFStringRef) [NSString stringWithUTF8String:argv[1]];
    }

    if (CFStringCompare(inputName, switchTo, 0) == 0) {
        return 0;
    }

    CFArrayRef inputArray = TISCreateInputSourceList ( NULL, false);
    int inputCount = CFArrayGetCount(inputArray);


    int i;
    for (i = 0; i < inputCount; i++) {
        input = (TISInputSourceRef) CFArrayGetValueAtIndex(inputArray, i);
        inputName = TISGetInputSourceProperty(input, kTISPropertyLocalizedName);
        if (CFStringCompare(inputName, switchTo, 0) == 0) {
            return TISSelectInputSource (input);
        }
    }
    return -1;
}

/* gcc -framework Carbon -framework Foundation -o keyboardSwitcher keyboardSwitcher.m */

