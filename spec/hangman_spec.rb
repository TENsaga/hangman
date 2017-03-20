require_relative '../lib/hangman.rb'

describe Hangman.new 'test' do 
  context "attributes" do
    it { is_expected.to respond_to(:guesses) }
    it { is_expected.to respond_to(:misses) }
    it { is_expected.to respond_to(:word) }
    it { is_expected.to respond_to(:incorrect) }  
  end

 let!(:hangman) { Hangman.new }
 let!(:word)    { hangman.word = %w( t e s t ) }
 let!(:guesses) { hangman.guesses = ["_", "_", "_", "_"] }

  describe ".select_word" do
    context "calling select_word with blank variable" do
      let!(:select_word) { hangman.select_word("") }

      it "returns random string from 5desk.txt" do
        expect(select_word).to be_a(String)
      end

      it "returns string between 7 and 14 characters" do
        expect(select_word.length).to be_between(7, 14).inclusive
      end
    end
  end

  describe ".letter_correct?" do 
    context "given correct letter" do 
      it "returns true" do
        expect(hangman.letter_correct?("t")).to be_truthy 
      end
    end

    context "given wrong letter" do 
      it "returns false" do 
        expect(hangman.letter_correct?("z")).to_not be_truthy
      end
    end
  end

  describe ".win?" do 
    subject(:win?) { hangman.win? }

    context "given word == guess" do
      let!(:guess) { hangman.guesses = %w( t e s t ) }
      it { is_expected.to be_truthy }
    end

    context "given word != guess" do 
      let!(:guess) { hangman.guesses = %w( a p p l e ) }
      it { is_expected.to_not be_truthy }
    end
  end

  describe ".update_guesses" do
    context "given letter t" do 
      it "update guess space with t if in word" do
        expect(hangman.update_guesses("t")).to eq([["t", 0], ["t", 3]])
        expect(hangman.guesses).to eq %w( t _ _ t )
      end
    end
  end

  describe ".update_misses" do 
    context "given letter z" do 
      let!(:miss) { hangman.update_misses("z") }
      it "update misses" do
        expect(hangman.misses).to include("z")
      end

      it "updates incorrect count" do 
        expect(hangman.incorrect).to eq 1
      end
    end
  end

end