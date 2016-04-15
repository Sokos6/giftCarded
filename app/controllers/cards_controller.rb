class CardsController < ApplicationController
	def index
		@cards = Card.all
	end

	def show
		@card = Card.find(params[:id])
	end

	def new
		@card = Card.new()
	end

	def create
		p params
		@card = Card.new(card_params)
		p @card
		if (@card.save)
			redirect_to @card
		else 
			render "new"
		end
	end

	def edit
		@card = Card.find(params[:id])
	end

	def update
		@card = Card.find(params[:id])
		if (@card.update(card_params))
			redirect_to @card
		else
			render "edit"
		end
	end

	def destroy
		Card.destroy(params[:id])
		render "success"
	end

	def new_transaction
        @transaction = Transaction.new()
        render "transaction"
	end

	def complete_transaction
		p "********************************"
        p params
        @card = Card.find(params[:id])
		if (params[:tx_type] == "credit" && params[:tx_amount].to_f)
            @card.transactions.create(:tx_type => 'credit', :tx_amount => params[:transaction][:tx_amount].to_f)
            if (@card.update(:balance => (@card.balance.to_f + params[:transaction][:tx_amount].to_f)))
                redirect_to @card
			end
        else if (params[:tx_type] == "debit" && params[:tx_amount].to_f)
            if (@card.balance > params[:transaction][:tx_amount].to_f)
                @card.transactions.create(:tx_type => 'debit', :tx_amount => params[:transaction][:tx_amount].to_f)
                if (@card.update(:balance => (@card.balance.to_f - params[:transaction][:tx_amount].to_f)))
                    redirect_to @card
                end
            else 
                # error --> balance cannot be negative
            end
		else
			p "*************ERROR**************"
            # ERROR HANDLING !!!!
        end # Figure out why this end is here
        end
    end

    def list_transactions
        @card = Card.find(params[:id])
        @transactions = @card.transactions
        render "transactions"
    end
    
    def show_transaction
        @transaction = Transaction.find(params[:txid])
        render "show_transaction"
    end
    
	private
		def card_params
			params.require(:card).permit(:issuing_company, :card_number, :balance)
		end
end
