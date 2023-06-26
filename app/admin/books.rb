ActiveAdmin.register Book do
  permit_params :name, :price, :author_name, :isbn, :quantity_available
  controller do
    def create
      if current_admin_user.present?
        super
      else
        flash[:error] = 'Only admin users can create books.'
        redirect_to admin_books_path
      end
    end
  
    def update
      if current_admin_user.present?
        super
      else
        flash[:error] = 'Only admin users can update books.'
        redirect_to admin_books_path
      end
    end
  
    def destroy
      if current_admin_user.present?
        super
      else
        flash[:error] = 'Only admin users can delete books.'
        redirect_to admin_books_path
      end
    end
  end
end
