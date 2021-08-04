require "bowling"

describe "Bowling score total" do
    describe "Overall total" do
        #combine creation of instances
        before do
            @game = Bowling.new
        end
        context "All tosses were gutter balls" do
            it "Score is 0" do
                add_many_scores(20,0)
                expect(@game.total_score).to eq 0
            end
        end
        
        context "All tosses knocked over 1 pin" do
            it "Score is 20" do
                add_many_scores(20,1)
                expect(@game.total_score).to eq 20
            end
        end
    end
end
private
#Run multiple times at once with same score
def add_many_scores(count, pins)
    count.times do
        @game.add_score(pins)
    end
end