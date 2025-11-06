create or replace trigger bb_order_trg
after update of stock on bb_product
for each row
declare 
v_onorder_num number(6);
BEGIN
        if (:NEW.stock <= :NEW.reorder)
        THEN
            select sum(qty)
            into v_onorder_num
            from BB_PRODUCT_REQUEST
            where idProduct = :new.idProduct
            and dtRect is null;

        if v_onorder_num is null 
        then 
            v_onorder_num := 0;
        end if;

        if v_onorder_num = 0
        THEN
            insert into bb_product_request(idRequest, idProduct, dtRequest, qty)
            values(BB_PRODID_SEQ.nextval, :NEW.idProduct, SYSDATE, :NEW.reorder);
        end if;
        end if;
end;

select stock, reorder
from BB_PRODUCT
where IDPRODUCT = 4;

update BB_PRODUCT
set stock = 24
where IDPRODUCT = 4;

select * from BB_PRODUCT_REQUEST;
ROLLBACK;

        