/*:
 ## Hello, Welcome
 
 **Welcome amazing maze.**
 
 **Tips:** Tap to begin and run the code then you will know how to play this game. Remember,find the end point first. Because you don't even know where you will navigate to.
 
 You can use **moveForward(), turnLeft(), turnRight()** to control yourself. And you can use **for** or **while** to program efficiently.
 
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
                page.assessmentStatus = .pass(message: "## Congratulation👏👏🏻👏🏽 \n\nYou have overcome this maze successfully. It's pretty easy right? Let's move to next page. It will not be easy. \n\n[**Next Page**](@next)")
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
moveForward()
moveForward()
turnRight()
moveForward()
moveForward()
turnRight()
moveForward()
moveForward()
turnLeft()
moveForward()
//#-end-editable-code
//#-hidden-code
commit()
//#-end-hidden-code
