//
//  Car-Example.swift
//  CSVExportSwift
//
//  Created by dcilia on 1/19/16.
//  Copyright © 2016 David Cilia. All rights reserved.
//

import Foundation


struct Car : CSVExporting {
    
    var make : String
    var model : String
    var year : String
    
    static func templateString() -> String {
        
        return "Manufacturer, Model, Year\n"
    }
    
    
    func exportAsCommaSeparatedString() -> String {
        
        return "\(self.make), \(self.model), \(self.year)\n"
    }
    
    func go() -> Void {
        
        let documents = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        guard let path = documents.first else { return }
        let filePath = String(NSString(string:path).appendingPathComponent("Cars.csv"))
        
        guard let url = URL(string: filePath) else { return }
        
        let items = [
            
            Car(make: "BMW", model: "325", year: "1999"),
            Car(make: "Toyota", model: "Rav4", year: "2003"),
            Car(make: "Hyundai", model: "Elantra", year: "2011"),
            Car(make: "Tesla", model: "Model 3", year: "2017")
        ]
        
        let operation = CSVOperation(filePath: url, source: items)
        
        operation.completionBlock = {
            
            if operation.finishedState == .success {
                
                //File has been saved to disk ...
            }
        }
        
        OperationQueue().addOperation(operation)
    }
}

