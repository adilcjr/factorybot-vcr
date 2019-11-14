require 'rails_helper'

RSpec.describe Customer, type: :model do

  it '#full_name' do
    customer = create(:customer)
    expect(customer.full_name).to start_with('Sr. ')
  end

  it 'customer_default' do
    customer = create(:customer_default)
    expect(customer.vip).to be false
    expect(customer.days_to_pay).to eq 15
  end

  it 'customer_vip' do
    customer = create(:customer_vip)
    expect(customer.vip).to be true
    expect(customer.days_to_pay).to eq 30
  end

  it '#full_name (changing name attr)' do
    customer = create(:customer, name: 'Jackson Pires')
    expect(customer.full_name).to start_with('Sr. Jackson Pires')
  end

  it 'attributes_for' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with('Sr. ') 
  end

  it { expect { create(:customer) }.to change { Customer.all.size }.by(1) }

  it 'Transient attributes' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Customer female' do
    customer = create(:customer_female)
    expect(customer.gender).to eq('F')
  end

  it 'Customer male vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(true)
  end

  it '#travel_to' do
    travel_to Time.zone.local(2004, 11, 24, 1, 4, 44) do
      @customer = create(:customer_vip)
    end
    puts @customer.created_at
    expect(@customer.created_at).to be < Time.new(2004, 11, 24, 1, 4, 44)
    expect(@customer.created_at).to be < Time.now
  end

  it 'Customer male default' do
    customer = create(:customer_male_default)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(false)
  end
end
