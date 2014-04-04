class JournalEntry
  include Comparable

  attr_reader :date, :data

  def initialize(date, data)
    @date = date
    @data = data
  end

  def <=>(anOther)
    case
      when self.date > anOther.date then -1
      when self.date < anOther.date then 1
      else 0
    end
  end

end
