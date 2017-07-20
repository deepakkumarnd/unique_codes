require "unique_codes/version"

module UniqueCodes
  LENGTH = 4

  class Queue

    attr_accessor :items

    def initialize
      @items = [*'0000'..'9999'].shuffle
    end

    def get
      fill_queue if @items.empty?
      @items.shift
    end

    def put(item)
      if (size < 10000) && !@items.include?(item)
        @items.push(item)
        true
      else
        false
      end
    end

    def fill_queue
      10000.times do
        put([*'a'..'z'].shuffle.take(4).join(''))
      end
    end

    def size
      @items.size
    end

    def list
      p @items
    end
  end
end
