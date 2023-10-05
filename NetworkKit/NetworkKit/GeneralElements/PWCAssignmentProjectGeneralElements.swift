//
//  PWCAssignmentProjectGeneralElements.swift
//  NetworkKit
//
//  Created by Afaq Ahmad on 10/5/23.
//

import UIKit

//A singleton class to hold global variables
public class PWCAssignmentProjectGeneralElements {
    
    public static let shared = PWCAssignmentProjectGeneralElements()
    
    public var internetConnectivity: Reachability.Connection = .unavailable
    
    //var domain : String = ""
    
    private init() {
    }
    
    static func convertToBase64(text: String)->String{
        let data = text.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    
    
    //MARK:- Static Methods
    public static func showAlertWithMessage(_ message: String, sender: UIViewController?){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        if let sender = sender{
            sender.present(alert, animated: false, completion: nil)
        }
        else{
            topViewController()?.present(alert, animated: false, completion: nil)
        }
    }
    
    //returns top view controller
    static func topViewController() -> UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while topViewController.presentedViewController != nil {
            topViewController = topViewController.presentedViewController!
        }
        return topViewController
    }
    
    static func distroy() {
        
    }
    
    
    static func getDateStringFromDBDate(date: String) -> String{
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"   //2019-06-04T00:00:00
        
        if let date = dateTimeFormatter.date(from: date){
            
            let dateFormatter  = DateFormatter()
            dateFormatter.dateFormat = "MMM-dd-yyyy"
            
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    static func localToUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: dt!)
    }
    
    static func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: dt!)
    }
    
    static func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    static func isValidWorkspace(workspaceString:String) -> Bool {
        let workspaceRegEx = "^[A-Za-z0-9_-]*$"
        
        let workspacePred = NSPredicate(format:"SELF MATCHES %@", workspaceRegEx)
        return workspacePred.evaluate(with: workspaceString)
    }
    
    
}
