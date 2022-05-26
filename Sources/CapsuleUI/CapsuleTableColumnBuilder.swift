
@frozen public struct CapsuleTupleTableColumnContent<RowValue: Identifiable, T> {
  public typealias TableRowValue = RowValue
  public var value: T
}
