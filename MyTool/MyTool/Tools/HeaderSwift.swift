//
//  HeaderSwift.swift
//  Potatso
//


import Foundation
import MBProgressHUD
import Async
import CommonCrypto

let AppNowVersion :Float = 7.0

let ScrollDelayTime :CGFloat = 5.0
let HudDelayTime :CGFloat = 1.0
let HudLongDelayTime :CGFloat = 2.0

func PTTScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

func PTTScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

func NvBarYMargen() -> CGFloat {
    return needBang() ? 24.0 : 0.0
}

func TabBarYMargen() -> CGFloat {
    return needBang() ? 34.0 : 0.0
}

func NvBarHeight() -> CGFloat {
    return needBang() ? 88.0 : 64.0
}
func TabBarheight() -> CGFloat {
    return needBang() ? 84.0 : 49.0
}

func UIColorFromRGB(rgbValue : Int64) -> UIColor {
    return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0, blue: CGFloat((rgbValue & 0xFF) >> 0) / 255.0, alpha: 1.0)
}
func RGBA(r:CGFloat,g:CGFloat,b :CGFloat,a:CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
func X_SafeAreaStatusBarHeight() -> CGFloat {
    return UIApplication.shared.statusBarFrame.size.height
}

//跑道
public enum RocketStatus : Int{
    //四种状态：
    //根本没有动画中
    //在滑行显示中
    //显示文字滚动中
    //在滑行隐藏中,
    case RocketCanStartNewAnimate = 1
    case RocketWillShowText = 2
    case RockeShowingText = 3
    case RockeShowTextOver = 4
}
public enum RocketAutoType : Int{
    //2种状态：
    //手动点击的火箭
    //自动滑行的火箭
    case RocketTypeAuto = 1
    case RocketTypeTap = 2
}

public enum inVCType:Int{
    case ShowTypeLiveRoom = 1,ShowTypePullStreamRoom
}
let RocketViewNotifatiPMTStr = "RocketViewNotifatiPaoDaoGuDingWei"
let liveroom_rocketbackgroundimage = "liveroom_rocketbackgroundimage"
let yellowHeight = 2+28+1
let guardOrNormalGiftOffsetY = 2
let worldGiftOffsetY = 11+3
let blueHeight = 28
let avatarHeight = yellowHeight-2-1-2*2
let fontSize = 10.0
let padding = 4

typealias blcok = ()->Void


func needBang() -> Bool {
    
    let phoneTypeStr :NSString = phoneType() as NSString
    
    if (phoneTypeStr.isEqual(to: "iPhoneX") || phoneTypeStr.isEqual(to: "iPhoneXS") || phoneTypeStr.isEqual(to: "iPhoneXSMax") || phoneTypeStr.isEqual(to: "iPhoneXR")) {
        return true;
    }
    return false
}

func phoneType() -> String {
    
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        //模拟器判断放前边
        //x xs
        if(__CGSizeEqualToSize(UIScreen.main.currentMode?.size ?? CGSize.init(width: 0.0, height: 0.0), CGSize.init(width: 1125.0, height: 2436.0)) ) {
            return"iPhoneX"
        }
        
        if(__CGSizeEqualToSize(UIScreen.main.currentMode?.size ?? CGSize.init(width: 0.0, height: 0.0), CGSize.init(width: 828.0, height: 1792.0)) ) {
            return"iPhoneXR"
        }
        if(__CGSizeEqualToSize(UIScreen.main.currentMode?.size ?? CGSize.init(width: 0.0, height: 0.0), CGSize.init(width: 1242.0, height: 2688.0)) ) {
            return"iPhoneXS"
        }
        
        
        switch identifier {
        case "iPod5,1":                                 return "iPodTouch 5"
        case "iPod7,1":                                 return "iPodTouch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone4"
        case "iPhone4,1":                               return "iPhone4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone5s"
        case "iPhone7,2":                               return "iPhone6"
        case "iPhone7,1":                               return "iPhone6Plus"
        case "iPhone8,1":                               return "iPhone6s"
        case "iPhone8,2":                               return "iPhone6sPlus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone7Plus"
        
        
        case "iPhone10,1", "iPhone10,4":                  return "iPhone8"
        case "iPhone10,2", "iPhone10,5":                  return "iPhone8Plus"
        case "iPhone10,3", "iPhone10,6":                  return "iPhoneX"
        case "iPhone11,2":
            return "iPhoneXS"
        case "iPhone11,4", "iPhone11,6":                  return "iPhoneXSMax"
        case "iPhone11,8":
            return "iPhoneXR"
        
        
        case "iPhone8,4":                               return "iPhoneSE"
        
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPadAir"
        case "iPad5,3", "iPad5,4":                      return "iPadAir2"
        case "iPad6,11", "iPad6,12":                    return "iPad5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPadMini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPadMini2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPadMini3"
        case "iPad5,1", "iPad5,2":                      return "iPadMini4"
        case "iPad6,3", "iPad6,4":                      return "iPadPro9.7Inch"
        case "iPad6,7", "iPad6,8":                      return "iPadPro12.9Inch"
        case "iPad7,1", "iPad7,2":                      return "iPadPro12.9Inch2.Generation"
        case "iPad7,3", "iPad7,4":                      return "iPadPro10.5Inch"
        case "AppleTV5,3":                              return "AppleTV"
        case "AppleTV6,2":                              return "AppleTV4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
}

func alertSurePush( vc : UIViewController, title : String?,msg : String? ,doneTitle : String?,cancleTitle : String?,doneBlock:  (()->(Void))?,cancleBlock: (()->(Void))? ) -> Void {
    let alertVC = UIAlertController.init(title: title, message:msg, preferredStyle: .alert)
    
    if(cancleTitle != nil){
        let cancleAction = UIAlertAction.init(title: cancleTitle ?? "取消", style: .default, handler: { (act) in
            print("点击了 %s",act.title as Any)
            if(cancleBlock != nil){
                cancleBlock!()
            }
        })
        alertVC.addAction(cancleAction)
    }
    
    let sureAction = UIAlertAction.init(title: doneTitle ?? "确定", style: .default, handler: { (act) in
        print("点击了 %s",act.title as Any)
        if(doneBlock != nil){
            doneBlock!()
        }
    })
    alertVC.addAction(sureAction)
    
    vc.present(alertVC, animated: true, completion: nil)
}
func addEndEditing( view : UIView) -> Void {
//    view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.tapView)))
}

//func systemAbove( Version : NSInteger) -> Bool {
//    if (UIDevice.current.systemVersion >= Version){
//        return true
//    }
//    return false
//}


func zoomView(view : UIView,big : Bool,remove : Bool, removeBlock :  (()->(Void))?) -> Void {
    if big{
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }) { (finish) in
            UIView.animate(withDuration: 0.2, animations: {
                view.transform = CGAffineTransform.identity
            })
        }
    }else{
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.2, animations: {
            view.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }) { (finish) in
                UIView.animate(withDuration: 0.3, animations: {
                    view.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
                    
                    
                }) { (finish) in
                    if(remove){
                        view.removeFromSuperview()
                    }
                    if (removeBlock != nil){
                        removeBlock!()
                    }
                }
            }
    }
}

