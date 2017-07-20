require 'test_helper'

class UniqueCodesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::UniqueCodes::VERSION
  end

  def setup
    @queue = UniqueCodes::Queue.new
  end

  def test_it_has_9999_items
    assert_equal @queue.items.size, 10000
  end

  def test_returns_current_number_of_items
    assert_equal @queue.size, 10000
  end

  def test_get_code_from_queue
    1000.times do
      old_size = @queue.size
      assert @queue.get
      assert_equal @queue.size, old_size - 1
    end
  end

  def test_put_item_into_queue
    refute @queue.put('0000')
    item = @queue.get
    assert_equal true, @queue.put(item)
  end

  def test_should_not_push_duplicates
    item = @queue.get

    val = rand(1000..9999)

    while (val.to_s == item)
      val = rand(1000, 9999)
    end

    assert_equal false, @queue.put('9999')
  end

  def test_should_refill_if_queue_become_empty
    10001.times do
      assert @queue.get
    end
  end
end
