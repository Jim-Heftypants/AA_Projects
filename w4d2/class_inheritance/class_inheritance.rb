class Employee # This means the Employee is the subclass of Manager. Will has essentially the same variables as in Manager.
    attr_reader :salary
    def initialize(name, salary, title, boss)
        @name = name
        @salary = salary
        @title = title
        @boss = boss
    end

    def bonus(multiplier)
        bonus = (salary) * multiplier
    end

end


class Manager < Employee

    def initialize(name, salary, title, boss, employees)
        super(name, salary, title, boss)
        @employees = employees
    end

    def bonus(multiplier)
        sum = 0
        @employees.each do |employee|
            sum += employee.salary * multiplier
        end
        sum
    end
end

jim = Employee.new("Jim", 100, "employee", "manager")
joe = Employee.new("Joe", 50, "employee", "manager")

manager = Manager.new("Bill", 200, "manager", "none", [jim, joe])

p jim.bonus(1)      # 100
p joe.bonus(1)      # 50
p manager.bonus(2)  # 300