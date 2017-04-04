/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Save and Share
 I'm sure you are having fun with Karel, so you definitely want to sae your progress. You have a several choices.
 */
helloWWDC17()
//: ## Save as an Image
//: You may notice there is a long, weird link below the image. That is where the image is!

Playground.current.saveAsImage(withName: "Karel's Selfie")

//: ## Save to a file
//: Save current world to a file

Playground.current.saveAsWorldModel(withName: "My Awesome World")

//: You can load your saved world like this

let model = WorldModel.named("My Awesome World")!

//: If you are curious, here is what the file contains

model.ascii

//: Then let's load the world back

Playground.current.show(worldModel: model)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
