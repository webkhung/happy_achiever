module PageHelper
  def quote(size = 1)
    [
      ["Our worst day is better than the best day of most of the people in the world", "Dr David Jermiah"],
      ["I have not failed. I've just found 10,000 ways that won't work.", "Thomas Edison"],
      ["Success is not final, failure is not fatal: it is the courage to continue that counts.", "Winston Churchill"],
      ["Success is most often achieved by those who don\'t know that failure is inevitable.", "Coco Chanel"],
      ["Only those who dare to fail greatly can ever achieve greatly.", "Robert F. Kennedy"],
      ["Failure is the condiment that gives success its flavor.", "Truman Capote"],
      ["The way to get started is to quit talking and begin doing.", "Walt Disney Company"],
      ["Do you want to know who you are? Don\'t ask. Act! Action will delineate and define you.", "Thomas Jefferson"],
      ["When someone tells me \"no,\" it doesn\'t mean I can't do it, it simply means I can't do it with them.", "Karen E. Quinones Miller"],
      ["The only thing standing between you and your goal is the bullshit story you keep telling yourself as to why you can\'t achieve it.", "Jordan Belfort"],
      ["All great achievements require time.", "Maya Angelou"],
      ["I\'ve come to believe that all my past failure and frustration were actually laying the foundation for the understandings that have created the new level of living I now enjoy.", "Tony Robbins"],
      ["Success comes from taking the initiative and following up... persisting... eloquently expressing the depth of your love. What simple action could you take today to produce a new momentum toward success in your life?", "Tony Robbins"],
      ["If we want to direct our lives, we must take control of our consistent actions. It\'s not what we do once in a while that shapes our lives], but what we do consistently.", "Tony Robbins"],
      ["Once you have mastered time, you will understand how true it is that most people overestimate what they can accomplish in a year and underestimate what they can achieve in a decade!", "Tony Robbins"],
      ["Change is never a matter of ability. Change is always a matter of motivation.", "Tony Robbins"],
      ["A real decision is measured by the fact that you\'ve taken a new action. If there\'s no action], you haven\'t truly decided.", "Tony Robbins"],
      ["It is in your moments of decision that your destiny is shaped.", "Tony Robbins"],
      ["If you do what you\'ve always done, you\'ll get what you\'ve always gotten.", "Tony Robbins"],
      ["For changes to be of any true value], they\'ve got to be lasting and consistent.", "Tony Robbins"],
      ["Stay committed to your decisions, but stay flexible in your approach.", "Tony Robbins"],
      ["We don't need to wait to be happy after we achieved our goals. We can feel happy while we are working on the goal as long as we are growing, learning and enjoy the process.", "Tony Robbins"]
    ].sample(size)
  end

  #def goal_quote
  #  [
  #    ["The way to get started is to quit talking and begin doing.", "Walt Disney Company",
  #    ["The only thing standing between you and your goal is the bullshit story you keep telling yourself as to why you can\'t achieve it.", "Jordan Belfort",
  #    ["Success comes from taking the initiative and following up... persisting... eloquently expressing the depth of your love. What simple action could you take today to produce a new momentum toward success in your life?", "Tony Robbins",
  #    ["If we want to direct our lives], we must take control of our consistent actions. It\'s not what we do once in a while that shapes our lives], but what we do consistently.", "Tony Robbins",
  #    ["Once you have mastered time], you will understand how true it is that most people overestimate what they can accomplish in a year and underestimate what they can gr in a decade!", "Tony Robbins",
  #    ["Change is never a matter of ability. Change is always a matter of motivation.", "Tony Robbins",
  #    ["A real decision is measured by the fact that you\'ve taken a new action. If there\'s no action], you haven\'t truly decided.", "Tony Robbins",
  #    ["It is in your moments of decision that your destiny is shaped.", "Tony Robbins",
  #    ["If you do what you\'ve always done], you\'ll get what you\'ve always gotten.", "Tony Robbins",
  #    ["For changes to be of any true value], they\'ve got to be lasting and consistent.", "Tony Robbins",
  #  ].sample.html_safe
  #end

  def journal
    entries = []

    @achievements.each do |ach|
      entries << JournalEntry.new(ach.achieved_date, ach)
    end

    @plans.each do |plan|
      entries << JournalEntry.new(plan.created_at, plan)
    end

    @milestones.each do |milestone|
      entries << JournalEntry.new(milestone.target, milestone)
    end

    entries.sort

  end

end
