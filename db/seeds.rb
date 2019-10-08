# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create Users before problems!

# Users
    # Admin Account
    User.create(name: 'admin', password: "123456", password_confirmation: "123456", email: "computerscience@nuimsu.com", is_admin: 1, score: 0)


# Problems
    Problem.create([
        {
            title: "Factorial", is_current: 0, is_hidden: 1, cpu_time: "2", memory: "512m",
            total_user_score: 0, users_attempted: 0, score: 100,
            body: "Write a program that returns the factorial of a number.\nThe first line of input, n, will be how many numbers will follow to be processed.\n" + 
            "The output should consist of n lines, on eachline the factorial of the corresponding input number.\n" + 
            "Sample Input:\n```\n2\n5\n4\n```\nSample Output:\n```\n120\n24\n```\n",
            test_cases: "2\n4\n5\n***\n24\n120\n---\n" + 
            "2\n21\n27\n***\n51090942171709440000\n10888869450418352160768000000\n"
        }
    ])