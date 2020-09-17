class EmployeesController < ApplicationController

    def index
        @employees = Employee.all
    end

    def show
        @employee = Employee.find(params[:id])
    end

    def new
        @employee = Employee.new
    end

    def create
        #create a jobs titles array and then lookup if job that was passed through params exists, if it does failure

        titles = Employee.all.map {|employee| employee.title}

        if titles.include?(params[:employee][:title])
            ## how do we throw an error in browser?
            render "error"
        else
            @employee = Employee.create(employee_params(:first_name, :last_name, :alias, :title, :office, :img_url, :dog_id))
            redirect_to employee_path(@employee)
        end
    end

    def edit
        @employee = Employee.find(params[:id])
    end

    def update
        @employee = Employee.find(params[:id])
        @employee.update(employee_params( :alias, :title, :office, :img_url, :dog_id))
        redirect_to employee_path(@employee)
    end

    private

    def employee_params(*args)
        params.require(:employee).permit(*args)
    end

end
