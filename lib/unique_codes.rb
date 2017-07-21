require 'unique_codes/version'

require 'singleton'

class UniqueCode

  class CodeUnderflowError < StandardError; end

  module ClassMethods

    def init
      @items = [*'0000'..'9999'].shuffle
      @reserved = []
    end

    def current_size
      @items.size
    end

    def all_codes
      @items.dup
    end

    def get
      index = rand(0...current_size)
      raise CodeUnderflowError if index.nil?
      code  = @items[index]
      raise CodeUnderflowError if code.nil?
      @items.delete_at(index)
      @reserved << code
      code
    end

    def reserved_codes
      @reserved.dup
    end

    def free(code)
      @reserved.delete(code)
      add(code)
    end

    def add(code)
      return if @items.include? code
      @items << code
    end

  end

  include Singleton
  extend ClassMethods
end