func upView(view : UIView,up : Bool,remove : Bool, removeBlock :  (()->(Void))?) -> Void {
    view.isHidden = false
    if up{
        view.frame = CGRect.init(x: view.frame.origin.x, y: PTTScreenHeight(), width: view.frame.size.width, height: view.frame.size.height)
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.3) {
            view.frame = CGRect.init(x: view.frame.origin.x, y: PTTScreenHeight() - view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height)
        }
    }else{
        view.frame = CGRect.init(x: view.frame.origin.x, y: PTTScreenHeight() - view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height)
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.2, animations: {
            view.frame = CGRect.init(x: view.frame.origin.x, y: PTTScreenHeight(), width: view.frame.size.width, height: view.frame.size.height)
        }) { (finish) in
                if(remove){
                    view.removeFromSuperview()
                }
                if (removeBlock != nil){
                    removeBlock!()
                
              }
          }
    }
}

func hideView(view : UIView,hide : Bool,remove : Bool, removeBlock :  (()->(Void))?) -> Void {
    view.isHidden = false
    if hide{
        view.isHidden = false
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        }) { (finish) in
            if(remove){
                view.removeFromSuperview()
            }
            if (removeBlock != nil){
                removeBlock!()
                
            }
        }
        
    }else{
        view.alpha = 0.0
        UIView.setAnimationsEnabled(true)
        UIView.animate(withDuration: 0.2) {
            view.alpha = 1.0
        }
    }
}

func userLogined() -> Bool {
    let token = UserDefaults.standard.object(forKey: "profile")
    if token == nil {
        return false
    }
    return true
}

func tipLogin() -> Void {
    let hud = MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
    hud.mode = .text
    hud.detailsLabel.text = "请先登录"
    Async.main(after: Double(HudDelayTime)) {
        MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
    }
}

