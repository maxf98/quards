//
//  OverviewModel.swift
//  Quards
//
//  Created by Max Fest on 30.08.20.
//

import Foundation

class OverviewModel: ObservableObject {
	@Published var currentTag: TagDeck
		
	init(tagDeck: TagDeck) {
		self.currentTag = tagDeck
	}
	
}
