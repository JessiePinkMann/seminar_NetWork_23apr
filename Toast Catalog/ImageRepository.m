#import "ImageRepository.h"

@implementation ImageRepository

- (UIImage *)imageForItemIdentifier:(NSInteger)itemIdentifier {
    NSString *systemImageName;
    if (itemIdentifier >= 50) {
        systemImageName = [NSString stringWithFormat:@"%li.circle.fill", (long)itemIdentifier];
        UIImage *image = [UIImage systemImageNamed:systemImageName];
        if (image) {
            return [image imageWithTintColor:[UIColor blackColor] renderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }
    return nil;
}



@end
