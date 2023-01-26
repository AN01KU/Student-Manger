//
//  StudentManager.swift
//  StudentFramework
//
//  Created by Ankush Ganesh on 23/01/23.
//

import Foundation

public class StudentManager {
    
    public static let shared = StudentManager()
    
    
    //        var student = Student(name: "Ankush",phoneNo: "6301598117", gpa: "7.4", gender: "Male", dob: Date(), age: "0", notes: "Add some notes here....")
//
//
//        do {
//            if let savedStudentData = UserDefaults.standard.data(forKey: "savedStudent") {
//                let studentDetails = try JSONDecoder().decode(Student.self, from: savedStudentData)
//                print("Fetched student")
//            }
////            let encodedData = try JSONEncoder().encode(student)
////            UserDefaults.standard.set(encodedData, forKey: "savedStudent")
//        } catch {
//            print("Faced exception")
//        }
//
////        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
////
////        // Add plist data
////        UserDefaults.standard.set(true, forKey: "isLoggedIn")
////
////        // Retrieve plist data
////        let isLoggedInUpdated = UserDefaults.standard.bool(forKey: "isLoggedIn")


    
    public func retrieveData() {
        
    }
    
    func saveStudentData() {
        
    }
}
