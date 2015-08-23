require 'rails_helper'
describe 'routing for Users', type: :routing do
  it { expect(get: '/signup').to route_to('users#new') }

  it { expect(get: '/users').to route_to('users#index') }
  it { expect(post: '/users').to route_to('users#create') }
  it { expect(get: '/users/1/edit').to route_to('users#edit', id: '1') }
  it { expect(get: '/users/1').to route_to('users#show', id: '1') }
  it { expect(put: '/users/1').to route_to('users#update', id: '1') }
  it { expect(delete: '/users/1').to route_to('users#destroy', id: '1') }
end
