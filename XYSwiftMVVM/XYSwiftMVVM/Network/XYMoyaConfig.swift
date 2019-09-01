//
//  XYMoyaConfig.swift
//  XYSwiftMVVM
//
//  Created by Wcaulpl on 2019/6/18.
//  Copyright © 2019 Wcaulpl. All rights reserved.
//

import Foundation
import Moya
import HandyJSON


/**
 1.状态码 根据自家后台数据更改
 
 - Todo: 根据自己的需要更改
 **/
enum HttpCode : Int {
    case success = 1 //请求成功的状态吗
    case needLogin = -1  // 返回需要登录的错误码
}

/**
 2.为了统一处理错误码和错误信息，在请求回调里会用这个model尝试解析返回值
 - Todo: 根据自家后台更改。
 **/
extension Array: HandyJSON{}

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: ReturnData<T>?
}

/**
 3.配置TargetType协议可以一次性处理的参数
 
 - Todo: 根据自己的需要更改，不能统一处理的移除下面的代码，并在DMAPI中实现
 
 **/
public extension TargetType {
    var baseURL: URL {
        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone/")!
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}

/**
 4.公共参数
 
 - Todo: 配置公共参数，例如所有接口都需要传token，version，time等，就可以在这里统一处理
 
 - Note: 接口传参时可以覆盖公共参数。下面的代码只需要更改 【private var commonParams: [String: Any]?】
 
 **/
extension URLRequest {
    //TODO：处理公共参数
    private var commonParams: [String: Any]? {
        //所有接口的公共参数添加在这里例如：
        //        return ["token": "",
        //                "version": "ios 1.0.0"
        //        ]
        return nil
    }
}
