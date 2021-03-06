//
//  AppDelegate.h
//  IOSDevTouchesHW
//
//  Created by Eduard Galchenko on 11/4/18.
//  Copyright © 2018 Eduard Galchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


/*
 
 1. Создайте шахматное поле (8х8), используйте черные сабвьюхи
 2. Добавьте балые и красные шашки на черные клетки (используйте начальное расположение в шашках)
 3. Реализуйте механизм драг'н'дроп подобно тому, что я сделал в примере, но с условиями:
 4. Шашки должны ставать в центр черных клеток.
 5. Даже если я отпустил шашку над центром белой клетки - она должна переместиться в центр ближайшей к отпусканию черной клетки.
 6. Шашки не могут становиться друг на друга
 7. Шашки не могут быть поставлены за пределы поля.
 
 */

