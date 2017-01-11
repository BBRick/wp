//
//  DealSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class DealSocketApi: BaseSocketAPI, DealApi {

    
    //当前仓位列表
    func currentDeals(complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? ""]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .currentDeals, dict: param as [String : AnyObject])
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //当前仓位详情
    func currentDealDetail(positionId: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.position: positionId ]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .currentDealDetail, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //历史仓位列表
    func historyDeals(complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? ""]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .historyDeals, dict: param as [String : AnyObject])
        startModelsRequest(packet, listName: "positioninfo", modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //历史仓位详情
    func historyDealDetail(positionId: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.position: positionId ]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .historyDealDetail, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //建仓
    func buildDeal(model: PositionModel, complete: CompleteBlock?, error:ErrorBlock?){
        model.token = UserModel.token!
        model.id = UserModel.share().currentUser?.uid ?? 0
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .buildDeal, model: model)
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //平仓
    func sellOutDeal(positionId: Int, price: Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.position: positionId,
                                    SocketConst.Key.price: price]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .sellOutDeal, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //修改持仓
    func changeDeal(model: PositionModel, complete: CompleteBlock?, error:ErrorBlock?){
        model.token = UserModel.token!
        model.id = UserModel.share().currentUser?.uid ?? 0
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .changeDeal, model: model)
        startModelRequest(packet, modelClass: PositionModel.self, complete: complete, error: error)
    }
    
    //商品列表
    func products(pid:Int, complete: CompleteBlock?, error:ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.pid: pid]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .products, dict: param as [String : AnyObject])
        startModelsRequest(packet, listName: "goodsinfo", modelClass: ProductModel.self, complete: complete, error: error)
    }
    
    //当时K线数据
    func kChartsData(param: KChartParam, complete: CompleteBlock?, error:ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .kChart, model: param)
        startModelsRequest(packet, listName: "priceinfo", modelClass: KChartModel.self, complete: complete, error: error)
    }
    
    //当时分时数据
    func timeline(param: KChartParam, complete: CompleteBlock?, error:ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .kChart, model: param)
        startModelsRequest(packet, listName: "priceinfo", modelClass: KChartModel.self, complete: complete, error: error)
    }
    
    //当前报价
    func realtime(goodType:String, exchange_name:String, platform_name:String, complete: CompleteBlock?, error:ErrorBlock?) {
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().currentUser?.uid ?? 0,
                                    SocketConst.Key.token: UserModel.token ?? "",
                                    SocketConst.Key.goodType: goodType,
                                    SocketConst.Key.exchange_name: exchange_name,
                                    SocketConst.Key.platform_name: platform_name]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .realtime, dict: param as [String : AnyObject])
        startModelsRequest(packet, listName: "priceinfo", modelClass: ProductModel.self, complete: complete, error: error)
    }
}






