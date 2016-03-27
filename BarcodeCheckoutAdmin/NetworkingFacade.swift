//
//  NetworkingFacade.swift
//  BarcodeCheckoutUser
//
//  Created by Joseph Pecoraro on 3/27/16.
//  Copyright © 2016 Joseph Pecoraro. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingFacade : NSObject {
    
    typealias BooleanClosure = (success: Bool) -> Void;
    typealias StringArrayClosure = (error: NSError?, list: Array<String>?) -> Void;
    let baseURL = "http://45.55.145.225:4001";

    // POST
    func uploadBarcodes(barcodeId: String, barcodes: [String], completionBlock: BooleanClosure?) {
        Alamofire.request(.POST, URLStringWithExtension("barcode"), parameters: [ "barcodeId" : barcodeId, "barcodes" : barcodes])
            .responseJSON { response in
                if let json = response.result.value {
                    print(json);
                    completionBlock?(success: true);
                }
                else {
                    completionBlock?(success: false);
                }
        }
    }
    
    // GET
    func getBarcodeList(barcodeId : String, completionBlock: StringArrayClosure?) {
        Alamofire.request(.GET, URLStringWithExtension("barcode/\(barcodeId)"))
            .responseJSON { response in
                if let json = response.result.value {
                    print(json);
                    
                    completionBlock?(error: nil, list: json["barcodes"] as? [String]);
                }
                else {
                    completionBlock?(error: response.result.error, list: nil);
                }
        }
    }
    
    // Utility
    
    func URLStringWithExtension(urlExtension: String) -> String {
        return "\(baseURL)/\(urlExtension)";
    }
}