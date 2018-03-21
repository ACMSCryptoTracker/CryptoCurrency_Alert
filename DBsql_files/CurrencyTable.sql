CREATE TABLE public.currency
(
	crypto_id bigserial primary key,
	name text,
	symbol text,
	rank integer,
	price_usd double precision,
	price_btc double precision,
	c_24h_volume_usd double precision,
	market_cap_usd double precision,
	available_supply double precision,
	total_supply double precision,
	max_supply double precision,
	percentage_change_1h double precision,
	percentage_change_24h double precision,
	percentage_change_7d double precision,
	last_updated double precision
);
CREATE OR REPLACE FUNCTION notify_event() RETURNS TRIGGER AS $$

    DECLARE 
        data json;
        notification json;
    
    BEGIN
    
        -- Convert the old or new row to JSON, based on the kind of action.
        -- Action = DELETE?             -> OLD row
        -- Action = INSERT or UPDATE?   -> NEW row
        IF (TG_OP = 'DELETE') THEN
            data = row_to_json(OLD);
        ELSE
            data = row_to_json(NEW);
        END IF;
        
        -- Contruct the notification as a JSON string.
        notification = json_build_object(
                          'table',TG_TABLE_NAME,
                          'action', TG_OP,
                          'data', data);
        
                        
        -- Execute pg_notify(channel, notification)
        PERFORM pg_notify('events',notification::text);
        
        -- Result is ignored since this is an AFTER trigger
        RETURN NULL; 
    END;
    
$$ LANGUAGE plpgsql;
CREATE TRIGGER currency_AFTER AFTER INSERT OR UPDATE ON currency FOR EACH ROW EXECUTE PROCEDURE notify_event();


