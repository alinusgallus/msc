class CompaniesController < ApplicationController


def index
	@companies = Company.scoped.page(params[:page]).per(50)
end

end
