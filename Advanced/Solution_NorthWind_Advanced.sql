32. High-value customers 
    We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those who've made at least 1 order with a total value (not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016.

    with cte as( select  customers.customer_id,
               		 SUM(order_details.unit_price * order_details.quantity  * (1 - order_details.discount)) As Total
		 	 from customers
         		 join orders
              		   on customers.customer_id = orders.customer_id
		 	 join order_details
              		   on orders.order_id = order_details.order_id
		 	 where year(orders.order_date) = '1998'
         		 group by customers.customer_id
         		 order by orders.order_id
		 ) 
         select * 
                from cte 
		where total > 10000
                order by total desc;
		 
33.High-value customers - total orders 
   The manager has changed his mind. Instead of requiring that customers have at least one individual orders totaling $10,000 or more, he wants to define high-value customers as those who have orders totaling $15,000 or more in 2016. How would you change the answer to the problem above?

    with cte as( select customers.customer_id,
                        SUM(order_details.unit_price * order_details.quantity  * (1 - order_details.discount)) As Total
		 	from customers
         		join orders
              		  on customers.customer_id = orders.customer_id
		 	join order_details
              		  on orders.order_id = order_details.order_id
		 	where year(orders.order_date) = '1998'
         		group by customers.customer_id
         		order by orders.order_id
		 )
         select * 
                from cte 
		where total > 15000
                order by total desc
		 ;
34.High-value customers - with discount 
   Change the above query to use the discount when calculating high-value customers. Order by the total amount which includes the discount.
      with cte as(select customers.customer_id,
           		 order_details.order_id as orderid,
        		 SUM(order_details.unit_price * order_details.quantity  * (1 - order_details.discount)) As Total
		 	 from customers
         		 join orders
              		   on customers.customer_id = orders.customer_id
		 	 join order_details
              		   on orders.order_id = order_details.order_id
		 	 where year(orders.order_date) = '1998'
         		 group by customers.customer_id
         		 order by orders.order_id
		 )
         select * 
                from cte 
		where total > 10000
                order by total desc;
		 
 36. Orders with many line items 
     The Northwind mobile app developers are testing an app that customers will use to show orders. In order to make sure that even the largest orders will show up correctly on the app, they'd like some samples of orders that have lots of individual line items. Show the 10 orders with the most line items, in order of total line items.

   select order_id,
          count(product_id) as Total_Order_details
          from order_details
          group by order_id
          order by total_order_details desc;
 38.Orders - accidental double-entry 
    Janet Leverling, one of the salespeople, has come to you with a request. She thinks that she accidentally double-entered a line item on an order, with a different ProductID, but the same quantity. She remembers that the quantity was 60 or more. Show all the OrderIDs with line items that match this, in order of OrderID.

    with cte as ( Select  Order_ID,
          		  Product_ID,
      			  Quantity,
         		  count(quantity) as coun
         		  From Order_Details
        		  Where Quantity >= 60
      			  group by order_id , quantity
           		  order by order_id
		)
          select order_id 
                 from
                 cte 
                 where cte.coun > 1;
39.Orders - accidental double-entry details
   Based on the previous question, we now want to show details of the order, for orders that match the above criteria.
    with cte as ( Select  Order_ID,
          		  Product_ID,
      			  Quantity,
         		  count(quantity) as coun
         		  From Order_Details
        		  Where Quantity >= 60
      			  group by order_id , quantity
           		  order by order_id
		)
          select * 
                 from order_details
                 where order_details.order_id in (select order_id from cte where cte.coun > 1);
40.Orders - accidental double-entry details, derived table
   Here's another way of getting the same results as in the previous problem, using a derived table instead of a CTE. However, there's a bug in this SQL. It returns 20 rows instead of 16. Correct the SQL.

    with cte as ( Select  Order_ID,
          		  Product_ID,
          		  Quantity,
          	          count(quantity) as coun
                          From Order_Details
                          Where Quantity >= 60
        		  group by order_id , quantity
       			  order by order_id
		)
          select order_id 
                 from
                 cte 
                 where cte.coun > 1;
41.Late orders 
   Some customers are complaining about their orders arriving late. Which orders are late?

     select order_id,
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
43. with cte1 as(select orders.employee_id as emp_id,
                        LAST_name,
                        COUNT(order_id) as Total_orders,
		        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
			group by orders.employee_id
                ),
         cte2 as(select orders.employee_id as emp_id,
                        LAST_name,
		        COUNT(order_id) as late_orders,
                        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
                        where shipped_date > required_date
                        group by orders.employee_id
                  )
          select  cte1.emp_id,
		  cte1.last_name,
                  cte1.total_orders,
                  cte2.late_orders
                  from cte1
                  join cte2 
                    on cte1.emp_id  = cte2.emp_id;
