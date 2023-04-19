CREATE TABLE IF NOT EXISTS "SraRunTable"(
  "Run" TEXT UNIQUE,
  "Assay_Type" TEXT,
  "AvgSpotLen" INTEGER,
  "Bases" INTEGER,
  "BioProject" TEXT,
  "BioSample" TEXT,
  "Bytes" INTEGER,
  "Center_Name" TEXT,
  "Collection_date" TEXT,
  "Consent" TEXT,
  "DATASTORE_filetype" TEXT,
  "DATASTORE_provider" TEXT,
  "DATASTORE_region" TEXT,
  "ENA-FIRST-PUBLIC (run)" TEXT,
  "ENA-FIRST-PUBLIC" TEXT,
  "ENA-LAST-UPDATE (run)" TEXT,
  "ENA-LAST-UPDATE" TEXT,
  "environment_(biome)" TEXT,
  "environment_(feature)" TEXT,
  "environment_(material)" TEXT,
  "Experiment" TEXT,
  "External_Id" TEXT,
  "geo_loc_name_country" TEXT,
  "geo_loc_name_country_continent" TEXT,
  "geographic_location_(country_and/or_sea)" TEXT,
  "geographic_location_(latitude)" TEXT,
  "geographic_location_(longitude)" TEXT,
  "geographic_location_(region_and_locality)" TEXT,
  "host_body_site" TEXT,
  "host_disease_status" TEXT,
  "host_subject_id" TEXT NOT NULL PRIMARY KEY,
  "human_oral_environmental_package" TEXT,
  "INSDC_center_alias" TEXT,
  "INSDC_center_name" TEXT,
  "INSDC_first_public" TEXT,
  "INSDC_last_update" TEXT,
  "INSDC_status" TEXT,
  "Instrument" TEXT,
  "Investigation_type" TEXT,
  "Library_Name" TEXT,
  "LibraryLayout" TEXT,
  "LibrarySelection" TEXT,
  "LibrarySource" TEXT,
  "miscellaneous_parameter" TEXT,
  "Organism" TEXT,
  "Platform" TEXT,
  "project_name" TEXT,
  "ReleaseDate" TEXT,
  "Sample_Name" TEXT,
  "sample_name_submitter" TEXT,
  "sequencing_method" TEXT,
  "SRA_Study" TEXT,
  "Submitter_Id" TEXT
);
CREATE UNIQUE INDEX index_SraRunTable_Run ON SraRunTable(Run);
CREATE UNIQUE INDEX index_SraRunTable_BioSample ON SraRunTable(BioSample);
CREATE UNIQUE INDEX index_SraRunTable_Experiment ON SraRunTable(Experiment);
CREATE UNIQUE INDEX index_SraRunTable_External_Id ON SraRunTable(External_Id);
CREATE UNIQUE INDEX index_SraRunTable_Sample_Name ON SraRunTable(Sample_Name);
CREATE UNIQUE INDEX index_SraRunTable_sample_name_submitter ON SraRunTable(sample_name_submitter);
CREATE UNIQUE INDEX index_SraRunTable_Submitter_Id ON SraRunTable(Submitter_Id);
CREATE INDEX index_SraRunTable_miscellaneous_parameter ON SraRunTable(miscellaneous_parameter);
CREATE INDEX index_SraRunTable_host_body_site ON SraRunTable(host_body_site);
CREATE INDEX index_SraRunTable_host_disease_status ON SraRunTable(host_disease_status);

CREATE TABLE IF NOT EXISTS "SampleOverviews"(
  "sample_name" TEXT NOT NULL PRIMARY KEY,
  "uploader" TEXT,
  "upload_date" TEXT,
  "overall_job_status" TEXT,
  "runtime_seconds" REAL,
  "total_reads" INTEGER,
  "nonhost_reads" INTEGER,
  "nonhost_reads_percent" TEXT,
  "total_ercc_reads" INTEGER,
  "subsampled_fraction" TEXT,
  "quality_control" TEXT,
  "compression_ratio" TEXT,
  "reads_after_star" INTEGER,
  "reads_after_trimmomatic" INTEGER,
  "reads_after_priceseq" INTEGER,
  "reads_after_cdhitdup" INTEGER,
  "reads_after_idseq_dedup" INTEGER,
  "host_organism" TEXT,
  "notes" TEXT,
  "insert_size_median" INTEGER,
  "insert_size_mode" INTEGER,
  "insert_size_median_absolute_deviation" INTEGER,
  "insert_size_min" INTEGER,
  "insert_size_max" INTEGER,
  "insert_size_mean" REAL,
  "insert_size_standard_deviation" REAL,
  "insert_size_read_pairs" INTEGER,
  "sample_type" TEXT,
  "nucleotide_type" TEXT,
  "collection_location" TEXT,
  "patient_code" TEXT
);

