//
//  FirstViewController.h
//  TestNSURL
//
//  Created by MitulB on 18/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<NSURLConnectionDelegate , UITableViewDataSource , UITableViewDelegate>
{
    IBOutlet UITableView *tblList;
    
    NSMutableData *receiveData;
    
}

@property (strong , nonatomic)NSMutableArray *arrList;




@end
