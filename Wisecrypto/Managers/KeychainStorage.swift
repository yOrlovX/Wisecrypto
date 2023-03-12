import SwiftUI
import KeychainAccess

@propertyWrapper
struct KeychainStorage<Value: Codable>: DynamicProperty {
  private let keychain = Keychain()
  private let valueKey: String
  @State private var value: Value?
  
  init(wrappedValue defaultValue: Value? = nil, _ key: String) {
    valueKey = key
    
    do {
      if let data = try keychain.getData(key) {
        _value = State(initialValue: try JSONDecoder().decode(Value.self, from: data))
      } else {
        _value = State(initialValue: defaultValue)
      }
    } catch {
      fatalError("\(error)")
    }
  }
  
  var wrappedValue: Value? {
    get {
      return value
    }
    nonmutating set {
      value = newValue
      
      do {
        if let storeValue = newValue {
          try keychain.set(JSONEncoder().encode(storeValue), key: valueKey)
        } else {
          try Keychain().remove(valueKey)
        }
      } catch {
        fatalError("\(error)")
      }
    }
  }
  
  var projectedValue: Binding<Value?> {
    return Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
  }
}

