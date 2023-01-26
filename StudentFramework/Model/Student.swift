//
//  Student.swift
//  StudentManageriOS
//
//  Created by Ankush Ganesh on 16/01/23.
//

import Foundation

struct Student: Codable {
    
    var name: String = ""
    var phoneNo: String = ""
    var gpa: String = ""
    var gender: String = ""
    var dob: Date = Date()
    var age: String = ""
    var notes: String = ""
    
    func validator(for student: Student) -> Bool{
        let nameRegex = "^[a-zA-Z][a-zA-Z ]{1,20}$"
        let isNameValid = NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: student.name)

        let phoneNoRegex = "^[6-9][0-9]{9}$"
        let isPhoneNoValid = NSPredicate(format: "SELF MATCHES %@", phoneNoRegex).evaluate(with: student.phoneNo)
        
        let genders = ["Male","Female","Others"]
        let isGenderValid = genders.contains(student.gender) ? true : false
        
        var isAgeValid = false
        if let ageNumber = Int(student.age) {
            let studentAgeRange = 5...25
            if studentAgeRange.contains(ageNumber) {
                isAgeValid = true
            }
        }
        
        var isGpaValid = false
        if let gpaNumber = Double(student.gpa) {
            let gpaRange = 1...10.0
            if gpaRange.contains(gpaNumber) {
                isGpaValid = true
            }
        }
        
        if isGpaValid && isAgeValid && isNameValid && isPhoneNoValid && isAgeValid && isGenderValid {
            return true
        }
        return false
    }
}
