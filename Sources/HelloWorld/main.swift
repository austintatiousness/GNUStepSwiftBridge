
// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import FoundationGNUStep
import libobjc2
import AppKitGNUStep
import ObjCSwiftInterop
import AppKit

class AppDelegate: NSApplicationDelegate {
	lazy var window = NSWindow()
	lazy var newWindow = NSWindow()
	lazy var button = NSButton()
	lazy var imageView = NSImageView()
	lazy var button2 = NSButton()
	lazy var newWindowButton = NSButton()
	lazy var textField = NSTextField()
	lazy var image = NSImage.image(named: "Terminal.tiff")
	lazy var textField2 = NSTextField()
	lazy var view = UIView()
	override func applicationDidFinishLaunching(notification: Any?) {
		window.orderFront(sender: self)

		newWindowButton.setTitle(NSString(string: "Show Window"))
		newWindowButton.frame = .init(x: 10, y: 60, width: 100, height: 22)
		newWindowButton.onAction = { button in
			self.newWindow.orderFront(sender: self)
			self.newWindow.setBackgroundColor(.purple)
		}
		view.addSubview(newWindowButton)
		
		imageView.setFrame(.init(x: 0, y: 0, width: 32, height: 32))
		imageView.setImage(self.image!)
		view.addSubview(imageView)
		
		button.setTitle(NSString(string: ""))
		button.setImage(image!)
		button.setFrame(.init(x: 120, y: 60, width: 100, height: 22))
		button.onAction = { button in
			self.textField.stringValue = "\(self.view.frame)"
		}
		view.addSubview(button)
		
		button2.setTitle(NSString(string: "Set Other Window"))
		button2.setFrame(.init(x: 230, y: 60, width: 100, height: 22))
		button2.onAction = { button in
			//self.view.frame = .init(x: 0, y: 32, width: 300, height: 300)
			self.newWindow.setBackgroundColor(.black)
		}
		view.addSubview(button2)
		
		
		self.textField.setBackgroundColor(.clear)
		self.textField.textColor = .init(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5)
		self.textField.isBordered = false
		self.textField.isBezeled = false
		self.textField.drawsBackground = false
		
		self.textField.frame = CGRect(x: 10, y: 100, width: 300, height: 32)
		self.textField.setText(NSString(string: "Unknown Frame"))
		self.textField.font = .boldSystemFontOfSize(size: 30)
		view.addSubview(textField)


		textField2.frame = CGRect(x: 10, y: 140, width: 300, height: 32)
		textField2.setText(NSString(string: "Text"))
		self.textField2.setBackgroundColor(.blue)
		view.addSubview(textField2)
		
		view.setBackgroundColor(.init(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0))
		window.setContentView(view)
		
		
	}
}

@main
struct App {
	static var window = NSWindow()
	static var delegate = AppDelegate()
	static var window2 = NSWindow()

	static var label = NSTextField()
	static func main() {
		print("Hello World Times Two")

		//var poolClass = objc_getClass("NSAutoreleasePool")
		//var poolClassAllocated =  forSwift_objcSendMessage(&objc_getClass("NSAutoreleasePool")!.pointee, sel_registerName("alloc"))
		//_ =  forSwift_objcSendMessage(&poolClassAllocated!.pointee, sel_registerName("init"))

		
		//https://stackoverflow.com/questions/24662864/swift-how-to-use-sizeof
		
		
		
		let napClass =  objc_getClass("NSApplication")
		var sharedApp =  forSwift_objcSendMessage(&napClass!.pointee, sel_registerName("sharedApplication"))
		print("Just created NSApplication")
		

		
		let v = forSwift_objcSendMessage1ID(&sharedApp!.pointee, sel_getUid("setDelegate:"), delegate._nsobjptr!)
		print("made it!")

		
		

		//window.setBackgroundColor(NSColor())

//'UnsafeMutablePointer<Int8>
//UnsafeMutablePointer<UnsafePointer<CChar>?>
		//return
		return NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv.pointee)		
	}
}
