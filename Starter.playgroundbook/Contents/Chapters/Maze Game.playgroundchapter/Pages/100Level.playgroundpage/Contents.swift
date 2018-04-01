/*:
 ## Do you think AI will rules the world ?
 
 **I think humans are smarter than robots. You guys know how Playground find the way out of the maze. How anout you? I think you can!**
 
 **Now you will navigate to bottom left** and you have only 20s to remember this maze. Move step by step, if you move into a wrong way, you will be back. Success belongs to the perseverance, **right**?
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
                page.assessmentStatus = .pass(message: "## Congratulation👏👏🏻👏🏽 \n\nYou complete this maze. Yep, That's what I think. We are smarter then robots right? Thanks for playing my game!")
            } else {
                page.assessmentStatus = .fail(hints: ["# Keep on !"], solution: nil)
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
