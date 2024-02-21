//

import UIKit

class ViewController: UIViewController {
    private let imageMinHeight = 270.0
    private var viewBoundsSize: CGSize { view.bounds.size }
    private var scrollContentSize: CGSize {
        CGSize(width: viewBoundsSize.width, height: viewBoundsSize.height + 300)
    }

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.backgroundColor = .clear
        scroll.automaticallyAdjustsScrollIndicatorInsets = false
        scroll.frame = CGRect(
            origin: CGPoint(x: 0.0, y: imageMinHeight),
            size: CGSize(
                width: viewBoundsSize.width,
                height: viewBoundsSize.height - imageMinHeight
            )
        )
        scroll.contentSize = scrollContentSize
        return scroll
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = scrollContentSize
        return view
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "test_image")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(
            origin: .zero,
            size: CGSize(width: viewBoundsSize.width, height: imageMinHeight)
        )
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.delegate = self
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageHeight = max(imageMinHeight, imageMinHeight - scrollView.contentOffset.y)
        let imagePositionY = min(0, -scrollView.contentOffset.y)
        imageView.frame = CGRect(
            origin: CGPoint(x: 0.0, y: imagePositionY),
            size: CGSize(width: viewBoundsSize.width, height: imageHeight)
        )
        scrollView.verticalScrollIndicatorInsets = .init(top: max(0, -scrollView.contentOffset.y), left: 0, bottom: 0, right: 0)
    }
}
