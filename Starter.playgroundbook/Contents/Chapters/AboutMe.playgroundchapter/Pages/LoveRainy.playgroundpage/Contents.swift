/*:
 ## Do you love rainy?🌧 or snow?❄️ or sunny?🌝
 I pretty love coding in rainy day. Because I love listening the rainy sound. The sound can relax myself. And I can pay more attention to learn coding.
 
 You guys can type **[preferSnow()](glossary://preferSnow()) ,[preferRainy()](glossary://preferRainy()) or [preferSunny()](glossary://preferSunny())** to choose the weather you like. And move you iPad to see in different angle.
 
 **Tips** If you found that your scene could not rotate in right way. Please make sure your iPad orientation is landscape and the Home button is in your right hand side.
 
 */


//#-hidden-code
import PlaygroundSupport
let page = PlaygroundPage.current

let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy

func preferRainy() {
    proxy.send(.string("rainy"))
}
func preferSnow() {
    proxy.send(.string("snow"))
}
func preferSunny() {
    proxy.send(.string("sunny"))
}
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, preferRainy(), preferSnow(), preferSunny())
//#-editable-code Tap to write code
preferRainy()

//#-end-editable-code

