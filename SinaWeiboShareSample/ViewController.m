//
//  ViewController.m
//  SinaWeiboShareSample
//
//  Created by Yu Jianjun on 9/17/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "ViewController.h"
#import "DESinaWeiboComposeViewController.h"
#import "Constants.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize weiBoEngine;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
    [engine setRootViewController:self];
    [engine setDelegate:self];
    [engine setRedirectURI:@"http://"];
    [engine setIsUserExclusive:NO];
    self.weiBoEngine = engine;
    [engine release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)SinaWeiboShareButtonPressed:(id)sender {
    
    if ([weiBoEngine isLoggedIn] && ![weiBoEngine isAuthorizeExpired])
    {
        DESinaWeiboComposeViewControllerCompletionHandler completionHandler = ^(DESinaWeiboComposeViewControllerResult result) {
            switch (result) {
                case DESinaWeiboComposeViewControllerResultCancelled:
                    NSLog(@"Sina Weibo: Cancelled");
                    break;
                case DESinaWeiboComposeViewControllerResultDone:
                    NSLog(@"Sina Weibo: Sent");
                    break;
            }
            
            [self dismissModalViewControllerAnimated:YES];
        };
        
        DESinaWeiboComposeViewController *sinaWeiboViewComposer = [[DESinaWeiboComposeViewController alloc] init];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        [sinaWeiboViewComposer setInitialText:@"Look on this"];
        [sinaWeiboViewComposer addImage:[UIImage imageNamed:@"share.png"]];
        sinaWeiboViewComposer.completionHandler = completionHandler;
        [self presentViewController:sinaWeiboViewComposer animated:YES completion:^{ }];
        
        [sinaWeiboViewComposer release];
    }else {
        
        [weiBoEngine logIn];
    }
}


- (IBAction)SinaWeiboLogoutButtonPressed:(id)sender {
    if ([weiBoEngine isLoggedIn] && ![weiBoEngine isAuthorizeExpired])
    {
        [weiBoEngine logOut];
    }
}

-(void)dealloc {
    [weiBoEngine setDelegate:nil];
    [weiBoEngine release], weiBoEngine = nil;
    
    [super dealloc];
}


#pragma mark - WBEngineDelegate Methods

#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请先登出！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登录成功！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登录失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}


- (void)engineDidLogOut:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登出成功！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engineNotAuthorized:(WBEngine *)engine
{
    
}

- (void)engineAuthorizeExpired:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"请重新登录！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

#pragma mark --
#pragma mark UIAlertViewDelegate

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//
//    [self SinaWeiboShareButtonPressed:nil];
//}

@end
