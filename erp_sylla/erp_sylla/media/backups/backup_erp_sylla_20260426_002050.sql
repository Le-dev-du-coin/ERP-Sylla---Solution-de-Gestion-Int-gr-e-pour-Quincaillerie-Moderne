--
-- PostgreSQL database dump
--

\restrict jwuLHlRrbjeh9hEadflhwIGtcJGuwrRUcHQWzwJEjscHnW8LWr1fPvGXPeEiuKN

-- Dumped from database version 16.13
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_user_id_20aca447_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_perm_permission_id_0b93982e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_user_id_5f6f5a90_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_group_id_9afc8d0e_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.users_user DROP CONSTRAINT IF EXISTS users_user_assigned_warehouse_i_619f9c78_fk_inventory;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialaccount DROP CONSTRAINT IF EXISTS socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialapp_sites DROP CONSTRAINT IF EXISTS socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialapp_sites DROP CONSTRAINT IF EXISTS socialaccount_social_site_id_2579dee5_fk_django_si;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialtoken DROP CONSTRAINT IF EXISTS socialaccount_social_app_id_636a42d7_fk_socialacc;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialtoken DROP CONSTRAINT IF EXISTS socialaccount_social_account_id_951f210e_fk_socialacc;
ALTER TABLE IF EXISTS ONLY public.sales_saleitem DROP CONSTRAINT IF EXISTS sales_saleitem_sale_id_56e67045_fk_sales_sale_id;
ALTER TABLE IF EXISTS ONLY public.sales_saleitem DROP CONSTRAINT IF EXISTS sales_saleitem_product_id_aeb6c9cd_fk_inventory_product_id;
ALTER TABLE IF EXISTS ONLY public.sales_sale DROP CONSTRAINT IF EXISTS sales_sale_seller_id_45166e30_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.sales_sale DROP CONSTRAINT IF EXISTS sales_sale_customer_id_2d66a408_fk_sales_customer_id;
ALTER TABLE IF EXISTS ONLY public.sales_payment DROP CONSTRAINT IF EXISTS sales_payment_received_by_id_82d5232b_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.sales_payment DROP CONSTRAINT IF EXISTS sales_payment_customer_id_a80e1f14_fk_sales_customer_id;
ALTER TABLE IF EXISTS ONLY public.sales_historicalsaleitem DROP CONSTRAINT IF EXISTS sales_historicalsale_history_user_id_4c052ebe_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.sales_historicalsale DROP CONSTRAINT IF EXISTS sales_historicalsale_history_user_id_11ceb754_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.sales_historicalpayment DROP CONSTRAINT IF EXISTS sales_historicalpaym_history_user_id_fc35d9f8_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.sales_historicalcustomer DROP CONSTRAINT IF EXISTS sales_historicalcust_history_user_id_bdb5b6b6_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.mfa_authenticator DROP CONSTRAINT IF EXISTS mfa_authenticator_user_id_0c3a50c0_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.inventory_stocktransaction DROP CONSTRAINT IF EXISTS inventory_stocktrans_warehouse_id_deef05ac_fk_inventory;
ALTER TABLE IF EXISTS ONLY public.inventory_stocktransaction DROP CONSTRAINT IF EXISTS inventory_stocktrans_to_warehouse_id_a035bea4_fk_inventory;
ALTER TABLE IF EXISTS ONLY public.inventory_stocktransaction DROP CONSTRAINT IF EXISTS inventory_stocktrans_product_id_6432f3fb_fk_inventory;
ALTER TABLE IF EXISTS ONLY public.inventory_historicalwarehouse DROP CONSTRAINT IF EXISTS inventory_historical_history_user_id_c9027fb5_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.inventory_historicalstocktransaction DROP CONSTRAINT IF EXISTS inventory_historical_history_user_id_93858482_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.inventory_historicalproduct DROP CONSTRAINT IF EXISTS inventory_historical_history_user_id_61ecbda7_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_periodictask DROP CONSTRAINT IF EXISTS django_celery_beat_p_solar_id_a87ce72c_fk_django_ce;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_periodictask DROP CONSTRAINT IF EXISTS django_celery_beat_p_interval_id_a8ca27da_fk_django_ce;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_periodictask DROP CONSTRAINT IF EXISTS django_celery_beat_p_crontab_id_d3cba168_fk_django_ce;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_periodictask DROP CONSTRAINT IF EXISTS django_celery_beat_p_clocked_id_47a69f82_fk_django_ce;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.core_releasecode DROP CONSTRAINT IF EXISTS core_releasecode_used_by_id_f6b72843_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.core_releasecode DROP CONSTRAINT IF EXISTS core_releasecode_created_by_id_995a897d_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.core_historicalreleasecode DROP CONSTRAINT IF EXISTS core_historicalrelea_history_user_id_5a170592_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.core_historicalexpense DROP CONSTRAINT IF EXISTS core_historicalexpen_history_user_id_ed5edfa1_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.core_historicalaudittestmodel DROP CONSTRAINT IF EXISTS core_historicalaudit_history_user_id_18c8e9f9_fk_users_use;
ALTER TABLE IF EXISTS ONLY public.core_expense DROP CONSTRAINT IF EXISTS core_expense_recorded_by_id_b2fff93e_fk_users_user_id;
ALTER TABLE IF EXISTS ONLY public.core_expense DROP CONSTRAINT IF EXISTS core_expense_category_id_dcdb74b3_fk_core_expensecategory_id;
ALTER TABLE IF EXISTS ONLY public.communications_whatsappnotification DROP CONSTRAINT IF EXISTS communications_whats_sale_id_7ad31ee7_fk_sales_sal;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.account_emailconfirmation DROP CONSTRAINT IF EXISTS account_emailconfirm_email_address_id_5b7f8c58_fk_account_e;
ALTER TABLE IF EXISTS ONLY public.account_emailaddress DROP CONSTRAINT IF EXISTS account_emailaddress_user_id_2c513194_fk_users_user_id;
DROP INDEX IF EXISTS public.users_user_username_06e46fe6_like;
DROP INDEX IF EXISTS public.users_user_user_permissions_user_id_20aca447;
DROP INDEX IF EXISTS public.users_user_user_permissions_permission_id_0b93982e;
DROP INDEX IF EXISTS public.users_user_groups_user_id_5f6f5a90;
DROP INDEX IF EXISTS public.users_user_groups_group_id_9afc8d0e;
DROP INDEX IF EXISTS public.users_user_assigned_warehouse_id_619f9c78;
DROP INDEX IF EXISTS public.unique_verified_email;
DROP INDEX IF EXISTS public.unique_primary_email;
DROP INDEX IF EXISTS public.unique_authenticator_type;
DROP INDEX IF EXISTS public.socialaccount_socialtoken_app_id_636a42d7;
DROP INDEX IF EXISTS public.socialaccount_socialtoken_account_id_951f210e;
DROP INDEX IF EXISTS public.socialaccount_socialapp_sites_socialapp_id_97fb6e7d;
DROP INDEX IF EXISTS public.socialaccount_socialapp_sites_site_id_2579dee5;
DROP INDEX IF EXISTS public.socialaccount_socialaccount_user_id_8146e70c;
DROP INDEX IF EXISTS public.sales_saleitem_sale_id_56e67045;
DROP INDEX IF EXISTS public.sales_saleitem_product_id_aeb6c9cd;
DROP INDEX IF EXISTS public.sales_sale_seller_id_45166e30;
DROP INDEX IF EXISTS public.sales_sale_invoice_number_a14f1a3f_like;
DROP INDEX IF EXISTS public.sales_sale_customer_id_2d66a408;
DROP INDEX IF EXISTS public.sales_payment_reference_842837cc_like;
DROP INDEX IF EXISTS public.sales_payment_received_by_id_82d5232b;
DROP INDEX IF EXISTS public.sales_payment_customer_id_a80e1f14;
DROP INDEX IF EXISTS public.sales_historicalsaleitem_sale_id_4652e58d;
DROP INDEX IF EXISTS public.sales_historicalsaleitem_product_id_947d640f;
DROP INDEX IF EXISTS public.sales_historicalsaleitem_id_3cc5e1a9;
DROP INDEX IF EXISTS public.sales_historicalsaleitem_history_user_id_4c052ebe;
DROP INDEX IF EXISTS public.sales_historicalsaleitem_history_date_c011a62c;
DROP INDEX IF EXISTS public.sales_historicalsale_seller_id_926bbc25;
DROP INDEX IF EXISTS public.sales_historicalsale_invoice_number_9c8baf23_like;
DROP INDEX IF EXISTS public.sales_historicalsale_invoice_number_9c8baf23;
DROP INDEX IF EXISTS public.sales_historicalsale_id_8c416b86;
DROP INDEX IF EXISTS public.sales_historicalsale_history_user_id_11ceb754;
DROP INDEX IF EXISTS public.sales_historicalsale_history_date_5f081278;
DROP INDEX IF EXISTS public.sales_historicalsale_customer_id_a7bce04b;
DROP INDEX IF EXISTS public.sales_historicalpayment_reference_d9103091_like;
DROP INDEX IF EXISTS public.sales_historicalpayment_reference_d9103091;
DROP INDEX IF EXISTS public.sales_historicalpayment_received_by_id_231c542c;
DROP INDEX IF EXISTS public.sales_historicalpayment_id_52139224;
DROP INDEX IF EXISTS public.sales_historicalpayment_history_user_id_fc35d9f8;
DROP INDEX IF EXISTS public.sales_historicalpayment_history_date_d63ef693;
DROP INDEX IF EXISTS public.sales_historicalpayment_customer_id_ee4f5dae;
DROP INDEX IF EXISTS public.sales_historicalcustomer_id_e3614027;
DROP INDEX IF EXISTS public.sales_historicalcustomer_history_user_id_bdb5b6b6;
DROP INDEX IF EXISTS public.sales_historicalcustomer_history_date_e904161d;
DROP INDEX IF EXISTS public.mfa_authenticator_user_id_0c3a50c0;
DROP INDEX IF EXISTS public.inventory_stocktransaction_warehouse_id_deef05ac;
DROP INDEX IF EXISTS public.inventory_stocktransaction_to_warehouse_id_a035bea4;
DROP INDEX IF EXISTS public.inventory_stocktransaction_product_id_6432f3fb;
DROP INDEX IF EXISTS public.inventory_product_sku_2aad2a63_like;
DROP INDEX IF EXISTS public.inventory_product_barcode_69d7d92c_like;
DROP INDEX IF EXISTS public.inventory_historicalwarehouse_id_5baca775;
DROP INDEX IF EXISTS public.inventory_historicalwarehouse_history_user_id_c9027fb5;
DROP INDEX IF EXISTS public.inventory_historicalwarehouse_history_date_c3103f39;
DROP INDEX IF EXISTS public.inventory_historicalstocktransaction_warehouse_id_8fa5c4c1;
DROP INDEX IF EXISTS public.inventory_historicalstocktransaction_to_warehouse_id_c0cd85b7;
DROP INDEX IF EXISTS public.inventory_historicalstocktransaction_product_id_0be3d71c;
DROP INDEX IF EXISTS public.inventory_historicalstocktransaction_id_1a64a2a7;
DROP INDEX IF EXISTS public.inventory_historicalstocktransaction_history_user_id_93858482;
DROP INDEX IF EXISTS public.inventory_historicalstocktransaction_history_date_3a21f60d;
DROP INDEX IF EXISTS public.inventory_historicalproduct_sku_82526047_like;
DROP INDEX IF EXISTS public.inventory_historicalproduct_sku_82526047;
DROP INDEX IF EXISTS public.inventory_historicalproduct_id_02f78ad9;
DROP INDEX IF EXISTS public.inventory_historicalproduct_history_user_id_61ecbda7;
DROP INDEX IF EXISTS public.inventory_historicalproduct_history_date_3e1a739c;
DROP INDEX IF EXISTS public.inventory_historicalproduct_barcode_0480f0ce_like;
DROP INDEX IF EXISTS public.inventory_historicalproduct_barcode_0480f0ce;
DROP INDEX IF EXISTS public.django_site_domain_a2e37b91_like;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_celery_beat_periodictask_solar_id_a87ce72c;
DROP INDEX IF EXISTS public.django_celery_beat_periodictask_name_265a36b7_like;
DROP INDEX IF EXISTS public.django_celery_beat_periodictask_interval_id_a8ca27da;
DROP INDEX IF EXISTS public.django_celery_beat_periodictask_crontab_id_d3cba168;
DROP INDEX IF EXISTS public.django_celery_beat_periodictask_clocked_id_47a69f82;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.core_releasecode_used_by_id_f6b72843;
DROP INDEX IF EXISTS public.core_releasecode_created_by_id_995a897d;
DROP INDEX IF EXISTS public.core_releasecode_code_f093d73a_like;
DROP INDEX IF EXISTS public.core_historicalreleasecode_used_by_id_9e7efa8c;
DROP INDEX IF EXISTS public.core_historicalreleasecode_id_4dafc17f;
DROP INDEX IF EXISTS public.core_historicalreleasecode_history_user_id_5a170592;
DROP INDEX IF EXISTS public.core_historicalreleasecode_history_date_1a3ceecd;
DROP INDEX IF EXISTS public.core_historicalreleasecode_created_by_id_e53b4cfd;
DROP INDEX IF EXISTS public.core_historicalreleasecode_code_094fdfad_like;
DROP INDEX IF EXISTS public.core_historicalreleasecode_code_094fdfad;
DROP INDEX IF EXISTS public.core_historicalexpense_recorded_by_id_5d1312b3;
DROP INDEX IF EXISTS public.core_historicalexpense_id_574d74eb;
DROP INDEX IF EXISTS public.core_historicalexpense_history_user_id_ed5edfa1;
DROP INDEX IF EXISTS public.core_historicalexpense_history_date_f822ea07;
DROP INDEX IF EXISTS public.core_historicalexpense_category_id_2a0e38a9;
DROP INDEX IF EXISTS public.core_historicalaudittestmodel_id_34ee7607;
DROP INDEX IF EXISTS public.core_historicalaudittestmodel_history_user_id_18c8e9f9;
DROP INDEX IF EXISTS public.core_historicalaudittestmodel_history_date_ee6441df;
DROP INDEX IF EXISTS public.core_expensecategory_name_aaa0c3d3_like;
DROP INDEX IF EXISTS public.core_expense_recorded_by_id_b2fff93e;
DROP INDEX IF EXISTS public.core_expense_category_id_dcdb74b3;
DROP INDEX IF EXISTS public.communications_whatsappnotification_sale_id_7ad31ee7;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
DROP INDEX IF EXISTS public.account_emailconfirmation_key_f43612bd_like;
DROP INDEX IF EXISTS public.account_emailconfirmation_email_address_id_5b7f8c58;
DROP INDEX IF EXISTS public.account_emailaddress_user_id_2c513194;
DROP INDEX IF EXISTS public.account_emailaddress_email_03be32b2_like;
DROP INDEX IF EXISTS public.account_emailaddress_email_03be32b2;
ALTER TABLE IF EXISTS ONLY public.users_user DROP CONSTRAINT IF EXISTS users_user_username_key;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_user_id_permission_id_43338c45_uniq;
ALTER TABLE IF EXISTS ONLY public.users_user_user_permissions DROP CONSTRAINT IF EXISTS users_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.users_user DROP CONSTRAINT IF EXISTS users_user_pkey;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_user_id_group_id_b88eab82_uniq;
ALTER TABLE IF EXISTS ONLY public.users_user_groups DROP CONSTRAINT IF EXISTS users_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialtoken DROP CONSTRAINT IF EXISTS socialaccount_socialtoken_pkey;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialtoken DROP CONSTRAINT IF EXISTS socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialapp_sites DROP CONSTRAINT IF EXISTS socialaccount_socialapp_sites_pkey;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialapp DROP CONSTRAINT IF EXISTS socialaccount_socialapp_pkey;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialapp_sites DROP CONSTRAINT IF EXISTS socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialaccount DROP CONSTRAINT IF EXISTS socialaccount_socialaccount_provider_uid_fc810c6e_uniq;
ALTER TABLE IF EXISTS ONLY public.socialaccount_socialaccount DROP CONSTRAINT IF EXISTS socialaccount_socialaccount_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_saleitem DROP CONSTRAINT IF EXISTS sales_saleitem_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_sale DROP CONSTRAINT IF EXISTS sales_sale_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_sale DROP CONSTRAINT IF EXISTS sales_sale_invoice_number_key;
ALTER TABLE IF EXISTS ONLY public.sales_payment DROP CONSTRAINT IF EXISTS sales_payment_reference_key;
ALTER TABLE IF EXISTS ONLY public.sales_payment DROP CONSTRAINT IF EXISTS sales_payment_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_historicalsaleitem DROP CONSTRAINT IF EXISTS sales_historicalsaleitem_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_historicalsale DROP CONSTRAINT IF EXISTS sales_historicalsale_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_historicalpayment DROP CONSTRAINT IF EXISTS sales_historicalpayment_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_historicalcustomer DROP CONSTRAINT IF EXISTS sales_historicalcustomer_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_customer DROP CONSTRAINT IF EXISTS sales_customer_pkey;
ALTER TABLE IF EXISTS ONLY public.mfa_authenticator DROP CONSTRAINT IF EXISTS mfa_authenticator_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_warehouse DROP CONSTRAINT IF EXISTS inventory_warehouse_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_stocktransaction DROP CONSTRAINT IF EXISTS inventory_stocktransaction_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_product DROP CONSTRAINT IF EXISTS inventory_product_sku_key;
ALTER TABLE IF EXISTS ONLY public.inventory_product DROP CONSTRAINT IF EXISTS inventory_product_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_product DROP CONSTRAINT IF EXISTS inventory_product_barcode_key;
ALTER TABLE IF EXISTS ONLY public.inventory_historicalwarehouse DROP CONSTRAINT IF EXISTS inventory_historicalwarehouse_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_historicalstocktransaction DROP CONSTRAINT IF EXISTS inventory_historicalstocktransaction_pkey;
ALTER TABLE IF EXISTS ONLY public.inventory_historicalproduct DROP CONSTRAINT IF EXISTS inventory_historicalproduct_pkey;
ALTER TABLE IF EXISTS ONLY public.django_site DROP CONSTRAINT IF EXISTS django_site_pkey;
ALTER TABLE IF EXISTS ONLY public.django_site DROP CONSTRAINT IF EXISTS django_site_domain_a2e37b91_uniq;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_solarschedule DROP CONSTRAINT IF EXISTS django_celery_beat_solarschedule_pkey;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_solarschedule DROP CONSTRAINT IF EXISTS django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_periodictasks DROP CONSTRAINT IF EXISTS django_celery_beat_periodictasks_pkey;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_periodictask DROP CONSTRAINT IF EXISTS django_celery_beat_periodictask_pkey;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_periodictask DROP CONSTRAINT IF EXISTS django_celery_beat_periodictask_name_key;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_intervalschedule DROP CONSTRAINT IF EXISTS django_celery_beat_intervalschedule_pkey;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_crontabschedule DROP CONSTRAINT IF EXISTS django_celery_beat_crontabschedule_pkey;
ALTER TABLE IF EXISTS ONLY public.django_celery_beat_clockedschedule DROP CONSTRAINT IF EXISTS django_celery_beat_clockedschedule_pkey;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.core_releasecode DROP CONSTRAINT IF EXISTS core_releasecode_pkey;
ALTER TABLE IF EXISTS ONLY public.core_releasecode DROP CONSTRAINT IF EXISTS core_releasecode_code_key;
ALTER TABLE IF EXISTS ONLY public.core_historicalreleasecode DROP CONSTRAINT IF EXISTS core_historicalreleasecode_pkey;
ALTER TABLE IF EXISTS ONLY public.core_historicalexpense DROP CONSTRAINT IF EXISTS core_historicalexpense_pkey;
ALTER TABLE IF EXISTS ONLY public.core_historicalaudittestmodel DROP CONSTRAINT IF EXISTS core_historicalaudittestmodel_pkey;
ALTER TABLE IF EXISTS ONLY public.core_expensecategory DROP CONSTRAINT IF EXISTS core_expensecategory_pkey;
ALTER TABLE IF EXISTS ONLY public.core_expensecategory DROP CONSTRAINT IF EXISTS core_expensecategory_name_key;
ALTER TABLE IF EXISTS ONLY public.core_expense DROP CONSTRAINT IF EXISTS core_expense_pkey;
ALTER TABLE IF EXISTS ONLY public.core_databasebackup DROP CONSTRAINT IF EXISTS core_databasebackup_pkey;
ALTER TABLE IF EXISTS ONLY public.core_audittestmodel DROP CONSTRAINT IF EXISTS core_audittestmodel_pkey;
ALTER TABLE IF EXISTS ONLY public.communications_whatsappnotification DROP CONSTRAINT IF EXISTS communications_whatsappnotification_token_key;
ALTER TABLE IF EXISTS ONLY public.communications_whatsappnotification DROP CONSTRAINT IF EXISTS communications_whatsappnotification_pkey;
ALTER TABLE IF EXISTS ONLY public.communications_dailyreport DROP CONSTRAINT IF EXISTS communications_dailyreport_token_key;
ALTER TABLE IF EXISTS ONLY public.communications_dailyreport DROP CONSTRAINT IF EXISTS communications_dailyreport_pkey;
ALTER TABLE IF EXISTS ONLY public.communications_dailyreport DROP CONSTRAINT IF EXISTS communications_dailyreport_date_key;
ALTER TABLE IF EXISTS ONLY public.communications_communicationconfig DROP CONSTRAINT IF EXISTS communications_communicationconfig_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
ALTER TABLE IF EXISTS ONLY public.account_emailconfirmation DROP CONSTRAINT IF EXISTS account_emailconfirmation_pkey;
ALTER TABLE IF EXISTS ONLY public.account_emailconfirmation DROP CONSTRAINT IF EXISTS account_emailconfirmation_key_key;
ALTER TABLE IF EXISTS ONLY public.account_emailaddress DROP CONSTRAINT IF EXISTS account_emailaddress_user_id_email_987c8728_uniq;
ALTER TABLE IF EXISTS ONLY public.account_emailaddress DROP CONSTRAINT IF EXISTS account_emailaddress_pkey;
DROP TABLE IF EXISTS public.users_user_user_permissions;
DROP TABLE IF EXISTS public.users_user_groups;
DROP TABLE IF EXISTS public.users_user;
DROP TABLE IF EXISTS public.socialaccount_socialtoken;
DROP TABLE IF EXISTS public.socialaccount_socialapp_sites;
DROP TABLE IF EXISTS public.socialaccount_socialapp;
DROP TABLE IF EXISTS public.socialaccount_socialaccount;
DROP TABLE IF EXISTS public.sales_saleitem;
DROP TABLE IF EXISTS public.sales_sale;
DROP TABLE IF EXISTS public.sales_payment;
DROP TABLE IF EXISTS public.sales_historicalsaleitem;
DROP TABLE IF EXISTS public.sales_historicalsale;
DROP TABLE IF EXISTS public.sales_historicalpayment;
DROP TABLE IF EXISTS public.sales_historicalcustomer;
DROP TABLE IF EXISTS public.sales_customer;
DROP TABLE IF EXISTS public.mfa_authenticator;
DROP TABLE IF EXISTS public.inventory_warehouse;
DROP TABLE IF EXISTS public.inventory_stocktransaction;
DROP TABLE IF EXISTS public.inventory_product;
DROP TABLE IF EXISTS public.inventory_historicalwarehouse;
DROP TABLE IF EXISTS public.inventory_historicalstocktransaction;
DROP TABLE IF EXISTS public.inventory_historicalproduct;
DROP TABLE IF EXISTS public.django_site;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_celery_beat_solarschedule;
DROP TABLE IF EXISTS public.django_celery_beat_periodictasks;
DROP TABLE IF EXISTS public.django_celery_beat_periodictask;
DROP TABLE IF EXISTS public.django_celery_beat_intervalschedule;
DROP TABLE IF EXISTS public.django_celery_beat_crontabschedule;
DROP TABLE IF EXISTS public.django_celery_beat_clockedschedule;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.core_releasecode;
DROP TABLE IF EXISTS public.core_historicalreleasecode;
DROP TABLE IF EXISTS public.core_historicalexpense;
DROP TABLE IF EXISTS public.core_historicalaudittestmodel;
DROP TABLE IF EXISTS public.core_expensecategory;
DROP TABLE IF EXISTS public.core_expense;
DROP TABLE IF EXISTS public.core_databasebackup;
DROP TABLE IF EXISTS public.core_audittestmodel;
DROP TABLE IF EXISTS public.communications_whatsappnotification;
DROP TABLE IF EXISTS public.communications_dailyreport;
DROP TABLE IF EXISTS public.communications_communicationconfig;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
DROP TABLE IF EXISTS public.account_emailconfirmation;
DROP TABLE IF EXISTS public.account_emailaddress;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO maliandevboy;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.account_emailaddress ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO maliandevboy;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.account_emailconfirmation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO maliandevboy;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO maliandevboy;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO maliandevboy;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: communications_communicationconfig; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.communications_communicationconfig (
    id bigint NOT NULL,
    manager_phone_1 character varying(20) NOT NULL,
    manager_phone_2 character varying(20),
    link_validity_hours integer NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    erp_version character varying(20) NOT NULL,
    report_time time without time zone NOT NULL,
    wachap_instance_id character varying(100) NOT NULL,
    wachap_token character varying(255) NOT NULL,
    CONSTRAINT communications_communicationconfig_link_validity_hours_check CHECK ((link_validity_hours >= 0))
);


