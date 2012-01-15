//
//  PSColorPicker.h
//  SwitcherExtensions
//
//  Created by Ryan Coffman on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Preferences/PSViewController.h>
#import "UIColor-Expanded.h"
@interface SESlider : UISlider
@property (nonatomic,retain) UILabel *label;
@property (nonatomic, retain) NSString *title;
-(void)setLabelFloat:(float)value;
@end
@interface PSColorPicker : PSViewController {
    UIView *_preview;
    SESlider *_redSlider;
    SESlider *_greenSlider;
    SESlider *_blueSLider;
    SESlider *_alphaSlider;
    UIColor *_currentColor;
 
    NSMutableDictionary *_dict;
    
    
}
@property (nonatomic, retain) UIView *preview;
@property (nonatomic, retain) SESlider *redSlider;
@property (nonatomic, retain) SESlider *greenSlider;
@property (nonatomic, retain) SESlider *blueSlider;
@property (nonatomic, retain) SESlider *alphaSlider;
@property (nonatomic, retain) UIColor *currentColor;

@property (nonatomic, retain) NSMutableDictionary *dict;
-(NSString *)key;
-(NSString *)prefsPath;
-(UIColor *)defaultColor;
-(void)update:(UISlider *)slider;
-(void)updateDict;
-(void)loadColor;

@end
@interface UIColor (Private)
+ (id)pinStripeColor;
+ (id)selectionTintColor;
+ (id)_textCaretColorDefault;
+ (id)_textCaretColorNotes;
+ (id)textCaretColor;
+ (id)selectionCaretColor;
+ (id)selectionHighlightColor;
+ (id)lightTextColor;
+ (id)darkTextColor;
+ (id)groupTableViewBackgroundColor;
+ (id)viewFlipsideBackgroundColor;
+ (id)scrollViewTexturedBackgroundColor;
@end

