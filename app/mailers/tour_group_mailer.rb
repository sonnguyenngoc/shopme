class TourGroupMailer < ApplicationMailer
	default from: 'soft.support@hoangkhang.com.vn'
	
	def tour_group_email(tour_group)
        @tour_group = tour_group
        mail(to: "sonnn0811@gmail.com", subject: "newdiscovery.vn - Giá Hot Tour Đoàn")
    end
end
