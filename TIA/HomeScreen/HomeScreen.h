//
//  HomeScreen.h
//  TIA
//
//  Created by Swtya on 19/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreen : UIViewController

@property (strong, atomic) IBOutlet UIImageView *nmImgView, *flightsImgView, *hotelsImgView,
                                    *infoImgView, *exchImgView, *journeyImgView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end