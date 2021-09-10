require 'sinatra'
require 'rest-client'
#require 'webrick/https'
require 'thin'




get '/' do
  logger = Logger.new(STDOUT)
  logger.info(request)
  #response['Access-Control-Allow-Origin'] = 'https://menu-dimensionamiento.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/'
  erb :index

end



#########################################
# Template producción
#########################################

get '/cp4dtemplateproduccion' do
  logger = Logger.new(STDOUT)
  logger.info("Selecciono dimensionamiento para template de CP4D")
  @name = "CP4D"
  respuestasizing=[]
  respuestasizingpx=[]
  respuestasizingalt=[]
  respuestastorage=[]
  respuestasizingga=[]
  respuestasizingdl=[]
  respuestasol=[]
  respuestamonitoring=[]
  respuestatracker=[]
  respuestaloganalysis=[]
  respuesta_portworx = []
  respuesta_etcd = []
  respuesta_storage = []


  erb :cp4dtemplateproduccion , :locals => {:respuestamonitoring => respuestamonitoring,
                                  :respuestatracker => respuestatracker,
                                  :respuestaloganalysis => respuestaloganalysis,
                                  :respuestasol => respuestasol,
                                  :respuestasizingdl => respuestasizingdl,
                                  :respuestasizingga => respuestasizingga,
                                  :respuestasizingpx => respuestasizingpx,
                                  :respuestasizing => respuestasizing,
                                  :respuestasizingalt => respuestasizingalt,
                                  :respuestastorage => respuestastorage,
                                  :respuesta_portworx => respuesta_portworx, 
                                  :respuesta_etcd => respuesta_etcd, 
                                  :respuesta_storage => respuesta_storage}

