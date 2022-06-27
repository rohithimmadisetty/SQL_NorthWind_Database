32. with cte as( select customers.customer_id,
         SUM(order_details.unit_price * order_details.quantity) As Total
		 from customers
         join orders
              on customers.customer_id = orders.customer_id
		 join order_details
              on orders.order_id = order_details.order_id
		 where year(orders.order_date) = '1998'
         group by customers.customer_id
         order by orders.order_id)
         select * 
                from cte 
				where total > 10000
                order by total desc;
		 ;
33.with cte as( select customers.customer_id,
        SUM(order_details.unit_price * order_details.quantity) As Total
		 from customers
         join orders
              on customers.customer_id = orders.customer_id
		 join order_details
              on orders.order_id = order_details.order_id
		 where year(orders.order_date) = '1998'
         group by customers.customer_id
         order by orders.order_id)
         select * 
                from cte 
				where total > 15000
                order by total desc;
		 ;
34.   with cte as( select customers.customer_id,
           order_details.order_id as orderid,
        SUM(order_details.unit_price * order_details.quantity  * (1 - order_details.discount)) As Total
		 from customers
         join orders
              on customers.customer_id = orders.customer_id
		 join order_details
              on orders.order_id = order_details.order_id
		 where year(orders.order_date) = '1998'
         group by customers.customer_id
         order by orders.order_id)
         select * 
                from cte 
				where total > 10000
                order by total desc;
		 ;
 select max(day(order_date)),
        order_date
        from orders
        group by year(order_date), month(order_date)
        order by order_date;
36.select order_id,
         count(product_id) as Total_Order_details
         from order_details
         group by order_id
         order by total_order_details desc;
 38. with cte as ( Select  Order_ID,
          Product_ID,
          Quantity,
          count(quantity) as coun
          From Order_Details
          Where Quantity >= 60
          group by order_id , quantity
          order by order_id)
          select order_id 
                 from
                 cte 
                 where cte.coun > 1;
39. with cte as ( Select  Order_ID,
          Product_ID,
          Quantity,
          count(quantity) as coun
          From Order_Details
          Where Quantity >= 60
          group by order_id , quantity
          order by order_id)
          select * 
                 from order_details
                 where order_details.order_id in (select order_id from cte where cte.coun > 1);
40. with cte as ( Select  Order_ID,
          Product_ID,
          Quantity,
          count(quantity) as coun
          From Order_Details
          Where Quantity >= 60
          group by order_id , quantity
          order by order_id)
          select order_id 
                 from
                 cte 
                 where cte.coun > 1;
41.  select order_id,
         order_date,
         required_date,
         shipped_date
		 from orders	
         where shipped_date >  required_date;
42.   select orders.employee_id,
              LAST_name,
              COUNT(order_id)
	     	 from orders	
		  JOIN employees
            on employees.employee_id  = orders.employee_id
         where shipped_date >  required_date
         group by employee_id;

 