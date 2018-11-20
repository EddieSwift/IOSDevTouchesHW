//
//  ViewController.h
//  IOSDevTouchesHW
//
//  Created by Eduard Galchenko on 11/4/18.
//  Copyright © 2018 Eduard Galchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *checkersBoard;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *blackCells;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *whiteCheckers;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *redCheckers;



@end

