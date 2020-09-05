//
//  CardTags.swift
//  Quards
//
//  Created by Max Fest on 03.09.20.
//

import SwiftUI

struct CardTags: View {
	var tagDeck: TagDeck?
	
	var body: some View {
		if let deck = tagDeck {
			HStack(spacing: 10) {
				ForEach(parentTags(for: deck)) { td in
					Text(td.name)
						.foregroundColor(Color(td.secondaryColor))
						.padding(10)
						.background(RoundedRectangle(cornerRadius: 10)
									 .foregroundColor(Color(td.wrappedColor)))
				}
			}
		} else {
			EmptyView()
		}
	}
	
	func parentTags(for tagDeck: TagDeck) -> [TagDeck] {
		var all = [tagDeck]
		var cur = tagDeck
		while let par = cur.parent {
			all.insert(par, at: 0)
			cur = par
		}
		
		return all
	}
}
