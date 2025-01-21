CREATE TYPE public.status_type AS ENUM
    ('registration', 'reset', 'new_email', 'confirmed', 'invalid');

CREATE TABLE IF NOT EXISTS "user"
(
    "userId" SERIAL NOT NULL,
    "userName" TEXT NOT NULL,
    email TEXT NOT NULL,
    hash TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "middleName" TEXT,
    "userPhone" TEXT,
    "userAddress" TEXT,
    "userCredentials" TEXT,
    token character varying,
    status status_type DEFAULT 'registration'::status_type,
    alias TEXT[],
    "createdAt" timestamp without time zone DEFAULT now(),
    "updatedAt" timestamp without time zone DEFAULT now(),
    CONSTRAINT user_pkey PRIMARY KEY ("userName"),
    CONSTRAINT unique_email UNIQUE (email),
    CONSTRAINT user_id_unique_key UNIQUE ("userId")
);

CREATE TABLE IF NOT EXISTS "role"
(
    role TEXT NOT NULL,
    "roleDesc" TEXT,
    CONSTRAINT role_pkey PRIMARY KEY (role)
);

CREATE TABLE IF NOT EXISTS user_role
(
    "userRoleUserId" INTEGER NOT NULL,
    "userRole" TEXT NOT NULL,
    CONSTRAINT user_role_unique UNIQUE ("userRoleUserId", "userRole"),
    CONSTRAINT user_role_role_fkey FOREIGN KEY ("userRole")
        REFERENCES "role" (role) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_role_userId_fkey" FOREIGN KEY ("userRoleUserId")
        REFERENCES "user" ("userId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS user_alias
(
    alias TEXT NOT NULL,
    "userAliasUserId" INTEGER NOT NULL,
    CONSTRAINT user_alias_pkey PRIMARY KEY (alias),
    CONSTRAINT "user_alias_user_id_fkey" FOREIGN KEY ("userAliasUserId")
        REFERENCES "user" ("userId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE OR REPLACE FUNCTION set_user_alias_rows_from_user_array()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	alias TEXT;
BEGIN
	DELETE FROM user_alias WHERE "userAliasUserId"=NEW."userId";
	RAISE NOTICE 'Alias Array %', NEW."alias";
	FOR i IN array_lower(NEW.alias, 1) .. array_upper(NEW.alias, 1)
	LOOP
		RAISE NOTICE 'alias: %', NEW.alias[i];
		INSERT INTO user_alias ("userAliasUserId", "alias") VALUES (NEW."userId", NEW.alias[i]);
	END LOOP;

	RETURN NEW;
END;
$BODY$;

CREATE FUNCTION public.set_updated_at()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
   NEW."updatedAt" = now(); 
   RETURN NEW;
END;
$BODY$;

CREATE TRIGGER trigger_before_insert_set_user_alias_rows_from_user_array
    AFTER INSERT
    ON "user"
    FOR EACH ROW
    EXECUTE FUNCTION set_user_alias_rows_from_user_array();

CREATE TRIGGER trigger_before_update_set_user_alias_rows_from_user_array
    AFTER UPDATE 
    ON "user"
    FOR EACH ROW
    EXECUTE FUNCTION set_user_alias_rows_from_user_array();

CREATE TRIGGER trigger_updated_at
    BEFORE UPDATE 
    ON "user"
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();
