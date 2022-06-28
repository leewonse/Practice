#3����

select * from enrolleds e 
left join courses c on e.course_id =c.course_id 

select c1.course_id, c2.title ,count(*) from checkins c1
inner join courses c2 on c1.course_id =c2.course_id
group by c1.course_id 

select name, count(*) from orders o 
inner join users u on o.user_id = u.user_id
where o.email LIKE '%naver.com'
group by name

select o.payment_method, round(avg(pu.point)) from point_users pu 
inner join orders o on pu.user_id = o.user_id
group by o.payment_method 

select c2.title, c.week, count(*) from checkins c 
inner join courses c2 on c.course_id =c2.course_id 
group by c.week, c2.title 
order by c2.title, c.week

select c2.title, c1.week, count(*) as cnt from checkins c1
inner join courses c2 on c1.course_id =c2.course_id 
inner join orders o on c1.user_id =o.user_id 
where o.created_at >= '2020-08-01'
group by c1.week, c2.title
order by c2.title, c1.week

select u.name, count(*) as cnt from users u 
left join point_users pu on u.user_id =pu.user_id
where pu.point_user_id is NULL
group by u.name

select u.name, count(*) as cnt from users u 
left join point_users pu on u.user_id =pu.user_id
where pu.point_user_id is not NULL
group by u.name

select count(pu.point_user_id) as pnt_user_cnt,
       count(u.user_id) as tot_user_cnt,
       round(count(pu.point_user_id)/count(u.user_id),2) as ratio
  from users u
  left join point_users pu on pu.user_id = u.user_id
where u.created_at BETWEEN '2020-07-10' and '2020-07-20'

select * from users u
union all
select * from users u2 

select e1.enrolled_id, e1.user_id, count(e2.done) as max_count from enrolleds e1
inner join enrolleds_detail e2 on e2.enrolled_id = e1.enrolled_id
where e2.done = 1
group by e1.enrolled_id 
order by max_count desc

#4����

select c.checkin_id,
	   c.user_id,
	   c.likes,
	   (select avg(likes) from checkins
		 where user_id=c.user_id 
		) as avg_likes_user
	from checkins c

select pu.user_id, pu.point, a.avg_likes from point_users pu
inner join (select user_id, likes, round(avg(likes),1) as avg_likes
			from checkins c 
			group by user_id) a on pu.user_id = a.user_id

select * from point_users pu
where point > (
	select avg(point) from point_users pu
	where user_id in (
		select u.user_id from users u 
		where name LIKE '��%'
	)
)

select c.checkin_id, c.course_id, c.user_id, c.likes,
		(
			select round(avg(likes),1) from checkins c2
			where c.course_id = c2.course_id
		) as course_avg,
		c3.title
		from checkins c
		inner join courses c3 on c.course_id = c3.course_id 


select a.course_id, a.cnt_checkins, b.cnt_total, (a.cnt_checkins/b.cnt_total) as ratio, c.title from
(
	select course_id, count(distinct(user_id)) as cnt_checkins from checkins
	group by course_id 
) a
inner join
(
	select course_id, count(*) as cnt_total from orders
	group by course_id
) b on a.course_id=b.course_id
inner join courses c on c.course_id = a.course_id

-- with �� �̿��ϱ�
with table1 as (
	select course_id, count(distinct(user_id)) as cnt_checkins from checkins
	group by course_id 
), table2 as (
	select course_id, count(*) as cnt_total from orders
	group by course_id
)
select a.course_id, a.cnt_checkins, b.cnt_total, (a.cnt_checkins/b.cnt_total) as ratio, c.title
from table1 a
inner join table2 b on a.course_id=b.course_id
inner join courses c on c.course_id = a.course_id

-- ���ڿ�
select user_id, email, SUBSTRING_INDEX(email, '@', -1) from users # 1�� �տ� -1�� �ڿ�

select order_no, created_at, SUBSTRING(created_at, 1, 10) as date  from orders # ù��°���� 10�ڸ� �ڸ���

-- case
select a.lv, count(*) as cnt from (
	select user_id, point,
		(case when pu.point > 10000 then '���ϰ� �־��!'
		      when pu.point > 5000 then '5õ �̻�'
			  else '����' end) as lv
	from point_users pu
) a
group by a.lv

select point_user_id, point from point_users pu 

-- ���� 1��
select point_user_id, point,
	(case when a1.point > (select avg(point) from point_users) then '��'
	     else '��' end) as msg
	   from point_users a1

-- ���� 2��
select domain, count(*) as cnt from (
	select SUBSTRING_INDEX(email, '@', -1) as domain from users 
) a
group by domain

-- ���� 3��
select * from checkins c 
where comment LIKE '%ȭ����%'

-- ���� 4��
select a.enrolled_id, a.cnt, b.total_cnt from (
	select enrolled_id, count(*) as cnt from enrolleds_detail ed 
	where done = 1
	group by enrolled_id 
) a
inner join (
	select enrolled_id, count(*) as total_cnt from enrolleds_detail ed 
	group by enrolled_id 
) b on a.enrolled_id = b.enrolled_id

-- �� ����
select enrolled_id,
		sum(done) as done_cnt,
		count(*) as total_cnt,
		round(sum(done)/count(*),2) as ratio
	from enrolleds_detail ed  
	group by enrolled_id 


select * from enrolleds e

select * from courses c 

select * from enrolleds e 

select * from enrolleds_detail ed 

select * from point_users pu 

select * from orders o 

select * from checkins c 











