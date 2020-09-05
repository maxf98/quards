//
//  TabBarController.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import Foundation
import SwiftUI

class TabBarController: ObservableObject {
	@Published var hideTabBar = false
	@Published var selectedTag: Tab = .review
	
	enum Tab {
		case overview
		case review
		case network
		
		var img: Image {
			switch self {
			case .overview:
				return Image(systemName: "tray.full")
			case .review:
				return Image(systemName: "house")
			case .network:
				return Image(systemName: "map")
			}
		}
	}
}
