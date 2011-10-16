class PageRequestsController < ApplicationController
  def index
    @page_requests = PageRequest.all
    @page_request_last = PageRequest.first
  end
end
