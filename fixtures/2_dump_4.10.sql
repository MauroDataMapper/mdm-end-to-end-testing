--
-- PostgreSQL database dump
--

-- Dumped from database version 12.0
-- Dumped by pg_dump version 12.0

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
-- Name: core; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA core;


--
-- Name: dataflow; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dataflow;


--
-- Name: datamodel; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA datamodel;


--
-- Name: federation; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA federation;


--
-- Name: referencedata; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA referencedata;


--
-- Name: security; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA security;


--
-- Name: terminology; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA terminology;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: annotation; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: api_property; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: authority; Type: TABLE; Schema: core; Owner: -
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
    description text,
    default_authority boolean DEFAULT false NOT NULL
);


--
-- Name: breadcrumb_tree; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: classifier; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: edit; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: email; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: flyway_schema_history; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: folder; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: join_classifier_to_facet; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.join_classifier_to_facet (
    classifier_id uuid NOT NULL,
    annotation_id uuid,
    rule_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid
);


--
-- Name: join_folder_to_facet; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.join_folder_to_facet (
    folder_id uuid NOT NULL,
    annotation_id uuid,
    rule_id uuid,
    semantic_link_id uuid,
    reference_file_id uuid,
    metadata_id uuid
);


--
-- Name: join_versionedfolder_to_facet; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.join_versionedfolder_to_facet (
    versionedfolder_id uuid NOT NULL,
    version_link_id uuid
);


--
-- Name: metadata; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: reference_file; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: rule; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: rule_representation; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: semantic_link; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: user_image_file; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: version_link; Type: TABLE; Schema: core; Owner: -
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


--
-- Name: data_class_component; Type: TABLE; Schema: dataflow; Owner: -
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


--
-- Name: data_element_component; Type: TABLE; Schema: dataflow; Owner: -
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


--
-- Name: data_flow; Type: TABLE; Schema: dataflow; Owner: -
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


--
-- Name: flyway_schema_history; Type: TABLE; Schema: dataflow; Owner: -
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


--
-- Name: join_data_class_component_to_source_data_class; Type: TABLE; Schema: dataflow; Owner: -
--

CREATE TABLE dataflow.join_data_class_component_to_source_data_class (
    data_class_component_id uuid NOT NULL,
    data_class_id uuid
);


--
-- Name: join_data_class_component_to_target_data_class; Type: TABLE; Schema: dataflow; Owner: -
--

CREATE TABLE dataflow.join_data_class_component_to_target_data_class (
    data_class_component_id uuid NOT NULL,
    data_class_id uuid
);


--
-- Name: join_data_element_component_to_source_data_element; Type: TABLE; Schema: dataflow; Owner: -
--

CREATE TABLE dataflow.join_data_element_component_to_source_data_element (
    data_element_component_id uuid NOT NULL,
    data_element_id uuid
);


--
-- Name: join_data_element_component_to_target_data_element; Type: TABLE; Schema: dataflow; Owner: -
--

CREATE TABLE dataflow.join_data_element_component_to_target_data_element (
    data_element_component_id uuid NOT NULL,
    data_element_id uuid
);


--
-- Name: join_dataclasscomponent_to_facet; Type: TABLE; Schema: dataflow; Owner: -
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


--
-- Name: join_dataelementcomponent_to_facet; Type: TABLE; Schema: dataflow; Owner: -
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


--
-- Name: join_dataflow_to_facet; Type: TABLE; Schema: dataflow; Owner: -
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


--
-- Name: data_class; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: data_element; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: data_model; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: data_type; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: enumeration_value; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: flyway_schema_history; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: join_dataclass_to_extended_data_class; Type: TABLE; Schema: datamodel; Owner: -
--

CREATE TABLE datamodel.join_dataclass_to_extended_data_class (
    dataclass_id uuid NOT NULL,
    extended_dataclass_id uuid NOT NULL
);


--
-- Name: join_dataclass_to_facet; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: join_dataclass_to_imported_data_class; Type: TABLE; Schema: datamodel; Owner: -
--

CREATE TABLE datamodel.join_dataclass_to_imported_data_class (
    imported_dataclass_id uuid NOT NULL,
    dataclass_id uuid NOT NULL
);


--
-- Name: join_dataclass_to_imported_data_element; Type: TABLE; Schema: datamodel; Owner: -
--

CREATE TABLE datamodel.join_dataclass_to_imported_data_element (
    dataclass_id uuid NOT NULL,
    imported_dataelement_id uuid NOT NULL
);


--
-- Name: join_dataelement_to_facet; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: join_datamodel_to_facet; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: join_datamodel_to_imported_data_class; Type: TABLE; Schema: datamodel; Owner: -
--

CREATE TABLE datamodel.join_datamodel_to_imported_data_class (
    imported_dataclass_id uuid NOT NULL,
    datamodel_id uuid NOT NULL
);


--
-- Name: join_datamodel_to_imported_data_type; Type: TABLE; Schema: datamodel; Owner: -
--

CREATE TABLE datamodel.join_datamodel_to_imported_data_type (
    imported_datatype_id uuid NOT NULL,
    datamodel_id uuid NOT NULL
);


--
-- Name: join_datatype_to_facet; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: join_enumerationvalue_to_facet; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: summary_metadata; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: summary_metadata_report; Type: TABLE; Schema: datamodel; Owner: -
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


--
-- Name: flyway_schema_history; Type: TABLE; Schema: federation; Owner: -
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


--
-- Name: subscribed_catalogue; Type: TABLE; Schema: federation; Owner: -
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
    api_key uuid,
    refresh_period integer NOT NULL,
    label text NOT NULL,
    description text,
    last_read timestamp without time zone
);


--
-- Name: subscribed_model; Type: TABLE; Schema: federation; Owner: -
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


--
-- Name: flyway_schema_history; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: join_referencedataelement_to_facet; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: join_referencedatamodel_to_facet; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: join_referencedatatype_to_facet; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: join_referenceenumerationvalue_to_facet; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: reference_data_element; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: reference_data_model; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: reference_data_type; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: reference_data_value; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: reference_enumeration_value; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: reference_summary_metadata; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: reference_summary_metadata_report; Type: TABLE; Schema: referencedata; Owner: -
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


--
-- Name: api_key; Type: TABLE; Schema: security; Owner: -
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


--
-- Name: catalogue_user; Type: TABLE; Schema: security; Owner: -
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
    last_login timestamp without time zone,
    creation_method character varying(255) NOT NULL
);


--
-- Name: flyway_schema_history; Type: TABLE; Schema: security; Owner: -
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


--
-- Name: group_role; Type: TABLE; Schema: security; Owner: -
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


--
-- Name: join_catalogue_user_to_user_group; Type: TABLE; Schema: security; Owner: -
--

CREATE TABLE security.join_catalogue_user_to_user_group (
    catalogue_user_id uuid NOT NULL,
    user_group_id uuid NOT NULL
);


--
-- Name: securable_resource_group_role; Type: TABLE; Schema: security; Owner: -
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


--
-- Name: user_group; Type: TABLE; Schema: security; Owner: -
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


--
-- Name: code_set; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: flyway_schema_history; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: join_codeset_to_facet; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: join_codeset_to_term; Type: TABLE; Schema: terminology; Owner: -
--

CREATE TABLE terminology.join_codeset_to_term (
    term_id uuid NOT NULL,
    codeset_id uuid NOT NULL
);


--
-- Name: join_term_to_facet; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: join_terminology_to_facet; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: join_termrelationship_to_facet; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: join_termrelationshiptype_to_facet; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: term; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: term_relationship; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: term_relationship_type; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Name: terminology; Type: TABLE; Schema: terminology; Owner: -
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


--
-- Data for Name: annotation; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.annotation (id, version, date_created, last_updated, path, multi_facet_aware_item_domain_type, depth, multi_facet_aware_item_id, parent_annotation_id, created_by, label, description, child_annotations_idx) FROM stdin;
40b82481-3a99-4d35-9dc0-de172365896a	0	2021-10-04 13:23:13.519709	2021-10-04 13:23:13.519709		DataModel	0	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	\N	development@test.com	test annotation 1	\N	\N
a5d5bcbf-b7d5-4c2f-9088-27b09e53b3c7	0	2021-10-04 13:23:13.520646	2021-10-04 13:23:13.520646		DataModel	0	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	\N	development@test.com	test annotation 2	with description	\N
57c2d27f-e592-402b-857d-b7e456c37b73	0	2021-10-04 13:23:14.35597	2021-10-04 13:23:14.35597		DataModel	0	6e73dcde-8ce7-4c45-b37d-0494e55394c9	\N	development@test.com	Finalised Model	DataModel finalised by null null on 2021-10-04T12:23:14.259Z	\N
3aaec6ef-33b0-4809-ba0f-f01d5958afc8	0	2021-10-04 13:23:14.870241	2021-10-04 13:23:14.870241		DataModel	0	926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	development@test.com	Finalised Model	DataModel finalised by null null on 2021-10-04T12:23:14.837Z	\N
c6cbb6c5-e69b-4dad-8bf5-092b1c542206	0	2021-10-04 13:23:15.957972	2021-10-04 13:23:15.957972		DataModel	0	c84fb099-79bc-496a-8901-75c99d539fbd	\N	development@test.com	versioning annotation 1	\N	\N
377c2564-8b8d-4ee7-93ae-d15853accb9d	0	2021-10-04 13:23:15.958536	2021-10-04 13:23:15.958536		DataModel	0	c84fb099-79bc-496a-8901-75c99d539fbd	\N	development@test.com	versioning annotation 2	with description	\N
e752192a-ea87-4aee-9470-bbcc9f398154	0	2021-10-04 13:23:16.072639	2021-10-04 13:23:16.072639		DataModel	0	c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	development@test.com	Finalised Model	DataModel finalised by null null on 2021-10-04T12:23:16.035Z	\N
9fc9b819-90f7-4df4-a84f-96b5d738a4a6	0	2021-10-04 13:23:16.398844	2021-10-04 13:23:16.398844		DataModel	0	94f194ee-79db-4835-840e-4168bc4d9331	\N	development@test.com	Finalised Model	DataModel finalised by null null on 2021-10-04T12:23:16.367Z	\N
3d27e254-f74f-447b-88f0-70764221d262	0	2021-10-04 13:23:17.006285	2021-10-04 13:23:17.006285		DataModel	0	726b5b98-4b02-433d-9e3b-249f139a27dc	\N	development@test.com	Finalised Model	DataModel finalised by null null on 2021-10-04T12:23:16.977Z	\N
01268021-19f0-4857-b2cc-7ccad1ad2633	0	2021-10-04 13:23:17.488786	2021-10-04 13:23:17.488786		DataModel	0	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	development@test.com	Finalised Model	DataModel finalised by null null on 2021-10-04T12:23:17.457Z	\N
1a916c53-f6de-4aba-aa18-7bf3d2544615	0	2021-10-04 13:23:19.43659	2021-10-04 13:23:19.43659		Terminology	0	fa8b47d9-daae-4d61-a682-2a93a893c6ca	\N	development@test.com	test annotation 1	\N	\N
e3019892-36d7-45ba-b4bf-4fa02d29a1e7	0	2021-10-04 13:23:19.437096	2021-10-04 13:23:19.437096		Terminology	0	fa8b47d9-daae-4d61-a682-2a93a893c6ca	\N	development@test.com	test annotation 2	with description	\N
\.


--
-- Data for Name: api_property; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.api_property (id, version, last_updated_by, date_created, last_updated, value, created_by, key, publicly_visible, category) FROM stdin;
859326fa-2187-425a-b42c-c349752a36d6	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.029275	2021-10-04 13:23:12.029275	Dear ${firstName},\nYou have been invited to edit the model '${itemLabel}' in the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour password is: ${tempPassword}\n and you will be asked to update this when you first log on.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.invite_edit.body	f	Email
3842053e-ba8c-41b2-8064-2c8bb1c0c5cf	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.075398	2021-10-04 13:23:12.075398	Dear ${firstName},\nYou have been given access to the Mauro Data Mapper at ${catalogueUrl} \n\nYour username / email address is: ${emailAddress} \nYour password is: ${tempPassword} \nand you will be asked to update this when you first log on.\n\nKind regards, the Mauro Data Mapper folks. \n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.admin_register.body	f	Email
77ea7b6a-1ac7-4dd5-a825-d890504f7868	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.07628	2021-10-04 13:23:12.07628	Mauro Data Mapper Registration	bootstrap.user@maurodatamapper.com	email.admin_register.subject	f	Email
057899b0-5c33-41a1-98c7-b87e3ce916ed	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.076915	2021-10-04 13:23:12.076915	Mauro Data Mapper Registration	bootstrap.user@maurodatamapper.com	email.self_register.subject	f	Email
bf154ad7-987f-40fc-b3e4-29a57386b033	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.077652	2021-10-04 13:23:12.077652	Mauro Data Mapper Forgotten Password	bootstrap.user@maurodatamapper.com	email.forgotten_password.subject	f	Email
1ea4c4af-c55c-456d-8e6b-8156470bef66	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.078916	2021-10-04 13:23:12.078916	Mauro Data Mapper Invitation	bootstrap.user@maurodatamapper.com	email.invite_edit.subject	f	Email
7fa5a8b4-5e40-4bbb-be42-22a7b2a756a6	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.080113	2021-10-04 13:23:12.080113	Mauro Data Mapper Invitation	bootstrap.user@maurodatamapper.com	email.invite_view.subject	f	Email
5ef8bdbb-a76a-4eb2-85b7-55d6920976f6	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.081956	2021-10-04 13:23:12.081956	Dear ${firstName},\nYour registration for the Mauro Data Mapper at ${catalogueUrl} has been confirmed.\n\nYour username / email address is: ${emailAddress} \nYou chose a password on registration, but can reset it from the login page.\n\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.admin_confirm_registration.body	f	Email
dca466fc-92e9-4a4e-b8e6-c4599db5ffd7	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.08303	2021-10-04 13:23:12.08303	Dear ${firstName},\nYou have self-registered for the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour registration is marked as pending: you'll be sent another email when your request has been confirmed by an administrator. \nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.self_register.body	f	Email
ee340796-42c2-447f-8df4-b5bb32fb1696	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.08388	2021-10-04 13:23:12.08388	Dear ${firstName},\nYour password has been reset for the Mauro Data Mapper at ${catalogueUrl}.\n\nYour new temporary password is: ${tempPassword} \nand you will be asked to update this when you next log on.\n\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.password_reset.body	f	Email
14608539-2ff1-4213-a117-35e8fd80c0dd	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.084508	2021-10-04 13:23:12.084508	Mauro Data Mapper	bootstrap.user@maurodatamapper.com	email.from.name	f	Email
ee2b7160-7ab6-43b5-a85b-93ef3c850efd	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.085077	2021-10-04 13:23:12.085077	Mauro Data Mapper Registration - Confirmation	bootstrap.user@maurodatamapper.com	email.admin_confirm_registration.subject	f	Email
7b11b54f-0480-45a1-81a5-b7d7028f29c7	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.08564	2021-10-04 13:23:12.08564	Dear ${firstName},\nA request has been made to reset the password for the Mauro Data Mapper at ${catalogueUrl}.\nIf you did not make this request please ignore this email.\n\nPlease use the following link to reset your password ${passwordResetLink}.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.forgotten_password.body	f	Email
3381dc84-e75f-4f81-99cb-f7f506d1e81a	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.086207	2021-10-04 13:23:12.086207	Mauro Data Mapper Password Reset	bootstrap.user@maurodatamapper.com	email.password_reset.subject	f	Email
64023f24-1b3f-42ba-a8d1-b41fe0d6d55d	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.086773	2021-10-04 13:23:12.086773	Dear ${firstName},\nYou have been invited to view the item '${itemLabel}' in the Mauro Data Mapper at ${catalogueUrl}\n\nYour username / email address is: ${emailAddress}\nYour password is: ${tempPassword}\n and you will be asked to update this when you first log on.\nKind regards, the Mauro Data Mapper folks.\n\n(This is an automated mail).	bootstrap.user@maurodatamapper.com	email.invite_view.body	f	Email
deb0a1c0-1998-40c3-8d32-c98919fbb614	0	bootstrap.user@maurodatamapper.com	2021-10-04 13:23:12.205463	2021-10-04 13:23:12.205463	username@gmail.com	bootstrap.user@maurodatamapper.com	email.from.address	f	Email
\.


--
-- Data for Name: authority; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.authority (id, version, date_created, last_updated, readable_by_authenticated_users, url, created_by, readable_by_everyone, label, description, default_authority) FROM stdin;
b5f79af9-dd57-4da3-844e-122cd65cd031	0	2021-10-04 13:23:12.31646	2021-10-04 13:23:12.31646	t	http://localhost	admin@maurodatamapper.com	t	Mauro Data Mapper	\N	t
\.


--
-- Data for Name: breadcrumb_tree; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.breadcrumb_tree (id, version, domain_type, finalised, domain_id, tree_string, top_breadcrumb_tree, label, parent_id) FROM stdin;
8e41bee3-e71d-41c2-a9a7-033b77074fd2	4	PrimitiveType	\N	29f5ecf2-270f-4efe-b4a2-04095a88520d	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n29f5ecf2-270f-4efe-b4a2-04095a88520d|PrimitiveType|string|null	f	string	72897474-1e20-4f02-8dae-61a2b39a3484
97a34419-c338-4475-9c57-bbf0f528a625	4	PrimitiveType	\N	fd61aec8-104f-4ecf-b4cc-7d54fec0c950	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\nfd61aec8-104f-4ecf-b4cc-7d54fec0c950|PrimitiveType|integer|null	f	integer	72897474-1e20-4f02-8dae-61a2b39a3484
a96e6f9a-dde2-40af-a91c-442d9e74a93f	4	EnumerationValue	\N	2906de04-8fcb-4fd6-b264-65d50661de1a	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n06d39cc7-abb4-4e88-bd98-9fbff34aedbd|EnumerationType|yesnounknown|null\n2906de04-8fcb-4fd6-b264-65d50661de1a|EnumerationValue|U|null	f	U	edca429b-ada6-4d0c-b994-2c035ee18530
b41f52a7-0f74-4284-9c23-26016bab070f	2	DataElement	\N	310ed824-0d34-4b3a-9c76-055df6604773	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n83fba1d1-0d86-4178-9dbe-91b6554d2b70|DataClass|content|null\n310ed824-0d34-4b3a-9c76-055df6604773|DataElement|element2|null	f	element2	e253d5d8-7811-4d04-a42b-9d8937821415
c892ca80-4707-43e4-82cf-84b4d4b6536d	4	DataClass	\N	ae701c79-ea4a-4e1f-be85-281f2e7281dd	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\nae701c79-ea4a-4e1f-be85-281f2e7281dd|DataClass|parent|null	f	parent	72897474-1e20-4f02-8dae-61a2b39a3484
e1f04439-e484-4296-a577-3772a7cf48cd	4	EnumerationValue	\N	fcdffb5e-d0b9-4653-9159-2cfd205ad5fb	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n06d39cc7-abb4-4e88-bd98-9fbff34aedbd|EnumerationType|yesnounknown|null\nfcdffb5e-d0b9-4653-9159-2cfd205ad5fb|EnumerationValue|N|null	f	N	edca429b-ada6-4d0c-b994-2c035ee18530
e253d5d8-7811-4d04-a42b-9d8937821415	2	DataClass	\N	83fba1d1-0d86-4178-9dbe-91b6554d2b70	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n83fba1d1-0d86-4178-9dbe-91b6554d2b70|DataClass|content|null	f	content	72897474-1e20-4f02-8dae-61a2b39a3484
edca429b-ada6-4d0c-b994-2c035ee18530	4	EnumerationType	\N	06d39cc7-abb4-4e88-bd98-9fbff34aedbd	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n06d39cc7-abb4-4e88-bd98-9fbff34aedbd|EnumerationType|yesnounknown|null	f	yesnounknown	72897474-1e20-4f02-8dae-61a2b39a3484
0f2ef7bf-67f4-4b79-b2d5-3b8a6b738c9d	2	DataElement	\N	6bf2400f-a673-422b-ab73-62b658f81b55	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n83fba1d1-0d86-4178-9dbe-91b6554d2b70|DataClass|content|null\n6bf2400f-a673-422b-ab73-62b658f81b55|DataElement|ele1|null	f	ele1	e253d5d8-7811-4d04-a42b-9d8937821415
23e16092-31db-457b-aeb2-e3242983ddaa	2	DataElement	\N	f2eef249-8c87-4236-8c42-9395972f2937	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\nae701c79-ea4a-4e1f-be85-281f2e7281dd|DataClass|parent|null\nf2eef249-8c87-4236-8c42-9395972f2937|DataElement|child|null	f	child	c892ca80-4707-43e4-82cf-84b4d4b6536d
50a3d251-1ea6-4abc-af47-0e29a954ca1a	2	ReferenceType	\N	4e4203aa-47ae-4a9d-9001-a18e91f504f2	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n4e4203aa-47ae-4a9d-9001-a18e91f504f2|ReferenceType|child|null	f	child	72897474-1e20-4f02-8dae-61a2b39a3484
6af0f078-725d-42b7-bce2-9aa2e640b4cf	4	DataClass	\N	e514a0eb-0b16-40c9-926a-363d9ac23d8b	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\ne514a0eb-0b16-40c9-926a-363d9ac23d8b|DataClass|emptyclass|null	f	emptyclass	72897474-1e20-4f02-8dae-61a2b39a3484
72897474-1e20-4f02-8dae-61a2b39a3484	6	DataModel	f	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false	t	Complex Test DataModel	\N
78a77d3e-8802-449f-9e1a-1e325020003a	4	EnumerationValue	\N	f0520e45-c4e1-49f7-949a-0bb2b88b17c2	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\n06d39cc7-abb4-4e88-bd98-9fbff34aedbd|EnumerationType|yesnounknown|null\nf0520e45-c4e1-49f7-949a-0bb2b88b17c2|EnumerationValue|Y|null	f	Y	edca429b-ada6-4d0c-b994-2c035ee18530
7bbb9a9a-8c8e-4ede-8838-817badea05e2	4	DataClass	\N	eb60ac95-5b35-4d6e-a01a-1b5b9a5d70c0	fd8e9d84-825e-4fa7-a070-5301bf6c89e5|DataModel|Complex Test DataModel|false\nae701c79-ea4a-4e1f-be85-281f2e7281dd|DataClass|parent|null\neb60ac95-5b35-4d6e-a01a-1b5b9a5d70c0|DataClass|child|null	f	child	c892ca80-4707-43e4-82cf-84b4d4b6536d
d4a492d3-e5aa-41b5-ab5a-2b392da45a99	2	DataModel	f	dc5e3bb9-9119-4540-a586-2f55380e49f4	dc5e3bb9-9119-4540-a586-2f55380e49f4|DataModel|Simple Test DataModel|false	t	Simple Test DataModel	\N
1e1de73f-46ad-4897-86dc-69699ac62e71	1	DataClass	\N	68d946d6-a0da-4859-a4df-7c14c9831d38	dc5e3bb9-9119-4540-a586-2f55380e49f4|DataModel|Simple Test DataModel|false\n68d946d6-a0da-4859-a4df-7c14c9831d38|DataClass|simple|null	f	simple	d4a492d3-e5aa-41b5-ab5a-2b392da45a99
07970cd2-17f4-4b7c-ae33-20cf4acd1965	2	DataModel	t	f9f834b7-74f5-4b0c-997a-044ac335a9f4	f9f834b7-74f5-4b0c-997a-044ac335a9f4|DataModel|Finalised Example Test DataModel|true	t	Finalised Example Test DataModel	\N
43b9cf21-3137-4587-9375-2943d0893117	1	DataClass	\N	50ea6b13-9b75-4fbc-b611-747988ab0afb	f9f834b7-74f5-4b0c-997a-044ac335a9f4|DataModel|Finalised Example Test DataModel|true\n50ea6b13-9b75-4fbc-b611-747988ab0afb|DataClass|Finalised Data Class|null	f	Finalised Data Class	07970cd2-17f4-4b7c-ae33-20cf4acd1965
9825a25c-c249-46fa-8b98-2b9f971aaf20	2	DataElement	\N	33e1bfca-abbb-4645-ac2c-c559499a23e8	f9f834b7-74f5-4b0c-997a-044ac335a9f4|DataModel|Finalised Example Test DataModel|true\n50ea6b13-9b75-4fbc-b611-747988ab0afb|DataClass|Finalised Data Class|null\n33e1bfca-abbb-4645-ac2c-c559499a23e8|DataElement|Finalised Data Element|null	f	Finalised Data Element	43b9cf21-3137-4587-9375-2943d0893117
b5e6f595-97cd-4183-83a3-8f39ee05f45e	2	DataClass	\N	913a731c-bfd9-4d82-8c59-224ca983a8cd	f9f834b7-74f5-4b0c-997a-044ac335a9f4|DataModel|Finalised Example Test DataModel|true\n913a731c-bfd9-4d82-8c59-224ca983a8cd|DataClass|Another Data Class|null	f	Another Data Class	07970cd2-17f4-4b7c-ae33-20cf4acd1965
d044f0ac-ce9f-43c9-a083-f8ca8b485f3e	2	DataElement	\N	6be94c01-f0e3-4810-8156-eabc5d48cee5	f9f834b7-74f5-4b0c-997a-044ac335a9f4|DataModel|Finalised Example Test DataModel|true\n50ea6b13-9b75-4fbc-b611-747988ab0afb|DataClass|Finalised Data Class|null\n6be94c01-f0e3-4810-8156-eabc5d48cee5|DataElement|Another DataElement|null	f	Another DataElement	43b9cf21-3137-4587-9375-2943d0893117
d763e1ee-5f2a-45fb-b83b-8659d908819a	2	PrimitiveType	\N	3db65ef9-f4ba-452a-920f-b601b15f56cc	f9f834b7-74f5-4b0c-997a-044ac335a9f4|DataModel|Finalised Example Test DataModel|true\n3db65ef9-f4ba-452a-920f-b601b15f56cc|PrimitiveType|Finalised Data Type|null	f	Finalised Data Type	07970cd2-17f4-4b7c-ae33-20cf4acd1965
bd9d5a42-3874-4023-ac06-1b555543e468	3	DataModel	t	6e73dcde-8ce7-4c45-b37d-0494e55394c9	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true	t	Model Version Tree DataModel	\N
f1fb81c5-5152-445d-9c1d-6915c0d5e1be	2	DataClass	\N	77e10ffc-d40c-4dda-82dd-7843f58e5d17	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\n77e10ffc-d40c-4dda-82dd-7843f58e5d17|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	bd9d5a42-3874-4023-ac06-1b555543e468
22942594-a102-4196-a76e-d78def304877	2	DataClass	\N	6efd3b15-ff7e-4ec5-9505-0712fa51eb39	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\n6efd3b15-ff7e-4ec5-9505-0712fa51eb39|DataClass|V1 Data Class|null	f	V1 Data Class	bd9d5a42-3874-4023-ac06-1b555543e468
23ff8b0f-a269-4bd7-a5ff-1ba43be7b56d	2	DataClass	\N	cf1ba70e-746a-4300-9409-2eb76d03aee4	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\ncf1ba70e-746a-4300-9409-2eb76d03aee4|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	bd9d5a42-3874-4023-ac06-1b555543e468
32505aa9-c4dc-448c-803f-6bce1e64c9af	2	DataElement	\N	b2f25c3f-11ad-45de-88a6-a2bd80ece516	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\n6efd3b15-ff7e-4ec5-9505-0712fa51eb39|DataClass|V1 Data Class|null\n7b544cd7-a689-49d9-9e4a-318339a95d89|DataClass|V1 Internal Data Class|null\nb2f25c3f-11ad-45de-88a6-a2bd80ece516|DataElement|V1 Data Element|null	f	V1 Data Element	bae2cdab-0c1d-44cc-8a83-a610dd255479
5ad8f3f1-2e40-44a7-b0d8-dfb1a2b0a240	2	PrimitiveType	\N	cace8c8b-048d-4158-b532-40198892fee4	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\ncace8c8b-048d-4158-b532-40198892fee4|PrimitiveType|V1 Data Type|null	f	V1 Data Type	bd9d5a42-3874-4023-ac06-1b555543e468
7f75bbb8-7243-4ea0-ba34-e64f443092b1	2	DataElement	\N	7e125a13-1332-4fcc-bb6e-6fe81759a936	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\ncf1ba70e-746a-4300-9409-2eb76d03aee4|DataClass|V1 Modify Data Class|null\n7e125a13-1332-4fcc-bb6e-6fe81759a936|DataElement|V1 Modify DataElement|null	f	V1 Modify DataElement	23ff8b0f-a269-4bd7-a5ff-1ba43be7b56d
8c7cce68-5b24-457e-a5f1-34f15d7d60a0	3	DataElement	\N	f76409c4-0760-4f75-bf72-edae0a4a7995	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\ncf1ba70e-746a-4300-9409-2eb76d03aee4|DataClass|V1 Modify Data Class|null\nf76409c4-0760-4f75-bf72-edae0a4a7995|DataElement|V1 Modify DataElement 2|null	f	V1 Modify DataElement 2	23ff8b0f-a269-4bd7-a5ff-1ba43be7b56d
bae2cdab-0c1d-44cc-8a83-a610dd255479	3	DataClass	\N	7b544cd7-a689-49d9-9e4a-318339a95d89	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\n6efd3b15-ff7e-4ec5-9505-0712fa51eb39|DataClass|V1 Data Class|null\n7b544cd7-a689-49d9-9e4a-318339a95d89|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	22942594-a102-4196-a76e-d78def304877
bd0d3827-cbf9-4c61-8c2f-ae7c698bdc81	3	DataElement	\N	d1586984-9494-487e-a747-6a165fbc9e6a	6e73dcde-8ce7-4c45-b37d-0494e55394c9|DataModel|Model Version Tree DataModel|true\n6efd3b15-ff7e-4ec5-9505-0712fa51eb39|DataClass|V1 Data Class|null\nd1586984-9494-487e-a747-6a165fbc9e6a|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	22942594-a102-4196-a76e-d78def304877
8f27c73f-b95b-444f-b5c9-0bc43474e654	1	DataClass	\N	f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\nf7dba7bd-8c19-4dab-a5da-8737bbbcf0a2|DataClass|V1 Data Class|null	f	V1 Data Class	041ac810-950c-4fc9-8a23-6816ebd439b3
9c54eb88-34b6-4e17-99f9-1f551b0d8898	1	DataClass	\N	81ea24dc-03de-4e25-8649-9778c6f53055	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\n81ea24dc-03de-4e25-8649-9778c6f53055|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	041ac810-950c-4fc9-8a23-6816ebd439b3
a736ef9c-230e-4f16-8b93-5fafd46ab80a	1	DataElement	\N	76d51770-c7f7-44e5-bf40-281dac1f4bfd	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\nf7dba7bd-8c19-4dab-a5da-8737bbbcf0a2|DataClass|V1 Data Class|null\n76d51770-c7f7-44e5-bf40-281dac1f4bfd|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	8f27c73f-b95b-444f-b5c9-0bc43474e654
b797c65b-8a03-432e-be8f-ba3736012aae	1	DataElement	\N	3beb7b0c-e257-4d8b-af26-8c5e903ba2fc	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\n81ea24dc-03de-4e25-8649-9778c6f53055|DataClass|V1 Modify Data Class|null\n3beb7b0c-e257-4d8b-af26-8c5e903ba2fc|DataElement|V1 Modify DataElement|null	f	V1 Modify DataElement	9c54eb88-34b6-4e17-99f9-1f551b0d8898
ee78dc72-a091-4075-bb19-58f11f97e1c5	1	DataElement	\N	e69b07fa-9bbe-4f97-bbfa-c74d2dee68d2	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\n81ea24dc-03de-4e25-8649-9778c6f53055|DataClass|V1 Modify Data Class|null\ne69b07fa-9bbe-4f97-bbfa-c74d2dee68d2|DataElement|V1 Modify DataElement 2|null	f	V1 Modify DataElement 2	9c54eb88-34b6-4e17-99f9-1f551b0d8898
041ac810-950c-4fc9-8a23-6816ebd439b3	2	DataModel	t	926d5e0c-5ee5-457f-9335-3e97d02c08b2	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true	t	Model Version Tree DataModel fork	\N
2a363984-863b-40aa-9bec-9db185ecbbee	1	DataClass	\N	059983db-5a11-4aa6-b910-e736e8303008	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\nf7dba7bd-8c19-4dab-a5da-8737bbbcf0a2|DataClass|V1 Data Class|null\n059983db-5a11-4aa6-b910-e736e8303008|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	8f27c73f-b95b-444f-b5c9-0bc43474e654
2fa73a84-7433-4584-8733-24c271beeb98	1	PrimitiveType	\N	f4740512-2cbd-4ad7-9ebb-ed6e7874fefe	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\nf4740512-2cbd-4ad7-9ebb-ed6e7874fefe|PrimitiveType|V1 Data Type|null	f	V1 Data Type	041ac810-950c-4fc9-8a23-6816ebd439b3
788d1356-420e-49c7-af6e-573c51af7465	1	DataClass	\N	52fccb51-0cb1-477a-8047-04ce51c7f643	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\n52fccb51-0cb1-477a-8047-04ce51c7f643|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	041ac810-950c-4fc9-8a23-6816ebd439b3
dd9daf2c-b8fd-4bde-a1d9-e97efcd902a4	2	DataElement	\N	1249f4b2-2375-4b5f-82fb-439a11f8c740	926d5e0c-5ee5-457f-9335-3e97d02c08b2|DataModel|Model Version Tree DataModel fork|true\nf7dba7bd-8c19-4dab-a5da-8737bbbcf0a2|DataClass|V1 Data Class|null\n059983db-5a11-4aa6-b910-e736e8303008|DataClass|V1 Internal Data Class|null\n1249f4b2-2375-4b5f-82fb-439a11f8c740|DataElement|V1 Data Element|null	f	V1 Data Element	2a363984-863b-40aa-9bec-9db185ecbbee
4fbaf452-5899-4a4a-b410-aa7c3bc3ee33	1	DataModel	f	b3099f15-afde-436a-be99-1300eae98b4e	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false	t	Model Version Tree DataModel fork	\N
900574ca-66fb-4db0-9930-ede8a366d0ae	1	DataClass	\N	3627da01-784f-469e-b9d5-e043291c5ec9	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\n3627da01-784f-469e-b9d5-e043291c5ec9|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	4fbaf452-5899-4a4a-b410-aa7c3bc3ee33
ef5ea635-9f6b-4220-89f1-3f19b0e50174	1	DataElement	\N	17981a0d-014d-4c4f-ac24-04eb88a49f7b	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\n3627da01-784f-469e-b9d5-e043291c5ec9|DataClass|V1 Modify Data Class|null\n17981a0d-014d-4c4f-ac24-04eb88a49f7b|DataElement|V1 Modify DataElement|null	f	V1 Modify DataElement	900574ca-66fb-4db0-9930-ede8a366d0ae
f358d581-59df-4f1b-abd4-ead6d1536d4c	1	DataClass	\N	72b25cd5-5294-43e1-b366-540d649412e1	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\n72b25cd5-5294-43e1-b366-540d649412e1|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	4fbaf452-5899-4a4a-b410-aa7c3bc3ee33
43c52d8e-c8d1-4a6a-9f5f-bd8613955b84	1	DataElement	\N	b3109d79-5844-4792-b8e3-9420aaada6bc	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\n3627da01-784f-469e-b9d5-e043291c5ec9|DataClass|V1 Modify Data Class|null\nb3109d79-5844-4792-b8e3-9420aaada6bc|DataElement|V1 Modify DataElement 2|null	f	V1 Modify DataElement 2	900574ca-66fb-4db0-9930-ede8a366d0ae
591e19fc-82a1-47b0-b2dc-20b1cbe189af	1	DataClass	\N	dd87ad23-df5a-4194-a2b0-9a0876c79ee4	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\ndd87ad23-df5a-4194-a2b0-9a0876c79ee4|DataClass|V1 Data Class|null	f	V1 Data Class	4fbaf452-5899-4a4a-b410-aa7c3bc3ee33
7abb1ef6-9227-4814-b759-cc3a854976bd	1	DataElement	\N	53b89bcf-fc38-43c2-8724-55273eb182e9	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\ndd87ad23-df5a-4194-a2b0-9a0876c79ee4|DataClass|V1 Data Class|null\nf95847c0-c163-4ca7-be79-e26e309e454e|DataClass|V1 Internal Data Class|null\n53b89bcf-fc38-43c2-8724-55273eb182e9|DataElement|V1 Data Element|null	f	V1 Data Element	9130ff88-9247-4061-bbde-4bff790302ad
7cd9214e-728b-406b-bb47-cbcb6cc2bbaa	1	PrimitiveType	\N	965d3adf-1328-4863-90b4-8ac988f38e57	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\n965d3adf-1328-4863-90b4-8ac988f38e57|PrimitiveType|V1 Data Type|null	f	V1 Data Type	4fbaf452-5899-4a4a-b410-aa7c3bc3ee33
9130ff88-9247-4061-bbde-4bff790302ad	2	DataClass	\N	f95847c0-c163-4ca7-be79-e26e309e454e	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\ndd87ad23-df5a-4194-a2b0-9a0876c79ee4|DataClass|V1 Data Class|null\nf95847c0-c163-4ca7-be79-e26e309e454e|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	591e19fc-82a1-47b0-b2dc-20b1cbe189af
2f536c86-7d28-4b04-bd8d-da6583c72435	2	DataElement	\N	eab6604d-b223-45eb-9003-ab956d4152ca	b3099f15-afde-436a-be99-1300eae98b4e|DataModel|Model Version Tree DataModel fork|false\ndd87ad23-df5a-4194-a2b0-9a0876c79ee4|DataClass|V1 Data Class|null\neab6604d-b223-45eb-9003-ab956d4152ca|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	591e19fc-82a1-47b0-b2dc-20b1cbe189af
846d34cd-46cf-4456-884b-6543e6f79ce0	2	DataElement	\N	104bf289-d3de-427c-9b28-cd98fe166d1c	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n7bef5540-b2c5-4c5c-b2db-37053c270a75|DataClass|V1 Data Class|null\n5826b473-352e-4bf3-bce2-2ff97be6c197|DataClass|V1 Internal Data Class|null\n104bf289-d3de-427c-9b28-cd98fe166d1c|DataElement|V1 Data Element|null	f	V1 Data Element	20a05053-4aa6-4bb1-aa63-c9f9510d46cd
860fbfb8-806b-4ef9-9b2d-79d56004d914	2	DataElement	\N	68c07e75-1cec-4147-8476-8cc03c0d28a2	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\ne4656cb5-fe45-494f-8b83-46c1c397de23|DataClass|V1 Modify Data Class|null\n68c07e75-1cec-4147-8476-8cc03c0d28a2|DataElement|V1 Modify DataElement 2|null	f	V1 Modify DataElement 2	971487e8-28bc-48eb-a531-4820b4858aa9
971487e8-28bc-48eb-a531-4820b4858aa9	2	DataClass	\N	e4656cb5-fe45-494f-8b83-46c1c397de23	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\ne4656cb5-fe45-494f-8b83-46c1c397de23|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	9a490544-59bb-4d0b-9be0-e1a7ab444ee9
9a490544-59bb-4d0b-9be0-e1a7ab444ee9	3	DataModel	f	c84fb099-79bc-496a-8901-75c99d539fbd	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false	t	Model Version Tree DataModel	\N
daee824a-efeb-47bd-8b30-59d876765ebb	1	EnumerationType	\N	4d7380c2-06a6-4da9-8a65-29bf621ba152	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n4d7380c2-06a6-4da9-8a65-29bf621ba152|EnumerationType|catdogfish|null	f	catdogfish	9a490544-59bb-4d0b-9be0-e1a7ab444ee9
e06c05aa-9a41-466d-9fdf-9cd1e86f6177	2	DataClass	\N	7bef5540-b2c5-4c5c-b2db-37053c270a75	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n7bef5540-b2c5-4c5c-b2db-37053c270a75|DataClass|V1 Data Class|null	f	V1 Data Class	9a490544-59bb-4d0b-9be0-e1a7ab444ee9
fa851ad8-27e6-4845-8fac-f023a1f8659e	1	EnumerationValue	\N	9d5cdf70-bf5d-4c30-9672-b58520c91395	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n4d7380c2-06a6-4da9-8a65-29bf621ba152|EnumerationType|catdogfish|null\n9d5cdf70-bf5d-4c30-9672-b58520c91395|EnumerationValue|C|null	f	C	daee824a-efeb-47bd-8b30-59d876765ebb
001e0df1-e48b-4502-9338-e97ac67e8dd8	1	EnumerationValue	\N	75b7fa46-613c-4c28-93b9-816fa81d7492	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n4d7380c2-06a6-4da9-8a65-29bf621ba152|EnumerationType|catdogfish|null\n75b7fa46-613c-4c28-93b9-816fa81d7492|EnumerationValue|D|null	f	D	daee824a-efeb-47bd-8b30-59d876765ebb
0e5ecc5d-4472-49f8-83f8-46023626353a	1	EnumerationValue	\N	fb23ef19-76a4-442f-b51d-39d331115360	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n4d7380c2-06a6-4da9-8a65-29bf621ba152|EnumerationType|catdogfish|null\nfb23ef19-76a4-442f-b51d-39d331115360|EnumerationValue|F|null	f	F	daee824a-efeb-47bd-8b30-59d876765ebb
12e3470b-a48b-431b-97ce-6dd4bc172438	2	DataElement	\N	3f7904a3-8043-4b5a-8f96-3801da3949d7	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\ne4656cb5-fe45-494f-8b83-46c1c397de23|DataClass|V1 Modify Data Class|null\n3f7904a3-8043-4b5a-8f96-3801da3949d7|DataElement|V1 Modify DataElement|null	f	V1 Modify DataElement	971487e8-28bc-48eb-a531-4820b4858aa9
1d128791-8c7c-4e32-a362-aeac4bbcd320	1	PrimitiveType	\N	86814478-32ca-488c-9802-61b22091efb3	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n86814478-32ca-488c-9802-61b22091efb3|PrimitiveType|string|null	f	string	9a490544-59bb-4d0b-9be0-e1a7ab444ee9
20a05053-4aa6-4bb1-aa63-c9f9510d46cd	2	DataClass	\N	5826b473-352e-4bf3-bce2-2ff97be6c197	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n7bef5540-b2c5-4c5c-b2db-37053c270a75|DataClass|V1 Data Class|null\n5826b473-352e-4bf3-bce2-2ff97be6c197|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	e06c05aa-9a41-466d-9fdf-9cd1e86f6177
24ca0fac-792a-4bf9-9cb8-2f3efddf1e76	2	DataClass	\N	ab2384cf-eafa-4693-ac91-9f155e0d0058	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\nab2384cf-eafa-4693-ac91-9f155e0d0058|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	9a490544-59bb-4d0b-9be0-e1a7ab444ee9
34b4025a-2437-4196-96a8-e2c42249c2ec	1	PrimitiveType	\N	2124ad0b-e2f1-46dd-bf2f-f02f0c6b3b90	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n2124ad0b-e2f1-46dd-bf2f-f02f0c6b3b90|PrimitiveType|integer|null	f	integer	9a490544-59bb-4d0b-9be0-e1a7ab444ee9
4e146101-0000-495c-abd4-a0ef2be5373a	1	DataClass	\N	97ed4f0a-611d-48a8-ac60-fcb2aaccf749	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n97ed4f0a-611d-48a8-ac60-fcb2aaccf749|DataClass|emptyVersioningClass|null	f	emptyVersioningClass	9a490544-59bb-4d0b-9be0-e1a7ab444ee9
539c3326-c782-415b-9195-c66dc04d50e9	2	PrimitiveType	\N	ada0765e-5d5d-4175-9c5f-a48e286661ea	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\nada0765e-5d5d-4175-9c5f-a48e286661ea|PrimitiveType|V1 Data Type|null	f	V1 Data Type	9a490544-59bb-4d0b-9be0-e1a7ab444ee9
600bf737-908e-4fc6-a224-cfd0113cc91f	2	DataElement	\N	47e4279d-543a-41bd-96ed-2e16f3d2f3de	c84fb099-79bc-496a-8901-75c99d539fbd|DataModel|Model Version Tree DataModel|false\n7bef5540-b2c5-4c5c-b2db-37053c270a75|DataClass|V1 Data Class|null\n47e4279d-543a-41bd-96ed-2e16f3d2f3de|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	e06c05aa-9a41-466d-9fdf-9cd1e86f6177
9398c798-0ba2-4d2a-8de3-641d47d07a5e	8	DataModel	t	c5c83da4-47de-44f2-a5fd-414ac1f13900	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true	t	Model Version Tree DataModel	\N
c2d19833-327d-4f36-9a1c-840bed22ed50	9	DataClass	\N	2211dfeb-5b7c-4022-923a-fb4e205a8bbc	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\n2211dfeb-5b7c-4022-923a-fb4e205a8bbc|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	9398c798-0ba2-4d2a-8de3-641d47d07a5e
cd06b2fc-d8a2-49ff-99c1-e6019e30ffad	6	DataClass	\N	ed7afe51-ccf7-448b-9716-a0d06fe14701	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\ned7afe51-ccf7-448b-9716-a0d06fe14701|DataClass|V2 Data Class|null	f	V2 Data Class	9398c798-0ba2-4d2a-8de3-641d47d07a5e
d70632f7-02cd-42ca-a44a-bcddbfa6be07	6	DataElement	\N	6a2412f3-29d1-4bee-aa3a-1f8d1fa836ae	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\ned7afe51-ccf7-448b-9716-a0d06fe14701|DataClass|V2 Data Class|null\n6a2412f3-29d1-4bee-aa3a-1f8d1fa836ae|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	cd06b2fc-d8a2-49ff-99c1-e6019e30ffad
dfb1560c-5c03-4630-ac8f-99844cb9cba9	6	DataElement	\N	a32022f4-a429-41fa-9d4d-0581a925a6a9	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\ned7afe51-ccf7-448b-9716-a0d06fe14701|DataClass|V2 Data Class|null\na32022f4-a429-41fa-9d4d-0581a925a6a9|DataElement|V2 Data Element|null	f	V2 Data Element	cd06b2fc-d8a2-49ff-99c1-e6019e30ffad
e08b48c1-354d-4bb9-b2f4-d013fbc49c65	6	PrimitiveType	\N	1e2be421-1894-4297-a557-3ae7e40fea96	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\n1e2be421-1894-4297-a557-3ae7e40fea96|PrimitiveType|V2 Data Type|null	f	V2 Data Type	9398c798-0ba2-4d2a-8de3-641d47d07a5e
e6ad9738-3346-4b0a-97b7-05abd981dfb3	9	DataElement	\N	125027e4-d56f-4c44-9afc-d6043aef4e88	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\n2211dfeb-5b7c-4022-923a-fb4e205a8bbc|DataClass|V1 Modify Data Class|null\n125027e4-d56f-4c44-9afc-d6043aef4e88|DataElement|Modified Label On this element|null	f	Modified Label On this element	c2d19833-327d-4f36-9a1c-840bed22ed50
1452d16f-c428-4549-828e-378272c7981d	6	PrimitiveType	\N	0ef863c6-a0b2-4cc0-b9ab-014a5114f108	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\n0ef863c6-a0b2-4cc0-b9ab-014a5114f108|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	9398c798-0ba2-4d2a-8de3-641d47d07a5e
16744ab2-20ed-449e-9e4c-04f9a64cafe6	4	DataClass	\N	d0011e3b-6137-4b62-b193-6b07db935308	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\n2211dfeb-5b7c-4022-923a-fb4e205a8bbc|DataClass|V1 Modify Data Class|null\nd0011e3b-6137-4b62-b193-6b07db935308|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	c2d19833-327d-4f36-9a1c-840bed22ed50
1b7e46ff-c589-4c51-ad31-a594015aa2cf	6	DataElement	\N	acfcf44f-468e-49c4-be43-c420adea68b4	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\ned7afe51-ccf7-448b-9716-a0d06fe14701|DataClass|V2 Data Class|null\nacfcf44f-468e-49c4-be43-c420adea68b4|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	cd06b2fc-d8a2-49ff-99c1-e6019e30ffad
2fff3115-3fc8-4181-b63c-f0f5b14434dd	7	PrimitiveType	\N	91ff3163-6a80-4e19-8ce2-172bb446ce15	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\n91ff3163-6a80-4e19-8ce2-172bb446ce15|PrimitiveType|V1 Data Type|null	f	V1 Data Type	9398c798-0ba2-4d2a-8de3-641d47d07a5e
4ab05dd3-f49d-4c22-b240-d226d3c41220	6	PrimitiveType	\N	0f4824f3-305c-4b2b-9533-9c9a3425aa4e	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\n0f4824f3-305c-4b2b-9533-9c9a3425aa4e|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	9398c798-0ba2-4d2a-8de3-641d47d07a5e
577f6a17-502f-46b5-936a-9c0b902cd7e9	9	DataClass	\N	b0808edb-75a9-4204-baca-3af4fe2ba053	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\nb0808edb-75a9-4204-baca-3af4fe2ba053|DataClass|V1 Data Class|null	f	V1 Data Class	9398c798-0ba2-4d2a-8de3-641d47d07a5e
6eda0ed0-1b00-4037-93e9-d65ad4e8f0eb	7	DataClass	\N	5abb9deb-b2f1-4e7b-ac60-6fc576131858	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\n5abb9deb-b2f1-4e7b-ac60-6fc576131858|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	9398c798-0ba2-4d2a-8de3-641d47d07a5e
49576816-9214-45ea-9a1a-13dd0e7259a3	9	DataElement	\N	27d9fd52-c55b-485e-a9ab-78b381b4b593	c5c83da4-47de-44f2-a5fd-414ac1f13900|DataModel|Model Version Tree DataModel|true\nb0808edb-75a9-4204-baca-3af4fe2ba053|DataClass|V1 Data Class|null\n27d9fd52-c55b-485e-a9ab-78b381b4b593|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	577f6a17-502f-46b5-936a-9c0b902cd7e9
8e0fa4ba-d390-490a-a91e-436a493c5591	1	PrimitiveType	\N	0d203b8d-8f47-432f-95da-535e8967328c	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n0d203b8d-8f47-432f-95da-535e8967328c|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	4a5261ca-4770-4be9-a95d-efcbee88dbb8
b0b89b39-39ea-4187-b597-b789d507ad05	1	PrimitiveType	\N	dd2caaa3-67ad-49f5-80f8-bc6978351fb2	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\ndd2caaa3-67ad-49f5-80f8-bc6978351fb2|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	4a5261ca-4770-4be9-a95d-efcbee88dbb8
cb6b5f0d-2bbc-4101-8138-f24319d996b8	1	DataClass	\N	01bc3883-ffae-4824-9044-7d1cd7719ec1	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n01bc3883-ffae-4824-9044-7d1cd7719ec1|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	4a5261ca-4770-4be9-a95d-efcbee88dbb8
f41dec0e-d994-453c-9b1e-3e599a2bf5db	1	PrimitiveType	\N	1c25775a-00bf-4221-91d4-5f644c764637	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n1c25775a-00bf-4221-91d4-5f644c764637|PrimitiveType|V2 Data Type|null	f	V2 Data Type	4a5261ca-4770-4be9-a95d-efcbee88dbb8
f9276cf1-f291-4886-9c73-cd5f582ef22f	1	DataClass	\N	71d70845-8359-4e06-93f4-d31984cb31c3	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n71d70845-8359-4e06-93f4-d31984cb31c3|DataClass|V1 Data Class|null	f	V1 Data Class	4a5261ca-4770-4be9-a95d-efcbee88dbb8
17bba52d-4039-428f-a16b-992e637ab1f7	1	DataElement	\N	ef1d9eda-1666-4102-8614-a20636c138c1	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n71d70845-8359-4e06-93f4-d31984cb31c3|DataClass|V1 Data Class|null\nef1d9eda-1666-4102-8614-a20636c138c1|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	f9276cf1-f291-4886-9c73-cd5f582ef22f
467c20a1-68d6-47d9-9eeb-abcdf507b097	1	DataClass	\N	b0616a77-ed8b-4ff4-883a-9494a0e8e821	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\nb0616a77-ed8b-4ff4-883a-9494a0e8e821|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	4a5261ca-4770-4be9-a95d-efcbee88dbb8
4a5261ca-4770-4be9-a95d-efcbee88dbb8	2	DataModel	t	94f194ee-79db-4835-840e-4168bc4d9331	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true	t	Model Version Tree DataModel	\N
5a7dcec0-3aac-40db-8134-14c7dc91a944	1	DataClass	\N	45122b94-5b79-4826-9afa-531042bba78a	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n45122b94-5b79-4826-9afa-531042bba78a|DataClass|V2 Data Class|null	f	V2 Data Class	4a5261ca-4770-4be9-a95d-efcbee88dbb8
5d80446e-693a-4296-996d-452b28d77f99	1	DataClass	\N	4f7b9a1e-4b81-43c1-af61-1061f6ddea54	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\nb0616a77-ed8b-4ff4-883a-9494a0e8e821|DataClass|V1 Modify Data Class|null\n4f7b9a1e-4b81-43c1-af61-1061f6ddea54|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	467c20a1-68d6-47d9-9eeb-abcdf507b097
6bede682-2d7a-4045-a111-5dd72c2a95a4	1	DataElement	\N	c4893582-8316-4c72-b6cc-b9b3edf6de22	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n45122b94-5b79-4826-9afa-531042bba78a|DataClass|V2 Data Class|null\nc4893582-8316-4c72-b6cc-b9b3edf6de22|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	5a7dcec0-3aac-40db-8134-14c7dc91a944
6ca03011-5238-4cd7-9e30-1d91898669c3	1	PrimitiveType	\N	30c1996b-46d8-44a8-9e9f-161df68a8d41	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n30c1996b-46d8-44a8-9e9f-161df68a8d41|PrimitiveType|V1 Data Type|null	f	V1 Data Type	4a5261ca-4770-4be9-a95d-efcbee88dbb8
bf00eba8-3314-4ced-8684-dcbe0041d7e4	2	DataElement	\N	d6da4efc-eea5-4a83-8554-9f28c9137d0f	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\nb0616a77-ed8b-4ff4-883a-9494a0e8e821|DataClass|V1 Modify Data Class|null\nd6da4efc-eea5-4a83-8554-9f28c9137d0f|DataElement|Modified Label On this element|null	f	Modified Label On this element	467c20a1-68d6-47d9-9eeb-abcdf507b097
fdf48ce3-00c0-4b79-a395-641f24d3b7c0	2	DataElement	\N	0faa2a77-0da9-45d4-a41d-18d7216b8b3b	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n45122b94-5b79-4826-9afa-531042bba78a|DataClass|V2 Data Class|null\n0faa2a77-0da9-45d4-a41d-18d7216b8b3b|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	5a7dcec0-3aac-40db-8134-14c7dc91a944
42fb17b3-8d24-47b6-b476-87bedc45b863	2	DataElement	\N	34e1a169-59b0-48b0-a7ee-82811742e4a9	94f194ee-79db-4835-840e-4168bc4d9331|DataModel|Model Version Tree DataModel|true\n45122b94-5b79-4826-9afa-531042bba78a|DataClass|V2 Data Class|null\n34e1a169-59b0-48b0-a7ee-82811742e4a9|DataElement|V2 Data Element|null	f	V2 Data Element	5a7dcec0-3aac-40db-8134-14c7dc91a944
837b1c91-89c8-4c9b-9639-69490d3dd531	2	DataClass	\N	7141fcdc-88a4-4580-bfdf-dc32ed481b93	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\n7141fcdc-88a4-4580-bfdf-dc32ed481b93|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	e11168e5-7df1-49d7-bbcc-723573c54243
89262994-c613-4bbf-bb17-e3c3b9641382	2	DataClass	\N	a099fc92-d9ca-4fa1-a74c-63a788819f68	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\na099fc92-d9ca-4fa1-a74c-63a788819f68|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	e11168e5-7df1-49d7-bbcc-723573c54243
9001c6ac-07a9-4ae9-943a-cb983948e3c1	2	DataClass	\N	4b806f2b-ff4e-4bda-9543-ca8e51eb3ebe	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\n4b806f2b-ff4e-4bda-9543-ca8e51eb3ebe|DataClass|V1 Data Class|null	f	V1 Data Class	e11168e5-7df1-49d7-bbcc-723573c54243
9550f09a-30f6-4f84-8878-d151c83b5bb9	2	DataElement	\N	d9aadda4-624a-4062-acdf-83fe4dd057c2	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\na099fc92-d9ca-4fa1-a74c-63a788819f68|DataClass|V1 Modify Data Class|null\nd9aadda4-624a-4062-acdf-83fe4dd057c2|DataElement|Modified Label On this element|null	f	Modified Label On this element	89262994-c613-4bbf-bb17-e3c3b9641382
9a8ac959-325a-4c6d-abb4-4bb012bfa7e9	2	PrimitiveType	\N	ed7c2eb7-4161-487a-b5f8-99f54d19f81e	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\ned7c2eb7-4161-487a-b5f8-99f54d19f81e|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	e11168e5-7df1-49d7-bbcc-723573c54243
b6b0e02a-b599-4a21-b763-5ab6d50ae3ac	2	PrimitiveType	\N	dcf77ff3-d2c8-4b21-a64e-006e65077418	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\ndcf77ff3-d2c8-4b21-a64e-006e65077418|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	e11168e5-7df1-49d7-bbcc-723573c54243
bd6e3549-b6ed-4961-a324-bb125ee729ea	3	DataElement	\N	543a0004-4252-4f31-9552-877865ccb77c	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\n41664fd2-5942-480a-9463-129c1afb2aa2|DataClass|V2 Data Class|null\n543a0004-4252-4f31-9552-877865ccb77c|DataElement|V2 Data Element|null	f	V2 Data Element	2c5524eb-a78b-4255-8588-68228ff335cc
c8f53e45-43ed-482c-8eeb-2a27d7f30be8	2	PrimitiveType	\N	a0f7ca74-465f-4968-8f83-9ea2f6b9007d	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\na0f7ca74-465f-4968-8f83-9ea2f6b9007d|PrimitiveType|V2 Data Type|null	f	V2 Data Type	e11168e5-7df1-49d7-bbcc-723573c54243
ce9545ad-30cf-41b9-8c76-9e7916c5bb48	2	DataClass	\N	70875f36-5b39-4d4d-b933-0dcd4e4f7f01	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\na099fc92-d9ca-4fa1-a74c-63a788819f68|DataClass|V1 Modify Data Class|null\n70875f36-5b39-4d4d-b933-0dcd4e4f7f01|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	89262994-c613-4bbf-bb17-e3c3b9641382
e11168e5-7df1-49d7-bbcc-723573c54243	2	DataModel	f	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false	t	Model Version Tree DataModel	\N
149fc25e-c973-4142-bb43-de4d77b38c05	2	PrimitiveType	\N	b12a75f4-bb3f-4e23-a154-a0345414358a	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\nb12a75f4-bb3f-4e23-a154-a0345414358a|PrimitiveType|V1 Data Type|null	f	V1 Data Type	e11168e5-7df1-49d7-bbcc-723573c54243
2c5524eb-a78b-4255-8588-68228ff335cc	2	DataClass	\N	41664fd2-5942-480a-9463-129c1afb2aa2	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\n41664fd2-5942-480a-9463-129c1afb2aa2|DataClass|V2 Data Class|null	f	V2 Data Class	e11168e5-7df1-49d7-bbcc-723573c54243
525a551d-840c-44ed-8233-40bff7719b59	2	DataElement	\N	140186cd-0ea3-4370-8887-361703993637	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\n41664fd2-5942-480a-9463-129c1afb2aa2|DataClass|V2 Data Class|null\n140186cd-0ea3-4370-8887-361703993637|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	2c5524eb-a78b-4255-8588-68228ff335cc
6d10f1eb-02cd-4d27-8ca8-4d36def093c7	3	DataElement	\N	e1f7e536-fa90-4d02-99fb-c5ae639dc2ef	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\n4b806f2b-ff4e-4bda-9543-ca8e51eb3ebe|DataClass|V1 Data Class|null\ne1f7e536-fa90-4d02-99fb-c5ae639dc2ef|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	9001c6ac-07a9-4ae9-943a-cb983948e3c1
6dcac5cd-8dea-4e89-802f-add0dfc36db2	2	DataElement	\N	d088448e-6501-4d69-a723-702e2b623f22	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02|DataModel|Model Version Tree DataModel|false\n41664fd2-5942-480a-9463-129c1afb2aa2|DataClass|V2 Data Class|null\nd088448e-6501-4d69-a723-702e2b623f22|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	2c5524eb-a78b-4255-8588-68228ff335cc
96f1033b-daf5-47e3-a244-472c5276a30b	2	PrimitiveType	\N	850a0c33-0121-43de-ae1c-e1ff5bab6f0a	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\n850a0c33-0121-43de-ae1c-e1ff5bab6f0a|PrimitiveType|V1 Data Type|null	f	V1 Data Type	65e728b4-c448-4655-be7d-652d49db9761
c948e194-d1e7-4b1b-a72a-800c60bdbad3	2	DataClass	\N	efd359cc-066f-4c58-b1e4-53db8085d44e	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\nefd359cc-066f-4c58-b1e4-53db8085d44e|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	65e728b4-c448-4655-be7d-652d49db9761
d0600903-ea99-4431-bae2-4d8def4d8bcf	2	PrimitiveType	\N	08ca0f68-87a1-474b-bffd-98c43c6fcc93	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\n08ca0f68-87a1-474b-bffd-98c43c6fcc93|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	65e728b4-c448-4655-be7d-652d49db9761
0d0fe1db-d2a9-4111-b603-117909c99b5c	2	PrimitiveType	\N	e7c6df2f-f1c5-4936-98e3-e06613890815	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\ne7c6df2f-f1c5-4936-98e3-e06613890815|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	65e728b4-c448-4655-be7d-652d49db9761
1204419c-4dc7-4605-9504-b5cd1cf43f01	2	DataClass	\N	5f2c57bc-4547-42e8-b777-7ee3e7f9715c	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\nefd359cc-066f-4c58-b1e4-53db8085d44e|DataClass|V1 Modify Data Class|null\n5f2c57bc-4547-42e8-b777-7ee3e7f9715c|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	c948e194-d1e7-4b1b-a72a-800c60bdbad3
397f9af5-a7a9-4745-b3e9-523148c4861a	2	DataClass	\N	3ccdd107-b935-4a0c-91b6-5f10f03c46a6	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\n3ccdd107-b935-4a0c-91b6-5f10f03c46a6|DataClass|V2 Data Class|null	f	V2 Data Class	65e728b4-c448-4655-be7d-652d49db9761
65e728b4-c448-4655-be7d-652d49db9761	2	DataModel	t	726b5b98-4b02-433d-9e3b-249f139a27dc	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true	t	Model Version Tree DataModel	\N
7228119b-649a-4d22-bd55-2ca40437926b	2	PrimitiveType	\N	debd425a-6c2f-41c2-918f-cf7bd81030bd	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\ndebd425a-6c2f-41c2-918f-cf7bd81030bd|PrimitiveType|V2 Data Type|null	f	V2 Data Type	65e728b4-c448-4655-be7d-652d49db9761
7eaf926b-cb17-4e19-8616-b453f554a453	2	DataClass	\N	c5b99d99-be9f-4639-ad03-feaeaed2188e	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\nc5b99d99-be9f-4639-ad03-feaeaed2188e|DataClass|V1 Data Class|null	f	V1 Data Class	65e728b4-c448-4655-be7d-652d49db9761
7f727900-29e4-4bb9-930c-d70be4e18ab6	2	DataClass	\N	46152471-14dd-42af-9fb7-75b804e4f7fa	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\n46152471-14dd-42af-9fb7-75b804e4f7fa|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	65e728b4-c448-4655-be7d-652d49db9761
86d9cd5f-5013-4268-92df-064165a45a35	1	DataModel	f	9dd076ab-1240-474c-a3cb-5ef48863c208	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false	t	Model Version Tree DataModel another fork	\N
8946a8ad-a418-4064-b8bf-e62372e2bfbb	4	DataElement	\N	ae063f71-0c7b-4019-9741-0fb249d10826	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\n3ccdd107-b935-4a0c-91b6-5f10f03c46a6|DataClass|V2 Data Class|null\nae063f71-0c7b-4019-9741-0fb249d10826|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	397f9af5-a7a9-4745-b3e9-523148c4861a
c7ef6753-2da7-43e3-8cee-95c97db9a2d5	4	DataElement	\N	1b80f6d8-8e4c-4611-85ce-f2bb134537ea	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\nefd359cc-066f-4c58-b1e4-53db8085d44e|DataClass|V1 Modify Data Class|null\n1b80f6d8-8e4c-4611-85ce-f2bb134537ea|DataElement|Modified Label On this element|null	f	Modified Label On this element	c948e194-d1e7-4b1b-a72a-800c60bdbad3
dbabbaef-c302-4f8c-80f2-7aedf143f254	4	DataElement	\N	391a79f0-6728-4679-ab52-97d98ceb5fd4	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\n3ccdd107-b935-4a0c-91b6-5f10f03c46a6|DataClass|V2 Data Class|null\n391a79f0-6728-4679-ab52-97d98ceb5fd4|DataElement|V2 Data Element|null	f	V2 Data Element	397f9af5-a7a9-4745-b3e9-523148c4861a
fe72dcc3-cd89-4246-9bb7-f2063dc99894	4	DataElement	\N	2663298a-f6fc-4c3e-a496-b3116a2cd986	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\n3ccdd107-b935-4a0c-91b6-5f10f03c46a6|DataClass|V2 Data Class|null\n2663298a-f6fc-4c3e-a496-b3116a2cd986|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	397f9af5-a7a9-4745-b3e9-523148c4861a
0b50d0f7-ce3e-42d2-a670-5f00f0223b7a	4	DataElement	\N	5a843782-2bd3-48a9-ad1a-ca0b0534c0b0	726b5b98-4b02-433d-9e3b-249f139a27dc|DataModel|Model Version Tree DataModel|true\nc5b99d99-be9f-4639-ad03-feaeaed2188e|DataClass|V1 Data Class|null\n5a843782-2bd3-48a9-ad1a-ca0b0534c0b0|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	7eaf926b-cb17-4e19-8616-b453f554a453
922fd3f0-69ef-4318-a66a-02fd4ea0f98e	1	PrimitiveType	\N	05868455-f7e3-4775-b563-4966b2550c73	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n05868455-f7e3-4775-b563-4966b2550c73|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	86d9cd5f-5013-4268-92df-064165a45a35
a1f6a5e4-d74f-4a57-b826-0b3c467b5537	1	DataClass	\N	f4678c70-3aae-426e-83ce-d812b89fc186	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\nf4678c70-3aae-426e-83ce-d812b89fc186|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	86d9cd5f-5013-4268-92df-064165a45a35
a74e710e-8492-44f0-ad66-5b9ba6ecd7e8	1	DataClass	\N	1fa88da0-c245-4981-888d-3872abed48c1	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n1fa88da0-c245-4981-888d-3872abed48c1|DataClass|V2 Data Class|null	f	V2 Data Class	86d9cd5f-5013-4268-92df-064165a45a35
aa453da1-8e17-42c6-b6e0-0b46e4ffff23	1	DataClass	\N	8865dc91-1795-4512-90cc-933206f36596	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n8865dc91-1795-4512-90cc-933206f36596|DataClass|V1 Data Class|null	f	V1 Data Class	86d9cd5f-5013-4268-92df-064165a45a35
d1bee0a2-b9a8-432b-89f7-efffd6dca730	1	DataElement	\N	b0fb7cb8-763c-4673-88b1-27731c356cc1	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n1fa88da0-c245-4981-888d-3872abed48c1|DataClass|V2 Data Class|null\nb0fb7cb8-763c-4673-88b1-27731c356cc1|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	a74e710e-8492-44f0-ad66-5b9ba6ecd7e8
d2647eec-8cdb-425b-ada7-64e2bfab5f11	1	PrimitiveType	\N	241cd456-e9ff-4521-9d8a-157438b29e85	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n241cd456-e9ff-4521-9d8a-157438b29e85|PrimitiveType|V2 Data Type|null	f	V2 Data Type	86d9cd5f-5013-4268-92df-064165a45a35
0d8dcaf2-8d3c-4d65-8f55-7303f1cbc704	1	DataElement	\N	722468b3-c1ad-4a11-be22-90ae8e3f16ca	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n1fa88da0-c245-4981-888d-3872abed48c1|DataClass|V2 Data Class|null\n722468b3-c1ad-4a11-be22-90ae8e3f16ca|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	a74e710e-8492-44f0-ad66-5b9ba6ecd7e8
2245fab3-5bab-42bb-96a9-88dcbd2dbea1	1	PrimitiveType	\N	7c3556c9-bf46-4378-945a-32ae5bfa1cc3	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n7c3556c9-bf46-4378-945a-32ae5bfa1cc3|PrimitiveType|V1 Data Type|null	f	V1 Data Type	86d9cd5f-5013-4268-92df-064165a45a35
29d808db-98bc-4a33-882a-6a81fcc73bba	1	DataElement	\N	702daa66-4894-4c45-b03f-48b6cca390b5	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n1fa88da0-c245-4981-888d-3872abed48c1|DataClass|V2 Data Class|null\n702daa66-4894-4c45-b03f-48b6cca390b5|DataElement|V2 Data Element|null	f	V2 Data Element	a74e710e-8492-44f0-ad66-5b9ba6ecd7e8
2c1eba02-df6a-479f-a02c-cf685fb7d4f4	1	PrimitiveType	\N	e762cdf4-e140-49e1-837d-f8a50bf85150	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\ne762cdf4-e140-49e1-837d-f8a50bf85150|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	86d9cd5f-5013-4268-92df-064165a45a35
378b0925-5cd7-48c5-9ac4-ce707ac74c3c	1	DataElement	\N	bfb391be-e237-4a3e-b01b-ac6da2d251ad	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n8865dc91-1795-4512-90cc-933206f36596|DataClass|V1 Data Class|null\nbfb391be-e237-4a3e-b01b-ac6da2d251ad|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	aa453da1-8e17-42c6-b6e0-0b46e4ffff23
458928cc-afc4-41be-a19e-7ae02ad9da71	1	DataClass	\N	5c58f136-c4b9-4a4e-8142-936660b4fa77	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\n5c58f136-c4b9-4a4e-8142-936660b4fa77|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	86d9cd5f-5013-4268-92df-064165a45a35
48239bd3-22ad-4315-831f-177eddd60911	1	DataClass	\N	9b10c08e-06cc-47d2-932c-c27ca10f55ad	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\nf4678c70-3aae-426e-83ce-d812b89fc186|DataClass|V1 Modify Data Class|null\n9b10c08e-06cc-47d2-932c-c27ca10f55ad|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	a1f6a5e4-d74f-4a57-b826-0b3c467b5537
63188978-5b05-4d99-8147-bff31748410c	1	DataElement	\N	e8f859bf-8371-4945-8ac7-850898c3394f	9dd076ab-1240-474c-a3cb-5ef48863c208|DataModel|Model Version Tree DataModel another fork|false\nf4678c70-3aae-426e-83ce-d812b89fc186|DataClass|V1 Modify Data Class|null\ne8f859bf-8371-4945-8ac7-850898c3394f|DataElement|Modified Label On this element|null	f	Modified Label On this element	a1f6a5e4-d74f-4a57-b826-0b3c467b5537
a73b7491-71a6-4d8b-8b3b-771234bfe2a5	2	DataModel	t	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true	t	Model Version Tree DataModel	\N
b3daeca0-6ad3-4c1b-a035-df421cb4a808	1	PrimitiveType	\N	0c313d45-1561-4e04-b881-9efc36ed3976	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n0c313d45-1561-4e04-b881-9efc36ed3976|PrimitiveType|V2 Data Type|null	f	V2 Data Type	a73b7491-71a6-4d8b-8b3b-771234bfe2a5
ed6f2a16-5029-460c-a776-97af5348a1fd	1	PrimitiveType	\N	55d78ee3-5908-48a5-8656-820256047de3	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n55d78ee3-5908-48a5-8656-820256047de3|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	a73b7491-71a6-4d8b-8b3b-771234bfe2a5
f5bb5db4-688e-4ec4-9e95-03ae55fe0e5e	1	PrimitiveType	\N	614e12ea-d510-4320-9be4-372af71d5e47	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n614e12ea-d510-4320-9be4-372af71d5e47|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	a73b7491-71a6-4d8b-8b3b-771234bfe2a5
0408885a-8920-4618-a5c9-9ff5464fb152	1	DataClass	\N	678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n678ef0af-95ca-4fde-9d84-dc3fcdabc7e0|DataClass|V2 Data Class|null	f	V2 Data Class	a73b7491-71a6-4d8b-8b3b-771234bfe2a5
2185c2fe-467e-4d63-b8a5-333a9c065535	1	DataElement	\N	0331172d-7a0b-4d77-ad29-9e09dee1c2be	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n678ef0af-95ca-4fde-9d84-dc3fcdabc7e0|DataClass|V2 Data Class|null\n0331172d-7a0b-4d77-ad29-9e09dee1c2be|DataElement|V2 Data Element|null	f	V2 Data Element	0408885a-8920-4618-a5c9-9ff5464fb152
4721d762-dbcf-445f-b5b8-d93e33a7ccb4	1	DataClass	\N	4cc41c61-2ff7-4325-8289-5efd97dd789d	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n4cc41c61-2ff7-4325-8289-5efd97dd789d|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	a73b7491-71a6-4d8b-8b3b-771234bfe2a5
5876ea5f-fd8b-4342-b2c4-3e3c51c0fb66	1	DataClass	\N	11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e|DataClass|V1 Data Class|null	f	V1 Data Class	a73b7491-71a6-4d8b-8b3b-771234bfe2a5
6b8459c4-4cfe-4a6d-89be-deb3b8415172	1	PrimitiveType	\N	92585be7-eb1d-4331-9f8b-20277bc3a3fe	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n92585be7-eb1d-4331-9f8b-20277bc3a3fe|PrimitiveType|V1 Data Type|null	f	V1 Data Type	a73b7491-71a6-4d8b-8b3b-771234bfe2a5
74bc68e3-357b-414a-bb34-597161ef4227	1	DataElement	\N	3a2a4dcd-3cb4-4bdf-8891-9723dab8b5af	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n678ef0af-95ca-4fde-9d84-dc3fcdabc7e0|DataClass|V2 Data Class|null\n3a2a4dcd-3cb4-4bdf-8891-9723dab8b5af|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	0408885a-8920-4618-a5c9-9ff5464fb152
76b78243-ab30-43fe-b236-2a125985cd8e	1	DataClass	\N	8eef006c-8b01-48cc-9048-9d22aa47e7f5	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n8eef006c-8b01-48cc-9048-9d22aa47e7f5|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	a73b7491-71a6-4d8b-8b3b-771234bfe2a5
8cd13e94-fde4-4eee-b801-a80a06d55289	2	DataElement	\N	95d47600-574f-49fb-bdd6-fa47d6935536	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n678ef0af-95ca-4fde-9d84-dc3fcdabc7e0|DataClass|V2 Data Class|null\n95d47600-574f-49fb-bdd6-fa47d6935536|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	0408885a-8920-4618-a5c9-9ff5464fb152
fc669fcc-adf3-4489-8f90-272e29c74707	1	DataModel	f	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false	t	Model Version Tree DataModel	\N
3dc83436-174c-40f6-90ec-b747b79ec8ae	2	DataElement	\N	5e1731b0-241b-4e25-b1a9-244c85c67275	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e|DataClass|V1 Data Class|null\n5e1731b0-241b-4e25-b1a9-244c85c67275|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	5876ea5f-fd8b-4342-b2c4-3e3c51c0fb66
6a28b2c5-f006-46a4-8e39-cd9ec523a0e3	2	DataClass	\N	953e8504-acce-452b-93ec-a9ab2817d26f	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n8eef006c-8b01-48cc-9048-9d22aa47e7f5|DataClass|V1 Modify Data Class|null\n953e8504-acce-452b-93ec-a9ab2817d26f|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	76b78243-ab30-43fe-b236-2a125985cd8e
6a533050-f447-4da8-b801-9df27e4d8bf8	2	DataElement	\N	24235cda-63d5-4c31-bdab-9d7e190b8d2f	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d|DataModel|Model Version Tree DataModel|true\n8eef006c-8b01-48cc-9048-9d22aa47e7f5|DataClass|V1 Modify Data Class|null\n24235cda-63d5-4c31-bdab-9d7e190b8d2f|DataElement|Modified Label On this element|null	f	Modified Label On this element	76b78243-ab30-43fe-b236-2a125985cd8e
ab0ebce0-9279-4aad-b0ca-a5e4865959a9	1	PrimitiveType	\N	4da5448a-a9dc-4ace-a777-a5dbd602cc9a	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n4da5448a-a9dc-4ace-a777-a5dbd602cc9a|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	fc669fcc-adf3-4489-8f90-272e29c74707
b753dea1-39ef-4b2b-9f86-2ca982d3345a	1	DataClass	\N	3c21c07e-ea7c-4345-a2ac-f450289200d9	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n3c21c07e-ea7c-4345-a2ac-f450289200d9|DataClass|V2 Data Class|null	f	V2 Data Class	fc669fcc-adf3-4489-8f90-272e29c74707
e8d96597-8499-4f48-a150-3f349beaed8b	1	DataClass	\N	b3c484a4-9928-4e28-a2e9-256234a01cf5	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\nb3c484a4-9928-4e28-a2e9-256234a01cf5|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	fc669fcc-adf3-4489-8f90-272e29c74707
0bd88e0f-3dba-4190-ae28-3c3a19406ad2	1	PrimitiveType	\N	700f81b0-5f14-43b6-b846-2d32a666ab56	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n700f81b0-5f14-43b6-b846-2d32a666ab56|PrimitiveType|V1 Data Type|null	f	V1 Data Type	fc669fcc-adf3-4489-8f90-272e29c74707
1e213be3-52dd-451b-9c00-36dee60f05f1	1	DataElement	\N	52bc7f27-1776-417d-9164-bc89dcb50419	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n3c21c07e-ea7c-4345-a2ac-f450289200d9|DataClass|V2 Data Class|null\n52bc7f27-1776-417d-9164-bc89dcb50419|DataElement|V2 Data Element|null	f	V2 Data Element	b753dea1-39ef-4b2b-9f86-2ca982d3345a
24abaf3e-335a-4d86-85f7-0475a8bf11c8	1	DataElement	\N	3d3185a5-ab88-4473-bb39-0b3f159cc726	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n3c21c07e-ea7c-4345-a2ac-f450289200d9|DataClass|V2 Data Class|null\n3d3185a5-ab88-4473-bb39-0b3f159cc726|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	b753dea1-39ef-4b2b-9f86-2ca982d3345a
3ab03bcf-7dc1-4966-9557-a1b21341bbe1	1	PrimitiveType	\N	25976300-071b-48b0-bc64-940ddaca293d	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n25976300-071b-48b0-bc64-940ddaca293d|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	fc669fcc-adf3-4489-8f90-272e29c74707
3e25da73-5548-43ec-88a9-e828e92f46f4	1	DataClass	\N	04c258ba-d2c3-47b0-9587-e79f88844ab4	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n04c258ba-d2c3-47b0-9587-e79f88844ab4|DataClass|V1 Data Class|null	f	V1 Data Class	fc669fcc-adf3-4489-8f90-272e29c74707
4d719fe3-5873-42bb-92e3-f1028ce4b7e8	1	DataClass	\N	1571b213-46cb-4287-abe5-015be482575a	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n1571b213-46cb-4287-abe5-015be482575a|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	fc669fcc-adf3-4489-8f90-272e29c74707
5132aa9c-b056-4e8b-9da9-87813f2b6ec5	1	PrimitiveType	\N	b2082605-ace7-4bb8-ac47-ae9b4cabb112	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\nb2082605-ace7-4bb8-ac47-ae9b4cabb112|PrimitiveType|V2 Data Type|null	f	V2 Data Type	fc669fcc-adf3-4489-8f90-272e29c74707
837a857c-569a-4602-b8ed-4833c12b4d65	2	DataElement	\N	1b5392b0-e316-4a0f-ae82-00ca5f2a2d1a	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n04c258ba-d2c3-47b0-9587-e79f88844ab4|DataClass|V1 Data Class|null\n1b5392b0-e316-4a0f-ae82-00ca5f2a2d1a|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	3e25da73-5548-43ec-88a9-e828e92f46f4
ad0cba26-c5ff-4464-b3ae-e00aa6631edf	2	DataElement	\N	cd6add7e-1f55-4efa-8742-308d6efc117b	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n3c21c07e-ea7c-4345-a2ac-f450289200d9|DataClass|V2 Data Class|null\ncd6add7e-1f55-4efa-8742-308d6efc117b|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	b753dea1-39ef-4b2b-9f86-2ca982d3345a
4209f905-c2bd-4053-bb10-bf6a9ad0545e	2	DataElement	\N	0175c673-66b3-484f-b8f1-e92bfffad169	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n1571b213-46cb-4287-abe5-015be482575a|DataClass|V1 Modify Data Class|null\n0175c673-66b3-484f-b8f1-e92bfffad169|DataElement|Modified Label On this element|null	f	Modified Label On this element	4d719fe3-5873-42bb-92e3-f1028ce4b7e8
437884bc-d4f4-4adc-b0a8-920f025fe3f1	2	DataClass	\N	94b17a72-c378-44b3-9ff7-1b1316e4575c	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d|DataModel|Model Version Tree DataModel|false\n1571b213-46cb-4287-abe5-015be482575a|DataClass|V1 Modify Data Class|null\n94b17a72-c378-44b3-9ff7-1b1316e4575c|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	4d719fe3-5873-42bb-92e3-f1028ce4b7e8
80dd3141-3944-4d0b-bf6f-423956e59f17	4	DataElement	\N	4cbdcb0e-adb0-4ea0-89b8-bbd0f8d649f2	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n1b151ae1-2b74-44a4-a865-28a521b61d68|DataClass|V2 Data Class|null\n4cbdcb0e-adb0-4ea0-89b8-bbd0f8d649f2|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	bd6f89bd-b8a9-4fca-96b0-ba02192d6a0f
93d6c866-c1f5-4e63-99b6-9dbee4fb8faa	3	DataClass	\N	2337c502-9095-4159-89ec-affc7f0e0535	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n2337c502-9095-4159-89ec-affc7f0e0535|DataClass|V1 Data Class|null	f	V1 Data Class	04292741-c682-4018-b513-edb134889b35
b0c90336-e5f4-4f45-a8f6-74ca4639f173	3	DataClass	\N	c52b5d6f-ffe0-4984-946b-adfcb4cf1a35	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\nc52b5d6f-ffe0-4984-946b-adfcb4cf1a35|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	04292741-c682-4018-b513-edb134889b35
bd6f89bd-b8a9-4fca-96b0-ba02192d6a0f	3	DataClass	\N	1b151ae1-2b74-44a4-a865-28a521b61d68	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n1b151ae1-2b74-44a4-a865-28a521b61d68|DataClass|V2 Data Class|null	f	V2 Data Class	04292741-c682-4018-b513-edb134889b35
c48cec78-d62f-46f6-a847-e487e0814fe9	3	DataClass	\N	b0041c32-46a2-4427-9f99-e1f9544e7949	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\nb0041c32-46a2-4427-9f99-e1f9544e7949|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	04292741-c682-4018-b513-edb134889b35
c8356771-3fbf-430d-8d88-4ac42277a465	3	DataElement	\N	a7729d1b-9be9-44a7-bb92-0e23bedc05a6	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\nc52b5d6f-ffe0-4984-946b-adfcb4cf1a35|DataClass|V1 Modify Data Class|null\na7729d1b-9be9-44a7-bb92-0e23bedc05a6|DataElement|Modified Label On this element|null	f	Modified Label On this element	b0c90336-e5f4-4f45-a8f6-74ca4639f173
cd6801ee-5f64-4157-bfee-98236733fc8d	3	PrimitiveType	\N	f43a3684-69de-418a-b22e-72b925c7f9d5	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\nf43a3684-69de-418a-b22e-72b925c7f9d5|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	04292741-c682-4018-b513-edb134889b35
d9e8efb6-0dd4-4d36-b615-fcbda3fc9f2a	3	DataElement	\N	81325df2-f680-4206-bd95-00cbce949b9f	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n1b151ae1-2b74-44a4-a865-28a521b61d68|DataClass|V2 Data Class|null\n81325df2-f680-4206-bd95-00cbce949b9f|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	bd6f89bd-b8a9-4fca-96b0-ba02192d6a0f
ddfcfdc8-898a-4a88-adb6-32ad66798437	4	DataElement	\N	c7cb89d6-3716-4183-a903-afa88eb46b4d	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n2337c502-9095-4159-89ec-affc7f0e0535|DataClass|V1 Data Class|null\nc7cb89d6-3716-4183-a903-afa88eb46b4d|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	93d6c866-c1f5-4e63-99b6-9dbee4fb8faa
00006932-a566-4fc7-8f38-9668928e79da	3	PrimitiveType	\N	241094fa-817f-41c8-aa73-0cbf44f727ce	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n241094fa-817f-41c8-aa73-0cbf44f727ce|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	04292741-c682-4018-b513-edb134889b35
04292741-c682-4018-b513-edb134889b35	3	DataModel	f	eb5a08e6-844e-47c1-a31f-160dd238c202	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false	t	Model Version Tree DataModel	\N
158399ca-c8ff-4c48-a2d9-e8e9a85ef592	4	DataElement	\N	21055a03-4775-4c04-be32-834238ecadda	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n1b151ae1-2b74-44a4-a865-28a521b61d68|DataClass|V2 Data Class|null\n21055a03-4775-4c04-be32-834238ecadda|DataElement|V2 Data Element|null	f	V2 Data Element	bd6f89bd-b8a9-4fca-96b0-ba02192d6a0f
26531fcc-bcc3-4416-8fa7-6c44c824311c	3	DataClass	\N	9d1f62b9-a19b-44f8-b5c3-971665681c43	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\nc52b5d6f-ffe0-4984-946b-adfcb4cf1a35|DataClass|V1 Modify Data Class|null\n9d1f62b9-a19b-44f8-b5c3-971665681c43|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	b0c90336-e5f4-4f45-a8f6-74ca4639f173
2bafc74d-c557-49b8-822d-83281c75a9f1	2	PrimitiveType	\N	3b93f98a-b33a-4cba-9a1e-f92b7583dd25	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n3b93f98a-b33a-4cba-9a1e-f92b7583dd25|PrimitiveType|string|null	f	string	04292741-c682-4018-b513-edb134889b35
393fb147-0319-492a-a15d-ed47ede8908e	3	PrimitiveType	\N	944f49a0-eec3-4d75-8476-1fd4dde40a76	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n944f49a0-eec3-4d75-8476-1fd4dde40a76|PrimitiveType|V1 Data Type|null	f	V1 Data Type	04292741-c682-4018-b513-edb134889b35
5e1973b9-7d68-4b4e-a7fa-90db5e18ac30	3	PrimitiveType	\N	10a25708-2580-4ca4-88de-21348e805ca8	eb5a08e6-844e-47c1-a31f-160dd238c202|DataModel|Model Version Tree DataModel|false\n10a25708-2580-4ca4-88de-21348e805ca8|PrimitiveType|V2 Data Type|null	f	V2 Data Type	04292741-c682-4018-b513-edb134889b35
74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c	1	DataModel	f	4b01f763-2505-46a2-938b-88622ca2eaa8	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false	t	Model Version Tree DataModel	\N
84d8131b-7d16-467b-8ffc-5851367e40c3	1	DataClass	\N	864840e4-8a66-40a0-9ee5-63b429410541	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n864840e4-8a66-40a0-9ee5-63b429410541|DataClass|V2 Data Class|null	f	V2 Data Class	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c
af87950b-1396-4291-82af-16c72d89a8cb	1	DataClass	\N	d87845e7-f37a-4e56-9b64-a164397b8ead	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\nd87845e7-f37a-4e56-9b64-a164397b8ead|DataClass|V1 Another Data Class|null	f	V1 Another Data Class	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c
c30e94a5-561e-4e46-9e41-5f2236fc696c	1	PrimitiveType	\N	2be54098-04ed-4795-8fcd-81a8f29e67a8	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n2be54098-04ed-4795-8fcd-81a8f29e67a8|PrimitiveType|V1 Data Type|null	f	V1 Data Type	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c
c93ff336-0bff-40b6-ae4a-e9437697963f	1	DataElement	\N	b7300ae0-6827-4559-86b0-2a81e16805cb	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n864840e4-8a66-40a0-9ee5-63b429410541|DataClass|V2 Data Class|null\nb7300ae0-6827-4559-86b0-2a81e16805cb|DataElement|V2 Third DataElement|null	f	V2 Third DataElement	84d8131b-7d16-467b-8ffc-5851367e40c3
d00da5d8-0002-48c5-abdc-90c61c843462	1	DataElement	\N	2d7d41cf-5a2b-4d1c-b280-27a6e39f9473	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n864840e4-8a66-40a0-9ee5-63b429410541|DataClass|V2 Data Class|null\n2d7d41cf-5a2b-4d1c-b280-27a6e39f9473|DataElement|V2 Second DataElement|null	f	V2 Second DataElement	84d8131b-7d16-467b-8ffc-5851367e40c3
fa93613d-5563-422c-8af3-a58bfb22374a	1	DataClass	\N	ad087a7f-a365-451d-8f43-62f4a23d3303	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\nad087a7f-a365-451d-8f43-62f4a23d3303|DataClass|V1 Data Class|null	f	V1 Data Class	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c
fae205b7-adb7-4119-b303-055713c03992	1	DataClass	\N	3e429da2-561b-48dd-bf3d-a1e28d574cc1	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n3e429da2-561b-48dd-bf3d-a1e28d574cc1|DataClass|V1 Modify Data Class|null	f	V1 Modify Data Class	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c
0c4b5b5e-fa89-4852-889b-265250982700	1	DataElement	\N	abd40f48-9adf-4700-8a9d-104ed1c9afb6	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n864840e4-8a66-40a0-9ee5-63b429410541|DataClass|V2 Data Class|null\nabd40f48-9adf-4700-8a9d-104ed1c9afb6|DataElement|V2 Data Element|null	f	V2 Data Element	84d8131b-7d16-467b-8ffc-5851367e40c3
16f0e226-2d6e-4473-8bfb-f63c8b3bc35a	1	DataClass	\N	b55ac619-f4c0-4d6d-86da-f02b868df7b1	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n3e429da2-561b-48dd-bf3d-a1e28d574cc1|DataClass|V1 Modify Data Class|null\nb55ac619-f4c0-4d6d-86da-f02b868df7b1|DataClass|V1 Internal Data Class|null	f	V1 Internal Data Class	fae205b7-adb7-4119-b303-055713c03992
1739d6c4-ca9f-42d3-89d1-8508edae99c7	1	DataElement	\N	faca94c6-de54-4c65-aa2c-6c0ea530e82c	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\nad087a7f-a365-451d-8f43-62f4a23d3303|DataClass|V1 Data Class|null\nfaca94c6-de54-4c65-aa2c-6c0ea530e82c|DataElement|V1 Second DataElement|null	f	V1 Second DataElement	fa93613d-5563-422c-8af3-a58bfb22374a
2b0dd363-4ea3-483c-aa33-4bb5fa370261	1	PrimitiveType	\N	85480359-f7ba-4e7d-af94-ec2392733e3f	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n85480359-f7ba-4e7d-af94-ec2392733e3f|PrimitiveType|V2 Data Type|null	f	V2 Data Type	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c
46b52925-d7b1-4d40-9963-3698ef34b1f7	1	PrimitiveType	\N	ad70193a-c09e-4ea5-97f0-17fed041198e	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\nad70193a-c09e-4ea5-97f0-17fed041198e|PrimitiveType|V2 Data Type 2|null	f	V2 Data Type 2	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c
68d1d2f3-54cb-4994-8de5-45aa2439f107	1	PrimitiveType	\N	b3ecf027-4cb6-44c2-87cf-dd2570883ed2	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\nb3ecf027-4cb6-44c2-87cf-dd2570883ed2|PrimitiveType|V2 Data Type 3|null	f	V2 Data Type 3	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c
9d3d6e43-1364-4120-87a9-9a5e1dbe75fe	2	DataElement	\N	6d33c17e-afda-483b-8cb0-1e9639503289	4b01f763-2505-46a2-938b-88622ca2eaa8|DataModel|Model Version Tree DataModel|false\n3e429da2-561b-48dd-bf3d-a1e28d574cc1|DataClass|V1 Modify Data Class|null\n6d33c17e-afda-483b-8cb0-1e9639503289|DataElement|Modified Label On this element|null	f	Modified Label On this element	fae205b7-adb7-4119-b303-055713c03992
517a29c7-3527-42a8-8dd2-eaaff44308fc	3	DataModel	f	b5dca58a-c401-4423-acd6-33d391b909c2	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false	t	TargetFlowDataModel	\N
84bbd789-8e27-480f-86c2-1a07ea98b4f1	4	DataElement	\N	eb25c72b-cc39-4400-9039-12c78a4969be	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb7dd4552-90b4-4cf5-879a-9438e00a1afd|DataClass|tableA|null\neb25c72b-cc39-4400-9039-12c78a4969be|DataElement|columnA|null	f	columnA	9b6468f4-b37e-4219-a829-9b1f59004106
8d65b25d-c408-450b-aa7b-c6b58ed484fd	4	DataElement	\N	7c9c4778-4e09-4133-ac9c-d4518adee5b0	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb7dd4552-90b4-4cf5-879a-9438e00a1afd|DataClass|tableA|null\n7c9c4778-4e09-4133-ac9c-d4518adee5b0|DataElement|columnC|null	f	columnC	9b6468f4-b37e-4219-a829-9b1f59004106
9b607be4-91f4-442e-b484-75eca144fa36	3	DataModel	f	bb3deab5-3b2e-418b-9bff-6bd62e49354d	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false	t	SourceFlowDataModel	\N
9b6468f4-b37e-4219-a829-9b1f59004106	3	DataClass	\N	b7dd4552-90b4-4cf5-879a-9438e00a1afd	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb7dd4552-90b4-4cf5-879a-9438e00a1afd|DataClass|tableA|null	f	tableA	9b607be4-91f4-442e-b484-75eca144fa36
acaa4312-50a7-4071-aac5-4d993fad44db	2	DataElement	\N	d1d64057-8bb1-4247-9a60-44cbc117893b	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n1dec0232-e3fc-4a40-a76c-01cfe1c15e3b|DataClass|tableE|null\nd1d64057-8bb1-4247-9a60-44cbc117893b|DataElement|columnV|null	f	columnV	6014f80f-b075-4950-a652-96635bf5b542
b0663109-f082-41b0-908b-c98c8a647492	2	DataElement	\N	7aeeaf13-2e6d-4492-ab8d-8d895270767b	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n1dec0232-e3fc-4a40-a76c-01cfe1c15e3b|DataClass|tableE|null\n7aeeaf13-2e6d-4492-ab8d-8d895270767b|DataElement|columnS|null	f	columnS	6014f80f-b075-4950-a652-96635bf5b542
b996f3e2-d793-46c9-b76b-abd3b2a0666a	2	DataElement	\N	92334819-e343-4606-9291-9507305183c0	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n0cbac9f2-d584-4473-9619-fa49740bf9e2|DataClass|tableD|null\n92334819-e343-4606-9291-9507305183c0|DataElement|columnQ|null	f	columnQ	52115a39-7646-4479-bf71-5627f9e00776
c39b1ea2-34db-421a-8b9d-8319046c3f84	3	PrimitiveType	\N	d1a0f502-3889-4b9a-9828-b5d78d4ec146	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nd1a0f502-3889-4b9a-9828-b5d78d4ec146|PrimitiveType|string|null	f	string	9b607be4-91f4-442e-b484-75eca144fa36
c3c31aab-a1e0-4545-a9b7-8a9c4f32c732	4	DataElement	\N	90c6becd-592e-4da5-8aa5-20747d781eb7	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\n269ea29f-b6e2-4d61-a26e-bc08942d0f14|DataClass|tableB|null\n90c6becd-592e-4da5-8aa5-20747d781eb7|DataElement|columnF|null	f	columnF	dfb71cfa-a2d1-4feb-89cc-abfccba579b8
d4bd816a-5dce-44ba-9b15-f7a3c4d081e4	2	PrimitiveType	\N	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n2ba8bfb2-8986-4755-b4d5-ae92baf96a9d|PrimitiveType|string|null	f	string	517a29c7-3527-42a8-8dd2-eaaff44308fc
d645dfe5-fabd-4214-ae30-ade3743348f4	2	DataElement	\N	e04dcbc9-0716-44ea-879d-bc0b93e40f2d	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n0cbac9f2-d584-4473-9619-fa49740bf9e2|DataClass|tableD|null\ne04dcbc9-0716-44ea-879d-bc0b93e40f2d|DataElement|columnP|null	f	columnP	52115a39-7646-4479-bf71-5627f9e00776
df24db80-b9db-4d9b-a5ef-f0142b1464fa	3	PrimitiveType	\N	2608400c-7966-47ad-85ea-04eeff4e3de4	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\n2608400c-7966-47ad-85ea-04eeff4e3de4|PrimitiveType|integer|null	f	integer	9b607be4-91f4-442e-b484-75eca144fa36
df7a1a68-75bd-48db-b513-656b8c5e20e6	3	DataElement	\N	fca598a4-fc87-4020-956e-bdbd2085e580	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb7dd4552-90b4-4cf5-879a-9438e00a1afd|DataClass|tableA|null\nfca598a4-fc87-4020-956e-bdbd2085e580|DataElement|columnB|null	f	columnB	9b6468f4-b37e-4219-a829-9b1f59004106
df876664-a82c-4a55-955e-73495243982c	4	DataElement	\N	7336d38b-7a77-4760-b4c7-ea072ca9635f	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\n269ea29f-b6e2-4d61-a26e-bc08942d0f14|DataClass|tableB|null\n7336d38b-7a77-4760-b4c7-ea072ca9635f|DataElement|columnH|null	f	columnH	dfb71cfa-a2d1-4feb-89cc-abfccba579b8
dfb71cfa-a2d1-4feb-89cc-abfccba579b8	3	DataClass	\N	269ea29f-b6e2-4d61-a26e-bc08942d0f14	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\n269ea29f-b6e2-4d61-a26e-bc08942d0f14|DataClass|tableB|null	f	tableB	9b607be4-91f4-442e-b484-75eca144fa36
ed6d980f-8742-4bc5-b92d-2a97e7e0d102	3	DataElement	\N	064a4aec-3db8-4cf7-af1c-187d078781e0	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\n269ea29f-b6e2-4d61-a26e-bc08942d0f14|DataClass|tableB|null\n064a4aec-3db8-4cf7-af1c-187d078781e0|DataElement|columnE1|null	f	columnE1	dfb71cfa-a2d1-4feb-89cc-abfccba579b8
ed95e360-cfec-4a85-be8a-4594e3733d97	4	DataElement	\N	1972c66e-0d7f-4776-806b-eea305091f12	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb5d32e45-3bbc-4b41-a96b-75019b8d5773|DataClass|tableC|null\n1972c66e-0d7f-4776-806b-eea305091f12|DataElement|columnE2|null	f	columnE2	140b72da-6d1f-460f-b726-770084f0a52f
ee8b4134-1d90-423c-98ae-81dd617454dc	4	DataElement	\N	e86518db-243a-4443-9abd-96bfb794f38c	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb5d32e45-3bbc-4b41-a96b-75019b8d5773|DataClass|tableC|null\ne86518db-243a-4443-9abd-96bfb794f38c|DataElement|columnK|null	f	columnK	140b72da-6d1f-460f-b726-770084f0a52f
f0fa6596-a9e0-49fa-9bc5-f9d34a9f0a56	4	DataElement	\N	ec2c0cd5-b87e-4955-be7f-8020a7eae6ba	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb5d32e45-3bbc-4b41-a96b-75019b8d5773|DataClass|tableC|null\nec2c0cd5-b87e-4955-be7f-8020a7eae6ba|DataElement|columnM|null	f	columnM	140b72da-6d1f-460f-b726-770084f0a52f
fa155d4e-5f81-40b2-89ee-d536c517d45b	2	DataElement	\N	52548ab2-7357-4783-9ae7-3d0a0df1fa7a	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n1dec0232-e3fc-4a40-a76c-01cfe1c15e3b|DataClass|tableE|null\n52548ab2-7357-4783-9ae7-3d0a0df1fa7a|DataElement|columnR|null	f	columnR	6014f80f-b075-4950-a652-96635bf5b542
fca1e721-e460-43a3-bcee-09fe50fb8043	2	DataElement	\N	75e0517f-257f-4ef4-b40f-9bce70ca2435	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n1dec0232-e3fc-4a40-a76c-01cfe1c15e3b|DataClass|tableE|null\n75e0517f-257f-4ef4-b40f-9bce70ca2435|DataElement|columnT|null	f	columnT	6014f80f-b075-4950-a652-96635bf5b542
03ab793c-83a5-4166-939b-ec5e296138da	4	DataElement	\N	9eb5dd97-ae95-44d9-926c-d25f628a8be6	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb5d32e45-3bbc-4b41-a96b-75019b8d5773|DataClass|tableC|null\n9eb5dd97-ae95-44d9-926c-d25f628a8be6|DataElement|columnL|null	f	columnL	140b72da-6d1f-460f-b726-770084f0a52f
0559336d-0ee0-4b64-8687-d81f50c9ee13	2	DataElement	\N	cd56c5e5-c19b-4084-a4b3-9a143fda562f	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n1dec0232-e3fc-4a40-a76c-01cfe1c15e3b|DataClass|tableE|null\ncd56c5e5-c19b-4084-a4b3-9a143fda562f|DataElement|columnU|null	f	columnU	6014f80f-b075-4950-a652-96635bf5b542
05ce9d9f-9e8e-4308-8e7d-391cbffc6d39	2	DataElement	\N	90f026a3-a2b5-48c4-a316-b08594a9e33a	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n0cbac9f2-d584-4473-9619-fa49740bf9e2|DataClass|tableD|null\n90f026a3-a2b5-48c4-a316-b08594a9e33a|DataElement|columnN|null	f	columnN	52115a39-7646-4479-bf71-5627f9e00776
0a6693ee-ee94-40dc-b876-563449b8de95	3	DataElement	\N	06807126-23a9-4c3e-b46c-5613da5df691	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\n269ea29f-b6e2-4d61-a26e-bc08942d0f14|DataClass|tableB|null\n06807126-23a9-4c3e-b46c-5613da5df691|DataElement|columnG|null	f	columnG	dfb71cfa-a2d1-4feb-89cc-abfccba579b8
140b72da-6d1f-460f-b726-770084f0a52f	3	DataClass	\N	b5d32e45-3bbc-4b41-a96b-75019b8d5773	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb5d32e45-3bbc-4b41-a96b-75019b8d5773|DataClass|tableC|null	f	tableC	9b607be4-91f4-442e-b484-75eca144fa36
23d4a078-1afa-4b9c-a3cb-49cb0ea2adad	3	DataElement	\N	32f481fc-c11d-4a58-87d8-002bda10440c	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb7dd4552-90b4-4cf5-879a-9438e00a1afd|DataClass|tableA|null\n32f481fc-c11d-4a58-87d8-002bda10440c|DataElement|columnD|null	f	columnD	9b6468f4-b37e-4219-a829-9b1f59004106
2d007721-5827-40cb-ac6e-20d3416401f7	2	DataElement	\N	3dd5a3a2-fb16-4859-becc-a17ce1d30775	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n0cbac9f2-d584-4473-9619-fa49740bf9e2|DataClass|tableD|null\n3dd5a3a2-fb16-4859-becc-a17ce1d30775|DataElement|columnO|null	f	columnO	52115a39-7646-4479-bf71-5627f9e00776
39321a33-c577-42d4-93b9-2f63aaaf596a	1	DataFlow	\N	d6f8e215-4d23-4592-9ebb-c901619ff147	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null	f	Sample DataFlow	517a29c7-3527-42a8-8dd2-eaaff44308fc
486cb826-7539-4a9b-9c05-ecf1228c822b	3	DataElement	\N	d19e8097-6e04-4bb7-b20a-3ff595acfbe7	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\nb5d32e45-3bbc-4b41-a96b-75019b8d5773|DataClass|tableC|null\nd19e8097-6e04-4bb7-b20a-3ff595acfbe7|DataElement|columnJ|null	f	columnJ	140b72da-6d1f-460f-b726-770084f0a52f
4d2eb56e-9d2a-459d-a4ea-3dcaa1a46e93	2	PrimitiveType	\N	06f6c250-c3c2-45ce-93ac-edbfd53e6b30	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n06f6c250-c3c2-45ce-93ac-edbfd53e6b30|PrimitiveType|integer|null	f	integer	517a29c7-3527-42a8-8dd2-eaaff44308fc
52115a39-7646-4479-bf71-5627f9e00776	2	DataClass	\N	0cbac9f2-d584-4473-9619-fa49740bf9e2	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n0cbac9f2-d584-4473-9619-fa49740bf9e2|DataClass|tableD|null	f	tableD	517a29c7-3527-42a8-8dd2-eaaff44308fc
52bde969-5721-4249-b06f-63bb115d8eed	3	DataElement	\N	f2f5d3b1-3512-4186-9c7e-7b858741b541	bb3deab5-3b2e-418b-9bff-6bd62e49354d|DataModel|SourceFlowDataModel|false\n269ea29f-b6e2-4d61-a26e-bc08942d0f14|DataClass|tableB|null\nf2f5d3b1-3512-4186-9c7e-7b858741b541|DataElement|columnI|null	f	columnI	dfb71cfa-a2d1-4feb-89cc-abfccba579b8
6014f80f-b075-4950-a652-96635bf5b542	2	DataClass	\N	1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n1dec0232-e3fc-4a40-a76c-01cfe1c15e3b|DataClass|tableE|null	f	tableE	517a29c7-3527-42a8-8dd2-eaaff44308fc
703d62c4-556b-47ef-9e50-04281ee0987b	2	DataElement	\N	31636115-5edb-4034-a131-44c054d3c40d	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\n1dec0232-e3fc-4a40-a76c-01cfe1c15e3b|DataClass|tableE|null\n31636115-5edb-4034-a131-44c054d3c40d|DataElement|columnE|null	f	columnE	6014f80f-b075-4950-a652-96635bf5b542
b5977387-b06d-43dc-914d-9f4376b85297	1	DataClassComponent	\N	1f75d2ef-6000-4489-836f-590ef32182e3	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n1f75d2ef-6000-4489-836f-590ef32182e3|DataClassComponent|bAndCToE|null	f	bAndCToE	39321a33-c577-42d4-93b9-2f63aaaf596a
fd41fee5-e30b-4584-9338-05822600d65c	1	DataElementComponent	\N	9d71b17b-85d5-4e37-b177-b9b93030bcf6	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n1f75d2ef-6000-4489-836f-590ef32182e3|DataClassComponent|bAndCToE|null\n9d71b17b-85d5-4e37-b177-b9b93030bcf6|DataElementComponent|Direct Copy|null	f	Direct Copy	b5977387-b06d-43dc-914d-9f4376b85297
036ecaa1-42d3-4853-9865-b614c17fb175	1	DataElementComponent	\N	be47c558-3532-4170-8ab8-075a783505aa	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n1f75d2ef-6000-4489-836f-590ef32182e3|DataClassComponent|bAndCToE|null\nbe47c558-3532-4170-8ab8-075a783505aa|DataElementComponent|CONCAT|null	f	CONCAT	b5977387-b06d-43dc-914d-9f4376b85297
3ba4f7f5-4a4e-4eeb-bf0b-de8b5a33293e	1	DataClassComponent	\N	904f76ac-1425-465a-9eae-bd3f1ca8523d	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n904f76ac-1425-465a-9eae-bd3f1ca8523d|DataClassComponent|aToD|null	f	aToD	39321a33-c577-42d4-93b9-2f63aaaf596a
42cf018f-95c4-4a9f-b111-8ad5a89756cf	1	DataElementComponent	\N	493a7bae-ee58-4336-a5a5-2b326f4aeccf	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n904f76ac-1425-465a-9eae-bd3f1ca8523d|DataClassComponent|aToD|null\n493a7bae-ee58-4336-a5a5-2b326f4aeccf|DataElementComponent|Direct Copy|null	f	Direct Copy	3ba4f7f5-4a4e-4eeb-bf0b-de8b5a33293e
4e92dfc9-5c27-4e92-b88f-52687143e8e8	1	DataElementComponent	\N	899a39ed-6a17-464d-b31d-c1de23299ba6	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n904f76ac-1425-465a-9eae-bd3f1ca8523d|DataClassComponent|aToD|null\n899a39ed-6a17-464d-b31d-c1de23299ba6|DataElementComponent|Direct Copy|null	f	Direct Copy	3ba4f7f5-4a4e-4eeb-bf0b-de8b5a33293e
59dd811c-7146-4c52-9868-a4b92fe35432	1	DataElementComponent	\N	68dae507-4a46-451d-bb29-864f619d88ee	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n1f75d2ef-6000-4489-836f-590ef32182e3|DataClassComponent|bAndCToE|null\n68dae507-4a46-451d-bb29-864f619d88ee|DataElementComponent|CONCAT|null	f	CONCAT	b5977387-b06d-43dc-914d-9f4376b85297
78011503-f6c1-4434-a8f4-a9cfb36f9736	1	DataElementComponent	\N	705700af-c2d5-4494-9f17-b9e4f8a83470	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n1f75d2ef-6000-4489-836f-590ef32182e3|DataClassComponent|bAndCToE|null\n705700af-c2d5-4494-9f17-b9e4f8a83470|DataElementComponent|TRIM|null	f	TRIM	b5977387-b06d-43dc-914d-9f4376b85297
9ba5d224-2ee8-4926-8a11-c5e37f8c899d	2	DataElementComponent	\N	e0d045e7-71e0-46e9-a6cc-895279b5278a	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n1f75d2ef-6000-4489-836f-590ef32182e3|DataClassComponent|bAndCToE|null\ne0d045e7-71e0-46e9-a6cc-895279b5278a|DataElementComponent|JOIN KEY|null	f	JOIN KEY	b5977387-b06d-43dc-914d-9f4376b85297
b311047e-e450-4102-9546-019a1feaab43	2	DataElementComponent	\N	de03e854-63d4-41f2-be30-56b3c51e4675	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n1f75d2ef-6000-4489-836f-590ef32182e3|DataClassComponent|bAndCToE|null\nde03e854-63d4-41f2-be30-56b3c51e4675|DataElementComponent|CASE|null	f	CASE	b5977387-b06d-43dc-914d-9f4376b85297
f46d2d3b-c932-43ec-84b0-7a58403ecca9	2	DataElementComponent	\N	2ea1a60d-0d7b-45ef-8f29-762275d68fee	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n904f76ac-1425-465a-9eae-bd3f1ca8523d|DataClassComponent|aToD|null\n2ea1a60d-0d7b-45ef-8f29-762275d68fee|DataElementComponent|Direct Copy|null	f	Direct Copy	3ba4f7f5-4a4e-4eeb-bf0b-de8b5a33293e
fef375d2-be1d-442d-a689-a5d62d0cdf46	2	DataElementComponent	\N	1fdd5e5e-ec35-4596-b98a-d9adcdf5f069	b5dca58a-c401-4423-acd6-33d391b909c2|DataModel|TargetFlowDataModel|false\nd6f8e215-4d23-4592-9ebb-c901619ff147|DataFlow|Sample DataFlow|null\n904f76ac-1425-465a-9eae-bd3f1ca8523d|DataClassComponent|aToD|null\n1fdd5e5e-ec35-4596-b98a-d9adcdf5f069|DataElementComponent|Direct Copy|null	f	Direct Copy	3ba4f7f5-4a4e-4eeb-bf0b-de8b5a33293e
bbc41ec2-a01f-4e03-983f-1dbc6e3779eb	2	Term	\N	a934a9f1-5b47-4995-b087-f1d54433aa1e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\na934a9f1-5b47-4995-b087-f1d54433aa1e|Term|CTT10: Complex Test Term 10|null	f	CTT10: Complex Test Term 10	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
bd1c29fa-77fa-438b-b271-0ea8e755edb3	2	Term	\N	88393671-e333-4dfd-9bb9-73776b8bf5c8	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n88393671-e333-4dfd-9bb9-73776b8bf5c8|Term|CTT12: Complex Test Term 12|null	f	CTT12: Complex Test Term 12	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
807dd4f4-5112-436f-aab3-24996331f952	2	TermRelationship	\N	aaef4866-4632-4bd3-b034-40584fc63b73	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n5b33d920-735d-4548-b152-c42d65a89485|Term|CTT58: Complex Test Term 58|null\naaef4866-4632-4bd3-b034-40584fc63b73|TermRelationship|is-a-part-of|null	f	is-a-part-of	4d9bfc45-8688-4b94-87bc-c2061f9eb637
80cba380-8208-4f58-9ab5-0ca6af7b46d7	2	TermRelationship	\N	a79c7cf2-f648-4b0a-bb0a-c24d04719a3a	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4a25866e-fbaa-4838-a2f6-6337ac5c6d2b|Term|CTT18: Complex Test Term 18|null\na79c7cf2-f648-4b0a-bb0a-c24d04719a3a|TermRelationship|broaderThan|null	f	broaderThan	32f83064-09ee-4533-b4c9-b27cd72cb121
8152e6c2-6607-478b-9e52-934f86361e1b	2	Term	\N	af8368b3-b782-4c27-b593-7e8ac1ccae81	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\naf8368b3-b782-4c27-b593-7e8ac1ccae81|Term|CTT60: Complex Test Term 60|null	f	CTT60: Complex Test Term 60	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
838bbecb-42b3-4ea5-9d0c-49a12bd71901	2	TermRelationshipType	\N	8c743bcc-30fc-4a4a-ac96-1f295364742b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8c743bcc-30fc-4a4a-ac96-1f295364742b|TermRelationshipType|is-a|null	f	is-a	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
83ea1399-1ca9-4ed4-90ef-4650a586ba50	2	TermRelationship	\N	c321667a-7ae3-4fe5-ac5d-dd66ae4e6f38	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n0a7f5772-b95d-4db5-89da-d05458604648|Term|CTT64: Complex Test Term 64|null\nc321667a-7ae3-4fe5-ac5d-dd66ae4e6f38|TermRelationship|is-a-part-of|null	f	is-a-part-of	004f44e9-a7dd-4639-b1f1-292c8885cfa6
840c7a7f-5c92-4651-8b7d-0da7e3adca73	2	Term	\N	18cd848d-eb53-49a7-8fd8-db08a979cb5f	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n18cd848d-eb53-49a7-8fd8-db08a979cb5f|Term|CTT89: Complex Test Term 89|null	f	CTT89: Complex Test Term 89	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
840f46ba-863f-4ee3-8841-efc430abef3f	2	Term	\N	47f19eca-d2dc-490a-9435-d824d8400ba0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n47f19eca-d2dc-490a-9435-d824d8400ba0|Term|CTT91: Complex Test Term 91|null	f	CTT91: Complex Test Term 91	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
858b5711-1979-477b-8b3a-a812e9f4064d	2	Term	\N	95081140-122d-4db5-95bd-d0845c8751e6	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n95081140-122d-4db5-95bd-d0845c8751e6|Term|CTT88: Complex Test Term 88|null	f	CTT88: Complex Test Term 88	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
8cb25aaf-3886-4600-8212-ea41bf061895	2	TermRelationship	\N	c2bd5c4d-44a9-432b-8d6f-dc5d48d342e5	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n3a34acb0-0717-4e5a-976f-eb5b1f3ed124|Term|CTT4: Complex Test Term 4|null\nc2bd5c4d-44a9-432b-8d6f-dc5d48d342e5|TermRelationship|is-a-part-of|null	f	is-a-part-of	7cddeb12-0623-49d4-885e-f4a7c6c8aa21
8ec1e5a3-ac8b-4de3-b2e5-ca6a06cd7f80	2	TermRelationship	\N	5d14954f-bb9b-4161-a7f8-260db0c7e3e2	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4a25866e-fbaa-4838-a2f6-6337ac5c6d2b|Term|CTT18: Complex Test Term 18|null\n5d14954f-bb9b-4161-a7f8-260db0c7e3e2|TermRelationship|is-a-part-of|null	f	is-a-part-of	32f83064-09ee-4533-b4c9-b27cd72cb121
bd539756-ebb4-4e10-8f1e-a2ed9f81c933	2	Term	\N	a45642b2-e367-4dd3-9e65-e0abe67d1969	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\na45642b2-e367-4dd3-9e65-e0abe67d1969|Term|CTT68: Complex Test Term 68|null	f	CTT68: Complex Test Term 68	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
903ab489-6fb4-4b77-b872-59c072ded6fe	2	TermRelationship	\N	36c087ca-cbe2-4876-a4da-8e83163868ec	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n21b59ceb-c5b6-425e-a965-c625117178a6|Term|CTT59: Complex Test Term 59|null\n36c087ca-cbe2-4876-a4da-8e83163868ec|TermRelationship|is-a-part-of|null	f	is-a-part-of	5d350f05-877b-4810-807c-3957dace5674
90b23b09-37e4-494b-8473-a6dab8805ea9	2	TermRelationship	\N	d6677375-6d73-4d3d-a7ae-bf35ef4f4ce5	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc6435a11-e087-4cb9-bb01-81c88ab71113|Term|CTT28: Complex Test Term 28|null\nd6677375-6d73-4d3d-a7ae-bf35ef4f4ce5|TermRelationship|is-a-part-of|null	f	is-a-part-of	d22d28ce-0416-413e-b72d-63fe62c2c172
93594f4c-5527-4774-b6c1-d52b71520f6c	2	TermRelationship	\N	ba52e6ba-2fbf-4ece-9016-509c75a03c9e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ncab6ed3e-d53d-442b-8581-920f2795a15e|Term|CTT73: Complex Test Term 73|null\nba52e6ba-2fbf-4ece-9016-509c75a03c9e|TermRelationship|is-a-part-of|null	f	is-a-part-of	589e3265-0cb4-48e4-ad03-bccadc105fe4
93bcb6e1-8494-404f-8588-c314fe9f2255	2	Term	\N	8c232f5e-7ea6-445a-911f-4ce266f1b1dc	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8c232f5e-7ea6-445a-911f-4ce266f1b1dc|Term|CTT17: Complex Test Term 17|null	f	CTT17: Complex Test Term 17	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
997962cc-9dfd-40e5-8cf1-042727f31e10	2	TermRelationship	\N	42a003d8-2dbe-4e6c-bee1-1239ff3d7789	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n85a0f6b0-c0da-48a6-af33-8772aa496981|Term|CTT81: Complex Test Term 81|null\n42a003d8-2dbe-4e6c-bee1-1239ff3d7789|TermRelationship|is-a-part-of|null	f	is-a-part-of	ea1e0ff9-b8c3-4e6c-a9bc-b8bccd990b39
9a5b9533-7f2e-41c2-acc4-7bb9a2563abf	2	Term	\N	2c1f66bb-0583-4cbb-8d73-d422c177cfef	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n2c1f66bb-0583-4cbb-8d73-d422c177cfef|Term|CTT77: Complex Test Term 77|null	f	CTT77: Complex Test Term 77	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
9aea6e3b-d9d8-4cd3-a6c8-7575e8271924	4	Terminology	f	fa8b47d9-daae-4d61-a682-2a93a893c6ca	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false	t	Complex Test Terminology	\N
9f27aac1-f63b-403e-a005-c63837c1e75a	2	Term	\N	734aa13a-a54e-4ea8-a363-5af80b09a31c	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n734aa13a-a54e-4ea8-a363-5af80b09a31c|Term|CTT97: Complex Test Term 97|null	f	CTT97: Complex Test Term 97	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
a0745a73-656d-4622-9b66-45a67ecfd35b	2	TermRelationship	\N	93464241-4f5a-4e21-bc64-239b33e820ca	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n553439f8-e19e-40a5-a253-48bb36e00199|Term|CTT50: Complex Test Term 50|null\n93464241-4f5a-4e21-bc64-239b33e820ca|TermRelationship|is-a-part-of|null	f	is-a-part-of	1838e389-ee88-4e13-96ec-bfdc752eb587
a0c56558-bf48-4700-97bf-f2be250ef7f4	2	Term	\N	436ab4fe-f546-4982-9997-c002c2d46d65	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n436ab4fe-f546-4982-9997-c002c2d46d65|Term|CTT92: Complex Test Term 92|null	f	CTT92: Complex Test Term 92	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
a11f4a13-621a-4ebb-ad7b-46946d389eab	2	Term	\N	f7c0ae7f-8e45-44f0-8cb8-b060f8176da0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf7c0ae7f-8e45-44f0-8cb8-b060f8176da0|Term|CTT86: Complex Test Term 86|null	f	CTT86: Complex Test Term 86	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
a1292e8a-e26f-413a-9847-1769fdeff35a	2	TermRelationship	\N	bfb890dc-b3fd-4e1e-b70c-1c9fc7030f53	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n54f1ce72-0013-4a11-a24e-2abfa01b34c7|Term|CTT21: Complex Test Term 21|null\nbfb890dc-b3fd-4e1e-b70c-1c9fc7030f53|TermRelationship|is-a-part-of|null	f	is-a-part-of	d13b68d7-9ab3-4309-9a8a-cb37489f7cb3
a1b2cb04-400d-4ce0-a8b5-2edd5d0d8b80	2	Term	\N	443a219c-96ef-4afc-b9fe-a9968c96f1b1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n443a219c-96ef-4afc-b9fe-a9968c96f1b1|Term|CTT14: Complex Test Term 14|null	f	CTT14: Complex Test Term 14	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
a1f0d33f-dd51-45e7-907c-127a7936e400	2	TermRelationship	\N	894357eb-d325-487b-b758-ea6f677639c9	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n88393671-e333-4dfd-9bb9-73776b8bf5c8|Term|CTT12: Complex Test Term 12|null\n894357eb-d325-487b-b758-ea6f677639c9|TermRelationship|broaderThan|null	f	broaderThan	bd1c29fa-77fa-438b-b271-0ea8e755edb3
a218715e-f7df-4147-9192-beca15c820d9	2	TermRelationship	\N	50e478e0-1880-4c6d-914d-dec641886084	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n7940bb06-7dba-4141-95c0-e2db8b98216f|Term|CTT47: Complex Test Term 47|null\n50e478e0-1880-4c6d-914d-dec641886084|TermRelationship|is-a-part-of|null	f	is-a-part-of	7032e9b0-6743-49a1-a4ce-c6876be54aae
a5c05cd7-d036-47ec-96e8-ffcb950f8b01	2	Term	\N	be81e94c-1d7f-4c63-b0fc-f4eecef29983	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nbe81e94c-1d7f-4c63-b0fc-f4eecef29983|Term|CTT98: Complex Test Term 98|null	f	CTT98: Complex Test Term 98	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
a5c5ade3-4b1d-4b77-b9e4-6b5e97f339a5	2	Term	\N	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne477f4eb-9dd5-4a67-86bb-7e292ada8f58|Term|CTT70: Complex Test Term 70|null	f	CTT70: Complex Test Term 70	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
a7472704-2123-4b5a-a097-7b3f6fe6fa18	2	Term	\N	0ae53ea0-d964-4218-a5de-9826a41cac35	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n0ae53ea0-d964-4218-a5de-9826a41cac35|Term|CTT35: Complex Test Term 35|null	f	CTT35: Complex Test Term 35	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
a887ca80-5b2d-4e22-9f8c-d95f21eb6bca	2	Term	\N	8c9dffc0-acdb-416c-acec-4b950e0d1cb7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8c9dffc0-acdb-416c-acec-4b950e0d1cb7|Term|CTT43: Complex Test Term 43|null	f	CTT43: Complex Test Term 43	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
aaa79497-8338-4803-9b18-cd4414f9ece5	2	Term	\N	e507201e-f57f-4e90-b6c1-b8a83c51c702	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne507201e-f57f-4e90-b6c1-b8a83c51c702|Term|CTT36: Complex Test Term 36|null	f	CTT36: Complex Test Term 36	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
ab578a48-293a-4be0-9426-6b3c70b4ea18	2	TermRelationship	\N	75f0f914-1569-470e-84e9-528aea371c33	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n583adb72-aca6-41fb-a2ad-56eed28ef826|Term|CTT13: Complex Test Term 13|null\n75f0f914-1569-470e-84e9-528aea371c33|TermRelationship|broaderThan|null	f	broaderThan	66f479d1-5218-485e-9e06-3850c5a1bd96
aed37100-2474-412a-80f0-5bbe5228685e	2	TermRelationship	\N	688449cb-5a44-4ca3-9e06-42535c9772d8	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ned487d06-4c11-473e-bc22-5ac46e223028|Term|CTT67: Complex Test Term 67|null\n688449cb-5a44-4ca3-9e06-42535c9772d8|TermRelationship|is-a-part-of|null	f	is-a-part-of	13f344d3-7805-47d7-b72b-4dc75f309a63
b29f081f-528a-41da-9dc6-30d1cd07b684	2	Term	\N	0d938873-4766-4dac-930f-ddc43cad2c39	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n0d938873-4766-4dac-930f-ddc43cad2c39|Term|CTT51: Complex Test Term 51|null	f	CTT51: Complex Test Term 51	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
b2c0ce3d-91b5-4912-bcc7-e2f2c6c20152	2	TermRelationship	\N	c3dde2ea-0680-4019-b888-e317a3e48a43	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n6f80cd8a-edc2-4398-a38e-e26ed6e2f467|Term|CTT24: Complex Test Term 24|null\nc3dde2ea-0680-4019-b888-e317a3e48a43|TermRelationship|is-a-part-of|null	f	is-a-part-of	19ba9219-08af-4d16-af5e-dce3aee2bf17
b795145b-9990-4bca-a650-9d2d773ae7f0	2	Term	\N	f53c5264-8350-4b92-98be-c3fb976b1f57	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf53c5264-8350-4b92-98be-c3fb976b1f57|Term|CTT100: Complex Test Term 100|null	f	CTT100: Complex Test Term 100	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
bddddecf-a170-4c86-91b2-b38935fe0c2d	2	TermRelationship	\N	8f34beaf-89ee-4dc8-83d7-e28af1b9d39c	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n18cd848d-eb53-49a7-8fd8-db08a979cb5f|Term|CTT89: Complex Test Term 89|null\n8f34beaf-89ee-4dc8-83d7-e28af1b9d39c|TermRelationship|is-a-part-of|null	f	is-a-part-of	840c7a7f-5c92-4651-8b7d-0da7e3adca73
bf1e3c0d-6166-4b49-ad0d-dead5a3595c7	2	Term	\N	d1a19f41-8726-4215-8a4e-774d448ab564	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nd1a19f41-8726-4215-8a4e-774d448ab564|Term|CTT61: Complex Test Term 61|null	f	CTT61: Complex Test Term 61	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
bf798318-5ab8-4c59-9694-717c536a16b8	2	TermRelationship	\N	4355ac72-1f4a-4a18-a7cb-8f48afe74e19	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nea8d3d31-39bc-4194-b0bc-fa0e23fc1771|Term|CTT5: Complex Test Term 5|null\n4355ac72-1f4a-4a18-a7cb-8f48afe74e19|TermRelationship|narrowerThan|null	f	narrowerThan	fdd81b9e-c89c-494a-81e0-f050e4dd58e0
bf863861-2543-4891-8d40-e724517a79ab	2	TermRelationship	\N	ea3a5b75-db74-46cb-a22e-981ebffade5a	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n89e014cc-5d4a-4b33-990e-32bcda03f5f1|Term|CTT2: Complex Test Term 2|null\nea3a5b75-db74-46cb-a22e-981ebffade5a|TermRelationship|narrowerThan|null	f	narrowerThan	e42abde1-9972-4c9a-910d-93405ad41d5e
c0249fc0-f5a4-4633-afd1-39501b47a85f	2	Term	\N	e5a57d8f-d9a1-45d9-8145-5bcfda4db009	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne5a57d8f-d9a1-45d9-8145-5bcfda4db009|Term|CTT31: Complex Test Term 31|null	f	CTT31: Complex Test Term 31	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
c075998d-27c4-4105-9f3d-6da81146d38f	2	TermRelationship	\N	aa7517f4-4ed7-4534-a7cd-d89cac3a6d22	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n71809374-0803-432c-b2cc-934904225ab7|Term|CTT33: Complex Test Term 33|null\naa7517f4-4ed7-4534-a7cd-d89cac3a6d22|TermRelationship|is-a-part-of|null	f	is-a-part-of	eb3ec6ce-3699-4156-a27b-f0f645095a65
c1780253-a811-41fe-858f-b3e0cf258d7f	2	Term	\N	c9f71177-d940-44e2-9807-be88b8b7bc32	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc9f71177-d940-44e2-9807-be88b8b7bc32|Term|CTT63: Complex Test Term 63|null	f	CTT63: Complex Test Term 63	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
c386374f-70d8-46f1-9761-d1e85be2d9a6	2	Term	\N	81773135-7779-40ca-9e07-31b4d5b8dd03	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n81773135-7779-40ca-9e07-31b4d5b8dd03|Term|CTT66: Complex Test Term 66|null	f	CTT66: Complex Test Term 66	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
c642b601-0ed6-4907-a7e5-148f93b6e33c	2	TermRelationship	\N	d91b985f-57fe-45bf-9361-89c259bcfdb9	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n780dafdb-7115-4d89-8466-124f3c984c76|Term|CTT72: Complex Test Term 72|null\nd91b985f-57fe-45bf-9361-89c259bcfdb9|TermRelationship|is-a-part-of|null	f	is-a-part-of	40d07642-393f-4b0b-a36b-bdd2354ecf39
c6a87e53-77e0-4c2f-96c2-ee2133f3dfa1	2	TermRelationship	\N	676d8c5f-4610-43f6-bf1e-5859876d0207	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n12b9ade2-9bb9-4156-862c-4c16e4ff3b25|Term|CTT62: Complex Test Term 62|null\n676d8c5f-4610-43f6-bf1e-5859876d0207|TermRelationship|is-a-part-of|null	f	is-a-part-of	28d6a82d-1acb-4822-ac42-2a84105b0094
c744f8fc-5c6a-4a9d-947e-aaabb2b91f71	2	TermRelationship	\N	65a4358d-d70d-453b-83ca-61111ee13a31	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n07bcbcd1-e322-4173-af44-0f7dfaee4259|Term|CTT46: Complex Test Term 46|null\n65a4358d-d70d-453b-83ca-61111ee13a31|TermRelationship|is-a-part-of|null	f	is-a-part-of	e8d3acf3-f58c-4353-8e11-1a7c26aa3731
c8c96392-c548-4810-bbbf-65b6cc18cd60	2	TermRelationship	\N	229f835a-351e-4533-8c1e-7ca633a0a2d1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n578acfea-5b75-4ef8-acec-74f21d6c4471|Term|CTT30: Complex Test Term 30|null\n229f835a-351e-4533-8c1e-7ca633a0a2d1|TermRelationship|is-a-part-of|null	f	is-a-part-of	6bf87a51-d9d2-479e-8425-a74d125ac492
ca0581b1-0c98-4c9d-8d57-96962481f4da	2	Term	\N	aef3acca-96c0-4827-9e73-c3f89bc85118	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\naef3acca-96c0-4827-9e73-c3f89bc85118|Term|CTT16: Complex Test Term 16|null	f	CTT16: Complex Test Term 16	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
caad33b6-6a74-4aa1-bdf6-2021affb7fde	2	TermRelationshipType	\N	fb178eb6-6853-415f-ae97-ee480f8d65fe	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nfb178eb6-6853-415f-ae97-ee480f8d65fe|TermRelationshipType|is-a-part-of|null	f	is-a-part-of	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
cc5f077c-9728-420d-abc7-80e4f99972ad	2	TermRelationship	\N	f5b2d7be-00c0-4fd1-bc33-44a795baaab2	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4872b09e-94f2-4b75-a516-66b1a8636670|Term|CTT96: Complex Test Term 96|null\nf5b2d7be-00c0-4fd1-bc33-44a795baaab2|TermRelationship|is-a-part-of|null	f	is-a-part-of	1ea01b36-2f79-4b56-96d7-9c260d24fc5a
ce269fc0-1d58-4ceb-81c3-fd4df2e2630b	2	TermRelationshipType	\N	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n0fdd6c46-0864-441c-a0ad-8e0d87cbc528|TermRelationshipType|broaderThan|null	f	broaderThan	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
cf17bc2e-731c-47ba-8684-c6e9e43e5f95	2	TermRelationship	\N	687dd1fc-2f53-40c7-91b3-c0f6e11f723b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc62afddf-d800-4997-958d-e21af5b67e00|Term|CTT78: Complex Test Term 78|null\n687dd1fc-2f53-40c7-91b3-c0f6e11f723b|TermRelationship|is-a-part-of|null	f	is-a-part-of	2b0648b7-3b3d-4f52-af9d-ce7dd8ce94cd
cf46a9cb-84e9-4ce3-b1b9-a598ac339882	2	Term	\N	553b84d1-3cfb-40fe-ad09-74468c158f7c	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n553b84d1-3cfb-40fe-ad09-74468c158f7c|Term|CTT79: Complex Test Term 79|null	f	CTT79: Complex Test Term 79	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
d13b68d7-9ab3-4309-9a8a-cb37489f7cb3	2	Term	\N	54f1ce72-0013-4a11-a24e-2abfa01b34c7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n54f1ce72-0013-4a11-a24e-2abfa01b34c7|Term|CTT21: Complex Test Term 21|null	f	CTT21: Complex Test Term 21	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
d1501c2e-eaf0-4db4-9c7a-9edcdfa76008	2	TermRelationship	\N	6cd73536-7442-4ea5-8c82-a9d98e3bc73e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ncfa35353-0759-44e6-834c-2b986e698fd0|Term|CTT74: Complex Test Term 74|null\n6cd73536-7442-4ea5-8c82-a9d98e3bc73e|TermRelationship|is-a-part-of|null	f	is-a-part-of	591cd88f-4fc1-4d07-a241-8f526bd5fb19
d155d5be-2574-407b-8f3c-0ea049669883	2	Term	\N	55f22fde-097a-41a8-8e87-180e30b8e117	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n55f22fde-097a-41a8-8e87-180e30b8e117|Term|CTT54: Complex Test Term 54|null	f	CTT54: Complex Test Term 54	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
d22d28ce-0416-413e-b72d-63fe62c2c172	2	Term	\N	c6435a11-e087-4cb9-bb01-81c88ab71113	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc6435a11-e087-4cb9-bb01-81c88ab71113|Term|CTT28: Complex Test Term 28|null	f	CTT28: Complex Test Term 28	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
d22f997d-668a-46fc-bb59-0149d5c21d7c	2	TermRelationship	\N	d52c7a3c-e878-441b-bc08-2b3e16b44589	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n81773135-7779-40ca-9e07-31b4d5b8dd03|Term|CTT66: Complex Test Term 66|null\nd52c7a3c-e878-441b-bc08-2b3e16b44589|TermRelationship|is-a-part-of|null	f	is-a-part-of	c386374f-70d8-46f1-9761-d1e85be2d9a6
d2333774-2aa5-4bd1-8afc-3efc3bc236e9	2	Term	\N	413df0ac-c866-44f9-af53-ca65f9c28da1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n413df0ac-c866-44f9-af53-ca65f9c28da1|Term|CTT49: Complex Test Term 49|null	f	CTT49: Complex Test Term 49	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
d4a0499e-ff42-4423-a2d9-015221cfa4ad	2	TermRelationship	\N	97cf230c-81b1-4e1e-8e6c-4f25869bc7d8	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8c232f5e-7ea6-445a-911f-4ce266f1b1dc|Term|CTT17: Complex Test Term 17|null\n97cf230c-81b1-4e1e-8e6c-4f25869bc7d8|TermRelationship|is-a-part-of|null	f	is-a-part-of	93bcb6e1-8494-404f-8588-c314fe9f2255
d9c85ec5-f8ea-4f09-957c-dc1e71566be8	2	Term	\N	8cd60786-686b-47fb-901d-0410d2cbf21b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8cd60786-686b-47fb-901d-0410d2cbf21b|Term|CTT19: Complex Test Term 19|null	f	CTT19: Complex Test Term 19	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
da6b9cc2-1072-4f9c-8173-7a4c0b5a4341	2	TermRelationship	\N	e1f691e0-d1e8-4164-9063-bc8b665a89da	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n2c1f66bb-0583-4cbb-8d73-d422c177cfef|Term|CTT77: Complex Test Term 77|null\ne1f691e0-d1e8-4164-9063-bc8b665a89da|TermRelationship|is-a-part-of|null	f	is-a-part-of	9a5b9533-7f2e-41c2-acc4-7bb9a2563abf
da7246f4-00e6-4e96-9629-bac6f220be27	2	TermRelationship	\N	fe4baa66-ab88-4ec4-ac29-e249a88f96bd	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ndef451cd-dbd6-47aa-992b-e6b880b078a3|Term|CTT48: Complex Test Term 48|null\nfe4baa66-ab88-4ec4-ac29-e249a88f96bd|TermRelationship|is-a-part-of|null	f	is-a-part-of	10f0bfcb-db1b-47c3-b50a-ff0cd641a413
dbad9404-ee8b-49b7-a68c-ee3f0020fc90	2	Term	\N	e14c6acb-4224-41e7-b724-789b652ba6ca	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne14c6acb-4224-41e7-b724-789b652ba6ca|Term|CTT25: Complex Test Term 25|null	f	CTT25: Complex Test Term 25	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
e2ebc928-1d0b-4174-987b-14c60aab17fc	2	Term	\N	a846ac87-557f-45ea-822b-ca7f8bf754fc	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\na846ac87-557f-45ea-822b-ca7f8bf754fc|Term|CTT57: Complex Test Term 57|null	f	CTT57: Complex Test Term 57	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
e3df3923-b04a-467f-8235-0da10c914b91	2	Term	\N	33614052-00c8-4f9c-805f-32e7924c2e06	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n33614052-00c8-4f9c-805f-32e7924c2e06|Term|CTT44: Complex Test Term 44|null	f	CTT44: Complex Test Term 44	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
e42abde1-9972-4c9a-910d-93405ad41d5e	2	Term	\N	89e014cc-5d4a-4b33-990e-32bcda03f5f1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n89e014cc-5d4a-4b33-990e-32bcda03f5f1|Term|CTT2: Complex Test Term 2|null	f	CTT2: Complex Test Term 2	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
e55b64be-eec6-4aa1-92f3-7ac7a199c798	2	TermRelationship	\N	a54d164d-62de-4f41-a412-2185f82228c0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n9c8a3b27-8bec-4822-a63b-9d01656e2972|Term|CTT11: Complex Test Term 11|null\na54d164d-62de-4f41-a412-2185f82228c0|TermRelationship|broaderThan|null	f	broaderThan	6ba114c3-3255-47bd-9cf5-eb09469780bc
e699823c-f82d-44e9-a9bc-ab2573f05a95	2	Term	\N	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n0dd3df81-ec25-4db1-9aa5-0d1b2d899034|Term|CTT00: Complex Test Term 00|null	f	CTT00: Complex Test Term 00	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
e6f44a20-6f0a-4003-b7b9-f9ace6491cfb	2	Term	\N	16d658dc-9746-4b71-bdb0-b08b67e829d1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n16d658dc-9746-4b71-bdb0-b08b67e829d1|Term|CTT93: Complex Test Term 93|null	f	CTT93: Complex Test Term 93	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
e7a1ec3b-9fa9-41ea-be19-d7c2c43509d7	2	Term	\N	3036f548-7be0-4c54-a445-950a0b39c2b0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n3036f548-7be0-4c54-a445-950a0b39c2b0|Term|CTT99: Complex Test Term 99|null	f	CTT99: Complex Test Term 99	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
e7e69be2-68e6-4203-baee-d2032f2c3c98	2	TermRelationship	\N	51cbf3b1-a8c3-44d2-9ca6-4e5e8c671965	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n328e39c2-872e-4f16-a205-19b30ff7b2ef|Term|CTT75: Complex Test Term 75|null\n51cbf3b1-a8c3-44d2-9ca6-4e5e8c671965|TermRelationship|is-a-part-of|null	f	is-a-part-of	27449818-7d9b-4c0a-bd39-de66655ece6a
e7fcf247-ed7d-4fdf-96de-e5ca861b97d7	2	Term	\N	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n598c1ae8-07e0-4e97-a72b-eda076bf92f7|Term|CTT20: Complex Test Term 20|null	f	CTT20: Complex Test Term 20	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
e8351010-f9d6-4509-b44b-688fb810a28b	2	TermRelationship	\N	264e062d-6e10-4136-a4e6-57385e39736b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n734aa13a-a54e-4ea8-a363-5af80b09a31c|Term|CTT97: Complex Test Term 97|null\n264e062d-6e10-4136-a4e6-57385e39736b|TermRelationship|is-a-part-of|null	f	is-a-part-of	9f27aac1-f63b-403e-a005-c63837c1e75a
e8d3acf3-f58c-4353-8e11-1a7c26aa3731	2	Term	\N	07bcbcd1-e322-4173-af44-0f7dfaee4259	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n07bcbcd1-e322-4173-af44-0f7dfaee4259|Term|CTT46: Complex Test Term 46|null	f	CTT46: Complex Test Term 46	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
ea1e0ff9-b8c3-4e6c-a9bc-b8bccd990b39	2	Term	\N	85a0f6b0-c0da-48a6-af33-8772aa496981	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n85a0f6b0-c0da-48a6-af33-8772aa496981|Term|CTT81: Complex Test Term 81|null	f	CTT81: Complex Test Term 81	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
eb3ec6ce-3699-4156-a27b-f0f645095a65	2	Term	\N	71809374-0803-432c-b2cc-934904225ab7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n71809374-0803-432c-b2cc-934904225ab7|Term|CTT33: Complex Test Term 33|null	f	CTT33: Complex Test Term 33	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
eb83ad43-9242-4d3c-9d49-bd74db71551d	2	Term	\N	c19c2d04-6b30-4215-bde1-8263f569297e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc19c2d04-6b30-4215-bde1-8263f569297e|Term|CTT65: Complex Test Term 65|null	f	CTT65: Complex Test Term 65	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
ec323690-9d99-4422-b2dd-303d55fd0c68	2	TermRelationship	\N	a06eef77-48b4-4dd5-ae06-1599fa1feeff	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc19c2d04-6b30-4215-bde1-8263f569297e|Term|CTT65: Complex Test Term 65|null\na06eef77-48b4-4dd5-ae06-1599fa1feeff|TermRelationship|is-a-part-of|null	f	is-a-part-of	eb83ad43-9242-4d3c-9d49-bd74db71551d
ed0c204c-8382-44f3-81f3-25245a7e4ba2	2	TermRelationship	\N	34a46dff-d01c-487f-93a5-a53080816cf7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n07f6a86f-f82e-49e1-838b-104d251e9b3b|Term|CTT42: Complex Test Term 42|null\n34a46dff-d01c-487f-93a5-a53080816cf7|TermRelationship|is-a-part-of|null	f	is-a-part-of	f5df67e7-6fb1-4ec2-8c26-e21b8b34e257
eeff48ea-d27b-4a0c-bf6c-da2694f181ec	2	TermRelationship	\N	2cf67028-d2c8-44eb-b5f5-60022f5f6553	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4dc5e72d-8d4b-4a5c-8664-ba759fc2007a|Term|CTT41: Complex Test Term 41|null\n2cf67028-d2c8-44eb-b5f5-60022f5f6553|TermRelationship|is-a-part-of|null	f	is-a-part-of	0a140c33-b602-4d37-996a-0ef0a7dd99eb
f05d06ad-eb62-49a1-8469-e928f34e9ce3	2	TermRelationship	\N	691cc1da-1392-4ae1-850e-5277139acb9b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e|Term|CTT8: Complex Test Term 8|null\n691cc1da-1392-4ae1-850e-5277139acb9b|TermRelationship|is-a-part-of|null	f	is-a-part-of	2ea0f7f0-89ee-4a30-bb0e-b697097f4a81
f185d251-eaa8-4dcf-b953-8254dc136b2a	2	TermRelationship	\N	82ff5a5e-f956-47b3-9c66-913fc55d2cf7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nb52bc4e7-ce89-47d6-917c-8d5e37ec0234|Term|CTT15: Complex Test Term 15|null\n82ff5a5e-f956-47b3-9c66-913fc55d2cf7|TermRelationship|is-a-part-of|null	f	is-a-part-of	5e7a841b-ff54-4ed2-a82d-7b0e9d95e217
f4272f7a-7ac6-49a0-9564-a9bd4f3c5f69	2	TermRelationship	\N	c330efa0-cdbd-4d53-827a-061956aa5f64	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nd1a19f41-8726-4215-8a4e-774d448ab564|Term|CTT61: Complex Test Term 61|null\nc330efa0-cdbd-4d53-827a-061956aa5f64|TermRelationship|is-a-part-of|null	f	is-a-part-of	bf1e3c0d-6166-4b49-ad0d-dead5a3595c7
f47f1730-a68b-4a8a-97ab-bbbfc2be757d	2	TermRelationship	\N	1fd307bc-8e5c-42b0-9570-4ab6e1a9b0aa	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf0df73e8-7599-4ca1-98b5-22ffc14e4195|Term|CTT34: Complex Test Term 34|null\n1fd307bc-8e5c-42b0-9570-4ab6e1a9b0aa|TermRelationship|is-a-part-of|null	f	is-a-part-of	46141187-3649-41c7-83a1-fb9de002895b
f5df67e7-6fb1-4ec2-8c26-e21b8b34e257	2	Term	\N	07f6a86f-f82e-49e1-838b-104d251e9b3b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n07f6a86f-f82e-49e1-838b-104d251e9b3b|Term|CTT42: Complex Test Term 42|null	f	CTT42: Complex Test Term 42	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
f6d383e7-7acd-454b-8461-4460a7c3bd9e	2	TermRelationship	\N	3ee32a6c-c3c4-45ac-90c5-60c1c5a0c927	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nb87d803e-a6ad-4017-8239-10c622d4572e|Term|CTT29: Complex Test Term 29|null\n3ee32a6c-c3c4-45ac-90c5-60c1c5a0c927|TermRelationship|is-a-part-of|null	f	is-a-part-of	3cf9c49a-fe5c-4886-89d6-1d95e5496494
f8a858e3-0853-4c09-a8f6-69530f13fe14	2	Term	\N	8df18676-2728-4cc3-8395-f231efaecd1d	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8df18676-2728-4cc3-8395-f231efaecd1d|Term|CTT69: Complex Test Term 69|null	f	CTT69: Complex Test Term 69	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
f97973db-01e8-430a-9acb-8b665307f523	2	TermRelationship	\N	daefe11c-c5f4-498b-bcf1-ee46a6a17bda	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nb52bc4e7-ce89-47d6-917c-8d5e37ec0234|Term|CTT15: Complex Test Term 15|null\ndaefe11c-c5f4-498b-bcf1-ee46a6a17bda|TermRelationship|broaderThan|null	f	broaderThan	5e7a841b-ff54-4ed2-a82d-7b0e9d95e217
fa9d729d-9ce0-4983-af22-5fa8e3dd69ab	2	TermRelationship	\N	7548a28f-e60f-4531-b8ec-2c70fe4722dd	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne5a57d8f-d9a1-45d9-8145-5bcfda4db009|Term|CTT31: Complex Test Term 31|null\n7548a28f-e60f-4531-b8ec-2c70fe4722dd|TermRelationship|is-a-part-of|null	f	is-a-part-of	c0249fc0-f5a4-4633-afd1-39501b47a85f
fa9f3445-13cf-48d5-81d7-297009b92e66	2	TermRelationship	\N	d43195e3-ce42-49f8-80cb-8fa10bb75041	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n0ae53ea0-d964-4218-a5de-9826a41cac35|Term|CTT35: Complex Test Term 35|null\nd43195e3-ce42-49f8-80cb-8fa10bb75041|TermRelationship|is-a-part-of|null	f	is-a-part-of	a7472704-2123-4b5a-a097-7b3f6fe6fa18
fdb8df61-3ade-4202-bc6f-31ec8de15d44	2	TermRelationship	\N	f94d7258-9a3f-4298-badf-dab295f5531d	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nab531b62-af47-4e11-ae67-ee7b18b8bf9a|Term|CTT23: Complex Test Term 23|null\nf94d7258-9a3f-4298-badf-dab295f5531d|TermRelationship|is-a-part-of|null	f	is-a-part-of	71363338-3273-4e8d-99d4-10570c3f1443
fdd81b9e-c89c-494a-81e0-f050e4dd58e0	2	Term	\N	ea8d3d31-39bc-4194-b0bc-fa0e23fc1771	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nea8d3d31-39bc-4194-b0bc-fa0e23fc1771|Term|CTT5: Complex Test Term 5|null	f	CTT5: Complex Test Term 5	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
fe94ba42-7eaa-4d10-94ec-4228c7187cd3	2	TermRelationship	\N	29de9216-8abd-4170-aff8-5cebd5a554d7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8df18676-2728-4cc3-8395-f231efaecd1d|Term|CTT69: Complex Test Term 69|null\n29de9216-8abd-4170-aff8-5cebd5a554d7|TermRelationship|is-a-part-of|null	f	is-a-part-of	f8a858e3-0853-4c09-a8f6-69530f13fe14
ff771d54-461c-4fdf-b0e6-2d39b9fd5788	2	TermRelationship	\N	90e815ae-e0bc-49f3-ad97-69275f55ef19	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8c232f5e-7ea6-445a-911f-4ce266f1b1dc|Term|CTT17: Complex Test Term 17|null\n90e815ae-e0bc-49f3-ad97-69275f55ef19|TermRelationship|broaderThan|null	f	broaderThan	93bcb6e1-8494-404f-8588-c314fe9f2255
004f44e9-a7dd-4639-b1f1-292c8885cfa6	2	Term	\N	0a7f5772-b95d-4db5-89da-d05458604648	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n0a7f5772-b95d-4db5-89da-d05458604648|Term|CTT64: Complex Test Term 64|null	f	CTT64: Complex Test Term 64	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
0260d37b-ed28-48d8-a6ab-f61a702b1a91	2	Term	\N	1656d691-efa8-4975-b146-dee29de15b13	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n1656d691-efa8-4975-b146-dee29de15b13|Term|CTT32: Complex Test Term 32|null	f	CTT32: Complex Test Term 32	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
03791513-aadf-42e4-9926-bbad795fce56	2	TermRelationship	\N	de2de447-d71c-4d20-94ae-9d9f17ebe2ba	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n3a34acb0-0717-4e5a-976f-eb5b1f3ed124|Term|CTT4: Complex Test Term 4|null\nde2de447-d71c-4d20-94ae-9d9f17ebe2ba|TermRelationship|narrowerThan|null	f	narrowerThan	7cddeb12-0623-49d4-885e-f4a7c6c8aa21
0566c55e-1db3-4668-a779-415d6d384ed9	2	Term	\N	b1b1c31c-8c1f-46fe-8a7b-3f82433af150	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nb1b1c31c-8c1f-46fe-8a7b-3f82433af150|Term|CTT27: Complex Test Term 27|null	f	CTT27: Complex Test Term 27	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
065a0958-d4f4-4ae2-89c5-b1553d39cd8a	2	TermRelationship	\N	39528559-8570-4459-9b92-1d34c2b256a8	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nec45ea78-b949-4e33-b51b-9d021cf2e7e7|Term|CTT55: Complex Test Term 55|null\n39528559-8570-4459-9b92-1d34c2b256a8|TermRelationship|is-a-part-of|null	f	is-a-part-of	25c2458d-c2e5-4416-9ae1-e1f60f6f5d27
06613eaa-619b-49ae-a8e4-a8993a5e0041	2	Term	\N	118ae67a-dfc0-4a90-8e4d-7e458ffa8cce	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n118ae67a-dfc0-4a90-8e4d-7e458ffa8cce|Term|CTT6: Complex Test Term 6|null	f	CTT6: Complex Test Term 6	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
07f85470-2322-431b-820c-b1db3c1c4e05	2	TermRelationship	\N	44f3a48f-1a2e-4d66-85d4-729db7dbacc2	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n118ae67a-dfc0-4a90-8e4d-7e458ffa8cce|Term|CTT6: Complex Test Term 6|null\n44f3a48f-1a2e-4d66-85d4-729db7dbacc2|TermRelationship|narrowerThan|null	f	narrowerThan	06613eaa-619b-49ae-a8e4-a8993a5e0041
0a140c33-b602-4d37-996a-0ef0a7dd99eb	2	Term	\N	4dc5e72d-8d4b-4a5c-8664-ba759fc2007a	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4dc5e72d-8d4b-4a5c-8664-ba759fc2007a|Term|CTT41: Complex Test Term 41|null	f	CTT41: Complex Test Term 41	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
0a753c0b-375d-4491-a1ed-8de3bf113c8c	2	TermRelationship	\N	a6c20a13-f47e-4e55-85d3-4209ff4a52de	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf95c6c1e-48f4-4470-8c03-2c96798c51ae|Term|CTT9: Complex Test Term 9|null\na6c20a13-f47e-4e55-85d3-4209ff4a52de|TermRelationship|is-a-part-of|null	f	is-a-part-of	4681a151-0623-4ac9-96ed-0a9e4fe5fb4c
0cb21e94-22b5-4b05-b38f-07f64043c67a	2	TermRelationship	\N	ee54677b-ce8b-4e4b-b9a0-bf6f6f95768d	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc9f71177-d940-44e2-9807-be88b8b7bc32|Term|CTT63: Complex Test Term 63|null\nee54677b-ce8b-4e4b-b9a0-bf6f6f95768d|TermRelationship|is-a-part-of|null	f	is-a-part-of	c1780253-a811-41fe-858f-b3e0cf258d7f
10f0bfcb-db1b-47c3-b50a-ff0cd641a413	2	Term	\N	def451cd-dbd6-47aa-992b-e6b880b078a3	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ndef451cd-dbd6-47aa-992b-e6b880b078a3|Term|CTT48: Complex Test Term 48|null	f	CTT48: Complex Test Term 48	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
110adc99-5b16-4a28-a78b-7b6e115b7993	2	TermRelationship	\N	0307c397-080f-41b8-8db9-ed0b54ea1b13	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4157c9f7-b977-40f9-a0db-bd964aef5494|Term|CTT82: Complex Test Term 82|null\n0307c397-080f-41b8-8db9-ed0b54ea1b13|TermRelationship|is-a-part-of|null	f	is-a-part-of	2a6acf60-c726-493e-9d0a-704695bc24da
129811b4-1e77-4f99-ab41-b2b1b141a2b8	2	Term	\N	da0f3dd2-4a9e-4bb0-a850-e235a6169571	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nda0f3dd2-4a9e-4bb0-a850-e235a6169571|Term|CTT22: Complex Test Term 22|null	f	CTT22: Complex Test Term 22	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
13f344d3-7805-47d7-b72b-4dc75f309a63	2	Term	\N	ed487d06-4c11-473e-bc22-5ac46e223028	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ned487d06-4c11-473e-bc22-5ac46e223028|Term|CTT67: Complex Test Term 67|null	f	CTT67: Complex Test Term 67	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
15ec6173-6b6c-4e5c-b49b-cc8cadb3722e	2	TermRelationship	\N	299ed7b3-f0a1-4070-ae39-80d4349e4468	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n2fbf3f4d-e2df-4b8e-bc83-669eaa6884f5|Term|CTT56: Complex Test Term 56|null\n299ed7b3-f0a1-4070-ae39-80d4349e4468|TermRelationship|is-a-part-of|null	f	is-a-part-of	54caa65b-9e23-404c-bd93-bdf2f63d6888
1731f45c-117b-4764-8ba7-9c672f7f1daa	2	TermRelationship	\N	e97553e9-dadd-478f-a05b-e0be835fdaf4	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8c9dffc0-acdb-416c-acec-4b950e0d1cb7|Term|CTT43: Complex Test Term 43|null\ne97553e9-dadd-478f-a05b-e0be835fdaf4|TermRelationship|is-a-part-of|null	f	is-a-part-of	a887ca80-5b2d-4e22-9f8c-d95f21eb6bca
17392641-ebba-42b4-84cf-f6293d331557	2	TermRelationship	\N	985bfc64-2503-4e1d-840b-796f404f5334	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf783da6c-26dc-4403-b3d0-cf4a2a7581d8|Term|CTT52: Complex Test Term 52|null\n985bfc64-2503-4e1d-840b-796f404f5334|TermRelationship|is-a-part-of|null	f	is-a-part-of	6c9707bd-bee6-43b0-a7b1-22317df9b087
1838e389-ee88-4e13-96ec-bfdc752eb587	2	Term	\N	553439f8-e19e-40a5-a253-48bb36e00199	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n553439f8-e19e-40a5-a253-48bb36e00199|Term|CTT50: Complex Test Term 50|null	f	CTT50: Complex Test Term 50	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
1978606f-2df6-4cb6-8b5a-d9b16ed0084a	2	TermRelationship	\N	0d44c455-647e-4f77-8767-9d2a355ecdcb	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n89e014cc-5d4a-4b33-990e-32bcda03f5f1|Term|CTT2: Complex Test Term 2|null\n0d44c455-647e-4f77-8767-9d2a355ecdcb|TermRelationship|is-a-part-of|null	f	is-a-part-of	e42abde1-9972-4c9a-910d-93405ad41d5e
19ba9219-08af-4d16-af5e-dce3aee2bf17	2	Term	\N	6f80cd8a-edc2-4398-a38e-e26ed6e2f467	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n6f80cd8a-edc2-4398-a38e-e26ed6e2f467|Term|CTT24: Complex Test Term 24|null	f	CTT24: Complex Test Term 24	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
19bb0bb3-5289-4cb3-99b7-12cbfadf1389	2	TermRelationship	\N	d0ce297a-c2ec-415c-8752-73fe13059f41	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n1b25e277-4ca6-4645-9eb6-7d403cb404dd|Term|CTT38: Complex Test Term 38|null\nd0ce297a-c2ec-415c-8752-73fe13059f41|TermRelationship|is-a-part-of|null	f	is-a-part-of	1fc949ad-1ba2-4a92-bd1e-b9678490d42d
1a827654-1393-444e-9983-904fdf62a67d	2	TermRelationship	\N	68e2e068-47db-46bb-ba4c-03b14ae7c2af	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n95081140-122d-4db5-95bd-d0845c8751e6|Term|CTT88: Complex Test Term 88|null\n68e2e068-47db-46bb-ba4c-03b14ae7c2af|TermRelationship|is-a-part-of|null	f	is-a-part-of	858b5711-1979-477b-8b3a-a812e9f4064d
1aa1347f-4629-4b2e-8421-cbe3b08acf3b	2	TermRelationship	\N	045bd408-5df4-4c03-89c9-8a2a20c57edd	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf95c6c1e-48f4-4470-8c03-2c96798c51ae|Term|CTT9: Complex Test Term 9|null\n045bd408-5df4-4c03-89c9-8a2a20c57edd|TermRelationship|narrowerThan|null	f	narrowerThan	4681a151-0623-4ac9-96ed-0a9e4fe5fb4c
1ea01b36-2f79-4b56-96d7-9c260d24fc5a	2	Term	\N	4872b09e-94f2-4b75-a516-66b1a8636670	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4872b09e-94f2-4b75-a516-66b1a8636670|Term|CTT96: Complex Test Term 96|null	f	CTT96: Complex Test Term 96	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
1f182a7b-ab12-42ee-bb4b-0c38451c0825	2	TermRelationship	\N	f5a0c158-e97f-4c0a-81ea-09ad32638fa1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne901be9b-113a-4ff1-b835-9fd1e509f3e1|Term|CTT53: Complex Test Term 53|null\nf5a0c158-e97f-4c0a-81ea-09ad32638fa1|TermRelationship|is-a-part-of|null	f	is-a-part-of	76af915f-f19f-4d36-895d-2dcdbefff1ef
1f32f303-4678-4655-857c-9a32e4201075	2	TermRelationship	\N	0dc55880-4ae4-4c44-9053-352050c342fb	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n553b84d1-3cfb-40fe-ad09-74468c158f7c|Term|CTT79: Complex Test Term 79|null\n0dc55880-4ae4-4c44-9053-352050c342fb|TermRelationship|is-a-part-of|null	f	is-a-part-of	cf46a9cb-84e9-4ce3-b1b9-a598ac339882
1f748c85-9931-4869-b8eb-5e31a17d837b	2	TermRelationship	\N	60571d81-96ac-42df-ad79-c33ea89a9307	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n864376cf-3691-48b4-b218-9547717a16e4|Term|CTT39: Complex Test Term 39|null\n60571d81-96ac-42df-ad79-c33ea89a9307|TermRelationship|is-a-part-of|null	f	is-a-part-of	502ffb0f-5239-40d4-9701-32a7e0428b87
1fc949ad-1ba2-4a92-bd1e-b9678490d42d	2	Term	\N	1b25e277-4ca6-4645-9eb6-7d403cb404dd	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n1b25e277-4ca6-4645-9eb6-7d403cb404dd|Term|CTT38: Complex Test Term 38|null	f	CTT38: Complex Test Term 38	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
20a6d37a-3cf3-4563-9d79-856fcccf4199	2	TermRelationship	\N	aadfede8-3018-4a64-956b-5df72a06c6d3	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n47f19eca-d2dc-490a-9435-d824d8400ba0|Term|CTT91: Complex Test Term 91|null\naadfede8-3018-4a64-956b-5df72a06c6d3|TermRelationship|is-a-part-of|null	f	is-a-part-of	840f46ba-863f-4ee3-8841-efc430abef3f
22e6f504-2138-41a0-bb3b-d4d73747b33c	2	Term	\N	980b9a60-4fc9-4734-bc21-656ec7073188	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n980b9a60-4fc9-4734-bc21-656ec7073188|Term|CTT26: Complex Test Term 26|null	f	CTT26: Complex Test Term 26	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
23104e5c-7c22-4f5f-97cd-d21da5c95e00	2	TermRelationship	\N	737276a8-f3ed-4640-bd42-8ad7720849cc	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n8cd60786-686b-47fb-901d-0410d2cbf21b|Term|CTT19: Complex Test Term 19|null\n737276a8-f3ed-4640-bd42-8ad7720849cc|TermRelationship|is-a-part-of|null	f	is-a-part-of	d9c85ec5-f8ea-4f09-957c-dc1e71566be8
2388760b-76c3-4e31-bb31-1ae985ff677e	2	TermRelationship	\N	c3fb4a0d-d074-45af-adae-fd96d7bc99c0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf4227289-7fd1-4daf-8499-ed60f81de735|Term|CTT87: Complex Test Term 87|null\nc3fb4a0d-d074-45af-adae-fd96d7bc99c0|TermRelationship|is-a-part-of|null	f	is-a-part-of	55ada9eb-0b74-40ff-9fea-8d32038408e6
2591b722-682a-40be-96dc-af28fed7ffaf	2	Term	\N	47c68fb7-0bfc-41d1-bb9d-3c484715ad22	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n47c68fb7-0bfc-41d1-bb9d-3c484715ad22|Term|CTT3: Complex Test Term 3|null	f	CTT3: Complex Test Term 3	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
25c2458d-c2e5-4416-9ae1-e1f60f6f5d27	2	Term	\N	ec45ea78-b949-4e33-b51b-9d021cf2e7e7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nec45ea78-b949-4e33-b51b-9d021cf2e7e7|Term|CTT55: Complex Test Term 55|null	f	CTT55: Complex Test Term 55	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
25f129e0-076c-4747-81bf-7babb66b5e5e	2	TermRelationship	\N	e392c8df-fca8-488f-8e18-f41f8f0af4f3	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n878bcde8-e98b-451b-8a77-616c5a057509|Term|CTT83: Complex Test Term 83|null\ne392c8df-fca8-488f-8e18-f41f8f0af4f3|TermRelationship|is-a-part-of|null	f	is-a-part-of	2e4b7e3a-c94f-4ed8-b02b-e28b357c4469
27449818-7d9b-4c0a-bd39-de66655ece6a	2	Term	\N	328e39c2-872e-4f16-a205-19b30ff7b2ef	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n328e39c2-872e-4f16-a205-19b30ff7b2ef|Term|CTT75: Complex Test Term 75|null	f	CTT75: Complex Test Term 75	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
28d6a82d-1acb-4822-ac42-2a84105b0094	2	Term	\N	12b9ade2-9bb9-4156-862c-4c16e4ff3b25	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n12b9ade2-9bb9-4156-862c-4c16e4ff3b25|Term|CTT62: Complex Test Term 62|null	f	CTT62: Complex Test Term 62	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
292db074-9ada-4e1d-b30e-087a42495531	2	Term	\N	6ecaf047-9c75-426c-9041-bc1ec33d6a68	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n6ecaf047-9c75-426c-9041-bc1ec33d6a68|Term|CTT45: Complex Test Term 45|null	f	CTT45: Complex Test Term 45	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
2982332d-8378-4bc6-b6c2-af346c8ef7d9	2	TermRelationship	\N	7a61290a-24e7-47b9-8353-912d5d07eafc	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n0d938873-4766-4dac-930f-ddc43cad2c39|Term|CTT51: Complex Test Term 51|null\n7a61290a-24e7-47b9-8353-912d5d07eafc|TermRelationship|is-a-part-of|null	f	is-a-part-of	b29f081f-528a-41da-9dc6-30d1cd07b684
2a6acf60-c726-493e-9d0a-704695bc24da	2	Term	\N	4157c9f7-b977-40f9-a0db-bd964aef5494	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4157c9f7-b977-40f9-a0db-bd964aef5494|Term|CTT82: Complex Test Term 82|null	f	CTT82: Complex Test Term 82	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
2b0648b7-3b3d-4f52-af9d-ce7dd8ce94cd	2	Term	\N	c62afddf-d800-4997-958d-e21af5b67e00	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc62afddf-d800-4997-958d-e21af5b67e00|Term|CTT78: Complex Test Term 78|null	f	CTT78: Complex Test Term 78	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
2e4b7e3a-c94f-4ed8-b02b-e28b357c4469	2	Term	\N	878bcde8-e98b-451b-8a77-616c5a057509	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n878bcde8-e98b-451b-8a77-616c5a057509|Term|CTT83: Complex Test Term 83|null	f	CTT83: Complex Test Term 83	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
2ea0f7f0-89ee-4a30-bb0e-b697097f4a81	2	Term	\N	05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e|Term|CTT8: Complex Test Term 8|null	f	CTT8: Complex Test Term 8	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
2f7dcf27-c2a8-4bfb-8012-2ae294fb5cab	2	TermRelationship	\N	8abb670d-5a19-49ed-916b-eebd7b495a26	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n443a219c-96ef-4afc-b9fe-a9968c96f1b1|Term|CTT14: Complex Test Term 14|null\n8abb670d-5a19-49ed-916b-eebd7b495a26|TermRelationship|broaderThan|null	f	broaderThan	a1b2cb04-400d-4ce0-a8b5-2edd5d0d8b80
2fc1f71f-b540-4427-ae22-3add21336146	2	TermRelationship	\N	e7c7b7f9-f691-4025-9b94-a89c865b5d8c	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n16d658dc-9746-4b71-bdb0-b08b67e829d1|Term|CTT93: Complex Test Term 93|null\ne7c7b7f9-f691-4025-9b94-a89c865b5d8c|TermRelationship|is-a-part-of|null	f	is-a-part-of	e6f44a20-6f0a-4003-b7b9-f9ace6491cfb
324e88c3-7ed6-4fa3-8e78-5eabed11a52d	2	TermRelationship	\N	4aa8dacb-a764-472e-bcdf-85cd6ad134e3	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n9c8a3b27-8bec-4822-a63b-9d01656e2972|Term|CTT11: Complex Test Term 11|null\n4aa8dacb-a764-472e-bcdf-85cd6ad134e3|TermRelationship|is-a-part-of|null	f	is-a-part-of	6ba114c3-3255-47bd-9cf5-eb09469780bc
32f83064-09ee-4533-b4c9-b27cd72cb121	2	Term	\N	4a25866e-fbaa-4838-a2f6-6337ac5c6d2b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4a25866e-fbaa-4838-a2f6-6337ac5c6d2b|Term|CTT18: Complex Test Term 18|null	f	CTT18: Complex Test Term 18	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
33b9e43c-63f8-4921-8e19-8eb3d10c9e76	2	TermRelationship	\N	4d761652-1b02-47aa-a041-e0ea252b4be6	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n3036f548-7be0-4c54-a445-950a0b39c2b0|Term|CTT99: Complex Test Term 99|null\n4d761652-1b02-47aa-a041-e0ea252b4be6|TermRelationship|is-a-part-of|null	f	is-a-part-of	e7a1ec3b-9fa9-41ea-be19-d7c2c43509d7
34751c14-8b4a-4d5f-8063-1fe64d8af7c8	2	TermRelationship	\N	be2ce520-47f9-447a-8002-4f3dbb29ecd1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\na934a9f1-5b47-4995-b087-f1d54433aa1e|Term|CTT10: Complex Test Term 10|null\nbe2ce520-47f9-447a-8002-4f3dbb29ecd1|TermRelationship|is-a-part-of|null	f	is-a-part-of	bbc41ec2-a01f-4e03-983f-1dbc6e3779eb
37d24bde-1c7d-4cc7-be7e-c0dba3b6933c	2	TermRelationship	\N	3df3cc36-ae3f-43af-9054-a2af32690e9f	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nbe81e94c-1d7f-4c63-b0fc-f4eecef29983|Term|CTT98: Complex Test Term 98|null\n3df3cc36-ae3f-43af-9054-a2af32690e9f|TermRelationship|is-a-part-of|null	f	is-a-part-of	a5c05cd7-d036-47ec-96e8-ffcb950f8b01
381bbd43-da1f-4f96-872e-4772ba2e978c	2	TermRelationship	\N	72e80b2d-5994-4197-be5c-15bb28943dbe	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne507201e-f57f-4e90-b6c1-b8a83c51c702|Term|CTT36: Complex Test Term 36|null\n72e80b2d-5994-4197-be5c-15bb28943dbe|TermRelationship|is-a-part-of|null	f	is-a-part-of	aaa79497-8338-4803-9b18-cd4414f9ece5
39b5bcd9-7cf1-4825-b84d-724daedc8e47	2	TermRelationship	\N	f0efe38f-cb47-4123-99b6-620bf0769721	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\naf8368b3-b782-4c27-b593-7e8ac1ccae81|Term|CTT60: Complex Test Term 60|null\nf0efe38f-cb47-4123-99b6-620bf0769721|TermRelationship|is-a-part-of|null	f	is-a-part-of	8152e6c2-6607-478b-9e52-934f86361e1b
3a61bf1d-55e8-4ac1-9271-63aedde1884f	2	TermRelationship	\N	aa2dfef3-6957-46ba-bf0c-ad805090837c	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n1718e492-1838-4e25-8ed9-d340995e3f97|Term|CTT95: Complex Test Term 95|null\naa2dfef3-6957-46ba-bf0c-ad805090837c|TermRelationship|is-a-part-of|null	f	is-a-part-of	48b3b248-a2af-4714-a2b9-bbb52cb5e000
3aab644d-23de-4c99-8a31-340648165de6	2	Term	\N	a3039085-c3c3-41d7-b396-16e83ac79aad	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\na3039085-c3c3-41d7-b396-16e83ac79aad|Term|CTT80: Complex Test Term 80|null	f	CTT80: Complex Test Term 80	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
3bc08f5a-3fb6-4850-8b17-aaea798e3c1f	2	TermRelationship	\N	4052530c-d312-489c-bf3a-38cfcab720f0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n980b9a60-4fc9-4734-bc21-656ec7073188|Term|CTT26: Complex Test Term 26|null\n4052530c-d312-489c-bf3a-38cfcab720f0|TermRelationship|is-a-part-of|null	f	is-a-part-of	22e6f504-2138-41a0-bb3b-d4d73747b33c
3c8acaa5-93cc-47bd-bb1a-f035126263f4	2	Term	\N	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf795e73f-8ec5-4d3c-b74c-3829f2aefd28|Term|CTT40: Complex Test Term 40|null	f	CTT40: Complex Test Term 40	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
3cd6565b-11ad-4170-a98d-8444f05f9bf3	2	TermRelationship	\N	5225a22d-baa2-410d-9551-c49aa8c0acd5	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n47c68fb7-0bfc-41d1-bb9d-3c484715ad22|Term|CTT3: Complex Test Term 3|null\n5225a22d-baa2-410d-9551-c49aa8c0acd5|TermRelationship|narrowerThan|null	f	narrowerThan	2591b722-682a-40be-96dc-af28fed7ffaf
3cf9c49a-fe5c-4886-89d6-1d95e5496494	2	Term	\N	b87d803e-a6ad-4017-8239-10c622d4572e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nb87d803e-a6ad-4017-8239-10c622d4572e|Term|CTT29: Complex Test Term 29|null	f	CTT29: Complex Test Term 29	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
3dc80100-a96e-435b-b498-a81ba193af50	2	TermRelationship	\N	0dab8c00-c9d1-4aa4-a256-d420317835a7	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n55f22fde-097a-41a8-8e87-180e30b8e117|Term|CTT54: Complex Test Term 54|null\n0dab8c00-c9d1-4aa4-a256-d420317835a7|TermRelationship|is-a-part-of|null	f	is-a-part-of	d155d5be-2574-407b-8f3c-0ea049669883
3f1531e7-b633-4210-a59b-085eb11b96f1	2	TermRelationship	\N	21df5cb6-e800-4324-bbf0-8573800165b1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\na45642b2-e367-4dd3-9e65-e0abe67d1969|Term|CTT68: Complex Test Term 68|null\n21df5cb6-e800-4324-bbf0-8573800165b1|TermRelationship|is-a-part-of|null	f	is-a-part-of	bd539756-ebb4-4e10-8f1e-a2ed9f81c933
40d07642-393f-4b0b-a36b-bdd2354ecf39	2	Term	\N	780dafdb-7115-4d89-8466-124f3c984c76	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n780dafdb-7115-4d89-8466-124f3c984c76|Term|CTT72: Complex Test Term 72|null	f	CTT72: Complex Test Term 72	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
40e8b246-73f6-4e92-9aea-945e9598dcbc	2	TermRelationship	\N	c82f47fe-4ed2-4e7c-80fc-dcb39f15824a	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n1656d691-efa8-4975-b146-dee29de15b13|Term|CTT32: Complex Test Term 32|null\nc82f47fe-4ed2-4e7c-80fc-dcb39f15824a|TermRelationship|is-a-part-of|null	f	is-a-part-of	0260d37b-ed28-48d8-a6ab-f61a702b1a91
41567699-e378-4990-a0ac-a6c8c5de55d6	2	TermRelationship	\N	8a01a171-a5b8-498f-a570-e2b7d0c9acb1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nda0f3dd2-4a9e-4bb0-a850-e235a6169571|Term|CTT22: Complex Test Term 22|null\n8a01a171-a5b8-498f-a570-e2b7d0c9acb1|TermRelationship|is-a-part-of|null	f	is-a-part-of	129811b4-1e77-4f99-ab41-b2b1b141a2b8
41c5f9fe-09c1-4f65-a2d7-82624653c947	2	TermRelationshipType	\N	86c63a69-3f33-401f-afe8-32dab264d1fb	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n86c63a69-3f33-401f-afe8-32dab264d1fb|TermRelationshipType|narrowerThan|null	f	narrowerThan	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
43c242a3-06ad-4cad-b453-eb8759e6df3b	2	TermRelationship	\N	eed7fd55-fb6c-48b5-a702-e9242818c2b2	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\na3039085-c3c3-41d7-b396-16e83ac79aad|Term|CTT80: Complex Test Term 80|null\need7fd55-fb6c-48b5-a702-e9242818c2b2|TermRelationship|is-a-part-of|null	f	is-a-part-of	3aab644d-23de-4c99-8a31-340648165de6
45e62b73-96da-4d29-9a1a-a8804b4f6c84	2	TermRelationship	\N	f634e78e-5857-4a11-972a-d907164906f0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n03314e3d-1598-4cdf-ac2b-15a5777f38c0|Term|CTT7: Complex Test Term 7|null\nf634e78e-5857-4a11-972a-d907164906f0|TermRelationship|narrowerThan|null	f	narrowerThan	62447a0c-d874-4540-8c4f-baec0d4950a8
46141187-3649-41c7-83a1-fb9de002895b	2	Term	\N	f0df73e8-7599-4ca1-98b5-22ffc14e4195	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf0df73e8-7599-4ca1-98b5-22ffc14e4195|Term|CTT34: Complex Test Term 34|null	f	CTT34: Complex Test Term 34	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
464f3d7b-b35c-4957-b6ae-4267311eaf6c	2	Term	\N	c605c709-2b2c-44c5-b174-e865d3724b52	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc605c709-2b2c-44c5-b174-e865d3724b52|Term|CTT71: Complex Test Term 71|null	f	CTT71: Complex Test Term 71	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
4681a151-0623-4ac9-96ed-0a9e4fe5fb4c	2	Term	\N	f95c6c1e-48f4-4470-8c03-2c96798c51ae	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf95c6c1e-48f4-4470-8c03-2c96798c51ae|Term|CTT9: Complex Test Term 9|null	f	CTT9: Complex Test Term 9	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
48b3b248-a2af-4714-a2b9-bbb52cb5e000	2	Term	\N	1718e492-1838-4e25-8ed9-d340995e3f97	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n1718e492-1838-4e25-8ed9-d340995e3f97|Term|CTT95: Complex Test Term 95|null	f	CTT95: Complex Test Term 95	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
49ab3999-ac1e-4bd8-a9e2-84dd5e374911	2	TermRelationship	\N	082d0c31-e894-4221-b7da-9a58465d668f	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n88393671-e333-4dfd-9bb9-73776b8bf5c8|Term|CTT12: Complex Test Term 12|null\n082d0c31-e894-4221-b7da-9a58465d668f|TermRelationship|is-a-part-of|null	f	is-a-part-of	bd1c29fa-77fa-438b-b271-0ea8e755edb3
4c5a82bd-c220-478c-8532-4730e0b313bd	2	TermRelationship	\N	d73b390b-b7b9-41cc-bf62-a4a8babe11fa	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n436ab4fe-f546-4982-9997-c002c2d46d65|Term|CTT92: Complex Test Term 92|null\nd73b390b-b7b9-41cc-bf62-a4a8babe11fa|TermRelationship|is-a-part-of|null	f	is-a-part-of	a0c56558-bf48-4700-97bf-f2be250ef7f4
4d9bfc45-8688-4b94-87bc-c2061f9eb637	2	Term	\N	5b33d920-735d-4548-b152-c42d65a89485	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n5b33d920-735d-4548-b152-c42d65a89485|Term|CTT58: Complex Test Term 58|null	f	CTT58: Complex Test Term 58	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
502ffb0f-5239-40d4-9701-32a7e0428b87	2	Term	\N	864376cf-3691-48b4-b218-9547717a16e4	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n864376cf-3691-48b4-b218-9547717a16e4|Term|CTT39: Complex Test Term 39|null	f	CTT39: Complex Test Term 39	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
520f0b88-bec3-4e4e-a630-6a32faa3f21d	2	Term	\N	ae981c04-92cc-4ee6-b38e-9561a386703e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nae981c04-92cc-4ee6-b38e-9561a386703e|Term|CTT101|null	f	CTT101	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
5317c9ac-2309-4550-8ba1-a749d57ad801	2	TermRelationship	\N	ad8b2dbb-30b4-445d-a84b-cf342dabb357	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n598c1ae8-07e0-4e97-a72b-eda076bf92f7|Term|CTT20: Complex Test Term 20|null\nad8b2dbb-30b4-445d-a84b-cf342dabb357|TermRelationship|is-a-part-of|null	f	is-a-part-of	e7fcf247-ed7d-4fdf-96de-e5ca861b97d7
536fa637-d1b4-4ae6-9cc1-3eefd3690c09	2	TermRelationship	\N	947b06d9-8819-4888-ab25-f9c1024a10c6	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e|Term|CTT8: Complex Test Term 8|null\n947b06d9-8819-4888-ab25-f9c1024a10c6|TermRelationship|narrowerThan|null	f	narrowerThan	2ea0f7f0-89ee-4a30-bb0e-b697097f4a81
53fd626b-38cd-42fb-a5aa-d5f843de7f62	2	TermRelationship	\N	1e501792-7a44-4baa-a96a-c149e2003da6	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf795e73f-8ec5-4d3c-b74c-3829f2aefd28|Term|CTT40: Complex Test Term 40|null\n1e501792-7a44-4baa-a96a-c149e2003da6|TermRelationship|is-a-part-of|null	f	is-a-part-of	3c8acaa5-93cc-47bd-bb1a-f035126263f4
54caa65b-9e23-404c-bd93-bdf2f63d6888	2	Term	\N	2fbf3f4d-e2df-4b8e-bc83-669eaa6884f5	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n2fbf3f4d-e2df-4b8e-bc83-669eaa6884f5|Term|CTT56: Complex Test Term 56|null	f	CTT56: Complex Test Term 56	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
55ada9eb-0b74-40ff-9fea-8d32038408e6	2	Term	\N	f4227289-7fd1-4daf-8499-ed60f81de735	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf4227289-7fd1-4daf-8499-ed60f81de735|Term|CTT87: Complex Test Term 87|null	f	CTT87: Complex Test Term 87	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
57158cef-c721-4e3e-8a73-751d1e61843d	2	TermRelationship	\N	c3eb8a36-6bdf-4199-8301-88dc43b846e0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n47c68fb7-0bfc-41d1-bb9d-3c484715ad22|Term|CTT3: Complex Test Term 3|null\nc3eb8a36-6bdf-4199-8301-88dc43b846e0|TermRelationship|is-a-part-of|null	f	is-a-part-of	2591b722-682a-40be-96dc-af28fed7ffaf
57fde8c8-40b3-43ab-938a-325d03bbd1ce	2	TermRelationship	\N	83b0f019-65c5-490c-8ead-5a879be5be33	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf53c5264-8350-4b92-98be-c3fb976b1f57|Term|CTT100: Complex Test Term 100|null\n83b0f019-65c5-490c-8ead-5a879be5be33|TermRelationship|is-a|null	f	is-a	b795145b-9990-4bca-a650-9d2d773ae7f0
586b9dd8-2b6f-4c29-9924-28a217d18ce0	2	Term	\N	04cb80c6-0c6b-48ea-b5ad-98bad16763b5	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n04cb80c6-0c6b-48ea-b5ad-98bad16763b5|Term|CTT94: Complex Test Term 94|null	f	CTT94: Complex Test Term 94	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
589e3265-0cb4-48e4-ad03-bccadc105fe4	2	Term	\N	cab6ed3e-d53d-442b-8581-920f2795a15e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ncab6ed3e-d53d-442b-8581-920f2795a15e|Term|CTT73: Complex Test Term 73|null	f	CTT73: Complex Test Term 73	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
58e17a9b-bcb9-4bf6-a932-a69314580c01	2	Term	\N	35ea045f-8a9b-486b-aad0-1d4547179938	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n35ea045f-8a9b-486b-aad0-1d4547179938|Term|CTT84: Complex Test Term 84|null	f	CTT84: Complex Test Term 84	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
591cd88f-4fc1-4d07-a241-8f526bd5fb19	2	Term	\N	cfa35353-0759-44e6-834c-2b986e698fd0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ncfa35353-0759-44e6-834c-2b986e698fd0|Term|CTT74: Complex Test Term 74|null	f	CTT74: Complex Test Term 74	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
5ab7f6b0-1c0b-4883-bae8-1fc2b5f5d353	2	TermRelationship	\N	f82df746-f4a3-4129-8ce9-2550407d384f	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf1f23747-06bc-4566-8576-1d263a5fe9f0|Term|CTT85: Complex Test Term 85|null\nf82df746-f4a3-4129-8ce9-2550407d384f|TermRelationship|is-a-part-of|null	f	is-a-part-of	5d7869d8-3d1e-4c96-8717-68f15085701f
5bfdf553-219c-4647-a027-4d64a2357503	2	TermRelationship	\N	e4e8ce9b-973f-492d-9796-4c02e5253469	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc605c709-2b2c-44c5-b174-e865d3724b52|Term|CTT71: Complex Test Term 71|null\ne4e8ce9b-973f-492d-9796-4c02e5253469|TermRelationship|is-a-part-of|null	f	is-a-part-of	464f3d7b-b35c-4957-b6ae-4267311eaf6c
5c4facb6-9b35-4075-ab35-82e8443094f0	2	TermRelationship	\N	d2838c13-aa68-4d69-9039-a54904baf295	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nb1b1c31c-8c1f-46fe-8a7b-3f82433af150|Term|CTT27: Complex Test Term 27|null\nd2838c13-aa68-4d69-9039-a54904baf295|TermRelationship|is-a-part-of|null	f	is-a-part-of	0566c55e-1db3-4668-a779-415d6d384ed9
5d350f05-877b-4810-807c-3957dace5674	2	Term	\N	21b59ceb-c5b6-425e-a965-c625117178a6	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n21b59ceb-c5b6-425e-a965-c625117178a6|Term|CTT59: Complex Test Term 59|null	f	CTT59: Complex Test Term 59	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
5d59524f-7a29-4956-b712-b5f9317d5fb0	2	TermRelationship	\N	15a248e7-a931-4c05-af49-ea241c3bf9ea	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf7c0ae7f-8e45-44f0-8cb8-b060f8176da0|Term|CTT86: Complex Test Term 86|null\n15a248e7-a931-4c05-af49-ea241c3bf9ea|TermRelationship|is-a-part-of|null	f	is-a-part-of	a11f4a13-621a-4ebb-ad7b-46946d389eab
5d7869d8-3d1e-4c96-8717-68f15085701f	2	Term	\N	f1f23747-06bc-4566-8576-1d263a5fe9f0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf1f23747-06bc-4566-8576-1d263a5fe9f0|Term|CTT85: Complex Test Term 85|null	f	CTT85: Complex Test Term 85	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
5e7a841b-ff54-4ed2-a82d-7b0e9d95e217	2	Term	\N	b52bc4e7-ce89-47d6-917c-8d5e37ec0234	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nb52bc4e7-ce89-47d6-917c-8d5e37ec0234|Term|CTT15: Complex Test Term 15|null	f	CTT15: Complex Test Term 15	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
6229ad1b-2c2a-4d82-bd15-40fc11ef42d3	2	TermRelationship	\N	07753774-a24c-4c68-8665-590b2c4d80da	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n583adb72-aca6-41fb-a2ad-56eed28ef826|Term|CTT13: Complex Test Term 13|null\n07753774-a24c-4c68-8665-590b2c4d80da|TermRelationship|is-a-part-of|null	f	is-a-part-of	66f479d1-5218-485e-9e06-3850c5a1bd96
62447a0c-d874-4540-8c4f-baec0d4950a8	2	Term	\N	03314e3d-1598-4cdf-ac2b-15a5777f38c0	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n03314e3d-1598-4cdf-ac2b-15a5777f38c0|Term|CTT7: Complex Test Term 7|null	f	CTT7: Complex Test Term 7	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
626f7348-e1a2-439f-8fe4-a82e8c1634eb	2	TermRelationship	\N	da007a85-ac1c-4fc8-8d23-53c40be3b5b2	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne477f4eb-9dd5-4a67-86bb-7e292ada8f58|Term|CTT70: Complex Test Term 70|null\nda007a85-ac1c-4fc8-8d23-53c40be3b5b2|TermRelationship|is-a-part-of|null	f	is-a-part-of	a5c5ade3-4b1d-4b77-b9e4-6b5e97f339a5
632dedcf-0641-43df-a6e4-36d97fca5501	2	TermRelationship	\N	5a852efc-8a15-465d-8786-b0e07f69db55	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n368cceb7-ad83-4cf3-9581-fdb89fceb5b6|Term|CTT37: Complex Test Term 37|null\n5a852efc-8a15-465d-8786-b0e07f69db55|TermRelationship|is-a-part-of|null	f	is-a-part-of	676a5290-1214-4cd9-b753-bbe416ef76d0
641d62ad-6ffb-492b-8f03-46b196c74e5f	2	TermRelationship	\N	d6da33b6-136b-4136-8b9b-2a6b3a28ce3b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc08834bb-029d-4bc0-812b-a5aaeda79f4d|Term|CTT76: Complex Test Term 76|null\nd6da33b6-136b-4136-8b9b-2a6b3a28ce3b|TermRelationship|is-a-part-of|null	f	is-a-part-of	78199b78-de4f-4b86-bf38-ce092bb83764
65631d80-d997-4c82-b9b0-ca4be664f639	2	TermRelationship	\N	c8af71de-e4c2-405c-991d-435ff1761769	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\naef3acca-96c0-4827-9e73-c3f89bc85118|Term|CTT16: Complex Test Term 16|null\nc8af71de-e4c2-405c-991d-435ff1761769|TermRelationship|is-a-part-of|null	f	is-a-part-of	ca0581b1-0c98-4c9d-8d57-96962481f4da
65a667bf-43a4-4fb8-9689-641995992f82	2	TermRelationship	\N	31d5d8cc-6085-49e9-a3ca-dadd8a395a9d	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n33614052-00c8-4f9c-805f-32e7924c2e06|Term|CTT44: Complex Test Term 44|null\n31d5d8cc-6085-49e9-a3ca-dadd8a395a9d|TermRelationship|is-a-part-of|null	f	is-a-part-of	e3df3923-b04a-467f-8235-0da10c914b91
667da2d7-d5d8-40d1-ae49-42848fda6504	2	TermRelationship	\N	28ecc8ba-bea5-4d40-8e93-c16639a8be15	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n58f5ad41-2ba1-49ed-a72d-9a4141ff66fd|Term|CTT90: Complex Test Term 90|null\n28ecc8ba-bea5-4d40-8e93-c16639a8be15|TermRelationship|is-a-part-of|null	f	is-a-part-of	7d8824bc-0c4c-4658-b6c1-0d7b0f8a49dd
66f479d1-5218-485e-9e06-3850c5a1bd96	2	Term	\N	583adb72-aca6-41fb-a2ad-56eed28ef826	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n583adb72-aca6-41fb-a2ad-56eed28ef826|Term|CTT13: Complex Test Term 13|null	f	CTT13: Complex Test Term 13	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
676a5290-1214-4cd9-b753-bbe416ef76d0	2	Term	\N	368cceb7-ad83-4cf3-9581-fdb89fceb5b6	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n368cceb7-ad83-4cf3-9581-fdb89fceb5b6|Term|CTT37: Complex Test Term 37|null	f	CTT37: Complex Test Term 37	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
6ad59ede-38a1-4e1f-96b2-785c14840e37	2	TermRelationship	\N	bf27abdf-d9a2-4461-9854-6d0b7c3ad21b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4c69bf94-0d9e-4309-88a7-ea8b47846c9b|Term|CTT1: Complex Test Term 1|null\nbf27abdf-d9a2-4461-9854-6d0b7c3ad21b|TermRelationship|is-a-part-of|null	f	is-a-part-of	741f3396-560d-4eb8-be15-855d95a55907
6ba114c3-3255-47bd-9cf5-eb09469780bc	2	Term	\N	9c8a3b27-8bec-4822-a63b-9d01656e2972	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n9c8a3b27-8bec-4822-a63b-9d01656e2972|Term|CTT11: Complex Test Term 11|null	f	CTT11: Complex Test Term 11	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
6bf87a51-d9d2-479e-8425-a74d125ac492	2	Term	\N	578acfea-5b75-4ef8-acec-74f21d6c4471	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n578acfea-5b75-4ef8-acec-74f21d6c4471|Term|CTT30: Complex Test Term 30|null	f	CTT30: Complex Test Term 30	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
6c9707bd-bee6-43b0-a7b1-22317df9b087	2	Term	\N	f783da6c-26dc-4403-b3d0-cf4a2a7581d8	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nf783da6c-26dc-4403-b3d0-cf4a2a7581d8|Term|CTT52: Complex Test Term 52|null	f	CTT52: Complex Test Term 52	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
6e2c36f6-ead9-4fff-bc93-3f59799d4660	2	TermRelationship	\N	4d846c97-4626-4232-8360-a9bf94c4155c	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n443a219c-96ef-4afc-b9fe-a9968c96f1b1|Term|CTT14: Complex Test Term 14|null\n4d846c97-4626-4232-8360-a9bf94c4155c|TermRelationship|is-a-part-of|null	f	is-a-part-of	a1b2cb04-400d-4ce0-a8b5-2edd5d0d8b80
6f8c8fe2-17c4-451e-8cc3-d54afd86d0aa	2	TermRelationship	\N	f5e02d45-45b3-433a-ae63-aa7dc3488537	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n413df0ac-c866-44f9-af53-ca65f9c28da1|Term|CTT49: Complex Test Term 49|null\nf5e02d45-45b3-433a-ae63-aa7dc3488537|TermRelationship|is-a-part-of|null	f	is-a-part-of	d2333774-2aa5-4bd1-8afc-3efc3bc236e9
7032e9b0-6743-49a1-a4ce-c6876be54aae	2	Term	\N	7940bb06-7dba-4141-95c0-e2db8b98216f	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n7940bb06-7dba-4141-95c0-e2db8b98216f|Term|CTT47: Complex Test Term 47|null	f	CTT47: Complex Test Term 47	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
71363338-3273-4e8d-99d4-10570c3f1443	2	Term	\N	ab531b62-af47-4e11-ae67-ee7b18b8bf9a	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nab531b62-af47-4e11-ae67-ee7b18b8bf9a|Term|CTT23: Complex Test Term 23|null	f	CTT23: Complex Test Term 23	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
738493aa-104a-40dc-90f3-b4a1bb81d0f6	2	TermRelationship	\N	1303e2d2-770c-461d-9e2d-9911750acaaa	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n03314e3d-1598-4cdf-ac2b-15a5777f38c0|Term|CTT7: Complex Test Term 7|null\n1303e2d2-770c-461d-9e2d-9911750acaaa|TermRelationship|is-a-part-of|null	f	is-a-part-of	62447a0c-d874-4540-8c4f-baec0d4950a8
741f3396-560d-4eb8-be15-855d95a55907	2	Term	\N	4c69bf94-0d9e-4309-88a7-ea8b47846c9b	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n4c69bf94-0d9e-4309-88a7-ea8b47846c9b|Term|CTT1: Complex Test Term 1|null	f	CTT1: Complex Test Term 1	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
74fb7b62-e341-49fd-bcf0-f4f82e11ec6c	2	TermRelationship	\N	a756c120-56e7-4f75-8c9b-9d753e92fb5f	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne14c6acb-4224-41e7-b724-789b652ba6ca|Term|CTT25: Complex Test Term 25|null\na756c120-56e7-4f75-8c9b-9d753e92fb5f|TermRelationship|is-a-part-of|null	f	is-a-part-of	dbad9404-ee8b-49b7-a68c-ee3f0020fc90
753188c8-6f83-47b0-8ff6-d43c64117392	2	TermRelationship	\N	9b9d6403-5c10-416d-8cfb-a55d862d8526	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nea8d3d31-39bc-4194-b0bc-fa0e23fc1771|Term|CTT5: Complex Test Term 5|null\n9b9d6403-5c10-416d-8cfb-a55d862d8526|TermRelationship|is-a-part-of|null	f	is-a-part-of	fdd81b9e-c89c-494a-81e0-f050e4dd58e0
762d77c6-f457-4218-a72f-961cb069d936	2	TermRelationship	\N	a522ad1f-462b-4e48-a6f8-f797b72fdb0e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n118ae67a-dfc0-4a90-8e4d-7e458ffa8cce|Term|CTT6: Complex Test Term 6|null\na522ad1f-462b-4e48-a6f8-f797b72fdb0e|TermRelationship|is-a-part-of|null	f	is-a-part-of	06613eaa-619b-49ae-a8e4-a8993a5e0041
7660aaa2-c774-42ed-92be-abcd50ea7688	2	TermRelationship	\N	b989636c-f150-45e3-8e57-77bb0e797e6a	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\naef3acca-96c0-4827-9e73-c3f89bc85118|Term|CTT16: Complex Test Term 16|null\nb989636c-f150-45e3-8e57-77bb0e797e6a|TermRelationship|broaderThan|null	f	broaderThan	ca0581b1-0c98-4c9d-8d57-96962481f4da
76af915f-f19f-4d36-895d-2dcdbefff1ef	2	Term	\N	e901be9b-113a-4ff1-b835-9fd1e509f3e1	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\ne901be9b-113a-4ff1-b835-9fd1e509f3e1|Term|CTT53: Complex Test Term 53|null	f	CTT53: Complex Test Term 53	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
78199b78-de4f-4b86-bf38-ce092bb83764	2	Term	\N	c08834bb-029d-4bc0-812b-a5aaeda79f4d	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\nc08834bb-029d-4bc0-812b-a5aaeda79f4d|Term|CTT76: Complex Test Term 76|null	f	CTT76: Complex Test Term 76	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
7822a97c-f124-4ef6-b46e-bf68f5501424	2	TermRelationship	\N	14306054-afed-4ba9-aad5-f9e47b58f8f2	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n04cb80c6-0c6b-48ea-b5ad-98bad16763b5|Term|CTT94: Complex Test Term 94|null\n14306054-afed-4ba9-aad5-f9e47b58f8f2|TermRelationship|is-a-part-of|null	f	is-a-part-of	586b9dd8-2b6f-4c29-9924-28a217d18ce0
78e4e10f-0173-42fa-b9ec-22d025fba91d	2	TermRelationship	\N	30569cb3-b367-44e9-b500-d8c63b351037	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n35ea045f-8a9b-486b-aad0-1d4547179938|Term|CTT84: Complex Test Term 84|null\n30569cb3-b367-44e9-b500-d8c63b351037|TermRelationship|is-a-part-of|null	f	is-a-part-of	58e17a9b-bcb9-4bf6-a932-a69314580c01
7c5eb5b7-b483-498e-9b36-8903ca859525	2	TermRelationship	\N	e2a6b6e1-df19-4102-9a6f-8556d6e0a55e	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\na846ac87-557f-45ea-822b-ca7f8bf754fc|Term|CTT57: Complex Test Term 57|null\ne2a6b6e1-df19-4102-9a6f-8556d6e0a55e|TermRelationship|is-a-part-of|null	f	is-a-part-of	e2ebc928-1d0b-4174-987b-14c60aab17fc
7cddeb12-0623-49d4-885e-f4a7c6c8aa21	2	Term	\N	3a34acb0-0717-4e5a-976f-eb5b1f3ed124	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n3a34acb0-0717-4e5a-976f-eb5b1f3ed124|Term|CTT4: Complex Test Term 4|null	f	CTT4: Complex Test Term 4	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
7d8824bc-0c4c-4658-b6c1-0d7b0f8a49dd	2	Term	\N	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n58f5ad41-2ba1-49ed-a72d-9a4141ff66fd|Term|CTT90: Complex Test Term 90|null	f	CTT90: Complex Test Term 90	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924
7daaf6a5-3a92-474b-b05f-13f8b6d62360	2	TermRelationship	\N	c50b4090-7761-49c3-b9bf-40a5e5c4dcc8	fa8b47d9-daae-4d61-a682-2a93a893c6ca|Terminology|Complex Test Terminology|false\n6ecaf047-9c75-426c-9041-bc1ec33d6a68|Term|CTT45: Complex Test Term 45|null\nc50b4090-7761-49c3-b9bf-40a5e5c4dcc8|TermRelationship|is-a-part-of|null	f	is-a-part-of	292db074-9ada-4e1d-b30e-087a42495531
85ffbe1e-69df-49ee-a1ae-889a595780de	1	Terminology	f	3b623de2-7811-443d-b403-f06981264881	3b623de2-7811-443d-b403-f06981264881|Terminology|Simple Test Terminology|false	t	Simple Test Terminology	\N
8433bb07-bf82-4805-a726-18b8e1e0f23e	1	Term	\N	0af12722-1469-4d38-a200-70a377986776	3b623de2-7811-443d-b403-f06981264881|Terminology|Simple Test Terminology|false\n0af12722-1469-4d38-a200-70a377986776|Term|STT02: Simple Test Term 02|null	f	STT02: Simple Test Term 02	85ffbe1e-69df-49ee-a1ae-889a595780de
11d732f8-3402-4cc2-9149-5e21694f7db7	1	Term	\N	475576ab-7511-4b98-8cfb-562be8c4fcc5	3b623de2-7811-443d-b403-f06981264881|Terminology|Simple Test Terminology|false\n475576ab-7511-4b98-8cfb-562be8c4fcc5|Term|STT01: Simple Test Term 01|null	f	STT01: Simple Test Term 01	85ffbe1e-69df-49ee-a1ae-889a595780de
a1ffd852-b490-4948-81e5-e9d8ca09156a	4	ReferenceDataModel	f	e309016a-b128-4282-afaa-37cdb8d88193	e309016a-b128-4282-afaa-37cdb8d88193|ReferenceDataModel|Simple Reference Data Model|false	t	Simple Reference Data Model	\N
070e44f5-5d24-4847-9a12-b0e220571657	3	ReferencePrimitiveType	\N	7d15d6cb-96c4-4828-889d-7d1bd78bff23	e309016a-b128-4282-afaa-37cdb8d88193|ReferenceDataModel|Simple Reference Data Model|false\n7d15d6cb-96c4-4828-889d-7d1bd78bff23|ReferencePrimitiveType|integer|null	f	integer	a1ffd852-b490-4948-81e5-e9d8ca09156a
1b714a46-ddc9-4e08-a736-4f33ff0cd85c	2	ReferenceDataElement	\N	39b2093f-f62d-46f7-b1be-b350ea89cfe3	e309016a-b128-4282-afaa-37cdb8d88193|ReferenceDataModel|Simple Reference Data Model|false\n39b2093f-f62d-46f7-b1be-b350ea89cfe3|ReferenceDataElement|Organisation name|null	f	Organisation name	a1ffd852-b490-4948-81e5-e9d8ca09156a
4cc72525-f0a2-450e-b79d-b837d3b914fe	2	ReferenceDataElement	\N	ee520084-a89c-4b72-9e8c-2d444b8093b6	e309016a-b128-4282-afaa-37cdb8d88193|ReferenceDataModel|Simple Reference Data Model|false\nee520084-a89c-4b72-9e8c-2d444b8093b6|ReferenceDataElement|Organisation code|null	f	Organisation code	a1ffd852-b490-4948-81e5-e9d8ca09156a
553315f7-ed50-4631-847c-f31585fec36e	3	ReferencePrimitiveType	\N	58567a62-59c0-4cb6-af34-2961b0673bda	e309016a-b128-4282-afaa-37cdb8d88193|ReferenceDataModel|Simple Reference Data Model|false\n58567a62-59c0-4cb6-af34-2961b0673bda|ReferencePrimitiveType|string|null	f	string	a1ffd852-b490-4948-81e5-e9d8ca09156a
\.


--
-- Data for Name: classifier; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.classifier (id, version, date_created, last_updated, path, depth, parent_classifier_id, readable_by_authenticated_users, created_by, readable_by_everyone, label, description) FROM stdin;
ed172493-dc3a-4125-ac99-d63373937ef9	0	2021-10-04 13:23:12.528347	2021-10-04 13:23:12.528347		0	\N	f	development@test.com	f	Development Classifier	\N
d875859e-54f8-41af-897c-2173661b5174	0	2021-10-04 13:23:13.403615	2021-10-04 13:23:13.403615		0	\N	t	development@test.com	f	test classifier	\N
7d5e4809-6370-41cd-a4a3-cd1d91579ca0	0	2021-10-04 13:23:13.4113	2021-10-04 13:23:13.4113		0	\N	t	development@test.com	f	test classifier2	\N
38e1a1ef-d3f2-42a3-b073-9e3c0eab1df5	0	2021-10-04 13:23:13.915899	2021-10-04 13:23:13.915899		0	\N	t	development@test.com	f	test classifier simple	\N
\.


--
-- Data for Name: edit; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.edit (id, version, date_created, last_updated, resource_domain_type, resource_id, created_by, description, title) FROM stdin;
00b8514d-56bd-4a93-bd7b-12f213ffce38	0	2021-10-04 13:23:14.355506	2021-10-04 13:23:14.355506	DataModel	6e73dcde-8ce7-4c45-b37d-0494e55394c9	development@test.com	DataModel finalised by null null on 2021-10-04T12:23:14.259Z	FINALISE
161cc25b-28d3-410d-b4b5-b2cd9e736798	0	2021-10-04 13:23:14.796461	2021-10-04 13:23:14.796461	DataModel	926d5e0c-5ee5-457f-9335-3e97d02c08b2	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 6e73dcde-8ce7-4c45-b37d-0494e55394c9	COPY
0882b62d-cd9a-4a13-9e64-8c3553a46749	0	2021-10-04 13:23:14.869847	2021-10-04 13:23:14.869847	DataModel	926d5e0c-5ee5-457f-9335-3e97d02c08b2	development@test.com	DataModel finalised by null null on 2021-10-04T12:23:14.837Z	FINALISE
299e3cd9-d267-4ea8-b2c6-69b7089ea607	0	2021-10-04 13:23:15.095785	2021-10-04 13:23:15.095785	DataModel	b3099f15-afde-436a-be99-1300eae98b4e	development@test.com	DataModel Data Standard:Model Version Tree DataModel fork created as a copy of 926d5e0c-5ee5-457f-9335-3e97d02c08b2	COPY
15da880c-3dc3-4f6b-9e17-a98a385df291	0	2021-10-04 13:23:15.287628	2021-10-04 13:23:15.287628	DataModel	c5c83da4-47de-44f2-a5fd-414ac1f13900	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 6e73dcde-8ce7-4c45-b37d-0494e55394c9	COPY
27413d5c-e72d-49ce-b024-9fcbeb9f69f3	0	2021-10-04 13:23:15.897533	2021-10-04 13:23:15.897533	DataModel	c84fb099-79bc-496a-8901-75c99d539fbd	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 6e73dcde-8ce7-4c45-b37d-0494e55394c9	COPY
83f81ff1-7f36-4fa1-bed5-075049922724	0	2021-10-04 13:23:16.072295	2021-10-04 13:23:16.072295	DataModel	c5c83da4-47de-44f2-a5fd-414ac1f13900	development@test.com	DataModel finalised by null null on 2021-10-04T12:23:16.035Z	FINALISE
a5dcdafd-6f73-4f7e-802d-37db59804358	0	2021-10-04 13:23:16.331989	2021-10-04 13:23:16.331989	DataModel	94f194ee-79db-4835-840e-4168bc4d9331	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of c5c83da4-47de-44f2-a5fd-414ac1f13900	COPY
3f5e7c87-8a8f-4f44-97f0-d9bca0660e0f	0	2021-10-04 13:23:16.398493	2021-10-04 13:23:16.398493	DataModel	94f194ee-79db-4835-840e-4168bc4d9331	development@test.com	DataModel finalised by null null on 2021-10-04T12:23:16.367Z	FINALISE
136e38d3-76ef-4fab-a1c7-a7bd91f792b0	0	2021-10-04 13:23:16.640969	2021-10-04 13:23:16.640969	DataModel	726b5b98-4b02-433d-9e3b-249f139a27dc	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 94f194ee-79db-4835-840e-4168bc4d9331	COPY
190d6835-bb3c-4701-b987-63583217642e	0	2021-10-04 13:23:16.871054	2021-10-04 13:23:16.871054	DataModel	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 94f194ee-79db-4835-840e-4168bc4d9331	COPY
0aef4c6c-fa97-4184-9a66-3c777c929870	0	2021-10-04 13:23:17.005957	2021-10-04 13:23:17.005957	DataModel	726b5b98-4b02-433d-9e3b-249f139a27dc	development@test.com	DataModel finalised by null null on 2021-10-04T12:23:16.977Z	FINALISE
79d9df25-b7aa-4172-85b8-b9ddc0895cc3	0	2021-10-04 13:23:17.208793	2021-10-04 13:23:17.208793	DataModel	9dd076ab-1240-474c-a3cb-5ef48863c208	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 726b5b98-4b02-433d-9e3b-249f139a27dc	COPY
ebed93bf-0686-4d71-8dcf-44abbdfb4163	0	2021-10-04 13:23:17.413482	2021-10-04 13:23:17.413482	DataModel	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 726b5b98-4b02-433d-9e3b-249f139a27dc	COPY
a1079c05-3a5d-4717-be53-4f860b262d2d	0	2021-10-04 13:23:17.488523	2021-10-04 13:23:17.488523	DataModel	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	development@test.com	DataModel finalised by null null on 2021-10-04T12:23:17.457Z	FINALISE
f3452005-2bd3-4c56-b730-e12034446ed9	0	2021-10-04 13:23:17.67105	2021-10-04 13:23:17.67105	DataModel	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	COPY
d7dbe061-fe2a-48b9-9e65-4bf81b0985e0	0	2021-10-04 13:23:17.894631	2021-10-04 13:23:17.894631	DataModel	eb5a08e6-844e-47c1-a31f-160dd238c202	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	COPY
24f95637-2b4d-47e8-af8f-944ec9d1dd3d	0	2021-10-04 13:23:18.261003	2021-10-04 13:23:18.261003	DataModel	4b01f763-2505-46a2-938b-88622ca2eaa8	development@test.com	DataModel Data Standard:Model Version Tree DataModel created as a copy of 20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	COPY
\.


--
-- Data for Name: email; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.email (id, version, sent_to_email_address, successfully_sent, body, date_time_sent, email_service_used, failure_reason, subject) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.0.0	core	SQL	V1_0_0__core.sql	30735148	maurodatamapper	2021-10-04 13:23:08.161409	117	t
2	1.5.0	authority	SQL	V1_5_0__authority.sql	1820762963	maurodatamapper	2021-10-04 13:23:08.286209	6	t
3	1.7.0	semantic link add unconfirmed	SQL	V1_7_0__semantic_link_add_unconfirmed.sql	490568862	maurodatamapper	2021-10-04 13:23:08.299907	1	t
4	1.13.0	add versioned folder	SQL	V1_13_0__add_versioned_folder.sql	1714761766	maurodatamapper	2021-10-04 13:23:08.305775	3	t
5	1.15.0	add rule	SQL	V1_15_0__add_rule.sql	1865268520	maurodatamapper	2021-10-04 13:23:08.312695	6	t
6	1.15.5	add rulerepresentation	SQL	V1_15_5__add_rulerepresentation.sql	-2123765594	maurodatamapper	2021-10-04 13:23:08.323993	6	t
0	\N	<< Flyway Schema Creation >>	SCHEMA	"core"	\N	maurodatamapper	2021-10-04 13:23:08.130404	0	t
7	2.0.0	fix flyway	SQL	V2_0_0__fix_flyway.sql	-995285273	maurodatamapper	2021-10-04 13:23:08.334968	115	t
8	2.1.0	add delete cascade to some foreign keys	SQL	V2_1_0__add_delete_cascade_to_some_foreign_keys.sql	1123726048	maurodatamapper	2021-10-04 13:23:08.454597	5	t
9	2.2.0	update edit description to text type	SQL	V2_2_0__update_edit_description_to_text_type.sql	758628834	maurodatamapper	2021-10-04 13:23:08.463651	1	t
10	2.3.0	model import	SQL	V2_3_0__model_import.sql	969010724	maurodatamapper	2021-10-04 13:23:08.469735	6	t
11	2.3.1	model extend	SQL	V2_3_1__model_extend.sql	423308479	maurodatamapper	2021-10-04 13:23:08.480097	7	t
12	2.4.0	update api properties	SQL	V2_4_0__update_api_properties.sql	185217942	maurodatamapper	2021-10-04 13:23:08.490757	3	t
13	2.5.0	add model version tag to versioned folder	SQL	V2_5_0__add_model_version_tag_to_versioned_folder.sql	-1320780895	maurodatamapper	2021-10-04 13:23:08.497175	1	t
14	2.6.0	add indexing to metadata	SQL	V2_6_0__add_indexing_to_metadata.sql	703739930	maurodatamapper	2021-10-04 13:23:08.501978	2	t
15	2.7.0	add and migrate edit title	SQL	V2_7_0__add_and_migrate_edit_title.sql	-665000924	maurodatamapper	2021-10-04 13:23:08.507437	3	t
16	2.8.0	rename catalogue item to multi facet	SQL	V2_8_0__rename_catalogue_item_to_multi_facet.sql	-491830151	maurodatamapper	2021-10-04 13:23:08.514327	5	t
17	2.8.1	containers add facets	SQL	V2_8_1__containers_add_facets.sql	824749235	maurodatamapper	2021-10-04 13:23:08.523328	18	t
18	2.8.2	remove model import export	SQL	V2_8_2__remove_model_import_export.sql	-1422014840	maurodatamapper	2021-10-04 13:23:08.545566	1	t
19	2.9.0	add version links to versioned folder	SQL	V2_9_0__add_version_links_to_versioned_folder.sql	-1431906977	maurodatamapper	2021-10-04 13:23:08.550752	5	t
20	2.10.0	add default authority field	SQL	V2_10_0__add_default_authority_field.sql	-564973694	maurodatamapper	2021-10-04 13:23:08.559431	2	t
\.


--
-- Data for Name: folder; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.folder (id, version, date_created, last_updated, path, deleted, depth, readable_by_authenticated_users, parent_folder_id, created_by, readable_by_everyone, label, description, class, branch_name, finalised, date_finalised, documentation_version, model_version, authority_id, model_version_tag) FROM stdin;
867eaaec-64b4-4736-8938-71caa2a0b837	0	2021-10-04 13:23:12.348701	2021-10-04 13:23:12.348701		f	0	f	\N	development@test.com	f	Development Folder	\N	uk.ac.ox.softeng.maurodatamapper.core.container.Folder	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: join_classifier_to_facet; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.join_classifier_to_facet (classifier_id, annotation_id, rule_id, semantic_link_id, reference_file_id, metadata_id) FROM stdin;
\.


--
-- Data for Name: join_folder_to_facet; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.join_folder_to_facet (folder_id, annotation_id, rule_id, semantic_link_id, reference_file_id, metadata_id) FROM stdin;
\.


--
-- Data for Name: join_versionedfolder_to_facet; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.join_versionedfolder_to_facet (versionedfolder_id, version_link_id) FROM stdin;
\.


--
-- Data for Name: metadata; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.metadata (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, namespace, multi_facet_aware_item_id, value, created_by, key) FROM stdin;
59aa910e-a838-40ec-aa2f-b997f3c79216	0	2021-10-04 13:23:13.5569	2021-10-04 13:23:13.5569	DataModel	test.com	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	mdv1	development@test.com	mdk1
c6482c71-f565-4c0d-b6d2-06de7e7d1504	0	2021-10-04 13:23:13.559418	2021-10-04 13:23:13.559418	DataModel	test.com	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	mdv2	development@test.com	mdk2
a6edf2a9-6dce-41da-8b2f-45ab83087a59	0	2021-10-04 13:23:13.560007	2021-10-04 13:23:13.560007	DataModel	test.com/test	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	mdv2	development@test.com	mdk1
1c8a8eea-c130-4a15-a6fb-d170c3f34c61	0	2021-10-04 13:23:13.949713	2021-10-04 13:23:13.949713	DataModel	test.com/simple	dc5e3bb9-9119-4540-a586-2f55380e49f4	mdv1	development@test.com	mdk1
a921aaef-9920-4d3f-8298-1f0a09182f30	0	2021-10-04 13:23:13.950729	2021-10-04 13:23:13.950729	DataModel	test.com	dc5e3bb9-9119-4540-a586-2f55380e49f4	mdv2	development@test.com	mdk2
5f83af67-4039-4df7-bc87-bb03dcc8cedf	0	2021-10-04 13:23:13.951187	2021-10-04 13:23:13.951187	DataModel	test.com/simple	dc5e3bb9-9119-4540-a586-2f55380e49f4	mdv2	development@test.com	mdk2
60af69cf-f515-487c-8bae-8e7338f62d70	0	2021-10-04 13:23:13.969966	2021-10-04 13:23:13.969966	DataClass	test.com/simple	68d946d6-a0da-4859-a4df-7c14c9831d38	mdv1	development@test.com	mdk1
19c9be8f-9446-4dbb-8de7-7dd952b836c7	0	2021-10-04 13:23:14.189329	2021-10-04 13:23:14.189329	DataModel	v1Versioning.com	6e73dcde-8ce7-4c45-b37d-0494e55394c9	jun2	development@test.com	jun1
c162d82b-0c0a-4098-8eb7-34041bd6029d	0	2021-10-04 13:23:14.190654	2021-10-04 13:23:14.190654	DataModel	v1Versioning.com	6e73dcde-8ce7-4c45-b37d-0494e55394c9	mdv1	development@test.com	mdk1
3dac39a1-c12a-4f29-928d-46dbf451489b	0	2021-10-04 13:23:14.191096	2021-10-04 13:23:14.191096	DataModel	v1Versioning.com	6e73dcde-8ce7-4c45-b37d-0494e55394c9	mdv2	development@test.com	mdk2
9f34ebc9-b596-4e1e-8c65-492b0d9a19b0	0	2021-10-04 13:23:14.238886	2021-10-04 13:23:14.238886	DataModel	versioning.com	6e73dcde-8ce7-4c45-b37d-0494e55394c9	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
824a4f58-29de-4524-85e5-64573c11b643	1	2021-10-04 13:23:14.795469	2021-10-04 13:23:14.823573	DataModel	v1Versioning.com	926d5e0c-5ee5-457f-9335-3e97d02c08b2	mdv1	development@test.com	mdk1
152f7207-94d3-4092-a859-3bf496da6412	1	2021-10-04 13:23:14.793927	2021-10-04 13:23:14.824526	DataModel	v1Versioning.com	926d5e0c-5ee5-457f-9335-3e97d02c08b2	jun2	development@test.com	jun1
2e4a4861-d2d4-43bb-806e-8acd2e5af8ee	1	2021-10-04 13:23:14.795821	2021-10-04 13:23:14.824886	DataModel	v1Versioning.com	926d5e0c-5ee5-457f-9335-3e97d02c08b2	mdv2	development@test.com	mdk2
7b246b50-fd49-47af-812a-ea086f97971b	1	2021-10-04 13:23:14.79615	2021-10-04 13:23:14.825307	DataModel	versioning.com	926d5e0c-5ee5-457f-9335-3e97d02c08b2	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
9f677b07-ef48-498f-9f48-46685b2af5d0	1	2021-10-04 13:23:15.093725	2021-10-04 13:23:15.112002	DataModel	v1Versioning.com	b3099f15-afde-436a-be99-1300eae98b4e	mdv1	development@test.com	mdk1
adc43fd0-868d-4bd6-988d-c3ef4a5b1d9a	1	2021-10-04 13:23:15.095484	2021-10-04 13:23:15.112926	DataModel	versioning.com	b3099f15-afde-436a-be99-1300eae98b4e	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
d4bddacd-8f39-465b-8217-f0316c7aa33a	1	2021-10-04 13:23:15.095179	2021-10-04 13:23:15.113298	DataModel	v1Versioning.com	b3099f15-afde-436a-be99-1300eae98b4e	mdv2	development@test.com	mdk2
ea2e5d17-e094-4946-a3bf-ba2c7fc2a811	1	2021-10-04 13:23:15.094846	2021-10-04 13:23:15.113607	DataModel	v1Versioning.com	b3099f15-afde-436a-be99-1300eae98b4e	jun2	development@test.com	jun1
16f816cc-9a66-4db4-99b5-58873b7373bd	1	2021-10-04 13:23:15.286702	2021-10-04 13:23:15.311374	DataModel	v1Versioning.com	c5c83da4-47de-44f2-a5fd-414ac1f13900	mdv1	development@test.com	mdk1
66dd750d-f0e5-45cd-a2cb-0867dd4ea17d	1	2021-10-04 13:23:15.287343	2021-10-04 13:23:15.311684	DataModel	versioning.com	c5c83da4-47de-44f2-a5fd-414ac1f13900	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
dfc7b229-b253-47d4-b352-a546e1ec1353	0	2021-10-04 13:23:15.373095	2021-10-04 13:23:15.373095	DataModel	JRDev.com/versioning	c5c83da4-47de-44f2-a5fd-414ac1f13900	mkv2	development@test.com	mkv1
d0fe90bf-f879-4770-ad59-906c1f4e2218	0	2021-10-04 13:23:15.373939	2021-10-04 13:23:15.373939	DataModel	JRDev.com/versioning	c5c83da4-47de-44f2-a5fd-414ac1f13900	abc3	development@test.com	abc2
9446b078-1d86-4717-9364-9f937654f00d	2	2021-10-04 13:23:15.285643	2021-10-04 13:23:15.650243	DataModel	v1Versioning.com	c5c83da4-47de-44f2-a5fd-414ac1f13900	mod1	development@test.com	jun1
aae8df2f-f05b-4d02-93df-fe435d0b3d72	1	2021-10-04 13:23:15.89575	2021-10-04 13:23:15.909353	DataModel	v1Versioning.com	c84fb099-79bc-496a-8901-75c99d539fbd	jun2	development@test.com	jun1
30a9bd4f-1b1d-48ea-a27d-7d7341834eb0	1	2021-10-04 13:23:15.897268	2021-10-04 13:23:15.910017	DataModel	versioning.com	c84fb099-79bc-496a-8901-75c99d539fbd	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
51b0a090-1eb3-469b-b8aa-fe610d05ffc1	1	2021-10-04 13:23:15.897002	2021-10-04 13:23:15.91032	DataModel	v1Versioning.com	c84fb099-79bc-496a-8901-75c99d539fbd	mdv2	development@test.com	mdk2
68eb3360-d433-4a87-8486-fc588f77656b	1	2021-10-04 13:23:15.896699	2021-10-04 13:23:15.910587	DataModel	v1Versioning.com	c84fb099-79bc-496a-8901-75c99d539fbd	mdv1	development@test.com	mdk1
6bbdce5c-745a-4395-9358-6ba03c6d6101	0	2021-10-04 13:23:15.968905	2021-10-04 13:23:15.968905	DataModel	versioning.com	c84fb099-79bc-496a-8901-75c99d539fbd	mdv1	development@test.com	mdk1
1a5fb315-68f1-4178-b031-fd1d9840582d	0	2021-10-04 13:23:15.972568	2021-10-04 13:23:15.972568	DataModel	versioning.com	c84fb099-79bc-496a-8901-75c99d539fbd	mdv2	development@test.com	mdk2
947755d5-cfec-41ae-9b4f-9c7be302cc1e	0	2021-10-04 13:23:15.972873	2021-10-04 13:23:15.972873	DataModel	versioning.com/bootstrap	c84fb099-79bc-496a-8901-75c99d539fbd	mdv2	development@test.com	mdk1
9e680962-9dda-4f32-a4e9-fb81928d5814	1	2021-10-04 13:23:16.331505	2021-10-04 13:23:16.355048	DataModel	JRDev.com/versioning	94f194ee-79db-4835-840e-4168bc4d9331	mkv2	development@test.com	mkv1
bdf18161-b0d1-418c-9fdf-6b0848a435b0	1	2021-10-04 13:23:16.331248	2021-10-04 13:23:16.355903	DataModel	versioning.com	94f194ee-79db-4835-840e-4168bc4d9331	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
76c48013-bdce-43ba-9ea6-36b31bb37782	1	2021-10-04 13:23:16.329318	2021-10-04 13:23:16.356235	DataModel	v1Versioning.com	94f194ee-79db-4835-840e-4168bc4d9331	mod1	development@test.com	jun1
76f36828-de9f-4583-8fb2-ba78fac16df7	1	2021-10-04 13:23:16.330894	2021-10-04 13:23:16.356518	DataModel	v1Versioning.com	94f194ee-79db-4835-840e-4168bc4d9331	mdv1	development@test.com	mdk1
7be2aca0-dd1e-45e7-931b-a2b64f42dbfe	1	2021-10-04 13:23:16.331743	2021-10-04 13:23:16.356758	DataModel	JRDev.com/versioning	94f194ee-79db-4835-840e-4168bc4d9331	abc3	development@test.com	abc2
8be0b38a-27af-4f26-80a6-832ba9c4eaa8	1	2021-10-04 13:23:16.639593	2021-10-04 13:23:16.66493	DataModel	versioning.com	726b5b98-4b02-433d-9e3b-249f139a27dc	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
99a04a15-1474-4d44-a646-56e869edebf9	1	2021-10-04 13:23:16.640669	2021-10-04 13:23:16.665879	DataModel	JRDev.com/versioning	726b5b98-4b02-433d-9e3b-249f139a27dc	abc3	development@test.com	abc2
b1104a5b-51d9-4702-886c-1c4c3670784e	1	2021-10-04 13:23:16.640033	2021-10-04 13:23:16.666255	DataModel	v1Versioning.com	726b5b98-4b02-433d-9e3b-249f139a27dc	mod1	development@test.com	jun1
d93fadbd-9c3f-494a-a992-2a7686db272e	1	2021-10-04 13:23:16.637971	2021-10-04 13:23:16.66658	DataModel	JRDev.com/versioning	726b5b98-4b02-433d-9e3b-249f139a27dc	mkv2	development@test.com	mkv1
682aee44-7550-4180-9689-f67e28ffe30c	1	2021-10-04 13:23:16.640368	2021-10-04 13:23:16.666871	DataModel	v1Versioning.com	726b5b98-4b02-433d-9e3b-249f139a27dc	mdv1	development@test.com	mdk1
8d2faa6a-fc83-4a94-a0e8-5d0860e9ca3a	1	2021-10-04 13:23:16.870598	2021-10-04 13:23:16.894415	DataModel	v1Versioning.com	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	mdv1	development@test.com	mdk1
e5dd03d9-e122-40bd-8b17-4a88df0cd7f3	1	2021-10-04 13:23:16.870121	2021-10-04 13:23:16.89601	DataModel	versioning.com	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
4a00d7e5-e194-4428-b3d0-efb98f6abbc2	1	2021-10-04 13:23:16.869063	2021-10-04 13:23:16.896271	DataModel	JRDev.com/versioning	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	mkv2	development@test.com	mkv1
6f0d821e-2dda-4ddd-a3a7-4100d4d8b613	1	2021-10-04 13:23:16.870829	2021-10-04 13:23:16.8965	DataModel	JRDev.com/versioning	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	abc3	development@test.com	abc2
780a2df7-2a0f-4849-afc9-2cdbd59d858d	2	2021-10-04 13:23:16.87037	2021-10-04 13:23:16.943816	DataModel	v1Versioning.com	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	modtest	development@test.com	jun1
9161816b-0e58-41c0-96a9-a2bd335e5520	1	2021-10-04 13:23:17.206367	2021-10-04 13:23:17.229616	DataModel	versioning.com	9dd076ab-1240-474c-a3cb-5ef48863c208	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
2f2b0a9e-af5b-4746-8b72-2024e02a2bfd	1	2021-10-04 13:23:17.208286	2021-10-04 13:23:17.230563	DataModel	JRDev.com/versioning	9dd076ab-1240-474c-a3cb-5ef48863c208	mkv2	development@test.com	mkv1
4e6b8395-0ab7-41e0-82da-9a0dde2f1cc0	1	2021-10-04 13:23:17.207723	2021-10-04 13:23:17.230818	DataModel	JRDev.com/versioning	9dd076ab-1240-474c-a3cb-5ef48863c208	abc3	development@test.com	abc2
5c84df42-070d-49b9-910c-74a2890b5388	1	2021-10-04 13:23:17.20855	2021-10-04 13:23:17.231048	DataModel	v1Versioning.com	9dd076ab-1240-474c-a3cb-5ef48863c208	mdv1	development@test.com	mdk1
5dbf013f-6ec5-4643-8809-20d7730ca73d	1	2021-10-04 13:23:17.208033	2021-10-04 13:23:17.23127	DataModel	v1Versioning.com	9dd076ab-1240-474c-a3cb-5ef48863c208	mod1	development@test.com	jun1
dd7e476c-9584-4d91-98d7-0d03d8887f8e	1	2021-10-04 13:23:17.412449	2021-10-04 13:23:17.443423	DataModel	JRDev.com/versioning	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	abc3	development@test.com	abc2
f6f1018c-7da7-47c1-a174-3ce8eb63f997	1	2021-10-04 13:23:17.413011	2021-10-04 13:23:17.445107	DataModel	JRDev.com/versioning	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	mkv2	development@test.com	mkv1
1a92f377-ea67-4d83-a1d0-5b257f924b06	1	2021-10-04 13:23:17.411148	2021-10-04 13:23:17.445478	DataModel	versioning.com	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
29223545-1165-4baf-be82-012ab50aadb6	1	2021-10-04 13:23:17.412754	2021-10-04 13:23:17.445745	DataModel	v1Versioning.com	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	mod1	development@test.com	jun1
795f4336-d210-4623-807b-81c14e0fedae	1	2021-10-04 13:23:17.413258	2021-10-04 13:23:17.446095	DataModel	v1Versioning.com	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	mdv1	development@test.com	mdk1
877466ba-ad27-4664-8d46-5d6a5d953263	1	2021-10-04 13:23:17.668696	2021-10-04 13:23:17.687846	DataModel	JRDev.com/versioning	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	abc3	development@test.com	abc2
a0922deb-5bb3-44a6-b2bc-a4072544d6ba	1	2021-10-04 13:23:17.670065	2021-10-04 13:23:17.688923	DataModel	JRDev.com/versioning	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	mkv2	development@test.com	mkv1
dd0d12bd-4275-45c3-bd78-f8a08bd85427	1	2021-10-04 13:23:17.670826	2021-10-04 13:23:17.689229	DataModel	v1Versioning.com	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	mdv1	development@test.com	mdk1
13001ff3-cffb-4c94-b725-26b5fa850b63	1	2021-10-04 13:23:17.670344	2021-10-04 13:23:17.689469	DataModel	versioning.com	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
5fc02f7e-4b83-40d3-8723-c9c127351c51	1	2021-10-04 13:23:17.670605	2021-10-04 13:23:17.689699	DataModel	v1Versioning.com	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	mod1	development@test.com	jun1
bf034686-a853-48b1-a561-c5815f04a1f4	1	2021-10-04 13:23:17.893879	2021-10-04 13:23:17.918771	DataModel	versioning.com	eb5a08e6-844e-47c1-a31f-160dd238c202	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
f495b2e0-a869-4b43-a39d-e67edd30808a	1	2021-10-04 13:23:17.892234	2021-10-04 13:23:17.919002	DataModel	JRDev.com/versioning	eb5a08e6-844e-47c1-a31f-160dd238c202	abc3	development@test.com	abc2
3acdda6e-661a-4d43-9802-a11ce101f4ba	1	2021-10-04 13:23:17.894374	2021-10-04 13:23:17.919218	DataModel	v1Versioning.com	eb5a08e6-844e-47c1-a31f-160dd238c202	mdv1	development@test.com	mdk1
4f2e62bf-8c2a-4a13-9dfc-d307823ef4ce	1	2021-10-04 13:23:17.893586	2021-10-04 13:23:17.919453	DataModel	JRDev.com/versioning	eb5a08e6-844e-47c1-a31f-160dd238c202	mkv2	development@test.com	mkv1
75c9b891-6e11-4208-a0bd-be602dd99f79	0	2021-10-04 13:23:17.938834	2021-10-04 13:23:17.938834	DataClass	versioning.com	2337c502-9095-4159-89ec-affc7f0e0535	mdv1	development@test.com	mdk1
9491aff7-b6c3-46db-98d1-3efb862d995b	2	2021-10-04 13:23:17.894136	2021-10-04 13:23:18.027991	DataModel	v1Versioning.com	eb5a08e6-844e-47c1-a31f-160dd238c202	modanother	development@test.com	jun1
8e1e08dd-b3f0-47d4-9621-7b61bf38b07e	1	2021-10-04 13:23:18.260564	2021-10-04 13:23:18.288643	DataModel	v1Versioning.com	4b01f763-2505-46a2-938b-88622ca2eaa8	mod1	development@test.com	jun1
bf59da9b-727b-464f-8b5a-37ed47d05745	1	2021-10-04 13:23:18.259887	2021-10-04 13:23:18.289604	DataModel	JRDev.com/versioning	4b01f763-2505-46a2-938b-88622ca2eaa8	mkv2	development@test.com	mkv1
e4d147e7-a6af-4c28-b6b8-da6b79828076	1	2021-10-04 13:23:18.260287	2021-10-04 13:23:18.290036	DataModel	versioning.com	4b01f763-2505-46a2-938b-88622ca2eaa8	/- anotherFork\nv1 --------------------------- v2 -- v3  -- v4 --------------- v5 --- main\n  \\\\_ newBranch (v1)                  \\_ testBranch (v3)          \\__ anotherBranch (v5)\n   \\_ fork ---- main                                               \\_ interestingBranch (v5)	development@test.com	map
55a72cef-6f57-4552-8b5f-380ad96ceb19	1	2021-10-04 13:23:18.26078	2021-10-04 13:23:18.290382	DataModel	v1Versioning.com	4b01f763-2505-46a2-938b-88622ca2eaa8	mdv1	development@test.com	mdk1
5703367e-3403-41d2-8ad7-064077ce51c2	1	2021-10-04 13:23:18.257869	2021-10-04 13:23:18.290708	DataModel	JRDev.com/versioning	4b01f763-2505-46a2-938b-88622ca2eaa8	abc3	development@test.com	abc2
19ee3174-0aa8-4e15-8886-5de4bfce07f6	0	2021-10-04 13:23:19.700522	2021-10-04 13:23:19.700522	Terminology	terminology.test.com/simple	fa8b47d9-daae-4d61-a682-2a93a893c6ca	mdv1	development@test.com	mdk1
61c8b4e1-4d44-4c69-b0b8-678a19e90dd1	0	2021-10-04 13:23:19.703726	2021-10-04 13:23:19.703726	Terminology	terminology.test.com	fa8b47d9-daae-4d61-a682-2a93a893c6ca	mdv2	development@test.com	mdk2
089fecf1-dc7d-430f-9099-1ab4d71a06e0	0	2021-10-04 13:23:19.703984	2021-10-04 13:23:19.703984	Terminology	terminology.test.com/simple	fa8b47d9-daae-4d61-a682-2a93a893c6ca	mdv2	development@test.com	mdk2
41c4a90a-1a3c-4f5b-a498-8666a808ec84	0	2021-10-04 13:23:20.472675	2021-10-04 13:23:20.472675	Terminology	terminology.test.com/simple	3b623de2-7811-443d-b403-f06981264881	mdv1	development@test.com	mdk1
3e8ac82e-db36-4496-b40c-f9fa48a289de	0	2021-10-04 13:23:20.47331	2021-10-04 13:23:20.47331	Terminology	terminology.test.com	3b623de2-7811-443d-b403-f06981264881	mdv2	development@test.com	mdk2
632dcf0c-811d-4ca8-8628-70d74c96da00	0	2021-10-04 13:23:20.473513	2021-10-04 13:23:20.473513	Terminology	terminology.test.com/simple	3b623de2-7811-443d-b403-f06981264881	mdv2	development@test.com	mdk2
f453d880-1745-42f7-b122-d5a5874805a9	0	2021-10-04 13:23:20.698147	2021-10-04 13:23:20.698147	ReferenceDataModel	referencedata.com	e309016a-b128-4282-afaa-37cdb8d88193	mdv1	development@test.com	mdk1
dd4846d3-420f-42e7-8c38-5080d69ba94b	0	2021-10-04 13:23:20.699588	2021-10-04 13:23:20.699588	ReferenceDataModel	referencedata.com	e309016a-b128-4282-afaa-37cdb8d88193	mdv2	development@test.com	mdk2
20b0008b-1a16-4446-8aa5-e19dd9f51110	0	2021-10-04 13:23:20.699868	2021-10-04 13:23:20.699868	ReferenceDataModel	referencedata.com	e309016a-b128-4282-afaa-37cdb8d88193	mdv3	development@test.com	mdk3
\.


--
-- Data for Name: reference_file; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.reference_file (id, version, file_size, date_created, last_updated, multi_facet_aware_item_domain_type, file_type, file_name, file_contents, multi_facet_aware_item_id, created_by) FROM stdin;
\.


--
-- Data for Name: rule; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.rule (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, name, created_by, description) FROM stdin;
c58caf40-c1c2-4aae-a430-2134bdcda361	0	2021-10-04 13:23:13.628465	2021-10-04 13:23:13.628465	DataModel	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
a8306ad2-70a0-4187-b295-b495b1e967cc	0	2021-10-04 13:23:13.62942	2021-10-04 13:23:13.62942	DataClass	ae701c79-ea4a-4e1f-be85-281f2e7281dd	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
2b17915c-7345-4dfe-a3df-cab0db321753	0	2021-10-04 13:23:13.629885	2021-10-04 13:23:13.629885	PrimitiveType	29f5ecf2-270f-4efe-b4a2-04095a88520d	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
431c98c4-a11e-4d07-9ca6-c1dc505ff76c	0	2021-10-04 13:23:13.789591	2021-10-04 13:23:13.789591	DataElement	6bf2400f-a673-422b-ab73-62b658f81b55	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
5be79e82-6d92-4efc-baa4-bb40fac04137	0	2021-10-04 13:23:14.237758	2021-10-04 13:23:14.237758	DataModel	6e73dcde-8ce7-4c45-b37d-0494e55394c9	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
e8e8bc76-4a20-4f9c-88df-b37279d168a0	0	2021-10-04 13:23:14.238456	2021-10-04 13:23:14.238456	DataModel	6e73dcde-8ce7-4c45-b37d-0494e55394c9	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
875fa51c-4305-4a9b-9c80-9fc127150c20	1	2021-10-04 13:23:14.788992	2021-10-04 13:23:14.825685	DataModel	926d5e0c-5ee5-457f-9335-3e97d02c08b2	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
338ce243-ad77-465c-9e57-df5e6598917b	1	2021-10-04 13:23:14.789815	2021-10-04 13:23:14.827281	DataModel	926d5e0c-5ee5-457f-9335-3e97d02c08b2	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
150b08f5-9eba-42f4-8fbf-7db1efdc195e	1	2021-10-04 13:23:15.089705	2021-10-04 13:23:15.113911	DataModel	b3099f15-afde-436a-be99-1300eae98b4e	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
64332d45-f9fd-4656-a42f-c0469e05d3e6	1	2021-10-04 13:23:15.088813	2021-10-04 13:23:15.115043	DataModel	b3099f15-afde-436a-be99-1300eae98b4e	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
c12a3ba7-b923-4a18-b318-e19dec817a96	1	2021-10-04 13:23:15.281172	2021-10-04 13:23:15.311963	DataModel	c5c83da4-47de-44f2-a5fd-414ac1f13900	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
e508a3c2-ae04-45a4-93a9-7eb9257fa409	1	2021-10-04 13:23:15.28206	2021-10-04 13:23:15.312835	DataModel	c5c83da4-47de-44f2-a5fd-414ac1f13900	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
33cccfd0-a84b-4efd-af58-1306d5bbc4b4	1	2021-10-04 13:23:15.430785	2021-10-04 13:23:15.45813	DataModel	c5c83da4-47de-44f2-a5fd-414ac1f13900	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
6ea32e5e-7128-411b-bcb3-80c9b3cbbb6b	1	2021-10-04 13:23:15.891487	2021-10-04 13:23:15.910853	DataModel	c84fb099-79bc-496a-8901-75c99d539fbd	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
6ff5d01a-0b4f-4d8f-921d-ea3e9f5408e9	1	2021-10-04 13:23:15.892316	2021-10-04 13:23:15.918657	DataModel	c84fb099-79bc-496a-8901-75c99d539fbd	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
89f59767-2d34-48ed-ae3a-c1d80f90072d	1	2021-10-04 13:23:16.324823	2021-10-04 13:23:16.357005	DataModel	94f194ee-79db-4835-840e-4168bc4d9331	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
5dfb1584-381d-473a-b844-90af31ba9cad	1	2021-10-04 13:23:16.324545	2021-10-04 13:23:16.357969	DataModel	94f194ee-79db-4835-840e-4168bc4d9331	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
62510ec1-3184-437c-b10d-de0ca9ba46d8	1	2021-10-04 13:23:16.323693	2021-10-04 13:23:16.358241	DataModel	94f194ee-79db-4835-840e-4168bc4d9331	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
0e58e702-9c59-4d82-9f58-b9da583fd617	1	2021-10-04 13:23:16.630573	2021-10-04 13:23:16.667156	DataModel	726b5b98-4b02-433d-9e3b-249f139a27dc	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
704fc9ae-748a-40a7-b12e-b66a3c05de7b	1	2021-10-04 13:23:16.631683	2021-10-04 13:23:16.668145	DataModel	726b5b98-4b02-433d-9e3b-249f139a27dc	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
714add63-a0a2-4acb-9df5-adf47ccfe512	1	2021-10-04 13:23:16.632138	2021-10-04 13:23:16.668485	DataModel	726b5b98-4b02-433d-9e3b-249f139a27dc	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
8f6f9a90-0536-4392-aae6-40e6b6fefb47	1	2021-10-04 13:23:16.864473	2021-10-04 13:23:16.896957	DataModel	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
d40da83b-f7e3-4786-8e6a-b845a6477461	1	2021-10-04 13:23:16.863806	2021-10-04 13:23:16.897747	DataModel	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
1d093d94-b183-483a-b687-bf10992b2bca	1	2021-10-04 13:23:16.864746	2021-10-04 13:23:16.897989	DataModel	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
9328ea26-6724-496e-b564-d865c7317168	1	2021-10-04 13:23:17.200943	2021-10-04 13:23:17.231495	DataModel	9dd076ab-1240-474c-a3cb-5ef48863c208	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
c9dab8e7-fc62-4834-aa31-52f5e9c68274	1	2021-10-04 13:23:17.200575	2021-10-04 13:23:17.232276	DataModel	9dd076ab-1240-474c-a3cb-5ef48863c208	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
3fe4b21f-f2a4-4125-a1b9-d1b8dbdd4ec4	1	2021-10-04 13:23:17.199598	2021-10-04 13:23:17.232546	DataModel	9dd076ab-1240-474c-a3cb-5ef48863c208	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
dbb82045-5199-46f8-9834-2ba3a23312a4	1	2021-10-04 13:23:17.405856	2021-10-04 13:23:17.446455	DataModel	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
2b044300-b3d0-4001-adbf-5129decae356	1	2021-10-04 13:23:17.404981	2021-10-04 13:23:17.447487	DataModel	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
6a73bc56-247c-441a-94e4-48e4abb0a83f	1	2021-10-04 13:23:17.4062	2021-10-04 13:23:17.447792	DataModel	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
b18c9163-4db9-4a0d-9ce2-32efd4ed6dd9	1	2021-10-04 13:23:17.663243	2021-10-04 13:23:17.689923	DataModel	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
e997b366-bcce-401e-b9d0-a36349a26fd0	1	2021-10-04 13:23:17.662495	2021-10-04 13:23:17.690813	DataModel	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
f10f8038-3e67-4388-8c43-c5d46fbbbd4e	1	2021-10-04 13:23:17.663525	2021-10-04 13:23:17.691094	DataModel	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
b590f629-1b45-467b-b441-64fd9a580843	1	2021-10-04 13:23:17.886781	2021-10-04 13:23:17.919671	DataModel	eb5a08e6-844e-47c1-a31f-160dd238c202	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
dd2380b3-86b8-4ce4-b516-d00d351da64f	1	2021-10-04 13:23:17.887115	2021-10-04 13:23:17.920453	DataModel	eb5a08e6-844e-47c1-a31f-160dd238c202	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
5875ceb2-ae8b-4faf-b10b-a07e088e9f6d	1	2021-10-04 13:23:17.885895	2021-10-04 13:23:17.920698	DataModel	eb5a08e6-844e-47c1-a31f-160dd238c202	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
9ce3d14a-ef45-4019-a0a5-42ee0cfb5eb7	1	2021-10-04 13:23:18.249767	2021-10-04 13:23:18.291066	DataModel	4b01f763-2505-46a2-938b-88622ca2eaa8	Bootstrapped modify rule	development@test.com	Bootstrapped rule for modification
f6fc3751-8b8c-4ada-acb1-25daf34b717a	1	2021-10-04 13:23:18.251247	2021-10-04 13:23:18.292447	DataModel	4b01f763-2505-46a2-938b-88622ca2eaa8	Bootstrapped versioning Test Rule	development@test.com	versioning Model rule Description
0bef88c3-a70f-4df2-8105-5fbaa933d55c	1	2021-10-04 13:23:18.250807	2021-10-04 13:23:18.292955	DataModel	4b01f763-2505-46a2-938b-88622ca2eaa8	Bootstrapped versioning V2Model Rule	development@test.com	Modified this description
a0306048-3fcb-420a-b284-1d855b14ea0d	0	2021-10-04 13:23:19.178841	2021-10-04 13:23:19.178841	Terminology	fa8b47d9-daae-4d61-a682-2a93a893c6ca	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
385777b5-f35b-480c-b698-c33ed798d155	0	2021-10-04 13:23:20.2847	2021-10-04 13:23:20.2847	TermRelationshipType	86c63a69-3f33-401f-afe8-32dab264d1fb	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
021f56a1-1b48-45c1-bda4-39031b20f067	0	2021-10-04 13:23:20.285068	2021-10-04 13:23:20.285068	TermRelationship	bf27abdf-d9a2-4461-9854-6d0b7c3ad21b	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
62be9ce8-d9ae-43d1-9728-275624601853	0	2021-10-04 13:23:20.285286	2021-10-04 13:23:20.285286	Term	4c69bf94-0d9e-4309-88a7-ea8b47846c9b	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
1bde3b90-2c9e-424c-94a3-ebaf5cbe0ac3	0	2021-10-04 13:23:20.569002	2021-10-04 13:23:20.569002	CodeSet	692ace8b-5561-449d-8486-63ea44075ed4	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
e05de3ef-ee43-4845-b82c-6088dafdde4e	0	2021-10-04 13:23:21.051357	2021-10-04 13:23:21.051357	ReferenceDataModel	e309016a-b128-4282-afaa-37cdb8d88193	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
f42a9499-03b9-4848-838c-ff9301a23fad	0	2021-10-04 13:23:21.0518	2021-10-04 13:23:21.0518	ReferencePrimitiveType	58567a62-59c0-4cb6-af34-2961b0673bda	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
0df6a2f9-260a-4116-bc4f-8b500c34169e	0	2021-10-04 13:23:21.052101	2021-10-04 13:23:21.052101	ReferenceDataElement	39b2093f-f62d-46f7-b1be-b350ea89cfe3	Bootstrapped Functional Test Rule	development@test.com	Functional Test Description
\.


--
-- Data for Name: rule_representation; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.rule_representation (id, version, date_created, last_updated, rule_id, language, representation, created_by) FROM stdin;
\.


--
-- Data for Name: semantic_link; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.semantic_link (id, version, date_created, target_multi_facet_aware_item_id, last_updated, multi_facet_aware_item_domain_type, target_multi_facet_aware_item_domain_type, link_type, multi_facet_aware_item_id, created_by, unconfirmed) FROM stdin;
a1ea3244-3d67-4f38-8346-ce39f31f2f50	0	2021-10-04 13:23:13.871288	ae701c79-ea4a-4e1f-be85-281f2e7281dd	2021-10-04 13:23:13.871288	DataClass	DataClass	DOES_NOT_REFINE	83fba1d1-0d86-4178-9dbe-91b6554d2b70	development@test.com	f
53dbc354-d7dd-464d-8b49-b7321544588e	0	2021-10-04 13:23:14.791123	77e10ffc-d40c-4dda-82dd-7843f58e5d17	2021-10-04 13:23:14.791123	DataClass	DataClass	REFINES	\N	development@test.com	f
cdf50113-da93-49da-89d3-015aaac930c7	0	2021-10-04 13:23:14.791495	6efd3b15-ff7e-4ec5-9505-0712fa51eb39	2021-10-04 13:23:14.791495	DataClass	DataClass	REFINES	\N	development@test.com	f
7aa60882-3f5c-4458-b7be-0656103ffbd6	0	2021-10-04 13:23:14.791805	d1586984-9494-487e-a747-6a165fbc9e6a	2021-10-04 13:23:14.791805	DataElement	DataElement	REFINES	\N	development@test.com	f
fa8f3113-1bbe-4d12-b002-c54c6e4e7587	0	2021-10-04 13:23:14.792107	7b544cd7-a689-49d9-9e4a-318339a95d89	2021-10-04 13:23:14.792107	DataClass	DataClass	REFINES	\N	development@test.com	f
6cc6da08-0a17-4caf-a5c6-72f2d0267411	0	2021-10-04 13:23:14.792412	b2f25c3f-11ad-45de-88a6-a2bd80ece516	2021-10-04 13:23:14.792412	DataElement	DataElement	REFINES	\N	development@test.com	f
5f040d95-3a25-4635-915c-949355596bb8	0	2021-10-04 13:23:14.792712	cf1ba70e-746a-4300-9409-2eb76d03aee4	2021-10-04 13:23:14.792712	DataClass	DataClass	REFINES	\N	development@test.com	f
fcf220fb-c93e-4254-899c-7dd9027214c0	0	2021-10-04 13:23:14.793013	7e125a13-1332-4fcc-bb6e-6fe81759a936	2021-10-04 13:23:14.793013	DataElement	DataElement	REFINES	\N	development@test.com	f
6a3bf799-8a78-4a19-9d26-16a3f573f36d	0	2021-10-04 13:23:14.793317	f76409c4-0760-4f75-bf72-edae0a4a7995	2021-10-04 13:23:14.793317	DataElement	DataElement	REFINES	\N	development@test.com	f
14d74a2e-94ba-4c0d-b0d5-74e2e1709312	0	2021-10-04 13:23:14.793622	cace8c8b-048d-4158-b532-40198892fee4	2021-10-04 13:23:14.793622	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
d7b87226-e6c5-4e2f-a981-8de1d6f4afbb	1	2021-10-04 13:23:14.790236	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:14.827662	DataModel	DataModel	REFINES	926d5e0c-5ee5-457f-9335-3e97d02c08b2	development@test.com	f
5f564858-abf1-4132-8be5-43362b7f0202	0	2021-10-04 13:23:15.091108	52fccb51-0cb1-477a-8047-04ce51c7f643	2021-10-04 13:23:15.091108	DataClass	DataClass	REFINES	\N	development@test.com	f
cc1aae67-5e66-444a-abdf-7aa18354a16f	0	2021-10-04 13:23:15.091426	f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2	2021-10-04 13:23:15.091426	DataClass	DataClass	REFINES	\N	development@test.com	f
5f4a31fa-be88-4e94-929a-e94c21ef73ea	0	2021-10-04 13:23:15.091712	76d51770-c7f7-44e5-bf40-281dac1f4bfd	2021-10-04 13:23:15.091712	DataElement	DataElement	REFINES	\N	development@test.com	f
c3b9a0b5-1a04-4db0-b997-c46e7a8b07e9	0	2021-10-04 13:23:15.092004	059983db-5a11-4aa6-b910-e736e8303008	2021-10-04 13:23:15.092004	DataClass	DataClass	REFINES	\N	development@test.com	f
c0622187-f0e3-4b2c-b2ed-ff7fd3f71884	0	2021-10-04 13:23:15.092291	1249f4b2-2375-4b5f-82fb-439a11f8c740	2021-10-04 13:23:15.092291	DataElement	DataElement	REFINES	\N	development@test.com	f
45b23945-f1e7-4e8e-aae1-350468ebf8d1	0	2021-10-04 13:23:15.092576	81ea24dc-03de-4e25-8649-9778c6f53055	2021-10-04 13:23:15.092576	DataClass	DataClass	REFINES	\N	development@test.com	f
7e917a6d-b9e7-4af4-92b2-74ae7a870d14	0	2021-10-04 13:23:15.092862	3beb7b0c-e257-4d8b-af26-8c5e903ba2fc	2021-10-04 13:23:15.092862	DataElement	DataElement	REFINES	\N	development@test.com	f
7af6efb7-3253-4137-b955-44c8c442b9d7	0	2021-10-04 13:23:15.093145	e69b07fa-9bbe-4f97-bbfa-c74d2dee68d2	2021-10-04 13:23:15.093145	DataElement	DataElement	REFINES	\N	development@test.com	f
61077dab-791c-4a4e-9a61-5ae646a1f527	0	2021-10-04 13:23:15.093434	f4740512-2cbd-4ad7-9ebb-ed6e7874fefe	2021-10-04 13:23:15.093434	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
81e36ef9-0a58-4ccb-bcc7-1327e5e72205	1	2021-10-04 13:23:15.090058	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:15.115407	DataModel	DataModel	REFINES	b3099f15-afde-436a-be99-1300eae98b4e	development@test.com	t
15d625f4-a671-4377-9e2b-11ccb1570521	1	2021-10-04 13:23:15.090789	926d5e0c-5ee5-457f-9335-3e97d02c08b2	2021-10-04 13:23:15.116279	DataModel	DataModel	REFINES	b3099f15-afde-436a-be99-1300eae98b4e	development@test.com	f
40597532-dd16-4272-afd8-89ee494f3ee9	0	2021-10-04 13:23:15.283123	77e10ffc-d40c-4dda-82dd-7843f58e5d17	2021-10-04 13:23:15.283123	DataClass	DataClass	REFINES	\N	development@test.com	f
ef2b6f06-8c73-4398-83ca-ab5dd9aa78bc	0	2021-10-04 13:23:15.283421	6efd3b15-ff7e-4ec5-9505-0712fa51eb39	2021-10-04 13:23:15.283421	DataClass	DataClass	REFINES	\N	development@test.com	f
307b6513-aba0-4bc9-a821-2b4bf71f8c0f	0	2021-10-04 13:23:15.283702	d1586984-9494-487e-a747-6a165fbc9e6a	2021-10-04 13:23:15.283702	DataElement	DataElement	REFINES	\N	development@test.com	f
7cecab12-cd7b-4a19-92ab-9aab6b42af52	0	2021-10-04 13:23:15.284535	cf1ba70e-746a-4300-9409-2eb76d03aee4	2021-10-04 13:23:15.284535	DataClass	DataClass	REFINES	\N	development@test.com	f
51255426-ca4f-4ab1-8708-bd211d22291b	0	2021-10-04 13:23:15.284804	7e125a13-1332-4fcc-bb6e-6fe81759a936	2021-10-04 13:23:15.284804	DataElement	DataElement	REFINES	\N	development@test.com	f
5405c059-f465-4be8-a479-57521d7085c9	0	2021-10-04 13:23:15.285357	cace8c8b-048d-4158-b532-40198892fee4	2021-10-04 13:23:15.285357	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
c6fcf55c-81e8-4593-abec-7817093e71f9	1	2021-10-04 13:23:15.282426	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:15.313137	DataModel	DataModel	REFINES	c5c83da4-47de-44f2-a5fd-414ac1f13900	development@test.com	f
0b53bc74-9bd1-48eb-81af-2efd48392371	0	2021-10-04 13:23:15.893291	77e10ffc-d40c-4dda-82dd-7843f58e5d17	2021-10-04 13:23:15.893291	DataClass	DataClass	REFINES	\N	development@test.com	f
cea5125e-0bc1-431e-b1a8-65ad49ed149d	0	2021-10-04 13:23:15.893648	6efd3b15-ff7e-4ec5-9505-0712fa51eb39	2021-10-04 13:23:15.893648	DataClass	DataClass	REFINES	\N	development@test.com	f
d2294332-93bb-454e-a8e6-e4570b1329ef	0	2021-10-04 13:23:15.893944	d1586984-9494-487e-a747-6a165fbc9e6a	2021-10-04 13:23:15.893944	DataElement	DataElement	REFINES	\N	development@test.com	f
893a8cd7-89ca-4e30-ab51-c97cd82d2a62	0	2021-10-04 13:23:15.894201	7b544cd7-a689-49d9-9e4a-318339a95d89	2021-10-04 13:23:15.894201	DataClass	DataClass	REFINES	\N	development@test.com	f
45f5ef00-c2eb-4bdc-b872-fa0a932b0051	0	2021-10-04 13:23:15.894458	b2f25c3f-11ad-45de-88a6-a2bd80ece516	2021-10-04 13:23:15.894458	DataElement	DataElement	REFINES	\N	development@test.com	f
f163abd6-04c7-44dc-8d3d-07fc3942bc48	0	2021-10-04 13:23:15.894721	cf1ba70e-746a-4300-9409-2eb76d03aee4	2021-10-04 13:23:15.894721	DataClass	DataClass	REFINES	\N	development@test.com	f
cc3710cb-c7da-4d38-aebd-2c3232decff2	0	2021-10-04 13:23:15.894982	7e125a13-1332-4fcc-bb6e-6fe81759a936	2021-10-04 13:23:15.894982	DataElement	DataElement	REFINES	\N	development@test.com	f
b15802f6-958c-4a26-8386-ff63bea31416	0	2021-10-04 13:23:15.895234	f76409c4-0760-4f75-bf72-edae0a4a7995	2021-10-04 13:23:15.895234	DataElement	DataElement	REFINES	\N	development@test.com	f
8289e006-10e6-4d42-96a2-c6551e9f5e47	0	2021-10-04 13:23:15.895493	cace8c8b-048d-4158-b532-40198892fee4	2021-10-04 13:23:15.895493	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
49df86e9-23d3-41c0-b2b6-35daa8030fd6	1	2021-10-04 13:23:15.892653	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:15.919023	DataModel	DataModel	REFINES	c84fb099-79bc-496a-8901-75c99d539fbd	development@test.com	f
b0b90211-1479-45b5-9707-4367555b75e6	0	2021-10-04 13:23:16.325935	5abb9deb-b2f1-4e7b-ac60-6fc576131858	2021-10-04 13:23:16.325935	DataClass	DataClass	REFINES	\N	development@test.com	f
557b2f2e-d966-4ad1-85fe-9ba0142cc85c	0	2021-10-04 13:23:16.326188	b0808edb-75a9-4204-baca-3af4fe2ba053	2021-10-04 13:23:16.326188	DataClass	DataClass	REFINES	\N	development@test.com	f
d8655cd1-80fd-41bd-95cd-2f2b199e1449	0	2021-10-04 13:23:16.326441	27d9fd52-c55b-485e-a9ab-78b381b4b593	2021-10-04 13:23:16.326441	DataElement	DataElement	REFINES	\N	development@test.com	f
eb2e8eca-ed06-4e0b-8038-d6188acdb0eb	0	2021-10-04 13:23:16.326668	2211dfeb-5b7c-4022-923a-fb4e205a8bbc	2021-10-04 13:23:16.326668	DataClass	DataClass	REFINES	\N	development@test.com	f
79762f83-31ca-4df7-b0a4-1a89b593be3a	0	2021-10-04 13:23:16.326913	125027e4-d56f-4c44-9afc-d6043aef4e88	2021-10-04 13:23:16.326913	DataElement	DataElement	REFINES	\N	development@test.com	f
5220ffaa-aefb-459b-8242-32f078e26d29	0	2021-10-04 13:23:16.327178	d0011e3b-6137-4b62-b193-6b07db935308	2021-10-04 13:23:16.327178	DataClass	DataClass	REFINES	\N	development@test.com	f
8796fddd-10b4-4e2d-af92-81b3a93687a0	0	2021-10-04 13:23:16.327417	ed7afe51-ccf7-448b-9716-a0d06fe14701	2021-10-04 13:23:16.327417	DataClass	DataClass	REFINES	\N	development@test.com	f
92586f74-b88b-413d-95dc-2a1fbe440335	0	2021-10-04 13:23:16.327657	a32022f4-a429-41fa-9d4d-0581a925a6a9	2021-10-04 13:23:16.327657	DataElement	DataElement	REFINES	\N	development@test.com	f
dc89366f-88bd-4507-8f93-333116f999c8	0	2021-10-04 13:23:16.327892	acfcf44f-468e-49c4-be43-c420adea68b4	2021-10-04 13:23:16.327892	DataElement	DataElement	REFINES	\N	development@test.com	f
782b5cf0-d7b4-4b79-a84f-b6f93e04d673	0	2021-10-04 13:23:16.328131	6a2412f3-29d1-4bee-aa3a-1f8d1fa836ae	2021-10-04 13:23:16.328131	DataElement	DataElement	REFINES	\N	development@test.com	f
5630a610-3f94-499c-8d0b-070962e93fb5	0	2021-10-04 13:23:16.328369	91ff3163-6a80-4e19-8ce2-172bb446ce15	2021-10-04 13:23:16.328369	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
ec20997f-de22-4ed3-a4fd-46654252b6f6	0	2021-10-04 13:23:16.328611	1e2be421-1894-4297-a557-3ae7e40fea96	2021-10-04 13:23:16.328611	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
cd19ef57-0ca8-4e43-bef4-5f15e81250ee	0	2021-10-04 13:23:16.328847	0f4824f3-305c-4b2b-9533-9c9a3425aa4e	2021-10-04 13:23:16.328847	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
a99d7857-7d86-4702-9dee-19b6f47cf88c	0	2021-10-04 13:23:16.329086	0ef863c6-a0b2-4cc0-b9ab-014a5114f108	2021-10-04 13:23:16.329086	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
802f093b-0349-4bd1-b584-67537f9909dc	1	2021-10-04 13:23:16.325685	c5c83da4-47de-44f2-a5fd-414ac1f13900	2021-10-04 13:23:16.358546	DataModel	DataModel	REFINES	94f194ee-79db-4835-840e-4168bc4d9331	development@test.com	f
25ec0d87-ea2c-43c2-9d83-71fa4901cc4a	1	2021-10-04 13:23:16.325085	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:16.359368	DataModel	DataModel	REFINES	94f194ee-79db-4835-840e-4168bc4d9331	development@test.com	t
75da67af-214c-4f75-9553-03ae5b0549e8	0	2021-10-04 13:23:16.633903	01bc3883-ffae-4824-9044-7d1cd7719ec1	2021-10-04 13:23:16.633903	DataClass	DataClass	REFINES	\N	development@test.com	f
9ac5f285-0736-47dc-93ef-fd8018f23170	0	2021-10-04 13:23:16.634203	71d70845-8359-4e06-93f4-d31984cb31c3	2021-10-04 13:23:16.634203	DataClass	DataClass	REFINES	\N	development@test.com	f
91cdce2c-2570-4469-b8fa-bbfe3045e95a	0	2021-10-04 13:23:16.634491	ef1d9eda-1666-4102-8614-a20636c138c1	2021-10-04 13:23:16.634491	DataElement	DataElement	REFINES	\N	development@test.com	f
d1c15c48-48c1-4f63-9f44-b50ab15c8ccc	0	2021-10-04 13:23:16.634758	b0616a77-ed8b-4ff4-883a-9494a0e8e821	2021-10-04 13:23:16.634758	DataClass	DataClass	REFINES	\N	development@test.com	f
fd7df5fc-0e5b-4033-9af1-1017578b20ae	0	2021-10-04 13:23:16.635041	d6da4efc-eea5-4a83-8554-9f28c9137d0f	2021-10-04 13:23:16.635041	DataElement	DataElement	REFINES	\N	development@test.com	f
c6b07905-acf9-4289-9cb0-dd56e3d2d161	0	2021-10-04 13:23:16.635311	4f7b9a1e-4b81-43c1-af61-1061f6ddea54	2021-10-04 13:23:16.635311	DataClass	DataClass	REFINES	\N	development@test.com	f
9f57caae-fca4-4aa6-95d6-1b7554b35180	0	2021-10-04 13:23:16.635599	45122b94-5b79-4826-9afa-531042bba78a	2021-10-04 13:23:16.635599	DataClass	DataClass	REFINES	\N	development@test.com	f
4ade6266-363b-4a6b-98d7-79bc4f6cbe9a	0	2021-10-04 13:23:16.635879	34e1a169-59b0-48b0-a7ee-82811742e4a9	2021-10-04 13:23:16.635879	DataElement	DataElement	REFINES	\N	development@test.com	f
8c414258-8b66-4480-9f8a-a6188eaf79d8	0	2021-10-04 13:23:16.63616	c4893582-8316-4c72-b6cc-b9b3edf6de22	2021-10-04 13:23:16.63616	DataElement	DataElement	REFINES	\N	development@test.com	f
9e8c502b-c011-4d08-aa6a-4365d2534967	0	2021-10-04 13:23:16.636456	0faa2a77-0da9-45d4-a41d-18d7216b8b3b	2021-10-04 13:23:16.636456	DataElement	DataElement	REFINES	\N	development@test.com	f
f9368582-adc9-4c40-abfd-37e6fd79fb4f	0	2021-10-04 13:23:16.636749	30c1996b-46d8-44a8-9e9f-161df68a8d41	2021-10-04 13:23:16.636749	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
d4a5a27a-fedd-4e9a-9f65-389c1f1f6282	0	2021-10-04 13:23:16.637117	1c25775a-00bf-4221-91d4-5f644c764637	2021-10-04 13:23:16.637117	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
d89cc38c-b5c6-4543-a077-a936897d6005	0	2021-10-04 13:23:16.637407	dd2caaa3-67ad-49f5-80f8-bc6978351fb2	2021-10-04 13:23:16.637407	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
1b1b0bd8-44b5-41c5-b9dd-0f6d43b24c27	0	2021-10-04 13:23:16.637694	0d203b8d-8f47-432f-95da-535e8967328c	2021-10-04 13:23:16.637694	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
f05e9387-4ecd-4532-906c-1132edfc2993	1	2021-10-04 13:23:16.633223	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:16.668791	DataModel	DataModel	REFINES	726b5b98-4b02-433d-9e3b-249f139a27dc	development@test.com	t
f5b2a162-18c3-4f11-8361-0abd512c4ea6	1	2021-10-04 13:23:16.632465	c5c83da4-47de-44f2-a5fd-414ac1f13900	2021-10-04 13:23:16.669667	DataModel	DataModel	REFINES	726b5b98-4b02-433d-9e3b-249f139a27dc	development@test.com	t
5e8946fa-e044-4485-91ed-3c0b850e36b4	1	2021-10-04 13:23:16.633585	94f194ee-79db-4835-840e-4168bc4d9331	2021-10-04 13:23:16.670102	DataModel	DataModel	REFINES	726b5b98-4b02-433d-9e3b-249f139a27dc	development@test.com	f
0e4d9ece-ee99-4787-82b1-1cb8a3419190	0	2021-10-04 13:23:16.865975	01bc3883-ffae-4824-9044-7d1cd7719ec1	2021-10-04 13:23:16.865975	DataClass	DataClass	REFINES	\N	development@test.com	f
4e175fa3-4f84-48f6-9d39-a0a88e82b39b	0	2021-10-04 13:23:16.866195	71d70845-8359-4e06-93f4-d31984cb31c3	2021-10-04 13:23:16.866195	DataClass	DataClass	REFINES	\N	development@test.com	f
657a359e-8f8c-4571-b5ae-210b9401e5d5	0	2021-10-04 13:23:16.866417	ef1d9eda-1666-4102-8614-a20636c138c1	2021-10-04 13:23:16.866417	DataElement	DataElement	REFINES	\N	development@test.com	f
a2a7452e-edfe-4504-ab62-5cc6439597fb	0	2021-10-04 13:23:16.866637	b0616a77-ed8b-4ff4-883a-9494a0e8e821	2021-10-04 13:23:16.866637	DataClass	DataClass	REFINES	\N	development@test.com	f
c9d8ed55-dc27-4a7e-98cf-1503dd424a35	0	2021-10-04 13:23:16.866857	d6da4efc-eea5-4a83-8554-9f28c9137d0f	2021-10-04 13:23:16.866857	DataElement	DataElement	REFINES	\N	development@test.com	f
7231d6b8-f576-4a57-8817-cd1ba979c808	0	2021-10-04 13:23:16.867077	4f7b9a1e-4b81-43c1-af61-1061f6ddea54	2021-10-04 13:23:16.867077	DataClass	DataClass	REFINES	\N	development@test.com	f
21d1f364-3feb-4c28-9048-094b06ada155	0	2021-10-04 13:23:16.867296	45122b94-5b79-4826-9afa-531042bba78a	2021-10-04 13:23:16.867296	DataClass	DataClass	REFINES	\N	development@test.com	f
8c7da8e4-e20d-490c-bac0-2a9f19f519e7	0	2021-10-04 13:23:16.86752	34e1a169-59b0-48b0-a7ee-82811742e4a9	2021-10-04 13:23:16.86752	DataElement	DataElement	REFINES	\N	development@test.com	f
55c06c38-8b6d-419d-b624-0390946ba113	0	2021-10-04 13:23:16.86774	c4893582-8316-4c72-b6cc-b9b3edf6de22	2021-10-04 13:23:16.86774	DataElement	DataElement	REFINES	\N	development@test.com	f
c3ae91e9-5f66-451e-b742-1b09da6fd120	0	2021-10-04 13:23:16.867957	0faa2a77-0da9-45d4-a41d-18d7216b8b3b	2021-10-04 13:23:16.867957	DataElement	DataElement	REFINES	\N	development@test.com	f
1bea4934-8554-45e6-8b92-e9995ff124ca	0	2021-10-04 13:23:16.86818	30c1996b-46d8-44a8-9e9f-161df68a8d41	2021-10-04 13:23:16.86818	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
84b1726b-e51e-4637-92b8-912423ce52e7	0	2021-10-04 13:23:16.8684	1c25775a-00bf-4221-91d4-5f644c764637	2021-10-04 13:23:16.8684	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
5b46cf70-7c15-4b7a-ae80-07ffc7decfee	0	2021-10-04 13:23:16.868619	dd2caaa3-67ad-49f5-80f8-bc6978351fb2	2021-10-04 13:23:16.868619	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
6466f2da-7b0f-4cb5-b5e9-7cc4c48c9f2e	0	2021-10-04 13:23:16.868838	0d203b8d-8f47-432f-95da-535e8967328c	2021-10-04 13:23:16.868838	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
a604ef58-32b5-44c8-b8f7-a82e887e8ebb	1	2021-10-04 13:23:16.864987	c5c83da4-47de-44f2-a5fd-414ac1f13900	2021-10-04 13:23:16.898217	DataModel	DataModel	REFINES	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	development@test.com	t
ba0bc158-8e1d-4744-be7f-c302fb217190	1	2021-10-04 13:23:16.865532	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:16.89881	DataModel	DataModel	REFINES	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	development@test.com	t
174a6233-05d6-4b21-be1c-e8e8a82b09ce	1	2021-10-04 13:23:16.865761	94f194ee-79db-4835-840e-4168bc4d9331	2021-10-04 13:23:16.899056	DataModel	DataModel	REFINES	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	development@test.com	f
18b1c776-1b9d-4b1d-bd79-dd4c6b482101	0	2021-10-04 13:23:17.202974	46152471-14dd-42af-9fb7-75b804e4f7fa	2021-10-04 13:23:17.202974	DataClass	DataClass	REFINES	\N	development@test.com	f
ae357927-da7c-4461-8c1e-99eadeb791fe	0	2021-10-04 13:23:17.203206	c5b99d99-be9f-4639-ad03-feaeaed2188e	2021-10-04 13:23:17.203206	DataClass	DataClass	REFINES	\N	development@test.com	f
15398764-58ae-429f-b763-634654ef6296	0	2021-10-04 13:23:17.203429	5a843782-2bd3-48a9-ad1a-ca0b0534c0b0	2021-10-04 13:23:17.203429	DataElement	DataElement	REFINES	\N	development@test.com	f
7eca6db0-aa88-4ab1-85b6-051b457ffda3	0	2021-10-04 13:23:17.203648	efd359cc-066f-4c58-b1e4-53db8085d44e	2021-10-04 13:23:17.203648	DataClass	DataClass	REFINES	\N	development@test.com	f
5c51c4a2-3aa6-4836-9e10-8adc612b059f	0	2021-10-04 13:23:17.203878	1b80f6d8-8e4c-4611-85ce-f2bb134537ea	2021-10-04 13:23:17.203878	DataElement	DataElement	REFINES	\N	development@test.com	f
db3ef042-7866-4b10-a163-72c29da67005	0	2021-10-04 13:23:17.2041	5f2c57bc-4547-42e8-b777-7ee3e7f9715c	2021-10-04 13:23:17.2041	DataClass	DataClass	REFINES	\N	development@test.com	f
829190d6-a934-46a5-99e9-11e548ae6ddd	0	2021-10-04 13:23:17.204324	3ccdd107-b935-4a0c-91b6-5f10f03c46a6	2021-10-04 13:23:17.204324	DataClass	DataClass	REFINES	\N	development@test.com	f
c0f32ada-b97f-4264-a38b-663d51465db4	0	2021-10-04 13:23:17.204553	391a79f0-6728-4679-ab52-97d98ceb5fd4	2021-10-04 13:23:17.204553	DataElement	DataElement	REFINES	\N	development@test.com	f
24c159f0-fadf-4d0b-be7e-3dcf10ea8160	0	2021-10-04 13:23:17.20477	2663298a-f6fc-4c3e-a496-b3116a2cd986	2021-10-04 13:23:17.20477	DataElement	DataElement	REFINES	\N	development@test.com	f
2afdf853-65e3-4774-8061-9017623869f5	0	2021-10-04 13:23:17.20504	ae063f71-0c7b-4019-9741-0fb249d10826	2021-10-04 13:23:17.20504	DataElement	DataElement	REFINES	\N	development@test.com	f
c103e066-2e1b-484d-9acb-63142d8fc9e7	0	2021-10-04 13:23:17.205437	850a0c33-0121-43de-ae1c-e1ff5bab6f0a	2021-10-04 13:23:17.205437	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
d894e1dd-0e41-4633-b400-6f2aea67de25	0	2021-10-04 13:23:17.205692	debd425a-6c2f-41c2-918f-cf7bd81030bd	2021-10-04 13:23:17.205692	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
d1b97ace-27b7-46b9-9b1c-f4d5a940c73b	0	2021-10-04 13:23:17.205925	08ca0f68-87a1-474b-bffd-98c43c6fcc93	2021-10-04 13:23:17.205925	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
bbcd1541-7d92-454b-8898-92c9b563d3db	0	2021-10-04 13:23:17.206142	e7c6df2f-f1c5-4936-98e3-e06613890815	2021-10-04 13:23:17.206142	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
96ce500d-12e3-4ed3-a0c3-5aa1e2359bc8	1	2021-10-04 13:23:17.201203	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:17.232779	DataModel	DataModel	REFINES	9dd076ab-1240-474c-a3cb-5ef48863c208	development@test.com	t
b6c55227-543e-4f1c-86e8-72d777ed15f5	1	2021-10-04 13:23:17.20216	c5c83da4-47de-44f2-a5fd-414ac1f13900	2021-10-04 13:23:17.233422	DataModel	DataModel	REFINES	9dd076ab-1240-474c-a3cb-5ef48863c208	development@test.com	t
d66587a6-9328-4d90-b515-58a5eff6e568	1	2021-10-04 13:23:17.202752	726b5b98-4b02-433d-9e3b-249f139a27dc	2021-10-04 13:23:17.233681	DataModel	DataModel	REFINES	9dd076ab-1240-474c-a3cb-5ef48863c208	development@test.com	f
dcd28f8b-4295-47f0-8c27-0e15eeb166cb	1	2021-10-04 13:23:17.202494	94f194ee-79db-4835-840e-4168bc4d9331	2021-10-04 13:23:17.233912	DataModel	DataModel	REFINES	9dd076ab-1240-474c-a3cb-5ef48863c208	development@test.com	t
b84b3889-3f45-479e-9a62-db9afe3ee0e9	0	2021-10-04 13:23:17.407958	46152471-14dd-42af-9fb7-75b804e4f7fa	2021-10-04 13:23:17.407958	DataClass	DataClass	REFINES	\N	development@test.com	f
76fe25e3-73d9-475c-932d-b37da4368698	0	2021-10-04 13:23:17.40822	c5b99d99-be9f-4639-ad03-feaeaed2188e	2021-10-04 13:23:17.40822	DataClass	DataClass	REFINES	\N	development@test.com	f
60348809-69c9-45ea-ad18-a2ea51718f7e	0	2021-10-04 13:23:17.40848	5a843782-2bd3-48a9-ad1a-ca0b0534c0b0	2021-10-04 13:23:17.40848	DataElement	DataElement	REFINES	\N	development@test.com	f
f82d2d45-4f22-41ed-8410-a1010151e39f	0	2021-10-04 13:23:17.408732	efd359cc-066f-4c58-b1e4-53db8085d44e	2021-10-04 13:23:17.408732	DataClass	DataClass	REFINES	\N	development@test.com	f
68de1490-4a18-465b-bbbc-62bc017cc062	0	2021-10-04 13:23:17.408962	1b80f6d8-8e4c-4611-85ce-f2bb134537ea	2021-10-04 13:23:17.408962	DataElement	DataElement	REFINES	\N	development@test.com	f
f5f3d781-99ec-4a18-9984-c29811de6972	0	2021-10-04 13:23:17.40918	5f2c57bc-4547-42e8-b777-7ee3e7f9715c	2021-10-04 13:23:17.40918	DataClass	DataClass	REFINES	\N	development@test.com	f
4889601e-dab2-4c26-b479-df797d4f7309	0	2021-10-04 13:23:17.409406	3ccdd107-b935-4a0c-91b6-5f10f03c46a6	2021-10-04 13:23:17.409406	DataClass	DataClass	REFINES	\N	development@test.com	f
64f3cdb4-37df-4914-8d4b-b4411237b606	0	2021-10-04 13:23:17.40962	391a79f0-6728-4679-ab52-97d98ceb5fd4	2021-10-04 13:23:17.40962	DataElement	DataElement	REFINES	\N	development@test.com	f
f55c888b-4fde-4827-a4e4-03be5c728935	0	2021-10-04 13:23:17.409836	2663298a-f6fc-4c3e-a496-b3116a2cd986	2021-10-04 13:23:17.409836	DataElement	DataElement	REFINES	\N	development@test.com	f
228e87f3-e614-4f85-b739-1682e6b10b73	0	2021-10-04 13:23:17.410054	ae063f71-0c7b-4019-9741-0fb249d10826	2021-10-04 13:23:17.410054	DataElement	DataElement	REFINES	\N	development@test.com	f
f2c5ebc1-5b1e-4c53-b1e1-49772ea5ae92	0	2021-10-04 13:23:17.410272	850a0c33-0121-43de-ae1c-e1ff5bab6f0a	2021-10-04 13:23:17.410272	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
f7467e2e-baa8-4104-ae06-b6f304bfeff4	0	2021-10-04 13:23:17.410487	debd425a-6c2f-41c2-918f-cf7bd81030bd	2021-10-04 13:23:17.410487	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
be9389c5-c9ac-411c-a210-a317aaa73098	0	2021-10-04 13:23:17.410703	08ca0f68-87a1-474b-bffd-98c43c6fcc93	2021-10-04 13:23:17.410703	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
24cd76e8-dfdb-4dbf-a799-edae8850d06a	0	2021-10-04 13:23:17.410926	e7c6df2f-f1c5-4936-98e3-e06613890815	2021-10-04 13:23:17.410926	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
a5c82765-d9fa-4388-9361-5f24503ddc59	1	2021-10-04 13:23:17.407719	726b5b98-4b02-433d-9e3b-249f139a27dc	2021-10-04 13:23:17.448047	DataModel	DataModel	REFINES	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	development@test.com	f
d470cd56-24a1-4e39-9cd8-bc5fc3b26d65	1	2021-10-04 13:23:17.407174	c5c83da4-47de-44f2-a5fd-414ac1f13900	2021-10-04 13:23:17.448754	DataModel	DataModel	REFINES	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	development@test.com	t
31fe5de5-af3d-4e33-b8c6-0ec8502171d1	1	2021-10-04 13:23:17.406467	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:17.449049	DataModel	DataModel	REFINES	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	development@test.com	t
565aa080-6aea-4402-9230-05c45f183ba2	1	2021-10-04 13:23:17.407477	94f194ee-79db-4835-840e-4168bc4d9331	2021-10-04 13:23:17.449292	DataModel	DataModel	REFINES	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	development@test.com	t
050309f5-4cfe-44f0-986f-1c6762ddd9d3	0	2021-10-04 13:23:17.665397	4cc41c61-2ff7-4325-8289-5efd97dd789d	2021-10-04 13:23:17.665397	DataClass	DataClass	REFINES	\N	development@test.com	f
910979bf-f361-46e6-8525-21478e759cc2	0	2021-10-04 13:23:17.665635	11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e	2021-10-04 13:23:17.665635	DataClass	DataClass	REFINES	\N	development@test.com	f
1681acdc-2dd4-4805-aae3-3353d0888fa9	0	2021-10-04 13:23:17.665867	5e1731b0-241b-4e25-b1a9-244c85c67275	2021-10-04 13:23:17.665867	DataElement	DataElement	REFINES	\N	development@test.com	f
3ec59865-405c-4a13-a58e-43b8204a8358	0	2021-10-04 13:23:17.666126	8eef006c-8b01-48cc-9048-9d22aa47e7f5	2021-10-04 13:23:17.666126	DataClass	DataClass	REFINES	\N	development@test.com	f
9b17bc55-d644-4376-b7ed-8f06a1788f2f	0	2021-10-04 13:23:17.66644	24235cda-63d5-4c31-bdab-9d7e190b8d2f	2021-10-04 13:23:17.66644	DataElement	DataElement	REFINES	\N	development@test.com	f
12afb26b-9e84-4855-aa7a-3844413f9adc	0	2021-10-04 13:23:17.666726	953e8504-acce-452b-93ec-a9ab2817d26f	2021-10-04 13:23:17.666726	DataClass	DataClass	REFINES	\N	development@test.com	f
01a8286b-edfa-4b4e-9810-9d20ed5bcaa1	0	2021-10-04 13:23:17.666956	678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2021-10-04 13:23:17.666956	DataClass	DataClass	REFINES	\N	development@test.com	f
b4181dc6-d544-4f89-81a4-3b37ffed1883	0	2021-10-04 13:23:17.667177	0331172d-7a0b-4d77-ad29-9e09dee1c2be	2021-10-04 13:23:17.667177	DataElement	DataElement	REFINES	\N	development@test.com	f
daf6e9d4-2b0b-41c7-b498-44c1d86aad25	0	2021-10-04 13:23:17.667396	95d47600-574f-49fb-bdd6-fa47d6935536	2021-10-04 13:23:17.667396	DataElement	DataElement	REFINES	\N	development@test.com	f
1845d61c-fe4f-412c-90a3-b70d976ec13e	0	2021-10-04 13:23:17.667603	3a2a4dcd-3cb4-4bdf-8891-9723dab8b5af	2021-10-04 13:23:17.667603	DataElement	DataElement	REFINES	\N	development@test.com	f
81000bb0-882c-47c5-8d6b-3f2ca3142774	0	2021-10-04 13:23:17.667839	92585be7-eb1d-4331-9f8b-20277bc3a3fe	2021-10-04 13:23:17.667839	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
47785b0b-7d78-4c75-aa3a-7b53c7d286d6	0	2021-10-04 13:23:17.66806	0c313d45-1561-4e04-b881-9efc36ed3976	2021-10-04 13:23:17.66806	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
3942f818-c49b-473c-9ad5-c8de7763c8d8	0	2021-10-04 13:23:17.668269	614e12ea-d510-4320-9be4-372af71d5e47	2021-10-04 13:23:17.668269	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
2351e3a4-949f-471f-9187-6d326821e438	0	2021-10-04 13:23:17.66848	55d78ee3-5908-48a5-8656-820256047de3	2021-10-04 13:23:17.66848	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
af2250f7-6876-44ee-b355-d65f3d07cba0	1	2021-10-04 13:23:17.665176	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	2021-10-04 13:23:17.691347	DataModel	DataModel	REFINES	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	development@test.com	f
d4282984-930e-4162-ae3e-aa475cb991ee	1	2021-10-04 13:23:17.664712	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:17.692061	DataModel	DataModel	REFINES	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	development@test.com	t
e21a8efd-80b6-43a5-a82d-a0682acf06d6	1	2021-10-04 13:23:17.664433	c5c83da4-47de-44f2-a5fd-414ac1f13900	2021-10-04 13:23:17.692333	DataModel	DataModel	REFINES	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	development@test.com	t
f5a1acc9-de53-4f91-a9ad-930dc6dca9da	1	2021-10-04 13:23:17.664942	94f194ee-79db-4835-840e-4168bc4d9331	2021-10-04 13:23:17.692562	DataModel	DataModel	REFINES	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	development@test.com	t
042d02b8-1779-4d0c-af5a-b517a2e64f11	1	2021-10-04 13:23:17.66378	726b5b98-4b02-433d-9e3b-249f139a27dc	2021-10-04 13:23:17.692787	DataModel	DataModel	REFINES	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	development@test.com	t
f12573ae-b8a2-489d-9ec5-cc33b3bd21c4	0	2021-10-04 13:23:17.889167	4cc41c61-2ff7-4325-8289-5efd97dd789d	2021-10-04 13:23:17.889167	DataClass	DataClass	REFINES	\N	development@test.com	f
609f65b1-863f-44af-9d64-9d346dfea96d	0	2021-10-04 13:23:17.889384	11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e	2021-10-04 13:23:17.889384	DataClass	DataClass	REFINES	\N	development@test.com	f
ef50cc4f-2237-4ca3-892b-e79603005383	0	2021-10-04 13:23:17.889601	5e1731b0-241b-4e25-b1a9-244c85c67275	2021-10-04 13:23:17.889601	DataElement	DataElement	REFINES	\N	development@test.com	f
fd6b5c7d-03df-464b-914c-c1d605db1d79	0	2021-10-04 13:23:17.889811	8eef006c-8b01-48cc-9048-9d22aa47e7f5	2021-10-04 13:23:17.889811	DataClass	DataClass	REFINES	\N	development@test.com	f
7597d788-13a0-41a3-a992-66dd355a208c	0	2021-10-04 13:23:17.890027	24235cda-63d5-4c31-bdab-9d7e190b8d2f	2021-10-04 13:23:17.890027	DataElement	DataElement	REFINES	\N	development@test.com	f
8f877d1e-9d4b-46f8-9b1a-e930c5c82fa4	0	2021-10-04 13:23:17.890242	953e8504-acce-452b-93ec-a9ab2817d26f	2021-10-04 13:23:17.890242	DataClass	DataClass	REFINES	\N	development@test.com	f
fdd6028b-2a22-4dde-8ae6-7d070d6f383c	0	2021-10-04 13:23:17.890459	678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2021-10-04 13:23:17.890459	DataClass	DataClass	REFINES	\N	development@test.com	f
5c2a1c83-b46e-4f8f-8402-db993e61535b	0	2021-10-04 13:23:17.890668	0331172d-7a0b-4d77-ad29-9e09dee1c2be	2021-10-04 13:23:17.890668	DataElement	DataElement	REFINES	\N	development@test.com	f
64863631-0095-43a8-a3f7-17ae076e09af	0	2021-10-04 13:23:17.890884	95d47600-574f-49fb-bdd6-fa47d6935536	2021-10-04 13:23:17.890884	DataElement	DataElement	REFINES	\N	development@test.com	f
71f2afad-2046-4359-a03b-7d65b7b45371	0	2021-10-04 13:23:17.89111	3a2a4dcd-3cb4-4bdf-8891-9723dab8b5af	2021-10-04 13:23:17.89111	DataElement	DataElement	REFINES	\N	development@test.com	f
2b709f3f-aa0f-4ee8-bf56-4262883fc900	0	2021-10-04 13:23:17.891359	92585be7-eb1d-4331-9f8b-20277bc3a3fe	2021-10-04 13:23:17.891359	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
d6db0240-2241-4fed-b5ab-38c0eb570110	0	2021-10-04 13:23:17.891576	0c313d45-1561-4e04-b881-9efc36ed3976	2021-10-04 13:23:17.891576	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
719d16cc-e23a-4ae0-8f18-1ed739018478	0	2021-10-04 13:23:17.891807	614e12ea-d510-4320-9be4-372af71d5e47	2021-10-04 13:23:17.891807	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
456d8b76-0898-465a-83c6-98d53b333921	0	2021-10-04 13:23:17.892021	55d78ee3-5908-48a5-8656-820256047de3	2021-10-04 13:23:17.892021	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
dbb46931-823e-4c58-add3-192875169784	1	2021-10-04 13:23:17.887379	726b5b98-4b02-433d-9e3b-249f139a27dc	2021-10-04 13:23:17.920923	DataModel	DataModel	REFINES	eb5a08e6-844e-47c1-a31f-160dd238c202	development@test.com	t
edd551fd-9a11-4747-93b5-48768e3a2695	1	2021-10-04 13:23:17.888945	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	2021-10-04 13:23:17.921528	DataModel	DataModel	REFINES	eb5a08e6-844e-47c1-a31f-160dd238c202	development@test.com	f
f1bd1357-59b8-408b-aa82-a67922146ff6	1	2021-10-04 13:23:17.888075	c5c83da4-47de-44f2-a5fd-414ac1f13900	2021-10-04 13:23:17.92178	DataModel	DataModel	REFINES	eb5a08e6-844e-47c1-a31f-160dd238c202	development@test.com	t
2638d034-e592-4465-909b-d4681bd4bfab	1	2021-10-04 13:23:17.888725	94f194ee-79db-4835-840e-4168bc4d9331	2021-10-04 13:23:17.922002	DataModel	DataModel	REFINES	eb5a08e6-844e-47c1-a31f-160dd238c202	development@test.com	t
709f2b45-f0ee-459b-a74a-a260ab39880c	1	2021-10-04 13:23:17.888429	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:17.922216	DataModel	DataModel	REFINES	eb5a08e6-844e-47c1-a31f-160dd238c202	development@test.com	t
8dfbdd06-b077-4bab-8dd2-92ecc7a44f78	0	2021-10-04 13:23:18.253471	4cc41c61-2ff7-4325-8289-5efd97dd789d	2021-10-04 13:23:18.253471	DataClass	DataClass	REFINES	\N	development@test.com	f
67c50f74-f0e9-4a6f-bf87-16d5b0e10eee	0	2021-10-04 13:23:18.253733	11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e	2021-10-04 13:23:18.253733	DataClass	DataClass	REFINES	\N	development@test.com	f
1a69ad25-2349-4ffd-8c62-d6851074cf7a	0	2021-10-04 13:23:18.25399	5e1731b0-241b-4e25-b1a9-244c85c67275	2021-10-04 13:23:18.25399	DataElement	DataElement	REFINES	\N	development@test.com	f
31f4cb22-841f-4541-8fc1-4d44d5f062cc	0	2021-10-04 13:23:18.254251	8eef006c-8b01-48cc-9048-9d22aa47e7f5	2021-10-04 13:23:18.254251	DataClass	DataClass	REFINES	\N	development@test.com	f
f74dccc2-4e24-4129-998a-4dcd1f96e271	0	2021-10-04 13:23:18.254504	24235cda-63d5-4c31-bdab-9d7e190b8d2f	2021-10-04 13:23:18.254504	DataElement	DataElement	REFINES	\N	development@test.com	f
7c9a02e3-855f-4814-bb71-4214b74d60c4	0	2021-10-04 13:23:18.254765	953e8504-acce-452b-93ec-a9ab2817d26f	2021-10-04 13:23:18.254765	DataClass	DataClass	REFINES	\N	development@test.com	f
7c85877a-6d30-433e-a653-35d548161a19	0	2021-10-04 13:23:18.255037	678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2021-10-04 13:23:18.255037	DataClass	DataClass	REFINES	\N	development@test.com	f
483d899f-0154-488b-9991-24b4b07fbbd7	0	2021-10-04 13:23:18.25547	0331172d-7a0b-4d77-ad29-9e09dee1c2be	2021-10-04 13:23:18.25547	DataElement	DataElement	REFINES	\N	development@test.com	f
601b1191-e4d5-48f7-92e5-4562c0665b3e	0	2021-10-04 13:23:18.255829	95d47600-574f-49fb-bdd6-fa47d6935536	2021-10-04 13:23:18.255829	DataElement	DataElement	REFINES	\N	development@test.com	f
b4bca730-0274-44e5-aad3-c8dc1f53b6cb	0	2021-10-04 13:23:18.256177	3a2a4dcd-3cb4-4bdf-8891-9723dab8b5af	2021-10-04 13:23:18.256177	DataElement	DataElement	REFINES	\N	development@test.com	f
9d5e2548-a9bc-46b1-ba3c-459db4261f8f	0	2021-10-04 13:23:18.256518	92585be7-eb1d-4331-9f8b-20277bc3a3fe	2021-10-04 13:23:18.256518	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
ef9e017f-8ce5-41ea-95bd-23fc09333e05	0	2021-10-04 13:23:18.25685	0c313d45-1561-4e04-b881-9efc36ed3976	2021-10-04 13:23:18.25685	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
94c7e680-2a74-4cdd-8dfb-1656d8780ab6	0	2021-10-04 13:23:18.257193	614e12ea-d510-4320-9be4-372af71d5e47	2021-10-04 13:23:18.257193	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
ed7264cd-10f3-4161-972c-196fa187e351	0	2021-10-04 13:23:18.25752	55d78ee3-5908-48a5-8656-820256047de3	2021-10-04 13:23:18.25752	PrimitiveType	PrimitiveType	REFINES	\N	development@test.com	f
95e7e100-5e86-4670-adb9-da7228a74858	1	2021-10-04 13:23:18.253213	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	2021-10-04 13:23:18.293424	DataModel	DataModel	REFINES	4b01f763-2505-46a2-938b-88622ca2eaa8	development@test.com	f
ccb03051-f78e-4a24-b454-70bd9d061d7b	1	2021-10-04 13:23:18.252314	c5c83da4-47de-44f2-a5fd-414ac1f13900	2021-10-04 13:23:18.294619	DataModel	DataModel	REFINES	4b01f763-2505-46a2-938b-88622ca2eaa8	development@test.com	t
df8fd228-c681-46a8-b32f-e5bcb22d5fb0	1	2021-10-04 13:23:18.251557	726b5b98-4b02-433d-9e3b-249f139a27dc	2021-10-04 13:23:18.29512	DataModel	DataModel	REFINES	4b01f763-2505-46a2-938b-88622ca2eaa8	development@test.com	t
f18fda23-3213-4e67-a273-01389279072c	1	2021-10-04 13:23:18.252952	94f194ee-79db-4835-840e-4168bc4d9331	2021-10-04 13:23:18.295495	DataModel	DataModel	REFINES	4b01f763-2505-46a2-938b-88622ca2eaa8	development@test.com	t
1a370d17-982a-40cb-9e1e-b970675848dc	1	2021-10-04 13:23:18.252655	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2021-10-04 13:23:18.295846	DataModel	DataModel	REFINES	4b01f763-2505-46a2-938b-88622ca2eaa8	development@test.com	t
\.


--
-- Data for Name: user_image_file; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.user_image_file (id, version, file_size, date_created, last_updated, file_type, file_name, user_id, file_contents, created_by) FROM stdin;
\.


--
-- Data for Name: version_link; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.version_link (id, version, date_created, last_updated, multi_facet_aware_item_domain_type, target_model_domain_type, link_type, target_model_id, multi_facet_aware_item_id, created_by) FROM stdin;
6dbc0dd0-ddb5-4258-bf0c-504adc1a5a24	0	2021-10-04 13:23:14.798077	2021-10-04 13:23:14.798077	DataModel	DataModel	NEW_FORK_OF	6e73dcde-8ce7-4c45-b37d-0494e55394c9	926d5e0c-5ee5-457f-9335-3e97d02c08b2	development@test.com
d0cfc0e0-c04b-499e-9081-5465b607c0e8	0	2021-10-04 13:23:15.096525	2021-10-04 13:23:15.096525	DataModel	DataModel	NEW_MODEL_VERSION_OF	926d5e0c-5ee5-457f-9335-3e97d02c08b2	b3099f15-afde-436a-be99-1300eae98b4e	development@test.com
e1292937-c059-4707-82b3-74721776807a	0	2021-10-04 13:23:15.288287	2021-10-04 13:23:15.288287	DataModel	DataModel	NEW_MODEL_VERSION_OF	6e73dcde-8ce7-4c45-b37d-0494e55394c9	c5c83da4-47de-44f2-a5fd-414ac1f13900	development@test.com
4754cd24-f444-4cc8-8ce2-5481797b1456	0	2021-10-04 13:23:15.898111	2021-10-04 13:23:15.898111	DataModel	DataModel	NEW_MODEL_VERSION_OF	6e73dcde-8ce7-4c45-b37d-0494e55394c9	c84fb099-79bc-496a-8901-75c99d539fbd	development@test.com
21946412-88e2-4ef2-8bab-7b0adb30d3ac	0	2021-10-04 13:23:16.33265	2021-10-04 13:23:16.33265	DataModel	DataModel	NEW_MODEL_VERSION_OF	c5c83da4-47de-44f2-a5fd-414ac1f13900	94f194ee-79db-4835-840e-4168bc4d9331	development@test.com
3fddaf4c-db81-48a9-8d8c-bf89804978cd	0	2021-10-04 13:23:16.641758	2021-10-04 13:23:16.641758	DataModel	DataModel	NEW_MODEL_VERSION_OF	94f194ee-79db-4835-840e-4168bc4d9331	726b5b98-4b02-433d-9e3b-249f139a27dc	development@test.com
5be5d70a-d3d0-4b2a-936d-84691cc9c0bd	0	2021-10-04 13:23:16.871644	2021-10-04 13:23:16.871644	DataModel	DataModel	NEW_MODEL_VERSION_OF	94f194ee-79db-4835-840e-4168bc4d9331	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	development@test.com
d27a98a0-fc36-432d-ba4b-0b02910aa4a9	0	2021-10-04 13:23:17.20986	2021-10-04 13:23:17.20986	DataModel	DataModel	NEW_FORK_OF	726b5b98-4b02-433d-9e3b-249f139a27dc	9dd076ab-1240-474c-a3cb-5ef48863c208	development@test.com
7f48760b-ff24-4d7a-8318-19531cbb323c	0	2021-10-04 13:23:17.414216	2021-10-04 13:23:17.414216	DataModel	DataModel	NEW_MODEL_VERSION_OF	726b5b98-4b02-433d-9e3b-249f139a27dc	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	development@test.com
0c5ac257-90b2-470c-a8b6-3133a716d9a6	0	2021-10-04 13:23:17.671756	2021-10-04 13:23:17.671756	DataModel	DataModel	NEW_MODEL_VERSION_OF	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	development@test.com
ddd75564-2316-412e-b06a-c3b334683a4c	0	2021-10-04 13:23:17.895358	2021-10-04 13:23:17.895358	DataModel	DataModel	NEW_MODEL_VERSION_OF	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	eb5a08e6-844e-47c1-a31f-160dd238c202	development@test.com
dfc37d8e-3164-4f92-b4cb-bda4820c2902	0	2021-10-04 13:23:18.268085	2021-10-04 13:23:18.268085	DataModel	DataModel	NEW_MODEL_VERSION_OF	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	4b01f763-2505-46a2-938b-88622ca2eaa8	development@test.com
\.


--
-- Data for Name: data_class_component; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.data_class_component (id, version, date_created, data_flow_id, definition, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
904f76ac-1425-465a-9eae-bd3f1ca8523d	0	2021-10-04 13:23:19.031446	d6f8e215-4d23-4592-9ebb-c901619ff147	SELECT * \nINTO TargetFlowDataModel.tableD \nFROM SourceFlowDataModel.tableA	2021-10-04 13:23:19.031446	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147	2	3ba4f7f5-4a4e-4eeb-bf0b-de8b5a33293e	2147483647	development@test.com	\N	aToD	\N
1f75d2ef-6000-4489-836f-590ef32182e3	0	2021-10-04 13:23:19.039612	d6f8e215-4d23-4592-9ebb-c901619ff147	INSERT INTO TargetFlowDataModel.tableE\nSELECT  \n    b.columnE1                                      AS columnE,\n    b.columnF                                       AS columnR,\n    CONCAT(b.columnG,'_',c.columnJ)                 AS columnS,\n    CASE\n        WHEN b.columnH IS NULL THEN b.columnI\n        ELSE b.columnH\n    END                                             AS columnT,\n    TRIM(c.columnJ)                                 AS columnU,\n    CONCAT(c.columnL,' ',c.columnM,'--',b.columnG)  AS columnV\nFROM SourceFlowDataModel.tableB b\nINNER JOIN SourceFlowDataModel.tableC c ON b.columnE1 = c.columnE2	2021-10-04 13:23:19.039612	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147	2	b5977387-b06d-43dc-914d-9f4376b85297	2147483647	development@test.com	\N	bAndCToE	\N
\.


--
-- Data for Name: data_element_component; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.data_element_component (id, version, date_created, data_class_component_id, definition, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
899a39ed-6a17-464d-b31d-c1de23299ba6	0	2021-10-04 13:23:19.040782	904f76ac-1425-465a-9eae-bd3f1ca8523d	\N	2021-10-04 13:23:19.040782	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/904f76ac-1425-465a-9eae-bd3f1ca8523d	3	4e92dfc9-5c27-4e92-b88f-52687143e8e8	2147483647	development@test.com	\N	Direct Copy	\N
493a7bae-ee58-4336-a5a5-2b326f4aeccf	0	2021-10-04 13:23:19.042561	904f76ac-1425-465a-9eae-bd3f1ca8523d	\N	2021-10-04 13:23:19.042561	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/904f76ac-1425-465a-9eae-bd3f1ca8523d	3	42cf018f-95c4-4a9f-b111-8ad5a89756cf	2147483647	development@test.com	\N	Direct Copy	\N
1fdd5e5e-ec35-4596-b98a-d9adcdf5f069	0	2021-10-04 13:23:19.043201	904f76ac-1425-465a-9eae-bd3f1ca8523d	\N	2021-10-04 13:23:19.043201	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/904f76ac-1425-465a-9eae-bd3f1ca8523d	3	fef375d2-be1d-442d-a689-a5d62d0cdf46	2147483647	development@test.com	\N	Direct Copy	\N
2ea1a60d-0d7b-45ef-8f29-762275d68fee	0	2021-10-04 13:23:19.043773	904f76ac-1425-465a-9eae-bd3f1ca8523d	\N	2021-10-04 13:23:19.043773	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/904f76ac-1425-465a-9eae-bd3f1ca8523d	3	f46d2d3b-c932-43ec-84b0-7a58403ecca9	2147483647	development@test.com	\N	Direct Copy	\N
e0d045e7-71e0-46e9-a6cc-895279b5278a	0	2021-10-04 13:23:19.044296	1f75d2ef-6000-4489-836f-590ef32182e3	\N	2021-10-04 13:23:19.044296	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/1f75d2ef-6000-4489-836f-590ef32182e3	3	9ba5d224-2ee8-4926-8a11-c5e37f8c899d	2147483647	development@test.com	\N	JOIN KEY	\N
9d71b17b-85d5-4e37-b177-b9b93030bcf6	0	2021-10-04 13:23:19.044722	1f75d2ef-6000-4489-836f-590ef32182e3	\N	2021-10-04 13:23:19.044722	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/1f75d2ef-6000-4489-836f-590ef32182e3	3	fd41fee5-e30b-4584-9338-05822600d65c	2147483647	development@test.com	\N	Direct Copy	\N
be47c558-3532-4170-8ab8-075a783505aa	0	2021-10-04 13:23:19.045645	1f75d2ef-6000-4489-836f-590ef32182e3	CONCAT(b.columnG,'_',c.columnJ)	2021-10-04 13:23:19.045645	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/1f75d2ef-6000-4489-836f-590ef32182e3	3	036ecaa1-42d3-4853-9865-b614c17fb175	2147483647	development@test.com	\N	CONCAT	\N
de03e854-63d4-41f2-be30-56b3c51e4675	0	2021-10-04 13:23:19.046125	1f75d2ef-6000-4489-836f-590ef32182e3	CASE\n    WHEN b.columnH IS NULL THEN b.columnI\n    ELSE b.columnH\nEND	2021-10-04 13:23:19.046125	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/1f75d2ef-6000-4489-836f-590ef32182e3	3	b311047e-e450-4102-9546-019a1feaab43	2147483647	development@test.com	\N	CASE	\N
705700af-c2d5-4494-9f17-b9e4f8a83470	0	2021-10-04 13:23:19.046559	1f75d2ef-6000-4489-836f-590ef32182e3	\N	2021-10-04 13:23:19.046559	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/1f75d2ef-6000-4489-836f-590ef32182e3	3	78011503-f6c1-4434-a8f4-a9cfb36f9736	2147483647	development@test.com	\N	TRIM	\N
68dae507-4a46-451d-bb29-864f619d88ee	0	2021-10-04 13:23:19.047002	1f75d2ef-6000-4489-836f-590ef32182e3	CONCAT(c.columnL,' ',c.columnM,'--',b.columnG)	2021-10-04 13:23:19.047002	/b5dca58a-c401-4423-acd6-33d391b909c2/d6f8e215-4d23-4592-9ebb-c901619ff147/1f75d2ef-6000-4489-836f-590ef32182e3	3	59dd811c-7146-4c52-9868-a4b92fe35432	2147483647	development@test.com	\N	CONCAT	\N
\.


--
-- Data for Name: data_flow; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.data_flow (id, version, date_created, definition, diagram_layout, last_updated, path, depth, source_id, breadcrumb_tree_id, target_id, idx, created_by, aliases_string, label, description) FROM stdin;
d6f8e215-4d23-4592-9ebb-c901619ff147	1	2021-10-04 13:23:18.843425	\N	\N	2021-10-04 13:23:19.072563	/b5dca58a-c401-4423-acd6-33d391b909c2	1	bb3deab5-3b2e-418b-9bff-6bd62e49354d	39321a33-c577-42d4-93b9-2f63aaaf596a	b5dca58a-c401-4423-acd6-33d391b909c2	2147483647	development@test.com	\N	Sample DataFlow	\N
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.4.0	dataflow	SQL	V1_4_0__dataflow.sql	1607778436	maurodatamapper	2021-10-04 13:23:09.569825	96	t
2	1.15.4	add rule to dataflow	SQL	V1_15_4__add_rule_to_dataflow.sql	-73896718	maurodatamapper	2021-10-04 13:23:09.67044	5	t
\.


--
-- Data for Name: join_data_class_component_to_source_data_class; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.join_data_class_component_to_source_data_class (data_class_component_id, data_class_id) FROM stdin;
904f76ac-1425-465a-9eae-bd3f1ca8523d	b7dd4552-90b4-4cf5-879a-9438e00a1afd
1f75d2ef-6000-4489-836f-590ef32182e3	269ea29f-b6e2-4d61-a26e-bc08942d0f14
1f75d2ef-6000-4489-836f-590ef32182e3	b5d32e45-3bbc-4b41-a96b-75019b8d5773
\.


--
-- Data for Name: join_data_class_component_to_target_data_class; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.join_data_class_component_to_target_data_class (data_class_component_id, data_class_id) FROM stdin;
904f76ac-1425-465a-9eae-bd3f1ca8523d	0cbac9f2-d584-4473-9619-fa49740bf9e2
1f75d2ef-6000-4489-836f-590ef32182e3	1dec0232-e3fc-4a40-a76c-01cfe1c15e3b
\.


--
-- Data for Name: join_data_element_component_to_source_data_element; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.join_data_element_component_to_source_data_element (data_element_component_id, data_element_id) FROM stdin;
899a39ed-6a17-464d-b31d-c1de23299ba6	eb25c72b-cc39-4400-9039-12c78a4969be
9d71b17b-85d5-4e37-b177-b9b93030bcf6	90c6becd-592e-4da5-8aa5-20747d781eb7
be47c558-3532-4170-8ab8-075a783505aa	06807126-23a9-4c3e-b46c-5613da5df691
be47c558-3532-4170-8ab8-075a783505aa	d19e8097-6e04-4bb7-b20a-3ff595acfbe7
de03e854-63d4-41f2-be30-56b3c51e4675	7336d38b-7a77-4760-b4c7-ea072ca9635f
de03e854-63d4-41f2-be30-56b3c51e4675	f2f5d3b1-3512-4186-9c7e-7b858741b541
e0d045e7-71e0-46e9-a6cc-895279b5278a	064a4aec-3db8-4cf7-af1c-187d078781e0
e0d045e7-71e0-46e9-a6cc-895279b5278a	1972c66e-0d7f-4776-806b-eea305091f12
1fdd5e5e-ec35-4596-b98a-d9adcdf5f069	7c9c4778-4e09-4133-ac9c-d4518adee5b0
2ea1a60d-0d7b-45ef-8f29-762275d68fee	32f481fc-c11d-4a58-87d8-002bda10440c
493a7bae-ee58-4336-a5a5-2b326f4aeccf	fca598a4-fc87-4020-956e-bdbd2085e580
68dae507-4a46-451d-bb29-864f619d88ee	9eb5dd97-ae95-44d9-926c-d25f628a8be6
68dae507-4a46-451d-bb29-864f619d88ee	ec2c0cd5-b87e-4955-be7f-8020a7eae6ba
68dae507-4a46-451d-bb29-864f619d88ee	06807126-23a9-4c3e-b46c-5613da5df691
705700af-c2d5-4494-9f17-b9e4f8a83470	d19e8097-6e04-4bb7-b20a-3ff595acfbe7
\.


--
-- Data for Name: join_data_element_component_to_target_data_element; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.join_data_element_component_to_target_data_element (data_element_component_id, data_element_id) FROM stdin;
899a39ed-6a17-464d-b31d-c1de23299ba6	90f026a3-a2b5-48c4-a316-b08594a9e33a
9d71b17b-85d5-4e37-b177-b9b93030bcf6	52548ab2-7357-4783-9ae7-3d0a0df1fa7a
be47c558-3532-4170-8ab8-075a783505aa	7aeeaf13-2e6d-4492-ab8d-8d895270767b
de03e854-63d4-41f2-be30-56b3c51e4675	75e0517f-257f-4ef4-b40f-9bce70ca2435
e0d045e7-71e0-46e9-a6cc-895279b5278a	31636115-5edb-4034-a131-44c054d3c40d
1fdd5e5e-ec35-4596-b98a-d9adcdf5f069	e04dcbc9-0716-44ea-879d-bc0b93e40f2d
2ea1a60d-0d7b-45ef-8f29-762275d68fee	92334819-e343-4606-9291-9507305183c0
493a7bae-ee58-4336-a5a5-2b326f4aeccf	3dd5a3a2-fb16-4859-becc-a17ce1d30775
68dae507-4a46-451d-bb29-864f619d88ee	d1d64057-8bb1-4247-9a60-44cbc117893b
705700af-c2d5-4494-9f17-b9e4f8a83470	cd56c5e5-c19b-4084-a4b3-9a143fda562f
\.


--
-- Data for Name: join_dataclasscomponent_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.join_dataclasscomponent_to_facet (dataclasscomponent_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_dataelementcomponent_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.join_dataelementcomponent_to_facet (dataelementcomponent_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: join_dataflow_to_facet; Type: TABLE DATA; Schema: dataflow; Owner: -
--

COPY dataflow.join_dataflow_to_facet (dataflow_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: data_class; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.data_class (id, version, date_created, last_updated, path, depth, min_multiplicity, max_multiplicity, parent_data_class_id, breadcrumb_tree_id, data_model_id, idx, created_by, aliases_string, label, description) FROM stdin;
e514a0eb-0b16-40c9-926a-363d9ac23d8b	0	2021-10-04 13:23:13.548695	2021-10-04 13:23:13.548695	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	\N	\N	\N	6af0f078-725d-42b7-bce2-9aa2e640b4cf	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	development@test.com	\N	emptyclass	dataclass with desc
ae701c79-ea4a-4e1f-be85-281f2e7281dd	2	2021-10-04 13:23:13.552328	2021-10-04 13:23:13.743894	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	1	-1	\N	c892ca80-4707-43e4-82cf-84b4d4b6536d	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	development@test.com	\N	parent	\N
eb60ac95-5b35-4d6e-a01a-1b5b9a5d70c0	1	2021-10-04 13:23:13.553904	2021-10-04 13:23:13.748706	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5/ae701c79-ea4a-4e1f-be85-281f2e7281dd	2	\N	\N	ae701c79-ea4a-4e1f-be85-281f2e7281dd	7bbb9a9a-8c8e-4ede-8838-817badea05e2	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	0	development@test.com	\N	child	\N
83fba1d1-0d86-4178-9dbe-91b6554d2b70	1	2021-10-04 13:23:13.719262	2021-10-04 13:23:13.88998	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	0	1	\N	e253d5d8-7811-4d04-a42b-9d8937821415	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	2	development@test.com	\N	content	A dataclass with elements
68d946d6-a0da-4859-a4df-7c14c9831d38	1	2021-10-04 13:23:13.947921	2021-10-04 13:23:13.973532	/dc5e3bb9-9119-4540-a586-2f55380e49f4	1	\N	\N	\N	1e1de73f-46ad-4897-86dc-69699ac62e71	dc5e3bb9-9119-4540-a586-2f55380e49f4	0	development@test.com	\N	simple	\N
50ea6b13-9b75-4fbc-b611-747988ab0afb	0	2021-10-04 13:23:14.024948	2021-10-04 13:23:14.024948	/f9f834b7-74f5-4b0c-997a-044ac335a9f4	1	\N	\N	\N	43b9cf21-3137-4587-9375-2943d0893117	f9f834b7-74f5-4b0c-997a-044ac335a9f4	1	development@test.com	\N	Finalised Data Class	\N
913a731c-bfd9-4d82-8c59-224ca983a8cd	0	2021-10-04 13:23:14.027028	2021-10-04 13:23:14.027028	/f9f834b7-74f5-4b0c-997a-044ac335a9f4	1	\N	\N	\N	b5e6f595-97cd-4183-83a3-8f39ee05f45e	f9f834b7-74f5-4b0c-997a-044ac335a9f4	1	development@test.com	\N	Another Data Class	\N
6efd3b15-ff7e-4ec5-9505-0712fa51eb39	0	2021-10-04 13:23:14.176849	2021-10-04 13:23:14.176849	/6e73dcde-8ce7-4c45-b37d-0494e55394c9	1	\N	\N	\N	22942594-a102-4196-a76e-d78def304877	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2	development@test.com	\N	V1 Data Class	\N
7b544cd7-a689-49d9-9e4a-318339a95d89	0	2021-10-04 13:23:14.185728	2021-10-04 13:23:14.185728	/6e73dcde-8ce7-4c45-b37d-0494e55394c9/6efd3b15-ff7e-4ec5-9505-0712fa51eb39	2	\N	\N	6efd3b15-ff7e-4ec5-9505-0712fa51eb39	bae2cdab-0c1d-44cc-8a83-a610dd255479	6e73dcde-8ce7-4c45-b37d-0494e55394c9	0	development@test.com	\N	V1 Internal Data Class	\N
cf1ba70e-746a-4300-9409-2eb76d03aee4	0	2021-10-04 13:23:14.187045	2021-10-04 13:23:14.187045	/6e73dcde-8ce7-4c45-b37d-0494e55394c9	1	\N	\N	\N	23ff8b0f-a269-4bd7-a5ff-1ba43be7b56d	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2	development@test.com	\N	V1 Modify Data Class	\N
77e10ffc-d40c-4dda-82dd-7843f58e5d17	0	2021-10-04 13:23:14.188135	2021-10-04 13:23:14.188135	/6e73dcde-8ce7-4c45-b37d-0494e55394c9	1	\N	\N	\N	f1fb81c5-5152-445d-9c1d-6915c0d5e1be	6e73dcde-8ce7-4c45-b37d-0494e55394c9	2	development@test.com	\N	V1 Another Data Class	\N
52fccb51-0cb1-477a-8047-04ce51c7f643	0	2021-10-04 13:23:14.799282	2021-10-04 13:23:14.799282	/926d5e0c-5ee5-457f-9335-3e97d02c08b2	1	\N	\N	\N	788d1356-420e-49c7-af6e-573c51af7465	926d5e0c-5ee5-457f-9335-3e97d02c08b2	0	development@test.com	\N	V1 Another Data Class	\N
f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2	0	2021-10-04 13:23:14.808236	2021-10-04 13:23:14.808236	/926d5e0c-5ee5-457f-9335-3e97d02c08b2	1	\N	\N	\N	8f27c73f-b95b-444f-b5c9-0bc43474e654	926d5e0c-5ee5-457f-9335-3e97d02c08b2	1	development@test.com	\N	V1 Data Class	\N
059983db-5a11-4aa6-b910-e736e8303008	0	2021-10-04 13:23:14.809328	2021-10-04 13:23:14.809328	/926d5e0c-5ee5-457f-9335-3e97d02c08b2/f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2	2	\N	\N	f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2	2a363984-863b-40aa-9bec-9db185ecbbee	926d5e0c-5ee5-457f-9335-3e97d02c08b2	0	development@test.com	\N	V1 Internal Data Class	\N
81ea24dc-03de-4e25-8649-9778c6f53055	0	2021-10-04 13:23:14.810329	2021-10-04 13:23:14.810329	/926d5e0c-5ee5-457f-9335-3e97d02c08b2	1	\N	\N	\N	9c54eb88-34b6-4e17-99f9-1f551b0d8898	926d5e0c-5ee5-457f-9335-3e97d02c08b2	2	development@test.com	\N	V1 Modify Data Class	\N
72b25cd5-5294-43e1-b366-540d649412e1	0	2021-10-04 13:23:15.09722	2021-10-04 13:23:15.09722	/b3099f15-afde-436a-be99-1300eae98b4e	1	\N	\N	\N	f358d581-59df-4f1b-abd4-ead6d1536d4c	b3099f15-afde-436a-be99-1300eae98b4e	0	development@test.com	\N	V1 Another Data Class	\N
dd87ad23-df5a-4194-a2b0-9a0876c79ee4	0	2021-10-04 13:23:15.09929	2021-10-04 13:23:15.09929	/b3099f15-afde-436a-be99-1300eae98b4e	1	\N	\N	\N	591e19fc-82a1-47b0-b2dc-20b1cbe189af	b3099f15-afde-436a-be99-1300eae98b4e	1	development@test.com	\N	V1 Data Class	\N
f95847c0-c163-4ca7-be79-e26e309e454e	0	2021-10-04 13:23:15.100314	2021-10-04 13:23:15.100314	/b3099f15-afde-436a-be99-1300eae98b4e/dd87ad23-df5a-4194-a2b0-9a0876c79ee4	2	\N	\N	dd87ad23-df5a-4194-a2b0-9a0876c79ee4	9130ff88-9247-4061-bbde-4bff790302ad	b3099f15-afde-436a-be99-1300eae98b4e	0	development@test.com	\N	V1 Internal Data Class	\N
3627da01-784f-469e-b9d5-e043291c5ec9	0	2021-10-04 13:23:15.101195	2021-10-04 13:23:15.101195	/b3099f15-afde-436a-be99-1300eae98b4e	1	\N	\N	\N	900574ca-66fb-4db0-9930-ede8a366d0ae	b3099f15-afde-436a-be99-1300eae98b4e	2	development@test.com	\N	V1 Modify Data Class	\N
5abb9deb-b2f1-4e7b-ac60-6fc576131858	0	2021-10-04 13:23:15.288966	2021-10-04 13:23:15.288966	/c5c83da4-47de-44f2-a5fd-414ac1f13900	1	\N	\N	\N	6eda0ed0-1b00-4037-93e9-d65ad4e8f0eb	c5c83da4-47de-44f2-a5fd-414ac1f13900	0	development@test.com	\N	V1 Another Data Class	\N
ed7afe51-ccf7-448b-9716-a0d06fe14701	0	2021-10-04 13:23:15.371177	2021-10-04 13:23:15.371177	/c5c83da4-47de-44f2-a5fd-414ac1f13900	1	\N	\N	\N	cd06b2fc-d8a2-49ff-99c1-e6019e30ffad	c5c83da4-47de-44f2-a5fd-414ac1f13900	3	development@test.com	\N	V2 Data Class	\N
d0011e3b-6137-4b62-b193-6b07db935308	0	2021-10-04 13:23:15.583226	2021-10-04 13:23:15.583226	/c5c83da4-47de-44f2-a5fd-414ac1f13900/2211dfeb-5b7c-4022-923a-fb4e205a8bbc	2	\N	\N	2211dfeb-5b7c-4022-923a-fb4e205a8bbc	16744ab2-20ed-449e-9e4c-04f9a64cafe6	c5c83da4-47de-44f2-a5fd-414ac1f13900	0	development@test.com	\N	V1 Internal Data Class	\N
b0808edb-75a9-4204-baca-3af4fe2ba053	2	2021-10-04 13:23:15.290509	2021-10-04 13:23:15.592167	/c5c83da4-47de-44f2-a5fd-414ac1f13900	1	\N	\N	\N	577f6a17-502f-46b5-936a-9c0b902cd7e9	c5c83da4-47de-44f2-a5fd-414ac1f13900	1	development@test.com	\N	V1 Data Class	Modified this description for V2
2211dfeb-5b7c-4022-923a-fb4e205a8bbc	2	2021-10-04 13:23:15.292388	2021-10-04 13:23:15.59389	/c5c83da4-47de-44f2-a5fd-414ac1f13900	1	\N	\N	\N	c2d19833-327d-4f36-9a1c-840bed22ed50	c5c83da4-47de-44f2-a5fd-414ac1f13900	2	development@test.com	\N	V1 Modify Data Class	\N
ab2384cf-eafa-4693-ac91-9f155e0d0058	0	2021-10-04 13:23:15.898709	2021-10-04 13:23:15.898709	/c84fb099-79bc-496a-8901-75c99d539fbd	1	\N	\N	\N	24ca0fac-792a-4bf9-9cb8-2f3efddf1e76	c84fb099-79bc-496a-8901-75c99d539fbd	0	development@test.com	\N	V1 Another Data Class	\N
7bef5540-b2c5-4c5c-b2db-37053c270a75	0	2021-10-04 13:23:15.90009	2021-10-04 13:23:15.90009	/c84fb099-79bc-496a-8901-75c99d539fbd	1	\N	\N	\N	e06c05aa-9a41-466d-9fdf-9cd1e86f6177	c84fb099-79bc-496a-8901-75c99d539fbd	1	development@test.com	\N	V1 Data Class	\N
5826b473-352e-4bf3-bce2-2ff97be6c197	0	2021-10-04 13:23:15.900994	2021-10-04 13:23:15.900994	/c84fb099-79bc-496a-8901-75c99d539fbd/7bef5540-b2c5-4c5c-b2db-37053c270a75	2	\N	\N	7bef5540-b2c5-4c5c-b2db-37053c270a75	20a05053-4aa6-4bb1-aa63-c9f9510d46cd	c84fb099-79bc-496a-8901-75c99d539fbd	0	development@test.com	\N	V1 Internal Data Class	\N
e4656cb5-fe45-494f-8b83-46c1c397de23	0	2021-10-04 13:23:15.901784	2021-10-04 13:23:15.901784	/c84fb099-79bc-496a-8901-75c99d539fbd	1	\N	\N	\N	971487e8-28bc-48eb-a531-4820b4858aa9	c84fb099-79bc-496a-8901-75c99d539fbd	2	development@test.com	\N	V1 Modify Data Class	\N
97ed4f0a-611d-48a8-ac60-fcb2aaccf749	0	2021-10-04 13:23:15.967685	2021-10-04 13:23:15.967685	/c84fb099-79bc-496a-8901-75c99d539fbd	1	\N	\N	\N	4e146101-0000-495c-abd4-a0ef2be5373a	c84fb099-79bc-496a-8901-75c99d539fbd	3	development@test.com	\N	emptyVersioningClass	dataclass with desc
01bc3883-ffae-4824-9044-7d1cd7719ec1	0	2021-10-04 13:23:16.333233	2021-10-04 13:23:16.333233	/94f194ee-79db-4835-840e-4168bc4d9331	1	\N	\N	\N	cb6b5f0d-2bbc-4101-8138-f24319d996b8	94f194ee-79db-4835-840e-4168bc4d9331	0	development@test.com	\N	V1 Another Data Class	\N
71d70845-8359-4e06-93f4-d31984cb31c3	0	2021-10-04 13:23:16.334522	2021-10-04 13:23:16.334522	/94f194ee-79db-4835-840e-4168bc4d9331	1	\N	\N	\N	f9276cf1-f291-4886-9c73-cd5f582ef22f	94f194ee-79db-4835-840e-4168bc4d9331	1	development@test.com	\N	V1 Data Class	Modified this description for V2
b0616a77-ed8b-4ff4-883a-9494a0e8e821	0	2021-10-04 13:23:16.335296	2021-10-04 13:23:16.335296	/94f194ee-79db-4835-840e-4168bc4d9331	1	\N	\N	\N	467c20a1-68d6-47d9-9eeb-abcdf507b097	94f194ee-79db-4835-840e-4168bc4d9331	2	development@test.com	\N	V1 Modify Data Class	\N
4f7b9a1e-4b81-43c1-af61-1061f6ddea54	0	2021-10-04 13:23:16.335997	2021-10-04 13:23:16.335997	/94f194ee-79db-4835-840e-4168bc4d9331/b0616a77-ed8b-4ff4-883a-9494a0e8e821	2	\N	\N	b0616a77-ed8b-4ff4-883a-9494a0e8e821	5d80446e-693a-4296-996d-452b28d77f99	94f194ee-79db-4835-840e-4168bc4d9331	0	development@test.com	\N	V1 Internal Data Class	\N
45122b94-5b79-4826-9afa-531042bba78a	0	2021-10-04 13:23:16.33668	2021-10-04 13:23:16.33668	/94f194ee-79db-4835-840e-4168bc4d9331	1	\N	\N	\N	5a7dcec0-3aac-40db-8134-14c7dc91a944	94f194ee-79db-4835-840e-4168bc4d9331	3	development@test.com	\N	V2 Data Class	\N
46152471-14dd-42af-9fb7-75b804e4f7fa	0	2021-10-04 13:23:16.642495	2021-10-04 13:23:16.642495	/726b5b98-4b02-433d-9e3b-249f139a27dc	1	\N	\N	\N	7f727900-29e4-4bb9-930c-d70be4e18ab6	726b5b98-4b02-433d-9e3b-249f139a27dc	0	development@test.com	\N	V1 Another Data Class	\N
c5b99d99-be9f-4639-ad03-feaeaed2188e	0	2021-10-04 13:23:16.644109	2021-10-04 13:23:16.644109	/726b5b98-4b02-433d-9e3b-249f139a27dc	1	\N	\N	\N	7eaf926b-cb17-4e19-8616-b453f554a453	726b5b98-4b02-433d-9e3b-249f139a27dc	1	development@test.com	\N	V1 Data Class	Modified this description for V2
efd359cc-066f-4c58-b1e4-53db8085d44e	0	2021-10-04 13:23:16.645149	2021-10-04 13:23:16.645149	/726b5b98-4b02-433d-9e3b-249f139a27dc	1	\N	\N	\N	c948e194-d1e7-4b1b-a72a-800c60bdbad3	726b5b98-4b02-433d-9e3b-249f139a27dc	2	development@test.com	\N	V1 Modify Data Class	\N
5f2c57bc-4547-42e8-b777-7ee3e7f9715c	0	2021-10-04 13:23:16.646152	2021-10-04 13:23:16.646152	/726b5b98-4b02-433d-9e3b-249f139a27dc/efd359cc-066f-4c58-b1e4-53db8085d44e	2	\N	\N	efd359cc-066f-4c58-b1e4-53db8085d44e	1204419c-4dc7-4605-9504-b5cd1cf43f01	726b5b98-4b02-433d-9e3b-249f139a27dc	0	development@test.com	\N	V1 Internal Data Class	\N
3ccdd107-b935-4a0c-91b6-5f10f03c46a6	0	2021-10-04 13:23:16.647053	2021-10-04 13:23:16.647053	/726b5b98-4b02-433d-9e3b-249f139a27dc	1	\N	\N	\N	397f9af5-a7a9-4745-b3e9-523148c4861a	726b5b98-4b02-433d-9e3b-249f139a27dc	3	development@test.com	\N	V2 Data Class	\N
7141fcdc-88a4-4580-bfdf-dc32ed481b93	0	2021-10-04 13:23:16.872145	2021-10-04 13:23:16.872145	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	\N	\N	\N	837b1c91-89c8-4c9b-9639-69490d3dd531	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	0	development@test.com	\N	V1 Another Data Class	\N
a099fc92-d9ca-4fa1-a74c-63a788819f68	0	2021-10-04 13:23:16.87402	2021-10-04 13:23:16.87402	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	\N	\N	\N	89262994-c613-4bbf-bb17-e3c3b9641382	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	2	development@test.com	\N	V1 Modify Data Class	\N
70875f36-5b39-4d4d-b933-0dcd4e4f7f01	0	2021-10-04 13:23:16.874667	2021-10-04 13:23:16.874667	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02/a099fc92-d9ca-4fa1-a74c-63a788819f68	2	\N	\N	a099fc92-d9ca-4fa1-a74c-63a788819f68	ce9545ad-30cf-41b9-8c76-9e7916c5bb48	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	0	development@test.com	\N	V1 Internal Data Class	\N
41664fd2-5942-480a-9463-129c1afb2aa2	0	2021-10-04 13:23:16.87529	2021-10-04 13:23:16.87529	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	\N	\N	\N	2c5524eb-a78b-4255-8588-68228ff335cc	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	3	development@test.com	\N	V2 Data Class	\N
4b806f2b-ff4e-4bda-9543-ca8e51eb3ebe	1	2021-10-04 13:23:16.873294	2021-10-04 13:23:16.926239	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	\N	\N	\N	9001c6ac-07a9-4ae9-943a-cb983948e3c1	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	development@test.com	\N	V1 Data Class	Modified this description for test branch
5c58f136-c4b9-4a4e-8142-936660b4fa77	0	2021-10-04 13:23:17.210777	2021-10-04 13:23:17.210777	/9dd076ab-1240-474c-a3cb-5ef48863c208	1	\N	\N	\N	458928cc-afc4-41be-a19e-7ae02ad9da71	9dd076ab-1240-474c-a3cb-5ef48863c208	0	development@test.com	\N	V1 Another Data Class	\N
8865dc91-1795-4512-90cc-933206f36596	0	2021-10-04 13:23:17.21223	2021-10-04 13:23:17.21223	/9dd076ab-1240-474c-a3cb-5ef48863c208	1	\N	\N	\N	aa453da1-8e17-42c6-b6e0-0b46e4ffff23	9dd076ab-1240-474c-a3cb-5ef48863c208	1	development@test.com	\N	V1 Data Class	Modified this description for V2
f4678c70-3aae-426e-83ce-d812b89fc186	0	2021-10-04 13:23:17.213337	2021-10-04 13:23:17.213337	/9dd076ab-1240-474c-a3cb-5ef48863c208	1	\N	\N	\N	a1f6a5e4-d74f-4a57-b826-0b3c467b5537	9dd076ab-1240-474c-a3cb-5ef48863c208	2	development@test.com	\N	V1 Modify Data Class	\N
9b10c08e-06cc-47d2-932c-c27ca10f55ad	0	2021-10-04 13:23:17.214534	2021-10-04 13:23:17.214534	/9dd076ab-1240-474c-a3cb-5ef48863c208/f4678c70-3aae-426e-83ce-d812b89fc186	2	\N	\N	f4678c70-3aae-426e-83ce-d812b89fc186	48239bd3-22ad-4315-831f-177eddd60911	9dd076ab-1240-474c-a3cb-5ef48863c208	0	development@test.com	\N	V1 Internal Data Class	\N
1fa88da0-c245-4981-888d-3872abed48c1	0	2021-10-04 13:23:17.215331	2021-10-04 13:23:17.215331	/9dd076ab-1240-474c-a3cb-5ef48863c208	1	\N	\N	\N	a74e710e-8492-44f0-ad66-5b9ba6ecd7e8	9dd076ab-1240-474c-a3cb-5ef48863c208	3	development@test.com	\N	V2 Data Class	\N
4cc41c61-2ff7-4325-8289-5efd97dd789d	0	2021-10-04 13:23:17.414938	2021-10-04 13:23:17.414938	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	\N	\N	\N	4721d762-dbcf-445f-b5b8-d93e33a7ccb4	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	0	development@test.com	\N	V1 Another Data Class	\N
11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e	0	2021-10-04 13:23:17.416435	2021-10-04 13:23:17.416435	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	\N	\N	\N	5876ea5f-fd8b-4342-b2c4-3e3c51c0fb66	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	development@test.com	\N	V1 Data Class	Modified this description for V2
8eef006c-8b01-48cc-9048-9d22aa47e7f5	0	2021-10-04 13:23:17.417338	2021-10-04 13:23:17.417338	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	\N	\N	\N	76b78243-ab30-43fe-b236-2a125985cd8e	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	2	development@test.com	\N	V1 Modify Data Class	\N
953e8504-acce-452b-93ec-a9ab2817d26f	0	2021-10-04 13:23:17.418269	2021-10-04 13:23:17.418269	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d/8eef006c-8b01-48cc-9048-9d22aa47e7f5	2	\N	\N	8eef006c-8b01-48cc-9048-9d22aa47e7f5	6a28b2c5-f006-46a4-8e39-cd9ec523a0e3	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	0	development@test.com	\N	V1 Internal Data Class	\N
678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	0	2021-10-04 13:23:17.419457	2021-10-04 13:23:17.419457	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	\N	\N	\N	0408885a-8920-4618-a5c9-9ff5464fb152	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	3	development@test.com	\N	V2 Data Class	\N
b3c484a4-9928-4e28-a2e9-256234a01cf5	0	2021-10-04 13:23:17.672419	2021-10-04 13:23:17.672419	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	\N	\N	\N	e8d96597-8499-4f48-a150-3f349beaed8b	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	0	development@test.com	\N	V1 Another Data Class	\N
04c258ba-d2c3-47b0-9587-e79f88844ab4	0	2021-10-04 13:23:17.673711	2021-10-04 13:23:17.673711	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	\N	\N	\N	3e25da73-5548-43ec-88a9-e828e92f46f4	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	development@test.com	\N	V1 Data Class	Modified this description for V2
1571b213-46cb-4287-abe5-015be482575a	0	2021-10-04 13:23:17.674399	2021-10-04 13:23:17.674399	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	\N	\N	\N	4d719fe3-5873-42bb-92e3-f1028ce4b7e8	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	2	development@test.com	\N	V1 Modify Data Class	\N
94b17a72-c378-44b3-9ff7-1b1316e4575c	0	2021-10-04 13:23:17.674964	2021-10-04 13:23:17.674964	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d/1571b213-46cb-4287-abe5-015be482575a	2	\N	\N	1571b213-46cb-4287-abe5-015be482575a	437884bc-d4f4-4adc-b0a8-920f025fe3f1	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	0	development@test.com	\N	V1 Internal Data Class	\N
3c21c07e-ea7c-4345-a2ac-f450289200d9	0	2021-10-04 13:23:17.675527	2021-10-04 13:23:17.675527	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	\N	\N	\N	b753dea1-39ef-4b2b-9f86-2ca982d3345a	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	3	development@test.com	\N	V2 Data Class	\N
b0041c32-46a2-4427-9f99-e1f9544e7949	0	2021-10-04 13:23:17.895943	2021-10-04 13:23:17.895943	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	\N	\N	\N	c48cec78-d62f-46f6-a847-e487e0814fe9	eb5a08e6-844e-47c1-a31f-160dd238c202	0	development@test.com	\N	V1 Another Data Class	\N
c52b5d6f-ffe0-4984-946b-adfcb4cf1a35	0	2021-10-04 13:23:17.897769	2021-10-04 13:23:17.897769	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	\N	\N	\N	b0c90336-e5f4-4f45-a8f6-74ca4639f173	eb5a08e6-844e-47c1-a31f-160dd238c202	2	development@test.com	\N	V1 Modify Data Class	\N
9d1f62b9-a19b-44f8-b5c3-971665681c43	0	2021-10-04 13:23:17.89833	2021-10-04 13:23:17.89833	/eb5a08e6-844e-47c1-a31f-160dd238c202/c52b5d6f-ffe0-4984-946b-adfcb4cf1a35	2	\N	\N	c52b5d6f-ffe0-4984-946b-adfcb4cf1a35	26531fcc-bcc3-4416-8fa7-6c44c824311c	eb5a08e6-844e-47c1-a31f-160dd238c202	0	development@test.com	\N	V1 Internal Data Class	\N
1b151ae1-2b74-44a4-a865-28a521b61d68	0	2021-10-04 13:23:17.898909	2021-10-04 13:23:17.898909	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	\N	\N	\N	bd6f89bd-b8a9-4fca-96b0-ba02192d6a0f	eb5a08e6-844e-47c1-a31f-160dd238c202	3	development@test.com	\N	V2 Data Class	\N
2337c502-9095-4159-89ec-affc7f0e0535	1	2021-10-04 13:23:17.897115	2021-10-04 13:23:17.95183	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	\N	\N	\N	93d6c866-c1f5-4e63-99b6-9dbee4fb8faa	eb5a08e6-844e-47c1-a31f-160dd238c202	1	development@test.com	\N	V1 Data Class	Modified this description for test branch
d87845e7-f37a-4e56-9b64-a164397b8ead	0	2021-10-04 13:23:18.269132	2021-10-04 13:23:18.269132	/4b01f763-2505-46a2-938b-88622ca2eaa8	1	\N	\N	\N	af87950b-1396-4291-82af-16c72d89a8cb	4b01f763-2505-46a2-938b-88622ca2eaa8	0	development@test.com	\N	V1 Another Data Class	\N
ad087a7f-a365-451d-8f43-62f4a23d3303	0	2021-10-04 13:23:18.271114	2021-10-04 13:23:18.271114	/4b01f763-2505-46a2-938b-88622ca2eaa8	1	\N	\N	\N	fa93613d-5563-422c-8af3-a58bfb22374a	4b01f763-2505-46a2-938b-88622ca2eaa8	1	development@test.com	\N	V1 Data Class	Modified this description for V2
3e429da2-561b-48dd-bf3d-a1e28d574cc1	0	2021-10-04 13:23:18.272338	2021-10-04 13:23:18.272338	/4b01f763-2505-46a2-938b-88622ca2eaa8	1	\N	\N	\N	fae205b7-adb7-4119-b303-055713c03992	4b01f763-2505-46a2-938b-88622ca2eaa8	2	development@test.com	\N	V1 Modify Data Class	\N
b55ac619-f4c0-4d6d-86da-f02b868df7b1	0	2021-10-04 13:23:18.273362	2021-10-04 13:23:18.273362	/4b01f763-2505-46a2-938b-88622ca2eaa8/3e429da2-561b-48dd-bf3d-a1e28d574cc1	2	\N	\N	3e429da2-561b-48dd-bf3d-a1e28d574cc1	16f0e226-2d6e-4473-8bfb-f63c8b3bc35a	4b01f763-2505-46a2-938b-88622ca2eaa8	0	development@test.com	\N	V1 Internal Data Class	\N
864840e4-8a66-40a0-9ee5-63b429410541	0	2021-10-04 13:23:18.27432	2021-10-04 13:23:18.27432	/4b01f763-2505-46a2-938b-88622ca2eaa8	1	\N	\N	\N	84d8131b-7d16-467b-8ffc-5851367e40c3	4b01f763-2505-46a2-938b-88622ca2eaa8	3	development@test.com	\N	V2 Data Class	\N
b7dd4552-90b4-4cf5-879a-9438e00a1afd	0	2021-10-04 13:23:18.649482	2021-10-04 13:23:18.649482	/bb3deab5-3b2e-418b-9bff-6bd62e49354d	1	\N	\N	\N	9b6468f4-b37e-4219-a829-9b1f59004106	bb3deab5-3b2e-418b-9bff-6bd62e49354d	2	development@test.com	\N	tableA	\N
269ea29f-b6e2-4d61-a26e-bc08942d0f14	0	2021-10-04 13:23:18.652236	2021-10-04 13:23:18.652236	/bb3deab5-3b2e-418b-9bff-6bd62e49354d	1	\N	\N	\N	dfb71cfa-a2d1-4feb-89cc-abfccba579b8	bb3deab5-3b2e-418b-9bff-6bd62e49354d	2	development@test.com	\N	tableB	\N
b5d32e45-3bbc-4b41-a96b-75019b8d5773	0	2021-10-04 13:23:18.653044	2021-10-04 13:23:18.653044	/bb3deab5-3b2e-418b-9bff-6bd62e49354d	1	\N	\N	\N	140b72da-6d1f-460f-b726-770084f0a52f	bb3deab5-3b2e-418b-9bff-6bd62e49354d	2	development@test.com	\N	tableC	\N
0cbac9f2-d584-4473-9619-fa49740bf9e2	0	2021-10-04 13:23:18.730395	2021-10-04 13:23:18.730395	/b5dca58a-c401-4423-acd6-33d391b909c2	1	\N	\N	\N	52115a39-7646-4479-bf71-5627f9e00776	b5dca58a-c401-4423-acd6-33d391b909c2	1	development@test.com	\N	tableD	\N
1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	0	2021-10-04 13:23:18.732436	2021-10-04 13:23:18.732436	/b5dca58a-c401-4423-acd6-33d391b909c2	1	\N	\N	\N	6014f80f-b075-4950-a652-96635bf5b542	b5dca58a-c401-4423-acd6-33d391b909c2	1	development@test.com	\N	tableE	\N
\.


--
-- Data for Name: data_element; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.data_element (id, version, date_created, data_class_id, last_updated, path, depth, min_multiplicity, max_multiplicity, breadcrumb_tree_id, data_type_id, idx, created_by, aliases_string, label, description) FROM stdin;
310ed824-0d34-4b3a-9c76-055df6604773	0	2021-10-04 13:23:13.725563	83fba1d1-0d86-4178-9dbe-91b6554d2b70	2021-10-04 13:23:13.725563	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5/83fba1d1-0d86-4178-9dbe-91b6554d2b70	2	1	1	b41f52a7-0f74-4284-9c23-26016bab070f	fd61aec8-104f-4ecf-b4cc-7d54fec0c950	1	development@test.com	\N	element2	\N
f2eef249-8c87-4236-8c42-9395972f2937	0	2021-10-04 13:23:13.727264	ae701c79-ea4a-4e1f-be85-281f2e7281dd	2021-10-04 13:23:13.727264	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5/ae701c79-ea4a-4e1f-be85-281f2e7281dd	2	1	1	23e16092-31db-457b-aeb2-e3242983ddaa	4e4203aa-47ae-4a9d-9001-a18e91f504f2	0	development@test.com	\N	child	\N
6bf2400f-a673-422b-ab73-62b658f81b55	1	2021-10-04 13:23:13.72327	83fba1d1-0d86-4178-9dbe-91b6554d2b70	2021-10-04 13:23:13.810344	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5/83fba1d1-0d86-4178-9dbe-91b6554d2b70	2	0	20	0f2ef7bf-67f4-4b79-b2d5-3b8a6b738c9d	29f5ecf2-270f-4efe-b4a2-04095a88520d	1	development@test.com	\N	ele1	\N
6be94c01-f0e3-4810-8156-eabc5d48cee5	0	2021-10-04 13:23:14.029515	50ea6b13-9b75-4fbc-b611-747988ab0afb	2021-10-04 13:23:14.029515	/f9f834b7-74f5-4b0c-997a-044ac335a9f4/50ea6b13-9b75-4fbc-b611-747988ab0afb	2	1	1	d044f0ac-ce9f-43c9-a083-f8ca8b485f3e	3db65ef9-f4ba-452a-920f-b601b15f56cc	1	development@test.com	\N	Another DataElement	\N
33e1bfca-abbb-4645-ac2c-c559499a23e8	0	2021-10-04 13:23:14.032247	50ea6b13-9b75-4fbc-b611-747988ab0afb	2021-10-04 13:23:14.032247	/f9f834b7-74f5-4b0c-997a-044ac335a9f4/50ea6b13-9b75-4fbc-b611-747988ab0afb	2	1	1	9825a25c-c249-46fa-8b98-2b9f971aaf20	3db65ef9-f4ba-452a-920f-b601b15f56cc	1	development@test.com	\N	Finalised Data Element	\N
7e125a13-1332-4fcc-bb6e-6fe81759a936	0	2021-10-04 13:23:14.193271	cf1ba70e-746a-4300-9409-2eb76d03aee4	2021-10-04 13:23:14.193271	/6e73dcde-8ce7-4c45-b37d-0494e55394c9/cf1ba70e-746a-4300-9409-2eb76d03aee4	2	1	1	7f75bbb8-7243-4ea0-ba34-e64f443092b1	cace8c8b-048d-4158-b532-40198892fee4	1	development@test.com	\N	V1 Modify DataElement	\N
b2f25c3f-11ad-45de-88a6-a2bd80ece516	0	2021-10-04 13:23:14.195267	7b544cd7-a689-49d9-9e4a-318339a95d89	2021-10-04 13:23:14.195267	/6e73dcde-8ce7-4c45-b37d-0494e55394c9/6efd3b15-ff7e-4ec5-9505-0712fa51eb39/7b544cd7-a689-49d9-9e4a-318339a95d89	3	1	1	32505aa9-c4dc-448c-803f-6bce1e64c9af	cace8c8b-048d-4158-b532-40198892fee4	0	development@test.com	\N	V1 Data Element	\N
f76409c4-0760-4f75-bf72-edae0a4a7995	0	2021-10-04 13:23:14.196604	cf1ba70e-746a-4300-9409-2eb76d03aee4	2021-10-04 13:23:14.196604	/6e73dcde-8ce7-4c45-b37d-0494e55394c9/cf1ba70e-746a-4300-9409-2eb76d03aee4	2	1	1	8c7cce68-5b24-457e-a5f1-34f15d7d60a0	cace8c8b-048d-4158-b532-40198892fee4	1	development@test.com	\N	V1 Modify DataElement 2	\N
d1586984-9494-487e-a747-6a165fbc9e6a	0	2021-10-04 13:23:14.197747	6efd3b15-ff7e-4ec5-9505-0712fa51eb39	2021-10-04 13:23:14.197747	/6e73dcde-8ce7-4c45-b37d-0494e55394c9/6efd3b15-ff7e-4ec5-9505-0712fa51eb39	2	1	1	bd0d3827-cbf9-4c61-8c2f-ae7c698bdc81	cace8c8b-048d-4158-b532-40198892fee4	0	development@test.com	\N	V1 Second DataElement	\N
e69b07fa-9bbe-4f97-bbfa-c74d2dee68d2	0	2021-10-04 13:23:14.813908	81ea24dc-03de-4e25-8649-9778c6f53055	2021-10-04 13:23:14.813908	/926d5e0c-5ee5-457f-9335-3e97d02c08b2/81ea24dc-03de-4e25-8649-9778c6f53055	2	1	1	ee78dc72-a091-4075-bb19-58f11f97e1c5	f4740512-2cbd-4ad7-9ebb-ed6e7874fefe	1	development@test.com	\N	V1 Modify DataElement 2	\N
3beb7b0c-e257-4d8b-af26-8c5e903ba2fc	0	2021-10-04 13:23:14.815693	81ea24dc-03de-4e25-8649-9778c6f53055	2021-10-04 13:23:14.815693	/926d5e0c-5ee5-457f-9335-3e97d02c08b2/81ea24dc-03de-4e25-8649-9778c6f53055	2	1	1	b797c65b-8a03-432e-be8f-ba3736012aae	f4740512-2cbd-4ad7-9ebb-ed6e7874fefe	1	development@test.com	\N	V1 Modify DataElement	\N
1249f4b2-2375-4b5f-82fb-439a11f8c740	0	2021-10-04 13:23:14.816701	059983db-5a11-4aa6-b910-e736e8303008	2021-10-04 13:23:14.816701	/926d5e0c-5ee5-457f-9335-3e97d02c08b2/f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2/059983db-5a11-4aa6-b910-e736e8303008	3	1	1	dd9daf2c-b8fd-4bde-a1d9-e97efcd902a4	f4740512-2cbd-4ad7-9ebb-ed6e7874fefe	0	development@test.com	\N	V1 Data Element	\N
76d51770-c7f7-44e5-bf40-281dac1f4bfd	0	2021-10-04 13:23:14.817591	f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2	2021-10-04 13:23:14.817591	/926d5e0c-5ee5-457f-9335-3e97d02c08b2/f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2	2	1	1	a736ef9c-230e-4f16-8b93-5fafd46ab80a	f4740512-2cbd-4ad7-9ebb-ed6e7874fefe	0	development@test.com	\N	V1 Second DataElement	\N
17981a0d-014d-4c4f-ac24-04eb88a49f7b	0	2021-10-04 13:23:15.104025	3627da01-784f-469e-b9d5-e043291c5ec9	2021-10-04 13:23:15.104025	/b3099f15-afde-436a-be99-1300eae98b4e/3627da01-784f-469e-b9d5-e043291c5ec9	2	1	1	ef5ea635-9f6b-4220-89f1-3f19b0e50174	965d3adf-1328-4863-90b4-8ac988f38e57	1	development@test.com	\N	V1 Modify DataElement	\N
b3109d79-5844-4792-b8e3-9420aaada6bc	0	2021-10-04 13:23:15.105682	3627da01-784f-469e-b9d5-e043291c5ec9	2021-10-04 13:23:15.105682	/b3099f15-afde-436a-be99-1300eae98b4e/3627da01-784f-469e-b9d5-e043291c5ec9	2	1	1	43c52d8e-c8d1-4a6a-9f5f-bd8613955b84	965d3adf-1328-4863-90b4-8ac988f38e57	1	development@test.com	\N	V1 Modify DataElement 2	\N
53b89bcf-fc38-43c2-8724-55273eb182e9	0	2021-10-04 13:23:15.106703	f95847c0-c163-4ca7-be79-e26e309e454e	2021-10-04 13:23:15.106703	/b3099f15-afde-436a-be99-1300eae98b4e/dd87ad23-df5a-4194-a2b0-9a0876c79ee4/f95847c0-c163-4ca7-be79-e26e309e454e	3	1	1	7abb1ef6-9227-4814-b759-cc3a854976bd	965d3adf-1328-4863-90b4-8ac988f38e57	0	development@test.com	\N	V1 Data Element	\N
eab6604d-b223-45eb-9003-ab956d4152ca	0	2021-10-04 13:23:15.108016	dd87ad23-df5a-4194-a2b0-9a0876c79ee4	2021-10-04 13:23:15.108016	/b3099f15-afde-436a-be99-1300eae98b4e/dd87ad23-df5a-4194-a2b0-9a0876c79ee4	2	1	1	2f536c86-7d28-4b04-bd8d-da6583c72435	965d3adf-1328-4863-90b4-8ac988f38e57	0	development@test.com	\N	V1 Second DataElement	\N
27d9fd52-c55b-485e-a9ab-78b381b4b593	0	2021-10-04 13:23:15.294925	b0808edb-75a9-4204-baca-3af4fe2ba053	2021-10-04 13:23:15.294925	/c5c83da4-47de-44f2-a5fd-414ac1f13900/b0808edb-75a9-4204-baca-3af4fe2ba053	2	1	1	49576816-9214-45ea-9a1a-13dd0e7259a3	91ff3163-6a80-4e19-8ce2-172bb446ce15	0	development@test.com	\N	V1 Second DataElement	\N
a32022f4-a429-41fa-9d4d-0581a925a6a9	0	2021-10-04 13:23:15.377403	ed7afe51-ccf7-448b-9716-a0d06fe14701	2021-10-04 13:23:15.377403	/c5c83da4-47de-44f2-a5fd-414ac1f13900/ed7afe51-ccf7-448b-9716-a0d06fe14701	2	1	1	dfb1560c-5c03-4630-ac8f-99844cb9cba9	1e2be421-1894-4297-a557-3ae7e40fea96	2	development@test.com	\N	V2 Data Element	\N
acfcf44f-468e-49c4-be43-c420adea68b4	0	2021-10-04 13:23:15.378848	ed7afe51-ccf7-448b-9716-a0d06fe14701	2021-10-04 13:23:15.378848	/c5c83da4-47de-44f2-a5fd-414ac1f13900/ed7afe51-ccf7-448b-9716-a0d06fe14701	2	1	1	1b7e46ff-c589-4c51-ad31-a594015aa2cf	0f4824f3-305c-4b2b-9533-9c9a3425aa4e	2	development@test.com	\N	V2 Second DataElement	\N
6a2412f3-29d1-4bee-aa3a-1f8d1fa836ae	0	2021-10-04 13:23:15.379718	ed7afe51-ccf7-448b-9716-a0d06fe14701	2021-10-04 13:23:15.379718	/c5c83da4-47de-44f2-a5fd-414ac1f13900/ed7afe51-ccf7-448b-9716-a0d06fe14701	2	1	1	d70632f7-02cd-42ca-a44a-bcddbfa6be07	0ef863c6-a0b2-4cc0-b9ab-014a5114f108	2	development@test.com	\N	V2 Third DataElement	\N
125027e4-d56f-4c44-9afc-d6043aef4e88	1	2021-10-04 13:23:15.297969	2211dfeb-5b7c-4022-923a-fb4e205a8bbc	2021-10-04 13:23:15.521056	/c5c83da4-47de-44f2-a5fd-414ac1f13900/2211dfeb-5b7c-4022-923a-fb4e205a8bbc	2	1	1	e6ad9738-3346-4b0a-97b7-05abd981dfb3	91ff3163-6a80-4e19-8ce2-172bb446ce15	1	development@test.com	\N	Modified Label On this element	\N
3f7904a3-8043-4b5a-8f96-3801da3949d7	0	2021-10-04 13:23:15.904164	e4656cb5-fe45-494f-8b83-46c1c397de23	2021-10-04 13:23:15.904164	/c84fb099-79bc-496a-8901-75c99d539fbd/e4656cb5-fe45-494f-8b83-46c1c397de23	2	1	1	12e3470b-a48b-431b-97ce-6dd4bc172438	ada0765e-5d5d-4175-9c5f-a48e286661ea	1	development@test.com	\N	V1 Modify DataElement	\N
47e4279d-543a-41bd-96ed-2e16f3d2f3de	0	2021-10-04 13:23:15.905434	7bef5540-b2c5-4c5c-b2db-37053c270a75	2021-10-04 13:23:15.905434	/c84fb099-79bc-496a-8901-75c99d539fbd/7bef5540-b2c5-4c5c-b2db-37053c270a75	2	1	1	600bf737-908e-4fc6-a224-cfd0113cc91f	ada0765e-5d5d-4175-9c5f-a48e286661ea	0	development@test.com	\N	V1 Second DataElement	\N
68c07e75-1cec-4147-8476-8cc03c0d28a2	0	2021-10-04 13:23:15.906235	e4656cb5-fe45-494f-8b83-46c1c397de23	2021-10-04 13:23:15.906235	/c84fb099-79bc-496a-8901-75c99d539fbd/e4656cb5-fe45-494f-8b83-46c1c397de23	2	1	1	860fbfb8-806b-4ef9-9b2d-79d56004d914	ada0765e-5d5d-4175-9c5f-a48e286661ea	1	development@test.com	\N	V1 Modify DataElement 2	\N
104bf289-d3de-427c-9b28-cd98fe166d1c	0	2021-10-04 13:23:15.906865	5826b473-352e-4bf3-bce2-2ff97be6c197	2021-10-04 13:23:15.906865	/c84fb099-79bc-496a-8901-75c99d539fbd/7bef5540-b2c5-4c5c-b2db-37053c270a75/5826b473-352e-4bf3-bce2-2ff97be6c197	3	1	1	846d34cd-46cf-4456-884b-6543e6f79ce0	ada0765e-5d5d-4175-9c5f-a48e286661ea	0	development@test.com	\N	V1 Data Element	\N
ef1d9eda-1666-4102-8614-a20636c138c1	0	2021-10-04 13:23:16.340998	71d70845-8359-4e06-93f4-d31984cb31c3	2021-10-04 13:23:16.340998	/94f194ee-79db-4835-840e-4168bc4d9331/71d70845-8359-4e06-93f4-d31984cb31c3	2	1	1	17bba52d-4039-428f-a16b-992e637ab1f7	30c1996b-46d8-44a8-9e9f-161df68a8d41	0	development@test.com	\N	V1 Second DataElement	\N
d6da4efc-eea5-4a83-8554-9f28c9137d0f	0	2021-10-04 13:23:16.342489	b0616a77-ed8b-4ff4-883a-9494a0e8e821	2021-10-04 13:23:16.342489	/94f194ee-79db-4835-840e-4168bc4d9331/b0616a77-ed8b-4ff4-883a-9494a0e8e821	2	1	1	bf00eba8-3314-4ced-8684-dcbe0041d7e4	30c1996b-46d8-44a8-9e9f-161df68a8d41	0	development@test.com	\N	Modified Label On this element	\N
34e1a169-59b0-48b0-a7ee-82811742e4a9	0	2021-10-04 13:23:16.343228	45122b94-5b79-4826-9afa-531042bba78a	2021-10-04 13:23:16.343228	/94f194ee-79db-4835-840e-4168bc4d9331/45122b94-5b79-4826-9afa-531042bba78a	2	1	1	42fb17b3-8d24-47b6-b476-87bedc45b863	1c25775a-00bf-4221-91d4-5f644c764637	2	development@test.com	\N	V2 Data Element	\N
c4893582-8316-4c72-b6cc-b9b3edf6de22	0	2021-10-04 13:23:16.343899	45122b94-5b79-4826-9afa-531042bba78a	2021-10-04 13:23:16.343899	/94f194ee-79db-4835-840e-4168bc4d9331/45122b94-5b79-4826-9afa-531042bba78a	2	1	1	6bede682-2d7a-4045-a111-5dd72c2a95a4	dd2caaa3-67ad-49f5-80f8-bc6978351fb2	2	development@test.com	\N	V2 Second DataElement	\N
0faa2a77-0da9-45d4-a41d-18d7216b8b3b	0	2021-10-04 13:23:16.34455	45122b94-5b79-4826-9afa-531042bba78a	2021-10-04 13:23:16.34455	/94f194ee-79db-4835-840e-4168bc4d9331/45122b94-5b79-4826-9afa-531042bba78a	2	1	1	fdf48ce3-00c0-4b79-a395-641f24d3b7c0	0d203b8d-8f47-432f-95da-535e8967328c	2	development@test.com	\N	V2 Third DataElement	\N
5a843782-2bd3-48a9-ad1a-ca0b0534c0b0	0	2021-10-04 13:23:16.652694	c5b99d99-be9f-4639-ad03-feaeaed2188e	2021-10-04 13:23:16.652694	/726b5b98-4b02-433d-9e3b-249f139a27dc/c5b99d99-be9f-4639-ad03-feaeaed2188e	2	1	1	0b50d0f7-ce3e-42d2-a670-5f00f0223b7a	850a0c33-0121-43de-ae1c-e1ff5bab6f0a	0	development@test.com	\N	V1 Second DataElement	\N
1b80f6d8-8e4c-4611-85ce-f2bb134537ea	0	2021-10-04 13:23:16.65481	efd359cc-066f-4c58-b1e4-53db8085d44e	2021-10-04 13:23:16.65481	/726b5b98-4b02-433d-9e3b-249f139a27dc/efd359cc-066f-4c58-b1e4-53db8085d44e	2	1	1	c7ef6753-2da7-43e3-8cee-95c97db9a2d5	850a0c33-0121-43de-ae1c-e1ff5bab6f0a	0	development@test.com	\N	Modified Label On this element	\N
391a79f0-6728-4679-ab52-97d98ceb5fd4	0	2021-10-04 13:23:16.656049	3ccdd107-b935-4a0c-91b6-5f10f03c46a6	2021-10-04 13:23:16.656049	/726b5b98-4b02-433d-9e3b-249f139a27dc/3ccdd107-b935-4a0c-91b6-5f10f03c46a6	2	1	1	dbabbaef-c302-4f8c-80f2-7aedf143f254	debd425a-6c2f-41c2-918f-cf7bd81030bd	2	development@test.com	\N	V2 Data Element	\N
2663298a-f6fc-4c3e-a496-b3116a2cd986	0	2021-10-04 13:23:16.657008	3ccdd107-b935-4a0c-91b6-5f10f03c46a6	2021-10-04 13:23:16.657008	/726b5b98-4b02-433d-9e3b-249f139a27dc/3ccdd107-b935-4a0c-91b6-5f10f03c46a6	2	1	1	fe72dcc3-cd89-4246-9bb7-f2063dc99894	08ca0f68-87a1-474b-bffd-98c43c6fcc93	2	development@test.com	\N	V2 Second DataElement	\N
ae063f71-0c7b-4019-9741-0fb249d10826	0	2021-10-04 13:23:16.658012	3ccdd107-b935-4a0c-91b6-5f10f03c46a6	2021-10-04 13:23:16.658012	/726b5b98-4b02-433d-9e3b-249f139a27dc/3ccdd107-b935-4a0c-91b6-5f10f03c46a6	2	1	1	8946a8ad-a418-4064-b8bf-e62372e2bfbb	e7c6df2f-f1c5-4936-98e3-e06613890815	2	development@test.com	\N	V2 Third DataElement	\N
d9aadda4-624a-4062-acdf-83fe4dd057c2	0	2021-10-04 13:23:16.87911	a099fc92-d9ca-4fa1-a74c-63a788819f68	2021-10-04 13:23:16.87911	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02/a099fc92-d9ca-4fa1-a74c-63a788819f68	2	1	1	9550f09a-30f6-4f84-8878-d151c83b5bb9	b12a75f4-bb3f-4e23-a154-a0345414358a	0	development@test.com	\N	Modified Label On this element	\N
543a0004-4252-4f31-9552-877865ccb77c	0	2021-10-04 13:23:16.881362	41664fd2-5942-480a-9463-129c1afb2aa2	2021-10-04 13:23:16.881362	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02/41664fd2-5942-480a-9463-129c1afb2aa2	2	1	1	bd6e3549-b6ed-4961-a324-bb125ee729ea	a0f7ca74-465f-4968-8f83-9ea2f6b9007d	2	development@test.com	\N	V2 Data Element	\N
d088448e-6501-4d69-a723-702e2b623f22	0	2021-10-04 13:23:16.881901	41664fd2-5942-480a-9463-129c1afb2aa2	2021-10-04 13:23:16.881901	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02/41664fd2-5942-480a-9463-129c1afb2aa2	2	1	1	6dcac5cd-8dea-4e89-802f-add0dfc36db2	dcf77ff3-d2c8-4b21-a64e-006e65077418	2	development@test.com	\N	V2 Second DataElement	\N
140186cd-0ea3-4370-8887-361703993637	0	2021-10-04 13:23:16.882421	41664fd2-5942-480a-9463-129c1afb2aa2	2021-10-04 13:23:16.882421	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02/41664fd2-5942-480a-9463-129c1afb2aa2	2	1	1	525a551d-840c-44ed-8233-40bff7719b59	ed7c2eb7-4161-487a-b5f8-99f54d19f81e	2	development@test.com	\N	V2 Third DataElement	\N
e1f7e536-fa90-4d02-99fb-c5ae639dc2ef	1	2021-10-04 13:23:16.880706	4b806f2b-ff4e-4bda-9543-ca8e51eb3ebe	2021-10-04 13:23:16.936821	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02/4b806f2b-ff4e-4bda-9543-ca8e51eb3ebe	2	0	1	6d10f1eb-02cd-4d27-8ca8-4d36def093c7	b12a75f4-bb3f-4e23-a154-a0345414358a	0	development@test.com	\N	V1 Second DataElement	Adding a description
bfb391be-e237-4a3e-b01b-ac6da2d251ad	0	2021-10-04 13:23:17.219706	8865dc91-1795-4512-90cc-933206f36596	2021-10-04 13:23:17.219706	/9dd076ab-1240-474c-a3cb-5ef48863c208/8865dc91-1795-4512-90cc-933206f36596	2	1	1	378b0925-5cd7-48c5-9ac4-ce707ac74c3c	7c3556c9-bf46-4378-945a-32ae5bfa1cc3	0	development@test.com	\N	V1 Second DataElement	\N
e8f859bf-8371-4945-8ac7-850898c3394f	0	2021-10-04 13:23:17.221154	f4678c70-3aae-426e-83ce-d812b89fc186	2021-10-04 13:23:17.221154	/9dd076ab-1240-474c-a3cb-5ef48863c208/f4678c70-3aae-426e-83ce-d812b89fc186	2	1	1	63188978-5b05-4d99-8147-bff31748410c	7c3556c9-bf46-4378-945a-32ae5bfa1cc3	0	development@test.com	\N	Modified Label On this element	\N
702daa66-4894-4c45-b03f-48b6cca390b5	0	2021-10-04 13:23:17.221803	1fa88da0-c245-4981-888d-3872abed48c1	2021-10-04 13:23:17.221803	/9dd076ab-1240-474c-a3cb-5ef48863c208/1fa88da0-c245-4981-888d-3872abed48c1	2	1	1	29d808db-98bc-4a33-882a-6a81fcc73bba	241cd456-e9ff-4521-9d8a-157438b29e85	2	development@test.com	\N	V2 Data Element	\N
722468b3-c1ad-4a11-be22-90ae8e3f16ca	0	2021-10-04 13:23:17.222365	1fa88da0-c245-4981-888d-3872abed48c1	2021-10-04 13:23:17.222365	/9dd076ab-1240-474c-a3cb-5ef48863c208/1fa88da0-c245-4981-888d-3872abed48c1	2	1	1	0d8dcaf2-8d3c-4d65-8f55-7303f1cbc704	e762cdf4-e140-49e1-837d-f8a50bf85150	2	development@test.com	\N	V2 Second DataElement	\N
b0fb7cb8-763c-4673-88b1-27731c356cc1	0	2021-10-04 13:23:17.222907	1fa88da0-c245-4981-888d-3872abed48c1	2021-10-04 13:23:17.222907	/9dd076ab-1240-474c-a3cb-5ef48863c208/1fa88da0-c245-4981-888d-3872abed48c1	2	1	1	d1bee0a2-b9a8-432b-89f7-efffd6dca730	05868455-f7e3-4775-b563-4966b2550c73	2	development@test.com	\N	V2 Third DataElement	\N
5e1731b0-241b-4e25-b1a9-244c85c67275	0	2021-10-04 13:23:17.423889	11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e	2021-10-04 13:23:17.423889	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d/11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e	2	1	1	3dc83436-174c-40f6-90ec-b747b79ec8ae	92585be7-eb1d-4331-9f8b-20277bc3a3fe	0	development@test.com	\N	V1 Second DataElement	\N
24235cda-63d5-4c31-bdab-9d7e190b8d2f	0	2021-10-04 13:23:17.425632	8eef006c-8b01-48cc-9048-9d22aa47e7f5	2021-10-04 13:23:17.425632	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d/8eef006c-8b01-48cc-9048-9d22aa47e7f5	2	1	1	6a533050-f447-4da8-b801-9df27e4d8bf8	92585be7-eb1d-4331-9f8b-20277bc3a3fe	0	development@test.com	\N	Modified Label On this element	\N
0331172d-7a0b-4d77-ad29-9e09dee1c2be	0	2021-10-04 13:23:17.426541	678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2021-10-04 13:23:17.426541	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d/678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2	1	1	2185c2fe-467e-4d63-b8a5-333a9c065535	0c313d45-1561-4e04-b881-9efc36ed3976	2	development@test.com	\N	V2 Data Element	\N
95d47600-574f-49fb-bdd6-fa47d6935536	0	2021-10-04 13:23:17.427217	678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2021-10-04 13:23:17.427217	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d/678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2	1	1	8cd13e94-fde4-4eee-b801-a80a06d55289	614e12ea-d510-4320-9be4-372af71d5e47	2	development@test.com	\N	V2 Second DataElement	\N
3a2a4dcd-3cb4-4bdf-8891-9723dab8b5af	0	2021-10-04 13:23:17.427815	678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2021-10-04 13:23:17.427815	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d/678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	2	1	1	74bc68e3-357b-414a-bb34-597161ef4227	55d78ee3-5908-48a5-8656-820256047de3	2	development@test.com	\N	V2 Third DataElement	\N
0175c673-66b3-484f-b8f1-e92bfffad169	0	2021-10-04 13:23:17.67911	1571b213-46cb-4287-abe5-015be482575a	2021-10-04 13:23:17.67911	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d/1571b213-46cb-4287-abe5-015be482575a	2	1	1	4209f905-c2bd-4053-bb10-bf6a9ad0545e	700f81b0-5f14-43b6-b846-2d32a666ab56	0	development@test.com	\N	Modified Label On this element	\N
1b5392b0-e316-4a0f-ae82-00ca5f2a2d1a	0	2021-10-04 13:23:17.680474	04c258ba-d2c3-47b0-9587-e79f88844ab4	2021-10-04 13:23:17.680474	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d/04c258ba-d2c3-47b0-9587-e79f88844ab4	2	1	1	837a857c-569a-4602-b8ed-4833c12b4d65	700f81b0-5f14-43b6-b846-2d32a666ab56	0	development@test.com	\N	V1 Second DataElement	\N
52bc7f27-1776-417d-9164-bc89dcb50419	0	2021-10-04 13:23:17.681135	3c21c07e-ea7c-4345-a2ac-f450289200d9	2021-10-04 13:23:17.681135	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d/3c21c07e-ea7c-4345-a2ac-f450289200d9	2	1	1	1e213be3-52dd-451b-9c00-36dee60f05f1	b2082605-ace7-4bb8-ac47-ae9b4cabb112	2	development@test.com	\N	V2 Data Element	\N
cd6add7e-1f55-4efa-8742-308d6efc117b	0	2021-10-04 13:23:17.681691	3c21c07e-ea7c-4345-a2ac-f450289200d9	2021-10-04 13:23:17.681691	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d/3c21c07e-ea7c-4345-a2ac-f450289200d9	2	1	1	ad0cba26-c5ff-4464-b3ae-e00aa6631edf	25976300-071b-48b0-bc64-940ddaca293d	2	development@test.com	\N	V2 Second DataElement	\N
3d3185a5-ab88-4473-bb39-0b3f159cc726	0	2021-10-04 13:23:17.682213	3c21c07e-ea7c-4345-a2ac-f450289200d9	2021-10-04 13:23:17.682213	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d/3c21c07e-ea7c-4345-a2ac-f450289200d9	2	1	1	24abaf3e-335a-4d86-85f7-0475a8bf11c8	4da5448a-a9dc-4ace-a777-a5dbd602cc9a	2	development@test.com	\N	V2 Third DataElement	\N
a7729d1b-9be9-44a7-bb92-0e23bedc05a6	0	2021-10-04 13:23:17.902345	c52b5d6f-ffe0-4984-946b-adfcb4cf1a35	2021-10-04 13:23:17.902345	/eb5a08e6-844e-47c1-a31f-160dd238c202/c52b5d6f-ffe0-4984-946b-adfcb4cf1a35	2	1	1	c8356771-3fbf-430d-8d88-4ac42277a465	944f49a0-eec3-4d75-8476-1fd4dde40a76	0	development@test.com	\N	Modified Label On this element	\N
4cbdcb0e-adb0-4ea0-89b8-bbd0f8d649f2	0	2021-10-04 13:23:17.904802	1b151ae1-2b74-44a4-a865-28a521b61d68	2021-10-04 13:23:17.904802	/eb5a08e6-844e-47c1-a31f-160dd238c202/1b151ae1-2b74-44a4-a865-28a521b61d68	2	1	1	80dd3141-3944-4d0b-bf6f-423956e59f17	f43a3684-69de-418a-b22e-72b925c7f9d5	2	development@test.com	\N	V2 Second DataElement	\N
81325df2-f680-4206-bd95-00cbce949b9f	0	2021-10-04 13:23:17.90533	1b151ae1-2b74-44a4-a865-28a521b61d68	2021-10-04 13:23:17.90533	/eb5a08e6-844e-47c1-a31f-160dd238c202/1b151ae1-2b74-44a4-a865-28a521b61d68	2	1	1	d9e8efb6-0dd4-4d36-b615-fcbda3fc9f2a	241094fa-817f-41c8-aa73-0cbf44f727ce	2	development@test.com	\N	V2 Third DataElement	\N
c7cb89d6-3716-4183-a903-afa88eb46b4d	1	2021-10-04 13:23:17.903579	2337c502-9095-4159-89ec-affc7f0e0535	2021-10-04 13:23:17.970336	/eb5a08e6-844e-47c1-a31f-160dd238c202/2337c502-9095-4159-89ec-affc7f0e0535	2	1	-1	ddfcfdc8-898a-4a88-adb6-32ad66798437	944f49a0-eec3-4d75-8476-1fd4dde40a76	0	development@test.com	\N	V1 Second DataElement	\N
21055a03-4775-4c04-be32-834238ecadda	1	2021-10-04 13:23:17.904257	1b151ae1-2b74-44a4-a865-28a521b61d68	2021-10-04 13:23:18.020488	/eb5a08e6-844e-47c1-a31f-160dd238c202/1b151ae1-2b74-44a4-a865-28a521b61d68	2	1	1	158399ca-c8ff-4c48-a2d9-e8e9a85ef592	3b93f98a-b33a-4cba-9a1e-f92b7583dd25	2	development@test.com	\N	V2 Data Element	\N
6d33c17e-afda-483b-8cb0-1e9639503289	0	2021-10-04 13:23:18.280291	3e429da2-561b-48dd-bf3d-a1e28d574cc1	2021-10-04 13:23:18.280291	/4b01f763-2505-46a2-938b-88622ca2eaa8/3e429da2-561b-48dd-bf3d-a1e28d574cc1	2	1	1	9d3d6e43-1364-4120-87a9-9a5e1dbe75fe	2be54098-04ed-4795-8fcd-81a8f29e67a8	0	development@test.com	\N	Modified Label On this element	\N
faca94c6-de54-4c65-aa2c-6c0ea530e82c	0	2021-10-04 13:23:18.282001	ad087a7f-a365-451d-8f43-62f4a23d3303	2021-10-04 13:23:18.282001	/4b01f763-2505-46a2-938b-88622ca2eaa8/ad087a7f-a365-451d-8f43-62f4a23d3303	2	1	1	1739d6c4-ca9f-42d3-89d1-8508edae99c7	2be54098-04ed-4795-8fcd-81a8f29e67a8	0	development@test.com	\N	V1 Second DataElement	\N
abd40f48-9adf-4700-8a9d-104ed1c9afb6	0	2021-10-04 13:23:18.283082	864840e4-8a66-40a0-9ee5-63b429410541	2021-10-04 13:23:18.283082	/4b01f763-2505-46a2-938b-88622ca2eaa8/864840e4-8a66-40a0-9ee5-63b429410541	2	1	1	0c4b5b5e-fa89-4852-889b-265250982700	85480359-f7ba-4e7d-af94-ec2392733e3f	2	development@test.com	\N	V2 Data Element	\N
2d7d41cf-5a2b-4d1c-b280-27a6e39f9473	0	2021-10-04 13:23:18.284032	864840e4-8a66-40a0-9ee5-63b429410541	2021-10-04 13:23:18.284032	/4b01f763-2505-46a2-938b-88622ca2eaa8/864840e4-8a66-40a0-9ee5-63b429410541	2	1	1	d00da5d8-0002-48c5-abdc-90c61c843462	ad70193a-c09e-4ea5-97f0-17fed041198e	2	development@test.com	\N	V2 Second DataElement	\N
b7300ae0-6827-4559-86b0-2a81e16805cb	0	2021-10-04 13:23:18.285037	864840e4-8a66-40a0-9ee5-63b429410541	2021-10-04 13:23:18.285037	/4b01f763-2505-46a2-938b-88622ca2eaa8/864840e4-8a66-40a0-9ee5-63b429410541	2	1	1	c93ff336-0bff-40b6-ae4a-e9437697963f	b3ecf027-4cb6-44c2-87cf-dd2570883ed2	2	development@test.com	\N	V2 Third DataElement	\N
9eb5dd97-ae95-44d9-926c-d25f628a8be6	0	2021-10-04 13:23:18.655685	b5d32e45-3bbc-4b41-a96b-75019b8d5773	2021-10-04 13:23:18.655685	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b5d32e45-3bbc-4b41-a96b-75019b8d5773	2	\N	\N	03ab793c-83a5-4166-939b-ec5e296138da	d1a0f502-3889-4b9a-9828-b5d78d4ec146	4	development@test.com	\N	columnL	\N
fca598a4-fc87-4020-956e-bdbd2085e580	0	2021-10-04 13:23:18.65696	b7dd4552-90b4-4cf5-879a-9438e00a1afd	2021-10-04 13:23:18.65696	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b7dd4552-90b4-4cf5-879a-9438e00a1afd	2	\N	\N	df7a1a68-75bd-48db-b513-656b8c5e20e6	d1a0f502-3889-4b9a-9828-b5d78d4ec146	3	development@test.com	\N	columnB	\N
90c6becd-592e-4da5-8aa5-20747d781eb7	0	2021-10-04 13:23:18.657709	269ea29f-b6e2-4d61-a26e-bc08942d0f14	2021-10-04 13:23:18.657709	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/269ea29f-b6e2-4d61-a26e-bc08942d0f14	2	\N	\N	c3c31aab-a1e0-4545-a9b7-8a9c4f32c732	d1a0f502-3889-4b9a-9828-b5d78d4ec146	4	development@test.com	\N	columnF	\N
1972c66e-0d7f-4776-806b-eea305091f12	0	2021-10-04 13:23:18.658277	b5d32e45-3bbc-4b41-a96b-75019b8d5773	2021-10-04 13:23:18.658277	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b5d32e45-3bbc-4b41-a96b-75019b8d5773	2	\N	\N	ed95e360-cfec-4a85-be8a-4594e3733d97	d1a0f502-3889-4b9a-9828-b5d78d4ec146	4	development@test.com	\N	columnE2	\N
7c9c4778-4e09-4133-ac9c-d4518adee5b0	0	2021-10-04 13:23:18.658819	b7dd4552-90b4-4cf5-879a-9438e00a1afd	2021-10-04 13:23:18.658819	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b7dd4552-90b4-4cf5-879a-9438e00a1afd	2	\N	\N	8d65b25d-c408-450b-aa7b-c6b58ed484fd	d1a0f502-3889-4b9a-9828-b5d78d4ec146	3	development@test.com	\N	columnC	\N
064a4aec-3db8-4cf7-af1c-187d078781e0	0	2021-10-04 13:23:18.659733	269ea29f-b6e2-4d61-a26e-bc08942d0f14	2021-10-04 13:23:18.659733	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/269ea29f-b6e2-4d61-a26e-bc08942d0f14	2	\N	\N	ed6d980f-8742-4bc5-b92d-2a97e7e0d102	d1a0f502-3889-4b9a-9828-b5d78d4ec146	4	development@test.com	\N	columnE1	\N
eb25c72b-cc39-4400-9039-12c78a4969be	0	2021-10-04 13:23:18.660774	b7dd4552-90b4-4cf5-879a-9438e00a1afd	2021-10-04 13:23:18.660774	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b7dd4552-90b4-4cf5-879a-9438e00a1afd	2	\N	\N	84bbd789-8e27-480f-86c2-1a07ea98b4f1	d1a0f502-3889-4b9a-9828-b5d78d4ec146	3	development@test.com	\N	columnA	\N
d19e8097-6e04-4bb7-b20a-3ff595acfbe7	0	2021-10-04 13:23:18.662071	b5d32e45-3bbc-4b41-a96b-75019b8d5773	2021-10-04 13:23:18.662071	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b5d32e45-3bbc-4b41-a96b-75019b8d5773	2	\N	\N	486cb826-7539-4a9b-9c05-ecf1228c822b	d1a0f502-3889-4b9a-9828-b5d78d4ec146	4	development@test.com	\N	columnJ	\N
7336d38b-7a77-4760-b4c7-ea072ca9635f	0	2021-10-04 13:23:18.663013	269ea29f-b6e2-4d61-a26e-bc08942d0f14	2021-10-04 13:23:18.663013	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/269ea29f-b6e2-4d61-a26e-bc08942d0f14	2	\N	\N	df876664-a82c-4a55-955e-73495243982c	d1a0f502-3889-4b9a-9828-b5d78d4ec146	4	development@test.com	\N	columnH	\N
e86518db-243a-4443-9abd-96bfb794f38c	0	2021-10-04 13:23:18.663785	b5d32e45-3bbc-4b41-a96b-75019b8d5773	2021-10-04 13:23:18.663785	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b5d32e45-3bbc-4b41-a96b-75019b8d5773	2	\N	\N	ee8b4134-1d90-423c-98ae-81dd617454dc	2608400c-7966-47ad-85ea-04eeff4e3de4	4	development@test.com	\N	columnK	\N
32f481fc-c11d-4a58-87d8-002bda10440c	0	2021-10-04 13:23:18.66466	b7dd4552-90b4-4cf5-879a-9438e00a1afd	2021-10-04 13:23:18.66466	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b7dd4552-90b4-4cf5-879a-9438e00a1afd	2	\N	\N	23d4a078-1afa-4b9c-a3cb-49cb0ea2adad	2608400c-7966-47ad-85ea-04eeff4e3de4	3	development@test.com	\N	columnD	\N
ec2c0cd5-b87e-4955-be7f-8020a7eae6ba	0	2021-10-04 13:23:18.66533	b5d32e45-3bbc-4b41-a96b-75019b8d5773	2021-10-04 13:23:18.66533	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/b5d32e45-3bbc-4b41-a96b-75019b8d5773	2	\N	\N	f0fa6596-a9e0-49fa-9bc5-f9d34a9f0a56	2608400c-7966-47ad-85ea-04eeff4e3de4	4	development@test.com	\N	columnM	\N
06807126-23a9-4c3e-b46c-5613da5df691	0	2021-10-04 13:23:18.666031	269ea29f-b6e2-4d61-a26e-bc08942d0f14	2021-10-04 13:23:18.666031	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/269ea29f-b6e2-4d61-a26e-bc08942d0f14	2	\N	\N	0a6693ee-ee94-40dc-b876-563449b8de95	2608400c-7966-47ad-85ea-04eeff4e3de4	4	development@test.com	\N	columnG	\N
f2f5d3b1-3512-4186-9c7e-7b858741b541	0	2021-10-04 13:23:18.666812	269ea29f-b6e2-4d61-a26e-bc08942d0f14	2021-10-04 13:23:18.666812	/bb3deab5-3b2e-418b-9bff-6bd62e49354d/269ea29f-b6e2-4d61-a26e-bc08942d0f14	2	\N	\N	52bde969-5721-4249-b06f-63bb115d8eed	2608400c-7966-47ad-85ea-04eeff4e3de4	4	development@test.com	\N	columnI	\N
cd56c5e5-c19b-4084-a4b3-9a143fda562f	0	2021-10-04 13:23:18.734647	1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2021-10-04 13:23:18.734647	/b5dca58a-c401-4423-acd6-33d391b909c2/1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2	\N	\N	0559336d-0ee0-4b64-8687-d81f50c9ee13	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	5	development@test.com	\N	columnU	\N
75e0517f-257f-4ef4-b40f-9bce70ca2435	0	2021-10-04 13:23:18.735836	1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2021-10-04 13:23:18.735836	/b5dca58a-c401-4423-acd6-33d391b909c2/1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2	\N	\N	fca1e721-e460-43a3-bcee-09fe50fb8043	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	5	development@test.com	\N	columnT	\N
3dd5a3a2-fb16-4859-becc-a17ce1d30775	0	2021-10-04 13:23:18.736459	0cbac9f2-d584-4473-9619-fa49740bf9e2	2021-10-04 13:23:18.736459	/b5dca58a-c401-4423-acd6-33d391b909c2/0cbac9f2-d584-4473-9619-fa49740bf9e2	2	\N	\N	2d007721-5827-40cb-ac6e-20d3416401f7	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	3	development@test.com	\N	columnO	\N
e04dcbc9-0716-44ea-879d-bc0b93e40f2d	0	2021-10-04 13:23:18.736966	0cbac9f2-d584-4473-9619-fa49740bf9e2	2021-10-04 13:23:18.736966	/b5dca58a-c401-4423-acd6-33d391b909c2/0cbac9f2-d584-4473-9619-fa49740bf9e2	2	\N	\N	d645dfe5-fabd-4214-ae30-ade3743348f4	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	3	development@test.com	\N	columnP	\N
31636115-5edb-4034-a131-44c054d3c40d	0	2021-10-04 13:23:18.737448	1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2021-10-04 13:23:18.737448	/b5dca58a-c401-4423-acd6-33d391b909c2/1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2	\N	\N	703d62c4-556b-47ef-9e50-04281ee0987b	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	5	development@test.com	\N	columnE	\N
7aeeaf13-2e6d-4492-ab8d-8d895270767b	0	2021-10-04 13:23:18.737942	1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2021-10-04 13:23:18.737942	/b5dca58a-c401-4423-acd6-33d391b909c2/1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2	\N	\N	b0663109-f082-41b0-908b-c98c8a647492	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	5	development@test.com	\N	columnS	\N
90f026a3-a2b5-48c4-a316-b08594a9e33a	0	2021-10-04 13:23:18.73843	0cbac9f2-d584-4473-9619-fa49740bf9e2	2021-10-04 13:23:18.73843	/b5dca58a-c401-4423-acd6-33d391b909c2/0cbac9f2-d584-4473-9619-fa49740bf9e2	2	\N	\N	05ce9d9f-9e8e-4308-8e7d-391cbffc6d39	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	3	development@test.com	\N	columnN	\N
52548ab2-7357-4783-9ae7-3d0a0df1fa7a	0	2021-10-04 13:23:18.738922	1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2021-10-04 13:23:18.738922	/b5dca58a-c401-4423-acd6-33d391b909c2/1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2	\N	\N	fa155d4e-5f81-40b2-89ee-d536c517d45b	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	5	development@test.com	\N	columnR	\N
d1d64057-8bb1-4247-9a60-44cbc117893b	0	2021-10-04 13:23:18.73942	1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2021-10-04 13:23:18.73942	/b5dca58a-c401-4423-acd6-33d391b909c2/1dec0232-e3fc-4a40-a76c-01cfe1c15e3b	2	\N	\N	acaa4312-50a7-4071-aac5-4d993fad44db	2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	5	development@test.com	\N	columnV	\N
92334819-e343-4606-9291-9507305183c0	0	2021-10-04 13:23:18.739925	0cbac9f2-d584-4473-9619-fa49740bf9e2	2021-10-04 13:23:18.739925	/b5dca58a-c401-4423-acd6-33d391b909c2/0cbac9f2-d584-4473-9619-fa49740bf9e2	2	\N	\N	b996f3e2-d793-46c9-b76b-abd3b2a0666a	06f6c250-c3c2-45ce-93ac-edbfd53e6b30	3	development@test.com	\N	columnQ	\N
\.


--
-- Data for Name: data_model; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.data_model (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag) FROM stdin;
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	3	2021-10-04 13:23:13.342662	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:13.74212	brc	f	admin person	72897474-1e20-4f02-8dae-61a2b39a3484	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Complex Test DataModel	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
dc5e3bb9-9119-4540-a586-2f55380e49f4	1	2021-10-04 13:23:13.927892	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:13.95405	\N	f	\N	d4a492d3-e5aa-41b5-ab5a-2b392da45a99	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Simple Test DataModel	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
f9f834b7-74f5-4b0c-997a-044ac335a9f4	2	2021-10-04 13:23:13.992331	t	f	2021-10-04 13:23:14.03914	1.0.0	f	Data Standard	2021-10-04 13:23:14.068365	\N	f	\N	07970cd2-17f4-4b7c-ae33-20cf4acd1965	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Finalised Example Test DataModel	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	1.0.0	\N
6e73dcde-8ce7-4c45-b37d-0494e55394c9	3	2021-10-04 13:23:14.125076	t	f	2021-10-04 13:23:14.259227	1.0.0	f	Data Standard	2021-10-04 13:23:14.370988	bootStrap	f	bill	bd9d5a42-3874-4023-ac06-1b555543e468	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	1.0.0	\N
926d5e0c-5ee5-457f-9335-3e97d02c08b2	2	2021-10-04 13:23:14.787499	t	f	2021-10-04 13:23:14.837429	1.0.0	f	Data Standard	2021-10-04 13:23:14.883841	bootStrap	f	bill	041ac810-950c-4fc9-8a23-6816ebd439b3	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel fork	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	1.0.0	\N
b3099f15-afde-436a-be99-1300eae98b4e	1	2021-10-04 13:23:15.087315	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:15.11665	bootStrap	f	bill	4fbaf452-5899-4a4a-b410-aa7c3bc3ee33	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel fork	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	2	2021-10-04 13:23:15.890105	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:15.990005	bootStrap	f	bill	9a490544-59bb-4d0b-9be0-e1a7ab444ee9	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	newBranch	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	7	2021-10-04 13:23:15.279709	t	f	2021-10-04 13:23:16.035038	1.0.0	f	Data Standard	2021-10-04 13:23:16.091029	Baal	f	Dante	9398c798-0ba2-4d2a-8de3-641d47d07a5e	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	main	2.0.0	\N
94f194ee-79db-4835-840e-4168bc4d9331	2	2021-10-04 13:23:16.322094	t	f	2021-10-04 13:23:16.367196	1.0.0	f	Data Standard	2021-10-04 13:23:16.412422	Baal	f	Dante	4a5261ca-4770-4be9-a95d-efcbee88dbb8	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	main	3.0.0	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	2021-10-04 13:23:16.862314	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:16.899286	Baal	f	Dante	e11168e5-7df1-49d7-bbcc-723573c54243	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	testBranch	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	2	2021-10-04 13:23:16.628569	t	f	2021-10-04 13:23:16.97742	1.0.0	f	Data Standard	2021-10-04 13:23:17.020029	Baal	f	Dante	65e728b4-c448-4655-be7d-652d49db9761	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	main	4.0.0	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	1	2021-10-04 13:23:17.197419	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:17.234139	Baal	f	Dante	86d9cd5f-5013-4268-92df-064165a45a35	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel another fork	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	2	2021-10-04 13:23:17.403394	t	f	2021-10-04 13:23:17.457463	1.0.0	f	Data Standard	2021-10-04 13:23:17.499777	Baal	f	Dante	a73b7491-71a6-4d8b-8b3b-771234bfe2a5	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	main	5.0.0	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	2021-10-04 13:23:17.660964	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:17.693009	Baal	f	Dante	fc669fcc-adf3-4489-8f90-272e29c74707	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	2	2021-10-04 13:23:17.884151	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:18.007154	Baal	f	Dante	04292741-c682-4018-b513-edb134889b35	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	anotherBranch	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	1	2021-10-04 13:23:18.24735	f	f	\N	1.0.0	f	Data Standard	2021-10-04 13:23:18.2962	Baal	f	Dante	74d6ff7d-0b2e-4fd5-9b97-f2a294efd85c	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Model Version Tree DataModel	default description due to error reading file. see log	b5f79af9-dd57-4da3-844e-122cd65cd031	interestingBranch	\N	\N
bb3deab5-3b2e-418b-9bff-6bd62e49354d	1	2021-10-04 13:23:18.599332	f	f	\N	1.0.0	f	Data Asset	2021-10-04 13:23:18.672236	\N	f	\N	9b607be4-91f4-442e-b484-75eca144fa36	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	SourceFlowDataModel	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
b5dca58a-c401-4423-acd6-33d391b909c2	1	2021-10-04 13:23:18.684669	f	f	\N	1.0.0	f	Data Asset	2021-10-04 13:23:18.74987	\N	f	\N	517a29c7-3527-42a8-8dd2-eaaff44308fc	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	TargetFlowDataModel	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
\.


--
-- Data for Name: data_type; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.data_type (id, version, date_created, domain_type, last_updated, path, depth, breadcrumb_tree_id, data_model_id, idx, created_by, aliases_string, label, description, class, units, reference_class_id, model_resource_id, model_resource_domain_type) FROM stdin;
4e4203aa-47ae-4a9d-9001-a18e91f504f2	0	2021-10-04 13:23:13.721272	ReferenceType	2021-10-04 13:23:13.721272	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	50a3d251-1ea6-4abc-af47-0e29a954ca1a	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	3	development@test.com	\N	child	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.ReferenceType	\N	eb60ac95-5b35-4d6e-a01a-1b5b9a5d70c0	\N	\N
06d39cc7-abb4-4e88-bd98-9fbff34aedbd	1	2021-10-04 13:23:13.541782	EnumerationType	2021-10-04 13:23:13.750456	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	edca429b-ada6-4d0c-b994-2c035ee18530	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	0	development@test.com	\N	yesnounknown	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.EnumerationType	\N	\N	\N	\N
fd61aec8-104f-4ecf-b4cc-7d54fec0c950	1	2021-10-04 13:23:13.564071	PrimitiveType	2021-10-04 13:23:13.752123	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	97a34419-c338-4475-9c57-bbf0f528a625	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
29f5ecf2-270f-4efe-b4a2-04095a88520d	2	2021-10-04 13:23:13.560518	PrimitiveType	2021-10-04 13:23:13.753667	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5	1	8e41bee3-e71d-41c2-a9a7-033b77074fd2	fd8e9d84-825e-4fa7-a070-5301bf6c89e5	2	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
3db65ef9-f4ba-452a-920f-b601b15f56cc	0	2021-10-04 13:23:14.028051	PrimitiveType	2021-10-04 13:23:14.028051	/f9f834b7-74f5-4b0c-997a-044ac335a9f4	1	d763e1ee-5f2a-45fb-b83b-8659d908819a	f9f834b7-74f5-4b0c-997a-044ac335a9f4	0	development@test.com	\N	Finalised Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
cace8c8b-048d-4158-b532-40198892fee4	0	2021-10-04 13:23:14.191515	PrimitiveType	2021-10-04 13:23:14.191515	/6e73dcde-8ce7-4c45-b37d-0494e55394c9	1	5ad8f3f1-2e40-44a7-b0d8-dfb1a2b0a240	6e73dcde-8ce7-4c45-b37d-0494e55394c9	0	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
f4740512-2cbd-4ad7-9ebb-ed6e7874fefe	0	2021-10-04 13:23:14.811527	PrimitiveType	2021-10-04 13:23:14.811527	/926d5e0c-5ee5-457f-9335-3e97d02c08b2	1	2fa73a84-7433-4584-8733-24c271beeb98	926d5e0c-5ee5-457f-9335-3e97d02c08b2	0	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
965d3adf-1328-4863-90b4-8ac988f38e57	0	2021-10-04 13:23:15.102219	PrimitiveType	2021-10-04 13:23:15.102219	/b3099f15-afde-436a-be99-1300eae98b4e	1	7cd9214e-728b-406b-bb47-cbcb6cc2bbaa	b3099f15-afde-436a-be99-1300eae98b4e	0	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
91ff3163-6a80-4e19-8ce2-172bb446ce15	0	2021-10-04 13:23:15.293254	PrimitiveType	2021-10-04 13:23:15.293254	/c5c83da4-47de-44f2-a5fd-414ac1f13900	1	2fff3115-3fc8-4181-b63c-f0f5b14434dd	c5c83da4-47de-44f2-a5fd-414ac1f13900	0	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
1e2be421-1894-4297-a557-3ae7e40fea96	0	2021-10-04 13:23:15.374344	PrimitiveType	2021-10-04 13:23:15.374344	/c5c83da4-47de-44f2-a5fd-414ac1f13900	1	e08b48c1-354d-4bb9-b2f4-d013fbc49c65	c5c83da4-47de-44f2-a5fd-414ac1f13900	2	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
0f4824f3-305c-4b2b-9533-9c9a3425aa4e	0	2021-10-04 13:23:15.375763	PrimitiveType	2021-10-04 13:23:15.375763	/c5c83da4-47de-44f2-a5fd-414ac1f13900	1	4ab05dd3-f49d-4c22-b240-d226d3c41220	c5c83da4-47de-44f2-a5fd-414ac1f13900	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
0ef863c6-a0b2-4cc0-b9ab-014a5114f108	0	2021-10-04 13:23:15.376627	PrimitiveType	2021-10-04 13:23:15.376627	/c5c83da4-47de-44f2-a5fd-414ac1f13900	1	1452d16f-c428-4549-828e-378272c7981d	c5c83da4-47de-44f2-a5fd-414ac1f13900	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
ada0765e-5d5d-4175-9c5f-a48e286661ea	0	2021-10-04 13:23:15.902599	PrimitiveType	2021-10-04 13:23:15.902599	/c84fb099-79bc-496a-8901-75c99d539fbd	1	539c3326-c782-415b-9195-c66dc04d50e9	c84fb099-79bc-496a-8901-75c99d539fbd	0	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
4d7380c2-06a6-4da9-8a65-29bf621ba152	0	2021-10-04 13:23:15.965092	EnumerationType	2021-10-04 13:23:15.965092	/c84fb099-79bc-496a-8901-75c99d539fbd	1	daee824a-efeb-47bd-8b30-59d876765ebb	c84fb099-79bc-496a-8901-75c99d539fbd	3	development@test.com	\N	catdogfish	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.EnumerationType	\N	\N	\N	\N
86814478-32ca-488c-9802-61b22091efb3	0	2021-10-04 13:23:15.973149	PrimitiveType	2021-10-04 13:23:15.973149	/c84fb099-79bc-496a-8901-75c99d539fbd	1	1d128791-8c7c-4e32-a362-aeac4bbcd320	c84fb099-79bc-496a-8901-75c99d539fbd	3	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
2124ad0b-e2f1-46dd-bf2f-f02f0c6b3b90	0	2021-10-04 13:23:15.975139	PrimitiveType	2021-10-04 13:23:15.975139	/c84fb099-79bc-496a-8901-75c99d539fbd	1	34b4025a-2437-4196-96a8-e2c42249c2ec	c84fb099-79bc-496a-8901-75c99d539fbd	3	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
30c1996b-46d8-44a8-9e9f-161df68a8d41	0	2021-10-04 13:23:16.337372	PrimitiveType	2021-10-04 13:23:16.337372	/94f194ee-79db-4835-840e-4168bc4d9331	1	6ca03011-5238-4cd7-9e30-1d91898669c3	94f194ee-79db-4835-840e-4168bc4d9331	2	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
1c25775a-00bf-4221-91d4-5f644c764637	0	2021-10-04 13:23:16.33902	PrimitiveType	2021-10-04 13:23:16.33902	/94f194ee-79db-4835-840e-4168bc4d9331	1	f41dec0e-d994-453c-9b1e-3e599a2bf5db	94f194ee-79db-4835-840e-4168bc4d9331	0	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
dd2caaa3-67ad-49f5-80f8-bc6978351fb2	0	2021-10-04 13:23:16.339789	PrimitiveType	2021-10-04 13:23:16.339789	/94f194ee-79db-4835-840e-4168bc4d9331	1	b0b89b39-39ea-4187-b597-b789d507ad05	94f194ee-79db-4835-840e-4168bc4d9331	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
0d203b8d-8f47-432f-95da-535e8967328c	0	2021-10-04 13:23:16.340393	PrimitiveType	2021-10-04 13:23:16.340393	/94f194ee-79db-4835-840e-4168bc4d9331	1	8e0fa4ba-d390-490a-a91e-436a493c5591	94f194ee-79db-4835-840e-4168bc4d9331	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
850a0c33-0121-43de-ae1c-e1ff5bab6f0a	0	2021-10-04 13:23:16.647979	PrimitiveType	2021-10-04 13:23:16.647979	/726b5b98-4b02-433d-9e3b-249f139a27dc	1	96f1033b-daf5-47e3-a244-472c5276a30b	726b5b98-4b02-433d-9e3b-249f139a27dc	2	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
debd425a-6c2f-41c2-918f-cf7bd81030bd	0	2021-10-04 13:23:16.649644	PrimitiveType	2021-10-04 13:23:16.649644	/726b5b98-4b02-433d-9e3b-249f139a27dc	1	7228119b-649a-4d22-bd55-2ca40437926b	726b5b98-4b02-433d-9e3b-249f139a27dc	0	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
08ca0f68-87a1-474b-bffd-98c43c6fcc93	0	2021-10-04 13:23:16.65061	PrimitiveType	2021-10-04 13:23:16.65061	/726b5b98-4b02-433d-9e3b-249f139a27dc	1	d0600903-ea99-4431-bae2-4d8def4d8bcf	726b5b98-4b02-433d-9e3b-249f139a27dc	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
e7c6df2f-f1c5-4936-98e3-e06613890815	0	2021-10-04 13:23:16.651625	PrimitiveType	2021-10-04 13:23:16.651625	/726b5b98-4b02-433d-9e3b-249f139a27dc	1	0d0fe1db-d2a9-4111-b603-117909c99b5c	726b5b98-4b02-433d-9e3b-249f139a27dc	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
b12a75f4-bb3f-4e23-a154-a0345414358a	0	2021-10-04 13:23:16.875945	PrimitiveType	2021-10-04 13:23:16.875945	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	149fc25e-c973-4142-bb43-de4d77b38c05	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	2	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
a0f7ca74-465f-4968-8f83-9ea2f6b9007d	0	2021-10-04 13:23:16.877363	PrimitiveType	2021-10-04 13:23:16.877363	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	c8f53e45-43ed-482c-8eeb-2a27d7f30be8	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	0	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
dcf77ff3-d2c8-4b21-a64e-006e65077418	0	2021-10-04 13:23:16.878026	PrimitiveType	2021-10-04 13:23:16.878026	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	b6b0e02a-b599-4a21-b763-5ab6d50ae3ac	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
ed7c2eb7-4161-487a-b5f8-99f54d19f81e	0	2021-10-04 13:23:16.878576	PrimitiveType	2021-10-04 13:23:16.878576	/73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	1	9a8ac959-325a-4c6d-abb4-4bb012bfa7e9	73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
7c3556c9-bf46-4378-945a-32ae5bfa1cc3	0	2021-10-04 13:23:17.216099	PrimitiveType	2021-10-04 13:23:17.216099	/9dd076ab-1240-474c-a3cb-5ef48863c208	1	2245fab3-5bab-42bb-96a9-88dcbd2dbea1	9dd076ab-1240-474c-a3cb-5ef48863c208	2	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
241cd456-e9ff-4521-9d8a-157438b29e85	0	2021-10-04 13:23:17.217708	PrimitiveType	2021-10-04 13:23:17.217708	/9dd076ab-1240-474c-a3cb-5ef48863c208	1	d2647eec-8cdb-425b-ada7-64e2bfab5f11	9dd076ab-1240-474c-a3cb-5ef48863c208	0	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
e762cdf4-e140-49e1-837d-f8a50bf85150	0	2021-10-04 13:23:17.218521	PrimitiveType	2021-10-04 13:23:17.218521	/9dd076ab-1240-474c-a3cb-5ef48863c208	1	2c1eba02-df6a-479f-a02c-cf685fb7d4f4	9dd076ab-1240-474c-a3cb-5ef48863c208	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
05868455-f7e3-4775-b563-4966b2550c73	0	2021-10-04 13:23:17.219135	PrimitiveType	2021-10-04 13:23:17.219135	/9dd076ab-1240-474c-a3cb-5ef48863c208	1	922fd3f0-69ef-4318-a66a-02fd4ea0f98e	9dd076ab-1240-474c-a3cb-5ef48863c208	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
92585be7-eb1d-4331-9f8b-20277bc3a3fe	0	2021-10-04 13:23:17.42028	PrimitiveType	2021-10-04 13:23:17.42028	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	6b8459c4-4cfe-4a6d-89be-deb3b8415172	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	2	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
0c313d45-1561-4e04-b881-9efc36ed3976	0	2021-10-04 13:23:17.421866	PrimitiveType	2021-10-04 13:23:17.421866	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	b3daeca0-6ad3-4c1b-a035-df421cb4a808	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	0	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
614e12ea-d510-4320-9be4-372af71d5e47	0	2021-10-04 13:23:17.422616	PrimitiveType	2021-10-04 13:23:17.422616	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	f5bb5db4-688e-4ec4-9e95-03ae55fe0e5e	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
55d78ee3-5908-48a5-8656-820256047de3	0	2021-10-04 13:23:17.423228	PrimitiveType	2021-10-04 13:23:17.423228	/20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	1	ed6f2a16-5029-460c-a776-97af5348a1fd	20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
700f81b0-5f14-43b6-b846-2d32a666ab56	0	2021-10-04 13:23:17.676078	PrimitiveType	2021-10-04 13:23:17.676078	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	0bd88e0f-3dba-4190-ae28-3c3a19406ad2	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	2	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
b2082605-ace7-4bb8-ac47-ae9b4cabb112	0	2021-10-04 13:23:17.677482	PrimitiveType	2021-10-04 13:23:17.677482	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	5132aa9c-b056-4e8b-9da9-87813f2b6ec5	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	0	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
25976300-071b-48b0-bc64-940ddaca293d	0	2021-10-04 13:23:17.678096	PrimitiveType	2021-10-04 13:23:17.678096	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	3ab03bcf-7dc1-4966-9557-a1b21341bbe1	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
4da5448a-a9dc-4ace-a777-a5dbd602cc9a	0	2021-10-04 13:23:17.678611	PrimitiveType	2021-10-04 13:23:17.678611	/c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	1	ab0ebce0-9279-4aad-b0ca-a5e4865959a9	c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
944f49a0-eec3-4d75-8476-1fd4dde40a76	0	2021-10-04 13:23:17.899517	PrimitiveType	2021-10-04 13:23:17.899517	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	393fb147-0319-492a-a15d-ed47ede8908e	eb5a08e6-844e-47c1-a31f-160dd238c202	2	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
10a25708-2580-4ca4-88de-21348e805ca8	0	2021-10-04 13:23:17.900839	PrimitiveType	2021-10-04 13:23:17.900839	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	5e1973b9-7d68-4b4e-a7fa-90db5e18ac30	eb5a08e6-844e-47c1-a31f-160dd238c202	0	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
f43a3684-69de-418a-b22e-72b925c7f9d5	0	2021-10-04 13:23:17.90138	PrimitiveType	2021-10-04 13:23:17.90138	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	cd6801ee-5f64-4157-bfee-98236733fc8d	eb5a08e6-844e-47c1-a31f-160dd238c202	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
241094fa-817f-41c8-aa73-0cbf44f727ce	0	2021-10-04 13:23:17.901866	PrimitiveType	2021-10-04 13:23:17.901866	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	00006932-a566-4fc7-8f38-9668928e79da	eb5a08e6-844e-47c1-a31f-160dd238c202	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
3b93f98a-b33a-4cba-9a1e-f92b7583dd25	0	2021-10-04 13:23:17.994904	PrimitiveType	2021-10-04 13:23:17.994904	/eb5a08e6-844e-47c1-a31f-160dd238c202	1	2bafc74d-c557-49b8-822d-83281c75a9f1	eb5a08e6-844e-47c1-a31f-160dd238c202	4	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
2be54098-04ed-4795-8fcd-81a8f29e67a8	0	2021-10-04 13:23:18.2753	PrimitiveType	2021-10-04 13:23:18.2753	/4b01f763-2505-46a2-938b-88622ca2eaa8	1	c30e94a5-561e-4e46-9e41-5f2236fc696c	4b01f763-2505-46a2-938b-88622ca2eaa8	2	development@test.com	\N	V1 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
85480359-f7ba-4e7d-af94-ec2392733e3f	0	2021-10-04 13:23:18.2775	PrimitiveType	2021-10-04 13:23:18.2775	/4b01f763-2505-46a2-938b-88622ca2eaa8	1	2b0dd363-4ea3-483c-aa33-4bb5fa370261	4b01f763-2505-46a2-938b-88622ca2eaa8	0	development@test.com	\N	V2 Data Type	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
ad70193a-c09e-4ea5-97f0-17fed041198e	0	2021-10-04 13:23:18.278619	PrimitiveType	2021-10-04 13:23:18.278619	/4b01f763-2505-46a2-938b-88622ca2eaa8	1	46b52925-d7b1-4d40-9963-3698ef34b1f7	4b01f763-2505-46a2-938b-88622ca2eaa8	1	development@test.com	\N	V2 Data Type 2	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
b3ecf027-4cb6-44c2-87cf-dd2570883ed2	0	2021-10-04 13:23:18.27948	PrimitiveType	2021-10-04 13:23:18.27948	/4b01f763-2505-46a2-938b-88622ca2eaa8	1	68d1d2f3-54cb-4994-8de5-45aa2439f107	4b01f763-2505-46a2-938b-88622ca2eaa8	3	development@test.com	\N	V2 Data Type 3	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
d1a0f502-3889-4b9a-9828-b5d78d4ec146	0	2021-10-04 13:23:18.653615	PrimitiveType	2021-10-04 13:23:18.653615	/bb3deab5-3b2e-418b-9bff-6bd62e49354d	1	c39b1ea2-34db-421a-8b9d-8319046c3f84	bb3deab5-3b2e-418b-9bff-6bd62e49354d	1	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
2608400c-7966-47ad-85ea-04eeff4e3de4	0	2021-10-04 13:23:18.654883	PrimitiveType	2021-10-04 13:23:18.654883	/bb3deab5-3b2e-418b-9bff-6bd62e49354d	1	df24db80-b9db-4d9b-a5ef-f0142b1464fa	bb3deab5-3b2e-418b-9bff-6bd62e49354d	0	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
2ba8bfb2-8986-4755-b4d5-ae92baf96a9d	0	2021-10-04 13:23:18.7331	PrimitiveType	2021-10-04 13:23:18.7331	/b5dca58a-c401-4423-acd6-33d391b909c2	1	d4bd816a-5dce-44ba-9b15-f7a3c4d081e4	b5dca58a-c401-4423-acd6-33d391b909c2	1	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
06f6c250-c3c2-45ce-93ac-edbfd53e6b30	0	2021-10-04 13:23:18.734101	PrimitiveType	2021-10-04 13:23:18.734101	/b5dca58a-c401-4423-acd6-33d391b909c2	1	4d2eb56e-9d2a-459d-a4ea-3dcaa1a46e93	b5dca58a-c401-4423-acd6-33d391b909c2	0	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.datamodel.item.datatype.PrimitiveType	\N	\N	\N	\N
\.


--
-- Data for Name: enumeration_value; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.enumeration_value (id, version, date_created, enumeration_type_id, value, last_updated, path, depth, breadcrumb_tree_id, idx, category, created_by, aliases_string, key, label, description) FROM stdin;
f0520e45-c4e1-49f7-949a-0bb2b88b17c2	0	2021-10-04 13:23:13.565845	06d39cc7-abb4-4e88-bd98-9fbff34aedbd	Yes	2021-10-04 13:23:13.565845	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5/06d39cc7-abb4-4e88-bd98-9fbff34aedbd	2	78a77d3e-8802-449f-9e1a-1e325020003a	0	\N	development@test.com	\N	Y	Y	Yes
fcdffb5e-d0b9-4653-9159-2cfd205ad5fb	0	2021-10-04 13:23:13.56997	06d39cc7-abb4-4e88-bd98-9fbff34aedbd	No	2021-10-04 13:23:13.56997	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5/06d39cc7-abb4-4e88-bd98-9fbff34aedbd	2	e1f04439-e484-4296-a577-3772a7cf48cd	1	\N	development@test.com	\N	N	N	No
2906de04-8fcb-4fd6-b264-65d50661de1a	0	2021-10-04 13:23:13.572903	06d39cc7-abb4-4e88-bd98-9fbff34aedbd	Unknown	2021-10-04 13:23:13.572903	/fd8e9d84-825e-4fa7-a070-5301bf6c89e5/06d39cc7-abb4-4e88-bd98-9fbff34aedbd	2	a96e6f9a-dde2-40af-a91c-442d9e74a93f	2	\N	development@test.com	\N	U	U	Unknown
9d5cdf70-bf5d-4c30-9672-b58520c91395	0	2021-10-04 13:23:15.976123	4d7380c2-06a6-4da9-8a65-29bf621ba152	Cat	2021-10-04 13:23:15.976123	/c84fb099-79bc-496a-8901-75c99d539fbd/4d7380c2-06a6-4da9-8a65-29bf621ba152	2	fa851ad8-27e6-4845-8fac-f023a1f8659e	0	\N	development@test.com	\N	C	C	Cat
75b7fa46-613c-4c28-93b9-816fa81d7492	0	2021-10-04 13:23:15.977358	4d7380c2-06a6-4da9-8a65-29bf621ba152	Dog	2021-10-04 13:23:15.977358	/c84fb099-79bc-496a-8901-75c99d539fbd/4d7380c2-06a6-4da9-8a65-29bf621ba152	2	001e0df1-e48b-4502-9338-e97ac67e8dd8	1	\N	development@test.com	\N	D	D	Dog
fb23ef19-76a4-442f-b51d-39d331115360	0	2021-10-04 13:23:15.978485	4d7380c2-06a6-4da9-8a65-29bf621ba152	Fish	2021-10-04 13:23:15.978485	/c84fb099-79bc-496a-8901-75c99d539fbd/4d7380c2-06a6-4da9-8a65-29bf621ba152	2	0e5ecc5d-4472-49f8-83f8-46023626353a	2	\N	development@test.com	\N	F	F	Fish
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.1.0	datamodel	SQL	V1_1_0__datamodel.sql	-1078313268	maurodatamapper	2021-10-04 13:23:08.616972	179	t
2	1.5.1	add authority to datamodel	SQL	V1_5_1__add_authority_to_datamodel.sql	-189904092	maurodatamapper	2021-10-04 13:23:08.801707	2	t
3	1.6.0	add extra model properties to datamodel	SQL	V1_6_0__add_extra_model_properties_to_datamodel.sql	1674821418	maurodatamapper	2021-10-04 13:23:08.80702	1	t
4	1.9.0	make sure data model type is correct	SQL	V1_9_0__make_sure_data_model_type_is_correct.sql	-1826314098	maurodatamapper	2021-10-04 13:23:08.811182	1	t
5	1.11.0	add model data type	SQL	V1_11_0__add_model_data_type.sql	-1282220622	maurodatamapper	2021-10-04 13:23:08.816057	1	t
6	1.15.1	add rule to datamodel	SQL	V1_15_1__add_rule_to_datamodel.sql	1543299352	maurodatamapper	2021-10-04 13:23:08.820161	7	t
7	2.0.0	add model version tag to datamodel	SQL	V2_0_0__add_model_version_tag_to_datamodel.sql	999639261	maurodatamapper	2021-10-04 13:23:08.830637	1	t
8	2.1.0	model import	SQL	V2_1_0__model_import.sql	-67495030	maurodatamapper	2021-10-04 13:23:08.834862	3	t
9	2.1.1	model extend	SQL	V2_1_1__model_extend.sql	827809470	maurodatamapper	2021-10-04 13:23:08.841151	2	t
10	2.2.0	rename catalogue item to multi facet	SQL	V2_2_0__rename_catalogue_item_to_multi_facet.sql	1051322676	maurodatamapper	2021-10-04 13:23:08.84693	1	t
11	2.2.1	remove model import export	SQL	V2_2_1__remove_model_import_export.sql	1494610551	maurodatamapper	2021-10-04 13:23:08.850754	4	t
12	2.2.3	add dataclass extension	SQL	V2_2_3__add_dataclass_extension.sql	601991483	maurodatamapper	2021-10-04 13:23:08.860287	3	t
13	2.2.4	add importing	SQL	V2_2_4__add_importing.sql	-1631221524	maurodatamapper	2021-10-04 13:23:08.866588	13	t
14	2.10.0	fix erroneous new model of and wrong direction version links	SQL	V2_10_0__fix_erroneous_new_model_of_and_wrong_direction_version_links.sql	-440622816	maurodatamapper	2021-10-04 13:23:08.883066	5	t
15	2.11.0	update database metadata values	SQL	V2_11_0__update_database_metadata_values.sql	-738055149	maurodatamapper	2021-10-04 13:23:08.891204	26	t
\.


--
-- Data for Name: join_dataclass_to_extended_data_class; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_dataclass_to_extended_data_class (dataclass_id, extended_dataclass_id) FROM stdin;
\.


--
-- Data for Name: join_dataclass_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_dataclass_to_facet (dataclass_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
ae701c79-ea4a-4e1f-be85-281f2e7281dd	\N	\N	\N	\N	\N	\N	a8306ad2-70a0-4187-b295-b495b1e967cc
83fba1d1-0d86-4178-9dbe-91b6554d2b70	\N	\N	a1ea3244-3d67-4f38-8346-ce39f31f2f50	\N	\N	\N	\N
68d946d6-a0da-4859-a4df-7c14c9831d38	\N	\N	\N	\N	60af69cf-f515-487c-8bae-8e7338f62d70	\N	\N
81ea24dc-03de-4e25-8649-9778c6f53055	\N	\N	5f040d95-3a25-4635-915c-949355596bb8	\N	\N	\N	\N
f7dba7bd-8c19-4dab-a5da-8737bbbcf0a2	\N	\N	cdf50113-da93-49da-89d3-015aaac930c7	\N	\N	\N	\N
059983db-5a11-4aa6-b910-e736e8303008	\N	\N	fa8f3113-1bbe-4d12-b002-c54c6e4e7587	\N	\N	\N	\N
52fccb51-0cb1-477a-8047-04ce51c7f643	\N	\N	53dbc354-d7dd-464d-8b49-b7321544588e	\N	\N	\N	\N
dd87ad23-df5a-4194-a2b0-9a0876c79ee4	\N	\N	cc1aae67-5e66-444a-abdf-7aa18354a16f	\N	\N	\N	\N
f95847c0-c163-4ca7-be79-e26e309e454e	\N	\N	c3b9a0b5-1a04-4db0-b997-c46e7a8b07e9	\N	\N	\N	\N
3627da01-784f-469e-b9d5-e043291c5ec9	\N	\N	45b23945-f1e7-4e8e-aae1-350468ebf8d1	\N	\N	\N	\N
72b25cd5-5294-43e1-b366-540d649412e1	\N	\N	5f564858-abf1-4132-8be5-43362b7f0202	\N	\N	\N	\N
b0808edb-75a9-4204-baca-3af4fe2ba053	\N	\N	ef2b6f06-8c73-4398-83ca-ab5dd9aa78bc	\N	\N	\N	\N
2211dfeb-5b7c-4022-923a-fb4e205a8bbc	\N	\N	7cecab12-cd7b-4a19-92ab-9aab6b42af52	\N	\N	\N	\N
5abb9deb-b2f1-4e7b-ac60-6fc576131858	\N	\N	40597532-dd16-4272-afd8-89ee494f3ee9	\N	\N	\N	\N
ab2384cf-eafa-4693-ac91-9f155e0d0058	\N	\N	0b53bc74-9bd1-48eb-81af-2efd48392371	\N	\N	\N	\N
e4656cb5-fe45-494f-8b83-46c1c397de23	\N	\N	f163abd6-04c7-44dc-8d3d-07fc3942bc48	\N	\N	\N	\N
5826b473-352e-4bf3-bce2-2ff97be6c197	\N	\N	893a8cd7-89ca-4e30-ab51-c97cd82d2a62	\N	\N	\N	\N
7bef5540-b2c5-4c5c-b2db-37053c270a75	\N	\N	cea5125e-0bc1-431e-b1a8-65ad49ed149d	\N	\N	\N	\N
b0616a77-ed8b-4ff4-883a-9494a0e8e821	\N	\N	eb2e8eca-ed06-4e0b-8038-d6188acdb0eb	\N	\N	\N	\N
01bc3883-ffae-4824-9044-7d1cd7719ec1	\N	\N	b0b90211-1479-45b5-9707-4367555b75e6	\N	\N	\N	\N
45122b94-5b79-4826-9afa-531042bba78a	\N	\N	8796fddd-10b4-4e2d-af92-81b3a93687a0	\N	\N	\N	\N
4f7b9a1e-4b81-43c1-af61-1061f6ddea54	\N	\N	5220ffaa-aefb-459b-8242-32f078e26d29	\N	\N	\N	\N
71d70845-8359-4e06-93f4-d31984cb31c3	\N	\N	557b2f2e-d966-4ad1-85fe-9ba0142cc85c	\N	\N	\N	\N
c5b99d99-be9f-4639-ad03-feaeaed2188e	\N	\N	9ac5f285-0736-47dc-93ef-fd8018f23170	\N	\N	\N	\N
efd359cc-066f-4c58-b1e4-53db8085d44e	\N	\N	d1c15c48-48c1-4f63-9f44-b50ab15c8ccc	\N	\N	\N	\N
3ccdd107-b935-4a0c-91b6-5f10f03c46a6	\N	\N	9f57caae-fca4-4aa6-95d6-1b7554b35180	\N	\N	\N	\N
46152471-14dd-42af-9fb7-75b804e4f7fa	\N	\N	75da67af-214c-4f75-9553-03ae5b0549e8	\N	\N	\N	\N
5f2c57bc-4547-42e8-b777-7ee3e7f9715c	\N	\N	c6b07905-acf9-4289-9cb0-dd56e3d2d161	\N	\N	\N	\N
a099fc92-d9ca-4fa1-a74c-63a788819f68	\N	\N	a2a7452e-edfe-4504-ab62-5cc6439597fb	\N	\N	\N	\N
41664fd2-5942-480a-9463-129c1afb2aa2	\N	\N	21d1f364-3feb-4c28-9048-094b06ada155	\N	\N	\N	\N
4b806f2b-ff4e-4bda-9543-ca8e51eb3ebe	\N	\N	4e175fa3-4f84-48f6-9d39-a0a88e82b39b	\N	\N	\N	\N
70875f36-5b39-4d4d-b933-0dcd4e4f7f01	\N	\N	7231d6b8-f576-4a57-8817-cd1ba979c808	\N	\N	\N	\N
7141fcdc-88a4-4580-bfdf-dc32ed481b93	\N	\N	0e4d9ece-ee99-4787-82b1-1cb8a3419190	\N	\N	\N	\N
8865dc91-1795-4512-90cc-933206f36596	\N	\N	ae357927-da7c-4461-8c1e-99eadeb791fe	\N	\N	\N	\N
9b10c08e-06cc-47d2-932c-c27ca10f55ad	\N	\N	db3ef042-7866-4b10-a163-72c29da67005	\N	\N	\N	\N
f4678c70-3aae-426e-83ce-d812b89fc186	\N	\N	7eca6db0-aa88-4ab1-85b6-051b457ffda3	\N	\N	\N	\N
1fa88da0-c245-4981-888d-3872abed48c1	\N	\N	829190d6-a934-46a5-99e9-11e548ae6ddd	\N	\N	\N	\N
5c58f136-c4b9-4a4e-8142-936660b4fa77	\N	\N	18b1c776-1b9d-4b1d-bd79-dd4c6b482101	\N	\N	\N	\N
8eef006c-8b01-48cc-9048-9d22aa47e7f5	\N	\N	f82d2d45-4f22-41ed-8410-a1010151e39f	\N	\N	\N	\N
953e8504-acce-452b-93ec-a9ab2817d26f	\N	\N	f5f3d781-99ec-4a18-9984-c29811de6972	\N	\N	\N	\N
11fee8e1-0b53-4ead-9e0e-2af94b8b3e1e	\N	\N	76fe25e3-73d9-475c-932d-b37da4368698	\N	\N	\N	\N
4cc41c61-2ff7-4325-8289-5efd97dd789d	\N	\N	b84b3889-3f45-479e-9a62-db9afe3ee0e9	\N	\N	\N	\N
678ef0af-95ca-4fde-9d84-dc3fcdabc7e0	\N	\N	4889601e-dab2-4c26-b479-df797d4f7309	\N	\N	\N	\N
94b17a72-c378-44b3-9ff7-1b1316e4575c	\N	\N	12afb26b-9e84-4855-aa7a-3844413f9adc	\N	\N	\N	\N
b3c484a4-9928-4e28-a2e9-256234a01cf5	\N	\N	050309f5-4cfe-44f0-986f-1c6762ddd9d3	\N	\N	\N	\N
04c258ba-d2c3-47b0-9587-e79f88844ab4	\N	\N	910979bf-f361-46e6-8525-21478e759cc2	\N	\N	\N	\N
1571b213-46cb-4287-abe5-015be482575a	\N	\N	3ec59865-405c-4a13-a58e-43b8204a8358	\N	\N	\N	\N
3c21c07e-ea7c-4345-a2ac-f450289200d9	\N	\N	01a8286b-edfa-4b4e-9810-9d20ed5bcaa1	\N	\N	\N	\N
9d1f62b9-a19b-44f8-b5c3-971665681c43	\N	\N	8f877d1e-9d4b-46f8-9b1a-e930c5c82fa4	\N	\N	\N	\N
b0041c32-46a2-4427-9f99-e1f9544e7949	\N	\N	f12573ae-b8a2-489d-9ec5-cc33b3bd21c4	\N	\N	\N	\N
c52b5d6f-ffe0-4984-946b-adfcb4cf1a35	\N	\N	fd6b5c7d-03df-464b-914c-c1d605db1d79	\N	\N	\N	\N
1b151ae1-2b74-44a4-a865-28a521b61d68	\N	\N	fdd6028b-2a22-4dde-8ae6-7d070d6f383c	\N	\N	\N	\N
2337c502-9095-4159-89ec-affc7f0e0535	\N	\N	609f65b1-863f-44af-9d64-9d346dfea96d	\N	\N	\N	\N
2337c502-9095-4159-89ec-affc7f0e0535	\N	\N	\N	\N	75c9b891-6e11-4208-a0bd-be602dd99f79	\N	\N
864840e4-8a66-40a0-9ee5-63b429410541	\N	\N	7c85877a-6d30-433e-a653-35d548161a19	\N	\N	\N	\N
ad087a7f-a365-451d-8f43-62f4a23d3303	\N	\N	67c50f74-f0e9-4a6f-bf87-16d5b0e10eee	\N	\N	\N	\N
b55ac619-f4c0-4d6d-86da-f02b868df7b1	\N	\N	7c9a02e3-855f-4814-bb71-4214b74d60c4	\N	\N	\N	\N
d87845e7-f37a-4e56-9b64-a164397b8ead	\N	\N	8dfbdd06-b077-4bab-8dd2-92ecc7a44f78	\N	\N	\N	\N
3e429da2-561b-48dd-bf3d-a1e28d574cc1	\N	\N	31f4cb22-841f-4541-8fc1-4d44d5f062cc	\N	\N	\N	\N
\.


--
-- Data for Name: join_dataclass_to_imported_data_class; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_dataclass_to_imported_data_class (imported_dataclass_id, dataclass_id) FROM stdin;
\.


--
-- Data for Name: join_dataclass_to_imported_data_element; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_dataclass_to_imported_data_element (dataclass_id, imported_dataelement_id) FROM stdin;
\.


--
-- Data for Name: join_dataelement_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_dataelement_to_facet (dataelement_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
6bf2400f-a673-422b-ab73-62b658f81b55	\N	\N	\N	\N	\N	\N	431c98c4-a11e-4d07-9ca6-c1dc505ff76c
e69b07fa-9bbe-4f97-bbfa-c74d2dee68d2	\N	\N	6a3bf799-8a78-4a19-9d26-16a3f573f36d	\N	\N	\N	\N
1249f4b2-2375-4b5f-82fb-439a11f8c740	\N	\N	6cc6da08-0a17-4caf-a5c6-72f2d0267411	\N	\N	\N	\N
3beb7b0c-e257-4d8b-af26-8c5e903ba2fc	\N	\N	fcf220fb-c93e-4254-899c-7dd9027214c0	\N	\N	\N	\N
76d51770-c7f7-44e5-bf40-281dac1f4bfd	\N	\N	7aa60882-3f5c-4458-b7be-0656103ffbd6	\N	\N	\N	\N
b3109d79-5844-4792-b8e3-9420aaada6bc	\N	\N	7af6efb7-3253-4137-b955-44c8c442b9d7	\N	\N	\N	\N
eab6604d-b223-45eb-9003-ab956d4152ca	\N	\N	5f4a31fa-be88-4e94-929a-e94c21ef73ea	\N	\N	\N	\N
17981a0d-014d-4c4f-ac24-04eb88a49f7b	\N	\N	7e917a6d-b9e7-4af4-92b2-74ae7a870d14	\N	\N	\N	\N
53b89bcf-fc38-43c2-8724-55273eb182e9	\N	\N	c0622187-f0e3-4b2c-b2ed-ff7fd3f71884	\N	\N	\N	\N
125027e4-d56f-4c44-9afc-d6043aef4e88	\N	\N	51255426-ca4f-4ab1-8708-bd211d22291b	\N	\N	\N	\N
27d9fd52-c55b-485e-a9ab-78b381b4b593	\N	\N	307b6513-aba0-4bc9-a821-2b4bf71f8c0f	\N	\N	\N	\N
104bf289-d3de-427c-9b28-cd98fe166d1c	\N	\N	45f5ef00-c2eb-4bdc-b872-fa0a932b0051	\N	\N	\N	\N
3f7904a3-8043-4b5a-8f96-3801da3949d7	\N	\N	cc3710cb-c7da-4d38-aebd-2c3232decff2	\N	\N	\N	\N
47e4279d-543a-41bd-96ed-2e16f3d2f3de	\N	\N	d2294332-93bb-454e-a8e6-e4570b1329ef	\N	\N	\N	\N
68c07e75-1cec-4147-8476-8cc03c0d28a2	\N	\N	b15802f6-958c-4a26-8386-ff63bea31416	\N	\N	\N	\N
c4893582-8316-4c72-b6cc-b9b3edf6de22	\N	\N	dc89366f-88bd-4507-8f93-333116f999c8	\N	\N	\N	\N
d6da4efc-eea5-4a83-8554-9f28c9137d0f	\N	\N	79762f83-31ca-4df7-b0a4-1a89b593be3a	\N	\N	\N	\N
ef1d9eda-1666-4102-8614-a20636c138c1	\N	\N	d8655cd1-80fd-41bd-95cd-2f2b199e1449	\N	\N	\N	\N
0faa2a77-0da9-45d4-a41d-18d7216b8b3b	\N	\N	782b5cf0-d7b4-4b79-a84f-b6f93e04d673	\N	\N	\N	\N
34e1a169-59b0-48b0-a7ee-82811742e4a9	\N	\N	92586f74-b88b-413d-95dc-2a1fbe440335	\N	\N	\N	\N
ae063f71-0c7b-4019-9741-0fb249d10826	\N	\N	9e8c502b-c011-4d08-aa6a-4365d2534967	\N	\N	\N	\N
1b80f6d8-8e4c-4611-85ce-f2bb134537ea	\N	\N	fd7df5fc-0e5b-4033-9af1-1017578b20ae	\N	\N	\N	\N
2663298a-f6fc-4c3e-a496-b3116a2cd986	\N	\N	8c414258-8b66-4480-9f8a-a6188eaf79d8	\N	\N	\N	\N
391a79f0-6728-4679-ab52-97d98ceb5fd4	\N	\N	4ade6266-363b-4a6b-98d7-79bc4f6cbe9a	\N	\N	\N	\N
5a843782-2bd3-48a9-ad1a-ca0b0534c0b0	\N	\N	91cdce2c-2570-4469-b8fa-bbfe3045e95a	\N	\N	\N	\N
d088448e-6501-4d69-a723-702e2b623f22	\N	\N	55c06c38-8b6d-419d-b624-0390946ba113	\N	\N	\N	\N
d9aadda4-624a-4062-acdf-83fe4dd057c2	\N	\N	c9d8ed55-dc27-4a7e-98cf-1503dd424a35	\N	\N	\N	\N
e1f7e536-fa90-4d02-99fb-c5ae639dc2ef	\N	\N	657a359e-8f8c-4571-b5ae-210b9401e5d5	\N	\N	\N	\N
140186cd-0ea3-4370-8887-361703993637	\N	\N	c3ae91e9-5f66-451e-b742-1b09da6fd120	\N	\N	\N	\N
543a0004-4252-4f31-9552-877865ccb77c	\N	\N	8c7da8e4-e20d-490c-bac0-2a9f19f519e7	\N	\N	\N	\N
b0fb7cb8-763c-4673-88b1-27731c356cc1	\N	\N	2afdf853-65e3-4774-8061-9017623869f5	\N	\N	\N	\N
bfb391be-e237-4a3e-b01b-ac6da2d251ad	\N	\N	15398764-58ae-429f-b763-634654ef6296	\N	\N	\N	\N
e8f859bf-8371-4945-8ac7-850898c3394f	\N	\N	5c51c4a2-3aa6-4836-9e10-8adc612b059f	\N	\N	\N	\N
702daa66-4894-4c45-b03f-48b6cca390b5	\N	\N	c0f32ada-b97f-4264-a38b-663d51465db4	\N	\N	\N	\N
722468b3-c1ad-4a11-be22-90ae8e3f16ca	\N	\N	24c159f0-fadf-4d0b-be7e-3dcf10ea8160	\N	\N	\N	\N
95d47600-574f-49fb-bdd6-fa47d6935536	\N	\N	f55c888b-4fde-4827-a4e4-03be5c728935	\N	\N	\N	\N
0331172d-7a0b-4d77-ad29-9e09dee1c2be	\N	\N	64f3cdb4-37df-4914-8d4b-b4411237b606	\N	\N	\N	\N
24235cda-63d5-4c31-bdab-9d7e190b8d2f	\N	\N	68de1490-4a18-465b-bbbc-62bc017cc062	\N	\N	\N	\N
3a2a4dcd-3cb4-4bdf-8891-9723dab8b5af	\N	\N	228e87f3-e614-4f85-b739-1682e6b10b73	\N	\N	\N	\N
5e1731b0-241b-4e25-b1a9-244c85c67275	\N	\N	60348809-69c9-45ea-ad18-a2ea51718f7e	\N	\N	\N	\N
cd6add7e-1f55-4efa-8742-308d6efc117b	\N	\N	daf6e9d4-2b0b-41c7-b498-44c1d86aad25	\N	\N	\N	\N
0175c673-66b3-484f-b8f1-e92bfffad169	\N	\N	9b17bc55-d644-4376-b7ed-8f06a1788f2f	\N	\N	\N	\N
1b5392b0-e316-4a0f-ae82-00ca5f2a2d1a	\N	\N	1681acdc-2dd4-4805-aae3-3353d0888fa9	\N	\N	\N	\N
3d3185a5-ab88-4473-bb39-0b3f159cc726	\N	\N	1845d61c-fe4f-412c-90a3-b70d976ec13e	\N	\N	\N	\N
52bc7f27-1776-417d-9164-bc89dcb50419	\N	\N	b4181dc6-d544-4f89-81a4-3b37ffed1883	\N	\N	\N	\N
81325df2-f680-4206-bd95-00cbce949b9f	\N	\N	71f2afad-2046-4359-a03b-7d65b7b45371	\N	\N	\N	\N
a7729d1b-9be9-44a7-bb92-0e23bedc05a6	\N	\N	7597d788-13a0-41a3-a992-66dd355a208c	\N	\N	\N	\N
c7cb89d6-3716-4183-a903-afa88eb46b4d	\N	\N	ef50cc4f-2237-4ca3-892b-e79603005383	\N	\N	\N	\N
21055a03-4775-4c04-be32-834238ecadda	\N	\N	5c2a1c83-b46e-4f8f-8402-db993e61535b	\N	\N	\N	\N
4cbdcb0e-adb0-4ea0-89b8-bbd0f8d649f2	\N	\N	64863631-0095-43a8-a3f7-17ae076e09af	\N	\N	\N	\N
abd40f48-9adf-4700-8a9d-104ed1c9afb6	\N	\N	483d899f-0154-488b-9991-24b4b07fbbd7	\N	\N	\N	\N
b7300ae0-6827-4559-86b0-2a81e16805cb	\N	\N	b4bca730-0274-44e5-aad3-c8dc1f53b6cb	\N	\N	\N	\N
faca94c6-de54-4c65-aa2c-6c0ea530e82c	\N	\N	1a69ad25-2349-4ffd-8c62-d6851074cf7a	\N	\N	\N	\N
2d7d41cf-5a2b-4d1c-b280-27a6e39f9473	\N	\N	601b1191-e4d5-48f7-92e5-4562c0665b3e	\N	\N	\N	\N
6d33c17e-afda-483b-8cb0-1e9639503289	\N	\N	f74dccc2-4e24-4129-998a-4dcd1f96e271	\N	\N	\N	\N
\.


--
-- Data for Name: join_datamodel_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_datamodel_to_facet (datamodel_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	\N	40b82481-3a99-4d35-9dc0-de172365896a	\N	\N	\N	\N	\N	\N
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	\N	a5d5bcbf-b7d5-4c2f-9088-27b09e53b3c7	\N	\N	\N	\N	\N	\N
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	d875859e-54f8-41af-897c-2173661b5174	\N	\N	\N	\N	\N	\N	\N
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	7d5e4809-6370-41cd-a4a3-cd1d91579ca0	\N	\N	\N	\N	\N	\N	\N
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	\N	\N	\N	\N	\N	59aa910e-a838-40ec-aa2f-b997f3c79216	\N	\N
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	\N	\N	\N	\N	\N	c6482c71-f565-4c0d-b6d2-06de7e7d1504	\N	\N
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	\N	\N	\N	\N	\N	a6edf2a9-6dce-41da-8b2f-45ab83087a59	\N	\N
fd8e9d84-825e-4fa7-a070-5301bf6c89e5	\N	\N	\N	\N	\N	\N	\N	c58caf40-c1c2-4aae-a430-2134bdcda361
dc5e3bb9-9119-4540-a586-2f55380e49f4	38e1a1ef-d3f2-42a3-b073-9e3c0eab1df5	\N	\N	\N	\N	\N	\N	\N
dc5e3bb9-9119-4540-a586-2f55380e49f4	\N	\N	\N	\N	\N	1c8a8eea-c130-4a15-a6fb-d170c3f34c61	\N	\N
dc5e3bb9-9119-4540-a586-2f55380e49f4	\N	\N	\N	\N	\N	a921aaef-9920-4d3f-8298-1f0a09182f30	\N	\N
dc5e3bb9-9119-4540-a586-2f55380e49f4	\N	\N	\N	\N	\N	5f83af67-4039-4df7-bc87-bb03dcc8cedf	\N	\N
6e73dcde-8ce7-4c45-b37d-0494e55394c9	\N	\N	\N	\N	\N	19c9be8f-9446-4dbb-8de7-7dd952b836c7	\N	\N
6e73dcde-8ce7-4c45-b37d-0494e55394c9	\N	\N	\N	\N	\N	c162d82b-0c0a-4098-8eb7-34041bd6029d	\N	\N
6e73dcde-8ce7-4c45-b37d-0494e55394c9	\N	\N	\N	\N	\N	3dac39a1-c12a-4f29-928d-46dbf451489b	\N	\N
6e73dcde-8ce7-4c45-b37d-0494e55394c9	\N	\N	\N	\N	\N	9f34ebc9-b596-4e1e-8c65-492b0d9a19b0	\N	\N
6e73dcde-8ce7-4c45-b37d-0494e55394c9	\N	\N	\N	\N	\N	\N	\N	5be79e82-6d92-4efc-baa4-bb40fac04137
6e73dcde-8ce7-4c45-b37d-0494e55394c9	\N	\N	\N	\N	\N	\N	\N	e8e8bc76-4a20-4f9c-88df-b37279d168a0
6e73dcde-8ce7-4c45-b37d-0494e55394c9	\N	57c2d27f-e592-402b-857d-b7e456c37b73	\N	\N	\N	\N	\N	\N
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	\N	\N	\N	\N	152f7207-94d3-4092-a859-3bf496da6412	\N	\N
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	\N	\N	\N	\N	824a4f58-29de-4524-85e5-64573c11b643	\N	\N
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	\N	\N	\N	\N	2e4a4861-d2d4-43bb-806e-8acd2e5af8ee	\N	\N
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	\N	\N	\N	\N	7b246b50-fd49-47af-812a-ea086f97971b	\N	\N
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	\N	\N	\N	\N	\N	\N	875fa51c-4305-4a9b-9c80-9fc127150c20
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	\N	\N	\N	\N	\N	\N	338ce243-ad77-465c-9e57-df5e6598917b
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	\N	d7b87226-e6c5-4e2f-a981-8de1d6f4afbb	\N	\N	\N	\N	\N
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	\N	\N	6dbc0dd0-ddb5-4258-bf0c-504adc1a5a24	\N	\N	\N	\N
926d5e0c-5ee5-457f-9335-3e97d02c08b2	\N	3aaec6ef-33b0-4809-ba0f-f01d5958afc8	\N	\N	\N	\N	\N	\N
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	\N	\N	\N	9f677b07-ef48-498f-9f48-46685b2af5d0	\N	\N
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	\N	\N	\N	ea2e5d17-e094-4946-a3bf-ba2c7fc2a811	\N	\N
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	\N	\N	\N	d4bddacd-8f39-465b-8217-f0316c7aa33a	\N	\N
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	\N	\N	\N	adc43fd0-868d-4bd6-988d-c3ef4a5b1d9a	\N	\N
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	\N	\N	\N	\N	\N	64332d45-f9fd-4656-a42f-c0469e05d3e6
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	\N	\N	\N	\N	\N	150b08f5-9eba-42f4-8fbf-7db1efdc195e
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	81e36ef9-0a58-4ccb-bcc7-1327e5e72205	\N	\N	\N	\N	\N
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	15d625f4-a671-4377-9e2b-11ccb1570521	\N	\N	\N	\N	\N
b3099f15-afde-436a-be99-1300eae98b4e	\N	\N	\N	d0cfc0e0-c04b-499e-9081-5465b607c0e8	\N	\N	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	\N	\N	9446b078-1d86-4717-9364-9f937654f00d	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	\N	\N	16f816cc-9a66-4db4-99b5-58873b7373bd	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	\N	\N	66dd750d-f0e5-45cd-a2cb-0867dd4ea17d	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	\N	\N	\N	\N	c12a3ba7-b923-4a18-b318-e19dec817a96
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	\N	\N	\N	\N	e508a3c2-ae04-45a4-93a9-7eb9257fa409
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	c6fcf55c-81e8-4593-abec-7817093e71f9	\N	\N	\N	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	e1292937-c059-4707-82b3-74721776807a	\N	\N	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	\N	\N	dfc7b229-b253-47d4-b352-a546e1ec1353	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	\N	\N	d0fe90bf-f879-4770-ad59-906c1f4e2218	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	\N	\N	\N	\N	\N	\N	33cccfd0-a84b-4efd-af58-1306d5bbc4b4
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	aae8df2f-f05b-4d02-93df-fe435d0b3d72	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	68eb3360-d433-4a87-8486-fc588f77656b	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	51b0a090-1eb3-469b-b8aa-fe610d05ffc1	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	30a9bd4f-1b1d-48ea-a27d-7d7341834eb0	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	\N	\N	6ea32e5e-7128-411b-bcb3-80c9b3cbbb6b
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	\N	\N	6ff5d01a-0b4f-4d8f-921d-ea3e9f5408e9
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	49df86e9-23d3-41c0-b2b6-35daa8030fd6	\N	\N	\N	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	4754cd24-f444-4cc8-8ce2-5481797b1456	\N	\N	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	6bbdce5c-745a-4395-9358-6ba03c6d6101	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	1a5fb315-68f1-4178-b031-fd1d9840582d	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	\N	\N	\N	\N	947755d5-cfec-41ae-9b4f-9c7be302cc1e	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	c6cbb6c5-e69b-4dad-8bf5-092b1c542206	\N	\N	\N	\N	\N	\N
c84fb099-79bc-496a-8901-75c99d539fbd	\N	377c2564-8b8d-4ee7-93ae-d15853accb9d	\N	\N	\N	\N	\N	\N
c5c83da4-47de-44f2-a5fd-414ac1f13900	\N	e752192a-ea87-4aee-9470-bbcc9f398154	\N	\N	\N	\N	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	\N	\N	76c48013-bdce-43ba-9ea6-36b31bb37782	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	\N	\N	76f36828-de9f-4583-8fb2-ba78fac16df7	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	\N	\N	bdf18161-b0d1-418c-9fdf-6b0848a435b0	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	\N	\N	9e680962-9dda-4f32-a4e9-fb81928d5814	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	\N	\N	7be2aca0-dd1e-45e7-931b-a2b64f42dbfe	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	\N	\N	\N	\N	62510ec1-3184-437c-b10d-de0ca9ba46d8
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	\N	\N	\N	\N	5dfb1584-381d-473a-b844-90af31ba9cad
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	\N	\N	\N	\N	89f59767-2d34-48ed-ae3a-c1d80f90072d
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	25ec0d87-ea2c-43c2-9d83-71fa4901cc4a	\N	\N	\N	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	802f093b-0349-4bd1-b584-67537f9909dc	\N	\N	\N	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	\N	\N	21946412-88e2-4ef2-8bab-7b0adb30d3ac	\N	\N	\N	\N
94f194ee-79db-4835-840e-4168bc4d9331	\N	9fc9b819-90f7-4df4-a84f-96b5d738a4a6	\N	\N	\N	\N	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	\N	\N	d93fadbd-9c3f-494a-a992-2a7686db272e	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	\N	\N	8be0b38a-27af-4f26-80a6-832ba9c4eaa8	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	\N	\N	b1104a5b-51d9-4702-886c-1c4c3670784e	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	\N	\N	682aee44-7550-4180-9689-f67e28ffe30c	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	\N	\N	99a04a15-1474-4d44-a646-56e869edebf9	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	\N	\N	\N	\N	0e58e702-9c59-4d82-9f58-b9da583fd617
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	\N	\N	\N	\N	704fc9ae-748a-40a7-b12e-b66a3c05de7b
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	\N	\N	\N	\N	714add63-a0a2-4acb-9df5-adf47ccfe512
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	f5b2a162-18c3-4f11-8361-0abd512c4ea6	\N	\N	\N	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	f05e9387-4ecd-4532-906c-1132edfc2993	\N	\N	\N	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	5e8946fa-e044-4485-91ed-3c0b850e36b4	\N	\N	\N	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	\N	\N	3fddaf4c-db81-48a9-8d8c-bf89804978cd	\N	\N	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	\N	\N	4a00d7e5-e194-4428-b3d0-efb98f6abbc2	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	\N	\N	e5dd03d9-e122-40bd-8b17-4a88df0cd7f3	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	\N	\N	780a2df7-2a0f-4849-afc9-2cdbd59d858d	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	\N	\N	8d2faa6a-fc83-4a94-a0e8-5d0860e9ca3a	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	\N	\N	6f0d821e-2dda-4ddd-a3a7-4100d4d8b613	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	\N	\N	\N	\N	d40da83b-f7e3-4786-8e6a-b845a6477461
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	\N	\N	\N	\N	8f6f9a90-0536-4392-aae6-40e6b6fefb47
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	\N	\N	\N	\N	1d093d94-b183-483a-b687-bf10992b2bca
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	a604ef58-32b5-44c8-b8f7-a82e887e8ebb	\N	\N	\N	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	ba0bc158-8e1d-4744-be7f-c302fb217190	\N	\N	\N	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	174a6233-05d6-4b21-be1c-e8e8a82b09ce	\N	\N	\N	\N	\N
73e4cf6a-a4d2-48bc-ad90-93cb1ad53d02	\N	\N	\N	5be5d70a-d3d0-4b2a-936d-84691cc9c0bd	\N	\N	\N	\N
726b5b98-4b02-433d-9e3b-249f139a27dc	\N	3d27e254-f74f-447b-88f0-70764221d262	\N	\N	\N	\N	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	\N	\N	9161816b-0e58-41c0-96a9-a2bd335e5520	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	\N	\N	4e6b8395-0ab7-41e0-82da-9a0dde2f1cc0	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	\N	\N	5dbf013f-6ec5-4643-8809-20d7730ca73d	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	\N	\N	2f2b0a9e-af5b-4746-8b72-2024e02a2bfd	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	\N	\N	5c84df42-070d-49b9-910c-74a2890b5388	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	\N	\N	\N	\N	3fe4b21f-f2a4-4125-a1b9-d1b8dbdd4ec4
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	\N	\N	\N	\N	c9dab8e7-fc62-4834-aa31-52f5e9c68274
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	\N	\N	\N	\N	9328ea26-6724-496e-b564-d865c7317168
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	96ce500d-12e3-4ed3-a0c3-5aa1e2359bc8	\N	\N	\N	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	b6c55227-543e-4f1c-86e8-72d777ed15f5	\N	\N	\N	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	dcd28f8b-4295-47f0-8c27-0e15eeb166cb	\N	\N	\N	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	d66587a6-9328-4d90-b515-58a5eff6e568	\N	\N	\N	\N	\N
9dd076ab-1240-474c-a3cb-5ef48863c208	\N	\N	\N	d27a98a0-fc36-432d-ba4b-0b02910aa4a9	\N	\N	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	\N	\N	1a92f377-ea67-4d83-a1d0-5b257f924b06	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	\N	\N	dd7e476c-9584-4d91-98d7-0d03d8887f8e	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	\N	\N	29223545-1165-4baf-be82-012ab50aadb6	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	\N	\N	f6f1018c-7da7-47c1-a174-3ce8eb63f997	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	\N	\N	795f4336-d210-4623-807b-81c14e0fedae	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	\N	\N	\N	\N	2b044300-b3d0-4001-adbf-5129decae356
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	\N	\N	\N	\N	dbb82045-5199-46f8-9834-2ba3a23312a4
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	\N	\N	\N	\N	6a73bc56-247c-441a-94e4-48e4abb0a83f
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	31fe5de5-af3d-4e33-b8c6-0ec8502171d1	\N	\N	\N	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	d470cd56-24a1-4e39-9cd8-bc5fc3b26d65	\N	\N	\N	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	565aa080-6aea-4402-9230-05c45f183ba2	\N	\N	\N	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	a5c82765-d9fa-4388-9361-5f24503ddc59	\N	\N	\N	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	\N	\N	7f48760b-ff24-4d7a-8318-19531cbb323c	\N	\N	\N	\N
20f4dada-c8a1-4c08-9f3b-4e53c9671a1d	\N	01268021-19f0-4857-b2cc-7ccad1ad2633	\N	\N	\N	\N	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	\N	\N	877466ba-ad27-4664-8d46-5d6a5d953263	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	\N	\N	a0922deb-5bb3-44a6-b2bc-a4072544d6ba	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	\N	\N	13001ff3-cffb-4c94-b725-26b5fa850b63	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	\N	\N	5fc02f7e-4b83-40d3-8723-c9c127351c51	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	\N	\N	dd0d12bd-4275-45c3-bd78-f8a08bd85427	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	\N	\N	\N	\N	e997b366-bcce-401e-b9d0-a36349a26fd0
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	\N	\N	\N	\N	b18c9163-4db9-4a0d-9ce2-32efd4ed6dd9
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	\N	\N	\N	\N	f10f8038-3e67-4388-8c43-c5d46fbbbd4e
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	042d02b8-1779-4d0c-af5a-b517a2e64f11	\N	\N	\N	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	e21a8efd-80b6-43a5-a82d-a0682acf06d6	\N	\N	\N	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	d4282984-930e-4162-ae3e-aa475cb991ee	\N	\N	\N	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	f5a1acc9-de53-4f91-a9ad-930dc6dca9da	\N	\N	\N	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	af2250f7-6876-44ee-b355-d65f3d07cba0	\N	\N	\N	\N	\N
c6e5cdfa-cb64-4988-8987-f0f8a6cfa85d	\N	\N	\N	0c5ac257-90b2-470c-a8b6-3133a716d9a6	\N	\N	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	\N	\N	f495b2e0-a869-4b43-a39d-e67edd30808a	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	\N	\N	4f2e62bf-8c2a-4a13-9dfc-d307823ef4ce	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	\N	\N	bf034686-a853-48b1-a561-c5815f04a1f4	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	\N	\N	9491aff7-b6c3-46db-98d1-3efb862d995b	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	\N	\N	3acdda6e-661a-4d43-9802-a11ce101f4ba	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	\N	\N	\N	\N	5875ceb2-ae8b-4faf-b10b-a07e088e9f6d
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	\N	\N	\N	\N	b590f629-1b45-467b-b441-64fd9a580843
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	\N	\N	\N	\N	dd2380b3-86b8-4ce4-b516-d00d351da64f
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	dbb46931-823e-4c58-add3-192875169784	\N	\N	\N	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	f1bd1357-59b8-408b-aa82-a67922146ff6	\N	\N	\N	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	709f2b45-f0ee-459b-a74a-a260ab39880c	\N	\N	\N	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	2638d034-e592-4465-909b-d4681bd4bfab	\N	\N	\N	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	edd551fd-9a11-4747-93b5-48768e3a2695	\N	\N	\N	\N	\N
eb5a08e6-844e-47c1-a31f-160dd238c202	\N	\N	\N	ddd75564-2316-412e-b06a-c3b334683a4c	\N	\N	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	\N	\N	5703367e-3403-41d2-8ad7-064077ce51c2	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	\N	\N	bf59da9b-727b-464f-8b5a-37ed47d05745	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	\N	\N	e4d147e7-a6af-4c28-b6b8-da6b79828076	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	\N	\N	8e1e08dd-b3f0-47d4-9621-7b61bf38b07e	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	\N	\N	55a72cef-6f57-4552-8b5f-380ad96ceb19	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	\N	\N	\N	\N	9ce3d14a-ef45-4019-a0a5-42ee0cfb5eb7
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	\N	\N	\N	\N	0bef88c3-a70f-4df2-8105-5fbaa933d55c
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	\N	\N	\N	\N	f6fc3751-8b8c-4ada-acb1-25daf34b717a
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	df8fd228-c681-46a8-b32f-e5bcb22d5fb0	\N	\N	\N	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	ccb03051-f78e-4a24-b454-70bd9d061d7b	\N	\N	\N	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	1a370d17-982a-40cb-9e1e-b970675848dc	\N	\N	\N	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	f18fda23-3213-4e67-a273-01389279072c	\N	\N	\N	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	95e7e100-5e86-4670-adb9-da7228a74858	\N	\N	\N	\N	\N
4b01f763-2505-46a2-938b-88622ca2eaa8	\N	\N	\N	dfc37d8e-3164-4f92-b4cb-bda4820c2902	\N	\N	\N	\N
\.


--
-- Data for Name: join_datamodel_to_imported_data_class; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_datamodel_to_imported_data_class (imported_dataclass_id, datamodel_id) FROM stdin;
\.


--
-- Data for Name: join_datamodel_to_imported_data_type; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_datamodel_to_imported_data_type (imported_datatype_id, datamodel_id) FROM stdin;
\.


--
-- Data for Name: join_datatype_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_datatype_to_facet (datatype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, summary_metadata_id, rule_id) FROM stdin;
29f5ecf2-270f-4efe-b4a2-04095a88520d	\N	\N	\N	\N	\N	\N	2b17915c-7345-4dfe-a3df-cab0db321753
f4740512-2cbd-4ad7-9ebb-ed6e7874fefe	\N	\N	14d74a2e-94ba-4c0d-b0d5-74e2e1709312	\N	\N	\N	\N
965d3adf-1328-4863-90b4-8ac988f38e57	\N	\N	61077dab-791c-4a4e-9a61-5ae646a1f527	\N	\N	\N	\N
91ff3163-6a80-4e19-8ce2-172bb446ce15	\N	\N	5405c059-f465-4be8-a479-57521d7085c9	\N	\N	\N	\N
ada0765e-5d5d-4175-9c5f-a48e286661ea	\N	\N	8289e006-10e6-4d42-96a2-c6551e9f5e47	\N	\N	\N	\N
dd2caaa3-67ad-49f5-80f8-bc6978351fb2	\N	\N	cd19ef57-0ca8-4e43-bef4-5f15e81250ee	\N	\N	\N	\N
0d203b8d-8f47-432f-95da-535e8967328c	\N	\N	a99d7857-7d86-4702-9dee-19b6f47cf88c	\N	\N	\N	\N
1c25775a-00bf-4221-91d4-5f644c764637	\N	\N	ec20997f-de22-4ed3-a4fd-46654252b6f6	\N	\N	\N	\N
30c1996b-46d8-44a8-9e9f-161df68a8d41	\N	\N	5630a610-3f94-499c-8d0b-070962e93fb5	\N	\N	\N	\N
850a0c33-0121-43de-ae1c-e1ff5bab6f0a	\N	\N	f9368582-adc9-4c40-abfd-37e6fd79fb4f	\N	\N	\N	\N
debd425a-6c2f-41c2-918f-cf7bd81030bd	\N	\N	d4a5a27a-fedd-4e9a-9f65-389c1f1f6282	\N	\N	\N	\N
e7c6df2f-f1c5-4936-98e3-e06613890815	\N	\N	1b1b0bd8-44b5-41c5-b9dd-0f6d43b24c27	\N	\N	\N	\N
08ca0f68-87a1-474b-bffd-98c43c6fcc93	\N	\N	d89cc38c-b5c6-4543-a077-a936897d6005	\N	\N	\N	\N
a0f7ca74-465f-4968-8f83-9ea2f6b9007d	\N	\N	84b1726b-e51e-4637-92b8-912423ce52e7	\N	\N	\N	\N
b12a75f4-bb3f-4e23-a154-a0345414358a	\N	\N	1bea4934-8554-45e6-8b92-e9995ff124ca	\N	\N	\N	\N
dcf77ff3-d2c8-4b21-a64e-006e65077418	\N	\N	5b46cf70-7c15-4b7a-ae80-07ffc7decfee	\N	\N	\N	\N
ed7c2eb7-4161-487a-b5f8-99f54d19f81e	\N	\N	6466f2da-7b0f-4cb5-b5e9-7cc4c48c9f2e	\N	\N	\N	\N
e762cdf4-e140-49e1-837d-f8a50bf85150	\N	\N	d1b97ace-27b7-46b9-9b1c-f4d5a940c73b	\N	\N	\N	\N
05868455-f7e3-4775-b563-4966b2550c73	\N	\N	bbcd1541-7d92-454b-8898-92c9b563d3db	\N	\N	\N	\N
241cd456-e9ff-4521-9d8a-157438b29e85	\N	\N	d894e1dd-0e41-4633-b400-6f2aea67de25	\N	\N	\N	\N
7c3556c9-bf46-4378-945a-32ae5bfa1cc3	\N	\N	c103e066-2e1b-484d-9acb-63142d8fc9e7	\N	\N	\N	\N
92585be7-eb1d-4331-9f8b-20277bc3a3fe	\N	\N	f2c5ebc1-5b1e-4c53-b1e1-49772ea5ae92	\N	\N	\N	\N
0c313d45-1561-4e04-b881-9efc36ed3976	\N	\N	f7467e2e-baa8-4104-ae06-b6f304bfeff4	\N	\N	\N	\N
55d78ee3-5908-48a5-8656-820256047de3	\N	\N	24cd76e8-dfdb-4dbf-a799-edae8850d06a	\N	\N	\N	\N
614e12ea-d510-4320-9be4-372af71d5e47	\N	\N	be9389c5-c9ac-411c-a210-a317aaa73098	\N	\N	\N	\N
b2082605-ace7-4bb8-ac47-ae9b4cabb112	\N	\N	47785b0b-7d78-4c75-aa3a-7b53c7d286d6	\N	\N	\N	\N
25976300-071b-48b0-bc64-940ddaca293d	\N	\N	3942f818-c49b-473c-9ad5-c8de7763c8d8	\N	\N	\N	\N
4da5448a-a9dc-4ace-a777-a5dbd602cc9a	\N	\N	2351e3a4-949f-471f-9187-6d326821e438	\N	\N	\N	\N
700f81b0-5f14-43b6-b846-2d32a666ab56	\N	\N	81000bb0-882c-47c5-8d6b-3f2ca3142774	\N	\N	\N	\N
944f49a0-eec3-4d75-8476-1fd4dde40a76	\N	\N	2b709f3f-aa0f-4ee8-bf56-4262883fc900	\N	\N	\N	\N
f43a3684-69de-418a-b22e-72b925c7f9d5	\N	\N	719d16cc-e23a-4ae0-8f18-1ed739018478	\N	\N	\N	\N
10a25708-2580-4ca4-88de-21348e805ca8	\N	\N	d6db0240-2241-4fed-b5ab-38c0eb570110	\N	\N	\N	\N
241094fa-817f-41c8-aa73-0cbf44f727ce	\N	\N	456d8b76-0898-465a-83c6-98d53b333921	\N	\N	\N	\N
85480359-f7ba-4e7d-af94-ec2392733e3f	\N	\N	ef9e017f-8ce5-41ea-95bd-23fc09333e05	\N	\N	\N	\N
ad70193a-c09e-4ea5-97f0-17fed041198e	\N	\N	94c7e680-2a74-4cdd-8dfb-1656d8780ab6	\N	\N	\N	\N
b3ecf027-4cb6-44c2-87cf-dd2570883ed2	\N	\N	ed7264cd-10f3-4161-972c-196fa187e351	\N	\N	\N	\N
2be54098-04ed-4795-8fcd-81a8f29e67a8	\N	\N	9d5e2548-a9bc-46b1-ba3c-459db4261f8f	\N	\N	\N	\N
\.


--
-- Data for Name: join_enumerationvalue_to_facet; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.join_enumerationvalue_to_facet (enumerationvalue_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: summary_metadata; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.summary_metadata (id, version, summary_metadata_type, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, created_by, label, description) FROM stdin;
\.


--
-- Data for Name: summary_metadata_report; Type: TABLE DATA; Schema: datamodel; Owner: -
--

COPY datamodel.summary_metadata_report (id, version, date_created, last_updated, report_date, created_by, report_value, summary_metadata_id) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: federation; Owner: -
--

COPY federation.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
0	\N	<< Flyway Schema Creation >>	SCHEMA	"federation"	\N	maurodatamapper	2021-10-04 13:23:09.019401	0	t
1	1.0.0	subscribed catalogue	SQL	V1_0_0__subscribed_catalogue.sql	664848546	maurodatamapper	2021-10-04 13:23:09.02348	9	t
2	1.1.0	allow public connections	SQL	V1_1_0__allow_public_connections.sql	-1099084963	maurodatamapper	2021-10-04 13:23:09.036933	1	t
\.


--
-- Data for Name: subscribed_catalogue; Type: TABLE DATA; Schema: federation; Owner: -
--

COPY federation.subscribed_catalogue (id, version, date_created, last_updated, readable_by_authenticated_users, readable_by_everyone, created_by, url, api_key, refresh_period, label, description, last_read) FROM stdin;
\.


--
-- Data for Name: subscribed_model; Type: TABLE DATA; Schema: federation; Owner: -
--

COPY federation.subscribed_model (id, version, date_created, last_updated, readable_by_authenticated_users, readable_by_everyone, created_by, subscribed_catalogue_id, subscribed_model_id, subscribed_model_type, folder_id, last_read, local_model_id) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.12.0	referencedata	SQL	V1_12_0__referencedata.sql	-1371414334	maurodatamapper	2021-10-04 13:23:09.066801	141	t
2	1.14.0	fix errant referencedata tables	SQL	V1_14_0__fix_errant_referencedata_tables.sql	1211767792	maurodatamapper	2021-10-04 13:23:09.213708	9	t
3	1.15.3	add rule to referencedata	SQL	V1_15_3__add_rule_to_referencedata.sql	-29360414	maurodatamapper	2021-10-04 13:23:09.226941	6	t
4	2.0.0	unmodelitem reference data value	SQL	V2_0_0__unmodelitem_reference_data_value.sql	-1153312026	maurodatamapper	2021-10-04 13:23:09.237073	5	t
5	2.1.0	add model version tag to referencedata	SQL	V2_1_0__add_model_version_tag_to_referencedata.sql	479267627	maurodatamapper	2021-10-04 13:23:09.246069	0	t
6	2.2.0	rename catalogue item to multi facet	SQL	V2_2_0__rename_catalogue_item_to_multi_facet.sql	1531204225	maurodatamapper	2021-10-04 13:23:09.249704	1	t
\.


--
-- Data for Name: join_referencedataelement_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.join_referencedataelement_to_facet (referencedataelement_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
39b2093f-f62d-46f7-b1be-b350ea89cfe3	\N	\N	\N	\N	\N	\N	0df6a2f9-260a-4116-bc4f-8b500c34169e
\.


--
-- Data for Name: join_referencedatamodel_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.join_referencedatamodel_to_facet (referencedatamodel_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
e309016a-b128-4282-afaa-37cdb8d88193	38e1a1ef-d3f2-42a3-b073-9e3c0eab1df5	\N	\N	\N	\N	\N	\N	\N
e309016a-b128-4282-afaa-37cdb8d88193	\N	\N	\N	\N	\N	f453d880-1745-42f7-b122-d5a5874805a9	\N	\N
e309016a-b128-4282-afaa-37cdb8d88193	\N	\N	\N	\N	\N	dd4846d3-420f-42e7-8c38-5080d69ba94b	\N	\N
e309016a-b128-4282-afaa-37cdb8d88193	\N	\N	\N	\N	\N	20b0008b-1a16-4446-8aa5-e19dd9f51110	\N	\N
e309016a-b128-4282-afaa-37cdb8d88193	\N	\N	\N	\N	\N	\N	\N	e05de3ef-ee43-4845-b82c-6088dafdde4e
\.


--
-- Data for Name: join_referencedatatype_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.join_referencedatatype_to_facet (referencedatatype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, reference_summary_metadata_id, rule_id) FROM stdin;
58567a62-59c0-4cb6-af34-2961b0673bda	\N	\N	\N	\N	\N	\N	f42a9499-03b9-4848-838c-ff9301a23fad
\.


--
-- Data for Name: join_referenceenumerationvalue_to_facet; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.join_referenceenumerationvalue_to_facet (referenceenumerationvalue_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
\.


--
-- Data for Name: reference_data_element; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.reference_data_element (id, version, date_created, reference_data_type_id, reference_data_model_id, last_updated, path, depth, min_multiplicity, max_multiplicity, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
ee520084-a89c-4b72-9e8c-2d444b8093b6	0	2021-10-04 13:23:20.730243	58567a62-59c0-4cb6-af34-2961b0673bda	e309016a-b128-4282-afaa-37cdb8d88193	2021-10-04 13:23:20.730243	/e309016a-b128-4282-afaa-37cdb8d88193	1	\N	\N	4cc72525-f0a2-450e-b79d-b837d3b914fe	2147483647	development@test.com	\N	Organisation code	\N
39b2093f-f62d-46f7-b1be-b350ea89cfe3	1	2021-10-04 13:23:20.729331	58567a62-59c0-4cb6-af34-2961b0673bda	e309016a-b128-4282-afaa-37cdb8d88193	2021-10-04 13:23:21.059041	/e309016a-b128-4282-afaa-37cdb8d88193	1	\N	\N	1b714a46-ddc9-4e08-a736-4f33ff0cd85c	2147483647	development@test.com	\N	Organisation name	\N
\.


--
-- Data for Name: reference_data_model; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.reference_data_model (id, version, branch_name, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, model_version, folder_id, authority_id, created_by, aliases_string, label, description, model_version_tag) FROM stdin;
e309016a-b128-4282-afaa-37cdb8d88193	4	main	2021-10-04 13:23:20.66946	f	f	\N	1.0.0	f	ReferenceDataModel	2021-10-04 13:23:21.057629	\N	f	\N	a1ffd852-b490-4948-81e5-e9d8ca09156a	\N	867eaaec-64b4-4736-8938-71caa2a0b837	b5f79af9-dd57-4da3-844e-122cd65cd031	development@test.com	\N	Simple Reference Data Model	\N	\N
\.


--
-- Data for Name: reference_data_type; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.reference_data_type (id, version, date_created, reference_data_model_id, domain_type, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description, class, units) FROM stdin;
7d15d6cb-96c4-4828-889d-7d1bd78bff23	0	2021-10-04 13:23:20.697629	e309016a-b128-4282-afaa-37cdb8d88193	ReferencePrimitiveType	2021-10-04 13:23:20.697629	/e309016a-b128-4282-afaa-37cdb8d88193	1	070e44f5-5d24-4847-9a12-b0e220571657	2147483647	development@test.com	\N	integer	\N	uk.ac.ox.softeng.maurodatamapper.referencedata.item.datatype.ReferencePrimitiveType	\N
58567a62-59c0-4cb6-af34-2961b0673bda	1	2021-10-04 13:23:20.695318	e309016a-b128-4282-afaa-37cdb8d88193	ReferencePrimitiveType	2021-10-04 13:23:21.063093	/e309016a-b128-4282-afaa-37cdb8d88193	1	553315f7-ed50-4631-847c-f31585fec36e	2147483647	development@test.com	\N	string	\N	uk.ac.ox.softeng.maurodatamapper.referencedata.item.datatype.ReferencePrimitiveType	\N
\.


--
-- Data for Name: reference_data_value; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.reference_data_value (id, version, date_created, value, reference_data_model_id, reference_data_element_id, row_number, last_updated, created_by) FROM stdin;
ae38b494-6304-48c6-bdea-30ab20ed0cb1	0	2021-10-04 13:23:20.932077	Organisation 1	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	1	2021-10-04 13:23:20.932077	development@test.com
2be3be48-cbfb-4a4f-ac19-205372f0182c	0	2021-10-04 13:23:20.93282	ORG1	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	1	2021-10-04 13:23:20.93282	development@test.com
ddff539f-a813-4f0d-96e5-d733b452e1bf	0	2021-10-04 13:23:20.933243	Organisation 2	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	2	2021-10-04 13:23:20.933243	development@test.com
9a38b79e-6994-4111-a49c-47a84e28dc17	0	2021-10-04 13:23:20.933583	ORG2	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	2	2021-10-04 13:23:20.933583	development@test.com
0f4c0824-564c-462a-beae-a97b08ca3a4a	0	2021-10-04 13:23:20.933883	Organisation 3	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	3	2021-10-04 13:23:20.933883	development@test.com
4654859c-94cc-4115-81cb-1418303caaed	0	2021-10-04 13:23:20.934276	ORG3	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	3	2021-10-04 13:23:20.934276	development@test.com
a02596ce-d143-4829-9c77-f645b8f18868	0	2021-10-04 13:23:20.934645	Organisation 4	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	4	2021-10-04 13:23:20.934645	development@test.com
c887b30e-e243-4fa7-8b1b-118f9f080bf0	0	2021-10-04 13:23:20.934991	ORG4	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	4	2021-10-04 13:23:20.934991	development@test.com
d8620633-1b83-4501-87fe-eba63542fedf	0	2021-10-04 13:23:20.935278	Organisation 5	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	5	2021-10-04 13:23:20.935278	development@test.com
e2ba8458-b4ff-4be8-a848-bab55c0f9b8e	0	2021-10-04 13:23:20.93555	ORG5	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	5	2021-10-04 13:23:20.93555	development@test.com
4f8f4ea0-606f-4f67-bef7-fb1bc787d0f8	0	2021-10-04 13:23:20.935825	Organisation 6	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	6	2021-10-04 13:23:20.935825	development@test.com
039d1738-f5b7-4519-9153-5e5653d1ca26	0	2021-10-04 13:23:20.936103	ORG6	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	6	2021-10-04 13:23:20.936103	development@test.com
17480c03-b53d-4834-bbb1-2aadca146290	0	2021-10-04 13:23:20.936374	Organisation 7	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	7	2021-10-04 13:23:20.936374	development@test.com
f21a1416-ce3c-4e97-be28-23098d25d6a7	0	2021-10-04 13:23:20.936636	ORG7	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	7	2021-10-04 13:23:20.936636	development@test.com
001c17e4-7b73-42b5-8d86-52013c77149b	0	2021-10-04 13:23:20.936899	Organisation 8	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	8	2021-10-04 13:23:20.936899	development@test.com
c15acc56-339b-4487-b725-1acd7b4586be	0	2021-10-04 13:23:20.937166	ORG8	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	8	2021-10-04 13:23:20.937166	development@test.com
3b579921-7e1b-4b5a-b42d-44c10a48632a	0	2021-10-04 13:23:20.937439	Organisation 9	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	9	2021-10-04 13:23:20.937439	development@test.com
80d741d5-7002-444a-90fd-25f704af3a09	0	2021-10-04 13:23:20.937717	ORG9	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	9	2021-10-04 13:23:20.937717	development@test.com
e22eee21-0ec2-4c8d-a27b-a6575361cbd8	0	2021-10-04 13:23:20.938002	Organisation 10	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	10	2021-10-04 13:23:20.938002	development@test.com
a4fde848-b589-4260-965b-3f162581d26e	0	2021-10-04 13:23:20.938278	ORG10	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	10	2021-10-04 13:23:20.938278	development@test.com
ee3fdee7-39c6-4f91-ac6c-0d01ef770288	0	2021-10-04 13:23:20.938648	Organisation 11	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	11	2021-10-04 13:23:20.938648	development@test.com
65052e45-7690-4937-85f1-e1ae47e4ab42	0	2021-10-04 13:23:20.938846	ORG11	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	11	2021-10-04 13:23:20.938846	development@test.com
499bc482-8770-42ea-9c51-8d8ed017f761	0	2021-10-04 13:23:20.939026	Organisation 12	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	12	2021-10-04 13:23:20.939026	development@test.com
06fe3721-4c47-455f-bb83-86632b74af8d	0	2021-10-04 13:23:20.939199	ORG12	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	12	2021-10-04 13:23:20.939199	development@test.com
520a0a74-5b80-4ce0-9b75-c06c7abef321	0	2021-10-04 13:23:20.939366	Organisation 13	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	13	2021-10-04 13:23:20.939366	development@test.com
26163c21-11d3-4ae6-80dd-9ffed377a5d3	0	2021-10-04 13:23:20.939532	ORG13	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	13	2021-10-04 13:23:20.939532	development@test.com
98b553ca-ac9b-4f00-b615-c41ed5673f8f	0	2021-10-04 13:23:20.939696	Organisation 14	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	14	2021-10-04 13:23:20.939696	development@test.com
67cb95aa-796f-42eb-a5a3-efeb8cf207ad	0	2021-10-04 13:23:20.93986	ORG14	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	14	2021-10-04 13:23:20.93986	development@test.com
8147e549-d0fa-49f5-a827-0265a3b23894	0	2021-10-04 13:23:20.940047	Organisation 15	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	15	2021-10-04 13:23:20.940047	development@test.com
9bcbd2b9-57ce-458e-89b7-e880d97cca2f	0	2021-10-04 13:23:20.940304	ORG15	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	15	2021-10-04 13:23:20.940304	development@test.com
c68d3a39-de5f-4d58-a960-9d3811553d70	0	2021-10-04 13:23:20.945626	Organisation 16	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	16	2021-10-04 13:23:20.945626	development@test.com
3561fa5b-3d3a-40ea-916d-ad412513b9af	0	2021-10-04 13:23:20.946049	ORG16	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	16	2021-10-04 13:23:20.946049	development@test.com
27d62791-e1dd-49f0-a67d-5e6582c5086e	0	2021-10-04 13:23:20.946354	Organisation 17	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	17	2021-10-04 13:23:20.946354	development@test.com
511b19db-dcf2-4f86-88e2-1f691b2bedd5	0	2021-10-04 13:23:20.946643	ORG17	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	17	2021-10-04 13:23:20.946643	development@test.com
5bd1d871-5795-4e23-8cab-f570d8622449	0	2021-10-04 13:23:20.946915	Organisation 18	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	18	2021-10-04 13:23:20.946915	development@test.com
6400bf46-a41b-447c-8f6d-df768613a27e	0	2021-10-04 13:23:20.947205	ORG18	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	18	2021-10-04 13:23:20.947205	development@test.com
443a75fb-234f-49ad-be8b-a9e61cbde27f	0	2021-10-04 13:23:20.947503	Organisation 19	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	19	2021-10-04 13:23:20.947503	development@test.com
0c19657a-0627-4986-9f3f-f319d2a80fca	0	2021-10-04 13:23:20.947829	ORG19	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	19	2021-10-04 13:23:20.947829	development@test.com
552c9a42-21d3-45b6-abfb-977a124ca228	0	2021-10-04 13:23:20.948123	Organisation 20	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	20	2021-10-04 13:23:20.948123	development@test.com
78acb368-9a12-4504-8f85-91d2af6b63a3	0	2021-10-04 13:23:20.948421	ORG20	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	20	2021-10-04 13:23:20.948421	development@test.com
80a0a1b9-1d48-478f-b835-4620c97a6381	0	2021-10-04 13:23:20.948707	Organisation 21	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	21	2021-10-04 13:23:20.948707	development@test.com
00c4ef94-4bb4-445a-b936-ddb7ffd1c95d	0	2021-10-04 13:23:20.949003	ORG21	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	21	2021-10-04 13:23:20.949003	development@test.com
91911d90-396c-41d6-b724-5219e090fe1b	0	2021-10-04 13:23:20.949294	Organisation 22	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	22	2021-10-04 13:23:20.949294	development@test.com
f1290c3f-f3e7-4b06-b1d1-91db7bb81cbf	0	2021-10-04 13:23:20.94962	ORG22	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	22	2021-10-04 13:23:20.94962	development@test.com
8aaa9e0b-50da-4b0f-8cf9-4b701824e5d1	0	2021-10-04 13:23:20.949887	Organisation 23	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	23	2021-10-04 13:23:20.949887	development@test.com
0df998ad-11ab-4312-8657-3f1fcef6d9c8	0	2021-10-04 13:23:20.9501	ORG23	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	23	2021-10-04 13:23:20.9501	development@test.com
2082586b-cde4-4b84-9188-00b16e63fad5	0	2021-10-04 13:23:20.950314	Organisation 24	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	24	2021-10-04 13:23:20.950314	development@test.com
a933aaf1-aaa1-413c-9161-7290ad0cd989	0	2021-10-04 13:23:20.950514	ORG24	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	24	2021-10-04 13:23:20.950514	development@test.com
3eef7fc0-0d89-408d-b319-5b5a732d42fb	0	2021-10-04 13:23:20.950715	Organisation 25	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	25	2021-10-04 13:23:20.950715	development@test.com
ec4595af-ed62-48b4-9692-8eb23255fa88	0	2021-10-04 13:23:20.950918	ORG25	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	25	2021-10-04 13:23:20.950918	development@test.com
d5f12071-81f7-493e-a8a4-5510d2803e4c	0	2021-10-04 13:23:20.9511	Organisation 26	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	26	2021-10-04 13:23:20.9511	development@test.com
527842c4-f106-499b-affd-e39468096718	0	2021-10-04 13:23:20.951285	ORG26	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	26	2021-10-04 13:23:20.951285	development@test.com
a37fcc6a-4830-4857-a836-183928ec87a2	0	2021-10-04 13:23:20.951479	Organisation 27	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	27	2021-10-04 13:23:20.951479	development@test.com
f0d2bf78-96d6-42e4-8bbb-172ea1336c21	0	2021-10-04 13:23:20.951671	ORG27	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	27	2021-10-04 13:23:20.951671	development@test.com
b5a5a185-b935-4832-ba91-369b7dd4a65d	0	2021-10-04 13:23:20.951863	Organisation 28	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	28	2021-10-04 13:23:20.951863	development@test.com
f2ea8475-70ca-4353-a953-0e7f06cab5bb	0	2021-10-04 13:23:20.95206	ORG28	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	28	2021-10-04 13:23:20.95206	development@test.com
c39d7a68-4ad0-44d5-a617-eedac4ad9f31	0	2021-10-04 13:23:20.952253	Organisation 29	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	29	2021-10-04 13:23:20.952253	development@test.com
1aaa5010-1848-4958-8b85-bc09916f51b9	0	2021-10-04 13:23:20.952443	ORG29	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	29	2021-10-04 13:23:20.952443	development@test.com
dbf945f3-b875-4a0b-af6f-0f43349381a9	0	2021-10-04 13:23:20.952643	Organisation 30	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	30	2021-10-04 13:23:20.952643	development@test.com
d00861ca-caa7-4126-b787-12929ca1c9b6	0	2021-10-04 13:23:20.952827	ORG30	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	30	2021-10-04 13:23:20.952827	development@test.com
171d4bcd-427e-4e71-9f70-9cff173fc933	0	2021-10-04 13:23:20.957117	Organisation 31	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	31	2021-10-04 13:23:20.957117	development@test.com
e531b354-c329-4e46-a5d3-f752acee5eff	0	2021-10-04 13:23:20.957605	ORG31	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	31	2021-10-04 13:23:20.957605	development@test.com
d495d478-9bb1-42eb-8ae2-13fb2757e6a4	0	2021-10-04 13:23:20.957982	Organisation 32	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	32	2021-10-04 13:23:20.957982	development@test.com
e8e73f31-8891-4cbe-b9b6-b32b53a3ae5a	0	2021-10-04 13:23:20.958278	ORG32	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	32	2021-10-04 13:23:20.958278	development@test.com
6cdca431-a057-45ba-9ece-aaeee4b41c15	0	2021-10-04 13:23:20.95856	Organisation 33	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	33	2021-10-04 13:23:20.95856	development@test.com
9204df32-5e66-44e3-98be-aa61391edf6d	0	2021-10-04 13:23:20.958859	ORG33	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	33	2021-10-04 13:23:20.958859	development@test.com
32be3445-59ec-4d0d-8d7c-e5d4284ef785	0	2021-10-04 13:23:20.95916	Organisation 34	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	34	2021-10-04 13:23:20.95916	development@test.com
4d726e5a-622d-4a92-9865-23fcdb08bf29	0	2021-10-04 13:23:20.959461	ORG34	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	34	2021-10-04 13:23:20.959461	development@test.com
a16a0b55-5080-46a3-8fba-1f7ab1f34ad7	0	2021-10-04 13:23:20.959771	Organisation 35	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	35	2021-10-04 13:23:20.959771	development@test.com
afe84d3a-cefc-4386-802b-05a3b3bd4354	0	2021-10-04 13:23:20.960048	ORG35	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	35	2021-10-04 13:23:20.960048	development@test.com
836e3cec-0c78-4433-aec5-34cbd4c4af32	0	2021-10-04 13:23:20.960315	Organisation 36	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	36	2021-10-04 13:23:20.960315	development@test.com
53c6e7a6-e08e-46cb-b155-831d0381a678	0	2021-10-04 13:23:20.960598	ORG36	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	36	2021-10-04 13:23:20.960598	development@test.com
0037430c-eacf-4787-81ba-499fce20b0be	0	2021-10-04 13:23:20.960866	Organisation 37	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	37	2021-10-04 13:23:20.960866	development@test.com
5c9f24ee-9bf3-4d7a-b905-60d7757acc45	0	2021-10-04 13:23:20.961136	ORG37	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	37	2021-10-04 13:23:20.961136	development@test.com
d3d04303-7e31-4793-b9cb-555cf3e38628	0	2021-10-04 13:23:20.961401	Organisation 38	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	38	2021-10-04 13:23:20.961401	development@test.com
b04bcd10-cabf-4ca9-b93c-6b89d35fd642	0	2021-10-04 13:23:20.961643	ORG38	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	38	2021-10-04 13:23:20.961643	development@test.com
91d7227e-dc16-480a-a6c7-cfacc56f219f	0	2021-10-04 13:23:20.961893	Organisation 39	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	39	2021-10-04 13:23:20.961893	development@test.com
2ee927ff-b632-473e-9dde-46e10f592402	0	2021-10-04 13:23:20.962167	ORG39	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	39	2021-10-04 13:23:20.962167	development@test.com
2d77e65e-dc74-4f21-b921-08f31435f27d	0	2021-10-04 13:23:20.962462	Organisation 40	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	40	2021-10-04 13:23:20.962462	development@test.com
65d73164-be3e-450b-9d6d-b66fe125b7fb	0	2021-10-04 13:23:20.962744	ORG40	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	40	2021-10-04 13:23:20.962744	development@test.com
6ebeef04-7133-4087-8b26-fd401212e110	0	2021-10-04 13:23:20.963015	Organisation 41	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	41	2021-10-04 13:23:20.963015	development@test.com
d3194249-99c8-4fa0-bf86-226aef501050	0	2021-10-04 13:23:20.963299	ORG41	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	41	2021-10-04 13:23:20.963299	development@test.com
b8f2c84e-a3d6-410b-ba69-d2939b40374a	0	2021-10-04 13:23:20.963559	Organisation 42	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	42	2021-10-04 13:23:20.963559	development@test.com
4b2def23-c0c6-47e5-a833-2f055016e598	0	2021-10-04 13:23:20.963811	ORG42	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	42	2021-10-04 13:23:20.963811	development@test.com
d7636509-bb50-432a-9937-d706296fcecd	0	2021-10-04 13:23:20.964058	Organisation 43	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	43	2021-10-04 13:23:20.964058	development@test.com
9a018514-fdae-4d00-b185-70bbc39de22f	0	2021-10-04 13:23:20.964317	ORG43	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	43	2021-10-04 13:23:20.964317	development@test.com
edc95833-2f6c-4c71-8bf7-5c3041a09581	0	2021-10-04 13:23:20.96458	Organisation 44	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	44	2021-10-04 13:23:20.96458	development@test.com
106bac42-ccb0-4437-9d26-93b1ff18a475	0	2021-10-04 13:23:20.964846	ORG44	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	44	2021-10-04 13:23:20.964846	development@test.com
70ab84e3-f699-4f51-b411-4914e8e3ab12	0	2021-10-04 13:23:20.965133	Organisation 45	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	45	2021-10-04 13:23:20.965133	development@test.com
56ae3694-c57d-40fa-9cc3-654585915914	0	2021-10-04 13:23:20.965434	ORG45	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	45	2021-10-04 13:23:20.965434	development@test.com
d88705fe-a28c-467a-a0ca-e2059b7c949f	0	2021-10-04 13:23:20.968516	Organisation 46	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	46	2021-10-04 13:23:20.968516	development@test.com
f50448fb-0eed-420f-9f11-f9b1a4a0a76c	0	2021-10-04 13:23:20.968989	ORG46	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	46	2021-10-04 13:23:20.968989	development@test.com
2b244fca-c29b-488b-8ead-36350762e084	0	2021-10-04 13:23:20.969319	Organisation 47	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	47	2021-10-04 13:23:20.969319	development@test.com
351d26ec-16b6-48b8-bce3-b759ab030d38	0	2021-10-04 13:23:20.969596	ORG47	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	47	2021-10-04 13:23:20.969596	development@test.com
cd88c57d-ff08-4fc2-bfbf-008052f1777c	0	2021-10-04 13:23:20.969863	Organisation 48	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	48	2021-10-04 13:23:20.969863	development@test.com
872a6c45-bab1-4fb9-aee6-8b200146d285	0	2021-10-04 13:23:20.970148	ORG48	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	48	2021-10-04 13:23:20.970148	development@test.com
da1be2d3-3db5-40c3-a8c4-38bddf7ca7e0	0	2021-10-04 13:23:20.970439	Organisation 49	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	49	2021-10-04 13:23:20.970439	development@test.com
48acb657-1bbb-46f6-8a62-0e31d4ffe2f1	0	2021-10-04 13:23:20.970758	ORG49	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	49	2021-10-04 13:23:20.970758	development@test.com
e3a92add-03b1-465e-82a4-739b16ffae10	0	2021-10-04 13:23:20.971149	Organisation 50	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	50	2021-10-04 13:23:20.971149	development@test.com
e1933e07-0570-496c-8637-05e90f69a664	0	2021-10-04 13:23:20.971528	ORG50	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	50	2021-10-04 13:23:20.971528	development@test.com
9d968a29-0588-4566-8286-7ee5f4775b1b	0	2021-10-04 13:23:20.97188	Organisation 51	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	51	2021-10-04 13:23:20.97188	development@test.com
b0fd3c9c-4798-4ccd-a75f-d7e1ca91ec38	0	2021-10-04 13:23:20.972385	ORG51	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	51	2021-10-04 13:23:20.972385	development@test.com
4cf85341-4a3a-4a7e-9d2f-7acc0f4d4450	0	2021-10-04 13:23:20.972793	Organisation 52	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	52	2021-10-04 13:23:20.972793	development@test.com
67cd36e7-6923-4973-8fdd-e195caff15db	0	2021-10-04 13:23:20.973127	ORG52	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	52	2021-10-04 13:23:20.973127	development@test.com
a12f902f-7359-494d-b194-2234e6d9e2eb	0	2021-10-04 13:23:20.97345	Organisation 53	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	53	2021-10-04 13:23:20.97345	development@test.com
c366713b-e83b-4d73-b7bd-0abf340d9b04	0	2021-10-04 13:23:20.973772	ORG53	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	53	2021-10-04 13:23:20.973772	development@test.com
ee6cf4d9-75c2-403e-8a5a-1999d1f4ffa5	0	2021-10-04 13:23:20.974131	Organisation 54	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	54	2021-10-04 13:23:20.974131	development@test.com
cb2d1915-fca0-4ef0-8f3a-c3dd0620c9b2	0	2021-10-04 13:23:20.974461	ORG54	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	54	2021-10-04 13:23:20.974461	development@test.com
a0d5e1c7-2246-415a-9a68-b5d273fad13e	0	2021-10-04 13:23:20.974775	Organisation 55	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	55	2021-10-04 13:23:20.974775	development@test.com
25903f57-dbab-47e3-82f0-51cc6c920a21	0	2021-10-04 13:23:20.975144	ORG55	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	55	2021-10-04 13:23:20.975144	development@test.com
80c3b901-f6db-48a0-9882-fb8ec432c1d2	0	2021-10-04 13:23:20.975467	Organisation 56	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	56	2021-10-04 13:23:20.975467	development@test.com
a2fa9256-bf78-4215-b60a-d7ef72caff40	0	2021-10-04 13:23:20.975725	ORG56	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	56	2021-10-04 13:23:20.975725	development@test.com
d532be10-a49e-463d-bff3-46bac3ebae55	0	2021-10-04 13:23:20.975969	Organisation 57	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	57	2021-10-04 13:23:20.975969	development@test.com
d2907ed2-854c-401f-b44f-47509594a83c	0	2021-10-04 13:23:20.976203	ORG57	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	57	2021-10-04 13:23:20.976203	development@test.com
076564e0-f0a6-4082-a3cd-4500642fff23	0	2021-10-04 13:23:20.976443	Organisation 58	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	58	2021-10-04 13:23:20.976443	development@test.com
b58a54a9-07f9-4787-b4b3-4be9adbfa483	0	2021-10-04 13:23:20.976715	ORG58	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	58	2021-10-04 13:23:20.976715	development@test.com
e7aa7091-bf8e-4113-88d2-cf0e3bdc8983	0	2021-10-04 13:23:20.976901	Organisation 59	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	59	2021-10-04 13:23:20.976901	development@test.com
a5f8cd34-2422-49a4-acf1-4a9290c0c798	0	2021-10-04 13:23:20.977096	ORG59	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	59	2021-10-04 13:23:20.977096	development@test.com
5ee24d46-a996-4f7a-8a34-5fb495d530c5	0	2021-10-04 13:23:20.977278	Organisation 60	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	60	2021-10-04 13:23:20.977278	development@test.com
be9528cb-7002-441d-aace-827e8633597d	0	2021-10-04 13:23:20.97746	ORG60	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	60	2021-10-04 13:23:20.97746	development@test.com
626184b3-d1d6-4e6b-a35f-76ef7c3d0f4e	0	2021-10-04 13:23:20.981325	Organisation 61	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	61	2021-10-04 13:23:20.981325	development@test.com
f46d71e2-d499-45f4-8ccd-f87589db49c2	0	2021-10-04 13:23:20.98184	ORG61	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	61	2021-10-04 13:23:20.98184	development@test.com
6a584c04-b9ac-42dd-afbf-747a1a7c6ecb	0	2021-10-04 13:23:20.982143	Organisation 62	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	62	2021-10-04 13:23:20.982143	development@test.com
41da3ade-48e7-4e78-9fc2-a7b7b7b25237	0	2021-10-04 13:23:20.982412	ORG62	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	62	2021-10-04 13:23:20.982412	development@test.com
ae0f478a-7d9a-4ff6-9a51-dd906be33028	0	2021-10-04 13:23:20.982707	Organisation 63	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	63	2021-10-04 13:23:20.982707	development@test.com
f3827ce3-fe00-458c-92ae-756f688ac65a	0	2021-10-04 13:23:20.982988	ORG63	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	63	2021-10-04 13:23:20.982988	development@test.com
22bbcc07-5ee4-41fe-9dc7-21fd386ed371	0	2021-10-04 13:23:20.983253	Organisation 64	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	64	2021-10-04 13:23:20.983253	development@test.com
d767bb12-8241-4b2b-8efb-635c16346652	0	2021-10-04 13:23:20.983526	ORG64	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	64	2021-10-04 13:23:20.983526	development@test.com
6d1d2006-48e5-44ea-a970-084406b74ada	0	2021-10-04 13:23:20.983772	Organisation 65	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	65	2021-10-04 13:23:20.983772	development@test.com
a4e1ab50-cd00-413f-acf5-401daa61225b	0	2021-10-04 13:23:20.984052	ORG65	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	65	2021-10-04 13:23:20.984052	development@test.com
d4127914-49eb-40bc-a395-73782c5dee27	0	2021-10-04 13:23:20.984323	Organisation 66	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	66	2021-10-04 13:23:20.984323	development@test.com
af4838e6-d65d-4b73-99d9-9c1b1e8a56ca	0	2021-10-04 13:23:20.984632	ORG66	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	66	2021-10-04 13:23:20.984632	development@test.com
05f7a86d-311e-496b-8c7e-725d48bcd714	0	2021-10-04 13:23:20.984928	Organisation 67	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	67	2021-10-04 13:23:20.984928	development@test.com
1b36c167-fb1f-4621-9144-38ba53560bd4	0	2021-10-04 13:23:20.985222	ORG67	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	67	2021-10-04 13:23:20.985222	development@test.com
081860fd-24d0-446d-971a-cb1070f027a6	0	2021-10-04 13:23:20.98551	Organisation 68	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	68	2021-10-04 13:23:20.98551	development@test.com
9c708f8d-44f1-4eb0-bf6b-b851a3f43dc8	0	2021-10-04 13:23:20.985765	ORG68	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	68	2021-10-04 13:23:20.985765	development@test.com
58826baa-3c19-42a6-9a75-16b3e79e62b4	0	2021-10-04 13:23:20.986022	Organisation 69	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	69	2021-10-04 13:23:20.986022	development@test.com
04df864c-f554-411b-b91d-f0c2eca60d43	0	2021-10-04 13:23:20.986305	ORG69	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	69	2021-10-04 13:23:20.986305	development@test.com
acd1c891-d7b3-4566-897b-19576d1d1855	0	2021-10-04 13:23:20.986586	Organisation 70	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	70	2021-10-04 13:23:20.986586	development@test.com
77ed3dfb-a94a-4d45-b2ca-fc5b8289d9e9	0	2021-10-04 13:23:20.986881	ORG70	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	70	2021-10-04 13:23:20.986881	development@test.com
6da18cc3-b6bc-47a3-b00d-263fe7d091aa	0	2021-10-04 13:23:20.987205	Organisation 71	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	71	2021-10-04 13:23:20.987205	development@test.com
2af259b7-a721-4f1c-9368-9ed0b6b01a0d	0	2021-10-04 13:23:20.987532	ORG71	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	71	2021-10-04 13:23:20.987532	development@test.com
86fde8c2-88a1-4c79-9b3a-d9138c4e4ccb	0	2021-10-04 13:23:20.987886	Organisation 72	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	72	2021-10-04 13:23:20.987886	development@test.com
33b70799-b297-43d8-8602-46358e314441	0	2021-10-04 13:23:20.988242	ORG72	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	72	2021-10-04 13:23:20.988242	development@test.com
570db358-8b3f-47e6-b18b-eb2f664e8deb	0	2021-10-04 13:23:20.988538	Organisation 73	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	73	2021-10-04 13:23:20.988538	development@test.com
1a15a0a4-6f1d-4d96-82cb-1444243474a9	0	2021-10-04 13:23:20.988803	ORG73	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	73	2021-10-04 13:23:20.988803	development@test.com
48d4b248-7457-4a8e-af46-dcfdd3b38b76	0	2021-10-04 13:23:20.989064	Organisation 74	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	74	2021-10-04 13:23:20.989064	development@test.com
ac08da52-9262-4b36-b30d-811d5aa69077	0	2021-10-04 13:23:20.98934	ORG74	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	74	2021-10-04 13:23:20.98934	development@test.com
c2dfbd10-2c47-40c9-a69b-7c15b662310f	0	2021-10-04 13:23:20.989615	Organisation 75	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	75	2021-10-04 13:23:20.989615	development@test.com
5e486685-0297-43f4-8ff6-504a1082bc2e	0	2021-10-04 13:23:20.989916	ORG75	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	75	2021-10-04 13:23:20.989916	development@test.com
f4c67f01-fc93-47a7-ad66-0bea07be9982	0	2021-10-04 13:23:20.993621	Organisation 76	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	76	2021-10-04 13:23:20.993621	development@test.com
d9768525-2c75-4409-a4b2-2285316f520f	0	2021-10-04 13:23:20.994133	ORG76	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	76	2021-10-04 13:23:20.994133	development@test.com
4ca582a7-8463-4e91-af4e-59d8c5c7de44	0	2021-10-04 13:23:20.994496	Organisation 77	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	77	2021-10-04 13:23:20.994496	development@test.com
50d307b7-086e-474f-8168-7b505a77dbbd	0	2021-10-04 13:23:20.994857	ORG77	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	77	2021-10-04 13:23:20.994857	development@test.com
a0e030af-3883-4e88-9395-d8db6997d198	0	2021-10-04 13:23:20.995097	Organisation 78	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	78	2021-10-04 13:23:20.995097	development@test.com
ac57e40c-0e3c-4a70-8ac3-6a5dcae0dd47	0	2021-10-04 13:23:20.995329	ORG78	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	78	2021-10-04 13:23:20.995329	development@test.com
d256743d-de1d-413a-a558-8abc88b46963	0	2021-10-04 13:23:20.995525	Organisation 79	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	79	2021-10-04 13:23:20.995525	development@test.com
c8424351-0c88-4e6c-a3cc-86684d6ae1bd	0	2021-10-04 13:23:20.995747	ORG79	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	79	2021-10-04 13:23:20.995747	development@test.com
04291ee2-cf9e-414b-b8cb-df5f8b207a46	0	2021-10-04 13:23:20.996023	Organisation 80	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	80	2021-10-04 13:23:20.996023	development@test.com
f5ba08ea-15cc-4794-a339-86badb0a3043	0	2021-10-04 13:23:20.996292	ORG80	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	80	2021-10-04 13:23:20.996292	development@test.com
6d4ee42d-f638-4e34-ac9d-6f34bb05aede	0	2021-10-04 13:23:20.996583	Organisation 81	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	81	2021-10-04 13:23:20.996583	development@test.com
c7c4ded5-62e8-48be-99e1-0db8cc1ff716	0	2021-10-04 13:23:20.996862	ORG81	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	81	2021-10-04 13:23:20.996862	development@test.com
0dc46cb0-271f-4fa1-b21c-2a4663e7c449	0	2021-10-04 13:23:20.997163	Organisation 82	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	82	2021-10-04 13:23:20.997163	development@test.com
39892d69-6808-4185-b15c-ff58faeeb1b4	0	2021-10-04 13:23:20.997451	ORG82	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	82	2021-10-04 13:23:20.997451	development@test.com
316635cd-a57f-4c51-ad90-108a52d3ceea	0	2021-10-04 13:23:20.997785	Organisation 83	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	83	2021-10-04 13:23:20.997785	development@test.com
da939689-80f3-4cc6-9564-fcecf8c0bbd1	0	2021-10-04 13:23:20.99801	ORG83	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	83	2021-10-04 13:23:20.99801	development@test.com
cd746dea-1814-435d-ba0d-13f0679c74f8	0	2021-10-04 13:23:20.998264	Organisation 84	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	84	2021-10-04 13:23:20.998264	development@test.com
cb9e0f3d-ed70-4fbc-9928-b893d8f48911	0	2021-10-04 13:23:20.998451	ORG84	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	84	2021-10-04 13:23:20.998451	development@test.com
649acae2-6210-4f99-8676-a704d64d0be3	0	2021-10-04 13:23:20.998659	Organisation 85	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	85	2021-10-04 13:23:20.998659	development@test.com
0c1b1985-884f-403b-ab2f-86d7802f71c4	0	2021-10-04 13:23:20.999013	ORG85	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	85	2021-10-04 13:23:20.999013	development@test.com
ca6d7262-518a-4873-b0d5-d08f1bdd145e	0	2021-10-04 13:23:20.999282	Organisation 86	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	86	2021-10-04 13:23:20.999282	development@test.com
86d3b79e-c4ab-4bea-9958-f50b5ea646f2	0	2021-10-04 13:23:20.999502	ORG86	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	86	2021-10-04 13:23:20.999502	development@test.com
bef1188c-7af9-4506-b46e-921a08cee95d	0	2021-10-04 13:23:20.999827	Organisation 87	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	87	2021-10-04 13:23:20.999827	development@test.com
f99ae689-e0fa-4c37-831a-3dc29c17c8b9	0	2021-10-04 13:23:21.00014	ORG87	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	87	2021-10-04 13:23:21.00014	development@test.com
0dc9e9ac-51c9-428e-8c5b-1dbce5987298	0	2021-10-04 13:23:21.000355	Organisation 88	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	88	2021-10-04 13:23:21.000355	development@test.com
52942db8-4a6f-4f76-9619-46b2fc6565c5	0	2021-10-04 13:23:21.000562	ORG88	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	88	2021-10-04 13:23:21.000562	development@test.com
5a2c1983-fff2-41ba-ae16-3ee5b3ae418a	0	2021-10-04 13:23:21.000807	Organisation 89	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	89	2021-10-04 13:23:21.000807	development@test.com
b7f545d8-bc98-493e-8d76-1824dfa4b6ea	0	2021-10-04 13:23:21.001088	ORG89	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	89	2021-10-04 13:23:21.001088	development@test.com
0b4d8034-a82c-42c6-8742-94d3418656c9	0	2021-10-04 13:23:21.001287	Organisation 90	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	90	2021-10-04 13:23:21.001287	development@test.com
6a20a195-4ec6-4a3b-90b2-c6bbc2d6e268	0	2021-10-04 13:23:21.001508	ORG90	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	90	2021-10-04 13:23:21.001508	development@test.com
7c2be871-95c6-4f6b-a1d0-a99e75b2ce78	0	2021-10-04 13:23:21.005011	Organisation 91	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	91	2021-10-04 13:23:21.005011	development@test.com
1bbd385e-8d7e-4bb7-8e67-5fb0807ffb97	0	2021-10-04 13:23:21.005464	ORG91	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	91	2021-10-04 13:23:21.005464	development@test.com
54759073-bd64-4cd5-ad28-5f8713cab3e6	0	2021-10-04 13:23:21.005793	Organisation 92	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	92	2021-10-04 13:23:21.005793	development@test.com
437749ca-f8f0-4457-a264-bf7bfa39816e	0	2021-10-04 13:23:21.006127	ORG92	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	92	2021-10-04 13:23:21.006127	development@test.com
27bd795f-357c-4e59-8a42-948569e0c266	0	2021-10-04 13:23:21.006394	Organisation 93	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	93	2021-10-04 13:23:21.006394	development@test.com
20d8dfc6-2524-46ba-9ad9-da2bb0c1d94a	0	2021-10-04 13:23:21.006665	ORG93	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	93	2021-10-04 13:23:21.006665	development@test.com
15c66380-2ccc-431d-9972-5c82fbd46a51	0	2021-10-04 13:23:21.006989	Organisation 94	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	94	2021-10-04 13:23:21.006989	development@test.com
217dcf31-15e6-4418-b373-689c2142bd58	0	2021-10-04 13:23:21.007255	ORG94	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	94	2021-10-04 13:23:21.007255	development@test.com
c3fbdc1e-375f-4788-838e-c4d1b102557c	0	2021-10-04 13:23:21.007504	Organisation 95	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	95	2021-10-04 13:23:21.007504	development@test.com
3c64d8fc-be85-4580-8fe7-760efdf14b47	0	2021-10-04 13:23:21.007755	ORG95	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	95	2021-10-04 13:23:21.007755	development@test.com
945f47d7-e07a-45e6-bbe5-3eca33fc50a4	0	2021-10-04 13:23:21.00803	Organisation 96	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	96	2021-10-04 13:23:21.00803	development@test.com
6532e57f-ec97-4602-a2ad-5af1e2ee949a	0	2021-10-04 13:23:21.008292	ORG96	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	96	2021-10-04 13:23:21.008292	development@test.com
d20c7f6d-17b5-427d-9617-7c6ad1c4bab1	0	2021-10-04 13:23:21.008555	Organisation 97	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	97	2021-10-04 13:23:21.008555	development@test.com
2a961dc2-5abb-4d4a-97a9-e3b1d671f40a	0	2021-10-04 13:23:21.008809	ORG97	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	97	2021-10-04 13:23:21.008809	development@test.com
8cb17862-d1e1-4a5d-9793-34880edc0405	0	2021-10-04 13:23:21.009054	Organisation 98	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	98	2021-10-04 13:23:21.009054	development@test.com
f80e1a10-a045-40da-ba83-f3f5fc096160	0	2021-10-04 13:23:21.009302	ORG98	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	98	2021-10-04 13:23:21.009302	development@test.com
e44ea216-e25b-4085-9a5b-29f95d49b4f3	0	2021-10-04 13:23:21.009552	Organisation 99	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	99	2021-10-04 13:23:21.009552	development@test.com
19712f74-f7e7-45cf-b825-a0c3de02b2bf	0	2021-10-04 13:23:21.009818	ORG99	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	99	2021-10-04 13:23:21.009818	development@test.com
5a1e1170-599f-4fee-b850-341fa4941d91	0	2021-10-04 13:23:21.010091	Organisation 100	e309016a-b128-4282-afaa-37cdb8d88193	39b2093f-f62d-46f7-b1be-b350ea89cfe3	100	2021-10-04 13:23:21.010091	development@test.com
498843c5-05bb-4b4d-bce7-2283d1f8216b	0	2021-10-04 13:23:21.010347	ORG100	e309016a-b128-4282-afaa-37cdb8d88193	ee520084-a89c-4b72-9e8c-2d444b8093b6	100	2021-10-04 13:23:21.010347	development@test.com
\.


--
-- Data for Name: reference_enumeration_value; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.reference_enumeration_value (id, version, date_created, value, reference_enumeration_type_id, last_updated, path, depth, breadcrumb_tree_id, idx, category, created_by, aliases_string, key, label, description) FROM stdin;
\.


--
-- Data for Name: reference_summary_metadata; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.reference_summary_metadata (id, version, summary_metadata_type, date_created, last_updated, multi_facet_aware_item_domain_type, multi_facet_aware_item_id, created_by, label, description) FROM stdin;
\.


--
-- Data for Name: reference_summary_metadata_report; Type: TABLE DATA; Schema: referencedata; Owner: -
--

COPY referencedata.reference_summary_metadata_report (id, version, date_created, last_updated, report_date, created_by, report_value, summary_metadata_id) FROM stdin;
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: security; Owner: -
--

COPY security.api_key (id, version, refreshable, date_created, expiry_date, last_updated, disabled, catalogue_user_id, name, created_by) FROM stdin;
\.


--
-- Data for Name: catalogue_user; Type: TABLE DATA; Schema: security; Owner: -
--

COPY security.catalogue_user (id, version, pending, salt, date_created, first_name, profile_picture_id, last_updated, organisation, reset_token, disabled, job_title, email_address, user_preferences, password, created_by, temp_password, last_name, last_login, creation_method) FROM stdin;
2d0273f5-8181-4058-9497-5545b775a761	0	f	\\x5b694953745d3457	2021-10-04 13:23:12.857369	Unlogged	\N	2021-10-04 13:23:12.857369	\N	\N	f	\N	unlogged_user@mdm-core.com	\N	\N	unlogged_user@mdm-core.com	\N	User	\N	Standard
ff7c6a2a-7150-4b2a-825a-5f810036f16e	1	f	\\x483a786e53424076	2021-10-04 13:23:12.976558	Admin	\N	2021-10-04 13:23:13.050813	Oxford BRC Informatics	\N	f	God	admin@maurodatamapper.com	\N	\\xf505c0f5eb68970e2d116e47354e223e0d66d8153e54409e3d649b4af7f3c674	admin@maurodatamapper.com	\N	User	\N	Standard
7c8a30a0-42c4-447b-bbc6-a269c850b30e	0	f	\\x6637543138743179	2021-10-04 13:23:13.154042	authenticated	\N	2021-10-04 13:23:13.154042	\N	\N	f	\N	authenticated@test.com	\N	\N	development@test.com	n9i-CQm-M9T-iV5	User	\N	Standard
d6d74c87-1100-482a-a5cd-12998b5a6e4d	0	t	\\x7a655d7744677060	2021-10-04 13:23:13.159125	pending	\N	2021-10-04 13:23:13.159125	Oxford	\N	f	tester	pending@test.com	\N	\\xf01d8b5b3866619ee4354bb6c385b46db5d69b5774c75b1febc8cb49b943118f	development@test.com	\N	User	\N	Standard
812fc531-5697-472c-9474-b35d5922fb3a	1	f	\\x766e78687573316c	2021-10-04 13:23:13.149154	reader	\N	2021-10-04 13:23:13.187126	\N	\N	f	\N	reader@test.com	\N	\N	development@test.com	NqH-WiD-VYF-Z6f	User	\N	Standard
8c31cd01-f81b-40ef-b37b-ecfc1f7a9fd6	1	f	\\x4a6e725670463757	2021-10-04 13:23:13.143656	editor	\N	2021-10-04 13:23:13.1888	\N	\N	f	\N	editor@test.com	\N	\\x37891c7183409a00030d5d5354d9f46e95079628ec366c7ea2589c7c114f0fd9	development@test.com	\N	User	\N	Standard
ba64f21e-3f83-40c1-b4f4-71e08c555130	1	f	\\x4f7242484763666e	2021-10-04 13:23:13.174391	reviewer	\N	2021-10-04 13:23:13.189613	\N	\N	f	\N	reviewer@test.com	\N	\N	development@test.com	8QE-ZNW-pzE-N86	User	\N	Standard
45e86d02-ff69-4131-baab-22f9e7268316	1	f	\\x5d65713f755d3974	2021-10-04 13:23:13.164131	containerAdmin	\N	2021-10-04 13:23:13.190313	\N	\N	f	\N	container_admin@test.com	\N	\\x1bd686640f2b85465d679cdd923f295a013b3fdcc3315f4a528cdbf03b5cf5e7	development@test.com	\N	User	\N	Standard
7d3aef5b-7e95-426e-8996-c247d1e94bb9	1	f	\\x6238497854505774	2021-10-04 13:23:13.169364	author	\N	2021-10-04 13:23:13.190995	\N	\N	f	\N	author@test.com	\N	\N	development@test.com	Pth-hOj-Cd1-P5L	User	\N	Standard
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: security; Owner: -
--

COPY security.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.2.0	security	SQL	V1_2_0__security.sql	-399282874	maurodatamapper	2021-10-04 13:23:09.460619	55	t
2	1.8.0	add can finalise model	SQL	V1_8_0__add_can_finalise_model.sql	1474674104	maurodatamapper	2021-10-04 13:23:09.521053	1	t
3	1.10.0	add user group undeleteable	SQL	V1_10_0__add_user_group_undeleteable.sql	617768911	maurodatamapper	2021-10-04 13:23:09.525644	1	t
4	1.11.0	add api key	SQL	V1_11_0__add_api_key.sql	-351808098	maurodatamapper	2021-10-04 13:23:09.529907	8	t
5	2.0.0	remove extra securableresourcegrouprole columns	SQL	V2_0_0__remove_extra_securableresourcegrouprole_columns.sql	-794214980	maurodatamapper	2021-10-04 13:23:09.542067	2	t
6	2.1.0	cleanup non unique securableresourcegrouproles	SQL	V2_1_0__cleanup_non_unique_securableresourcegrouproles.sql	-1673556944	maurodatamapper	2021-10-04 13:23:09.547477	2	t
7	2.2.0	add creation method to users	SQL	V2_2_0__add_creation_method_to_users.sql	1701130066	maurodatamapper	2021-10-04 13:23:09.55262	1	t
\.


--
-- Data for Name: group_role; Type: TABLE DATA; Schema: security; Owner: -
--

COPY security.group_role (id, version, date_created, display_name, name, parent_id, last_updated, path, depth, application_level_role, created_by) FROM stdin;
fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2	0	2021-10-04 13:23:12.692455	Site Administrator	site_admin	\N	2021-10-04 13:23:12.692455		0	t	mdm-security@maurodatamapper.com
daf4df16-aee0-42bf-a1b5-b0c3c408cd87	0	2021-10-04 13:23:12.694429	Application Administrator	application_admin	fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2	2021-10-04 13:23:12.694429	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2	1	t	mdm-security@maurodatamapper.com
a2274f9d-8621-40f5-896d-52b1f0d69fe5	0	2021-10-04 13:23:12.702636	User Administrator	user_admin	daf4df16-aee0-42bf-a1b5-b0c3c408cd87	2021-10-04 13:23:12.702636	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2/daf4df16-aee0-42bf-a1b5-b0c3c408cd87	2	t	mdm-security@maurodatamapper.com
d1ad7192-fe07-4837-9e83-18941876fcec	0	2021-10-04 13:23:12.703465	Group Administrator	group_admin	a2274f9d-8621-40f5-896d-52b1f0d69fe5	2021-10-04 13:23:12.703465	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2/daf4df16-aee0-42bf-a1b5-b0c3c408cd87/a2274f9d-8621-40f5-896d-52b1f0d69fe5	3	t	mdm-security@maurodatamapper.com
126502e5-6b44-4d1b-a74d-be508a12bd7f	0	2021-10-04 13:23:12.704213	Container Group Administrator	container_group_admin	d1ad7192-fe07-4837-9e83-18941876fcec	2021-10-04 13:23:12.704213	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2/daf4df16-aee0-42bf-a1b5-b0c3c408cd87/a2274f9d-8621-40f5-896d-52b1f0d69fe5/d1ad7192-fe07-4837-9e83-18941876fcec	4	t	mdm-security@maurodatamapper.com
22531090-078a-4c74-b588-65493f037b09	0	2021-10-04 13:23:12.704916	Container Administrator	container_admin	fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2	2021-10-04 13:23:12.704916	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2	1	f	mdm-security@maurodatamapper.com
fef8c35b-5d23-4a05-8183-27b3ec905235	0	2021-10-04 13:23:12.705773	Editor	editor	22531090-078a-4c74-b588-65493f037b09	2021-10-04 13:23:12.705773	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2/22531090-078a-4c74-b588-65493f037b09	2	f	mdm-security@maurodatamapper.com
365d7d36-af1f-4a1c-8a1b-4bbc29b6d7b6	0	2021-10-04 13:23:12.707541	Author	author	fef8c35b-5d23-4a05-8183-27b3ec905235	2021-10-04 13:23:12.707541	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2/22531090-078a-4c74-b588-65493f037b09/fef8c35b-5d23-4a05-8183-27b3ec905235	3	f	mdm-security@maurodatamapper.com
330bca60-e2b7-4ad4-a418-6da95d568aab	0	2021-10-04 13:23:12.708357	Reviewer	reviewer	365d7d36-af1f-4a1c-8a1b-4bbc29b6d7b6	2021-10-04 13:23:12.708357	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2/22531090-078a-4c74-b588-65493f037b09/fef8c35b-5d23-4a05-8183-27b3ec905235/365d7d36-af1f-4a1c-8a1b-4bbc29b6d7b6	4	f	mdm-security@maurodatamapper.com
07eaaff9-494c-4530-a0f6-535fef2890d2	0	2021-10-04 13:23:12.709098	Reader	reader	330bca60-e2b7-4ad4-a418-6da95d568aab	2021-10-04 13:23:12.709098	/fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2/22531090-078a-4c74-b588-65493f037b09/fef8c35b-5d23-4a05-8183-27b3ec905235/365d7d36-af1f-4a1c-8a1b-4bbc29b6d7b6/330bca60-e2b7-4ad4-a418-6da95d568aab	5	f	mdm-security@maurodatamapper.com
\.


--
-- Data for Name: join_catalogue_user_to_user_group; Type: TABLE DATA; Schema: security; Owner: -
--

COPY security.join_catalogue_user_to_user_group (catalogue_user_id, user_group_id) FROM stdin;
ff7c6a2a-7150-4b2a-825a-5f810036f16e	c60aebf8-4c19-4a27-bc75-65bf1ca83dba
45e86d02-ff69-4131-baab-22f9e7268316	ea53d184-9b40-45ff-adbe-e9fa99170462
8c31cd01-f81b-40ef-b37b-ecfc1f7a9fd6	ea53d184-9b40-45ff-adbe-e9fa99170462
7d3aef5b-7e95-426e-8996-c247d1e94bb9	2b158579-51a4-474e-9dea-f0dea5b3a095
ba64f21e-3f83-40c1-b4f4-71e08c555130	2b158579-51a4-474e-9dea-f0dea5b3a095
812fc531-5697-472c-9474-b35d5922fb3a	2b158579-51a4-474e-9dea-f0dea5b3a095
\.


--
-- Data for Name: securable_resource_group_role; Type: TABLE DATA; Schema: security; Owner: -
--

COPY security.securable_resource_group_role (id, version, securable_resource_id, user_group_id, date_created, securable_resource_domain_type, last_updated, group_role_id, created_by) FROM stdin;
ed412331-5557-458c-b906-36cd1322e693	0	867eaaec-64b4-4736-8938-71caa2a0b837	ea53d184-9b40-45ff-adbe-e9fa99170462	2021-10-04 13:23:13.213592	Folder	2021-10-04 13:23:13.213592	22531090-078a-4c74-b588-65493f037b09	development@test.com
03588921-e3ca-4876-ad22-64686cec180e	0	867eaaec-64b4-4736-8938-71caa2a0b837	2b158579-51a4-474e-9dea-f0dea5b3a095	2021-10-04 13:23:13.221243	Folder	2021-10-04 13:23:13.221243	07eaaff9-494c-4530-a0f6-535fef2890d2	development@test.com
e8c5309f-8cb4-46c1-b471-3c5cdf38cb21	0	ed172493-dc3a-4125-ac99-d63373937ef9	ea53d184-9b40-45ff-adbe-e9fa99170462	2021-10-04 13:23:13.230146	Classifier	2021-10-04 13:23:13.230146	22531090-078a-4c74-b588-65493f037b09	development@test.com
9dafd88d-14f8-4721-ad64-c5835cba64ad	0	ed172493-dc3a-4125-ac99-d63373937ef9	2b158579-51a4-474e-9dea-f0dea5b3a095	2021-10-04 13:23:13.237726	Classifier	2021-10-04 13:23:13.237726	07eaaff9-494c-4530-a0f6-535fef2890d2	development@test.com
\.


--
-- Data for Name: user_group; Type: TABLE DATA; Schema: security; Owner: -
--

COPY security.user_group (id, version, date_created, last_updated, name, application_group_role_id, created_by, description, undeleteable) FROM stdin;
c60aebf8-4c19-4a27-bc75-65bf1ca83dba	0	2021-10-04 13:23:13.048335	2021-10-04 13:23:13.048335	administrators	fbb53a95-1dbb-4cb8-80c5-fb049f7bc7a2	admin@maurodatamapper.com	\N	t
ea53d184-9b40-45ff-adbe-e9fa99170462	0	2021-10-04 13:23:13.186153	2021-10-04 13:23:13.186153	editors	\N	development@test.com	\N	f
2b158579-51a4-474e-9dea-f0dea5b3a095	0	2021-10-04 13:23:13.199338	2021-10-04 13:23:13.199338	readers	\N	development@test.com	\N	f
\.


--
-- Data for Name: code_set; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.code_set (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag) FROM stdin;
abf2646e-dd2f-4271-84b8-c46893cb8dcc	1	2021-10-04 13:23:20.505576	t	f	2021-10-04 13:23:20.51	1.0.0	f	CodeSet	2021-10-04 13:23:20.521827	Oxford BRC	f	Test Bootstrap	\N	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Simple Test CodeSet	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	1.0.0	\N
692ace8b-5561-449d-8486-63ea44075ed4	2	2021-10-04 13:23:20.537116	f	f	\N	1.0.0	f	CodeSet	2021-10-04 13:23:20.569803	Oxford BRC	f	Test Bootstrap	\N	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Unfinalised Simple Test CodeSet	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1.3.0	terminology	SQL	V1_3_0__terminology.sql	712422872	maurodatamapper	2021-10-04 13:23:09.279078	121	t
2	1.5.2	add authority to terminology	SQL	V1_5_2__add_authority_to_terminology.sql	303081238	maurodatamapper	2021-10-04 13:23:09.404897	3	t
3	1.6.1	add extra model properties to terminology	SQL	V1_6_1__add_extra_model_properties_to_terminology.sql	-507038112	maurodatamapper	2021-10-04 13:23:09.411622	1	t
4	1.15.2	add rule to terminology	SQL	V1_15_2__add_rule_to_terminology.sql	413736981	maurodatamapper	2021-10-04 13:23:09.416168	6	t
5	2.0.0	add model version tag to terminology and codeset	SQL	V2_0_0__add_model_version_tag_to_terminology_and_codeset.sql	1715495761	maurodatamapper	2021-10-04 13:23:09.425426	1	t
6	2.1.0	fix erroneous new model of and wrong direction version links	SQL	V2_1_0__fix_erroneous_new_model_of_and_wrong_direction_version_links.sql	372732891	maurodatamapper	2021-10-04 13:23:09.429493	8	t
\.


--
-- Data for Name: join_codeset_to_facet; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.join_codeset_to_facet (codeset_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
abf2646e-dd2f-4271-84b8-c46893cb8dcc	d875859e-54f8-41af-897c-2173661b5174	\N	\N	\N	\N	\N	\N
692ace8b-5561-449d-8486-63ea44075ed4	\N	\N	\N	\N	\N	\N	1bde3b90-2c9e-424c-94a3-ebaf5cbe0ac3
\.


--
-- Data for Name: join_codeset_to_term; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.join_codeset_to_term (term_id, codeset_id) FROM stdin;
475576ab-7511-4b98-8cfb-562be8c4fcc5	abf2646e-dd2f-4271-84b8-c46893cb8dcc
0af12722-1469-4d38-a200-70a377986776	abf2646e-dd2f-4271-84b8-c46893cb8dcc
475576ab-7511-4b98-8cfb-562be8c4fcc5	692ace8b-5561-449d-8486-63ea44075ed4
0af12722-1469-4d38-a200-70a377986776	692ace8b-5561-449d-8486-63ea44075ed4
\.


--
-- Data for Name: join_term_to_facet; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.join_term_to_facet (term_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
4c69bf94-0d9e-4309-88a7-ea8b47846c9b	\N	\N	\N	\N	\N	62be9ce8-d9ae-43d1-9728-275624601853
\.


--
-- Data for Name: join_terminology_to_facet; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.join_terminology_to_facet (terminology_id, classifier_id, annotation_id, semantic_link_id, version_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
fa8b47d9-daae-4d61-a682-2a93a893c6ca	\N	\N	\N	\N	\N	\N	a0306048-3fcb-420a-b284-1d855b14ea0d
fa8b47d9-daae-4d61-a682-2a93a893c6ca	\N	1a916c53-f6de-4aba-aa18-7bf3d2544615	\N	\N	\N	\N	\N
fa8b47d9-daae-4d61-a682-2a93a893c6ca	\N	e3019892-36d7-45ba-b4bf-4fa02d29a1e7	\N	\N	\N	\N	\N
fa8b47d9-daae-4d61-a682-2a93a893c6ca	d875859e-54f8-41af-897c-2173661b5174	\N	\N	\N	\N	\N	\N
fa8b47d9-daae-4d61-a682-2a93a893c6ca	7d5e4809-6370-41cd-a4a3-cd1d91579ca0	\N	\N	\N	\N	\N	\N
fa8b47d9-daae-4d61-a682-2a93a893c6ca	\N	\N	\N	\N	\N	19ee3174-0aa8-4e15-8886-5de4bfce07f6	\N
fa8b47d9-daae-4d61-a682-2a93a893c6ca	\N	\N	\N	\N	\N	61c8b4e1-4d44-4c69-b0b8-678a19e90dd1	\N
fa8b47d9-daae-4d61-a682-2a93a893c6ca	\N	\N	\N	\N	\N	089fecf1-dc7d-430f-9099-1ab4d71a06e0	\N
3b623de2-7811-443d-b403-f06981264881	38e1a1ef-d3f2-42a3-b073-9e3c0eab1df5	\N	\N	\N	\N	\N	\N
3b623de2-7811-443d-b403-f06981264881	\N	\N	\N	\N	\N	41c4a90a-1a3c-4f5b-a498-8666a808ec84	\N
3b623de2-7811-443d-b403-f06981264881	\N	\N	\N	\N	\N	3e8ac82e-db36-4496-b40c-f9fa48a289de	\N
3b623de2-7811-443d-b403-f06981264881	\N	\N	\N	\N	\N	632dcf0c-811d-4ca8-8628-70d74c96da00	\N
\.


--
-- Data for Name: join_termrelationship_to_facet; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.join_termrelationship_to_facet (termrelationship_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
bf27abdf-d9a2-4461-9854-6d0b7c3ad21b	\N	\N	\N	\N	\N	021f56a1-1b48-45c1-bda4-39031b20f067
\.


--
-- Data for Name: join_termrelationshiptype_to_facet; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.join_termrelationshiptype_to_facet (termrelationshiptype_id, classifier_id, annotation_id, semantic_link_id, reference_file_id, metadata_id, rule_id) FROM stdin;
86c63a69-3f33-401f-afe8-32dab264d1fb	\N	\N	\N	\N	\N	385777b5-f35b-480c-b698-c33ed798d155
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.term (id, version, date_created, url, definition, terminology_id, is_parent, code, last_updated, path, depth, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
0dd3df81-ec25-4db1-9aa5-0d1b2d899034	0	2021-10-04 13:23:19.56513	https://google.co.uk	Complex Test Term 00	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT00	2021-10-04 13:23:19.56513	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	1	e699823c-f82d-44e9-a9bc-ab2573f05a95	2147483647	development@test.com	\N	CTT00: Complex Test Term 00	This is a very important description
f53c5264-8350-4b92-98be-c3fb976b1f57	0	2021-10-04 13:23:19.635983	\N	Complex Test Term 100	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT100	2021-10-04 13:23:19.635983	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	1	b795145b-9990-4bca-a650-9d2d773ae7f0	2147483647	development@test.com	\N	CTT100: Complex Test Term 100	\N
ae981c04-92cc-4ee6-b38e-9561a386703e	0	2021-10-04 13:23:19.636488	\N	CTT101	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT101	2021-10-04 13:23:19.636488	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	1	520f0b88-bec3-4e4e-a630-6a32faa3f21d	2147483647	development@test.com	\N	CTT101	Example of truncated term label when code and definition are the same
81773135-7779-40ca-9e07-31b4d5b8dd03	1	2021-10-04 13:23:19.615303	\N	Complex Test Term 66	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT66	2021-10-04 13:23:20.079099	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	c386374f-70d8-46f1-9761-d1e85be2d9a6	2147483647	development@test.com	\N	CTT66: Complex Test Term 66	\N
85a0f6b0-c0da-48a6-af33-8772aa496981	1	2021-10-04 13:23:19.623196	\N	Complex Test Term 81	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT81	2021-10-04 13:23:20.08092	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	ea1e0ff9-b8c3-4e6c-a9bc-b8bccd990b39	2147483647	development@test.com	\N	CTT81: Complex Test Term 81	\N
864376cf-3691-48b4-b218-9547717a16e4	1	2021-10-04 13:23:19.598444	\N	Complex Test Term 39	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT39	2021-10-04 13:23:20.081511	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	502ffb0f-5239-40d4-9701-32a7e0428b87	2147483647	development@test.com	\N	CTT39: Complex Test Term 39	\N
878bcde8-e98b-451b-8a77-616c5a057509	1	2021-10-04 13:23:19.624208	\N	Complex Test Term 83	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT83	2021-10-04 13:23:20.082047	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	2e4b7e3a-c94f-4ed8-b02b-e28b357c4469	2147483647	development@test.com	\N	CTT83: Complex Test Term 83	\N
88393671-e333-4dfd-9bb9-73776b8bf5c8	1	2021-10-04 13:23:19.57369	\N	Complex Test Term 12	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT12	2021-10-04 13:23:20.082537	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	4	bd1c29fa-77fa-438b-b271-0ea8e755edb3	2147483647	development@test.com	\N	CTT12: Complex Test Term 12	\N
89e014cc-5d4a-4b33-990e-32bcda03f5f1	1	2021-10-04 13:23:19.568294	\N	Complex Test Term 2	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT2	2021-10-04 13:23:20.08303	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	e42abde1-9972-4c9a-910d-93405ad41d5e	2147483647	development@test.com	\N	CTT2: Complex Test Term 2	\N
8c232f5e-7ea6-445a-911f-4ce266f1b1dc	1	2021-10-04 13:23:19.576781	\N	Complex Test Term 17	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT17	2021-10-04 13:23:20.083509	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	9	93bcb6e1-8494-404f-8588-c314fe9f2255	2147483647	development@test.com	\N	CTT17: Complex Test Term 17	\N
8c9dffc0-acdb-416c-acec-4b950e0d1cb7	1	2021-10-04 13:23:19.600567	\N	Complex Test Term 43	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT43	2021-10-04 13:23:20.083997	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	a887ca80-5b2d-4e22-9f8c-d95f21eb6bca	2147483647	development@test.com	\N	CTT43: Complex Test Term 43	\N
8cd60786-686b-47fb-901d-0410d2cbf21b	1	2021-10-04 13:23:19.577869	\N	Complex Test Term 19	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT19	2021-10-04 13:23:20.084456	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	11	d9c85ec5-f8ea-4f09-957c-dc1e71566be8	2147483647	development@test.com	\N	CTT19: Complex Test Term 19	\N
8df18676-2728-4cc3-8395-f231efaecd1d	1	2021-10-04 13:23:19.616802	\N	Complex Test Term 69	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT69	2021-10-04 13:23:20.084936	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	f8a858e3-0853-4c09-a8f6-69530f13fe14	2147483647	development@test.com	\N	CTT69: Complex Test Term 69	\N
95081140-122d-4db5-95bd-d0845c8751e6	1	2021-10-04 13:23:19.626904	\N	Complex Test Term 88	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT88	2021-10-04 13:23:20.085395	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	858b5711-1979-477b-8b3a-a812e9f4064d	2147483647	development@test.com	\N	CTT88: Complex Test Term 88	\N
980b9a60-4fc9-4734-bc21-656ec7073188	1	2021-10-04 13:23:19.581506	\N	Complex Test Term 26	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT26	2021-10-04 13:23:20.085861	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	22e6f504-2138-41a0-bb3b-d4d73747b33c	2147483647	development@test.com	\N	CTT26: Complex Test Term 26	\N
9c8a3b27-8bec-4822-a63b-9d01656e2972	1	2021-10-04 13:23:19.573151	\N	Complex Test Term 11	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT11	2021-10-04 13:23:20.086346	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	6ba114c3-3255-47bd-9cf5-eb09469780bc	2147483647	development@test.com	\N	CTT11: Complex Test Term 11	\N
a3039085-c3c3-41d7-b396-16e83ac79aad	1	2021-10-04 13:23:19.622675	\N	Complex Test Term 80	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT80	2021-10-04 13:23:20.08681	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	3aab644d-23de-4c99-8a31-340648165de6	2147483647	development@test.com	\N	CTT80: Complex Test Term 80	\N
a45642b2-e367-4dd3-9e65-e0abe67d1969	1	2021-10-04 13:23:19.616305	\N	Complex Test Term 68	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT68	2021-10-04 13:23:20.087281	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	bd539756-ebb4-4e10-8f1e-a2ed9f81c933	2147483647	development@test.com	\N	CTT68: Complex Test Term 68	\N
a846ac87-557f-45ea-822b-ca7f8bf754fc	1	2021-10-04 13:23:19.607861	\N	Complex Test Term 57	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT57	2021-10-04 13:23:20.087738	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	e2ebc928-1d0b-4174-987b-14c60aab17fc	2147483647	development@test.com	\N	CTT57: Complex Test Term 57	\N
a934a9f1-5b47-4995-b087-f1d54433aa1e	1	2021-10-04 13:23:19.572621	\N	Complex Test Term 10	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT10	2021-10-04 13:23:20.088619	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	bbc41ec2-a01f-4e03-983f-1dbc6e3779eb	2147483647	development@test.com	\N	CTT10: Complex Test Term 10	\N
ab531b62-af47-4e11-ae67-ee7b18b8bf9a	1	2021-10-04 13:23:19.579942	\N	Complex Test Term 23	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT23	2021-10-04 13:23:20.089098	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	71363338-3273-4e8d-99d4-10570c3f1443	2147483647	development@test.com	\N	CTT23: Complex Test Term 23	\N
aef3acca-96c0-4827-9e73-c3f89bc85118	1	2021-10-04 13:23:19.576236	\N	Complex Test Term 16	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT16	2021-10-04 13:23:20.089579	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	8	ca0581b1-0c98-4c9d-8d57-96962481f4da	2147483647	development@test.com	\N	CTT16: Complex Test Term 16	\N
af8368b3-b782-4c27-b593-7e8ac1ccae81	1	2021-10-04 13:23:19.612121	\N	Complex Test Term 60	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT60	2021-10-04 13:23:20.090076	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	8152e6c2-6607-478b-9e52-934f86361e1b	2147483647	development@test.com	\N	CTT60: Complex Test Term 60	\N
b1b1c31c-8c1f-46fe-8a7b-3f82433af150	1	2021-10-04 13:23:19.582049	\N	Complex Test Term 27	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT27	2021-10-04 13:23:20.090559	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	0566c55e-1db3-4668-a779-415d6d384ed9	2147483647	development@test.com	\N	CTT27: Complex Test Term 27	\N
b52bc4e7-ce89-47d6-917c-8d5e37ec0234	1	2021-10-04 13:23:19.575299	\N	Complex Test Term 15	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT15	2021-10-04 13:23:20.091011	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	7	5e7a841b-ff54-4ed2-a82d-7b0e9d95e217	2147483647	development@test.com	\N	CTT15: Complex Test Term 15	\N
b87d803e-a6ad-4017-8239-10c622d4572e	1	2021-10-04 13:23:19.583148	\N	Complex Test Term 29	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT29	2021-10-04 13:23:20.091495	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	3cf9c49a-fe5c-4886-89d6-1d95e5496494	2147483647	development@test.com	\N	CTT29: Complex Test Term 29	\N
be81e94c-1d7f-4c63-b0fc-f4eecef29983	1	2021-10-04 13:23:19.634974	\N	Complex Test Term 98	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT98	2021-10-04 13:23:20.091984	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	a5c05cd7-d036-47ec-96e8-ffcb950f8b01	2147483647	development@test.com	\N	CTT98: Complex Test Term 98	\N
c08834bb-029d-4bc0-812b-a5aaeda79f4d	1	2021-10-04 13:23:19.620353	\N	Complex Test Term 76	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT76	2021-10-04 13:23:20.092457	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	78199b78-de4f-4b86-bf38-ce092bb83764	2147483647	development@test.com	\N	CTT76: Complex Test Term 76	\N
c19c2d04-6b30-4215-bde1-8263f569297e	1	2021-10-04 13:23:19.614784	\N	Complex Test Term 65	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT65	2021-10-04 13:23:20.092938	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	eb83ad43-9242-4d3c-9d49-bd74db71551d	2147483647	development@test.com	\N	CTT65: Complex Test Term 65	\N
c605c709-2b2c-44c5-b174-e865d3724b52	1	2021-10-04 13:23:19.61781	\N	Complex Test Term 71	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT71	2021-10-04 13:23:20.093413	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	464f3d7b-b35c-4957-b6ae-4267311eaf6c	2147483647	development@test.com	\N	CTT71: Complex Test Term 71	\N
c62afddf-d800-4997-958d-e21af5b67e00	1	2021-10-04 13:23:19.621479	\N	Complex Test Term 78	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT78	2021-10-04 13:23:20.093893	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	2b0648b7-3b3d-4f52-af9d-ce7dd8ce94cd	2147483647	development@test.com	\N	CTT78: Complex Test Term 78	\N
c6435a11-e087-4cb9-bb01-81c88ab71113	1	2021-10-04 13:23:19.582598	\N	Complex Test Term 28	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT28	2021-10-04 13:23:20.094364	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	d22d28ce-0416-413e-b72d-63fe62c2c172	2147483647	development@test.com	\N	CTT28: Complex Test Term 28	\N
c9f71177-d940-44e2-9807-be88b8b7bc32	1	2021-10-04 13:23:19.613754	\N	Complex Test Term 63	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT63	2021-10-04 13:23:20.094841	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	c1780253-a811-41fe-858f-b3e0cf258d7f	2147483647	development@test.com	\N	CTT63: Complex Test Term 63	\N
cab6ed3e-d53d-442b-8581-920f2795a15e	1	2021-10-04 13:23:19.618807	\N	Complex Test Term 73	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT73	2021-10-04 13:23:20.098868	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	589e3265-0cb4-48e4-ad03-bccadc105fe4	2147483647	development@test.com	\N	CTT73: Complex Test Term 73	\N
cfa35353-0759-44e6-834c-2b986e698fd0	1	2021-10-04 13:23:19.619338	\N	Complex Test Term 74	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT74	2021-10-04 13:23:20.099559	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	591cd88f-4fc1-4d07-a241-8f526bd5fb19	2147483647	development@test.com	\N	CTT74: Complex Test Term 74	\N
d1a19f41-8726-4215-8a4e-774d448ab564	1	2021-10-04 13:23:19.612717	\N	Complex Test Term 61	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT61	2021-10-04 13:23:20.100059	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	bf1e3c0d-6166-4b49-ad0d-dead5a3595c7	2147483647	development@test.com	\N	CTT61: Complex Test Term 61	\N
da0f3dd2-4a9e-4bb0-a850-e235a6169571	1	2021-10-04 13:23:19.579438	\N	Complex Test Term 22	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT22	2021-10-04 13:23:20.100563	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	129811b4-1e77-4f99-ab41-b2b1b141a2b8	2147483647	development@test.com	\N	CTT22: Complex Test Term 22	\N
def451cd-dbd6-47aa-992b-e6b880b078a3	1	2021-10-04 13:23:19.603173	\N	Complex Test Term 48	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT48	2021-10-04 13:23:20.101059	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	10f0bfcb-db1b-47c3-b50a-ff0cd641a413	2147483647	development@test.com	\N	CTT48: Complex Test Term 48	\N
e14c6acb-4224-41e7-b724-789b652ba6ca	1	2021-10-04 13:23:19.580982	\N	Complex Test Term 25	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT25	2021-10-04 13:23:20.101546	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	dbad9404-ee8b-49b7-a68c-ee3f0020fc90	2147483647	development@test.com	\N	CTT25: Complex Test Term 25	\N
e477f4eb-9dd5-4a67-86bb-7e292ada8f58	1	2021-10-04 13:23:19.617301	\N	Complex Test Term 70	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT70	2021-10-04 13:23:20.102017	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	a5c5ade3-4b1d-4b77-b9e4-6b5e97f339a5	2147483647	development@test.com	\N	CTT70: Complex Test Term 70	\N
e507201e-f57f-4e90-b6c1-b8a83c51c702	1	2021-10-04 13:23:19.596837	\N	Complex Test Term 36	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT36	2021-10-04 13:23:20.102518	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	aaa79497-8338-4803-9b18-cd4414f9ece5	2147483647	development@test.com	\N	CTT36: Complex Test Term 36	\N
e5a57d8f-d9a1-45d9-8145-5bcfda4db009	1	2021-10-04 13:23:19.594205	\N	Complex Test Term 31	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT31	2021-10-04 13:23:20.102993	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	c0249fc0-f5a4-4633-afd1-39501b47a85f	2147483647	development@test.com	\N	CTT31: Complex Test Term 31	\N
e901be9b-113a-4ff1-b835-9fd1e509f3e1	1	2021-10-04 13:23:19.6058	\N	Complex Test Term 53	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT53	2021-10-04 13:23:20.103501	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	76af915f-f19f-4d36-895d-2dcdbefff1ef	2147483647	development@test.com	\N	CTT53: Complex Test Term 53	\N
ea8d3d31-39bc-4194-b0bc-fa0e23fc1771	1	2021-10-04 13:23:19.56997	\N	Complex Test Term 5	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT5	2021-10-04 13:23:20.103979	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	fdd81b9e-c89c-494a-81e0-f050e4dd58e0	2147483647	development@test.com	\N	CTT5: Complex Test Term 5	\N
ec45ea78-b949-4e33-b51b-9d021cf2e7e7	1	2021-10-04 13:23:19.606835	\N	Complex Test Term 55	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT55	2021-10-04 13:23:20.104505	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	25c2458d-c2e5-4416-9ae1-e1f60f6f5d27	2147483647	development@test.com	\N	CTT55: Complex Test Term 55	\N
ed487d06-4c11-473e-bc22-5ac46e223028	1	2021-10-04 13:23:19.615799	\N	Complex Test Term 67	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT67	2021-10-04 13:23:20.104994	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	13f344d3-7805-47d7-b72b-4dc75f309a63	2147483647	development@test.com	\N	CTT67: Complex Test Term 67	\N
f0df73e8-7599-4ca1-98b5-22ffc14e4195	1	2021-10-04 13:23:19.595803	\N	Complex Test Term 34	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT34	2021-10-04 13:23:20.105533	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	46141187-3649-41c7-83a1-fb9de002895b	2147483647	development@test.com	\N	CTT34: Complex Test Term 34	\N
f1f23747-06bc-4566-8576-1d263a5fe9f0	1	2021-10-04 13:23:19.625293	\N	Complex Test Term 85	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT85	2021-10-04 13:23:20.106043	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	5d7869d8-3d1e-4c96-8717-68f15085701f	2147483647	development@test.com	\N	CTT85: Complex Test Term 85	\N
f4227289-7fd1-4daf-8499-ed60f81de735	1	2021-10-04 13:23:19.626383	\N	Complex Test Term 87	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT87	2021-10-04 13:23:20.10672	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	55ada9eb-0b74-40ff-9fea-8d32038408e6	2147483647	development@test.com	\N	CTT87: Complex Test Term 87	\N
f783da6c-26dc-4403-b3d0-cf4a2a7581d8	1	2021-10-04 13:23:19.605266	\N	Complex Test Term 52	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT52	2021-10-04 13:23:20.107309	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	6c9707bd-bee6-43b0-a7b1-22317df9b087	2147483647	development@test.com	\N	CTT52: Complex Test Term 52	\N
f795e73f-8ec5-4d3c-b74c-3829f2aefd28	1	2021-10-04 13:23:19.598993	\N	Complex Test Term 40	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT40	2021-10-04 13:23:20.107873	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	3c8acaa5-93cc-47bd-bb1a-f035126263f4	2147483647	development@test.com	\N	CTT40: Complex Test Term 40	\N
f7c0ae7f-8e45-44f0-8cb8-b060f8176da0	1	2021-10-04 13:23:19.625847	\N	Complex Test Term 86	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT86	2021-10-04 13:23:20.108408	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	a11f4a13-621a-4ebb-ad7b-46946d389eab	2147483647	development@test.com	\N	CTT86: Complex Test Term 86	\N
f95c6c1e-48f4-4470-8c03-2c96798c51ae	1	2021-10-04 13:23:19.572076	\N	Complex Test Term 9	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT9	2021-10-04 13:23:20.108929	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	4681a151-0623-4ac9-96ed-0a9e4fe5fb4c	2147483647	development@test.com	\N	CTT9: Complex Test Term 9	\N
03314e3d-1598-4cdf-ac2b-15a5777f38c0	1	2021-10-04 13:23:19.571026	\N	Complex Test Term 7	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT7	2021-10-04 13:23:20.109429	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	62447a0c-d874-4540-8c4f-baec0d4950a8	2147483647	development@test.com	\N	CTT7: Complex Test Term 7	\N
04cb80c6-0c6b-48ea-b5ad-98bad16763b5	1	2021-10-04 13:23:19.632876	\N	Complex Test Term 94	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT94	2021-10-04 13:23:20.109949	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	586b9dd8-2b6f-4c29-9924-28a217d18ce0	2147483647	development@test.com	\N	CTT94: Complex Test Term 94	\N
05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e	1	2021-10-04 13:23:19.57155	\N	Complex Test Term 8	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT8	2021-10-04 13:23:20.110454	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	2ea0f7f0-89ee-4a30-bb0e-b697097f4a81	2147483647	development@test.com	\N	CTT8: Complex Test Term 8	\N
07bcbcd1-e322-4173-af44-0f7dfaee4259	1	2021-10-04 13:23:19.602125	\N	Complex Test Term 46	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT46	2021-10-04 13:23:20.110966	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	e8d3acf3-f58c-4353-8e11-1a7c26aa3731	2147483647	development@test.com	\N	CTT46: Complex Test Term 46	\N
07f6a86f-f82e-49e1-838b-104d251e9b3b	1	2021-10-04 13:23:19.600031	\N	Complex Test Term 42	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT42	2021-10-04 13:23:20.111458	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	f5df67e7-6fb1-4ec2-8c26-e21b8b34e257	2147483647	development@test.com	\N	CTT42: Complex Test Term 42	\N
0a7f5772-b95d-4db5-89da-d05458604648	1	2021-10-04 13:23:19.614276	\N	Complex Test Term 64	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT64	2021-10-04 13:23:20.111974	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	004f44e9-a7dd-4639-b1f1-292c8885cfa6	2147483647	development@test.com	\N	CTT64: Complex Test Term 64	\N
0ae53ea0-d964-4218-a5de-9826a41cac35	1	2021-10-04 13:23:19.59632	\N	Complex Test Term 35	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT35	2021-10-04 13:23:20.112491	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	a7472704-2123-4b5a-a097-7b3f6fe6fa18	2147483647	development@test.com	\N	CTT35: Complex Test Term 35	\N
0d938873-4766-4dac-930f-ddc43cad2c39	1	2021-10-04 13:23:19.604698	\N	Complex Test Term 51	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT51	2021-10-04 13:23:20.113011	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	b29f081f-528a-41da-9dc6-30d1cd07b684	2147483647	development@test.com	\N	CTT51: Complex Test Term 51	\N
118ae67a-dfc0-4a90-8e4d-7e458ffa8cce	1	2021-10-04 13:23:19.570503	\N	Complex Test Term 6	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT6	2021-10-04 13:23:20.113493	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	06613eaa-619b-49ae-a8e4-a8993a5e0041	2147483647	development@test.com	\N	CTT6: Complex Test Term 6	\N
12b9ade2-9bb9-4156-862c-4c16e4ff3b25	1	2021-10-04 13:23:19.613232	\N	Complex Test Term 62	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT62	2021-10-04 13:23:20.114016	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	28d6a82d-1acb-4822-ac42-2a84105b0094	2147483647	development@test.com	\N	CTT62: Complex Test Term 62	\N
1656d691-efa8-4975-b146-dee29de15b13	1	2021-10-04 13:23:19.594768	\N	Complex Test Term 32	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT32	2021-10-04 13:23:20.117545	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	0260d37b-ed28-48d8-a6ab-f61a702b1a91	2147483647	development@test.com	\N	CTT32: Complex Test Term 32	\N
16d658dc-9746-4b71-bdb0-b08b67e829d1	1	2021-10-04 13:23:19.632335	\N	Complex Test Term 93	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT93	2021-10-04 13:23:20.118291	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	e6f44a20-6f0a-4003-b7b9-f9ace6491cfb	2147483647	development@test.com	\N	CTT93: Complex Test Term 93	\N
1718e492-1838-4e25-8ed9-d340995e3f97	1	2021-10-04 13:23:19.633403	\N	Complex Test Term 95	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT95	2021-10-04 13:23:20.118822	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	48b3b248-a2af-4714-a2b9-bbb52cb5e000	2147483647	development@test.com	\N	CTT95: Complex Test Term 95	\N
18cd848d-eb53-49a7-8fd8-db08a979cb5f	1	2021-10-04 13:23:19.627408	\N	Complex Test Term 89	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT89	2021-10-04 13:23:20.119309	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	840c7a7f-5c92-4651-8b7d-0da7e3adca73	2147483647	development@test.com	\N	CTT89: Complex Test Term 89	\N
1b25e277-4ca6-4645-9eb6-7d403cb404dd	1	2021-10-04 13:23:19.597858	\N	Complex Test Term 38	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT38	2021-10-04 13:23:20.119861	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	1fc949ad-1ba2-4a92-bd1e-b9678490d42d	2147483647	development@test.com	\N	CTT38: Complex Test Term 38	\N
21b59ceb-c5b6-425e-a965-c625117178a6	1	2021-10-04 13:23:19.608925	\N	Complex Test Term 59	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT59	2021-10-04 13:23:20.120401	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	5d350f05-877b-4810-807c-3957dace5674	2147483647	development@test.com	\N	CTT59: Complex Test Term 59	\N
2c1f66bb-0583-4cbb-8d73-d422c177cfef	1	2021-10-04 13:23:19.620858	\N	Complex Test Term 77	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT77	2021-10-04 13:23:20.120893	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	9a5b9533-7f2e-41c2-acc4-7bb9a2563abf	2147483647	development@test.com	\N	CTT77: Complex Test Term 77	\N
2fbf3f4d-e2df-4b8e-bc83-669eaa6884f5	1	2021-10-04 13:23:19.607345	\N	Complex Test Term 56	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT56	2021-10-04 13:23:20.121458	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	54caa65b-9e23-404c-bd93-bdf2f63d6888	2147483647	development@test.com	\N	CTT56: Complex Test Term 56	\N
3036f548-7be0-4c54-a445-950a0b39c2b0	1	2021-10-04 13:23:19.635486	\N	Complex Test Term 99	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT99	2021-10-04 13:23:20.122167	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	e7a1ec3b-9fa9-41ea-be19-d7c2c43509d7	2147483647	development@test.com	\N	CTT99: Complex Test Term 99	\N
328e39c2-872e-4f16-a205-19b30ff7b2ef	1	2021-10-04 13:23:19.619844	\N	Complex Test Term 75	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT75	2021-10-04 13:23:20.122743	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	27449818-7d9b-4c0a-bd39-de66655ece6a	2147483647	development@test.com	\N	CTT75: Complex Test Term 75	\N
33614052-00c8-4f9c-805f-32e7924c2e06	1	2021-10-04 13:23:19.601084	\N	Complex Test Term 44	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT44	2021-10-04 13:23:20.123266	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	e3df3923-b04a-467f-8235-0da10c914b91	2147483647	development@test.com	\N	CTT44: Complex Test Term 44	\N
35ea045f-8a9b-486b-aad0-1d4547179938	1	2021-10-04 13:23:19.624722	\N	Complex Test Term 84	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT84	2021-10-04 13:23:20.123805	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	58e17a9b-bcb9-4bf6-a932-a69314580c01	2147483647	development@test.com	\N	CTT84: Complex Test Term 84	\N
368cceb7-ad83-4cf3-9581-fdb89fceb5b6	1	2021-10-04 13:23:19.597347	\N	Complex Test Term 37	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT37	2021-10-04 13:23:20.124338	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	676a5290-1214-4cd9-b753-bbe416ef76d0	2147483647	development@test.com	\N	CTT37: Complex Test Term 37	\N
3a34acb0-0717-4e5a-976f-eb5b1f3ed124	1	2021-10-04 13:23:19.569426	\N	Complex Test Term 4	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT4	2021-10-04 13:23:20.124909	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	7cddeb12-0623-49d4-885e-f4a7c6c8aa21	2147483647	development@test.com	\N	CTT4: Complex Test Term 4	\N
413df0ac-c866-44f9-af53-ca65f9c28da1	1	2021-10-04 13:23:19.603687	\N	Complex Test Term 49	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT49	2021-10-04 13:23:20.125443	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	d2333774-2aa5-4bd1-8afc-3efc3bc236e9	2147483647	development@test.com	\N	CTT49: Complex Test Term 49	\N
4157c9f7-b977-40f9-a0db-bd964aef5494	1	2021-10-04 13:23:19.623695	\N	Complex Test Term 82	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT82	2021-10-04 13:23:20.125949	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	2a6acf60-c726-493e-9d0a-704695bc24da	2147483647	development@test.com	\N	CTT82: Complex Test Term 82	\N
436ab4fe-f546-4982-9997-c002c2d46d65	1	2021-10-04 13:23:19.63176	\N	Complex Test Term 92	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT92	2021-10-04 13:23:20.126435	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	a0c56558-bf48-4700-97bf-f2be250ef7f4	2147483647	development@test.com	\N	CTT92: Complex Test Term 92	\N
443a219c-96ef-4afc-b9fe-a9968c96f1b1	1	2021-10-04 13:23:19.574766	\N	Complex Test Term 14	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT14	2021-10-04 13:23:20.126912	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	6	a1b2cb04-400d-4ce0-a8b5-2edd5d0d8b80	2147483647	development@test.com	\N	CTT14: Complex Test Term 14	\N
47c68fb7-0bfc-41d1-bb9d-3c484715ad22	1	2021-10-04 13:23:19.568874	\N	Complex Test Term 3	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT3	2021-10-04 13:23:20.127409	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	2591b722-682a-40be-96dc-af28fed7ffaf	2147483647	development@test.com	\N	CTT3: Complex Test Term 3	\N
47f19eca-d2dc-490a-9435-d824d8400ba0	1	2021-10-04 13:23:19.631195	\N	Complex Test Term 91	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT91	2021-10-04 13:23:20.127894	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	840f46ba-863f-4ee3-8841-efc430abef3f	2147483647	development@test.com	\N	CTT91: Complex Test Term 91	\N
4872b09e-94f2-4b75-a516-66b1a8636670	1	2021-10-04 13:23:19.633911	\N	Complex Test Term 96	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT96	2021-10-04 13:23:20.128403	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	1ea01b36-2f79-4b56-96d7-9c260d24fc5a	2147483647	development@test.com	\N	CTT96: Complex Test Term 96	\N
4a25866e-fbaa-4838-a2f6-6337ac5c6d2b	1	2021-10-04 13:23:19.577336	\N	Complex Test Term 18	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT18	2021-10-04 13:23:20.128931	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	10	32f83064-09ee-4533-b4c9-b27cd72cb121	2147483647	development@test.com	\N	CTT18: Complex Test Term 18	\N
4dc5e72d-8d4b-4a5c-8664-ba759fc2007a	1	2021-10-04 13:23:19.599508	\N	Complex Test Term 41	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT41	2021-10-04 13:23:20.129987	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	0a140c33-b602-4d37-996a-0ef0a7dd99eb	2147483647	development@test.com	\N	CTT41: Complex Test Term 41	\N
54f1ce72-0013-4a11-a24e-2abfa01b34c7	1	2021-10-04 13:23:19.578912	\N	Complex Test Term 21	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT21	2021-10-04 13:23:20.130456	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	d13b68d7-9ab3-4309-9a8a-cb37489f7cb3	2147483647	development@test.com	\N	CTT21: Complex Test Term 21	\N
553439f8-e19e-40a5-a253-48bb36e00199	1	2021-10-04 13:23:19.604195	\N	Complex Test Term 50	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT50	2021-10-04 13:23:20.130914	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	1838e389-ee88-4e13-96ec-bfdc752eb587	2147483647	development@test.com	\N	CTT50: Complex Test Term 50	\N
553b84d1-3cfb-40fe-ad09-74468c158f7c	1	2021-10-04 13:23:19.622089	\N	Complex Test Term 79	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT79	2021-10-04 13:23:20.131381	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	cf46a9cb-84e9-4ce3-b1b9-a598ac339882	2147483647	development@test.com	\N	CTT79: Complex Test Term 79	\N
55f22fde-097a-41a8-8e87-180e30b8e117	1	2021-10-04 13:23:19.606324	\N	Complex Test Term 54	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT54	2021-10-04 13:23:20.13184	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	d155d5be-2574-407b-8f3c-0ea049669883	2147483647	development@test.com	\N	CTT54: Complex Test Term 54	\N
578acfea-5b75-4ef8-acec-74f21d6c4471	1	2021-10-04 13:23:19.593335	\N	Complex Test Term 30	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT30	2021-10-04 13:23:20.132302	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	6bf87a51-d9d2-479e-8425-a74d125ac492	2147483647	development@test.com	\N	CTT30: Complex Test Term 30	\N
583adb72-aca6-41fb-a2ad-56eed28ef826	1	2021-10-04 13:23:19.574228	\N	Complex Test Term 13	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT13	2021-10-04 13:23:20.132771	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	5	66f479d1-5218-485e-9e06-3850c5a1bd96	2147483647	development@test.com	\N	CTT13: Complex Test Term 13	\N
58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	1	2021-10-04 13:23:19.63047	\N	Complex Test Term 90	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT90	2021-10-04 13:23:20.136417	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	7d8824bc-0c4c-4658-b6c1-0d7b0f8a49dd	2147483647	development@test.com	\N	CTT90: Complex Test Term 90	\N
598c1ae8-07e0-4e97-a72b-eda076bf92f7	1	2021-10-04 13:23:19.57839	\N	Complex Test Term 20	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT20	2021-10-04 13:23:20.137433	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	e7fcf247-ed7d-4fdf-96de-e5ca861b97d7	2147483647	development@test.com	\N	CTT20: Complex Test Term 20	\N
5b33d920-735d-4548-b152-c42d65a89485	1	2021-10-04 13:23:19.608398	\N	Complex Test Term 58	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT58	2021-10-04 13:23:20.13821	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	4d9bfc45-8688-4b94-87bc-c2061f9eb637	2147483647	development@test.com	\N	CTT58: Complex Test Term 58	\N
6ecaf047-9c75-426c-9041-bc1ec33d6a68	1	2021-10-04 13:23:19.6016	\N	Complex Test Term 45	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT45	2021-10-04 13:23:20.138878	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	292db074-9ada-4e1d-b30e-087a42495531	2147483647	development@test.com	\N	CTT45: Complex Test Term 45	\N
6f80cd8a-edc2-4398-a38e-e26ed6e2f467	1	2021-10-04 13:23:19.58046	\N	Complex Test Term 24	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT24	2021-10-04 13:23:20.139398	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	19ba9219-08af-4d16-af5e-dce3aee2bf17	2147483647	development@test.com	\N	CTT24: Complex Test Term 24	\N
71809374-0803-432c-b2cc-934904225ab7	1	2021-10-04 13:23:19.59528	\N	Complex Test Term 33	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT33	2021-10-04 13:23:20.139932	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	eb3ec6ce-3699-4156-a27b-f0f645095a65	2147483647	development@test.com	\N	CTT33: Complex Test Term 33	\N
734aa13a-a54e-4ea8-a363-5af80b09a31c	1	2021-10-04 13:23:19.634451	\N	Complex Test Term 97	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT97	2021-10-04 13:23:20.140452	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	9f27aac1-f63b-403e-a005-c63837c1e75a	2147483647	development@test.com	\N	CTT97: Complex Test Term 97	\N
780dafdb-7115-4d89-8466-124f3c984c76	1	2021-10-04 13:23:19.61831	\N	Complex Test Term 72	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT72	2021-10-04 13:23:20.141013	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	40d07642-393f-4b0b-a36b-bdd2354ecf39	2147483647	development@test.com	\N	CTT72: Complex Test Term 72	\N
7940bb06-7dba-4141-95c0-e2db8b98216f	1	2021-10-04 13:23:19.602659	\N	Complex Test Term 47	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT47	2021-10-04 13:23:20.141512	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	3	7032e9b0-6743-49a1-a4ce-c6876be54aae	2147483647	development@test.com	\N	CTT47: Complex Test Term 47	\N
4c69bf94-0d9e-4309-88a7-ea8b47846c9b	2	2021-10-04 13:23:19.567468	\N	Complex Test Term 1	fa8b47d9-daae-4d61-a682-2a93a893c6ca	f	CTT1	2021-10-04 13:23:20.418312	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	741f3396-560d-4eb8-be15-855d95a55907	2147483647	development@test.com	\N	CTT1: Complex Test Term 1	\N
475576ab-7511-4b98-8cfb-562be8c4fcc5	0	2021-10-04 13:23:20.471046	\N	Simple Test Term 01	3b623de2-7811-443d-b403-f06981264881	f	STT01	2021-10-04 13:23:20.471046	/3b623de2-7811-443d-b403-f06981264881	1	11d732f8-3402-4cc2-9149-5e21694f7db7	2147483647	development@test.com	\N	STT01: Simple Test Term 01	\N
0af12722-1469-4d38-a200-70a377986776	0	2021-10-04 13:23:20.472183	\N	Simple Test Term 02	3b623de2-7811-443d-b403-f06981264881	f	STT02	2021-10-04 13:23:20.472183	/3b623de2-7811-443d-b403-f06981264881	1	8433bb07-bf82-4805-a726-18b8e1e0f23e	2147483647	development@test.com	\N	STT02: Simple Test Term 02	\N
\.


--
-- Data for Name: term_relationship; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.term_relationship (id, version, date_created, target_term_id, relationship_type_id, last_updated, path, depth, source_term_id, breadcrumb_tree_id, idx, created_by, aliases_string, label, description) FROM stdin;
ea3a5b75-db74-46cb-a22e-981ebffade5a	0	2021-10-04 13:23:19.638884	4c69bf94-0d9e-4309-88a7-ea8b47846c9b	86c63a69-3f33-401f-afe8-32dab264d1fb	2021-10-04 13:23:19.638884	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/89e014cc-5d4a-4b33-990e-32bcda03f5f1	2	89e014cc-5d4a-4b33-990e-32bcda03f5f1	bf863861-2543-4891-8d40-e724517a79ab	2147483647	development@test.com	\N	narrowerThan	\N
0d44c455-647e-4f77-8767-9d2a355ecdcb	0	2021-10-04 13:23:19.639343	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.639343	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/89e014cc-5d4a-4b33-990e-32bcda03f5f1	2	89e014cc-5d4a-4b33-990e-32bcda03f5f1	1978606f-2df6-4cb6-8b5a-d9b16ed0084a	2147483647	development@test.com	\N	is-a-part-of	\N
5225a22d-baa2-410d-9551-c49aa8c0acd5	0	2021-10-04 13:23:19.63976	89e014cc-5d4a-4b33-990e-32bcda03f5f1	86c63a69-3f33-401f-afe8-32dab264d1fb	2021-10-04 13:23:19.63976	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/47c68fb7-0bfc-41d1-bb9d-3c484715ad22	2	47c68fb7-0bfc-41d1-bb9d-3c484715ad22	3cd6565b-11ad-4170-a98d-8444f05f9bf3	2147483647	development@test.com	\N	narrowerThan	\N
c3eb8a36-6bdf-4199-8301-88dc43b846e0	0	2021-10-04 13:23:19.640141	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.640141	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/47c68fb7-0bfc-41d1-bb9d-3c484715ad22	2	47c68fb7-0bfc-41d1-bb9d-3c484715ad22	57158cef-c721-4e3e-8a73-751d1e61843d	2147483647	development@test.com	\N	is-a-part-of	\N
c2bd5c4d-44a9-432b-8d6f-dc5d48d342e5	0	2021-10-04 13:23:19.640515	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.640515	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/3a34acb0-0717-4e5a-976f-eb5b1f3ed124	2	3a34acb0-0717-4e5a-976f-eb5b1f3ed124	8cb25aaf-3886-4600-8212-ea41bf061895	2147483647	development@test.com	\N	is-a-part-of	\N
de2de447-d71c-4d20-94ae-9d9f17ebe2ba	0	2021-10-04 13:23:19.640903	47c68fb7-0bfc-41d1-bb9d-3c484715ad22	86c63a69-3f33-401f-afe8-32dab264d1fb	2021-10-04 13:23:19.640903	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/3a34acb0-0717-4e5a-976f-eb5b1f3ed124	2	3a34acb0-0717-4e5a-976f-eb5b1f3ed124	03791513-aadf-42e4-9926-bbad795fce56	2147483647	development@test.com	\N	narrowerThan	\N
9b9d6403-5c10-416d-8cfb-a55d862d8526	0	2021-10-04 13:23:19.641312	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.641312	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/ea8d3d31-39bc-4194-b0bc-fa0e23fc1771	2	ea8d3d31-39bc-4194-b0bc-fa0e23fc1771	753188c8-6f83-47b0-8ff6-d43c64117392	2147483647	development@test.com	\N	is-a-part-of	\N
4355ac72-1f4a-4a18-a7cb-8f48afe74e19	0	2021-10-04 13:23:19.6417	3a34acb0-0717-4e5a-976f-eb5b1f3ed124	86c63a69-3f33-401f-afe8-32dab264d1fb	2021-10-04 13:23:19.6417	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/ea8d3d31-39bc-4194-b0bc-fa0e23fc1771	2	ea8d3d31-39bc-4194-b0bc-fa0e23fc1771	bf798318-5ab8-4c59-9694-717c536a16b8	2147483647	development@test.com	\N	narrowerThan	\N
44f3a48f-1a2e-4d66-85d4-729db7dbacc2	0	2021-10-04 13:23:19.642084	ea8d3d31-39bc-4194-b0bc-fa0e23fc1771	86c63a69-3f33-401f-afe8-32dab264d1fb	2021-10-04 13:23:19.642084	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/118ae67a-dfc0-4a90-8e4d-7e458ffa8cce	2	118ae67a-dfc0-4a90-8e4d-7e458ffa8cce	07f85470-2322-431b-820c-b1db3c1c4e05	2147483647	development@test.com	\N	narrowerThan	\N
a522ad1f-462b-4e48-a6f8-f797b72fdb0e	0	2021-10-04 13:23:19.642466	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.642466	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/118ae67a-dfc0-4a90-8e4d-7e458ffa8cce	2	118ae67a-dfc0-4a90-8e4d-7e458ffa8cce	762d77c6-f457-4218-a72f-961cb069d936	2147483647	development@test.com	\N	is-a-part-of	\N
f634e78e-5857-4a11-972a-d907164906f0	0	2021-10-04 13:23:19.642842	118ae67a-dfc0-4a90-8e4d-7e458ffa8cce	86c63a69-3f33-401f-afe8-32dab264d1fb	2021-10-04 13:23:19.642842	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/03314e3d-1598-4cdf-ac2b-15a5777f38c0	2	03314e3d-1598-4cdf-ac2b-15a5777f38c0	45e62b73-96da-4d29-9a1a-a8804b4f6c84	2147483647	development@test.com	\N	narrowerThan	\N
1303e2d2-770c-461d-9e2d-9911750acaaa	0	2021-10-04 13:23:19.64325	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.64325	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/03314e3d-1598-4cdf-ac2b-15a5777f38c0	2	03314e3d-1598-4cdf-ac2b-15a5777f38c0	738493aa-104a-40dc-90f3-b4a1bb81d0f6	2147483647	development@test.com	\N	is-a-part-of	\N
947b06d9-8819-4888-ab25-f9c1024a10c6	0	2021-10-04 13:23:19.643635	03314e3d-1598-4cdf-ac2b-15a5777f38c0	86c63a69-3f33-401f-afe8-32dab264d1fb	2021-10-04 13:23:19.643635	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e	2	05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e	536fa637-d1b4-4ae6-9cc1-3eefd3690c09	2147483647	development@test.com	\N	narrowerThan	\N
691cc1da-1392-4ae1-850e-5277139acb9b	0	2021-10-04 13:23:19.644029	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.644029	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e	2	05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e	f05d06ad-eb62-49a1-8469-e928f34e9ce3	2147483647	development@test.com	\N	is-a-part-of	\N
045bd408-5df4-4c03-89c9-8a2a20c57edd	0	2021-10-04 13:23:19.644405	05f2ea8e-2e02-461a-bdc9-0a5ac5d98e1e	86c63a69-3f33-401f-afe8-32dab264d1fb	2021-10-04 13:23:19.644405	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f95c6c1e-48f4-4470-8c03-2c96798c51ae	2	f95c6c1e-48f4-4470-8c03-2c96798c51ae	1aa1347f-4629-4b2e-8421-cbe3b08acf3b	2147483647	development@test.com	\N	narrowerThan	\N
a6c20a13-f47e-4e55-85d3-4209ff4a52de	0	2021-10-04 13:23:19.645185	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.645185	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f95c6c1e-48f4-4470-8c03-2c96798c51ae	2	f95c6c1e-48f4-4470-8c03-2c96798c51ae	0a753c0b-375d-4491-a1ed-8de3bf113c8c	2147483647	development@test.com	\N	is-a-part-of	\N
be2ce520-47f9-447a-8002-4f3dbb29ecd1	0	2021-10-04 13:23:19.645568	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.645568	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/a934a9f1-5b47-4995-b087-f1d54433aa1e	2	a934a9f1-5b47-4995-b087-f1d54433aa1e	34751c14-8b4a-4d5f-8063-1fe64d8af7c8	2147483647	development@test.com	\N	is-a-part-of	\N
4aa8dacb-a764-472e-bcdf-85cd6ad134e3	0	2021-10-04 13:23:19.645963	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.645963	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/9c8a3b27-8bec-4822-a63b-9d01656e2972	2	9c8a3b27-8bec-4822-a63b-9d01656e2972	324e88c3-7ed6-4fa3-8e78-5eabed11a52d	2147483647	development@test.com	\N	is-a-part-of	\N
a54d164d-62de-4f41-a412-2185f82228c0	0	2021-10-04 13:23:19.646352	88393671-e333-4dfd-9bb9-73776b8bf5c8	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	2021-10-04 13:23:19.646352	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/9c8a3b27-8bec-4822-a63b-9d01656e2972	2	9c8a3b27-8bec-4822-a63b-9d01656e2972	e55b64be-eec6-4aa1-92f3-7ac7a199c798	2147483647	development@test.com	\N	broaderThan	\N
082d0c31-e894-4221-b7da-9a58465d668f	0	2021-10-04 13:23:19.646738	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.646738	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/88393671-e333-4dfd-9bb9-73776b8bf5c8	2	88393671-e333-4dfd-9bb9-73776b8bf5c8	49ab3999-ac1e-4bd8-a9e2-84dd5e374911	2147483647	development@test.com	\N	is-a-part-of	\N
894357eb-d325-487b-b758-ea6f677639c9	0	2021-10-04 13:23:19.64713	583adb72-aca6-41fb-a2ad-56eed28ef826	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	2021-10-04 13:23:19.64713	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/88393671-e333-4dfd-9bb9-73776b8bf5c8	2	88393671-e333-4dfd-9bb9-73776b8bf5c8	a1f0d33f-dd51-45e7-907c-127a7936e400	2147483647	development@test.com	\N	broaderThan	\N
07753774-a24c-4c68-8665-590b2c4d80da	0	2021-10-04 13:23:19.64751	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.64751	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/583adb72-aca6-41fb-a2ad-56eed28ef826	2	583adb72-aca6-41fb-a2ad-56eed28ef826	6229ad1b-2c2a-4d82-bd15-40fc11ef42d3	2147483647	development@test.com	\N	is-a-part-of	\N
4d846c97-4626-4232-8360-a9bf94c4155c	0	2021-10-04 13:23:19.647885	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.647885	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/443a219c-96ef-4afc-b9fe-a9968c96f1b1	2	443a219c-96ef-4afc-b9fe-a9968c96f1b1	6e2c36f6-ead9-4fff-bc93-3f59799d4660	2147483647	development@test.com	\N	is-a-part-of	\N
75f0f914-1569-470e-84e9-528aea371c33	0	2021-10-04 13:23:19.648269	443a219c-96ef-4afc-b9fe-a9968c96f1b1	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	2021-10-04 13:23:19.648269	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/583adb72-aca6-41fb-a2ad-56eed28ef826	2	583adb72-aca6-41fb-a2ad-56eed28ef826	ab578a48-293a-4be0-9426-6b3c70b4ea18	2147483647	development@test.com	\N	broaderThan	\N
8abb670d-5a19-49ed-916b-eebd7b495a26	0	2021-10-04 13:23:19.648704	b52bc4e7-ce89-47d6-917c-8d5e37ec0234	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	2021-10-04 13:23:19.648704	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/443a219c-96ef-4afc-b9fe-a9968c96f1b1	2	443a219c-96ef-4afc-b9fe-a9968c96f1b1	2f7dcf27-c2a8-4bfb-8012-2ae294fb5cab	2147483647	development@test.com	\N	broaderThan	\N
82ff5a5e-f956-47b3-9c66-913fc55d2cf7	0	2021-10-04 13:23:19.649102	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.649102	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/b52bc4e7-ce89-47d6-917c-8d5e37ec0234	2	b52bc4e7-ce89-47d6-917c-8d5e37ec0234	f185d251-eaa8-4dcf-b953-8254dc136b2a	2147483647	development@test.com	\N	is-a-part-of	\N
c8af71de-e4c2-405c-991d-435ff1761769	0	2021-10-04 13:23:19.649498	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.649498	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/aef3acca-96c0-4827-9e73-c3f89bc85118	2	aef3acca-96c0-4827-9e73-c3f89bc85118	65631d80-d997-4c82-b9b0-ca4be664f639	2147483647	development@test.com	\N	is-a-part-of	\N
daefe11c-c5f4-498b-bcf1-ee46a6a17bda	0	2021-10-04 13:23:19.649872	aef3acca-96c0-4827-9e73-c3f89bc85118	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	2021-10-04 13:23:19.649872	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/b52bc4e7-ce89-47d6-917c-8d5e37ec0234	2	b52bc4e7-ce89-47d6-917c-8d5e37ec0234	f97973db-01e8-430a-9acb-8b665307f523	2147483647	development@test.com	\N	broaderThan	\N
b989636c-f150-45e3-8e57-77bb0e797e6a	0	2021-10-04 13:23:19.650248	8c232f5e-7ea6-445a-911f-4ce266f1b1dc	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	2021-10-04 13:23:19.650248	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/aef3acca-96c0-4827-9e73-c3f89bc85118	2	aef3acca-96c0-4827-9e73-c3f89bc85118	7660aaa2-c774-42ed-92be-abcd50ea7688	2147483647	development@test.com	\N	broaderThan	\N
97cf230c-81b1-4e1e-8e6c-4f25869bc7d8	0	2021-10-04 13:23:19.658639	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.658639	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/8c232f5e-7ea6-445a-911f-4ce266f1b1dc	2	8c232f5e-7ea6-445a-911f-4ce266f1b1dc	d4a0499e-ff42-4423-a2d9-015221cfa4ad	2147483647	development@test.com	\N	is-a-part-of	\N
5d14954f-bb9b-4161-a7f8-260db0c7e3e2	0	2021-10-04 13:23:19.659254	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.659254	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/4a25866e-fbaa-4838-a2f6-6337ac5c6d2b	2	4a25866e-fbaa-4838-a2f6-6337ac5c6d2b	8ec1e5a3-ac8b-4de3-b2e5-ca6a06cd7f80	2147483647	development@test.com	\N	is-a-part-of	\N
90e815ae-e0bc-49f3-ad97-69275f55ef19	0	2021-10-04 13:23:19.659662	4a25866e-fbaa-4838-a2f6-6337ac5c6d2b	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	2021-10-04 13:23:19.659662	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/8c232f5e-7ea6-445a-911f-4ce266f1b1dc	2	8c232f5e-7ea6-445a-911f-4ce266f1b1dc	ff771d54-461c-4fdf-b0e6-2d39b9fd5788	2147483647	development@test.com	\N	broaderThan	\N
737276a8-f3ed-4640-bd42-8ad7720849cc	0	2021-10-04 13:23:19.660125	a934a9f1-5b47-4995-b087-f1d54433aa1e	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.660125	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/8cd60786-686b-47fb-901d-0410d2cbf21b	2	8cd60786-686b-47fb-901d-0410d2cbf21b	23104e5c-7c22-4f5f-97cd-d21da5c95e00	2147483647	development@test.com	\N	is-a-part-of	\N
a79c7cf2-f648-4b0a-bb0a-c24d04719a3a	0	2021-10-04 13:23:19.660558	8cd60786-686b-47fb-901d-0410d2cbf21b	0fdd6c46-0864-441c-a0ad-8e0d87cbc528	2021-10-04 13:23:19.660558	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/4a25866e-fbaa-4838-a2f6-6337ac5c6d2b	2	4a25866e-fbaa-4838-a2f6-6337ac5c6d2b	80cba380-8208-4f58-9ab5-0ca6af7b46d7	2147483647	development@test.com	\N	broaderThan	\N
ad8b2dbb-30b4-445d-a84b-cf342dabb357	0	2021-10-04 13:23:19.660939	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.660939	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/598c1ae8-07e0-4e97-a72b-eda076bf92f7	2	598c1ae8-07e0-4e97-a72b-eda076bf92f7	5317c9ac-2309-4550-8ba1-a749d57ad801	2147483647	development@test.com	\N	is-a-part-of	\N
bfb890dc-b3fd-4e1e-b70c-1c9fc7030f53	0	2021-10-04 13:23:19.661314	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.661314	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/54f1ce72-0013-4a11-a24e-2abfa01b34c7	2	54f1ce72-0013-4a11-a24e-2abfa01b34c7	a1292e8a-e26f-413a-9847-1769fdeff35a	2147483647	development@test.com	\N	is-a-part-of	\N
8a01a171-a5b8-498f-a570-e2b7d0c9acb1	0	2021-10-04 13:23:19.661713	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.661713	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/da0f3dd2-4a9e-4bb0-a850-e235a6169571	2	da0f3dd2-4a9e-4bb0-a850-e235a6169571	41567699-e378-4990-a0ac-a6c8c5de55d6	2147483647	development@test.com	\N	is-a-part-of	\N
f94d7258-9a3f-4298-badf-dab295f5531d	0	2021-10-04 13:23:19.662104	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.662104	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/ab531b62-af47-4e11-ae67-ee7b18b8bf9a	2	ab531b62-af47-4e11-ae67-ee7b18b8bf9a	fdb8df61-3ade-4202-bc6f-31ec8de15d44	2147483647	development@test.com	\N	is-a-part-of	\N
c3dde2ea-0680-4019-b888-e317a3e48a43	0	2021-10-04 13:23:19.66251	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.66251	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/6f80cd8a-edc2-4398-a38e-e26ed6e2f467	2	6f80cd8a-edc2-4398-a38e-e26ed6e2f467	b2c0ce3d-91b5-4912-bcc7-e2f2c6c20152	2147483647	development@test.com	\N	is-a-part-of	\N
a756c120-56e7-4f75-8c9b-9d753e92fb5f	0	2021-10-04 13:23:19.662916	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.662916	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/e14c6acb-4224-41e7-b724-789b652ba6ca	2	e14c6acb-4224-41e7-b724-789b652ba6ca	74fb7b62-e341-49fd-bcf0-f4f82e11ec6c	2147483647	development@test.com	\N	is-a-part-of	\N
4052530c-d312-489c-bf3a-38cfcab720f0	0	2021-10-04 13:23:19.663309	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.663309	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/980b9a60-4fc9-4734-bc21-656ec7073188	2	980b9a60-4fc9-4734-bc21-656ec7073188	3bc08f5a-3fb6-4850-8b17-aaea798e3c1f	2147483647	development@test.com	\N	is-a-part-of	\N
d2838c13-aa68-4d69-9039-a54904baf295	0	2021-10-04 13:23:19.663684	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.663684	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/b1b1c31c-8c1f-46fe-8a7b-3f82433af150	2	b1b1c31c-8c1f-46fe-8a7b-3f82433af150	5c4facb6-9b35-4075-ab35-82e8443094f0	2147483647	development@test.com	\N	is-a-part-of	\N
d6677375-6d73-4d3d-a7ae-bf35ef4f4ce5	0	2021-10-04 13:23:19.664062	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.664062	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/c6435a11-e087-4cb9-bb01-81c88ab71113	2	c6435a11-e087-4cb9-bb01-81c88ab71113	90b23b09-37e4-494b-8473-a6dab8805ea9	2147483647	development@test.com	\N	is-a-part-of	\N
3ee32a6c-c3c4-45ac-90c5-60c1c5a0c927	0	2021-10-04 13:23:19.664466	598c1ae8-07e0-4e97-a72b-eda076bf92f7	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.664466	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/b87d803e-a6ad-4017-8239-10c622d4572e	2	b87d803e-a6ad-4017-8239-10c622d4572e	f6d383e7-7acd-454b-8461-4460a7c3bd9e	2147483647	development@test.com	\N	is-a-part-of	\N
229f835a-351e-4533-8c1e-7ca633a0a2d1	0	2021-10-04 13:23:19.664853	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.664853	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/578acfea-5b75-4ef8-acec-74f21d6c4471	2	578acfea-5b75-4ef8-acec-74f21d6c4471	c8c96392-c548-4810-bbbf-65b6cc18cd60	2147483647	development@test.com	\N	is-a-part-of	\N
7548a28f-e60f-4531-b8ec-2c70fe4722dd	0	2021-10-04 13:23:19.665246	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.665246	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/e5a57d8f-d9a1-45d9-8145-5bcfda4db009	2	e5a57d8f-d9a1-45d9-8145-5bcfda4db009	fa9d729d-9ce0-4983-af22-5fa8e3dd69ab	2147483647	development@test.com	\N	is-a-part-of	\N
c82f47fe-4ed2-4e7c-80fc-dcb39f15824a	0	2021-10-04 13:23:19.665642	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.665642	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/1656d691-efa8-4975-b146-dee29de15b13	2	1656d691-efa8-4975-b146-dee29de15b13	40e8b246-73f6-4e92-9aea-945e9598dcbc	2147483647	development@test.com	\N	is-a-part-of	\N
aa7517f4-4ed7-4534-a7cd-d89cac3a6d22	0	2021-10-04 13:23:19.666133	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.666133	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/71809374-0803-432c-b2cc-934904225ab7	2	71809374-0803-432c-b2cc-934904225ab7	c075998d-27c4-4105-9f3d-6da81146d38f	2147483647	development@test.com	\N	is-a-part-of	\N
1fd307bc-8e5c-42b0-9570-4ab6e1a9b0aa	0	2021-10-04 13:23:19.66665	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.66665	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f0df73e8-7599-4ca1-98b5-22ffc14e4195	2	f0df73e8-7599-4ca1-98b5-22ffc14e4195	f47f1730-a68b-4a8a-97ab-bbbfc2be757d	2147483647	development@test.com	\N	is-a-part-of	\N
d43195e3-ce42-49f8-80cb-8fa10bb75041	0	2021-10-04 13:23:19.667094	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.667094	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/0ae53ea0-d964-4218-a5de-9826a41cac35	2	0ae53ea0-d964-4218-a5de-9826a41cac35	fa9f3445-13cf-48d5-81d7-297009b92e66	2147483647	development@test.com	\N	is-a-part-of	\N
72e80b2d-5994-4197-be5c-15bb28943dbe	0	2021-10-04 13:23:19.667539	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.667539	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/e507201e-f57f-4e90-b6c1-b8a83c51c702	2	e507201e-f57f-4e90-b6c1-b8a83c51c702	381bbd43-da1f-4f96-872e-4772ba2e978c	2147483647	development@test.com	\N	is-a-part-of	\N
5a852efc-8a15-465d-8786-b0e07f69db55	0	2021-10-04 13:23:19.667994	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.667994	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/368cceb7-ad83-4cf3-9581-fdb89fceb5b6	2	368cceb7-ad83-4cf3-9581-fdb89fceb5b6	632dedcf-0641-43df-a6e4-36d97fca5501	2147483647	development@test.com	\N	is-a-part-of	\N
d0ce297a-c2ec-415c-8752-73fe13059f41	0	2021-10-04 13:23:19.668552	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.668552	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/1b25e277-4ca6-4645-9eb6-7d403cb404dd	2	1b25e277-4ca6-4645-9eb6-7d403cb404dd	19bb0bb3-5289-4cb3-99b7-12cbfadf1389	2147483647	development@test.com	\N	is-a-part-of	\N
60571d81-96ac-42df-ad79-c33ea89a9307	0	2021-10-04 13:23:19.668996	578acfea-5b75-4ef8-acec-74f21d6c4471	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.668996	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/864376cf-3691-48b4-b218-9547717a16e4	2	864376cf-3691-48b4-b218-9547717a16e4	1f748c85-9931-4869-b8eb-5e31a17d837b	2147483647	development@test.com	\N	is-a-part-of	\N
1e501792-7a44-4baa-a96a-c149e2003da6	0	2021-10-04 13:23:19.66941	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.66941	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f795e73f-8ec5-4d3c-b74c-3829f2aefd28	2	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	53fd626b-38cd-42fb-a5aa-d5f843de7f62	2147483647	development@test.com	\N	is-a-part-of	\N
2cf67028-d2c8-44eb-b5f5-60022f5f6553	0	2021-10-04 13:23:19.669812	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.669812	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/4dc5e72d-8d4b-4a5c-8664-ba759fc2007a	2	4dc5e72d-8d4b-4a5c-8664-ba759fc2007a	eeff48ea-d27b-4a0c-bf6c-da2694f181ec	2147483647	development@test.com	\N	is-a-part-of	\N
34a46dff-d01c-487f-93a5-a53080816cf7	0	2021-10-04 13:23:19.670224	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.670224	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/07f6a86f-f82e-49e1-838b-104d251e9b3b	2	07f6a86f-f82e-49e1-838b-104d251e9b3b	ed0c204c-8382-44f3-81f3-25245a7e4ba2	2147483647	development@test.com	\N	is-a-part-of	\N
e97553e9-dadd-478f-a05b-e0be835fdaf4	0	2021-10-04 13:23:19.670646	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.670646	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/8c9dffc0-acdb-416c-acec-4b950e0d1cb7	2	8c9dffc0-acdb-416c-acec-4b950e0d1cb7	1731f45c-117b-4764-8ba7-9c672f7f1daa	2147483647	development@test.com	\N	is-a-part-of	\N
31d5d8cc-6085-49e9-a3ca-dadd8a395a9d	0	2021-10-04 13:23:19.671036	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.671036	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/33614052-00c8-4f9c-805f-32e7924c2e06	2	33614052-00c8-4f9c-805f-32e7924c2e06	65a667bf-43a4-4fb8-9689-641995992f82	2147483647	development@test.com	\N	is-a-part-of	\N
c50b4090-7761-49c3-b9bf-40a5e5c4dcc8	0	2021-10-04 13:23:19.675079	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.675079	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/6ecaf047-9c75-426c-9041-bc1ec33d6a68	2	6ecaf047-9c75-426c-9041-bc1ec33d6a68	7daaf6a5-3a92-474b-b05f-13f8b6d62360	2147483647	development@test.com	\N	is-a-part-of	\N
65a4358d-d70d-453b-83ca-61111ee13a31	0	2021-10-04 13:23:19.675724	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.675724	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/07bcbcd1-e322-4173-af44-0f7dfaee4259	2	07bcbcd1-e322-4173-af44-0f7dfaee4259	c744f8fc-5c6a-4a9d-947e-aaabb2b91f71	2147483647	development@test.com	\N	is-a-part-of	\N
50e478e0-1880-4c6d-914d-dec641886084	0	2021-10-04 13:23:19.676138	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.676138	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/7940bb06-7dba-4141-95c0-e2db8b98216f	2	7940bb06-7dba-4141-95c0-e2db8b98216f	a218715e-f7df-4147-9192-beca15c820d9	2147483647	development@test.com	\N	is-a-part-of	\N
fe4baa66-ab88-4ec4-ac29-e249a88f96bd	0	2021-10-04 13:23:19.676536	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.676536	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/def451cd-dbd6-47aa-992b-e6b880b078a3	2	def451cd-dbd6-47aa-992b-e6b880b078a3	da7246f4-00e6-4e96-9629-bac6f220be27	2147483647	development@test.com	\N	is-a-part-of	\N
f5e02d45-45b3-433a-ae63-aa7dc3488537	0	2021-10-04 13:23:19.676933	f795e73f-8ec5-4d3c-b74c-3829f2aefd28	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.676933	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/413df0ac-c866-44f9-af53-ca65f9c28da1	2	413df0ac-c866-44f9-af53-ca65f9c28da1	6f8c8fe2-17c4-451e-8cc3-d54afd86d0aa	2147483647	development@test.com	\N	is-a-part-of	\N
93464241-4f5a-4e21-bc64-239b33e820ca	0	2021-10-04 13:23:19.677328	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.677328	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/553439f8-e19e-40a5-a253-48bb36e00199	2	553439f8-e19e-40a5-a253-48bb36e00199	a0745a73-656d-4622-9b66-45a67ecfd35b	2147483647	development@test.com	\N	is-a-part-of	\N
7a61290a-24e7-47b9-8353-912d5d07eafc	0	2021-10-04 13:23:19.677719	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.677719	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/0d938873-4766-4dac-930f-ddc43cad2c39	2	0d938873-4766-4dac-930f-ddc43cad2c39	2982332d-8378-4bc6-b6c2-af346c8ef7d9	2147483647	development@test.com	\N	is-a-part-of	\N
985bfc64-2503-4e1d-840b-796f404f5334	0	2021-10-04 13:23:19.678105	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.678105	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f783da6c-26dc-4403-b3d0-cf4a2a7581d8	2	f783da6c-26dc-4403-b3d0-cf4a2a7581d8	17392641-ebba-42b4-84cf-f6293d331557	2147483647	development@test.com	\N	is-a-part-of	\N
f5a0c158-e97f-4c0a-81ea-09ad32638fa1	0	2021-10-04 13:23:19.678492	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.678492	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/e901be9b-113a-4ff1-b835-9fd1e509f3e1	2	e901be9b-113a-4ff1-b835-9fd1e509f3e1	1f182a7b-ab12-42ee-bb4b-0c38451c0825	2147483647	development@test.com	\N	is-a-part-of	\N
0dab8c00-c9d1-4aa4-a256-d420317835a7	0	2021-10-04 13:23:19.678873	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.678873	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/55f22fde-097a-41a8-8e87-180e30b8e117	2	55f22fde-097a-41a8-8e87-180e30b8e117	3dc80100-a96e-435b-b498-a81ba193af50	2147483647	development@test.com	\N	is-a-part-of	\N
39528559-8570-4459-9b92-1d34c2b256a8	0	2021-10-04 13:23:19.679265	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.679265	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/ec45ea78-b949-4e33-b51b-9d021cf2e7e7	2	ec45ea78-b949-4e33-b51b-9d021cf2e7e7	065a0958-d4f4-4ae2-89c5-b1553d39cd8a	2147483647	development@test.com	\N	is-a-part-of	\N
299ed7b3-f0a1-4070-ae39-80d4349e4468	0	2021-10-04 13:23:19.679654	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.679654	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/2fbf3f4d-e2df-4b8e-bc83-669eaa6884f5	2	2fbf3f4d-e2df-4b8e-bc83-669eaa6884f5	15ec6173-6b6c-4e5c-b49b-cc8cadb3722e	2147483647	development@test.com	\N	is-a-part-of	\N
e2a6b6e1-df19-4102-9a6f-8556d6e0a55e	0	2021-10-04 13:23:19.680041	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.680041	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/a846ac87-557f-45ea-822b-ca7f8bf754fc	2	a846ac87-557f-45ea-822b-ca7f8bf754fc	7c5eb5b7-b483-498e-9b36-8903ca859525	2147483647	development@test.com	\N	is-a-part-of	\N
aaef4866-4632-4bd3-b034-40584fc63b73	0	2021-10-04 13:23:19.680425	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.680425	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/5b33d920-735d-4548-b152-c42d65a89485	2	5b33d920-735d-4548-b152-c42d65a89485	807dd4f4-5112-436f-aab3-24996331f952	2147483647	development@test.com	\N	is-a-part-of	\N
36c087ca-cbe2-4876-a4da-8e83163868ec	0	2021-10-04 13:23:19.68081	553439f8-e19e-40a5-a253-48bb36e00199	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.68081	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/21b59ceb-c5b6-425e-a965-c625117178a6	2	21b59ceb-c5b6-425e-a965-c625117178a6	903ab489-6fb4-4b77-b872-59c072ded6fe	2147483647	development@test.com	\N	is-a-part-of	\N
f0efe38f-cb47-4123-99b6-620bf0769721	0	2021-10-04 13:23:19.681198	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.681198	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/af8368b3-b782-4c27-b593-7e8ac1ccae81	2	af8368b3-b782-4c27-b593-7e8ac1ccae81	39b5bcd9-7cf1-4825-b84d-724daedc8e47	2147483647	development@test.com	\N	is-a-part-of	\N
c330efa0-cdbd-4d53-827a-061956aa5f64	0	2021-10-04 13:23:19.681581	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.681581	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/d1a19f41-8726-4215-8a4e-774d448ab564	2	d1a19f41-8726-4215-8a4e-774d448ab564	f4272f7a-7ac6-49a0-9564-a9bd4f3c5f69	2147483647	development@test.com	\N	is-a-part-of	\N
676d8c5f-4610-43f6-bf1e-5859876d0207	0	2021-10-04 13:23:19.68196	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.68196	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/12b9ade2-9bb9-4156-862c-4c16e4ff3b25	2	12b9ade2-9bb9-4156-862c-4c16e4ff3b25	c6a87e53-77e0-4c2f-96c2-ee2133f3dfa1	2147483647	development@test.com	\N	is-a-part-of	\N
ee54677b-ce8b-4e4b-b9a0-bf6f6f95768d	0	2021-10-04 13:23:19.682341	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.682341	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/c9f71177-d940-44e2-9807-be88b8b7bc32	2	c9f71177-d940-44e2-9807-be88b8b7bc32	0cb21e94-22b5-4b05-b38f-07f64043c67a	2147483647	development@test.com	\N	is-a-part-of	\N
c321667a-7ae3-4fe5-ac5d-dd66ae4e6f38	0	2021-10-04 13:23:19.682733	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.682733	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/0a7f5772-b95d-4db5-89da-d05458604648	2	0a7f5772-b95d-4db5-89da-d05458604648	83ea1399-1ca9-4ed4-90ef-4650a586ba50	2147483647	development@test.com	\N	is-a-part-of	\N
a06eef77-48b4-4dd5-ae06-1599fa1feeff	0	2021-10-04 13:23:19.683187	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.683187	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/c19c2d04-6b30-4215-bde1-8263f569297e	2	c19c2d04-6b30-4215-bde1-8263f569297e	ec323690-9d99-4422-b2dd-303d55fd0c68	2147483647	development@test.com	\N	is-a-part-of	\N
d52c7a3c-e878-441b-bc08-2b3e16b44589	0	2021-10-04 13:23:19.683613	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.683613	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/81773135-7779-40ca-9e07-31b4d5b8dd03	2	81773135-7779-40ca-9e07-31b4d5b8dd03	d22f997d-668a-46fc-bb59-0149d5c21d7c	2147483647	development@test.com	\N	is-a-part-of	\N
688449cb-5a44-4ca3-9e06-42535c9772d8	0	2021-10-04 13:23:19.68401	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.68401	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/ed487d06-4c11-473e-bc22-5ac46e223028	2	ed487d06-4c11-473e-bc22-5ac46e223028	aed37100-2474-412a-80f0-5bbe5228685e	2147483647	development@test.com	\N	is-a-part-of	\N
21df5cb6-e800-4324-bbf0-8573800165b1	0	2021-10-04 13:23:19.684389	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.684389	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/a45642b2-e367-4dd3-9e65-e0abe67d1969	2	a45642b2-e367-4dd3-9e65-e0abe67d1969	3f1531e7-b633-4210-a59b-085eb11b96f1	2147483647	development@test.com	\N	is-a-part-of	\N
29de9216-8abd-4170-aff8-5cebd5a554d7	0	2021-10-04 13:23:19.68477	af8368b3-b782-4c27-b593-7e8ac1ccae81	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.68477	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/8df18676-2728-4cc3-8395-f231efaecd1d	2	8df18676-2728-4cc3-8395-f231efaecd1d	fe94ba42-7eaa-4d10-94ec-4228c7187cd3	2147483647	development@test.com	\N	is-a-part-of	\N
da007a85-ac1c-4fc8-8d23-53c40be3b5b2	0	2021-10-04 13:23:19.685207	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.685207	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/e477f4eb-9dd5-4a67-86bb-7e292ada8f58	2	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	626f7348-e1a2-439f-8fe4-a82e8c1634eb	2147483647	development@test.com	\N	is-a-part-of	\N
e4e8ce9b-973f-492d-9796-4c02e5253469	0	2021-10-04 13:23:19.685609	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.685609	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/c605c709-2b2c-44c5-b174-e865d3724b52	2	c605c709-2b2c-44c5-b174-e865d3724b52	5bfdf553-219c-4647-a027-4d64a2357503	2147483647	development@test.com	\N	is-a-part-of	\N
d91b985f-57fe-45bf-9361-89c259bcfdb9	0	2021-10-04 13:23:19.685993	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.685993	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/780dafdb-7115-4d89-8466-124f3c984c76	2	780dafdb-7115-4d89-8466-124f3c984c76	c642b601-0ed6-4907-a7e5-148f93b6e33c	2147483647	development@test.com	\N	is-a-part-of	\N
ba52e6ba-2fbf-4ece-9016-509c75a03c9e	0	2021-10-04 13:23:19.686376	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.686376	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/cab6ed3e-d53d-442b-8581-920f2795a15e	2	cab6ed3e-d53d-442b-8581-920f2795a15e	93594f4c-5527-4774-b6c1-d52b71520f6c	2147483647	development@test.com	\N	is-a-part-of	\N
6cd73536-7442-4ea5-8c82-a9d98e3bc73e	0	2021-10-04 13:23:19.686764	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.686764	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/cfa35353-0759-44e6-834c-2b986e698fd0	2	cfa35353-0759-44e6-834c-2b986e698fd0	d1501c2e-eaf0-4db4-9c7a-9edcdfa76008	2147483647	development@test.com	\N	is-a-part-of	\N
51cbf3b1-a8c3-44d2-9ca6-4e5e8c671965	0	2021-10-04 13:23:19.690356	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.690356	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/328e39c2-872e-4f16-a205-19b30ff7b2ef	2	328e39c2-872e-4f16-a205-19b30ff7b2ef	e7e69be2-68e6-4203-baee-d2032f2c3c98	2147483647	development@test.com	\N	is-a-part-of	\N
d6da33b6-136b-4136-8b9b-2a6b3a28ce3b	0	2021-10-04 13:23:19.690821	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.690821	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/c08834bb-029d-4bc0-812b-a5aaeda79f4d	2	c08834bb-029d-4bc0-812b-a5aaeda79f4d	641d62ad-6ffb-492b-8f03-46b196c74e5f	2147483647	development@test.com	\N	is-a-part-of	\N
e1f691e0-d1e8-4164-9063-bc8b665a89da	0	2021-10-04 13:23:19.691202	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.691202	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/2c1f66bb-0583-4cbb-8d73-d422c177cfef	2	2c1f66bb-0583-4cbb-8d73-d422c177cfef	da6b9cc2-1072-4f9c-8173-7a4c0b5a4341	2147483647	development@test.com	\N	is-a-part-of	\N
687dd1fc-2f53-40c7-91b3-c0f6e11f723b	0	2021-10-04 13:23:19.691583	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.691583	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/c62afddf-d800-4997-958d-e21af5b67e00	2	c62afddf-d800-4997-958d-e21af5b67e00	cf17bc2e-731c-47ba-8684-c6e9e43e5f95	2147483647	development@test.com	\N	is-a-part-of	\N
0dc55880-4ae4-4c44-9053-352050c342fb	0	2021-10-04 13:23:19.691973	e477f4eb-9dd5-4a67-86bb-7e292ada8f58	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.691973	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/553b84d1-3cfb-40fe-ad09-74468c158f7c	2	553b84d1-3cfb-40fe-ad09-74468c158f7c	1f32f303-4678-4655-857c-9a32e4201075	2147483647	development@test.com	\N	is-a-part-of	\N
eed7fd55-fb6c-48b5-a702-e9242818c2b2	0	2021-10-04 13:23:19.692381	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.692381	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/a3039085-c3c3-41d7-b396-16e83ac79aad	2	a3039085-c3c3-41d7-b396-16e83ac79aad	43c242a3-06ad-4cad-b453-eb8759e6df3b	2147483647	development@test.com	\N	is-a-part-of	\N
42a003d8-2dbe-4e6c-bee1-1239ff3d7789	0	2021-10-04 13:23:19.692779	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.692779	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/85a0f6b0-c0da-48a6-af33-8772aa496981	2	85a0f6b0-c0da-48a6-af33-8772aa496981	997962cc-9dfd-40e5-8cf1-042727f31e10	2147483647	development@test.com	\N	is-a-part-of	\N
0307c397-080f-41b8-8db9-ed0b54ea1b13	0	2021-10-04 13:23:19.693167	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.693167	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/4157c9f7-b977-40f9-a0db-bd964aef5494	2	4157c9f7-b977-40f9-a0db-bd964aef5494	110adc99-5b16-4a28-a78b-7b6e115b7993	2147483647	development@test.com	\N	is-a-part-of	\N
e392c8df-fca8-488f-8e18-f41f8f0af4f3	0	2021-10-04 13:23:19.693556	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.693556	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/878bcde8-e98b-451b-8a77-616c5a057509	2	878bcde8-e98b-451b-8a77-616c5a057509	25f129e0-076c-4747-81bf-7babb66b5e5e	2147483647	development@test.com	\N	is-a-part-of	\N
30569cb3-b367-44e9-b500-d8c63b351037	0	2021-10-04 13:23:19.693942	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.693942	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/35ea045f-8a9b-486b-aad0-1d4547179938	2	35ea045f-8a9b-486b-aad0-1d4547179938	78e4e10f-0173-42fa-b9ec-22d025fba91d	2147483647	development@test.com	\N	is-a-part-of	\N
f82df746-f4a3-4129-8ce9-2550407d384f	0	2021-10-04 13:23:19.694337	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.694337	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f1f23747-06bc-4566-8576-1d263a5fe9f0	2	f1f23747-06bc-4566-8576-1d263a5fe9f0	5ab7f6b0-1c0b-4883-bae8-1fc2b5f5d353	2147483647	development@test.com	\N	is-a-part-of	\N
15a248e7-a931-4c05-af49-ea241c3bf9ea	0	2021-10-04 13:23:19.694746	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.694746	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f7c0ae7f-8e45-44f0-8cb8-b060f8176da0	2	f7c0ae7f-8e45-44f0-8cb8-b060f8176da0	5d59524f-7a29-4956-b712-b5f9317d5fb0	2147483647	development@test.com	\N	is-a-part-of	\N
c3fb4a0d-d074-45af-adae-fd96d7bc99c0	0	2021-10-04 13:23:19.695174	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.695174	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f4227289-7fd1-4daf-8499-ed60f81de735	2	f4227289-7fd1-4daf-8499-ed60f81de735	2388760b-76c3-4e31-bb31-1ae985ff677e	2147483647	development@test.com	\N	is-a-part-of	\N
68e2e068-47db-46bb-ba4c-03b14ae7c2af	0	2021-10-04 13:23:19.695567	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.695567	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/95081140-122d-4db5-95bd-d0845c8751e6	2	95081140-122d-4db5-95bd-d0845c8751e6	1a827654-1393-444e-9983-904fdf62a67d	2147483647	development@test.com	\N	is-a-part-of	\N
8f34beaf-89ee-4dc8-83d7-e28af1b9d39c	0	2021-10-04 13:23:19.695957	a3039085-c3c3-41d7-b396-16e83ac79aad	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.695957	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/18cd848d-eb53-49a7-8fd8-db08a979cb5f	2	18cd848d-eb53-49a7-8fd8-db08a979cb5f	bddddecf-a170-4c86-91b2-b38935fe0c2d	2147483647	development@test.com	\N	is-a-part-of	\N
28ecc8ba-bea5-4d40-8e93-c16639a8be15	0	2021-10-04 13:23:19.696346	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.696346	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	2	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	667da2d7-d5d8-40d1-ae49-42848fda6504	2147483647	development@test.com	\N	is-a-part-of	\N
aadfede8-3018-4a64-956b-5df72a06c6d3	0	2021-10-04 13:23:19.696727	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.696727	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/47f19eca-d2dc-490a-9435-d824d8400ba0	2	47f19eca-d2dc-490a-9435-d824d8400ba0	20a6d37a-3cf3-4563-9d79-856fcccf4199	2147483647	development@test.com	\N	is-a-part-of	\N
d73b390b-b7b9-41cc-bf62-a4a8babe11fa	0	2021-10-04 13:23:19.6971	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.6971	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/436ab4fe-f546-4982-9997-c002c2d46d65	2	436ab4fe-f546-4982-9997-c002c2d46d65	4c5a82bd-c220-478c-8532-4730e0b313bd	2147483647	development@test.com	\N	is-a-part-of	\N
e7c7b7f9-f691-4025-9b94-a89c865b5d8c	0	2021-10-04 13:23:19.697489	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.697489	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/16d658dc-9746-4b71-bdb0-b08b67e829d1	2	16d658dc-9746-4b71-bdb0-b08b67e829d1	2fc1f71f-b540-4427-ae22-3add21336146	2147483647	development@test.com	\N	is-a-part-of	\N
14306054-afed-4ba9-aad5-f9e47b58f8f2	0	2021-10-04 13:23:19.697859	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.697859	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/04cb80c6-0c6b-48ea-b5ad-98bad16763b5	2	04cb80c6-0c6b-48ea-b5ad-98bad16763b5	7822a97c-f124-4ef6-b46e-bf68f5501424	2147483647	development@test.com	\N	is-a-part-of	\N
aa2dfef3-6957-46ba-bf0c-ad805090837c	0	2021-10-04 13:23:19.698238	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.698238	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/1718e492-1838-4e25-8ed9-d340995e3f97	2	1718e492-1838-4e25-8ed9-d340995e3f97	3a61bf1d-55e8-4ac1-9271-63aedde1884f	2147483647	development@test.com	\N	is-a-part-of	\N
f5b2d7be-00c0-4fd1-bc33-44a795baaab2	0	2021-10-04 13:23:19.698611	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.698611	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/4872b09e-94f2-4b75-a516-66b1a8636670	2	4872b09e-94f2-4b75-a516-66b1a8636670	cc5f077c-9728-420d-abc7-80e4f99972ad	2147483647	development@test.com	\N	is-a-part-of	\N
264e062d-6e10-4136-a4e6-57385e39736b	0	2021-10-04 13:23:19.698989	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.698989	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/734aa13a-a54e-4ea8-a363-5af80b09a31c	2	734aa13a-a54e-4ea8-a363-5af80b09a31c	e8351010-f9d6-4509-b44b-688fb810a28b	2147483647	development@test.com	\N	is-a-part-of	\N
3df3cc36-ae3f-43af-9054-a2af32690e9f	0	2021-10-04 13:23:19.69937	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.69937	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/be81e94c-1d7f-4c63-b0fc-f4eecef29983	2	be81e94c-1d7f-4c63-b0fc-f4eecef29983	37d24bde-1c7d-4cc7-be7e-c0dba3b6933c	2147483647	development@test.com	\N	is-a-part-of	\N
4d761652-1b02-47aa-a041-e0ea252b4be6	0	2021-10-04 13:23:19.699758	58f5ad41-2ba1-49ed-a72d-9a4141ff66fd	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:19.699758	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/3036f548-7be0-4c54-a445-950a0b39c2b0	2	3036f548-7be0-4c54-a445-950a0b39c2b0	33b9e43c-63f8-4921-8e19-8eb3d10c9e76	2147483647	development@test.com	\N	is-a-part-of	\N
83b0f019-65c5-490c-8ead-5a879be5be33	0	2021-10-04 13:23:19.700136	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	8c743bcc-30fc-4a4a-ac96-1f295364742b	2021-10-04 13:23:19.700136	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/f53c5264-8350-4b92-98be-c3fb976b1f57	2	f53c5264-8350-4b92-98be-c3fb976b1f57	57fde8c8-40b3-43ab-938a-325d03bbd1ce	2147483647	development@test.com	\N	is-a	\N
bf27abdf-d9a2-4461-9854-6d0b7c3ad21b	1	2021-10-04 13:23:19.637048	0dd3df81-ec25-4db1-9aa5-0d1b2d899034	fb178eb6-6853-415f-ae97-ee480f8d65fe	2021-10-04 13:23:20.421393	/fa8b47d9-daae-4d61-a682-2a93a893c6ca/4c69bf94-0d9e-4309-88a7-ea8b47846c9b	3	4c69bf94-0d9e-4309-88a7-ea8b47846c9b	6ad59ede-38a1-4e1f-96b2-785c14840e37	2147483647	development@test.com	\N	is-a-part-of	\N
\.


--
-- Data for Name: term_relationship_type; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.term_relationship_type (id, version, date_created, child_relationship, terminology_id, last_updated, path, depth, breadcrumb_tree_id, parental_relationship, idx, created_by, aliases_string, label, display_label, description) FROM stdin;
8c743bcc-30fc-4a4a-ac96-1f295364742b	0	2021-10-04 13:23:19.562065	f	fa8b47d9-daae-4d61-a682-2a93a893c6ca	2021-10-04 13:23:19.562065	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	1	838bbecb-42b3-4ea5-9d0c-49a12bd71901	f	2147483647	development@test.com	\N	is-a	Is A	\N
fb178eb6-6853-415f-ae97-ee480f8d65fe	0	2021-10-04 13:23:19.563418	t	fa8b47d9-daae-4d61-a682-2a93a893c6ca	2021-10-04 13:23:19.563418	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	1	caad33b6-6a74-4aa1-bdf6-2021affb7fde	f	2147483647	development@test.com	\N	is-a-part-of	Is A Part Of	\N
0fdd6c46-0864-441c-a0ad-8e0d87cbc528	0	2021-10-04 13:23:19.563901	f	fa8b47d9-daae-4d61-a682-2a93a893c6ca	2021-10-04 13:23:19.563901	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	1	ce269fc0-1d58-4ceb-81c3-fd4df2e2630b	t	2147483647	development@test.com	\N	broaderThan	Broader Than	\N
86c63a69-3f33-401f-afe8-32dab264d1fb	1	2021-10-04 13:23:19.564299	f	fa8b47d9-daae-4d61-a682-2a93a893c6ca	2021-10-04 13:23:20.420367	/fa8b47d9-daae-4d61-a682-2a93a893c6ca	1	41c5f9fe-09c1-4f65-a2d7-82624653c947	f	2147483647	development@test.com	\N	narrowerThan	Narrower Than	\N
\.


--
-- Data for Name: terminology; Type: TABLE DATA; Schema: terminology; Owner: -
--

COPY terminology.terminology (id, version, date_created, finalised, readable_by_authenticated_users, date_finalised, documentation_version, readable_by_everyone, model_type, last_updated, organisation, deleted, author, breadcrumb_tree_id, folder_id, created_by, aliases_string, label, description, authority_id, branch_name, model_version, model_version_tag) FROM stdin;
fa8b47d9-daae-4d61-a682-2a93a893c6ca	2	2021-10-04 13:23:19.164696	f	f	\N	1.0.0	f	Terminology	2021-10-04 13:23:19.706036	Oxford BRC	f	Test Bootstrap	9aea6e3b-d9d8-4cd3-a6c8-7575e8271924	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Complex Test Terminology	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
3b623de2-7811-443d-b403-f06981264881	1	2021-10-04 13:23:20.452337	f	f	\N	1.0.0	f	Terminology	2021-10-04 13:23:20.475154	Oxford BRC	f	Test Bootstrap	85ffbe1e-69df-49ee-a1ae-889a595780de	867eaaec-64b4-4736-8938-71caa2a0b837	development@test.com	\N	Simple Test Terminology	\N	b5f79af9-dd57-4da3-844e-122cd65cd031	main	\N	\N
\.


--
-- Name: annotation annotation_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.annotation
    ADD CONSTRAINT annotation_pkey PRIMARY KEY (id);


--
-- Name: api_property api_property_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.api_property
    ADD CONSTRAINT api_property_pkey PRIMARY KEY (id);


--
-- Name: authority authority_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.authority
    ADD CONSTRAINT authority_pkey PRIMARY KEY (id);


--
-- Name: breadcrumb_tree breadcrumb_tree_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.breadcrumb_tree
    ADD CONSTRAINT breadcrumb_tree_pkey PRIMARY KEY (id);


--
-- Name: classifier classifier_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT classifier_pkey PRIMARY KEY (id);


--
-- Name: edit edit_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.edit
    ADD CONSTRAINT edit_pkey PRIMARY KEY (id);


--
-- Name: email email_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: folder folder_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- Name: metadata metadata_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.metadata
    ADD CONSTRAINT metadata_pkey PRIMARY KEY (id);


--
-- Name: reference_file reference_file_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.reference_file
    ADD CONSTRAINT reference_file_pkey PRIMARY KEY (id);


--
-- Name: rule rule_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.rule
    ADD CONSTRAINT rule_pkey PRIMARY KEY (id);


--
-- Name: rule_representation rule_representation_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.rule_representation
    ADD CONSTRAINT rule_representation_pkey PRIMARY KEY (id);


--
-- Name: semantic_link semantic_link_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.semantic_link
    ADD CONSTRAINT semantic_link_pkey PRIMARY KEY (id);


--
-- Name: classifier uk_j7bbt97ko557eewc3u50ha8ko; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT uk_j7bbt97ko557eewc3u50ha8ko UNIQUE (label);


--
-- Name: authority ukfcae2aea4497b223b1762d7b79a3; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.authority
    ADD CONSTRAINT ukfcae2aea4497b223b1762d7b79a3 UNIQUE (url, label);


--
-- Name: user_image_file user_image_file_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.user_image_file
    ADD CONSTRAINT user_image_file_pkey PRIMARY KEY (id);


--
-- Name: version_link version_link_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.version_link
    ADD CONSTRAINT version_link_pkey PRIMARY KEY (id);


--
-- Name: data_class_component data_class_component_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT data_class_component_pkey PRIMARY KEY (id);


--
-- Name: data_element_component data_element_component_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT data_element_component_pkey PRIMARY KEY (id);


--
-- Name: data_flow data_flow_pkey; Type: CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT data_flow_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: data_class data_class_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT data_class_pkey PRIMARY KEY (id);


--
-- Name: data_element data_element_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT data_element_pkey PRIMARY KEY (id);


--
-- Name: data_model data_model_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT data_model_pkey PRIMARY KEY (id);


--
-- Name: data_type data_type_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT data_type_pkey PRIMARY KEY (id);


--
-- Name: enumeration_value enumeration_value_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT enumeration_value_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: summary_metadata summary_metadata_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.summary_metadata
    ADD CONSTRAINT summary_metadata_pkey PRIMARY KEY (id);


--
-- Name: summary_metadata_report summary_metadata_report_pkey; Type: CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.summary_metadata_report
    ADD CONSTRAINT summary_metadata_report_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: federation; Owner: -
--

ALTER TABLE ONLY federation.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: subscribed_catalogue subscribed_catalogue_pkey; Type: CONSTRAINT; Schema: federation; Owner: -
--

ALTER TABLE ONLY federation.subscribed_catalogue
    ADD CONSTRAINT subscribed_catalogue_pkey PRIMARY KEY (id);


--
-- Name: subscribed_model subscribed_model_pkey; Type: CONSTRAINT; Schema: federation; Owner: -
--

ALTER TABLE ONLY federation.subscribed_model
    ADD CONSTRAINT subscribed_model_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: reference_data_element reference_data_element_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT reference_data_element_pkey PRIMARY KEY (id);


--
-- Name: reference_data_model reference_data_model_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT reference_data_model_pkey PRIMARY KEY (id);


--
-- Name: reference_data_type reference_data_type_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT reference_data_type_pkey PRIMARY KEY (id);


--
-- Name: reference_data_value reference_data_value_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT reference_data_value_pkey PRIMARY KEY (id);


--
-- Name: reference_enumeration_value reference_enumeration_value_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT reference_enumeration_value_pkey PRIMARY KEY (id);


--
-- Name: reference_summary_metadata reference_summary_metadata_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_summary_metadata
    ADD CONSTRAINT reference_summary_metadata_pkey PRIMARY KEY (id);


--
-- Name: reference_summary_metadata_report reference_summary_metadata_report_pkey; Type: CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_summary_metadata_report
    ADD CONSTRAINT reference_summary_metadata_report_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_pkey; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (id);


--
-- Name: catalogue_user catalogue_user_pkey; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT catalogue_user_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: group_role group_role_pkey; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT group_role_pkey PRIMARY KEY (id);


--
-- Name: join_catalogue_user_to_user_group join_catalogue_user_to_user_group_pkey; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT join_catalogue_user_to_user_group_pkey PRIMARY KEY (user_group_id, catalogue_user_id);


--
-- Name: securable_resource_group_role securable_resource_group_role_pkey; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT securable_resource_group_role_pkey PRIMARY KEY (id);


--
-- Name: catalogue_user uk_26qjnuqu76954q376opkqelqd; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT uk_26qjnuqu76954q376opkqelqd UNIQUE (email_address);


--
-- Name: group_role uk_7kvrlnisllgg2md5614ywh82g; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT uk_7kvrlnisllgg2md5614ywh82g UNIQUE (name);


--
-- Name: user_group uk_kas9w8ead0ska5n3csefp2bpp; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT uk_kas9w8ead0ska5n3csefp2bpp UNIQUE (name);


--
-- Name: api_key ukee162bd1d3e12dac9f8ef55811f7; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT ukee162bd1d3e12dac9f8ef55811f7 UNIQUE (catalogue_user_id, name);


--
-- Name: user_group user_group_pkey; Type: CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT user_group_pkey PRIMARY KEY (id);


--
-- Name: code_set code_set_pkey; Type: CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT code_set_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: term term_pkey; Type: CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT term_pkey PRIMARY KEY (id);


--
-- Name: term_relationship term_relationship_pkey; Type: CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT term_relationship_pkey PRIMARY KEY (id);


--
-- Name: term_relationship_type term_relationship_type_pkey; Type: CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT term_relationship_type_pkey PRIMARY KEY (id);


--
-- Name: terminology terminology_pkey; Type: CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT terminology_pkey PRIMARY KEY (id);


--
-- Name: annotation_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX annotation_created_by_idx ON core.annotation USING btree (created_by);


--
-- Name: annotation_parent_annotation_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX annotation_parent_annotation_idx ON core.annotation USING btree (parent_annotation_id);


--
-- Name: apiproperty_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX apiproperty_created_by_idx ON core.api_property USING btree (created_by);


--
-- Name: authority_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX authority_created_by_idx ON core.authority USING btree (created_by);


--
-- Name: classifier_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX classifier_created_by_idx ON core.classifier USING btree (created_by);


--
-- Name: classifier_parent_classifier_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX classifier_parent_classifier_idx ON core.classifier USING btree (parent_classifier_id);


--
-- Name: edit_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX edit_created_by_idx ON core.edit USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON core.flyway_schema_history USING btree (success);


--
-- Name: folder_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX folder_created_by_idx ON core.folder USING btree (created_by);


--
-- Name: folder_parent_folder_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX folder_parent_folder_idx ON core.folder USING btree (parent_folder_id);


--
-- Name: metadata_catalogue_item_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX metadata_catalogue_item_idx ON core.metadata USING btree (multi_facet_aware_item_id);


--
-- Name: metadata_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX metadata_created_by_idx ON core.metadata USING btree (created_by);


--
-- Name: metadata_namespace_index; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX metadata_namespace_index ON core.metadata USING btree (namespace);


--
-- Name: metadata_namespace_key_index; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX metadata_namespace_key_index ON core.metadata USING btree (namespace, key);


--
-- Name: referencefile_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX referencefile_created_by_idx ON core.reference_file USING btree (created_by);


--
-- Name: rule_catalogue_item_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX rule_catalogue_item_idx ON core.rule USING btree (multi_facet_aware_item_id);


--
-- Name: rule_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX rule_created_by_idx ON core.rule USING btree (created_by);


--
-- Name: rule_representation_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX rule_representation_created_by_idx ON core.rule_representation USING btree (created_by);


--
-- Name: rule_representation_rule_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX rule_representation_rule_idx ON core.rule_representation USING btree (rule_id);


--
-- Name: semantic_link_catalogue_item_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX semantic_link_catalogue_item_idx ON core.semantic_link USING btree (multi_facet_aware_item_id);


--
-- Name: semantic_link_target_catalogue_item_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX semantic_link_target_catalogue_item_idx ON core.semantic_link USING btree (target_multi_facet_aware_item_id);


--
-- Name: semanticlink_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX semanticlink_created_by_idx ON core.semantic_link USING btree (created_by);


--
-- Name: userimagefile_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX userimagefile_created_by_idx ON core.user_image_file USING btree (created_by);


--
-- Name: version_link_catalogue_item_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX version_link_catalogue_item_idx ON core.version_link USING btree (multi_facet_aware_item_id);


--
-- Name: version_link_target_model_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX version_link_target_model_idx ON core.version_link USING btree (target_model_id);


--
-- Name: versionlink_created_by_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX versionlink_created_by_idx ON core.version_link USING btree (created_by);


--
-- Name: data_flow_source_idx; Type: INDEX; Schema: dataflow; Owner: -
--

CREATE INDEX data_flow_source_idx ON dataflow.data_flow USING btree (source_id);


--
-- Name: data_flow_target_idx; Type: INDEX; Schema: dataflow; Owner: -
--

CREATE INDEX data_flow_target_idx ON dataflow.data_flow USING btree (target_id);


--
-- Name: dataclasscomponent_created_by_idx; Type: INDEX; Schema: dataflow; Owner: -
--

CREATE INDEX dataclasscomponent_created_by_idx ON dataflow.data_class_component USING btree (created_by);


--
-- Name: dataelementcomponent_created_by_idx; Type: INDEX; Schema: dataflow; Owner: -
--

CREATE INDEX dataelementcomponent_created_by_idx ON dataflow.data_element_component USING btree (created_by);


--
-- Name: dataflow_created_by_idx; Type: INDEX; Schema: dataflow; Owner: -
--

CREATE INDEX dataflow_created_by_idx ON dataflow.data_flow USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: dataflow; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON dataflow.flyway_schema_history USING btree (success);


--
-- Name: data_class_data_model_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX data_class_data_model_idx ON datamodel.data_class USING btree (data_model_id);


--
-- Name: data_class_parent_data_class_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX data_class_parent_data_class_idx ON datamodel.data_class USING btree (parent_data_class_id);


--
-- Name: data_element_data_class_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX data_element_data_class_idx ON datamodel.data_element USING btree (data_class_id);


--
-- Name: data_element_data_type_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX data_element_data_type_idx ON datamodel.data_element USING btree (data_type_id);


--
-- Name: data_type_data_model_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX data_type_data_model_idx ON datamodel.data_type USING btree (data_model_id);


--
-- Name: dataclass_created_by_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX dataclass_created_by_idx ON datamodel.data_class USING btree (created_by);


--
-- Name: dataelement_created_by_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX dataelement_created_by_idx ON datamodel.data_element USING btree (created_by);


--
-- Name: datamodel_created_by_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX datamodel_created_by_idx ON datamodel.data_model USING btree (created_by);


--
-- Name: datatype_created_by_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX datatype_created_by_idx ON datamodel.data_type USING btree (created_by);


--
-- Name: enumeration_value_enumeration_type_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX enumeration_value_enumeration_type_idx ON datamodel.enumeration_value USING btree (enumeration_type_id);


--
-- Name: enumerationvalue_created_by_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX enumerationvalue_created_by_idx ON datamodel.enumeration_value USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON datamodel.flyway_schema_history USING btree (success);


--
-- Name: reference_type_reference_class_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX reference_type_reference_class_idx ON datamodel.data_type USING btree (reference_class_id);


--
-- Name: summary_metadata_report_summary_metadata_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX summary_metadata_report_summary_metadata_idx ON datamodel.summary_metadata_report USING btree (summary_metadata_id);


--
-- Name: summarymetadata_created_by_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX summarymetadata_created_by_idx ON datamodel.summary_metadata USING btree (created_by);


--
-- Name: summarymetadatareport_created_by_idx; Type: INDEX; Schema: datamodel; Owner: -
--

CREATE INDEX summarymetadatareport_created_by_idx ON datamodel.summary_metadata_report USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: federation; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON federation.flyway_schema_history USING btree (success);


--
-- Name: subscribed_model_local_model_id; Type: INDEX; Schema: federation; Owner: -
--

CREATE INDEX subscribed_model_local_model_id ON federation.subscribed_model USING btree (local_model_id);


--
-- Name: subscribed_model_subscribed_catalogue_id; Type: INDEX; Schema: federation; Owner: -
--

CREATE INDEX subscribed_model_subscribed_catalogue_id ON federation.subscribed_model USING btree (subscribed_catalogue_id);


--
-- Name: data_element_data_type_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX data_element_data_type_idx ON referencedata.reference_data_element USING btree (reference_data_type_id);


--
-- Name: data_element_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX data_element_reference_data_model_idx ON referencedata.reference_data_element USING btree (reference_data_model_id);


--
-- Name: data_type_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX data_type_reference_data_model_idx ON referencedata.reference_data_type USING btree (reference_data_model_id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON referencedata.flyway_schema_history USING btree (success);


--
-- Name: reference_data_value_reference_data_element_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX reference_data_value_reference_data_element_idx ON referencedata.reference_data_value USING btree (reference_data_element_id);


--
-- Name: reference_data_value_reference_data_model_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX reference_data_value_reference_data_model_idx ON referencedata.reference_data_value USING btree (reference_data_model_id);


--
-- Name: referencedataelement_created_by_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX referencedataelement_created_by_idx ON referencedata.reference_data_element USING btree (created_by);


--
-- Name: referencedatamodel_created_by_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX referencedatamodel_created_by_idx ON referencedata.reference_data_model USING btree (created_by);


--
-- Name: referencedatatype_created_by_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX referencedatatype_created_by_idx ON referencedata.reference_data_type USING btree (created_by);


--
-- Name: referenceenumerationvalue_created_by_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX referenceenumerationvalue_created_by_idx ON referencedata.reference_enumeration_value USING btree (created_by);


--
-- Name: referencesummarymetadata_created_by_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX referencesummarymetadata_created_by_idx ON referencedata.reference_summary_metadata USING btree (created_by);


--
-- Name: referencesummarymetadatareport_created_by_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX referencesummarymetadatareport_created_by_idx ON referencedata.reference_summary_metadata_report USING btree (created_by);


--
-- Name: summary_metadata_report_summary_metadata_idx; Type: INDEX; Schema: referencedata; Owner: -
--

CREATE INDEX summary_metadata_report_summary_metadata_idx ON referencedata.reference_summary_metadata_report USING btree (summary_metadata_id);


--
-- Name: apikey_created_by_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX apikey_created_by_idx ON security.api_key USING btree (created_by);


--
-- Name: catalogue_user_profile_picture_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX catalogue_user_profile_picture_idx ON security.catalogue_user USING btree (profile_picture_id);


--
-- Name: catalogueuser_created_by_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX catalogueuser_created_by_idx ON security.catalogue_user USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON security.flyway_schema_history USING btree (success);


--
-- Name: grouprole_created_by_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX grouprole_created_by_idx ON security.group_role USING btree (created_by);


--
-- Name: jcutug_catalogue_user_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX jcutug_catalogue_user_idx ON security.join_catalogue_user_to_user_group USING btree (catalogue_user_id);


--
-- Name: jcutug_user_group_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX jcutug_user_group_idx ON security.join_catalogue_user_to_user_group USING btree (user_group_id);


--
-- Name: securableresourcegrouprole_created_by_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX securableresourcegrouprole_created_by_idx ON security.securable_resource_group_role USING btree (created_by);


--
-- Name: usergroup_created_by_idx; Type: INDEX; Schema: security; Owner: -
--

CREATE INDEX usergroup_created_by_idx ON security.user_group USING btree (created_by);


--
-- Name: codeset_created_by_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX codeset_created_by_idx ON terminology.code_set USING btree (created_by);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON terminology.flyway_schema_history USING btree (success);


--
-- Name: term_created_by_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX term_created_by_idx ON terminology.term USING btree (created_by);


--
-- Name: term_relationship_source_term_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX term_relationship_source_term_idx ON terminology.term_relationship USING btree (source_term_id);


--
-- Name: term_relationship_target_term_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX term_relationship_target_term_idx ON terminology.term_relationship USING btree (target_term_id);


--
-- Name: term_relationship_type_terminology_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX term_relationship_type_terminology_idx ON terminology.term_relationship_type USING btree (terminology_id);


--
-- Name: term_terminology_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX term_terminology_idx ON terminology.term USING btree (terminology_id);


--
-- Name: terminology_created_by_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX terminology_created_by_idx ON terminology.terminology USING btree (created_by);


--
-- Name: termrelationship_created_by_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX termrelationship_created_by_idx ON terminology.term_relationship USING btree (created_by);


--
-- Name: termrelationshiptype_created_by_idx; Type: INDEX; Schema: terminology; Owner: -
--

CREATE INDEX termrelationshiptype_created_by_idx ON terminology.term_relationship_type USING btree (created_by);


--
-- Name: join_folder_to_facet fk14o06qtiem74ycw6896javux7; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fk14o06qtiem74ycw6896javux7 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: breadcrumb_tree fk1hraqwgiiva4reb2v6do4it81; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.breadcrumb_tree
    ADD CONSTRAINT fk1hraqwgiiva4reb2v6do4it81 FOREIGN KEY (parent_id) REFERENCES core.breadcrumb_tree(id) ON DELETE CASCADE;


--
-- Name: join_classifier_to_facet fk1yihq7q1hhwm3f7jn4g7isg5k; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk1yihq7q1hhwm3f7jn4g7isg5k FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_classifier_to_facet fk3h1hax9omk9o62119jsc45m35; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk3h1hax9omk9o62119jsc45m35 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_classifier_to_facet fk54j6lhkhnneag9rqsnchk9rwf; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk54j6lhkhnneag9rqsnchk9rwf FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: folder fk57g7veis1gp5wn3g0mp0x57pl; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.folder
    ADD CONSTRAINT fk57g7veis1gp5wn3g0mp0x57pl FOREIGN KEY (parent_folder_id) REFERENCES core.folder(id);


--
-- Name: join_classifier_to_facet fk5owmrlff8c3f3bf2e7om5xkfj; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk5owmrlff8c3f3bf2e7om5xkfj FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_classifier_to_facet fk6531dcod746lwh2v7k4fatx7b; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fk6531dcod746lwh2v7k4fatx7b FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_folder_to_facet fk6bgvwj5n9a92tkoky84uaktlm; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fk6bgvwj5n9a92tkoky84uaktlm FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: classifier fkahkm58kcer6a9q2v01ealovr6; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.classifier
    ADD CONSTRAINT fkahkm58kcer6a9q2v01ealovr6 FOREIGN KEY (parent_classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_versionedfolder_to_facet fkcdu99gvtth7g6q2glm329u7uu; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_versionedfolder_to_facet
    ADD CONSTRAINT fkcdu99gvtth7g6q2glm329u7uu FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_folder_to_facet fkibq4i08l0b0nkbopm8wjrdfd9; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkibq4i08l0b0nkbopm8wjrdfd9 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_folder_to_facet fkml4kb6cf0wr79sopbu6fglets; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkml4kb6cf0wr79sopbu6fglets FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: annotation fknrnwt8d2s4kytg7mis2rg2a5x; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.annotation
    ADD CONSTRAINT fknrnwt8d2s4kytg7mis2rg2a5x FOREIGN KEY (parent_annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_folder_to_facet fkohkkmadsw0xtk5qs2mx0y0npo; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fkohkkmadsw0xtk5qs2mx0y0npo FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_classifier_to_facet fks9xsugq08k5ejrfha2540ups0; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_classifier_to_facet
    ADD CONSTRAINT fks9xsugq08k5ejrfha2540ups0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_versionedfolder_to_facet fksltt9c209xswibf8ocho4l8ly; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_versionedfolder_to_facet
    ADD CONSTRAINT fksltt9c209xswibf8ocho4l8ly FOREIGN KEY (versionedfolder_id) REFERENCES core.folder(id);


--
-- Name: join_folder_to_facet fksuj7eo7stfn56f1b0ci16uqc4; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.join_folder_to_facet
    ADD CONSTRAINT fksuj7eo7stfn56f1b0ci16uqc4 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: rule_representation rule_representation_rule_id_fk; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.rule_representation
    ADD CONSTRAINT rule_representation_rule_id_fk FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataflow_to_facet fk18w0v8pjw1ejcppns1ovsaiuh; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk18w0v8pjw1ejcppns1ovsaiuh FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataelementcomponent_to_facet fk2458d1q7dlb53wk3i2f3tvn07; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fk2458d1q7dlb53wk3i2f3tvn07 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataflow_to_facet fk3desra9ff6a5m317j5emcbrb; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk3desra9ff6a5m317j5emcbrb FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_flow fk3fj19l4nvknojy3srxmkdfw5w; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fk3fj19l4nvknojy3srxmkdfw5w FOREIGN KEY (source_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataflow_to_facet fk4lftftotgkhj732e3cdofnua9; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk4lftftotgkhj732e3cdofnua9 FOREIGN KEY (dataflow_id) REFERENCES dataflow.data_flow(id);


--
-- Name: join_data_class_component_to_target_data_class fk5n8do09dd74fa9h1n73ovvule; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_target_data_class
    ADD CONSTRAINT fk5n8do09dd74fa9h1n73ovvule FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_data_class_component_to_source_data_class fk69j2bufggb1whkshma276fb3u; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_source_data_class
    ADD CONSTRAINT fk69j2bufggb1whkshma276fb3u FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_dataflow_to_facet fk6i15t337ti18ejj9g11ntw7wa; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fk6i15t337ti18ejj9g11ntw7wa FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataelementcomponent_to_facet fk6oar34bhid29tojvm1ukllq7t; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fk6oar34bhid29tojvm1ukllq7t FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_data_element_component_to_target_data_element fk75eg0xy6obhx83sahuf43ftkn; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_target_data_element
    ADD CONSTRAINT fk75eg0xy6obhx83sahuf43ftkn FOREIGN KEY (data_element_id) REFERENCES datamodel.data_element(id);


--
-- Name: data_flow fk77hjma5cdtsc07lk9axb9uplj; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fk77hjma5cdtsc07lk9axb9uplj FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataclasscomponent_to_facet fk83mqbv5ca5sjld100rbiymsvs; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fk83mqbv5ca5sjld100rbiymsvs FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_element_component fk8q670e83q94a20x8urckoqhs7; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT fk8q670e83q94a20x8urckoqhs7 FOREIGN KEY (data_class_component_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: data_class_component fk8qu1p2ejn32fxvwbtqmcb28d4; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT fk8qu1p2ejn32fxvwbtqmcb28d4 FOREIGN KEY (data_flow_id) REFERENCES dataflow.data_flow(id);


--
-- Name: join_data_class_component_to_source_data_class fk8rlgnf224u6byjb9mutxvj02d; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_source_data_class
    ADD CONSTRAINT fk8rlgnf224u6byjb9mutxvj02d FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclasscomponent_to_facet fk9nd41ujgegfisr6s7prcxle75; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fk9nd41ujgegfisr6s7prcxle75 FOREIGN KEY (dataclasscomponent_id) REFERENCES dataflow.data_class_component(id);


--
-- Name: join_dataelementcomponent_to_facet fkbcxohbk6botm68gguiqulgveq; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkbcxohbk6botm68gguiqulgveq FOREIGN KEY (dataelementcomponent_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: join_dataclasscomponent_to_facet fkdataclasscomponent_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkdataclasscomponent_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelementcomponent_to_facet fkdataelementcomponent_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkdataelementcomponent_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataflow_to_facet fkdataflow_to_rule; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkdataflow_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataclasscomponent_to_facet fke3nbbi9b4igb936kcxlx9lcxd; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fke3nbbi9b4igb936kcxlx9lcxd FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_class_component fkevgs9u7n7x5tr0a32ce3br9pi; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_class_component
    ADD CONSTRAINT fkevgs9u7n7x5tr0a32ce3br9pi FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_data_element_component_to_source_data_element fkfj2dcm6f4pug84c27slqx72sb; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_source_data_element
    ADD CONSTRAINT fkfj2dcm6f4pug84c27slqx72sb FOREIGN KEY (data_element_component_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: join_dataclasscomponent_to_facet fki22diqv42nnrxmhyki9f8sodi; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fki22diqv42nnrxmhyki9f8sodi FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelementcomponent_to_facet fkj8cv4bqtulig1rg7f0xikfr2d; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkj8cv4bqtulig1rg7f0xikfr2d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataclasscomponent_to_facet fkjnu3epst826kd40f60ktimo6k; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkjnu3epst826kd40f60ktimo6k FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_data_class_component_to_target_data_class fkjp8k503bbqqe4h6s0f7uygg8n; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_data_class_component_to_target_data_class
    ADD CONSTRAINT fkjp8k503bbqqe4h6s0f7uygg8n FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: data_flow fkl8uawgeg58jq51ydqqddm5d7g; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_flow
    ADD CONSTRAINT fkl8uawgeg58jq51ydqqddm5d7g FOREIGN KEY (target_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataclasscomponent_to_facet fkmfkn6if9k5q1k938jr5mx2lhw; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataclasscomponent_to_facet
    ADD CONSTRAINT fkmfkn6if9k5q1k938jr5mx2lhw FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataelementcomponent_to_facet fknf8wevvjjhglny27yn1yoav83; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fknf8wevvjjhglny27yn1yoav83 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_data_element_component_to_source_data_element fknmiwa6fd5ohwd00f0sk0wfx3t; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_source_data_element
    ADD CONSTRAINT fknmiwa6fd5ohwd00f0sk0wfx3t FOREIGN KEY (data_element_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_data_element_component_to_target_data_element fko677lt6vljfo4mcjbhn0y4bf6; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_data_element_component_to_target_data_element
    ADD CONSTRAINT fko677lt6vljfo4mcjbhn0y4bf6 FOREIGN KEY (data_element_component_id) REFERENCES dataflow.data_element_component(id);


--
-- Name: data_element_component fkpfgnmog9cl0w1lmqoor55xq3p; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.data_element_component
    ADD CONSTRAINT fkpfgnmog9cl0w1lmqoor55xq3p FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataflow_to_facet fkpvp8i5ner679uom2d32bu59f7; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkpvp8i5ner679uom2d32bu59f7 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataflow_to_facet fkpwwfp2jwv5f5kwascasa113r1; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataflow_to_facet
    ADD CONSTRAINT fkpwwfp2jwv5f5kwascasa113r1 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelementcomponent_to_facet fkrs6wh8ahehpma0s81ysqruvgp; Type: FK CONSTRAINT; Schema: dataflow; Owner: -
--

ALTER TABLE ONLY dataflow.join_dataelementcomponent_to_facet
    ADD CONSTRAINT fkrs6wh8ahehpma0s81ysqruvgp FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_datamodel_to_facet fk1ek18e3t2cki6fch7jmbbati0; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fk1ek18e3t2cki6fch7jmbbati0 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_datamodel_to_facet fk1yt7axbg37bynceoy6p06a5pk; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fk1yt7axbg37bynceoy6p06a5pk FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: data_class fk27usn28pto0b239mwltrfmksg; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk27usn28pto0b239mwltrfmksg FOREIGN KEY (data_model_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_enumerationvalue_to_facet fk40tuyaalgpyfdnp2wqfl1bl3b; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fk40tuyaalgpyfdnp2wqfl1bl3b FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_class fk4yr99q0xt49n31x48e78do1rq; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk4yr99q0xt49n31x48e78do1rq FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_dataclass_to_extended_data_class fk5cn7jgi02lejlubi97a3x17ar; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_extended_data_class
    ADD CONSTRAINT fk5cn7jgi02lejlubi97a3x17ar FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fk5n6b907728hblnk0ihhwhbac4; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fk5n6b907728hblnk0ihhwhbac4 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: data_model fk5vqrag93xcmptnduomuj1d5up; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fk5vqrag93xcmptnduomuj1d5up FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_datatype_to_facet fk685o5rkte9js4kibmx3e201ul; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fk685o5rkte9js4kibmx3e201ul FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_element fk6e7wo4o9bw27vk32roeo91cyn; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fk6e7wo4o9bw27vk32roeo91cyn FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: data_class fk71lrhqamsxh1b57sbigrgonq2; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_class
    ADD CONSTRAINT fk71lrhqamsxh1b57sbigrgonq2 FOREIGN KEY (parent_data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fk7tq9mj4pasf5fmebs2sc9ap86; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fk7tq9mj4pasf5fmebs2sc9ap86 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_element fk86to96ckvjf64qlwvosltcnsm; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fk86to96ckvjf64qlwvosltcnsm FOREIGN KEY (data_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataelement_to_facet fk89immwtwlrbwrel10gjy3yimw; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fk89immwtwlrbwrel10gjy3yimw FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_dataclass_to_imported_data_class fk8bf683fj07ef7q6ua9ax5sipb; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_class
    ADD CONSTRAINT fk8bf683fj07ef7q6ua9ax5sipb FOREIGN KEY (imported_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataelement_to_facet fk8roq23ibhwodnpibdp1srk6aq; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fk8roq23ibhwodnpibdp1srk6aq FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: summary_metadata_report fk9auhycixx3nly0xthx9eg8i8y; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.summary_metadata_report
    ADD CONSTRAINT fk9auhycixx3nly0xthx9eg8i8y FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_enumerationvalue_to_facet fk9xuiuctli6j5hra8j0pw0xbib; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fk9xuiuctli6j5hra8j0pw0xbib FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_model fk9ybmrposbekl2h5pnwet4fx30; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fk9ybmrposbekl2h5pnwet4fx30 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: enumeration_value fkam3sx31p5a0eap02h4iu1nwsg; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT fkam3sx31p5a0eap02h4iu1nwsg FOREIGN KEY (enumeration_type_id) REFERENCES datamodel.data_type(id);


--
-- Name: join_dataclass_to_extended_data_class fkaph92y3qdyublukjj8mbsivo3; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_extended_data_class
    ADD CONSTRAINT fkaph92y3qdyublukjj8mbsivo3 FOREIGN KEY (extended_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_imported_data_element fkaywt9cf9pam7w7ieo2kyv64sb; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_element
    ADD CONSTRAINT fkaywt9cf9pam7w7ieo2kyv64sb FOREIGN KEY (imported_dataelement_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_datamodel_to_facet fkb1rfqfx6stfaote1vqbh0u65b; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkb1rfqfx6stfaote1vqbh0u65b FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_datamodel_to_facet fkb2bggjawxcb5pynsrnpwgw35q; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkb2bggjawxcb5pynsrnpwgw35q FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_datamodel_to_imported_data_type fkbax3mbjn9u65ahhb5t782hq7y; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_type
    ADD CONSTRAINT fkbax3mbjn9u65ahhb5t782hq7y FOREIGN KEY (imported_datatype_id) REFERENCES datamodel.data_type(id);


--
-- Name: data_type fkbqs2sknmwe6i3rtwrhflk9s5n; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fkbqs2sknmwe6i3rtwrhflk9s5n FOREIGN KEY (data_model_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_dataclass_to_facet fkc80l2pkf48a8sw4ijsudyaers; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkc80l2pkf48a8sw4ijsudyaers FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_facet fkdataclass_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkdataclass_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelement_to_facet fkdataelement_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkdataelement_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_datamodel_to_facet fkdatamodel_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkdatamodel_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_datatype_to_facet fkdatatype_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkdatatype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataelement_to_facet fkdn8e1l2pofwmdpfroe9bkhskm; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkdn8e1l2pofwmdpfroe9bkhskm FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelement_to_facet fke75uuv2w694ofrm1ogdqio495; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fke75uuv2w694ofrm1ogdqio495 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_enumerationvalue_to_facet fkenumerationvalue_to_rule; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkenumerationvalue_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_dataclass_to_facet fkewipna2xjervio2w9rsem7vvu; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkewipna2xjervio2w9rsem7vvu FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_enumerationvalue_to_facet fkf8d99ketatffxmapoax1upmo8; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkf8d99ketatffxmapoax1upmo8 FOREIGN KEY (enumerationvalue_id) REFERENCES datamodel.enumeration_value(id);


--
-- Name: join_dataelement_to_facet fkg58co9t99dfp0076vkn23hemy; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkg58co9t99dfp0076vkn23hemy FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_dataclass_to_facet fkgeoshkis2b6trtu8c5etvg72n; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkgeoshkis2b6trtu8c5etvg72n FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_datatype_to_facet fkgfuqffr58ihdup07r1ys2rsts; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkgfuqffr58ihdup07r1ys2rsts FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_dataclass_to_facet fkgh9f6ok7n9wxwxopjku7yhfea; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkgh9f6ok7n9wxwxopjku7yhfea FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_datamodel_to_imported_data_class fkhlnup269u21f4tvdkt9sshg51; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_class
    ADD CONSTRAINT fkhlnup269u21f4tvdkt9sshg51 FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: join_datamodel_to_facet fkicjxoyym4mvpajl7amd2c96vg; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkicjxoyym4mvpajl7amd2c96vg FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_enumerationvalue_to_facet fkissxtxxag5rkhtjr2q1pivt64; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkissxtxxag5rkhtjr2q1pivt64 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: enumeration_value fkj6s22vawbgx8qbi6u95umov5t; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.enumeration_value
    ADD CONSTRAINT fkj6s22vawbgx8qbi6u95umov5t FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_datatype_to_facet fkk6htfwfpc5ty1o1skmlw0ct5h; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkk6htfwfpc5ty1o1skmlw0ct5h FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_datamodel_to_facet fkk8m8u0b9dd216qsjdkbbttqmu; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkk8m8u0b9dd216qsjdkbbttqmu FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_datatype_to_facet fkka92tyn95wh23p9y7rjb1sila; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkka92tyn95wh23p9y7rjb1sila FOREIGN KEY (datatype_id) REFERENCES datamodel.data_type(id);


--
-- Name: data_model fkkq5e5fj5kdb737ktmhyyljy4e; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_model
    ADD CONSTRAINT fkkq5e5fj5kdb737ktmhyyljy4e FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_datamodel_to_facet fkn8kvp5hpmtpu6t9ivldafifom; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkn8kvp5hpmtpu6t9ivldafifom FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: data_element fkncb91jl5cylo6nmoolmkif0y4; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_element
    ADD CONSTRAINT fkncb91jl5cylo6nmoolmkif0y4 FOREIGN KEY (data_type_id) REFERENCES datamodel.data_type(id);


--
-- Name: join_datamodel_to_imported_data_class fkp7q1ry4kxlgldr6vtdqai1bns; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_class
    ADD CONSTRAINT fkp7q1ry4kxlgldr6vtdqai1bns FOREIGN KEY (imported_dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_dataclass_to_imported_data_element fkppmuveyr38fys2lw45kkp8n0s; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_element
    ADD CONSTRAINT fkppmuveyr38fys2lw45kkp8n0s FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datamodel_to_facet fkppqku5drbeh06ro6594sx7qpn; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_facet
    ADD CONSTRAINT fkppqku5drbeh06ro6594sx7qpn FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_dataclass_to_facet fkpqpxtrqg9jh2ick2ug9mhcfxt; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_facet
    ADD CONSTRAINT fkpqpxtrqg9jh2ick2ug9mhcfxt FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataelement_to_facet fkpsyiacoeuww886wy5apt5idwq; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkpsyiacoeuww886wy5apt5idwq FOREIGN KEY (dataelement_id) REFERENCES datamodel.data_element(id);


--
-- Name: join_datatype_to_facet fkq73nqfoqdhodobkio53xnoroj; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkq73nqfoqdhodobkio53xnoroj FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_dataelement_to_facet fkqef1ustdtk1irqjnohxwhlsxf; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataelement_to_facet
    ADD CONSTRAINT fkqef1ustdtk1irqjnohxwhlsxf FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: join_enumerationvalue_to_facet fkrefs16rh5cjm8rwngb9ijw9y1; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkrefs16rh5cjm8rwngb9ijw9y1 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: data_type fkribr7hv9shypnj2iru0hsx2sn; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fkribr7hv9shypnj2iru0hsx2sn FOREIGN KEY (reference_class_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datatype_to_facet fks3obp3gh2qp7lvl7c2ke33672; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fks3obp3gh2qp7lvl7c2ke33672 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_datamodel_to_imported_data_type fks8icj3nlbxt8bnrtnhpo81lg2; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datamodel_to_imported_data_type
    ADD CONSTRAINT fks8icj3nlbxt8bnrtnhpo81lg2 FOREIGN KEY (datamodel_id) REFERENCES datamodel.data_model(id);


--
-- Name: data_type fksiu83nftgdvb7kdvaik9fghsj; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.data_type
    ADD CONSTRAINT fksiu83nftgdvb7kdvaik9fghsj FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_enumerationvalue_to_facet fkso04vaqmba4n4ffdbx5gg0fly; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_enumerationvalue_to_facet
    ADD CONSTRAINT fkso04vaqmba4n4ffdbx5gg0fly FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_dataclass_to_imported_data_class fktfwuhg9cda52duj50ocsed0cl; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_dataclass_to_imported_data_class
    ADD CONSTRAINT fktfwuhg9cda52duj50ocsed0cl FOREIGN KEY (dataclass_id) REFERENCES datamodel.data_class(id);


--
-- Name: join_datatype_to_facet fkxyctuwpfqyqog98xf69enu2y; Type: FK CONSTRAINT; Schema: datamodel; Owner: -
--

ALTER TABLE ONLY datamodel.join_datatype_to_facet
    ADD CONSTRAINT fkxyctuwpfqyqog98xf69enu2y FOREIGN KEY (summary_metadata_id) REFERENCES datamodel.summary_metadata(id);


--
-- Name: reference_data_type fk21bionqtblyjus0xdx0fpxsd0; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT fk21bionqtblyjus0xdx0fpxsd0 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referenceenumerationvalue_to_facet fk2cfjn7dvabjkphwvne3jmhu24; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fk2cfjn7dvabjkphwvne3jmhu24 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_referencedataelement_to_facet fk2fki0p2nnwaurehb5cjttuvix; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fk2fki0p2nnwaurehb5cjttuvix FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_referencedataelement_to_facet fk2ls8wxo2ymrl7lpcys7j0xv3b; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fk2ls8wxo2ymrl7lpcys7j0xv3b FOREIGN KEY (referencedataelement_id) REFERENCES referencedata.reference_data_element(id);


--
-- Name: join_referencedatamodel_to_facet fk3jbl1c288a9m1wp6hpira3esu; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk3jbl1c288a9m1wp6hpira3esu FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: reference_data_value fk3ru68cbfsr7cx03c1szowx23u; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT fk3ru68cbfsr7cx03c1szowx23u FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referencedatatype_to_facet fk3vwe6oyjkdap164w7imcng9vx; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fk3vwe6oyjkdap164w7imcng9vx FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: reference_data_element fk5s8ym98wxlmji2cwd5c2uqx51; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fk5s8ym98wxlmji2cwd5c2uqx51 FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: reference_data_element fk72aidiwlq9doq630milqmpt0h; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fk72aidiwlq9doq630milqmpt0h FOREIGN KEY (reference_data_type_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: join_referencedatatype_to_facet fk7j8ag77c03icvomcohocy682d; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fk7j8ag77c03icvomcohocy682d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_data_model fk7jnsebhp01jrvj1cnoiglnk36; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fk7jnsebhp01jrvj1cnoiglnk36 FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_referenceenumerationvalue_to_facet fk87toxbm4bddbchculnipo9876; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fk87toxbm4bddbchculnipo9876 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: reference_data_model fk8dvr6bt8lf5xtces9vstu3h9i; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fk8dvr6bt8lf5xtces9vstu3h9i FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_referencedatamodel_to_facet fk8gio5kn4wbjxsb3vpxno2guty; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk8gio5kn4wbjxsb3vpxno2guty FOREIGN KEY (referencedatamodel_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referencedatamodel_to_facet fk8jwrx0ncwyb64s7d9ygmjr2f7; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fk8jwrx0ncwyb64s7d9ygmjr2f7 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedatatype_to_facet fkag55g7g8434y1497a6jmldxlr; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkag55g7g8434y1497a6jmldxlr FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedataelement_to_facet fkb7mrla3ru59iox823w8cgdiy0; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkb7mrla3ru59iox823w8cgdiy0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_referencedatatype_to_facet fkbw5w6fr1vaf9v0pcu7qs81nvu; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkbw5w6fr1vaf9v0pcu7qs81nvu FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkclc83k4qxd0yxfspwkkttsjmj; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkclc83k4qxd0yxfspwkkttsjmj FOREIGN KEY (referenceenumerationvalue_id) REFERENCES referencedata.reference_enumeration_value(id);


--
-- Name: join_referencedataelement_to_facet fkd3a65vscren7g42xw4rahy6g5; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkd3a65vscren7g42xw4rahy6g5 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_enumeration_value fkdh4kk2d1frpb2rfep76o7d6v8; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT fkdh4kk2d1frpb2rfep76o7d6v8 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkemx1xs8y5xnl1a6kdu18mp3us; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkemx1xs8y5xnl1a6kdu18mp3us FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedataelement_to_facet fketu75lbeuhiookwn6qawi4coq; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fketu75lbeuhiookwn6qawi4coq FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_enumeration_value fkfcsl5wvgo4hhgd32kio4vsxke; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_enumeration_value
    ADD CONSTRAINT fkfcsl5wvgo4hhgd32kio4vsxke FOREIGN KEY (reference_enumeration_type_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: reference_data_element fkfmyjc00b03urjiavamg30vryh; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_element
    ADD CONSTRAINT fkfmyjc00b03urjiavamg30vryh FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referencedatatype_to_facet fkggbf0ml2ou4b2k525xrb1mxq6; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkggbf0ml2ou4b2k525xrb1mxq6 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedatamodel_to_facet fkjiqw3v6crj988n5addti0ar4u; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkjiqw3v6crj988n5addti0ar4u FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: reference_data_model fkk0dbj4ejwa3rpnm87ten7l650; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_model
    ADD CONSTRAINT fkk0dbj4ejwa3rpnm87ten7l650 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_referencedatamodel_to_facet fkksgi9yaaa427xe5saynb6rd2i; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkksgi9yaaa427xe5saynb6rd2i FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedatamodel_to_facet fkmn7qjcevpmoeq4rtudux34by; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkmn7qjcevpmoeq4rtudux34by FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_data_type fkn6ied2qohp1b9guvwcsskng2b; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_type
    ADD CONSTRAINT fkn6ied2qohp1b9guvwcsskng2b FOREIGN KEY (reference_data_model_id) REFERENCES referencedata.reference_data_model(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkp2io00cx587eojmbl5v27g7m3; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkp2io00cx587eojmbl5v27g7m3 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_referencedatamodel_to_facet fkpq9dfcuckjwcdeh9n54r062e0; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkpq9dfcuckjwcdeh9n54r062e0 FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkq50iqxdtfqwh3x6mdaepsx143; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkq50iqxdtfqwh3x6mdaepsx143 FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedatatype_to_facet fkqaa9kx536h4hsp7prrv01ouay; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkqaa9kx536h4hsp7prrv01ouay FOREIGN KEY (reference_summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: join_referencedataelement_to_facet fkqp0ri5bm3hvss6s1j3pyonkxr; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkqp0ri5bm3hvss6s1j3pyonkxr FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_referencedataelement_to_facet fkreferencedataelement_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkreferencedataelement_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedatamodel_to_facet fkreferencedatamodel_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fkreferencedatamodel_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedatatype_to_facet fkreferencedatatype_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkreferencedatatype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referenceenumerationvalue_to_facet fkreferenceenumerationvalue_to_rule; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referenceenumerationvalue_to_facet
    ADD CONSTRAINT fkreferenceenumerationvalue_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_referencedataelement_to_facet fkrltsh3bwdh88lysiui0euxus8; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedataelement_to_facet
    ADD CONSTRAINT fkrltsh3bwdh88lysiui0euxus8 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_referencedatatype_to_facet fkser4c5ad6dkspbnyjl2r1yuj3; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatatype_to_facet
    ADD CONSTRAINT fkser4c5ad6dkspbnyjl2r1yuj3 FOREIGN KEY (referencedatatype_id) REFERENCES referencedata.reference_data_type(id);


--
-- Name: join_referencedatamodel_to_facet fktlkajagcv38bnatcquinb7p2v; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.join_referencedatamodel_to_facet
    ADD CONSTRAINT fktlkajagcv38bnatcquinb7p2v FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: reference_summary_metadata_report fktm1k29089tgksd63i7yjaha8g; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_summary_metadata_report
    ADD CONSTRAINT fktm1k29089tgksd63i7yjaha8g FOREIGN KEY (summary_metadata_id) REFERENCES referencedata.reference_summary_metadata(id);


--
-- Name: reference_data_value fkuknlrsbwja5t5vd84ceulvn9p; Type: FK CONSTRAINT; Schema: referencedata; Owner: -
--

ALTER TABLE ONLY referencedata.reference_data_value
    ADD CONSTRAINT fkuknlrsbwja5t5vd84ceulvn9p FOREIGN KEY (reference_data_element_id) REFERENCES referencedata.reference_data_element(id);


--
-- Name: group_role fk9y8ew5lpksnila4b7g56xcl1n; Type: FK CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.group_role
    ADD CONSTRAINT fk9y8ew5lpksnila4b7g56xcl1n FOREIGN KEY (parent_id) REFERENCES security.group_role(id);


--
-- Name: join_catalogue_user_to_user_group fkauyvlits5bug2jc362csx3m18; Type: FK CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT fkauyvlits5bug2jc362csx3m18 FOREIGN KEY (user_group_id) REFERENCES security.user_group(id);


--
-- Name: securable_resource_group_role fkdjitehknypyvc8rjpeiw9ri97; Type: FK CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT fkdjitehknypyvc8rjpeiw9ri97 FOREIGN KEY (user_group_id) REFERENCES security.user_group(id);


--
-- Name: securable_resource_group_role fkgxkys8feqb0jvmshenxe7hvig; Type: FK CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.securable_resource_group_role
    ADD CONSTRAINT fkgxkys8feqb0jvmshenxe7hvig FOREIGN KEY (group_role_id) REFERENCES security.group_role(id);


--
-- Name: api_key fkl8s3q1v3lg1crjh3kmqqbiwcu; Type: FK CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.api_key
    ADD CONSTRAINT fkl8s3q1v3lg1crjh3kmqqbiwcu FOREIGN KEY (catalogue_user_id) REFERENCES security.catalogue_user(id);


--
-- Name: user_group fknfw9gxi505amomyyy78665950; Type: FK CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.user_group
    ADD CONSTRAINT fknfw9gxi505amomyyy78665950 FOREIGN KEY (application_group_role_id) REFERENCES security.group_role(id);


--
-- Name: join_catalogue_user_to_user_group fkr4d5x0mewom4ibi8h9qy61ycc; Type: FK CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.join_catalogue_user_to_user_group
    ADD CONSTRAINT fkr4d5x0mewom4ibi8h9qy61ycc FOREIGN KEY (catalogue_user_id) REFERENCES security.catalogue_user(id);


--
-- Name: catalogue_user fkrvd4rw9ujjx4ca9b4dkps3jyt; Type: FK CONSTRAINT; Schema: security; Owner: -
--

ALTER TABLE ONLY security.catalogue_user
    ADD CONSTRAINT fkrvd4rw9ujjx4ca9b4dkps3jyt FOREIGN KEY (profile_picture_id) REFERENCES core.user_image_file(id);


--
-- Name: join_termrelationshiptype_to_facet fk16s1q7crb8ipqjg55yc7mmjqm; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk16s1q7crb8ipqjg55yc7mmjqm FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: code_set fk2jwton4ry4smlk76tax1n1j5p; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fk2jwton4ry4smlk76tax1n1j5p FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_term_to_facet fk30th9e8a75qjf08804ttebhsm; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk30th9e8a75qjf08804ttebhsm FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationship_to_facet fk334wl2e2hfjm3641dvx9kbvrr; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk334wl2e2hfjm3641dvx9kbvrr FOREIGN KEY (termrelationship_id) REFERENCES terminology.term_relationship(id);


--
-- Name: join_termrelationshiptype_to_facet fk3ampvxuqr5vc4wnpha04k33in; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk3ampvxuqr5vc4wnpha04k33in FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationshiptype_to_facet fk4p7n1lms874i479o632m3u0bc; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk4p7n1lms874i479o632m3u0bc FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_termrelationship_to_facet fk5nnjqhchac10vbq4dnturf43d; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk5nnjqhchac10vbq4dnturf43d FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fk5w07m1k4c62vcduljr349h48j; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk5w07m1k4c62vcduljr349h48j FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_codeset_to_facet fk6cgrkxpermch26tfb07629so4; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fk6cgrkxpermch26tfb07629so4 FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fk6kxdv6f6gqa7xkm2bcywsohxy; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fk6kxdv6f6gqa7xkm2bcywsohxy FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: terminology fk7dlm65qgt6m8ptacxycqyhl4m; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fk7dlm65qgt6m8ptacxycqyhl4m FOREIGN KEY (authority_id) REFERENCES core.authority(id);


--
-- Name: join_term_to_facet fk7jn78931gti2jluti9tm592p0; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk7jn78931gti2jluti9tm592p0 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_termrelationship_to_facet fk7mj3h26tgnbprkogynq8ws1mx; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk7mj3h26tgnbprkogynq8ws1mx FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_codeset_to_facet fk7t7ilhhckw9qf6xrn1ubfm7d5; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fk7t7ilhhckw9qf6xrn1ubfm7d5 FOREIGN KEY (codeset_id) REFERENCES terminology.code_set(id);


--
-- Name: terminology fk8kiyjbnrjas88qosgt78fdue5; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fk8kiyjbnrjas88qosgt78fdue5 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: join_terminology_to_facet fk8rh0jwsnqbg5wj37sabpxt808; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fk8rh0jwsnqbg5wj37sabpxt808 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: join_term_to_facet fk9bpl4j09xy1seyx3iaaueyapu; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fk9bpl4j09xy1seyx3iaaueyapu FOREIGN KEY (term_id) REFERENCES terminology.term(id);


--
-- Name: join_termrelationship_to_facet fk9jq2jv72rf5xm5qvhw2808477; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fk9jq2jv72rf5xm5qvhw2808477 FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: term_relationship fka5wounncpjf0fcv4fpd12j10g; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fka5wounncpjf0fcv4fpd12j10g FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_term_to_facet fkahmuw6nlc4rr8afxo7jw47wdf; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkahmuw6nlc4rr8afxo7jw47wdf FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: term fkcdm4c5ljr1inp380r0bsce94s; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT fkcdm4c5ljr1inp380r0bsce94s FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_codeset_to_facet fkcodeset_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkcodeset_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkcu5iih9ugs9y5guu5mqwdymae; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkcu5iih9ugs9y5guu5mqwdymae FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: term_relationship fkd55uv21yk0qoax6ofaxbg5x9w; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fkd55uv21yk0qoax6ofaxbg5x9w FOREIGN KEY (target_term_id) REFERENCES terminology.term(id);


--
-- Name: join_codeset_to_facet fkd6o1dmjdok9j9f4kk9kry3nlo; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkd6o1dmjdok9j9f4kk9kry3nlo FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: join_codeset_to_facet fkf251q9vbfhi6t007drkr0ot56; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkf251q9vbfhi6t007drkr0ot56 FOREIGN KEY (version_link_id) REFERENCES core.version_link(id);


--
-- Name: join_codeset_to_facet fkf977e6gh0go5gsb1mdypxq5qm; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkf977e6gh0go5gsb1mdypxq5qm FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: code_set fkfxs2u8sgiov5x5jf40oy3q2y3; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fkfxs2u8sgiov5x5jf40oy3q2y3 FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_codeset_to_term fkgova93e87cae5ibqn41b9i81q; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_term
    ADD CONSTRAINT fkgova93e87cae5ibqn41b9i81q FOREIGN KEY (codeset_id) REFERENCES terminology.code_set(id);


--
-- Name: join_termrelationship_to_facet fkgx7mfxmfac6cjqhwfy8e0pema; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fkgx7mfxmfac6cjqhwfy8e0pema FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: terminology fkh0m1mr4fvlw79xuod2uffrvhx; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.terminology
    ADD CONSTRAINT fkh0m1mr4fvlw79xuod2uffrvhx FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_terminology_to_facet fki6m0bt3anil9c8xa1vkro2sex; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fki6m0bt3anil9c8xa1vkro2sex FOREIGN KEY (annotation_id) REFERENCES core.annotation(id);


--
-- Name: join_termrelationshiptype_to_facet fkimkg4xk0vgadayww633utts6m; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fkimkg4xk0vgadayww633utts6m FOREIGN KEY (termrelationshiptype_id) REFERENCES terminology.term_relationship_type(id);


--
-- Name: join_codeset_to_facet fkis38oricalv28ssx3swcyfqe0; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkis38oricalv28ssx3swcyfqe0 FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_termrelationship_to_facet fkkejqseo866piupm5aos0tcewt; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fkkejqseo866piupm5aos0tcewt FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: term_relationship_type fkksj1p00n2s6upo53rj0g2rcln; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT fkksj1p00n2s6upo53rj0g2rcln FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_terminology_to_facet fkmutj2dw99jmqoiyqs7elxax0b; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkmutj2dw99jmqoiyqs7elxax0b FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: term_relationship fknaqfdwx75pqsv1x4yk4nopa8s; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fknaqfdwx75pqsv1x4yk4nopa8s FOREIGN KEY (source_term_id) REFERENCES terminology.term(id);


--
-- Name: join_codeset_to_facet fkopyxyabfcixr8q5p4tdfiatw; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_facet
    ADD CONSTRAINT fkopyxyabfcixr8q5p4tdfiatw FOREIGN KEY (semantic_link_id) REFERENCES core.semantic_link(id);


--
-- Name: code_set fkp5k3i717iool706wniwjjvwv3; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.code_set
    ADD CONSTRAINT fkp5k3i717iool706wniwjjvwv3 FOREIGN KEY (folder_id) REFERENCES core.folder(id);


--
-- Name: term_relationship fkpjx0bwxtjt6qewxak7fpgr0pk; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term_relationship
    ADD CONSTRAINT fkpjx0bwxtjt6qewxak7fpgr0pk FOREIGN KEY (relationship_type_id) REFERENCES terminology.term_relationship_type(id);


--
-- Name: term fkpry3m6mjob704x9e0w56auich; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term
    ADD CONSTRAINT fkpry3m6mjob704x9e0w56auich FOREIGN KEY (breadcrumb_tree_id) REFERENCES core.breadcrumb_tree(id);


--
-- Name: join_term_to_facet fkpvf7f5wddn60lwuucualmnfcu; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkpvf7f5wddn60lwuucualmnfcu FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- Name: term_relationship_type fkqlbqof0u5k91mxq16h2f1p2p8; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.term_relationship_type
    ADD CONSTRAINT fkqlbqof0u5k91mxq16h2f1p2p8 FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_codeset_to_term fkrce6i901t3rmqwa7oh215fc99; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_codeset_to_term
    ADD CONSTRAINT fkrce6i901t3rmqwa7oh215fc99 FOREIGN KEY (term_id) REFERENCES terminology.term(id);


--
-- Name: join_term_to_facet fks9timcfrvfej60b2b0pinlxs0; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fks9timcfrvfej60b2b0pinlxs0 FOREIGN KEY (reference_file_id) REFERENCES core.reference_file(id);


--
-- Name: join_terminology_to_facet fksk9svegop687oy8527bni5mxl; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fksk9svegop687oy8527bni5mxl FOREIGN KEY (classifier_id) REFERENCES core.classifier(id);


--
-- Name: join_terminology_to_facet fkt5xk7gkhiyj0y1snpsqhgwnhk; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkt5xk7gkhiyj0y1snpsqhgwnhk FOREIGN KEY (terminology_id) REFERENCES terminology.terminology(id);


--
-- Name: join_term_to_facet fkterm_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_term_to_facet
    ADD CONSTRAINT fkterm_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkterminology_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkterminology_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_termrelationship_to_facet fktermrelationship_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationship_to_facet
    ADD CONSTRAINT fktermrelationship_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_termrelationshiptype_to_facet fktermrelationshiptype_to_rule; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_termrelationshiptype_to_facet
    ADD CONSTRAINT fktermrelationshiptype_to_rule FOREIGN KEY (rule_id) REFERENCES core.rule(id);


--
-- Name: join_terminology_to_facet fkti72ejs5r77aweqn2voaukggw; Type: FK CONSTRAINT; Schema: terminology; Owner: -
--

ALTER TABLE ONLY terminology.join_terminology_to_facet
    ADD CONSTRAINT fkti72ejs5r77aweqn2voaukggw FOREIGN KEY (metadata_id) REFERENCES core.metadata(id);


--
-- PostgreSQL database dump complete
--

