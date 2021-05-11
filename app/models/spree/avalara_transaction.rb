# frozen_string_literal: true

module Spree
  class AvalaraTransaction < Spree::Base
    belongs_to :order
    validates :order, presence: true
    validates :order_id, uniqueness: true

    def lookup_avatax
      post_order_to_avalara(false, 'SalesOrder')
    end

    def commit_avatax(invoice_dt = nil, refund = nil)
      if tax_calculation_enabled?
        if %w(ReturnInvoice ReturnOrder).include?(invoice_dt)
          post_return_to_avalara(false, invoice_dt, refund)
        else
          post_order_to_avalara(false, invoice_dt)
        end
      else
        { 'totalTax' => 0.0 }
      end
    end

    def commit_avatax_final(invoice_dt = nil, refund = nil)
      if document_committing_enabled?
        if tax_calculation_enabled?
          if %w(ReturnInvoice ReturnOrder).include?(invoice_dt)
            post_return_to_avalara(true, invoice_dt, refund)
          else
            post_order_to_avalara(true, invoice_dt)
          end
        else
          { 'totalTax' => 0.0 }
        end
      else
        logger.info 'Avalara Document Committing Disabled'
        'Avalara Document Committing Disabled'
      end
    end

    def cancel_order
      cancel_order_to_avalara if tax_calculation_enabled?
    end

    private

    def cancel_order_to_avalara
      logger.info "Begin cancel order #{order.number} to avalara..."

      mytax = SolidusAvataxCertified::TaxSvc.new
      mytax.cancel_tax(order.number).tax_result
    end

    def post_order_to_avalara(commit = false, doc_type = nil)
      logger.info "Begin post order #{order.number} to avalara"

      request = SolidusAvataxCertified::Request::GetTax.new(order, commit: commit, doc_type: doc_type).generate

      mytax = SolidusAvataxCertified::TaxSvc.new
      response = mytax.get_tax(request)

      return { 'totalTax' => -1 } if response.error?

      response.tax_result
    end

    def post_return_to_avalara(commit = false, doc_type = nil, refund = nil)
      logger.info "Begin post return order #{order.number} to avalara"

      request = SolidusAvataxCertified::Request::ReturnTax.new(order, commit: commit, doc_type: doc_type, refund: refund).generate

      mytax = SolidusAvataxCertified::TaxSvc.new
      response = mytax.get_tax(request)

      return { 'totalTax' => 0.0 } if response.error?

      response.tax_result
    end

    def document_committing_enabled?
      Spree::Avatax::Config.document_commit
    end

    def tax_calculation_enabled?
      Spree::Avatax::Config.tax_calculation
    end

    def logger
      @logger ||= SolidusAvataxCertified::AvataxLog.new('Spree::AvalaraTransaction class')
    end
  end
end
