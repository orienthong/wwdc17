/*:
 ## Hello, Welcome
 
 For you guys first playing my awesome playground, I think is better to know about you. What's your name and how are you?
 
 Simply **enter the [myName](glossary://myName) property** and **show your mood** currently using two different function **[notGood()](glossary://notGood()) and [sayHello()](glossary://sayHello())**
 
 */

//#-hidden-code
import PlaygroundSupport
let page = PlaygroundPage.current


page.needsIndefiniteExecution = true

let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

class MyClassThatListens: PlaygroundRemoteLiveViewProxyDelegate {
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {
    }
    func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue) {
        if case let .dictionary(dic) = message {
            guard case let .boolean(success)? = dic["mood"], case let .string(assessment)? = dic["assessment"] else {
                return
            }
            
            if Bool(success) { //in good mood then success
                page.assessmentStatus = .pass(message: assessment)
            } else { //in bad mood then fail
                page.assessmentStatus = .fail(hints: [assessment], solution: nil)
            }
        }
    }
}

let listener = MyClassThatListens()
proxy?.delegate = listener

func sendMyName(_ name: String) {
    proxy?.send(.string("\(name)"))
}
func sayHello() {
    proxy?.send(.boolean(true))
}
func notGood() {
    proxy?.send(.boolean(false))
}
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, myName, sayHello(), notGood())
//#-editable-code Tap to enter your name
myName = "<#name#>"
//#-end-editable-code
//#-hidden-code
sendMyName(myName)
//#-end-hidden-code

//#-editable-code Tap to choose your mood
sayHello()
//#-end-editable-code


