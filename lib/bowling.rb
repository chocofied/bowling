#Class to manage bowling scores
class Bowling
    def initialize
        #Set total score to 0 at first
        @total_score = 0
        #Keep track of scores
        @scores = []
        #temp storage array
        @temp = []
    end
    
    #return total score
    def total_score
        @total_score
    end
    
    #add score
    def add_score(pins)
        @temp << pins
        #add total frame score when second toss is done
        if @temp.size == 2 || strike?(@temp)
            @scores << @temp
            @temp = []
        end
    end
    
    #calculate score
    def calc_score
        @scores.each.with_index(1) do |score, index|
            #If a strike that's not the last frame, then add bonus
            if strike?(score) && not_last_frame?(index)
                @total_score += calc_strike_bonus(index)
            #If a spare that's not the last frame, then add bonus
            elsif spare?(score) && not_last_frame?(index)
                @total_score += calc_spare_bonus(index)
            else
                @total_score += score.inject(:+)
            end
        end
    end
    
    private
    #Check if strike
    def strike?(score)
        score.first == 10
    end
    
    #Check if spare
    def spare?(score)
        score.inject(:+) == 10
    end
    
    #Check if not last frame
    def not_last_frame?(index)
        index < 10
    end
    
    #Calculate strike bonus
    def calc_strike_bonus(index)
        #Next frame is a strike and not last frame, then
        #the frame after that's first toss is added as a bonus
        if strike?(@scores[index]) && not_last_frame?(index + 1)
            20 + @scores[index + 1].first
        else
            10 + @scores[index].inject(:+)
        end
    end
    #Calculate spare bonus
    def calc_spare_bonus(index)
        10 + @scores[index].first
    end
end