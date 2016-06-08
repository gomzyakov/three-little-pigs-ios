//
//  main.m
//  ThreeLittlePigs
//
//  Created by Alexander Gomzyakov on 23.02.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

// clean the console output.

typedef int (*PYStdWriter)(void *, const char *, int);

static PYStdWriter _oldStdWrite;


int __pyStderrWrite(void *inFD, const char *buffer, int size)
{
    if ( strncmp(buffer, "AssertMacros:", 13) == 0 ) {
        return 0;
    }
    return _oldStdWrite(inFD, buffer, size);
}

void __iOS7B5CleanConsoleOutput(void)
{
    _oldStdWrite = stderr->_write;
    stderr->_write = __pyStderrWrite;
}

// end clean console output.

int main(int argc, char * argv[])
{
    @autoreleasepool
    {
        __iOS7B5CleanConsoleOutput(); // clean console
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

