

import Foundation
import UIKit

class NodeListCell: UITableViewCell {
    
    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var speedLb: UILabel!
    
    var url : String? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let v : UITableViewCell  = Bundle.main.loadNibNamed("NodeListCell", owner: self, options: nil)?.last as! UITableViewCell
        
        v.frame = CGRect.init(x: 0, y: 0, width: PTTScreenWidth(), height: 40.0)
        addSubview(v)
        
        nameLb.adjustsFontSizeToFitWidth = true
        speedLb.adjustsFontSizeToFitWidth = true
    }
    
    
    
    func config(configUrl : String,speed : String?) -> Void {
        url = configUrl
        
        nameLb.text = url
        if (speed != nil && (!NSString.init(string: speed!).isEqual(to: "")))  {
            speedLb.text = speed
        }else{
            
            speedLb.text = ""
        }
    }
    
}
