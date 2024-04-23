import UIKit

class ItemsViewController: UITableViewController {

    private lazy var dataSource = makeDataSource()
    private let imageRepository = ImageRepository()


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseIdentifier)
        tableView.dataSource = dataSource

        let networkClient = NetworkClient()
        networkClient.getItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self?.update(with: items)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }


    func makeDataSource() -> UITableViewDiffableDataSource<Int, Item> {
        UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ItemTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? ItemTableViewCell

                cell?.nameLabel.text = item.name
                cell?.priceLabel.text = "\(item.price) €"
                cell?.dateLabel.text = self.formattedDate(from: item.lastSold)
                cell?.orderLabel.text = "\(indexPath.row + 1)"
                cell?.iconView.image = self.imageRepository.image(forItemIdentifier: item.id)

                return cell
            }
        )
    }



    func update(with items: [Item], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
    
    func formattedDate(from string: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        if let date = dateFormatter.date(from: string) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM d, yyyy, HH:mm"
            return displayFormatter.string(from: date)
        }
        return "N/A"
    }


}
