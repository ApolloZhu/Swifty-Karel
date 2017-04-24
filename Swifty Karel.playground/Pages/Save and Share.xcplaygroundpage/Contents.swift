/*:
 [Previous](@previous) | [Next](@next)
 ****
 # Save and Share
 I'm sure you are having fun with Karel, so you definitely want to save your progress. 
 */

Playground.current.isAnimationEnabled = false
helloWWDC17()

//: ## Save as an Image
//: You may notice there is a long, weird link below the image. That is where the image located in your computer!

Playground.current.saveAsImage(withName: "Karel's Selfie")

//: ## Save to a file
//: Save current world to a file

Playground.current.saveAsWorldModel(withName: "My Awesome World")

//: You can load your saved world like this. Now we can refer to it as the `model`.

let model = WorldModel.named("My Awesome World")!

//: If you are curious, these are the data representing the world we just saved.

model.ascii

//: And finally, let's display the model. It should be exactly the same as the world before.

Playground.current.show(worldModel: model)

/*:
 ****
 [Previous](@previous) | [Next](@next)
 */
