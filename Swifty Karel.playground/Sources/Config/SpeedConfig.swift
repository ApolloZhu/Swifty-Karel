public enum SpeedConfig: RawRepresentable {
    case half
    case normal
    case double
    case quadruple
    case custom(scale: Double)
    
    public typealias RawValue = Double
    public init?(rawValue: Double) {
        switch rawValue {
        case 0.5: self = .half
        case 1: self = .normal
        case 2: self = .double
        case 4: self = .quadruple
        default: self = .custom(scale: rawValue)
        }
    }

    public var rawValue: Double {
        switch self {
        case .half: return 0.5
        case .normal: return 1
        case .double: return 2
        case .quadruple: return 4
        case .custom(let scale): return scale
        }
    }
}
