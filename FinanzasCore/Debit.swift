import Foundation


public protocol DebitTransaction: Transaction {
    var category: DebitCategories {get}
}


public enum DebitCategories {
    case food, services, transportation, entertainment, other
}

public class Debit: Transaction {
    public var confirmation: Date?
    public var completed: Bool = false
    public var handler: TransactionHandler?
    public var date: Date
    public var delegate: invalidateTransaccion?
    public var isValid: Bool = true
    public var value: Float
    public var name: String
    public var category: DebitCategories
    
    public init(value: Float, name: String, category: DebitCategories, date: Date) {
        self.value = value
        self.name = name
        self.category = category
        self.date = date
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.completed = true
            self.handler?(true, Date())
        }
    }
    
    
}