func tipInWindow(msg : String , delayTime : CGFloat) -> Void {
    let hud = MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
    hud.mode = .text
    hud.detailsLabel.text = msg
    Async.main(after: Double(delayTime)) {
        MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
    }
}


func scrollDic(dic : Dictionary<String,Any>) -> Dictionary<String,Any> {
    var tempDic : Dictionary<String,Any> = dic
    
    
    for item in tempDic.keys {
        if(tempDic[item] == nil || (tempDic[item] as? NSNull) != nil ){
            tempDic[item] = ""
        }
        
        if((tempDic[item] as? Dictionary<String,Any>) != nil ){
            let getDic = scrollDic(dic: tempDic[item] as! Dictionary<String,Any>)
            tempDic[item] = getDic
        }
        
        if((tempDic[item] as? [Dictionary<String,Any>]) != nil ){
            
            var tempArr : [Dictionary<String,Any>] = (tempDic[item] as! [Dictionary<String,Any>])
            
            var tempNArr : [Dictionary<String,Any>]? = []
            tempNArr?.removeAll()
            
            for var i in tempArr{
                let iDic = scrollDic(dic: i as! Dictionary<String,Any>)
                tempNArr?.append(iDic)
            }
            
            tempDic[item] = tempNArr
            
        }
        
    }
    
    return tempDic
}
func timeIntervalChangeToTimeStr(timeInterval:TimeInterval, dateFormat:String?) -> String {
    let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval)
    let formatter = DateFormatter.init()
    if dateFormat == nil {
        formatter.dateFormat = "yyyy-MM-dd"
    }else{
        formatter.dateFormat = dateFormat
    }
    return formatter.string(from: date as Date)
}
func getUserValue(key : String) ->Any {
    let profile : Dictionary<String , Any>? = UserDefaults.standard.object(forKey: "profile") as? Dictionary
    
    let user : Dictionary<String , Any>? = profile?["user"] as? Dictionary
    
    
    let value = user?[key]
    
    return value as Any
}
func getPaySignTimeValue(key : String) ->Any {
    let profile : Dictionary<String , Any>? = UserDefaults.standard.object(forKey: "profile") as? Dictionary
    
    let paySignTime : Dictionary<String , Any>? = profile?["signToTime"] as? Dictionary
    
    
    let value = paySignTime?[key]
    
    return value as Any
}

func putNewValueInProFile(key : String, newValue : Any) -> Void {
    var profile : Dictionary<String , Any>? = UserDefaults.standard.object(forKey: "profile") as? Dictionary
    profile?[key] = newValue
    
    saveProfile(profileData: profile)
}

func tipVpnExpired(profile : Dictionary<String , Any>?)  {
    let user : Dictionary<String , Any>? = profile?["user"] as? Dictionary
    
    
    let nowTimeInterval : TimeInterval = Date().timeIntervalSince1970
    //当天可用
    let expireTimeInterval : TimeInterval = user?["expireTime"] as? TimeInterval ?? 0
    print("now:\(nowTimeInterval) exp:\(expireTimeInterval)")
    if(nowTimeInterval > expireTimeInterval){
        tipInWindow(msg: "\("VipExpireTip".localized())",delayTime: HudLongDelayTime)
    }
}
func updateExpireDate(profile : Dictionary<String , Any>?)  {
    let user : Dictionary<String , Any>? = profile?["user"] as? Dictionary
    
    let nowTimeInterval : TimeInterval = Date().timeIntervalSince1970
    //当天可用
    let expireTimeInterval : TimeInterval = user?["expireTime"] as? TimeInterval ?? 0
    
    if(nowTimeInterval > expireTimeInterval){
        tipInWindow(msg: "\("VipExpireTip".localized())",delayTime: HudLongDelayTime)
    }
}


func saveProfile(profileData : Dictionary<String,Any>!) -> Void {
    let profile : Dictionary<String,Any> = profileData
    
    UserDefaults.standard.set(scrollDic(dic: profile), forKey: "profile")
    UserDefaults.standard.synchronize()
}

public func md5(strs:String) ->String!{
  let str = strs.cString(using: String.Encoding.utf8)
  let strLen = CUnsignedInt(strs.lengthOfBytes(using: String.Encoding.utf8))
  let digestLen = Int(CC_MD5_DIGEST_LENGTH)
  let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
  CC_MD5(str!, strLen, result)
  let hash = NSMutableString()
  for i in 0 ..< digestLen {
      hash.appendFormat("%02x", result[i])
  }
  result.deinitialize()
  return String(format: hash as String)
}