end
get '/cp4dtemplateproduccionrespuesta' do
  urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  #urlapi="http://localhost:8080"
  urlapiga="https://apis-ga.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"
  #urlapiga="http://localhost:8080"
  urlapismonitoring="https://apimonitoring.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  #urlapismonitoring="http://localhost:3000"
  urlapiPX= "https://apis-portworx.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  urlapiPX2 = "https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  logger = Logger.new(STDOUT)
  logger.info("Selecciono dimensionamiento para template de CP4D")
  @name = "CP4D"
  ####################################
  # Parametros Generales
  ####################################
  region="#{params['region']}"
  country_offer="#{params['preciopais']}"
  tiposoporte="#{params['tiposoporte']}"

  increspaldos="#{params['increspaldos']}"
  inclogs="#{params['inclogs']}"
  inclsalud="#{params['incsalud']}"
  inclauditoria="#{params['incauditoria']}"
  inclga="#{params['incga']}"
  incldl="#{params['incdl']}"
  incpw="#{params['incpw']}"
  logger.info("Parametros generales")
  logger.info("region #{region}")
  logger.info("country_offer #{country_offer}")
  logger.info("tiposoporte #{tiposoporte}")

  logger.info("Inclusión de servicios")
  logger.info("increspaldos #{increspaldos}")
  logger.info("inclogs #{inclogs}")
  logger.info("inclsalud #{inclsalud}")
  logger.info("inclauditoria #{inclauditoria}")
  logger.info("inclga #{inclga}")
  logger.info("incldl #{incldl}")
  logger.info("incldl #{incpw}")
  ####################################
  # Parametros para Clúster
  ####################################
  cpu="#{params['cpu']}"
  ram="#{params['ram']}"
  infra_type="#{params['infra_type']}"
  storage="#{params['storage']}"
  iops="#{params['iops']}"
  cpudallas="#{params['cpudallas']}"
  ramdallas="#{params['ramdallas']}"
  infra_typedallas="#{params['infra_typedallas']}"
  storagedallas="#{params['storagedallas']}"
  iopsdallas="#{params['iopsdallas']}"

  ####################################
  # Parametros para Respaldos
  ####################################
  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de PX-backup:" +
    "rsemanal:"+"#{params['rsemanal']}"+
    "rsemanalretencion:"+ "#{params['rsemanalretencion']}"+
    "diff:"+ "#{params['diff']}"+
    "rdiario: "+"#{params['rdiario']}"+
    "rdiarioretencion:"+"#{params['rdiarioretencion']}"+
    "rmensual: "+"#{params['rmensual']}"+
    "rmensualretencion:"+"#{params['rmensualretencion']}"+
    "ranual: "+"#{params['ranual']}"+
    "ranualretencion:"+"#{params['ranualretencion']}"+
    "regioncluster: "+"#{params['regioncluster']}"+
    "almacenamientogb:"+"#{params['almacenamientogb']}"+
    "countryrespaldo: "+"#{params['countryrespaldo']}"+
    "resiliencybackup:"+"#{params['resiliencybackup']}")


  almacenamientogb="#{params['almacenamientogb']}" #cantidad en GB
  #parametros de politicas
  rsemanal="#{params['rsemanal']}"
  rsemanalretencion="#{params['rsemanalretencion']}" #cantidad de backups retenidos
  rdiario="#{params['rdiario']}"
  rdiarioretencion="#{params['rdiarioretencion']}"#cantidad de backups retenidos
  rmensual="#{params['rmensual']}"
  rmensualretencion="#{params['rmensualretencion']}"#cantidad de backups retenidos
  ranual="#{params['ranual']}"
  ranualretencion="#{params['ranualretencion']}"#cantidad de backups retenidos
  diff="#{params['diff']}"
  regioncluster=region
  #{}"#{params['regioncluster']}"#region del cluster de IKS donde se desplegará PX-Backup
  countryrespaldo = "#{params['countryrespaldo']}"
  resiliencybackup ="#{params['resiliencybackup']}"


  ####################################
  # Parametros para Gateway Appliance
  ####################################
  logger.info("Recibiendo parametros para dimensionamiento de GatewayAppliance:")
  logger.info("Type: #{params[:typega]} Interfase: #{params[:interfase]} PII: #{params[:pii]} HA #{params[:ha]}")

  typega="#{params['typega']}"
  interfase="#{params['interfase']}"
  pii="#{params['pii']}"
  ha="#{params['ha']}"
  typegadallas="#{params['typegadallas']}"
  interfasedallas="#{params['interfasedallas']}"
  piidallas="#{params['piidallas']}"
  hadallas="#{params['hadallas']}"
  #parametros recibidos


  ####################################
  # Parametros para DirectLink
  ####################################
  typedl="#{params['typedl']}"
  regiondl="#{params['regiondl']}"
  puerto="#{params['puerto']}"
  routing="#{params['routing']}"
  ha="#{params['ha']}"
  typedldallas="#{params['typedldallas']}"
  regiondldallas="#{params['regiondldallas']}"
  puertodallas="#{params['puertodallas']}"
  routingdallas="#{params['routingdallas']}"
  hadallas="#{params['hadallas']}"

  nodos=0
  nodoslite=0
  respuestasizingpx=[]
  respuestasizing=[]
  respuestasizingalt=[]
  respuestastorage=[]
  respuestasizingga=[]
  respuestasizingdl=[]
  respuestasol=[]
  precioservicios=0



  ####################################
  # Cálculo de clúster óptimo
  ####################################

  logger.info("PRIMER LLAMADO DE API #{urlapi}/api/v2/sizingclusteroptimoproductivo?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}")
  respuestasizing = RestClient.get "#{urlapi}/api/v2/sizingclusteroptimoproductivo?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  if (respuestasizing != nil and respuestasizing.size>0)


    ########################
    # Información de Cloud Monitoring
    ########################
    if infra_type=="bm"
      nodos=respuestasizing[0]["workers"].to_i
    else
      nodoslite=respuestasizing[0]["workers"].to_i
    end


    preciocluster=precioservicios+respuestasizing[0]["precio"].to_f
    precioservicios=precioservicios+preciocluster
    logger.info("Precio Clúster: #{preciocluster}")
    logger.info("Precio Servicios: #{precioservicios}")
    logger.info(respuestasizing)
  else
        logger.info("NO SE OBTUVO SIZING DEL CLUSTER")
  end

  ####################################
  # Alternativas de clúster al óptimo
  ####################################
  logger.info("SEGUNDO LLAMADO DE API #{urlapi}/api/v2/sizingclusterproductivo?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}")
  respuestasizingalt = RestClient.get "#{urlapi}/api/v2/sizingclusterproductivo?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestasizingalt=JSON.parse(respuestasizingalt.to_s)
  logger.info(respuestasizingalt)

  ####################################
  # Cálculo de storage
  ####################################

  logger.info("API Storage #{urlapi}/api/v1/sizingblockstorage?iops=#{iops}&storage=#{storage}&region=#{region}")
  respuestastorage = RestClient.get "#{urlapi}/api/v1/sizingblockstorage?iops=#{iops}&storage=#{storage}&region=#{region}", {:params => {}}
  respuestastorage=JSON.parse(respuestastorage.to_s)
  logger.info(respuestastorage)
  if (respuestastorage != nil and respuestastorage.size>0)
    preciostorage=respuestastorage[0]["precio"].to_f+respuestastorage[0]["preciounidadrestante"].to_f
    precioservicios=precioservicios+preciostorage
    logger.info("Precio Storage: #{preciostorage}")
    logger.info("Precio Servicios: #{precioservicios}")
  else
        logger.info("NO SE OBTUVO SIZING DE STORAGE")
  end

  ####################################
  #Cálculo de logs
  ####################################
  if inclogs=="true"
      logger.info("=====>>>  INCLUYE LOGS")
      storagelogs="#{params['storagelogs']}"
      loganalysis_retencion="#{params['loganalysis_retencion']}"
      logger.info("API LOG ANALYSIS #{urlapismonitoring}/LogAnalysis?GB=#{storagelogs}&dias=#{loganalysis_retencion}&region=us-south&preciopais=mexico")
      respuestaloganalysis=[]
      respuestaloganalysis = RestClient.post "#{urlapismonitoring}/LogAnalysis?GB=#{storagelogs}&dias=#{loganalysis_retencion}&region=us-south&preciopais=mexico", {:params => {}}
      respuestaloganalysis =JSON.parse(respuestaloganalysis.to_s)
      logger.info(respuestaloganalysis)
      if (respuestaloganalysis != nil and respuestaloganalysis.size>0)
        preciolog=respuestaloganalysis["total"].to_f
        precioservicios=precioservicios+preciolog
        logger.info("Precio LogAnalysis: #{preciolog}")
        logger.info("Precio Servicios: #{precioservicios}")
      else
            logger.info("NO SE OBTUVO SIZING DE LOG ANALYSIS")
      end

  else
      logger.info("=====>>> NO INCLUYE LOGS")
  end


  ####################################
  #Cálculo de auditoria
  ####################################
  if inclauditoria=="true"
      logger.info("=====>>>  INCLUYE AUDITORIA")
      storagetracker="#{params['storagetracker']}"
      tracker_retencion="#{params['tracker_retencion']}"
      logger.info("API ACTIVITY TRACKER #{urlapismonitoring}/ActivityTracker?GB=#{storagetracker}&dias=#{tracker_retencion}&region=us-south&preciopais=mexico")
      respuestatracker=[]
      respuestatracker = RestClient.post "#{urlapismonitoring}/ActivityTracker?GB=#{storagetracker}&dias=#{tracker_retencion}&region=us-south&preciopais=mexico", {:params => {}}
      respuestatracker =JSON.parse(respuestatracker.to_s)
      logger.info(respuestatracker)
      if (respuestatracker != nil and respuestatracker.size>0)
        preciotracker=respuestatracker["total"].to_f
        precioservicios=precioservicios+preciotracker
        logger.info("Precio Activity Tracker: #{preciotracker}")
        logger.info("Precio Servicios: #{precioservicios}")
      else
            logger.info("NO SE OBTUVO SIZING DE ACTIVITY TRACKER")
      end

  else
      logger.info("=====>>> NO INCLUYE AUDITORIA")
  end

  ####################################
  #Cálculo de auditoria
  ####################################
  if inclsalud=="true"
      logger.info("=====>>>  INCLUYE MONITOREO SALUD")
      #nodoslite
      #nodos
      #contenedores
      #seriestiempo
      contenedores="#{params['contenedores']}"
      seriestiempo="#{params['seriestiempo']}"
      logger.info("API MONITORING #{urlapismonitoring}/CloudMonitoring?node=#{nodos}&litenode=#{nodoslite}&region=us-south&preciopais=mexico&container=#{contenedores}&timeserieshour=#{seriestiempo}")
      respuestamonitoring=[]
      respuestamonitoring = RestClient.post "#{urlapismonitoring}/CloudMonitoring?node=#{nodos}&litenode=#{nodoslite}&region=us-south&preciopais=mexico&container=#{contenedores}&timeserieshour=#{seriestiempo}", {:params => {}}
      respuestamonitoring =JSON.parse(respuestamonitoring.to_s)
      logger.info(respuestamonitoring)
      if (respuestamonitoring != nil and respuestamonitoring.size>0)
        preciomonitoring=respuestamonitoring["total"].to_f
        precioservicios=precioservicios+preciomonitoring
        logger.info("Precio Cloud Monitoring: #{preciomonitoring}")
        logger.info("Precio Servicios: #{precioservicios}")
      else
            logger.info("NO SE OBTUVO SIZING DE MONITORING")
      end

  else
      logger.info("=====>>> NO INCLUYE MONITOREO SALUD")
  end

  ####################################
  #Cálculo de respaldos
  ####################################
  if increspaldos=="true"
      logger.info("llamado api PX-Backup:" )
      callapi="#{urlapi}/api/lvl2/pxbackupsol_pxent?almacenamientogb=#{almacenamientogb}&rsemanal=#{rsemanal}&rsemanalretencion=#{rsemanalretencion}&rdiario=#{rdiario}&rdiarioretencion=#{rdiarioretencion}&rmensual=#{rmensual}&rmensualretencion=#{rmensualretencion}&ranual=#{ranual}&ranualretencion=#{ranualretencion}&regioncluster=#{regioncluster}&countryrespaldo=#{countryrespaldo}&resiliencybackup=#{resiliencybackup}&diff=#{diff}"
      #callapi="#{urlapi}/api/lvl2/pxbackupsol?almacenamientogb=#{almacenamientogb}&rsemanal=#{rsemanal}&rsemanalretencion=#{rsemanalretencion}&rdiario=#{rdiario}&rdiarioretencion=#{rdiarioretencion}&rmensual=#{rmensual}&rmensualretencion=#{rmensualretencion}&ranual=#{ranual}&ranualretencion=#{ranualretencion}&regioncluster=#{regioncluster}&countryrespaldo=#{countryrespaldo}&resiliencybackup=#{resiliencybackup}"
      logger.info(callapi)
      respuestasizingpx = RestClient.get callapi, {:params => {}}
      respuestasizingpx = JSON.parse(respuestasizingpx.to_s)
      logger.info("*************")
      logger.info(respuestasizingpx)
      precioiks=respuestasizingpx[1]["precio"]
      preciocos=respuestasizingpx[3]["precio"]
      preciopx=respuestasizingpx[2]["precio"]
      precioservicios=precioservicios+preciopx+preciocos+precioiks
      logger.info("Precio Sol PX: IKS #{precioiks} COS #{preciocos} PX #{preciopx}")
      logger.info("Precio Servicios: #{precioservicios}")
  else
      logger.info("=====>>> NO INCLUYE RESPALDOS")
  end


  ####################################
  #Cálculo de gateway appliance
  ####################################
  if inclga=="true"
      logger.info("llamado api GA:" )
      logger.info("#{urlapiga}/api/v1/sizingga?region=#{region}&type=#{typega}&interfase=#{interfase}&ha=#{ha}&pii=#{pii}")
      respuestasizingga = RestClient.get "#{urlapiga}/api/v1/sizingga?region=#{region}&type=#{typega}&interfase=#{interfase}&ha=#{ha}&pii=#{pii}", {:params => {}}
      respuestasizingga=JSON.parse(respuestasizingga.to_s)
      logger.info("*************")
      logger.info(respuestasizingga)
      precioga=respuestasizingga[0]["precio"].to_f
      precioservicios=precioservicios+precioga
      logger.info("Precio Gateway Appliance: #{precioga}")
      logger.info("Precio Servicios: #{precioservicios}")
  else
      logger.info("=====>>> NO INCLUYE GATEWAY APPLIANCE")
  end

  ####################################
  #Cálculo de Direct Link
  ####################################
  if incldl=="true"
      logger.info("llamado api DL:" )
      respuestasizingdl = RestClient.get "#{urlapiga}/api/v1/sizingdl?region=#{regiondl}&type=#{typedl}&country_offer=#{country_offer}&puerto=#{puerto}&routing=#{routing}&ha=#{ha}", {:params => {}}
      respuestasizingdl=JSON.parse(respuestasizingdl.to_s)
      logger.info("*************")
      logger.info(respuestasizingdl)
      preciodl=respuestasizingdl[0]["precio"].to_f
      precioservicios=precioservicios+preciodl
      logger.info("Precio Direct Link: #{preciodl}")
      logger.info("Precio Servicios: #{precioservicios}")
  else
        logger.info("=====>>> NO INCLUYE DIRECT LINK")
  end


    ####################################
    #Cálculo de Portworxs
    ####################################
    if incpw=="true"

    #PORTWORX

    logger.info("Dimensionamiento portworx:\n")

    region="#{params['region']}"
    tipo="#{params['tipo']}"
    workers="#{params['workers']}"

    logger.info("Parámetros portworx: region: #{region}, tipo: #{tipo}, workers: #{workers}")

    urlapiPX = "https://apis-portworx.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
    urlapiPX2 = "https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"

    request = "#{urlapiPX}/api/v1/portworxprecio?region=#{region}&tipo=#{tipo}&workers=#{workers}"
    logger.info(request)
    respuesta_portworx = RestClient.get "#{request}", {:params => {}}
    respuesta_portworx = JSON.parse(respuesta_portworx.to_s)
    logger.info(respuesta_portworx)

  #STORAGE
    iops = "#{params['iops']}"
    region_storage = "#{params['region_storage']}"
    storage = "#{params['storage_block']}".to_i
    replicas="#{params['replicas']}".to_i
    total_storage = storage * replicas

    logger.info("Parámetros Block Storage: region: #{region_storage}, iops: #{iops}, replicas: #{replicas}, total storage: #{total_storage}")

    request= "#{urlapiPX2}/api/v1/sizingblockstorage?region=#{region_storage}&iops=#{iops}&storage=#{total_storage}"
    logger.info(request)
    respuesta_storage = RestClient.get "#{request}", {:params => {}}
    respuesta_storage=JSON.parse(respuesta_storage.to_s)
    logger.info(respuesta_storage);
    
    #DB FOR ETCD

    region_etcd = "#{params['region_etcd']}"
    ram_etcd = "#{params['ram_etcd']}"
    storage_etcd ="#{params['storage_etcd']}"
    cores = "#{params['cores']}" 

    logger.info("Parámetros DB ETCD: region: #{region_etcd}, ram: #{ram_etcd}, storage: #{storage_etcd}, cores: #{cores}")

    request_etcd = "#{urlapiPX}/api/v1/dbforetcdprecio?region=#{region_etcd}&ram=#{ram_etcd}&storage=#{storage_etcd}&cores=#{cores}"
    logger.info(request)
    respuesta_etcd = RestClient.get "#{request_etcd}", {:params => {}}
    respuesta_etcd = JSON.parse(respuesta_etcd.to_s)
    logger.info(respuesta_etcd)

    totalPX = respuesta_portworx[0]["precio"].to_f + respuesta_storage[0]["preciounidadrestante"].to_f + respuesta_storage[0]["precio"].to_f + respuesta_etcd[0]["precio"].to_f
    logger.info("Total a pagar: #{totalPX}")
  else
    logger.info("=====>>> NO INCLUYE DR")
