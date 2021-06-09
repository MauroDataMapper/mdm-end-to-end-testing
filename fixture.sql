--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: core; Type: SCHEMA; Schema: -; Owner: maurodatamapper
--

CREATE SCHEMA core;


ALTER SCHEMA core OWNER TO maurodatamapper;

--
-- Name: dataflow; Type: SCHEMA; Schema: -; Owner: maurodatamapper
--

CREATE SCHEMA dataflow;


ALTER SCHEMA dataflow OWNER TO maurodatamapper;

--
-- Name: datamodel; Type: SCHEMA; Schema: -; Owner: maurodatamapper
--

CREATE SCHEMA datamodel;


ALTER SCHEMA datamodel OWNER TO maurodatamapper;

--
-- Name: federation; Type: SCHEMA; Schema: -; Owner: maurodatamapper
--

CREATE SCHEMA federation;


ALTER SCHEMA federation OWNER TO maurodatamapper;

--
-- Name: referencedata; Type: SCHEMA; Schema: -; Owner: maurodatamapper
--

CREATE SCHEMA referencedata;


ALTER SCHEMA referencedata OWNER TO maurodatamapper;

--
-- Name: security; Type: SCHEMA; Schema: -; Owner: maurodatamapper
--

CREATE SCHEMA security;


ALTER SCHEMA security OWNER TO maurodatamapper;

--
-- Name: terminology; Type: SCHEMA; Schema: -; Owner: maurodatamapper
--

CREATE SCHEMA terminology;


ALTER SCHEMA terminology OWNER TO maurodatamapper;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: annotation; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.annotation (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    depth integer NOT NULL,
    multi_facet_aware_item_id uuid,
    parent_annotation_id uuid,
    created_by character varying(255) NOT NULL,
    label text NOT NULL,
    description text,
    child_annotations_idx integer
);


ALTER TABLE core.annotation OWNER TO maurodatamapper;

--
-- Name: api_property; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.api_property (
    id uuid NOT NULL,
    version bigint NOT NULL,
    last_updated_by character varying(255) NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    value text NOT NULL,
    created_by character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    publicly_visible boolean DEFAULT false NOT NULL,
    category character varying(255)
);


ALTER TABLE core.api_property OWNER TO maurodatamapper;

--
-- Name: authority; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.authority (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    url character varying(255) NOT NULL,
    created_by character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE core.authority OWNER TO maurodatamapper;

--
-- Name: breadcrumb_tree; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.breadcrumb_tree (
    id uuid NOT NULL,
    version bigint NOT NULL,
    domain_type character varying(255) NOT NULL,
    finalised boolean,
    domain_id uuid,
    tree_string text NOT NULL,
    top_breadcrumb_tree boolean NOT NULL,
    label text,
    parent_id uuid
);


ALTER TABLE core.breadcrumb_tree OWNER TO maurodatamapper;

--
-- Name: classifier; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.classifier (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    parent_classifier_id uuid,
    readable_by_authenticated_users boolean NOT NULL,
    created_by character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE core.classifier OWNER TO maurodatamapper;

--
-- Name: edit; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.edit (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    resource_domain_type character varying(255) NOT NULL,
    resource_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    description text NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE core.edit OWNER TO maurodatamapper;

--
-- Name: email; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.email (
    id uuid NOT NULL,
    version bigint NOT NULL,
    sent_to_email_address character varying(255) NOT NULL,
    successfully_sent boolean NOT NULL,
    body text NOT NULL,
    date_time_sent timestamp without time zone NOT NULL,
    email_service_used character varying(255) NOT NULL,
    failure_reason text,
    subject text NOT NULL
);


ALTER TABLE core.email OWNER TO maurodatamapper;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE core.flyway_schema_history OWNER TO maurodatamapper;

--
-- Name: folder; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.folder (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    deleted boolean NOT NULL,
    depth integer NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    parent_folder_id uuid,
    created_by character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    label text NOT NULL,
    description text,
    class character varying(255) DEFAULT 'uk.ac.ox.softeng.maurodatamapper.core.container.Folder'::character varying NOT NULL,
    branch_name character varying(255),
    finalised boolean,
    date_finalised timestamp without time zone,
    documentation_version character varying(255),
    model_version character varying(255),
    authority_id uuid,
    model_version_tag character varying(255)
);


ALTER TABLE core.folder OWNER TO maurodatamapper;

--
-- Name: join_classifier_to_facet; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.join_classifier_to_facet (
    classifier_id uuid NOT NULL,
    annotation_id uuid,
    rule_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid
);


ALTER TABLE core.join_classifier_to_facet OWNER TO maurodatamapper;

--
-- Name: join_folder_to_facet; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.join_folder_to_facet (
    folder_id uuid NOT NULL,
    annotation_id uuid,
    rule_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid
);


ALTER TABLE core.join_folder_to_facet OWNER TO maurodatamapper;

--
-- Name: join_versionedfolder_to_facet; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.join_versionedfolder_to_facet (
    versionedfolder_id uuid NOT NULL,
    version_link_id uuid
);


ALTER TABLE core.join_versionedfolder_to_facet OWNER TO maurodatamapper;

--
-- Name: metadata; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.metadata (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    namespace text NOT NULL,
    multi_facet_aware_item_id uuid,
    value text NOT NULL,
    created_by character varying(255) NOT NULL,
    key text NOT NULL
);


ALTER TABLE core.metadata OWNER TO maurodatamapper;

--
-- Name: reference_file; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.reference_file (
    id uuid NOT NULL,
    version bigint NOT NULL,
    file_size bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    file_type character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    file_contents bytea NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL
);


ALTER TABLE core.reference_file OWNER TO maurodatamapper;

--
-- Name: rule; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.rule (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    name text,
    created_by character varying(255) NOT NULL,
    description text
);


ALTER TABLE core.rule OWNER TO maurodatamapper;

--
-- Name: rule_representation; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.rule_representation (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    rule_id uuid NOT NULL,
    language text NOT NULL,
    representation text NOT NULL,
    created_by character varying(255) NOT NULL
);


ALTER TABLE core.rule_representation OWNER TO maurodatamapper;

--
-- Name: semantic_link; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.semantic_link (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    target_multi_facet_aware_item_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    target_multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    link_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL,
    unconfirmed boolean DEFAULT false NOT NULL
);


ALTER TABLE core.semantic_link OWNER TO maurodatamapper;

--
-- Name: user_image_file; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.user_image_file (
    id uuid NOT NULL,
    version bigint NOT NULL,
    file_size bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    file_type character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    user_id uuid NOT NULL,
    file_contents bytea NOT NULL,
    created_by character varying(255) NOT NULL
);


ALTER TABLE core.user_image_file OWNER TO maurodatamapper;

--
-- Name: version_link; Type: TABLE; Schema: core; Owner: maurodatamapper
--

CREATE TABLE core.version_link (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    target_model_domain_type character varying(255) NOT NULL,
    link_type character varying(255) NOT NULL,
    target_model_id uuid NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL
);


ALTER TABLE core.version_link OWNER TO maurodatamapper;

--
-- Name: data_class_component; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.data_class_component (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    data_flow_id uuid NOT NULL,
    definition text,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE dataflow.data_class_component OWNER TO maurodatamapper;

--
-- Name: data_element_component; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.data_element_component (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    data_class_component_id uuid NOT NULL,
    definition text,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE dataflow.data_element_component OWNER TO maurodatamapper;

--
-- Name: data_flow; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.data_flow (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    definition text,
    diagram_layout text,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    source_id uuid NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    target_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE dataflow.data_flow OWNER TO maurodatamapper;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE dataflow.flyway_schema_history OWNER TO maurodatamapper;

--
-- Name: join_data_class_component_to_source_data_class; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.join_data_class_component_to_source_data_class (
    data_class_component_id uuid NOT NULL,
    data_class_id uuid
);


ALTER TABLE dataflow.join_data_class_component_to_source_data_class OWNER TO maurodatamapper;

--
-- Name: join_data_class_component_to_target_data_class; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.join_data_class_component_to_target_data_class (
    data_class_component_id uuid NOT NULL,
    data_class_id uuid
);


ALTER TABLE dataflow.join_data_class_component_to_target_data_class OWNER TO maurodatamapper;

--
-- Name: join_data_element_component_to_source_data_element; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.join_data_element_component_to_source_data_element (
    data_element_component_id uuid NOT NULL,
    data_element_id uuid
);


ALTER TABLE dataflow.join_data_element_component_to_source_data_element OWNER TO maurodatamapper;

--
-- Name: join_data_element_component_to_target_data_element; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.join_data_element_component_to_target_data_element (
    data_element_component_id uuid NOT NULL,
    data_element_id uuid
);


ALTER TABLE dataflow.join_data_element_component_to_target_data_element OWNER TO maurodatamapper;

--
-- Name: join_dataclasscomponent_to_facet; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.join_dataclasscomponent_to_facet (
    dataclasscomponent_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE dataflow.join_dataclasscomponent_to_facet OWNER TO maurodatamapper;

--
-- Name: join_dataelementcomponent_to_facet; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.join_dataelementcomponent_to_facet (
    dataelementcomponent_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE dataflow.join_dataelementcomponent_to_facet OWNER TO maurodatamapper;

--
-- Name: join_dataflow_to_facet; Type: TABLE; Schema: dataflow; Owner: maurodatamapper
--

CREATE TABLE dataflow.join_dataflow_to_facet (
    dataflow_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE dataflow.join_dataflow_to_facet OWNER TO maurodatamapper;

--
-- Name: data_class; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.data_class (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    min_multiplicity integer,
    max_multiplicity integer,
    parent_data_class_id uuid,
    breadcrumb_tree_id uuid NOT NULL,
    data_model_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE datamodel.data_class OWNER TO maurodatamapper;

--
-- Name: data_element; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.data_element (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    data_class_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    min_multiplicity integer,
    max_multiplicity integer,
    breadcrumb_tree_id uuid NOT NULL,
    data_type_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE datamodel.data_element OWNER TO maurodatamapper;

--
-- Name: data_model; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.data_model (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    finalised boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    date_finalised timestamp without time zone,
    documentation_version character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    model_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    deleted boolean NOT NULL,
    author character varying(255),
    breadcrumb_tree_id uuid NOT NULL,
    folder_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    authority_id uuid,
    branch_name character varying(255),
    model_version character varying(255),
    model_version_tag character varying(255)
);


ALTER TABLE datamodel.data_model OWNER TO maurodatamapper;

--
-- Name: data_type; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.data_type (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    domain_type character varying(15) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    data_model_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    class character varying(255) NOT NULL,
    units character varying(255),
    reference_class_id uuid,
    model_resource_id uuid,
    model_resource_domain_type character varying(255)
);


ALTER TABLE datamodel.data_type OWNER TO maurodatamapper;

--
-- Name: enumeration_value; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.enumeration_value (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    enumeration_type_id uuid NOT NULL,
    value text NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    category text,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    key text NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE datamodel.enumeration_value OWNER TO maurodatamapper;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE datamodel.flyway_schema_history OWNER TO maurodatamapper;

--
-- Name: join_dataclass_to_extended_data_class; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_dataclass_to_extended_data_class (
    dataclass_id uuid NOT NULL,
    extended_dataclass_id uuid NOT NULL
);


ALTER TABLE datamodel.join_dataclass_to_extended_data_class OWNER TO maurodatamapper;

--
-- Name: join_dataclass_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_dataclass_to_facet (
    dataclass_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_dataclass_to_facet OWNER TO maurodatamapper;

--
-- Name: join_dataclass_to_imported_data_class; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_dataclass_to_imported_data_class (
    imported_dataclass_id uuid NOT NULL,
    dataclass_id uuid NOT NULL
);


ALTER TABLE datamodel.join_dataclass_to_imported_data_class OWNER TO maurodatamapper;

--
-- Name: join_dataclass_to_imported_data_element; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_dataclass_to_imported_data_element (
    dataclass_id uuid NOT NULL,
    imported_dataelement_id uuid NOT NULL
);


ALTER TABLE datamodel.join_dataclass_to_imported_data_element OWNER TO maurodatamapper;

--
-- Name: join_dataelement_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_dataelement_to_facet (
    dataelement_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_dataelement_to_facet OWNER TO maurodatamapper;

--
-- Name: join_datamodel_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_datamodel_to_facet (
    datamodel_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    version_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_datamodel_to_facet OWNER TO maurodatamapper;

--
-- Name: join_datamodel_to_imported_data_class; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_datamodel_to_imported_data_class (
    imported_dataclass_id uuid NOT NULL,
    datamodel_id uuid NOT NULL
);


ALTER TABLE datamodel.join_datamodel_to_imported_data_class OWNER TO maurodatamapper;

--
-- Name: join_datamodel_to_imported_data_type; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_datamodel_to_imported_data_type (
    imported_datatype_id uuid NOT NULL,
    datamodel_id uuid NOT NULL
);


ALTER TABLE datamodel.join_datamodel_to_imported_data_type OWNER TO maurodatamapper;

--
-- Name: join_datatype_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_datatype_to_facet (
    datatype_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_datatype_to_facet OWNER TO maurodatamapper;

--
-- Name: join_enumerationvalue_to_facet; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.join_enumerationvalue_to_facet (
    enumerationvalue_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE datamodel.join_enumerationvalue_to_facet OWNER TO maurodatamapper;

--
-- Name: summary_metadata; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.summary_metadata (
    id uuid NOT NULL,
    version bigint NOT NULL,
    summary_metadata_type character varying(255) NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE datamodel.summary_metadata OWNER TO maurodatamapper;

--
-- Name: summary_metadata_report; Type: TABLE; Schema: datamodel; Owner: maurodatamapper
--

CREATE TABLE datamodel.summary_metadata_report (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    report_date timestamp without time zone NOT NULL,
    created_by character varying(255) NOT NULL,
    report_value text NOT NULL,
    summary_metadata_id uuid NOT NULL
);


ALTER TABLE datamodel.summary_metadata_report OWNER TO maurodatamapper;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: federation; Owner: maurodatamapper
--

CREATE TABLE federation.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE federation.flyway_schema_history OWNER TO maurodatamapper;

--
-- Name: subscribed_catalogue; Type: TABLE; Schema: federation; Owner: maurodatamapper
--

CREATE TABLE federation.subscribed_catalogue (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    readable_by_everyone boolean NOT NULL,
    created_by character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    api_key uuid NOT NULL,
    refresh_period integer NOT NULL,
    label text NOT NULL,
    description text,
    last_read timestamp without time zone
);


ALTER TABLE federation.subscribed_catalogue OWNER TO maurodatamapper;

--
-- Name: subscribed_model; Type: TABLE; Schema: federation; Owner: maurodatamapper
--

CREATE TABLE federation.subscribed_model (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    readable_by_everyone boolean NOT NULL,
    created_by character varying(255) NOT NULL,
    subscribed_catalogue_id uuid NOT NULL,
    subscribed_model_id uuid NOT NULL,
    subscribed_model_type character varying(255) NOT NULL,
    folder_id uuid NOT NULL,
    last_read timestamp without time zone,
    local_model_id uuid
);


ALTER TABLE federation.subscribed_model OWNER TO maurodatamapper;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE referencedata.flyway_schema_history OWNER TO maurodatamapper;

--
-- Name: join_referencedataelement_to_facet; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.join_referencedataelement_to_facet (
    referencedataelement_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    reference_summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE referencedata.join_referencedataelement_to_facet OWNER TO maurodatamapper;

--
-- Name: join_referencedatamodel_to_facet; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.join_referencedatamodel_to_facet (
    referencedatamodel_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    version_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    reference_summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE referencedata.join_referencedatamodel_to_facet OWNER TO maurodatamapper;

--
-- Name: join_referencedatatype_to_facet; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.join_referencedatatype_to_facet (
    referencedatatype_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    reference_summary_metadata_id uuid,
    rule_id uuid
);


ALTER TABLE referencedata.join_referencedatatype_to_facet OWNER TO maurodatamapper;

--
-- Name: join_referenceenumerationvalue_to_facet; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.join_referenceenumerationvalue_to_facet (
    referenceenumerationvalue_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE referencedata.join_referenceenumerationvalue_to_facet OWNER TO maurodatamapper;

--
-- Name: reference_data_element; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.reference_data_element (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    reference_data_type_id uuid NOT NULL,
    reference_data_model_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    min_multiplicity integer,
    max_multiplicity integer,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE referencedata.reference_data_element OWNER TO maurodatamapper;

--
-- Name: reference_data_model; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.reference_data_model (
    id uuid NOT NULL,
    version bigint NOT NULL,
    branch_name character varying(255) NOT NULL,
    date_created timestamp without time zone NOT NULL,
    finalised boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    date_finalised timestamp without time zone,
    documentation_version character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    model_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    deleted boolean NOT NULL,
    author character varying(255),
    breadcrumb_tree_id uuid NOT NULL,
    model_version character varying(255),
    folder_id uuid NOT NULL,
    authority_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    model_version_tag character varying(255)
);


ALTER TABLE referencedata.reference_data_model OWNER TO maurodatamapper;

--
-- Name: reference_data_type; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.reference_data_type (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    reference_data_model_id uuid NOT NULL,
    domain_type character varying(30) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    class character varying(255) NOT NULL,
    units character varying(255)
);


ALTER TABLE referencedata.reference_data_type OWNER TO maurodatamapper;

--
-- Name: reference_data_value; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.reference_data_value (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    value text,
    reference_data_model_id uuid NOT NULL,
    reference_data_element_id uuid NOT NULL,
    row_number bigint NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    created_by character varying(255) NOT NULL
);


ALTER TABLE referencedata.reference_data_value OWNER TO maurodatamapper;

--
-- Name: reference_enumeration_value; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.reference_enumeration_value (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    value text NOT NULL,
    reference_enumeration_type_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    category text,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    key text NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE referencedata.reference_enumeration_value OWNER TO maurodatamapper;

--
-- Name: reference_summary_metadata; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.reference_summary_metadata (
    id uuid NOT NULL,
    version bigint NOT NULL,
    summary_metadata_type character varying(255) NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    multi_facet_aware_item_domain_type character varying(255) NOT NULL,
    multi_facet_aware_item_id uuid,
    created_by character varying(255) NOT NULL,
    label text NOT NULL,
    description text
);


ALTER TABLE referencedata.reference_summary_metadata OWNER TO maurodatamapper;

--
-- Name: reference_summary_metadata_report; Type: TABLE; Schema: referencedata; Owner: maurodatamapper
--

CREATE TABLE referencedata.reference_summary_metadata_report (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    report_date timestamp without time zone NOT NULL,
    created_by character varying(255) NOT NULL,
    report_value text NOT NULL,
    summary_metadata_id uuid NOT NULL
);


ALTER TABLE referencedata.reference_summary_metadata_report OWNER TO maurodatamapper;

--
-- Name: api_key; Type: TABLE; Schema: security; Owner: maurodatamapper
--

CREATE TABLE security.api_key (
    id uuid NOT NULL,
    version bigint NOT NULL,
    refreshable boolean NOT NULL,
    date_created timestamp without time zone NOT NULL,
    expiry_date date NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    disabled boolean NOT NULL,
    catalogue_user_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_by character varying(255) NOT NULL
);


ALTER TABLE security.api_key OWNER TO maurodatamapper;

--
-- Name: catalogue_user; Type: TABLE; Schema: security; Owner: maurodatamapper
--

CREATE TABLE security.catalogue_user (
    id uuid NOT NULL,
    version bigint NOT NULL,
    pending boolean NOT NULL,
    salt bytea NOT NULL,
    date_created timestamp without time zone NOT NULL,
    first_name character varying(255) NOT NULL,
    profile_picture_id uuid,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    reset_token uuid,
    disabled boolean NOT NULL,
    job_title character varying(255),
    email_address character varying(255) NOT NULL,
    user_preferences text,
    password bytea,
    created_by character varying(255) NOT NULL,
    temp_password character varying(255),
    last_name character varying(255) NOT NULL,
    last_login timestamp without time zone
);


ALTER TABLE security.catalogue_user OWNER TO maurodatamapper;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: security; Owner: maurodatamapper
--

CREATE TABLE security.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE security.flyway_schema_history OWNER TO maurodatamapper;

--
-- Name: group_role; Type: TABLE; Schema: security; Owner: maurodatamapper
--

CREATE TABLE security.group_role (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    display_name character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    parent_id uuid,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    application_level_role boolean NOT NULL,
    created_by character varying(255) NOT NULL
);


ALTER TABLE security.group_role OWNER TO maurodatamapper;

--
-- Name: join_catalogue_user_to_user_group; Type: TABLE; Schema: security; Owner: maurodatamapper
--

CREATE TABLE security.join_catalogue_user_to_user_group (
    catalogue_user_id uuid NOT NULL,
    user_group_id uuid NOT NULL
);


ALTER TABLE security.join_catalogue_user_to_user_group OWNER TO maurodatamapper;

--
-- Name: securable_resource_group_role; Type: TABLE; Schema: security; Owner: maurodatamapper
--

CREATE TABLE security.securable_resource_group_role (
    id uuid NOT NULL,
    version bigint NOT NULL,
    securable_resource_id uuid NOT NULL,
    user_group_id uuid NOT NULL,
    date_created timestamp without time zone NOT NULL,
    securable_resource_domain_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    group_role_id uuid NOT NULL,
    created_by character varying(255) NOT NULL
);


ALTER TABLE security.securable_resource_group_role OWNER TO maurodatamapper;

--
-- Name: user_group; Type: TABLE; Schema: security; Owner: maurodatamapper
--

CREATE TABLE security.user_group (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    application_group_role_id uuid,
    created_by character varying(255) NOT NULL,
    description character varying(255),
    undeleteable boolean DEFAULT false
);


ALTER TABLE security.user_group OWNER TO maurodatamapper;

--
-- Name: code_set; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.code_set (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    finalised boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    date_finalised timestamp without time zone,
    documentation_version character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    model_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    deleted boolean NOT NULL,
    author character varying(255),
    breadcrumb_tree_id uuid,
    folder_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    authority_id uuid,
    branch_name character varying(255),
    model_version character varying(255),
    model_version_tag character varying(255)
);


ALTER TABLE terminology.code_set OWNER TO maurodatamapper;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp(6) without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE terminology.flyway_schema_history OWNER TO maurodatamapper;

--
-- Name: join_codeset_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.join_codeset_to_facet (
    codeset_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    version_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_codeset_to_facet OWNER TO maurodatamapper;

--
-- Name: join_codeset_to_term; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.join_codeset_to_term (
    term_id uuid NOT NULL,
    codeset_id uuid NOT NULL
);


ALTER TABLE terminology.join_codeset_to_term OWNER TO maurodatamapper;

--
-- Name: join_term_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.join_term_to_facet (
    term_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_term_to_facet OWNER TO maurodatamapper;

--
-- Name: join_terminology_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.join_terminology_to_facet (
    terminology_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    version_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_terminology_to_facet OWNER TO maurodatamapper;

--
-- Name: join_termrelationship_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.join_termrelationship_to_facet (
    termrelationship_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_termrelationship_to_facet OWNER TO maurodatamapper;

--
-- Name: join_termrelationshiptype_to_facet; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.join_termrelationshiptype_to_facet (
    termrelationshiptype_id uuid NOT NULL,
    classifier_id uuid,
    annotation_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid,
    rule_id uuid
);


ALTER TABLE terminology.join_termrelationshiptype_to_facet OWNER TO maurodatamapper;

--
-- Name: term; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.term (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    url character varying(255),
    definition text NOT NULL,
    terminology_id uuid NOT NULL,
    is_parent boolean NOT NULL,
    code character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE terminology.term OWNER TO maurodatamapper;

--
-- Name: term_relationship; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.term_relationship (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    target_term_id uuid NOT NULL,
    relationship_type_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    source_term_id uuid NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text
);


ALTER TABLE terminology.term_relationship OWNER TO maurodatamapper;

--
-- Name: term_relationship_type; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.term_relationship_type (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    child_relationship boolean NOT NULL,
    terminology_id uuid NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    path text NOT NULL,
    depth integer NOT NULL,
    breadcrumb_tree_id uuid NOT NULL,
    parental_relationship boolean NOT NULL,
    idx integer NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    display_label character varying(255) NOT NULL,
    description text
);


ALTER TABLE terminology.term_relationship_type OWNER TO maurodatamapper;

--
-- Name: terminology; Type: TABLE; Schema: terminology; Owner: maurodatamapper
--

CREATE TABLE terminology.terminology (
    id uuid NOT NULL,
    version bigint NOT NULL,
    date_created timestamp without time zone NOT NULL,
    finalised boolean NOT NULL,
    readable_by_authenticated_users boolean NOT NULL,
    date_finalised timestamp without time zone,
    documentation_version character varying(255) NOT NULL,
    readable_by_everyone boolean NOT NULL,
    model_type character varying(255) NOT NULL,
    last_updated timestamp without time zone NOT NULL,
    organisation character varying(255),
    deleted boolean NOT NULL,
    author character varying(255),
    breadcrumb_tree_id uuid NOT NULL,
    folder_id uuid NOT NULL,
    created_by character varying(255) NOT NULL,
    aliases_string text,
    label text NOT NULL,
    description text,
    authority_id uuid,
    branch_name character varying(255),
    model_version character varying(255),
    model_version_tag character varying(255)
);


ALTER TABLE terminology.terminology OWNER TO maurodatamapper;

--
-- Data for Name: annotation; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.annotation (id, version, date_created, last_updated, path, multi_facet_aware_item_domain_type, depth, multi_facet_aware_item_id, parent_annotation_id, created_by, label, description, child_annotations_idx) FROM stdin;
32309bca-6930-4e74-9049-08fbf335d3e1	0	2021-05-20 15:35:21.299143	2021-05-20 15:35:21.299143		DataModel	0	ed800789-3cd4-4058-884b-758ccf654132	\N	development@test.com	test annotation 1	\N	\N
674f1847-502c-4d48-acde-3b35d3fe42b7	0	2021-05-20 15:35:21.300196	2021-05-20 15:35:21.300196		DataModel	0	ed800789-3cd4-4058-884b-758ccf654132	\N	development@test.com	test annotation 2	with description	\N
0a1e89bb-18b1-4751-bb14-197c198978dd	0	2021-05-20 15:35:23.390661	2021-05-20 15:35:23.390661		Terminology	0	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	\N	development@test.com	test annotation 1	\N	\N
9cd7afc6-cc8d-4d08-9ef3-5ce70bf3342a	0	2021-05-20 15:35:23.391228	2021-05-20 15:35:23.391228		Terminology	0	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	\N	development@test.com	test annotation 2	with description	\N
\.


--
-- Data for Name: api_property; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.api_property (id, version, last_updated_by, date_created, last_updated, value, created_by, key, publicly_visible, category) FROM stdin;
8a20748c-410c-4b6b-abfa-787198fd6129	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.307144	2021-05-20 15:35:20.307144	Dear ${firstName},\nYou have been invited to edit the model '${itemLabel}' in the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour password is: ${tempPassword}\n and you will be asked to update this when you first log on.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.invite_edit.body	f	Email
b1b2b064-3ed8-4338-b0e8-8693b9044adb	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.349988	2021-05-20 15:35:20.349988	Dear ${firstName},\nYou have been given access to the Mauro Data Mapper at ${catalogueUrl} \n\nYour username / email address is: ${emailAddress} \nYour password is: ${tempPassword} \nand you will be asked to update this when you first log on.\n\nKind regards, the Mauro Data Mapper folks. \n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.admin_register.body	f	Email
87376b2b-59f0-4416-a795-4fa6c65c9c6e	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.350962	2021-05-20 15:35:20.350962	Mauro Data Mapper Registration	bootstrap.user@maurodatamapper.com	email.admin_register.subject	f	Email
518dad03-11ef-4f38-885e-83bcf1b74768	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.35186	2021-05-20 15:35:20.35186	Mauro Data Mapper Registration	bootstrap.user@maurodatamapper.com	email.self_register.subject	f	Email
d4687691-a8f3-46f2-b240-9ea0cf56d657	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.35252	2021-05-20 15:35:20.35252	Mauro Data Mapper Forgotten Password	bootstrap.user@maurodatamapper.com	email.forgotten_password.subject	f	Email
24a99e63-1129-4875-b3fe-c28ee61b7bf2	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.353132	2021-05-20 15:35:20.353132	Mauro Data Mapper Invitation	bootstrap.user@maurodatamapper.com	email.invite_edit.subject	f	Email
0ee70339-414c-4fe9-8e3b-4bcb6367d07b	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.354271	2021-05-20 15:35:20.354271	Mauro Data Mapper Invitation	bootstrap.user@maurodatamapper.com	email.invite_view.subject	f	Email
bcc954f8-d83e-4e2b-ad6b-05ded01f3120	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.355808	2021-05-20 15:35:20.355808	Dear ${firstName},\nYour registration for the Mauro Data Mapper at ${catalogueUrl} has been confirmed.\n\nYour username / email address is: ${emailAddress} \nYou chose a password on registration, but can reset it from the login page.\n\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.admin_confirm_registration.body	f	Email
c2d935eb-c735-4f2c-9d2f-8a276b288703	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.357809	2021-05-20 15:35:20.357809	Dear ${firstName},\nYou have self-registered for the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour registration is marked as pending: you'll be sent another email when your request has been confirmed by an administrator. \nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.self_register.body	f	Email
212a1c0c-c0e6-4544-baaf-3db6c5a10c48	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.359111	2021-05-20 15:35:20.359111	Dear ${firstName},\nYour password has been reset for the Mauro Data Mapper at ${catalogueUrl}.\n\nYour new temporary password is: ${tempPassword} \nand you will be asked to update this when you next log on.\n\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.password_reset.body	f	Email
44b2d39e-957f-40e4-b761-70557e381a93	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.359848	2021-05-20 15:35:20.359848	Mauro Data Mapper	bootstrap.user@maurodatamapper.com	email.from.name	f	Email
614b2f67-af0a-4afc-b6f3-cee0c3527ea1	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.360455	2021-05-20 15:35:20.360455	Mauro Data Mapper Registration - Confirmation	bootstrap.user@maurodatamapper.com	email.admin_confirm_registration.subject	f	Email
b1bf66b3-1e5e-452a-86c8-9f6e716ed7f4	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.360997	2021-05-20 15:35:20.360997	Dear ${firstName},\nA request has been made to reset the password for the Mauro Data Mapper at ${catalogueUrl}.\nIf you did not make this request please ignore this email.\n\nPlease use the following link to reset your password ${passwordResetLink}.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.forgotten_password.body	f	Email
c967f191-c5a8-4503-bb1f-bf26fed1f53e	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.361675	2021-05-20 15:35:20.361675	Mauro Data Mapper Password Reset	bootstrap.user@maurodatamapper.com	email.password_reset.subject	f	Email
657c1c4b-491e-4b1e-b00f-693e7567210d	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.362578	2021-05-20 15:35:20.362578	Dear ${firstName},\nYou have been invited to view the item '${itemLabel}' in the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour password is: ${tempPassword}\n and you will be asked to update this when you first log on.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.invite_view.body	f	Email
062158db-2216-463c-9545-6d67a6921dff	0	bootstrap.user@maurodatamapper.com	2021-05-20 15:35:20.51941	2021-05-20 15:35:20.51941	username@gmail.com	bootstrap.user@maurodatamapper.com	email.from.address	f	Email
\.


--
-- Data for Name: authority; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.authority (id, version, date_created, last_updated, readable_by_authenticated_users, url, created_by, readable_by_everyone, label, description) FROM stdin;
4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	0	2021-05-20 15:35:20.609743	2021-05-20 15:35:20.609743	f	http://localhost	admin@maurodatamapper.com	t	Mauro Data Mapper	\N
\.


--
-- Data for Name: breadcrumb_tree; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.breadcrumb_tree (id, version, domain_type, finalised, domain_id, tree_string, top_breadcrumb_tree, label, parent_id) FROM stdin;
209ac018-4b20-4723-a30e-cb02678b3825	6	DataModel	f	ed800789-3cd4-4058-884b-758ccf654132	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false	t	Complex Test DataModel	\N
3f973c1e-0bf4-4d2e-9978-de31deba6bb6	4	PrimitiveType	\N	baa81da3-bbb4-415c-86d1-5dcac118d36a	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\nbaa81da3-bbb4-415c-86d1-5dcac118d36a|PrimitiveType|string|null	f	string	209ac018-4b20-4723-a30e-cb02678b3825
7386b2b7-1b7e-4301-9d09-3ef009d46d94	4	PrimitiveType	\N	e93a7ea8-85e8-4066-9bc3-42e44101bba5	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\ne93a7ea8-85e8-4066-9bc3-42e44101bba5|PrimitiveType|integer|null	f	integer	209ac018-4b20-4723-a30e-cb02678b3825
84260660-dbb3-48e3-94b3-e01633582161	5	DataClass	\N	47496217-ced4-443b-bf9c-5b13ccac366a	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n47496217-ced4-443b-bf9c-5b13ccac366a|DataClass|emptyclass|null	f	emptyclass	209ac018-4b20-4723-a30e-cb02678b3825
8702b46b-1b26-431f-8665-7316d6662393	5	DataClass	\N	04659fc9-4340-4e13-bf78-690de6bce191	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n04659fc9-4340-4e13-bf78-690de6bce191|DataClass|parent|null	f	parent	209ac018-4b20-4723-a30e-cb02678b3825
8d367afd-3a82-4c55-bcff-af2727ce2643	5	EnumerationType	\N	1d99bf8a-3584-44eb-ad25-907e7fa0f979	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n1d99bf8a-3584-44eb-ad25-907e7fa0f979|EnumerationType|yesnounknown|null	f	yesnounknown	209ac018-4b20-4723-a30e-cb02678b3825
bd9a7d66-ca96-499d-855a-6a94119f07a3	5	EnumerationValue	\N	148477b8-0d7a-48f7-ba4e-af23ffa33bca	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n1d99bf8a-3584-44eb-ad25-907e7fa0f979|EnumerationType|yesnounknown|null\n148477b8-0d7a-48f7-ba4e-af23ffa33bca|EnumerationValue|N|null	f	N	8d367afd-3a82-4c55-bcff-af2727ce2643
d0443366-26fb-4008-b86b-0033f7d7884f	3	ReferenceType	\N	295f56c7-0de2-40c1-8a28-13f28574641e	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n295f56c7-0de2-40c1-8a28-13f28574641e|ReferenceType|child|null	f	child	209ac018-4b20-4723-a30e-cb02678b3825
d7a47471-088d-4f02-bf40-f0e2ba40efb6	5	DataClass	\N	b7bfbc0e-9677-4fa2-9277-02e12aa849b6	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n04659fc9-4340-4e13-bf78-690de6bce191|DataClass|parent|null\nb7bfbc0e-9677-4fa2-9277-02e12aa849b6|DataClass|child|null	f	child	8702b46b-1b26-431f-8665-7316d6662393
f54887e1-bc5c-4a70-926c-32654e27eec7	3	DataClass	\N	3594cda2-4824-4697-93c9-93d4df8586c6	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n3594cda2-4824-4697-93c9-93d4df8586c6|DataClass|content|null	f	content	209ac018-4b20-4723-a30e-cb02678b3825
159d3f8f-0f7f-4c29-8e19-59c9707339be	3	DataElement	\N	d99eae34-491e-4455-a40a-bd21dbfb3740	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n04659fc9-4340-4e13-bf78-690de6bce191|DataClass|parent|null\nd99eae34-491e-4455-a40a-bd21dbfb3740|DataElement|child|null	f	child	8702b46b-1b26-431f-8665-7316d6662393
16cdf122-2e7e-4997-a299-1f2774b7139d	5	EnumerationValue	\N	65056f85-6d3f-4f49-99f0-d855e9967126	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n1d99bf8a-3584-44eb-ad25-907e7fa0f979|EnumerationType|yesnounknown|null\n65056f85-6d3f-4f49-99f0-d855e9967126|EnumerationValue|Y|null	f	Y	8d367afd-3a82-4c55-bcff-af2727ce2643
185fc37a-1e75-415f-8179-b9f7355f6122	3	DataElement	\N	d407d6a1-712f-4126-a058-03c0de03a1d0	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n3594cda2-4824-4697-93c9-93d4df8586c6|DataClass|content|null\nd407d6a1-712f-4126-a058-03c0de03a1d0|DataElement|element2|null	f	element2	f54887e1-bc5c-4a70-926c-32654e27eec7
1a59d25b-adec-4827-9835-3ea15dc8aaf3	5	EnumerationValue	\N	768d9193-aafa-4a70-b77f-621f9e372577	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n1d99bf8a-3584-44eb-ad25-907e7fa0f979|EnumerationType|yesnounknown|null\n768d9193-aafa-4a70-b77f-621f9e372577|EnumerationValue|U|null	f	U	8d367afd-3a82-4c55-bcff-af2727ce2643
7c0dfc21-67d2-40d2-bf0f-55b1e463325d	3	DataElement	\N	2d998eee-1c4e-42a5-9fa7-4cd517711a1e	ed800789-3cd4-4058-884b-758ccf654132|DataModel|Complex Test DataModel|false\n3594cda2-4824-4697-93c9-93d4df8586c6|DataClass|content|null\n2d998eee-1c4e-42a5-9fa7-4cd517711a1e|DataElement|ele1|null	f	ele1	f54887e1-bc5c-4a70-926c-32654e27eec7
3903fb16-8b28-40ff-9cfb-019dac012f0e	2	DataModel	f	9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0|DataModel|Simple Test DataModel|false	t	Simple Test DataModel	\N
f1a7d6d5-142c-4c42-befc-cef7d4438069	2	DataClass	\N	467f8282-42dc-4cc7-bd3d-6bab24297bb2	9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0|DataModel|Simple Test DataModel|false\n467f8282-42dc-4cc7-bd3d-6bab24297bb2|DataClass|simple|null	f	simple	3903fb16-8b28-40ff-9cfb-019dac012f0e
ba276eba-eb46-40dd-9dbe-aae1424d0cb3	2	DataModel	t	47bc72a2-07e7-4afd-a453-db2894a64663	47bc72a2-07e7-4afd-a453-db2894a64663|DataModel|Finalised Example Test DataModel|true	t	Finalised Example Test DataModel	\N
2fd3c9de-1e5c-4afa-aa29-e1381b8a3389	1	DataClass	\N	e55f20c7-e7a8-46c7-bbdf-cd4aa4db1dde	47bc72a2-07e7-4afd-a453-db2894a64663|DataModel|Finalised Example Test DataModel|true\ne55f20c7-e7a8-46c7-bbdf-cd4aa4db1dde|DataClass|Another Data Class|null	f	Another Data Class	ba276eba-eb46-40dd-9dbe-aae1424d0cb3
7b96d487-6596-4c3e-9e8a-6be4c822739f	1	PrimitiveType	\N	65bfb646-8e63-46dc-b732-81464cbabc84	47bc72a2-07e7-4afd-a453-db2894a64663|DataModel|Finalised Example Test DataModel|true\n65bfb646-8e63-46dc-b732-81464cbabc84|PrimitiveType|Finalised Data Type|null	f	Finalised Data Type	ba276eba-eb46-40dd-9dbe-aae1424d0cb3
a990cf1a-e1ac-4666-bcac-ff656895e837	2	DataClass	\N	0d75b276-ea7a-4def-a31f-11e3aa8a77d4	47bc72a2-07e7-4afd-a453-db2894a64663|DataModel|Finalised Example Test DataModel|true\n0d75b276-ea7a-4def-a31f-11e3aa8a77d4|DataClass|Finalised Data Class|null	f	Finalised Data Class	ba276eba-eb46-40dd-9dbe-aae1424d0cb3
6a4ba564-5dc3-4dac-a4e7-ebf2922e44ba	2	DataElement	\N	842717d8-97cc-49cb-bd28-e0ef18aa02c3	47bc72a2-07e7-4afd-a453-db2894a64663|DataModel|Finalised Example Test DataModel|true\n0d75b276-ea7a-4def-a31f-11e3aa8a77d4|DataClass|Finalised Data Class|null\n842717d8-97cc-49cb-bd28-e0ef18aa02c3|DataElement|Finalised Data Element|null	f	Finalised Data Element	a990cf1a-e1ac-4666-bcac-ff656895e837
7b7df051-59f3-4c2b-9c4a-9d041a58fc80	2	DataElement	\N	cd12ced6-225d-4ac9-a054-990c50fcb9c7	47bc72a2-07e7-4afd-a453-db2894a64663|DataModel|Finalised Example Test DataModel|true\n0d75b276-ea7a-4def-a31f-11e3aa8a77d4|DataClass|Finalised Data Class|null\ncd12ced6-225d-4ac9-a054-990c50fcb9c7|DataElement|Another DataElement|null	f	Another DataElement	a990cf1a-e1ac-4666-bcac-ff656895e837
c17b0c4e-d2f1-4d17-a848-d175042b7179	3	DataModel	f	1c412f8c-0369-41db-8472-9c5e89469b5f	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false	t	SourceFlowDataModel	\N
c7068759-0f83-461b-8e63-720702aba35f	3	DataClass	\N	1fc79fcf-b149-438c-9884-c3157eda7f0b	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n1fc79fcf-b149-438c-9884-c3157eda7f0b|DataClass|tableB|null	f	tableB	c17b0c4e-d2f1-4d17-a848-d175042b7179
d7e15ccf-10dc-4639-8bbe-7dcbda9fd422	3	DataClass	\N	9477ed2f-99fe-4130-b172-08fc2c98642c	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n9477ed2f-99fe-4130-b172-08fc2c98642c|DataClass|tableA|null	f	tableA	c17b0c4e-d2f1-4d17-a848-d175042b7179
007dc29d-aaaf-4ae1-ac26-280699d313b3	3	PrimitiveType	\N	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n961267d4-0fd5-4a2f-8d6f-978a9eb8c987|PrimitiveType|string|null	f	string	c17b0c4e-d2f1-4d17-a848-d175042b7179
137481e6-6cd8-466f-9f9b-cf4668d2d0ad	3	DataElement	\N	45032660-ca45-4da0-a61c-6e754f236132	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n1fc79fcf-b149-438c-9884-c3157eda7f0b|DataClass|tableB|null\n45032660-ca45-4da0-a61c-6e754f236132|DataElement|columnF|null	f	columnF	c7068759-0f83-461b-8e63-720702aba35f
89dd02b0-a107-4535-a99a-0e7f6c0065c5	4	PrimitiveType	\N	09d00cad-53c0-4f7b-9d1f-fca26c42fb64	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n09d00cad-53c0-4f7b-9d1f-fca26c42fb64|PrimitiveType|integer|null	f	integer	c17b0c4e-d2f1-4d17-a848-d175042b7179
ca284174-0aac-4b89-91f5-f84c77e94a4a	4	DataElement	\N	f5300062-822c-4db7-8d87-9e7635ba5679	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\nb6d0d671-d676-4f03-bf1a-5a502576d75e|DataClass|tableC|null\nf5300062-822c-4db7-8d87-9e7635ba5679|DataElement|columnL|null	f	columnL	9a427250-eb8d-4897-b4a2-ee0ad7308e6a
34c9c0d4-bc0c-432d-bb96-746635335347	3	DataElement	\N	8570bc51-b105-4735-b9a8-f54a7c9507c9	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n1fc79fcf-b149-438c-9884-c3157eda7f0b|DataClass|tableB|null\n8570bc51-b105-4735-b9a8-f54a7c9507c9|DataElement|columnE1|null	f	columnE1	c7068759-0f83-461b-8e63-720702aba35f
47ae3020-4fc4-4f75-9d71-f413d4effe52	3	DataElement	\N	021c2905-dd41-4c20-93e0-40b3779f7480	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n1fc79fcf-b149-438c-9884-c3157eda7f0b|DataClass|tableB|null\n021c2905-dd41-4c20-93e0-40b3779f7480|DataElement|columnG|null	f	columnG	c7068759-0f83-461b-8e63-720702aba35f
6baf61e7-9df2-4fe9-b435-53aa229e5121	3	DataModel	f	4cb3611e-12dc-4b86-a996-da79283818fe	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false	t	TargetFlowDataModel	\N
7dac85a8-8a95-46aa-a5fc-44a6ed5c8855	3	DataElement	\N	b7bfa6c1-b62b-41ff-916a-fec5fabc2482	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n1fc79fcf-b149-438c-9884-c3157eda7f0b|DataClass|tableB|null\nb7bfa6c1-b62b-41ff-916a-fec5fabc2482|DataElement|columnH|null	f	columnH	c7068759-0f83-461b-8e63-720702aba35f
8bb74927-422f-4b0e-9557-7a6e13a24da8	5	DataElement	\N	ef19d301-be66-4d3e-970e-32ea9537de7c	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n9477ed2f-99fe-4130-b172-08fc2c98642c|DataClass|tableA|null\nef19d301-be66-4d3e-970e-32ea9537de7c|DataElement|columnD|null	f	columnD	d7e15ccf-10dc-4639-8bbe-7dcbda9fd422
947b879c-c0ab-4a69-aa1a-e80dc2ef21f9	2	DataFlow	\N	7d67c734-2064-4834-92ba-fca961cb9b18	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null	f	Sample DataFlow	6baf61e7-9df2-4fe9-b435-53aa229e5121
96e4cabf-6971-43ad-ad96-cd39db9d3f08	1	DataClassComponent	\N	e260e937-5c25-4b16-aeef-adc511d92476	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\ne260e937-5c25-4b16-aeef-adc511d92476|DataClassComponent|aToD|null	f	aToD	947b879c-c0ab-4a69-aa1a-e80dc2ef21f9
9a427250-eb8d-4897-b4a2-ee0ad7308e6a	4	DataClass	\N	b6d0d671-d676-4f03-bf1a-5a502576d75e	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\nb6d0d671-d676-4f03-bf1a-5a502576d75e|DataClass|tableC|null	f	tableC	c17b0c4e-d2f1-4d17-a848-d175042b7179
a0037a36-2d2f-4379-8b4b-7545e59f5992	1	DataElementComponent	\N	ccf0c187-a759-4527-8d9e-79e5a3c8a766	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\ne260e937-5c25-4b16-aeef-adc511d92476|DataClassComponent|aToD|null\nccf0c187-a759-4527-8d9e-79e5a3c8a766|DataElementComponent|Direct Copy|null	f	Direct Copy	96e4cabf-6971-43ad-ad96-cd39db9d3f08
a5ef49c2-55db-4f05-98d4-346df31caac0	4	DataElement	\N	ee110977-ce2a-4436-855f-d27dfcba8dfd	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\nb6d0d671-d676-4f03-bf1a-5a502576d75e|DataClass|tableC|null\nee110977-ce2a-4436-855f-d27dfcba8dfd|DataElement|columnJ|null	f	columnJ	9a427250-eb8d-4897-b4a2-ee0ad7308e6a
ba65c185-4623-4cc6-bd2b-559e80674eba	5	DataElement	\N	21e6e5af-6e3f-47cf-8e24-5f2ddef0ba99	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n9477ed2f-99fe-4130-b172-08fc2c98642c|DataClass|tableA|null\n21e6e5af-6e3f-47cf-8e24-5f2ddef0ba99|DataElement|columnB|null	f	columnB	d7e15ccf-10dc-4639-8bbe-7dcbda9fd422
bce98467-b507-4e24-8e17-246068148531	5	DataElement	\N	f9f4d4f5-359d-4d99-82f1-fa2585976bf0	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n1fc79fcf-b149-438c-9884-c3157eda7f0b|DataClass|tableB|null\nf9f4d4f5-359d-4d99-82f1-fa2585976bf0|DataElement|columnI|null	f	columnI	c7068759-0f83-461b-8e63-720702aba35f
be3df439-f3cd-4467-a2c2-9631000e8006	3	PrimitiveType	\N	3613e97d-bd18-43a2-aea6-1519b1a6bfe0	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n3613e97d-bd18-43a2-aea6-1519b1a6bfe0|PrimitiveType|integer|null	f	integer	6baf61e7-9df2-4fe9-b435-53aa229e5121
bf87a4ad-7097-49a8-a117-2cf02dda4aac	5	DataElement	\N	96d0c214-bd98-41fa-bdf0-6ce22a33c45d	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n9477ed2f-99fe-4130-b172-08fc2c98642c|DataClass|tableA|null\n96d0c214-bd98-41fa-bdf0-6ce22a33c45d|DataElement|columnA|null	f	columnA	d7e15ccf-10dc-4639-8bbe-7dcbda9fd422
c848f9da-fa52-46f4-ba5a-8bbf002f3162	5	DataElement	\N	61a1470d-43af-467e-86bf-6431bda53f5c	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\n9477ed2f-99fe-4130-b172-08fc2c98642c|DataClass|tableA|null\n61a1470d-43af-467e-86bf-6431bda53f5c|DataElement|columnC|null	f	columnC	d7e15ccf-10dc-4639-8bbe-7dcbda9fd422
c916cc68-c3ab-4c26-9a52-682c404ef292	3	DataClass	\N	d66b9510-73e8-4c9e-b7db-2822c8974312	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\nd66b9510-73e8-4c9e-b7db-2822c8974312|DataClass|tableD|null	f	tableD	6baf61e7-9df2-4fe9-b435-53aa229e5121
971a87d9-7eff-41a9-bdc6-5a7a17be8828	4	DataElement	\N	d57c1cca-a7b0-4c88-8d97-04721aeb1967	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\nd66b9510-73e8-4c9e-b7db-2822c8974312|DataClass|tableD|null\nd57c1cca-a7b0-4c88-8d97-04721aeb1967|DataElement|columnQ|null	f	columnQ	c916cc68-c3ab-4c26-9a52-682c404ef292
d6107176-6147-4c8d-a6a6-a69135630cf6	3	DataElement	\N	627b2a27-c625-4ec4-a9d8-d5c17367ea61	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\nd66b9510-73e8-4c9e-b7db-2822c8974312|DataClass|tableD|null\n627b2a27-c625-4ec4-a9d8-d5c17367ea61|DataElement|columnP|null	f	columnP	c916cc68-c3ab-4c26-9a52-682c404ef292
f1f38141-57e2-4062-8dab-ab848c2590c7	1	DataElementComponent	\N	158a7282-6924-4f0f-bcb8-99b69d81b8d6	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\ne260e937-5c25-4b16-aeef-adc511d92476|DataClassComponent|aToD|null\n158a7282-6924-4f0f-bcb8-99b69d81b8d6|DataElementComponent|Direct Copy|null	f	Direct Copy	96e4cabf-6971-43ad-ad96-cd39db9d3f08
fd2ef7e5-4773-4a2e-a29f-9a41ac41982c	3	DataClass	\N	a2cd824d-3691-43ff-b50f-a8a846cc5358	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\na2cd824d-3691-43ff-b50f-a8a846cc5358|DataClass|tableE|null	f	tableE	6baf61e7-9df2-4fe9-b435-53aa229e5121
0dd9110b-76cb-4a50-b36d-54063151adb1	1	DataClassComponent	\N	002dc358-4c90-4b4f-a81b-6a6f4fe33707	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\n002dc358-4c90-4b4f-a81b-6a6f4fe33707|DataClassComponent|bAndCToE|null	f	bAndCToE	947b879c-c0ab-4a69-aa1a-e80dc2ef21f9
1ee62b1f-1d3d-4b06-8ce5-57401a0a53a2	3	DataElement	\N	57de6b8b-a58c-45bd-b77c-96adfdf1b40e	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\na2cd824d-3691-43ff-b50f-a8a846cc5358|DataClass|tableE|null\n57de6b8b-a58c-45bd-b77c-96adfdf1b40e|DataElement|columnU|null	f	columnU	fd2ef7e5-4773-4a2e-a29f-9a41ac41982c
2edbfa62-3722-48dd-9841-e3b86804be4d	3	DataElement	\N	99add985-9041-406d-abc9-3f0b0e5c26ee	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\na2cd824d-3691-43ff-b50f-a8a846cc5358|DataClass|tableE|null\n99add985-9041-406d-abc9-3f0b0e5c26ee|DataElement|columnE|null	f	columnE	fd2ef7e5-4773-4a2e-a29f-9a41ac41982c
2f61e1f8-0877-49b5-91a5-da03bf4a71a2	3	DataElement	\N	20d6bbea-7c62-46bc-a9a8-779c035ad012	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\nd66b9510-73e8-4c9e-b7db-2822c8974312|DataClass|tableD|null\n20d6bbea-7c62-46bc-a9a8-779c035ad012|DataElement|columnN|null	f	columnN	c916cc68-c3ab-4c26-9a52-682c404ef292
3b1efe84-f2b8-4998-9c91-9ece0c4db6d5	3	DataElement	\N	c3dfb686-2c0f-4444-823f-d0db6b40f457	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\na2cd824d-3691-43ff-b50f-a8a846cc5358|DataClass|tableE|null\nc3dfb686-2c0f-4444-823f-d0db6b40f457|DataElement|columnR|null	f	columnR	fd2ef7e5-4773-4a2e-a29f-9a41ac41982c
4e3313aa-4179-40f6-ae3d-a443c09a16fd	3	PrimitiveType	\N	718d2e04-e2ed-4aeb-abc8-968b333b2c11	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n718d2e04-e2ed-4aeb-abc8-968b333b2c11|PrimitiveType|string|null	f	string	6baf61e7-9df2-4fe9-b435-53aa229e5121
510826e7-5fc8-4ded-aba1-433f472b85b1	1	DataElementComponent	\N	bad7eb32-06af-42f3-9a35-d14cb9307522	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\ne260e937-5c25-4b16-aeef-adc511d92476|DataClassComponent|aToD|null\nbad7eb32-06af-42f3-9a35-d14cb9307522|DataElementComponent|Direct Copy|null	f	Direct Copy	96e4cabf-6971-43ad-ad96-cd39db9d3f08
56c2a3e0-af1d-4bca-8141-92200eb2513a	1	DataElementComponent	\N	7953762c-70a1-4a5e-a042-0bd8133e1e0c	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\n002dc358-4c90-4b4f-a81b-6a6f4fe33707|DataClassComponent|bAndCToE|null\n7953762c-70a1-4a5e-a042-0bd8133e1e0c|DataElementComponent|TRIM|null	f	TRIM	0dd9110b-76cb-4a50-b36d-54063151adb1
68d97f3b-77b0-4a20-9a8b-ba85a347a7ab	1	DataElementComponent	\N	83bbf788-8fa3-4f36-add1-3db5d603a91c	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\ne260e937-5c25-4b16-aeef-adc511d92476|DataClassComponent|aToD|null\n83bbf788-8fa3-4f36-add1-3db5d603a91c|DataElementComponent|Direct Copy|null	f	Direct Copy	96e4cabf-6971-43ad-ad96-cd39db9d3f08
a88425d3-4f36-4459-9dec-25107957a317	2	DataElementComponent	\N	67de5e94-5e79-4eb2-b7b3-9e82e92c7497	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\n002dc358-4c90-4b4f-a81b-6a6f4fe33707|DataClassComponent|bAndCToE|null\n67de5e94-5e79-4eb2-b7b3-9e82e92c7497|DataElementComponent|CONCAT|null	f	CONCAT	0dd9110b-76cb-4a50-b36d-54063151adb1
b9374444-432a-47ed-a799-9c4dd1b965e4	2	DataElementComponent	\N	cb283885-b3e5-4942-82e4-a480dd002b93	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\n002dc358-4c90-4b4f-a81b-6a6f4fe33707|DataClassComponent|bAndCToE|null\ncb283885-b3e5-4942-82e4-a480dd002b93|DataElementComponent|JOIN KEY|null	f	JOIN KEY	0dd9110b-76cb-4a50-b36d-54063151adb1
c5a3328a-45e3-4bff-a7a2-89bc7633e686	4	DataElement	\N	64c5dcda-4422-463d-927f-73a8c439e477	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\nd66b9510-73e8-4c9e-b7db-2822c8974312|DataClass|tableD|null\n64c5dcda-4422-463d-927f-73a8c439e477|DataElement|columnO|null	f	columnO	c916cc68-c3ab-4c26-9a52-682c404ef292
c780195d-64c3-4c41-8de0-c74306776e69	4	DataElement	\N	b93e712e-e06a-4aeb-90a8-88481d283e7a	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\na2cd824d-3691-43ff-b50f-a8a846cc5358|DataClass|tableE|null\nb93e712e-e06a-4aeb-90a8-88481d283e7a|DataElement|columnS|null	f	columnS	fd2ef7e5-4773-4a2e-a29f-9a41ac41982c
e5d5f64c-f1e8-4c9d-bc12-560bc48c920c	4	DataElement	\N	048a9c0f-08a0-4a99-91bf-eaa4c7948020	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\na2cd824d-3691-43ff-b50f-a8a846cc5358|DataClass|tableE|null\n048a9c0f-08a0-4a99-91bf-eaa4c7948020|DataElement|columnT|null	f	columnT	fd2ef7e5-4773-4a2e-a29f-9a41ac41982c
e75222c0-43a4-48aa-9160-5f28a4a004f7	4	DataElement	\N	d0430c92-f9d4-4c12-aa1f-840cb041737c	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\na2cd824d-3691-43ff-b50f-a8a846cc5358|DataClass|tableE|null\nd0430c92-f9d4-4c12-aa1f-840cb041737c|DataElement|columnV|null	f	columnV	fd2ef7e5-4773-4a2e-a29f-9a41ac41982c
e865c436-0dc7-418e-9c71-636edce47cad	2	DataElementComponent	\N	96ce9787-4981-4a03-8cb0-1497d609fd75	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\n002dc358-4c90-4b4f-a81b-6a6f4fe33707|DataClassComponent|bAndCToE|null\n96ce9787-4981-4a03-8cb0-1497d609fd75|DataElementComponent|CONCAT|null	f	CONCAT	0dd9110b-76cb-4a50-b36d-54063151adb1
f52a54cb-1127-4649-a76a-9d21c9e4fd2f	2	DataElementComponent	\N	054e63a6-33f9-4ee6-9e65-958f038b8ecd	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\n002dc358-4c90-4b4f-a81b-6a6f4fe33707|DataClassComponent|bAndCToE|null\n054e63a6-33f9-4ee6-9e65-958f038b8ecd|DataElementComponent|Direct Copy|null	f	Direct Copy	0dd9110b-76cb-4a50-b36d-54063151adb1
03182574-a012-4e40-8576-ff7be49e5404	2	DataElementComponent	\N	0f177626-1566-454b-8d20-a42aed771b58	4cb3611e-12dc-4b86-a996-da79283818fe|DataModel|TargetFlowDataModel|false\n7d67c734-2064-4834-92ba-fca961cb9b18|DataFlow|Sample DataFlow|null\n002dc358-4c90-4b4f-a81b-6a6f4fe33707|DataClassComponent|bAndCToE|null\n0f177626-1566-454b-8d20-a42aed771b58|DataElementComponent|CASE|null	f	CASE	0dd9110b-76cb-4a50-b36d-54063151adb1
34a5f3fc-c501-4165-95ad-a30be3e7802a	4	DataElement	\N	2050c541-3ca4-4aa0-8bd4-0b34215b9e54	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\nb6d0d671-d676-4f03-bf1a-5a502576d75e|DataClass|tableC|null\n2050c541-3ca4-4aa0-8bd4-0b34215b9e54|DataElement|columnK|null	f	columnK	9a427250-eb8d-4897-b4a2-ee0ad7308e6a
50346ea3-0995-4e69-b1e7-9e6919d45ca9	4	DataElement	\N	bc6362c1-f63c-4cd2-b867-d561667622a4	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\nb6d0d671-d676-4f03-bf1a-5a502576d75e|DataClass|tableC|null\nbc6362c1-f63c-4cd2-b867-d561667622a4|DataElement|columnE2|null	f	columnE2	9a427250-eb8d-4897-b4a2-ee0ad7308e6a
7ad7984d-a530-4024-93ef-f8e3a0a4f0e5	4	DataElement	\N	d09db654-bb94-4744-af40-fab7eaa1ce14	1c412f8c-0369-41db-8472-9c5e89469b5f|DataModel|SourceFlowDataModel|false\nb6d0d671-d676-4f03-bf1a-5a502576d75e|DataClass|tableC|null\nd09db654-bb94-4744-af40-fab7eaa1ce14|DataElement|columnM|null	f	columnM	9a427250-eb8d-4897-b4a2-ee0ad7308e6a
c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447	4	Terminology	f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false	t	Complex Test Terminology	\N
7b3ae3a5-0abc-4ec2-90ae-bbea4de91f84	4	ReferenceDataModel	f	92e6abca-5ae4-4d01-b9db-fd577aaac4be	92e6abca-5ae4-4d01-b9db-fd577aaac4be|ReferenceDataModel|Simple Reference Data Model|false	t	Simple Reference Data Model	\N
a9c99cf1-c177-41d4-bdb8-b4c1ee52c3f0	4	ReferencePrimitiveType	\N	66858e4c-0a6e-47ff-995b-ff7fe5aae537	92e6abca-5ae4-4d01-b9db-fd577aaac4be|ReferenceDataModel|Simple Reference Data Model|false\n66858e4c-0a6e-47ff-995b-ff7fe5aae537|ReferencePrimitiveType|string|null	f	string	7b3ae3a5-0abc-4ec2-90ae-bbea4de91f84
affc3ba6-ff9d-4fbb-9e0f-59027f98ffe6	3	ReferenceDataElement	\N	59773fd0-48bb-4138-b6f4-eec60dbadfca	92e6abca-5ae4-4d01-b9db-fd577aaac4be|ReferenceDataModel|Simple Reference Data Model|false\n59773fd0-48bb-4138-b6f4-eec60dbadfca|ReferenceDataElement|Organisation code|null	f	Organisation code	7b3ae3a5-0abc-4ec2-90ae-bbea4de91f84
f3f5a0b1-e1a4-494b-96c6-f7cb8d66923d	3	ReferenceDataElement	\N	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	92e6abca-5ae4-4d01-b9db-fd577aaac4be|ReferenceDataModel|Simple Reference Data Model|false\n2e22cfaa-47d5-4bca-bc5b-50ed2bf71846|ReferenceDataElement|Organisation name|null	f	Organisation name	7b3ae3a5-0abc-4ec2-90ae-bbea4de91f84
2c9465f1-864b-4f2d-919f-63098213add8	4	ReferencePrimitiveType	\N	976d3d0e-3729-4358-b3cb-85d34800916e	92e6abca-5ae4-4d01-b9db-fd577aaac4be|ReferenceDataModel|Simple Reference Data Model|false\n976d3d0e-3729-4358-b3cb-85d34800916e|ReferencePrimitiveType|integer|null	f	integer	7b3ae3a5-0abc-4ec2-90ae-bbea4de91f84
cbb53b06-d34c-4280-8b8d-8ed037bf6477	2	Term	\N	78f5b327-befc-4b99-876e-c61f919ceb67	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n78f5b327-befc-4b99-876e-c61f919ceb67|Term|CTT29: Complex Test Term 29|null	f	CTT29: Complex Test Term 29	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
ce43ce0d-7e43-4a25-b86b-908fc39d5e90	2	Term	\N	d82b571d-5a6b-44cc-9c59-fd1f0fa9a223	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nd82b571d-5a6b-44cc-9c59-fd1f0fa9a223|Term|CTT42: Complex Test Term 42|null	f	CTT42: Complex Test Term 42	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
d0fae6ca-2427-4c8a-b19f-5ab4ab90611f	2	Term	\N	f2ca0183-8b72-41f3-a75e-ab4204d452a5	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf2ca0183-8b72-41f3-a75e-ab4204d452a5|Term|CTT10: Complex Test Term 10|null	f	CTT10: Complex Test Term 10	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
d19a550b-ccc2-4b27-bbc0-2593fa87ac5a	2	Term	\N	3531b6a3-c1fe-4aa1-8efa-6180dcc1b0ed	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n3531b6a3-c1fe-4aa1-8efa-6180dcc1b0ed|Term|CTT98: Complex Test Term 98|null	f	CTT98: Complex Test Term 98	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
d53754b7-fdcc-4477-b969-b9ed05552ecf	2	Term	\N	224f7429-5295-489b-b8af-4998b0593b38	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n224f7429-5295-489b-b8af-4998b0593b38|Term|CTT50: Complex Test Term 50|null	f	CTT50: Complex Test Term 50	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
d5c3ea2f-1659-4d96-a93f-52676b9fef85	2	Term	\N	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n5cd40598-a8bd-48d7-9003-e3513c7b3f6b|Term|CTT30: Complex Test Term 30|null	f	CTT30: Complex Test Term 30	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
d6a8b61b-9759-4383-bb8d-1d2cfcc217c0	2	Term	\N	81ce2a3a-647e-40d4-a903-022dafc00926	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n81ce2a3a-647e-40d4-a903-022dafc00926|Term|CTT2: Complex Test Term 2|null	f	CTT2: Complex Test Term 2	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
da9f8189-3ded-40eb-9a6c-4a7393d7574f	2	Term	\N	a7b211da-b399-49fd-9f28-cab4194cf015	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na7b211da-b399-49fd-9f28-cab4194cf015|Term|CTT85: Complex Test Term 85|null	f	CTT85: Complex Test Term 85	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
deaa3af4-cafa-4892-9b61-18cc9540d245	2	Term	\N	69bd2789-97a6-43a5-9adc-bf6e783c8217	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n69bd2789-97a6-43a5-9adc-bf6e783c8217|Term|CTT22: Complex Test Term 22|null	f	CTT22: Complex Test Term 22	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
dec5bcd0-6aa3-47e2-b0ef-b0e8138a9854	2	Term	\N	7db966c7-cde8-411e-898f-77753e51399e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7db966c7-cde8-411e-898f-77753e51399e|Term|CTT52: Complex Test Term 52|null	f	CTT52: Complex Test Term 52	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
df74d894-ba76-4201-bdf7-d8588fae8550	2	Term	\N	f79a800e-65c8-4267-805b-a11d97d684c0	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf79a800e-65c8-4267-805b-a11d97d684c0|Term|CTT28: Complex Test Term 28|null	f	CTT28: Complex Test Term 28	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
e239b3ed-c333-4943-814d-c671a3430760	2	Term	\N	4f5942bc-0a6b-4fd1-907a-3be9857829de	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n4f5942bc-0a6b-4fd1-907a-3be9857829de|Term|CTT64: Complex Test Term 64|null	f	CTT64: Complex Test Term 64	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
e2c07afb-b66b-4043-b512-94533f40605a	2	TermRelationshipType	\N	6d4f4ed1-a873-4d32-8b38-d1ef3b8e62b5	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n6d4f4ed1-a873-4d32-8b38-d1ef3b8e62b5|TermRelationshipType|is-a|null	f	is-a	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
e3d6bc21-a92d-417e-9e75-75b670bd230a	2	Term	\N	418dac17-dbc8-4496-9570-9d0f16d8fb13	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n418dac17-dbc8-4496-9570-9d0f16d8fb13|Term|CTT19: Complex Test Term 19|null	f	CTT19: Complex Test Term 19	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
e43cd170-126f-44cb-bd60-aa8cfcc8c2ef	2	Term	\N	0139b193-222d-4bde-8077-2a9ea50dc69b	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n0139b193-222d-4bde-8077-2a9ea50dc69b|Term|CTT20: Complex Test Term 20|null	f	CTT20: Complex Test Term 20	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
e4bbe818-41d1-4ad7-b2e6-9cd6ef29a353	2	Term	\N	79be971d-7827-430d-9e03-8089f890f00a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n79be971d-7827-430d-9e03-8089f890f00a|Term|CTT53: Complex Test Term 53|null	f	CTT53: Complex Test Term 53	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
e507dac2-53b3-4768-b68f-8bebcd0225f0	2	Term	\N	7e91ccae-41d4-415e-92ee-50387659f2e5	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7e91ccae-41d4-415e-92ee-50387659f2e5|Term|CTT14: Complex Test Term 14|null	f	CTT14: Complex Test Term 14	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
e53b26a7-d85a-4c1b-aaf2-ef3e4f48181e	2	Term	\N	6a01d8b9-e446-477c-bb5d-94f8ac4a53dc	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n6a01d8b9-e446-477c-bb5d-94f8ac4a53dc|Term|CTT27: Complex Test Term 27|null	f	CTT27: Complex Test Term 27	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
e9779223-5333-495a-a05b-5de14bfad625	2	Term	\N	6c013905-0c1b-47a5-8ac4-9db79a5bde9e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n6c013905-0c1b-47a5-8ac4-9db79a5bde9e|Term|CTT91: Complex Test Term 91|null	f	CTT91: Complex Test Term 91	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
ed41d342-9a77-49a6-9db1-7c8d8d5d7a31	2	TermRelationship	\N	0cb75211-d5b9-4d94-b5c7-51efccc33545	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n418dac17-dbc8-4496-9570-9d0f16d8fb13|Term|CTT19: Complex Test Term 19|null\n0cb75211-d5b9-4d94-b5c7-51efccc33545|TermRelationship|is-a-part-of|null	f	is-a-part-of	e3d6bc21-a92d-417e-9e75-75b670bd230a
ed50049e-5188-4ecd-b073-fd9fac359cfb	2	TermRelationship	\N	3e133c10-3e2e-497a-8745-9f2ce28db697	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n5cd40598-a8bd-48d7-9003-e3513c7b3f6b|Term|CTT30: Complex Test Term 30|null\n3e133c10-3e2e-497a-8745-9f2ce28db697|TermRelationship|is-a-part-of|null	f	is-a-part-of	d5c3ea2f-1659-4d96-a93f-52676b9fef85
ed8e5039-3fc9-4461-b614-f3c3b145abfc	2	TermRelationship	\N	645d7e4a-d023-4217-8ebd-6391b0b5ef37	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n0139b193-222d-4bde-8077-2a9ea50dc69b|Term|CTT20: Complex Test Term 20|null\n645d7e4a-d023-4217-8ebd-6391b0b5ef37|TermRelationship|is-a-part-of|null	f	is-a-part-of	e43cd170-126f-44cb-bd60-aa8cfcc8c2ef
f176e5f2-99fb-4b1c-a684-c56754569cf4	2	Term	\N	101f1d61-8fc9-4b33-a520-568cf03a2613	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n101f1d61-8fc9-4b33-a520-568cf03a2613|Term|CTT96: Complex Test Term 96|null	f	CTT96: Complex Test Term 96	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
f6a29049-a802-49e6-97eb-8f26f15615cd	2	Term	\N	966c91cd-a2b2-45fe-9172-b32077156666	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n966c91cd-a2b2-45fe-9172-b32077156666|Term|CTT73: Complex Test Term 73|null	f	CTT73: Complex Test Term 73	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
f87a5bbb-10fd-414d-aaf5-958f77db9ea3	2	TermRelationship	\N	548cebca-9219-4396-97cb-be39d77827a2	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nd82b571d-5a6b-44cc-9c59-fd1f0fa9a223|Term|CTT42: Complex Test Term 42|null\n548cebca-9219-4396-97cb-be39d77827a2|TermRelationship|is-a-part-of|null	f	is-a-part-of	ce43ce0d-7e43-4a25-b86b-908fc39d5e90
f9dc8897-69c0-4bee-a43e-ade18964b04d	2	Term	\N	138e033f-e261-4e6f-a33c-ba2e6c3248af	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n138e033f-e261-4e6f-a33c-ba2e6c3248af|Term|CTT72: Complex Test Term 72|null	f	CTT72: Complex Test Term 72	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
fbb077ba-aaf6-4e90-b657-e0eaab04a169	2	Term	\N	27ead685-0ac8-4cae-81d6-b89deafcdd28	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n27ead685-0ac8-4cae-81d6-b89deafcdd28|Term|CTT97: Complex Test Term 97|null	f	CTT97: Complex Test Term 97	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
01a77b47-7f65-4501-b65a-e68415e6605c	2	TermRelationship	\N	2b705546-b539-435d-9d91-3f0f13c87d64	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf2ca0183-8b72-41f3-a75e-ab4204d452a5|Term|CTT10: Complex Test Term 10|null\n2b705546-b539-435d-9d91-3f0f13c87d64|TermRelationship|is-a-part-of|null	f	is-a-part-of	d0fae6ca-2427-4c8a-b19f-5ab4ab90611f
01e1fb42-1f62-4c4e-967a-e2d02dd449fb	2	TermRelationship	\N	8f4c7395-558f-4927-a2eb-ef4a734cf2d9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na7b211da-b399-49fd-9f28-cab4194cf015|Term|CTT85: Complex Test Term 85|null\n8f4c7395-558f-4927-a2eb-ef4a734cf2d9|TermRelationship|is-a-part-of|null	f	is-a-part-of	da9f8189-3ded-40eb-9a6c-4a7393d7574f
0316f929-a4f9-4c68-8415-cd316a3d29c3	2	Term	\N	9ed15988-e1ca-42f7-b61a-9f1cbf1e4289	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9ed15988-e1ca-42f7-b61a-9f1cbf1e4289|Term|CTT99: Complex Test Term 99|null	f	CTT99: Complex Test Term 99	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
079190f8-81be-427f-8180-0874012af93f	2	Term	\N	cfbf199a-442d-4819-91af-5ecf85abab8e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ncfbf199a-442d-4819-91af-5ecf85abab8e|Term|CTT44: Complex Test Term 44|null	f	CTT44: Complex Test Term 44	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
0831c0a9-2432-4fa6-8d3b-a537cb8c3980	2	TermRelationship	\N	1b154790-020f-49f8-9f95-0aad623fba52	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n78f5b327-befc-4b99-876e-c61f919ceb67|Term|CTT29: Complex Test Term 29|null\n1b154790-020f-49f8-9f95-0aad623fba52|TermRelationship|is-a-part-of|null	f	is-a-part-of	cbb53b06-d34c-4280-8b8d-8ed037bf6477
0b899a54-6b08-43fd-ab4a-6105db8ef00e	2	Term	\N	c70309d4-1e06-4600-97af-17d1f02c7e5c	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc70309d4-1e06-4600-97af-17d1f02c7e5c|Term|CTT37: Complex Test Term 37|null	f	CTT37: Complex Test Term 37	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
0d2ad825-520d-49fc-8ef2-2d588b36a7fe	2	Term	\N	45c82b1c-67ab-4018-b0a9-087acd671522	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n45c82b1c-67ab-4018-b0a9-087acd671522|Term|CTT67: Complex Test Term 67|null	f	CTT67: Complex Test Term 67	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
0ed41d3b-91e7-4aa2-a3d6-fc4fe6c99c46	2	Term	\N	66a5991d-dca7-44d3-8140-9944dfc4497d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n66a5991d-dca7-44d3-8140-9944dfc4497d|Term|CTT63: Complex Test Term 63|null	f	CTT63: Complex Test Term 63	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
0f44235c-e087-45ee-87c9-18df8f08e941	2	TermRelationship	\N	6a4b6685-4a2f-45ca-85fb-7a2281be48a9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n3531b6a3-c1fe-4aa1-8efa-6180dcc1b0ed|Term|CTT98: Complex Test Term 98|null\n6a4b6685-4a2f-45ca-85fb-7a2281be48a9|TermRelationship|is-a-part-of|null	f	is-a-part-of	d19a550b-ccc2-4b27-bbc0-2593fa87ac5a
0fd9fd10-b428-4d8e-a0bc-05c5bf6406dc	2	Term	\N	de3364c4-aacf-4a22-b30c-0eb113c33f81	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nde3364c4-aacf-4a22-b30c-0eb113c33f81|Term|CTT33: Complex Test Term 33|null	f	CTT33: Complex Test Term 33	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
10a0d1b6-8a65-4501-8cc1-285a94c06b7e	2	Term	\N	15d499ac-3edd-4264-811a-40cabb8b6dce	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n15d499ac-3edd-4264-811a-40cabb8b6dce|Term|CTT56: Complex Test Term 56|null	f	CTT56: Complex Test Term 56	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
10f725d1-83fd-422c-a920-760c9b29b59c	2	Term	\N	c39c02c4-5590-4cc4-82bc-98baea435d60	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc39c02c4-5590-4cc4-82bc-98baea435d60|Term|CTT65: Complex Test Term 65|null	f	CTT65: Complex Test Term 65	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
111b4d2f-e3ba-4f6f-9bd0-7faa0a26cd02	2	TermRelationship	\N	3251244a-7e0b-4dbf-9edd-87267cf16198	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc39c02c4-5590-4cc4-82bc-98baea435d60|Term|CTT65: Complex Test Term 65|null\n3251244a-7e0b-4dbf-9edd-87267cf16198|TermRelationship|is-a-part-of|null	f	is-a-part-of	10f725d1-83fd-422c-a920-760c9b29b59c
13cdbba1-35c8-4f4e-94e5-88c80306fb4f	2	Term	\N	9da7f89e-0f4f-4407-b2b4-e205fcf7ebf4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9da7f89e-0f4f-4407-b2b4-e205fcf7ebf4|Term|CTT23: Complex Test Term 23|null	f	CTT23: Complex Test Term 23	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
1401143a-22ea-4298-8c0e-86c3b98b72c6	2	Term	\N	dd3deeb9-669d-4b04-95d0-74f47006bc59	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ndd3deeb9-669d-4b04-95d0-74f47006bc59|Term|CTT80: Complex Test Term 80|null	f	CTT80: Complex Test Term 80	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
166e8500-daaf-4713-9c4f-a702ab34d117	2	TermRelationship	\N	4ed278d0-3394-4ff1-a73a-d113a4b259af	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ndd3deeb9-669d-4b04-95d0-74f47006bc59|Term|CTT80: Complex Test Term 80|null\n4ed278d0-3394-4ff1-a73a-d113a4b259af|TermRelationship|is-a-part-of|null	f	is-a-part-of	1401143a-22ea-4298-8c0e-86c3b98b72c6
19631df1-a17f-4ba8-a5c9-0e1d7e1ce2ad	2	Term	\N	c483431b-579b-4e17-9163-8cbc4ac27516	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc483431b-579b-4e17-9163-8cbc4ac27516|Term|CTT68: Complex Test Term 68|null	f	CTT68: Complex Test Term 68	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
1b4423cd-a0c0-4094-b2df-7f00a3f17174	2	Term	\N	5da8046a-c396-42b1-95c7-70f97258ecaf	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n5da8046a-c396-42b1-95c7-70f97258ecaf|Term|CTT18: Complex Test Term 18|null	f	CTT18: Complex Test Term 18	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
1fbb972d-ec0e-4aa6-bac1-2dfbee57a95d	2	Term	\N	1dd60ede-3f14-4e99-a623-a7200426e2e1	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n1dd60ede-3f14-4e99-a623-a7200426e2e1|Term|CTT95: Complex Test Term 95|null	f	CTT95: Complex Test Term 95	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
20af71f3-8e20-4d99-b0af-d3126cc4164b	2	TermRelationship	\N	977cafb3-ed45-4b09-bf71-398937b064e9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n966c91cd-a2b2-45fe-9172-b32077156666|Term|CTT73: Complex Test Term 73|null\n977cafb3-ed45-4b09-bf71-398937b064e9|TermRelationship|is-a-part-of|null	f	is-a-part-of	f6a29049-a802-49e6-97eb-8f26f15615cd
23440f71-d763-4efa-aa6f-a1c4fed204d6	2	TermRelationship	\N	89f3eb60-1cf2-42d0-b043-eee706c5f8de	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9da7f89e-0f4f-4407-b2b4-e205fcf7ebf4|Term|CTT23: Complex Test Term 23|null\n89f3eb60-1cf2-42d0-b043-eee706c5f8de|TermRelationship|is-a-part-of|null	f	is-a-part-of	13cdbba1-35c8-4f4e-94e5-88c80306fb4f
23997534-f827-40f7-8e89-5bed92923fb5	2	Term	\N	2b09c524-e3db-4aa1-80e7-28038f5fc5b2	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n2b09c524-e3db-4aa1-80e7-28038f5fc5b2|Term|CTT47: Complex Test Term 47|null	f	CTT47: Complex Test Term 47	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
28351da6-824b-446e-a6b6-d26b0d622cdc	2	Term	\N	09568626-94a3-48ca-a9f6-8b3393013fe1	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n09568626-94a3-48ca-a9f6-8b3393013fe1|Term|CTT3: Complex Test Term 3|null	f	CTT3: Complex Test Term 3	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
285077f1-f11d-411b-a8f3-2a18bb295e90	2	Term	\N	da64d023-3573-4b2b-9b2b-803836246e9a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nda64d023-3573-4b2b-9b2b-803836246e9a|Term|CTT46: Complex Test Term 46|null	f	CTT46: Complex Test Term 46	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
28ae9533-d81d-4555-b3a9-ddf32dc80511	2	Term	\N	13a6ae7d-dede-41f6-9353-aa24fdf9b5a4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n13a6ae7d-dede-41f6-9353-aa24fdf9b5a4|Term|CTT54: Complex Test Term 54|null	f	CTT54: Complex Test Term 54	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
2c9b5520-1a6d-4eee-ab5f-63f0cbd91ef1	2	TermRelationship	\N	d4faf174-f904-4bd5-8e98-66976ea09ec5	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nda64d023-3573-4b2b-9b2b-803836246e9a|Term|CTT46: Complex Test Term 46|null\nd4faf174-f904-4bd5-8e98-66976ea09ec5|TermRelationship|is-a-part-of|null	f	is-a-part-of	285077f1-f11d-411b-a8f3-2a18bb295e90
2d0685a1-c4cf-487e-8e50-4cb61f8b3dd4	2	Term	\N	b49f7b23-3d75-4d7f-91c3-7cd36378ecd0	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nb49f7b23-3d75-4d7f-91c3-7cd36378ecd0|Term|CTT57: Complex Test Term 57|null	f	CTT57: Complex Test Term 57	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
2d8c3999-923d-4500-b99d-9a921dfef44b	2	Term	\N	673f6435-1147-48d8-9f30-0036c4f12df0	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n673f6435-1147-48d8-9f30-0036c4f12df0|Term|CTT78: Complex Test Term 78|null	f	CTT78: Complex Test Term 78	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
32506d30-1525-4ac0-914e-7b265f9ef24e	2	Term	\N	6c0d0b48-61af-4e44-b5e5-1b03fcfd80e1	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n6c0d0b48-61af-4e44-b5e5-1b03fcfd80e1|Term|CTT84: Complex Test Term 84|null	f	CTT84: Complex Test Term 84	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
326bfebd-db6c-404e-87b8-a11398f17155	2	TermRelationship	\N	f0aca16f-8ecd-447b-a86c-3e8d544241d4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n09568626-94a3-48ca-a9f6-8b3393013fe1|Term|CTT3: Complex Test Term 3|null\nf0aca16f-8ecd-447b-a86c-3e8d544241d4|TermRelationship|narrowerThan|null	f	narrowerThan	28351da6-824b-446e-a6b6-d26b0d622cdc
345541a7-8af9-47f8-aa5f-1c8cd39c988f	2	TermRelationship	\N	9871d3d7-6321-488c-bf63-0bd65f1631bb	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n09568626-94a3-48ca-a9f6-8b3393013fe1|Term|CTT3: Complex Test Term 3|null\n9871d3d7-6321-488c-bf63-0bd65f1631bb|TermRelationship|is-a-part-of|null	f	is-a-part-of	28351da6-824b-446e-a6b6-d26b0d622cdc
35cd8351-13d2-4fbb-9bcf-7dca9ef24953	2	Term	\N	18034212-f5c2-4244-b5dd-fa23e76725d6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n18034212-f5c2-4244-b5dd-fa23e76725d6|Term|CTT11: Complex Test Term 11|null	f	CTT11: Complex Test Term 11	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
3858e610-de22-4984-94c8-0d036701f60e	2	TermRelationship	\N	9dec5cb4-5d0a-43a2-92c7-c003687b0035	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n673f6435-1147-48d8-9f30-0036c4f12df0|Term|CTT78: Complex Test Term 78|null\n9dec5cb4-5d0a-43a2-92c7-c003687b0035|TermRelationship|is-a-part-of|null	f	is-a-part-of	2d8c3999-923d-4500-b99d-9a921dfef44b
38cbda61-b3d7-429f-b837-172c8c87e8dd	2	TermRelationship	\N	c99ead1e-2582-4672-92dd-7fa4eb5ea06d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n224f7429-5295-489b-b8af-4998b0593b38|Term|CTT50: Complex Test Term 50|null\nc99ead1e-2582-4672-92dd-7fa4eb5ea06d|TermRelationship|is-a-part-of|null	f	is-a-part-of	d53754b7-fdcc-4477-b969-b9ed05552ecf
397784c1-6cdb-4832-bdd9-034338921130	2	Term	\N	de06b170-e802-4e59-a99e-3c9aafad340a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nde06b170-e802-4e59-a99e-3c9aafad340a|Term|CTT66: Complex Test Term 66|null	f	CTT66: Complex Test Term 66	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
3a4f0e35-4131-49ca-8cb6-13f2ebc31711	2	Term	\N	9010bddb-88e0-493c-bbef-ce1b56aad1b4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9010bddb-88e0-493c-bbef-ce1b56aad1b4|Term|CTT32: Complex Test Term 32|null	f	CTT32: Complex Test Term 32	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
3cdb6065-bae6-4154-90f0-fc438ce4d847	2	TermRelationshipType	\N	00c30b70-25df-4b66-8887-feeb990309f3	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n00c30b70-25df-4b66-8887-feeb990309f3|TermRelationshipType|is-a-part-of|null	f	is-a-part-of	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
3e7492b9-8eef-41e1-a13d-9032972fc447	2	Term	\N	c5fd1676-d7c2-44d4-9eac-7ead6d00256e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc5fd1676-d7c2-44d4-9eac-7ead6d00256e|Term|CTT48: Complex Test Term 48|null	f	CTT48: Complex Test Term 48	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
3ecd44d6-2920-4d3e-b4cb-1e7fc6e517ee	2	TermRelationship	\N	b35e0294-3a15-4f63-b9a7-40ff0d66fab4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n101f1d61-8fc9-4b33-a520-568cf03a2613|Term|CTT96: Complex Test Term 96|null\nb35e0294-3a15-4f63-b9a7-40ff0d66fab4|TermRelationship|is-a-part-of|null	f	is-a-part-of	f176e5f2-99fb-4b1c-a684-c56754569cf4
43869643-cad3-4403-b644-a4d0704132a1	2	TermRelationship	\N	af7b10cb-8691-4605-a505-c15ac22e43c1	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc70309d4-1e06-4600-97af-17d1f02c7e5c|Term|CTT37: Complex Test Term 37|null\naf7b10cb-8691-4605-a505-c15ac22e43c1|TermRelationship|is-a-part-of|null	f	is-a-part-of	0b899a54-6b08-43fd-ab4a-6105db8ef00e
4432285a-eb88-4958-a9e4-a4f07762de89	2	Term	\N	7e31a14f-5339-40f5-9cf5-3a9e540f0600	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7e31a14f-5339-40f5-9cf5-3a9e540f0600|Term|CTT15: Complex Test Term 15|null	f	CTT15: Complex Test Term 15	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
4518cf0d-a4b6-4629-b19e-6af5a06fecae	2	Term	\N	bfa2411d-97c4-44bf-9224-f1f5245c47de	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nbfa2411d-97c4-44bf-9224-f1f5245c47de|Term|CTT00: Complex Test Term 00|null	f	CTT00: Complex Test Term 00	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
469a2ecb-19fa-4c09-9ab9-dc3f7abbc1b7	2	Term	\N	07bbdde8-81fc-40f7-915a-b312924d60d0	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n07bbdde8-81fc-40f7-915a-b312924d60d0|Term|CTT24: Complex Test Term 24|null	f	CTT24: Complex Test Term 24	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
46d2269e-f5c0-473c-ae0e-d4eb71863719	2	Term	\N	3d731a71-d245-4e17-8baf-8793161982ee	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n3d731a71-d245-4e17-8baf-8793161982ee|Term|CTT83: Complex Test Term 83|null	f	CTT83: Complex Test Term 83	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
48063e33-d127-49fc-ae39-f990ccdb947f	2	TermRelationship	\N	4489cfe3-4b9c-423f-adcf-7808eb99ca2e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9010bddb-88e0-493c-bbef-ce1b56aad1b4|Term|CTT32: Complex Test Term 32|null\n4489cfe3-4b9c-423f-adcf-7808eb99ca2e|TermRelationship|is-a-part-of|null	f	is-a-part-of	3a4f0e35-4131-49ca-8cb6-13f2ebc31711
49f0d1c6-e415-4cb3-9243-e42846bddb08	2	TermRelationshipType	\N	c4960220-4d94-4c75-bd17-a46b1415bbf6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc4960220-4d94-4c75-bd17-a46b1415bbf6|TermRelationshipType|broaderThan|null	f	broaderThan	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
4df175c3-0448-4daa-8fd7-e88cc57cb2ce	2	Term	\N	ccba40ce-a827-43d9-9135-57cb4de1ad68	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nccba40ce-a827-43d9-9135-57cb4de1ad68|Term|CTT31: Complex Test Term 31|null	f	CTT31: Complex Test Term 31	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
4f5cbb08-f596-465a-9ffb-67a32b3ba0f2	2	Term	\N	aa15a48d-1f0e-434c-ac2c-f8a3e36d8d37	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\naa15a48d-1f0e-434c-ac2c-f8a3e36d8d37|Term|CTT76: Complex Test Term 76|null	f	CTT76: Complex Test Term 76	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
50d1411e-bfc7-48d1-b685-25459b8609ea	2	Term	\N	b6e043e6-aa70-41c0-8a85-bf55986adf32	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nb6e043e6-aa70-41c0-8a85-bf55986adf32|Term|CTT93: Complex Test Term 93|null	f	CTT93: Complex Test Term 93	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
5340bf06-4833-4f85-bcaa-bb8ce772a98f	2	Term	\N	3d93eca4-93b5-4f31-b923-74e97c60dd7e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n3d93eca4-93b5-4f31-b923-74e97c60dd7e|Term|CTT21: Complex Test Term 21|null	f	CTT21: Complex Test Term 21	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
54055903-37a0-458e-85d4-bb5e025d66b8	2	TermRelationship	\N	7da0e12c-5aa7-46a4-8a13-3d341b88c35b	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc5fd1676-d7c2-44d4-9eac-7ead6d00256e|Term|CTT48: Complex Test Term 48|null\n7da0e12c-5aa7-46a4-8a13-3d341b88c35b|TermRelationship|is-a-part-of|null	f	is-a-part-of	3e7492b9-8eef-41e1-a13d-9032972fc447
5523b574-eef6-49c8-8235-495ddc4aa4b5	2	TermRelationship	\N	5bcc72d3-fe4a-4191-bb44-c3d97d328bcb	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n45c82b1c-67ab-4018-b0a9-087acd671522|Term|CTT67: Complex Test Term 67|null\n5bcc72d3-fe4a-4191-bb44-c3d97d328bcb|TermRelationship|is-a-part-of|null	f	is-a-part-of	0d2ad825-520d-49fc-8ef2-2d588b36a7fe
56992ef8-5e48-44ff-a507-a32cb380bcf8	2	Term	\N	f7fb2530-31da-4e49-96c5-ca33f5a95948	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf7fb2530-31da-4e49-96c5-ca33f5a95948|Term|CTT71: Complex Test Term 71|null	f	CTT71: Complex Test Term 71	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
5761d26c-c270-475b-a228-98bd90b960ea	2	TermRelationship	\N	91dce2a0-2d33-4a01-999e-ccb8ce7dd744	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n18034212-f5c2-4244-b5dd-fa23e76725d6|Term|CTT11: Complex Test Term 11|null\n91dce2a0-2d33-4a01-999e-ccb8ce7dd744|TermRelationship|broaderThan|null	f	broaderThan	35cd8351-13d2-4fbb-9bcf-7dca9ef24953
57d23a34-9c35-4880-9362-5c471b7389fa	2	Term	\N	26f74230-995c-4ae6-b010-7440115002dd	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n26f74230-995c-4ae6-b010-7440115002dd|Term|CTT7: Complex Test Term 7|null	f	CTT7: Complex Test Term 7	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
597c2a6c-0000-4235-910e-dbc9971efdaa	2	TermRelationship	\N	ba181721-f12f-4e34-b4e9-cdf7a0a147fb	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nde06b170-e802-4e59-a99e-3c9aafad340a|Term|CTT66: Complex Test Term 66|null\nba181721-f12f-4e34-b4e9-cdf7a0a147fb|TermRelationship|is-a-part-of|null	f	is-a-part-of	397784c1-6cdb-4832-bdd9-034338921130
5a0f58e0-13f6-409e-823d-7a5ac5753a60	2	TermRelationship	\N	975b4784-9523-4347-aed5-6b41375b2462	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7e91ccae-41d4-415e-92ee-50387659f2e5|Term|CTT14: Complex Test Term 14|null\n975b4784-9523-4347-aed5-6b41375b2462|TermRelationship|broaderThan|null	f	broaderThan	e507dac2-53b3-4768-b68f-8bebcd0225f0
5a6931dc-2748-4b87-a262-76476dcc57ae	2	TermRelationship	\N	a2a14f2f-bd5a-4787-a440-1b4d86a2308d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n66a5991d-dca7-44d3-8140-9944dfc4497d|Term|CTT63: Complex Test Term 63|null\na2a14f2f-bd5a-4787-a440-1b4d86a2308d|TermRelationship|is-a-part-of|null	f	is-a-part-of	0ed41d3b-91e7-4aa2-a3d6-fc4fe6c99c46
5c8c3e4d-e968-4fef-99d5-9bf7faa5999c	2	Term	\N	edeeda06-8fee-4cfb-b551-6821f886fee6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nedeeda06-8fee-4cfb-b551-6821f886fee6|Term|CTT6: Complex Test Term 6|null	f	CTT6: Complex Test Term 6	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
5cedd5d3-9819-4e96-8912-e97a22b36076	2	Term	\N	fc870e89-1cd8-4f47-85f9-eb3339cf2b48	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nfc870e89-1cd8-4f47-85f9-eb3339cf2b48|Term|CTT62: Complex Test Term 62|null	f	CTT62: Complex Test Term 62	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
5f7c37d9-91f5-4832-a02f-f5332d9a0b0a	2	Term	\N	129e31ae-f381-4e2f-ae44-d6cbcb39f7df	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n129e31ae-f381-4e2f-ae44-d6cbcb39f7df|Term|CTT77: Complex Test Term 77|null	f	CTT77: Complex Test Term 77	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
605ec1cf-1948-4137-a8a4-7bd7e73f841a	2	Term	\N	85f636ff-72a0-4c14-9524-1c6175b2769e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n85f636ff-72a0-4c14-9524-1c6175b2769e|Term|CTT1: Complex Test Term 1|null	f	CTT1: Complex Test Term 1	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
63df27bb-9157-4c81-b55e-5b9ce9cea40f	2	TermRelationship	\N	e54ca461-ba3a-4821-b51d-18c07bd60fcd	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7e31a14f-5339-40f5-9cf5-3a9e540f0600|Term|CTT15: Complex Test Term 15|null\ne54ca461-ba3a-4821-b51d-18c07bd60fcd|TermRelationship|is-a-part-of|null	f	is-a-part-of	4432285a-eb88-4958-a9e4-a4f07762de89
64391eef-cc47-4573-a940-2958715cb70d	2	TermRelationship	\N	f7235094-b072-483f-a7ec-c48761b71cd8	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n81ce2a3a-647e-40d4-a903-022dafc00926|Term|CTT2: Complex Test Term 2|null\nf7235094-b072-483f-a7ec-c48761b71cd8|TermRelationship|narrowerThan|null	f	narrowerThan	d6a8b61b-9759-4383-bb8d-1d2cfcc217c0
64622060-e221-47b6-84b3-b7234a54db17	2	TermRelationship	\N	9b49e60d-fc13-49fc-b9db-262085fb8222	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n81ce2a3a-647e-40d4-a903-022dafc00926|Term|CTT2: Complex Test Term 2|null\n9b49e60d-fc13-49fc-b9db-262085fb8222|TermRelationship|is-a-part-of|null	f	is-a-part-of	d6a8b61b-9759-4383-bb8d-1d2cfcc217c0
64b3cb4b-17b8-4236-8ee6-5b0865e3b73f	2	TermRelationship	\N	0ed578fe-ff84-47aa-8f47-29ffc43f82e3	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n15d499ac-3edd-4264-811a-40cabb8b6dce|Term|CTT56: Complex Test Term 56|null\n0ed578fe-ff84-47aa-8f47-29ffc43f82e3|TermRelationship|is-a-part-of|null	f	is-a-part-of	10a0d1b6-8a65-4501-8cc1-285a94c06b7e
64e84c36-b8b1-46d9-a43b-7557df117f39	2	TermRelationship	\N	29ac10b5-b3a7-4fee-b85e-1b8b1ea92ca8	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n07bbdde8-81fc-40f7-915a-b312924d60d0|Term|CTT24: Complex Test Term 24|null\n29ac10b5-b3a7-4fee-b85e-1b8b1ea92ca8|TermRelationship|is-a-part-of|null	f	is-a-part-of	469a2ecb-19fa-4c09-9ab9-dc3f7abbc1b7
660c5e36-b86b-4288-a96b-3939532ce559	2	Term	\N	9a65239d-4685-4cb0-96f6-aaaa3fe8f024	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9a65239d-4685-4cb0-96f6-aaaa3fe8f024|Term|CTT36: Complex Test Term 36|null	f	CTT36: Complex Test Term 36	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
68273980-9f78-4e04-b671-895296ee62d0	2	TermRelationship	\N	85f0c71f-00d9-4b0d-bd11-7bbc8390033b	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n69bd2789-97a6-43a5-9adc-bf6e783c8217|Term|CTT22: Complex Test Term 22|null\n85f0c71f-00d9-4b0d-bd11-7bbc8390033b|TermRelationship|is-a-part-of|null	f	is-a-part-of	deaa3af4-cafa-4892-9b61-18cc9540d245
68f713a4-c02b-4e53-baf0-88c148dbaa03	2	Term	\N	402fc088-137d-4e1e-8178-876f921bdb3d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n402fc088-137d-4e1e-8178-876f921bdb3d|Term|CTT70: Complex Test Term 70|null	f	CTT70: Complex Test Term 70	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
69646ba0-a153-4889-92c4-73c5229ab542	2	Term	\N	30594004-573b-4652-b585-094ee77506f9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n30594004-573b-4652-b585-094ee77506f9|Term|CTT49: Complex Test Term 49|null	f	CTT49: Complex Test Term 49	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
6aa72e76-368f-463c-a522-f47ac4ff3a40	2	Term	\N	fd3777b0-521a-46f9-9cf7-4cbdd2cb6006	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nfd3777b0-521a-46f9-9cf7-4cbdd2cb6006|Term|CTT69: Complex Test Term 69|null	f	CTT69: Complex Test Term 69	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
6ab90483-e092-4212-b16c-fea2128b1428	2	TermRelationship	\N	2c39ecc8-d7d3-428a-878f-d6beb4139e4f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n6c0d0b48-61af-4e44-b5e5-1b03fcfd80e1|Term|CTT84: Complex Test Term 84|null\n2c39ecc8-d7d3-428a-878f-d6beb4139e4f|TermRelationship|is-a-part-of|null	f	is-a-part-of	32506d30-1525-4ac0-914e-7b265f9ef24e
7418ad2c-e88e-49c1-9cee-f9dc41e1c839	2	Term	\N	ae8fdb84-b5d9-49bb-a81c-6901f6b7d32a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nae8fdb84-b5d9-49bb-a81c-6901f6b7d32a|Term|CTT92: Complex Test Term 92|null	f	CTT92: Complex Test Term 92	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
746b6dd0-5992-4c40-8ae5-ed4cf54ef85f	2	TermRelationship	\N	0e41f342-a010-4147-bcba-43010810216d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n6a01d8b9-e446-477c-bb5d-94f8ac4a53dc|Term|CTT27: Complex Test Term 27|null\n0e41f342-a010-4147-bcba-43010810216d|TermRelationship|is-a-part-of|null	f	is-a-part-of	e53b26a7-d85a-4c1b-aaf2-ef3e4f48181e
7583e5ec-869f-4323-b41d-bafb299b1ce3	2	Term	\N	15bf739d-0a84-4bf6-9d75-89fa47b9f929	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n15bf739d-0a84-4bf6-9d75-89fa47b9f929|Term|CTT89: Complex Test Term 89|null	f	CTT89: Complex Test Term 89	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
76794f0b-c3ea-4253-b089-0517d16659d2	2	TermRelationship	\N	1080a4ce-a9a5-49d3-aa78-9e345155a245	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf7fb2530-31da-4e49-96c5-ca33f5a95948|Term|CTT71: Complex Test Term 71|null\n1080a4ce-a9a5-49d3-aa78-9e345155a245|TermRelationship|is-a-part-of|null	f	is-a-part-of	56992ef8-5e48-44ff-a507-a32cb380bcf8
7777d38f-adfd-4360-8896-c08877c68719	2	Term	\N	708f794d-56a9-4ef2-81f3-f7cd163201e9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n708f794d-56a9-4ef2-81f3-f7cd163201e9|Term|CTT12: Complex Test Term 12|null	f	CTT12: Complex Test Term 12	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
7790c6db-d50e-4b07-ae22-adb967aa56a5	2	Term	\N	a42e7a84-8e5f-423e-92ec-2eec5156eac8	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na42e7a84-8e5f-423e-92ec-2eec5156eac8|Term|CTT38: Complex Test Term 38|null	f	CTT38: Complex Test Term 38	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
782bf016-ae19-4521-a31c-880eb1024c4f	2	TermRelationship	\N	37301770-1e93-4f41-9864-81f15e4857fb	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n27ead685-0ac8-4cae-81d6-b89deafcdd28|Term|CTT97: Complex Test Term 97|null\n37301770-1e93-4f41-9864-81f15e4857fb|TermRelationship|is-a-part-of|null	f	is-a-part-of	fbb077ba-aaf6-4e90-b657-e0eaab04a169
78b85ffa-304b-415a-8111-15fe2d3ae911	2	Term	\N	bbf81fec-09e4-4b93-a7f3-49c6f463d9a2	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nbbf81fec-09e4-4b93-a7f3-49c6f463d9a2|Term|CTT88: Complex Test Term 88|null	f	CTT88: Complex Test Term 88	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
797d3dbd-55f2-42bd-9334-973f8f85915b	2	TermRelationship	\N	517c0269-cf62-48e2-936e-fd5e2530c5eb	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nedeeda06-8fee-4cfb-b551-6821f886fee6|Term|CTT6: Complex Test Term 6|null\n517c0269-cf62-48e2-936e-fd5e2530c5eb|TermRelationship|is-a-part-of|null	f	is-a-part-of	5c8c3e4d-e968-4fef-99d5-9bf7faa5999c
7c24ba86-964a-4638-b70c-7a6decc56d11	2	Term	\N	dc8d8ddd-510b-44be-a507-d4c0fa670f40	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ndc8d8ddd-510b-44be-a507-d4c0fa670f40|Term|CTT16: Complex Test Term 16|null	f	CTT16: Complex Test Term 16	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
7c24f97b-0157-4267-8356-4c857f6bdb8e	2	Term	\N	a877238c-25da-498d-b6da-5fdfdc8abb80	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na877238c-25da-498d-b6da-5fdfdc8abb80|Term|CTT58: Complex Test Term 58|null	f	CTT58: Complex Test Term 58	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
7e47485f-752d-4386-ab07-cbdee4d7fdb1	2	Term	\N	57ad05d4-b529-4958-9cc8-2feedbea2753	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n57ad05d4-b529-4958-9cc8-2feedbea2753|Term|CTT61: Complex Test Term 61|null	f	CTT61: Complex Test Term 61	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
7f0e5f29-81ff-47d7-b76b-e79f78e434d0	2	Term	\N	e2d46641-8b2c-4002-9aeb-8e22ed721a80	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ne2d46641-8b2c-4002-9aeb-8e22ed721a80|Term|CTT101|null	f	CTT101	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
802d9320-e3e7-47a9-a824-3eea8f41bcb1	3	Term	\N	00405a22-2e59-48ac-85bf-2fa5cd44cc14	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n00405a22-2e59-48ac-85bf-2fa5cd44cc14|Term|CTT60: Complex Test Term 60|null	f	CTT60: Complex Test Term 60	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
8271c203-896e-499b-8adf-b9720217c84d	3	Term	\N	54576326-c11d-4436-9354-2d2b430571d8	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n54576326-c11d-4436-9354-2d2b430571d8|Term|CTT9: Complex Test Term 9|null	f	CTT9: Complex Test Term 9	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
82c2c02a-87dc-4b24-84be-23a42d46262e	3	TermRelationshipType	\N	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nbce306a1-2de1-4b20-b74b-26ad75ae2eaf|TermRelationshipType|narrowerThan|null	f	narrowerThan	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
83f1645a-ea8f-44d1-8fa6-53ec5fa91f57	3	Term	\N	887e8bc9-2104-42d2-8528-485b4623c473	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n887e8bc9-2104-42d2-8528-485b4623c473|Term|CTT5: Complex Test Term 5|null	f	CTT5: Complex Test Term 5	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
84b79828-91c1-4249-82e9-70d9a86bdda2	3	Term	\N	132e194c-377c-48ea-aa60-753b156d4ba6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n132e194c-377c-48ea-aa60-753b156d4ba6|Term|CTT59: Complex Test Term 59|null	f	CTT59: Complex Test Term 59	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
865f6bfc-66d9-46e5-9c9e-03f6c0ccd836	3	Term	\N	f0bef74c-309d-448f-83ed-5d6a7287434e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf0bef74c-309d-448f-83ed-5d6a7287434e|Term|CTT43: Complex Test Term 43|null	f	CTT43: Complex Test Term 43	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
8769bf31-ccf5-4012-891f-9a7f027d427d	3	TermRelationship	\N	011ef4fe-838b-45b6-9024-fd8bd297934f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9ed15988-e1ca-42f7-b61a-9f1cbf1e4289|Term|CTT99: Complex Test Term 99|null\n011ef4fe-838b-45b6-9024-fd8bd297934f|TermRelationship|is-a-part-of|null	f	is-a-part-of	0316f929-a4f9-4c68-8415-cd316a3d29c3
87ee52f4-091c-46ad-8869-ed1c0ae5545c	3	Term	\N	9ea09e24-705c-4920-9dba-8ccf39fac00c	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9ea09e24-705c-4920-9dba-8ccf39fac00c|Term|CTT51: Complex Test Term 51|null	f	CTT51: Complex Test Term 51	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
8abb89c6-8539-435d-b971-6be39072b0ec	3	Term	\N	a1c2246a-4ec2-4f50-8e2f-606c8c6b6496	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na1c2246a-4ec2-4f50-8e2f-606c8c6b6496|Term|CTT4: Complex Test Term 4|null	f	CTT4: Complex Test Term 4	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
8b1deef1-998d-46e4-a062-fcbdda58dac2	3	TermRelationship	\N	e2c7b2fd-3677-44d8-802f-34702b5cd1f7	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7e31a14f-5339-40f5-9cf5-3a9e540f0600|Term|CTT15: Complex Test Term 15|null\ne2c7b2fd-3677-44d8-802f-34702b5cd1f7|TermRelationship|broaderThan|null	f	broaderThan	4432285a-eb88-4958-a9e4-a4f07762de89
8c82657a-fc06-49e6-ad81-4284827534e2	3	TermRelationship	\N	4b52cedc-5b0b-4f14-866f-2ebf94ce589c	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na42e7a84-8e5f-423e-92ec-2eec5156eac8|Term|CTT38: Complex Test Term 38|null\n4b52cedc-5b0b-4f14-866f-2ebf94ce589c|TermRelationship|is-a-part-of|null	f	is-a-part-of	7790c6db-d50e-4b07-ae22-adb967aa56a5
8dc9d4c8-c98d-4c64-ad92-363b4c0b2404	3	Term	\N	73e0323a-c8da-4d14-9ba0-af6978425e72	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n73e0323a-c8da-4d14-9ba0-af6978425e72|Term|CTT86: Complex Test Term 86|null	f	CTT86: Complex Test Term 86	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
8fa27aa6-98a5-4bba-8aed-d362e9a8ae54	3	Term	\N	fe87dd5a-7817-4f0f-832f-318ba238846e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nfe87dd5a-7817-4f0f-832f-318ba238846e|Term|CTT34: Complex Test Term 34|null	f	CTT34: Complex Test Term 34	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
8fbb3624-4ef1-4d5d-942e-e6c83d1897ce	3	TermRelationship	\N	d41764a4-cc17-4253-9100-aef867d69ab2	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n4f5942bc-0a6b-4fd1-907a-3be9857829de|Term|CTT64: Complex Test Term 64|null\nd41764a4-cc17-4253-9100-aef867d69ab2|TermRelationship|is-a-part-of|null	f	is-a-part-of	e239b3ed-c333-4943-814d-c671a3430760
8fc91ef2-42a9-491f-87bd-38ef812d355a	3	TermRelationship	\N	0fd5031d-ddf2-4676-96ed-0d3776649596	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n402fc088-137d-4e1e-8178-876f921bdb3d|Term|CTT70: Complex Test Term 70|null\n0fd5031d-ddf2-4676-96ed-0d3776649596|TermRelationship|is-a-part-of|null	f	is-a-part-of	68f713a4-c02b-4e53-baf0-88c148dbaa03
8fe22e59-a799-4318-86d9-58b12dd2a735	3	TermRelationship	\N	d12ce272-46b3-494c-9111-2a7bc96f92a6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7db966c7-cde8-411e-898f-77753e51399e|Term|CTT52: Complex Test Term 52|null\nd12ce272-46b3-494c-9111-2a7bc96f92a6|TermRelationship|is-a-part-of|null	f	is-a-part-of	dec5bcd0-6aa3-47e2-b0ef-b0e8138a9854
9326fb45-c4d6-4c55-b698-54b12ebfcd0c	3	TermRelationship	\N	bbc9f321-cbd7-48a8-b402-3f3c9a699d7a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n79be971d-7827-430d-9e03-8089f890f00a|Term|CTT53: Complex Test Term 53|null\nbbc9f321-cbd7-48a8-b402-3f3c9a699d7a|TermRelationship|is-a-part-of|null	f	is-a-part-of	e4bbe818-41d1-4ad7-b2e6-9cd6ef29a353
9332004f-791b-435d-854e-8f073a01fa69	3	Term	\N	f440ddd8-38eb-4e59-818b-37687e279ff9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf440ddd8-38eb-4e59-818b-37687e279ff9|Term|CTT74: Complex Test Term 74|null	f	CTT74: Complex Test Term 74	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
950efdcf-2c95-4f1c-8dfd-816a44a76c63	3	Term	\N	f99727bf-c9c4-4b72-a3d8-47cc47114623	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf99727bf-c9c4-4b72-a3d8-47cc47114623|Term|CTT17: Complex Test Term 17|null	f	CTT17: Complex Test Term 17	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
95820a9b-01c4-44b4-a2b2-06145a9a81ad	3	Term	\N	653a93b2-8882-4b64-bf00-9faee1db357a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n653a93b2-8882-4b64-bf00-9faee1db357a|Term|CTT35: Complex Test Term 35|null	f	CTT35: Complex Test Term 35	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
963c0aea-3a57-4bd2-aa8b-fe28a536f320	3	Term	\N	44460eaf-ec29-41cb-9dc0-eefa6c7cc839	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n44460eaf-ec29-41cb-9dc0-eefa6c7cc839|Term|CTT26: Complex Test Term 26|null	f	CTT26: Complex Test Term 26	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
96922b3b-0aa1-439d-b926-7919245e4396	3	TermRelationship	\N	e3d6f965-e5a6-4c9f-8715-afd83bfc6fc7	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n44460eaf-ec29-41cb-9dc0-eefa6c7cc839|Term|CTT26: Complex Test Term 26|null\ne3d6f965-e5a6-4c9f-8715-afd83bfc6fc7|TermRelationship|is-a-part-of|null	f	is-a-part-of	963c0aea-3a57-4bd2-aa8b-fe28a536f320
975bf000-30e0-4a42-9336-c2e1908c9e93	3	TermRelationship	\N	ce7ae17d-b647-46cc-b9b9-28649dbdaff4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na1c2246a-4ec2-4f50-8e2f-606c8c6b6496|Term|CTT4: Complex Test Term 4|null\nce7ae17d-b647-46cc-b9b9-28649dbdaff4|TermRelationship|is-a-part-of|null	f	is-a-part-of	8abb89c6-8539-435d-b971-6be39072b0ec
977260ad-bd41-4729-b75d-49ee7b08f5b9	3	Term	\N	7e56219c-fc40-4717-85d8-c73e24fdf463	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7e56219c-fc40-4717-85d8-c73e24fdf463|Term|CTT40: Complex Test Term 40|null	f	CTT40: Complex Test Term 40	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
99189f15-8569-4fb2-aaf6-01cbd1352311	3	TermRelationship	\N	de83a5a1-be59-4712-b8a1-79147904200f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n26f74230-995c-4ae6-b010-7440115002dd|Term|CTT7: Complex Test Term 7|null\nde83a5a1-be59-4712-b8a1-79147904200f|TermRelationship|narrowerThan|null	f	narrowerThan	57d23a34-9c35-4880-9362-5c471b7389fa
99fb4f29-6d43-4ac9-a4a3-3e4bbc21fdee	3	TermRelationship	\N	0e5b8afd-8355-46e9-be4b-f94dc251ef8d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9a65239d-4685-4cb0-96f6-aaaa3fe8f024|Term|CTT36: Complex Test Term 36|null\n0e5b8afd-8355-46e9-be4b-f94dc251ef8d|TermRelationship|is-a-part-of|null	f	is-a-part-of	660c5e36-b86b-4288-a96b-3939532ce559
9b67c488-174d-40ae-9e74-9596d1d64b7c	3	TermRelationship	\N	97fa8417-c83f-4e1d-ac33-06888cad6f1d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n653a93b2-8882-4b64-bf00-9faee1db357a|Term|CTT35: Complex Test Term 35|null\n97fa8417-c83f-4e1d-ac33-06888cad6f1d|TermRelationship|is-a-part-of|null	f	is-a-part-of	95820a9b-01c4-44b4-a2b2-06145a9a81ad
9c0a16fb-3488-4f1a-a0e0-841a23622edd	3	Term	\N	28d2fb48-49ae-4398-b769-c2889b5348cd	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n28d2fb48-49ae-4398-b769-c2889b5348cd|Term|CTT94: Complex Test Term 94|null	f	CTT94: Complex Test Term 94	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
9d0041c1-c9f8-44fa-9166-91afc669602a	3	TermRelationship	\N	e130763f-fdf3-43ac-9328-0a0d018066e0	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ncfbf199a-442d-4819-91af-5ecf85abab8e|Term|CTT44: Complex Test Term 44|null\ne130763f-fdf3-43ac-9328-0a0d018066e0|TermRelationship|is-a-part-of|null	f	is-a-part-of	079190f8-81be-427f-8180-0874012af93f
9d41215f-9c11-4fe6-ae0d-f15f36ca1bb7	3	TermRelationship	\N	83b7d35e-23fa-43f8-aed1-4a0aecb15ab2	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\naa15a48d-1f0e-434c-ac2c-f8a3e36d8d37|Term|CTT76: Complex Test Term 76|null\n83b7d35e-23fa-43f8-aed1-4a0aecb15ab2|TermRelationship|is-a-part-of|null	f	is-a-part-of	4f5cbb08-f596-465a-9ffb-67a32b3ba0f2
9dc74045-06c7-4934-8847-e9e3d0d9da23	3	TermRelationship	\N	0aad28f6-f721-4de8-a504-ca258ae00d4b	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf79a800e-65c8-4267-805b-a11d97d684c0|Term|CTT28: Complex Test Term 28|null\n0aad28f6-f721-4de8-a504-ca258ae00d4b|TermRelationship|is-a-part-of|null	f	is-a-part-of	df74d894-ba76-4201-bdf7-d8588fae8550
9ecab653-7599-48f5-b38b-a474f0fe9b3a	3	Term	\N	b44284c0-7ed1-4f53-8c7f-9a9f8bd278fa	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nb44284c0-7ed1-4f53-8c7f-9a9f8bd278fa|Term|CTT55: Complex Test Term 55|null	f	CTT55: Complex Test Term 55	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
9f033007-5ec9-4293-9aa9-6fa184ec4f11	3	Term	\N	9f00cbd1-cb54-4d94-94af-9066868ec2c4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9f00cbd1-cb54-4d94-94af-9066868ec2c4|Term|CTT90: Complex Test Term 90|null	f	CTT90: Complex Test Term 90	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
a07714c7-9bcf-4ef4-963a-25d0ebe0b26c	3	Term	\N	ddce352a-5089-4617-93ea-e3f84c3e8d3b	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nddce352a-5089-4617-93ea-e3f84c3e8d3b|Term|CTT81: Complex Test Term 81|null	f	CTT81: Complex Test Term 81	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
a17bc3d8-a868-4737-b334-1ad0749ff60c	3	TermRelationship	\N	34be82e2-f6d5-4f25-91ed-c81b66d0c8e0	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7e91ccae-41d4-415e-92ee-50387659f2e5|Term|CTT14: Complex Test Term 14|null\n34be82e2-f6d5-4f25-91ed-c81b66d0c8e0|TermRelationship|is-a-part-of|null	f	is-a-part-of	e507dac2-53b3-4768-b68f-8bebcd0225f0
a1d7590d-548d-4b59-a20b-f031bffdbb09	3	TermRelationship	\N	cac46786-67fb-4ebd-9605-f5652bc6723e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n5da8046a-c396-42b1-95c7-70f97258ecaf|Term|CTT18: Complex Test Term 18|null\ncac46786-67fb-4ebd-9605-f5652bc6723e|TermRelationship|broaderThan|null	f	broaderThan	1b4423cd-a0c0-4094-b2df-7f00a3f17174
a3012cd1-72d0-4cf3-bb7f-0da5c00d0a32	3	Term	\N	e1ddcda9-a224-41c3-9e6d-6f2c805c03a3	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ne1ddcda9-a224-41c3-9e6d-6f2c805c03a3|Term|CTT13: Complex Test Term 13|null	f	CTT13: Complex Test Term 13	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
a4bc7ecc-7c40-4794-8f7d-b89b67c3ecbe	3	Term	\N	249afb7d-b556-4a98-9330-491cec9bd772	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n249afb7d-b556-4a98-9330-491cec9bd772|Term|CTT8: Complex Test Term 8|null	f	CTT8: Complex Test Term 8	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
a52861c2-4170-42a8-87a8-ba3eb4710118	3	Term	\N	1654c39e-b5f3-4fc0-abb4-2ed008c5282f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n1654c39e-b5f3-4fc0-abb4-2ed008c5282f|Term|CTT82: Complex Test Term 82|null	f	CTT82: Complex Test Term 82	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
a5ea57a9-ed71-4924-8fe3-a43c28138ac6	3	Term	\N	75015253-c01b-47a1-91b8-75296d504076	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n75015253-c01b-47a1-91b8-75296d504076|Term|CTT41: Complex Test Term 41|null	f	CTT41: Complex Test Term 41	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
acf1fd3f-3fbe-4e1a-80aa-aa803621f360	3	Term	\N	659a2fbc-3a09-4f92-a166-52121ae15001	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n659a2fbc-3a09-4f92-a166-52121ae15001|Term|CTT75: Complex Test Term 75|null	f	CTT75: Complex Test Term 75	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
ae2a21d2-f773-44d8-858e-eb86207a1904	3	Term	\N	b23215ef-213b-4d54-8f72-616c81bb0cfa	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nb23215ef-213b-4d54-8f72-616c81bb0cfa|Term|CTT87: Complex Test Term 87|null	f	CTT87: Complex Test Term 87	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
aebc0847-f052-458e-98af-65df369aa735	3	TermRelationship	\N	3b0d6642-edd8-4053-90fb-59e585b72e51	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n54576326-c11d-4436-9354-2d2b430571d8|Term|CTT9: Complex Test Term 9|null\n3b0d6642-edd8-4053-90fb-59e585b72e51|TermRelationship|is-a-part-of|null	f	is-a-part-of	8271c203-896e-499b-8adf-b9720217c84d
b0b51716-1a6d-4814-8e78-7c0a0ad6c378	3	TermRelationship	\N	339a141e-cd4a-4f9d-8842-d9148a6ab2cc	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nb44284c0-7ed1-4f53-8c7f-9a9f8bd278fa|Term|CTT55: Complex Test Term 55|null\n339a141e-cd4a-4f9d-8842-d9148a6ab2cc|TermRelationship|is-a-part-of|null	f	is-a-part-of	9ecab653-7599-48f5-b38b-a474f0fe9b3a
b221ddc1-614f-4a2c-83a0-fcd1526eccf7	3	Term	\N	4477d862-0588-4bc2-852e-67dd32e24a94	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n4477d862-0588-4bc2-852e-67dd32e24a94|Term|CTT39: Complex Test Term 39|null	f	CTT39: Complex Test Term 39	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
b2c72d2a-e56e-465d-903f-622d427729a4	3	Term	\N	f85c9c3a-d739-4995-9534-6ae7ca636f87	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf85c9c3a-d739-4995-9534-6ae7ca636f87|Term|CTT25: Complex Test Term 25|null	f	CTT25: Complex Test Term 25	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
b44e1ef6-6d80-489b-89c4-40cae511c2e3	3	TermRelationship	\N	3f2d66e5-6b2a-4948-a5be-1e7e89b156b5	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf440ddd8-38eb-4e59-818b-37687e279ff9|Term|CTT74: Complex Test Term 74|null\n3f2d66e5-6b2a-4948-a5be-1e7e89b156b5|TermRelationship|is-a-part-of|null	f	is-a-part-of	9332004f-791b-435d-854e-8f073a01fa69
b5d0e29b-1c4b-4e64-bd58-f385bc925901	3	TermRelationship	\N	1090fb8c-c18b-47e6-b6dc-fe3f71ce4ec9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nc483431b-579b-4e17-9163-8cbc4ac27516|Term|CTT68: Complex Test Term 68|null\n1090fb8c-c18b-47e6-b6dc-fe3f71ce4ec9|TermRelationship|is-a-part-of|null	f	is-a-part-of	19631df1-a17f-4ba8-a5c9-0e1d7e1ce2ad
b8f0fe55-afa4-4b02-b216-da3165d85de1	3	Term	\N	04c22cc3-9b6a-4838-9f1f-ddb87da2336f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n04c22cc3-9b6a-4838-9f1f-ddb87da2336f|Term|CTT100: Complex Test Term 100|null	f	CTT100: Complex Test Term 100	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
bbd28b39-0263-479e-9b02-265d09dd588e	3	TermRelationship	\N	59c5ae2c-2e7c-4e4d-a2f8-71d753f83700	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n887e8bc9-2104-42d2-8528-485b4623c473|Term|CTT5: Complex Test Term 5|null\n59c5ae2c-2e7c-4e4d-a2f8-71d753f83700|TermRelationship|narrowerThan|null	f	narrowerThan	83f1645a-ea8f-44d1-8fa6-53ec5fa91f57
bd3095f0-ebe6-47d1-8a1c-13474f835c9f	3	TermRelationship	\N	eb44f0c1-e31a-4fc3-8f3c-ad8fc2b53294	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nde3364c4-aacf-4a22-b30c-0eb113c33f81|Term|CTT33: Complex Test Term 33|null\neb44f0c1-e31a-4fc3-8f3c-ad8fc2b53294|TermRelationship|is-a-part-of|null	f	is-a-part-of	0fd9fd10-b428-4d8e-a0bc-05c5bf6406dc
bd880ed6-26a4-43bf-af00-3f5dad009a86	3	TermRelationship	\N	1d4948ca-4cd2-447f-94e9-cb37a69059a4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nbbf81fec-09e4-4b93-a7f3-49c6f463d9a2|Term|CTT88: Complex Test Term 88|null\n1d4948ca-4cd2-447f-94e9-cb37a69059a4|TermRelationship|is-a-part-of|null	f	is-a-part-of	78b85ffa-304b-415a-8111-15fe2d3ae911
bffc615f-2d47-432a-b292-6050a93251e6	3	TermRelationship	\N	83fa019c-d752-4e40-8252-5fc437bed781	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n00405a22-2e59-48ac-85bf-2fa5cd44cc14|Term|CTT60: Complex Test Term 60|null\n83fa019c-d752-4e40-8252-5fc437bed781|TermRelationship|is-a-part-of|null	f	is-a-part-of	802d9320-e3e7-47a9-a824-3eea8f41bcb1
c0ec3807-ad6d-4a58-a05b-950d3f22b49d	3	TermRelationship	\N	cadec1f6-e047-46c9-a854-d6f1b45d87f6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n249afb7d-b556-4a98-9330-491cec9bd772|Term|CTT8: Complex Test Term 8|null\ncadec1f6-e047-46c9-a854-d6f1b45d87f6|TermRelationship|is-a-part-of|null	f	is-a-part-of	a4bc7ecc-7c40-4794-8f7d-b89b67c3ecbe
c3d2f5e6-8d6f-4151-b4c8-ad1a81d69cf8	3	Term	\N	45aa7dba-e19e-4602-9dd7-ee4b0b7a69d3	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n45aa7dba-e19e-4602-9dd7-ee4b0b7a69d3|Term|CTT45: Complex Test Term 45|null	f	CTT45: Complex Test Term 45	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
c550a7e5-b039-4537-99dc-f4ce930ba92b	3	Term	\N	222cf3cb-bdf6-4f45-a0f0-3123adfb2773	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n222cf3cb-bdf6-4f45-a0f0-3123adfb2773|Term|CTT79: Complex Test Term 79|null	f	CTT79: Complex Test Term 79	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447
c9af3acf-4981-4fb8-b78e-966b6b787d54	3	TermRelationship	\N	10117bd9-f259-46ad-8d84-f513ecd3c97c	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n15bf739d-0a84-4bf6-9d75-89fa47b9f929|Term|CTT89: Complex Test Term 89|null\n10117bd9-f259-46ad-8d84-f513ecd3c97c|TermRelationship|is-a-part-of|null	f	is-a-part-of	7583e5ec-869f-4323-b41d-bafb299b1ce3
cb55b6e9-a2b0-4ffa-9eb4-c6831a6da6ba	3	TermRelationship	\N	58c1a39d-4df7-43ee-b093-cde71a9cebc7	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n3d93eca4-93b5-4f31-b923-74e97c60dd7e|Term|CTT21: Complex Test Term 21|null\n58c1a39d-4df7-43ee-b093-cde71a9cebc7|TermRelationship|is-a-part-of|null	f	is-a-part-of	5340bf06-4833-4f85-bcaa-bb8ce772a98f
ce3cffc9-596e-46dd-a3d1-1c25b23de70a	3	TermRelationship	\N	0f12f60b-343b-4bef-8642-f0a2577b82bf	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n30594004-573b-4652-b585-094ee77506f9|Term|CTT49: Complex Test Term 49|null\n0f12f60b-343b-4bef-8642-f0a2577b82bf|TermRelationship|is-a-part-of|null	f	is-a-part-of	69646ba0-a153-4889-92c4-73c5229ab542
d19f5800-cfeb-45bb-83a3-373751dd27a4	3	TermRelationship	\N	dadfa7e2-8eb3-40f2-ac7c-d3eae711f432	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n26f74230-995c-4ae6-b010-7440115002dd|Term|CTT7: Complex Test Term 7|null\ndadfa7e2-8eb3-40f2-ac7c-d3eae711f432|TermRelationship|is-a-part-of|null	f	is-a-part-of	57d23a34-9c35-4880-9362-5c471b7389fa
d3c34d9f-e818-43da-b196-7fbb2c219c8c	3	TermRelationship	\N	c6f2fa87-9f67-4a93-8dc9-f6c9b1169490	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n13a6ae7d-dede-41f6-9353-aa24fdf9b5a4|Term|CTT54: Complex Test Term 54|null\nc6f2fa87-9f67-4a93-8dc9-f6c9b1169490|TermRelationship|is-a-part-of|null	f	is-a-part-of	28ae9533-d81d-4555-b3a9-ddf32dc80511
e3fef071-df7f-4b78-9f4b-1159f9c77ccb	3	TermRelationship	\N	277fed1a-23a7-4dc6-9895-fdff8b25ebce	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nb49f7b23-3d75-4d7f-91c3-7cd36378ecd0|Term|CTT57: Complex Test Term 57|null\n277fed1a-23a7-4dc6-9895-fdff8b25ebce|TermRelationship|is-a-part-of|null	f	is-a-part-of	2d0685a1-c4cf-487e-8e50-4cb61f8b3dd4
e804fcd5-c54e-4783-9a28-4fb6c455bed0	3	TermRelationship	\N	aa63c8da-f813-42f7-8b17-e2fab41b8d51	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n138e033f-e261-4e6f-a33c-ba2e6c3248af|Term|CTT72: Complex Test Term 72|null\naa63c8da-f813-42f7-8b17-e2fab41b8d51|TermRelationship|is-a-part-of|null	f	is-a-part-of	f9dc8897-69c0-4bee-a43e-ade18964b04d
e959a9f6-60c9-4181-8ac1-ecd6e76405ee	3	TermRelationship	\N	4f1b7a3a-8711-4a6f-b1ab-bffb58ebd82a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n6c013905-0c1b-47a5-8ac4-9db79a5bde9e|Term|CTT91: Complex Test Term 91|null\n4f1b7a3a-8711-4a6f-b1ab-bffb58ebd82a|TermRelationship|is-a-part-of|null	f	is-a-part-of	e9779223-5333-495a-a05b-5de14bfad625
ef5223e0-5bad-40fd-8f60-0d536879a2fa	3	TermRelationship	\N	88d8ffb1-2658-4540-8d2e-bfb189e68805	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nae8fdb84-b5d9-49bb-a81c-6901f6b7d32a|Term|CTT92: Complex Test Term 92|null\n88d8ffb1-2658-4540-8d2e-bfb189e68805|TermRelationship|is-a-part-of|null	f	is-a-part-of	7418ad2c-e88e-49c1-9cee-f9dc41e1c839
ef80e4e8-f484-44e4-997a-a59ae8ff1dbe	3	TermRelationship	\N	e155da92-6cfe-42ec-99bb-28e4a40f5817	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n57ad05d4-b529-4958-9cc8-2feedbea2753|Term|CTT61: Complex Test Term 61|null\ne155da92-6cfe-42ec-99bb-28e4a40f5817|TermRelationship|is-a-part-of|null	f	is-a-part-of	7e47485f-752d-4386-ab07-cbdee4d7fdb1
f389693e-f5aa-4277-a4ad-5a3b027df4b1	3	TermRelationship	\N	428e6345-8d7c-4efe-a219-915fd88ab9f2	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nfd3777b0-521a-46f9-9cf7-4cbdd2cb6006|Term|CTT69: Complex Test Term 69|null\n428e6345-8d7c-4efe-a219-915fd88ab9f2|TermRelationship|is-a-part-of|null	f	is-a-part-of	6aa72e76-368f-463c-a522-f47ac4ff3a40
f5b1c96a-9bc8-415c-b5af-f8a5d3588f34	3	TermRelationship	\N	9255dcaa-7f4f-4924-9bab-f4c7faaaed8d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n1dd60ede-3f14-4e99-a623-a7200426e2e1|Term|CTT95: Complex Test Term 95|null\n9255dcaa-7f4f-4924-9bab-f4c7faaaed8d|TermRelationship|is-a-part-of|null	f	is-a-part-of	1fbb972d-ec0e-4aa6-bac1-2dfbee57a95d
f635ac6a-8e12-4906-aa52-cb372708932b	3	TermRelationship	\N	aa941aef-e0df-46b4-b44e-1c4d4c49e520	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n129e31ae-f381-4e2f-ae44-d6cbcb39f7df|Term|CTT77: Complex Test Term 77|null\naa941aef-e0df-46b4-b44e-1c4d4c49e520|TermRelationship|is-a-part-of|null	f	is-a-part-of	5f7c37d9-91f5-4832-a02f-f5332d9a0b0a
00438f6f-05a4-4639-a36f-f946e380fe6a	3	TermRelationship	\N	3c425b3b-cbfb-4c8e-98ee-f407455b69be	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n708f794d-56a9-4ef2-81f3-f7cd163201e9|Term|CTT12: Complex Test Term 12|null\n3c425b3b-cbfb-4c8e-98ee-f407455b69be|TermRelationship|broaderThan|null	f	broaderThan	7777d38f-adfd-4360-8896-c08877c68719
0c0d127a-5f32-4c49-82f6-ef927d5041fa	3	TermRelationship	\N	91bf82ba-4b1f-4990-86f0-3ddd19f826fd	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n5da8046a-c396-42b1-95c7-70f97258ecaf|Term|CTT18: Complex Test Term 18|null\n91bf82ba-4b1f-4990-86f0-3ddd19f826fd|TermRelationship|is-a-part-of|null	f	is-a-part-of	1b4423cd-a0c0-4094-b2df-7f00a3f17174
0c452fbd-b702-4cce-9b18-7a7bdabc3535	3	TermRelationship	\N	94c993be-a3d9-4df2-b916-806336606832	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n18034212-f5c2-4244-b5dd-fa23e76725d6|Term|CTT11: Complex Test Term 11|null\n94c993be-a3d9-4df2-b916-806336606832|TermRelationship|is-a-part-of|null	f	is-a-part-of	35cd8351-13d2-4fbb-9bcf-7dca9ef24953
1cb12b94-c2cf-4bc5-b87a-8a80787d98ab	3	TermRelationship	\N	983a8684-1336-41bd-960f-1aab36b0cee4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n2b09c524-e3db-4aa1-80e7-28038f5fc5b2|Term|CTT47: Complex Test Term 47|null\n983a8684-1336-41bd-960f-1aab36b0cee4|TermRelationship|is-a-part-of|null	f	is-a-part-of	23997534-f827-40f7-8e89-5bed92923fb5
1dbf12f7-37eb-4eed-af13-c2f75b349493	3	TermRelationship	\N	8a6d8e32-f63e-4585-af8d-7d815605b560	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nb6e043e6-aa70-41c0-8a85-bf55986adf32|Term|CTT93: Complex Test Term 93|null\n8a6d8e32-f63e-4585-af8d-7d815605b560|TermRelationship|is-a-part-of|null	f	is-a-part-of	50d1411e-bfc7-48d1-b685-25459b8609ea
20823fc1-e8cd-4d01-9602-5a19c7d46ea6	3	TermRelationship	\N	9acb623a-7718-4566-9cb3-51fdf45d2b0f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na877238c-25da-498d-b6da-5fdfdc8abb80|Term|CTT58: Complex Test Term 58|null\n9acb623a-7718-4566-9cb3-51fdf45d2b0f|TermRelationship|is-a-part-of|null	f	is-a-part-of	7c24f97b-0157-4267-8356-4c857f6bdb8e
2e0d76dd-e79d-41c5-aeca-06206d23a845	3	TermRelationship	\N	4415f41b-9dd0-43a7-b464-9be29d86e6c6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ndc8d8ddd-510b-44be-a507-d4c0fa670f40|Term|CTT16: Complex Test Term 16|null\n4415f41b-9dd0-43a7-b464-9be29d86e6c6|TermRelationship|is-a-part-of|null	f	is-a-part-of	7c24ba86-964a-4638-b70c-7a6decc56d11
302926ec-8995-4a97-9a24-46bbd24cf8fc	3	TermRelationship	\N	42799a29-d962-4ced-88d7-fa98f8fda08d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n85f636ff-72a0-4c14-9524-1c6175b2769e|Term|CTT1: Complex Test Term 1|null\n42799a29-d962-4ced-88d7-fa98f8fda08d|TermRelationship|is-a-part-of|null	f	is-a-part-of	605ec1cf-1948-4137-a8a4-7bd7e73f841a
398f7739-a11b-47c8-bf03-44284fb4cd19	3	TermRelationship	\N	8022c2e9-e32f-424e-bca6-d2e92467b5a9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nfc870e89-1cd8-4f47-85f9-eb3339cf2b48|Term|CTT62: Complex Test Term 62|null\n8022c2e9-e32f-424e-bca6-d2e92467b5a9|TermRelationship|is-a-part-of|null	f	is-a-part-of	5cedd5d3-9819-4e96-8912-e97a22b36076
3a6957c1-fbf5-48c1-87ff-1239f0381903	3	TermRelationship	\N	7d2ed1cf-6631-43c5-b3eb-348bd56365a3	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n3d731a71-d245-4e17-8baf-8793161982ee|Term|CTT83: Complex Test Term 83|null\n7d2ed1cf-6631-43c5-b3eb-348bd56365a3|TermRelationship|is-a-part-of|null	f	is-a-part-of	46d2269e-f5c0-473c-ae0e-d4eb71863719
3bc1fed9-70bc-43e0-b3ff-6a0a360fcb5a	3	TermRelationship	\N	ab88e6ed-4371-4a2c-86a4-30488061e919	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ndc8d8ddd-510b-44be-a507-d4c0fa670f40|Term|CTT16: Complex Test Term 16|null\nab88e6ed-4371-4a2c-86a4-30488061e919|TermRelationship|broaderThan|null	f	broaderThan	7c24ba86-964a-4638-b70c-7a6decc56d11
4bfc69ad-4d19-43e1-9abe-c3f48cd88351	3	TermRelationship	\N	5c2e7be4-b597-4582-a859-f524dd154616	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nccba40ce-a827-43d9-9135-57cb4de1ad68|Term|CTT31: Complex Test Term 31|null\n5c2e7be4-b597-4582-a859-f524dd154616|TermRelationship|is-a-part-of|null	f	is-a-part-of	4df175c3-0448-4daa-8fd7-e88cc57cb2ce
5a11c2a7-57b0-4149-ac0e-403da85e0497	3	TermRelationship	\N	b7beb439-6cf8-4794-a656-00b53171f729	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nedeeda06-8fee-4cfb-b551-6821f886fee6|Term|CTT6: Complex Test Term 6|null\nb7beb439-6cf8-4794-a656-00b53171f729|TermRelationship|narrowerThan|null	f	narrowerThan	5c8c3e4d-e968-4fef-99d5-9bf7faa5999c
69630f02-7e3d-4ffe-8e8c-f9f382677df6	3	TermRelationship	\N	1ad1ffea-e00c-4787-9fd7-3378791ac594	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n708f794d-56a9-4ef2-81f3-f7cd163201e9|Term|CTT12: Complex Test Term 12|null\n1ad1ffea-e00c-4787-9fd7-3378791ac594|TermRelationship|is-a-part-of|null	f	is-a-part-of	7777d38f-adfd-4360-8896-c08877c68719
87ae15bd-e599-4098-b4d2-7fcf824076be	4	TermRelationship	\N	544f4d4a-e102-48de-b65a-8e21c5f6c18e	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n75015253-c01b-47a1-91b8-75296d504076|Term|CTT41: Complex Test Term 41|null\n544f4d4a-e102-48de-b65a-8e21c5f6c18e|TermRelationship|is-a-part-of|null	f	is-a-part-of	a5ea57a9-ed71-4924-8fe3-a43c28138ac6
87b81b91-0dc2-4189-9fd5-ca91ae8579d2	4	TermRelationship	\N	9317b700-6104-4bb4-bd3c-bcd43909566b	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n4477d862-0588-4bc2-852e-67dd32e24a94|Term|CTT39: Complex Test Term 39|null\n9317b700-6104-4bb4-bd3c-bcd43909566b|TermRelationship|is-a-part-of|null	f	is-a-part-of	b221ddc1-614f-4a2c-83a0-fcd1526eccf7
970382ff-a678-4159-89dd-e5283cf6d04a	4	TermRelationship	\N	1b937fee-f8f8-4b75-81da-5b5612d1aec4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n28d2fb48-49ae-4398-b769-c2889b5348cd|Term|CTT94: Complex Test Term 94|null\n1b937fee-f8f8-4b75-81da-5b5612d1aec4|TermRelationship|is-a-part-of|null	f	is-a-part-of	9c0a16fb-3488-4f1a-a0e0-841a23622edd
9dd3a666-149c-4562-a004-ae3922f4e342	4	TermRelationship	\N	4eaaa616-c537-4d60-a8cc-555b495db9b8	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nddce352a-5089-4617-93ea-e3f84c3e8d3b|Term|CTT81: Complex Test Term 81|null\n4eaaa616-c537-4d60-a8cc-555b495db9b8|TermRelationship|is-a-part-of|null	f	is-a-part-of	a07714c7-9bcf-4ef4-963a-25d0ebe0b26c
9e428dca-ef09-4ea1-b415-5f95619cea63	4	TermRelationship	\N	b93699b9-802b-4eff-8bcb-8a28b29bfb68	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n45aa7dba-e19e-4602-9dd7-ee4b0b7a69d3|Term|CTT45: Complex Test Term 45|null\nb93699b9-802b-4eff-8bcb-8a28b29bfb68|TermRelationship|is-a-part-of|null	f	is-a-part-of	c3d2f5e6-8d6f-4151-b4c8-ad1a81d69cf8
cda702f3-a682-4581-ab0d-4a199aa96d0d	3	TermRelationship	\N	04c86515-6f72-48d2-99bb-c9e3e552b18f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n1654c39e-b5f3-4fc0-abb4-2ed008c5282f|Term|CTT82: Complex Test Term 82|null\n04c86515-6f72-48d2-99bb-c9e3e552b18f|TermRelationship|is-a-part-of|null	f	is-a-part-of	a52861c2-4170-42a8-87a8-ba3eb4710118
db7b8f3d-84ff-4db6-ab33-42e8ff05b66b	3	TermRelationship	\N	4704048c-20c7-49d5-b905-490e691f06fd	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n54576326-c11d-4436-9354-2d2b430571d8|Term|CTT9: Complex Test Term 9|null\n4704048c-20c7-49d5-b905-490e691f06fd|TermRelationship|narrowerThan|null	f	narrowerThan	8271c203-896e-499b-8adf-b9720217c84d
dbb72c27-9713-4347-88a8-82d976a518f9	3	TermRelationship	\N	5d4ed392-61a4-4ceb-9c58-6cb8a3f15478	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n73e0323a-c8da-4d14-9ba0-af6978425e72|Term|CTT86: Complex Test Term 86|null\n5d4ed392-61a4-4ceb-9c58-6cb8a3f15478|TermRelationship|is-a-part-of|null	f	is-a-part-of	8dc9d4c8-c98d-4c64-ad92-363b4c0b2404
e1f42237-fba5-4248-907f-42214adce966	3	TermRelationship	\N	3de95454-8fac-4180-9a2d-79ab413ad95d	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9f00cbd1-cb54-4d94-94af-9066868ec2c4|Term|CTT90: Complex Test Term 90|null\n3de95454-8fac-4180-9a2d-79ab413ad95d|TermRelationship|is-a-part-of|null	f	is-a-part-of	9f033007-5ec9-4293-9aa9-6fa184ec4f11
e506cd3e-5558-4a21-b042-cb15fc7a0b30	3	TermRelationship	\N	f7df059e-30bd-409a-9e4e-29ebf2cf27cd	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf99727bf-c9c4-4b72-a3d8-47cc47114623|Term|CTT17: Complex Test Term 17|null\nf7df059e-30bd-409a-9e4e-29ebf2cf27cd|TermRelationship|is-a-part-of|null	f	is-a-part-of	950efdcf-2c95-4f1c-8dfd-816a44a76c63
ed8726c2-2580-4915-b036-31606947d6b1	3	TermRelationship	\N	3db528e6-69b0-4b71-8312-57e2f8b2f107	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n249afb7d-b556-4a98-9330-491cec9bd772|Term|CTT8: Complex Test Term 8|null\n3db528e6-69b0-4b71-8312-57e2f8b2f107|TermRelationship|narrowerThan|null	f	narrowerThan	a4bc7ecc-7c40-4794-8f7d-b89b67c3ecbe
f1cd8029-5e74-4c6b-a06e-7133933a1b1b	3	TermRelationship	\N	13612d7b-b315-4a16-ba99-1bc473c39111	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n659a2fbc-3a09-4f92-a166-52121ae15001|Term|CTT75: Complex Test Term 75|null\n13612d7b-b315-4a16-ba99-1bc473c39111|TermRelationship|is-a-part-of|null	f	is-a-part-of	acf1fd3f-3fbe-4e1a-80aa-aa803621f360
fe79753f-8b17-4524-89db-f15d2a0cbcab	3	TermRelationship	\N	9bb861d6-8411-4e31-a87b-625b73f75bc9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf0bef74c-309d-448f-83ed-5d6a7287434e|Term|CTT43: Complex Test Term 43|null\n9bb861d6-8411-4e31-a87b-625b73f75bc9|TermRelationship|is-a-part-of|null	f	is-a-part-of	865f6bfc-66d9-46e5-9c9e-03f6c0ccd836
ff565e6e-c6bf-48e3-bcda-6b5a7a199cdf	3	TermRelationship	\N	54375d7c-513c-4d3f-9d8a-d032c8649be1	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf99727bf-c9c4-4b72-a3d8-47cc47114623|Term|CTT17: Complex Test Term 17|null\n54375d7c-513c-4d3f-9d8a-d032c8649be1|TermRelationship|broaderThan|null	f	broaderThan	950efdcf-2c95-4f1c-8dfd-816a44a76c63
01242bf7-012d-40c3-b557-5b5e3e614c5c	3	TermRelationship	\N	d8f8ecb8-3d5f-4acd-8261-c5f3e44281f6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ne1ddcda9-a224-41c3-9e6d-6f2c805c03a3|Term|CTT13: Complex Test Term 13|null\nd8f8ecb8-3d5f-4acd-8261-c5f3e44281f6|TermRelationship|is-a-part-of|null	f	is-a-part-of	a3012cd1-72d0-4cf3-bb7f-0da5c00d0a32
02542414-9d95-4693-9633-5433f95ddb5b	3	TermRelationship	\N	aeb68b64-ea34-4fac-a92a-c251719f8ea4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nf85c9c3a-d739-4995-9534-6ae7ca636f87|Term|CTT25: Complex Test Term 25|null\naeb68b64-ea34-4fac-a92a-c251719f8ea4|TermRelationship|is-a-part-of|null	f	is-a-part-of	b2c72d2a-e56e-465d-903f-622d427729a4
0bea60ee-47c3-47d8-ad16-b982ed0514ab	3	TermRelationship	\N	e532061d-7f43-465b-a642-8a4149ec0315	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n887e8bc9-2104-42d2-8528-485b4623c473|Term|CTT5: Complex Test Term 5|null\ne532061d-7f43-465b-a642-8a4149ec0315|TermRelationship|is-a-part-of|null	f	is-a-part-of	83f1645a-ea8f-44d1-8fa6-53ec5fa91f57
271bb492-2c96-4889-aa4a-2cbbe3507b66	3	TermRelationship	\N	fc2f49e6-c35b-447f-9c67-cd0f6b66b38c	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\na1c2246a-4ec2-4f50-8e2f-606c8c6b6496|Term|CTT4: Complex Test Term 4|null\nfc2f49e6-c35b-447f-9c67-cd0f6b66b38c|TermRelationship|narrowerThan|null	f	narrowerThan	8abb89c6-8539-435d-b971-6be39072b0ec
44ac90a6-7d5d-484d-b72d-19dd245a4647	3	TermRelationship	\N	aec3803f-7bd1-4522-878b-dd919e5fb9bb	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\ne1ddcda9-a224-41c3-9e6d-6f2c805c03a3|Term|CTT13: Complex Test Term 13|null\naec3803f-7bd1-4522-878b-dd919e5fb9bb|TermRelationship|broaderThan|null	f	broaderThan	a3012cd1-72d0-4cf3-bb7f-0da5c00d0a32
4625a444-b2d9-47ee-b622-2045d4efec95	3	TermRelationship	\N	a2cd5b66-6257-4efa-af37-aeb619492d8b	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n9ea09e24-705c-4920-9dba-8ccf39fac00c|Term|CTT51: Complex Test Term 51|null\na2cd5b66-6257-4efa-af37-aeb619492d8b|TermRelationship|is-a-part-of|null	f	is-a-part-of	87ee52f4-091c-46ad-8869-ed1c0ae5545c
46d1aa86-ff9c-431c-a168-2e3760addb26	3	TermRelationship	\N	0f5ef777-3f57-4f08-a95c-ea984933c96a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n222cf3cb-bdf6-4f45-a0f0-3123adfb2773|Term|CTT79: Complex Test Term 79|null\n0f5ef777-3f57-4f08-a95c-ea984933c96a|TermRelationship|is-a-part-of|null	f	is-a-part-of	c550a7e5-b039-4537-99dc-f4ce930ba92b
6e243a90-6441-416a-a7a5-35f1e19ff5b9	3	TermRelationship	\N	0fcab2c2-a270-45bc-9a61-fe703bd8065a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n132e194c-377c-48ea-aa60-753b156d4ba6|Term|CTT59: Complex Test Term 59|null\n0fcab2c2-a270-45bc-9a61-fe703bd8065a|TermRelationship|is-a-part-of|null	f	is-a-part-of	84b79828-91c1-4249-82e9-70d9a86bdda2
70002f26-08a3-4ecf-8ebf-dd1b8668e834	3	TermRelationship	\N	1f5eb2db-fdea-40dd-94a9-205cfd692daf	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n7e56219c-fc40-4717-85d8-c73e24fdf463|Term|CTT40: Complex Test Term 40|null\n1f5eb2db-fdea-40dd-94a9-205cfd692daf|TermRelationship|is-a-part-of|null	f	is-a-part-of	977260ad-bd41-4729-b75d-49ee7b08f5b9
78a1c45b-a4f2-43e7-9864-68738147c5ae	3	TermRelationship	\N	efb0b935-53f3-4054-b287-d564f5ac2a4a	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nb23215ef-213b-4d54-8f72-616c81bb0cfa|Term|CTT87: Complex Test Term 87|null\nefb0b935-53f3-4054-b287-d564f5ac2a4a|TermRelationship|is-a-part-of|null	f	is-a-part-of	ae2a21d2-f773-44d8-858e-eb86207a1904
793af870-4a2b-4bdd-a1f2-888ceba22eb3	3	TermRelationship	\N	ff0bf30f-3830-4494-8c83-43574a8d6aad	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\nfe87dd5a-7817-4f0f-832f-318ba238846e|Term|CTT34: Complex Test Term 34|null\nff0bf30f-3830-4494-8c83-43574a8d6aad|TermRelationship|is-a-part-of|null	f	is-a-part-of	8fa27aa6-98a5-4bba-8aed-d362e9a8ae54
7f0aa7ed-d965-403a-ba1a-530c33ca96c8	3	TermRelationship	\N	02cb1f81-e098-4cea-9356-6c59aa777fc9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f|Terminology|Complex Test Terminology|false\n04c22cc3-9b6a-4838-9f1f-ddb87da2336f|Term|CTT100: Complex Test Term 100|null\n02cb1f81-e098-4cea-9356-6c59aa777fc9|TermRelationship|is-a|null	f	is-a	b8f0fe55-afa4-4b02-b216-da3165d85de1
559f61bf-6e38-4eda-9210-15137bdf72e5	1	Terminology	f	dc582af4-674a-4569-a59b-2defccfb876f	dc582af4-674a-4569-a59b-2defccfb876f|Terminology|Simple Test Terminology|false	t	Simple Test Terminology	\N
ab6cea42-1128-4074-821a-c33ca071a5c1	1	Term	\N	6200b0e0-5c9a-4951-ae06-cfbc34476ba9	dc582af4-674a-4569-a59b-2defccfb876f|Terminology|Simple Test Terminology|false\n6200b0e0-5c9a-4951-ae06-cfbc34476ba9|Term|STT01: Simple Test Term 01|null	f	STT01: Simple Test Term 01	559f61bf-6e38-4eda-9210-15137bdf72e5
e42cee7a-480f-4edc-bcbf-4afe56a556eb	1	Term	\N	0346e1c7-7d1c-4c83-838c-36518da14dd4	dc582af4-674a-4569-a59b-2defccfb876f|Terminology|Simple Test Terminology|false\n0346e1c7-7d1c-4c83-838c-36518da14dd4|Term|STT02: Simple Test Term 02|null	f	STT02: Simple Test Term 02	559f61bf-6e38-4eda-9210-15137bdf72e5
\.


--
-- Data for Name: classifier; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.classifier (id, version, date_created, last_updated, path, depth, parent_classifier_id, readable_by_authenticated_users, created_by, readable_by_everyone, label, description) FROM stdin;
bbc5ae78-7c94-4502-9ee7-236d60d5cb2b	0	2021-05-20 15:35:20.968928	2021-05-20 15:35:20.968928		0	\N	f	development@test.com	f	Development Classifier	\N
bdce918d-d092-487c-8b03-87cf2b6fdf90	0	2021-05-20 15:35:21.15838	2021-05-20 15:35:21.15838		0	\N	t	development@test.com	f	test classifier	\N
76cf5a69-ba52-45e4-b2ea-8decfc467490	0	2021-05-20 15:35:21.178631	2021-05-20 15:35:21.178631		0	\N	t	development@test.com	f	test classifier2	\N
df6316af-5e81-4ab0-a325-5d11e9dcd11c	0	2021-05-20 15:35:21.683196	2021-05-20 15:35:21.683196		0	\N	t	development@test.com	f	test classifier simple	\N
\.


--
-- Data for Name: edit; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.edit (id, version, date_created, last_updated, resource_domain_type, resource_id, created_by, description, title) FROM stdin;
\.


--
-- Data for Name: email; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.email (id, version, sent_to_email_address, successfully_sent, body, date_time_sent, email_service_used, failure_reason, subject) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.0.0	core	SQL	V1_0_0__core.sql	30735148	maurodatamapper	2021-05-20 15:35:16.763008	219	t
2	1.5.0	authority	SQL	V1_5_0__authority.sql	1820762963	maurodatamapper	2021-05-20 15:35:16.990824	7	t
3	1.7.0	semantic link add unconfirmed	SQL	V1_7_0__semantic_link_add_unconfirmed.sql	490568862	maurodatamapper	2021-05-20 15:35:17.002903	3	t
4	1.13.0	add versioned folder	SQL	V1_13_0__add_versioned_folder.sql	1714761766	maurodatamapper	2021-05-20 15:35:17.010004	3	t
5	1.15.0	add rule	SQL	V1_15_0__add_rule.sql	1865268520	maurodatamapper	2021-05-20 15:35:17.016477	6	t
6	1.15.5	add rulerepresentation	SQL	V1_15_5__add_rulerepresentation.sql	-2123765594	maurodatamapper	2021-05-20 15:35:17.026627	5	t
0	\N	<< Flyway Schema Creation >>	SCHEMA	"core"	\N	maurodatamapper	2021-05-20 15:35:16.708547	0	t
7	2.0.0	fix flyway	SQL	V2_0_0__fix_flyway.sql	-995285273	maurodatamapper	2021-05-20 15:35:17.036054	92	t
8	2.1.0	add delete cascade to some foreign keys	SQL	V2_1_0__add_delete_cascade_to_some_foreign_keys.sql	1123726048	maurodatamapper	2021-05-20 15:35:17.133307	7	t
9	2.2.0	update edit description to text type	SQL	V2_2_0__update_edit_description_to_text_type.sql	758628834	maurodatamapper	2021-05-20 15:35:17.143981	1	t
10	2.3.0	model import	SQL	V2_3_0__model_import.sql	969010724	maurodatamapper	2021-05-20 15:35:17.148751	8	t
11	2.3.1	model extend	SQL	V2_3_1__model_extend.sql	423308479	maurodatamapper	2021-05-20 15:35:17.160198	6	t
12	2.4.0	update api properties	SQL	V2_4_0__update_api_properties.sql	185217942	maurodatamapper	2021-05-20 15:35:17.169746	3	t
13	2.5.0	add model version tag to versioned folder	SQL	V2_5_0__add_model_version_tag_to_versioned_folder.sql	-1320780895	maurodatamapper	2021-05-20 15:35:17.175334	1	t
14	2.6.0	add indexing to metadata	SQL	V2_6_0__add_indexing_to_metadata.sql	703739930	maurodatamapper	2021-05-20 15:35:17.179015	3	t
15	2.7.0	add and migrate edit title	SQL	V2_7_0__add_and_migrate_edit_title.sql	-665000924	maurodatamapper	2021-05-20 15:35:17.185387	3	t
16	2.8.0	rename catalogue item to multi facet	SQL	V2_8_0__rename_catalogue_item_to_multi_facet.sql	-491830151	maurodatamapper	2021-05-20 15:35:17.191621	3	t
17	2.8.1	containers add facets	SQL	V2_8_1__containers_add_facets.sql	824749235	maurodatamapper	2021-05-20 15:35:17.198454	19	t
18	2.8.2	remove model import export	SQL	V2_8_2__remove_model_import_export.sql	-1422014840	maurodatamapper	2021-05-20 15:35:17.22136	2	t
19	2.9.0	add version links to versioned folder	SQL	V2_9_0__add_version_links_to_versioned_folder.sql	-1431906977	maurodatamapper	2021-05-20 15:35:17.226268	4	t
\.


--
-- Data for Name: folder; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.folder (id, version, date_created, last_updated, path, deleted, depth, readable_by_authenticated_users, parent_folder_id, created_by, readable_by_everyone, label, description, class, branch_name, finalised, date_finalised, documentation_version, model_version, authority_id, model_version_tag) FROM stdin;
31a0deb7-7d38-45f6-a48e-5cfef3d40026	0	2021-05-20 15:35:20.709195	2021-05-20 15:35:20.709195		f	0	f	\N	development@test.com	f	Development Folder	\N	uk.ac.ox.softeng.maurodatamapper.core.container.Folder	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: join_classifier_to_facet; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.join_classifier_to_facet (classifier_id, annotation_id, rule_id, semantic_link_id, reference_file_id, metadata_id) FROM stdin;
\.


--
-- Data for Name: join_folder_to_facet; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.join_folder_to_facet (folder_id, annotation_id, rule_id, semantic_link_id, reference_file_id, metadata_id) FROM stdin;
\.


--
-- Data for Name: join_versionedfolder_to_facet; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.join_versionedfolder_to_facet (versionedfolder_id, version_link_id) FROM stdin;
\.


--
-- Data for Name: metadata; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.metadata (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, namespace, multi_facet_aware_item_id, value, created_by, key) FROM stdin;
f026474f-e85d-4637-9302-b034e002b25c	0	2021-05-20 15:35:21.334674	2021-05-20 15:35:21.334674	DataModel	test.com	ed800789-3cd4-4058-884b-758ccf654132	mdv1	development@test.com	mdk1
2f8f8ef2-d4d2-466e-97b4-c8b09dbc218e	0	2021-05-20 15:35:21.337312	2021-05-20 15:35:21.337312	DataModel	test.com	ed800789-3cd4-4058-884b-758ccf654132	mdv2	development@test.com	mdk2
cc443b93-4c10-40d3-b637-fb4ea950263e	0	2021-05-20 15:35:21.337867	2021-05-20 15:35:21.337867	DataModel	test.com/test	ed800789-3cd4-4058-884b-758ccf654132	mdv2	development@test.com	mdk1
6d91e4a5-f014-4525-b255-3489518af222	0	2021-05-20 15:35:21.712186	2021-05-20 15:35:21.712186	DataModel	test.com/simple	9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	mdv1	development@test.com	mdk1
36a7c444-78fc-45c1-b878-8495fd28686c	0	2021-05-20 15:35:21.713088	2021-05-20 15:35:21.713088	DataModel	test.com	9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	mdv2	development@test.com	mdk2
f1c656b2-6ac9-471d-b6a6-05e24287fd92	0	2021-05-20 15:35:21.713536	2021-05-20 15:35:21.713536	DataModel	test.com/simple	9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	mdv2	development@test.com	mdk2
af351046-876b-42ef-9fc8-fe7569022073	0	2021-05-20 15:35:21.728774	2021-05-20 15:35:21.728774	DataClass	test.com/simple	467f8282-42dc-4cc7-bd3d-6bab24297bb2	mdv1	development@test.com	mdk1
688980ce-8e6d-4736-9b44-f2ae900c4c4a	0	2021-05-20 15:35:23.856682	2021-05-20 15:35:23.856682	Terminology	terminology.test.com/simple	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	mdv1	development@test.com	mdk1
e3419eb0-5ea6-4476-8e66-92cd7fc764f8	0	2021-05-20 15:35:23.860435	2021-05-20 15:35:23.860435	Terminology	terminology.test.com	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	mdv2	development@test.com	mdk2
0f7175b7-f5b3-4f38-a9f1-ecad7735b5cc	0	2021-05-20 15:35:23.860797	2021-05-20 15:35:23.860797	Terminology	terminology.test.com/simple	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	mdv2	development@test.com	mdk2
aab6d28d-1aa0-432f-bd8b-cce32e9f78c1	0	2021-05-20 15:35:25.100595	2021-05-20 15:35:25.100595	Terminology	terminology.test.com/simple	dc582af4-674a-4569-a59b-2defccfb876f	mdv1	development@test.com	mdk1
a95c3db5-a351-46f2-ac12-ea920bdfd1cf	0	2021-05-20 15:35:25.101387	2021-05-20 15:35:25.101387	Terminology	terminology.test.com	dc582af4-674a-4569-a59b-2defccfb876f	mdv2	development@test.com	mdk2
caaa2be7-0bc2-4c6d-be47-283e693c7b92	0	2021-05-20 15:35:25.101654	2021-05-20 15:35:25.101654	Terminology	terminology.test.com/simple	dc582af4-674a-4569-a59b-2defccfb876f	mdv2	development@test.com	mdk2
93f8369f-109b-4c17-81a3-14ccab581d4c	0	2021-05-20 15:35:25.415858	2021-05-20 15:35:25.415858	ReferenceDataModel	referencedata.com	92e6abca-5ae4-4d01-b9db-fd577aaac4be	mdv1	development@test.com	mdk1
043d8575-d031-46a2-8531-446cda872c50	0	2021-05-20 15:35:25.420083	2021-05-20 15:35:25.420083	ReferenceDataModel	referencedata.com	92e6abca-5ae4-4d01-b9db-fd577aaac4be	mdv2	development@test.com	mdk2
102c23a4-63e4-4b9d-998f-6d9fa7da5348	0	2021-05-20 15:35:25.420377	2021-05-20 15:35:25.420377	ReferenceDataModel	referencedata.com	92e6abca-5ae4-4d01-b9db-fd577aaac4be	mdv3	development@test.com	mdk3
\.


--
-- Data for Name: reference_file; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.reference_file (id, version, file_size, date_created, last_updated, multi_facet_aware_item_domain_type, file_type, file_name, file_contents, multi_facet_aware_item_id, created_by) FROM stdin;
\.


--
-- Data for Name: rule; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.rule (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, name, created_by, description) FROM stdin;
c0d9cbd6-a70d-4495-b117-62196a3e1dd3	0	2021-05-20 15:35:21.396251	2021-05-20 15:35:21.396251	DataModel	ed800789-3cd4-4058-884b-758ccf654132	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
05c7b7d8-4f28-4eb7-9dc0-c1e2cd18e9ea	0	2021-05-20 15:35:21.396982	2021-05-20 15:35:21.396982	DataClass	04659fc9-4340-4e13-bf78-690de6bce191	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
7f60e151-9979-4b85-ab1d-661d87916c04	0	2021-05-20 15:35:21.397413	2021-05-20 15:35:21.397413	PrimitiveType	baa81da3-bbb4-415c-86d1-5dcac118d36a	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
eb9901d0-d03c-4cb4-b95d-ba1d4638a7e1	0	2021-05-20 15:35:21.56513	2021-05-20 15:35:21.56513	DataElement	2d998eee-1c4e-42a5-9fa7-4cd517711a1e	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
4ed7a924-2845-4762-a820-d8a89fbd3cbc	0	2021-05-20 15:35:23.090668	2021-05-20 15:35:23.090668	Terminology	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
e9519af7-7119-4a42-ac57-b9d1d4539d29	0	2021-05-20 15:35:24.748298	2021-05-20 15:35:24.748298	TermRelationshipType	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
fa557fa1-ecfe-4c1a-8a17-ec459cde85db	0	2021-05-20 15:35:24.748786	2021-05-20 15:35:24.748786	TermRelationship	42799a29-d962-4ced-88d7-fa98f8fda08d	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
5d7acecb-242c-441e-a45d-853e7acc185c	0	2021-05-20 15:35:24.749055	2021-05-20 15:35:24.749055	Term	85f636ff-72a0-4c14-9524-1c6175b2769e	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
0f5cdd4a-3360-4461-8fa9-a6ea47709ea3	0	2021-05-20 15:35:25.227545	2021-05-20 15:35:25.227545	CodeSet	be9b7c0b-5c7f-44b8-aeae-9841f5404946	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
a7df967d-40d9-47d7-95f2-e6870e5b945e	0	2021-05-20 15:35:25.688899	2021-05-20 15:35:25.688899	ReferenceDataModel	92e6abca-5ae4-4d01-b9db-fd577aaac4be	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
3e9cf08c-cedc-4d6e-8fff-67eedd256dde	0	2021-05-20 15:35:25.689434	2021-05-20 15:35:25.689434	ReferencePrimitiveType	66858e4c-0a6e-47ff-995b-ff7fe5aae537	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
3e029747-63d6-46df-8060-7b21071e5498	0	2021-05-20 15:35:25.689743	2021-05-20 15:35:25.689743	ReferenceDataElement	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
\.


--
-- Data for Name: rule_representation; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.rule_representation (id, version, date_created, last_updated, rule_id, language, representation, created_by) FROM stdin;
\.


--
-- Data for Name: semantic_link; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.semantic_link (id, version, date_created, target_multi_facet_aware_item_id, last_updated, multi_facet_aware_item_domain_type, target_multi_facet_aware_item_domain_type, link_type, multi_facet_aware_item_id, created_by, unconfirmed) FROM stdin;
9ed20429-f5fc-44e6-867b-edd2ffada989	0	2021-05-20 15:35:21.630532	04659fc9-4340-4e13-bf78-690de6bce191	2021-05-20 15:35:21.630532	DataClass	DataClass	DOES_NOT_REFINE	3594cda2-4824-4697-93c9-93d4df8586c6	development@test.com	f
\.


--
-- Data for Name: user_image_file; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.user_image_file (id, version, file_size, date_created, last_updated, file_type, file_name, user_id, file_contents, created_by) FROM stdin;
\.


--
-- Data for Name: version_link; Type: TABLE DATA; Schema: core; Owner: maurodatamapper
--

COPY core.version_link (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, target_model_domain_type, link_type, target_model_id, multi_facet_aware_item_id, created_by) FROM stdin;
\.


--
-- Data for Name: data_class_component; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.data_class_component (id, version, date_created, data_flow_id, definition, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
e260e937-5c25-4b16-aeef-adc511d92476	0	2021-05-20 15:35:22.419549	7d67c734-2064-4834-92ba-fca961cb9b18	SELECT * \nINTO TargetFlowDataModel.tableD \nFROM SourceFlowDataModel.tableA	2021-05-20 15:35:22.419549	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18	2	96e4cabf-6971-43ad-ad96-cd39db9d3f08	2147483647	development@test.com	\N	aToD	\N
002dc358-4c90-4b4f-a81b-6a6f4fe33707	0	2021-05-20 15:35:22.421766	7d67c734-2064-4834-92ba-fca961cb9b18	INSERT INTO TargetFlowDataModel.tableE\nSELECT  \n    b.columnE1                                      AS columnE,\n    b.columnF                                       AS columnR,\n    CONCAT(b.columnG,'_',c.columnJ)                 AS columnS,\n    CASE\n        WHEN b.columnH IS NULL THEN b.columnI\n        ELSE b.columnH\n    END                                             AS columnT,\n    TRIM(c.columnJ)                                 AS columnU,\n    CONCAT(c.columnL,' ',c.columnM,'--',b.columnG)  AS columnV\nFROM SourceFlowDataModel.tableB b\nINNER JOIN SourceFlowDataModel.tableC c ON b.columnE1 = c.columnE2	2021-05-20 15:35:22.421766	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18	2	0dd9110b-76cb-4a50-b36d-54063151adb1	2147483647	development@test.com	\N	bAndCToE	\N
\.


--
-- Data for Name: data_element_component; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.data_element_component (id, version, date_created, data_class_component_id, definition, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
ccf0c187-a759-4527-8d9e-79e5a3c8a766	0	2021-05-20 15:35:22.422913	e260e937-5c25-4b16-aeef-adc511d92476	\N	2021-05-20 15:35:22.422913	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/e260e937-5c25-4b16-aeef-adc511d92476	3	a0037a36-2d2f-4379-8b4b-7545e59f5992	2147483647	development@test.com	\N	Direct Copy	\N
83bbf788-8fa3-4f36-add1-3db5d603a91c	0	2021-05-20 15:35:22.427465	e260e937-5c25-4b16-aeef-adc511d92476	\N	2021-05-20 15:35:22.427465	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/e260e937-5c25-4b16-aeef-adc511d92476	3	68d97f3b-77b0-4a20-9a8b-ba85a347a7ab	2147483647	development@test.com	\N	Direct Copy	\N
bad7eb32-06af-42f3-9a35-d14cb9307522	0	2021-05-20 15:35:22.42814	e260e937-5c25-4b16-aeef-adc511d92476	\N	2021-05-20 15:35:22.42814	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/e260e937-5c25-4b16-aeef-adc511d92476	3	510826e7-5fc8-4ded-aba1-433f472b85b1	2147483647	development@test.com	\N	Direct Copy	\N
158a7282-6924-4f0f-bcb8-99b69d81b8d6	0	2021-05-20 15:35:22.428627	e260e937-5c25-4b16-aeef-adc511d92476	\N	2021-05-20 15:35:22.428627	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/e260e937-5c25-4b16-aeef-adc511d92476	3	f1f38141-57e2-4062-8dab-ab848c2590c7	2147483647	development@test.com	\N	Direct Copy	\N
cb283885-b3e5-4942-82e4-a480dd002b93	0	2021-05-20 15:35:22.429093	002dc358-4c90-4b4f-a81b-6a6f4fe33707	\N	2021-05-20 15:35:22.429093	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/002dc358-4c90-4b4f-a81b-6a6f4fe33707	3	b9374444-432a-47ed-a799-9c4dd1b965e4	2147483647	development@test.com	\N	JOIN KEY	\N
054e63a6-33f9-4ee6-9e65-958f038b8ecd	0	2021-05-20 15:35:22.429578	002dc358-4c90-4b4f-a81b-6a6f4fe33707	\N	2021-05-20 15:35:22.429578	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/002dc358-4c90-4b4f-a81b-6a6f4fe33707	3	f52a54cb-1127-4649-a76a-9d21c9e4fd2f	2147483647	development@test.com	\N	Direct Copy	\N
67de5e94-5e79-4eb2-b7b3-9e82e92c7497	0	2021-05-20 15:35:22.430357	002dc358-4c90-4b4f-a81b-6a6f4fe33707	CONCAT(b.columnG,'_',c.columnJ)	2021-05-20 15:35:22.430357	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/002dc358-4c90-4b4f-a81b-6a6f4fe33707	3	a88425d3-4f36-4459-9dec-25107957a317	2147483647	development@test.com	\N	CONCAT	\N
0f177626-1566-454b-8d20-a42aed771b58	0	2021-05-20 15:35:22.430871	002dc358-4c90-4b4f-a81b-6a6f4fe33707	CASE\n    WHEN b.columnH IS NULL THEN b.columnI\n    ELSE b.columnH\nEND	2021-05-20 15:35:22.430871	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/002dc358-4c90-4b4f-a81b-6a6f4fe33707	3	03182574-a012-4e40-8576-ff7be49e5404	2147483647	development@test.com	\N	CASE	\N
7953762c-70a1-4a5e-a042-0bd8133e1e0c	0	2021-05-20 15:35:22.431357	002dc358-4c90-4b4f-a81b-6a6f4fe33707	\N	2021-05-20 15:35:22.431357	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/002dc358-4c90-4b4f-a81b-6a6f4fe33707	3	56c2a3e0-af1d-4bca-8141-92200eb2513a	2147483647	development@test.com	\N	TRIM	\N
96ce9787-4981-4a03-8cb0-1497d609fd75	0	2021-05-20 15:35:22.431836	002dc358-4c90-4b4f-a81b-6a6f4fe33707	CONCAT(c.columnL,' ',c.columnM,'--',b.columnG)	2021-05-20 15:35:22.431836	/4cb3611e-12dc-4b86-a996-da79283818fe/7d67c734-2064-4834-92ba-fca961cb9b18/002dc358-4c90-4b4f-a81b-6a6f4fe33707	3	e865c436-0dc7-418e-9c71-636edce47cad	2147483647	development@test.com	\N	CONCAT	\N
\.


--
-- Data for Name: data_flow; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.data_flow (id, version, date_created, definition, diagram_layout, last_updated, path, depth, source_id, breadcrumb_tree_id, target_id, idx, created_by, aliases_string, label, description) FROM stdin;
7d67c734-2064-4834-92ba-fca961cb9b18	1	2021-05-20 15:35:22.287205	\N	\N	2021-05-20 15:35:22.470268	/4cb3611e-12dc-4b86-a996-da79283818fe	1	1c412f8c-0369-41db-8472-9c5e89469b5f	947b879c-c0ab-4a69-aa1a-e80dc2ef21f9	4cb3611e-12dc-4b86-a996-da79283818fe	2147483647	development@test.com	\N	Sample DataFlow	\N
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.4.0	dataflow	SQL	V1_4_0__dataflow.sql	1607778436	maurodatamapper	2021-05-20 15:35:18.077565	103	t
2	1.15.4	add rule to dataflow	SQL	V1_15_4__add_rule_to_dataflow.sql	-73896718	maurodatamapper	2021-05-20 15:35:18.186018	5	t
\.


--
-- Data for Name: join_data_class_component_to_source_data_class; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.join_data_class_component_to_source_data_class (data_class_component_id, data_class_id) FROM stdin;
e260e937-5c25-4b16-aeef-adc511d92476	9477ed2f-99fe-4130-b172-08fc2c98642c
002dc358-4c90-4b4f-a81b-6a6f4fe33707	1fc79fcf-b149-438c-9884-c3157eda7f0b
002dc358-4c90-4b4f-a81b-6a6f4fe33707	b6d0d671-d676-4f03-bf1a-5a502576d75e
\.


--
-- Data for Name: join_data_class_component_to_target_data_class; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.join_data_class_component_to_target_data_class (data_class_component_id, data_class_id) FROM stdin;
e260e937-5c25-4b16-aeef-adc511d92476	d66b9510-73e8-4c9e-b7db-2822c8974312
002dc358-4c90-4b4f-a81b-6a6f4fe33707	a2cd824d-3691-43ff-b50f-a8a846cc5358
\.


--
-- Data for Name: join_data_element_component_to_source_data_element; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.join_data_element_component_to_source_data_element (data_element_component_id, data_element_id) FROM stdin;
83bbf788-8fa3-4f36-add1-3db5d603a91c	21e6e5af-6e3f-47cf-8e24-5f2ddef0ba99
96ce9787-4981-4a03-8cb0-1497d609fd75	f5300062-822c-4db7-8d87-9e7635ba5679
96ce9787-4981-4a03-8cb0-1497d609fd75	d09db654-bb94-4744-af40-fab7eaa1ce14
96ce9787-4981-4a03-8cb0-1497d609fd75	021c2905-dd41-4c20-93e0-40b3779f7480
bad7eb32-06af-42f3-9a35-d14cb9307522	61a1470d-43af-467e-86bf-6431bda53f5c
cb283885-b3e5-4942-82e4-a480dd002b93	8570bc51-b105-4735-b9a8-f54a7c9507c9
cb283885-b3e5-4942-82e4-a480dd002b93	bc6362c1-f63c-4cd2-b867-d561667622a4
ccf0c187-a759-4527-8d9e-79e5a3c8a766	96d0c214-bd98-41fa-bdf0-6ce22a33c45d
054e63a6-33f9-4ee6-9e65-958f038b8ecd	45032660-ca45-4da0-a61c-6e754f236132
0f177626-1566-454b-8d20-a42aed771b58	b7bfa6c1-b62b-41ff-916a-fec5fabc2482
0f177626-1566-454b-8d20-a42aed771b58	f9f4d4f5-359d-4d99-82f1-fa2585976bf0
158a7282-6924-4f0f-bcb8-99b69d81b8d6	ef19d301-be66-4d3e-970e-32ea9537de7c
67de5e94-5e79-4eb2-b7b3-9e82e92c7497	021c2905-dd41-4c20-93e0-40b3779f7480
67de5e94-5e79-4eb2-b7b3-9e82e92c7497	ee110977-ce2a-4436-855f-d27dfcba8dfd
7953762c-70a1-4a5e-a042-0bd8133e1e0c	ee110977-ce2a-4436-855f-d27dfcba8dfd
\.


--
-- Data for Name: join_data_element_component_to_target_data_element; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.join_data_element_component_to_target_data_element (data_element_component_id, data_element_id) FROM stdin;
83bbf788-8fa3-4f36-add1-3db5d603a91c	64c5dcda-4422-463d-927f-73a8c439e477
96ce9787-4981-4a03-8cb0-1497d609fd75	d0430c92-f9d4-4c12-aa1f-840cb041737c
bad7eb32-06af-42f3-9a35-d14cb9307522	627b2a27-c625-4ec4-a9d8-d5c17367ea61
cb283885-b3e5-4942-82e4-a480dd002b93	99add985-9041-406d-abc9-3f0b0e5c26ee
ccf0c187-a759-4527-8d9e-79e5a3c8a766	20d6bbea-7c62-46bc-a9a8-779c035ad012
054e63a6-33f9-4ee6-9e65-958f038b8ecd	c3dfb686-2c0f-4444-823f-d0db6b40f457
0f177626-1566-454b-8d20-a42aed771b58	048a9c0f-08a0-4a99-91bf-eaa4c7948020
158a7282-6924-4f0f-bcb8-99b69d81b8d6	d57c1cca-a7b0-4c88-8d97-04721aeb1967
67de5e94-5e79-4eb2-b7b3-9e82e92c7497	b93e712e-e06a-4aeb-90a8-88481d283e7a
7953762c-70a1-4a5e-a042-0bd8133e1e0c	57de6b8b-a58c-45bd-b77c-96adfdf1b40e
\.


--
-- Data for Name: join_dataclasscomponent_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.join_dataclasscomponent_to_facet (dataclasscomponent_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_dataelementcomponent_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.join_dataelementcomponent_to_facet (dataelementcomponent_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_dataflow_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: maurodatamapper
--

COPY dataflow.join_dataflow_to_facet (dataflow_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: data_class; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.data_class (id, version, date_created, last_updated, path, depth, min_multiplicity, max_multiplicity, parent_data_class_id, breadcrumb_tree_id, data_model_id, idx, created_by, aliases_string, label, description) FROM stdin;
47496217-ced4-443b-bf9c-5b13ccac366a	0	2021-05-20 15:35:21.324913	2021-05-20 15:35:21.324913	/ed800789-3cd4-4058-884b-758ccf654132	1	\N	\N	\N	84260660-dbb3-48e3-94b3-e01633582161	ed800789-3cd4-4058-884b-758ccf654132	1	development@test.com	\N	emptyclass	dataclass with desc
b7bfbc0e-9677-4fa2-9277-02e12aa849b6	1	2021-05-20 15:35:21.33201	2021-05-20 15:35:21.522182	/ed800789-3cd4-4058-884b-758ccf654132/04659fc9-4340-4e13-bf78-690de6bce191	2	\N	\N	04659fc9-4340-4e13-bf78-690de6bce191	d7a47471-088d-4f02-bf40-f0e2ba40efb6	ed800789-3cd4-4058-884b-758ccf654132	0	development@test.com	\N	child	\N
04659fc9-4340-4e13-bf78-690de6bce191	2	2021-05-20 15:35:21.330585	2021-05-20 15:35:21.525849	/ed800789-3cd4-4058-884b-758ccf654132	1	1	-1	\N	8702b46b-1b26-431f-8665-7316d6662393	ed800789-3cd4-4058-884b-758ccf654132	1	development@test.com	\N	parent	\N
3594cda2-4824-4697-93c9-93d4df8586c6	1	2021-05-20 15:35:21.478268	2021-05-20 15:35:21.649734	/ed800789-3cd4-4058-884b-758ccf654132	1	0	1	\N	f54887e1-bc5c-4a70-926c-32654e27eec7	ed800789-3cd4-4058-884b-758ccf654132	2	development@test.com	\N	content	A dataclass with elements
467f8282-42dc-4cc7-bd3d-6bab24297bb2	1	2021-05-20 15:35:21.71054	2021-05-20 15:35:21.731783	/9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	1	\N	\N	\N	f1a7d6d5-142c-4c42-befc-cef7d4438069	9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	0	development@test.com	\N	simple	\N
0d75b276-ea7a-4def-a31f-11e3aa8a77d4	0	2021-05-20 15:35:21.778534	2021-05-20 15:35:21.778534	/47bc72a2-07e7-4afd-a453-db2894a64663	1	\N	\N	\N	a990cf1a-e1ac-4666-bcac-ff656895e837	47bc72a2-07e7-4afd-a453-db2894a64663	1	development@test.com	\N	Finalised Data Class	\N
e55f20c7-e7a8-46c7-bbdf-cd4aa4db1dde	0	2021-05-20 15:35:21.781014	2021-05-20 15:35:21.781014	/47bc72a2-07e7-4afd-a453-db2894a64663	1	\N	\N	\N	2fd3c9de-1e5c-4afa-aa29-e1381b8a3389	47bc72a2-07e7-4afd-a453-db2894a64663	1	development@test.com	\N	Another Data Class	\N
9477ed2f-99fe-4130-b172-08fc2c98642c	0	2021-05-20 15:35:22.062293	2021-05-20 15:35:22.062293	/1c412f8c-0369-41db-8472-9c5e89469b5f	1	\N	\N	\N	d7e15ccf-10dc-4639-8bbe-7dcbda9fd422	1c412f8c-0369-41db-8472-9c5e89469b5f	2	development@test.com	\N	tableA	\N
1fc79fcf-b149-438c-9884-c3157eda7f0b	0	2021-05-20 15:35:22.065526	2021-05-20 15:35:22.065526	/1c412f8c-0369-41db-8472-9c5e89469b5f	1	\N	\N	\N	c7068759-0f83-461b-8e63-720702aba35f	1c412f8c-0369-41db-8472-9c5e89469b5f	2	development@test.com	\N	tableB	\N
b6d0d671-d676-4f03-bf1a-5a502576d75e	0	2021-05-20 15:35:22.066496	2021-05-20 15:35:22.066496	/1c412f8c-0369-41db-8472-9c5e89469b5f	1	\N	\N	\N	9a427250-eb8d-4897-b4a2-ee0ad7308e6a	1c412f8c-0369-41db-8472-9c5e89469b5f	2	development@test.com	\N	tableC	\N
d66b9510-73e8-4c9e-b7db-2822c8974312	0	2021-05-20 15:35:22.183627	2021-05-20 15:35:22.183627	/4cb3611e-12dc-4b86-a996-da79283818fe	1	\N	\N	\N	c916cc68-c3ab-4c26-9a52-682c404ef292	4cb3611e-12dc-4b86-a996-da79283818fe	1	development@test.com	\N	tableD	\N
a2cd824d-3691-43ff-b50f-a8a846cc5358	0	2021-05-20 15:35:22.186783	2021-05-20 15:35:22.186783	/4cb3611e-12dc-4b86-a996-da79283818fe	1	\N	\N	\N	fd2ef7e5-4773-4a2e-a29f-9a41ac41982c	4cb3611e-12dc-4b86-a996-da79283818fe	1	development@test.com	\N	tableE	\N
\.


--
-- Data for Name: data_element; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.data_element (id, version, date_created, data_class_id, last_updated, path, depth, min_multiplicity, max_multiplicity, breadcrumb_tree_id, data_type_id, idx, created_by, aliases_string, label, description) FROM stdin;
d407d6a1-712f-4126-a058-03c0de03a1d0	0	2021-05-20 15:35:21.484923	3594cda2-4824-4697-93c9-93d4df8586c6	2021-05-20 15:35:21.484923	/ed800789-3cd4-4058-884b-758ccf654132/3594cda2-4824-4697-93c9-93d4df8586c6	2	1	1	185fc37a-1e75-415f-8179-b9f7355f6122	e93a7ea8-85e8-4066-9bc3-42e44101bba5	1	development@test.com	\N	element2	\N
d99eae34-491e-4455-a40a-bd21dbfb3740	0	2021-05-20 15:35:21.486335	04659fc9-4340-4e13-bf78-690de6bce191	2021-05-20 15:35:21.486335	/ed800789-3cd4-4058-884b-758ccf654132/04659fc9-4340-4e13-bf78-690de6bce191	2	1	1	159d3f8f-0f7f-4c29-8e19-59c9707339be	295f56c7-0de2-40c1-8a28-13f28574641e	0	development@test.com	\N	child	\N
2d998eee-1c4e-42a5-9fa7-4cd517711a1e	1	2021-05-20 15:35:21.482457	3594cda2-4824-4697-93c9-93d4df8586c6	2021-05-20 15:35:21.583417	/ed800789-3cd4-4058-884b-758ccf654132/3594cda2-4824-4697-93c9-93d4df8586c6	2	0	20	7c0dfc21-67d2-40d2-bf0f-55b1e463325d	baa81da3-bbb4-415c-86d1-5dcac118d36a	1	development@test.com	\N	ele1	\N
842717d8-97cc-49cb-bd28-e0ef18aa02c3	0	2021-05-20 15:35:21.783736	0d75b276-ea7a-4def-a31f-11e3aa8a77d4	2021-05-20 15:35:21.783736	/47bc72a2-07e7-4afd-a453-db2894a64663/0d75b276-ea7a-4def-a31f-11e3aa8a77d4	2	1	1	6a4ba564-5dc3-4dac-a4e7-ebf2922e44ba	65bfb646-8e63-46dc-b732-81464cbabc84	1	development@test.com	\N	Finalised Data Element	\N
cd12ced6-225d-4ac9-a054-990c50fcb9c7	0	2021-05-20 15:35:21.786049	0d75b276-ea7a-4def-a31f-11e3aa8a77d4	2021-05-20 15:35:21.786049	/47bc72a2-07e7-4afd-a453-db2894a64663/0d75b276-ea7a-4def-a31f-11e3aa8a77d4	2	1	1	7b7df051-59f3-4c2b-9c4a-9d041a58fc80	65bfb646-8e63-46dc-b732-81464cbabc84	1	development@test.com	\N	Another DataElement	\N
bc6362c1-f63c-4cd2-b867-d561667622a4	0	2021-05-20 15:35:22.069661	b6d0d671-d676-4f03-bf1a-5a502576d75e	2021-05-20 15:35:22.069661	/1c412f8c-0369-41db-8472-9c5e89469b5f/b6d0d671-d676-4f03-bf1a-5a502576d75e	2	\N	\N	50346ea3-0995-4e69-b1e7-9e6919d45ca9	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	4	development@test.com	\N	columnE2	\N
ee110977-ce2a-4436-855f-d27dfcba8dfd	0	2021-05-20 15:35:22.071217	b6d0d671-d676-4f03-bf1a-5a502576d75e	2021-05-20 15:35:22.071217	/1c412f8c-0369-41db-8472-9c5e89469b5f/b6d0d671-d676-4f03-bf1a-5a502576d75e	2	\N	\N	a5ef49c2-55db-4f05-98d4-346df31caac0	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	4	development@test.com	\N	columnJ	\N
f5300062-822c-4db7-8d87-9e7635ba5679	0	2021-05-20 15:35:22.072306	b6d0d671-d676-4f03-bf1a-5a502576d75e	2021-05-20 15:35:22.072306	/1c412f8c-0369-41db-8472-9c5e89469b5f/b6d0d671-d676-4f03-bf1a-5a502576d75e	2	\N	\N	ca284174-0aac-4b89-91f5-f84c77e94a4a	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	4	development@test.com	\N	columnL	\N
21e6e5af-6e3f-47cf-8e24-5f2ddef0ba99	0	2021-05-20 15:35:22.073103	9477ed2f-99fe-4130-b172-08fc2c98642c	2021-05-20 15:35:22.073103	/1c412f8c-0369-41db-8472-9c5e89469b5f/9477ed2f-99fe-4130-b172-08fc2c98642c	2	\N	\N	ba65c185-4623-4cc6-bd2b-559e80674eba	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	3	development@test.com	\N	columnB	\N
96d0c214-bd98-41fa-bdf0-6ce22a33c45d	0	2021-05-20 15:35:22.07385	9477ed2f-99fe-4130-b172-08fc2c98642c	2021-05-20 15:35:22.07385	/1c412f8c-0369-41db-8472-9c5e89469b5f/9477ed2f-99fe-4130-b172-08fc2c98642c	2	\N	\N	bf87a4ad-7097-49a8-a117-2cf02dda4aac	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	3	development@test.com	\N	columnA	\N
b7bfa6c1-b62b-41ff-916a-fec5fabc2482	0	2021-05-20 15:35:22.074942	1fc79fcf-b149-438c-9884-c3157eda7f0b	2021-05-20 15:35:22.074942	/1c412f8c-0369-41db-8472-9c5e89469b5f/1fc79fcf-b149-438c-9884-c3157eda7f0b	2	\N	\N	7dac85a8-8a95-46aa-a5fc-44a6ed5c8855	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	4	development@test.com	\N	columnH	\N
8570bc51-b105-4735-b9a8-f54a7c9507c9	0	2021-05-20 15:35:22.07636	1fc79fcf-b149-438c-9884-c3157eda7f0b	2021-05-20 15:35:22.07636	/1c412f8c-0369-41db-8472-9c5e89469b5f/1fc79fcf-b149-438c-9884-c3157eda7f0b	2	\N	\N	34c9c0d4-bc0c-432d-bb96-746635335347	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	4	development@test.com	\N	columnE1	\N
45032660-ca45-4da0-a61c-6e754f236132	0	2021-05-20 15:35:22.077454	1fc79fcf-b149-438c-9884-c3157eda7f0b	2021-05-20 15:35:22.077454	/1c412f8c-0369-41db-8472-9c5e89469b5f/1fc79fcf-b149-438c-9884-c3157eda7f0b	2	\N	\N	137481e6-6cd8-466f-9f9b-cf4668d2d0ad	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	4	development@test.com	\N	columnF	\N
61a1470d-43af-467e-86bf-6431bda53f5c	0	2021-05-20 15:35:22.07829	9477ed2f-99fe-4130-b172-08fc2c98642c	2021-05-20 15:35:22.07829	/1c412f8c-0369-41db-8472-9c5e89469b5f/9477ed2f-99fe-4130-b172-08fc2c98642c	2	\N	\N	c848f9da-fa52-46f4-ba5a-8bbf002f3162	961267d4-0fd5-4a2f-8d6f-978a9eb8c987	3	development@test.com	\N	columnC	\N
021c2905-dd41-4c20-93e0-40b3779f7480	0	2021-05-20 15:35:22.079035	1fc79fcf-b149-438c-9884-c3157eda7f0b	2021-05-20 15:35:22.079035	/1c412f8c-0369-41db-8472-9c5e89469b5f/1fc79fcf-b149-438c-9884-c3157eda7f0b	2	\N	\N	47ae3020-4fc4-4f75-9d71-f413d4effe52	09d00cad-53c0-4f7b-9d1f-fca26c42fb64	4	development@test.com	\N	columnG	\N
2050c541-3ca4-4aa0-8bd4-0b34215b9e54	0	2021-05-20 15:35:22.079806	b6d0d671-d676-4f03-bf1a-5a502576d75e	2021-05-20 15:35:22.079806	/1c412f8c-0369-41db-8472-9c5e89469b5f/b6d0d671-d676-4f03-bf1a-5a502576d75e	2	\N	\N	34a5f3fc-c501-4165-95ad-a30be3e7802a	09d00cad-53c0-4f7b-9d1f-fca26c42fb64	4	development@test.com	\N	columnK	\N
d09db654-bb94-4744-af40-fab7eaa1ce14	0	2021-05-20 15:35:22.080901	b6d0d671-d676-4f03-bf1a-5a502576d75e	2021-05-20 15:35:22.080901	/1c412f8c-0369-41db-8472-9c5e89469b5f/b6d0d671-d676-4f03-bf1a-5a502576d75e	2	\N	\N	7ad7984d-a530-4024-93ef-f8e3a0a4f0e5	09d00cad-53c0-4f7b-9d1f-fca26c42fb64	4	development@test.com	\N	columnM	\N
f9f4d4f5-359d-4d99-82f1-fa2585976bf0	0	2021-05-20 15:35:22.081765	1fc79fcf-b149-438c-9884-c3157eda7f0b	2021-05-20 15:35:22.081765	/1c412f8c-0369-41db-8472-9c5e89469b5f/1fc79fcf-b149-438c-9884-c3157eda7f0b	2	\N	\N	bce98467-b507-4e24-8e17-246068148531	09d00cad-53c0-4f7b-9d1f-fca26c42fb64	4	development@test.com	\N	columnI	\N
ef19d301-be66-4d3e-970e-32ea9537de7c	0	2021-05-20 15:35:22.082558	9477ed2f-99fe-4130-b172-08fc2c98642c	2021-05-20 15:35:22.082558	/1c412f8c-0369-41db-8472-9c5e89469b5f/9477ed2f-99fe-4130-b172-08fc2c98642c	2	\N	\N	8bb74927-422f-4b0e-9557-7a6e13a24da8	09d00cad-53c0-4f7b-9d1f-fca26c42fb64	3	development@test.com	\N	columnD	\N
20d6bbea-7c62-46bc-a9a8-779c035ad012	0	2021-05-20 15:35:22.189534	d66b9510-73e8-4c9e-b7db-2822c8974312	2021-05-20 15:35:22.189534	/4cb3611e-12dc-4b86-a996-da79283818fe/d66b9510-73e8-4c9e-b7db-2822c8974312	2	\N	\N	2f61e1f8-0877-49b5-91a5-da03bf4a71a2	718d2e04-e2ed-4aeb-abc8-968b333b2c11	3	development@test.com	\N	columnN	\N
d0430c92-f9d4-4c12-aa1f-840cb041737c	0	2021-05-20 15:35:22.191063	a2cd824d-3691-43ff-b50f-a8a846cc5358	2021-05-20 15:35:22.191063	/4cb3611e-12dc-4b86-a996-da79283818fe/a2cd824d-3691-43ff-b50f-a8a846cc5358	2	\N	\N	e75222c0-43a4-48aa-9160-5f28a4a004f7	718d2e04-e2ed-4aeb-abc8-968b333b2c11	5	development@test.com	\N	columnV	\N
99add985-9041-406d-abc9-3f0b0e5c26ee	0	2021-05-20 15:35:22.192231	a2cd824d-3691-43ff-b50f-a8a846cc5358	2021-05-20 15:35:22.192231	/4cb3611e-12dc-4b86-a996-da79283818fe/a2cd824d-3691-43ff-b50f-a8a846cc5358	2	\N	\N	2edbfa62-3722-48dd-9841-e3b86804be4d	718d2e04-e2ed-4aeb-abc8-968b333b2c11	5	development@test.com	\N	columnE	\N
627b2a27-c625-4ec4-a9d8-d5c17367ea61	0	2021-05-20 15:35:22.193651	d66b9510-73e8-4c9e-b7db-2822c8974312	2021-05-20 15:35:22.193651	/4cb3611e-12dc-4b86-a996-da79283818fe/d66b9510-73e8-4c9e-b7db-2822c8974312	2	\N	\N	d6107176-6147-4c8d-a6a6-a69135630cf6	718d2e04-e2ed-4aeb-abc8-968b333b2c11	3	development@test.com	\N	columnP	\N
c3dfb686-2c0f-4444-823f-d0db6b40f457	0	2021-05-20 15:35:22.194482	a2cd824d-3691-43ff-b50f-a8a846cc5358	2021-05-20 15:35:22.194482	/4cb3611e-12dc-4b86-a996-da79283818fe/a2cd824d-3691-43ff-b50f-a8a846cc5358	2	\N	\N	3b1efe84-f2b8-4998-9c91-9ece0c4db6d5	718d2e04-e2ed-4aeb-abc8-968b333b2c11	5	development@test.com	\N	columnR	\N
b93e712e-e06a-4aeb-90a8-88481d283e7a	0	2021-05-20 15:35:22.195261	a2cd824d-3691-43ff-b50f-a8a846cc5358	2021-05-20 15:35:22.195261	/4cb3611e-12dc-4b86-a996-da79283818fe/a2cd824d-3691-43ff-b50f-a8a846cc5358	2	\N	\N	c780195d-64c3-4c41-8de0-c74306776e69	718d2e04-e2ed-4aeb-abc8-968b333b2c11	5	development@test.com	\N	columnS	\N
64c5dcda-4422-463d-927f-73a8c439e477	0	2021-05-20 15:35:22.195959	d66b9510-73e8-4c9e-b7db-2822c8974312	2021-05-20 15:35:22.195959	/4cb3611e-12dc-4b86-a996-da79283818fe/d66b9510-73e8-4c9e-b7db-2822c8974312	2	\N	\N	c5a3328a-45e3-4bff-a7a2-89bc7633e686	718d2e04-e2ed-4aeb-abc8-968b333b2c11	3	development@test.com	\N	columnO	\N
048a9c0f-08a0-4a99-91bf-eaa4c7948020	0	2021-05-20 15:35:22.196692	a2cd824d-3691-43ff-b50f-a8a846cc5358	2021-05-20 15:35:22.196692	/4cb3611e-12dc-4b86-a996-da79283818fe/a2cd824d-3691-43ff-b50f-a8a846cc5358	2	\N	\N	e5d5f64c-f1e8-4c9d-bc12-560bc48c920c	718d2e04-e2ed-4aeb-abc8-968b333b2c11	5	development@test.com	\N	columnT	\N
57de6b8b-a58c-45bd-b77c-96adfdf1b40e	0	2021-05-20 15:35:22.197489	a2cd824d-3691-43ff-b50f-a8a846cc5358	2021-05-20 15:35:22.197489	/4cb3611e-12dc-4b86-a996-da79283818fe/a2cd824d-3691-43ff-b50f-a8a846cc5358	2	\N	\N	1ee62b1f-1d3d-4b06-8ce5-57401a0a53a2	718d2e04-e2ed-4aeb-abc8-968b333b2c11	5	development@test.com	\N	columnU	\N
d57c1cca-a7b0-4c88-8d97-04721aeb1967	0	2021-05-20 15:35:22.198267	d66b9510-73e8-4c9e-b7db-2822c8974312	2021-05-20 15:35:22.198267	/4cb3611e-12dc-4b86-a996-da79283818fe/d66b9510-73e8-4c9e-b7db-2822c8974312	2	\N	\N	971a87d9-7eff-41a9-bdc6-5a7a17be8828	3613e97d-bd18-43a2-aea6-1519b1a6bfe0	3	development@test.com	\N	columnQ	\N
\.


--
-- Data for Name: data_model; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.data_model (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag) FROM stdin;
ed800789-3cd4-4058-884b-758ccf654132	3	2021-05-20 15:35:21.098695	f	f	\N	1.0.0	f	Data Standard	2021-05-20 15:35:21.52034	brc	f	admin person	209ac018-4b20-4723-a30e-cb02678b3825	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	Complex Test DataModel	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	\N	\N
9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	1	2021-05-20 15:35:21.694487	f	f	\N	1.0.0	f	Data Standard	2021-05-20 15:35:21.716093	\N	f	\N	3903fb16-8b28-40ff-9cfb-019dac012f0e	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	Simple Test DataModel	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	\N	\N
47bc72a2-07e7-4afd-a453-db2894a64663	2	2021-05-20 15:35:21.748422	t	f	2021-05-20 15:35:21.792585	1.0.0	f	Data Standard	2021-05-20 15:35:21.817673	\N	f	\N	ba276eba-eb46-40dd-9dbe-aae1424d0cb3	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	Finalised Example Test DataModel	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	1.0.0	\N
1c412f8c-0369-41db-8472-9c5e89469b5f	1	2021-05-20 15:35:21.993428	f	f	\N	1.0.0	f	Data Asset	2021-05-20 15:35:22.08865	\N	f	\N	c17b0c4e-d2f1-4d17-a848-d175042b7179	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	SourceFlowDataModel	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	\N	\N
4cb3611e-12dc-4b86-a996-da79283818fe	1	2021-05-20 15:35:22.106718	f	f	\N	1.0.0	f	Data Asset	2021-05-20 15:35:22.206842	\N	f	\N	6baf61e7-9df2-4fe9-b435-53aa229e5121	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	TargetFlowDataModel	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	\N	\N
\.


--
-- Data for Name: data_type; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.data_type (id, version, date_created, domain_type, last_updated, path, depth, breadcrumb_tree_id, data_model_id, idx, created_by, aliases_string, label, description, class, units, reference_class_id, model_resource_id, model_resource_domain_type) FROM stdin;
295f56c7-0de2-40c1-8a28-13f28574641e	0	2021-05-20 15:35:21.480447	ReferenceType	2021-05-20 15:35:21.480447	/ed800789-3cd4-4058-884b-758ccf654132	1	d0443366-26fb-4008-b86b-0033f7d7884f	ed800789-3cd4-4058-884b-758ccf654132	3	development@test.com	\N	child	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.ReferenceType	\N	b7bfbc0e-9677-4fa2-9277-02e12aa849b6	\N	\N
1d99bf8a-3584-44eb-ad25-907e7fa0f979	1	2021-05-20 15:35:21.319078	EnumerationType	2021-05-20 15:35:21.527417	/ed800789-3cd4-4058-884b-758ccf654132	1	8d367afd-3a82-4c55-bcff-af2727ce2643	ed800789-3cd4-4058-884b-758ccf654132	0	development@test.com	\N	yesnounknown	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.EnumerationType	\N	\N	\N	\N
baa81da3-bbb4-415c-86d1-5dcac118d36a	2	2021-05-20 15:35:21.338456	PrimitiveType	2021-05-20 15:35:21.528975	/ed800789-3cd4-4058-884b-758ccf654132	1	3f973c1e-0bf4-4d2e-9978-de31deba6bb6	ed800789-3cd4-4058-884b-758ccf654132	2	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
e93a7ea8-85e8-4066-9bc3-42e44101bba5	1	2021-05-20 15:35:21.342601	PrimitiveType	2021-05-20 15:35:21.531193	/ed800789-3cd4-4058-884b-758ccf654132	1	7386b2b7-1b7e-4301-9d09-3ef009d46d94	ed800789-3cd4-4058-884b-758ccf654132	1	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
65bfb646-8e63-46dc-b732-81464cbabc84	0	2021-05-20 15:35:21.782072	PrimitiveType	2021-05-20 15:35:21.782072	/47bc72a2-07e7-4afd-a453-db2894a64663	1	7b96d487-6596-4c3e-9e8a-6be4c822739f	47bc72a2-07e7-4afd-a453-db2894a64663	0	development@test.com	\N	Finalised Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
961267d4-0fd5-4a2f-8d6f-978a9eb8c987	0	2021-05-20 15:35:22.067261	PrimitiveType	2021-05-20 15:35:22.067261	/1c412f8c-0369-41db-8472-9c5e89469b5f	1	007dc29d-aaaf-4ae1-ac26-280699d313b3	1c412f8c-0369-41db-8472-9c5e89469b5f	1	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
09d00cad-53c0-4f7b-9d1f-fca26c42fb64	0	2021-05-20 15:35:22.068911	PrimitiveType	2021-05-20 15:35:22.068911	/1c412f8c-0369-41db-8472-9c5e89469b5f	1	89dd02b0-a107-4535-a99a-0e7f6c0065c5	1c412f8c-0369-41db-8472-9c5e89469b5f	0	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
718d2e04-e2ed-4aeb-abc8-968b333b2c11	0	2021-05-20 15:35:22.187645	PrimitiveType	2021-05-20 15:35:22.187645	/4cb3611e-12dc-4b86-a996-da79283818fe	1	4e3313aa-4179-40f6-ae3d-a443c09a16fd	4cb3611e-12dc-4b86-a996-da79283818fe	1	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
3613e97d-bd18-43a2-aea6-1519b1a6bfe0	0	2021-05-20 15:35:22.188844	PrimitiveType	2021-05-20 15:35:22.188844	/4cb3611e-12dc-4b86-a996-da79283818fe	1	be3df439-f3cd-4467-a2c2-9631000e8006	4cb3611e-12dc-4b86-a996-da79283818fe	0	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
\.


--
-- Data for Name: enumeration_value; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.enumeration_value (id, version, date_created, enumeration_type_id, value, last_updated, path, depth, breadcrumb_tree_id, idx, category, created_by, aliases_string, key, label, description) FROM stdin;
65056f85-6d3f-4f49-99f0-d855e9967126	0	2021-05-20 15:35:21.344034	1d99bf8a-3584-44eb-ad25-907e7fa0f979	Yes	2021-05-20 15:35:21.344034	/ed800789-3cd4-4058-884b-758ccf654132/1d99bf8a-3584-44eb-ad25-907e7fa0f979	2	16cdf122-2e7e-4997-a299-1f2774b7139d	0	\N	development@test.com	\N	Y	Y	Yes
148477b8-0d7a-48f7-ba4e-af23ffa33bca	0	2021-05-20 15:35:21.348503	1d99bf8a-3584-44eb-ad25-907e7fa0f979	No	2021-05-20 15:35:21.348503	/ed800789-3cd4-4058-884b-758ccf654132/1d99bf8a-3584-44eb-ad25-907e7fa0f979	2	bd9a7d66-ca96-499d-855a-6a94119f07a3	1	\N	development@test.com	\N	N	N	No
768d9193-aafa-4a70-b77f-621f9e372577	0	2021-05-20 15:35:21.350525	1d99bf8a-3584-44eb-ad25-907e7fa0f979	Unknown	2021-05-20 15:35:21.350525	/ed800789-3cd4-4058-884b-758ccf654132/1d99bf8a-3584-44eb-ad25-907e7fa0f979	2	1a59d25b-adec-4827-9835-3ea15dc8aaf3	2	\N	development@test.com	\N	U	U	Unknown
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.1.0	datamodel	SQL	V1_1_0__datamodel.sql	-1078313268	maurodatamapper	2021-05-20 15:35:17.263264	107	t
2	1.5.1	add authority to datamodel	SQL	V1_5_1__add_authority_to_datamodel.sql	-189904092	maurodatamapper	2021-05-20 15:35:17.376918	2	t
3	1.6.0	add extra model properties to datamodel	SQL	V1_6_0__add_extra_model_properties_to_datamodel.sql	1674821418	maurodatamapper	2021-05-20 15:35:17.383156	1	t
4	1.9.0	make sure data model type is correct	SQL	V1_9_0__make_sure_data_model_type_is_correct.sql	-809313812	maurodatamapper	2021-05-20 15:35:17.38721	1	t
5	1.11.0	add model data type	SQL	V1_11_0__add_model_data_type.sql	404844351	maurodatamapper	2021-05-20 15:35:17.391833	1	t
6	1.15.1	add rule to datamodel	SQL	V1_15_1__add_rule_to_datamodel.sql	1543299352	maurodatamapper	2021-05-20 15:35:17.396019	6	t
7	2.0.0	add model version tag to datamodel	SQL	V2_0_0__add_model_version_tag_to_datamodel.sql	999639261	maurodatamapper	2021-05-20 15:35:17.405852	0	t
8	2.1.0	model import	SQL	V2_1_0__model_import.sql	-67495030	maurodatamapper	2021-05-20 15:35:17.409569	3	t
9	2.1.1	model extend	SQL	V2_1_1__model_extend.sql	827809470	maurodatamapper	2021-05-20 15:35:17.416112	2	t
10	2.2.0	rename catalogue item to multi facet	SQL	V2_2_0__rename_catalogue_item_to_multi_facet.sql	1051322676	maurodatamapper	2021-05-20 15:35:17.421698	1	t
11	2.2.1	remove model import export	SQL	V2_2_1__remove_model_import_export.sql	1494610551	maurodatamapper	2021-05-20 15:35:17.426667	7	t
12	2.2.3	add dataclass extension	SQL	V2_2_3__add_dataclass_extension.sql	601991483	maurodatamapper	2021-05-20 15:35:17.439646	4	t
13	2.2.4	add importing	SQL	V2_2_4__add_importing.sql	-1631221524	maurodatamapper	2021-05-20 15:35:17.446516	12	t
\.


--
-- Data for Name: join_dataclass_to_extended_data_class; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_dataclass_to_extended_data_class (dataclass_id, extended_dataclass_id) FROM stdin;
\.


--
-- Data for Name: join_dataclass_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_dataclass_to_facet (dataclass_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
04659fc9-4340-4e13-bf78-690de6bce191	\N	\N	\N	\N	\N	\N	05c7b7d8-4f28-4eb7-9dc0-c1e2cd18e9ea
3594cda2-4824-4697-93c9-93d4df8586c6	\N	\N	9ed20429-f5fc-44e6-867b-edd2ffada989	\N	\N	\N	\N
467f8282-42dc-4cc7-bd3d-6bab24297bb2	\N	\N	\N	\N	af351046-876b-42ef-9fc8-fe7569022073	\N	\N
\.


--
-- Data for Name: join_dataclass_to_imported_data_class; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_dataclass_to_imported_data_class (imported_dataclass_id, dataclass_id) FROM stdin;
\.


--
-- Data for Name: join_dataclass_to_imported_data_element; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_dataclass_to_imported_data_element (dataclass_id, imported_dataelement_id) FROM stdin;
\.


--
-- Data for Name: join_dataelement_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_dataelement_to_facet (dataelement_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
2d998eee-1c4e-42a5-9fa7-4cd517711a1e	\N	\N	\N	\N	\N	\N	eb9901d0-d03c-4cb4-b95d-ba1d4638a7e1
\.


--
-- Data for Name: join_datamodel_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_datamodel_to_facet (datamodel_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
ed800789-3cd4-4058-884b-758ccf654132	\N	32309bca-6930-4e74-9049-08fbf335d3e1	\N	\N	\N	\N	\N	\N
ed800789-3cd4-4058-884b-758ccf654132	\N	674f1847-502c-4d48-acde-3b35d3fe42b7	\N	\N	\N	\N	\N	\N
ed800789-3cd4-4058-884b-758ccf654132	bdce918d-d092-487c-8b03-87cf2b6fdf90	\N	\N	\N	\N	\N	\N	\N
ed800789-3cd4-4058-884b-758ccf654132	76cf5a69-ba52-45e4-b2ea-8decfc467490	\N	\N	\N	\N	\N	\N	\N
ed800789-3cd4-4058-884b-758ccf654132	\N	\N	\N	\N	\N	f026474f-e85d-4637-9302-b034e002b25c	\N	\N
ed800789-3cd4-4058-884b-758ccf654132	\N	\N	\N	\N	\N	2f8f8ef2-d4d2-466e-97b4-c8b09dbc218e	\N	\N
ed800789-3cd4-4058-884b-758ccf654132	\N	\N	\N	\N	\N	cc443b93-4c10-40d3-b637-fb4ea950263e	\N	\N
ed800789-3cd4-4058-884b-758ccf654132	\N	\N	\N	\N	\N	\N	\N	c0d9cbd6-a70d-4495-b117-62196a3e1dd3
9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	df6316af-5e81-4ab0-a325-5d11e9dcd11c	\N	\N	\N	\N	\N	\N	\N
9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	\N	\N	\N	\N	\N	6d91e4a5-f014-4525-b255-3489518af222	\N	\N
9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	\N	\N	\N	\N	\N	36a7c444-78fc-45c1-b878-8495fd28686c	\N	\N
9cafeafd-ed77-4d8c-a46b-c0de0a5ea2c0	\N	\N	\N	\N	\N	f1c656b2-6ac9-471d-b6a6-05e24287fd92	\N	\N
\.


--
-- Data for Name: join_datamodel_to_imported_data_class; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_datamodel_to_imported_data_class (imported_dataclass_id, datamodel_id) FROM stdin;
\.


--
-- Data for Name: join_datamodel_to_imported_data_type; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_datamodel_to_imported_data_type (imported_datatype_id, datamodel_id) FROM stdin;
\.


--
-- Data for Name: join_datatype_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_datatype_to_facet (datatype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
baa81da3-bbb4-415c-86d1-5dcac118d36a	\N	\N	\N	\N	\N	\N	7f60e151-9979-4b85-ab1d-661d87916c04
\.


--
-- Data for Name: join_enumerationvalue_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.join_enumerationvalue_to_facet (enumerationvalue_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: summary_metadata; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.summary_metadata (id, version, summary_metadata_type, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, created_by, label, description) FROM stdin;
\.


--
-- Data for Name: summary_metadata_report; Type: TABLE DATA; Schema: datamodel; Owner: maurodatamapper
--

COPY datamodel.summary_metadata_report (id, version, date_created, last_updated, report_date, created_by, report_value, summary_metadata_id) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: federation; Owner: maurodatamapper
--

COPY federation.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
0	\N	<< Flyway Schema Creation >>	SCHEMA	"federation"	\N	maurodatamapper	2021-05-20 15:35:17.478277	0	t
1	1.0.0	subscribed catalogue	SQL	V1_0_0__subscribed_catalogue.sql	664848546	maurodatamapper	2021-05-20 15:35:17.483421	9	t
\.


--
-- Data for Name: subscribed_catalogue; Type: TABLE DATA; Schema: federation; Owner: maurodatamapper
--

COPY federation.subscribed_catalogue (id, version, date_created, last_updated, readable_by_authenticated_users, readable_by_everyone, created_by, url, api_key, refresh_period, label, description, last_read) FROM stdin;
\.


--
-- Data for Name: subscribed_model; Type: TABLE DATA; Schema: federation; Owner: maurodatamapper
--

COPY federation.subscribed_model (id, version, date_created, last_updated, readable_by_authenticated_users, readable_by_everyone, created_by, subscribed_catalogue_id, subscribed_model_id, subscribed_model_type, folder_id, last_read, local_model_id) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.12.0	referencedata	SQL	V1_12_0__referencedata.sql	-1371414334	maurodatamapper	2021-05-20 15:35:17.546714	146	t
2	1.14.0	fix errant referencedata tables	SQL	V1_14_0__fix_errant_referencedata_tables.sql	1211767792	maurodatamapper	2021-05-20 15:35:17.699122	10	t
3	1.15.3	add rule to referencedata	SQL	V1_15_3__add_rule_to_referencedata.sql	-29360414	maurodatamapper	2021-05-20 15:35:17.713364	8	t
4	2.0.0	unmodelitem reference data value	SQL	V2_0_0__unmodelitem_reference_data_value.sql	-1153312026	maurodatamapper	2021-05-20 15:35:17.74815	6	t
5	2.1.0	add model version tag to referencedata	SQL	V2_1_0__add_model_version_tag_to_referencedata.sql	479267627	maurodatamapper	2021-05-20 15:35:17.758299	1	t
6	2.2.0	rename catalogue item to multi facet	SQL	V2_2_0__rename_catalogue_item_to_multi_facet.sql	1531204225	maurodatamapper	2021-05-20 15:35:17.762097	1	t
\.


--
-- Data for Name: join_referencedataelement_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.join_referencedataelement_to_facet (referencedataelement_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	\N	\N	\N	\N	\N	\N	3e029747-63d6-46df-8060-7b21071e5498
\.


--
-- Data for Name: join_referencedatamodel_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.join_referencedatamodel_to_facet (referencedatamodel_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
92e6abca-5ae4-4d01-b9db-fd577aaac4be	df6316af-5e81-4ab0-a325-5d11e9dcd11c	\N	\N	\N	\N	\N	\N	\N
92e6abca-5ae4-4d01-b9db-fd577aaac4be	\N	\N	\N	\N	\N	93f8369f-109b-4c17-81a3-14ccab581d4c	\N	\N
92e6abca-5ae4-4d01-b9db-fd577aaac4be	\N	\N	\N	\N	\N	043d8575-d031-46a2-8531-446cda872c50	\N	\N
92e6abca-5ae4-4d01-b9db-fd577aaac4be	\N	\N	\N	\N	\N	102c23a4-63e4-4b9d-998f-6d9fa7da5348	\N	\N
92e6abca-5ae4-4d01-b9db-fd577aaac4be	\N	\N	\N	\N	\N	\N	\N	a7df967d-40d9-47d7-95f2-e6870e5b945e
\.


--
-- Data for Name: join_referencedatatype_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.join_referencedatatype_to_facet (referencedatatype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
66858e4c-0a6e-47ff-995b-ff7fe5aae537	\N	\N	\N	\N	\N	\N	3e9cf08c-cedc-4d6e-8fff-67eedd256dde
\.


--
-- Data for Name: join_referenceenumerationvalue_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.join_referenceenumerationvalue_to_facet (referenceenumerationvalue_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: reference_data_element; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.reference_data_element (id, version, date_created, reference_data_type_id, reference_data_model_id, last_updated, path, depth, min_multiplicity, max_multiplicity, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
59773fd0-48bb-4138-b6f4-eec60dbadfca	0	2021-05-20 15:35:25.454203	66858e4c-0a6e-47ff-995b-ff7fe5aae537	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2021-05-20 15:35:25.454203	/92e6abca-5ae4-4d01-b9db-fd577aaac4be	1	\N	\N	affc3ba6-ff9d-4fbb-9e0f-59027f98ffe6	2147483647	development@test.com	\N	Organisation code	\N
2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	1	2021-05-20 15:35:25.45305	66858e4c-0a6e-47ff-995b-ff7fe5aae537	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2021-05-20 15:35:25.696224	/92e6abca-5ae4-4d01-b9db-fd577aaac4be	1	\N	\N	f3f5a0b1-e1a4-494b-96c6-f7cb8d66923d	2147483647	development@test.com	\N	Organisation name	\N
\.


--
-- Data for Name: reference_data_model; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.reference_data_model (id, version, branch_name, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, model_version, folder_id, authority_id, created_by, aliases_string, label, description, model_version_tag) FROM stdin;
92e6abca-5ae4-4d01-b9db-fd577aaac4be	4	main	2021-05-20 15:35:25.384611	f	f	\N	1.0.0	f	ReferenceDataModel	2021-05-20 15:35:25.694869	\N	f	\N	7b3ae3a5-0abc-4ec2-90ae-bbea4de91f84	\N	31a0deb7-7d38-45f6-a48e-5cfef3d40026	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	development@test.com	\N	Simple Reference Data Model	\N	\N
\.


--
-- Data for Name: reference_data_type; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.reference_data_type (id, version, date_created, reference_data_model_id, domain_type, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description, class, units) FROM stdin;
976d3d0e-3729-4358-b3cb-85d34800916e	0	2021-05-20 15:35:25.415212	92e6abca-5ae4-4d01-b9db-fd577aaac4be	ReferencePrimitiveType	2021-05-20 15:35:25.415212	/92e6abca-5ae4-4d01-b9db-fd577aaac4be	1	2c9465f1-864b-4f2d-919f-63098213add8	2147483647	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.referencedata.item.datatype.ReferencePrimitiveType	\N
66858e4c-0a6e-47ff-995b-ff7fe5aae537	1	2021-05-20 15:35:25.412631	92e6abca-5ae4-4d01-b9db-fd577aaac4be	ReferencePrimitiveType	2021-05-20 15:35:25.698588	/92e6abca-5ae4-4d01-b9db-fd577aaac4be	1	a9c99cf1-c177-41d4-bdb8-b4c1ee52c3f0	2147483647	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.referencedata.item.datatype.ReferencePrimitiveType	\N
\.


--
-- Data for Name: reference_data_value; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.reference_data_value (id, version, date_created, value, reference_data_model_id, reference_data_element_id, row_number, last_updated, created_by) FROM stdin;
dfcb99ff-536e-43cf-a84a-43a3ad77bd1f	0	2021-05-20 15:35:25.597639	Organisation 1	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	1	2021-05-20 15:35:25.597639	development@test.com
56004ec4-8b34-4e7c-b69e-0b579dfabb58	0	2021-05-20 15:35:25.598135	ORG1	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	1	2021-05-20 15:35:25.598135	development@test.com
97d925a9-5c6d-4bac-a10d-825c295497f0	0	2021-05-20 15:35:25.598361	Organisation 2	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	2	2021-05-20 15:35:25.598361	development@test.com
87f131b6-7998-4b46-b2d7-3cd3af98457c	0	2021-05-20 15:35:25.598549	ORG2	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	2	2021-05-20 15:35:25.598549	development@test.com
21ff1a92-d939-4368-b2b7-c564394197a5	0	2021-05-20 15:35:25.598739	Organisation 3	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	3	2021-05-20 15:35:25.598739	development@test.com
e2ed98bc-9d4b-4a70-9a77-7a926a36a2ef	0	2021-05-20 15:35:25.598931	ORG3	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	3	2021-05-20 15:35:25.598931	development@test.com
da0c01fc-ed87-48f1-85f5-cafcb7918e17	0	2021-05-20 15:35:25.599117	Organisation 4	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	4	2021-05-20 15:35:25.599117	development@test.com
cae45de7-a8f4-4650-a653-dd3425a43248	0	2021-05-20 15:35:25.599321	ORG4	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	4	2021-05-20 15:35:25.599321	development@test.com
cf41d8f3-da66-4ea0-a2c3-1a6cc4a3fd77	0	2021-05-20 15:35:25.599512	Organisation 5	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	5	2021-05-20 15:35:25.599512	development@test.com
11950fba-29b5-4935-b5cf-3bc3d65dd402	0	2021-05-20 15:35:25.599704	ORG5	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	5	2021-05-20 15:35:25.599704	development@test.com
0c65dcc7-4c7a-4bb0-823a-f90c673b4396	0	2021-05-20 15:35:25.599891	Organisation 6	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	6	2021-05-20 15:35:25.599891	development@test.com
2ff89a0c-9756-48ed-a0a2-4193580cc091	0	2021-05-20 15:35:25.600081	ORG6	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	6	2021-05-20 15:35:25.600081	development@test.com
7502efe7-89aa-4798-8620-2eadcf2ec1d6	0	2021-05-20 15:35:25.600287	Organisation 7	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	7	2021-05-20 15:35:25.600287	development@test.com
0d586578-a797-4330-a10e-e33dcb64ebbf	0	2021-05-20 15:35:25.600499	ORG7	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	7	2021-05-20 15:35:25.600499	development@test.com
9cb5ec13-20d1-4f33-94d6-3bd88720c061	0	2021-05-20 15:35:25.600694	Organisation 8	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	8	2021-05-20 15:35:25.600694	development@test.com
8d5eb44d-92d6-4f61-ad9e-66309c0575b5	0	2021-05-20 15:35:25.600897	ORG8	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	8	2021-05-20 15:35:25.600897	development@test.com
88a2349e-a941-4894-b9b0-9b252685e7d8	0	2021-05-20 15:35:25.601108	Organisation 9	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	9	2021-05-20 15:35:25.601108	development@test.com
cbaf7b85-ca5a-4639-992e-d054d4e42e65	0	2021-05-20 15:35:25.601315	ORG9	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	9	2021-05-20 15:35:25.601315	development@test.com
60366d98-52fd-418f-b0cb-5a4ae8b6dc78	0	2021-05-20 15:35:25.601506	Organisation 10	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	10	2021-05-20 15:35:25.601506	development@test.com
ef54ae5e-e2d2-4577-9b29-188c6f62a39c	0	2021-05-20 15:35:25.601699	ORG10	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	10	2021-05-20 15:35:25.601699	development@test.com
288beb82-17c3-415a-9756-b465a385bbf4	0	2021-05-20 15:35:25.601891	Organisation 11	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	11	2021-05-20 15:35:25.601891	development@test.com
ae10a90f-8e45-4035-9e58-817df12b3465	0	2021-05-20 15:35:25.602083	ORG11	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	11	2021-05-20 15:35:25.602083	development@test.com
759bcbfa-8db6-4aea-b791-8d4bf9e1bb76	0	2021-05-20 15:35:25.602275	Organisation 12	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	12	2021-05-20 15:35:25.602275	development@test.com
ddbb639b-a438-4c9a-b0d4-8ad3c0a61edb	0	2021-05-20 15:35:25.602461	ORG12	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	12	2021-05-20 15:35:25.602461	development@test.com
257d8141-4361-4214-b455-900c3d5dbee2	0	2021-05-20 15:35:25.60265	Organisation 13	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	13	2021-05-20 15:35:25.60265	development@test.com
836ca21d-03ec-4a4b-9d06-e3c9202f1cf8	0	2021-05-20 15:35:25.60284	ORG13	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	13	2021-05-20 15:35:25.60284	development@test.com
10b665ec-ac2a-4dbe-bc6a-18ada3e67774	0	2021-05-20 15:35:25.603043	Organisation 14	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	14	2021-05-20 15:35:25.603043	development@test.com
ea52c1a1-d5f2-4d67-9873-f541f2281753	0	2021-05-20 15:35:25.603245	ORG14	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	14	2021-05-20 15:35:25.603245	development@test.com
0ea1ff32-f1c5-4e53-94f5-78c3143ca7b5	0	2021-05-20 15:35:25.603419	Organisation 15	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	15	2021-05-20 15:35:25.603419	development@test.com
aab73b98-29c0-4a2f-a2b8-88a7e535257e	0	2021-05-20 15:35:25.603594	ORG15	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	15	2021-05-20 15:35:25.603594	development@test.com
a8ddb642-dbec-4859-b0be-d4cd9d74cad7	0	2021-05-20 15:35:25.608058	Organisation 16	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	16	2021-05-20 15:35:25.608058	development@test.com
4269691b-97bf-413f-9bbf-0665aed09024	0	2021-05-20 15:35:25.608378	ORG16	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	16	2021-05-20 15:35:25.608378	development@test.com
c01c3af9-ee64-4986-bd86-9bda1e42edf9	0	2021-05-20 15:35:25.608571	Organisation 17	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	17	2021-05-20 15:35:25.608571	development@test.com
48c6b9a5-5ecc-4255-9272-ff827c974cb2	0	2021-05-20 15:35:25.608801	ORG17	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	17	2021-05-20 15:35:25.608801	development@test.com
2a2f1dc5-54b4-4a79-bc5d-b90474b4d3e9	0	2021-05-20 15:35:25.609005	Organisation 18	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	18	2021-05-20 15:35:25.609005	development@test.com
10ffd1d5-e38f-4969-b8aa-360ca2b906ca	0	2021-05-20 15:35:25.609226	ORG18	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	18	2021-05-20 15:35:25.609226	development@test.com
6332daa4-ea0c-464e-9a88-b0d515c7c785	0	2021-05-20 15:35:25.60942	Organisation 19	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	19	2021-05-20 15:35:25.60942	development@test.com
34619f7f-3b73-4b1d-8827-08df4abca815	0	2021-05-20 15:35:25.609601	ORG19	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	19	2021-05-20 15:35:25.609601	development@test.com
cf55b2d0-3b22-4110-897c-16573396e586	0	2021-05-20 15:35:25.609789	Organisation 20	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	20	2021-05-20 15:35:25.609789	development@test.com
66599bdb-1c76-4461-bf5e-791ad3481884	0	2021-05-20 15:35:25.609976	ORG20	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	20	2021-05-20 15:35:25.609976	development@test.com
93124c67-703b-4716-ad2b-ba3d838ee175	0	2021-05-20 15:35:25.610154	Organisation 21	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	21	2021-05-20 15:35:25.610154	development@test.com
74f8d7ee-f31f-401e-ab41-78e68d982a01	0	2021-05-20 15:35:25.610341	ORG21	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	21	2021-05-20 15:35:25.610341	development@test.com
6fe4732f-3785-4f30-8a46-3aef53780e8a	0	2021-05-20 15:35:25.610513	Organisation 22	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	22	2021-05-20 15:35:25.610513	development@test.com
1848ebb2-0e29-4aa6-a86d-809ba94c5938	0	2021-05-20 15:35:25.610778	ORG22	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	22	2021-05-20 15:35:25.610778	development@test.com
2181f211-a447-49d0-81d3-70b85de962a0	0	2021-05-20 15:35:25.61107	Organisation 23	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	23	2021-05-20 15:35:25.61107	development@test.com
a652b315-d704-4049-9490-dd93ca626416	0	2021-05-20 15:35:25.611357	ORG23	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	23	2021-05-20 15:35:25.611357	development@test.com
56b7b3e0-2c70-4e37-88c5-5f70c9adfcee	0	2021-05-20 15:35:25.611633	Organisation 24	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	24	2021-05-20 15:35:25.611633	development@test.com
0e3a02b4-b54b-460b-b004-ed64d984fa35	0	2021-05-20 15:35:25.611935	ORG24	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	24	2021-05-20 15:35:25.611935	development@test.com
1866e5ad-cf91-4fca-acc2-87f722721abf	0	2021-05-20 15:35:25.612328	Organisation 25	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	25	2021-05-20 15:35:25.612328	development@test.com
7e80f1d5-a83d-41c9-8c86-3171aff92649	0	2021-05-20 15:35:25.612648	ORG25	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	25	2021-05-20 15:35:25.612648	development@test.com
274a0b16-34b7-4ec9-ba1b-3bb815a03677	0	2021-05-20 15:35:25.612857	Organisation 26	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	26	2021-05-20 15:35:25.612857	development@test.com
854cfa91-9319-445d-89b4-60e376f1b0f7	0	2021-05-20 15:35:25.613042	ORG26	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	26	2021-05-20 15:35:25.613042	development@test.com
ad8482cb-647a-4413-a1fb-4e0d66d20c3b	0	2021-05-20 15:35:25.613233	Organisation 27	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	27	2021-05-20 15:35:25.613233	development@test.com
398c8c76-3c10-4625-bd6e-f4e5713c280e	0	2021-05-20 15:35:25.61341	ORG27	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	27	2021-05-20 15:35:25.61341	development@test.com
329e743f-5293-45b5-8440-13c4868f6dad	0	2021-05-20 15:35:25.613584	Organisation 28	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	28	2021-05-20 15:35:25.613584	development@test.com
b15a759a-f248-4440-b2d6-7a37fd2bfb9e	0	2021-05-20 15:35:25.613763	ORG28	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	28	2021-05-20 15:35:25.613763	development@test.com
35c4a85c-4cf3-4f03-8b5c-5c95b4376976	0	2021-05-20 15:35:25.61394	Organisation 29	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	29	2021-05-20 15:35:25.61394	development@test.com
7f2c0913-0723-4dd7-814b-116accd1ea2a	0	2021-05-20 15:35:25.614143	ORG29	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	29	2021-05-20 15:35:25.614143	development@test.com
a24580ed-d917-4f10-962f-d2c46baafc79	0	2021-05-20 15:35:25.614344	Organisation 30	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	30	2021-05-20 15:35:25.614344	development@test.com
4309348d-51cd-48e1-8032-0558586b3078	0	2021-05-20 15:35:25.614535	ORG30	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	30	2021-05-20 15:35:25.614535	development@test.com
a13d352e-c057-4a5e-9953-e9b308b1f4a6	0	2021-05-20 15:35:25.617559	Organisation 31	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	31	2021-05-20 15:35:25.617559	development@test.com
f0912107-55f7-42f4-b82b-8c0ea4abdb83	0	2021-05-20 15:35:25.617869	ORG31	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	31	2021-05-20 15:35:25.617869	development@test.com
b55c4c40-8f34-441d-a298-3122325a9d55	0	2021-05-20 15:35:25.618068	Organisation 32	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	32	2021-05-20 15:35:25.618068	development@test.com
150f4ed9-6eb7-497f-a61d-c579add17e2b	0	2021-05-20 15:35:25.61826	ORG32	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	32	2021-05-20 15:35:25.61826	development@test.com
df45c0fc-84ef-47d8-8d0d-86c2c1c869f1	0	2021-05-20 15:35:25.618445	Organisation 33	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	33	2021-05-20 15:35:25.618445	development@test.com
b5bc180c-1a26-44c3-9b62-349e3394374a	0	2021-05-20 15:35:25.618625	ORG33	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	33	2021-05-20 15:35:25.618625	development@test.com
e7baecf3-5a21-4eb9-8774-ff59d72476d5	0	2021-05-20 15:35:25.618799	Organisation 34	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	34	2021-05-20 15:35:25.618799	development@test.com
715e78c6-34ab-4387-b83c-7b0a2a610196	0	2021-05-20 15:35:25.618973	ORG34	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	34	2021-05-20 15:35:25.618973	development@test.com
c15b454e-7ba0-4d02-b36e-2e7d248f15ff	0	2021-05-20 15:35:25.619146	Organisation 35	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	35	2021-05-20 15:35:25.619146	development@test.com
8a59e332-8a47-4e46-9941-70379c35d145	0	2021-05-20 15:35:25.61934	ORG35	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	35	2021-05-20 15:35:25.61934	development@test.com
fee0cc71-f847-41bd-8647-29ab8315d4e0	0	2021-05-20 15:35:25.61952	Organisation 36	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	36	2021-05-20 15:35:25.61952	development@test.com
5759e73f-bfad-45d0-88c0-ea228ce956fa	0	2021-05-20 15:35:25.6197	ORG36	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	36	2021-05-20 15:35:25.6197	development@test.com
e96e36d9-5e17-4da8-8f0e-414c2cd8683b	0	2021-05-20 15:35:25.619891	Organisation 37	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	37	2021-05-20 15:35:25.619891	development@test.com
d852eb2e-ae4f-4524-9bbf-f8862214f24a	0	2021-05-20 15:35:25.620083	ORG37	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	37	2021-05-20 15:35:25.620083	development@test.com
88d2bd37-42e0-4757-bf95-61984614c769	0	2021-05-20 15:35:25.620257	Organisation 38	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	38	2021-05-20 15:35:25.620257	development@test.com
e65a9df5-f33f-4468-a8df-547ed6ec744e	0	2021-05-20 15:35:25.620437	ORG38	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	38	2021-05-20 15:35:25.620437	development@test.com
134f7456-7fa7-4628-9d61-5f2e470fd358	0	2021-05-20 15:35:25.620636	Organisation 39	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	39	2021-05-20 15:35:25.620636	development@test.com
a7670799-5e20-4a51-a9ac-e67754cb8a7b	0	2021-05-20 15:35:25.620845	ORG39	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	39	2021-05-20 15:35:25.620845	development@test.com
b56f031d-f7d9-4da7-8185-b06a89812610	0	2021-05-20 15:35:25.621032	Organisation 40	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	40	2021-05-20 15:35:25.621032	development@test.com
7c8280fc-1036-455f-b763-b19e77ef4d76	0	2021-05-20 15:35:25.621242	ORG40	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	40	2021-05-20 15:35:25.621242	development@test.com
d23f288e-19fe-4947-a4a8-9c4b6321e8aa	0	2021-05-20 15:35:25.621421	Organisation 41	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	41	2021-05-20 15:35:25.621421	development@test.com
9c2fd94e-e7f9-45d2-90c5-fdf7e9972dec	0	2021-05-20 15:35:25.621605	ORG41	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	41	2021-05-20 15:35:25.621605	development@test.com
0fa75d0b-5636-4b99-b64b-bec13188e8d0	0	2021-05-20 15:35:25.621787	Organisation 42	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	42	2021-05-20 15:35:25.621787	development@test.com
44c68502-849a-48e7-aa4e-a5c26acec774	0	2021-05-20 15:35:25.621966	ORG42	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	42	2021-05-20 15:35:25.621966	development@test.com
0547c9ea-96f7-4c35-8ce7-70182737380f	0	2021-05-20 15:35:25.622148	Organisation 43	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	43	2021-05-20 15:35:25.622148	development@test.com
578e0333-e785-43c2-b735-0cd6411dce37	0	2021-05-20 15:35:25.62235	ORG43	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	43	2021-05-20 15:35:25.62235	development@test.com
c39d3e86-7176-41c0-93e9-4a4ad49c4bfb	0	2021-05-20 15:35:25.622544	Organisation 44	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	44	2021-05-20 15:35:25.622544	development@test.com
5e23770c-a82d-4dcc-99be-1d9aee4b568e	0	2021-05-20 15:35:25.62273	ORG44	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	44	2021-05-20 15:35:25.62273	development@test.com
83391f8f-1dfb-4cc1-b2c2-3ab64fa36259	0	2021-05-20 15:35:25.622911	Organisation 45	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	45	2021-05-20 15:35:25.622911	development@test.com
a7b5f7b0-7c1c-46d1-9763-8ef61dcc1849	0	2021-05-20 15:35:25.62309	ORG45	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	45	2021-05-20 15:35:25.62309	development@test.com
014d7a25-598f-44cd-a40b-d47577ee06a6	0	2021-05-20 15:35:25.625645	Organisation 46	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	46	2021-05-20 15:35:25.625645	development@test.com
c34e61a9-3f7e-426f-bbff-60183878e16e	0	2021-05-20 15:35:25.625901	ORG46	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	46	2021-05-20 15:35:25.625901	development@test.com
2ddd987f-2c21-4ee4-b378-0028f08fb543	0	2021-05-20 15:35:25.626101	Organisation 47	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	47	2021-05-20 15:35:25.626101	development@test.com
fe26996e-6726-4722-b290-557e5454b1fa	0	2021-05-20 15:35:25.626284	ORG47	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	47	2021-05-20 15:35:25.626284	development@test.com
f8f779e4-bd53-4bdb-97d4-42080ae4e563	0	2021-05-20 15:35:25.626465	Organisation 48	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	48	2021-05-20 15:35:25.626465	development@test.com
572cb6e4-d62a-4863-8611-905ace942fe1	0	2021-05-20 15:35:25.626645	ORG48	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	48	2021-05-20 15:35:25.626645	development@test.com
e40c7f51-228b-441d-ad7a-35143067ee2e	0	2021-05-20 15:35:25.626827	Organisation 49	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	49	2021-05-20 15:35:25.626827	development@test.com
77b9fdfc-d9e0-4995-b156-09afca06111b	0	2021-05-20 15:35:25.627025	ORG49	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	49	2021-05-20 15:35:25.627025	development@test.com
a42f6e28-f578-4a37-a5bb-e8d2a7dcba8d	0	2021-05-20 15:35:25.627204	Organisation 50	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	50	2021-05-20 15:35:25.627204	development@test.com
eb7791e0-35cb-4136-ab24-74c68460a5f8	0	2021-05-20 15:35:25.627399	ORG50	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	50	2021-05-20 15:35:25.627399	development@test.com
381ecbe4-7004-40b8-bb4f-5b44bb2d9df0	0	2021-05-20 15:35:25.627765	Organisation 51	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	51	2021-05-20 15:35:25.627765	development@test.com
cbc92670-06e9-4086-84d3-2e68f8621053	0	2021-05-20 15:35:25.628024	ORG51	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	51	2021-05-20 15:35:25.628024	development@test.com
024988fb-6583-4f49-a771-95353641837e	0	2021-05-20 15:35:25.628213	Organisation 52	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	52	2021-05-20 15:35:25.628213	development@test.com
997936a4-8eaa-4d27-b605-cca41384cf79	0	2021-05-20 15:35:25.628392	ORG52	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	52	2021-05-20 15:35:25.628392	development@test.com
6a03c621-d0ab-46f3-b5b8-e02155a32c15	0	2021-05-20 15:35:25.628582	Organisation 53	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	53	2021-05-20 15:35:25.628582	development@test.com
0dd65236-72e1-454b-aacb-063ee975351a	0	2021-05-20 15:35:25.628769	ORG53	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	53	2021-05-20 15:35:25.628769	development@test.com
6f2d2cb8-0b00-46bb-98b6-be094e40c850	0	2021-05-20 15:35:25.628939	Organisation 54	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	54	2021-05-20 15:35:25.628939	development@test.com
934e69a7-2487-44c7-971f-fec50408f53e	0	2021-05-20 15:35:25.629122	ORG54	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	54	2021-05-20 15:35:25.629122	development@test.com
7215a324-d64a-4c12-aa8b-042b59a2f428	0	2021-05-20 15:35:25.629296	Organisation 55	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	55	2021-05-20 15:35:25.629296	development@test.com
c6fd865a-effd-4212-bb78-4d3d15b84621	0	2021-05-20 15:35:25.629486	ORG55	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	55	2021-05-20 15:35:25.629486	development@test.com
e1f247de-2145-4239-b15a-82278835a062	0	2021-05-20 15:35:25.629662	Organisation 56	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	56	2021-05-20 15:35:25.629662	development@test.com
4d99fc3f-0122-442a-b3e4-5f4580601145	0	2021-05-20 15:35:25.629835	ORG56	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	56	2021-05-20 15:35:25.629835	development@test.com
d8775649-de04-401c-ab5f-90c97fd02489	0	2021-05-20 15:35:25.630013	Organisation 57	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	57	2021-05-20 15:35:25.630013	development@test.com
a24f26fc-1800-40b6-be4b-b082a927f752	0	2021-05-20 15:35:25.630195	ORG57	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	57	2021-05-20 15:35:25.630195	development@test.com
b4ebd783-9e32-4a8d-a86e-df20a13adad5	0	2021-05-20 15:35:25.630362	Organisation 58	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	58	2021-05-20 15:35:25.630362	development@test.com
938f04f8-fcf1-4218-a494-f949a726f375	0	2021-05-20 15:35:25.630546	ORG58	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	58	2021-05-20 15:35:25.630546	development@test.com
fa2c69e3-fc81-4fb2-86ae-ea77cd36f783	0	2021-05-20 15:35:25.630734	Organisation 59	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	59	2021-05-20 15:35:25.630734	development@test.com
f0a0f79a-76bf-4e8f-ad2f-aef4ddf04099	0	2021-05-20 15:35:25.631044	ORG59	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	59	2021-05-20 15:35:25.631044	development@test.com
e97188f4-9c3c-4dc8-8a34-9578f0d2229c	0	2021-05-20 15:35:25.63138	Organisation 60	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	60	2021-05-20 15:35:25.63138	development@test.com
b05d210d-ac23-4c8b-baef-3daa85a0e4bb	0	2021-05-20 15:35:25.631592	ORG60	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	60	2021-05-20 15:35:25.631592	development@test.com
2483c06f-5472-41ae-a9cd-97701b668228	0	2021-05-20 15:35:25.63433	Organisation 61	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	61	2021-05-20 15:35:25.63433	development@test.com
523170f1-ab87-4a3b-83d6-c54b8fb4448b	0	2021-05-20 15:35:25.634649	ORG61	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	61	2021-05-20 15:35:25.634649	development@test.com
e13eefaf-9660-4391-bfb3-6064bae0cee2	0	2021-05-20 15:35:25.634915	Organisation 62	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	62	2021-05-20 15:35:25.634915	development@test.com
f10170da-ac19-4976-a829-e71c8c4216ea	0	2021-05-20 15:35:25.635111	ORG62	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	62	2021-05-20 15:35:25.635111	development@test.com
fbc5bb48-fa7c-4d58-9286-058247ccd87c	0	2021-05-20 15:35:25.635293	Organisation 63	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	63	2021-05-20 15:35:25.635293	development@test.com
a48cb494-0823-49ce-af7f-f38957ac2a1f	0	2021-05-20 15:35:25.635492	ORG63	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	63	2021-05-20 15:35:25.635492	development@test.com
ed4a5f01-0993-495e-936b-464ab5f6dc41	0	2021-05-20 15:35:25.635674	Organisation 64	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	64	2021-05-20 15:35:25.635674	development@test.com
b6d39224-acf9-4ec7-8d00-450fb152a5a6	0	2021-05-20 15:35:25.635867	ORG64	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	64	2021-05-20 15:35:25.635867	development@test.com
ee4fd760-f848-4c15-9b74-28576af2a3e0	0	2021-05-20 15:35:25.636044	Organisation 65	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	65	2021-05-20 15:35:25.636044	development@test.com
3492b6bd-4365-4e6a-a1ed-2aaa039b536e	0	2021-05-20 15:35:25.636226	ORG65	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	65	2021-05-20 15:35:25.636226	development@test.com
9f8aa01a-18cb-4c6d-adb3-d7dbf712238d	0	2021-05-20 15:35:25.636403	Organisation 66	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	66	2021-05-20 15:35:25.636403	development@test.com
f916d058-83a5-4b49-bf92-dc5679dbf41a	0	2021-05-20 15:35:25.636578	ORG66	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	66	2021-05-20 15:35:25.636578	development@test.com
d2aa6ac4-7c74-49e9-a177-bf20c7a3c0bd	0	2021-05-20 15:35:25.636768	Organisation 67	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	67	2021-05-20 15:35:25.636768	development@test.com
7ef83415-e5fa-44bc-8f00-85332f6fa950	0	2021-05-20 15:35:25.636955	ORG67	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	67	2021-05-20 15:35:25.636955	development@test.com
22e4a3fa-3975-44d6-9471-636baba040ee	0	2021-05-20 15:35:25.637132	Organisation 68	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	68	2021-05-20 15:35:25.637132	development@test.com
7ebee4c2-dedf-41c5-86b8-4a4ed3710dbc	0	2021-05-20 15:35:25.637309	ORG68	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	68	2021-05-20 15:35:25.637309	development@test.com
2b2b03fd-c28c-4039-8117-3a89eba9a258	0	2021-05-20 15:35:25.637492	Organisation 69	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	69	2021-05-20 15:35:25.637492	development@test.com
f80179ea-c709-4244-bd48-b26cd05767fe	0	2021-05-20 15:35:25.637668	ORG69	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	69	2021-05-20 15:35:25.637668	development@test.com
74abef33-3487-4032-a6c2-45423c9d39ee	0	2021-05-20 15:35:25.63785	Organisation 70	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	70	2021-05-20 15:35:25.63785	development@test.com
1321f342-9416-499d-9ce8-e6d088b0ee9e	0	2021-05-20 15:35:25.638028	ORG70	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	70	2021-05-20 15:35:25.638028	development@test.com
e41d5d00-b781-4348-8753-1a99cfa1198f	0	2021-05-20 15:35:25.638203	Organisation 71	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	71	2021-05-20 15:35:25.638203	development@test.com
2f26aa84-d75d-4a9c-a827-d2f81d8012f4	0	2021-05-20 15:35:25.638382	ORG71	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	71	2021-05-20 15:35:25.638382	development@test.com
c29ac873-a96c-4303-b24d-3b35cae32c97	0	2021-05-20 15:35:25.638556	Organisation 72	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	72	2021-05-20 15:35:25.638556	development@test.com
9d66686f-03a4-44e0-b5c9-4a4a643feab6	0	2021-05-20 15:35:25.638809	ORG72	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	72	2021-05-20 15:35:25.638809	development@test.com
c9c09fa1-c825-4cc1-8f0e-0935874e8ffa	0	2021-05-20 15:35:25.63901	Organisation 73	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	73	2021-05-20 15:35:25.63901	development@test.com
64ffdef7-7794-4871-a48f-7e9e7e846d27	0	2021-05-20 15:35:25.639194	ORG73	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	73	2021-05-20 15:35:25.639194	development@test.com
9832d273-7234-4f74-a6c2-65f2e5b30993	0	2021-05-20 15:35:25.639368	Organisation 74	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	74	2021-05-20 15:35:25.639368	development@test.com
a158ee78-db49-4e0e-9256-3b761e5aa33d	0	2021-05-20 15:35:25.639548	ORG74	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	74	2021-05-20 15:35:25.639548	development@test.com
0b5053db-a6cd-4943-892f-34e438dfb7f7	0	2021-05-20 15:35:25.639781	Organisation 75	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	75	2021-05-20 15:35:25.639781	development@test.com
79dd2fd8-f0f7-4b22-8ceb-b2b89e00b086	0	2021-05-20 15:35:25.63997	ORG75	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	75	2021-05-20 15:35:25.63997	development@test.com
c31a0fd8-8314-4fa1-aab0-e0958b1725f2	0	2021-05-20 15:35:25.642971	Organisation 76	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	76	2021-05-20 15:35:25.642971	development@test.com
7e78fe9d-4b52-4085-9fc3-c905a34fa698	0	2021-05-20 15:35:25.643288	ORG76	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	76	2021-05-20 15:35:25.643288	development@test.com
a8d4ff88-f6c4-47c3-9a59-e8cea3f3e949	0	2021-05-20 15:35:25.643486	Organisation 77	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	77	2021-05-20 15:35:25.643486	development@test.com
0e85ad7c-1983-4ba1-89ad-f801ee9ddb3f	0	2021-05-20 15:35:25.643663	ORG77	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	77	2021-05-20 15:35:25.643663	development@test.com
7481fde0-4a45-4a40-8649-d23e25724b39	0	2021-05-20 15:35:25.643845	Organisation 78	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	78	2021-05-20 15:35:25.643845	development@test.com
a90e49e5-90b5-4cdc-9fb1-d7c00ee109c3	0	2021-05-20 15:35:25.644032	ORG78	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	78	2021-05-20 15:35:25.644032	development@test.com
06d683ca-3f02-4bc9-bf41-17096872d227	0	2021-05-20 15:35:25.644263	Organisation 79	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	79	2021-05-20 15:35:25.644263	development@test.com
97a7847d-6f58-4086-ad1a-aef302c579c8	0	2021-05-20 15:35:25.644658	ORG79	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	79	2021-05-20 15:35:25.644658	development@test.com
70f97d50-30d7-454c-9c6b-58ff42d04186	0	2021-05-20 15:35:25.645056	Organisation 80	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	80	2021-05-20 15:35:25.645056	development@test.com
975a7a49-4dda-47d2-9836-40992d72327b	0	2021-05-20 15:35:25.645422	ORG80	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	80	2021-05-20 15:35:25.645422	development@test.com
b77de59f-b010-4c13-92b7-d5bdeb5f206f	0	2021-05-20 15:35:25.645884	Organisation 81	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	81	2021-05-20 15:35:25.645884	development@test.com
3e0fbd99-76da-4437-8abb-f0c98fd10cc7	0	2021-05-20 15:35:25.646207	ORG81	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	81	2021-05-20 15:35:25.646207	development@test.com
d0aaf94d-c710-4662-bf90-7bf7057fcabb	0	2021-05-20 15:35:25.64651	Organisation 82	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	82	2021-05-20 15:35:25.64651	development@test.com
9f5c291f-4c71-484f-8375-0f6e38d9bddd	0	2021-05-20 15:35:25.646799	ORG82	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	82	2021-05-20 15:35:25.646799	development@test.com
94e6a599-4314-46d1-997e-36e0e7f84f86	0	2021-05-20 15:35:25.647086	Organisation 83	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	83	2021-05-20 15:35:25.647086	development@test.com
8f52bd72-2be5-40d7-b2a4-dc880430db60	0	2021-05-20 15:35:25.647361	ORG83	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	83	2021-05-20 15:35:25.647361	development@test.com
b45fa9ae-24a1-49a8-a816-d82ab5a9acc0	0	2021-05-20 15:35:25.647687	Organisation 84	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	84	2021-05-20 15:35:25.647687	development@test.com
f80a225e-e574-403f-a999-3f7c456b1844	0	2021-05-20 15:35:25.647896	ORG84	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	84	2021-05-20 15:35:25.647896	development@test.com
1d094c67-2d0e-4728-820d-5ae1490fffdc	0	2021-05-20 15:35:25.648096	Organisation 85	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	85	2021-05-20 15:35:25.648096	development@test.com
ae19f64f-4a4b-4344-ab45-db367d5f6e7e	0	2021-05-20 15:35:25.648275	ORG85	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	85	2021-05-20 15:35:25.648275	development@test.com
abad314d-6850-49cc-a701-fcec8d9a81ed	0	2021-05-20 15:35:25.648456	Organisation 86	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	86	2021-05-20 15:35:25.648456	development@test.com
204ca58c-9de7-4761-9be2-e4ce5f5eb709	0	2021-05-20 15:35:25.64863	ORG86	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	86	2021-05-20 15:35:25.64863	development@test.com
771b745f-4773-436a-b6cd-52318bbd7b84	0	2021-05-20 15:35:25.648858	Organisation 87	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	87	2021-05-20 15:35:25.648858	development@test.com
3c468d89-e935-46fd-8dfd-2f6e58c84ee7	0	2021-05-20 15:35:25.649084	ORG87	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	87	2021-05-20 15:35:25.649084	development@test.com
9b26d344-7e16-4d05-bd54-7c5cb0b0c382	0	2021-05-20 15:35:25.649277	Organisation 88	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	88	2021-05-20 15:35:25.649277	development@test.com
09a04050-9896-483d-b6ae-f5393d94a9f3	0	2021-05-20 15:35:25.649614	ORG88	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	88	2021-05-20 15:35:25.649614	development@test.com
b9b732ce-b787-4caf-bb80-24ce8a5c0582	0	2021-05-20 15:35:25.649944	Organisation 89	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	89	2021-05-20 15:35:25.649944	development@test.com
07feb778-6c99-4a37-93f0-1179999f1aa4	0	2021-05-20 15:35:25.650234	ORG89	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	89	2021-05-20 15:35:25.650234	development@test.com
5e96176b-85e0-4125-894c-2b370b6f8781	0	2021-05-20 15:35:25.650428	Organisation 90	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	90	2021-05-20 15:35:25.650428	development@test.com
f1e230ba-aac6-4a12-aaaa-38f48eba7a10	0	2021-05-20 15:35:25.650611	ORG90	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	90	2021-05-20 15:35:25.650611	development@test.com
02c2f0dd-38b8-4b23-bf09-3e0f9616fb6f	0	2021-05-20 15:35:25.653446	Organisation 91	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	91	2021-05-20 15:35:25.653446	development@test.com
b2e8076d-1fd1-455a-8074-531f5c40235b	0	2021-05-20 15:35:25.653809	ORG91	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	91	2021-05-20 15:35:25.653809	development@test.com
aee71690-947d-448e-acc9-d191bed27265	0	2021-05-20 15:35:25.654003	Organisation 92	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	92	2021-05-20 15:35:25.654003	development@test.com
e980fa02-12fe-469e-937e-5888579caedb	0	2021-05-20 15:35:25.654187	ORG92	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	92	2021-05-20 15:35:25.654187	development@test.com
a960eb72-a328-4efe-bb6e-5bb61810d012	0	2021-05-20 15:35:25.65436	Organisation 93	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	93	2021-05-20 15:35:25.65436	development@test.com
bd728c99-711f-45dc-a5d6-9e25311feae5	0	2021-05-20 15:35:25.654541	ORG93	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	93	2021-05-20 15:35:25.654541	development@test.com
e7714894-d38f-4c60-80f1-30e6824673fe	0	2021-05-20 15:35:25.654714	Organisation 94	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	94	2021-05-20 15:35:25.654714	development@test.com
43807006-d83e-426b-8739-964f39e9a8a0	0	2021-05-20 15:35:25.65489	ORG94	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	94	2021-05-20 15:35:25.65489	development@test.com
efe6c956-5389-4bbd-b8a6-7026384cd79a	0	2021-05-20 15:35:25.655064	Organisation 95	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	95	2021-05-20 15:35:25.655064	development@test.com
76651619-31df-4197-8320-3115147249f2	0	2021-05-20 15:35:25.655245	ORG95	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	95	2021-05-20 15:35:25.655245	development@test.com
763e5a00-4576-455b-ad98-20e392c968da	0	2021-05-20 15:35:25.655424	Organisation 96	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	96	2021-05-20 15:35:25.655424	development@test.com
2d030b1f-6d62-467b-81bb-852bfad3da68	0	2021-05-20 15:35:25.655606	ORG96	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	96	2021-05-20 15:35:25.655606	development@test.com
fbe67a18-78e3-471e-9cd2-1830c88ecc0d	0	2021-05-20 15:35:25.655786	Organisation 97	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	97	2021-05-20 15:35:25.655786	development@test.com
32fcadb6-4cb0-4c07-a26e-716c643309d9	0	2021-05-20 15:35:25.655959	ORG97	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	97	2021-05-20 15:35:25.655959	development@test.com
bd9965df-afed-4be0-a3f1-588eac2a431e	0	2021-05-20 15:35:25.65621	Organisation 98	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	98	2021-05-20 15:35:25.65621	development@test.com
f6b729f7-b40d-47a5-87d9-9222aff67f67	0	2021-05-20 15:35:25.656408	ORG98	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	98	2021-05-20 15:35:25.656408	development@test.com
fc2e1d69-514e-4065-8996-ae395cc2e2c3	0	2021-05-20 15:35:25.656598	Organisation 99	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	99	2021-05-20 15:35:25.656598	development@test.com
2043739a-2d4b-47f2-b8d3-a8cfe9e8c3db	0	2021-05-20 15:35:25.656782	ORG99	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	99	2021-05-20 15:35:25.656782	development@test.com
f9acbcd4-2551-496b-ab0f-027737cd9fdf	0	2021-05-20 15:35:25.656964	Organisation 100	92e6abca-5ae4-4d01-b9db-fd577aaac4be	2e22cfaa-47d5-4bca-bc5b-50ed2bf71846	100	2021-05-20 15:35:25.656964	development@test.com
3f22fc50-c7bf-4714-a530-d16c4c54936e	0	2021-05-20 15:35:25.657139	ORG100	92e6abca-5ae4-4d01-b9db-fd577aaac4be	59773fd0-48bb-4138-b6f4-eec60dbadfca	100	2021-05-20 15:35:25.657139	development@test.com
\.


--
-- Data for Name: reference_enumeration_value; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.reference_enumeration_value (id, version, date_created, value, reference_enumeration_type_id, last_updated, path, depth, breadcrumb_tree_id, idx, category, created_by, aliases_string, key, label, description) FROM stdin;
\.


--
-- Data for Name: reference_summary_metadata; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.reference_summary_metadata (id, version, summary_metadata_type, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, created_by, label, description) FROM stdin;
\.


--
-- Data for Name: reference_summary_metadata_report; Type: TABLE DATA; Schema: referencedata; Owner: maurodatamapper
--

COPY referencedata.reference_summary_metadata_report (id, version, date_created, last_updated, report_date, created_by, report_value, summary_metadata_id) FROM stdin;
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: security; Owner: maurodatamapper
--

COPY security.api_key (id, version, refreshable, date_created, expiry_date, last_updated, disabled, catalogue_user_id, name, created_by) FROM stdin;
\.


--
-- Data for Name: catalogue_user; Type: TABLE DATA; Schema: security; Owner: maurodatamapper
--

COPY security.catalogue_user (id, version, pending, salt, date_created, first_name, profile_picture_id, last_updated, organisation, reset_token, disabled, job_title, email_address, user_preferences, password, created_by, temp_password, last_name, last_login) FROM stdin;
67c9cad4-22c2-4074-aa54-45a413d0d53e	0	f	\\x527946496f473f5e	2021-05-20 15:35:22.78413	Unlogged	\N	2021-05-20 15:35:22.78413	\N	\N	f	\N	unlogged_user@mdm-core.com	\N	\N	unlogged_user@mdm-core.com	\N	User	\N
651a1053-fb0e-4661-8270-110ec1ea6d2f	0	f	\\x5e613c4c5c776148	2021-05-20 15:35:22.949318	authenticated	\N	2021-05-20 15:35:22.949318	\N	\N	f	\N	authenticated@test.com	\N	\N	development@test.com	JFm-Aor-Z8Y-lln	User	\N
af9a2bb0-0bcb-4ae8-9879-5d2d0eb7993b	0	t	\\x3768783667496a3d	2021-05-20 15:35:22.954417	pending	\N	2021-05-20 15:35:22.954417	Oxford	\N	f	tester	pending@test.com	\N	\\xf0a6c8c6b92613b3f041846aeda4eef5d01b299c2a870dac2dd1dda3915c2f86	development@test.com	\N	User	\N
96ca23e6-b5c9-4ac9-bbcd-0d40484e65ac	1	f	\\x73665f69773d735b	2021-05-20 15:35:22.944003	reader	\N	2021-05-20 15:35:22.982274	\N	\N	f	\N	reader@test.com	\N	\N	development@test.com	YoF-HUG-iia-kYq	User	\N
c4557954-38be-4cc3-9619-6b1a01c6c932	1	f	\\x7261383b6f4c764f	2021-05-20 15:35:22.959731	containerAdmin	\N	2021-05-20 15:35:22.983127	\N	\N	f	\N	container_admin@test.com	\N	\\xabf4073bf3b45879224ee0620459cae1383e24e9510b94976ac7d135351be683	development@test.com	\N	User	\N
29e320f3-7c06-43d3-b393-5c2cb7dbd4e1	1	f	\\x65493f6e3c746779	2021-05-20 15:35:22.939058	editor	\N	2021-05-20 15:35:22.983488	\N	\N	f	\N	editor@test.com	\N	\\xd98f844fd9c6c6ebed0a4e65db121ea897b348d2aea38d75255ddf25ea02b9ea	development@test.com	\N	User	\N
6347239f-5bdb-49fd-80eb-52f631230e28	1	f	\\x5c433c65623f5075	2021-05-20 15:35:22.970276	reviewer	\N	2021-05-20 15:35:22.983819	\N	\N	f	\N	reviewer@test.com	\N	\N	development@test.com	FsG-W3C-ALl-Ab2	User	\N
7b7436bf-0abf-434e-bf7a-e397311cc927	1	f	\\x3f51423244594254	2021-05-20 15:35:22.965073	author	\N	2021-05-20 15:35:22.984135	\N	\N	f	\N	author@test.com	\N	\N	development@test.com	liN-nZq-ETT-Ixq	User	\N
d3bce3b6-d497-4dd2-b2e1-5132ee59cfa0	82	f	\\x6441557a4e40425a	2021-05-20 15:35:22.878444	Admin	\N	2021-05-21 13:44:12.273288	Oxford BRC Informatics	\N	f	God	admin@maurodatamapper.com	\N	\\x595df9f52c982ae2905e40058ef4f41224b7ac337d5ca605acdb2d84e19a3d3a	admin@maurodatamapper.com	\N	User	2021-05-21 13:44:12.272692
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: security; Owner: maurodatamapper
--

COPY security.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.2.0	security	SQL	V1_2_0__security.sql	-399282874	maurodatamapper	2021-05-20 15:35:17.969523	57	t
2	1.8.0	add can finalise model	SQL	V1_8_0__add_can_finalise_model.sql	1474674104	maurodatamapper	2021-05-20 15:35:18.031877	2	t
3	1.10.0	add user group undeleteable	SQL	V1_10_0__add_user_group_undeleteable.sql	617768911	maurodatamapper	2021-05-20 15:35:18.03728	2	t
4	1.11.0	add api key	SQL	V1_11_0__add_api_key.sql	-351808098	maurodatamapper	2021-05-20 15:35:18.043133	9	t
5	2.0.0	remove extra securableresourcegrouprole columns	SQL	V2_0_0__remove_extra_securableresourcegrouprole_columns.sql	-794214980	maurodatamapper	2021-05-20 15:35:18.056834	1	t
\.


--
-- Data for Name: group_role; Type: TABLE DATA; Schema: security; Owner: maurodatamapper
--

COPY security.group_role (id, version, date_created, display_name, name, parent_id, last_updated, path, depth, application_level_role, created_by) FROM stdin;
6e008458-8c9b-4dc8-8e61-16ebd09a0aef	0	2021-05-20 15:35:22.644015	Site Administrator	site_admin	\N	2021-05-20 15:35:22.644015		0	t	mdm-security@maurodatamapper.com
23db7323-5c50-4c86-b2f2-e1b66383a6c4	0	2021-05-20 15:35:22.646355	Application Administrator	application_admin	6e008458-8c9b-4dc8-8e61-16ebd09a0aef	2021-05-20 15:35:22.646355	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef	1	t	mdm-security@maurodatamapper.com
a17f4820-e3eb-40cc-9171-f12479f5c21d	0	2021-05-20 15:35:22.646986	User Administrator	user_admin	23db7323-5c50-4c86-b2f2-e1b66383a6c4	2021-05-20 15:35:22.646986	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef/23db7323-5c50-4c86-b2f2-e1b66383a6c4	2	t	mdm-security@maurodatamapper.com
453d1c9c-e8b7-44c3-a0d7-5ee2bddd8e9f	0	2021-05-20 15:35:22.647401	Group Administrator	group_admin	a17f4820-e3eb-40cc-9171-f12479f5c21d	2021-05-20 15:35:22.647401	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef/23db7323-5c50-4c86-b2f2-e1b66383a6c4/a17f4820-e3eb-40cc-9171-f12479f5c21d	3	t	mdm-security@maurodatamapper.com
46a137bf-5ed3-4c8b-979b-3a7a4650c73c	0	2021-05-20 15:35:22.647798	Container Group Administrator	container_group_admin	453d1c9c-e8b7-44c3-a0d7-5ee2bddd8e9f	2021-05-20 15:35:22.647798	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef/23db7323-5c50-4c86-b2f2-e1b66383a6c4/a17f4820-e3eb-40cc-9171-f12479f5c21d/453d1c9c-e8b7-44c3-a0d7-5ee2bddd8e9f	4	t	mdm-security@maurodatamapper.com
64bb9bc3-6b2a-4c15-bd1b-c84f7556e2c7	0	2021-05-20 15:35:22.648229	Container Administrator	container_admin	6e008458-8c9b-4dc8-8e61-16ebd09a0aef	2021-05-20 15:35:22.648229	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef	1	f	mdm-security@maurodatamapper.com
fc08ef5e-6c5b-4cca-b0ef-05488c5e8bef	0	2021-05-20 15:35:22.648876	Editor	editor	64bb9bc3-6b2a-4c15-bd1b-c84f7556e2c7	2021-05-20 15:35:22.648876	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef/64bb9bc3-6b2a-4c15-bd1b-c84f7556e2c7	2	f	mdm-security@maurodatamapper.com
5543bf46-c0b5-43a8-b926-88af16d02ac7	0	2021-05-20 15:35:22.649688	Author	author	fc08ef5e-6c5b-4cca-b0ef-05488c5e8bef	2021-05-20 15:35:22.649688	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef/64bb9bc3-6b2a-4c15-bd1b-c84f7556e2c7/fc08ef5e-6c5b-4cca-b0ef-05488c5e8bef	3	f	mdm-security@maurodatamapper.com
867fd1b9-cac2-4c68-8d5c-cf2d27a671da	0	2021-05-20 15:35:22.650113	Reviewer	reviewer	5543bf46-c0b5-43a8-b926-88af16d02ac7	2021-05-20 15:35:22.650113	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef/64bb9bc3-6b2a-4c15-bd1b-c84f7556e2c7/fc08ef5e-6c5b-4cca-b0ef-05488c5e8bef/5543bf46-c0b5-43a8-b926-88af16d02ac7	4	f	mdm-security@maurodatamapper.com
07263737-29f3-4a9a-9307-183c262975f3	0	2021-05-20 15:35:22.650602	Reader	reader	867fd1b9-cac2-4c68-8d5c-cf2d27a671da	2021-05-20 15:35:22.650602	/6e008458-8c9b-4dc8-8e61-16ebd09a0aef/64bb9bc3-6b2a-4c15-bd1b-c84f7556e2c7/fc08ef5e-6c5b-4cca-b0ef-05488c5e8bef/5543bf46-c0b5-43a8-b926-88af16d02ac7/867fd1b9-cac2-4c68-8d5c-cf2d27a671da	5	f	mdm-security@maurodatamapper.com
\.


--
-- Data for Name: join_catalogue_user_to_user_group; Type: TABLE DATA; Schema: security; Owner: maurodatamapper
--

COPY security.join_catalogue_user_to_user_group (catalogue_user_id, user_group_id) FROM stdin;
d3bce3b6-d497-4dd2-b2e1-5132ee59cfa0	c596bed6-e64e-4508-bd40-da2238070368
c4557954-38be-4cc3-9619-6b1a01c6c932	e1d23730-b0e5-45b4-bd5b-8eb4c61d2747
29e320f3-7c06-43d3-b393-5c2cb7dbd4e1	e1d23730-b0e5-45b4-bd5b-8eb4c61d2747
7b7436bf-0abf-434e-bf7a-e397311cc927	2ebf3360-cb7b-45c9-b9a6-be08838bc039
6347239f-5bdb-49fd-80eb-52f631230e28	2ebf3360-cb7b-45c9-b9a6-be08838bc039
96ca23e6-b5c9-4ac9-bbcd-0d40484e65ac	2ebf3360-cb7b-45c9-b9a6-be08838bc039
\.


--
-- Data for Name: securable_resource_group_role; Type: TABLE DATA; Schema: security; Owner: maurodatamapper
--

COPY security.securable_resource_group_role (id, version, securable_resource_id, user_group_id, date_created, securable_resource_domain_type, last_updated, group_role_id, created_by) FROM stdin;
02d4f286-51b6-44d7-baaa-27e6c1f690a6	0	31a0deb7-7d38-45f6-a48e-5cfef3d40026	e1d23730-b0e5-45b4-bd5b-8eb4c61d2747	2021-05-20 15:35:23.006265	Folder	2021-05-20 15:35:23.006265	64bb9bc3-6b2a-4c15-bd1b-c84f7556e2c7	development@test.com
6f9eca09-9046-4dfe-8b6a-818aa8d6325b	0	31a0deb7-7d38-45f6-a48e-5cfef3d40026	2ebf3360-cb7b-45c9-b9a6-be08838bc039	2021-05-20 15:35:23.030317	Folder	2021-05-20 15:35:23.030317	07263737-29f3-4a9a-9307-183c262975f3	development@test.com
328baa0b-8883-4f71-a582-041b2e498521	0	bbc5ae78-7c94-4502-9ee7-236d60d5cb2b	e1d23730-b0e5-45b4-bd5b-8eb4c61d2747	2021-05-20 15:35:23.038324	Classifier	2021-05-20 15:35:23.038324	64bb9bc3-6b2a-4c15-bd1b-c84f7556e2c7	development@test.com
63c3a786-6161-477c-97c7-a064487b1ad5	0	bbc5ae78-7c94-4502-9ee7-236d60d5cb2b	2ebf3360-cb7b-45c9-b9a6-be08838bc039	2021-05-20 15:35:23.045438	Classifier	2021-05-20 15:35:23.045438	07263737-29f3-4a9a-9307-183c262975f3	development@test.com
\.


--
-- Data for Name: user_group; Type: TABLE DATA; Schema: security; Owner: maurodatamapper
--

COPY security.user_group (id, version, date_created, last_updated, name, application_group_role_id, created_by, description, undeleteable) FROM stdin;
c596bed6-e64e-4508-bd40-da2238070368	0	2021-05-20 15:35:22.897137	2021-05-20 15:35:22.897137	administrators	6e008458-8c9b-4dc8-8e61-16ebd09a0aef	admin@maurodatamapper.com	\N	t
e1d23730-b0e5-45b4-bd5b-8eb4c61d2747	0	2021-05-20 15:35:22.981415	2021-05-20 15:35:22.981415	editors	\N	development@test.com	\N	f
2ebf3360-cb7b-45c9-b9a6-be08838bc039	0	2021-05-20 15:35:22.991133	2021-05-20 15:35:22.991133	readers	\N	development@test.com	\N	f
\.


--
-- Data for Name: code_set; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.code_set (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag) FROM stdin;
c070add3-af60-42ef-b0c1-2e3f5efe6d18	1	2021-05-20 15:35:25.130008	t	f	2021-05-20 15:35:25.179	1.0.0	f	CodeSet	2021-05-20 15:35:25.189159	Oxford BRC	f	Test Bootstrap	\N	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	Simple Test CodeSet	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	1.0.0	\N
be9b7c0b-5c7f-44b8-aeae-9841f5404946	2	2021-05-20 15:35:25.203529	f	f	\N	1.0.0	f	CodeSet	2021-05-20 15:35:25.22893	Oxford BRC	f	Test Bootstrap	\N	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	Unfinalised Simple Test CodeSet	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	\N	\N
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.3.0	terminology	SQL	V1_3_0__terminology.sql	712422872	maurodatamapper	2021-05-20 15:35:17.79373	129	t
2	1.5.2	add authority to terminology	SQL	V1_5_2__add_authority_to_terminology.sql	303081238	maurodatamapper	2021-05-20 15:35:17.92833	4	t
3	1.6.1	add extra model properties to terminology	SQL	V1_6_1__add_extra_model_properties_to_terminology.sql	-507038112	maurodatamapper	2021-05-20 15:35:17.935346	2	t
4	1.15.2	add rule to terminology	SQL	V1_15_2__add_rule_to_terminology.sql	413736981	maurodatamapper	2021-05-20 15:35:17.941246	6	t
5	2.0.0	add model version tag to terminology and codeset	SQL	V2_0_0__add_model_version_tag_to_terminology_and_codeset.sql	1715495761	maurodatamapper	2021-05-20 15:35:17.950454	1	t
\.


--
-- Data for Name: join_codeset_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.join_codeset_to_facet (codeset_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
c070add3-af60-42ef-b0c1-2e3f5efe6d18	bdce918d-d092-487c-8b03-87cf2b6fdf90	\N	\N	\N	\N	\N	\N
be9b7c0b-5c7f-44b8-aeae-9841f5404946	\N	\N	\N	\N	\N	\N	0f5cdd4a-3360-4461-8fa9-a6ea47709ea3
\.


--
-- Data for Name: join_codeset_to_term; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.join_codeset_to_term (term_id, codeset_id) FROM stdin;
6200b0e0-5c9a-4951-ae06-cfbc34476ba9	c070add3-af60-42ef-b0c1-2e3f5efe6d18
0346e1c7-7d1c-4c83-838c-36518da14dd4	c070add3-af60-42ef-b0c1-2e3f5efe6d18
6200b0e0-5c9a-4951-ae06-cfbc34476ba9	be9b7c0b-5c7f-44b8-aeae-9841f5404946
0346e1c7-7d1c-4c83-838c-36518da14dd4	be9b7c0b-5c7f-44b8-aeae-9841f5404946
\.


--
-- Data for Name: join_term_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.join_term_to_facet (term_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
85f636ff-72a0-4c14-9524-1c6175b2769e	\N	\N	\N	\N	\N	5d7acecb-242c-441e-a45d-853e7acc185c
\.


--
-- Data for Name: join_terminology_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.join_terminology_to_facet (terminology_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	\N	\N	\N	\N	\N	\N	4ed7a924-2845-4762-a820-d8a89fbd3cbc
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	\N	0a1e89bb-18b1-4751-bb14-197c198978dd	\N	\N	\N	\N	\N
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	\N	9cd7afc6-cc8d-4d08-9ef3-5ce70bf3342a	\N	\N	\N	\N	\N
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	bdce918d-d092-487c-8b03-87cf2b6fdf90	\N	\N	\N	\N	\N	\N
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	76cf5a69-ba52-45e4-b2ea-8decfc467490	\N	\N	\N	\N	\N	\N
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	\N	\N	\N	\N	\N	688980ce-8e6d-4736-9b44-f2ae900c4c4a	\N
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	\N	\N	\N	\N	\N	e3419eb0-5ea6-4476-8e66-92cd7fc764f8	\N
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	\N	\N	\N	\N	\N	0f7175b7-f5b3-4f38-a9f1-ecad7735b5cc	\N
dc582af4-674a-4569-a59b-2defccfb876f	df6316af-5e81-4ab0-a325-5d11e9dcd11c	\N	\N	\N	\N	\N	\N
dc582af4-674a-4569-a59b-2defccfb876f	\N	\N	\N	\N	\N	aab6d28d-1aa0-432f-bd8b-cce32e9f78c1	\N
dc582af4-674a-4569-a59b-2defccfb876f	\N	\N	\N	\N	\N	a95c3db5-a351-46f2-ac12-ea920bdfd1cf	\N
dc582af4-674a-4569-a59b-2defccfb876f	\N	\N	\N	\N	\N	caaa2be7-0bc2-4c6d-be47-283e693c7b92	\N
\.


--
-- Data for Name: join_termrelationship_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.join_termrelationship_to_facet (termrelationship_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
42799a29-d962-4ced-88d7-fa98f8fda08d	\N	\N	\N	\N	\N	fa557fa1-ecfe-4c1a-8a17-ec459cde85db
\.


--
-- Data for Name: join_termrelationshiptype_to_facet; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.join_termrelationshiptype_to_facet (termrelationshiptype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
bce306a1-2de1-4b20-b74b-26ad75ae2eaf	\N	\N	\N	\N	\N	e9519af7-7119-4a42-ac57-b9d1d4539d29
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.term (id, version, date_created, url, definition, terminology_id, is_parent, code, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
bfa2411d-97c4-44bf-9224-f1f5245c47de	0	2021-05-20 15:35:23.60178	https://google.co.uk	Complex Test Term 00	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT00	2021-05-20 15:35:23.60178	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	1	4518cf0d-a4b6-4629-b19e-6af5a06fecae	2147483647	development@test.com	\N	CTT00: Complex Test Term 00	This is a very important description
04c22cc3-9b6a-4838-9f1f-ddb87da2336f	0	2021-05-20 15:35:23.767935	\N	Complex Test Term 100	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT100	2021-05-20 15:35:23.767935	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	1	b8f0fe55-afa4-4b02-b216-da3165d85de1	2147483647	development@test.com	\N	CTT100: Complex Test Term 100	\N
e2d46641-8b2c-4002-9aeb-8e22ed721a80	0	2021-05-20 15:35:23.768524	\N	CTT101	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT101	2021-05-20 15:35:23.768524	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	1	7f0e5f29-81ff-47d7-b76b-e79f78e434d0	2147483647	development@test.com	\N	CTT101	Example of truncated term label when code and definition are the same
81ce2a3a-647e-40d4-a903-022dafc00926	1	2021-05-20 15:35:23.673659	\N	Complex Test Term 2	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT2	2021-05-20 15:35:24.431625	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	d6a8b61b-9759-4383-bb8d-1d2cfcc217c0	2147483647	development@test.com	\N	CTT2: Complex Test Term 2	\N
887e8bc9-2104-42d2-8528-485b4623c473	1	2021-05-20 15:35:23.675799	\N	Complex Test Term 5	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT5	2021-05-20 15:35:24.434454	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	83f1645a-ea8f-44d1-8fa6-53ec5fa91f57	2147483647	development@test.com	\N	CTT5: Complex Test Term 5	\N
9010bddb-88e0-493c-bbef-ce1b56aad1b4	1	2021-05-20 15:35:23.699709	\N	Complex Test Term 32	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT32	2021-05-20 15:35:24.43505	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	3a4f0e35-4131-49ca-8cb6-13f2ebc31711	2147483647	development@test.com	\N	CTT32: Complex Test Term 32	\N
966c91cd-a2b2-45fe-9172-b32077156666	1	2021-05-20 15:35:23.730582	\N	Complex Test Term 73	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT73	2021-05-20 15:35:24.435586	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	f6a29049-a802-49e6-97eb-8f26f15615cd	2147483647	development@test.com	\N	CTT73: Complex Test Term 73	\N
9a65239d-4685-4cb0-96f6-aaaa3fe8f024	1	2021-05-20 15:35:23.701973	\N	Complex Test Term 36	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT36	2021-05-20 15:35:24.436118	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	660c5e36-b86b-4288-a96b-3939532ce559	2147483647	development@test.com	\N	CTT36: Complex Test Term 36	\N
9da7f89e-0f4f-4407-b2b4-e205fcf7ebf4	1	2021-05-20 15:35:23.688771	\N	Complex Test Term 23	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT23	2021-05-20 15:35:24.436651	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	13cdbba1-35c8-4f4e-94e5-88c80306fb4f	2147483647	development@test.com	\N	CTT23: Complex Test Term 23	\N
9ea09e24-705c-4920-9dba-8ccf39fac00c	1	2021-05-20 15:35:23.711744	\N	Complex Test Term 51	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT51	2021-05-20 15:35:24.437175	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	87ee52f4-091c-46ad-8869-ed1c0ae5545c	2147483647	development@test.com	\N	CTT51: Complex Test Term 51	\N
9ed15988-e1ca-42f7-b61a-9f1cbf1e4289	1	2021-05-20 15:35:23.767341	\N	Complex Test Term 99	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT99	2021-05-20 15:35:24.437705	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	0316f929-a4f9-4c68-8415-cd316a3d29c3	2147483647	development@test.com	\N	CTT99: Complex Test Term 99	\N
9f00cbd1-cb54-4d94-94af-9066868ec2c4	1	2021-05-20 15:35:23.761052	\N	Complex Test Term 90	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT90	2021-05-20 15:35:24.438236	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	9f033007-5ec9-4293-9aa9-6fa184ec4f11	2147483647	development@test.com	\N	CTT90: Complex Test Term 90	\N
a1c2246a-4ec2-4f50-8e2f-606c8c6b6496	1	2021-05-20 15:35:23.675195	\N	Complex Test Term 4	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT4	2021-05-20 15:35:24.438757	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	8abb89c6-8539-435d-b971-6be39072b0ec	2147483647	development@test.com	\N	CTT4: Complex Test Term 4	\N
a42e7a84-8e5f-423e-92ec-2eec5156eac8	1	2021-05-20 15:35:23.70312	\N	Complex Test Term 38	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT38	2021-05-20 15:35:24.439379	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	7790c6db-d50e-4b07-ae22-adb967aa56a5	2147483647	development@test.com	\N	CTT38: Complex Test Term 38	\N
a7b211da-b399-49fd-9f28-cab4194cf015	1	2021-05-20 15:35:23.738358	\N	Complex Test Term 85	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT85	2021-05-20 15:35:24.439962	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	da9f8189-3ded-40eb-9a6c-4a7393d7574f	2147483647	development@test.com	\N	CTT85: Complex Test Term 85	\N
a877238c-25da-498d-b6da-5fdfdc8abb80	1	2021-05-20 15:35:23.716782	\N	Complex Test Term 58	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT58	2021-05-20 15:35:24.440505	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	7c24f97b-0157-4267-8356-4c857f6bdb8e	2147483647	development@test.com	\N	CTT58: Complex Test Term 58	\N
aa15a48d-1f0e-434c-ac2c-f8a3e36d8d37	1	2021-05-20 15:35:23.732385	\N	Complex Test Term 76	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT76	2021-05-20 15:35:24.441043	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	4f5cbb08-f596-465a-9ffb-67a32b3ba0f2	2147483647	development@test.com	\N	CTT76: Complex Test Term 76	\N
ae8fdb84-b5d9-49bb-a81c-6901f6b7d32a	1	2021-05-20 15:35:23.762611	\N	Complex Test Term 92	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT92	2021-05-20 15:35:24.441597	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	7418ad2c-e88e-49c1-9cee-f9dc41e1c839	2147483647	development@test.com	\N	CTT92: Complex Test Term 92	\N
b23215ef-213b-4d54-8f72-616c81bb0cfa	1	2021-05-20 15:35:23.739655	\N	Complex Test Term 87	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT87	2021-05-20 15:35:24.442395	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	ae2a21d2-f773-44d8-858e-eb86207a1904	2147483647	development@test.com	\N	CTT87: Complex Test Term 87	\N
b44284c0-7ed1-4f53-8c7f-9a9f8bd278fa	1	2021-05-20 15:35:23.71501	\N	Complex Test Term 55	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT55	2021-05-20 15:35:24.443	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	9ecab653-7599-48f5-b38b-a474f0fe9b3a	2147483647	development@test.com	\N	CTT55: Complex Test Term 55	\N
b49f7b23-3d75-4d7f-91c3-7cd36378ecd0	1	2021-05-20 15:35:23.716207	\N	Complex Test Term 57	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT57	2021-05-20 15:35:24.443809	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	2d0685a1-c4cf-487e-8e50-4cb61f8b3dd4	2147483647	development@test.com	\N	CTT57: Complex Test Term 57	\N
b6e043e6-aa70-41c0-8a85-bf55986adf32	1	2021-05-20 15:35:23.763419	\N	Complex Test Term 93	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT93	2021-05-20 15:35:24.444829	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	50d1411e-bfc7-48d1-b685-25459b8609ea	2147483647	development@test.com	\N	CTT93: Complex Test Term 93	\N
bbf81fec-09e4-4b93-a7f3-49c6f463d9a2	1	2021-05-20 15:35:23.740227	\N	Complex Test Term 88	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT88	2021-05-20 15:35:24.445514	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	78b85ffa-304b-415a-8111-15fe2d3ae911	2147483647	development@test.com	\N	CTT88: Complex Test Term 88	\N
c39c02c4-5590-4cc4-82bc-98baea435d60	1	2021-05-20 15:35:23.724358	\N	Complex Test Term 65	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT65	2021-05-20 15:35:24.446059	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	10f725d1-83fd-422c-a920-760c9b29b59c	2147483647	development@test.com	\N	CTT65: Complex Test Term 65	\N
c483431b-579b-4e17-9163-8cbc4ac27516	1	2021-05-20 15:35:23.726338	\N	Complex Test Term 68	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT68	2021-05-20 15:35:24.446589	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	19631df1-a17f-4ba8-a5c9-0e1d7e1ce2ad	2147483647	development@test.com	\N	CTT68: Complex Test Term 68	\N
c5fd1676-d7c2-44d4-9eac-7ead6d00256e	1	2021-05-20 15:35:23.709429	\N	Complex Test Term 48	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT48	2021-05-20 15:35:24.447125	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	3e7492b9-8eef-41e1-a13d-9032972fc447	2147483647	development@test.com	\N	CTT48: Complex Test Term 48	\N
c70309d4-1e06-4600-97af-17d1f02c7e5c	1	2021-05-20 15:35:23.70254	\N	Complex Test Term 37	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT37	2021-05-20 15:35:24.447673	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	0b899a54-6b08-43fd-ab4a-6105db8ef00e	2147483647	development@test.com	\N	CTT37: Complex Test Term 37	\N
ccba40ce-a827-43d9-9135-57cb4de1ad68	1	2021-05-20 15:35:23.699126	\N	Complex Test Term 31	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT31	2021-05-20 15:35:24.448199	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	4df175c3-0448-4daa-8fd7-e88cc57cb2ce	2147483647	development@test.com	\N	CTT31: Complex Test Term 31	\N
cfbf199a-442d-4819-91af-5ecf85abab8e	1	2021-05-20 15:35:23.706902	\N	Complex Test Term 44	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT44	2021-05-20 15:35:24.448755	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	079190f8-81be-427f-8180-0874012af93f	2147483647	development@test.com	\N	CTT44: Complex Test Term 44	\N
d82b571d-5a6b-44cc-9c59-fd1f0fa9a223	1	2021-05-20 15:35:23.70557	\N	Complex Test Term 42	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT42	2021-05-20 15:35:24.449284	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	ce43ce0d-7e43-4a25-b86b-908fc39d5e90	2147483647	development@test.com	\N	CTT42: Complex Test Term 42	\N
da64d023-3573-4b2b-9b2b-803836246e9a	1	2021-05-20 15:35:23.708105	\N	Complex Test Term 46	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT46	2021-05-20 15:35:24.449817	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	285077f1-f11d-411b-a8f3-2a18bb295e90	2147483647	development@test.com	\N	CTT46: Complex Test Term 46	\N
dc8d8ddd-510b-44be-a507-d4c0fa670f40	1	2021-05-20 15:35:23.684317	\N	Complex Test Term 16	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT16	2021-05-20 15:35:24.450343	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	8	7c24ba86-964a-4638-b70c-7a6decc56d11	2147483647	development@test.com	\N	CTT16: Complex Test Term 16	\N
dd3deeb9-669d-4b04-95d0-74f47006bc59	1	2021-05-20 15:35:23.735162	\N	Complex Test Term 80	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT80	2021-05-20 15:35:24.455355	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	1401143a-22ea-4298-8c0e-86c3b98b72c6	2147483647	development@test.com	\N	CTT80: Complex Test Term 80	\N
ddce352a-5089-4617-93ea-e3f84c3e8d3b	1	2021-05-20 15:35:23.735901	\N	Complex Test Term 81	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT81	2021-05-20 15:35:24.456467	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	a07714c7-9bcf-4ef4-963a-25d0ebe0b26c	2147483647	development@test.com	\N	CTT81: Complex Test Term 81	\N
de06b170-e802-4e59-a99e-3c9aafad340a	1	2021-05-20 15:35:23.724959	\N	Complex Test Term 66	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT66	2021-05-20 15:35:24.457191	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	397784c1-6cdb-4832-bdd9-034338921130	2147483647	development@test.com	\N	CTT66: Complex Test Term 66	\N
de3364c4-aacf-4a22-b30c-0eb113c33f81	1	2021-05-20 15:35:23.700295	\N	Complex Test Term 33	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT33	2021-05-20 15:35:24.458172	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	0fd9fd10-b428-4d8e-a0bc-05c5bf6406dc	2147483647	development@test.com	\N	CTT33: Complex Test Term 33	\N
e1ddcda9-a224-41c3-9e6d-6f2c805c03a3	1	2021-05-20 15:35:23.681429	\N	Complex Test Term 13	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT13	2021-05-20 15:35:24.458903	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	5	a3012cd1-72d0-4cf3-bb7f-0da5c00d0a32	2147483647	development@test.com	\N	CTT13: Complex Test Term 13	\N
edeeda06-8fee-4cfb-b551-6821f886fee6	1	2021-05-20 15:35:23.676501	\N	Complex Test Term 6	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT6	2021-05-20 15:35:24.459759	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	5c8c3e4d-e968-4fef-99d5-9bf7faa5999c	2147483647	development@test.com	\N	CTT6: Complex Test Term 6	\N
f0bef74c-309d-448f-83ed-5d6a7287434e	1	2021-05-20 15:35:23.706182	\N	Complex Test Term 43	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT43	2021-05-20 15:35:24.460646	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	865f6bfc-66d9-46e5-9c9e-03f6c0ccd836	2147483647	development@test.com	\N	CTT43: Complex Test Term 43	\N
f2ca0183-8b72-41f3-a75e-ab4204d452a5	1	2021-05-20 15:35:23.67914	\N	Complex Test Term 10	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT10	2021-05-20 15:35:24.461309	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	d0fae6ca-2427-4c8a-b19f-5ab4ab90611f	2147483647	development@test.com	\N	CTT10: Complex Test Term 10	\N
f440ddd8-38eb-4e59-818b-37687e279ff9	1	2021-05-20 15:35:23.731238	\N	Complex Test Term 74	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT74	2021-05-20 15:35:24.462029	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	9332004f-791b-435d-854e-8f073a01fa69	2147483647	development@test.com	\N	CTT74: Complex Test Term 74	\N
f79a800e-65c8-4267-805b-a11d97d684c0	1	2021-05-20 15:35:23.691807	\N	Complex Test Term 28	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT28	2021-05-20 15:35:24.46276	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	df74d894-ba76-4201-bdf7-d8588fae8550	2147483647	development@test.com	\N	CTT28: Complex Test Term 28	\N
f7fb2530-31da-4e49-96c5-ca33f5a95948	1	2021-05-20 15:35:23.728966	\N	Complex Test Term 71	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT71	2021-05-20 15:35:24.463858	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	56992ef8-5e48-44ff-a507-a32cb380bcf8	2147483647	development@test.com	\N	CTT71: Complex Test Term 71	\N
f85c9c3a-d739-4995-9534-6ae7ca636f87	1	2021-05-20 15:35:23.689923	\N	Complex Test Term 25	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT25	2021-05-20 15:35:24.46497	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	b2c72d2a-e56e-465d-903f-622d427729a4	2147483647	development@test.com	\N	CTT25: Complex Test Term 25	\N
f99727bf-c9c4-4b72-a3d8-47cc47114623	1	2021-05-20 15:35:23.685095	\N	Complex Test Term 17	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT17	2021-05-20 15:35:24.46582	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	9	950efdcf-2c95-4f1c-8dfd-816a44a76c63	2147483647	development@test.com	\N	CTT17: Complex Test Term 17	\N
fc870e89-1cd8-4f47-85f9-eb3339cf2b48	1	2021-05-20 15:35:23.722575	\N	Complex Test Term 62	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT62	2021-05-20 15:35:24.466779	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	5cedd5d3-9819-4e96-8912-e97a22b36076	2147483647	development@test.com	\N	CTT62: Complex Test Term 62	\N
fd3777b0-521a-46f9-9cf7-4cbdd2cb6006	1	2021-05-20 15:35:23.727501	\N	Complex Test Term 69	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT69	2021-05-20 15:35:24.467741	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	6aa72e76-368f-463c-a522-f47ac4ff3a40	2147483647	development@test.com	\N	CTT69: Complex Test Term 69	\N
fe87dd5a-7817-4f0f-832f-318ba238846e	1	2021-05-20 15:35:23.700856	\N	Complex Test Term 34	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT34	2021-05-20 15:35:24.468464	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	8fa27aa6-98a5-4bba-8aed-d362e9a8ae54	2147483647	development@test.com	\N	CTT34: Complex Test Term 34	\N
00405a22-2e59-48ac-85bf-2fa5cd44cc14	1	2021-05-20 15:35:23.720978	\N	Complex Test Term 60	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT60	2021-05-20 15:35:24.469447	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	802d9320-e3e7-47a9-a824-3eea8f41bcb1	2147483647	development@test.com	\N	CTT60: Complex Test Term 60	\N
0139b193-222d-4bde-8077-2a9ea50dc69b	1	2021-05-20 15:35:23.686982	\N	Complex Test Term 20	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT20	2021-05-20 15:35:24.470237	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	e43cd170-126f-44cb-bd60-aa8cfcc8c2ef	2147483647	development@test.com	\N	CTT20: Complex Test Term 20	\N
07bbdde8-81fc-40f7-915a-b312924d60d0	1	2021-05-20 15:35:23.68934	\N	Complex Test Term 24	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT24	2021-05-20 15:35:24.470969	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	469a2ecb-19fa-4c09-9ab9-dc3f7abbc1b7	2147483647	development@test.com	\N	CTT24: Complex Test Term 24	\N
09568626-94a3-48ca-a9f6-8b3393013fe1	1	2021-05-20 15:35:23.674493	\N	Complex Test Term 3	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT3	2021-05-20 15:35:24.471527	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	28351da6-824b-446e-a6b6-d26b0d622cdc	2147483647	development@test.com	\N	CTT3: Complex Test Term 3	\N
101f1d61-8fc9-4b33-a520-568cf03a2613	1	2021-05-20 15:35:23.765529	\N	Complex Test Term 96	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT96	2021-05-20 15:35:24.472103	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	f176e5f2-99fb-4b1c-a684-c56754569cf4	2147483647	development@test.com	\N	CTT96: Complex Test Term 96	\N
129e31ae-f381-4e2f-ae44-d6cbcb39f7df	1	2021-05-20 15:35:23.733021	\N	Complex Test Term 77	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT77	2021-05-20 15:35:24.472813	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	5f7c37d9-91f5-4832-a02f-f5332d9a0b0a	2147483647	development@test.com	\N	CTT77: Complex Test Term 77	\N
132e194c-377c-48ea-aa60-753b156d4ba6	1	2021-05-20 15:35:23.717442	\N	Complex Test Term 59	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT59	2021-05-20 15:35:24.473798	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	84b79828-91c1-4249-82e9-70d9a86bdda2	2147483647	development@test.com	\N	CTT59: Complex Test Term 59	\N
138e033f-e261-4e6f-a33c-ba2e6c3248af	1	2021-05-20 15:35:23.729742	\N	Complex Test Term 72	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT72	2021-05-20 15:35:24.47479	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	f9dc8897-69c0-4bee-a43e-ade18964b04d	2147483647	development@test.com	\N	CTT72: Complex Test Term 72	\N
13a6ae7d-dede-41f6-9353-aa24fdf9b5a4	1	2021-05-20 15:35:23.714276	\N	Complex Test Term 54	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT54	2021-05-20 15:35:24.475504	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	28ae9533-d81d-4555-b3a9-ddf32dc80511	2147483647	development@test.com	\N	CTT54: Complex Test Term 54	\N
15bf739d-0a84-4bf6-9d75-89fa47b9f929	1	2021-05-20 15:35:23.740791	\N	Complex Test Term 89	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT89	2021-05-20 15:35:24.476027	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	7583e5ec-869f-4323-b41d-bafb299b1ce3	2147483647	development@test.com	\N	CTT89: Complex Test Term 89	\N
15d499ac-3edd-4264-811a-40cabb8b6dce	1	2021-05-20 15:35:23.715628	\N	Complex Test Term 56	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT56	2021-05-20 15:35:24.476574	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	10a0d1b6-8a65-4501-8cc1-285a94c06b7e	2147483647	development@test.com	\N	CTT56: Complex Test Term 56	\N
1654c39e-b5f3-4fc0-abb4-2ed008c5282f	1	2021-05-20 15:35:23.736495	\N	Complex Test Term 82	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT82	2021-05-20 15:35:24.47711	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	a52861c2-4170-42a8-87a8-ba3eb4710118	2147483647	development@test.com	\N	CTT82: Complex Test Term 82	\N
18034212-f5c2-4244-b5dd-fa23e76725d6	1	2021-05-20 15:35:23.679877	\N	Complex Test Term 11	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT11	2021-05-20 15:35:24.477704	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	35cd8351-13d2-4fbb-9bcf-7dca9ef24953	2147483647	development@test.com	\N	CTT11: Complex Test Term 11	\N
1dd60ede-3f14-4e99-a623-a7200426e2e1	1	2021-05-20 15:35:23.76492	\N	Complex Test Term 95	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT95	2021-05-20 15:35:24.478515	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	1fbb972d-ec0e-4aa6-bac1-2dfbee57a95d	2147483647	development@test.com	\N	CTT95: Complex Test Term 95	\N
222cf3cb-bdf6-4f45-a0f0-3123adfb2773	1	2021-05-20 15:35:23.73451	\N	Complex Test Term 79	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT79	2021-05-20 15:35:24.482624	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	c550a7e5-b039-4537-99dc-f4ce930ba92b	2147483647	development@test.com	\N	CTT79: Complex Test Term 79	\N
224f7429-5295-489b-b8af-4998b0593b38	1	2021-05-20 15:35:23.710996	\N	Complex Test Term 50	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT50	2021-05-20 15:35:24.483729	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	d53754b7-fdcc-4477-b969-b9ed05552ecf	2147483647	development@test.com	\N	CTT50: Complex Test Term 50	\N
249afb7d-b556-4a98-9330-491cec9bd772	1	2021-05-20 15:35:23.677877	\N	Complex Test Term 8	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT8	2021-05-20 15:35:24.484392	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	a4bc7ecc-7c40-4794-8f7d-b89b67c3ecbe	2147483647	development@test.com	\N	CTT8: Complex Test Term 8	\N
26f74230-995c-4ae6-b010-7440115002dd	1	2021-05-20 15:35:23.677229	\N	Complex Test Term 7	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT7	2021-05-20 15:35:24.485169	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	57d23a34-9c35-4880-9362-5c471b7389fa	2147483647	development@test.com	\N	CTT7: Complex Test Term 7	\N
27ead685-0ac8-4cae-81d6-b89deafcdd28	1	2021-05-20 15:35:23.766131	\N	Complex Test Term 97	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT97	2021-05-20 15:35:24.485819	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	fbb077ba-aaf6-4e90-b657-e0eaab04a169	2147483647	development@test.com	\N	CTT97: Complex Test Term 97	\N
28d2fb48-49ae-4398-b769-c2889b5348cd	1	2021-05-20 15:35:23.764194	\N	Complex Test Term 94	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT94	2021-05-20 15:35:24.486383	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	9c0a16fb-3488-4f1a-a0e0-841a23622edd	2147483647	development@test.com	\N	CTT94: Complex Test Term 94	\N
2b09c524-e3db-4aa1-80e7-28038f5fc5b2	1	2021-05-20 15:35:23.708706	\N	Complex Test Term 47	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT47	2021-05-20 15:35:24.4869	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	23997534-f827-40f7-8e89-5bed92923fb5	2147483647	development@test.com	\N	CTT47: Complex Test Term 47	\N
30594004-573b-4652-b585-094ee77506f9	1	2021-05-20 15:35:23.710247	\N	Complex Test Term 49	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT49	2021-05-20 15:35:24.487397	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	69646ba0-a153-4889-92c4-73c5229ab542	2147483647	development@test.com	\N	CTT49: Complex Test Term 49	\N
3531b6a3-c1fe-4aa1-8efa-6180dcc1b0ed	1	2021-05-20 15:35:23.766737	\N	Complex Test Term 98	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT98	2021-05-20 15:35:24.487918	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	d19a550b-ccc2-4b27-bbc0-2593fa87ac5a	2147483647	development@test.com	\N	CTT98: Complex Test Term 98	\N
3d731a71-d245-4e17-8baf-8793161982ee	1	2021-05-20 15:35:23.737069	\N	Complex Test Term 83	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT83	2021-05-20 15:35:24.488444	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	46d2269e-f5c0-473c-ae0e-d4eb71863719	2147483647	development@test.com	\N	CTT83: Complex Test Term 83	\N
3d93eca4-93b5-4f31-b923-74e97c60dd7e	1	2021-05-20 15:35:23.68758	\N	Complex Test Term 21	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT21	2021-05-20 15:35:24.488985	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	5340bf06-4833-4f85-bcaa-bb8ce772a98f	2147483647	development@test.com	\N	CTT21: Complex Test Term 21	\N
402fc088-137d-4e1e-8178-876f921bdb3d	1	2021-05-20 15:35:23.728332	\N	Complex Test Term 70	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT70	2021-05-20 15:35:24.48955	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	68f713a4-c02b-4e53-baf0-88c148dbaa03	2147483647	development@test.com	\N	CTT70: Complex Test Term 70	\N
418dac17-dbc8-4496-9570-9d0f16d8fb13	1	2021-05-20 15:35:23.686386	\N	Complex Test Term 19	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT19	2021-05-20 15:35:24.490117	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	11	e3d6bc21-a92d-417e-9e75-75b670bd230a	2147483647	development@test.com	\N	CTT19: Complex Test Term 19	\N
44460eaf-ec29-41cb-9dc0-eefa6c7cc839	1	2021-05-20 15:35:23.690497	\N	Complex Test Term 26	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT26	2021-05-20 15:35:24.490663	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	963c0aea-3a57-4bd2-aa8b-fe28a536f320	2147483647	development@test.com	\N	CTT26: Complex Test Term 26	\N
4477d862-0588-4bc2-852e-67dd32e24a94	1	2021-05-20 15:35:23.703695	\N	Complex Test Term 39	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT39	2021-05-20 15:35:24.491203	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	b221ddc1-614f-4a2c-83a0-fcd1526eccf7	2147483647	development@test.com	\N	CTT39: Complex Test Term 39	\N
45aa7dba-e19e-4602-9dd7-ee4b0b7a69d3	1	2021-05-20 15:35:23.70751	\N	Complex Test Term 45	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT45	2021-05-20 15:35:24.491762	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	c3d2f5e6-8d6f-4151-b4c8-ad1a81d69cf8	2147483647	development@test.com	\N	CTT45: Complex Test Term 45	\N
45c82b1c-67ab-4018-b0a9-087acd671522	1	2021-05-20 15:35:23.725579	\N	Complex Test Term 67	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT67	2021-05-20 15:35:24.492325	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	0d2ad825-520d-49fc-8ef2-2d588b36a7fe	2147483647	development@test.com	\N	CTT67: Complex Test Term 67	\N
4f5942bc-0a6b-4fd1-907a-3be9857829de	1	2021-05-20 15:35:23.723763	\N	Complex Test Term 64	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT64	2021-05-20 15:35:24.492855	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	e239b3ed-c333-4943-814d-c671a3430760	2147483647	development@test.com	\N	CTT64: Complex Test Term 64	\N
54576326-c11d-4436-9354-2d2b430571d8	1	2021-05-20 15:35:23.67855	\N	Complex Test Term 9	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT9	2021-05-20 15:35:24.493453	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	8271c203-896e-499b-8adf-b9720217c84d	2147483647	development@test.com	\N	CTT9: Complex Test Term 9	\N
57ad05d4-b529-4958-9cc8-2feedbea2753	1	2021-05-20 15:35:23.721899	\N	Complex Test Term 61	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT61	2021-05-20 15:35:24.49401	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	7e47485f-752d-4386-ab07-cbdee4d7fdb1	2147483647	development@test.com	\N	CTT61: Complex Test Term 61	\N
5cd40598-a8bd-48d7-9003-e3513c7b3f6b	1	2021-05-20 15:35:23.698193	\N	Complex Test Term 30	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT30	2021-05-20 15:35:24.494568	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	d5c3ea2f-1659-4d96-a93f-52676b9fef85	2147483647	development@test.com	\N	CTT30: Complex Test Term 30	\N
5da8046a-c396-42b1-95c7-70f97258ecaf	1	2021-05-20 15:35:23.685761	\N	Complex Test Term 18	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT18	2021-05-20 15:35:24.495069	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	10	1b4423cd-a0c0-4094-b2df-7f00a3f17174	2147483647	development@test.com	\N	CTT18: Complex Test Term 18	\N
653a93b2-8882-4b64-bf00-9faee1db357a	1	2021-05-20 15:35:23.701417	\N	Complex Test Term 35	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT35	2021-05-20 15:35:24.495572	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	95820a9b-01c4-44b4-a2b2-06145a9a81ad	2147483647	development@test.com	\N	CTT35: Complex Test Term 35	\N
659a2fbc-3a09-4f92-a166-52121ae15001	1	2021-05-20 15:35:23.731808	\N	Complex Test Term 75	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT75	2021-05-20 15:35:24.496103	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	acf1fd3f-3fbe-4e1a-80aa-aa803621f360	2147483647	development@test.com	\N	CTT75: Complex Test Term 75	\N
66a5991d-dca7-44d3-8140-9944dfc4497d	1	2021-05-20 15:35:23.723175	\N	Complex Test Term 63	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT63	2021-05-20 15:35:24.496649	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	0ed41d3b-91e7-4aa2-a3d6-fc4fe6c99c46	2147483647	development@test.com	\N	CTT63: Complex Test Term 63	\N
673f6435-1147-48d8-9f30-0036c4f12df0	1	2021-05-20 15:35:23.733695	\N	Complex Test Term 78	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT78	2021-05-20 15:35:24.497313	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	2d8c3999-923d-4500-b99d-9a921dfef44b	2147483647	development@test.com	\N	CTT78: Complex Test Term 78	\N
69bd2789-97a6-43a5-9adc-bf6e783c8217	1	2021-05-20 15:35:23.688176	\N	Complex Test Term 22	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT22	2021-05-20 15:35:24.49801	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	deaa3af4-cafa-4892-9b61-18cc9540d245	2147483647	development@test.com	\N	CTT22: Complex Test Term 22	\N
6a01d8b9-e446-477c-bb5d-94f8ac4a53dc	1	2021-05-20 15:35:23.691201	\N	Complex Test Term 27	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT27	2021-05-20 15:35:24.498707	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	e53b26a7-d85a-4c1b-aaf2-ef3e4f48181e	2147483647	development@test.com	\N	CTT27: Complex Test Term 27	\N
6c013905-0c1b-47a5-8ac4-9db79a5bde9e	1	2021-05-20 15:35:23.762028	\N	Complex Test Term 91	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT91	2021-05-20 15:35:24.4993	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	e9779223-5333-495a-a05b-5de14bfad625	2147483647	development@test.com	\N	CTT91: Complex Test Term 91	\N
6c0d0b48-61af-4e44-b5e5-1b03fcfd80e1	1	2021-05-20 15:35:23.737716	\N	Complex Test Term 84	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT84	2021-05-20 15:35:24.49985	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	32506d30-1525-4ac0-914e-7b265f9ef24e	2147483647	development@test.com	\N	CTT84: Complex Test Term 84	\N
708f794d-56a9-4ef2-81f3-f7cd163201e9	1	2021-05-20 15:35:23.680636	\N	Complex Test Term 12	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT12	2021-05-20 15:35:24.504484	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	4	7777d38f-adfd-4360-8896-c08877c68719	2147483647	development@test.com	\N	CTT12: Complex Test Term 12	\N
73e0323a-c8da-4d14-9ba0-af6978425e72	1	2021-05-20 15:35:23.739039	\N	Complex Test Term 86	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT86	2021-05-20 15:35:24.505337	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	8dc9d4c8-c98d-4c64-ad92-363b4c0b2404	2147483647	development@test.com	\N	CTT86: Complex Test Term 86	\N
75015253-c01b-47a1-91b8-75296d504076	1	2021-05-20 15:35:23.704943	\N	Complex Test Term 41	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT41	2021-05-20 15:35:24.505868	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	a5ea57a9-ed71-4924-8fe3-a43c28138ac6	2147483647	development@test.com	\N	CTT41: Complex Test Term 41	\N
78f5b327-befc-4b99-876e-c61f919ceb67	1	2021-05-20 15:35:23.692392	\N	Complex Test Term 29	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT29	2021-05-20 15:35:24.506395	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	cbb53b06-d34c-4280-8b8d-8ed037bf6477	2147483647	development@test.com	\N	CTT29: Complex Test Term 29	\N
79be971d-7827-430d-9e03-8089f890f00a	1	2021-05-20 15:35:23.713105	\N	Complex Test Term 53	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT53	2021-05-20 15:35:24.506994	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	e4bbe818-41d1-4ad7-b2e6-9cd6ef29a353	2147483647	development@test.com	\N	CTT53: Complex Test Term 53	\N
7db966c7-cde8-411e-898f-77753e51399e	1	2021-05-20 15:35:23.712403	\N	Complex Test Term 52	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT52	2021-05-20 15:35:24.507513	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	3	dec5bcd0-6aa3-47e2-b0ef-b0e8138a9854	2147483647	development@test.com	\N	CTT52: Complex Test Term 52	\N
7e31a14f-5339-40f5-9cf5-3a9e540f0600	1	2021-05-20 15:35:23.683166	\N	Complex Test Term 15	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT15	2021-05-20 15:35:24.508013	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	7	4432285a-eb88-4958-a9e4-a4f07762de89	2147483647	development@test.com	\N	CTT15: Complex Test Term 15	\N
7e56219c-fc40-4717-85d8-c73e24fdf463	1	2021-05-20 15:35:23.704293	\N	Complex Test Term 40	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT40	2021-05-20 15:35:24.508571	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	977260ad-bd41-4729-b75d-49ee7b08f5b9	2147483647	development@test.com	\N	CTT40: Complex Test Term 40	\N
7e91ccae-41d4-415e-92ee-50387659f2e5	1	2021-05-20 15:35:23.682185	\N	Complex Test Term 14	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT14	2021-05-20 15:35:24.509098	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	6	e507dac2-53b3-4768-b68f-8bebcd0225f0	2147483647	development@test.com	\N	CTT14: Complex Test Term 14	\N
85f636ff-72a0-4c14-9524-1c6175b2769e	2	2021-05-20 15:35:23.672474	\N	Complex Test Term 1	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	f	CTT1	2021-05-20 15:35:24.945668	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	605ec1cf-1948-4137-a8a4-7bd7e73f841a	2147483647	development@test.com	\N	CTT1: Complex Test Term 1	\N
6200b0e0-5c9a-4951-ae06-cfbc34476ba9	0	2021-05-20 15:35:25.098858	\N	Simple Test Term 01	dc582af4-674a-4569-a59b-2defccfb876f	f	STT01	2021-05-20 15:35:25.098858	/dc582af4-674a-4569-a59b-2defccfb876f	1	ab6cea42-1128-4074-821a-c33ca071a5c1	2147483647	development@test.com	\N	STT01: Simple Test Term 01	\N
0346e1c7-7d1c-4c83-838c-36518da14dd4	0	2021-05-20 15:35:25.100035	\N	Simple Test Term 02	dc582af4-674a-4569-a59b-2defccfb876f	f	STT02	2021-05-20 15:35:25.100035	/dc582af4-674a-4569-a59b-2defccfb876f	1	e42cee7a-480f-4edc-bcbf-4afe56a556eb	2147483647	development@test.com	\N	STT02: Simple Test Term 02	\N
\.


--
-- Data for Name: term_relationship; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.term_relationship (id, version, date_created, target_term_id, relationship_type_id, last_updated, path, depth, source_term_id, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
f7235094-b072-483f-a7ec-c48761b71cd8	0	2021-05-20 15:35:23.771635	85f636ff-72a0-4c14-9524-1c6175b2769e	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	2021-05-20 15:35:23.771635	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/81ce2a3a-647e-40d4-a903-022dafc00926	2	81ce2a3a-647e-40d4-a903-022dafc00926	64391eef-cc47-4573-a940-2958715cb70d	2147483647	development@test.com	\N	narrowerThan	\N
9b49e60d-fc13-49fc-b9db-262085fb8222	0	2021-05-20 15:35:23.772337	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.772337	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/81ce2a3a-647e-40d4-a903-022dafc00926	2	81ce2a3a-647e-40d4-a903-022dafc00926	64622060-e221-47b6-84b3-b7234a54db17	2147483647	development@test.com	\N	is-a-part-of	\N
9871d3d7-6321-488c-bf63-0bd65f1631bb	0	2021-05-20 15:35:23.772919	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.772919	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/09568626-94a3-48ca-a9f6-8b3393013fe1	2	09568626-94a3-48ca-a9f6-8b3393013fe1	345541a7-8af9-47f8-aa5f-1c8cd39c988f	2147483647	development@test.com	\N	is-a-part-of	\N
f0aca16f-8ecd-447b-a86c-3e8d544241d4	0	2021-05-20 15:35:23.77345	81ce2a3a-647e-40d4-a903-022dafc00926	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	2021-05-20 15:35:23.77345	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/09568626-94a3-48ca-a9f6-8b3393013fe1	2	09568626-94a3-48ca-a9f6-8b3393013fe1	326bfebd-db6c-404e-87b8-a11398f17155	2147483647	development@test.com	\N	narrowerThan	\N
fc2f49e6-c35b-447f-9c67-cd0f6b66b38c	0	2021-05-20 15:35:23.774014	09568626-94a3-48ca-a9f6-8b3393013fe1	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	2021-05-20 15:35:23.774014	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/a1c2246a-4ec2-4f50-8e2f-606c8c6b6496	2	a1c2246a-4ec2-4f50-8e2f-606c8c6b6496	271bb492-2c96-4889-aa4a-2cbbe3507b66	2147483647	development@test.com	\N	narrowerThan	\N
ce7ae17d-b647-46cc-b9b9-28649dbdaff4	0	2021-05-20 15:35:23.774568	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.774568	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/a1c2246a-4ec2-4f50-8e2f-606c8c6b6496	2	a1c2246a-4ec2-4f50-8e2f-606c8c6b6496	975bf000-30e0-4a42-9336-c2e1908c9e93	2147483647	development@test.com	\N	is-a-part-of	\N
e532061d-7f43-465b-a642-8a4149ec0315	0	2021-05-20 15:35:23.775118	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.775118	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/887e8bc9-2104-42d2-8528-485b4623c473	2	887e8bc9-2104-42d2-8528-485b4623c473	0bea60ee-47c3-47d8-ad16-b982ed0514ab	2147483647	development@test.com	\N	is-a-part-of	\N
59c5ae2c-2e7c-4e4d-a2f8-71d753f83700	0	2021-05-20 15:35:23.775673	a1c2246a-4ec2-4f50-8e2f-606c8c6b6496	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	2021-05-20 15:35:23.775673	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/887e8bc9-2104-42d2-8528-485b4623c473	2	887e8bc9-2104-42d2-8528-485b4623c473	bbd28b39-0263-479e-9b02-265d09dd588e	2147483647	development@test.com	\N	narrowerThan	\N
517c0269-cf62-48e2-936e-fd5e2530c5eb	0	2021-05-20 15:35:23.776255	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.776255	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/edeeda06-8fee-4cfb-b551-6821f886fee6	2	edeeda06-8fee-4cfb-b551-6821f886fee6	797d3dbd-55f2-42bd-9334-973f8f85915b	2147483647	development@test.com	\N	is-a-part-of	\N
b7beb439-6cf8-4794-a656-00b53171f729	0	2021-05-20 15:35:23.776867	887e8bc9-2104-42d2-8528-485b4623c473	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	2021-05-20 15:35:23.776867	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/edeeda06-8fee-4cfb-b551-6821f886fee6	2	edeeda06-8fee-4cfb-b551-6821f886fee6	5a11c2a7-57b0-4149-ac0e-403da85e0497	2147483647	development@test.com	\N	narrowerThan	\N
dadfa7e2-8eb3-40f2-ac7c-d3eae711f432	0	2021-05-20 15:35:23.777681	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.777681	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/26f74230-995c-4ae6-b010-7440115002dd	2	26f74230-995c-4ae6-b010-7440115002dd	d19f5800-cfeb-45bb-83a3-373751dd27a4	2147483647	development@test.com	\N	is-a-part-of	\N
de83a5a1-be59-4712-b8a1-79147904200f	0	2021-05-20 15:35:23.778694	edeeda06-8fee-4cfb-b551-6821f886fee6	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	2021-05-20 15:35:23.778694	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/26f74230-995c-4ae6-b010-7440115002dd	2	26f74230-995c-4ae6-b010-7440115002dd	99189f15-8569-4fb2-aaf6-01cbd1352311	2147483647	development@test.com	\N	narrowerThan	\N
cadec1f6-e047-46c9-a854-d6f1b45d87f6	0	2021-05-20 15:35:23.779403	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.779403	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/249afb7d-b556-4a98-9330-491cec9bd772	2	249afb7d-b556-4a98-9330-491cec9bd772	c0ec3807-ad6d-4a58-a05b-950d3f22b49d	2147483647	development@test.com	\N	is-a-part-of	\N
3db528e6-69b0-4b71-8312-57e2f8b2f107	0	2021-05-20 15:35:23.780085	26f74230-995c-4ae6-b010-7440115002dd	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	2021-05-20 15:35:23.780085	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/249afb7d-b556-4a98-9330-491cec9bd772	2	249afb7d-b556-4a98-9330-491cec9bd772	ed8726c2-2580-4915-b036-31606947d6b1	2147483647	development@test.com	\N	narrowerThan	\N
3b0d6642-edd8-4053-90fb-59e585b72e51	0	2021-05-20 15:35:23.780683	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.780683	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/54576326-c11d-4436-9354-2d2b430571d8	2	54576326-c11d-4436-9354-2d2b430571d8	aebc0847-f052-458e-98af-65df369aa735	2147483647	development@test.com	\N	is-a-part-of	\N
4704048c-20c7-49d5-b905-490e691f06fd	0	2021-05-20 15:35:23.781577	249afb7d-b556-4a98-9330-491cec9bd772	bce306a1-2de1-4b20-b74b-26ad75ae2eaf	2021-05-20 15:35:23.781577	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/54576326-c11d-4436-9354-2d2b430571d8	2	54576326-c11d-4436-9354-2d2b430571d8	db7b8f3d-84ff-4db6-ab33-42e8ff05b66b	2147483647	development@test.com	\N	narrowerThan	\N
2b705546-b539-435d-9d91-3f0f13c87d64	0	2021-05-20 15:35:23.782142	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.782142	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/f2ca0183-8b72-41f3-a75e-ab4204d452a5	2	f2ca0183-8b72-41f3-a75e-ab4204d452a5	01a77b47-7f65-4501-b65a-e68415e6605c	2147483647	development@test.com	\N	is-a-part-of	\N
94c993be-a3d9-4df2-b916-806336606832	0	2021-05-20 15:35:23.782683	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.782683	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/18034212-f5c2-4244-b5dd-fa23e76725d6	2	18034212-f5c2-4244-b5dd-fa23e76725d6	0c452fbd-b702-4cce-9b18-7a7bdabc3535	2147483647	development@test.com	\N	is-a-part-of	\N
1ad1ffea-e00c-4787-9fd7-3378791ac594	0	2021-05-20 15:35:23.783227	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.783227	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/708f794d-56a9-4ef2-81f3-f7cd163201e9	2	708f794d-56a9-4ef2-81f3-f7cd163201e9	69630f02-7e3d-4ffe-8e8c-f9f382677df6	2147483647	development@test.com	\N	is-a-part-of	\N
91dce2a0-2d33-4a01-999e-ccb8ce7dd744	0	2021-05-20 15:35:23.783769	708f794d-56a9-4ef2-81f3-f7cd163201e9	c4960220-4d94-4c75-bd17-a46b1415bbf6	2021-05-20 15:35:23.783769	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/18034212-f5c2-4244-b5dd-fa23e76725d6	2	18034212-f5c2-4244-b5dd-fa23e76725d6	5761d26c-c270-475b-a228-98bd90b960ea	2147483647	development@test.com	\N	broaderThan	\N
d8f8ecb8-3d5f-4acd-8261-c5f3e44281f6	0	2021-05-20 15:35:23.784234	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.784234	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/e1ddcda9-a224-41c3-9e6d-6f2c805c03a3	2	e1ddcda9-a224-41c3-9e6d-6f2c805c03a3	01242bf7-012d-40c3-b557-5b5e3e614c5c	2147483647	development@test.com	\N	is-a-part-of	\N
3c425b3b-cbfb-4c8e-98ee-f407455b69be	0	2021-05-20 15:35:23.78478	e1ddcda9-a224-41c3-9e6d-6f2c805c03a3	c4960220-4d94-4c75-bd17-a46b1415bbf6	2021-05-20 15:35:23.78478	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/708f794d-56a9-4ef2-81f3-f7cd163201e9	2	708f794d-56a9-4ef2-81f3-f7cd163201e9	00438f6f-05a4-4639-a36f-f946e380fe6a	2147483647	development@test.com	\N	broaderThan	\N
aec3803f-7bd1-4522-878b-dd919e5fb9bb	0	2021-05-20 15:35:23.785235	7e91ccae-41d4-415e-92ee-50387659f2e5	c4960220-4d94-4c75-bd17-a46b1415bbf6	2021-05-20 15:35:23.785235	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/e1ddcda9-a224-41c3-9e6d-6f2c805c03a3	2	e1ddcda9-a224-41c3-9e6d-6f2c805c03a3	44ac90a6-7d5d-484d-b72d-19dd245a4647	2147483647	development@test.com	\N	broaderThan	\N
34be82e2-f6d5-4f25-91ed-c81b66d0c8e0	0	2021-05-20 15:35:23.785739	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.785739	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/7e91ccae-41d4-415e-92ee-50387659f2e5	2	7e91ccae-41d4-415e-92ee-50387659f2e5	a17bc3d8-a868-4737-b334-1ad0749ff60c	2147483647	development@test.com	\N	is-a-part-of	\N
e54ca461-ba3a-4821-b51d-18c07bd60fcd	0	2021-05-20 15:35:23.786293	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.786293	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/7e31a14f-5339-40f5-9cf5-3a9e540f0600	2	7e31a14f-5339-40f5-9cf5-3a9e540f0600	63df27bb-9157-4c81-b55e-5b9ce9cea40f	2147483647	development@test.com	\N	is-a-part-of	\N
975b4784-9523-4347-aed5-6b41375b2462	0	2021-05-20 15:35:23.786889	7e31a14f-5339-40f5-9cf5-3a9e540f0600	c4960220-4d94-4c75-bd17-a46b1415bbf6	2021-05-20 15:35:23.786889	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/7e91ccae-41d4-415e-92ee-50387659f2e5	2	7e91ccae-41d4-415e-92ee-50387659f2e5	5a0f58e0-13f6-409e-823d-7a5ac5753a60	2147483647	development@test.com	\N	broaderThan	\N
4415f41b-9dd0-43a7-b464-9be29d86e6c6	0	2021-05-20 15:35:23.787374	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.787374	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/dc8d8ddd-510b-44be-a507-d4c0fa670f40	2	dc8d8ddd-510b-44be-a507-d4c0fa670f40	2e0d76dd-e79d-41c5-aeca-06206d23a845	2147483647	development@test.com	\N	is-a-part-of	\N
e2c7b2fd-3677-44d8-802f-34702b5cd1f7	0	2021-05-20 15:35:23.787917	dc8d8ddd-510b-44be-a507-d4c0fa670f40	c4960220-4d94-4c75-bd17-a46b1415bbf6	2021-05-20 15:35:23.787917	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/7e31a14f-5339-40f5-9cf5-3a9e540f0600	2	7e31a14f-5339-40f5-9cf5-3a9e540f0600	8b1deef1-998d-46e4-a062-fcbdda58dac2	2147483647	development@test.com	\N	broaderThan	\N
ab88e6ed-4371-4a2c-86a4-30488061e919	0	2021-05-20 15:35:23.788372	f99727bf-c9c4-4b72-a3d8-47cc47114623	c4960220-4d94-4c75-bd17-a46b1415bbf6	2021-05-20 15:35:23.788372	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/dc8d8ddd-510b-44be-a507-d4c0fa670f40	2	dc8d8ddd-510b-44be-a507-d4c0fa670f40	3bc1fed9-70bc-43e0-b3ff-6a0a360fcb5a	2147483647	development@test.com	\N	broaderThan	\N
f7df059e-30bd-409a-9e4e-29ebf2cf27cd	0	2021-05-20 15:35:23.797531	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.797531	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/f99727bf-c9c4-4b72-a3d8-47cc47114623	2	f99727bf-c9c4-4b72-a3d8-47cc47114623	e506cd3e-5558-4a21-b042-cb15fc7a0b30	2147483647	development@test.com	\N	is-a-part-of	\N
54375d7c-513c-4d3f-9d8a-d032c8649be1	0	2021-05-20 15:35:23.798352	5da8046a-c396-42b1-95c7-70f97258ecaf	c4960220-4d94-4c75-bd17-a46b1415bbf6	2021-05-20 15:35:23.798352	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/f99727bf-c9c4-4b72-a3d8-47cc47114623	2	f99727bf-c9c4-4b72-a3d8-47cc47114623	ff565e6e-c6bf-48e3-bcda-6b5a7a199cdf	2147483647	development@test.com	\N	broaderThan	\N
91bf82ba-4b1f-4990-86f0-3ddd19f826fd	0	2021-05-20 15:35:23.798821	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.798821	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/5da8046a-c396-42b1-95c7-70f97258ecaf	2	5da8046a-c396-42b1-95c7-70f97258ecaf	0c0d127a-5f32-4c49-82f6-ef927d5041fa	2147483647	development@test.com	\N	is-a-part-of	\N
0cb75211-d5b9-4d94-b5c7-51efccc33545	0	2021-05-20 15:35:23.79936	f2ca0183-8b72-41f3-a75e-ab4204d452a5	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.79936	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/418dac17-dbc8-4496-9570-9d0f16d8fb13	2	418dac17-dbc8-4496-9570-9d0f16d8fb13	ed41d342-9a77-49a6-9db1-7c8d8d5d7a31	2147483647	development@test.com	\N	is-a-part-of	\N
cac46786-67fb-4ebd-9605-f5652bc6723e	0	2021-05-20 15:35:23.799894	418dac17-dbc8-4496-9570-9d0f16d8fb13	c4960220-4d94-4c75-bd17-a46b1415bbf6	2021-05-20 15:35:23.799894	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/5da8046a-c396-42b1-95c7-70f97258ecaf	2	5da8046a-c396-42b1-95c7-70f97258ecaf	a1d7590d-548d-4b59-a20b-f031bffdbb09	2147483647	development@test.com	\N	broaderThan	\N
645d7e4a-d023-4217-8ebd-6391b0b5ef37	0	2021-05-20 15:35:23.80035	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.80035	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/0139b193-222d-4bde-8077-2a9ea50dc69b	2	0139b193-222d-4bde-8077-2a9ea50dc69b	ed8e5039-3fc9-4461-b614-f3c3b145abfc	2147483647	development@test.com	\N	is-a-part-of	\N
58c1a39d-4df7-43ee-b093-cde71a9cebc7	0	2021-05-20 15:35:23.800896	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.800896	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/3d93eca4-93b5-4f31-b923-74e97c60dd7e	2	3d93eca4-93b5-4f31-b923-74e97c60dd7e	cb55b6e9-a2b0-4ffa-9eb4-c6831a6da6ba	2147483647	development@test.com	\N	is-a-part-of	\N
85f0c71f-00d9-4b0d-bd11-7bbc8390033b	0	2021-05-20 15:35:23.801465	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.801465	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/69bd2789-97a6-43a5-9adc-bf6e783c8217	2	69bd2789-97a6-43a5-9adc-bf6e783c8217	68273980-9f78-4e04-b671-895296ee62d0	2147483647	development@test.com	\N	is-a-part-of	\N
89f3eb60-1cf2-42d0-b043-eee706c5f8de	0	2021-05-20 15:35:23.802049	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.802049	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/9da7f89e-0f4f-4407-b2b4-e205fcf7ebf4	2	9da7f89e-0f4f-4407-b2b4-e205fcf7ebf4	23440f71-d763-4efa-aa6f-a1c4fed204d6	2147483647	development@test.com	\N	is-a-part-of	\N
29ac10b5-b3a7-4fee-b85e-1b8b1ea92ca8	0	2021-05-20 15:35:23.802894	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.802894	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/07bbdde8-81fc-40f7-915a-b312924d60d0	2	07bbdde8-81fc-40f7-915a-b312924d60d0	64e84c36-b8b1-46d9-a43b-7557df117f39	2147483647	development@test.com	\N	is-a-part-of	\N
aeb68b64-ea34-4fac-a92a-c251719f8ea4	0	2021-05-20 15:35:23.803616	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.803616	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/f85c9c3a-d739-4995-9534-6ae7ca636f87	2	f85c9c3a-d739-4995-9534-6ae7ca636f87	02542414-9d95-4693-9633-5433f95ddb5b	2147483647	development@test.com	\N	is-a-part-of	\N
e3d6f965-e5a6-4c9f-8715-afd83bfc6fc7	0	2021-05-20 15:35:23.804354	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.804354	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/44460eaf-ec29-41cb-9dc0-eefa6c7cc839	2	44460eaf-ec29-41cb-9dc0-eefa6c7cc839	96922b3b-0aa1-439d-b926-7919245e4396	2147483647	development@test.com	\N	is-a-part-of	\N
0e41f342-a010-4147-bcba-43010810216d	0	2021-05-20 15:35:23.804984	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.804984	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/6a01d8b9-e446-477c-bb5d-94f8ac4a53dc	2	6a01d8b9-e446-477c-bb5d-94f8ac4a53dc	746b6dd0-5992-4c40-8ae5-ed4cf54ef85f	2147483647	development@test.com	\N	is-a-part-of	\N
0aad28f6-f721-4de8-a504-ca258ae00d4b	0	2021-05-20 15:35:23.805817	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.805817	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/f79a800e-65c8-4267-805b-a11d97d684c0	2	f79a800e-65c8-4267-805b-a11d97d684c0	9dc74045-06c7-4934-8847-e9e3d0d9da23	2147483647	development@test.com	\N	is-a-part-of	\N
1b154790-020f-49f8-9f95-0aad623fba52	0	2021-05-20 15:35:23.806428	0139b193-222d-4bde-8077-2a9ea50dc69b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.806428	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/78f5b327-befc-4b99-876e-c61f919ceb67	2	78f5b327-befc-4b99-876e-c61f919ceb67	0831c0a9-2432-4fa6-8d3b-a537cb8c3980	2147483647	development@test.com	\N	is-a-part-of	\N
3e133c10-3e2e-497a-8745-9f2ce28db697	0	2021-05-20 15:35:23.807086	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.807086	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/5cd40598-a8bd-48d7-9003-e3513c7b3f6b	2	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	ed50049e-5188-4ecd-b073-fd9fac359cfb	2147483647	development@test.com	\N	is-a-part-of	\N
5c2e7be4-b597-4582-a859-f524dd154616	0	2021-05-20 15:35:23.807677	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.807677	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/ccba40ce-a827-43d9-9135-57cb4de1ad68	2	ccba40ce-a827-43d9-9135-57cb4de1ad68	4bfc69ad-4d19-43e1-9abe-c3f48cd88351	2147483647	development@test.com	\N	is-a-part-of	\N
4489cfe3-4b9c-423f-adcf-7808eb99ca2e	0	2021-05-20 15:35:23.808228	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.808228	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/9010bddb-88e0-493c-bbef-ce1b56aad1b4	2	9010bddb-88e0-493c-bbef-ce1b56aad1b4	48063e33-d127-49fc-ae39-f990ccdb947f	2147483647	development@test.com	\N	is-a-part-of	\N
eb44f0c1-e31a-4fc3-8f3c-ad8fc2b53294	0	2021-05-20 15:35:23.808774	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.808774	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/de3364c4-aacf-4a22-b30c-0eb113c33f81	2	de3364c4-aacf-4a22-b30c-0eb113c33f81	bd3095f0-ebe6-47d1-8a1c-13474f835c9f	2147483647	development@test.com	\N	is-a-part-of	\N
ff0bf30f-3830-4494-8c83-43574a8d6aad	0	2021-05-20 15:35:23.80932	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.80932	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/fe87dd5a-7817-4f0f-832f-318ba238846e	2	fe87dd5a-7817-4f0f-832f-318ba238846e	793af870-4a2b-4bdd-a1f2-888ceba22eb3	2147483647	development@test.com	\N	is-a-part-of	\N
97fa8417-c83f-4e1d-ac33-06888cad6f1d	0	2021-05-20 15:35:23.810044	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.810044	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/653a93b2-8882-4b64-bf00-9faee1db357a	2	653a93b2-8882-4b64-bf00-9faee1db357a	9b67c488-174d-40ae-9e74-9596d1d64b7c	2147483647	development@test.com	\N	is-a-part-of	\N
0e5b8afd-8355-46e9-be4b-f94dc251ef8d	0	2021-05-20 15:35:23.811103	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.811103	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/9a65239d-4685-4cb0-96f6-aaaa3fe8f024	2	9a65239d-4685-4cb0-96f6-aaaa3fe8f024	99fb4f29-6d43-4ac9-a4a3-3e4bbc21fdee	2147483647	development@test.com	\N	is-a-part-of	\N
af7b10cb-8691-4605-a505-c15ac22e43c1	0	2021-05-20 15:35:23.811939	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.811939	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/c70309d4-1e06-4600-97af-17d1f02c7e5c	2	c70309d4-1e06-4600-97af-17d1f02c7e5c	43869643-cad3-4403-b644-a4d0704132a1	2147483647	development@test.com	\N	is-a-part-of	\N
4b52cedc-5b0b-4f14-866f-2ebf94ce589c	0	2021-05-20 15:35:23.81255	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.81255	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/a42e7a84-8e5f-423e-92ec-2eec5156eac8	2	a42e7a84-8e5f-423e-92ec-2eec5156eac8	8c82657a-fc06-49e6-ad81-4284827534e2	2147483647	development@test.com	\N	is-a-part-of	\N
9317b700-6104-4bb4-bd3c-bcd43909566b	0	2021-05-20 15:35:23.81335	5cd40598-a8bd-48d7-9003-e3513c7b3f6b	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.81335	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/4477d862-0588-4bc2-852e-67dd32e24a94	2	4477d862-0588-4bc2-852e-67dd32e24a94	87b81b91-0dc2-4189-9fd5-ca91ae8579d2	2147483647	development@test.com	\N	is-a-part-of	\N
1f5eb2db-fdea-40dd-94a9-205cfd692daf	0	2021-05-20 15:35:23.814042	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.814042	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/7e56219c-fc40-4717-85d8-c73e24fdf463	2	7e56219c-fc40-4717-85d8-c73e24fdf463	70002f26-08a3-4ecf-8ebf-dd1b8668e834	2147483647	development@test.com	\N	is-a-part-of	\N
544f4d4a-e102-48de-b65a-8e21c5f6c18e	0	2021-05-20 15:35:23.814679	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.814679	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/75015253-c01b-47a1-91b8-75296d504076	2	75015253-c01b-47a1-91b8-75296d504076	87ae15bd-e599-4098-b4d2-7fcf824076be	2147483647	development@test.com	\N	is-a-part-of	\N
548cebca-9219-4396-97cb-be39d77827a2	0	2021-05-20 15:35:23.815569	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.815569	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/d82b571d-5a6b-44cc-9c59-fd1f0fa9a223	2	d82b571d-5a6b-44cc-9c59-fd1f0fa9a223	f87a5bbb-10fd-414d-aaf5-958f77db9ea3	2147483647	development@test.com	\N	is-a-part-of	\N
9bb861d6-8411-4e31-a87b-625b73f75bc9	0	2021-05-20 15:35:23.816308	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.816308	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/f0bef74c-309d-448f-83ed-5d6a7287434e	2	f0bef74c-309d-448f-83ed-5d6a7287434e	fe79753f-8b17-4524-89db-f15d2a0cbcab	2147483647	development@test.com	\N	is-a-part-of	\N
e130763f-fdf3-43ac-9328-0a0d018066e0	0	2021-05-20 15:35:23.816881	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.816881	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/cfbf199a-442d-4819-91af-5ecf85abab8e	2	cfbf199a-442d-4819-91af-5ecf85abab8e	9d0041c1-c9f8-44fa-9166-91afc669602a	2147483647	development@test.com	\N	is-a-part-of	\N
b93699b9-802b-4eff-8bcb-8a28b29bfb68	0	2021-05-20 15:35:23.821312	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.821312	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/45aa7dba-e19e-4602-9dd7-ee4b0b7a69d3	2	45aa7dba-e19e-4602-9dd7-ee4b0b7a69d3	9e428dca-ef09-4ea1-b415-5f95619cea63	2147483647	development@test.com	\N	is-a-part-of	\N
d4faf174-f904-4bd5-8e98-66976ea09ec5	0	2021-05-20 15:35:23.82219	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.82219	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/da64d023-3573-4b2b-9b2b-803836246e9a	2	da64d023-3573-4b2b-9b2b-803836246e9a	2c9b5520-1a6d-4eee-ab5f-63f0cbd91ef1	2147483647	development@test.com	\N	is-a-part-of	\N
983a8684-1336-41bd-960f-1aab36b0cee4	0	2021-05-20 15:35:23.822838	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.822838	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/2b09c524-e3db-4aa1-80e7-28038f5fc5b2	2	2b09c524-e3db-4aa1-80e7-28038f5fc5b2	1cb12b94-c2cf-4bc5-b87a-8a80787d98ab	2147483647	development@test.com	\N	is-a-part-of	\N
7da0e12c-5aa7-46a4-8a13-3d341b88c35b	0	2021-05-20 15:35:23.823416	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.823416	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/c5fd1676-d7c2-44d4-9eac-7ead6d00256e	2	c5fd1676-d7c2-44d4-9eac-7ead6d00256e	54055903-37a0-458e-85d4-bb5e025d66b8	2147483647	development@test.com	\N	is-a-part-of	\N
0f12f60b-343b-4bef-8642-f0a2577b82bf	0	2021-05-20 15:35:23.82408	7e56219c-fc40-4717-85d8-c73e24fdf463	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.82408	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/30594004-573b-4652-b585-094ee77506f9	2	30594004-573b-4652-b585-094ee77506f9	ce3cffc9-596e-46dd-a3d1-1c25b23de70a	2147483647	development@test.com	\N	is-a-part-of	\N
c99ead1e-2582-4672-92dd-7fa4eb5ea06d	0	2021-05-20 15:35:23.824643	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.824643	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/224f7429-5295-489b-b8af-4998b0593b38	2	224f7429-5295-489b-b8af-4998b0593b38	38cbda61-b3d7-429f-b837-172c8c87e8dd	2147483647	development@test.com	\N	is-a-part-of	\N
a2cd5b66-6257-4efa-af37-aeb619492d8b	0	2021-05-20 15:35:23.82519	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.82519	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/9ea09e24-705c-4920-9dba-8ccf39fac00c	2	9ea09e24-705c-4920-9dba-8ccf39fac00c	4625a444-b2d9-47ee-b622-2045d4efec95	2147483647	development@test.com	\N	is-a-part-of	\N
d12ce272-46b3-494c-9111-2a7bc96f92a6	0	2021-05-20 15:35:23.825723	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.825723	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/7db966c7-cde8-411e-898f-77753e51399e	2	7db966c7-cde8-411e-898f-77753e51399e	8fe22e59-a799-4318-86d9-58b12dd2a735	2147483647	development@test.com	\N	is-a-part-of	\N
bbc9f321-cbd7-48a8-b402-3f3c9a699d7a	0	2021-05-20 15:35:23.826347	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.826347	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/79be971d-7827-430d-9e03-8089f890f00a	2	79be971d-7827-430d-9e03-8089f890f00a	9326fb45-c4d6-4c55-b698-54b12ebfcd0c	2147483647	development@test.com	\N	is-a-part-of	\N
c6f2fa87-9f67-4a93-8dc9-f6c9b1169490	0	2021-05-20 15:35:23.826938	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.826938	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/13a6ae7d-dede-41f6-9353-aa24fdf9b5a4	2	13a6ae7d-dede-41f6-9353-aa24fdf9b5a4	d3c34d9f-e818-43da-b196-7fbb2c219c8c	2147483647	development@test.com	\N	is-a-part-of	\N
339a141e-cd4a-4f9d-8842-d9148a6ab2cc	0	2021-05-20 15:35:23.827517	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.827517	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/b44284c0-7ed1-4f53-8c7f-9a9f8bd278fa	2	b44284c0-7ed1-4f53-8c7f-9a9f8bd278fa	b0b51716-1a6d-4814-8e78-7c0a0ad6c378	2147483647	development@test.com	\N	is-a-part-of	\N
0ed578fe-ff84-47aa-8f47-29ffc43f82e3	0	2021-05-20 15:35:23.828046	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.828046	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/15d499ac-3edd-4264-811a-40cabb8b6dce	2	15d499ac-3edd-4264-811a-40cabb8b6dce	64b3cb4b-17b8-4236-8ee6-5b0865e3b73f	2147483647	development@test.com	\N	is-a-part-of	\N
277fed1a-23a7-4dc6-9895-fdff8b25ebce	0	2021-05-20 15:35:23.828734	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.828734	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/b49f7b23-3d75-4d7f-91c3-7cd36378ecd0	2	b49f7b23-3d75-4d7f-91c3-7cd36378ecd0	e3fef071-df7f-4b78-9f4b-1159f9c77ccb	2147483647	development@test.com	\N	is-a-part-of	\N
9acb623a-7718-4566-9cb3-51fdf45d2b0f	0	2021-05-20 15:35:23.829299	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.829299	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/a877238c-25da-498d-b6da-5fdfdc8abb80	2	a877238c-25da-498d-b6da-5fdfdc8abb80	20823fc1-e8cd-4d01-9602-5a19c7d46ea6	2147483647	development@test.com	\N	is-a-part-of	\N
0fcab2c2-a270-45bc-9a61-fe703bd8065a	0	2021-05-20 15:35:23.830024	224f7429-5295-489b-b8af-4998b0593b38	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.830024	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/132e194c-377c-48ea-aa60-753b156d4ba6	2	132e194c-377c-48ea-aa60-753b156d4ba6	6e243a90-6441-416a-a7a5-35f1e19ff5b9	2147483647	development@test.com	\N	is-a-part-of	\N
83fa019c-d752-4e40-8252-5fc437bed781	0	2021-05-20 15:35:23.830637	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.830637	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/00405a22-2e59-48ac-85bf-2fa5cd44cc14	2	00405a22-2e59-48ac-85bf-2fa5cd44cc14	bffc615f-2d47-432a-b292-6050a93251e6	2147483647	development@test.com	\N	is-a-part-of	\N
e155da92-6cfe-42ec-99bb-28e4a40f5817	0	2021-05-20 15:35:23.831259	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.831259	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/57ad05d4-b529-4958-9cc8-2feedbea2753	2	57ad05d4-b529-4958-9cc8-2feedbea2753	ef80e4e8-f484-44e4-997a-a59ae8ff1dbe	2147483647	development@test.com	\N	is-a-part-of	\N
8022c2e9-e32f-424e-bca6-d2e92467b5a9	0	2021-05-20 15:35:23.831845	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.831845	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/fc870e89-1cd8-4f47-85f9-eb3339cf2b48	2	fc870e89-1cd8-4f47-85f9-eb3339cf2b48	398f7739-a11b-47c8-bf03-44284fb4cd19	2147483647	development@test.com	\N	is-a-part-of	\N
a2a14f2f-bd5a-4787-a440-1b4d86a2308d	0	2021-05-20 15:35:23.832457	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.832457	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/66a5991d-dca7-44d3-8140-9944dfc4497d	2	66a5991d-dca7-44d3-8140-9944dfc4497d	5a6931dc-2748-4b87-a262-76476dcc57ae	2147483647	development@test.com	\N	is-a-part-of	\N
d41764a4-cc17-4253-9100-aef867d69ab2	0	2021-05-20 15:35:23.832995	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.832995	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/4f5942bc-0a6b-4fd1-907a-3be9857829de	2	4f5942bc-0a6b-4fd1-907a-3be9857829de	8fbb3624-4ef1-4d5d-942e-e6c83d1897ce	2147483647	development@test.com	\N	is-a-part-of	\N
3251244a-7e0b-4dbf-9edd-87267cf16198	0	2021-05-20 15:35:23.833526	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.833526	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/c39c02c4-5590-4cc4-82bc-98baea435d60	2	c39c02c4-5590-4cc4-82bc-98baea435d60	111b4d2f-e3ba-4f6f-9bd0-7faa0a26cd02	2147483647	development@test.com	\N	is-a-part-of	\N
ba181721-f12f-4e34-b4e9-cdf7a0a147fb	0	2021-05-20 15:35:23.834094	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.834094	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/de06b170-e802-4e59-a99e-3c9aafad340a	2	de06b170-e802-4e59-a99e-3c9aafad340a	597c2a6c-0000-4235-910e-dbc9971efdaa	2147483647	development@test.com	\N	is-a-part-of	\N
5bcc72d3-fe4a-4191-bb44-c3d97d328bcb	0	2021-05-20 15:35:23.834656	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.834656	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/45c82b1c-67ab-4018-b0a9-087acd671522	2	45c82b1c-67ab-4018-b0a9-087acd671522	5523b574-eef6-49c8-8235-495ddc4aa4b5	2147483647	development@test.com	\N	is-a-part-of	\N
1090fb8c-c18b-47e6-b6dc-fe3f71ce4ec9	0	2021-05-20 15:35:23.835281	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.835281	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/c483431b-579b-4e17-9163-8cbc4ac27516	2	c483431b-579b-4e17-9163-8cbc4ac27516	b5d0e29b-1c4b-4e64-bd58-f385bc925901	2147483647	development@test.com	\N	is-a-part-of	\N
428e6345-8d7c-4efe-a219-915fd88ab9f2	0	2021-05-20 15:35:23.835811	00405a22-2e59-48ac-85bf-2fa5cd44cc14	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.835811	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/fd3777b0-521a-46f9-9cf7-4cbdd2cb6006	2	fd3777b0-521a-46f9-9cf7-4cbdd2cb6006	f389693e-f5aa-4277-a4ad-5a3b027df4b1	2147483647	development@test.com	\N	is-a-part-of	\N
0fd5031d-ddf2-4676-96ed-0d3776649596	0	2021-05-20 15:35:23.836331	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.836331	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/402fc088-137d-4e1e-8178-876f921bdb3d	2	402fc088-137d-4e1e-8178-876f921bdb3d	8fc91ef2-42a9-491f-87bd-38ef812d355a	2147483647	development@test.com	\N	is-a-part-of	\N
1080a4ce-a9a5-49d3-aa78-9e345155a245	0	2021-05-20 15:35:23.83684	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.83684	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/f7fb2530-31da-4e49-96c5-ca33f5a95948	2	f7fb2530-31da-4e49-96c5-ca33f5a95948	76794f0b-c3ea-4253-b089-0517d16659d2	2147483647	development@test.com	\N	is-a-part-of	\N
aa63c8da-f813-42f7-8b17-e2fab41b8d51	0	2021-05-20 15:35:23.837356	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.837356	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/138e033f-e261-4e6f-a33c-ba2e6c3248af	2	138e033f-e261-4e6f-a33c-ba2e6c3248af	e804fcd5-c54e-4783-9a28-4fb6c455bed0	2147483647	development@test.com	\N	is-a-part-of	\N
977cafb3-ed45-4b09-bf71-398937b064e9	0	2021-05-20 15:35:23.837941	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.837941	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/966c91cd-a2b2-45fe-9172-b32077156666	2	966c91cd-a2b2-45fe-9172-b32077156666	20af71f3-8e20-4d99-b0af-d3126cc4164b	2147483647	development@test.com	\N	is-a-part-of	\N
3f2d66e5-6b2a-4948-a5be-1e7e89b156b5	0	2021-05-20 15:35:23.838451	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.838451	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/f440ddd8-38eb-4e59-818b-37687e279ff9	2	f440ddd8-38eb-4e59-818b-37687e279ff9	b44e1ef6-6d80-489b-89c4-40cae511c2e3	2147483647	development@test.com	\N	is-a-part-of	\N
13612d7b-b315-4a16-ba99-1bc473c39111	0	2021-05-20 15:35:23.842449	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.842449	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/659a2fbc-3a09-4f92-a166-52121ae15001	2	659a2fbc-3a09-4f92-a166-52121ae15001	f1cd8029-5e74-4c6b-a06e-7133933a1b1b	2147483647	development@test.com	\N	is-a-part-of	\N
83b7d35e-23fa-43f8-aed1-4a0aecb15ab2	0	2021-05-20 15:35:23.843191	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.843191	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/aa15a48d-1f0e-434c-ac2c-f8a3e36d8d37	2	aa15a48d-1f0e-434c-ac2c-f8a3e36d8d37	9d41215f-9c11-4fe6-ae0d-f15f36ca1bb7	2147483647	development@test.com	\N	is-a-part-of	\N
aa941aef-e0df-46b4-b44e-1c4d4c49e520	0	2021-05-20 15:35:23.84411	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.84411	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/129e31ae-f381-4e2f-ae44-d6cbcb39f7df	2	129e31ae-f381-4e2f-ae44-d6cbcb39f7df	f635ac6a-8e12-4906-aa52-cb372708932b	2147483647	development@test.com	\N	is-a-part-of	\N
9dec5cb4-5d0a-43a2-92c7-c003687b0035	0	2021-05-20 15:35:23.84487	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.84487	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/673f6435-1147-48d8-9f30-0036c4f12df0	2	673f6435-1147-48d8-9f30-0036c4f12df0	3858e610-de22-4984-94c8-0d036701f60e	2147483647	development@test.com	\N	is-a-part-of	\N
0f5ef777-3f57-4f08-a95c-ea984933c96a	0	2021-05-20 15:35:23.845411	402fc088-137d-4e1e-8178-876f921bdb3d	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.845411	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/222cf3cb-bdf6-4f45-a0f0-3123adfb2773	2	222cf3cb-bdf6-4f45-a0f0-3123adfb2773	46d1aa86-ff9c-431c-a168-2e3760addb26	2147483647	development@test.com	\N	is-a-part-of	\N
4ed278d0-3394-4ff1-a73a-d113a4b259af	0	2021-05-20 15:35:23.845924	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.845924	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/dd3deeb9-669d-4b04-95d0-74f47006bc59	2	dd3deeb9-669d-4b04-95d0-74f47006bc59	166e8500-daaf-4713-9c4f-a702ab34d117	2147483647	development@test.com	\N	is-a-part-of	\N
4eaaa616-c537-4d60-a8cc-555b495db9b8	0	2021-05-20 15:35:23.846447	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.846447	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/ddce352a-5089-4617-93ea-e3f84c3e8d3b	2	ddce352a-5089-4617-93ea-e3f84c3e8d3b	9dd3a666-149c-4562-a004-ae3922f4e342	2147483647	development@test.com	\N	is-a-part-of	\N
04c86515-6f72-48d2-99bb-c9e3e552b18f	0	2021-05-20 15:35:23.846965	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.846965	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/1654c39e-b5f3-4fc0-abb4-2ed008c5282f	2	1654c39e-b5f3-4fc0-abb4-2ed008c5282f	cda702f3-a682-4581-ab0d-4a199aa96d0d	2147483647	development@test.com	\N	is-a-part-of	\N
7d2ed1cf-6631-43c5-b3eb-348bd56365a3	0	2021-05-20 15:35:23.847483	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.847483	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/3d731a71-d245-4e17-8baf-8793161982ee	2	3d731a71-d245-4e17-8baf-8793161982ee	3a6957c1-fbf5-48c1-87ff-1239f0381903	2147483647	development@test.com	\N	is-a-part-of	\N
2c39ecc8-d7d3-428a-878f-d6beb4139e4f	0	2021-05-20 15:35:23.847977	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.847977	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/6c0d0b48-61af-4e44-b5e5-1b03fcfd80e1	2	6c0d0b48-61af-4e44-b5e5-1b03fcfd80e1	6ab90483-e092-4212-b16c-fea2128b1428	2147483647	development@test.com	\N	is-a-part-of	\N
8f4c7395-558f-4927-a2eb-ef4a734cf2d9	0	2021-05-20 15:35:23.848469	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.848469	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/a7b211da-b399-49fd-9f28-cab4194cf015	2	a7b211da-b399-49fd-9f28-cab4194cf015	01e1fb42-1f62-4c4e-967a-e2d02dd449fb	2147483647	development@test.com	\N	is-a-part-of	\N
5d4ed392-61a4-4ceb-9c58-6cb8a3f15478	0	2021-05-20 15:35:23.848973	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.848973	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/73e0323a-c8da-4d14-9ba0-af6978425e72	2	73e0323a-c8da-4d14-9ba0-af6978425e72	dbb72c27-9713-4347-88a8-82d976a518f9	2147483647	development@test.com	\N	is-a-part-of	\N
efb0b935-53f3-4054-b287-d564f5ac2a4a	0	2021-05-20 15:35:23.849468	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.849468	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/b23215ef-213b-4d54-8f72-616c81bb0cfa	2	b23215ef-213b-4d54-8f72-616c81bb0cfa	78a1c45b-a4f2-43e7-9864-68738147c5ae	2147483647	development@test.com	\N	is-a-part-of	\N
1d4948ca-4cd2-447f-94e9-cb37a69059a4	0	2021-05-20 15:35:23.84997	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.84997	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/bbf81fec-09e4-4b93-a7f3-49c6f463d9a2	2	bbf81fec-09e4-4b93-a7f3-49c6f463d9a2	bd880ed6-26a4-43bf-af00-3f5dad009a86	2147483647	development@test.com	\N	is-a-part-of	\N
10117bd9-f259-46ad-8d84-f513ecd3c97c	0	2021-05-20 15:35:23.850466	dd3deeb9-669d-4b04-95d0-74f47006bc59	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.850466	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/15bf739d-0a84-4bf6-9d75-89fa47b9f929	2	15bf739d-0a84-4bf6-9d75-89fa47b9f929	c9af3acf-4981-4fb8-b78e-966b6b787d54	2147483647	development@test.com	\N	is-a-part-of	\N
3de95454-8fac-4180-9a2d-79ab413ad95d	0	2021-05-20 15:35:23.851051	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.851051	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/9f00cbd1-cb54-4d94-94af-9066868ec2c4	2	9f00cbd1-cb54-4d94-94af-9066868ec2c4	e1f42237-fba5-4248-907f-42214adce966	2147483647	development@test.com	\N	is-a-part-of	\N
4f1b7a3a-8711-4a6f-b1ab-bffb58ebd82a	0	2021-05-20 15:35:23.851556	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.851556	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/6c013905-0c1b-47a5-8ac4-9db79a5bde9e	2	6c013905-0c1b-47a5-8ac4-9db79a5bde9e	e959a9f6-60c9-4181-8ac1-ecd6e76405ee	2147483647	development@test.com	\N	is-a-part-of	\N
88d8ffb1-2658-4540-8d2e-bfb189e68805	0	2021-05-20 15:35:23.852057	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.852057	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/ae8fdb84-b5d9-49bb-a81c-6901f6b7d32a	2	ae8fdb84-b5d9-49bb-a81c-6901f6b7d32a	ef5223e0-5bad-40fd-8f60-0d536879a2fa	2147483647	development@test.com	\N	is-a-part-of	\N
8a6d8e32-f63e-4585-af8d-7d815605b560	0	2021-05-20 15:35:23.852555	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.852555	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/b6e043e6-aa70-41c0-8a85-bf55986adf32	2	b6e043e6-aa70-41c0-8a85-bf55986adf32	1dbf12f7-37eb-4eed-af13-c2f75b349493	2147483647	development@test.com	\N	is-a-part-of	\N
1b937fee-f8f8-4b75-81da-5b5612d1aec4	0	2021-05-20 15:35:23.853051	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.853051	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/28d2fb48-49ae-4398-b769-c2889b5348cd	2	28d2fb48-49ae-4398-b769-c2889b5348cd	970382ff-a678-4159-89dd-e5283cf6d04a	2147483647	development@test.com	\N	is-a-part-of	\N
9255dcaa-7f4f-4924-9bab-f4c7faaaed8d	0	2021-05-20 15:35:23.853543	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.853543	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/1dd60ede-3f14-4e99-a623-a7200426e2e1	2	1dd60ede-3f14-4e99-a623-a7200426e2e1	f5b1c96a-9bc8-415c-b5af-f8a5d3588f34	2147483647	development@test.com	\N	is-a-part-of	\N
b35e0294-3a15-4f63-b9a7-40ff0d66fab4	0	2021-05-20 15:35:23.854038	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.854038	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/101f1d61-8fc9-4b33-a520-568cf03a2613	2	101f1d61-8fc9-4b33-a520-568cf03a2613	3ecd44d6-2920-4d3e-b4cb-1e7fc6e517ee	2147483647	development@test.com	\N	is-a-part-of	\N
37301770-1e93-4f41-9864-81f15e4857fb	0	2021-05-20 15:35:23.854526	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.854526	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/27ead685-0ac8-4cae-81d6-b89deafcdd28	2	27ead685-0ac8-4cae-81d6-b89deafcdd28	782bf016-ae19-4521-a31c-880eb1024c4f	2147483647	development@test.com	\N	is-a-part-of	\N
6a4b6685-4a2f-45ca-85fb-7a2281be48a9	0	2021-05-20 15:35:23.855091	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.855091	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/3531b6a3-c1fe-4aa1-8efa-6180dcc1b0ed	2	3531b6a3-c1fe-4aa1-8efa-6180dcc1b0ed	0f44235c-e087-45ee-87c9-18df8f08e941	2147483647	development@test.com	\N	is-a-part-of	\N
011ef4fe-838b-45b6-9024-fd8bd297934f	0	2021-05-20 15:35:23.855619	9f00cbd1-cb54-4d94-94af-9066868ec2c4	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:23.855619	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/9ed15988-e1ca-42f7-b61a-9f1cbf1e4289	2	9ed15988-e1ca-42f7-b61a-9f1cbf1e4289	8769bf31-ccf5-4012-891f-9a7f027d427d	2147483647	development@test.com	\N	is-a-part-of	\N
02cb1f81-e098-4cea-9356-6c59aa777fc9	0	2021-05-20 15:35:23.85618	bfa2411d-97c4-44bf-9224-f1f5245c47de	6d4f4ed1-a873-4d32-8b38-d1ef3b8e62b5	2021-05-20 15:35:23.85618	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/04c22cc3-9b6a-4838-9f1f-ddb87da2336f	2	04c22cc3-9b6a-4838-9f1f-ddb87da2336f	7f0aa7ed-d965-403a-ba1a-530c33ca96c8	2147483647	development@test.com	\N	is-a	\N
42799a29-d962-4ced-88d7-fa98f8fda08d	1	2021-05-20 15:35:23.769132	bfa2411d-97c4-44bf-9224-f1f5245c47de	00c30b70-25df-4b66-8887-feeb990309f3	2021-05-20 15:35:24.949198	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f/85f636ff-72a0-4c14-9524-1c6175b2769e	3	85f636ff-72a0-4c14-9524-1c6175b2769e	302926ec-8995-4a97-9a24-46bbd24cf8fc	2147483647	development@test.com	\N	is-a-part-of	\N
\.


--
-- Data for Name: term_relationship_type; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.term_relationship_type (id, version, date_created, child_relationship, terminology_id, last_updated, path, depth, breadcrumb_tree_id, parental_relationship, idx, created_by, aliases_string, label, display_label, description) FROM stdin;
6d4f4ed1-a873-4d32-8b38-d1ef3b8e62b5	0	2021-05-20 15:35:23.597525	f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2021-05-20 15:35:23.597525	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	1	e2c07afb-b66b-4043-b512-94533f40605a	f	2147483647	development@test.com	\N	is-a	Is A	\N
00c30b70-25df-4b66-8887-feeb990309f3	0	2021-05-20 15:35:23.599624	t	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2021-05-20 15:35:23.599624	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	1	3cdb6065-bae6-4154-90f0-fc438ce4d847	f	2147483647	development@test.com	\N	is-a-part-of	Is A Part Of	\N
c4960220-4d94-4c75-bd17-a46b1415bbf6	0	2021-05-20 15:35:23.600224	f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2021-05-20 15:35:23.600224	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	1	49f0d1c6-e415-4cb3-9243-e42846bddb08	t	2147483647	development@test.com	\N	broaderThan	Broader Than	\N
bce306a1-2de1-4b20-b74b-26ad75ae2eaf	1	2021-05-20 15:35:23.600817	f	d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2021-05-20 15:35:24.948	/d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	1	82c2c02a-87dc-4b24-84be-23a42d46262e	f	2147483647	development@test.com	\N	narrowerThan	Narrower Than	\N
\.


--
-- Data for Name: terminology; Type: TABLE DATA; Schema: terminology; Owner: maurodatamapper
--

COPY terminology.terminology (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag) FROM stdin;
d1f24541-c6ba-4442-b4e8-4e75ceb5c74f	2	2021-05-20 15:35:23.080886	f	f	\N	1.0.0	f	Terminology	2021-05-20 15:35:23.869893	Oxford BRC	f	Test Bootstrap	c9faa5b3-3cfd-47a4-8b8b-f4e455e9a447	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	Complex Test Terminology	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	\N	\N
dc582af4-674a-4569-a59b-2defccfb876f	1	2021-05-20 15:35:25.057864	f	f	\N	1.0.0	f	Terminology	2021-05-20 15:35:25.103462	Oxford BRC	f	Test Bootstrap	559f61bf-6e38-4eda-9210-15137bdf72e5	31a0deb7-7d38-45f6-a48e-5cfef3d40026	development@test.com	\N	Simple Test Terminology	\N	4c6c3da6-1c35-4f84-b01b-72dcadef0b2b	main	\N	\N
\.


--
-- Name: annotation annotation_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.annotation
    ADD CONSTRAINT annotation_pkey PRIMARY KEY (id);


--
-- Name: api_property api_property_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.api_property
    ADD CONSTRAINT api_property_pkey PRIMARY KEY (id);


--
-- Name: authority authority_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.authority
    ADD CONSTRAINT authority_pkey PRIMARY KEY (id);


--
-- Name: breadcrumb_tree breadcrumb_tree_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.breadcrumb_tree
    ADD CONSTRAINT breadcrumb_tree_pkey PRIMARY KEY (id);


--
-- Name: classifier classifier_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT classifier_pkey PRIMARY KEY (id);


--
-- Name: edit edit_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.edit
    ADD CONSTRAINT edit_pkey PRIMARY KEY (id);


--
-- Name: email email_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: folder folder_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- Name: metadata metadata_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.metadata
    ADD CONSTRAINT metadata_pkey PRIMARY KEY (id);


--
-- Name: reference_file reference_file_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.reference_file
    ADD CONSTRAINT reference_file_pkey PRIMARY KEY (id);


--
-- Name: rule rule_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.rule
    ADD CONSTRAINT rule_pkey PRIMARY KEY (id);


--
-- Name: rule_representation rule_representation_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.rule_representation
    ADD CONSTRAINT rule_representation_pkey PRIMARY KEY (id);


--
-- Name: semantic_link semantic_link_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.semantic_link
    ADD CONSTRAINT semantic_link_pkey PRIMARY KEY (id);


--
-- Name: classifier uk_j7bbt97ko557eewc3u50ha8ko; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT uk_j7bbt97ko557eewc3u50ha8ko UNIQUE (label);


--
-- Name: authority ukfcae2aea4497b223b1762d7b79a3; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.authority
    ADD CONSTRAINT ukfcae2aea4497b223b1762d7b79a3 UNIQUE (url, label);


--
-- Name: user_image_file user_image_file_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.user_image_file
    ADD CONSTRAINT user_image_file_pkey PRIMARY KEY (id);


--
-- Name: version_link version_link_pkey; Type: CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.version_link
    ADD CONSTRAINT version_link_pkey PRIMARY KEY (id);


--
-- Name: data_class_component data_class_component_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT data_class_component_pkey PRIMARY KEY (id);


--
-- Name: data_element_component data_element_component_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT data_element_component_pkey PRIMARY KEY (id);


--
-- Name: data_flow data_flow_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT data_flow_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: data_class data_class_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT data_class_pkey PRIMARY KEY (id);


--
-- Name: data_element data_element_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT data_element_pkey PRIMARY KEY (id);


--
-- Name: data_model data_model_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT data_model_pkey PRIMARY KEY (id);


--
-- Name: data_type data_type_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT data_type_pkey PRIMARY KEY (id);


--
-- Name: enumeration_value enumeration_value_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT enumeration_value_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: summary_metadata summary_metadata_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.summary_metadata
    ADD CONSTRAINT summary_metadata_pkey PRIMARY KEY (id);


--
-- Name: summary_metadata_report summary_metadata_report_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.summary_metadata_report
    ADD CONSTRAINT summary_metadata_report_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: federation; Owner: maurodatamapper
--

ALTER TABLE ONLY federation.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: subscribed_catalogue subscribed_catalogue_pkey; Type: CONSTRAINT; Schema: federation; Owner: maurodatamapper
--

ALTER TABLE ONLY federation.subscribed_catalogue
    ADD CONSTRAINT subscribed_catalogue_pkey PRIMARY KEY (id);


--
-- Name: subscribed_model subscribed_model_pkey; Type: CONSTRAINT; Schema: federation; Owner: maurodatamapper
--

ALTER TABLE ONLY federation.subscribed_model
    ADD CONSTRAINT subscribed_model_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: reference_data_element reference_data_element_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT reference_data_element_pkey PRIMARY KEY (id);


--
-- Name: reference_data_model reference_data_model_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT reference_data_model_pkey PRIMARY KEY (id);


--
-- Name: reference_data_type reference_data_type_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT reference_data_type_pkey PRIMARY KEY (id);


--
-- Name: reference_data_value reference_data_value_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT reference_data_value_pkey PRIMARY KEY (id);


--
-- Name: reference_enumeration_value reference_enumeration_value_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT reference_enumeration_value_pkey PRIMARY KEY (id);


--
-- Name: reference_summary_metadata reference_summary_metadata_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_summary_metadata
    ADD CONSTRAINT reference_summary_metadata_pkey PRIMARY KEY (id);


--
-- Name: reference_summary_metadata_report reference_summary_metadata_report_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_summary_metadata_report
    ADD CONSTRAINT reference_summary_metadata_report_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (id);


--
-- Name: catalogue_user catalogue_user_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT catalogue_user_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: group_role group_role_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT group_role_pkey PRIMARY KEY (id);


--
-- Name: join_catalogue_user_to_user_group join_catalogue_user_to_user_group_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT join_catalogue_user_to_user_group_pkey PRIMARY KEY (user_group_id, catalogue_user_id);


--
-- Name: securable_resource_group_role securable_resource_group_role_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT securable_resource_group_role_pkey PRIMARY KEY (id);


--
-- Name: catalogue_user uk_26qjnuqu76954q376opkqelqd; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT uk_26qjnuqu76954q376opkqelqd UNIQUE (email_address);


--
-- Name: group_role uk_7kvrlnisllgg2md5614ywh82g; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT uk_7kvrlnisllgg2md5614ywh82g UNIQUE (name);


--
-- Name: user_group uk_kas9w8ead0ska5n3csefp2bpp; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT uk_kas9w8ead0ska5n3csefp2bpp UNIQUE (name);


--
-- Name: api_key ukee162bd1d3e12dac9f8ef55811f7; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT ukee162bd1d3e12dac9f8ef55811f7 UNIQUE (catalogue_user_id, name);


--
-- Name: user_group user_group_pkey; Type: CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT user_group_pkey PRIMARY KEY (id);


--
-- Name: code_set code_set_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT code_set_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: term term_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT term_pkey PRIMARY KEY (id);


--
-- Name: term_relationship term_relationship_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT term_relationship_pkey PRIMARY KEY (id);


--
-- Name: term_relationship_type term_relationship_type_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT term_relationship_type_pkey PRIMARY KEY (id);


--
-- Name: terminology terminology_pkey; Type: CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT terminology_pkey PRIMARY KEY (id);


--
-- Name: annotation_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX annotation_created_by_idx ON core.annotation USING btree (created_by);


--
-- Name: annotation_parent_annotation_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX annotation_parent_annotation_idx ON core.annotation USING btree (parent_annotation_id);


--
-- Name: apiproperty_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX apiproperty_created_by_idx ON core.api_property USING btree (created_by);


--
-- Name: authority_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX authority_created_by_idx ON core.authority USING btree (created_by);


--
-- Name: classifier_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX classifier_created_by_idx ON core.classifier USING btree (created_by);


--
-- Name: classifier_parent_classifier_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX classifier_parent_classifier_idx ON core.classifier USING btree (parent_classifier_id);


--
-- Name: edit_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX edit_created_by_idx ON core.edit USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX flyway_schema_history_s_idx ON core.flyway_schema_history USING btree (success);


--
-- Name: folder_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX folder_created_by_idx ON core.folder USING btree (created_by);


--
-- Name: folder_parent_folder_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX folder_parent_folder_idx ON core.folder USING btree (parent_folder_id);


--
-- Name: metadata_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX metadata_catalogue_item_idx ON core.metadata USING btree (multi_facet_aware_item_id);


--
-- Name: metadata_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX metadata_created_by_idx ON core.metadata USING btree (created_by);


--
-- Name: metadata_namespace_index; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX metadata_namespace_index ON core.metadata USING btree (namespace);


--
-- Name: metadata_namespace_key_index; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX metadata_namespace_key_index ON core.metadata USING btree (namespace, key);


--
-- Name: referencefile_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX referencefile_created_by_idx ON core.reference_file USING btree (created_by);


--
-- Name: rule_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX rule_catalogue_item_idx ON core.rule USING btree (multi_facet_aware_item_id);


--
-- Name: rule_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX rule_created_by_idx ON core.rule USING btree (created_by);


--
-- Name: rule_representation_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX rule_representation_created_by_idx ON core.rule_representation USING btree (created_by);


--
-- Name: rule_representation_rule_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX rule_representation_rule_idx ON core.rule_representation USING btree (rule_id);


--
-- Name: semantic_link_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX semantic_link_catalogue_item_idx ON core.semantic_link USING btree (multi_facet_aware_item_id);


--
-- Name: semantic_link_target_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX semantic_link_target_catalogue_item_idx ON core.semantic_link USING btree (target_multi_facet_aware_item_id);


--
-- Name: semanticlink_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX semanticlink_created_by_idx ON core.semantic_link USING btree (created_by);


--
-- Name: userimagefile_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX userimagefile_created_by_idx ON core.user_image_file USING btree (created_by);


--
-- Name: version_link_catalogue_item_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX version_link_catalogue_item_idx ON core.version_link USING btree (multi_facet_aware_item_id);


--
-- Name: version_link_target_model_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX version_link_target_model_idx ON core.version_link USING btree (target_model_id);


--
-- Name: versionlink_created_by_idx; Type: INDEX; Schema: core; Owner: maurodatamapper
--

CREATE INDEX versionlink_created_by_idx ON core.version_link USING btree (created_by);


--
-- Name: data_flow_source_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapper
--

CREATE INDEX data_flow_source_idx ON dataflow.data_flow USING btree (source_id);


--
-- Name: data_flow_target_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapper
--

CREATE INDEX data_flow_target_idx ON dataflow.data_flow USING btree (target_id);


--
-- Name: dataclasscomponent_created_by_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapper
--

CREATE INDEX dataclasscomponent_created_by_idx ON dataflow.data_class_component USING btree (created_by);


--
-- Name: dataelementcomponent_created_by_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapper
--

CREATE INDEX dataelementcomponent_created_by_idx ON dataflow.data_element_component USING btree (created_by);


--
-- Name: dataflow_created_by_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapper
--

CREATE INDEX dataflow_created_by_idx ON dataflow.data_flow USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: dataflow; Owner: maurodatamapper
--

CREATE INDEX flyway_schema_history_s_idx ON dataflow.flyway_schema_history USING btree (success);


--
-- Name: data_class_data_model_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX data_class_data_model_idx ON datamodel.data_class USING btree (data_model_id);


--
-- Name: data_class_parent_data_class_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX data_class_parent_data_class_idx ON datamodel.data_class USING btree (parent_data_class_id);


--
-- Name: data_element_data_class_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX data_element_data_class_idx ON datamodel.data_element USING btree (data_class_id);


--
-- Name: data_element_data_type_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX data_element_data_type_idx ON datamodel.data_element USING btree (data_type_id);


--
-- Name: data_type_data_model_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX data_type_data_model_idx ON datamodel.data_type USING btree (data_model_id);


--
-- Name: dataclass_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX dataclass_created_by_idx ON datamodel.data_class USING btree (created_by);


--
-- Name: dataelement_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX dataelement_created_by_idx ON datamodel.data_element USING btree (created_by);


--
-- Name: datamodel_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX datamodel_created_by_idx ON datamodel.data_model USING btree (created_by);


--
-- Name: datatype_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX datatype_created_by_idx ON datamodel.data_type USING btree (created_by);


--
-- Name: enumeration_value_enumeration_type_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX enumeration_value_enumeration_type_idx ON datamodel.enumeration_value USING btree (enumeration_type_id);


--
-- Name: enumerationvalue_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX enumerationvalue_created_by_idx ON datamodel.enumeration_value USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX flyway_schema_history_s_idx ON datamodel.flyway_schema_history USING btree (success);


--
-- Name: reference_type_reference_class_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX reference_type_reference_class_idx ON datamodel.data_type USING btree (reference_class_id);


--
-- Name: summary_metadata_report_summary_metadata_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX summary_metadata_report_summary_metadata_idx ON datamodel.summary_metadata_report USING btree (summary_metadata_id);


--
-- Name: summarymetadata_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX summarymetadata_created_by_idx ON datamodel.summary_metadata USING btree (created_by);


--
-- Name: summarymetadatareport_created_by_idx; Type: INDEX; Schema: datamodel; Owner: maurodatamapper
--

CREATE INDEX summarymetadatareport_created_by_idx ON datamodel.summary_metadata_report USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: federation; Owner: maurodatamapper
--

CREATE INDEX flyway_schema_history_s_idx ON federation.flyway_schema_history USING btree (success);


--
-- Name: subscribed_model_local_model_id; Type: INDEX; Schema: federation; Owner: maurodatamapper
--

CREATE INDEX subscribed_model_local_model_id ON federation.subscribed_model USING btree (local_model_id);


--
-- Name: subscribed_model_subscribed_catalogue_id; Type: INDEX; Schema: federation; Owner: maurodatamapper
--

CREATE INDEX subscribed_model_subscribed_catalogue_id ON federation.subscribed_model USING btree (subscribed_catalogue_id);


--
-- Name: data_element_data_type_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX data_element_data_type_idx ON referencedata.reference_data_element USING btree (reference_data_type_id);


--
-- Name: data_element_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX data_element_reference_data_model_idx ON referencedata.reference_data_element USING btree (reference_data_model_id);


--
-- Name: data_type_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX data_type_reference_data_model_idx ON referencedata.reference_data_type USING btree (reference_data_model_id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX flyway_schema_history_s_idx ON referencedata.flyway_schema_history USING btree (success);


--
-- Name: reference_data_value_reference_data_element_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX reference_data_value_reference_data_element_idx ON referencedata.reference_data_value USING btree (reference_data_element_id);


--
-- Name: reference_data_value_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX reference_data_value_reference_data_model_idx ON referencedata.reference_data_value USING btree (reference_data_model_id);


--
-- Name: referencedataelement_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX referencedataelement_created_by_idx ON referencedata.reference_data_element USING btree (created_by);


--
-- Name: referencedatamodel_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX referencedatamodel_created_by_idx ON referencedata.reference_data_model USING btree (created_by);


--
-- Name: referencedatatype_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX referencedatatype_created_by_idx ON referencedata.reference_data_type USING btree (created_by);


--
-- Name: referenceenumerationvalue_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX referenceenumerationvalue_created_by_idx ON referencedata.reference_enumeration_value USING btree (created_by);


--
-- Name: referencesummarymetadata_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX referencesummarymetadata_created_by_idx ON referencedata.reference_summary_metadata USING btree (created_by);


--
-- Name: referencesummarymetadatareport_created_by_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX referencesummarymetadatareport_created_by_idx ON referencedata.reference_summary_metadata_report USING btree (created_by);


--
-- Name: summary_metadata_report_summary_metadata_idx; Type: INDEX; Schema: referencedata; Owner: maurodatamapper
--

CREATE INDEX summary_metadata_report_summary_metadata_idx ON referencedata.reference_summary_metadata_report USING btree (summary_metadata_id);


--
-- Name: apikey_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX apikey_created_by_idx ON security.api_key USING btree (created_by);


--
-- Name: catalogue_user_profile_picture_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX catalogue_user_profile_picture_idx ON security.catalogue_user USING btree (profile_picture_id);


--
-- Name: catalogueuser_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX catalogueuser_created_by_idx ON security.catalogue_user USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX flyway_schema_history_s_idx ON security.flyway_schema_history USING btree (success);


--
-- Name: grouprole_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX grouprole_created_by_idx ON security.group_role USING btree (created_by);


--
-- Name: jcutug_catalogue_user_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX jcutug_catalogue_user_idx ON security.join_catalogue_user_to_user_group USING btree (catalogue_user_id);


--
-- Name: jcutug_user_group_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX jcutug_user_group_idx ON security.join_catalogue_user_to_user_group USING btree (user_group_id);


--
-- Name: securableresourcegrouprole_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX securableresourcegrouprole_created_by_idx ON security.securable_resource_group_role USING btree (created_by);


--
-- Name: usergroup_created_by_idx; Type: INDEX; Schema: security; Owner: maurodatamapper
--

CREATE INDEX usergroup_created_by_idx ON security.user_group USING btree (created_by);


--
-- Name: codeset_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX codeset_created_by_idx ON terminology.code_set USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX flyway_schema_history_s_idx ON terminology.flyway_schema_history USING btree (success);


--
-- Name: term_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX term_created_by_idx ON terminology.term USING btree (created_by);


--
-- Name: term_relationship_source_term_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX term_relationship_source_term_idx ON terminology.term_relationship USING btree (source_term_id);


--
-- Name: term_relationship_target_term_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX term_relationship_target_term_idx ON terminology.term_relationship USING btree (target_term_id);


--
-- Name: term_relationship_type_terminology_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX term_relationship_type_terminology_idx ON terminology.term_relationship_type USING btree (terminology_id);


--
-- Name: term_terminology_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX term_terminology_idx ON terminology.term USING btree (terminology_id);


--
-- Name: terminology_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX terminology_created_by_idx ON terminology.terminology USING btree (created_by);


--
-- Name: termrelationship_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX termrelationship_created_by_idx ON terminology.term_relationship USING btree (created_by);


--
-- Name: termrelationshiptype_created_by_idx; Type: INDEX; Schema: terminology; Owner: maurodatamapper
--

CREATE INDEX termrelationshiptype_created_by_idx ON terminology.term_relationship_type USING btree (created_by);


--
-- Name: join_folder_to_facet fk14o06qtiem74ycw6896javux7; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fk14o06qtiem74ycw6896javux7 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: breadcrumb_tree fk1hraqwgiiva4reb2v6do4it81; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.breadcrumb_tree
    ADD CONSTRAINT fk1hraqwgiiva4reb2v6do4it81 FOREIGN KEY (parent_id) REFERENCES core.breadcrumb_tree(id) ON DELETE CASCADE;


--
-- Name: join_classifier_to_facet fk1yihq7q1hhwm3f7jn4g7isg5k; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk1yihq7q1hhwm3f7jn4g7isg5k FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_classifier_to_facet fk3h1hax9omk9o62119jsc45m35; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk3h1hax9omk9o62119jsc45m35 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_classifier_to_facet fk54j6lhkhnneag9rqsnchk9rwf; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk54j6lhkhnneag9rqsnchk9rwf FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: folder fk57g7veis1gp5wn3g0mp0x57pl; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.folder
    ADD CONSTRAINT fk57g7veis1gp5wn3g0mp0x57pl FOREIGN KEY (parent_folder_id) REFERENCES core.folder(id);


--
-- Name: join_classifier_to_facet fk5owmrlff8c3f3bf2e7om5xkfj; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk5owmrlff8c3f3bf2e7om5xkfj FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_classifier_to_facet fk6531dcod746lwh2v7k4fatx7b; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk6531dcod746lwh2v7k4fatx7b FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_folder_to_facet fk6bgvwj5n9a92tkoky84uaktlm; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fk6bgvwj5n9a92tkoky84uaktlm FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: classifier fkahkm58kcer6a9q2v01ealovr6; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT fkahkm58kcer6a9q2v01ealovr6 FOREIGN KEY (parent_classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_versionedfolder_to_facet fkcdu99gvtth7g6q2glm329u7uu; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_versionedfolder_to_facet
    ADD CONSTRAINT fkcdu99gvtth7g6q2glm329u7uu FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_folder_to_facet fkibq4i08l0b0nkbopm8wjrdfd9; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkibq4i08l0b0nkbopm8wjrdfd9 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_folder_to_facet fkml4kb6cf0wr79sopbu6fglets; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkml4kb6cf0wr79sopbu6fglets FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: annotation fknrnwt8d2s4kytg7mis2rg2a5x; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.annotation
    ADD CONSTRAINT fknrnwt8d2s4kytg7mis2rg2a5x FOREIGN KEY (parent_annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_folder_to_facet fkohkkmadsw0xtk5qs2mx0y0npo; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkohkkmadsw0xtk5qs2mx0y0npo FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_classifier_to_facet fks9xsugq08k5ejrfha2540ups0; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fks9xsugq08k5ejrfha2540ups0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_versionedfolder_to_facet fksltt9c209xswibf8ocho4l8ly; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_versionedfolder_to_facet
    ADD CONSTRAINT fksltt9c209xswibf8ocho4l8ly FOREIGN KEY (versionedfolder_id) REFERENCES core.folder(id);


--
-- Name: join_folder_to_facet fksuj7eo7stfn56f1b0ci16uqc4; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fksuj7eo7stfn56f1b0ci16uqc4 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: rule_representation rule_representation_rule_id_fk; Type: FK CONSTRAINT; Schema: core; Owner: maurodatamapper
--

ALTER TABLE ONLY core.rule_representation
    ADD CONSTRAINT rule_representation_rule_id_fk FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataflow_to_facet fk18w0v8pjw1ejcppns1ovsaiuh; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk18w0v8pjw1ejcppns1ovsaiuh FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataelementcomponent_to_facet fk2458d1q7dlb53wk3i2f3tvn07; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fk2458d1q7dlb53wk3i2f3tvn07 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataflow_to_facet fk3desra9ff6a5m317j5emcbrb; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk3desra9ff6a5m317j5emcbrb FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_flow fk3fj19l4nvknojy3srxmkdfw5w; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fk3fj19l4nvknojy3srxmkdfw5w FOREIGN KEY (source_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataflow_to_facet fk4lftftotgkhj732e3cdofnua9; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk4lftftotgkhj732e3cdofnua9 FOREIGN KEY (dataflow_id) REFERENCES dataflow.data_flow(id);


--
-- Name: join_data_class_component_to_target_data_class fk5n8do09dd74fa9h1n73ovvule; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_target_data_class
    ADD CONSTRAINT fk5n8do09dd74fa9h1n73ovvule FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_data_class_component_to_source_data_class fk69j2bufggb1whkshma276fb3u; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_source_data_class
    ADD CONSTRAINT fk69j2bufggb1whkshma276fb3u FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_dataflow_to_facet fk6i15t337ti18ejj9g11ntw7wa; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk6i15t337ti18ejj9g11ntw7wa FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataelementcomponent_to_facet fk6oar34bhid29tojvm1ukllq7t; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fk6oar34bhid29tojvm1ukllq7t FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_data_element_component_to_target_data_element fk75eg0xy6obhx83sahuf43ftkn; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_target_data_element
    ADD CONSTRAINT fk75eg0xy6obhx83sahuf43ftkn FOREIGN KEY (data_element_id) REFERENCES datamodel.data_element(id);


--
-- Name: data_flow fk77hjma5cdtsc07lk9axb9uplj; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fk77hjma5cdtsc07lk9axb9uplj FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataclasscomponent_to_facet fk83mqbv5ca5sjld100rbiymsvs; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fk83mqbv5ca5sjld100rbiymsvs FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_element_component fk8q670e83q94a20x8urckoqhs7; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT fk8q670e83q94a20x8urckoqhs7 FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: data_class_component fk8qu1p2ejn32fxvwbtqmcb28d4; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT fk8qu1p2ejn32fxvwbtqmcb28d4 FOREIGN KEY (data_flow_id) REFERENCES dataflow.data_flow(id);


--
-- Name: join_data_class_component_to_source_data_class fk8rlgnf224u6byjb9mutxvj02d; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_source_data_class
    ADD CONSTRAINT fk8rlgnf224u6byjb9mutxvj02d FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclasscomponent_to_facet fk9nd41ujgegfisr6s7prcxle75; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fk9nd41ujgegfisr6s7prcxle75 FOREIGN KEY (dataclasscomponent_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_dataelementcomponent_to_facet fkbcxohbk6botm68gguiqulgveq; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkbcxohbk6botm68gguiqulgveq FOREIGN KEY (dataelementcomponent_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: join_dataclasscomponent_to_facet fkdataclasscomponent_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkdataclasscomponent_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelementcomponent_to_facet fkdataelementcomponent_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkdataelementcomponent_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataflow_to_facet fkdataflow_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkdataflow_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataclasscomponent_to_facet fke3nbbi9b4igb936kcxlx9lcxd; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fke3nbbi9b4igb936kcxlx9lcxd FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_class_component fkevgs9u7n7x5tr0a32ce3br9pi; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT fkevgs9u7n7x5tr0a32ce3br9pi FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_data_element_component_to_source_data_element fkfj2dcm6f4pug84c27slqx72sb; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_source_data_element
    ADD CONSTRAINT fkfj2dcm6f4pug84c27slqx72sb FOREIGN KEY (data_element_component_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: join_dataclasscomponent_to_facet fki22diqv42nnrxmhyki9f8sodi; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fki22diqv42nnrxmhyki9f8sodi FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelementcomponent_to_facet fkj8cv4bqtulig1rg7f0xikfr2d; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkj8cv4bqtulig1rg7f0xikfr2d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataclasscomponent_to_facet fkjnu3epst826kd40f60ktimo6k; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkjnu3epst826kd40f60ktimo6k FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_data_class_component_to_target_data_class fkjp8k503bbqqe4h6s0f7uygg8n; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_target_data_class
    ADD CONSTRAINT fkjp8k503bbqqe4h6s0f7uygg8n FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: data_flow fkl8uawgeg58jq51ydqqddm5d7g; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fkl8uawgeg58jq51ydqqddm5d7g FOREIGN KEY (target_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataclasscomponent_to_facet fkmfkn6if9k5q1k938jr5mx2lhw; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkmfkn6if9k5q1k938jr5mx2lhw FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataelementcomponent_to_facet fknf8wevvjjhglny27yn1yoav83; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fknf8wevvjjhglny27yn1yoav83 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_data_element_component_to_source_data_element fknmiwa6fd5ohwd00f0sk0wfx3t; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_source_data_element
    ADD CONSTRAINT fknmiwa6fd5ohwd00f0sk0wfx3t FOREIGN KEY (data_element_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_data_element_component_to_target_data_element fko677lt6vljfo4mcjbhn0y4bf6; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_target_data_element
    ADD CONSTRAINT fko677lt6vljfo4mcjbhn0y4bf6 FOREIGN KEY (data_element_component_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: data_element_component fkpfgnmog9cl0w1lmqoor55xq3p; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT fkpfgnmog9cl0w1lmqoor55xq3p FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataflow_to_facet fkpvp8i5ner679uom2d32bu59f7; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkpvp8i5ner679uom2d32bu59f7 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataflow_to_facet fkpwwfp2jwv5f5kwascasa113r1; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkpwwfp2jwv5f5kwascasa113r1 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelementcomponent_to_facet fkrs6wh8ahehpma0s81ysqruvgp; Type: FK CONSTRAINT; Schema: dataflow; Owner: maurodatamapper
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkrs6wh8ahehpma0s81ysqruvgp FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_datamodel_to_facet fk1ek18e3t2cki6fch7jmbbati0; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fk1ek18e3t2cki6fch7jmbbati0 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_datamodel_to_facet fk1yt7axbg37bynceoy6p06a5pk; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fk1yt7axbg37bynceoy6p06a5pk FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: data_class fk27usn28pto0b239mwltrfmksg; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk27usn28pto0b239mwltrfmksg FOREIGN KEY (data_model_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_enumerationvalue_to_facet fk40tuyaalgpyfdnp2wqfl1bl3b; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fk40tuyaalgpyfdnp2wqfl1bl3b FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_class fk4yr99q0xt49n31x48e78do1rq; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk4yr99q0xt49n31x48e78do1rq FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataclass_to_extended_data_class fk5cn7jgi02lejlubi97a3x17ar; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_extended_data_class
    ADD CONSTRAINT fk5cn7jgi02lejlubi97a3x17ar FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fk5n6b907728hblnk0ihhwhbac4; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fk5n6b907728hblnk0ihhwhbac4 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_model fk5vqrag93xcmptnduomuj1d5up; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fk5vqrag93xcmptnduomuj1d5up FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_datatype_to_facet fk685o5rkte9js4kibmx3e201ul; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fk685o5rkte9js4kibmx3e201ul FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_element fk6e7wo4o9bw27vk32roeo91cyn; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fk6e7wo4o9bw27vk32roeo91cyn FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: data_class fk71lrhqamsxh1b57sbigrgonq2; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk71lrhqamsxh1b57sbigrgonq2 FOREIGN KEY (parent_data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fk7tq9mj4pasf5fmebs2sc9ap86; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fk7tq9mj4pasf5fmebs2sc9ap86 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_element fk86to96ckvjf64qlwvosltcnsm; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fk86to96ckvjf64qlwvosltcnsm FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataelement_to_facet fk89immwtwlrbwrel10gjy3yimw; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fk89immwtwlrbwrel10gjy3yimw FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataclass_to_imported_data_class fk8bf683fj07ef7q6ua9ax5sipb; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_class
    ADD CONSTRAINT fk8bf683fj07ef7q6ua9ax5sipb FOREIGN KEY (imported_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataelement_to_facet fk8roq23ibhwodnpibdp1srk6aq; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fk8roq23ibhwodnpibdp1srk6aq FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: summary_metadata_report fk9auhycixx3nly0xthx9eg8i8y; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.summary_metadata_report
    ADD CONSTRAINT fk9auhycixx3nly0xthx9eg8i8y FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_enumerationvalue_to_facet fk9xuiuctli6j5hra8j0pw0xbib; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fk9xuiuctli6j5hra8j0pw0xbib FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_model fk9ybmrposbekl2h5pnwet4fx30; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fk9ybmrposbekl2h5pnwet4fx30 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: enumeration_value fkam3sx31p5a0eap02h4iu1nwsg; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT fkam3sx31p5a0eap02h4iu1nwsg FOREIGN KEY (enumeration_type_id) REFERENCES datamodel.data_type(id);


--
-- Name: join_dataclass_to_extended_data_class fkaph92y3qdyublukjj8mbsivo3; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_extended_data_class
    ADD CONSTRAINT fkaph92y3qdyublukjj8mbsivo3 FOREIGN KEY (extended_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_imported_data_element fkaywt9cf9pam7w7ieo2kyv64sb; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_element
    ADD CONSTRAINT fkaywt9cf9pam7w7ieo2kyv64sb FOREIGN KEY (imported_dataelement_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_datamodel_to_facet fkb1rfqfx6stfaote1vqbh0u65b; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkb1rfqfx6stfaote1vqbh0u65b FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_datamodel_to_facet fkb2bggjawxcb5pynsrnpwgw35q; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkb2bggjawxcb5pynsrnpwgw35q FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_datamodel_to_imported_data_type fkbax3mbjn9u65ahhb5t782hq7y; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_type
    ADD CONSTRAINT fkbax3mbjn9u65ahhb5t782hq7y FOREIGN KEY (imported_datatype_id) REFERENCES datamodel.data_type(id);


--
-- Name: data_type fkbqs2sknmwe6i3rtwrhflk9s5n; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fkbqs2sknmwe6i3rtwrhflk9s5n FOREIGN KEY (data_model_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataclass_to_facet fkc80l2pkf48a8sw4ijsudyaers; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkc80l2pkf48a8sw4ijsudyaers FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fkdataclass_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkdataclass_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelement_to_facet fkdataelement_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkdataelement_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_datamodel_to_facet fkdatamodel_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkdatamodel_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_datatype_to_facet fkdatatype_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkdatatype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelement_to_facet fkdn8e1l2pofwmdpfroe9bkhskm; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkdn8e1l2pofwmdpfroe9bkhskm FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelement_to_facet fke75uuv2w694ofrm1ogdqio495; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fke75uuv2w694ofrm1ogdqio495 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_enumerationvalue_to_facet fkenumerationvalue_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkenumerationvalue_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataclass_to_facet fkewipna2xjervio2w9rsem7vvu; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkewipna2xjervio2w9rsem7vvu FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_enumerationvalue_to_facet fkf8d99ketatffxmapoax1upmo8; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkf8d99ketatffxmapoax1upmo8 FOREIGN KEY (enumerationvalue_id) REFERENCES datamodel.enumeration_value(id);


--
-- Name: join_dataelement_to_facet fkg58co9t99dfp0076vkn23hemy; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkg58co9t99dfp0076vkn23hemy FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataclass_to_facet fkgeoshkis2b6trtu8c5etvg72n; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkgeoshkis2b6trtu8c5etvg72n FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_datatype_to_facet fkgfuqffr58ihdup07r1ys2rsts; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkgfuqffr58ihdup07r1ys2rsts FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_dataclass_to_facet fkgh9f6ok7n9wxwxopjku7yhfea; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkgh9f6ok7n9wxwxopjku7yhfea FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_datamodel_to_imported_data_class fkhlnup269u21f4tvdkt9sshg51; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_class
    ADD CONSTRAINT fkhlnup269u21f4tvdkt9sshg51 FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_datamodel_to_facet fkicjxoyym4mvpajl7amd2c96vg; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkicjxoyym4mvpajl7amd2c96vg FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_enumerationvalue_to_facet fkissxtxxag5rkhtjr2q1pivt64; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkissxtxxag5rkhtjr2q1pivt64 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: enumeration_value fkj6s22vawbgx8qbi6u95umov5t; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT fkj6s22vawbgx8qbi6u95umov5t FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_datatype_to_facet fkk6htfwfpc5ty1o1skmlw0ct5h; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkk6htfwfpc5ty1o1skmlw0ct5h FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_datamodel_to_facet fkk8m8u0b9dd216qsjdkbbttqmu; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkk8m8u0b9dd216qsjdkbbttqmu FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_datatype_to_facet fkka92tyn95wh23p9y7rjb1sila; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkka92tyn95wh23p9y7rjb1sila FOREIGN KEY (datatype_id) REFERENCES datamodel.data_type(id);


--
-- Name: data_model fkkq5e5fj5kdb737ktmhyyljy4e; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fkkq5e5fj5kdb737ktmhyyljy4e FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_datamodel_to_facet fkn8kvp5hpmtpu6t9ivldafifom; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkn8kvp5hpmtpu6t9ivldafifom FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_element fkncb91jl5cylo6nmoolmkif0y4; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fkncb91jl5cylo6nmoolmkif0y4 FOREIGN KEY (data_type_id) REFERENCES datamodel.data_type(id);


--
-- Name: join_datamodel_to_imported_data_class fkp7q1ry4kxlgldr6vtdqai1bns; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_class
    ADD CONSTRAINT fkp7q1ry4kxlgldr6vtdqai1bns FOREIGN KEY (imported_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_imported_data_element fkppmuveyr38fys2lw45kkp8n0s; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_element
    ADD CONSTRAINT fkppmuveyr38fys2lw45kkp8n0s FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datamodel_to_facet fkppqku5drbeh06ro6594sx7qpn; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkppqku5drbeh06ro6594sx7qpn FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_dataclass_to_facet fkpqpxtrqg9jh2ick2ug9mhcfxt; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkpqpxtrqg9jh2ick2ug9mhcfxt FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataelement_to_facet fkpsyiacoeuww886wy5apt5idwq; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkpsyiacoeuww886wy5apt5idwq FOREIGN KEY (dataelement_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_datatype_to_facet fkq73nqfoqdhodobkio53xnoroj; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkq73nqfoqdhodobkio53xnoroj FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelement_to_facet fkqef1ustdtk1irqjnohxwhlsxf; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkqef1ustdtk1irqjnohxwhlsxf FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_enumerationvalue_to_facet fkrefs16rh5cjm8rwngb9ijw9y1; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkrefs16rh5cjm8rwngb9ijw9y1 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_type fkribr7hv9shypnj2iru0hsx2sn; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fkribr7hv9shypnj2iru0hsx2sn FOREIGN KEY (reference_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datatype_to_facet fks3obp3gh2qp7lvl7c2ke33672; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fks3obp3gh2qp7lvl7c2ke33672 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_datamodel_to_imported_data_type fks8icj3nlbxt8bnrtnhpo81lg2; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_type
    ADD CONSTRAINT fks8icj3nlbxt8bnrtnhpo81lg2 FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: data_type fksiu83nftgdvb7kdvaik9fghsj; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fksiu83nftgdvb7kdvaik9fghsj FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_enumerationvalue_to_facet fkso04vaqmba4n4ffdbx5gg0fly; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkso04vaqmba4n4ffdbx5gg0fly FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataclass_to_imported_data_class fktfwuhg9cda52duj50ocsed0cl; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_class
    ADD CONSTRAINT fktfwuhg9cda52duj50ocsed0cl FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datatype_to_facet fkxyctuwpfqyqog98xf69enu2y; Type: FK CONSTRAINT; Schema: datamodel; Owner: maurodatamapper
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkxyctuwpfqyqog98xf69enu2y FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: reference_data_type fk21bionqtblyjus0xdx0fpxsd0; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT fk21bionqtblyjus0xdx0fpxsd0 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referenceenumerationvalue_to_facet fk2cfjn7dvabjkphwvne3jmhu24; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fk2cfjn7dvabjkphwvne3jmhu24 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_referencedataelement_to_facet fk2fki0p2nnwaurehb5cjttuvix; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fk2fki0p2nnwaurehb5cjttuvix FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_referencedataelement_to_facet fk2ls8wxo2ymrl7lpcys7j0xv3b; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fk2ls8wxo2ymrl7lpcys7j0xv3b FOREIGN KEY (referencedataelement_id) REFERENCES referencedata.reference_data_element(id);


--
-- Name: join_referencedatamodel_to_facet fk3jbl1c288a9m1wp6hpira3esu; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk3jbl1c288a9m1wp6hpira3esu FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: reference_data_value fk3ru68cbfsr7cx03c1szowx23u; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT fk3ru68cbfsr7cx03c1szowx23u FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referencedatatype_to_facet fk3vwe6oyjkdap164w7imcng9vx; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fk3vwe6oyjkdap164w7imcng9vx FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: reference_data_element fk5s8ym98wxlmji2cwd5c2uqx51; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fk5s8ym98wxlmji2cwd5c2uqx51 FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: reference_data_element fk72aidiwlq9doq630milqmpt0h; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fk72aidiwlq9doq630milqmpt0h FOREIGN KEY (reference_data_type_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: join_referencedatatype_to_facet fk7j8ag77c03icvomcohocy682d; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fk7j8ag77c03icvomcohocy682d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_data_model fk7jnsebhp01jrvj1cnoiglnk36; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fk7jnsebhp01jrvj1cnoiglnk36 FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_referenceenumerationvalue_to_facet fk87toxbm4bddbchculnipo9876; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fk87toxbm4bddbchculnipo9876 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: reference_data_model fk8dvr6bt8lf5xtces9vstu3h9i; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fk8dvr6bt8lf5xtces9vstu3h9i FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_referencedatamodel_to_facet fk8gio5kn4wbjxsb3vpxno2guty; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk8gio5kn4wbjxsb3vpxno2guty FOREIGN KEY (referencedatamodel_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referencedatamodel_to_facet fk8jwrx0ncwyb64s7d9ygmjr2f7; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk8jwrx0ncwyb64s7d9ygmjr2f7 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedatatype_to_facet fkag55g7g8434y1497a6jmldxlr; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkag55g7g8434y1497a6jmldxlr FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedataelement_to_facet fkb7mrla3ru59iox823w8cgdiy0; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkb7mrla3ru59iox823w8cgdiy0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedatatype_to_facet fkbw5w6fr1vaf9v0pcu7qs81nvu; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkbw5w6fr1vaf9v0pcu7qs81nvu FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkclc83k4qxd0yxfspwkkttsjmj; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkclc83k4qxd0yxfspwkkttsjmj FOREIGN KEY (referenceenumerationvalue_id) REFERENCES referencedata.reference_enumeration_value(id);


--
-- Name: join_referencedataelement_to_facet fkd3a65vscren7g42xw4rahy6g5; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkd3a65vscren7g42xw4rahy6g5 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_enumeration_value fkdh4kk2d1frpb2rfep76o7d6v8; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT fkdh4kk2d1frpb2rfep76o7d6v8 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkemx1xs8y5xnl1a6kdu18mp3us; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkemx1xs8y5xnl1a6kdu18mp3us FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedataelement_to_facet fketu75lbeuhiookwn6qawi4coq; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fketu75lbeuhiookwn6qawi4coq FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_enumeration_value fkfcsl5wvgo4hhgd32kio4vsxke; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT fkfcsl5wvgo4hhgd32kio4vsxke FOREIGN KEY (reference_enumeration_type_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: reference_data_element fkfmyjc00b03urjiavamg30vryh; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fkfmyjc00b03urjiavamg30vryh FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referencedatatype_to_facet fkggbf0ml2ou4b2k525xrb1mxq6; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkggbf0ml2ou4b2k525xrb1mxq6 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedatamodel_to_facet fkjiqw3v6crj988n5addti0ar4u; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkjiqw3v6crj988n5addti0ar4u FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_data_model fkk0dbj4ejwa3rpnm87ten7l650; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fkk0dbj4ejwa3rpnm87ten7l650 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referencedatamodel_to_facet fkksgi9yaaa427xe5saynb6rd2i; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkksgi9yaaa427xe5saynb6rd2i FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedatamodel_to_facet fkmn7qjcevpmoeq4rtudux34by; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkmn7qjcevpmoeq4rtudux34by FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_data_type fkn6ied2qohp1b9guvwcsskng2b; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT fkn6ied2qohp1b9guvwcsskng2b FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkp2io00cx587eojmbl5v27g7m3; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkp2io00cx587eojmbl5v27g7m3 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_referencedatamodel_to_facet fkpq9dfcuckjwcdeh9n54r062e0; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkpq9dfcuckjwcdeh9n54r062e0 FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkq50iqxdtfqwh3x6mdaepsx143; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkq50iqxdtfqwh3x6mdaepsx143 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedatatype_to_facet fkqaa9kx536h4hsp7prrv01ouay; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkqaa9kx536h4hsp7prrv01ouay FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: join_referencedataelement_to_facet fkqp0ri5bm3hvss6s1j3pyonkxr; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkqp0ri5bm3hvss6s1j3pyonkxr FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedataelement_to_facet fkreferencedataelement_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkreferencedataelement_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedatamodel_to_facet fkreferencedatamodel_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkreferencedatamodel_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedatatype_to_facet fkreferencedatatype_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkreferencedatatype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkreferenceenumerationvalue_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkreferenceenumerationvalue_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedataelement_to_facet fkrltsh3bwdh88lysiui0euxus8; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkrltsh3bwdh88lysiui0euxus8 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedatatype_to_facet fkser4c5ad6dkspbnyjl2r1yuj3; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkser4c5ad6dkspbnyjl2r1yuj3 FOREIGN KEY (referencedatatype_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: join_referencedatamodel_to_facet fktlkajagcv38bnatcquinb7p2v; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fktlkajagcv38bnatcquinb7p2v FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: reference_summary_metadata_report fktm1k29089tgksd63i7yjaha8g; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_summary_metadata_report
    ADD CONSTRAINT fktm1k29089tgksd63i7yjaha8g FOREIGN KEY (summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_data_value fkuknlrsbwja5t5vd84ceulvn9p; Type: FK CONSTRAINT; Schema: referencedata; Owner: maurodatamapper
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT fkuknlrsbwja5t5vd84ceulvn9p FOREIGN KEY (reference_data_element_id) REFERENCES referencedata.reference_data_element(id);


--
-- Name: group_role fk9y8ew5lpksnila4b7g56xcl1n; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT fk9y8ew5lpksnila4b7g56xcl1n FOREIGN KEY (parent_id) REFERENCES security.group_role(id);


--
-- Name: join_catalogue_user_to_user_group fkauyvlits5bug2jc362csx3m18; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT fkauyvlits5bug2jc362csx3m18 FOREIGN KEY (user_group_id) REFERENCES security.user_group(id);


--
-- Name: securable_resource_group_role fkdjitehknypyvc8rjpeiw9ri97; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT fkdjitehknypyvc8rjpeiw9ri97 FOREIGN KEY (user_group_id) REFERENCES security.user_group(id);


--
-- Name: securable_resource_group_role fkgxkys8feqb0jvmshenxe7hvig; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT fkgxkys8feqb0jvmshenxe7hvig FOREIGN KEY (group_role_id) REFERENCES security.group_role(id);


--
-- Name: api_key fkl8s3q1v3lg1crjh3kmqqbiwcu; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT fkl8s3q1v3lg1crjh3kmqqbiwcu FOREIGN KEY (catalogue_user_id) REFERENCES security.catalogue_user(id);


--
-- Name: user_group fknfw9gxi505amomyyy78665950; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT fknfw9gxi505amomyyy78665950 FOREIGN KEY (application_group_role_id) REFERENCES security.group_role(id);


--
-- Name: join_catalogue_user_to_user_group fkr4d5x0mewom4ibi8h9qy61ycc; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT fkr4d5x0mewom4ibi8h9qy61ycc FOREIGN KEY (catalogue_user_id) REFERENCES security.catalogue_user(id);


--
-- Name: catalogue_user fkrvd4rw9ujjx4ca9b4dkps3jyt; Type: FK CONSTRAINT; Schema: security; Owner: maurodatamapper
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT fkrvd4rw9ujjx4ca9b4dkps3jyt FOREIGN KEY (profile_picture_id) REFERENCES core.user_image_file(id);


--
-- Name: join_termrelationshiptype_to_facet fk16s1q7crb8ipqjg55yc7mmjqm; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk16s1q7crb8ipqjg55yc7mmjqm FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: code_set fk2jwton4ry4smlk76tax1n1j5p; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fk2jwton4ry4smlk76tax1n1j5p FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_term_to_facet fk30th9e8a75qjf08804ttebhsm; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk30th9e8a75qjf08804ttebhsm FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationship_to_facet fk334wl2e2hfjm3641dvx9kbvrr; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk334wl2e2hfjm3641dvx9kbvrr FOREIGN KEY (termrelationship_id) REFERENCES terminology.term_relationship(id);


--
-- Name: join_termrelationshiptype_to_facet fk3ampvxuqr5vc4wnpha04k33in; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk3ampvxuqr5vc4wnpha04k33in FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationshiptype_to_facet fk4p7n1lms874i479o632m3u0bc; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk4p7n1lms874i479o632m3u0bc FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_termrelationship_to_facet fk5nnjqhchac10vbq4dnturf43d; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk5nnjqhchac10vbq4dnturf43d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fk5w07m1k4c62vcduljr349h48j; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk5w07m1k4c62vcduljr349h48j FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_codeset_to_facet fk6cgrkxpermch26tfb07629so4; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fk6cgrkxpermch26tfb07629so4 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fk6kxdv6f6gqa7xkm2bcywsohxy; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk6kxdv6f6gqa7xkm2bcywsohxy FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: terminology fk7dlm65qgt6m8ptacxycqyhl4m; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fk7dlm65qgt6m8ptacxycqyhl4m FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_term_to_facet fk7jn78931gti2jluti9tm592p0; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk7jn78931gti2jluti9tm592p0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_termrelationship_to_facet fk7mj3h26tgnbprkogynq8ws1mx; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk7mj3h26tgnbprkogynq8ws1mx FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_codeset_to_facet fk7t7ilhhckw9qf6xrn1ubfm7d5; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fk7t7ilhhckw9qf6xrn1ubfm7d5 FOREIGN KEY (codeset_id) REFERENCES terminology.code_set(id);


--
-- Name: terminology fk8kiyjbnrjas88qosgt78fdue5; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fk8kiyjbnrjas88qosgt78fdue5 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_terminology_to_facet fk8rh0jwsnqbg5wj37sabpxt808; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fk8rh0jwsnqbg5wj37sabpxt808 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_term_to_facet fk9bpl4j09xy1seyx3iaaueyapu; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk9bpl4j09xy1seyx3iaaueyapu FOREIGN KEY (term_id) REFERENCES terminology.term(id);


--
-- Name: join_termrelationship_to_facet fk9jq2jv72rf5xm5qvhw2808477; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk9jq2jv72rf5xm5qvhw2808477 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: term_relationship fka5wounncpjf0fcv4fpd12j10g; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fka5wounncpjf0fcv4fpd12j10g FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_term_to_facet fkahmuw6nlc4rr8afxo7jw47wdf; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkahmuw6nlc4rr8afxo7jw47wdf FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: term fkcdm4c5ljr1inp380r0bsce94s; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT fkcdm4c5ljr1inp380r0bsce94s FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_codeset_to_facet fkcodeset_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkcodeset_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkcu5iih9ugs9y5guu5mqwdymae; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkcu5iih9ugs9y5guu5mqwdymae FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: term_relationship fkd55uv21yk0qoax6ofaxbg5x9w; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fkd55uv21yk0qoax6ofaxbg5x9w FOREIGN KEY (target_term_id) REFERENCES terminology.term(id);


--
-- Name: join_codeset_to_facet fkd6o1dmjdok9j9f4kk9kry3nlo; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkd6o1dmjdok9j9f4kk9kry3nlo FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_codeset_to_facet fkf251q9vbfhi6t007drkr0ot56; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkf251q9vbfhi6t007drkr0ot56 FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_codeset_to_facet fkf977e6gh0go5gsb1mdypxq5qm; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkf977e6gh0go5gsb1mdypxq5qm FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: code_set fkfxs2u8sgiov5x5jf40oy3q2y3; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fkfxs2u8sgiov5x5jf40oy3q2y3 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_codeset_to_term fkgova93e87cae5ibqn41b9i81q; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_term
    ADD CONSTRAINT fkgova93e87cae5ibqn41b9i81q FOREIGN KEY (codeset_id) REFERENCES terminology.code_set(id);


--
-- Name: join_termrelationship_to_facet fkgx7mfxmfac6cjqhwfy8e0pema; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fkgx7mfxmfac6cjqhwfy8e0pema FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: terminology fkh0m1mr4fvlw79xuod2uffrvhx; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fkh0m1mr4fvlw79xuod2uffrvhx FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_terminology_to_facet fki6m0bt3anil9c8xa1vkro2sex; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fki6m0bt3anil9c8xa1vkro2sex FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fkimkg4xk0vgadayww633utts6m; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fkimkg4xk0vgadayww633utts6m FOREIGN KEY (termrelationshiptype_id) REFERENCES terminology.term_relationship_type(id);


--
-- Name: join_codeset_to_facet fkis38oricalv28ssx3swcyfqe0; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkis38oricalv28ssx3swcyfqe0 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationship_to_facet fkkejqseo866piupm5aos0tcewt; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fkkejqseo866piupm5aos0tcewt FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: term_relationship_type fkksj1p00n2s6upo53rj0g2rcln; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT fkksj1p00n2s6upo53rj0g2rcln FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_terminology_to_facet fkmutj2dw99jmqoiyqs7elxax0b; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkmutj2dw99jmqoiyqs7elxax0b FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: term_relationship fknaqfdwx75pqsv1x4yk4nopa8s; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fknaqfdwx75pqsv1x4yk4nopa8s FOREIGN KEY (source_term_id) REFERENCES terminology.term(id);


--
-- Name: join_codeset_to_facet fkopyxyabfcixr8q5p4tdfiatw; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkopyxyabfcixr8q5p4tdfiatw FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: code_set fkp5k3i717iool706wniwjjvwv3; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fkp5k3i717iool706wniwjjvwv3 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: term_relationship fkpjx0bwxtjt6qewxak7fpgr0pk; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fkpjx0bwxtjt6qewxak7fpgr0pk FOREIGN KEY (relationship_type_id) REFERENCES terminology.term_relationship_type(id);


--
-- Name: term fkpry3m6mjob704x9e0w56auich; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT fkpry3m6mjob704x9e0w56auich FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_term_to_facet fkpvf7f5wddn60lwuucualmnfcu; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkpvf7f5wddn60lwuucualmnfcu FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: term_relationship_type fkqlbqof0u5k91mxq16h2f1p2p8; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT fkqlbqof0u5k91mxq16h2f1p2p8 FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_codeset_to_term fkrce6i901t3rmqwa7oh215fc99; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_codeset_to_term
    ADD CONSTRAINT fkrce6i901t3rmqwa7oh215fc99 FOREIGN KEY (term_id) REFERENCES terminology.term(id);


--
-- Name: join_term_to_facet fks9timcfrvfej60b2b0pinlxs0; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fks9timcfrvfej60b2b0pinlxs0 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_terminology_to_facet fksk9svegop687oy8527bni5mxl; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fksk9svegop687oy8527bni5mxl FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_terminology_to_facet fkt5xk7gkhiyj0y1snpsqhgwnhk; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkt5xk7gkhiyj0y1snpsqhgwnhk FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_term_to_facet fkterm_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkterm_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkterminology_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkterminology_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_termrelationship_to_facet fktermrelationship_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fktermrelationship_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_termrelationshiptype_to_facet fktermrelationshiptype_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fktermrelationshiptype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkti72ejs5r77aweqn2voaukggw; Type: FK CONSTRAINT; Schema: terminology; Owner: maurodatamapper
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkti72ejs5r77aweqn2voaukggw FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- PostgreSQL database dump complete
--

