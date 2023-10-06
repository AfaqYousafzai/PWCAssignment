//
//  ListRequest.swift
//  NetworkKit
//
//  Created by Afaq Ahmad on 10/6/23.
//

import UIKit
import Alamofire

public enum makeURL {
    case getList
    case noList
    
    public func getURl() -> String {
        var url: String = ""
        
        switch self {
        case .getList:
            return "search?country=Pakistan"
        case .noList:
            return "goAndGetErro"
        }
        
    }
}

public class ListRequest: BaseRequest {
    
//    public override var getParams: [String : String] {
//        get {
//            let dicParams : [String : String] = [:]
//            return dicParams
//        }
//    }

    public override var requestType: HTTPMethod {
        get {
            return .get
        }
        set {
            
        }
    }
    
    
    
    
    public override init() {
        super.init()
    }
    
    
}
