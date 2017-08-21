class Article < ActiveRecord::Base
	has_many :comments
	has_many :article_categories
	has_many :categories, through: :article_categories
	belongs_to :article
	belongs_to :category
	validates_presence_of :title,:body
	validates_length_of :body, minimum: 10
	validate :check_published_date
	private #Custom validations
	def check_published_date
		if self.published_date < Date.today  && self.published == false
			errors.add(:published_date,"cannot be greater than 1 month")
		end
	end

end
