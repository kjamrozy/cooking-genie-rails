require 'rails_helper'

RSpec.shared_examples 'accessible_route' do |template, layout=nil|
  it 'renders index template' do
    expect(response).to render_template(template)
  end

  unless layout.nil?
    it "renders #{layout} layout" do
      expect(response).to render_template(layout: layout)
    end
  end
  
  it 'returns http success' do
    expect(response).to have_http_status(:success)
  end
end