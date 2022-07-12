require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'should be invalid to create a post without a creator' do
    invalid_post = Post.new(content: 'content')
    expect( invalid_post ).to_not be_valid
  end

  it 'should be invalid to create a post without content' do
    invalid_post_1 = Post.new(user_id: '123')
    invalid_post_2 = Post.new(user_id: '123', content: '')

    expect( invalid_post_1 ).to_not be_valid
    expect( invalid_post_2 ).to_not be_valid
  end

  it 'should be invalid to create a post exceeding the maximum content limit' do
    content_limit = 280
    content = '.' * (content_limit + 1)
    invalid_post = Post.new(user_id: '123', content: content)
    expect( invalid_post ).to_not be_valid
  end
end
