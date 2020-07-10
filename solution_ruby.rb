class EventSourcer
  def initialize()
    @value = 0
    @operations = [0]
    @place = 0
  end

  attr_reader :value

  def add(num)
    @operations.insert(@place + 1, num)
    @value += num
    @place += 1
  end

  def subtract(num)
    @operations.insert(@place + 1, num*-1)
    @value -= num
    @place += 1
  end

  def undo()
    bulk_undo(1)
  end

  def redo()
    bulk_redo(1)
  end

  def bulk_undo(amount)
    interval = @place - amount
    if interval >= 0
      while @place > interval
        @value -= @operations[@place]
        @place -= 1
      end
    else
      @value = 0
      @place = 0
      end
    return @value
  end

  def bulk_redo(amount)
    interval = @place + amount
    if interval <= @operations.length - 1
      while @place < interval
        @value += @operations[@place+1]
        @place += 1
      end
    else
      @value = 0
      for i in 0..@operations.length-1
        @value += @operations[i]
      end
      @place = @operations.length - 1
    end
    return @value
  end
end
