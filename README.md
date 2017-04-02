> Tell us about the features and technologies you used in your Swift playground.

"Swifty Karel" is inspired by the Karel robot form Stanford University. It uses UIKit to layout and perform animations.  CoreGraphics framework to perform drawings and animations, AVFoundation to play sound effects. 

Technically, this project used a lot of language features of Swift. Using weak references in escaping trailing closures to avoid ARC issue. By encapsulating common operations and functional programming, the code is organized.

Also, to make the playground itself appealing, Playground/Xcode markup language is used to as guide to users. By conforming to CustomPlaygroundQuicklookable, even an abstract model can be elegantly shown to the user.

Due to the known bug with Xcode playground, UIKit animation is having weird behavior, such as animate before the scheduled time, as illustrated in https://cloud.githubusercontent.com/assets/10842684/24583831/f95d2a36-1725-11e7-9430-8e35bc53173f.png
