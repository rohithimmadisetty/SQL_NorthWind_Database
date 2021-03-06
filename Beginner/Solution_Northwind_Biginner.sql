
1. select * from shippers;

2. Select category_name,description from Categories;

3. select first_name,
       last_name,
       hire_date
       from employees
       where title = 'Sales Representative';
       
4. select first_name,
          last_name,
          hire_date
          from employees
          where title = 'Sales Representative' and country = 'USA';
   
5. select order_id,
          order_date
          from orders
          where employee_id = 5;
       
6. select supplier_id , 
          contact_name,
          contact_title
          from suppliers
          where contact_title != 'Marketing Manager';
7. select product_id,
          product_name
          from products
          where product_name like '%Queso%';
8.select order_id,
         customer_id,
         ship_country
         from orders
         where ship_country = 'France' OR ship_country = 'Belgium';

9.Select Order_ID,
         Customer_ID,
         Ship_Country From Orders
         where Ship_Country in ( 'Brazil','Mexico','Argentina','Venezuela');  
         
10. select first_name,
           last_name,
           title,
           birth_date
           from employees
           order by birth_date;
11. select first_name,
           last_name,
           title,
           DATE(birth_date)
           from employees
           order by DATE(birth_date);
12. select first_name,
            last_name,
            concat(first_name , ' ' ,  last_name)
            from employees;
13. select order_id,
           product_id,
           unit_price,
           quantity,
           unit_price * quantity as Total_Price
           from order_details
           order by order_id, product_id;

14. select count(distinct(customer_id)) as Total_customers
           from customers;
15. select MIN(order_date) as First_order
	       from orders;
16.	select distinct(country)
           from customers;
17. select contact_title, count(contact_title) as Total_contact_title 
           from customers
           group by contact_title
           order by Total_contact_title desc;
 18.select product_id,
           product_name,
           company_name as supplier
           from products
           left join suppliers	
             on products.supplier_id = suppliers.supplier_id
			order by product_id;
19. select order_id,
           DATE(order_date),
           company_name as supplier
           from orders
           left join shippers	
             on orders.ship_via = shippers.shipper_id
		   where order_id < 10300
		   order by order_id;
	
	