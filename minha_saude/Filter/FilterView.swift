import Cartography
import UIKit

public protocol FilterViewDelegate: AnyObject {
    func didSelectedFilter(text: String)
}

public final class FilterView: UIView {
    struct Constants {
        static let filterFontSize: CGFloat = 13
        static let filterNameFontSize: CGFloat = 12
        static let cornerRadius: CGFloat = 6
        static let minimumInteritemSpacing: CGFloat = 5
        static let itemHeight: CGFloat = 25
        static let viewHeight: CGFloat = 60
        static let widthSpacing: CGFloat = 8
        static let collectionHeight: CGFloat = 30
        static let defaultCollectionItemWidth: CGFloat = 50
    }
    
    private let filterTitle: String
    private var filters: [String] = []
    
    public weak var delegate: FilterViewDelegate?
    
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.filterFontSize)
        label.textColor = Asset.ColorAssets.lightGray.color
        label.textAlignment = .left
        return label
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0
        flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return flow
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        let identifier = String(describing: FilterCollectionViewCell.self)
        collection.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collection.bounces = false
        collection.backgroundColor = .clear
        collection.allowsMultipleSelection = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.autoresizingMask = .flexibleWidth
        return collection
    }()
    
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    public init(filterTitle: String, filters: [String]) {
        self.filterTitle = filterTitle
        self.filters = filters
        
        super.init(frame: .zero)
        
        configureSubviews()
        setupConstraints()
    }
    
    public func selectFilter(filter: String) {
        guard let index = filters.firstIndex(of: filter) else { return }
        
        collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    private func configureSubviews() {
        backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        
        filterLabel.text = filterTitle
        
        addSubview(filterLabel)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        constrain(self, filterLabel, collectionView) { view, label, collection in
            view.height == Constants.viewHeight
            
            label.leading == view.leading
            label.top == view.top + Constants.minimumInteritemSpacing
            
            collection.leading == view.leading
            collection.trailing == view.trailing
            collection.top == label.bottom + Constants.minimumInteritemSpacing
            collection.height == Constants.collectionHeight
        }
    }
    
    private func widthOfString(text: String, usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension FilterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filters.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: FilterCollectionViewCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell()}
        
        let text = filters[indexPath.row]
        cell.configure(text: text)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let size = cell?.contentView.systemLayoutSizeFitting(CGSize(width: 0, height: Constants.itemHeight), withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .fittingSizeLevel)
        
        return CGSize(width: size?.width ?? Constants.defaultCollectionItemWidth, height: Constants.itemHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = filters[indexPath.row]
        delegate?.didSelectedFilter(text: text)
    }
}
