class BookingPlaneMailer < ApplicationMailer
    def booking_plane_email(booking_plane)
        @booking_plane = booking_plane
        mail(to: "sonnn0811@gmail.com", subject: "Newdiscovery.vn - Đặt Vé Máy Bay")
    end
end
