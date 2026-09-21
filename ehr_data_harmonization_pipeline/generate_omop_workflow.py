# Databricks notebook source
import json
import os
import yaml

# Configuration
project_name = "AI-READI EHR OMOP Pipeline"
email_notification = "ychen634@jh.edu"  
default_timeout = 3600  # 1 hour in seconds
existing_cluster_id = "1204-164130-gd3w52vy"  # Your existing cluster ID

# Define workflow parameters
workflow_params = [
    {"name": "databaseName", "default": "jhu"}
]

# Define pipeline steps in order
pipeline_steps = [
    {
        "name": "extraction",
        "notebooks": [
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/00-unzipped/00_unziped_abfss",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/01-parsed/01_parsed",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/02-clean/02_all_domain"
        ]
    },
    {
        "name": "prepare",
        "notebooks": [
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/03-prepared/03_all_domains"
        ]
    },
    {
        "name": "domain_mapping",
        "notebooks": [
            # Foundation domains (must run first)
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/person",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/location",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/care_site",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/provider",
            
            # Visit domains
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/visit_occurrence",
            
            # Clinical domains
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/condition_occurrence",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/procedure_occurrence",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/drug_exposure",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/device_exposure",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/measurement",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/observation",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/04-domain-map/death"
        ]
    },
    {
        "name": "id_check",
        "notebooks": [
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/05-id-generation-check/05_all_domain"
        ]
    },
    {
        "name": "id_generation",
        "notebooks": [
            # Foundation domains (must run first)
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/person",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/location",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/care_site",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/provider",
            
            # Visit domains
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/visit_occurrence",
            
            # Clinical domains
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/condition_occurrence",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/procedure_occurrence",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/drug_exposure",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/device_exposure",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/measurement",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/observation",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/06-id-generation/death"
        ]
    },
    {
        "name": "preclean",
        "notebooks": [
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/07-preclean/1_remove_person_id_key",
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/07-preclean/2_all_domain"
        ]
    },
    {
        "name": "add_concept_name",
        "notebooks": [
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/08-add-concept-name/08_all_domain"
        ]
    },
    {
        "name": "health_check",
        "notebooks": [
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/09-final-health-checks/09_all_domain"
        ]
    },
    {
        "name": "staging",
        "notebooks": [
            "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/10-staging/10_all_domain"
        ]
    }
]

# Generate tasks with dependencies
tasks = []
last_task_key = None
last_step_task_keys = {}

# Process each step in the pipeline
for step_idx, step in enumerate(pipeline_steps):
    step_name = step["name"]
    step_task_keys = []
    
    # Process each notebook in this step
    for notebook_idx, notebook_path in enumerate(step["notebooks"]):
        # Extract notebook name for task key
        notebook_name = os.path.basename(notebook_path)
        task_key = f"{step_name}_{notebook_name}"
        
        # Create task definition with existing cluster reference
        task = {
            "task_key": task_key,
            "notebook_task": {
                "notebook_path": notebook_path,
                "base_parameters": {
                    "databaseName": "{{databaseName}}"
                }
            },
            "existing_cluster_id": existing_cluster_id,  # Use existing cluster instead of job cluster
            "timeout_seconds": default_timeout,
            "retry_on_timeout": False,
            "max_retries": 1,
            "min_retry_interval_millis": 60000
        }
        
        # Add dependencies
        dependencies = []
        
        # Special handling for domain-specific steps that need specific order
        if step_name in ["domain_mapping", "id_generation"]:
            # For foundation domains (first 4 notebooks in these steps)
            if notebook_idx < 4:
                # First foundation domain depends on previous step
                if notebook_idx == 0 and step_idx > 0:
                    # Get the last task key from previous step
                    prev_step = pipeline_steps[step_idx - 1]["name"]
                    if prev_step in last_step_task_keys:
                        dependencies.append({"task_key": last_step_task_keys[prev_step]})
                # Other foundation domains depend on previous foundation domain
                elif notebook_idx > 0:
                    dependencies.append({"task_key": step_task_keys[-1]})
            
            # Visit domain depends on all foundation domains
            elif notebook_idx == 4:  # visit_occurrence
                dependencies.append({"task_key": step_task_keys[-1]})  # Depend on last foundation domain
            
            # Clinical domains depend on visit domain
            elif notebook_idx > 4:
                if notebook_idx == 5:  # First clinical domain
                    dependencies.append({"task_key": step_task_keys[-1]})  # Depend on visit domain
                else:
                    dependencies.append({"task_key": step_task_keys[-1]})  # Depend on previous clinical domain
        else:
            # For other steps, each notebook depends on previous notebook in same step
            if notebook_idx > 0:
                dependencies.append({"task_key": step_task_keys[-1]})
            # First notebook in step depends on last notebook of previous step
            elif step_idx > 0:
                prev_step = pipeline_steps[step_idx - 1]["name"]
                if prev_step in last_step_task_keys:
                    dependencies.append({"task_key": last_step_task_keys[prev_step]})
        
        # Add dependencies to task
        if dependencies:
            task["depends_on"] = dependencies
        
        # Add task to list
        tasks.append(task)
        step_task_keys.append(task_key)
    
    # Store last task key for this step
    if step_task_keys:
        last_step_task_keys[step_name] = step_task_keys[-1]

# Create the complete workflow definition with proper Databricks YAML structure
job_key = project_name.lower().replace(" ", "_").replace("-", "_")
workflow_definition = {
    "resources": {
        "jobs": {
            job_key: {
                "name": project_name,
                "email_notifications": {
                    "on_failure": [email_notification]
                },
                "parameters": workflow_params,
                # Removed job_clusters section since we're using existing cluster
                "tasks": tasks,
                "format": "MULTI_TASK"
            }
        }
    }
}

# Save as JSON (for reference)
try:
    with open("omop_workflow_definition.json", "w") as f:
        json.dump(workflow_definition, f, indent=2)
    print("JSON saved locally as omop_workflow_definition.json")
except Exception as e:
    print(f"Error saving JSON locally: {str(e)}")

# Save as YAML (for Databricks)
try:
    with open("omop_workflow_definition.yaml", "w") as f:
        yaml.dump(workflow_definition, f, sort_keys=False, default_flow_style=False)
    print("YAML saved locally as omop_workflow_definition.yaml")
except Exception as e:
    print(f"Error saving YAML locally: {str(e)}")

# Display for copying
print("\nWorkflow YAML (copy this to create your workflow):")
yaml_content = yaml.dump(workflow_definition, sort_keys=False, default_flow_style=False)
print(yaml_content)

# COMMAND ----------

print(os.getcwd())

# COMMAND ----------


