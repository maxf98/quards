//
//  TagDeckThumbnail.swift
//  Quards
//
//  Created by Max Fest on 31.08.20.
//

import SwiftUI

struct TagDeckThumbnail: View {
	@Binding var name: String
	var body: some View {
		Text(name)
			.fontWeight(.bold)
	}
}
