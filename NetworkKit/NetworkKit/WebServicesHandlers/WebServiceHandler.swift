//
//  WebServiceHandler.swift
//  NetworkKit
//
//  Created by Afaq Ahmad on 10/5/23.
//

import UIKit
import Alamofire
import PKHUD

public class WebServiceHandler {
    
    // generic base url will be set here on app level
    public static var baseUrl = PWCConfigurations.getBaseURL()
    public static func callWebService(url: makeURL, request: BaseRequest, completion: @escaping (_ result: Data?, _ error: Error?, _ code: Int) -> Void){
        
        //checking for internet reachability
        if PWCAssignmentProjectGeneralElements.shared.internetConnectivity == .unavailable {
            HUD.hide()
            PWCAssignmentProjectGeneralElements.showAlertWithMessage("No Internet Connection", sender: nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        
        
        var parameterEncoding : ParameterEncoding
        
        if request.requestType == HTTPMethod.post {
            
            parameterEncoding = JSONEncoding.default
        }
        else {
            
            parameterEncoding = URLEncoding.default
        }
        
        AF.request(baseUrl + url.getURl(), method: request.requestType, parameters: request.getParams, encoding: parameterEncoding, headers: headers).responseData { (response:DataResponse<Data, AFError>) in
            
            print(response)
            
            switch response.result{
            case .success(let result):
                if let httpStatusCode = response.response?.statusCode {
                    completion(result, nil, httpStatusCode)
                }
                
            case .failure(let error):
                if let httpStatusCode = response.response?.statusCode {
                    completion(nil, error, httpStatusCode)
                }
            }
            
        }
    }
}


public extension UIApplication {
    public func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        switch (base) {
        case let controller as UINavigationController:
            return topViewController(controller.visibleViewController)
        case let controller as UITabBarController:
            return controller.selectedViewController.flatMap { topViewController($0) } ?? base
        default:
            return base?.presentedViewController.flatMap { topViewController($0) } ?? base
        }
    }
}



