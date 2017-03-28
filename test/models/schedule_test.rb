require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  
  def setup
    @schedule = schedules(:one)
  end

  test 'valid schedule' do
    assert @schedule.valid?
  end

  test 'invalid without week_day' do
    @schedule.week_day = nil
    refute @schedule.valid?
    assert_not_nil @schedule.errors[:week_day]
  end

  test 'invalid without time_begin' do
    @schedule.time_begin = nil
    refute @schedule.valid?
    assert_not_nil @schedule.errors[:time_begin]
  end

  test 'invalid without time_end' do
    @schedule.time_end = nil
    refute @schedule.valid?
    assert_not_nil @schedule.errors[:time_end]
  end

  test 'invalid without teachers' do
    @schedule.teachers = nil
    refute @schedule.valid?
    assert_not_nil @schedule.errors[:teachers]
  end

  test 'invalid without classroom' do
    @schedule.classroom = nil
    refute @schedule.valid?
    assert_not_nil @schedule.errors[:classroom]
  end

end
