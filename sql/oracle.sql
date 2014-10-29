
create table helloworld(
    id number(10) not null primary key,
    name varchar2(40)
);

drop table helloworld;

desc helloworld;

alter table helloworld add age number(3);


insert into helloworld (id, name, age) values (1, 'Henry Wang', 22);

insert into helloworld values (0, 'Henry Wang', 22);

select * from helloworld;

commit;

update helloworld set name = 'Brand Peter' where id = 0;


select * from helloworld where exists (select * from helloworld where id = 4);

select * from helloworld;


exec proc_helloworld(0, 'hehe');
exec proc_helloworld(1, 'First Name');

create or replace procedure proc_helloworld 
(
    p_id in number:=1,
    p_name in varchar2:='Default Name',
    p_age in number:=22
)
as
begin
    update helloworld set name=proc_helloworld.p_name where id=proc_helloworld.p_id;
end;

create or replace procedure get_helloworld 
(
    p_id in number:=1
)
is
begin
    select name from helloworld where id=proc_helloworld.p_id;
end;


create or replace function get_name(p_id in number)
    return varchar2
    is ret_val varchar2(10);
    
    begin
        select name into ret_val from helloworld where id=get_name.p_id;
        return(ret_val);
    end get_name;

select * from helloworld where name=get_name(1);

