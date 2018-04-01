/*:
 ## Welcome the second level
 
 Tap to begin.
 
 **Tips:** Now, you have only 10 seconds to remember the maze. Then you will navigate to a location. Yep, I won't tell you the location. Close you eyes after you were navigated, the maze are allways in your mind.
 
 ### I hope you can pass this level

 */

//#-hidden-code
import PlaygroundSupport
let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy

public func start() {
    proxy.send(PlaygroundValue.integer(4))
}
public func moveForward() {
    proxy.send(PlaygroundValue.integer(0))
}
public func turnLeft() {
    proxy.send(PlaygroundValue.integer(1))
}
public func turnRight() {
    proxy.send(PlaygroundValue.integer(3))
}
public func commit() {
    proxy.send(PlaygroundValue.integer(5))
}
class MyClassThatListens: PlaygroundRemoteLiveViewProxyDelegate {
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {
    }
    func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue) {
        if case let .dictionary(dic) = message {
            guard case let .boolean(success)? = dic["success"] else {
                return
            }
            
            if Bool(success) { //in good mood then success
                page.assessmentStatus = .pass(message: "## Congratulation👏👏🏻👏🏽 \n\nYou have complete one more diffiucal maze. In next page, I will show you how Playground can help us find the way out of the maze. \n\n[**Next Page**](@next)")
            } else {
                let solution = "```swift\nfor _ in 0 ... 3 {\n  moveForward()\n}\nturnLeft()\nmoveForward()\nturnRight()\nmoveForward()\nmoveForward()\nturnLeft()\nmoveForward()\nmoveForward()\nturnLeft()\nmoveForward()\nmoveForward()\nmoveForward()\nturnRight()\nmoveForward()\nmoveForward()\nturnRight()\nmoveForward()\nturnLeft()\nmoveForward()\nturnRight()\nmoveForward()\nmoveForward()\n```"
                page.assessmentStatus = .fail(hints: ["## Don't give up \n\n Keep going and you will find the way out.", "If you are tired, you can check the solution. In next page, I will show you how Playground can help us find the way out of the maze. \n\n[**Next Page**](@next)"], solution: solution)
            }
        }
    }
}

let listener = MyClassThatListens()
proxy.delegate = listener



start()
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, moveForward(), turnLeft(), turnRight(), while, func, for)
//#-editable-code Tap to enter code
moveForward()

//#-end-editable-code
//#-hidden-code
commit()
//#-end-hidden-code
