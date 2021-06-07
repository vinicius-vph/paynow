module LoginDefault
    def admin_one_login(admin_one = Admin.create!(email: 'admin_one@paynow.com', password: '123mudar'))
        login as admin_one, scope: :admin
        admin_one
    end

    def admin_two_login(admin_two = Admin.create!(email: 'admin_two@paynow.com', password: '123mudar'))
        login as admin_two, scope: :admin
        admin_two
    end
end