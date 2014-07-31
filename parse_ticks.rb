#!/usr/bin/env ruby

require 'lzma'
require 'pp'

def main
  File.open("2012/11/03/01h_ticks.bi5", "r") do |f|
    data = LZMA.decompress(f.read)
    st = Time.new(2012,11,3, 1)
    puts "Time\tBid\tBidV\tAsk\tAskV"
    data.chars.each_slice(20).to_a.map(&:join).map{|row| row.unpack("L>3g2")}.each do |row|
      t_offset = (row[0] / 1000.0)
      print (st + t_offset).round(3).strftime("%Y-%b-%d %H:%M:%S.%6N")
      print ", "
      print row[2] * 0.001
      print ", "
      print row[4].round(2)
      print ", "
      print (row[1] * 0.001).round(3)
      print ", "
      print row[3].round(2)
      puts
    end
  end
end



main if $0 == __FILE__
