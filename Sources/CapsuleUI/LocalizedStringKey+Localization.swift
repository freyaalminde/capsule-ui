import SwiftUI

extension LocalizedStringKey {
  var key: String {
    Mirror(reflecting: self).children.first { $0.label == "key" }?.value as? String ?? ""
  }

  var string: String {
    NSLocalizedString(key, comment: "")
  }
}
