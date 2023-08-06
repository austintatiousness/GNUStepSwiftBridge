# GNUStepSwiftBridge

This is a sample Swift project designed to work with GNUStep Desktop. 

To build, you need to install GNUStep Desktop [https://onflapp.github.io/gs-desktop/index.html] on Debian, then install Swift version 5.8.1 on Debian.

This assumes that file system layout of Onflapp's GNUstep Desktop environment. 

# GORM File and Info_gnustep.plist

I haven't yet figured out how to configure Swift to copy the files into the a folder /Resources within the same folder as the built executable. For now, just copy in the Resources folder into the .build/build/debug folder. 


# Targets
HelloWorld is my playground. It is often not working. 
NSWindowTest is to strictly test the code that creates NSWindow. I am currently investigating why NSWindow objects disappear randmoly. 
