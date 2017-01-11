//
//  DealVC.swift
//  wp
//
//  Created by 木柳 on 2016/12/25.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class DealVC: BaseTableViewController {
    
    @IBOutlet weak var myMoneyLabel: UILabel!
    @IBOutlet weak var myQuanLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var upDownView: UIView!
    @IBOutlet weak var winRateConstraint: NSLayoutConstraint!
    @IBOutlet weak var kLineView: KLineView!
    @IBOutlet weak var minBtn: UIButton!
    @IBOutlet weak var dealTable: MyDealTableView!
    @IBOutlet weak var titleView: ProductTitleView!
    private var klineBtn: UIButton?
    
    
    //MARK: --LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    deinit {
        DealModel.share().removeObserver(self, forKeyPath: "selectDealModel")
    }
    //MARK: --DATA
    func initData() {
        //初始化持仓数据
        initDealTableData()
        //初始化下商品数据
        initProductData()
        //持仓点击
        DealModel.share().addObserver(self, forKeyPath: "selectDealModel", options: .new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "selectDealModel" {
            if DealModel.share().type == .btnTapped {
                UserDefaults.standard.removeObject(forKey: SocketConst.Key.id)
                return
            }
            
            if DealModel.share().type == .cellTapped {
                DealModel.share().isDealDetail = true
                        performSegue(withIdentifier: BuyVC.className(), sender: nil)
                return
            }
        }
    }
    // 当前列表数据
    func initProductData() {
        AppAPIHelper.deal().products(pid: 0, complete: { [weak self](result) -> ()? in
            if let products: [ProductModel] = result as! [ProductModel]?{
                self?.titleView.products = products
            }
            return nil
        }, error: errorBlockFunc())
    }
    // 持仓列表数据
    func initDealTableData() {
        AppAPIHelper.deal().currentDeals(complete: { [weak self](result) -> ()? in
            if result == nil{
                return nil
            }
            if let resultModel: [PositionModel] = result as! [PositionModel]?{
                self?.dealTable.dealTableData = resultModel
            }
            return nil
        }, error: errorBlockFunc())
    }
    
    //MARK: --UI
    func initUI() {
        timeBtnTapped(minBtn)
        
    }
    
    //MARK: --商品选择
  
    
    //MARK: --KlineView and Btns
    @IBAction func timeBtnTapped(_ sender: UIButton) {
        if let btn = klineBtn {
            btn.isSelected = false
            btn.backgroundColor = UIColor.init(rgbHex: 0xe6e9ed)
        }
        
        kLineView.selectIndex = sender.tag
        sender.isSelected = true
        sender.backgroundColor = AppConst.Color.CMain
        klineBtn = sender
    }
    
    //MARK: --买涨/买跌
    @IBAction func dealBtnTapped(_ sender: UIButton) {
        DealModel.share().dealUp = sender.tag == 1
        DealModel.share().isDealDetail = false
        performSegue(withIdentifier: BuyVC.className(), sender: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == BuyVC.className() {
            return checkLogin()
        }
        return true
    }
}
