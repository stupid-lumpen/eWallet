-- Drop table

-- DROP TABLE public.transaction_types;

CREATE TABLE public.transaction_types (
	transaction_type_id serial4 NOT NULL,
	type_name varchar NOT NULL,
	description text NULL,
	CONSTRAINT transaction_types_names UNIQUE (type_name),
	CONSTRAINT transaction_types_pk PRIMARY KEY (transaction_type_id)
);

ALTER TABLE public.users ADD created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL;

ALTER TABLE public.transaction_types ADD transaction_type_id serial4 NOT NULL;

ALTER TABLE public.users ADD "name" varchar NOT NULL;

ALTER TABLE public.transactions ADD type_id int4 NULL;

ALTER TABLE public.users ADD secret_2fa varchar NULL;

ALTER TABLE public.currencies ADD currency_id serial4 NOT NULL;

ALTER TABLE public.transaction_types ADD description text NULL;

-- Drop table

-- DROP TABLE public.currencies;

CREATE TABLE public.currencies (
	currency_id serial4 NOT NULL,
	code varchar NOT NULL,
	symbol varchar NULL,
	is_active bool DEFAULT true NULL,
	CONSTRAINT currencies_code UNIQUE (code),
	CONSTRAINT currencies_pk PRIMARY KEY (currency_id)
);

ALTER TABLE public.wallets ADD wallet_id uuid NOT NULL;

ALTER TABLE public.users ADD is_2fa_enabled bool DEFAULT false NULL;

ALTER TABLE public.transaction_statuses ADD is_terminal bool DEFAULT false NULL;

ALTER TABLE public.users ADD surname varchar NOT NULL;

ALTER TABLE public.transactions ADD receiver_wallet_id uuid NULL;

ALTER TABLE public.users ADD birth_date date NOT NULL;

ALTER TABLE public.transactions ADD descrtiption text NULL;

ALTER TABLE public.users ADD user_id uuid NOT NULL;

-- Drop table

-- DROP TABLE public.wallets;

CREATE TABLE public.wallets (
	wallet_id uuid NOT NULL,
	user_id uuid NULL,
	currency_id int4 NULL,
	balance numeric DEFAULT 0.00 NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT wallets_pk PRIMARY KEY (wallet_id),
	CONSTRAINT wallets_currencies_fk FOREIGN KEY (currency_id) REFERENCES public.currencies(currency_id),
	CONSTRAINT wallets_users_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id)
);

ALTER TABLE public.currencies ADD code varchar NOT NULL;

-- Drop table

-- DROP TABLE public.transactions;

CREATE TABLE public.transactions (
	transaction_id bigserial NOT NULL,
	sender_wallet_id uuid NULL,
	receiver_wallet_id uuid NULL,
	amount numeric NOT NULL,
	descrtiption text NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	type_id int4 NULL,
	status_id int4 NULL,
	CONSTRAINT transactions_pk PRIMARY KEY (transaction_id),
	CONSTRAINT transactions_transaction_statuses_fk FOREIGN KEY (status_id) REFERENCES public.transaction_statuses(transaction_status_id),
	CONSTRAINT transactions_transaction_types_fk FOREIGN KEY (type_id) REFERENCES public.transaction_types(transaction_type_id),
	CONSTRAINT transactions_wallets_fk FOREIGN KEY (sender_wallet_id) REFERENCES public.wallets(wallet_id),
	CONSTRAINT transactions_wallets_fk_1 FOREIGN KEY (sender_wallet_id) REFERENCES public.wallets(wallet_id)
);

ALTER TABLE public.transaction_statuses ADD transaction_status_id serial4 NOT NULL;

ALTER TABLE public.wallets ADD created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL;

ALTER TABLE public.wallets ADD currency_id int4 NULL;

ALTER TABLE public.transactions ADD transaction_id bigserial NOT NULL;

ALTER TABLE public.roles ADD role_name varchar NOT NULL;

ALTER TABLE public.users ADD fathername varchar NOT NULL;

ALTER TABLE public.users ADD email varchar NOT NULL;

ALTER TABLE public.transaction_types ADD type_name varchar NOT NULL;

ALTER TABLE public.wallets ADD user_id uuid NULL;

ALTER TABLE public.wallets ADD balance numeric DEFAULT 0.00 NULL;

ALTER TABLE public.transactions ADD amount numeric NOT NULL;

ALTER TABLE public.transactions ADD created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL;

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	user_id uuid NOT NULL,
	"name" varchar NOT NULL,
	surname varchar NOT NULL,
	fathername varchar NOT NULL,
	birth_date date NOT NULL,
	email varchar NOT NULL,
	secret_2fa varchar NULL,
	is_2fa_enabled bool DEFAULT false NULL,
	role_id int4 NOT NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT users_email UNIQUE (email),
	CONSTRAINT users_pk PRIMARY KEY (user_id),
	CONSTRAINT users_roles_fk FOREIGN KEY (role_id) REFERENCES public.roles(role_id)
);

ALTER TABLE public.users ADD role_id int4 NOT NULL;

-- Drop table

-- DROP TABLE public.roles;

CREATE TABLE public.roles (
	role_id serial4 NOT NULL,
	role_name varchar NOT NULL,
	CONSTRAINT roles_name UNIQUE (role_name),
	CONSTRAINT roles_pk PRIMARY KEY (role_id)
);

ALTER TABLE public.currencies ADD symbol varchar NULL;

ALTER TABLE public.transaction_statuses ADD status_name varchar NOT NULL;

-- Drop table

-- DROP TABLE public.transaction_statuses;

CREATE TABLE public.transaction_statuses (
	transaction_status_id serial4 NOT NULL,
	status_name varchar NOT NULL,
	is_terminal bool DEFAULT false NULL,
	CONSTRAINT transaction_statuses_names UNIQUE (status_name),
	CONSTRAINT transaction_statuses_pk PRIMARY KEY (transaction_status_id)
);

ALTER TABLE public.roles ADD role_id serial4 NOT NULL;

ALTER TABLE public.currencies ADD is_active bool DEFAULT true NULL;

ALTER TABLE public.transactions ADD sender_wallet_id uuid NULL;

ALTER TABLE public.transactions ADD status_id int4 NULL;
