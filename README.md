This project based on https://github.com/doubleencore/DETweetComposeViewController

What is it?
DESinaWeiboComposeViewController is a sina weio share controller. 
Looks like as the tweet share Sheet in iOS 5.

How to use it?

1.Add your sina weibo appkey and secret in Constants.h

2.#import "DESinaWeiboComposeViewController.h"




        DESinaWeiboComposeViewController *sinaWeiboViewComposer = [[DESinaWeiboComposeViewController alloc] init];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        [sinaWeiboViewComposer setInitialText:@"Look on this"];
        [sinaWeiboViewComposer addImage:[UIImage imageNamed:@"share.png"]];
        sinaWeiboViewComposer.completionHandler = completionHandler;
        [self presentViewController:sinaWeiboViewComposer animated:YES completion:^{ }];
        
        [sinaWeiboViewComposer release];