require "spec_helper"

describe Game do
  let(:game) { Game.create_default }
  let(:custom_game) { Game.new(:a) }

  describe "#create_default" do
    context "when given 0 arguments" do
      it "returns a Game object" do
        expect(game).to be_an_instance_of(Game)
      end
    end

    context "when given more than 0 arguments" do
      it "raises an ArgumentError" do
        expect { Game.create_default(:a) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#new" do
    context "when given 1 argument" do
      it "returns a Game object" do
        expect(custom_game).to be_an_instance_of(Game)
      end
    end

    context "when given fewer than 1 argument" do
      it "raises an ArgumentError" do
        expect { Game.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 1 argument" do
      it "raises an ArgumentError" do
        expect { Game.new(:a, :b) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#state" do
    it "returns the correct_state" do
      expect(custom_game.state).to eq(:a)
    end
  end
end