CREATE INDEX index_SampleOverviews_patient_code ON SampleOverviews(patient_code);
CREATE INDEX index_SampleOverviews_nucleotide_type ON SampleOverviews(nucleotide_type);
CREATE INDEX index_SampleOverviews_sample_type ON SampleOverviews(sample_type);

CREATE TABLE IF NOT EXISTS "CtValues"(
  "Blinded_number" TEXT NOT NULL PRIMARY KEY,
  "Ct" REAL
);
CREATE INDEX index_CtValues_Ct ON CtValues(Ct);

CREATE TABLE IF NOT EXISTS "ENARunTable"(
  "study_accession" TEXT,
  "secondary_study_accession" TEXT,
  "sample_accession" TEXT,
  "secondary_sample_accession" TEXT,
  "experiment_accession" TEXT,
  "run_accession" TEXT NOT NULL PRIMARY KEY,
  "submission_accession" TEXT,
  "tax_id" INTEGER,
  "scientific_name" TEXT,
  "instrument_platform" TEXT,
  "instrument_model" TEXT,
  "library_name" TEXT,
  "nominal_length" INTEGER,
  "library_layout" TEXT,
  "library_strategy" TEXT,
  "library_source" TEXT,
  "library_selection" TEXT,
  "read_count" INTEGER,
  "base_count" INTEGER,
  "center_name" TEXT,
  "first_public" TEXT,
  "last_updated" TEXT,
  "experiment_title" TEXT,
  "study_title" TEXT,
  "study_alias" TEXT,
  "experiment_alias" TEXT,
  "run_alias" TEXT,
  "fastq_bytes" TEXT,
  "fastq_md5" TEXT,
  "fastq_ftp" TEXT,
  "fastq_aspera" TEXT,
  "fastq_galaxy" TEXT,
  "submitted_bytes" TEXT,
  "submitted_md5" TEXT,
  "submitted_ftp" TEXT,
  "submitted_aspera" TEXT,
  "submitted_galaxy" TEXT,
  "submitted_format" TEXT,
  "sra_bytes" TEXT,
  "sra_md5" TEXT,
  "sra_ftp" TEXT,
  "sra_aspera" TEXT,
  "sra_galaxy" TEXT,
  "cram_index_ftp" TEXT,
  "cram_index_aspera" TEXT,
  "cram_index_galaxy" TEXT,
  "sample_alias" TEXT,
  "broker_name" TEXT,
  "sample_title" TEXT,
  "nominal_sdev" TEXT,
  "first_created" TEXT
);

CREATE UNIQUE INDEX index_ENARunTable_sample_accession ON ENARunTable(sample_accession);
CREATE UNIQUE INDEX index_ENARunTable_secondary_sample_accession ON ENARunTable(secondary_sample_accession);
CREATE UNIQUE INDEX index_ENARunTable_experiment_accession ON ENARunTable(experiment_accession);
CREATE UNIQUE INDEX index_ENARunTable_sample_alias ON ENARunTable(sample_alias);

CREATE TABLE IF NOT EXISTS "bioinformaticians"(
  "username" TEXT NOT NULL PRIMARY KEY,
  "firstname" TEXT NOT NULL,
  "lastname" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "sample2bioinformatician"(
  "username" TEXT NOT NULL,
  "patient_code" TEXT NOT NULL,
  PRIMARY KEY (username, patient_code)
);
CREATE UNIQUE INDEX index_sample2bioinformatician_patient_code ON sample2bioinformatician(patient_code);
CREATE INDEX index_sample2bioinformatician_username ON sample2bioinformatician(username);

