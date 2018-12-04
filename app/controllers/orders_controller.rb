require 'json'
require 'rubygems'

class OrdersController < ApplicationController
    respond_to :json
    before_action :find_order, only:[:show, :edit, :destroy, :update, :complete]
    attr_accessor :token, :status, :txn_id

    def index
        @orders = Order.where(user_id: current_user)
    end
    
    def show
      render 'complete'
      # Getting the TOKEN variable from javascript
      tok = params[:token]

      txn = Transaction.new() 

      # Create a new transaction
      response1 = txn.create_transaction(tok, @order.total, @order.id.to_s, @order.apple, @order.orange)
      response = JSON.parse(response1, symbolize_names: true)

      t_id = response[:data][:transaction][:transaction_id] 
      sta = response[:data][:transaction][:status]
      # Assigning the Txn_Id, Status variables to Order 
      @order.update_attributes(:token => tok, :txn_id => t_id, :status => sta)
    end
    
    def new
        @order = current_user.orders.build
    end
    
    def create
      @order = current_user.orders.build(order_params)
      
      if @order.save
        render 'show'
      else 
        render 'new'
      end
            
    end
    
    def update
      render 'complete'
    end

    def destroy 
        @order.destroy
        redirect_to orders_path
    end
    
    
    private
    
    def find_order
        @order = Order.find(params[:id])
    end
    
    def order_params
        params.require(:order).permit(:apple, :orange, :total, :token, :txn_id, :status)
    end   
     
end
