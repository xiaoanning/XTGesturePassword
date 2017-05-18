
#import "HZBGesturePasswordButton.h"

@implementation HZBGesturePasswordButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        _success=YES;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds ;


    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (_selected)
    {
        if (_success)
        {
            CGContextSetRGBStrokeColor(context, 37/255.f, 198/255.f, 255/255.f,1);
            CGContextSetRGBFillColor(context,2/255.f, 174/255.f, 240/255.f,1);
        } else
        {
            CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f,1);
            CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f,1);
        }
        CGRect frame = CGRectMake(bounds.size.width/2-(bounds.size.width/2-10)/2+1, bounds.size.height/2-(bounds.size.width/2-10)/2, bounds.size.width/2-10, bounds.size.height/2-10);


        CGContextAddEllipseInRect(context,frame);
        CGContextFillPath(context);
    } else
    {
        CGContextSetRGBStrokeColor(context, 1,1,1,1);
        
    }
    
    
    
    CGContextSetLineWidth(context,2);
    CGRect frame = CGRectMake(2, 2, bounds.size.width-3, bounds.size.height-3);
    CGContextAddEllipseInRect(context,frame);
    CGContextStrokePath(context);
    if (_success)
    {
        CGContextSetRGBFillColor(context,37/255.f, 198/255.f, 255/255.f,0.3);
    }
    else {
        CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f,0.3);
    }

    CGContextAddEllipseInRect(context,frame);
    if (_selected)
    {
        CGContextFillPath(context);
    }
    
}

-(void)returnToTheOriginalData
{
    _selected = NO ;
    _success = YES ;
    
    [self setNeedsDisplay];
}



@end
