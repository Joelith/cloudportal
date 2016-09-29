class CloudComponentsController < ApplicationController
	before_action :set_product
	before_action :set_component, only: [:show, :edit, :update, :destroy]
	before_action :set_type

	def new
		@component = type_class.new()
		@attributes = type_class.create_attributes		
	end

	def create
		@component = @product.cloud_components.build(component_params)
		logger.debug "Model valid: #{@component.inspect}"
	  if @component.save
	    flash[:notice] = "Component has been added."
	    redirect_to [@product, @component]
	  else
	    flash.now[:alert] = "Component has not been added."
	    render "new"
	  end
	end

	def show
	end

	def edit
		@attributes = type_class.create_attributes		
	end

	def update
		if @component.update(component_params)
	    flash[:notice] = "Component has been updated."
	    redirect_to [@product, @component]
	  else
			@attributes = fog_create_attributes(@component.cloud_type)		

	    flash.now[:alert] = "Component has not been updated."
	    render "edit"
	  end
	end

	def destroy
		@component.destroy
  	flash[:notice] = "Component has been deleted."

  	redirect_to @product
	end

	private

	def set_product
		@product = Product.find(params[:product_id])
	end

	def set_component
	  @component = CloudComponent.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The component you were looking for could not be found."
	  redirect_to product_path
	end

	def component_params
	  params.require(:cloud_component).permit(:type, :config=>type_class.create_attributes)
	end

	def set_type 
    @type = type 
  end

	def type 
    CloudComponent.types.include?(params[:type]) ? params[:type] : "CloudComponent"
  end

  def type_class 
    type.constantize 
  end

  def fog_create_attributes(cloud_type)
  	attributes = {}

  	logger.debug "Checking fog attributes #{cloud_type}"
  	if cloud_type == 'database'
			attributes = Fog::OracleCloud[:database].instances.model.attributes.reject{|key, value| [:status, :identity_domain, :creation_time, :last_modified_time, :created_by, :sm_plugin_version, :service_url, :num_nodes, :creation_job_id, :num_ip_reservations, :timezone, :em_url, :connect_descriptor, :connect_descriptor_with_public_ip, :apex_url, :glassfish_url, :compute_site_name, :parameters].include?(key)}
 		elsif cloud_type == 'java'
 			attributes = Fog::OracleCloud[:java].instances.model.attributes.reject{|key, value| [:created_by, :auto_update, :cluster_name, :compliance_status, :compliance_status_desc, :compute_site_name, :content_url, :creation_job_id, :creation_time, :db_associations, :db_info, :deletion_job_id, :error_status_desc, :fmw_control_url, :last_modified_time, :lifecycle_control_job_id, :num_ip_reservations, :num_nodes, :options, :otd_admin_url, :otd_provisioned, :otd_shape, :otd_storage_size, :psm_plugin_version, :sample_app_url, :secure_content_url, :service_components, :service_type, :service_uri, :uri, :wls_admin_url, :wls_deployment_channel_port, :force_delete, :dba_name, :dba_password, :identity_domain].include?(key)}
 		elsif cloud_type == 'compute_instance'
 			attributes = Fog::Compute[:oraclecloud].instances.model.attributes.reject{|key, value| [:account, :boot_order, :disk_attach, :domain, :entry, :error_reason, :fingerprint, :hostname, :hypervisor, :image_format, :ip, :networking, :placement_requirements, :platform, :priority, :quota, :quota_reservation, :resolvers, :reverse_dns, :site, :start_time, :state, :storage_attachments, :tags, :uri, :vcable_id, :virtio, :vnc].include?(key)}
 		end
 		logger.debug "Got fog attributes #{attributes.inspect}"

 		attributes
  end

end
