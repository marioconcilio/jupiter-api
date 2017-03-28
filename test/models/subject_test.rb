require 'test_helper'

class SubjectTest < ActiveSupport::TestCase

  def setup
    @subject = subjects(:one)
  end
  
  test 'valid subject' do
    assert @subject.valid?
  end

  test 'invalid without name' do
  	@subject.name = nil
  	refute @subject.valid?
  	assert_not_nil @subject.errors[:name]
  end

  test 'invalid without code' do
    @subject.code = nil
    refute @subject.valid?
    assert_not_nil @subject.errors[:code]
  end

end
