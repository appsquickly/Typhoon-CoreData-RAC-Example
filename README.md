#Typhoon Core Data + RAC Sample

Here's a sample that was kindly posted by <a href="https://github.com/rizumita">Ryoichi Izumita</a> showing how to set up an assembly that uses CoreData and RAC. 


#Assemblies

**CDRApplicationAssembly** 

The top-level assembly is <a href="https://github.com/typhoon-framework/Typhoon-CoreData-RAC-Example/blob/master/CoreData%2BDI%2BRAC/Assembly/CDRApplicationAssembly.m">CDRApplicationAssembly</a>. In this assembly: 

* The AppDelegate is injected at startup with some Core Data components. This allows the app delegate to save the context when the application is terminated. 
* The's a <a href="https://github.com/typhoon-framework/Typhoon-CoreData-RAC-Example/blob/master/CoreData%2BDI%2BRAC/CDRViewController.m">CDRViewController</a>, which is declared on the main story board, because we've boot-strapped Typhoon from the <a href="https://github.com/typhoon-framework/Typhoon-CoreData-RAC-Example/blob/master/CoreData%2BDI%2BRAC/CoreData%2BDI%2BRAC-Info.plist">app's plist file</a> all storyboards will be an instance of `TyphoonStoryboard`. These work just like regular storyboards with the added benefit that dependencies are injected according to the rules outline in our assembly. 
* 
**CDRCoreDataComponents**

The main assembly refers to a helper assembly - <a href="https://github.com/typhoon-framework/Typhoon-CoreData-RAC-Example/blob/master/CoreData%2BDI%2BRAC/Assembly/CDRCoreDataComponents.h">CDRCoreDataComponents</a>, which is responsible for setting up core data. 

# LICENSE

Apache License, Version 2.0, January 2004, http://www.apache.org/licenses/

© 2012 - 2014 Jasper Blues and contributors.
