//
//  ViewController.m
//  IOSDevTouchesHW
//
//  Created by Eduard Galchenko on 11/4/18.
//  Copyright © 2018 Eduard Galchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *dragginView;

@property (assign, nonatomic) CGPoint touchOfSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self makeRoundChechers];
}

#pragma mark - Additional methods

- (void) makeRoundChechers {
    
    for (UIView *checkers in self.redCheckers) {
        
        [checkers.layer setCornerRadius:checkers.frame.size.width / 2];
    }
    
    for (UIView *checkers in self.whiteCheckers) {
        
        [checkers.layer setCornerRadius:checkers.frame.size.width / 2];
    }
}

- (double) distanceBeetwenPoints:(CGPoint) firstPoint withSecondPoint:(CGPoint) secondPoint {
    
    double lengthX = (secondPoint.x - firstPoint.x);
    double lengthY = (secondPoint.y - firstPoint.y);
    
    return sqrt(pow(lengthX, 2) + pow(lengthY, 2));
}

- (BOOL) freeCellsAndCheckers:(UIView*) freeCells freeCheckers:(UIView*) freeCheckers {
    
    BOOL freeCellsOnBoard = YES;
    
    for (UIView *checker in self.whiteCheckers) {
        
        if ([freeCheckers isEqual:checker]) {
            
            continue;
        }
        
        if ([freeCells pointInside:[self.checkersBoard convertPoint:checker.center toView:freeCells] withEvent:nil]) {
            
            freeCellsOnBoard = NO;
        }

    }
    
    return freeCellsOnBoard;
}

- (void) logTouches:(NSSet*)touches WithMethod:(NSString*) methodName {
    
    NSMutableString *string = [NSMutableString stringWithString:methodName];
    
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInView:self.view];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    NSLog(@"%@", string);
}

- (void) animationDragginView:(UIView*) dragginView transformView:(CGAffineTransform) transformView withAlpha:(CGFloat) alpha {
    
    [UIView animateWithDuration:0.3 animations:^{
        dragginView.transform = transformView;
        dragginView.alpha = alpha;
    }];
    
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.checkersBoard];
    UIView *testView = [self.checkersBoard hitTest:pointOnMainView withEvent:event];
    
    if ([self.whiteCheckers containsObject:testView] || [self.redCheckers containsObject:testView]) {
        
        self.dragginView = testView;
        
        [self.view bringSubviewToFront:self.dragginView];
        
        CGPoint touchPoint = [touch locationInView:self.dragginView];
        
        self.touchOfSet = CGPointMake(CGRectGetMidX(self.dragginView.bounds) - touchPoint.x, CGRectGetMidY(self.dragginView.bounds) - touchPoint.y);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.dragginView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            self.dragginView.alpha = 0.3f;
        }];
        
    } else {

        self.dragginView = nil;
    }
    
    NSLog(@"inside = %d", [self.checkersBoard pointInside:pointOnMainView withEvent:event]);
    [self logTouches:touches WithMethod:@"Touches Began"];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

        if (self.dragginView) {
            
            [self.view bringSubviewToFront:self.dragginView];
            
            UITouch *touch = [touches anyObject];
            
            CGPoint point = [touch locationInView:self.checkersBoard];
            
            CGPoint correction = CGPointMake(point.x + self.touchOfSet.x, point.y + self.touchOfSet.y);

            self.dragginView.center = correction;
            
        }
    
    [self logTouches:touches WithMethod:@"Touches Moved"];
    }

- (void) onTouchesEnd {
    
    CGPoint centerPoint = self.dragginView.center;
    UIView *firstView = [self.blackCells objectAtIndex:0];
    CGPoint nearestPoint = firstView.center;
    CGFloat middleDistance = [self distanceBeetwenPoints:centerPoint withSecondPoint:nearestPoint];
    
    for (UIView *cells in self.blackCells) {
        
        if (![self freeCellsAndCheckers:cells freeCheckers:self.dragginView]) {
            
            continue;
        }
        
        CGFloat distance = [self distanceBeetwenPoints:centerPoint withSecondPoint:cells.center];
        
        if (distance < middleDistance) {
            
            middleDistance = distance;
            nearestPoint = cells.center;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.dragginView.center = nearestPoint;
            self.dragginView.alpha = 1.f;
        }];
        
        [self animationDragginView:self.dragginView transformView:CGAffineTransformMakeScale(1.f, 1.f) withAlpha:1.f];
    }
    
    self.dragginView = nil;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self onTouchesEnd];
    
    [self logTouches:touches WithMethod:@"Touches Ended"];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self onTouchesEnd];
    
    [self logTouches:touches WithMethod:@"Touches Cancelled"];
}


@end
