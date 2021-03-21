RSpec.describe ToSentenceExclusive do
  it "has a version number" do
    expect(ToSentenceExclusive::VERSION).not_to be nil
  end

  describe "Array#to_sentence_exclusive" do
    subject { array.to_sentence_exclusive(options) }

    let(:options) { {} }

    context "when array is empty" do
      let(:array) { [] }
      it { is_expected.to eq("") }
      it { should be_kind_of(String) }

      it "does not freeze string" do
        expect(subject.frozen?).to be(false)
      end
    end

    context "when array has one item" do
      let(:array) { ["one"] }
      it { is_expected.to eq("one") }
      it { should be_kind_of(String) }

      it "does not freeze string" do
        expect(subject.frozen?).to be(false)
      end

      it "is not the same object" do
        expect(subject.object_id).not_to eq(array[0].object_id)
      end
    end
    context "when array has two items" do
      let(:array) { ["one", "two"] }
      it { is_expected.to eq("one or two") }
      it { should be_kind_of(String) }

      it "does not freeze string" do
        expect(subject.frozen?).to be(false)
      end

      context "when two_words_connector is passed" do
        let(:options) { { two_words_connector: " " } }
        it { is_expected.to eq("one two") }
      end
    end

    context "when array has three items" do
      let(:array) { ["one", "two", "three"] }
      it { is_expected.to eq("one, two, or three") }
      it { should be_kind_of(String) }

      it "does not freeze string" do
        expect(subject.frozen?).to be(false)
      end

      context "and words connector is ' '" do
        let(:options) { { words_connector: " " } }
        it { is_expected.to eq("one two, or three") }
      end

      context "and words connector is a ' & '" do
        let(:options) { { words_connector: " & " } }
        it { is_expected.to eq("one & two, or three") }
      end

      context "and words connector is nil" do
        let(:options) { { words_connector: nil } }
        it { is_expected.to eq("onetwo, or three") }
      end

      context "and last_word_connector is ', or maybe '" do
        let(:options) { { last_word_connector: ", or maybe " } }

        it { is_expected.to eq("one, two, or maybe three") }
      end

      context "and last_word_connector is nil" do
        let(:options) { { last_word_connector: nil } }

        it { is_expected.to eq("one, twothree") }
      end

      context "and last_word_connector is ' '" do
        let(:options) { { last_word_connector: " " } }

        it { is_expected.to eq("one, two three") }
      end

      context "and last_word_connector is ' or '" do
        let(:options) { { last_word_connector: " or " } }

        it { is_expected.to eq("one, two or three") }
      end
    end

    context "when given invalid options" do
      let(:options) { { passing: "invalid option" } }
      let(:array) { [] }

      it "raises an ArgumentError with detailed error message" do
        expect { subject }.to raise_error.with_message("Unknown key: :passing. Valid keys are: :words_connector, :two_words_connector, :last_word_connector, :locale")
      end
    end

    context "when array has blank_elements" do
      let(:array) { [nil, "one", "", "two", "three"] }
      it { is_expected.to eq(", one, , two, or three") }
    end

    context "when array contains a non-string element" do
      let(:array) { [1] }

      it { is_expected.to eq("1") }
    end
  end
end