ALTER TABLE public.communications_communicationconfig OWNER TO maliandevboy;

--
-- Name: communications_communicationconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.communications_communicationconfig ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.communications_communicationconfig_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: communications_dailyreport; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.communications_dailyreport (
    id bigint NOT NULL,
    date date NOT NULL,
    token uuid NOT NULL,
    total_sales integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    CONSTRAINT communications_dailyreport_total_sales_check CHECK ((total_sales >= 0))
);


ALTER TABLE public.communications_dailyreport OWNER TO maliandevboy;

--
-- Name: communications_dailyreport_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.communications_dailyreport ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.communications_dailyreport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: communications_whatsappnotification; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.communications_whatsappnotification (
    id bigint NOT NULL,
    phone character varying(20) NOT NULL,
    status character varying(20) NOT NULL,
    token uuid NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    message_id character varying(100),
    error_log text,
    retry_count integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    sent_at timestamp with time zone,
    sale_id bigint NOT NULL,
    CONSTRAINT communications_whatsappnotification_retry_count_check CHECK ((retry_count >= 0))
);


ALTER TABLE public.communications_whatsappnotification OWNER TO maliandevboy;

--
-- Name: communications_whatsappnotification_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.communications_whatsappnotification ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.communications_whatsappnotification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_audittestmodel; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.core_audittestmodel (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.core_audittestmodel OWNER TO maliandevboy;

--
-- Name: core_audittestmodel_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.core_audittestmodel ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_audittestmodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_databasebackup; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.core_databasebackup (
    id bigint NOT NULL,
    file character varying(100) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    backup_type character varying(10) NOT NULL,
    file_size integer NOT NULL,
    CONSTRAINT core_databasebackup_file_size_check CHECK ((file_size >= 0))
);


ALTER TABLE public.core_databasebackup OWNER TO maliandevboy;

--
-- Name: core_databasebackup_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.core_databasebackup ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_databasebackup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_expense; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.core_expense (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    amount integer NOT NULL,
    date date NOT NULL,
    notes text NOT NULL,
    receipt character varying(100),
    created_at timestamp with time zone NOT NULL,
    recorded_by_id bigint,
    category_id bigint NOT NULL,
    CONSTRAINT core_expense_amount_check CHECK ((amount >= 0))
);


ALTER TABLE public.core_expense OWNER TO maliandevboy;

--
-- Name: core_expense_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.core_expense ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_expense_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_expensecategory; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.core_expensecategory (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.core_expensecategory OWNER TO maliandevboy;

--
-- Name: core_expensecategory_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.core_expensecategory ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_expensecategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_historicalaudittestmodel; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.core_historicalaudittestmodel (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id bigint
);


ALTER TABLE public.core_historicalaudittestmodel OWNER TO maliandevboy;

--
-- Name: core_historicalaudittestmodel_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.core_historicalaudittestmodel ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_historicalaudittestmodel_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_historicalexpense; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.core_historicalexpense (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    amount integer NOT NULL,
    date date NOT NULL,
    notes text NOT NULL,
    receipt text,
    created_at timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    category_id bigint,
    history_user_id bigint,
    recorded_by_id bigint,
    CONSTRAINT core_historicalexpense_amount_check CHECK ((amount >= 0))
);


ALTER TABLE public.core_historicalexpense OWNER TO maliandevboy;

--
-- Name: core_historicalexpense_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.core_historicalexpense ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_historicalexpense_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_historicalreleasecode; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.core_historicalreleasecode (
    id bigint NOT NULL,
    code character varying(10) NOT NULL,
    operation_type character varying(20) NOT NULL,
    is_used boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    used_at timestamp with time zone,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    created_by_id bigint,
    history_user_id bigint,
    used_by_id bigint
);


ALTER TABLE public.core_historicalreleasecode OWNER TO maliandevboy;

--
-- Name: core_historicalreleasecode_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.core_historicalreleasecode ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_historicalreleasecode_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: core_releasecode; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.core_releasecode (
    id bigint NOT NULL,
    code character varying(10) NOT NULL,
    operation_type character varying(20) NOT NULL,
    is_used boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    used_at timestamp with time zone,
    created_by_id bigint,
    used_by_id bigint
);


ALTER TABLE public.core_releasecode OWNER TO maliandevboy;

--
-- Name: core_releasecode_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.core_releasecode ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.core_releasecode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO maliandevboy;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_clockedschedule; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_celery_beat_clockedschedule (
    id integer NOT NULL,
    clocked_time timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_clockedschedule OWNER TO maliandevboy;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_celery_beat_clockedschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_celery_beat_clockedschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_crontabschedule; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_celery_beat_crontabschedule (
    id integer NOT NULL,
    minute character varying(240) NOT NULL,
    hour character varying(96) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(124) NOT NULL,
    month_of_year character varying(64) NOT NULL,
    timezone character varying(63) NOT NULL
);


ALTER TABLE public.django_celery_beat_crontabschedule OWNER TO maliandevboy;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_celery_beat_crontabschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_celery_beat_crontabschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_intervalschedule; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_celery_beat_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE public.django_celery_beat_intervalschedule OWNER TO maliandevboy;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_celery_beat_intervalschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_celery_beat_intervalschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_periodictask; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_celery_beat_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    solar_id integer,
    one_off boolean NOT NULL,
    start_time timestamp with time zone,
    priority integer,
    headers text NOT NULL,
    clocked_id integer,
    expire_seconds integer,
    CONSTRAINT django_celery_beat_periodictask_expire_seconds_check CHECK ((expire_seconds >= 0)),
    CONSTRAINT django_celery_beat_periodictask_priority_check CHECK ((priority >= 0)),
    CONSTRAINT django_celery_beat_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE public.django_celery_beat_periodictask OWNER TO maliandevboy;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_celery_beat_periodictask ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_celery_beat_periodictask_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_periodictasks; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_celery_beat_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_periodictasks OWNER TO maliandevboy;

--
-- Name: django_celery_beat_solarschedule; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_celery_beat_solarschedule (
    id integer NOT NULL,
    event character varying(24) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);


ALTER TABLE public.django_celery_beat_solarschedule OWNER TO maliandevboy;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_celery_beat_solarschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_celery_beat_solarschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO maliandevboy;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO maliandevboy;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO maliandevboy;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO maliandevboy;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.django_site ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_historicalproduct; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.inventory_historicalproduct (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    sku character varying(50) NOT NULL,
    barcode character varying(100),
    purchase_price integer NOT NULL,
    sale_price_piece integer NOT NULL,
    sale_price_carton integer NOT NULL,
    conversion_factor integer NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id bigint,
    low_stock_threshold integer NOT NULL,
    alert_threshold_cartons integer,
    alert_threshold_pieces integer,
    CONSTRAINT inventory_historicalproduct_alert_threshold_cartons_check CHECK ((alert_threshold_cartons >= 0)),
    CONSTRAINT inventory_historicalproduct_alert_threshold_pieces_check CHECK ((alert_threshold_pieces >= 0)),
    CONSTRAINT inventory_historicalproduct_conversion_factor_check CHECK ((conversion_factor >= 0)),
    CONSTRAINT inventory_historicalproduct_low_stock_threshold_check CHECK ((low_stock_threshold >= 0)),
    CONSTRAINT inventory_historicalproduct_purchase_price_check CHECK ((purchase_price >= 0)),
    CONSTRAINT inventory_historicalproduct_sale_price_carton_check CHECK ((sale_price_carton >= 0)),
    CONSTRAINT inventory_historicalproduct_sale_price_piece_check CHECK ((sale_price_piece >= 0))
);


ALTER TABLE public.inventory_historicalproduct OWNER TO maliandevboy;

--
-- Name: inventory_historicalproduct_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.inventory_historicalproduct ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_historicalproduct_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_historicalstocktransaction; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.inventory_historicalstocktransaction (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    type character varying(10) NOT NULL,
    notes text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id bigint,
    product_id bigint,
    warehouse_id bigint,
    to_warehouse_id bigint
);


ALTER TABLE public.inventory_historicalstocktransaction OWNER TO maliandevboy;

--
-- Name: inventory_historicalstocktransaction_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.inventory_historicalstocktransaction ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_historicalstocktransaction_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_historicalwarehouse; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.inventory_historicalwarehouse (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id bigint
);


ALTER TABLE public.inventory_historicalwarehouse OWNER TO maliandevboy;

--
-- Name: inventory_historicalwarehouse_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.inventory_historicalwarehouse ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_historicalwarehouse_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_product; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.inventory_product (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    sku character varying(50) NOT NULL,
    barcode character varying(100),
    purchase_price integer NOT NULL,
    sale_price_piece integer NOT NULL,
    sale_price_carton integer NOT NULL,
    conversion_factor integer NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    low_stock_threshold integer NOT NULL,
    alert_threshold_cartons integer,
    alert_threshold_pieces integer,
    CONSTRAINT inventory_product_alert_threshold_cartons_check CHECK ((alert_threshold_cartons >= 0)),
    CONSTRAINT inventory_product_alert_threshold_pieces_check CHECK ((alert_threshold_pieces >= 0)),
    CONSTRAINT inventory_product_conversion_factor_check CHECK ((conversion_factor >= 0)),
    CONSTRAINT inventory_product_low_stock_threshold_check CHECK ((low_stock_threshold >= 0)),
    CONSTRAINT inventory_product_purchase_price_check CHECK ((purchase_price >= 0)),
    CONSTRAINT inventory_product_sale_price_carton_check CHECK ((sale_price_carton >= 0)),
    CONSTRAINT inventory_product_sale_price_piece_check CHECK ((sale_price_piece >= 0))
);


ALTER TABLE public.inventory_product OWNER TO maliandevboy;

--
-- Name: inventory_product_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.inventory_product ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_stocktransaction; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.inventory_stocktransaction (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    type character varying(10) NOT NULL,
    notes text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    product_id bigint NOT NULL,
    warehouse_id bigint NOT NULL,
    to_warehouse_id bigint
);


ALTER TABLE public.inventory_stocktransaction OWNER TO maliandevboy;

--
-- Name: inventory_stocktransaction_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.inventory_stocktransaction ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_stocktransaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_warehouse; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.inventory_warehouse (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.inventory_warehouse OWNER TO maliandevboy;

--
-- Name: inventory_warehouse_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.inventory_warehouse ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_warehouse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: mfa_authenticator; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.mfa_authenticator (
    id bigint NOT NULL,
    type character varying(20) NOT NULL,
    data jsonb NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE public.mfa_authenticator OWNER TO maliandevboy;

--
-- Name: mfa_authenticator_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.mfa_authenticator ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.mfa_authenticator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_customer; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.sales_customer (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(20),
    address text,
    balance integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.sales_customer OWNER TO maliandevboy;

--
-- Name: sales_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.sales_customer ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sales_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_historicalcustomer; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.sales_historicalcustomer (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(20),
    address text,
    balance integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id bigint
);


ALTER TABLE public.sales_historicalcustomer OWNER TO maliandevboy;

--
-- Name: sales_historicalcustomer_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.sales_historicalcustomer ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sales_historicalcustomer_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_historicalpayment; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.sales_historicalpayment (
    id bigint NOT NULL,
    amount integer NOT NULL,
    payment_method character varying(20) NOT NULL,
    reference character varying(50) NOT NULL,
    notes text NOT NULL,
    balance_after integer,
    created_at timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    customer_id bigint,
    history_user_id bigint,
    received_by_id bigint,
    CONSTRAINT sales_historicalpayment_amount_check CHECK ((amount >= 0))
);


ALTER TABLE public.sales_historicalpayment OWNER TO maliandevboy;

--
-- Name: sales_historicalpayment_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.sales_historicalpayment ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sales_historicalpayment_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_historicalsale; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.sales_historicalsale (
    id bigint NOT NULL,
    invoice_number character varying(50) NOT NULL,
    type character varying(10) NOT NULL,
    total_amount integer NOT NULL,
    payment_method character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id bigint,
    seller_id bigint,
    status character varying(20) NOT NULL,
    customer_phone character varying(20),
    customer_id bigint,
    customer_name character varying(255),
    notes text NOT NULL
);


ALTER TABLE public.sales_historicalsale OWNER TO maliandevboy;

--
-- Name: sales_historicalsale_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.sales_historicalsale ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sales_historicalsale_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_historicalsaleitem; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.sales_historicalsaleitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    unit character varying(10) NOT NULL,
    unit_price integer NOT NULL,
    total_line integer NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id bigint,
    product_id bigint,
    sale_id bigint,
    CONSTRAINT sales_historicalsaleitem_quantity_check CHECK ((quantity >= 0)),
    CONSTRAINT sales_historicalsaleitem_total_line_check CHECK ((total_line >= 0)),
    CONSTRAINT sales_historicalsaleitem_unit_price_check CHECK ((unit_price >= 0))
);


ALTER TABLE public.sales_historicalsaleitem OWNER TO maliandevboy;

--
-- Name: sales_historicalsaleitem_history_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.sales_historicalsaleitem ALTER COLUMN history_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sales_historicalsaleitem_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_payment; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.sales_payment (
    id bigint NOT NULL,
    amount integer NOT NULL,
    payment_method character varying(20) NOT NULL,
    reference character varying(50) NOT NULL,
    notes text NOT NULL,
    balance_after integer,
    created_at timestamp with time zone NOT NULL,
    customer_id bigint NOT NULL,
    received_by_id bigint,
    CONSTRAINT sales_payment_amount_check CHECK ((amount >= 0))
);


ALTER TABLE public.sales_payment OWNER TO maliandevboy;

--
-- Name: sales_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.sales_payment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sales_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_sale; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.sales_sale (
    id bigint NOT NULL,
    invoice_number character varying(50) NOT NULL,
    type character varying(10) NOT NULL,
    total_amount integer NOT NULL,
    payment_method character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    seller_id bigint,
    status character varying(20) NOT NULL,
    customer_phone character varying(20),
    customer_id bigint,
    customer_name character varying(255),
    notes text NOT NULL
);


ALTER TABLE public.sales_sale OWNER TO maliandevboy;

--
-- Name: sales_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.sales_sale ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sales_sale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sales_saleitem; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.sales_saleitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    unit character varying(10) NOT NULL,
    unit_price integer NOT NULL,
    total_line integer NOT NULL,
    product_id bigint NOT NULL,
    sale_id bigint NOT NULL,
    CONSTRAINT sales_saleitem_quantity_check CHECK ((quantity >= 0)),
    CONSTRAINT sales_saleitem_total_line_check CHECK ((total_line >= 0)),
    CONSTRAINT sales_saleitem_unit_price_check CHECK ((unit_price >= 0))
);


ALTER TABLE public.sales_saleitem OWNER TO maliandevboy;

--
-- Name: sales_saleitem_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.sales_saleitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sales_saleitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(200) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data jsonb NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO maliandevboy;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.socialaccount_socialaccount ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL,
    provider_id character varying(200) NOT NULL,
    settings jsonb NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO maliandevboy;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.socialaccount_socialapp ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.socialaccount_socialapp_sites (
    id bigint NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO maliandevboy;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.socialaccount_socialapp_sites ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO maliandevboy;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.socialaccount_socialtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.users_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL,
    role character varying(10) NOT NULL,
    assigned_warehouse_id bigint
);


ALTER TABLE public.users_user OWNER TO maliandevboy;

--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.users_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_user_groups OWNER TO maliandevboy;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.users_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.users_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: maliandevboy
--

CREATE TABLE public.users_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_user_permissions OWNER TO maliandevboy;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: maliandevboy
--

ALTER TABLE public.users_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
1	admin@erp-sylla.com	f	f	1
\.


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.auth_group (id, name) FROM stdin;
1	Gérants
2	Vendeurs
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	77
2	1	78
3	1	79
4	1	80
5	2	80
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	2	add_permission
2	Can change permission	2	change_permission
3	Can delete permission	2	delete_permission
4	Can view permission	2	view_permission
5	Can add group	1	add_group
6	Can change group	1	change_group
7	Can delete group	1	delete_group
8	Can view group	1	view_group
9	Can add content type	3	add_contenttype
10	Can change content type	3	change_contenttype
11	Can delete content type	3	delete_contenttype
12	Can view content type	3	view_contenttype
13	Can add session	4	add_session
14	Can change session	4	change_session
15	Can delete session	4	delete_session
16	Can view session	4	view_session
17	Can add site	5	add_site
18	Can change site	5	change_site
19	Can delete site	5	delete_site
20	Can view site	5	view_site
21	Can add log entry	6	add_logentry
22	Can change log entry	6	change_logentry
23	Can delete log entry	6	delete_logentry
24	Can view log entry	6	view_logentry
25	Can add email address	7	add_emailaddress
26	Can change email address	7	change_emailaddress
27	Can delete email address	7	delete_emailaddress
28	Can view email address	7	view_emailaddress
29	Can add email confirmation	8	add_emailconfirmation
30	Can change email confirmation	8	change_emailconfirmation
31	Can delete email confirmation	8	delete_emailconfirmation
32	Can view email confirmation	8	view_emailconfirmation
33	Can add authenticator	9	add_authenticator
34	Can change authenticator	9	change_authenticator
35	Can delete authenticator	9	delete_authenticator
36	Can view authenticator	9	view_authenticator
37	Can add social account	10	add_socialaccount
38	Can change social account	10	change_socialaccount
39	Can delete social account	10	delete_socialaccount
40	Can view social account	10	view_socialaccount
41	Can add social application	11	add_socialapp
42	Can change social application	11	change_socialapp
43	Can delete social application	11	delete_socialapp
44	Can view social application	11	view_socialapp
45	Can add social application token	12	add_socialtoken
46	Can change social application token	12	change_socialtoken
47	Can delete social application token	12	delete_socialtoken
48	Can view social application token	12	view_socialtoken
49	Can add crontab	14	add_crontabschedule
50	Can change crontab	14	change_crontabschedule
51	Can delete crontab	14	delete_crontabschedule
52	Can view crontab	14	view_crontabschedule
53	Can add interval	15	add_intervalschedule
54	Can change interval	15	change_intervalschedule
55	Can delete interval	15	delete_intervalschedule
56	Can view interval	15	view_intervalschedule
57	Can add periodic task	16	add_periodictask
58	Can change periodic task	16	change_periodictask
59	Can delete periodic task	16	delete_periodictask
60	Can view periodic task	16	view_periodictask
61	Can add periodic task track	17	add_periodictasks
62	Can change periodic task track	17	change_periodictasks
63	Can delete periodic task track	17	delete_periodictasks
64	Can view periodic task track	17	view_periodictasks
65	Can add solar event	18	add_solarschedule
66	Can change solar event	18	change_solarschedule
67	Can delete solar event	18	delete_solarschedule
68	Can view solar event	18	view_solarschedule
69	Can add clocked	13	add_clockedschedule
70	Can change clocked	13	change_clockedschedule
71	Can delete clocked	13	delete_clockedschedule
72	Can view clocked	13	view_clockedschedule
73	Can add user	19	add_user
74	Can change user	19	change_user
75	Can delete user	19	delete_user
76	Can view user	19	view_user
77	Can add Modèle d'Audit Test	20	add_audittestmodel
78	Can change Modèle d'Audit Test	20	change_audittestmodel
79	Can delete Modèle d'Audit Test	20	delete_audittestmodel
80	Can view Modèle d'Audit Test	20	view_audittestmodel
81	Can add historical Modèle d'Audit Test	21	add_historicalaudittestmodel
82	Can change historical Modèle d'Audit Test	21	change_historicalaudittestmodel
83	Can delete historical Modèle d'Audit Test	21	delete_historicalaudittestmodel
84	Can view historical Modèle d'Audit Test	21	view_historicalaudittestmodel
85	Can add Article	23	add_product
86	Can change Article	23	change_product
87	Can delete Article	23	delete_product
88	Can view Article	23	view_product
89	Can add historical Article	22	add_historicalproduct
90	Can change historical Article	22	change_historicalproduct
91	Can delete historical Article	22	delete_historicalproduct
92	Can view historical Article	22	view_historicalproduct
93	Can add Entrepôt	27	add_warehouse
94	Can change Entrepôt	27	change_warehouse
95	Can delete Entrepôt	27	delete_warehouse
96	Can view Entrepôt	27	view_warehouse
97	Can add historical Entrepôt	25	add_historicalwarehouse
98	Can change historical Entrepôt	25	change_historicalwarehouse
99	Can delete historical Entrepôt	25	delete_historicalwarehouse
100	Can view historical Entrepôt	25	view_historicalwarehouse
101	Can add Mouvement de stock	26	add_stocktransaction
102	Can change Mouvement de stock	26	change_stocktransaction
103	Can delete Mouvement de stock	26	delete_stocktransaction
104	Can view Mouvement de stock	26	view_stocktransaction
105	Can add historical Mouvement de stock	24	add_historicalstocktransaction
106	Can change historical Mouvement de stock	24	change_historicalstocktransaction
107	Can delete historical Mouvement de stock	24	delete_historicalstocktransaction
108	Can view historical Mouvement de stock	24	view_historicalstocktransaction
109	Can add sale item	30	add_saleitem
110	Can change sale item	30	change_saleitem
111	Can delete sale item	30	delete_saleitem
112	Can view sale item	30	view_saleitem
113	Can add historical Vente	28	add_historicalsale
114	Can change historical Vente	28	change_historicalsale
115	Can delete historical Vente	28	delete_historicalsale
116	Can view historical Vente	28	view_historicalsale
117	Can add Vente	29	add_sale
118	Can change Vente	29	change_sale
119	Can delete Vente	29	delete_sale
120	Can view Vente	29	view_sale
121	Can add historical Code de déblocage	31	add_historicalreleasecode
122	Can change historical Code de déblocage	31	change_historicalreleasecode
123	Can delete historical Code de déblocage	31	delete_historicalreleasecode
124	Can view historical Code de déblocage	31	view_historicalreleasecode
125	Can add Code de déblocage	32	add_releasecode
126	Can change Code de déblocage	32	change_releasecode
127	Can delete Code de déblocage	32	delete_releasecode
128	Can view Code de déblocage	32	view_releasecode
129	Can add Configuration Communication	33	add_communicationconfig
130	Can change Configuration Communication	33	change_communicationconfig
131	Can delete Configuration Communication	33	delete_communicationconfig
132	Can view Configuration Communication	33	view_communicationconfig
133	Can add Notification WhatsApp	34	add_whatsappnotification
134	Can change Notification WhatsApp	34	change_whatsappnotification
135	Can delete Notification WhatsApp	34	delete_whatsappnotification
136	Can view Notification WhatsApp	34	view_whatsappnotification
137	Can add Rapport Journalier	35	add_dailyreport
138	Can change Rapport Journalier	35	change_dailyreport
139	Can delete Rapport Journalier	35	delete_dailyreport
140	Can view Rapport Journalier	35	view_dailyreport
141	Can add historical Client	37	add_historicalcustomer
142	Can change historical Client	37	change_historicalcustomer
143	Can delete historical Client	37	delete_historicalcustomer
144	Can view historical Client	37	view_historicalcustomer
145	Can add Client	36	add_customer
146	Can change Client	36	change_customer
147	Can delete Client	36	delete_customer
148	Can view Client	36	view_customer
149	Can add historical Paiement Client	38	add_historicalpayment
150	Can change historical Paiement Client	38	change_historicalpayment
151	Can delete historical Paiement Client	38	delete_historicalpayment
152	Can view historical Paiement Client	38	view_historicalpayment
153	Can add historical Ligne de vente	39	add_historicalsaleitem
154	Can change historical Ligne de vente	39	change_historicalsaleitem
155	Can delete historical Ligne de vente	39	delete_historicalsaleitem
156	Can view historical Ligne de vente	39	view_historicalsaleitem
157	Can add Paiement Client	40	add_payment
158	Can change Paiement Client	40	change_payment
159	Can delete Paiement Client	40	delete_payment
160	Can view Paiement Client	40	view_payment
161	Can add Catégorie de dépense	42	add_expensecategory
162	Can change Catégorie de dépense	42	change_expensecategory
163	Can delete Catégorie de dépense	42	delete_expensecategory
164	Can view Catégorie de dépense	42	view_expensecategory
165	Can add Dépense	41	add_expense
166	Can change Dépense	41	change_expense
167	Can delete Dépense	41	delete_expense
168	Can view Dépense	41	view_expense
169	Can add historical Dépense	43	add_historicalexpense
170	Can change historical Dépense	43	change_historicalexpense
171	Can delete historical Dépense	43	delete_historicalexpense
172	Can view historical Dépense	43	view_historicalexpense
173	Can add Sauvegarde	44	add_databasebackup
174	Can change Sauvegarde	44	change_databasebackup
175	Can delete Sauvegarde	44	delete_databasebackup
176	Can view Sauvegarde	44	view_databasebackup
\.


--
-- Data for Name: communications_communicationconfig; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.communications_communicationconfig (id, manager_phone_1, manager_phone_2, link_validity_hours, updated_at, erp_version, report_time, wachap_instance_id, wachap_token) FROM stdin;
1		\N	48	2026-04-16 21:52:31.85036+00	v1.2.0	20:00:00		
\.


--
-- Data for Name: communications_dailyreport; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.communications_dailyreport (id, date, token, total_sales, created_at) FROM stdin;
\.


--
-- Data for Name: communications_whatsappnotification; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.communications_whatsappnotification (id, phone, status, token, expires_at, message_id, error_log, retry_count, created_at, sent_at, sale_id) FROM stdin;
1	+22376541852	PENDING	18311550-3fe2-4864-8fb6-ed7c4bd51e45	2026-04-20 19:43:50.63219+00	\N	\N	0	2026-04-18 19:43:50.639244+00	\N	12
2	+22373457616	PENDING	cad893f5-7b80-42be-9ef5-0face0588817	2026-04-22 11:08:41.937145+00	\N	\N	0	2026-04-20 11:08:41.944311+00	\N	16
3	+22373457616	PENDING	eba2bef6-9e01-4744-89d9-c06f2dd510ec	2026-04-22 12:37:34.751778+00	\N	\N	0	2026-04-20 12:37:34.756235+00	\N	18
4	+22390877889	PENDING	f8c30436-8e9a-46f2-93e6-9f10a8f67e4f	2026-04-22 12:38:11.31708+00	\N	\N	0	2026-04-20 12:38:11.320649+00	\N	19
5	+22390877889	PENDING	ec498796-fd6f-41fa-a048-066e2974bd6c	2026-04-23 00:46:51.934228+00	\N	\N	0	2026-04-21 00:46:51.934561+00	\N	19
6	+22390877889	PENDING	18e3e2e5-680e-4569-bfda-6a8aedbb038d	2026-04-23 00:46:52.986417+00	\N	\N	0	2026-04-21 00:46:52.986661+00	\N	19
7	+22390877889	PENDING	5acb5e2a-9a6a-457a-ab33-7ca7993a7f1c	2026-04-23 00:46:54.271509+00	\N	\N	0	2026-04-21 00:46:54.27179+00	\N	19
8	+22390877889	PENDING	7dcb0853-0ff8-4efd-939f-6ba22c5f92fc	2026-04-23 00:46:54.564324+00	\N	\N	0	2026-04-21 00:46:54.564605+00	\N	19
9	+22390877889	PENDING	fedc0b16-14b3-462d-8a97-cfebcde9b475	2026-04-23 00:46:54.832913+00	\N	\N	0	2026-04-21 00:46:54.83322+00	\N	19
10	+22390877889	PENDING	07c9202a-33d1-48f3-a305-b6f426540acb	2026-04-23 00:46:55.115401+00	\N	\N	0	2026-04-21 00:46:55.11565+00	\N	19
11	+22390877889	PENDING	1d854575-a678-4c1d-9e2f-7b982850acde	2026-04-23 00:46:55.364861+00	\N	\N	0	2026-04-21 00:46:55.365143+00	\N	19
12	+22390877889	PENDING	dc425e2a-2f86-4b59-a8f6-d9ae814ad895	2026-04-23 00:46:55.659718+00	\N	\N	0	2026-04-21 00:46:55.659998+00	\N	19
13	+22390877889	PENDING	bdcd0fc4-a483-4d9f-901d-94e5ae139f77	2026-04-23 00:46:55.90905+00	\N	\N	0	2026-04-21 00:46:55.909309+00	\N	19
14	+22390877889	PENDING	058109da-aa33-48d4-bf7a-095f7b727e1d	2026-04-23 00:46:56.246978+00	\N	\N	0	2026-04-21 00:46:56.247333+00	\N	19
15	+22390877889	PENDING	1255eee2-f10c-46b4-b62d-2cdfb70458cd	2026-04-23 00:46:56.496478+00	\N	\N	0	2026-04-21 00:46:56.496775+00	\N	19
16	+22390877889	PENDING	37f4e28d-396c-4c1c-866d-19e52359dccb	2026-04-23 00:46:56.969645+00	\N	\N	0	2026-04-21 00:46:56.969882+00	\N	19
17	+22390877889	PENDING	111c8d7c-3a90-446b-a26c-a9b772ae2d04	2026-04-23 00:46:57.230454+00	\N	\N	0	2026-04-21 00:46:57.230766+00	\N	19
18	+22390877889	PENDING	c79f02fb-b394-4ea5-bc0a-d7093919ae6a	2026-04-23 00:46:57.501187+00	\N	\N	0	2026-04-21 00:46:57.501489+00	\N	19
19	+22390877889	PENDING	4b865747-e07a-4de6-8177-cb04bf300605	2026-04-23 00:46:57.777779+00	\N	\N	0	2026-04-21 00:46:57.778037+00	\N	19
20	+22390877889	PENDING	7c20efd4-82fc-4271-976a-a4e568e802b7	2026-04-23 00:46:58.032501+00	\N	\N	0	2026-04-21 00:46:58.03291+00	\N	19
21	+22390877889	PENDING	356458b8-4ef1-43ba-bf7e-e65e2cad5bb0	2026-04-23 00:46:58.306972+00	\N	\N	0	2026-04-21 00:46:58.30734+00	\N	19
22	+22390877889	PENDING	47b32e99-2e35-4d4c-86d5-59f7fb95e1f1	2026-04-23 00:47:02.078494+00	\N	\N	0	2026-04-21 00:47:02.078745+00	\N	19
23	+22390877889	PENDING	3caa1499-2db0-4b08-af15-3e0d91e2c476	2026-04-23 00:47:02.341872+00	\N	\N	0	2026-04-21 00:47:02.342153+00	\N	19
24	+22390877889	PENDING	bd01f6a1-8e76-436c-89a6-d65f808c6cf0	2026-04-23 00:47:02.608288+00	\N	\N	0	2026-04-21 00:47:02.608586+00	\N	19
25	+22373457616	PENDING	c16e741a-2b7e-41cc-a107-72ece6d8d13c	2026-04-23 10:40:58.780062+00	\N	\N	0	2026-04-21 10:40:58.780725+00	\N	18
26	+22373457616	PENDING	eec24df3-e0df-47f0-a555-9fb603994dbf	2026-04-23 10:41:05.916648+00	\N	\N	0	2026-04-21 10:41:05.916948+00	\N	18
27	+22373457616	PENDING	c03aab77-0f3d-48ee-9bad-58940c2377a7	2026-04-23 10:41:08.737167+00	\N	\N	0	2026-04-21 10:41:08.737493+00	\N	18
28	+22373457616	PENDING	06c49056-3c07-4b48-9289-d0816f0bdcb0	2026-04-23 10:42:10.099119+00	\N	\N	0	2026-04-21 10:42:10.099428+00	\N	18
29	+22373457616	PENDING	cbbb4ecd-97a6-4815-8db0-721f168b14ca	2026-04-23 10:49:17.279144+00	\N	\N	0	2026-04-21 10:49:17.285196+00	\N	20
30	+22373457616	PENDING	f764e546-2e14-4d77-9a60-fe749551da0f	2026-04-23 10:49:48.487369+00	\N	\N	0	2026-04-21 10:49:48.487622+00	\N	20
31	+22373457616	PENDING	8e4e0e2d-9878-43c3-be17-c70ec477e9d5	2026-04-23 11:01:43.64885+00	\N	\N	0	2026-04-21 11:01:43.649227+00	\N	20
32	+22373457616	PENDING	3b90c340-a52b-4eb4-8b52-af895e93169d	2026-04-23 11:02:15.183802+00	\N	\N	0	2026-04-21 11:02:15.184049+00	\N	20
33	+22373457616	PENDING	70b47e34-1df5-492e-97c1-baabddc1a56f	2026-04-23 11:16:24.49955+00	\N	\N	0	2026-04-21 11:16:24.499816+00	\N	20
34	+22373457616	PENDING	1371010f-677c-4ade-836f-7cd217022276	2026-04-25 23:27:32.916292+00	\N	\N	0	2026-04-23 23:27:32.922903+00	\N	21
35	+22390877889	PENDING	d9b81087-cf41-4b4d-9452-8099e1f36b44	2026-04-27 21:33:00.922277+00	\N	\N	0	2026-04-25 21:33:00.927813+00	\N	22
36	+22373457616	PENDING	e6c4bc02-4b5e-407c-b7f1-ef9f82fdcbe4	2026-04-27 21:33:39.871125+00	\N	\N	0	2026-04-25 21:33:39.871383+00	\N	21
37	+22373457616	PENDING	0d75f20c-5a4d-4eb5-8683-5869fefa000a	2026-04-27 21:36:25.197829+00	\N	\N	0	2026-04-25 21:36:25.198122+00	\N	21
\.


--
-- Data for Name: core_audittestmodel; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.core_audittestmodel (id, name) FROM stdin;
1	Test Modifié
\.


--
-- Data for Name: core_databasebackup; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.core_databasebackup (id, file, created_at, backup_type, file_size) FROM stdin;
\.


--
-- Data for Name: core_expense; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.core_expense (id, title, amount, date, notes, receipt, created_at, recorded_by_id, category_id) FROM stdin;
1	Loyer du mois de Mai	150000	2026-04-24			2026-04-24 00:45:07.533454+00	1	1
\.


--
-- Data for Name: core_expensecategory; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.core_expensecategory (id, name, description) FROM stdin;
1	Loyer	Frais de location des boutiques ou dépôts
2	Salaires	Rémunération du personnel
3	Transport	Frais de déplacement et livraison
4	Électricité / Eau	Factures EDM / SOMAGEP
5	Communication	Crédit téléphonique et internet
6	Fournitures	Papeterie et petit matériel
7	Entretien	Maintenance des locaux et matériel
8	Divers	Autres dépenses non classées
9	test	
\.


--
-- Data for Name: core_historicalaudittestmodel; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.core_historicalaudittestmodel (id, name, history_id, history_date, history_change_reason, history_type, history_user_id) FROM stdin;
1	Test Initial	1	2026-04-11 00:47:23.781886+00	\N	+	\N
1	Test Modifié	2	2026-04-11 00:47:23.787145+00	\N	~	\N
\.


--
-- Data for Name: core_historicalexpense; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.core_historicalexpense (id, title, amount, date, notes, receipt, created_at, history_id, history_date, history_change_reason, history_type, category_id, history_user_id, recorded_by_id) FROM stdin;
1	Loyer du mois de Mai	150000	2026-04-24			2026-04-24 00:45:07.533454+00	1	2026-04-24 00:45:07.538784+00	\N	+	1	1	1
\.


--
-- Data for Name: core_historicalreleasecode; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.core_historicalreleasecode (id, code, operation_type, is_used, created_at, expires_at, used_at, history_id, history_date, history_change_reason, history_type, created_by_id, history_user_id, used_by_id) FROM stdin;
\.


--
-- Data for Name: core_releasecode; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.core_releasecode (id, code, operation_type, is_used, created_at, expires_at, used_at, created_by_id, used_by_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_clockedschedule; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_celery_beat_clockedschedule (id, clocked_time) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_crontabschedule; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_celery_beat_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year, timezone) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_intervalschedule; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_celery_beat_intervalschedule (id, every, period) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_periodictask; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_celery_beat_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id, solar_id, one_off, start_time, priority, headers, clocked_id, expire_seconds) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_periodictasks; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_celery_beat_periodictasks (ident, last_update) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_solarschedule; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_celery_beat_solarschedule (id, event, latitude, longitude) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	auth	group
2	auth	permission
3	contenttypes	contenttype
4	sessions	session
5	sites	site
6	admin	logentry
7	account	emailaddress
8	account	emailconfirmation
9	mfa	authenticator
10	socialaccount	socialaccount
11	socialaccount	socialapp
12	socialaccount	socialtoken
13	django_celery_beat	clockedschedule
14	django_celery_beat	crontabschedule
15	django_celery_beat	intervalschedule
16	django_celery_beat	periodictask
17	django_celery_beat	periodictasks
18	django_celery_beat	solarschedule
19	users	user
20	core	audittestmodel
21	core	historicalaudittestmodel
22	inventory	historicalproduct
23	inventory	product
24	inventory	historicalstocktransaction
25	inventory	historicalwarehouse
26	inventory	stocktransaction
27	inventory	warehouse
28	sales	historicalsale
29	sales	sale
30	sales	saleitem
31	core	historicalreleasecode
32	core	releasecode
33	communications	communicationconfig
34	communications	whatsappnotification
35	communications	dailyreport
36	sales	customer
37	sales	historicalcustomer
38	sales	historicalpayment
39	sales	historicalsaleitem
40	sales	payment
41	core	expense
42	core	expensecategory
43	core	historicalexpense
44	core	databasebackup
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-04-11 00:13:01.203844+00
2	contenttypes	0002_remove_content_type_name	2026-04-11 00:13:01.215655+00
3	auth	0001_initial	2026-04-11 00:13:01.27455+00
4	auth	0002_alter_permission_name_max_length	2026-04-11 00:13:01.281912+00
5	auth	0003_alter_user_email_max_length	2026-04-11 00:13:01.288499+00
6	auth	0004_alter_user_username_opts	2026-04-11 00:13:01.296088+00
7	auth	0005_alter_user_last_login_null	2026-04-11 00:13:01.303332+00
8	auth	0006_require_contenttypes_0002	2026-04-11 00:13:01.306228+00
9	auth	0007_alter_validators_add_error_messages	2026-04-11 00:13:01.313727+00
10	auth	0008_alter_user_username_max_length	2026-04-11 00:13:01.354838+00
11	auth	0009_alter_user_last_name_max_length	2026-04-11 00:13:01.363047+00
12	auth	0010_alter_group_name_max_length	2026-04-11 00:13:01.374135+00
13	auth	0011_update_proxy_permissions	2026-04-11 00:13:01.38112+00
14	auth	0012_alter_user_first_name_max_length	2026-04-11 00:13:01.388532+00
15	users	0001_initial	2026-04-11 00:13:01.457432+00
16	account	0001_initial	2026-04-11 00:13:01.510279+00
17	account	0002_email_max_length	2026-04-11 00:13:01.524443+00
18	account	0003_alter_emailaddress_create_unique_verified_email	2026-04-11 00:13:01.549365+00
19	account	0004_alter_emailaddress_drop_unique_email	2026-04-11 00:13:01.575032+00
20	account	0005_emailaddress_idx_upper_email	2026-04-11 00:13:01.588184+00
21	account	0006_emailaddress_lower	2026-04-11 00:13:01.603977+00
22	account	0007_emailaddress_idx_email	2026-04-11 00:13:01.627758+00
23	account	0008_emailaddress_unique_primary_email_fixup	2026-04-11 00:13:01.643009+00
24	account	0009_emailaddress_unique_primary_email	2026-04-11 00:13:01.655335+00
25	admin	0001_initial	2026-04-11 00:13:01.687684+00
26	admin	0002_logentry_remove_auto_add	2026-04-11 00:13:01.696194+00
27	admin	0003_logentry_add_action_flag_choices	2026-04-11 00:13:01.705316+00
28	django_celery_beat	0001_initial	2026-04-11 00:13:01.759666+00
29	django_celery_beat	0002_auto_20161118_0346	2026-04-11 00:13:01.779169+00
30	django_celery_beat	0003_auto_20161209_0049	2026-04-11 00:13:01.791442+00
31	django_celery_beat	0004_auto_20170221_0000	2026-04-11 00:13:01.796569+00
32	django_celery_beat	0005_add_solarschedule_events_choices	2026-04-11 00:13:01.802361+00
33	django_celery_beat	0006_auto_20180322_0932	2026-04-11 00:13:01.849553+00
34	django_celery_beat	0007_auto_20180521_0826	2026-04-11 00:13:01.874327+00
35	django_celery_beat	0008_auto_20180914_1922	2026-04-11 00:13:01.911759+00
36	django_celery_beat	0006_auto_20180210_1226	2026-04-11 00:13:01.938163+00
37	django_celery_beat	0006_periodictask_priority	2026-04-11 00:13:01.952224+00
38	django_celery_beat	0009_periodictask_headers	2026-04-11 00:13:01.965592+00
39	django_celery_beat	0010_auto_20190429_0326	2026-04-11 00:13:02.208421+00
40	django_celery_beat	0011_auto_20190508_0153	2026-04-11 00:13:02.234044+00
41	django_celery_beat	0012_periodictask_expire_seconds	2026-04-11 00:13:02.247597+00
42	django_celery_beat	0013_auto_20200609_0727	2026-04-11 00:13:02.262393+00
43	django_celery_beat	0014_remove_clockedschedule_enabled	2026-04-11 00:13:02.270109+00
44	django_celery_beat	0015_edit_solarschedule_events_choices	2026-04-11 00:13:02.275497+00
45	django_celery_beat	0016_alter_crontabschedule_timezone	2026-04-11 00:13:02.290285+00
46	django_celery_beat	0017_alter_crontabschedule_month_of_year	2026-04-11 00:13:02.302206+00
47	django_celery_beat	0018_improve_crontab_helptext	2026-04-11 00:13:02.312898+00
48	django_celery_beat	0019_alter_periodictasks_options	2026-04-11 00:13:02.318246+00
49	mfa	0001_initial	2026-04-11 00:13:02.352058+00
50	mfa	0002_authenticator_timestamps	2026-04-11 00:13:02.376562+00
51	mfa	0003_authenticator_type_uniq	2026-04-11 00:13:02.416516+00
52	sessions	0001_initial	2026-04-11 00:13:02.434634+00
53	sites	0001_initial	2026-04-11 00:13:02.441726+00
54	sites	0002_alter_domain_unique	2026-04-11 00:13:02.450541+00
55	sites	0003_set_site_domain_and_name	2026-04-11 00:13:02.478007+00
56	sites	0004_alter_options_ordering_domain	2026-04-11 00:13:02.48345+00
57	socialaccount	0001_initial	2026-04-11 00:13:02.576092+00
58	socialaccount	0002_token_max_lengths	2026-04-11 00:13:02.604782+00
59	socialaccount	0003_extra_data_default_dict	2026-04-11 00:13:02.615237+00
60	socialaccount	0004_app_provider_id_settings	2026-04-11 00:13:02.641517+00
61	socialaccount	0005_socialtoken_nullable_app	2026-04-11 00:13:02.666568+00
62	socialaccount	0006_alter_socialaccount_extra_data	2026-04-11 00:13:02.691681+00
63	core	0001_initial	2026-04-11 00:46:23.796019+00
64	users	0002_user_role	2026-04-11 10:07:16.333612+00
65	core	0002_setup_initial_roles	2026-04-11 11:07:36.517682+00
66	inventory	0001_initial	2026-04-11 12:22:44.629462+00
67	inventory	0002_warehouse_alter_historicalproduct_sku_and_more	2026-04-11 13:40:59.387034+00
68	inventory	0003_historicalstocktransaction_to_warehouse_and_more	2026-04-11 15:21:26.087625+00
69	sales	0001_initial	2026-04-11 20:39:47.24232+00
70	users	0003_user_assigned_warehouse	2026-04-11 21:02:56.753151+00
71	inventory	0004_historicalproduct_low_stock_threshold_and_more	2026-04-11 21:42:10.877016+00
72	inventory	0005_historicalproduct_alert_threshold_cartons_and_more	2026-04-13 14:09:43.176801+00
73	inventory	0006_alter_historicalproduct_alert_threshold_cartons_and_more	2026-04-13 14:35:42.90806+00
74	sales	0002_historicalsale_status_sale_status	2026-04-14 11:03:26.998514+00
75	core	0003_historicalreleasecode_releasecode	2026-04-14 11:54:28.474486+00
76	sales	0003_historicalsale_customer_phone_sale_customer_phone	2026-04-14 22:17:48.821344+00
77	communications	0001_initial	2026-04-16 19:20:07.739934+00
78	communications	0002_dailyreport	2026-04-16 19:59:02.756122+00
79	communications	0003_remove_communicationconfig_api_key_and_more	2026-04-16 21:56:18.279881+00
80	sales	0004_customer_historicalsale_customer_sale_customer_and_more	2026-04-16 23:21:45.617061+00
81	sales	0005_historicalsale_customer_name_sale_customer_name	2026-04-18 19:58:57.808951+00
82	sales	0006_alter_historicalsale_options_alter_sale_options_and_more	2026-04-20 12:00:51.283477+00
83	core	0004_expensecategory_alter_audittestmodel_options_and_more	2026-04-23 23:38:53.762439+00
84	sales	0007_alter_saleitem_options_and_more	2026-04-23 23:53:15.541022+00
85	core	0005_databasebackup	2026-04-25 17:31:28.04635+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
vx0ki6sj3yk5ovch0zdb78lq77i1f88v	.eJxVkMFuhDAMRP_FZ4QChiRw7H2_oKqQQ7wlXUhWJKhdIf69pN3L3kae57HGO9A4hs2ngbY0sU9upOSCHxZOU7AR-vcd_jX0cKcYv8NqoQBK0FdKSVSoJZY1KtHKArbIq6eFT5js4vwQH_NMcHwU8HdhyMDgclgFLzND4419NuwX-c9QjsGn1ZkyI-XTjeUlWJ7fnuxLwERxOrfrjlGY9sodotSI3OoWJbbElVBcdep0ZKOaRghUUlPHxmi8SivVqUSdQyPHmJ_AP3e3PqAXBRiKNz4778fxCx7dZbY:1wDXfN:KUWZexgarLNJHGfd7LLN-gy8a7gHMo4PVZA8xTFhYUw	2026-05-01 01:06:41.099954+00
tey2spt9fipfqo8k84asdovnqh7v89y8	.eJxVkE1ugzAQhe8ya4TAdgCz7L4nqCo09owKDbEjxjSJEHevabPJbjTve29-NkDv4xrSgGsaOaTJY5piGC6cxkgC_ccG_zX0cEWRW1wICsAEfd22je6UtbrUurZ1AavwEvDCmf3hQLwugzzmGWH_LOBvxHAgw3SkKXjpOfTn7MkCfWP4iqWPIS2TKw-kfKpSvkfi-e3JvgSMKGN2s69a9OicrrFRpum0wgZt1-RtrUIyJ8PkLBrrqKITe7LKKF13rakIdXWECoscX-D7dVoe0FcFOJQz56O3ff8FL89nPw:1wEnwh:6yc1hDFfT6UM3t4LQCYCAPNXGUbJkFh8qR8Emn_r9EY	2026-05-04 12:41:47.935913+00
ntirienz2z81uvne5gwphg56xuehx5zr	.eJxVkMFuhDAMRP_FZ4RCCIRw7L1fUFXIia1Cl01WOLRdIf690O5lb5bnzVjjDTCEtMY84JpHjnkKmKcUhyvnMZFA_7bB_ww93FDkOy0EBWCGvrK2ccboqimNUrZWVQGr8BLxygf9xZF4XQa5zzPC_l7A35HhRIbpzNPwtPMYLofnEOgT40cqQ4p5mXx5IuVDlfI1Ec8vD_YpYEQZDzcHZTGg93WFrTZtV2ts0XWtta3TSKYxTN6hcZ4UNRzIaaPrqrNGEdbqDBUWOf_AP7dpuUOvCvAoFz5qb_v-C6-gZ5M:1wBgFC:CmBIRNQ3Xi6zpF8MLEsBCO0UVT173dKEY4EkgsjXBXI	2026-04-25 21:51:58.45273+00
3r5b2t7oe63f6lu8tah9crdialorkoqs	.eJxVkM1uhDAMhN_FZ4QSQn7g2Ps-QVUhh3hLupCsSFC7Qrx7SbuXvY08n8ca74DjGLeQB9zyRCH7EbOPYVgoT9El6N93-NfQwx1T-o6rgwowQ8-1lh1XWjV1o7k0FWyJ1oALnSy6xYchPeYZ4fio4O_AUIDBlywOLzOL441CMdwXhs9YjzHk1du6IPXTTfUlOprfnuxLwIRpOrebjgSz8kqdEMoIQdJIoYRE4kwT7_TpqFa3LWNCK4MdWWvEVTmlT8WaEpoopfID-rn79QE9q8BiutFZeT-OX9nEZYY:1wChbZ:UaHubUyMNDebqGNFFZuHHdBZxLIiVnbgT2Z0aiFlwuc	2026-04-28 17:31:17.486783+00
5nvfhtkrn92ethx9xqulxx9rerx6gp4q	.eJxVkM1uhDAMhN_FZ4QCIT9w7H2foKoih3hLupCsSFC7Qrx7SbuXvY08n8ca74DjGLeQDW55opD9iNnHYBbKU3QJhvcd_jUMcMeUvuPqoALMMDRKyV5rLbqasVY3ooIt0RpwoRNGt_hg0mOeEY6PCv4umAIYX8IaeJlZHG8UiuG-MHzGeowhr97WBamfbqov0dH89mRfAiZM07nd9sSZFVfqOZeacxJacMkFUsMUNb06HdmprmOMK6mxJ2s1v0on1alYW0ITpVSeQD93vz5gYBVYTDc6O-_H8Qsjy2W7:1wG4pP:nk0oYb6fubw_2UZfYBUW42aKIEbhTmLhuHcpZk_3uF0	2026-05-08 00:55:31.877837+00
7ptmmmzajuc1vr5ac2r6xsipm9w4nwf3	.eJxVkE1uhDAMhe_iNUKQhN9l9z1BVSEntgodJhnh0HaEuHuTdjazs_w-Pz_7AHQu7D5OuMeZfVwcxiX46cpxDiQwvh3wX8MINxT5DhtBARhhrLuuHfq2r-tS675ptCpgF948XjnRX-yJ922S-7oinO8F_C2ZMjIt2U_BU8-iu6SZJNAn-o9QuuDjttgyI-VDlfI1EK8vD_bJYEaZ0zS7qkOH1uoaW2XaXitsMSXNeRWSaQyTHdAMlipq2NGgjNJ135mKUFfZVFgk_4F_bst2h7EqwKJcOJ19nOcvxSlnqg:1wGPT6:dvPQgr_JQJHSPArjUHZiMvOxwU4150p3GstKYFlK1vc	2026-05-08 22:57:52.477522+00
mn85cfoyld0cf80yktefhdi7bp54ml8w	.eJxVkE1uhDAMhe_iNUKQhEBYdt8TVBVyEqvQYZJRHNqOEHdvaGczO8vve88_O6BzcQt5wi3PFPLiMC8xTFfKc_QM49sO_zWMcEPm75g8VIAZxrbvdS-FNLpWygxDV8HGlAJeqcBfFDxtaeL7uiIc7xX8zZhOZFrOOAFPPYvuUjxF8J8YPmLtYshpsfWJ1A-V69foaX15sE8BM_Jc3OSaHh1aK1vUQulBCtRoBl3WNQK96hR5a1AZ6xvfkfNGKCHboVeNR9mcoUzM5xvo57akO4xNBRb5QuXq_Th-AYTAZ4A:1wGkg3:4uaxrxWHBPU1xtm4QxDEtJ4TimWgwV0cewQgOlxLBLI	2026-05-09 21:36:39.170126+00
qd1gwu7wdaec1b7lsjfsuvi6cblkap5z	.eJxVkE1uhDAMhe_iNUKBQAIsu58TVBVyiKekA8kIB7UjxN2btLOZ3ZPf5-efA3Cawu7jiHucyUc3YXTBjyvFOViG4f2Afw0D3JH5O2wWCsAIQ6W1rtpGalXWSola9gXsTJvHlRKNdnV-5MeyIJwfBfyNGDMwupxWwUvN4HQjnw37hf4zlFPwcXOmzEj5dLm8BEvL25N9CZiR59Rd9ySFaa_US6k6KantWqlki1QJTVWvk6Ma3TRCpM077MmYTl6VVTopUedQJub8Bfq5u-0BgyjAIN8oHX2c5y9lz2Xo:1wGl2n:tBsgpfjkOJlC1OE02HFvPXosP7avYBLMAuNnHyEgD5w	2026-05-09 22:00:09.74317+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.django_site (id, domain, name) FROM stdin;
1	erp-sylla.com	ERP Ets Sylla Madjou
\.


--
-- Data for Name: inventory_historicalproduct; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.inventory_historicalproduct (id, name, description, sku, barcode, purchase_price, sale_price_piece, sale_price_carton, conversion_factor, is_active, created_at, updated_at, history_id, history_date, history_change_reason, history_type, history_user_id, low_stock_threshold, alert_threshold_cartons, alert_threshold_pieces) FROM stdin;
1	Article 1	test article 1	ARTICLE-1-0A4D	\N	40000	5000	44000	10	t	2026-04-11 14:15:32.712375+00	2026-04-11 14:15:32.712445+00	1	2026-04-11 14:15:32.720767+00	\N	+	1	5	0	5
2	Article 2	test article 2	ARTICLE-2-5D54	\N	150000	25000	175000	8	t	2026-04-11 14:20:47.453615+00	2026-04-11 14:20:47.453628+00	2	2026-04-11 14:20:47.457227+00	\N	+	1	5	0	5
3	Article 3	Tests article 3	ARTICLE-3-AC62	\N	100000	55000	105000	2	t	2026-04-11 14:41:35.80812+00	2026-04-11 14:41:35.808134+00	3	2026-04-11 14:41:35.810875+00	\N	+	1	5	0	5
1	Article 1	test article 1	ARTICLE-1-0A4D	\N	40000	5000	44000	10	t	2026-04-11 14:15:32.712375+00	2026-04-11 14:15:32.712445+00	4	2026-04-11 17:03:11.272197+00	\N	-	1	5	0	5
2	Article 2 modif	test article 2 modif	ARTICLE-2-5D54	\N	150000	25000	175000	8	t	2026-04-11 14:20:47.453615+00	2026-04-11 17:13:29.868271+00	5	2026-04-11 17:13:29.872324+00	\N	~	1	5	0	5
2	Article 2 modif	test article 2 modif	ARTICLE-2-5D54	\N	150000	25000	175000	8	t	2026-04-11 14:20:47.453615+00	2026-04-11 17:16:06.716294+00	6	2026-04-11 17:16:06.718887+00	\N	~	1	5	0	5
2	Article 2 test	test article 2 modif	ARTICLE-2-TEST-BBE5	\N	150000	25000	175000	8	t	2026-04-11 14:20:47.453615+00	2026-04-11 17:16:19.536931+00	7	2026-04-11 17:16:19.539361+00	\N	~	1	5	0	5
4	Article 4		ARTICLE-4-901F	\N	100000	12000	120000	10	t	2026-04-14 10:39:19.038583+00	2026-04-14 10:39:19.038597+00	8	2026-04-14 10:39:19.057184+00	\N	+	1	20	\N	20
5	Article 4		ARTICLE-4-3824	\N	150000	80000	160000	5	t	2026-04-18 19:46:42.411255+00	2026-04-18 19:46:42.411275+00	9	2026-04-18 19:46:42.417897+00	\N	+	2	10	\N	10
\.


--
-- Data for Name: inventory_historicalstocktransaction; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.inventory_historicalstocktransaction (id, quantity, type, notes, created_at, history_id, history_date, history_change_reason, history_type, history_user_id, product_id, warehouse_id, to_warehouse_id) FROM stdin;
1	100	IN		2026-04-11 14:15:57.823416+00	1	2026-04-11 14:15:57.827787+00	\N	+	1	1	1	\N
2	58	ADJ		2026-04-11 14:38:27.299995+00	2	2026-04-11 14:38:27.305623+00	\N	+	1	2	1	\N
3	58	IN		2026-04-11 14:41:57.723706+00	3	2026-04-11 14:41:57.728411+00	\N	+	1	3	2	\N
4	100	ADJ		2026-04-11 14:42:21.603668+00	4	2026-04-11 14:42:21.607135+00	\N	+	1	2	1	\N
5	50	TRANS		2026-04-11 14:45:46.701886+00	5	2026-04-11 14:45:46.706224+00	\N	+	1	2	1	\N
6	-550	TRANS		2026-04-11 15:39:06.369382+00	6	2026-04-11 15:39:06.376455+00	\N	+	1	1	1	2
7	550	IN	Transfert depuis Boutique 1. 	2026-04-11 15:39:06.41049+00	7	2026-04-11 15:39:06.41226+00	\N	+	1	1	2	\N
6	-550	TRANS		2026-04-11 15:39:06.369382+00	8	2026-04-11 15:39:06.420287+00	\N	~	1	1	1	2
8	-80	TRANS		2026-04-11 15:41:06.997103+00	9	2026-04-11 15:41:07.001876+00	\N	+	1	2	1	2
9	80	IN	Transfert depuis Boutique 1. 	2026-04-11 15:41:07.006761+00	10	2026-04-11 15:41:07.008649+00	\N	+	1	2	2	\N
8	-80	TRANS		2026-04-11 15:41:06.997103+00	11	2026-04-11 15:41:07.014969+00	\N	~	1	2	1	2
10	480	ADJ	Inventaire : stock corrigé de -450 vers 30. 	2026-04-11 15:42:41.296827+00	12	2026-04-11 15:42:41.29911+00	\N	+	1	1	1	\N
10	480	ADJ	Inventaire : stock corrigé de -450 vers 30. 	2026-04-11 15:42:41.296827+00	13	2026-04-11 15:42:41.306013+00	\N	~	1	1	1	\N
11	-98	ADJ	Inventaire : stock corrigé de 128 vers 30. 	2026-04-11 16:32:40.206908+00	14	2026-04-11 16:32:40.210163+00	\N	+	1	2	1	\N
11	-98	ADJ	Inventaire : stock corrigé de 128 vers 30. 	2026-04-11 16:32:40.206908+00	15	2026-04-11 16:32:40.221313+00	\N	~	1	2	1	\N
12	-200	TRANS		2026-04-11 16:40:33.960045+00	16	2026-04-11 16:40:33.962624+00	\N	+	1	1	2	1
13	200	IN	Transfert depuis Boutique 2. 	2026-04-11 16:40:33.96802+00	17	2026-04-11 16:40:33.969354+00	\N	+	1	1	1	\N
12	-200	TRANS		2026-04-11 16:40:33.960045+00	18	2026-04-11 16:40:33.973217+00	\N	~	1	1	2	1
14	-20	TRANS		2026-04-11 16:42:26.565715+00	19	2026-04-11 16:42:26.568574+00	\N	+	1	3	2	1
15	20	IN	Transfert depuis Boutique 2. 	2026-04-11 16:42:26.573088+00	20	2026-04-11 16:42:26.57563+00	\N	+	1	3	1	\N
14	-20	TRANS		2026-04-11 16:42:26.565715+00	21	2026-04-11 16:42:26.581341+00	\N	~	1	3	2	1
13	200	IN	Transfert depuis Boutique 2. 	2026-04-11 16:40:33.96802+00	22	2026-04-11 17:03:11.253417+00	\N	-	1	1	1	\N
12	-200	TRANS		2026-04-11 16:40:33.960045+00	23	2026-04-11 17:03:11.260751+00	\N	-	1	1	2	1
10	480	ADJ	Inventaire : stock corrigé de -450 vers 30. 	2026-04-11 15:42:41.296827+00	24	2026-04-11 17:03:11.263063+00	\N	-	1	1	1	\N
7	550	IN	Transfert depuis Boutique 1. 	2026-04-11 15:39:06.41049+00	25	2026-04-11 17:03:11.265099+00	\N	-	1	1	2	\N
6	-550	TRANS		2026-04-11 15:39:06.369382+00	26	2026-04-11 17:03:11.266958+00	\N	-	1	1	1	2
1	100	IN		2026-04-11 14:15:57.823416+00	27	2026-04-11 17:03:11.268684+00	\N	-	1	1	1	\N
16	-24	OUT	Vente FAC-20260411-0001	2026-04-11 20:49:29.72588+00	28	2026-04-11 20:49:29.730824+00	\N	+	1	2	1	\N
17	-6	OUT	Vente FAC-20260411-0001	2026-04-11 20:49:29.743053+00	29	2026-04-11 20:49:29.744412+00	\N	+	1	3	1	\N
18	-2	OUT	Vente FAC-20260411-0001	2026-04-11 20:49:29.749616+00	30	2026-04-11 20:49:29.751208+00	\N	+	1	3	1	\N
19	-16	OUT	Vente FAC-20260411-0005	2026-04-11 21:29:26.860537+00	31	2026-04-11 21:29:26.863302+00	\N	+	1	2	1	\N
20	-2	OUT	Vente FAC-20260411-0005	2026-04-11 21:29:26.870417+00	32	2026-04-11 21:29:26.871596+00	\N	+	1	2	1	\N
21	-2	OUT	Vente FAC-20260411-0005	2026-04-11 21:29:26.87693+00	33	2026-04-11 21:29:26.878137+00	\N	+	1	3	1	\N
22	-2	OUT	Vente FAC-20260411-0005	2026-04-11 21:29:26.883217+00	34	2026-04-11 21:29:26.884503+00	\N	+	1	3	1	\N
23	-2	OUT	Vente FAC-20260411-0006	2026-04-11 21:51:50.52764+00	35	2026-04-11 21:51:50.529827+00	\N	+	2	3	1	\N
24	-1	OUT	Vente FAC-20260411-0006	2026-04-11 21:51:50.539573+00	36	2026-04-11 21:51:50.541179+00	\N	+	2	3	1	\N
25	-2	OUT	Vente FAC-20260414-0001	2026-04-14 17:11:02.905114+00	37	2026-04-14 17:11:02.910232+00	\N	+	1	3	1	\N
26	-2	OUT	Vente FAC-20260418-0001	2026-04-18 19:41:36.946311+00	38	2026-04-18 19:41:36.950876+00	\N	+	2	3	1	\N
27	-1	OUT	Vente FAC-20260418-0002	2026-04-18 19:43:50.340515+00	39	2026-04-18 19:43:50.34248+00	\N	+	2	3	1	\N
28	100	IN		2026-04-18 19:47:09.418646+00	40	2026-04-18 19:47:09.423142+00	\N	+	2	5	1	\N
29	-1	OUT	Vente FAC-20260418-0003	2026-04-18 19:53:57.831964+00	41	2026-04-18 19:53:57.836486+00	\N	+	2	5	1	\N
30	-5	OUT	Vente FAC-20260418-0003	2026-04-18 19:53:57.850996+00	42	2026-04-18 19:53:57.852989+00	\N	+	2	5	1	\N
31	-3	OUT	Vente FAC-20260419-0001	2026-04-19 12:51:51.644898+00	43	2026-04-19 12:51:51.649492+00	\N	+	2	5	1	\N
32	-1	OUT	Vente FAC-20260420-0001	2026-04-20 01:24:12.273006+00	44	2026-04-20 01:24:12.277526+00	\N	+	2	5	1	\N
33	-5	OUT	Vente FAC-20260420-0001	2026-04-20 01:24:12.290689+00	45	2026-04-20 01:24:12.292697+00	\N	+	2	5	1	\N
34	-1	OUT	Vente FAC-20260420-0002	2026-04-20 11:08:41.756134+00	46	2026-04-20 11:08:41.758756+00	\N	+	2	5	1	\N
35	-5	OUT	Vente FAC-20260420-0002	2026-04-20 11:08:41.770418+00	47	2026-04-20 11:08:41.771945+00	\N	+	2	5	1	\N
36	-2	OUT	Vente FAC-20260420-0003	2026-04-20 12:37:34.56678+00	48	2026-04-20 12:37:34.571449+00	\N	+	2	5	1	\N
37	-5	OUT	Vente FAC-20260420-0004	2026-04-20 12:38:11.279035+00	49	2026-04-20 12:38:11.280889+00	\N	+	2	5	1	\N
38	-1	OUT	Vente FAC-20260420-0004	2026-04-20 12:38:11.295539+00	50	2026-04-20 12:38:11.297171+00	\N	+	2	5	1	\N
39	-2	OUT	Vente FAC-20260421-0001	2026-04-21 10:49:17.079762+00	51	2026-04-21 10:49:17.082795+00	\N	+	2	5	1	\N
40	-10	OUT	Vente FAC-20260421-0001	2026-04-21 10:49:17.099099+00	52	2026-04-21 10:49:17.101298+00	\N	+	2	5	1	\N
41	-1	OUT	Vente FAC-20260423-0001	2026-04-23 23:27:32.719079+00	53	2026-04-23 23:27:32.722297+00	\N	+	2	5	1	\N
42	-5	OUT	Vente FAC-20260423-0001	2026-04-23 23:27:32.74037+00	54	2026-04-23 23:27:32.742212+00	\N	+	2	5	1	\N
45	1	IN	Retour en stock suite annulation FAC-20260423-0001	2026-04-24 00:55:06.563387+00	57	2026-04-24 00:55:06.56698+00	\N	+	1	5	1	\N
46	1	IN	Retour en stock suite annulation FAC-20260423-0001	2026-04-24 00:55:06.58242+00	58	2026-04-24 00:55:06.584076+00	\N	+	1	5	1	\N
47	-1	OUT	Vente FAC-20260425-0001	2026-04-25 21:33:00.492391+00	59	2026-04-25 21:33:00.495656+00	\N	+	2	5	1	\N
48	-5	OUT	Vente FAC-20260425-0001	2026-04-25 21:33:00.512254+00	60	2026-04-25 21:33:00.51391+00	\N	+	2	5	1	\N
\.


--
-- Data for Name: inventory_historicalwarehouse; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.inventory_historicalwarehouse (id, name, location, is_active, created_at, history_id, history_date, history_change_reason, history_type, history_user_id) FROM stdin;
1	Boutique 1	Golf	t	2026-04-11 14:13:13.371681+00	1	2026-04-11 14:13:13.377103+00	\N	+	1
2	Boutique 2	ACI 2000	t	2026-04-11 14:39:41.696578+00	2	2026-04-11 14:39:41.699327+00	\N	+	1
\.


--
-- Data for Name: inventory_product; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.inventory_product (id, name, description, sku, barcode, purchase_price, sale_price_piece, sale_price_carton, conversion_factor, is_active, created_at, updated_at, low_stock_threshold, alert_threshold_cartons, alert_threshold_pieces) FROM stdin;
3	Article 3	Tests article 3	ARTICLE-3-AC62	\N	100000	55000	105000	2	t	2026-04-11 14:41:35.80812+00	2026-04-11 14:41:35.808134+00	5	0	5
2	Article 2 test	test article 2 modif	ARTICLE-2-TEST-BBE5	\N	150000	25000	175000	8	t	2026-04-11 14:20:47.453615+00	2026-04-11 17:16:19.536931+00	5	0	5
4	Article 4		ARTICLE-4-901F	\N	100000	12000	120000	10	t	2026-04-14 10:39:19.038583+00	2026-04-14 10:39:19.038597+00	20	\N	20
5	Article 4		ARTICLE-4-3824	\N	150000	80000	160000	5	t	2026-04-18 19:46:42.411255+00	2026-04-18 19:46:42.411275+00	10	\N	10
\.


--
-- Data for Name: inventory_stocktransaction; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.inventory_stocktransaction (id, quantity, type, notes, created_at, product_id, warehouse_id, to_warehouse_id) FROM stdin;
2	58	ADJ		2026-04-11 14:38:27.299995+00	2	1	\N
3	58	IN		2026-04-11 14:41:57.723706+00	3	2	\N
4	100	ADJ		2026-04-11 14:42:21.603668+00	2	1	\N
5	50	TRANS		2026-04-11 14:45:46.701886+00	2	1	\N
9	80	IN	Transfert depuis Boutique 1. 	2026-04-11 15:41:07.006761+00	2	2	\N
8	-80	TRANS		2026-04-11 15:41:06.997103+00	2	1	2
11	-98	ADJ	Inventaire : stock corrigé de 128 vers 30. 	2026-04-11 16:32:40.206908+00	2	1	\N
15	20	IN	Transfert depuis Boutique 2. 	2026-04-11 16:42:26.573088+00	3	1	\N
14	-20	TRANS		2026-04-11 16:42:26.565715+00	3	2	1
16	-24	OUT	Vente FAC-20260411-0001	2026-04-11 20:49:29.72588+00	2	1	\N
17	-6	OUT	Vente FAC-20260411-0001	2026-04-11 20:49:29.743053+00	3	1	\N
18	-2	OUT	Vente FAC-20260411-0001	2026-04-11 20:49:29.749616+00	3	1	\N
19	-16	OUT	Vente FAC-20260411-0005	2026-04-11 21:29:26.860537+00	2	1	\N
20	-2	OUT	Vente FAC-20260411-0005	2026-04-11 21:29:26.870417+00	2	1	\N
21	-2	OUT	Vente FAC-20260411-0005	2026-04-11 21:29:26.87693+00	3	1	\N
22	-2	OUT	Vente FAC-20260411-0005	2026-04-11 21:29:26.883217+00	3	1	\N
23	-2	OUT	Vente FAC-20260411-0006	2026-04-11 21:51:50.52764+00	3	1	\N
24	-1	OUT	Vente FAC-20260411-0006	2026-04-11 21:51:50.539573+00	3	1	\N
25	-2	OUT	Vente FAC-20260414-0001	2026-04-14 17:11:02.905114+00	3	1	\N
26	-2	OUT	Vente FAC-20260418-0001	2026-04-18 19:41:36.946311+00	3	1	\N
27	-1	OUT	Vente FAC-20260418-0002	2026-04-18 19:43:50.340515+00	3	1	\N
28	100	IN		2026-04-18 19:47:09.418646+00	5	1	\N
29	-1	OUT	Vente FAC-20260418-0003	2026-04-18 19:53:57.831964+00	5	1	\N
30	-5	OUT	Vente FAC-20260418-0003	2026-04-18 19:53:57.850996+00	5	1	\N
31	-3	OUT	Vente FAC-20260419-0001	2026-04-19 12:51:51.644898+00	5	1	\N
32	-1	OUT	Vente FAC-20260420-0001	2026-04-20 01:24:12.273006+00	5	1	\N
33	-5	OUT	Vente FAC-20260420-0001	2026-04-20 01:24:12.290689+00	5	1	\N
34	-1	OUT	Vente FAC-20260420-0002	2026-04-20 11:08:41.756134+00	5	1	\N
35	-5	OUT	Vente FAC-20260420-0002	2026-04-20 11:08:41.770418+00	5	1	\N
36	-2	OUT	Vente FAC-20260420-0003	2026-04-20 12:37:34.56678+00	5	1	\N
37	-5	OUT	Vente FAC-20260420-0004	2026-04-20 12:38:11.279035+00	5	1	\N
38	-1	OUT	Vente FAC-20260420-0004	2026-04-20 12:38:11.295539+00	5	1	\N
39	-2	OUT	Vente FAC-20260421-0001	2026-04-21 10:49:17.079762+00	5	1	\N
40	-10	OUT	Vente FAC-20260421-0001	2026-04-21 10:49:17.099099+00	5	1	\N
41	-1	OUT	Vente FAC-20260423-0001	2026-04-23 23:27:32.719079+00	5	1	\N
42	-5	OUT	Vente FAC-20260423-0001	2026-04-23 23:27:32.74037+00	5	1	\N
45	1	IN	Retour en stock suite annulation FAC-20260423-0001	2026-04-24 00:55:06.563387+00	5	1	\N
46	1	IN	Retour en stock suite annulation FAC-20260423-0001	2026-04-24 00:55:06.58242+00	5	1	\N
47	-1	OUT	Vente FAC-20260425-0001	2026-04-25 21:33:00.492391+00	5	1	\N
48	-5	OUT	Vente FAC-20260425-0001	2026-04-25 21:33:00.512254+00	5	1	\N
\.


--
-- Data for Name: inventory_warehouse; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.inventory_warehouse (id, name, location, is_active, created_at) FROM stdin;
1	Boutique 1	Golf	t	2026-04-11 14:13:13.371681+00
2	Boutique 2	ACI 2000	t	2026-04-11 14:39:41.696578+00
\.


--
-- Data for Name: mfa_authenticator; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.mfa_authenticator (id, type, data, user_id, created_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: sales_customer; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.sales_customer (id, name, phone, address, balance, created_at, updated_at) FROM stdin;
2	Moussa Toure	+22390893212	Bamako	0	2026-04-17 00:54:17.732712+00	2026-04-17 00:54:17.732725+00
3	Mamadou Diarra	+22390877889	Bamako	-1520000	2026-04-17 01:01:35.29826+00	2026-04-25 21:33:00.464606+00
1	Mamadou Sylla	+22373457616	Bamako	100000	2026-04-17 00:05:50.057567+00	2026-04-25 21:36:24.966991+00
\.


--
-- Data for Name: sales_historicalcustomer; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.sales_historicalcustomer (id, name, phone, address, balance, created_at, updated_at, history_id, history_date, history_change_reason, history_type, history_user_id) FROM stdin;
1	Mamadou Sylla	+22373457616	Bamako	0	2026-04-17 00:05:50.057567+00	2026-04-17 00:05:50.057579+00	1	2026-04-17 00:05:50.06414+00	\N	+	2
2	Moussa Toure	+22390893212	Bamako	0	2026-04-17 00:54:17.732712+00	2026-04-17 00:54:17.732725+00	2	2026-04-17 00:54:17.738309+00	\N	+	2
3	Mamadou Diarra	+22390877889	Bamako	0	2026-04-17 01:01:35.29826+00	2026-04-17 01:01:35.298275+00	3	2026-04-17 01:01:35.301798+00	\N	+	2
1	Mamadou Sylla	+22373457616	Bamako	160000	2026-04-17 00:05:50.057567+00	2026-04-20 12:37:34.481715+00	4	2026-04-20 12:37:34.486957+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	240000	2026-04-17 01:01:35.29826+00	2026-04-20 12:38:11.255586+00	5	2026-04-20 12:38:11.257833+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	140000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:51.395414+00	6	2026-04-21 00:46:51.398578+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	40000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:52.797518+00	7	2026-04-21 00:46:52.800176+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-60000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:54.061775+00	8	2026-04-21 00:46:54.063287+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-160000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:54.323824+00	9	2026-04-21 00:46:54.325872+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-260000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:54.614064+00	10	2026-04-21 00:46:54.61561+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-360000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:54.895439+00	11	2026-04-21 00:46:54.897165+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-460000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:55.160097+00	12	2026-04-21 00:46:55.161602+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-560000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:55.416987+00	13	2026-04-21 00:46:55.418774+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-660000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:55.710479+00	14	2026-04-21 00:46:55.711925+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-760000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:56.026439+00	15	2026-04-21 00:46:56.028392+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-860000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:56.295217+00	16	2026-04-21 00:46:56.296967+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-960000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:56.776566+00	17	2026-04-21 00:46:56.778138+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1060000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:57.01494+00	18	2026-04-21 00:46:57.016584+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1160000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:57.279458+00	19	2026-04-21 00:46:57.281425+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1260000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:57.556414+00	20	2026-04-21 00:46:57.558028+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1360000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:57.824618+00	21	2026-04-21 00:46:57.826532+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1460000	2026-04-17 01:01:35.29826+00	2026-04-21 00:46:58.079338+00	22	2026-04-21 00:46:58.080872+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1560000	2026-04-17 01:01:35.29826+00	2026-04-21 00:47:01.846869+00	23	2026-04-21 00:47:01.848963+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1660000	2026-04-17 01:01:35.29826+00	2026-04-21 00:47:02.128925+00	24	2026-04-21 00:47:02.130695+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1760000	2026-04-17 01:01:35.29826+00	2026-04-21 00:47:02.395722+00	25	2026-04-21 00:47:02.397531+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	110000	2026-04-17 00:05:50.057567+00	2026-04-21 10:40:58.034731+00	26	2026-04-21 10:40:58.040815+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	60000	2026-04-17 00:05:50.057567+00	2026-04-21 10:41:05.692527+00	27	2026-04-21 10:41:05.694601+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	10000	2026-04-17 00:05:50.057567+00	2026-04-21 10:41:08.512498+00	28	2026-04-21 10:41:08.514555+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	0	2026-04-17 00:05:50.057567+00	2026-04-21 10:42:09.855372+00	29	2026-04-21 10:42:09.857473+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	480000	2026-04-17 00:05:50.057567+00	2026-04-21 10:49:17.051715+00	30	2026-04-21 10:49:17.054397+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	455000	2026-04-17 00:05:50.057567+00	2026-04-21 10:49:48.248744+00	31	2026-04-21 10:49:48.250819+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	442500	2026-04-17 00:05:50.057567+00	2026-04-21 11:01:43.187216+00	32	2026-04-21 11:01:43.189774+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	392500	2026-04-17 00:05:50.057567+00	2026-04-21 11:02:14.953378+00	33	2026-04-21 11:02:14.95574+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	300500	2026-04-17 00:05:50.057567+00	2026-04-21 11:16:24.228194+00	34	2026-04-21 11:16:24.230403+00	\N	~	2
3	Mamadou Diarra	+22390877889	Bamako	-1520000	2026-04-17 01:01:35.29826+00	2026-04-25 21:33:00.464606+00	35	2026-04-25 21:33:00.467187+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	150500	2026-04-17 00:05:50.057567+00	2026-04-25 21:33:39.622464+00	36	2026-04-25 21:33:39.624559+00	\N	~	2
1	Mamadou Sylla	+22373457616	Bamako	100000	2026-04-17 00:05:50.057567+00	2026-04-25 21:36:24.966991+00	37	2026-04-25 21:36:24.969204+00	\N	~	2
\.


--
-- Data for Name: sales_historicalpayment; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.sales_historicalpayment (id, amount, payment_method, reference, notes, balance_after, created_at, history_id, history_date, history_change_reason, history_type, customer_id, history_user_id, received_by_id) FROM stdin;
1	100000	CASH	PAY-20260421-0001		140000	2026-04-21 00:46:51.419042+00	1	2026-04-21 00:46:51.432645+00	\N	+	3	2	2
2	100000	CASH	PAY-20260421-0002		40000	2026-04-21 00:46:52.809815+00	2	2026-04-21 00:46:52.81184+00	\N	+	3	2	2
3	100000	CASH	PAY-20260421-0003		-60000	2026-04-21 00:46:54.069764+00	3	2026-04-21 00:46:54.070878+00	\N	+	3	2	2
4	100000	CASH	PAY-20260421-0004		-160000	2026-04-21 00:46:54.335187+00	4	2026-04-21 00:46:54.337099+00	\N	+	3	2	2
5	100000	CASH	PAY-20260421-0005		-260000	2026-04-21 00:46:54.622282+00	5	2026-04-21 00:46:54.623475+00	\N	+	3	2	2
6	100000	CASH	PAY-20260421-0006		-360000	2026-04-21 00:46:54.905601+00	6	2026-04-21 00:46:54.907039+00	\N	+	3	2	2
7	100000	CASH	PAY-20260421-0007		-460000	2026-04-21 00:46:55.167832+00	7	2026-04-21 00:46:55.16899+00	\N	+	3	2	2
8	100000	CASH	PAY-20260421-0008		-560000	2026-04-21 00:46:55.427031+00	8	2026-04-21 00:46:55.429208+00	\N	+	3	2	2
9	100000	CASH	PAY-20260421-0009		-660000	2026-04-21 00:46:55.718455+00	9	2026-04-21 00:46:55.719681+00	\N	+	3	2	2
10	100000	CASH	PAY-20260421-0010		-760000	2026-04-21 00:46:56.037447+00	10	2026-04-21 00:46:56.038824+00	\N	+	3	2	2
11	100000	CASH	PAY-20260421-0011		-860000	2026-04-21 00:46:56.304189+00	11	2026-04-21 00:46:56.305418+00	\N	+	3	2	2
12	100000	CASH	PAY-20260421-0012		-960000	2026-04-21 00:46:56.784936+00	12	2026-04-21 00:46:56.786228+00	\N	+	3	2	2
13	100000	CASH	PAY-20260421-0013		-1060000	2026-04-21 00:46:57.023757+00	13	2026-04-21 00:46:57.02515+00	\N	+	3	2	2
14	100000	CASH	PAY-20260421-0014		-1160000	2026-04-21 00:46:57.302663+00	14	2026-04-21 00:46:57.304272+00	\N	+	3	2	2
15	100000	CASH	PAY-20260421-0015		-1260000	2026-04-21 00:46:57.565206+00	15	2026-04-21 00:46:57.566617+00	\N	+	3	2	2
16	100000	CASH	PAY-20260421-0016		-1360000	2026-04-21 00:46:57.834369+00	16	2026-04-21 00:46:57.836013+00	\N	+	3	2	2
17	100000	CASH	PAY-20260421-0017		-1460000	2026-04-21 00:46:58.088935+00	17	2026-04-21 00:46:58.091104+00	\N	+	3	2	2
18	100000	CASH	PAY-20260421-0018		-1560000	2026-04-21 00:47:01.859308+00	18	2026-04-21 00:47:01.861897+00	\N	+	3	2	2
19	100000	CASH	PAY-20260421-0019		-1660000	2026-04-21 00:47:02.139521+00	19	2026-04-21 00:47:02.141281+00	\N	+	3	2	2
20	100000	CASH	PAY-20260421-0020		-1760000	2026-04-21 00:47:02.404696+00	20	2026-04-21 00:47:02.406477+00	\N	+	3	2	2
21	50000	CASH	PAY-20260421-0021		110000	2026-04-21 10:40:58.060042+00	21	2026-04-21 10:40:58.063517+00	\N	+	1	2	2
22	50000	CASH	PAY-20260421-0022		60000	2026-04-21 10:41:05.702847+00	22	2026-04-21 10:41:05.704244+00	\N	+	1	2	2
23	50000	CASH	PAY-20260421-0023		10000	2026-04-21 10:41:08.524077+00	23	2026-04-21 10:41:08.525618+00	\N	+	1	2	2
24	10000	CASH	PAY-20260421-0024		0	2026-04-21 10:42:09.866209+00	24	2026-04-21 10:42:09.868171+00	\N	+	1	2	2
25	25000	CASH	PAY-20260421-0025		455000	2026-04-21 10:49:48.260261+00	25	2026-04-21 10:49:48.261924+00	\N	+	1	2	2
26	12500	CASH	PAY-20260421-0026		442500	2026-04-21 11:01:43.203624+00	26	2026-04-21 11:01:43.206296+00	\N	+	1	2	2
27	50000	CASH	PAY-20260421-0027		392500	2026-04-21 11:02:14.964423+00	27	2026-04-21 11:02:14.965978+00	\N	+	1	2	2
28	92000	CASH	PAY-20260421-0028		300500	2026-04-21 11:16:24.241397+00	28	2026-04-21 11:16:24.243234+00	\N	+	1	2	2
29	150000	WAVE	PAY-20260425-0001		150500	2026-04-25 21:33:39.634781+00	29	2026-04-25 21:33:39.638423+00	\N	+	1	2	2
30	50500	CASH	PAY-20260425-0002		100000	2026-04-25 21:36:24.9779+00	30	2026-04-25 21:36:24.979671+00	\N	+	1	2	2
\.


--
-- Data for Name: sales_historicalsale; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.sales_historicalsale (id, invoice_number, type, total_amount, payment_method, created_at, updated_at, history_id, history_date, history_change_reason, history_type, history_user_id, seller_id, status, customer_phone, customer_id, customer_name, notes) FROM stdin;
1	FAC-20260411-0001	SALE	950000	CASH	2026-04-11 20:49:29.707838+00	2026-04-11 20:49:29.707849+00	1	2026-04-11 20:49:29.711486+00	\N	+	1	1	COMPLETED	\N	\N	\N	
2	PRO-20260411-0002	QUOTE	185000	CASH	2026-04-11 20:59:54.635239+00	2026-04-11 20:59:54.635252+00	2	2026-04-11 20:59:54.637369+00	\N	+	1	1	COMPLETED	\N	\N	\N	
3	PRO-20260411-0003	QUOTE	360000	CASH	2026-04-11 21:12:55.048324+00	2026-04-11 21:12:55.048337+00	3	2026-04-11 21:12:55.050988+00	\N	+	1	1	COMPLETED	\N	\N	\N	
4	PRO-20260411-0004	QUOTE	360000	CASH	2026-04-11 21:23:17.36761+00	2026-04-11 21:23:17.367623+00	4	2026-04-11 21:23:17.369842+00	\N	+	1	1	COMPLETED	\N	\N	\N	
5	FAC-20260411-0005	SALE	615000	CASH	2026-04-11 21:29:26.849369+00	2026-04-11 21:29:26.849381+00	5	2026-04-11 21:29:26.851273+00	\N	+	1	1	COMPLETED	\N	\N	\N	
8	FAC-20260411-0006	SALE	160000	CREDIT	2026-04-11 21:51:50.510278+00	2026-04-11 21:51:50.51029+00	8	2026-04-11 21:51:50.512354+00	\N	+	2	2	COMPLETED	\N	\N	\N	
10	FAC-20260414-0001	SALE	110000	CASH	2026-04-14 17:11:02.887949+00	2026-04-14 17:11:02.887962+00	10	2026-04-14 17:11:02.890222+00	\N	+	1	1	COMPLETED	\N	\N	\N	
11	FAC-20260418-0001	SALE	105000	CASH	2026-04-18 19:41:36.914084+00	2026-04-18 19:41:36.914097+00	11	2026-04-18 19:41:36.924219+00	\N	+	2	2	COMPLETED		\N	\N	
12	FAC-20260418-0002	SALE	55000	CASH	2026-04-18 19:43:50.322027+00	2026-04-18 19:43:50.322039+00	12	2026-04-18 19:43:50.32489+00	\N	+	2	2	COMPLETED	+22376541852	\N	\N	
13	FAC-20260418-0003	SALE	240000	CASH	2026-04-18 19:53:57.798088+00	2026-04-18 19:53:57.798149+00	13	2026-04-18 19:53:57.804148+00	\N	+	2	2	COMPLETED		\N	\N	
14	FAC-20260419-0001	SALE	240000	CASH	2026-04-19 12:51:51.607669+00	2026-04-19 12:51:51.607682+00	14	2026-04-19 12:51:51.621045+00	\N	+	2	2	COMPLETED		\N		
15	FAC-20260420-0001	SALE	240000	CASH	2026-04-20 01:24:12.248223+00	2026-04-20 01:24:12.248236+00	15	2026-04-20 01:24:12.252073+00	\N	+	2	2	COMPLETED		\N	mamadou	
16	FAC-20260420-0002	SALE	240000	CASH	2026-04-20 11:08:41.733939+00	2026-04-20 11:08:41.733953+00	16	2026-04-20 11:08:41.739101+00	\N	+	2	2	COMPLETED	+22373457616	1	Mamadou Sylla	
17	PRO-20260420-0001	QUOTE	240000	CASH	2026-04-20 11:10:02.486297+00	2026-04-20 11:10:02.486312+00	17	2026-04-20 11:10:02.488837+00	\N	+	2	2	PENDING		\N	Moussa	
18	FAC-20260420-0003	SALE	160000	CREDIT	2026-04-20 12:37:34.463068+00	2026-04-20 12:37:34.463083+00	18	2026-04-20 12:37:34.469845+00	\N	+	2	2	COMPLETED	+22373457616	1	Mamadou Sylla	
19	FAC-20260420-0004	SALE	240000	CREDIT	2026-04-20 12:38:11.246732+00	2026-04-20 12:38:11.246744+00	19	2026-04-20 12:38:11.249943+00	\N	+	2	2	COMPLETED	+22390877889	3	Mamadou Diarra	
20	FAC-20260421-0001	SALE	480000	CREDIT	2026-04-21 10:49:17.036821+00	2026-04-21 10:49:17.036838+00	20	2026-04-21 10:49:17.042079+00	\N	+	2	2	COMPLETED	+22373457616	1	Mamadou Sylla	
21	FAC-20260423-0001	SALE	240000	CASH	2026-04-23 23:27:32.681942+00	2026-04-23 23:27:32.681957+00	21	2026-04-23 23:27:32.686692+00	\N	+	2	2	COMPLETED	+22373457616	1	Mamadou Sylla	
21	FAC-20260423-0001	SALE	240000	CASH	2026-04-23 23:27:32.681942+00	2026-04-24 00:55:06.586783+00	22	2026-04-24 00:55:06.590247+00	\N	~	1	2	CANCELLED	+22373457616	1	Mamadou Sylla	\nAnnulée par admin_sylla le 24/04/2026 00:55
22	FAC-20260425-0001	SALE	240000	CREDIT	2026-04-25 21:33:00.451765+00	2026-04-25 21:33:00.451778+00	23	2026-04-25 21:33:00.455773+00	\N	+	2	2	COMPLETED	+22390877889	3	Mamadou Diarra	
\.


--
-- Data for Name: sales_historicalsaleitem; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.sales_historicalsaleitem (id, quantity, unit, unit_price, total_line, history_id, history_date, history_change_reason, history_type, history_user_id, product_id, sale_id) FROM stdin;
36	2	PIECE	80000	160000	1	2026-04-20 12:37:34.528177+00	\N	+	2	5	18
37	1	CARTON	160000	160000	2	2026-04-20 12:38:11.264399+00	\N	+	2	5	19
38	1	PIECE	80000	80000	3	2026-04-20 12:38:11.28804+00	\N	+	2	5	19
39	2	PIECE	80000	160000	4	2026-04-21 10:49:17.063885+00	\N	+	2	5	20
40	2	CARTON	160000	320000	5	2026-04-21 10:49:17.092007+00	\N	+	2	5	20
41	1	PIECE	80000	80000	6	2026-04-23 23:27:32.703547+00	\N	+	2	5	21
42	1	CARTON	160000	160000	7	2026-04-23 23:27:32.73335+00	\N	+	2	5	21
43	1	PIECE	80000	80000	8	2026-04-25 21:33:00.478149+00	\N	+	2	5	22
44	1	CARTON	160000	160000	9	2026-04-25 21:33:00.503578+00	\N	+	2	5	22
\.


--
-- Data for Name: sales_payment; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.sales_payment (id, amount, payment_method, reference, notes, balance_after, created_at, customer_id, received_by_id) FROM stdin;
1	100000	CASH	PAY-20260421-0001		140000	2026-04-21 00:46:51.419042+00	3	2
2	100000	CASH	PAY-20260421-0002		40000	2026-04-21 00:46:52.809815+00	3	2
3	100000	CASH	PAY-20260421-0003		-60000	2026-04-21 00:46:54.069764+00	3	2
4	100000	CASH	PAY-20260421-0004		-160000	2026-04-21 00:46:54.335187+00	3	2
5	100000	CASH	PAY-20260421-0005		-260000	2026-04-21 00:46:54.622282+00	3	2
6	100000	CASH	PAY-20260421-0006		-360000	2026-04-21 00:46:54.905601+00	3	2
7	100000	CASH	PAY-20260421-0007		-460000	2026-04-21 00:46:55.167832+00	3	2
8	100000	CASH	PAY-20260421-0008		-560000	2026-04-21 00:46:55.427031+00	3	2
9	100000	CASH	PAY-20260421-0009		-660000	2026-04-21 00:46:55.718455+00	3	2
10	100000	CASH	PAY-20260421-0010		-760000	2026-04-21 00:46:56.037447+00	3	2
11	100000	CASH	PAY-20260421-0011		-860000	2026-04-21 00:46:56.304189+00	3	2
12	100000	CASH	PAY-20260421-0012		-960000	2026-04-21 00:46:56.784936+00	3	2
13	100000	CASH	PAY-20260421-0013		-1060000	2026-04-21 00:46:57.023757+00	3	2
14	100000	CASH	PAY-20260421-0014		-1160000	2026-04-21 00:46:57.302663+00	3	2
15	100000	CASH	PAY-20260421-0015		-1260000	2026-04-21 00:46:57.565206+00	3	2
16	100000	CASH	PAY-20260421-0016		-1360000	2026-04-21 00:46:57.834369+00	3	2
17	100000	CASH	PAY-20260421-0017		-1460000	2026-04-21 00:46:58.088935+00	3	2
18	100000	CASH	PAY-20260421-0018		-1560000	2026-04-21 00:47:01.859308+00	3	2
19	100000	CASH	PAY-20260421-0019		-1660000	2026-04-21 00:47:02.139521+00	3	2
20	100000	CASH	PAY-20260421-0020		-1760000	2026-04-21 00:47:02.404696+00	3	2
21	50000	CASH	PAY-20260421-0021		110000	2026-04-21 10:40:58.060042+00	1	2
22	50000	CASH	PAY-20260421-0022		60000	2026-04-21 10:41:05.702847+00	1	2
23	50000	CASH	PAY-20260421-0023		10000	2026-04-21 10:41:08.524077+00	1	2
24	10000	CASH	PAY-20260421-0024		0	2026-04-21 10:42:09.866209+00	1	2
25	25000	CASH	PAY-20260421-0025		455000	2026-04-21 10:49:48.260261+00	1	2
26	12500	CASH	PAY-20260421-0026		442500	2026-04-21 11:01:43.203624+00	1	2
27	50000	CASH	PAY-20260421-0027		392500	2026-04-21 11:02:14.964423+00	1	2
28	92000	CASH	PAY-20260421-0028		300500	2026-04-21 11:16:24.241397+00	1	2
29	150000	WAVE	PAY-20260425-0001		150500	2026-04-25 21:33:39.634781+00	1	2
30	50500	CASH	PAY-20260425-0002		100000	2026-04-25 21:36:24.9779+00	1	2
\.


--
-- Data for Name: sales_sale; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.sales_sale (id, invoice_number, type, total_amount, payment_method, created_at, updated_at, seller_id, status, customer_phone, customer_id, customer_name, notes) FROM stdin;
1	FAC-20260411-0001	SALE	950000	CASH	2026-04-11 20:49:29.707838+00	2026-04-11 20:49:29.707849+00	1	COMPLETED	\N	\N	\N	
2	PRO-20260411-0002	QUOTE	185000	CASH	2026-04-11 20:59:54.635239+00	2026-04-11 20:59:54.635252+00	1	COMPLETED	\N	\N	\N	
3	PRO-20260411-0003	QUOTE	360000	CASH	2026-04-11 21:12:55.048324+00	2026-04-11 21:12:55.048337+00	1	COMPLETED	\N	\N	\N	
4	PRO-20260411-0004	QUOTE	360000	CASH	2026-04-11 21:23:17.36761+00	2026-04-11 21:23:17.367623+00	1	COMPLETED	\N	\N	\N	
5	FAC-20260411-0005	SALE	615000	CASH	2026-04-11 21:29:26.849369+00	2026-04-11 21:29:26.849381+00	1	COMPLETED	\N	\N	\N	
8	FAC-20260411-0006	SALE	160000	CREDIT	2026-04-11 21:51:50.510278+00	2026-04-11 21:51:50.51029+00	2	COMPLETED	\N	\N	\N	
10	FAC-20260414-0001	SALE	110000	CASH	2026-04-14 17:11:02.887949+00	2026-04-14 17:11:02.887962+00	1	COMPLETED	\N	\N	\N	
11	FAC-20260418-0001	SALE	105000	CASH	2026-04-18 19:41:36.914084+00	2026-04-18 19:41:36.914097+00	2	COMPLETED		\N	\N	
12	FAC-20260418-0002	SALE	55000	CASH	2026-04-18 19:43:50.322027+00	2026-04-18 19:43:50.322039+00	2	COMPLETED	+22376541852	\N	\N	
13	FAC-20260418-0003	SALE	240000	CASH	2026-04-18 19:53:57.798088+00	2026-04-18 19:53:57.798149+00	2	COMPLETED		\N	\N	
14	FAC-20260419-0001	SALE	240000	CASH	2026-04-19 12:51:51.607669+00	2026-04-19 12:51:51.607682+00	2	COMPLETED		\N		
15	FAC-20260420-0001	SALE	240000	CASH	2026-04-20 01:24:12.248223+00	2026-04-20 01:24:12.248236+00	2	COMPLETED		\N	mamadou	
16	FAC-20260420-0002	SALE	240000	CASH	2026-04-20 11:08:41.733939+00	2026-04-20 11:08:41.733953+00	2	COMPLETED	+22373457616	1	Mamadou Sylla	
17	PRO-20260420-0001	QUOTE	240000	CASH	2026-04-20 11:10:02.486297+00	2026-04-20 11:10:02.486312+00	2	PENDING		\N	Moussa	
18	FAC-20260420-0003	SALE	160000	CREDIT	2026-04-20 12:37:34.463068+00	2026-04-20 12:37:34.463083+00	2	COMPLETED	+22373457616	1	Mamadou Sylla	
19	FAC-20260420-0004	SALE	240000	CREDIT	2026-04-20 12:38:11.246732+00	2026-04-20 12:38:11.246744+00	2	COMPLETED	+22390877889	3	Mamadou Diarra	
20	FAC-20260421-0001	SALE	480000	CREDIT	2026-04-21 10:49:17.036821+00	2026-04-21 10:49:17.036838+00	2	COMPLETED	+22373457616	1	Mamadou Sylla	
21	FAC-20260423-0001	SALE	240000	CASH	2026-04-23 23:27:32.681942+00	2026-04-24 00:55:06.586783+00	2	CANCELLED	+22373457616	1	Mamadou Sylla	\nAnnulée par admin_sylla le 24/04/2026 00:55
22	FAC-20260425-0001	SALE	240000	CREDIT	2026-04-25 21:33:00.451765+00	2026-04-25 21:33:00.451778+00	2	COMPLETED	+22390877889	3	Mamadou Diarra	
\.


--
-- Data for Name: sales_saleitem; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.sales_saleitem (id, quantity, unit, unit_price, total_line, product_id, sale_id) FROM stdin;
1	3	CARTON	175000	525000	2	1
2	3	CARTON	105000	315000	3	1
3	2	PIECE	55000	110000	3	1
4	1	PIECE	25000	25000	2	2
5	1	CARTON	105000	105000	3	2
6	1	PIECE	55000	55000	3	2
7	1	PIECE	25000	25000	2	3
8	1	CARTON	175000	175000	2	3
9	1	PIECE	55000	55000	3	3
10	1	CARTON	105000	105000	3	3
11	1	PIECE	25000	25000	2	4
12	1	PIECE	55000	55000	3	4
13	1	CARTON	105000	105000	3	4
14	1	CARTON	175000	175000	2	4
15	2	CARTON	175000	350000	2	5
16	2	PIECE	25000	50000	2	5
17	1	CARTON	105000	105000	3	5
18	2	PIECE	55000	110000	3	5
21	1	CARTON	105000	105000	3	8
22	1	PIECE	55000	55000	3	8
24	2	PIECE	55000	110000	3	10
25	1	CARTON	105000	105000	3	11
26	1	PIECE	55000	55000	3	12
27	1	PIECE	80000	80000	5	13
28	1	CARTON	160000	160000	5	13
29	3	PIECE	80000	240000	5	14
30	1	PIECE	80000	80000	5	15
31	1	CARTON	160000	160000	5	15
32	1	PIECE	80000	80000	5	16
33	1	CARTON	160000	160000	5	16
34	1	PIECE	80000	80000	5	17
35	1	CARTON	160000	160000	5	17
36	2	PIECE	80000	160000	5	18
37	1	CARTON	160000	160000	5	19
38	1	PIECE	80000	80000	5	19
39	2	PIECE	80000	160000	5	20
40	2	CARTON	160000	320000	5	20
41	1	PIECE	80000	80000	5	21
42	1	CARTON	160000	160000	5	21
43	1	PIECE	80000	80000	5	22
44	1	CARTON	160000	160000	5	22
\.


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.socialaccount_socialapp (id, provider, name, client_id, secret, key, provider_id, settings) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
\.


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.users_user (id, password, last_login, is_superuser, username, email, is_staff, is_active, date_joined, name, role, assigned_warehouse_id) FROM stdin;
2	argon2$argon2id$v=19$m=102400,t=2,p=8$WkFXOUNSSzRtd3V4UFlMa0RaRVBMNQ$RUwtO9HteItfxUGlqZ9RiI1VOkEi5ui9i0GZBE6gN2c	2026-04-23 23:26:51.361868+00	f	vendeur_sylla	vendeur@erp-sylla.com	f	t	2026-04-11 12:32:43.420475+00	Oumar Sylla	VENDEUR	1
1	argon2$argon2id$v=19$m=102400,t=2,p=8$a0l5R0lBTTg1ZGZSUEhoWVlObEdORA$Z0PlH2+zt47/IckKJqi1dFR9eM875aD7RogiuAzWcis	2026-04-25 21:59:36.289398+00	t	admin_sylla	admin@erp-sylla.com	t	t	2026-04-11 12:32:42.518051+00		GERANT	\N
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.users_user_groups (id, user_id, group_id) FROM stdin;
1	1	1
2	2	2
\.


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: maliandevboy
--

COPY public.users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.account_emailaddress_id_seq', 1, true);


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.account_emailconfirmation_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 2, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 10, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 176, true);


--
-- Name: communications_communicationconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.communications_communicationconfig_id_seq', 1, false);


--
-- Name: communications_dailyreport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.communications_dailyreport_id_seq', 1, false);


--
-- Name: communications_whatsappnotification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.communications_whatsappnotification_id_seq', 37, true);


--
-- Name: core_audittestmodel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.core_audittestmodel_id_seq', 1, true);


--
-- Name: core_databasebackup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.core_databasebackup_id_seq', 1, false);


--
-- Name: core_expense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.core_expense_id_seq', 1, true);


--
-- Name: core_expensecategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.core_expensecategory_id_seq', 9, true);


--
-- Name: core_historicalaudittestmodel_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.core_historicalaudittestmodel_history_id_seq', 2, true);


--
-- Name: core_historicalexpense_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.core_historicalexpense_history_id_seq', 1, true);


--
-- Name: core_historicalreleasecode_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.core_historicalreleasecode_history_id_seq', 1, false);


--
-- Name: core_releasecode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.core_releasecode_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_celery_beat_clockedschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_celery_beat_crontabschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_celery_beat_intervalschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_celery_beat_periodictask_id_seq', 1, false);


--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_celery_beat_solarschedule_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 44, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 85, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.django_site_id_seq', 2, false);


--
-- Name: inventory_historicalproduct_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.inventory_historicalproduct_history_id_seq', 9, true);


--
-- Name: inventory_historicalstocktransaction_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.inventory_historicalstocktransaction_history_id_seq', 60, true);


--
-- Name: inventory_historicalwarehouse_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.inventory_historicalwarehouse_history_id_seq', 2, true);


--
-- Name: inventory_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.inventory_product_id_seq', 5, true);


--
-- Name: inventory_stocktransaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.inventory_stocktransaction_id_seq', 48, true);


--
-- Name: inventory_warehouse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.inventory_warehouse_id_seq', 2, true);


--
-- Name: mfa_authenticator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.mfa_authenticator_id_seq', 1, false);


--
-- Name: sales_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.sales_customer_id_seq', 3, true);


--
-- Name: sales_historicalcustomer_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.sales_historicalcustomer_history_id_seq', 37, true);


--
-- Name: sales_historicalpayment_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.sales_historicalpayment_history_id_seq', 30, true);


--
-- Name: sales_historicalsale_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.sales_historicalsale_history_id_seq', 23, true);


--
-- Name: sales_historicalsaleitem_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.sales_historicalsaleitem_history_id_seq', 9, true);


--
-- Name: sales_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.sales_payment_id_seq', 30, true);


--
-- Name: sales_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.sales_sale_id_seq', 22, true);


--
-- Name: sales_saleitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.sales_saleitem_id_seq', 44, true);


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.socialaccount_socialaccount_id_seq', 1, false);


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_id_seq', 1, false);


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_sites_id_seq', 1, false);


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.socialaccount_socialtoken_id_seq', 1, false);


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.users_user_groups_id_seq', 14, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.users_user_id_seq', 2, true);


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: maliandevboy
--

SELECT pg_catalog.setval('public.users_user_user_permissions_id_seq', 1, false);


--
-- Name: account_emailaddress account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress account_emailaddress_user_id_email_987c8728_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_email_987c8728_uniq UNIQUE (user_id, email);


--
-- Name: account_emailconfirmation account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: communications_communicationconfig communications_communicationconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.communications_communicationconfig
    ADD CONSTRAINT communications_communicationconfig_pkey PRIMARY KEY (id);


--
-- Name: communications_dailyreport communications_dailyreport_date_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.communications_dailyreport
    ADD CONSTRAINT communications_dailyreport_date_key UNIQUE (date);


--
-- Name: communications_dailyreport communications_dailyreport_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.communications_dailyreport
    ADD CONSTRAINT communications_dailyreport_pkey PRIMARY KEY (id);


--
-- Name: communications_dailyreport communications_dailyreport_token_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.communications_dailyreport
    ADD CONSTRAINT communications_dailyreport_token_key UNIQUE (token);


--
-- Name: communications_whatsappnotification communications_whatsappnotification_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.communications_whatsappnotification
    ADD CONSTRAINT communications_whatsappnotification_pkey PRIMARY KEY (id);


--
-- Name: communications_whatsappnotification communications_whatsappnotification_token_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.communications_whatsappnotification
    ADD CONSTRAINT communications_whatsappnotification_token_key UNIQUE (token);


--
-- Name: core_audittestmodel core_audittestmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_audittestmodel
    ADD CONSTRAINT core_audittestmodel_pkey PRIMARY KEY (id);


--
-- Name: core_databasebackup core_databasebackup_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_databasebackup
    ADD CONSTRAINT core_databasebackup_pkey PRIMARY KEY (id);


--
-- Name: core_expense core_expense_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_expense
    ADD CONSTRAINT core_expense_pkey PRIMARY KEY (id);


--
-- Name: core_expensecategory core_expensecategory_name_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_expensecategory
    ADD CONSTRAINT core_expensecategory_name_key UNIQUE (name);


--
-- Name: core_expensecategory core_expensecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_expensecategory
    ADD CONSTRAINT core_expensecategory_pkey PRIMARY KEY (id);


--
-- Name: core_historicalaudittestmodel core_historicalaudittestmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_historicalaudittestmodel
    ADD CONSTRAINT core_historicalaudittestmodel_pkey PRIMARY KEY (history_id);


--
-- Name: core_historicalexpense core_historicalexpense_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_historicalexpense
    ADD CONSTRAINT core_historicalexpense_pkey PRIMARY KEY (history_id);


--
-- Name: core_historicalreleasecode core_historicalreleasecode_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_historicalreleasecode
    ADD CONSTRAINT core_historicalreleasecode_pkey PRIMARY KEY (history_id);


--
-- Name: core_releasecode core_releasecode_code_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_releasecode
    ADD CONSTRAINT core_releasecode_code_key UNIQUE (code);


--
-- Name: core_releasecode core_releasecode_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_releasecode
    ADD CONSTRAINT core_releasecode_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_clockedschedule django_celery_beat_clockedschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule
    ADD CONSTRAINT django_celery_beat_clockedschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_crontabschedule django_celery_beat_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule
    ADD CONSTRAINT django_celery_beat_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_intervalschedule django_celery_beat_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule
    ADD CONSTRAINT django_celery_beat_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_name_key UNIQUE (name);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictasks django_celery_beat_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_periodictasks
    ADD CONSTRAINT django_celery_beat_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq UNIQUE (event, latitude, longitude);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solarschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solarschedule_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: inventory_historicalproduct inventory_historicalproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_historicalproduct
    ADD CONSTRAINT inventory_historicalproduct_pkey PRIMARY KEY (history_id);


--
-- Name: inventory_historicalstocktransaction inventory_historicalstocktransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_historicalstocktransaction
    ADD CONSTRAINT inventory_historicalstocktransaction_pkey PRIMARY KEY (history_id);


--
-- Name: inventory_historicalwarehouse inventory_historicalwarehouse_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_historicalwarehouse
    ADD CONSTRAINT inventory_historicalwarehouse_pkey PRIMARY KEY (history_id);


--
-- Name: inventory_product inventory_product_barcode_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_product
    ADD CONSTRAINT inventory_product_barcode_key UNIQUE (barcode);


--
-- Name: inventory_product inventory_product_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_product
    ADD CONSTRAINT inventory_product_pkey PRIMARY KEY (id);


--
-- Name: inventory_product inventory_product_sku_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_product
    ADD CONSTRAINT inventory_product_sku_key UNIQUE (sku);


--
-- Name: inventory_stocktransaction inventory_stocktransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_stocktransaction
    ADD CONSTRAINT inventory_stocktransaction_pkey PRIMARY KEY (id);


--
-- Name: inventory_warehouse inventory_warehouse_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_warehouse
    ADD CONSTRAINT inventory_warehouse_pkey PRIMARY KEY (id);


--
-- Name: mfa_authenticator mfa_authenticator_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.mfa_authenticator
    ADD CONSTRAINT mfa_authenticator_pkey PRIMARY KEY (id);


--
-- Name: sales_customer sales_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_customer
    ADD CONSTRAINT sales_customer_pkey PRIMARY KEY (id);


--
-- Name: sales_historicalcustomer sales_historicalcustomer_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_historicalcustomer
    ADD CONSTRAINT sales_historicalcustomer_pkey PRIMARY KEY (history_id);


--
-- Name: sales_historicalpayment sales_historicalpayment_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_historicalpayment
    ADD CONSTRAINT sales_historicalpayment_pkey PRIMARY KEY (history_id);


--
-- Name: sales_historicalsale sales_historicalsale_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_historicalsale
    ADD CONSTRAINT sales_historicalsale_pkey PRIMARY KEY (history_id);


--
-- Name: sales_historicalsaleitem sales_historicalsaleitem_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_historicalsaleitem
    ADD CONSTRAINT sales_historicalsaleitem_pkey PRIMARY KEY (history_id);


--
-- Name: sales_payment sales_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_payment
    ADD CONSTRAINT sales_payment_pkey PRIMARY KEY (id);


--
-- Name: sales_payment sales_payment_reference_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_payment
    ADD CONSTRAINT sales_payment_reference_key UNIQUE (reference);


--
-- Name: sales_sale sales_sale_invoice_number_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_sale
    ADD CONSTRAINT sales_sale_invoice_number_key UNIQUE (invoice_number);


--
-- Name: sales_sale sales_sale_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_sale
    ADD CONSTRAINT sales_sale_pkey PRIMARY KEY (id);


--
-- Name: sales_saleitem sales_saleitem_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_saleitem
    ADD CONSTRAINT sales_saleitem_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_provider_uid_fc810c6e_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_uid_fc810c6e_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialapp socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_user_id_group_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_permission_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: account_emailaddress_email_03be32b2; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX account_emailaddress_email_03be32b2 ON public.account_emailaddress USING btree (email);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON public.account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailaddress_user_id_2c513194; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);


--
-- Name: account_emailconfirmation_email_address_id_5b7f8c58; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: communications_whatsappnotification_sale_id_7ad31ee7; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX communications_whatsappnotification_sale_id_7ad31ee7 ON public.communications_whatsappnotification USING btree (sale_id);


--
-- Name: core_expense_category_id_dcdb74b3; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_expense_category_id_dcdb74b3 ON public.core_expense USING btree (category_id);


--
-- Name: core_expense_recorded_by_id_b2fff93e; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_expense_recorded_by_id_b2fff93e ON public.core_expense USING btree (recorded_by_id);


--
-- Name: core_expensecategory_name_aaa0c3d3_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_expensecategory_name_aaa0c3d3_like ON public.core_expensecategory USING btree (name varchar_pattern_ops);


--
-- Name: core_historicalaudittestmodel_history_date_ee6441df; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalaudittestmodel_history_date_ee6441df ON public.core_historicalaudittestmodel USING btree (history_date);


--
-- Name: core_historicalaudittestmodel_history_user_id_18c8e9f9; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalaudittestmodel_history_user_id_18c8e9f9 ON public.core_historicalaudittestmodel USING btree (history_user_id);


--
-- Name: core_historicalaudittestmodel_id_34ee7607; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalaudittestmodel_id_34ee7607 ON public.core_historicalaudittestmodel USING btree (id);


--
-- Name: core_historicalexpense_category_id_2a0e38a9; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalexpense_category_id_2a0e38a9 ON public.core_historicalexpense USING btree (category_id);


--
-- Name: core_historicalexpense_history_date_f822ea07; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalexpense_history_date_f822ea07 ON public.core_historicalexpense USING btree (history_date);


--
-- Name: core_historicalexpense_history_user_id_ed5edfa1; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalexpense_history_user_id_ed5edfa1 ON public.core_historicalexpense USING btree (history_user_id);


--
-- Name: core_historicalexpense_id_574d74eb; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalexpense_id_574d74eb ON public.core_historicalexpense USING btree (id);


--
-- Name: core_historicalexpense_recorded_by_id_5d1312b3; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalexpense_recorded_by_id_5d1312b3 ON public.core_historicalexpense USING btree (recorded_by_id);


--
-- Name: core_historicalreleasecode_code_094fdfad; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalreleasecode_code_094fdfad ON public.core_historicalreleasecode USING btree (code);


--
-- Name: core_historicalreleasecode_code_094fdfad_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalreleasecode_code_094fdfad_like ON public.core_historicalreleasecode USING btree (code varchar_pattern_ops);


--
-- Name: core_historicalreleasecode_created_by_id_e53b4cfd; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalreleasecode_created_by_id_e53b4cfd ON public.core_historicalreleasecode USING btree (created_by_id);


--
-- Name: core_historicalreleasecode_history_date_1a3ceecd; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalreleasecode_history_date_1a3ceecd ON public.core_historicalreleasecode USING btree (history_date);


--
-- Name: core_historicalreleasecode_history_user_id_5a170592; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalreleasecode_history_user_id_5a170592 ON public.core_historicalreleasecode USING btree (history_user_id);


--
-- Name: core_historicalreleasecode_id_4dafc17f; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalreleasecode_id_4dafc17f ON public.core_historicalreleasecode USING btree (id);


--
-- Name: core_historicalreleasecode_used_by_id_9e7efa8c; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_historicalreleasecode_used_by_id_9e7efa8c ON public.core_historicalreleasecode USING btree (used_by_id);


--
-- Name: core_releasecode_code_f093d73a_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_releasecode_code_f093d73a_like ON public.core_releasecode USING btree (code varchar_pattern_ops);


--
-- Name: core_releasecode_created_by_id_995a897d; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_releasecode_created_by_id_995a897d ON public.core_releasecode USING btree (created_by_id);


--
-- Name: core_releasecode_used_by_id_f6b72843; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX core_releasecode_used_by_id_f6b72843 ON public.core_releasecode USING btree (used_by_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_celery_beat_periodictask_clocked_id_47a69f82; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_celery_beat_periodictask_clocked_id_47a69f82 ON public.django_celery_beat_periodictask USING btree (clocked_id);


--
-- Name: django_celery_beat_periodictask_crontab_id_d3cba168; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_celery_beat_periodictask_crontab_id_d3cba168 ON public.django_celery_beat_periodictask USING btree (crontab_id);


--
-- Name: django_celery_beat_periodictask_interval_id_a8ca27da; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_celery_beat_periodictask_interval_id_a8ca27da ON public.django_celery_beat_periodictask USING btree (interval_id);


--
-- Name: django_celery_beat_periodictask_name_265a36b7_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_celery_beat_periodictask_name_265a36b7_like ON public.django_celery_beat_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: django_celery_beat_periodictask_solar_id_a87ce72c; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_celery_beat_periodictask_solar_id_a87ce72c ON public.django_celery_beat_periodictask USING btree (solar_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: inventory_historicalproduct_barcode_0480f0ce; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalproduct_barcode_0480f0ce ON public.inventory_historicalproduct USING btree (barcode);


--
-- Name: inventory_historicalproduct_barcode_0480f0ce_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalproduct_barcode_0480f0ce_like ON public.inventory_historicalproduct USING btree (barcode varchar_pattern_ops);


--
-- Name: inventory_historicalproduct_history_date_3e1a739c; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalproduct_history_date_3e1a739c ON public.inventory_historicalproduct USING btree (history_date);


--
-- Name: inventory_historicalproduct_history_user_id_61ecbda7; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalproduct_history_user_id_61ecbda7 ON public.inventory_historicalproduct USING btree (history_user_id);


--
-- Name: inventory_historicalproduct_id_02f78ad9; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalproduct_id_02f78ad9 ON public.inventory_historicalproduct USING btree (id);


--
-- Name: inventory_historicalproduct_sku_82526047; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalproduct_sku_82526047 ON public.inventory_historicalproduct USING btree (sku);


--
-- Name: inventory_historicalproduct_sku_82526047_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalproduct_sku_82526047_like ON public.inventory_historicalproduct USING btree (sku varchar_pattern_ops);


--
-- Name: inventory_historicalstocktransaction_history_date_3a21f60d; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalstocktransaction_history_date_3a21f60d ON public.inventory_historicalstocktransaction USING btree (history_date);


--
-- Name: inventory_historicalstocktransaction_history_user_id_93858482; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalstocktransaction_history_user_id_93858482 ON public.inventory_historicalstocktransaction USING btree (history_user_id);


--
-- Name: inventory_historicalstocktransaction_id_1a64a2a7; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalstocktransaction_id_1a64a2a7 ON public.inventory_historicalstocktransaction USING btree (id);


--
-- Name: inventory_historicalstocktransaction_product_id_0be3d71c; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalstocktransaction_product_id_0be3d71c ON public.inventory_historicalstocktransaction USING btree (product_id);


--
-- Name: inventory_historicalstocktransaction_to_warehouse_id_c0cd85b7; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalstocktransaction_to_warehouse_id_c0cd85b7 ON public.inventory_historicalstocktransaction USING btree (to_warehouse_id);


--
-- Name: inventory_historicalstocktransaction_warehouse_id_8fa5c4c1; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalstocktransaction_warehouse_id_8fa5c4c1 ON public.inventory_historicalstocktransaction USING btree (warehouse_id);


--
-- Name: inventory_historicalwarehouse_history_date_c3103f39; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalwarehouse_history_date_c3103f39 ON public.inventory_historicalwarehouse USING btree (history_date);


--
-- Name: inventory_historicalwarehouse_history_user_id_c9027fb5; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalwarehouse_history_user_id_c9027fb5 ON public.inventory_historicalwarehouse USING btree (history_user_id);


--
-- Name: inventory_historicalwarehouse_id_5baca775; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_historicalwarehouse_id_5baca775 ON public.inventory_historicalwarehouse USING btree (id);


--
-- Name: inventory_product_barcode_69d7d92c_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_product_barcode_69d7d92c_like ON public.inventory_product USING btree (barcode varchar_pattern_ops);


--
-- Name: inventory_product_sku_2aad2a63_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_product_sku_2aad2a63_like ON public.inventory_product USING btree (sku varchar_pattern_ops);


--
-- Name: inventory_stocktransaction_product_id_6432f3fb; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_stocktransaction_product_id_6432f3fb ON public.inventory_stocktransaction USING btree (product_id);


--
-- Name: inventory_stocktransaction_to_warehouse_id_a035bea4; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_stocktransaction_to_warehouse_id_a035bea4 ON public.inventory_stocktransaction USING btree (to_warehouse_id);


--
-- Name: inventory_stocktransaction_warehouse_id_deef05ac; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX inventory_stocktransaction_warehouse_id_deef05ac ON public.inventory_stocktransaction USING btree (warehouse_id);


--
-- Name: mfa_authenticator_user_id_0c3a50c0; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX mfa_authenticator_user_id_0c3a50c0 ON public.mfa_authenticator USING btree (user_id);


--
-- Name: sales_historicalcustomer_history_date_e904161d; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalcustomer_history_date_e904161d ON public.sales_historicalcustomer USING btree (history_date);


--
-- Name: sales_historicalcustomer_history_user_id_bdb5b6b6; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalcustomer_history_user_id_bdb5b6b6 ON public.sales_historicalcustomer USING btree (history_user_id);


--
-- Name: sales_historicalcustomer_id_e3614027; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalcustomer_id_e3614027 ON public.sales_historicalcustomer USING btree (id);


--
-- Name: sales_historicalpayment_customer_id_ee4f5dae; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalpayment_customer_id_ee4f5dae ON public.sales_historicalpayment USING btree (customer_id);


--
-- Name: sales_historicalpayment_history_date_d63ef693; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalpayment_history_date_d63ef693 ON public.sales_historicalpayment USING btree (history_date);


--
-- Name: sales_historicalpayment_history_user_id_fc35d9f8; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalpayment_history_user_id_fc35d9f8 ON public.sales_historicalpayment USING btree (history_user_id);


--
-- Name: sales_historicalpayment_id_52139224; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalpayment_id_52139224 ON public.sales_historicalpayment USING btree (id);


--
-- Name: sales_historicalpayment_received_by_id_231c542c; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalpayment_received_by_id_231c542c ON public.sales_historicalpayment USING btree (received_by_id);


--
-- Name: sales_historicalpayment_reference_d9103091; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalpayment_reference_d9103091 ON public.sales_historicalpayment USING btree (reference);


--
-- Name: sales_historicalpayment_reference_d9103091_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalpayment_reference_d9103091_like ON public.sales_historicalpayment USING btree (reference varchar_pattern_ops);


--
-- Name: sales_historicalsale_customer_id_a7bce04b; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsale_customer_id_a7bce04b ON public.sales_historicalsale USING btree (customer_id);


--
-- Name: sales_historicalsale_history_date_5f081278; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsale_history_date_5f081278 ON public.sales_historicalsale USING btree (history_date);


--
-- Name: sales_historicalsale_history_user_id_11ceb754; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsale_history_user_id_11ceb754 ON public.sales_historicalsale USING btree (history_user_id);


--
-- Name: sales_historicalsale_id_8c416b86; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsale_id_8c416b86 ON public.sales_historicalsale USING btree (id);


--
-- Name: sales_historicalsale_invoice_number_9c8baf23; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsale_invoice_number_9c8baf23 ON public.sales_historicalsale USING btree (invoice_number);


--
-- Name: sales_historicalsale_invoice_number_9c8baf23_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsale_invoice_number_9c8baf23_like ON public.sales_historicalsale USING btree (invoice_number varchar_pattern_ops);


--
-- Name: sales_historicalsale_seller_id_926bbc25; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsale_seller_id_926bbc25 ON public.sales_historicalsale USING btree (seller_id);


--
-- Name: sales_historicalsaleitem_history_date_c011a62c; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsaleitem_history_date_c011a62c ON public.sales_historicalsaleitem USING btree (history_date);


--
-- Name: sales_historicalsaleitem_history_user_id_4c052ebe; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsaleitem_history_user_id_4c052ebe ON public.sales_historicalsaleitem USING btree (history_user_id);


--
-- Name: sales_historicalsaleitem_id_3cc5e1a9; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsaleitem_id_3cc5e1a9 ON public.sales_historicalsaleitem USING btree (id);


--
-- Name: sales_historicalsaleitem_product_id_947d640f; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsaleitem_product_id_947d640f ON public.sales_historicalsaleitem USING btree (product_id);


--
-- Name: sales_historicalsaleitem_sale_id_4652e58d; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_historicalsaleitem_sale_id_4652e58d ON public.sales_historicalsaleitem USING btree (sale_id);


--
-- Name: sales_payment_customer_id_a80e1f14; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_payment_customer_id_a80e1f14 ON public.sales_payment USING btree (customer_id);


--
-- Name: sales_payment_received_by_id_82d5232b; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_payment_received_by_id_82d5232b ON public.sales_payment USING btree (received_by_id);


--
-- Name: sales_payment_reference_842837cc_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_payment_reference_842837cc_like ON public.sales_payment USING btree (reference varchar_pattern_ops);


--
-- Name: sales_sale_customer_id_2d66a408; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_sale_customer_id_2d66a408 ON public.sales_sale USING btree (customer_id);


--
-- Name: sales_sale_invoice_number_a14f1a3f_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_sale_invoice_number_a14f1a3f_like ON public.sales_sale USING btree (invoice_number varchar_pattern_ops);


--
-- Name: sales_sale_seller_id_45166e30; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_sale_seller_id_45166e30 ON public.sales_sale USING btree (seller_id);


--
-- Name: sales_saleitem_product_id_aeb6c9cd; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_saleitem_product_id_aeb6c9cd ON public.sales_saleitem USING btree (product_id);


--
-- Name: sales_saleitem_sale_id_56e67045; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX sales_saleitem_sale_id_56e67045 ON public.sales_saleitem USING btree (sale_id);


--
-- Name: socialaccount_socialaccount_user_id_8146e70c; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX socialaccount_socialaccount_user_id_8146e70c ON public.socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_site_id_2579dee5; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX socialaccount_socialapp_sites_site_id_2579dee5 ON public.socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_97fb6e7d; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX socialaccount_socialapp_sites_socialapp_id_97fb6e7d ON public.socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_account_id_951f210e; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX socialaccount_socialtoken_account_id_951f210e ON public.socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_app_id_636a42d7; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX socialaccount_socialtoken_app_id_636a42d7 ON public.socialaccount_socialtoken USING btree (app_id);


--
-- Name: unique_authenticator_type; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE UNIQUE INDEX unique_authenticator_type ON public.mfa_authenticator USING btree (user_id, type) WHERE ((type)::text = ANY ((ARRAY['totp'::character varying, 'recovery_codes'::character varying])::text[]));


--
-- Name: unique_primary_email; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE UNIQUE INDEX unique_primary_email ON public.account_emailaddress USING btree (user_id, "primary") WHERE "primary";


--
-- Name: unique_verified_email; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE UNIQUE INDEX unique_verified_email ON public.account_emailaddress USING btree (email) WHERE verified;


--
-- Name: users_user_assigned_warehouse_id_619f9c78; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX users_user_assigned_warehouse_id_619f9c78 ON public.users_user USING btree (assigned_warehouse_id);


--
-- Name: users_user_groups_group_id_9afc8d0e; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX users_user_groups_group_id_9afc8d0e ON public.users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_user_id_5f6f5a90; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX users_user_groups_user_id_5f6f5a90 ON public.users_user_groups USING btree (user_id);


--
-- Name: users_user_user_permissions_permission_id_0b93982e; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX users_user_user_permissions_permission_id_0b93982e ON public.users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_user_id_20aca447; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX users_user_user_permissions_user_id_20aca447 ON public.users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: maliandevboy
--

CREATE INDEX users_user_username_06e46fe6_like ON public.users_user USING btree (username varchar_pattern_ops);


--
-- Name: account_emailaddress account_emailaddress_user_id_2c513194_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailconfirmation account_emailconfirm_email_address_id_5b7f8c58_fk_account_e; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirm_email_address_id_5b7f8c58_fk_account_e FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: communications_whatsappnotification communications_whats_sale_id_7ad31ee7_fk_sales_sal; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.communications_whatsappnotification
    ADD CONSTRAINT communications_whats_sale_id_7ad31ee7_fk_sales_sal FOREIGN KEY (sale_id) REFERENCES public.sales_sale(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_expense core_expense_category_id_dcdb74b3_fk_core_expensecategory_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_expense
    ADD CONSTRAINT core_expense_category_id_dcdb74b3_fk_core_expensecategory_id FOREIGN KEY (category_id) REFERENCES public.core_expensecategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_expense core_expense_recorded_by_id_b2fff93e_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_expense
    ADD CONSTRAINT core_expense_recorded_by_id_b2fff93e_fk_users_user_id FOREIGN KEY (recorded_by_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_historicalaudittestmodel core_historicalaudit_history_user_id_18c8e9f9_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_historicalaudittestmodel
    ADD CONSTRAINT core_historicalaudit_history_user_id_18c8e9f9_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_historicalexpense core_historicalexpen_history_user_id_ed5edfa1_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_historicalexpense
    ADD CONSTRAINT core_historicalexpen_history_user_id_ed5edfa1_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_historicalreleasecode core_historicalrelea_history_user_id_5a170592_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_historicalreleasecode
    ADD CONSTRAINT core_historicalrelea_history_user_id_5a170592_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_releasecode core_releasecode_created_by_id_995a897d_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_releasecode
    ADD CONSTRAINT core_releasecode_created_by_id_995a897d_fk_users_user_id FOREIGN KEY (created_by_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_releasecode core_releasecode_used_by_id_f6b72843_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.core_releasecode
    ADD CONSTRAINT core_releasecode_used_by_id_f6b72843_fk_users_user_id FOREIGN KEY (used_by_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_clocked_id_47a69f82_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_clocked_id_47a69f82_fk_django_ce FOREIGN KEY (clocked_id) REFERENCES public.django_celery_beat_clockedschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_crontab_id_d3cba168_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_crontab_id_d3cba168_fk_django_ce FOREIGN KEY (crontab_id) REFERENCES public.django_celery_beat_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_interval_id_a8ca27da_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_interval_id_a8ca27da_fk_django_ce FOREIGN KEY (interval_id) REFERENCES public.django_celery_beat_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_solar_id_a87ce72c_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_solar_id_a87ce72c_fk_django_ce FOREIGN KEY (solar_id) REFERENCES public.django_celery_beat_solarschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_historicalproduct inventory_historical_history_user_id_61ecbda7_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_historicalproduct
    ADD CONSTRAINT inventory_historical_history_user_id_61ecbda7_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_historicalstocktransaction inventory_historical_history_user_id_93858482_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_historicalstocktransaction
    ADD CONSTRAINT inventory_historical_history_user_id_93858482_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_historicalwarehouse inventory_historical_history_user_id_c9027fb5_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_historicalwarehouse
    ADD CONSTRAINT inventory_historical_history_user_id_c9027fb5_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_stocktransaction inventory_stocktrans_product_id_6432f3fb_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_stocktransaction
    ADD CONSTRAINT inventory_stocktrans_product_id_6432f3fb_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_stocktransaction inventory_stocktrans_to_warehouse_id_a035bea4_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_stocktransaction
    ADD CONSTRAINT inventory_stocktrans_to_warehouse_id_a035bea4_fk_inventory FOREIGN KEY (to_warehouse_id) REFERENCES public.inventory_warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_stocktransaction inventory_stocktrans_warehouse_id_deef05ac_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.inventory_stocktransaction
    ADD CONSTRAINT inventory_stocktrans_warehouse_id_deef05ac_fk_inventory FOREIGN KEY (warehouse_id) REFERENCES public.inventory_warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mfa_authenticator mfa_authenticator_user_id_0c3a50c0_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.mfa_authenticator
    ADD CONSTRAINT mfa_authenticator_user_id_0c3a50c0_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_historicalcustomer sales_historicalcust_history_user_id_bdb5b6b6_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_historicalcustomer
    ADD CONSTRAINT sales_historicalcust_history_user_id_bdb5b6b6_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_historicalpayment sales_historicalpaym_history_user_id_fc35d9f8_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_historicalpayment
    ADD CONSTRAINT sales_historicalpaym_history_user_id_fc35d9f8_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_historicalsale sales_historicalsale_history_user_id_11ceb754_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_historicalsale
    ADD CONSTRAINT sales_historicalsale_history_user_id_11ceb754_fk_users_user_id FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_historicalsaleitem sales_historicalsale_history_user_id_4c052ebe_fk_users_use; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_historicalsaleitem
    ADD CONSTRAINT sales_historicalsale_history_user_id_4c052ebe_fk_users_use FOREIGN KEY (history_user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_payment sales_payment_customer_id_a80e1f14_fk_sales_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_payment
    ADD CONSTRAINT sales_payment_customer_id_a80e1f14_fk_sales_customer_id FOREIGN KEY (customer_id) REFERENCES public.sales_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_payment sales_payment_received_by_id_82d5232b_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_payment
    ADD CONSTRAINT sales_payment_received_by_id_82d5232b_fk_users_user_id FOREIGN KEY (received_by_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_sale sales_sale_customer_id_2d66a408_fk_sales_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_sale
    ADD CONSTRAINT sales_sale_customer_id_2d66a408_fk_sales_customer_id FOREIGN KEY (customer_id) REFERENCES public.sales_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_sale sales_sale_seller_id_45166e30_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_sale
    ADD CONSTRAINT sales_sale_seller_id_45166e30_fk_users_user_id FOREIGN KEY (seller_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_saleitem sales_saleitem_product_id_aeb6c9cd_fk_inventory_product_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_saleitem
    ADD CONSTRAINT sales_saleitem_product_id_aeb6c9cd_fk_inventory_product_id FOREIGN KEY (product_id) REFERENCES public.inventory_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_saleitem sales_saleitem_sale_id_56e67045_fk_sales_sale_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.sales_saleitem
    ADD CONSTRAINT sales_saleitem_sale_id_56e67045_fk_sales_sale_id FOREIGN KEY (sale_id) REFERENCES public.sales_sale(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_account_id_951f210e_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_account_id_951f210e_fk_socialacc FOREIGN KEY (account_id) REFERENCES public.socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_app_id_636a42d7_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_app_id_636a42d7_fk_socialacc FOREIGN KEY (app_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_site_id_2579dee5_fk_django_si; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_site_id_2579dee5_fk_django_si FOREIGN KEY (site_id) REFERENCES public.django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc FOREIGN KEY (socialapp_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user users_user_assigned_warehouse_i_619f9c78_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_assigned_warehouse_i_619f9c78_fk_inventory FOREIGN KEY (assigned_warehouse_id) REFERENCES public.inventory_warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_perm_permission_id_0b93982e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: maliandevboy
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict jwuLHlRrbjeh9hEadflhwIGtcJGuwrRUcHQWzwJEjscHnW8LWr1fPvGXPeEiuKN