44. with cte1 as(select orders.employee_id as emp_id,
                        LAST_name,
                        COUNT(order_id) as Total_orders,
		        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
			group by orders.employee_id
                ),
         cte2 as(select orders.employee_id as emp_id,
                        LAST_name,
		        COUNT(order_id) as late_orders,
                        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
                        where shipped_date > required_date
                        group by orders.employee_id
                  )
          select  cte1.emp_id,
		  cte1.last_name,
                  cte1.total_orders,
                  cte2.late_orders
                  from cte1
                  left join cte2 
                   on cte1.emp_id  = cte2.emp_id;

45.  with cte1 as(select orders.employee_id as emp_id,
                        LAST_name,
                        COUNT(order_id) as Total_orders,
		        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
			group by orders.employee_id
                 ),
          cte2 as(select orders.employee_id as emp_id,
                        LAST_name,
		        COUNT(order_id) as late_orders,
                        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
                        where shipped_date > required_date
                        group by orders.employee_id
                  )
          select  cte1.emp_id,
		  cte1.last_name,
                  cte1.total_orders,
                  case
                      when ISNULL(cte2.late_orders) then 0
                      else cte2.late_orders
		  END as late_orders
                  from cte1
                  left join cte2 
                         on cte1.emp_id  = cte2.emp_id;

 46. with cte1 as(select orders.employee_id as emp_id,
                        LAST_name,
                        COUNT(order_id) as Total_orders,
		        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
			group by orders.employee_id
                 ),
          cte2 as(select orders.employee_id as emp_id,
                         LAST_name,
		         COUNT(order_id) as late_orders,
                         shipped_date,
                         required_date
	     	         from orders	
		         JOIN employees
                           on employees.employee_id  = orders.employee_id
                         where shipped_date > required_date
                         group by orders.employee_id
                  )
          select  cte1.emp_id,
		  cte1.last_name,
                  cte1.total_orders,
                  cte2.late_orders,
                  (cast(cte2.late_orders as float)  / cast(cte1.total_orders as float) )  AS percentage_late_order
                  from cte1
                  left join cte2 
                         on cte1.emp_id  = cte2.emp_id;
47. with cte1 as(select orders.employee_id as emp_id,
                        LAST_name,
                        COUNT(order_id) as Total_orders,
		        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
			group by orders.employee_id
                ),
         cte2 as(select orders.employee_id as emp_id,
                        LAST_name,
		        COUNT(order_id) as late_orders,
                        shipped_date,
                        required_date
	     	        from orders	
		        JOIN employees
                          on employees.employee_id  = orders.employee_id
                        where shipped_date > required_date
                        group by orders.employee_id
                 )
          select  cte1.emp_id,
		  cte1.last_name,
                  cte1.total_orders,
                  cte2.late_orders,
                  ROUND( (cast(cte2.late_orders as float)  / cast(cte1.total_orders as float) ) , 2)  AS percentage_late_order
                  from cte1
                  left join cte2 
                         on cte1.emp_id  = cte2.emp_id;
48.	  with cte as(select customers.customer_id,
         		     SUM(order_details.unit_price * order_details.quantity) As Total
		 	     from customers
                             join orders
                             on customers.customer_id = orders.customer_id
		             join order_details
                             on orders.order_id = order_details.order_id
		             where year(order_date) = 1998
		             group by customers.customer_id        
                             order by orders.order_id)
               select * ,
                      case 
		            when total < 1000 then "Low"                
                            when total < 5000 then 'Medium'
                            when total < 10000 then 'High'
                            when total > 10000 then 'Very High'
                      END as customer_group
                      from cte 
		      order by customer_id;
		     
49.
  	  with cte as(select customers.customer_id,
         		     SUM(order_details.unit_price * order_details.quantity) As Total
		 	     from customers
         		     join orders
              		     on customers.customer_id = orders.customer_id
		 	     join order_details
              		     on orders.order_id = order_details.order_id
			     where year(order_date) = 1998
		 	     group by customers.customer_id        
         		     order by orders.order_id
		     )
              select * ,
              	     case 
		         when total < 1000 then "Low"                
                         when total < 5000 then 'Medium'
                         when total < 10000 then 'High'
                         when total > 10000 then 'Very High'
                     END as customer_group
                     from cte 
		     order by customer_id;
		 

 
