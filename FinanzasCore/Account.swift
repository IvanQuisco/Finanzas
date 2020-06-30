import Foundation


public enum AccountException: Error {
    case invalidTransaction
    case amountExeded
}


public class Account {
    public var amount: Float = 0
    public var name: String = ""
    public var transactions: [Transaction] = []
    
    public var gains: [Transaction] = []
    public var debits: [Debit] = []
    
    public init(amount: Float, name: String) {
        self.amount = amount
        self.name = name
    }

    
    @discardableResult
       public func addTransaction(with transaction: TransactionType?) throws -> Transaction? {
           guard let transaction = transaction else {
                throw AccountException.invalidTransaction
           }
           
           switch transaction {
           case .debit(let value, let name, let category, let date):
               if amount - value < 0 {
                throw AccountException.amountExeded
               }
               let debit = Debit(value: value, name: name, category: category, date: date)
               debit.delegate = self
               debit.handler = { (completed, confirmation) in
                if completed {
                    debit.confirmation = confirmation
                    self.amount -= debit.value
                    self.debits.append(debit)
                }
               }
               return debit
           case .gain(let value, let name, let category, let date):
               let gain = Gain(value: value, name: name, category: category, date: date)
               gain.delegate = self
               gain.handler = { (completed, confirmation) in
                if completed {
                    gain.confirmation = confirmation
                    self.amount += gain.value
                    self.gains.append(gain)
                }
               }
               return gain
           }
       }
    
    public func getDebits() -> [Transaction] {
        return transactions.filter({$0 is Debit})
    }
    
    public func getGains() -> [Transaction] {
        return transactions.filter({$0 is Gain})
    }
}

extension Account: invalidateTransaccion {
    public func invalidateTransaccion(transaction: Transaction) {
        if !transaction.isValid {
            if transaction is Debit {
                amount += transaction.value
            }
            if transaction is Gain {
                amount -= transaction.value
            }
        }
    }
}
