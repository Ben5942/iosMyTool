
import Foundation
import UIKit

class NodeListView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var fatherVC: UIViewController? = nil
    var urlS : [String]? = []
    
    @IBOutlet weak var tipLb: UILabel!
    
    @IBOutlet weak var viewForTap: UIView!
    
    @IBOutlet weak var nodeListView: UITableView!
    
    
    @IBOutlet weak var contentView: UIView!
    
    init(frame: CGRect, fataherVc : UIViewController) {
        super.init(frame: frame)
        self.fatherVC = fataherVc
        let v : UIView = Bundle.main.loadNibNamed("NodeListView", owner: self, options: nil)?.last as! UIView
        
        addSubview(v)
        addConstraints(contentView: v)
        viewForTap.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.tap)))
        v.layer.backgroundColor = RGBA(r: 0.0, g: 0.0, b: 0.0, a: 0.38).cgColor
        
        nodeListView.register(NodeListCell.self, forCellReuseIdentifier: "NodeListCell")
        
        let corners: UIRectCorner = [UIRectCorner.topLeft, UIRectCorner.topRight]
        let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: PTTScreenWidth(), height: 450), byRoundingCorners: corners, cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        //        maskLayer.frame = contentView.bounds
        maskLayer.frame = CGRect.init(x: 0, y: 0, width: PTTScreenWidth(), height: 450)
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func addConstraints(contentView : UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView, attribute: .leading,
                                            relatedBy: .equal, toItem: self, attribute: .leading,
                                            multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .trailing,
                                        relatedBy: .equal, toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal,
                                        toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .bottom,
                                        relatedBy: .equal, toItem: self, attribute: .bottom,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
    }
    
    @objc func tap() -> Void {
        upView(view: contentView, up: false, remove: false) { () -> (Void) in
            self.isHidden = true
        }
    }
    
    
    
    
    @IBAction func testSpeed(_ sender: Any) {
        //hud开启
        //开启循环初始值
        
        nextPing(index: 0)
    }
    
    
    
    
    @IBAction func clickCancle(_ sender: Any) {
    }
    
    
    
    @IBAction func clickSure(_ sender: Any) {
    }
    
    var speedArr : [String]? = []
    
    func getUrls(urlList : [String]) -> Void {
        urlS = urlList
        speedArr?.removeAll()
        for _ in (urlS ?? []) {
            speedArr?.append("")
        }
        
        nodeListView.reloadData()
        self.isHidden = false
        upView(view: contentView, up: true, remove: false, removeBlock: nil)
        
        if urlS?.count ?? 0>7 {
            tipLb.isHidden = false
        }else{
            tipLb.isHidden = true
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlS?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : NodeListCell = tableView.dequeueReusableCell(withIdentifier: "NodeListCell", for: indexPath) as! NodeListCell
        cell.config(configUrl: urlS![indexPath.row],speed: speedArr![indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    
    
    func nextPing(index : Int) -> Void {
        
        if (urlS == nil || urlS!.count <= 0) {
            return
        }
        
        let nowProxy = urlS![index]
        speedArr![index] = ""
        
        var sev = STDPingServices.init(address: nowProxy)
        sev!.callbackHandler = { (item, arr) in
            if (item?.status == STDPingStatus.didStart) {
                //开始发包
                print("didStart:\(self.speedArr![index]) index :\(index)")
            }else if (item?.status == STDPingStatus.didFailToSendPacket) {
                //发包失败
                self.speedArr![index] = "连接失败"
                print("didFailToSendPacket:\(self.speedArr![index]) index :\(index)")
                if (index + 1 < self.urlS!.count) {
                    self.nextPing(index: (index + 1))
                }
                if (index + 1 >= self.urlS!.count) {
                    self.nodeListView.reloadData()
                }
            }else if (item?.status == STDPingStatus.didReceivePacket) {
                //收到回包
                self.speedArr![index] = String.init(format: "%.2fms", item?.timeMilliseconds ?? 0)
            print("didReceivePacket:\(self.speedArr![index]) index :\(index)")
                if (index + 1 < self.urlS!.count) {
                    self.nextPing(index: (index + 1))
                }
                if (index + 1 >= self.urlS!.count) {
                    self.nodeListView.reloadData()
                }
            }else if (item?.status == STDPingStatus.didReceiveUnexpectedPacket) {
                //收到意外回包
                self.speedArr![index] = "超时"
                if (index + 1 < self.urlS!.count) {
                    self.nextPing(index: (index + 1))
                }
                if (index + 1 >= self.urlS!.count) {
                    self.nodeListView.reloadData()
                }

                print("didReceiveUnexpectedPacket:\(self.speedArr![index]) index :\(index)")
            }else if (item?.status == STDPingStatus.didTimeout) {
                //超时
                self.speedArr![index] = "超时"
            print("didTimeout:\(self.speedArr![index]) index :\(index)")
                if (index + 1 < self.urlS!.count) {
                    self.nextPing(index: (index + 1))
                }
                if (index + 1 >= self.urlS!.count) {
                    self.nodeListView.reloadData()
                }
            }else if (item?.status == STDPingStatus.error) {
                //失败
                self.speedArr![index] = "连接失败"
                if (index + 1 < self.urlS!.count) {
                    self.nextPing(index: (index + 1))
                }
                if (index + 1 >= self.urlS!.count) {
                    self.nodeListView.reloadData()
                }
                print("error:\(self.speedArr![index]) index :\(index)")
            }else if (item?.status == STDPingStatus.finished) {
                //完成
                print("finished:\(self.speedArr![index]) index :\(index)")
            }
            
            
            if(item?.status != STDPingStatus.didStart){
                self.urlS![index] = nowProxy
                sev?.cancel()
            }
            
            
            
            
        };
        sev!.startPing();
    }
    
    
    
}










