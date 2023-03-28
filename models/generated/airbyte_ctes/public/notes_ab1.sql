{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_notes') }}
select
    {{ json_extract_scalar('_airbyte_data', ['text'], ['text']) }} as {{ adapter.quote('text') }},
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('_airbyte_data', ['noteId'], ['noteId']) }} as noteid,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as {{ adapter.quote('source') }},
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract('table_alias', '_airbyte_data', ['createdBy'], ['createdBy']) }} as createdby,
    {{ json_extract_scalar('_airbyte_data', ['createdBy', 'userId'], ['createdBy_userId']) }} as createdBy_userId,
    {{ json_extract_scalar('_airbyte_data', ['createdBy', 'email'], ['createdBy_email']) }} as createdBy_email,
    {{ json_extract_scalar('_airbyte_data', ['createdBy', 'firstName'], ['createdBy_firstName']) }} as createdBy_firstName,
    {{ json_extract_scalar('_airbyte_data', ['createdBy', 'lastName'], ['createdBy_lastName']) }} as createdBy_lastName,
    {{ json_extract_scalar('_airbyte_data', ['createdBy', 'deleted'], ['createdBy_deleted']) }} as createdBy_deleted,    
    {{ json_extract_array('_airbyte_data', ['candidates'], ['candidates']) }} as candidates,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'candidates'))->>'candidateId' as candidateId,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'candidates'))->>'email' as candidate_email,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'candidates'))->>'firstName' as candidate_firstName,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'candidates'))->>'lastName' as candidate_lastName,
    {{ json_extract_scalar('_airbyte_data', ['subject'], ['subject']) }} as subject,
    {{ json_extract_array('_airbyte_data', ['applications'], ['applications']) }} as applications,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'applications'))->>'applicationId' as applicationId,
    {{ json_extract_array('_airbyte_data', ['jobs'], ['jobs']) }} as jobs,   
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'jobs'))->>'jobId' as jobId,
    jsonb_extract_path_text(jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'jobs')), 'company', 'name') as jobs_company_name,
    jsonb_extract_path_text(jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'jobs')), 'company', 'companyId') as jobs_companyId,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'jobs'))->>'jobTitle' as jobtitle,
    {{ json_extract_array('_airbyte_data', ['contacts'], ['contacts']) }} as contacts,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'contacts'))->>'contactId' as contactId,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'contacts'))->>'firstName' as contact_firstName,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'contacts'))->>'lastName' as contact_lastName,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'contacts'))->>'email' as contact_email,    
    {{ json_extract_array('_airbyte_data', ['companies'], ['companies']) }} as companies,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'companies'))->>'companyId' as companyId,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'companies'))->>'name' as company_name,
    {{ json_extract_array('_airbyte_data', ['placements'], ['placements']) }} as placements,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'placements'))->>'placementId' as placementId,
    {{ json_extract_array('_airbyte_data', ['attachments'], ['attachments']) }} as attachments,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'attachments'))->>'attachmentId' as attachmentId,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'attachments'))->>'createdAt' as attachment_createdAt,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'attachments'))->>'fileType' as attachment_fileType,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'attachments'))->>'fileType' as attachment_fileName,
    {{ json_extract_scalar('_airbyte_data', ['reference'], ['reference']) }} as reference,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_notes') }} as table_alias
-- notes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

