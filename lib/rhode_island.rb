module RhodeIsland
  def self.included(base)
    base.send :include, RhodeIsland::InstanceMethods
    base.class_eval do
      base::STATES.each do |state|
        define_method :"is_#{state}?" do
          self.state == state
        end unless self.respond_to?(:"is_#{state}?")

        define_method :"make_#{state}" do
          self.make(state)
        end

        define_method :"make_#{state}!" do
          self.make!(state)
        end
      end
    end
  end

  module InstanceMethods
    def make(new_state)
      return new_state if new_state == self.state && !self.state_changed?
      self.class.transaction do
        self.change_state(new_state)
        raise ActiveRecord::Rollback unless self.save
      end
    end

    def make!(new_state)
      return new_state if new_state == self.state && !self.state_changed?
      self.class.transaction do
        self.change_state(new_state)
        self.save!
      end
    end

    protected
    def change_state(new_state)
      @previous_state = self.state
      before_leaving_method_name = :"before_leaving_#{@previous_state}_state"
      before_entering_method_name = :"before_entering_#{new_state}_state"
      self.send(before_leaving_method_name) if self.respond_to?(before_leaving_method_name)
      self.send(before_entering_method_name) if self.respond_to?(before_entering_method_name)
      self.state = new_state
      new_state
    end
  end
end
