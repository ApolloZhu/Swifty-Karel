# Swifty Karel
Redesigned Karel that is really "Swifty"

## How to Start?
### iOS
```swift
func ViewController: UIViewController, AZ[Super]KarelIDE{
	
	func viewDidLoad(){
		super.viewDidLoad()
		let settings: AZKarelWorldSettings(fromFile: "filename.plist")
		let world = AZKarelWorld(settings)
		view.addSubView(world)
	}
	
	func run(){
		move()
		turnLeft()
		putBeeper()
		pickBeeper()
	}
}

```