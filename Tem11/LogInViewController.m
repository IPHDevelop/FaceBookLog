//
//  LogInViewController.m
//  Tem11
//
//  Created by Admin on 3/6/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "LogInViewController.h"
#import "Manager.h"
#import <FBSDKCoreKit.h>
#import <FBSDKLoginKit.h>
@import Firebase;
@import FirebaseAuth;

@interface LogInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtemil;

@property (weak, nonatomic) IBOutlet UITextField *txtpassword;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLogIn;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([FBSDKAccessToken currentAccessToken])
    {
        
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}



- (IBAction)LogInBtn:(id)sender {

    NSString * email=self.txtemil.text;
    
    if (!email || [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length<1)
    {
        
        UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"Wrong!!!"
                                                                       message:@"Please enter correct Email"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction *ok= [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * action)
                            {
                                [self.txtemil becomeFirstResponder];
                            }
        ];
        [alert addAction:ok];
        return;
    }
    
    
    
    if (![Manager wrongEmail:email])
    {
        [self.txtemil becomeFirstResponder];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Email address is not valid."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtemil becomeFirstResponder];
                             }];
        [alert addAction:ok];
        return;
    }
    

    NSString* password = self.txtpassword.text;
    if (!password || [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1)
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Password should not be empty."
                                      preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtpassword becomeFirstResponder];
                             }];
        [alert addAction:ok];
        return;
    }
    
    [[FIRAuth auth] signInWithEmail:self.txtemil.text
                           password:self.txtpassword.text
                         completion:^(FIRUser *_Nullable user,NSError *_Nullable error)
    {
        if (error == nil)
        {
        
            
        }
        else
        {
            NSDictionary * detailError = error.userInfo;
            UIAlertController * alert=   [UIAlertController alertControllerWithTitle:@"Error"
                                                               message:detailError[@"NSLocalizedDescription"]
                                                               preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                                      {
                                                          [self.txtemil becomeFirstResponder];
                                                      }
                                 ];
            [alert addAction:ok];
            
        }
    }
    ];
}

- (IBAction)SignUpBtn:(id)sender {
    
    //[self performSegueWithIdentifier:@"signup" sender:nil];

    NSString* email = self.txtemil.text;
    
    if (!email || [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1)
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Email address should not be empty."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtemil becomeFirstResponder];
                             }
                             ];
        [alert addAction:ok];
        
        return;
    }
    
    if (![Manager wrongEmail:email]) {
        [self.txtemil becomeFirstResponder];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Email address is not valid."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtemil becomeFirstResponder];
                             }
                             ];
        [alert addAction:ok];
        
        return;
    }

    NSString* password = self.txtpassword.text;
    
    if (!password || [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1)
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Password should not be empty."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self.txtpassword becomeFirstResponder];
                             }
                             ];
        [alert addAction:ok];
        
        return;
    }
    
    [[FIRAuth auth] createUserWithEmail:self.txtemil.text
                               password:self.txtpassword.text
                             completion:^(FIRUser *_Nullable user,
                                          NSError *_Nullable error)
     {
         if (error == nil)
         {
             
         }
         else
         {
             NSDictionary *detailError = error.userInfo;
             UIAlertController * alert=   [UIAlertController
                                           alertControllerWithTitle:@"Error"                                                                message:detailError[@"NSLocalizedDescription"]                                                                   preferredStyle:UIAlertControllerStyleAlert];
             [self presentViewController:alert animated:YES completion:nil];
             
             UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action)
                                  {
                                      [self.txtemil becomeFirstResponder];
                                  }
                                  ];
             [alert addAction:ok];
             //error.description;
         }
     }
     ];

    
    
    
}

- (IBAction)FaceBookLogInBtn:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions: @[@"public_profile",@"",@"user_likes",@"user_birthday"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
    {
                                if (error)
                                {
                                    NSLog(@"Process error");
                                }
                                else if (result.isCancelled)
                                {
                                    NSLog(@"Cancelled");
                                }
                                else
                                {
                                    NSLog(@"Logged in:%@", result);
                                    if ([FBSDKAccessToken currentAccessToken])
                                    {
                                        
                                        
                                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture,email,birthday,gender,name"}] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id res, NSError *error)
                                         {
                                             if (!error)
                                             {
                                                 
                                                 
                                                 NSString* user_id = res[@"id"];
                                                 NSString* email = res[@"email"];
                                                 NSString* gender = res[@"gender"];
                                                 NSString* user_name = res[@"name"];
                                                 NSString* birthday = res[@"birthday"];
                                                 
                                             }
                                 
                                             else
                                             {
                                                 NSLog(@"%@", [error localizedDescription]);
                                             }
                                         }
                                        ];
                                    }
                                }
    }
    ];
    

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
