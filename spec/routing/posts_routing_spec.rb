require "rails_helper"

RSpec.describe PostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/all").to route_to("posts#index")
    end

    it "routes to #show" do
      expect(get: "/1").to route_to("posts#show", id: "1")
    end

    it "routes to #user_posts" do
      expect(get: "/users/1/posts").to route_to("posts#user_posts", id: "1")
    end

    it "routes to #create" do
      expect(post: "/").to route_to("posts#create")
    end

    it "routes to #reply" do
      expect(post: "/1/reply").to route_to("posts#reply", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/1").to route_to("posts#destroy", id: "1")
    end
  end
end
