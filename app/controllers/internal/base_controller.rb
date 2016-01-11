module Internal
  class BaseController < ::ApplicationController
    before_filter :ensure_logged_in
    layout 'internal'
  end
end
