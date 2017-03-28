require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  
  test 'valid subject' do
    subject = subjects(:one)
    assert subject.valid?
  end

  test 'invalid subject' do
  	subject = subjects(:two)
  	refute subject.valid?
  	assert_not_nil subject.errors[:name]
  end

end
