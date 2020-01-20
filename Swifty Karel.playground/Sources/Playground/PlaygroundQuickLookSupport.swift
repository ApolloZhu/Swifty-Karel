import UIKit
#if canImport(PlaygroundSupport)
import PlaygroundSupport
#endif

public struct CachedViewable {
    public let content: UIView
    public let path: String
}

extension CachedViewable: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        let frame = CGRect(
            x: 0, y: content.frame.maxY,
            width: content.bounds.width, height: 50
        )
        let label = UILabel(frame: frame)
        label.text = path
        label.numberOfLines = 0
        label.sizeToFit()

        let view = UIView(frame:
            CGRect(origin: .zero,
                   size: CGSize(width: content.frame.width,
                                height: content.frame.height + label.frame.height)))
        view.backgroundColor = .background
        view.addSubview(content)
        view.addSubview(label)
        return view
    }
}

extension Playground: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return liveView
    }
}

extension WorldModel: CustomPlaygroundDisplayConvertible {
    var quickLookView: UIView {
        defer {
            if Playground.current.worldModel !== WorldModel.invalid {
                let model = Playground.current.clonedWorldModel()
                Playground.current.show(worldModel: model)
            }
        }
        Playground.current.show(worldModel: self)
        let view = Playground.current.worldView
        return view
    }

    public var playgroundDescription: Any {
        return quickLookView
    }
}
