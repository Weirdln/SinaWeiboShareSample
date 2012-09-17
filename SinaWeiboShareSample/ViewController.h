//
//  ViewController.h
//  SinaWeiboShareSample
//
//  Created by Yu Jianjun on 9/17/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WBEngine.h"

@interface ViewController : UIViewController <WBEngineDelegate>{
    
    WBEngine *weiBoEngine;
}

@property (nonatomic, retain) WBEngine *weiBoEngine;

- (IBAction)SinaWeiboShareButtonPressed:(id)sender;


- (IBAction)SinaWeiboLogoutButtonPressed:(id)sender;

@end
