//
//  BuyProductVC.swift
//  wp
//
//  Created by mu on 2017/2/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import DKNightVersion
class BuyProductVC: UIViewController {
    
    
    @IBOutlet weak var buyCountLabel: UILabel!
    @IBOutlet weak var countSlider: UISlider!
    @IBOutlet weak var dingjinLabel: UILabel!
    @IBOutlet weak var dingjinPLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var huoyunBtn: UIButton!
    @IBOutlet weak var doubleBtn: UIButton!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var countBtn: UIButton!
    @IBOutlet weak var countConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        view.backgroundColor = UIColor.clear
        contentView.layer.cornerRadius = 3
        buyCountLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: AppConst.Color.main)
        countBtn.dk_setTitleColorPicker(DKColorTable.shared().picker(withKey: AppConst.Color.main), for: .normal)
        countSlider.setThumbImage(UIImage.init(named: "buyPoint"), for: .normal)
        
        buyBtn.setTitle(DealModel.share().dealUp ? "买涨" : "买跌", for: .normal)
        
        let colorKey = DealModel.share().dealUp ? AppConst.Color.buyUp : AppConst.Color.buyDown
        dingjinLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        dingjinPLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        moneyLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        feeLabel.dk_textColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        buyBtn.dk_backgroundColorPicker = DKColorTable.shared().picker(withKey: colorKey)
        
        let selectBtnName = DealModel.share().dealUp ? "upSelect" : "downSelect"
        huoyunBtn.setImage(UIImage.init(named: selectBtnName), for: .selected)
        doubleBtn.setImage(UIImage.init(named: selectBtnName), for: .selected)
        selectTypeBtnTapped(doubleBtn)
    }
    
    @IBAction func changeCount(_ sender: UISlider) {
        let value = sender.value
        let sliderWidth = countSlider.frame.width
        countConstraint.constant = sliderWidth * CGFloat(value) / 10.0 - 34
        countBtn.setTitle("\(Int(value))", for: .normal)
        buyCountLabel.text = "当前选择手数 \(Int(value))"
    }
    
    @IBAction func selectTypeBtnTapped(_ sender: UIButton) {
        sender.isSelected = true
        if huoyunBtn == sender {
            doubleBtn.isSelected = false
        }else{
            huoyunBtn.isSelected = false
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        dismissController()
    }
    
    @IBAction func buyBtnTapped(_ sender: UIButton) {
        let buyModel: PositionModel = PositionModel()
        buyModel.id = UserModel.currentUserId
        buyModel.token = UserModel.token ?? ""
        buyModel.code = (DealModel.share().buyProduct?.code)!
        buyModel.buySell = DealModel.share().dealUp ? 1 : -1
        buyModel.amount = Int(countSlider.value)
        AppAPIHelper.deal().buildDeal(model: buyModel, complete: { [weak self](result) -> ()? in
            self?.dismissController()
            return nil
        }, error: errorBlockFunc())
    }
    
}
