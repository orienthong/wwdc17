/*:
 ## Welcome the last page
 Now, I want to explain how I made this maze game. Designing a maze is difficult. Because when you design a big maze, you don't even know if you can find the way out. So I think Computer can help find the way. Computer is smart if you make good use of it.
 
 I use Matrix to design a maze. Just like the welcome scene you saw before.
 Number '0' represent a road and '1' represents a wall. And the location of the top left cornet is Location(z: 0, x: 0). The Playground use BSF algorithm to find the way.
 
 |- - - - - - - - - - - -> +x
 
 |0, 0, 0, 1, 0, 0, 1 ...
 
 |0, 1, 0, 1, 0 ...
 
 |0, 1, 0 ...
 
 V
 
 +z
 
 **In this page**, you can enter different entrence and endPoint. The Playground will help you find the way out. I hope you enjoy.
 */

struct Location {
    var x: Int
    var z: Int
    public init(z: Int, x: Int) {
        self.x = x
        self.z = z
    }
}

//#-hidden-code
import PlaygroundSupport
let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy

var entrance: Location!
var endPoint: Location!
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, entrance, endPoint, Location)
//#-editable-code
entrance = Location(z: 14, x: 0)
endPoint = Location(z: 0, x: 12)
//#-end-editable-code
//#-hidden-code
proxy.send(PlaygroundValue.dictionary(["entrence" : .array([PlaygroundValue.integer(entrance.z), PlaygroundValue.integer(entrance.x)])]))
proxy.send(PlaygroundValue.dictionary(["endPoint" : .array([PlaygroundValue.integer(endPoint.z), PlaygroundValue.integer(endPoint.x)])]))
proxy.send(PlaygroundValue.string("start"))
//#-end-hidden-code



