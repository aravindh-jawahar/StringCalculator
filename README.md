# README

https://blog.incubyte.co/blog/tdd-assessment/



**Create a simple String calculator with a method signature like this:**

Input: a string of comma-separated numbers
Output: an integer, sum of the numbers


Examples:

Input: “”, Output: 0
Input: “1”, Output: 1
Input: “1,5”, Output: 6


Allow the add method to handle any amount of numbers.

Allow the add method to handle new lines between numbers (instead of commas). ("1\n2,3" should return 6)

Support different delimiters:

To change the delimiter, the beginning of the string will contain a separate line that looks like this: "//[delimiter]\n[numbers…]". For example, "//;\n1;2" where the delimiter is ";" should return 3.
Calling add with a negative number will throw an exception: "negative numbers not allowed <negative_number>".


If there are multiple negative numbers, show all of them in the exception message, separated by commas.



**API's:**

API can be extended accordingly for different calculator logics, for now have the logic of string calculator with the requistics above in case of new addition will include the class for specific type of calculator and add perform! method to have seperate logic to get the result


**Sample API request:**

1. Post API to perform the addition

curl --location 'http://localhost:3000/calculators/calculate' \
--header 'Content-Type: application/json' \
--data '{
    "variant": "string_calculator",
    "operation": "add",
    "input": "//:\n1:3"
}'

varient indicates the calculator type - "string_calculator" is the current calculator
operation specifies the calculator operation type
input specifies the input data to process


**Pre-requistics to run the app**
1. Ruby - "3.1.2"
2. Rails - "7.1.5"
3. Postgresql >= 9.3
