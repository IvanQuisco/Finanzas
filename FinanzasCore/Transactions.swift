import Foundation

public protocol invalidateTransaccion {
    func invalidateTransaccion(transaction: Transaction)
}

public enum TransactionType {
    case debit(value: Float, name: String, category: DebitCategories, date: Date)
    case gain(value: Float, name: String, category: GainCategories, date: Date)
}

public typealias TransactionHandler = ((_ completed: Bool, _ confirmation: Date) -> Void)

public protocol Transaction {
    var value: Float {get}
    var name: String {get}
    var isValid: Bool {get set}
    var delegate: invalidateTransaccion? {get set}
    var date: Date {get}
    var handler: TransactionHandler? {get set}
    var completed: Bool {get}
    var confirmation: Date? {get set}
}

extension Transaction {
    mutating public func invalidateTransaction(compleation: ((_ succeeded: Bool) -> Void)?)  {
        if self.completed {
            isValid = false
            delegate?.invalidateTransaccion(transaction: self)
            print("transaction invalidated \((self.name) )")
            compleation?(true)
        } else {
            print("waiting for confirmation")
            compleation?(false)
        }
            
    }
}
