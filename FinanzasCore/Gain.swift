import Foundation

public enum GainCategories: String {
    case salary, extra
}

public class Gain: Transaction {
    public var confirmation: Date?
    public var completed: Bool = false
    public var handler: TransactionHandler?
    public var date: Date
    public var delegate: invalidateTransaccion?
    public var isValid: Bool = true
    public var value: Float
    public var name: String
    public var category: GainCategories
    
    public init(value: Float, name: String, category: GainCategories, date: Date) {
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
