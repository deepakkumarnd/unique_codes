require_relative 'test_helper'

describe UniqueCode do
  def test_that_it_has_a_version_number
    refute_nil ::UniqueCode::VERSION
  end

  def setup
    UniqueCode.init
  end

  it 'should have 10000 items on init' do
    assert_equal 10000, UniqueCode.current_size
  end

  it 'should have no duplicate items' do
    assert_equal UniqueCode.current_size, UniqueCode.all_codes.uniq.count
  end

  it 'returns a single code' do
    size1 = UniqueCode.current_size
    UniqueCode.get
    size2 = UniqueCode.current_size
    assert_equal 1, size1 - size2
  end

  it 'returned item will be reserved' do
    code = UniqueCode.get
    assert_equal true, UniqueCode.reserved_codes.include?(code)
  end

  it 'should reinsert a freed item' do
    code = UniqueCode.get
    assert_equal false, UniqueCode.all_codes.include?(code)
    UniqueCode.free(code)
    assert_equal true, UniqueCode.all_codes.include?(code)
  end

  it 'has the same total number of codes at any point of time' do
    rand(100).times do
      UniqueCode.get
      assert_equal 10000, UniqueCode.current_size + UniqueCode.reserved_codes.size
    end
  end

  it 'raises error if there are no more code left to allocate' do
    assert_raises UniqueCode::CodeUnderflowError do
      10001.times { UniqueCode.get }
    end
  end
end