end




  respuestasoporte=[]
  llamadoapisoporte="#{urlapi}/api/v1/sizingsupport?type=#{tiposoporte}&precioservicios=#{precioservicios}"
  logger.info("Llamado API Soporte #{llamadoapisoporte}")
  respuestasoporte = RestClient.get llamadoapisoporte, {:params => {}}
  logger.info("Respuesta API Soporte #{respuestasoporte}")
  respuestasoporte=JSON.parse(respuestasoporte.to_s)
  preciosoporte=respuestasoporte["precio"].to_f
  precioservicios=precioservicios+totalPX
  preciototal=preciosoporte+precioservicios
  respuestasol=[]
  respuestasol.push({total:preciototal.round(2).to_s,soporte:preciosoporte.round(2).to_s,servicios:precioservicios.round(2).to_s})
  #respuestasol=respuestasol.to_json
  logger.info("Precio Servicios: #{precioservicios}")
  logger.info("Precio Soporte: #{preciosoporte}")
  logger.info("Precio Total: #{preciototal}")

  logger.info("TERMINO DE LLAMAR LOS APIS")

  #response['Access-Control-Allow-Origin'] = 'https://menu-dimensionamiento.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/'
  erb :cp4dtemplateproduccion , :locals => {:respuestamonitoring => respuestamonitoring,
                                  :respuestatracker => respuestatracker,
                                  :respuestaloganalysis => respuestaloganalysis,
                                  :respuestasol => respuestasol,
                                  :respuestasizingdl => respuestasizingdl,
                                  :respuestasizingga => respuestasizingga,
                                  :respuestasizingpx => respuestasizingpx,
                                  :respuestasizing => respuestasizing,
                                  :respuestasizingalt => respuestasizingalt,
                                  :respuestastorage => respuestastorage,
                                  :respuesta_portworx => respuesta_portworx, 
                                  :respuesta_etcd => respuesta_etcd, 
                                  :respuesta_storage => respuesta_storage,
                                  :totalPX =>totalPX}
end
