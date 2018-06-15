class SpgatewayController < ApplicationController
  skip_before_action :verify_authenticity_token

  def return
    hash_key = "a8g3vaCzZP2OOlXm0EdB4z87NsK80VKm"
    hash_iv = "8zenp5vcccOMj8I1"
    trade_info = spgateway_params['TradeInfo']
    trade_sha = spgateway_params['TradeSha']

    str = "HashKey=#{hash_key}&#{trade_info}&HashIV=#{hash_iv}"
    check_sha = Digest::SHA256.hexdigest(str).upcase

    if check_sha == trade_sha
      decipher = OpenSSL::Cipher::AES256.new(:CBC)
      decipher.decrypt
      decipher.padding = 0
      decipher.key = hash_key
      decipher.iv = hash_iv

      binary_encrypted = [trade_info].pack('H*') # hex to binary
      plain = decipher.update(binary_encrypted) + decipher.final

      # strip last padding
      if plain[-1] != '}'
        plain = plain[0, plain.index(plain[-1])]
      end
      data = JSON.parse(plain)
    end

    # 根據參數的 MerchantOrderNo，查出 payment 實例
    # 更新相關的 payment 與 order 屬性

    if data
      payment = Payment.find(data['Result']['MerchantOrderNo'].to_i)
      if params['Status'] == 'SUCCESS'
        payment.paid_at = Time.now
      end
      payment.params = data
    end

    if payment.save
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