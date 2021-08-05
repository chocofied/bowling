require_relative "../../lib/bowling.rb"

describe "Bowling score total" do
    describe "Overall total" do
        #combine creation of instances
        before do
            @game = Bowling.new
        end
        context "All tosses were gutter balls" do
            it "Score should be 0" do
                add_many_scores(20,0)
                @game.calc_score
                expect(@game.total_score).to eq 0
            end
        end
        
        context "All tosses knocked over 1 pin" do
            it "Score should be 20" do
                add_many_scores(20,1)
                @game.calc_score
                expect(@game.total_score).to eq 20
            end
        end
        context "Got a spare" do
            it "Spare bonus should be added" do
                #First frame is 3, then 7 points - a spare
                @game.add_score(3)
                @game.add_score(7)
                #Second frame's first throw is 4 points
                @game.add_score(4)
                #The rest are gutter balls
                add_many_scores(17,0)
                #Calculate total
                @game.calc_score
                #Expected total *(4) is the bonus points
                # 3 + 7 + 4 + (4) = 18
                expect(@game.total_score).to eq 18
            end
        end
        context "Frame is different, but two adjacent throws would make a spare" do
            it "Spare bonus should not be added" do
                #First frame is 3, then 5 points
                @game.add_score(3)
                @game.add_score(5)
                #Second frame is 5, then 4 points
                @game.add_score(5)
                @game.add_score(4)
                #The rest are gutter balls
                add_many_scores(16,0)
                #Calculate total
                @game.calc_score
                #Expected total
                # 3 + 5 + 5 + 4 = 17
                expect(@game.total_score).to eq 17
            end
        end
        context "Getting a spare in the last frame" do
            it "Spare bonus should not be added" do
                #First frame is 3, then 7 points - a spare
                @game.add_score(3)
                @game.add_score(7)
                #Second frame first throw is 4 points
                @game.add_score(4)
                #15 gutter balls
                add_many_scores(15,0)
                #Last frame is 3, then 7 points - a spare
                @game.add_score(3)
                @game.add_score(7)
                #Calculate total
                @game.calc_score
                #Expected total
                # 3 + 7 + 4 + (4) + 3 + 7 = 28
                expect(@game.total_score).to eq 28
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