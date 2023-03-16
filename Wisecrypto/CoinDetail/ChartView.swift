//
//  ChartView.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 09.02.2023.
//

import SwiftUI

struct ChartView: View {
  let data: [Double]
  let maxPrice: Double
  let minPrice: Double
  let startingDate: Date
  let endingDate: Date
  let rank: Int
  
  @State private var percentage: CGFloat = 0
  
  var body: some View {
    VStack(spacing: 10) {
      topLabels
      Divider()
      chart
      Divider()
      bottomLabels
      dateLabels
    }
    .padding(.horizontal, 5)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        withAnimation(.linear(duration: 2)) {
          percentage = 1.0
        }
      }
    }
  }
}

private extension ChartView {
  private var chart: some View {
    GeometryReader { geo in
      Path { path in
        for index in data.indices {
          let xPosition = geo.size.width / CGFloat(data.count) * CGFloat(index + 1)
          let maxY = data.max() ?? 0
          let minY = data.min() ?? 0
          let yAxis = maxY - minY
          let yPosition = (1 - CGFloat((data[index] - minY)) / yAxis) * geo.size.height
          
          if index == 0 {
            path.move(to: CGPoint(x: xPosition, y: yPosition))
          }
          path.addLine(to: CGPoint(x: xPosition, y: yPosition))
        }
      }
      .trim(from: 0, to: percentage)
      .stroke(Colors.primaryGreen, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
      .shadow(color: .black, radius: 20, x: 0, y: 0)
    }
    .frame(height: 200)
  }
  
  private var topLabels: some View {
    HStack {
      Text("Max Price: \(String(format: "%.2f", maxPrice))")
      Spacer()
      Text("Market cap rank: \(rank)")
    }
    .padding(.horizontal, 5)
  }
  
  private var bottomLabels: some View {
    HStack {
      Text("Min Price: \(String(format: "%.2f", minPrice))")
      Spacer()
    }
    .padding(.horizontal, 5)
  }
  
  private var dateLabels: some View {
    HStack {
      Text(endingDate.shortDate())
      Spacer()
      Text(startingDate.shortDate())
    }
    .padding(.horizontal, 5)
  }
}


struct ChartView_Previews: PreviewProvider {
  static var mockData: [Double] = [22784.727629274923,
                                   22707.395636945126,
                                   22733.141386037303,
                                   22794.08003043052,
                                   22938.642903279277,
                                   22851.463206859717,
                                   22945.215282098827,
                                   22819.03379003602,
                                   22882.031036519216,
                                   22881.59327125767,
                                   22891.494888575995,
                                   22970.847176497045,
                                   23066.963597958547,]
  static var previews: some View {
    ChartView(data: mockData, maxPrice: 300, minPrice: 100, startingDate: Date(), endingDate: Date(), rank: 1)
  }
}
