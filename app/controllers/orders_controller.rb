class OrdersController < ApplicationController
    before_action :find_order, only:[:show]


    def index
        @orders = Order.where(user_id: current_user)
    end
    
    def show
    end
    
    def new
        @order = current_user.orders.build
    end
    
    def create
        @order = current_user.orders.build(order_params)
        if @order.save
            redirect_to @order
            else 
                render 'new'
        end
            
    end
    
    def update
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
