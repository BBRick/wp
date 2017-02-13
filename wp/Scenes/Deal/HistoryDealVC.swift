//
//  HistoryDealVC.swift
//  wp
//
//  Created by 木柳 on 2017/1/4.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

class HistoryDealCell: OEZTableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var failLabel: UILabel!
    // 盈亏
    @IBOutlet weak var statuslb: UILabel!
    override func update(_ data: Any!) {
        if let model: PositionModel = data as! PositionModel? {
            nameLabel.text = "\(model.name)"
            timeLabel.text = Date.yt_convertDateToStr(Date.init(timeIntervalSince1970: TimeInterval(model.positionTime)), format: "yyyy.MM.dd HH:mm:ss")
            priceLabel.text = "¥" + "\(model.openPrice)"
            priceLabel.textColor = model.buySell == 1 ? UIColor.init(hexString: "E9573F") : UIColor.init(hexString: "0EAF56")
          // UIColor.green
            statuslb.backgroundColor = model.result == 1  ? UIColor.red : (model.result == -1 ?  UIColor.green :  UIColor.green)
            
            statuslb.text =  model.result == 1  ?  "盈" : (model.result == -1 ?  "亏" :  "亏")
//                model.result ? "盈" :  "亏"
            
//            let string : NSString =  "\(model.grossProfit)" as NSString
//            
//            let rangge : NSRange = string.range(of: "-")
            
//            print("\(model.grossProfit)")
//            if  model.grossProfit < 0{
//                statuslb.backgroundColor = UIColor.init(hexString: "0EAF56")
//                statuslb.text =  "亏"
//            }else{
//                statuslb.backgroundColor =  UIColor.init(hexString: "E9573F")
//                statuslb.text =  "盈"
//
//            }
            statuslb.layer.cornerRadius = 3
            
            statuslb.clipsToBounds = true
//            print(model.buySell)
            
            
//            winLabel.text = model.limit > 0 ? "止盈\(model.limit*10)%" : "止盈无"
//            failLabel.text = model.stop > 0 ? "止损\(model.stop*10)%" : "止损无"
        }
    }
}

class HistoryDealVC: BasePageListTableViewController {
    var models: [PositionModel] = []
    
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    override func didRequest(_ pageIndex: Int) {
        AppAPIHelper.deal().historyDeals(complete: {[weak self] (result) -> ()? in
            if let models: [PositionModel] = result as! [PositionModel]?{
                if pageIndex == 1 {
                    self?.models =  models
                    self?.didRequestComplete(self?.models as AnyObject?)
                }else{
                
                    self?.models = (self?.models)! + models
                    self?.didRequestComplete(self?.models as AnyObject?)
                }
               
            }
            return nil
            }, error: errorBlockFunc())
//        initData()
    }
    //MARK: --DATA
    func initData() {
        AppAPIHelper.deal().historyDeals(complete: {[weak self] (result) -> ()? in
            if let models: [PositionModel] = result as! [PositionModel]?{
                self?.models = (self?.models)! + models
                self?.didRequestComplete(self?.models as AnyObject?)
            }
            return nil
        }, error: errorBlockFunc())
    }
    //MARK: --UI
    func initUI() {
        tableView.rowHeight = 75
    }

}
