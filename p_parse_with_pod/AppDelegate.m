//
//  AppDelegate.m
//  p_parse_with_pod
//
//  Created by Jaime_Andrade on 9/1/16.
//  Copyright © 2016 lab5. All rights reserved.
///

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "AppUtilities.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse setApplicationId:APPLICATION_ID clientKey: CLIENT_KEY];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    PFObject *mipersona = [PFObject objectWithClassName:@"Persona"];
    [mipersona setObject:@"MIGUEL" forKey:@"nombre"];
    [mipersona setObject:@"RAMIREZ" forKey:@"apellido"];
    [mipersona setObject:@21 forKey:@"edad"];
    
    
    // Versión síncrona
        //[miPersona save];
    
    // Versión asíncrona
    [mipersona saveInBackgroundWithBlock:^(BOOL secceeded, NSError *error){
        if(!error){
            NSLog(@"LA PERSONA SE HA GUARDADO CORRECTAMENTE");
        }
        else{
            NSLog(@"SE HA PRODUCIDO UN ERROR EN LA PERSONA");
        }
    }];
    
    //metodo sin internet, encola la peticion y se ejecuta cuando haya conección de internet
        //[miPersona saveEventually];
    
    
    
    //***************************Guardar nota de una persona************************************
    
    PFObject *miNota = [PFObject objectWithClassName:@"Nota"];
    [miNota setObject:@8 forKey:@"nota"];
    //paso como parámetro el objecto persona generado anteriormente.
    [miNota setObject:mipersona forKey:@"notaPersona"];
    //[miNota save];
    [miNota saveInBackgroundWithBlock:^(BOOL secceeded, NSError *error){
        if(!error){
            NSLog(@"LA NOTA SE HA GUARDADO CORRECTAMENTE");
        }
        else{
            NSLog(@"SE HA PRODUCIDO UN ERROR EN LA NOTA");
        }
    }];
    
    
    //***************************Consulta de registro ******************************************
    PFQuery *query = [PFQuery queryWithClassName:@"Persona"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"La busqueda se ha ejecutado y el NSArray objects contiene los resultados de la mismo");
        }
        else{
            NSLog(@"se ha producido un error al ejecutar la búqueda");
        }
    }];
    //cuando la búsqueda es más detallada, se agrega el ntes de la ejecución del metodo find la siguiente linea
    [query whereKey:@"nombre" equalTo:@"MIGUEL"];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
