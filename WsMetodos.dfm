object WebsMetodos: TWebsMetodos
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 509
  Width = 703
  object DBPPal: TFDConnection
    Params.Strings = (
      'Database=C:\Bases de Datos\UPN.FDB'
      'User_Name=SYSDBA'
      'Password=REMOTO@SAI@15'
      'Server=hhh'
      'Protocol=TCPIP'
      'DriverID=FB')
    Left = 24
    Top = 16
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 640
    Top = 96
  end
  object PhysDriver: TFDPhysFBDriverLink
    Left = 640
    Top = 24
  end
  object QFactura: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      'select o.ID_EMPRESA,'
      'o.NUMBER,'
      'o.TIPO,'
      'o.ID_N,'
      'o.FECHA,'
      'o.SHIPTO,'
      'o.TOTAL,'
      'O.SALESTAX,'
      'd.item,'
      'd.dpto,'
      'd.ccost,'
      'd.iva,'
      'd.price,'
      'd.notes,'
      'd.qtyship,'
      'd.codbarrascurva,'
      'd.proyecto,'
      'd.actividad,'
      'd.VLR_IVA'
      'from oe o, oedet d'
      'where o.tipo = :tipo and o.number = :number and'
      'd.tipo = o.tipo and d.number = o.number')
    Left = 24
    Top = 80
    ParamData = <
      item
        Name = 'TIPO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NUMBER'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object QRecibo: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      
        'select c.tipo, d.acct,c.batch, c.observ, c.id_n, c.fecha, c.tota' +
        'l, c.shipto, c.username,'
      
        'd.banco, d.credit valor,d.debit, d.concepto_pago, d.invc numero_' +
        'fv, d.fecha_consig,'
      
        'd.cruce tipo_fv, d.cheque, d.descripcion,d.dpto,d.ccost,d.activi' +
        'dad,d.proyecto'
      'from carproen c, carprode d'
      
        'where c.tipo = :tipo and c.batch = :batch and d.tipo = c.tipo an' +
        'd d.batch = c.batch')
    Left = 24
    Top = 144
    ParamData = <
      item
        Name = 'TIPO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'BATCH'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object QItems: TFDQuery
    Connection = DBPPal
    FetchOptions.AssignedValues = [evUnidirectional]
    FetchOptions.Unidirectional = True
    SQL.Strings = (
      
        'SELECT a.ITEM, a.REVACCT, a.INVACCT, a.COSACCT, a.ITEMMSTR, a.DE' +
        'SCRIPCION, a.CLASS, a.GRUPO, a.REF, a.IMPOVENTA,'
      
        'a.CCOSTO, a.CCOSTOV, a.DEPTO, a.UOFMSALES, a.UOFMORDERS, a.FACTO' +
        'R, a.ONORDER, a.PHYSICAL, a.VENDOR, a.COST, a.COSTU,'
      
        'a.COSTP, a.PRICE, a.PRICE1, a.PRICE2, a.INQTY, a.INDATE, a.OUTQT' +
        'Y, a.OUTDATE, a.ADJQTY, a.ADJDATE, a.MTD_ISSUE,'
      
        'a.MTD_RCPTS, a.MTD_ADJ, a.YTD_ISSUE, a.YTD_RCPTS, a.YTD_ADJ, a.I' +
        'NVENTORY, a.MINIMO, a.MAXIMO, a.KITLEVEL, a.NOTAS,'
      
        'a.COMMENTS, a.TIPO, a.ESTADO, a.QTYSINCOST, a.PESO, a.ENPROOR, a' +
        '.BARRA, a.MARCA, a.MODELO, a.PRICE3, a.PRICE4, a.PRICE5,'
      
        'a.MARGEN, a.DIAS_GARANTIA_PROVEEDOR, a.DIAS_GARANTIA_CLIENTE, a.' +
        'DESC_MAXP, a.PORC_COMI, a.SERIALES, a.UBICACION,'
      
        'a.DOBLE_UNIDAD, a.TIPO_FACTOR, a.PESO_PROMEDIO, a.DESVIACION, a.' +
        'USAR_DESVIACION, a.PESO_CAJA, a.UNIDADES_CAJA,'
      
        'a.DIMENSION, a.PROCEDENCIA, a.VALORFOB, a.IMPSTOCONSUMO, a.CODNI' +
        'VEL, a.NIVEL, a.NPRICE1, a.NPRICE2, a.NPRICE3,'
      
        'a.NPRICE4, a.NPRICE5, a.REFN, a.PROMOCION, a.FECHAPROMC, a.PRECI' +
        'OIVA, a.OPCIONABC, a.COD_BARRAS, a.SUCCLIENTE, a.TALLA,'
      
        'a.COLOR, a.DEVACCT, a.IVA, a.REFFABRICA, a.IMPCONSUMO2, a.DCTADI' +
        'CIONAL, a.MARCADO, a.ACUMDISPONIBLE, a.ACUMCOSTO,'
      
        'a.FECHAUA, a.DCTFIJO, a.COM_COST, a.ACCT_PRODUCCION, a.ES_CONTRO' +
        'LADO, a.VLR_MAX_CONTROLADO, a.FOBFECHA, a.FOBFUENTE,'
      
        'a.FOBDCT, a.FOBGASTO, a.FOBLOCAL, a.IMPORTADO, a.PRICEPROV, a.DC' +
        'TPROV, a.FACTOR_CONVER_VENTAS, a.FECHA_CREACION,'
      
        'a.REFERENCIA_ANTERIOR, a.PANIER, a.GROUPE, a.CRENEAU, a.FAMILIA,' +
        ' a.DESIGNACION, a.DESCRIPCION_PRE, a.DESCRIPCION_PRF,'
      
        'a.DESCRIPCION_TECNICA, a.APLICACION, a.USO_POR_VEHICULO, a.POSIC' +
        'ION_ARANCELARIA, a.DESPIECE1, a.DESPIECE2, a.DESPIECE3,'
      
        'a.DESPIECE4, a.AGOTAR_PR, a.UNIDAD_EMBALAJE, a.PESO_UNIDAD_EMBAL' +
        'AJE, a.VOL_POR_UNIDAD_EMBALAJE, a.QARTIFICIAL,'
      
        'a.QSUGERIDO, a.PERMANENCIA_QA, a.PERMANENCIA_QS, a.TIEMPOTRANSIT' +
        'O, a.ORIGEN, a.MARCAORIGEN, a.GENERO,'
      
        'a.PESO_PROMEDIO_UNI, a.NUM_UNIDADES_POR_CAJA, a.MAN_LOTE, a.FACT' +
        'URABLE, a.CONTROLA_DCT, a.COD_POSARANCEL,'
      
        'a.DCTTALLER, a.DESC1, a.COD_APLICAC, a.REF_INTERC, a.ESTADOFAB, ' +
        'a.REF_SUSTITUTAS, a.MANEJA_TALLA_COLOR,'
      
        'a.MANEJA_GRP_IMPRESORA, a.IMPRESORA, a.PRECIOIVA_MAX, a.PRECIOIV' +
        'A_MIN, a.CANTIDAD_COLORES, a.MANEJA_COMBINATORIA,'
      
        'a.FECHA_LOTE, a.FECHA_LIMITE_LOTE, a.INVCMACCT, a.FACTOR_CONVERT' +
        '_VENTAS, a.PRECIO_UNIDAD, a.FLETES, a.TRAMITES_USD,'
      
        'a.MARGEN_U, a.DIAS_ITEM, a.KILOMETRAJE, a.SALDOU, a.SALDOPESOS, ' +
        'a.COSTP_REF, a.ROTCOD, a.CRICOD, a.FECHAPROMD,'
      
        'a.PRECIOPROM, a.PRECIONORM, a.PORCPROM, a.INVACCTE, a.COSACCTE, ' +
        'a.REVACCTE, a.DEVACCTE, a.TIPO_SERVICIO, a.CUM,'
      
        'a.TIEDES, a.TIETIP, a.DIASPROD, a.RTFITEM, a.RTFTIP, a.RTFBASEMI' +
        'N, a.APLRTICA, a.ULTCOSTEA, a.ACTIVO, a.FACPRECIO1,'
      
        'a.FACPRECIO2, a.MANPESO, a.PORC_COMI_REC, a.IMPTOAMOR, a.MANEJOA' +
        'IU, a.MANTALLA, a.NROPUNTOS, a.NROPTOSDCTO, a.SELPUNTOS,'
      
        'a.PTOSXCADA, a.PP_OBLIGATORIO, a.PP_HORAFIJA, a.IMPCONSUMO3, a.V' +
        'IDA_UTIL, a.NIIF_VLRNTR, a.ITEM_SERVICIO,'
      
        'a.COSTO_INICIAL, a.NIIF_PRECIO_VENTA_ESTIMADO, a.NIIF_OPCION_COS' +
        'TO_VENTA, a.NIIF_PORCENTAJE, a.ALTO, a.ANCHO, a.LARGO,'
      
        'a.BONOACCT, a.COSBONOACCT, a.REVBONOACCT, a.DEVBONOACCT, a.DESAC' +
        'CT, a.EDESACCT, a.DESBONOACCT, a.ACCTMANDANTE,'
      
        'a.PORCENTAJE_MAND, a.COD_CURVA, a.CUENTA_INV_CONSIG, a.CUENTA_CO' +
        'STO_CONSIG, a.CUENTA_INGRESO_TRASLADO,'
      'a.FORMA_FARMACEUTICA, a.CONCENTRACION_MEDICAMENTO, a."Version"'
      'FROM ITEM a'
      'where a."Version" >= :version')
    Left = 24
    Top = 208
    ParamData = <
      item
        Name = 'VERSION'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object QTerceros: TFDQuery
    Connection = DBPPal
    FetchOptions.AssignedValues = [evUnidirectional]
    FetchOptions.Unidirectional = True
    SQL.Strings = (
      
        'select a.ID_N, a.NIT, a.ACCT, a.ACCTP, a.COMPANY, a.ADDR1, a.ADD' +
        'R2, a.CITY, a.PAIS, a.CONTACT1, a.CARGO1, a.CONTACT2,'
      
        'a.CARGO2, a.PHONE1, a.EXT1, a.PHONE2, a.EXT2, a.PHONE3, a.EXT3, ' +
        'a.FAX, a.EXT4, a.NOTAS, a.MEMO, a.ACTIVIDAD, a.GRUPO,'
      
        'a.CATEGORIA, a.ZONA, a.TERMS, a.TERMSP, a.GRAVABLE, a.RETENEDOR,' +
        ' a.LATE, a.CREDITLMT, a.ONACCOUNT, a.NIVEL, a.FUENTE,'
      
        'a.ISSUE1099, a.ONETIME, a.RETIVA, a.IVAIN, a.AUTORET, a.CREDITO,' +
        ' a.PLAZO, a.CLIENTE, a.PROVEEDOR, a.OTRO, a.EMPLEADO,'
      
        'a.VENDEDOR, a.ICAIN, a.RETEICA, a.TIPOEMP, a.COD_VEND, a.IDVEND,' +
        ' a.PROSPECTO, a.DESCUENTO, a.CV, a.E, a.S,'
      
        'a.FECHA_CREACION, a.EMAIL, a.TIPORETEICA, a.DCTADICIONAL, a.DEPA' +
        'RTAMENTO, a.COMPANY_EXTENDIDO, a.ID_TIPOCARTERA,'
      
        'a.COD_NIVEL, a.DIAS_GRACIA, a.USERNAME, a.RETIVA_PROV, a.DCTO_AD' +
        '1, a.DCTO_AD2, a.MEDICO, a.IPS, a.TIPORETICA_VENTA,'
      
        'a.GRAVABLEIP, a.TASA_COM, a.CLITIP, a.EAN_ENTIDAD_COMP, a.NUIT, ' +
        'a.PORCON, a.IVATEO, a.RTIVA100, a.TASAAIU,'
      
        'a.NRO_TARJETA, a.FECVEN, a.COD_EPS, a.CONTEO, a.TASA_DCTO_PRONTO' +
        'PAGO, a.RETECREEC, a.RETECREEV, a.AUTOCREE,'
      
        'a.NIIF_CONTA_AUTO_FAC, a.CREDITLMTPROV, a.TIPRET, a.TIPAUTRET, a' +
        '.INACTIVO, a.BANKNO, a.CTA_CORRIENTE, a.CODIGO_BANCO,'
      'a.APLICA_RETEFUENTE, a.CONTRATO, a."Version"'
      'from CUST a'
      'where a."Version" > :version')
    Left = 24
    Top = 336
    ParamData = <
      item
        Name = 'VERSION'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object QTercero: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      
        'select a.ID_N, a.NIT, a.ACCT, a.ACCTP, a.COMPANY, a.ADDR1, a.ADD' +
        'R2, a.CITY, a.PAIS, a.CONTACT1, a.CARGO1, a.CONTACT2,'
      
        'a.CARGO2, a.PHONE1, a.EXT1, a.PHONE2, a.EXT2, a.PHONE3, a.EXT3, ' +
        'a.FAX, a.EXT4, a.NOTAS, a.MEMO, a.ACTIVIDAD, a.GRUPO,'
      
        'a.CATEGORIA, a.ZONA, a.TERMS, a.TERMSP, a.GRAVABLE, a.RETENEDOR,' +
        ' a.LATE, a.CREDITLMT, a.ONACCOUNT, a.NIVEL, a.FUENTE,'
      
        'a.ISSUE1099, a.ONETIME, a.RETIVA, a.IVAIN, a.AUTORET, a.CREDITO,' +
        ' a.PLAZO, a.CLIENTE, a.PROVEEDOR, a.OTRO, a.EMPLEADO,'
      
        'a.VENDEDOR, a.ICAIN, a.RETEICA, a.TIPOEMP, a.COD_VEND, a.IDVEND,' +
        ' a.PROSPECTO, a.DESCUENTO, a.CV, a.E, a.S,'
      
        'a.FECHA_CREACION, a.EMAIL, a.TIPORETEICA, a.DCTADICIONAL, a.DEPA' +
        'RTAMENTO, a.COMPANY_EXTENDIDO, a.ID_TIPOCARTERA,'
      
        'a.COD_NIVEL, a.DIAS_GRACIA, a.USERNAME, a.RETIVA_PROV, a.DCTO_AD' +
        '1, a.DCTO_AD2, a.MEDICO, a.IPS, a.TIPORETICA_VENTA,'
      
        'a.GRAVABLEIP, a.TASA_COM, a.CLITIP, a.EAN_ENTIDAD_COMP, a.NUIT, ' +
        'a.PORCON, a.IVATEO, a.RTIVA100, a.TASAAIU,'
      
        'a.NRO_TARJETA, a.FECVEN, a.COD_EPS, a.CONTEO, a.TASA_DCTO_PRONTO' +
        'PAGO, a.RETECREEC, a.RETECREEV, a.AUTOCREE,'
      
        'a.NIIF_CONTA_AUTO_FAC, a.CREDITLMTPROV, a.TIPRET, a.TIPAUTRET, a' +
        '.INACTIVO, a.BANKNO, a.CTA_CORRIENTE, a.CODIGO_BANCO,'
      'a.APLICA_RETEFUENTE, a.CONTRATO, a."Version"'
      'from CUST a'
      'where a.ID_N = :ID_N')
    Left = 24
    Top = 400
    ParamData = <
      item
        Name = 'ID_N'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object QItem: TFDQuery
    Connection = DBPPal
    FetchOptions.AssignedValues = [evUnidirectional]
    FetchOptions.Unidirectional = True
    SQL.Strings = (
      
        'SELECT a.ITEM, a.REVACCT, a.INVACCT, a.COSACCT, a.ITEMMSTR, a.DE' +
        'SCRIPCION, a.CLASS, a.GRUPO, a.REF, a.IMPOVENTA,'
      
        'a.CCOSTO, a.CCOSTOV, a.DEPTO, a.UOFMSALES, a.UOFMORDERS, a.FACTO' +
        'R, a.ONORDER, a.PHYSICAL, a.VENDOR, a.COST, a.COSTU,'
      
        'a.COSTP, a.PRICE, a.PRICE1, a.PRICE2, a.INQTY, a.INDATE, a.OUTQT' +
        'Y, a.OUTDATE, a.ADJQTY, a.ADJDATE, a.MTD_ISSUE,'
      
        'a.MTD_RCPTS, a.MTD_ADJ, a.YTD_ISSUE, a.YTD_RCPTS, a.YTD_ADJ, a.I' +
        'NVENTORY, a.MINIMO, a.MAXIMO, a.KITLEVEL, a.NOTAS,'
      
        'a.COMMENTS, a.TIPO, a.ESTADO, a.QTYSINCOST, a.PESO, a.ENPROOR, a' +
        '.BARRA, a.MARCA, a.MODELO, a.PRICE3, a.PRICE4, a.PRICE5,'
      
        'a.MARGEN, a.DIAS_GARANTIA_PROVEEDOR, a.DIAS_GARANTIA_CLIENTE, a.' +
        'DESC_MAXP, a.PORC_COMI, a.SERIALES, a.UBICACION,'
      
        'a.DOBLE_UNIDAD, a.TIPO_FACTOR, a.PESO_PROMEDIO, a.DESVIACION, a.' +
        'USAR_DESVIACION, a.PESO_CAJA, a.UNIDADES_CAJA,'
      
        'a.DIMENSION, a.PROCEDENCIA, a.VALORFOB, a.IMPSTOCONSUMO, a.CODNI' +
        'VEL, a.NIVEL, a.NPRICE1, a.NPRICE2, a.NPRICE3,'
      
        'a.NPRICE4, a.NPRICE5, a.REFN, a.PROMOCION, a.FECHAPROMC, a.PRECI' +
        'OIVA, a.OPCIONABC, a.COD_BARRAS, a.SUCCLIENTE, a.TALLA,'
      
        'a.COLOR, a.DEVACCT, a.IVA, a.REFFABRICA, a.IMPCONSUMO2, a.DCTADI' +
        'CIONAL, a.MARCADO, a.ACUMDISPONIBLE, a.ACUMCOSTO,'
      
        'a.FECHAUA, a.DCTFIJO, a.COM_COST, a.ACCT_PRODUCCION, a.ES_CONTRO' +
        'LADO, a.VLR_MAX_CONTROLADO, a.FOBFECHA, a.FOBFUENTE,'
      
        'a.FOBDCT, a.FOBGASTO, a.FOBLOCAL, a.IMPORTADO, a.PRICEPROV, a.DC' +
        'TPROV, a.FACTOR_CONVER_VENTAS, a.FECHA_CREACION,'
      
        'a.REFERENCIA_ANTERIOR, a.PANIER, a.GROUPE, a.CRENEAU, a.FAMILIA,' +
        ' a.DESIGNACION, a.DESCRIPCION_PRE, a.DESCRIPCION_PRF,'
      
        'a.DESCRIPCION_TECNICA, a.APLICACION, a.USO_POR_VEHICULO, a.POSIC' +
        'ION_ARANCELARIA, a.DESPIECE1, a.DESPIECE2, a.DESPIECE3,'
      
        'a.DESPIECE4, a.AGOTAR_PR, a.UNIDAD_EMBALAJE, a.PESO_UNIDAD_EMBAL' +
        'AJE, a.VOL_POR_UNIDAD_EMBALAJE, a.QARTIFICIAL,'
      
        'a.QSUGERIDO, a.PERMANENCIA_QA, a.PERMANENCIA_QS, a.TIEMPOTRANSIT' +
        'O, a.ORIGEN, a.MARCAORIGEN, a.GENERO,'
      
        'a.PESO_PROMEDIO_UNI, a.NUM_UNIDADES_POR_CAJA, a.MAN_LOTE, a.FACT' +
        'URABLE, a.CONTROLA_DCT, a.COD_POSARANCEL,'
      
        'a.DCTTALLER, a.DESC1, a.COD_APLICAC, a.REF_INTERC, a.ESTADOFAB, ' +
        'a.REF_SUSTITUTAS, a.MANEJA_TALLA_COLOR,'
      
        'a.MANEJA_GRP_IMPRESORA, a.IMPRESORA, a.PRECIOIVA_MAX, a.PRECIOIV' +
        'A_MIN, a.CANTIDAD_COLORES, a.MANEJA_COMBINATORIA,'
      
        'a.FECHA_LOTE, a.FECHA_LIMITE_LOTE, a.INVCMACCT, a.FACTOR_CONVERT' +
        '_VENTAS, a.PRECIO_UNIDAD, a.FLETES, a.TRAMITES_USD,'
      
        'a.MARGEN_U, a.DIAS_ITEM, a.KILOMETRAJE, a.SALDOU, a.SALDOPESOS, ' +
        'a.COSTP_REF, a.ROTCOD, a.CRICOD, a.FECHAPROMD,'
      
        'a.PRECIOPROM, a.PRECIONORM, a.PORCPROM, a.INVACCTE, a.COSACCTE, ' +
        'a.REVACCTE, a.DEVACCTE, a.TIPO_SERVICIO, a.CUM,'
      
        'a.TIEDES, a.TIETIP, a.DIASPROD, a.RTFITEM, a.RTFTIP, a.RTFBASEMI' +
        'N, a.APLRTICA, a.ULTCOSTEA, a.ACTIVO, a.FACPRECIO1,'
      
        'a.FACPRECIO2, a.MANPESO, a.PORC_COMI_REC, a.IMPTOAMOR, a.MANEJOA' +
        'IU, a.MANTALLA, a.NROPUNTOS, a.NROPTOSDCTO, a.SELPUNTOS,'
      
        'a.PTOSXCADA, a.PP_OBLIGATORIO, a.PP_HORAFIJA, a.IMPCONSUMO3, a.V' +
        'IDA_UTIL, a.NIIF_VLRNTR, a.ITEM_SERVICIO,'
      
        'a.COSTO_INICIAL, a.NIIF_PRECIO_VENTA_ESTIMADO, a.NIIF_OPCION_COS' +
        'TO_VENTA, a.NIIF_PORCENTAJE, a.ALTO, a.ANCHO, a.LARGO,'
      
        'a.BONOACCT, a.COSBONOACCT, a.REVBONOACCT, a.DEVBONOACCT, a.DESAC' +
        'CT, a.EDESACCT, a.DESBONOACCT, a.ACCTMANDANTE,'
      
        'a.PORCENTAJE_MAND, a.COD_CURVA, a.CUENTA_INV_CONSIG, a.CUENTA_CO' +
        'STO_CONSIG, a.CUENTA_INGRESO_TRASLADO,'
      'a.FORMA_FARMACEUTICA, a.CONCENTRACION_MEDICAMENTO, a."Version"'
      'FROM ITEM a'
      'where a.ITEM = :ITEM')
    Left = 24
    Top = 272
    ParamData = <
      item
        Name = 'ITEM'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object QCartera: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      'SELECT c.TIPO, c.BATCH, c.FECHA, c.DUEDATE,'
      'DATEDIFF(DAY, c.DUEDATE, CURRENT_DATE) DIAS_VENCIMIENTO, '
      'SALDO, c.ID_N C.SALDO_US FROM CARPRO c'
      'WHERE c.ID_N = :ID_N AND c.SALDO <> 0 AND'
      '(SELECT t.TIPO '
      'FROM TIPDOC t WHERE t.CLASE = c.TIPO) IN ('#39'FA'#39', '#39'SC'#39')'
      'ORDER BY c.TIPO, c.BATCH')
    Left = 96
    Top = 403
    ParamData = <
      item
        Name = 'ID_N'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object QPedido: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      'select E.tipo, E.number, E.id_n, E.succliente,'
      'E.SALESMAN, E.SUBTOTAL, E.SALESTAX, E.FEDTAX,'
      'E.PONUMBER, E.DESTOTAL, E.TOTAL, E.ESTADO, '
      'E.AUTORIZADO, E.DESCRIPCION, E.FECHA_ENTREGA,'
      'E.COMMENTS,E.fecha, D.CONTEO, D.ITEM, D.LOCATION, D.QTYSHIP,'
      'D.QTYORDER, D.PRICE, D.EXTEND, D.TAXES, D.COST,'
      'D.NOTES, D.DCT, D.TOTALDCT, D.CODBARRASCURVA, D.PORC_IVA,'
      'D.VLR_IVA,E.OCNUMERO'
      'from PEDIDOE E, PEDIDOD D'
      'where D.ID_EMPRESA = E.ID_EMPRESA and '
      'D.ID_SUCURSAL = E.ID_SUCURSAL and'
      'D.TIPO = E.TIPO and'
      'D.NUMBER = E.NUMBER and'
      'E.TIPO = :TIPO and'
      'E.NUMBER = :NUMBER')
    Left = 88
    Top = 16
    ParamData = <
      item
        Name = 'TIPO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NUMBER'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object QCarteraTotal: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      'SELECT c.TIPO, c.BATCH, c.FECHA, c.DUEDATE,'
      'DATEDIFF(DAY, c.DUEDATE, CURRENT_DATE) DIAS_VENCIMIENTO, '
      'SALDO, c.ID_N,c.saldo_us  FROM CARPRO c'
      'WHERE c.SALDO <> 0 AND'
      '(SELECT t.TIPO '
      'FROM TIPDOC t WHERE t.CLASE = c.TIPO) IN ('#39'FA'#39', '#39'SC'#39')'
      'ORDER BY c.TIPO, c.BATCH')
    Left = 88
    Top = 339
  end
  object QOrden: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      
        'select E.E,E.S,E.NUMBER,E.TIPO,E.ID_N,E.FECHA,E.ACCT,E.ESTADO,E.' +
        'DUEDATE,E.TOTAL,E.FECHA_PAGO,E.TOTALDCT,E.SUBTOTAL,E.TOTALIVA,'
      
        'E.ID_N_SOLICITANTE,E.VALORRTICA,E.FECHA_REQUISICION, D.LOCATION,' +
        ' D.QTY, D.ITEM,D.RECIBIDO,D.COST,D.PRICEPROV,D.PORC_IVA'
      'FROM IPOCE E, ipocd D'
      'WHERE E.E = D.E AND E.S = D.S AND '
      'E.TIPO=D.TIPO AND E.NUMBER=D.NUMBER AND'
      ' E.TIPO=:TIPO AND E.NUMBER=:NUMBER'
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 88
    Top = 80
    ParamData = <
      item
        Name = 'TIPO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NUMBER'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object QEntrada: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      
        'select e.tipo, e.fecha, e.number, d.item, d.codbarrascurva, d.qt' +
        'y, d.cost,'
      'e.id_n'
      'from ip e, ipdet d'
      'where d.tipo = e.tipo and d.number = e.number and'
      'e.tipo = :tipo and e.number = :number')
    Left = 96
    Top = 152
    ParamData = <
      item
        Name = 'TIPO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NUMBER'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object QFor_Pago: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      'Select acct,descripcion from for_pago'
      'where concepto=:concepto')
    Left = 88
    Top = 216
    ParamData = <
      item
        Name = 'CONCEPTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QFor_PagoACCT: TFloatField
      FieldName = 'ACCT'
    end
    object QFor_PagoDESCRIPCION: TStringField
      FieldName = 'DESCRIPCION'
      Size = 100
    end
  end
  object QPagos: TFDQuery
    Connection = DBPPal
    SQL.Strings = (
      'Select acct from pagos'
      'Where numero=:numero and tipo=:tipo')
    Left = 88
    Top = 280
    ParamData = <
      item
        Name = 'NUMERO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TIPO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QPagosACCT: TFloatField
      FieldName = 'ACCT'
    end
  end
end
