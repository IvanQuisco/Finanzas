import Foundation

public class Person {
   public var name: String
   public var lastName: String
   public var account: Account?
   public var fullName: String {
        get {
            return "\(name) \(lastName)"
        }
        set {
            name = String(newValue.split(separator: " ").first ?? "")
            lastName = String(newValue.split(separator: " ").last ?? "")
        }
    }
    
   public init(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
    }
}
