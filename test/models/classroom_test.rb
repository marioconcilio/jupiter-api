require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
  
  def setup
    @classroom = classrooms(:one)
  end

  test 'valid classroom' do
    assert @classroom.valid?
  end

  test 'invalid without date_begin' do
    @classroom.date_begin = nil
    refute @classroom.valid?
    assert_not_nil @classroom.errors[:date_begin]
  end

  test 'invalid without date_end' do
    @classroom.date_end = nil
    refute @classroom.valid?
    assert_not_nil @classroom.errors[:date_end]
  end

  test 'invalid without kind' do
    @classroom.kind = nil
    refute @classroom.valid?
    assert_not_nil @classroom.errors[:kind]
  end

  test 'valid without subject' do
    @classroom.subject = nil
    assert @classroom.valid?
  end

end
