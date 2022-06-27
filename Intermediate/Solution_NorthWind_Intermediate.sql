20. select  category_name ,
            count(product_id) as total_no_of_products
            from products
            join categories
		on products.category_id = categories.category_id
            group by category_name
	    order by total_no_of_products desc;
21.  select country,
            city,
            count(customer_id) as TotalCustomer
            from customers
            group by country, city
            order by country;
22.  select product_id,
            product_name,
            units_in_stock,
            reorder_level
            from products
            where units_in_stock <  reorder_level 
            order by product_id;
23.  select product_id,
            product_name,
            units_in_stock,
            units_on_order,
            reorder_level,
            discontinued
            from products
            where units_in_stock + units_on_order <  reorder_level and
                  discontinued = 0
            order by product_id;
24.   select customer_id,
             company_name,
             region,
             case
                when ISNULL(region) then 0
                else 1
			 END as reg
             from customers
             order by reg desc , region, company_name;
  25. select ship_country,
             avg(freight) as avg_fright 
             from orders
             group by ship_country
             order by avg_fright desc limit 3;
26.   select ship_country,
             avg(freight) as avg_fright
             from orders
             where order_date > '1996-01-01'
             group by ship_country
             order by avg_fright desc limit 3;
29.  select employees.employee_id,
            employees.last_name,
            orders.order_id,
            product_name,
            quantity
            from employees
            join orders
                on employees.employee_id = orders.employee_id
			join order_details
                on orders.order_id = order_details.order_id
			join products
                on products.product_id = order_details.product_id
			order by orders.order_id,products.product_id;
30.   select customers.customer_id,
             orders.order_id
             from customers
             left join orders
                  on customers.customer_id = orders.customer_id
	     where ISNULL(order_id);

31. 	select distinct(customers.customer_id) 
               from customers
               where customers.customer_id not in (select distinct(customers.customer_id) as custom
		                                    	  from
                                                          customers
                                                          left join orders
                                                                on customers.customer_id = orders.customer_id
			                                  where orders.employee_id = 4);
             
                  
             
      
             
             
