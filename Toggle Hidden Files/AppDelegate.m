//
//  AppDelegate.m
//  Toggle Hidden Files
//
//  Created by Amarjeet Rai on 25/01/2014.
//  Copyright (c) 2014 Amarjeet Rai. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

NSString *runCommand(NSString *commandToRun)
{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c" ,
                          [NSString stringWithFormat:@"%@", commandToRun],
                          nil];
    NSLog(@"run command: %@",commandToRun);
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *output;
    output = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    return output;
}

- (IBAction)showHiddenFiles:(id)sender {
    runCommand(@"defaults write com.apple.finder AppleShowAllFiles TRUE");
    runCommand(@"killall Finder");
}
- (IBAction)hideHiddenFiles:(id)sender {
    runCommand(@"defaults write com.apple.finder AppleShowAllFiles FALSE");
    runCommand(@"killall Finder");
}

@end
