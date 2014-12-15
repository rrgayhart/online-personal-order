require 'spec_helper'

describe OrderItem do
  let(:order_item){ build(:order_item) }
  let(:bought_today){ build(:order_item, last_purchase: Date.today) }
  let(:due_in_the_future){ build(:order_item, :bought_six_months_ago, frequency: 14) }
  let(:past_due){ build(:order_item, :bought_six_months_ago, frequency: 1) }
  let(:due_now){ build(:order_item, :bought_six_months_ago, frequency: 6) }

  describe 'Validations' do
    it { should validate_presence_of :last_purchase }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'Associations' do
    it { should have_many :order_item_locations }
    it { should have_many(:locations).through(:order_item_locations) }
  end

  describe '.purchase' do
    it 'sets the purchased date to today' do
      expect(order_item.last_purchase).to_not eq(Date.today)
      order_item.purchase
      expect(order_item.last_purchase).to eq(Date.today)
    end
  end

  describe '.set_due' do
    context 'when suject is not due' do
      it 'sets the frequency to equal months since last purchase' do
        due_in_the_future.set_due
        expect(due_in_the_future.frequency).to eq(due_in_the_future.months_since_purchase)
      end

      it 'handles due soon' do
        due_now.update_attributes(frequency: due_now.frequency += 1)
        due_now.set_due
        expect(due_now.frequency).to eq(due_now.months_since_purchase)
      end
    end

    context 'when subject bought this month' do
      it 'handles due in a month' do
        order_item = build(:order_item, last_purchase: Date.today, frequency: 1)
        order_item.set_due
        expect(order_item.frequency).to_not eq(0)
        expect(order_item.frequency).to_not eq(nil)
      end

      it 'handles due in many months' do
        order_item = build(:order_item, last_purchase: Date.today, frequency: 4)
        order_item.set_due
        expect(order_item.frequency).to_not eq(0)
        expect(order_item.frequency).to_not eq(nil)
      end
    end

    context 'when subject is due this month' do
      it 'does not change the frequency' do
        expect{ due_now.set_due }.to_not change{due_now.frequency}
      end

      it 'does not change the last_purchased' do
        expect{ due_now.set_due }.to_not change{due_now.last_purchase}
      end
    end

    context 'when suject is past due' do
      it 'does not change the frequency' do
        expect{ past_due.set_due }.to_not change{past_due.frequency}
      end

      it 'does not change the last_purchase' do
        expect{ past_due.set_due }.to_not change{past_due.last_purchase}
      end
    end
  end

  describe '.postpone' do
    context 'when item due' do
      it 'adds to the frequency until the item is due the next month' do
        expect{ past_due.postpone }.to change{ past_due.frequency }.by(6)
        expect(past_due.due?).to eq(false)
        expect(past_due.due_soon?).to eq(true)
      end
    end

    context 'when item is not due' do
      it 'adds one month to the frequency count' do
        expect{ due_in_the_future.postpone }.to change{ due_in_the_future.frequency }.by(1)
      end
    end

  end

  describe '.due?' do
    it 'returns true if past due' do
      expect(past_due.due?).to eq(true)
    end

    it 'returns true if due now' do
      expect(due_now.due?).to eq(true)
    end

    it 'returns false for due in a month' do
      due_now.update_attributes(frequency: due_now.frequency += 1)
      expect(due_now.due?).to eq(false)
    end

    it 'returns false for due in the ar future' do
      expect(due_in_the_future.due?).to eq(false)
    end
  end

  describe '.due_soon?' do
    it 'returns true only if due next month' do
      expect(past_due.due_soon?).to eq(false)
      expect(due_now.due_soon?).to eq(false)
      due_now.update_attributes(frequency: due_now.frequency += 1)
      expect(due_now.due_soon?).to eq(true)
      expect(due_in_the_future.due_soon?).to eq(false)
    end
  end

  describe 'months_till_purchase' do
    context 'with item due in the future' do
      it 'returns months until purchase should be made' do
        expect(due_in_the_future.months_till_purchase).to eq(8)
      end
    end

    context 'with item past due' do
      it 'returns negative months until purchase should be made' do
        expect(past_due.months_till_purchase).to eq(-5)
      end
    end

    context 'with item purchased today' do
      it 'returns' do
        bought_today.update_attributes(frequency: 2)
        expect(bought_today.months_till_purchase).to eq(2)
      end
    end
  end

  describe 'months_since_purchase' do
    it 'returns the number of months since last purchase' do
      expect(past_due.months_since_purchase).to eq(6)
    end

    it 'returns 0 if subject purchased this month' do
      expect(bought_today.months_since_purchase).to eq(0)
    end
  end
end
