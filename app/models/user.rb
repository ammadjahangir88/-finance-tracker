class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends , through: :friendships
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def full_name
           return "#{first_name} #{last_name}".strip if (first_name || last_name)
           "Anonymous"
         end

         def stock_already_added?(ticker_symbol)
          stock = Stock.find_by_ticker(ticker_symbol)
          return false unless stock
          user_stocks.where(stock_id: stock.id).exists?
          end
          
          def under_stock_limit?
          (user_stocks.count < 10)
          end
          
          def can_add_stock?(ticker_symbol)
          under_stock_limit? && !stock_already_added?(ticker_symbol)
          end

          def self.search(param)
            param.strip!
            param.downcase!
            to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
            return nil unless to_send_back
            to_send_back

          end
        def self.first_name_matches(params)
          matches('first_name',params)

        end
        def self.last_name_matches(params)
          matches('last_name',params)

        end

        def self.email_matches(params)
          matches('email',params)

        end
        def self.matches(field_name, params)
          where("#{field_name} like ?", "%#{params}%")
        end
end
