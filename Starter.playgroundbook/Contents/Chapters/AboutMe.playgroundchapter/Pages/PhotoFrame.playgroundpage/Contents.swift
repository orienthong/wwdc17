/*:
 ## 3D photo frame 🌁
 Hey, you now navigate to 3D Photo Frame page. In this page, you can design your own 3D photo frame.
 
 **Tips** Tap the photo frame and choose your image from your photo album. Build and Run, you guys can choose different colors for the photo frame.
 
 **By the way, you can Take Picture and show on your Facebook if you like.**
 */

//#-hidden-code
import PlaygroundSupport
import UIKit

let page = PlaygroundPage.current

let proxy = page.liveView as! PlaygroundRemoteLiveViewProxy
let color = #colorLiteral(red: 0.341176480054855, green: 0.623529434204102, blue: 0.168627455830574, alpha: 1.0)
let colors = [#colorLiteral(red: 0.0352941192686558, green: 0.117647059261799, blue: 0.164705887436867, alpha: 1.0),#colorLiteral(red: 0.0470588244497776, green: 0.0, blue: 0.129411771893501, alpha: 1.0),#colorLiteral(red: 0.117647059261799, green: 0.0, blue: 0.0666666701436043, alpha: 1.0),#colorLiteral(red: 0.207843139767647, green: 0.0549019612371922, blue: 0.0117647061124444, alpha: 1.0),#colorLiteral(red: 0.200000002980232, green: 0.129411771893501, blue: 0.0196078438311815, alpha: 1.0),#colorLiteral(red: 0.0901960805058479, green: 0.133333340287209, blue: 0.0392156876623631, alpha: 1.0),
              #colorLiteral(red: 0.0588235296308994, green: 0.180392161011696, blue: 0.24705882370472, alpha: 1.0),#colorLiteral(red: 0.062745101749897, green: 0.0, blue: 0.192156866192818, alpha: 1.0),#colorLiteral(red: 0.192156866192818, green: 0.00784313771873713, blue: 0.0901960805058479, alpha: 1.0),#colorLiteral(red: 0.317647069692612, green: 0.0745098069310188, blue: 0.0274509806185961, alpha: 1.0),#colorLiteral(red: 0.309803932905197, green: 0.20392157137394, blue: 0.0392156876623631, alpha: 1.0),#colorLiteral(red: 0.129411771893501, green: 0.215686276555061, blue: 0.0666666701436043, alpha: 1.0),
              #colorLiteral(red: 0.10196078568697, green: 0.278431385755539, blue: 0.400000005960464, alpha: 1.0),#colorLiteral(red: 0.0901960805058479, green: 0.0, blue: 0.301960796117783, alpha: 1.0),#colorLiteral(red: 0.309803932905197, green: 0.0156862754374743, blue: 0.129411771893501, alpha: 1.0),#colorLiteral(red: 0.521568655967712, green: 0.109803922474384, blue: 0.0509803928434849, alpha: 1.0),#colorLiteral(red: 0.505882382392883, green: 0.337254911661148, blue: 0.0666666701436043, alpha: 1.0),#colorLiteral(red: 0.196078434586525, green: 0.341176480054855, blue: 0.10196078568697, alpha: 1.0),
              #colorLiteral(red: 0.141176477074623, green: 0.396078437566757, blue: 0.564705908298492, alpha: 1.0),#colorLiteral(red: 0.121568627655506, green: 0.0117647061124444, blue: 0.423529416322708, alpha: 1.0),#colorLiteral(red: 0.439215689897537, green: 0.0117647061124444, blue: 0.192156866192818, alpha: 1.0),#colorLiteral(red: 0.745098054409027, green: 0.156862750649452, blue: 0.0745098069310188, alpha: 1.0),#colorLiteral(red: 0.725490212440491, green: 0.47843137383461, blue: 0.0980392172932625, alpha: 1.0),#colorLiteral(red: 0.274509817361832, green: 0.486274510622025, blue: 0.141176477074623, alpha: 1.0),
              #colorLiteral(red: 0.176470592617989, green: 0.498039215803146, blue: 0.756862759590149, alpha: 1.0),#colorLiteral(red: 0.176470592617989, green: 0.0117647061124444, blue: 0.560784339904785, alpha: 1.0),#colorLiteral(red: 0.572549045085907, green: 0.0, blue: 0.23137255012989, alpha: 1.0),#colorLiteral(red: 0.925490200519562, green: 0.235294118523598, blue: 0.10196078568697, alpha: 1.0),#colorLiteral(red: 0.952941179275513, green: 0.686274528503418, blue: 0.133333340287209, alpha: 1.0),#colorLiteral(red: 0.341176480054855, green: 0.623529434204102, blue: 0.168627455830574, alpha: 1.0),
              #colorLiteral(red: 0.239215686917305, green: 0.674509823322296, blue: 0.968627452850342, alpha: 1.0),#colorLiteral(red: 0.219607844948769, green: 0.00784313771873713, blue: 0.854901969432831, alpha: 1.0),#colorLiteral(red: 0.807843148708344, green: 0.0274509806185961, blue: 0.333333343267441, alpha: 1.0),#colorLiteral(red: 0.937254905700684, green: 0.34901961684227, blue: 0.192156866192818, alpha: 1.0),#colorLiteral(red: 0.960784316062927, green: 0.705882370471954, blue: 0.200000002980232, alpha: 1.0),#colorLiteral(red: 0.466666668653488, green: 0.764705896377563, blue: 0.266666680574417, alpha: 1.0),
              #colorLiteral(red: 0.258823543787003, green: 0.756862759590149, blue: 0.968627452850342, alpha: 1.0),#colorLiteral(red: 0.364705890417099, green: 0.0666666701436043, blue: 0.968627452850342, alpha: 1.0),#colorLiteral(red: 0.854901969432831, green: 0.250980406999588, blue: 0.47843137383461, alpha: 1.0),#colorLiteral(red: 0.941176474094391, green: 0.498039215803146, blue: 0.352941185235977, alpha: 1.0),#colorLiteral(red: 0.968627452850342, green: 0.780392169952393, blue: 0.345098048448563, alpha: 1.0),#colorLiteral(red: 0.584313750267029, green: 0.823529422283173, blue: 0.419607847929001, alpha: 1.0),
              #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0),#colorLiteral(red: 0.556862771511078, green: 0.352941185235977, blue: 0.968627452850342, alpha: 1.0),#colorLiteral(red: 0.909803926944733, green: 0.47843137383461, blue: 0.643137276172638, alpha: 1.0),#colorLiteral(red: 0.95686274766922, green: 0.658823549747467, blue: 0.545098066329956, alpha: 1.0),#colorLiteral(red: 0.976470589637756, green: 0.850980401039124, blue: 0.549019634723663, alpha: 1.0),#colorLiteral(red: 0.721568644046783, green: 0.886274516582489, blue: 0.592156887054443, alpha: 1.0),
              #colorLiteral(red: 0.803921580314636, green: 0.803921580314636, blue: 0.803921580314636, alpha: 1.0),#colorLiteral(red: 0.600000023841858, green: 0.600000023841858, blue: 0.600000023841858, alpha: 1.0),#colorLiteral(red: 0.501960813999176, green: 0.501960813999176, blue: 0.501960813999176, alpha: 1.0),#colorLiteral(red: 0.254901975393295, green: 0.274509817361832, blue: 0.301960796117783, alpha: 1.0),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)]
func index(for color: UIColor) -> Int {
    for i in 0 ... colors.count {
        if color == colors[i] {
            return i
        }
    }
    return 0
}
enum Model: String {
    case firstFrame
    case secondFrame
    case thridFrame
    case floor
    case background
    case spotLight
}
func change(color: UIColor,for model: Model) {
    let i = index(for: color)
    let Dict: PlaygroundValue = .dictionary([model.rawValue: PlaygroundValue.integer(i)])
    proxy.send(Dict)
}
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-editable-code Tap to change color
change(color: #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0), for: .firstFrame)
change(color: #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0), for: .secondFrame)
change(color: #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0), for: .thridFrame)
change(color: #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0), for: .floor)
change(color: #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0), for: .background)
change(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .spotLight)
//#-end-editable-code




