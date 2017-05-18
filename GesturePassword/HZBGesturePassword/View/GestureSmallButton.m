#import "GestureSmallButton.h"


@implementation GestureSmallButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
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
        CGContextSetRGBStrokeColor(context, 37/255.f, 198/255.f, 255/255.f,1);
        CGContextSetRGBFillColor(context,37/255.f, 198/255.f, 255/255.f,1);
    } else
    {
        CGContextSetRGBStrokeColor(context, 1,1,1,1);
    }
    
    
    
    CGContextSetLineWidth(context,2);
    CGRect frame = CGRectMake(2, 2, bounds.size.width-5, bounds.size.height-5);
    CGContextAddEllipseInRect(context,frame);
    CGContextStrokePath(context);

    CGContextSetRGBFillColor(context,37/255.f, 198/255.f, 255/255.f,1);

    CGContextAddEllipseInRect(context,frame);
    if (_selected)
    {
        CGContextFillPath(context);
    }
    
}


@end
