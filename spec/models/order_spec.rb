require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'Tem 1 pedido - belongs_to' do
    customer = create(:customer)
    order = create(:order, customer: customer)
    expect(order.customer).to be_kind_of(Customer)
  end

  it 'Tem 3 pedidos - create_list' do
    orders = create_list(:order, 3, description: 'Teste')
    puts orders.inspect
    expect(orders.count).to eq(3)
  end

  it 'has_many' do
    customer = create(:customer_with_orders)
    puts customer.inspect
    puts customer.orders.inspect
    expect(customer.orders.count).to eq(3)
  end
end
