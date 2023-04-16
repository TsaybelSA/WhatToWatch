//
//  DataSource.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 12.03.2023.
//

import RxDataSources

enum TableViewItem {
    /// Represents a cell with a collection view inside
    case MoviesTableViewItem(data: [Movie])
    /// Represents a cell with a switch
    case SwitchTableViewItem(isOn: Bool)
    /// Represents a cell with a disclosure indicator
    case IndicatorTableViewItem
}

enum TableViewSection {
    case GridSection(items: [TableViewItem], header: String)
    case CustomSection(items: [TableViewItem])
}

extension TableViewSection: SectionModelType {
    typealias Item = TableViewItem

    var header: String {
        switch self {
        case .GridSection(gridInfo: let gridInfo):
            return gridInfo.header
        case .CustomSection:
            return "Custom Section"
        }
    }
    
    var items: [TableViewItem] {
        switch self {
        case .GridSection(gridInfo: let gridInfo):
            return gridInfo.items
        case .CustomSection(items: let items):
            return items
        }
    }
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct DataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<TableViewSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            
            switch dataSource[indexPath] {
            case let .MoviesTableViewItem(movies):
                let cell = CategoryTableViewCell()
                cell.viewModel = GridViewModel(data: movies)
                return cell
            default:
                return UITableViewCell()
            }
        }, titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].header
        })
    }
}

