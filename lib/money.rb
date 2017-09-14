# Archivo gem-test/lib/money.rb
 
class Money
    attr_accessor :amount, :currency
    def initialize(amount,currency)
        @amount = amount
        @currency = currency
        @conversions = { 'USD' => 0.84, 'BTC' => 0.0047, 'JPY' => 131.8845, 'ARS' => 20.439, 'VEF' => 26916.18 }
    end
    
    def convert_to(currency)
        unless @currency == 'EUR'
            case @currency
                when 'USD' || 'BTC' then converted = @amount * @conversions[@currency]
                else converted = @amount / @conversions[@currency]
            end
            case currency
                when 'EUR' then return Money.new(converted.round(2),currency)
                when 'USD' then converted_next = converted.round(2) / @conversions[currency]
                else converted_next = converted.round(2) * @conversions[currency] 
            end
            return Money.new(converted_next.round(2),currency)
        end
        converted = @amount * @conversions[currency]
        Money.new(converted.round(2),currency)
    end
    
    def +(amount)
        if amount.class == Fixnum
            return "#{@amount + amount} #{@currency}"
        end
        if @currency != amount.currency
            amount = amount.convert_to(@currency).to_i
            return "#{@amount + amount} #{@currency}"
        else
           return "#{@amount + amount.amount} #{@currency}"
        end
    end
    
    def -(amount)
        if amount.class == Fixnum
            return "#{@amount - amount} #{@currency}"
        end
        if @currency != amount.currency
            amount = amount.convert_to(@currency).to_i
            return "#{@amount - amount} #{@currency}"
        else
           return "#{@amount - amount.amount} #{@currency}"
        end
    end
    
    def *(amount)
        if amount.class == Fixnum
            return "#{@amount * amount} #{@currency}"
        end
        if @currency != amount.currency
            amount = amount.convert_to(@currency).to_i
            return "#{@amount * amount} #{@currency}"
        else
           return "#{@amount * amount.amount} #{@currency}"
        end
    end
    
    def /(amount)
        if amount.class == Fixnum
            return "#{@amount / amount} #{@currency}"
        end
        if @currency != amount.currency
            amount = amount.convert_to(@currency).to_i
            return "#{@amount / amount} #{@currency}"
        else
           return "#{@amount / amount.amount} #{@currency}"
        end
    end
    
    def ==(amount)
        unless amount.class == Fixnum || @currency == amount.currency
            amount = amount.convert_to(@currency)
        end
        @amount == amount ? true : false
    end
    
    def >(amount)
        unless @currency == amount.currency
            amount = amount.convert_to(@currency).to_i
            @amount > amount ? true : false
        else
            @amount > amount.amount ? true : false
        end
    end
    
    def <(amount)
        unless @currency == amount.currency
            amount = amount.convert_to(@currency).to_i
            @amount < amount ? true : false
        else
            @amount < amount.amount ? true : false
        end
    end
end
