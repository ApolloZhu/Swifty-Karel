> Tell us about the features and technologies you used in your Swift playground.

"Swifty Karel" is inspired by the Karel robot form Stanford University. By giving Karel commands through global functions, it can explore the "world". It is very similar to the lectures provided within Swift Playgrounds on iPad, but in 2D.

The project is highly customizable. The Playground class is implemented as a Singleton, and it contains

Depending on whether or not animation is on Karel itself, `UIView` animation will be preformed, or a scheduled timer will fire after certain delay. The project is playing background music through `AVFoudation`, handled by an lazily initialized player.

Technically, this project used a lot of language features of Swift. Using weak references in escaping trailing closures to avoid ARC issue. By encapsulating common operations and functional programming, the code is organized.

By conforming to `CustomPlaygroundQuicklookable`, even an abstract model can be elegantly shown to the user.

Also, to make the playground itself appealing, Playground/Xcode markup language is used to as guide to users.

![Karel the Robot Learns Swift](https://user-images.githubusercontent.com/10842684/81167960-2183aa80-8f64-11ea-8f85-b017331bad83.png)
