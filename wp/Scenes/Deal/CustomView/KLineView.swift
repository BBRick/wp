//
//  KLineView.swift
//  wp
//
//  Created by 木柳 on 2016/12/26.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit
import Charts
class KLineView: UIView {
    @IBOutlet weak var miuCharts: LineChartView!
    @IBOutlet weak var min15Charts: CombinedChartView!
    @IBOutlet weak var hourCharts: CombinedChartView!
    @IBOutlet weak var dayCharts: CombinedChartView!
    var selectIndex: NSInteger!{
        didSet{
            switch selectIndex {
            case 1:
                bringSubview(toFront: self.miuCharts)
                break
            case 2:
                bringSubview(toFront: self.min15Charts)
                break
            case 3:
                bringSubview(toFront: self.hourCharts)
                break
            case 4:
                bringSubview(toFront: self.dayCharts)
                break
            default:
                bringSubview(toFront: self.miuCharts)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectIndex = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initLineChartData()
        initBarChartData()
        initCandleStickData()
    }

    func initLineChartData() {
        let lineCount = [7.0,6.0,7.0,8.0,9.0,5.0,6.0,7.0,8.0,9.0]
        let L = [1.0,2.0,3.0,4.0,5.0,4.0,3.0,2.0,1.0,1.0]
        let O = [3.0,4.0,5.0,6.0,7.0,6.0,5.0,4.0,3.0,2.0]
        
        var entrys: [ChartDataEntry] = []
        var entrys1: [ChartDataEntry] = []
        var entrys2: [ChartDataEntry] = []
        for i in 0...lineCount.count - 1  {
            let entry = ChartDataEntry.init(x: Double(i), y: lineCount[i])
            entrys.append(entry)
            
            let entry1 = ChartDataEntry.init(x: Double(i), y: L[i])
            entrys1.append(entry1)
            
            let entry2 = ChartDataEntry.init(x: Double(i), y: O[i])
            entrys2.append(entry2)
            
        }
        
        let set: LineChartDataSet = LineChartDataSet.init(values: entrys, label: "折线图")
        set.mode = .stepped
        set.colors = [UIColor.blue]
        
        let set1: LineChartDataSet = LineChartDataSet.init(values: entrys1, label: "折线图1")
        set1.mode = .cubicBezier
        set1.colors = [UIColor.red]
        
        let set2: LineChartDataSet = LineChartDataSet.init(values: entrys2, label: "折线图2")
        set2.mode = .horizontalBezier
        set2.colors = [UIColor.green]
        
        let data: LineChartData  = LineChartData.init(dataSets: [set,set1,set2])
        
        let combinData: CombinedChartData = CombinedChartData.init()
        combinData.lineData = data
        min15Charts.data = combinData
    }
    
    func initCandleStickData() {
        
        let H = [7.0,6.0,7.0,8.0,9.0,5.0,6.0,7.0,8.0,9.0]
        let L = [1.0,2.0,3.0,4.0,5.0,4.0,3.0,2.0,1.0,1.0]
        let O = [3.0,4.0,5.0,6.0,7.0,6.0,5.0,4.0,3.0,2.0]
        let C = [7.0,6.0,4.0,5.0,3.0,4.0,5.0,6.0,7.0,2.0]
        
        var entrys: [CandleChartDataEntry] = []
        for  i  in 0...H.count-1 {
            let entry = CandleChartDataEntry.init(x: Double(i), shadowH: H[i], shadowL: L[i], open: O[i], close: C[i])
            entrys.append(entry)
        }
        
        let set: CandleChartDataSet = CandleChartDataSet.init(values: entrys, label: nil)
        set.shadowColor = UIColor.red
        set.increasingColor = UIColor.red
        set.decreasingColor = UIColor.blue
        set.neutralColor = UIColor.red
        set.increasingFilled = true
        let dataSets: [IChartDataSet] = [set]
        let data: CandleChartData = CandleChartData.init(dataSets: dataSets)
        let combinData: CombinedChartData = CombinedChartData.init()
        combinData.candleData = data
        miuCharts.data = combinData
    }
    
    
    func initBarChartData() {
        
        let values = [20.0, 4.0, 6.0]
        var barEntrys: [BarChartDataEntry] = []
        for (index, value) in values.enumerated() {
            let barEntry: BarChartDataEntry = BarChartDataEntry.init(x: Double(index), yValues: [value], label: "title\(index)")
            barEntrys.append(barEntry)
        }
        let set: BarChartDataSet = BarChartDataSet.init(values: barEntrys, label: nil)
        set.colors = [UIColor.red,UIColor.blue,UIColor.purple]
        let dataSets: [IChartDataSet] = [set]
        let data: BarChartData = BarChartData.init(dataSets: dataSets)
        let combinData: CombinedChartData = CombinedChartData.init()
        combinData.barData = data
        hourCharts.data = combinData
    }

    
}