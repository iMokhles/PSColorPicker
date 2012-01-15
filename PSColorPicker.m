//
//  PSColorPicker.m
//  SwitcherExtensions
//
//  Created by Ryan Coffman on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSColorPicker.h"
//subclass of a UISlider to add labels to it
@implementation SESlider 
@synthesize label; 
@synthesize title;
-(void)setLabelFloat:(float)value {
    //shows the current rgb value for that color
    NSString *text = [NSString stringWithFormat:@"%@(%.02f)",self.title,value];
    self.label.text =text;
    
}

-(void)dealloc {
    [self.label release];
    [super dealloc];
}
@end
@implementation PSColorPicker
@synthesize preview = _preview;
@synthesize redSlider = _redSlider;
@synthesize greenSlider = _greenSlider;
@synthesize blueSlider = _blueSlider;
@synthesize alphaSlider = _alphaSlider;
@synthesize currentColor = _currentColor;

@synthesize dict = _dict;
-(void)viewDidLoad {
    self.dict = [[NSMutableDictionary alloc]initWithContentsOfFile:[self prefsPath]];
    if(!self.dict)
        self.dict = [[NSMutableDictionary alloc]init];
    //load the current color from prefs
    [self loadColor];
    //view where we see color changes
    self.preview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/6,25,self.view.frame.size.width/1.5,100)];
    //sliders and their lables
    self.redSlider = [[SESlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10,CGRectGetMaxY(self.preview.frame) + 40,self.view.frame.size.width/1.25,23)];
    self.redSlider.title = @"Red";
    self.greenSlider = [[SESlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10,CGRectGetMaxY(self.redSlider.frame) + 40,self.view.frame.size.width/1.25,23)];
    self.greenSlider.title = @"Green";
    self.blueSlider = [[SESlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10,CGRectGetMaxY(self.greenSlider.frame) + 40,self.view.frame.size.width/1.25,23)];
    self.blueSlider.title = @"Blue";
    self.alphaSlider = [[SESlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10,CGRectGetMaxY(self.blueSlider.frame) + 40,self.view.frame.size.width/1.25,23)];
    self.alphaSlider.title = @"Alpha";
    //set the sliders values to the color saved in prefs
    self.redSlider.value = self.currentColor.red;
    self.greenSlider.value = self.currentColor.green;
    self.blueSlider.value = self.currentColor.blue;
    self.alphaSlider.value = self.currentColor.alpha;
    self.preview.backgroundColor = self.currentColor;
    self.view.backgroundColor = [UIColor pinStripeColor];
    [self.view addSubview:self.preview];
    [self.view addSubview:self.redSlider];
    [self.view addSubview:self.greenSlider];
    [self.view addSubview:self.blueSlider];
    [self.view addSubview:self.alphaSlider];
    [super viewDidLoad];
    //set universal slider properties
    for (SESlider *slider in self.view.subviews) {
        if([slider isKindOfClass:[SESlider class]]) {
            
            slider.minimumValue = 0.0f;
            slider.maximumValue = 1.0f;
            [slider addTarget:self action:@selector(update:) forControlEvents:UIControlEventValueChanged];
            [slider addTarget:self action:@selector(updateDict) forControlEvents:UIControlEventTouchUpInside];
            slider.label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(slider.frame),CGRectGetMinY(slider.frame) - 22,CGRectGetWidth(slider.frame),20)];
            slider.label.backgroundColor = [UIColor clearColor];
            [slider setLabelFloat:slider.value];
            [self.view addSubview:slider.label];

           

        }
    } 
   

                      
    
}
-(void)loadColor {
    if([self.dict objectForKey:[self key]]) {
        self.currentColor = [UIColor colorWithString:[self.dict objectForKey:[self key]]];
        
    }
    else
        self.currentColor = [self defaultColor];

}
-(void)viewDidUnload {
    [self.dict release];
    [self.preview release];
    [self.redSlider release];
    [self.greenSlider release];
    [self.blueSlider release];
    [self.alphaSlider release];
    [self.currentColor release];
    
    [super viewDidUnload];
    
}

-(NSString *)key {
    // the key for your color
    return @"YourKey";
    
}
-(NSString *)prefsPath {
    //path to your preferences plist
    return @"prefpath";
    
}
-(UIColor *)defaultColor {
    //the default color when there is no color set yet
    return [UIColor whiteColor];
    
}

-(void)update:(SESlider *)slider {
    //called whenever a slider is dragged
    if(self.currentColor)
        [self.currentColor release];
    self.currentColor = [[UIColor alloc] initWithRed:self.redSlider.value green:self.greenSlider.value blue: self.blueSlider.value alpha:self.alphaSlider.value];
    self.preview.backgroundColor = self.currentColor;
    [slider setLabelFloat:slider.value];
    
}
-(void)updateDict {
    //called everytime a finger is lifted from a slider
    //colors are saved in a string suing the UIColor-expanded file
    [self.dict setObject:[self.currentColor stringFromColor] forKey:[self key]];
    [self.dict writeToFile:[self prefsPath] atomically:YES];
    
}

@end






