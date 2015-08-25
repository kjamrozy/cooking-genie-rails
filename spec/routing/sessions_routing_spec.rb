require 'rails_helper'

describe 'routing for Sessions' do
  it { expect(get: 'signin').to route_to('sessions#new') }
  it { expect(post: 'signin').to route_to('sessions#create') }
  it { expect(get: 'signout').to route_to('sessions#destroy') }
end