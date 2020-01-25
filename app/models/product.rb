class Product < ApplicationRecord
  searchkick

  SORT_BY = [["Relevance", "relevance"], ["Newest", "newest"], ["Oldest", "oldest"], ["Lowest price", "lprice"], ["Highest price", "hprice"]]
  PRICE_OPTIONS = [["Less Than", "lt"], ["Equal To", "eq"], ["Greater Than", "gt"]]

  validates :title, :description, :country, :tags, :price, presence: true

  def self.search_kick params
    search_term = params[:q].present? ? params[:q] : "*"

    price_condition, country_condition = {}, {}
    if params[:price].present?
      if params[:price_option].to_s == "lt"
        price_condition = {price: {lt: params[:price]}}
      elsif params[:price_option].to_s == "gt"
        price_condition = {price: {gt: params[:price]}}
      else
        price_condition = {price: params[:price]}
      end
    end
    country_condition = {country: params[:country]} if params[:country].present?
    conditions = {_and: [country_condition, price_condition]}
    sort_by_order = Product.get_sort_by_order(params[:sort_by])
    
    Product.search search_term, fields: ["title^10", "description", "price", "tags", "country"], where: conditions, order: sort_by_order, page: params[:page], per_page: 15
  end

  def self.get_sort_by_order sort_by
    if sort_by == "newest"
      sort_by_order = {created_at: :desc}
    elsif sort_by == "oldest"
      sort_by_order = {created_at: :asc}
    elsif sort_by == "hprice"
      sort_by_order = {price: :desc}
    elsif sort_by == "lprice"
      sort_by_order = {price: :asc}
    else
      sort_by_order = {_score: :desc}
    end
  end
end
