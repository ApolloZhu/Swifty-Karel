import UIKit

public struct CachedViewable {
    public let content: UIView
    public let path: String
}

extension CachedViewable: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        let label = UILabel(frame: CGRect(x: 0, y: content.frame.maxY,
                                          width: content.bounds.width, height: 50))
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
        return .view(view)
    }
}

extension Playground: CustomPlaygroundQuickLookable {
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return PlaygroundQuickLook.view(liveView)
    }
}

extension WorldModel: CustomPlaygroundQuickLookable {
    var quickLookView: UIView {
        if Playground.current.worldModel !== WorldModel.invalid {
            let model = Playground.current.clonedWorldModel()
            defer { Playground.current.show(worldModel: model) }
        }
        Playground.current.show(worldModel: self)
        let view = Playground.current.worldView
        return view
    }
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return .view(quickLookView)
    }
}
