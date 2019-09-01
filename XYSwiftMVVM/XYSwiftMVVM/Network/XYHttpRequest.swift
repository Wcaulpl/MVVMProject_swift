//
//  NetworkTools.swift
//  XYSwiftMVVM
//
//  Created by Wcaulpl on 2019/6/18.
//  Copyright © 2019 Wcaulpl. All rights reserved.
//

import Foundation
import HandyJSON
import Moya
import RxSwift

let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = currentVc else { return }
    switch type {
    case .began:
        print("显示 加载视图")
//        MBProgressHUD.hide(for: vc.view, animated: false)
//        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended:
        print("隐藏 加载视图")
//        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<XYApi>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let XYHttpRequest = MoyaProvider<XYApi>(requestClosure: timeoutClosure)
let XYHttpLoadingRequest = MoyaProvider<XYApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension Data {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String(data: self, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
}


extension MoyaProvider {
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) {
        guard let completion = completion else { return }

        //如果需要读取缓存，则优先读取缓存内容
        if !isReachable(), let data = XYSaveFiles.read(path: target.path) {
            let response = data.mapModel(ResponseData<T>.self)
            completion(response.data?.returnData)
        }
        request(target, completion: { (result) in
            print(result)
            if let error = result.error {
                let statusCode = error.response?.statusCode ?? 0
                let errorCode = "请求出错，错误码：" + String(statusCode)
                print(error.errorDescription ?? errorCode)
            }
            guard let response = try? result.value?.mapModel(ResponseData<T>.self) else {
                print("数据解析失败")
                completion(nil)
                return
            }

            if let responseData = result.value?.data {
                XYSaveFiles.save(path: target.path, data:responseData)
            }
            completion(response.data?.returnData)
        })
    }
}
