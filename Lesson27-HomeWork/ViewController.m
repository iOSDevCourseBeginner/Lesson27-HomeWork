//
//  ViewController.m
//  Lesson27-HomeWork
//
//  Created by Nick Bibikov on 12/1/14.
//  Copyright (c) 2014 Nick Bibikov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - UITextFieldDelegate
//-------------------------------------------------------------------------------

// Tabbing when press 'Next' button
-(BOOL)textFieldShouldReturn:(UITextField*)textField {
    
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
        
    }
    
    return NO;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:self.telField]) {
    
    NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    NSLog(@"%@", newString);
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    
    NSMutableString* resultString = [NSMutableString new];
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberLength > 0) {
        
        NSString* number = [newString substringFromIndex:[newString length] - localNumberLength];
        
        [resultString appendString:number];
        
        if ([resultString length] > 3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    
    
    if ([newString length] > localNumberMaxLength) {
        
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        
        NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
        
        NSString* area = [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
        
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
        
        NSString* countryCode = [newString substringWithRange:countryCodeRange];
        
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        
        [resultString insertString:countryCode atIndex:0];
    }
    
    textField.text = resultString;
    self.telLabel.text = textField.text;
    
    return NO;
        
    }
    
    return YES;
    
}




#pragma mark - Actions
//-------------------------------------------------------------------------------
- (IBAction)textFieldAction:(UITextField *)sender {
    
    NSInteger numberTag = sender.tag;
    
    for (UILabel* label in self.labelCollection) {
        
        if (label.tag == numberTag) {
            label.text = sender.text;
        }
        
        if (sender.tag == 5) {
            self.ageLabel.text = [NSString stringWithFormat:@"%@ years old", sender.text];
        }
    }
    
}

- (IBAction)buttonDone:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"All Done!"
                                                    message:@"You done home work for Lesson 28 - 'Text fields'. Congradulation!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

@end
