import Cartography
import UIKit

public final class FilterView: UIView {
    
    struct Constants {
        static let filterFontSize: CGFloat = 13
        static let filterNameFontSize: CGFloat = 12
        static let cornerRadius: CGFloat = 6
        static let minimumInteritemSpacing: CGFloat = 5
        static let itemHeight: CGFloat = 25
        static let viewHeight: CGFloat = 50
        static let widthSpacing: CGFloat = 8
        static let bottomSpacing: CGFloat = 1
    }
    
    private let filterTitle: String
    private var filters: [String] = []
    
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
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = Constants.minimumInteritemSpacing
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
        //        collection.delegate = self
        //        collection.dataSource = self
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
    
    private func configureSubviews() {
        backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
            collection.bottom == view.bottom + Constants.bottomSpacing
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
        let text = filters[indexPath.row]
        let width = widthOfString(text: text, usingFont: UIFont.systemFont(ofSize: Constants.filterNameFontSize)) + Constants.widthSpacing
        return CGSize(width: width, height: Constants.itemHeight)
    }
}
