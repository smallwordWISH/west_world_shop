class SpgatewayController < ApplicationController
  skip_before_action :verify_authenticity_token

  def return
    trade_info = spgateway_params['TradeInfo']
    trade_sha = spgateway_params['TradeSha']

    data = Spgateway.decrypt(trade_info, trade_sha)
   
    # 根據參數的 MerchantOrderNo，查出 payment 實例
    # 更新相關的 payment 與 order 屬性

    if data
      payment = Payment.find(data['Result']['MerchantOrderNo'].to_i)
      if params['Status'] == 'SUCCESS'
        payment.paid_at = Time.now
      end
      payment.params = data
    end

    if payment&.save
      order = payment.order
      order.update(payment_status: 'paid')

      flash[:notice] = "#{order.sn} paid"
    else
      flash[:alert] = "Somethint went wrong. Please try again later."
    end

    redirect_to orders_path
  end

  def spgateway_params
    params.slice("Status", "MerchantID", "Version", "TradeInfo", "TradeSha")
  end
end