unit WsMetodos;

interface

uses System.SysUtils, System.Classes, System.Json,
  Datasnap.DSServer, Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  Clases, Generics.Collections, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase, FireDAC.Comp.UI;

type
  TWebsMetodos = class(TDSServerModule)
    DBPPal: TFDConnection;
    WaitCursor: TFDGUIxWaitCursor;
    PhysDriver: TFDPhysFBDriverLink;
    QFactura: TFDQuery;
    QRecibo: TFDQuery;
    QItems: TFDQuery;
    QTerceros: TFDQuery;
    QTercero: TFDQuery;
    QItem: TFDQuery;
    QCartera: TFDQuery;
    QPedido: TFDQuery;
    QCarteraTotal: TFDQuery;
    QOrden: TFDQuery;
    QEntrada: TFDQuery;
    QFor_Pago: TFDQuery;
    QFor_PagoACCT: TFloatField;
    QFor_PagoDESCRIPCION: TStringField;
    QPagos: TFDQuery;
    QPagosACCT: TFloatField;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    function DataSetATercero(pDataSet: TDataSet): TTercero;
    function DataSetAItem(pDataSet: TDataSet): TProducto;
    function DataSetACartera(pDataSet: TDataSet): TCartera;

    procedure IncrementarConsecutivo(E, S: Integer; Tipo, Clase: String);

    function TraeIva(Codigo: Integer): Double;
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function TraeUnidades(pItem: String; pBodega: String)
      : TObjectList<TUnidades>;

    /// <summary>
    /// Devuelve el encabezado y el detalle de la factura en formato JSON,
    /// según su prefijo y número <see cref="UClases|TFactura" />
    /// </summary>
    /// <param name="pTipo">
    /// Prefijo de la factura
    /// </param>
    /// <param name="pNumero">
    /// Número de la factura
    /// </param>
    function TraeFactura(pTipo: String; pNumero: Integer): TFactura;
    /// <summary>
    /// Devuelve el encabezado y el detalle del recibo de caja en formato
    /// JSON, según su prefijo y número <see cref="UClases|TReciboCaja" />
    /// </summary>
    /// <param name="pTipo">
    /// Prefijo del recibo
    /// </param>
    /// <param name="pNumero">
    /// Número del recibo de caja
    /// </param>
    function TraeRecibo(pTipo: String; pNumero: Integer): TReciboCaja;

    /// <summary>
    /// Crea un recibo de caja según el parámetro de tipo JSON <see cref="UClases|TReciboCaja" />
    /// recibido
    /// </summary>
    /// <param name="pRecibo">
    /// Recibo de caja en formato JSON
    /// </param>
    function CreaRecibo(pRecibo: TReciboCaja): TResultadoRecibo;
    function UpdateCreaRecibo(pRecibo: TReciboCaja): TResultadoRecibo;

    /// <summary>
    /// Crea una factura según el parámetro de tipo JSON <see cref="UClases|TFactura" />
    /// recibido
    /// </summary>
    /// <param name="pFactura">
    /// Formato JSON de Factura
    /// </param>
    function CreaFactura(pFactura: TFactura): TResultadoFactura;
    function UpdateCreaFactura(pFactura: TFactura): TResultadoFactura;

    /// <summary>
    /// Devuelve una lista de facturas <see cref="UClases|TResultadoFactura" />
    /// realizadas en el sistema
    /// </summary>
    /// <param name="pID_N">
    /// Identificación del tercero
    /// </param>
    /// <param name="pShipto">
    /// Sucursal del tercero (ID Estudiante)
    /// </param>
    /// <param name="pMes">
    /// Mes
    /// </param>
    /// <param name="pAno">
    /// Año
    /// </param>
    function TraeNumeroFactura(pID_N: String; pShipto, pMes, pAno: Integer)
      : TList<TResultadoFactura>;

    /// <summary>
    /// Devuelve los datos del tercero acorde a la clase <see cref="UClases|TTercero" />
    /// </summary>
    /// <param name="pNit">
    /// Nit sin digito de verificación del tercero
    /// </param>
    function TraeTercero(pNit: String): TTercero;

    function CreaTercero(pTercero: TTercero): TResultadoTercero;
    function UpdateCreaTercero(pTercero: TTercero): TResultadoTercero;

    /// <summary>
    /// Devuelve la lista de terceros <see cref="UClases|TTercero" />
    /// </summary>
    /// <param name="pVersion">
    /// Última versión de cambio
    /// </param>
    /// <remarks>
    /// La versión de cambio es el número de cambio desde el cual se desea el
    /// listado de terceros-
    /// <note type="tip">
    /// Se recomienda guardar la última versión de cambio capturada para
    /// que la próxima petición devuelva solamente los cambios realizados
    /// y no toda la lista de terceros
    /// </note>
    /// </remarks>
    function TraeListaTerceros(pVersion: Integer): TList<TTercero>;

    /// <summary>
    /// Devuelve la información del producto <see cref="UClases|TProducto" />
    /// </summary>
    /// <param name="pCodigo">
    /// Código del producto
    /// </param>
    function TraeProducto(pCodigo: String): TProducto;
    /// <summary>
    /// Devuelve la lista de productos <see cref="UClases|TProducto" />
    /// </summary>
    /// <param name="pVersion">
    /// Última versión de cambio
    /// </param>
    /// <remarks>
    /// La versión de cambio es el número de cambio desde el cual se desea el
    /// listado de terceros
    /// <note type="note">
    /// Se recomienda guardar la última versión de cambio capturada para
    /// que la próxima petición devuelva solamente los cambios realizados
    /// y no toda la lista de terceros
    /// </note>
    /// </remarks>
    function TraeListaProductos(pVersion: Integer): TList<TProducto>;

    /// <summary>
    /// Devuelve la lista de curvas asociadas a un producto <see cref="UClases|TCurva" />
    /// </summary>
    /// <param name="pCodigoItem">
    /// Código de Item
    /// </param>
    function TraeListaCurvasPorItem(pCodigoItem: String): TList<TCurva>;
    /// <summary>
    /// Devuelve la lista de curvas asociadas a un código de curva TCurva
    /// </summary>
    /// <param name="pCodigoCurva">
    /// Código de curva
    /// </param>
    function TraeListaCurvas(pCodigoCurva: String): TList<TCurva>;

    function TraeCartera(pNit: string): TList<TCartera>;
    /// <summary>
    /// Retorna una lista con de objetos de tipo TCartera cuyo saldo es
    /// distinto de cero (0). <br /><br />En otras palabras retorna la
    /// cartera de todos los terceros que tengan saldo al momento de llamar
    /// esta función... tanto los que están vencidos como los que no.
    /// </summary>
    function TraeTotalCartera: TList<TCartera>;

    /// <summary>
    /// Devuelve un documento Orden de Compra <see cref="UClasesPedido|TPedido" />
    /// creado en el sistema
    /// </summary>
    /// <param name="pTipo">
    /// Prefijo de Orden Ej. 'O1'
    /// </param>
    /// <param name="pNumero">
    /// Número de Orden
    /// </param>
    function TraeOrden(pTipo: String; pNumero: Integer): TOrden;

    function TraeEntrada(pTipo: String; pNumero: Integer)
      : TObjectList<TEntrada>;

    // function EnviaEntrada
  end;

implementation

{$R *.dfm}

uses System.StrUtils;

function TWebsMetodos.CreaFactura(pFactura: TFactura): TResultadoFactura;
var
  vQInsert, vQInsertCarpro: TFDQuery;
  vFactura: TResultadoFactura;
  vConsecutivo: Integer;
  vFacturaDet: TFacturaDet;
  vConteo: Integer;

begin
  if not Assigned(pFactura) then
    raise Exception.Create('Parámetro pFactura con estructura defectuosa');

  vQInsert := TFDQuery.Create(nil);
  vQInsert.Connection := DBPPal;

  vQInsertCarpro := TFDQuery.Create(nil);
  vQInsertCarpro.Connection := DBPPal;
  try
    vQInsert.SQl.Add
      ('update or insert into OE (ID_EMPRESA, ID_SUCURSAL, NUMBER, TIPO, ID_USUARIO, ID_N, ENTITY, SALESMAN, ');
    vQInsert.SQl.Add
      ('FECHA, DUEDATE, SUBTOTAL, COST, SALESTAX, FEDTAX, DISC1, DISC2, DISC3, SHIPTO1,');
    vQInsert.SQl.Add
      ('SHIPTO2, SHIPTO4, ONACCOUNT, PRINTED, POSTED, CLOSED, PONUMBER,');
    vQInsert.SQl.Add
      ('TERMS, DES_GLO, POR_DES, DESTOTAL, TOTAL, CODSUC, IMPCONSUMO, ');
    vQInsert.SQl.Add
      ('RFAPLICADA, SHIPTO, TIPO_PEDIDO, DEV_FACTURA, DEV_TIPOFAC, DIFERENCIA, CODACTIVIDAD, SERIALES,');
    vQInsert.SQl.Add
      ('OCNUMERO, LETRAS, EXPORTADA, D, NROREMISION, CODTRANSPORTADOR, CONDUCTOR,');
    vQInsert.SQl.Add
      ('NITCONDUCTOR, PESO, BULTOS, DESPACHADOPOR, CODPROYECTO, DESCRIPCION_RECETA, SI, REVISADO,');
    vQInsert.SQl.Add
      ('FP, CE, CC, VLR_MERCANCIA, OTRO, UNIDADES, ID_TIPOCARTERA,');
    vQInsert.SQl.Add('DEDUCIBLE_CLENTE, ID_NDEDUCIBLE, PESO_NETO,');
    vQInsert.SQl.Add('OTROSCARGOS, DEDUCIBLE_CLIENTE, CAJA,');
    vQInsert.SQl.Add('SERIALDISCO, PAGOSPORVALOR, ');
    vQInsert.SQl.Add
      ('DESCRIP_ORDENPAC, NRO_ORDENPAC, COD_PLACA, COMMENTS, TOTALDEUDA,');
    vQInsert.SQl.Add('AFECTA_RETENCION, TOTALDOL,');
    vQInsert.SQl.Add
      ('VALDEV, PORCENIVA, FORPAGVAL, TIMBRE, CENICA, CONTRACT, FORMAS_PAGO, VALIVABIEN, VALIVASER,');
    vQInsert.SQl.Add
      ('IMPAMOR, OBSDESPACHO, COMENTA2, TOTALCRUCEANTICIPO, SALDOANTICIPOS,SHIPTO6,CONNIIF,CONTAB_NIIF) ');
    vQInsert.SQl.Add
      ('values (:ID_EMPRESA, :ID_SUCURSAL, :NUMBER, :TIPO, :ID_USUARIO, :ID_N, :ENTITY, :SALESMAN, ');
    vQInsert.SQl.Add
      (':FECHA, :DUEDATE, :SUBTOTAL, :COST, :SALESTAX, 0, 0, 0, 0, '''', ''0'',');
    vQInsert.SQl.Add
      (''''', ''False'', ''False'', ''False'', ''False'', '''', ''1'', 0,');
    vQInsert.SQl.Add('0, 0, :TOTAL, :CODSUC, 0, '''', :SHIPTO,');
    vQInsert.SQl.Add
      (''''', :DEV_FACTURA, :DEV_TIPOFAC, 0, :ACTIVIDAD, ''0'', '''', '''', ''N'',');
    vQInsert.SQl.Add('1, '''', '''', ''0'', ''0'', 0, 0, ''0'',');
    vQInsert.SQl.Add(':PROYECTO, '''', ''N'',');
    vQInsert.SQl.Add('''N'', ''N'', ''N'', ''N'', 0, ''N'', 0,');
    vQInsert.SQl.Add('''CC'', 0, ''0'', 0, 0,');
    vQInsert.SQl.Add('0, '''', '''', ''N'', ');
    vQInsert.SQl.Add(''''', '''', '''', '''', 0,');
    vQInsert.SQl.Add('''N'', 0, 0,');
    vQInsert.SQl.Add('0, 0, 0, 0, 0, '''', 0, 0, 0, ');
    vQInsert.SQl.Add(''''', '''', 0, 0,'''',''S'',''S'')');
    vQInsert.SQl.Add('matching (ID_EMPRESA, ID_SUCURSAL, NUMBER, TIPO)');

    vQInsert.Close;
    vQInsert.ParamByName('ID_EMPRESA').AsInteger := 1;
    vQInsert.ParamByName('ID_SUCURSAL').AsInteger := 1;

    vConsecutivo := pFactura.BATCH;
    if pFactura.BATCH <> 0 then
    begin
      vQInsert.ParamByName('NUMBER').AsInteger := pFactura.BATCH;
      vQInsert.ParamByName('DEV_FACTURA').AsInteger := pFactura.BATCH;
    end
    else
    begin
      vConsecutivo := TConsecutivo.GetConsecutivo(DBPPal, pFactura.Tipo);
      vQInsert.ParamByName('NUMBER').AsInteger := vConsecutivo;
      vQInsert.ParamByName('DEV_FACTURA').AsInteger := vConsecutivo;
    end;

    vQInsert.ParamByName('TIPO').AsString := pFactura.Tipo;
    vQInsert.ParamByName('ID_USUARIO').AsString := DBPPal.Params.Values
      ['User_Fact'];
    vQInsert.ParamByName('ID_N').AsString := pFactura.ID_N;
    vQInsert.ParamByName('ENTITY').AsString := '1';
    vQInsert.ParamByName('SALESMAN').AsInteger := 99;
    vQInsert.ParamByName('FECHA').AsDateTime := StrToDate(pFactura.FECHA);
    vQInsert.ParamByName('DUEDATE').AsDateTime := StrToDate(pFactura.FECHA);
    vQInsert.ParamByName('SUBTOTAL').AsFloat := pFactura.SUBTOTAL;
    vQInsert.ParamByName('COST').AsFloat := 0;
    vQInsert.ParamByName('SALESTAX').AsFloat := pFactura.VLR_IVA;
    vQInsert.ParamByName('TOTAL').AsFloat := pFactura.SUBTOTAL +
      pFactura.VLR_IVA;
    vQInsert.ParamByName('CODSUC').AsInteger := pFactura.SHIPTO;
    // vQInsert.ParamByName('IMPCONSUMO').AsFloat := 0;
    vQInsert.ParamByName('SHIPTO').AsInteger := pFactura.SHIPTO;
    vQInsert.ParamByName('DEV_TIPOFAC').AsString := pFactura.Tipo;
    vQInsert.ParamByName('ACTIVIDAD').AsString := '04';
    vQInsert.ParamByName('PROYECTO').AsString := '3';
    vQInsert.ExecSQL;

    vQInsert.Close;
    vQInsert.SQl.Clear;
    vQInsert.SQl.Add
      ('delete from oedet where ID_EMPRESA=:ID_EMPRESA and ID_SUCURSAL = :ID_SUCURSAL and NUMBER = :NUMBER and trim(TIPO)=trim(:TIPO)');
    vQInsert.Close;
    vQInsert.ParamByName('ID_EMPRESA').AsInteger := 1;
    vQInsert.ParamByName('ID_SUCURSAL').AsInteger := 1;
    vQInsert.ParamByName('NUMBER').AsInteger := vConsecutivo;
    vQInsert.ParamByName('TIPO').AsString := pFactura.Tipo;
    vQInsert.ExecSQL;

    vQInsert.Close;
    vQInsert.SQl.Clear;
    vQInsert.SQl.Add
      ('update or insert into OEDET (CONTEO, ID_EMPRESA, ID_SUCURSAL, NUMBER, TIPO, ID_USUARIO, ITEM, LOCATION, IVA,');
    vQInsert.SQl.Add
      ('QTYSHIP, QTYORDER, PRICE, PRICE1, EXTEND, TAXES, COST, DIAS_GARANTIA, DCT, TOTALDCT,');
    vQInsert.SQl.Add
      ('VLR_IVA, PORC_IVA, CAJAS, PESO_BRUTO, TIPO_FACTOR, DOBLE_UNIDAD, USAR_DESVIACION,');
    vQInsert.SQl.Add
      ('DESVIACIONP, PESO_PROMEDIOI, FALLO, PESO_NETO, DESINICIO, DESFINAL,');
    vQInsert.SQl.Add
      ('CAJAS_SUGERIDAS, PESO_NETOI, IMPCONSUMO, PRECIOIVA, TIPO_PEDIDO, NUMERO_PEDIDO, SERIALES,');
    vQInsert.SQl.Add
      ('NOTES, DCTADICIONAL, MANDANTE, PROYECTO, DCTFIJO, COD_UNIDAD_VENTA, FACTOR, KITNO,');
    vQInsert.SQl.Add
      ('KITDESCRIPCION, COLOR, DCTPORVALOR, DCTO_AD1, DCTO_AD2, COSTO_AJUSTE, VLR_DCTFIJO, VLR_DCT,');
    vQInsert.SQl.Add
      ('VLR_DCTOAD1, VLR_DCTOAD2, VLR_DCTOADICIONAL, OCNUMERO, COD_CENTRO, DESCRIP_CENTRO,');
    vQInsert.SQl.Add
      ('DIAS_ITEM, KILOMETRAJES, PORC_COMI, NOTES1, IDN_LOC, MARVAL, MARPOR, TOTALDOL, PRECIODOL,');
    vQInsert.SQl.Add
      ('ACTIVIDAD, DPTO, CCOST, RTFTIP, RTFITEM, RTFBASEMIN, RTFVAL, NUMITEM, UTIL1,');
    vQInsert.SQl.Add
      ('UTIL2, NUMUSU, IMPAMOR, ITEM2, POSICION, IDN_PAC, COD_TALLA, COD_COLOR)');
    vQInsert.SQl.Add
      ('values (:CONTEO, :ID_EMPRESA, :ID_SUCURSAL, :NUMBER, :TIPO, :ID_USUARIO, :ITEM, :LOCATION, :IVA, :QTYSHIP,');
    vQInsert.SQl.Add
      ('0, :PRICE, 0, :EXTEND, 0, :COST, 0, 0, 0, :VLR_IVA, :PORC_IVA,');
    vQInsert.SQl.Add('0, 0, ''Unidad'', ''False'', '''', 0, 0, ''False'',');
    vQInsert.SQl.Add('0, 0, 0, 0, 0, 0, :PRICE,');
    vQInsert.SQl.Add(''''', 0, '''', '''', 0, ''0'', :PROYECTO, 0,');
    vQInsert.SQl.Add('''Und'', 1, '''', '''', '''', 0, 0, 0, 0,');
    vQInsert.SQl.Add('0, 0, 0, 0, 0, '''', :COD_CENTRO, '''',');
    vQInsert.SQl.Add('0, 0, 0, '''', :IDN_LOC, 0, 0, 0, 0, :ACTIVIDAD,');
    vQInsert.SQl.Add(':DPTO, :CCOST, '''', 0, 0, 0, 0, 0, 0, '''',');
    vQInsert.SQl.Add('0, '''', 0, '''', '''', '''')');
    vQInsert.Close;

    vConteo := 0;
    for vFacturaDet in pFactura.FacturaDet do
    begin
      Inc(vConteo);
      vQInsert.Close;
      vQInsert.ParamByName('CONTEO').AsInteger := vConteo;
      vQInsert.ParamByName('ID_EMPRESA').AsInteger := 1;
      vQInsert.ParamByName('ID_SUCURSAL').AsInteger := 1;
      vQInsert.ParamByName('NUMBER').AsInteger := vConsecutivo;
      vQInsert.ParamByName('TIPO').AsString := pFactura.Tipo;
      vQInsert.ParamByName('ID_USUARIO').AsString := DBPPal.Params.Values
        ['User_Fact'];
      vQInsert.ParamByName('ITEM').AsString := vFacturaDet.ITEM;
      vQInsert.ParamByName('LOCATION').AsString := '01';
      vQInsert.ParamByName('IVA').AsInteger := vFacturaDet.IVA;
      vQInsert.ParamByName('QTYSHIP').AsFloat := vFacturaDet.QTYSHIP;
      vQInsert.ParamByName('PRICE').AsFloat := vFacturaDet.PRICE;
      vQInsert.ParamByName('EXTEND').AsFloat := vFacturaDet.QTYSHIP *
        vFacturaDet.PRICE;
      vQInsert.ParamByName('COST').AsFloat := 0;


//       vQInsert.ParamByName('VLR_IVA').AsFloat :=
//        Trunc((vFacturaDet.PRICE * vFacturaDet.QTYSHIP) *
//        TraeIva(vFacturaDet.IVA));

        vQInsert.ParamByName('VLR_IVA').AsFloat :=vFacturaDet.VLR_IVA;

      vQInsert.ParamByName('PORC_IVA').AsFloat :=
        TraeIva(vFacturaDet.IVA) * 100;
      vQInsert.ParamByName('COD_CENTRO').AsInteger := vFacturaDet.CCOST;
      vQInsert.ParamByName('IDN_LOC').AsString := pFactura.ID_N;
      vQInsert.ParamByName('DPTO').AsInteger := vFacturaDet.DPTO;
      vQInsert.ParamByName('CCOST').AsInteger := vFacturaDet.CCOST;
      vQInsert.ParamByName('PROYECTO').AsString := vFacturaDet.PROY;
      vQInsert.ParamByName('ACTIVIDAD').AsString := vFacturaDet.ACTIV;
      vQInsert.ExecSQL;
    end;

    vQInsertCarpro.Close;
    vQInsertCarpro.SQl.Clear;
    vQInsertCarpro.SQl.Add
      ('update or insert into carpro (id_n, acct, tipo, batch, e, s, descripcion, fecha,');
    vQInsertCarpro.SQl.Add
      ('duedate, invc, depto, ccost, cruce, benef, abono, idvend,');
    vQInsertCarpro.SQl.Add('usuario, saldo_reporte,');
    vQInsertCarpro.SQl.Add('id_tipocartera, cheque_postf, diapago, ');
    vQInsertCarpro.SQl.Add
      ('saldo, base, credit, debit, tasa_cambio, saldo_us, credito_us, debito_us, cuota, shipto, ');
    vQInsertCarpro.SQl.Add('fecha_consig, actividad, proyecto)');
    vQInsertCarpro.SQl.Add
      ('values (:id_n, :acct, trim(:tipo), :batch, 1, 1, :descripcion, :fecha, :duedate, :invc,');
    vQInsertCarpro.SQl.Add(':depto, :ccost, :cruce, :id_n, 0, :idvend, ');
    vQInsertCarpro.SQl.Add(':usuario, 0,');
    vQInsertCarpro.SQl.Add('''CC'', ''false'', ');
    vQInsertCarpro.SQl.Add
      ('''false'', :saldo, 0, :credit, :debit, 0, 0, 0, 0, 1,');
    vQInsertCarpro.SQl.Add(':shipto, :fecha_consig, :actividad, :proyecto)');
    vQInsertCarpro.SQl.Add('matching (tipo, batch, e, s)');
    QFor_Pago.Close;
    QFor_Pago.ParamByName('concepto').AsInteger := pFactura.CONCEPTO_PAGO;
    QFor_Pago.Open;
    vQInsertCarpro.Close;
    vQInsertCarpro.ParamByName('id_n').AsString := pFactura.ID_N;
    vQInsertCarpro.ParamByName('acct').AsFloat := QFor_PagoACCT.AsFloat;
    vQInsertCarpro.ParamByName('tipo').AsString := pFactura.Tipo;
    vQInsertCarpro.ParamByName('batch').AsInteger := vConsecutivo;
    vQInsertCarpro.ParamByName('descripcion').AsString := 'Factura de Venta';
    vQInsertCarpro.ParamByName('fecha').AsDate := StrToDate(pFactura.FECHA);
    vQInsertCarpro.ParamByName('duedate').AsDate := StrToDate(pFactura.FECHA);
    vQInsertCarpro.ParamByName('invc').AsInteger := vConsecutivo;
    vQInsertCarpro.ParamByName('depto').AsInteger := 20;
    vQInsertCarpro.ParamByName('ccost').AsInteger := 3;
    vQInsertCarpro.ParamByName('idvend').AsString := '99';
    vQInsertCarpro.ParamByName('usuario').AsString := DBPPal.Params.Values
      ['User_Fact'];
    vQInsertCarpro.ParamByName('credit').AsFloat := 0;
    vQInsertCarpro.ParamByName('debit').AsFloat := pFactura.SUBTOTAL +
      pFactura.VLR_IVA;
    vQInsertCarpro.ParamByName('shipto').AsInteger := pFactura.SHIPTO;
    vQInsertCarpro.ParamByName('fecha_consig').AsDate := Date;
    vQInsertCarpro.ParamByName('cruce').AsString := pFactura.Tipo;
    vQInsertCarpro.ParamByName('saldo').AsFloat := pFactura.SUBTOTAL +
      pFactura.VLR_IVA;
    vQInsertCarpro.ParamByName('actividad').AsString := vFacturaDet.ACTIV;
    vQInsertCarpro.ParamByName('proyecto').AsString := vFacturaDet.PROY;
    vQInsertCarpro.ExecSQL;

    vQInsert.Close;
    vQInsert.SQl.Clear;
    vQInsert.SQl.Add
      ('delete from pagos where trim(TIPO) = trim(:TIPO) and NUMERO = :NUMERO');
    vQInsert.Close;
    vQInsert.ParamByName('TIPO').AsString := pFactura.Tipo;
    vQInsert.ParamByName('NUMERO').AsInteger := pFactura.BATCH;
    vQInsert.ExecSQL;

    vQInsert.Close;
    vQInsert.SQl.Clear;
    vQInsert.SQl.Add
      ('INSERT INTO PAGOS(EMPRESA, SUCURSAL, NUMERO, TIPO, NUM_CUOTA, USUARIO, ACCT, CONCEPTO, ');
    vQInsert.SQl.Add
      ('DESCRIPCION, PORC, DIAS, FECHA, NUM_DOC, COD_BANCO, PLAZA, VLR_PAGO, CONTA, TIPO_REF, REFERENCIA,');
    vQInsert.SQl.Add
      ('ID_N, NROCRUCE, TIPOCRUCE, CUOTACRUCE, DPTO, CC) VALUES(:EMPRESA, :SUCURSAL, :NUMERO, :TIPO, ');
    vQInsert.SQl.Add(':NUM_CUOTA, :USUARIO, :ACCT, :CONCEPTO,');
    vQInsert.SQl.Add
      (':DESCRIPCION, :PORC, :DIAS, :FECHA, :NUM_DOC, :COD_BANCO, :PLAZA, :VLR_PAGO, :CONTA, :TIPO_REF, :REFERENCIA,');
    vQInsert.SQl.Add(':ID_N, :NROCRUCE, :TIPOCRUCE, :CUOTACRUCE, :DPTO, :CC)');
    vQInsert.Close;
    vQInsert.ParamByName('EMPRESA').AsInteger := 1;
    vQInsert.ParamByName('SUCURSAL').AsInteger := 1;
    vQInsert.ParamByName('NUMERO').AsInteger := vConsecutivo;
    vQInsert.ParamByName('TIPO').AsString := pFactura.Tipo;
    vQInsert.ParamByName('NUM_CUOTA').AsInteger := 1;
    vQInsert.ParamByName('USUARIO').AsString := DBPPal.Params.Values
      ['User_Fact'];

    vQInsert.ParamByName('ACCT').AsFloat := QFor_PagoACCT.AsFloat;
    vQInsert.ParamByName('CONCEPTO').AsInteger := pFactura.CONCEPTO_PAGO;
    vQInsert.ParamByName('DESCRIPCION').AsString :=
      QFor_PagoDESCRIPCION.AsString;
    vQInsert.ParamByName('PORC').AsFloat := 100;
    vQInsert.ParamByName('DIAS').AsInteger := 0;
    vQInsert.ParamByName('FECHA').AsDateTime := StrToDate(pFactura.FECHA);
    vQInsert.ParamByName('NUM_DOC').AsString := pFactura.BATCH.ToString;
    vQInsert.ParamByName('COD_BANCO').AsInteger := 0;
    vQInsert.ParamByName('PLAZA').AsString := '';
    vQInsert.ParamByName('VLR_PAGO').AsFloat := pFactura.SUBTOTAL +
      pFactura.VLR_IVA;
    vQInsert.ParamByName('CONTA').AsString := 'False';
    vQInsert.ParamByName('TIPO_REF').AsString := '';
    vQInsert.ParamByName('REFERENCIA').AsInteger := 0;
    vQInsert.ParamByName('ID_N').AsString := pFactura.ID_N;
    vQInsert.ParamByName('NROCRUCE').AsInteger := 0;
    vQInsert.ParamByName('TIPOCRUCE').AsString := '';
    vQInsert.ParamByName('CUOTACRUCE').AsInteger := 0;
    vQInsert.ParamByName('DPTO').AsInteger := 20;
    vQInsert.ParamByName('CC').AsInteger := 3;
    vQInsert.ExecSQL;
  finally
    vQInsert.Free;
    vQInsertCarpro.Free;
  end;

  vFactura := TResultadoFactura.Create;
  vFactura.TIPO_FV := pFactura.Tipo;
  vFactura.BATCH_FV := vConsecutivo;

  TConsecutivo.IncrementaConsecutivo(DBPPal, pFactura.Tipo);

  Result := vFactura;

end;

procedure TWebsMetodos.IncrementarConsecutivo(E, S: Integer;
  Tipo, Clase: String);
var
  q: TFDQuery;
  vNumeroPedido: Integer;
begin
  q := TFDQuery.Create(nil);
  try
    q.Connection := DBPPal;
    q.SQl.Add(
      'update TIPDOC set CONSECUTIVO = CONSECUTIVO + 1 where tipo=''PE'' and clase='''
      + Clase + '''');
    q.ExecSQL;
  finally
    q.Free;
  end;
end;


function TWebsMetodos.CreaRecibo(pRecibo: TReciboCaja): TResultadoRecibo;
var
  vQInsert, vQInsertCarpro, vQActualizaSaldo, vQInsertGl: TFDQuery;
  vReciboCajaDet: TReciboCajaDet;
  vReciboCaja: TReciboCaja;
  vResultadoRecibo: TResultadoRecibo;
  vSaldoFV: TSaldoFactura;
  vConsecutivo: Integer;
  vTotDebit, vTotCredit: Double;
begin
  if not Assigned(pRecibo) then
    raise Exception.Create('Parámetro pRecibo con estructura defectuosa');

  vQInsert := TFDQuery.Create(nil);
  vQInsert.Connection := DBPPal;
  vQInsertCarpro := TFDQuery.Create(nil);
  vQInsertCarpro.Connection := DBPPal;

  vQActualizaSaldo := TFDQuery.Create(nil);
  vQActualizaSaldo.Connection := DBPPal;
  vQInsertGl := TFDQuery.Create(nil);
  vQInsertGl.Connection := DBPPal;
  vTotDebit := 0;
  vTotCredit := 0;
  try
    for vReciboCajaDet in pRecibo.ReciboCajaDet do
    begin
      if vReciboCajaDet.CONCEPTO_PAGO <> 0 then
        vTotDebit := vTotDebit + vReciboCajaDet.VALOR
      else
        vTotCredit := vTotCredit + vReciboCajaDet.VALOR;
    end;

    if vTotDebit <> vTotCredit then
      raise Exception.Create('El total recibido no cuadra con el pagado');
    vQInsert.SQl.Add
      ('update or insert into carproen (e, s, tipo, batch, id_n, fecha, total, username, fecha_hora, observ, banco, cheque,');
    vQInsert.SQl.Add
      ('duedate, letras, idvend, shipto, exportada, entregado, revisado, revisor, impreso, doc_fisico,');
    vQInsert.SQl.Add
      ('cheque_postf, proyecto, saldo_deuda, saldo_deuda_abono, ponumber)');
    vQInsert.SQl.Add
      ('values (1, 1, :tipo, :batch, :id_n, :fecha, :total, :username, :fecha_hora, :observ, :banco, :cheque, :duedate,');
    vQInsert.SQl.Add
      (':letras, :idvend, :shipto, ''N'', ''N'', ''N'', '''', ''N'', '''',');
    vQInsert.SQl.Add
      ('''false'', '''', :saldo_deuda, :saldo_deuda_abono, '''')');

    vQInsert.Close;
    vQInsert.ParamByName('tipo').AsString := pRecibo.Tipo;

    vConsecutivo := pRecibo.BATCH;
    if pRecibo.BATCH <> 0 then
      vQInsert.ParamByName('batch').AsInteger := pRecibo.BATCH
    else
    begin
      vConsecutivo := TConsecutivo.GetConsecutivo(DBPPal, pRecibo.Tipo);
      vQInsert.ParamByName('batch').AsInteger := vConsecutivo;
    end;

    vQInsert.ParamByName('id_n').AsString := pRecibo.ID_N;
    vQInsert.ParamByName('fecha').AsDate := StrToDate(pRecibo.FECHA);

    for vReciboCajaDet in pRecibo.ReciboCajaDet do
    begin
      vQInsert.ParamByName('total').AsFloat := vTotCredit;
    end;
    vQInsert.ParamByName('username').AsString := pRecibo.USERNAME;
    vQInsert.ParamByName('fecha_hora').AsString :=
      FormatDateTime('DD/MM/YYYY HH:MM:SS', StrToDate(pRecibo.FECHA));
    vQInsert.ParamByName('observ').AsString := pRecibo.OBSERV;
    vQInsert.ParamByName('banco').AsString := '';
    vQInsert.ParamByName('cheque').AsString := '';
    vQInsert.ParamByName('duedate').AsDate := StrToDate(pRecibo.FECHA);
    // Traer del NumToWord
    vQInsert.ParamByName('letras').AsString := '';
    vQInsert.ParamByName('idvend').AsInteger := 99;
    vQInsert.ParamByName('shipto').AsInteger := pRecibo.SHIPTO;
    vQInsert.ParamByName('saldo_deuda').AsFloat := 0;
    vQInsert.ParamByName('saldo_deuda_abono').AsFloat := 0;
    vQInsert.ExecSQL;

    vQInsert.Close;
    vQInsert.SQl.Clear;
    vQInsert.SQl.Add
      ('delete from carprode where tipo=:tipo and batch =:batch and e=1 and s=1');
    vQInsert.Close;
    vQInsert.ParamByName('tipo').AsString := pRecibo.Tipo;
    vQInsert.ParamByName('batch').AsInteger := pRecibo.BATCH;
    vQInsert.ExecSQL;

    vQInsert.Close;
    vQInsert.SQl.Clear;
    vQInsert.SQl.Add
      ('delete from carpro where tipo = :tipo and batch = :batch and e=1 and s=1');
    vQInsert.Close;
    vQInsert.ParamByName('tipo').AsString := pRecibo.Tipo;
    vQInsert.ParamByName('batch').AsInteger := pRecibo.BATCH;
    vQInsert.ExecSQL;

    vQInsertGl.Close;
    vQInsertGl.SQl.Clear;
    vQInsertGl.SQl.Add
      ('delete from gl where tipo = :tipo and batch = :batch and e=1 and s=1');
    vQInsertGl.Close;
    vQInsertGl.ParamByName('tipo').AsString := pRecibo.Tipo;
    vQInsertGl.ParamByName('batch').AsInteger := pRecibo.BATCH;
    vQInsertGl.ExecSQL;

    vQInsert.Close;
    vQInsert.SQl.Clear;
    vQInsert.SQl.Add('insert into carprode');
    vQInsert.SQl.Add
      ('(tipo, batch, id_n, acct, e, s, cruce, invc, fecha, duedate, dpto, ccost, actividad, descripcion, dias,');
    vQInsert.SQl.Add
      ('destino, invc_entero, cheque_postf, saldo, credit, tasa_cambio, credito_us, debito_us, base,');
    vQInsert.SQl.Add
      ('debit, cuota, import, concepto_pago,banco,cheque,fecha_consig,cod_flujoefe,proyecto)');
    vQInsert.SQl.Add
      ('values (:tipo, :batch, :id_n, :acct, 1, 1, :cruce, :invc, :fecha, :duedate, :dpto, :ccost, :actividad,');
    vQInsert.SQl.Add(':descripcion, 0, 1, ');
    vQInsert.SQl.Add('0, ''false'', :saldo, :credit,');
    vQInsert.SQl.Add
      ('0, 0, 0, 0, :debit, 1, ''N'',:concepto_pago,0,0,:fecha_consig,:cod_flujoefe,:proyecto)');

    vQInsertCarpro.Close;
    vQInsertCarpro.SQl.Clear;
    vQInsertCarpro.SQl.Add
      ('insert into carpro (id_n, acct, tipo, batch, e, s, descripcion, fecha,');
    vQInsertCarpro.SQl.Add
      ('duedate, invc, depto, ccost, cruce, benef, abono, idvend,');
    vQInsertCarpro.SQl.Add('usuario, saldo_reporte,');
    vQInsertCarpro.SQl.Add('id_tipocartera, cheque_postf, diapago, ');
    vQInsertCarpro.SQl.Add
      ('saldo, base, credit, debit, tasa_cambio, saldo_us, credito_us, debito_us, cuota, shipto, ');
    vQInsertCarpro.SQl.Add('fecha_consig,actividad,proyecto)');
    vQInsertCarpro.SQl.Add
      ('values (:id_n, :acct, :tipo, :batch, 1, 1, :descripcion, :fecha, :duedate, :invc,');
    vQInsertCarpro.SQl.Add(':depto, :ccost, :cruce, :id_n, 0, :idvend, ');
    vQInsertCarpro.SQl.Add(':usuario, 0,');
    vQInsertCarpro.SQl.Add('''CC'', ''false'', ');
    vQInsertCarpro.SQl.Add
      ('''false'', :saldo, 0, :credit, :debit, 0, 0, 0, 0, 1,');
    vQInsertCarpro.SQl.Add(':shipto, :fecha_consig,:actividad,:proyecto)');

    vResultadoRecibo := TResultadoRecibo.Create;
    vResultadoRecibo.TIPO_RC := pRecibo.Tipo;
    vResultadoRecibo.BATCH_RC := vConsecutivo;

    //

    for vReciboCajaDet in pRecibo.ReciboCajaDet do
    begin

      vQInsert.Close;
      vQInsert.ParamByName('tipo').AsString := pRecibo.Tipo;
      vQInsert.ParamByName('batch').AsInteger := vConsecutivo;
      vQInsert.ParamByName('id_n').AsString := pRecibo.ID_N;

      vQInsert.ParamByName('fecha').AsDate := StrToDate(pRecibo.FECHA);
      vQInsert.ParamByName('duedate').AsDate := StrToDate(pRecibo.FECHA);
      vQInsert.ParamByName('dpto').AsInteger := vReciboCajaDet.DEPTO;
      vQInsert.ParamByName('ccost').AsInteger := vReciboCajaDet.CCOST;
      vQInsert.ParamByName('actividad').AsString := vReciboCajaDet.ACTIVIDAD;
      vQInsert.ParamByName('proyecto').AsString := vReciboCajaDet.PROYECTO;
      vQInsert.ParamByName('descripcion').AsString :=
        vReciboCajaDet.DESCRIPCION;
      vQInsert.ParamByName('concepto_pago').AsInteger :=
        vReciboCajaDet.CONCEPTO_PAGO;
      vQInsert.ParamByName('fecha_consig').AsDate := StrToDate(pRecibo.FECHA);
      QFor_Pago.Close;
      QFor_Pago.ParamByName('concepto').AsInteger :=
        vReciboCajaDet.CONCEPTO_PAGO;
      QFor_Pago.Open;
      QPagos.Close;
      QPagos.ParamByName('NUMERO').AsInteger :=
        vReciboCajaDet.NUMERO_FV.ToInteger;
      QPagos.ParamByName('TIPO').AsString := vReciboCajaDet.TIPO_FV;
      QPagos.Open;
      if vReciboCajaDet.CONCEPTO_PAGO <> 0 then
      begin

        vQInsert.ParamByName('debit').AsFloat := vReciboCajaDet.VALOR;
        vQInsert.ParamByName('credit').AsFloat := 0;
        vQInsert.ParamByName('acct').AsFloat := QFor_PagoACCT.AsFloat;
        vQInsert.ParamByName('saldo').AsFloat := 0;
        vQInsert.ParamByName('cod_flujoefe').AsFloat := 0;
        vTotDebit := vTotDebit + vReciboCajaDet.VALOR;

        vQInsert.ParamByName('cruce').AsString := pRecibo.Tipo;
        vQInsert.ParamByName('invc').AsString := vConsecutivo.ToString;
      end
      else
      begin
        vQInsert.ParamByName('cruce').AsString := vReciboCajaDet.TIPO_FV;
        vQInsert.ParamByName('invc').AsString := vReciboCajaDet.NUMERO_FV;
        vQInsert.ParamByName('debit').AsFloat := 0;
        vQInsert.ParamByName('credit').AsFloat := vReciboCajaDet.VALOR;
        vQInsert.ParamByName('acct').AsFloat := QPagosACCT.AsFloat;
        // .Valor_FloatQPagosACCT.AsFloat;
        vQInsert.ParamByName('saldo').AsFloat := 0 - vReciboCajaDet.VALOR;
        vQInsert.ParamByName('concepto_pago').Clear;
        vQInsert.ParamByName('cod_flujoefe').Clear;
        vTotCredit := vTotCredit + vReciboCajaDet.VALOR;
      end;
      vQInsert.ExecSQL;

      //
      if vQInsert.ParamByName('acct').AsFloat = QPagosACCT.AsFloat then
      begin
        vQInsertCarpro.Close;
        vQInsertCarpro.ParamByName('id_n').AsString := pRecibo.ID_N;
        vQInsertCarpro.ParamByName('acct').AsFloat := QPagosACCT.AsFloat;
        vQInsertCarpro.ParamByName('tipo').AsString := pRecibo.Tipo;
        vQInsertCarpro.ParamByName('batch').AsInteger := vConsecutivo;
        vQInsertCarpro.ParamByName('descripcion').AsString :=
          vReciboCajaDet.DESCRIPCION;
        vQInsertCarpro.ParamByName('fecha').AsDate := StrToDate(pRecibo.FECHA);
        vQInsertCarpro.ParamByName('duedate').AsDate :=
          StrToDate(pRecibo.FECHA);
        vQInsertCarpro.ParamByName('invc').AsString := vReciboCajaDet.NUMERO_FV;
        vQInsertCarpro.ParamByName('depto').AsInteger := 0;
        vQInsertCarpro.ParamByName('ccost').AsInteger := 0;
        vQInsertCarpro.ParamByName('idvend').AsString := '99';
        vQInsertCarpro.ParamByName('usuario').AsString := pRecibo.USERNAME;
        vQInsertCarpro.ParamByName('credit').AsFloat := vReciboCajaDet.VALOR;
        vQInsertCarpro.ParamByName('debit').AsFloat := 0;
        vQInsertCarpro.ParamByName('shipto').AsInteger := pRecibo.SHIPTO;
        vQInsertCarpro.ParamByName('saldo').AsFloat := 0;
        vQInsertCarpro.ParamByName('fecha_consig').AsDate :=
          StrToDateTimeDef(vReciboCajaDet.FECHA_CONSIG, Date);
        vQInsertCarpro.ParamByName('cruce').AsString := vReciboCajaDet.TIPO_FV;
        vQInsertCarpro.ParamByName('actividad').AsString :=
          vReciboCajaDet.ACTIVIDAD;
        vQInsertCarpro.ParamByName('proyecto').AsString :=
          vReciboCajaDet.PROYECTO;
        vQInsertCarpro.ExecSQL;
        vQActualizaSaldo.Close;
        vQActualizaSaldo.SQl.Clear;
        vQActualizaSaldo.Params.Clear;
        vQActualizaSaldo.ExecSQL
          ('execute procedure CXCXP_ACTUALIZARSALDOS_INSERTAR(1,1,''' +
          pRecibo.Tipo + ''',' + vConsecutivo.ToString + ')');
      end;
      vSaldoFV := TSaldoFactura.Create;
      vSaldoFV.TIPO_FV := vReciboCajaDet.TIPO_FV;
      vSaldoFV.BATCH_FV := StrToIntDef(vReciboCajaDet.NUMERO_FV, 0);
      vSaldoFV.SALDO_FV := 0;
      vResultadoRecibo.SaldoFacturas.Add(vSaldoFV);
    end;

    vQInsertGl.Close;
    vQInsertGl.SQl.Clear;
    vQInsertGl.SQl.Add('insert into gl');
    vQInsertGl.SQl.Add
      ('(id_n, acct,e,s,tipo,batch,fecha,duedate,invc,depto,ccost,actividad,period,descripcion,');
    vQInsertGl.SQl.Add
      ('cruce, destino,base,credit,debit,cuota,prorrateado,cod_flujoefe,username,proyecto)');
    vQInsertGl.SQl.Add
      ('select id_n,acct,e,s,tipo,batch,fecha,duedate,invc,dpto,ccost,actividad,(extract(year from fecha) || extract(month from fecha)),descripcion,');
    vQInsertGl.SQl.Add
      ('cruce,destino,base,credit,debit,cuota,''N'',cod_flujoefe,' +
      QuotedStr(pRecibo.USERNAME) + ',proyecto from carprode  ');
    vQInsertGl.SQl.Add('where tipo=' + QuotedStr(pRecibo.Tipo) + ' and Batch=' +
      vConsecutivo.ToString + '');
    vQInsertGl.ExecSQL;

    TConsecutivo.IncrementaConsecutivo(DBPPal, pRecibo.Tipo);
  finally
    vQInsert.Free;
    vQActualizaSaldo.Free;
  end;
  Result := vResultadoRecibo;
end;

function TWebsMetodos.CreaTercero(pTercero: TTercero): TResultadoTercero;
var
  vQ: TFDQuery;
begin
  vQ := TFDQuery.Create(nil);
  try
    vQ.Connection := DBPPal;
    Result := TResultadoTercero.Create;
    try
      vQ.ExecSQL
        ('insert into CUST (ID_N, NIT, ACCT, ACCTP, COMPANY, ADDR1, ADDR2, CITY,'
        + 'PAIS, CONTACT1, CARGO1, CONTACT2, CARGO2, PHONE1, EXT1, PHONE2, EXT2, PHONE3,'
        + 'EXT3, FAX, EXT4, NOTAS, MEMO, ACTIVIDAD, GRUPO, CATEGORIA, ZONA, TERMS, TERMSP,'
        + 'GRAVABLE, RETENEDOR, LATE, CREDITLMT, ONACCOUNT, NIVEL, FUENTE, ' +
        'ISSUE1099, ONETIME, RETIVA, IVAIN, AUTORET, CREDITO, PLAZO, CLIENTE, PROVEEDOR, OTRO, EMPLEADO,'
        + 'VENDEDOR, ICAIN, RETEICA, TIPOEMP, COD_VEND, IDVEND, PROSPECTO, DESCUENTO, CV, E, S,'
        + 'FECHA_CREACION, EMAIL, TIPORETEICA, DCTADICIONAL, DEPARTAMENTO, COMPANY_EXTENDIDO, ID_TIPOCARTERA,'
        + 'COD_NIVEL, DIAS_GRACIA, USERNAME, RETIVA_PROV, DCTO_AD1, DCTO_AD2, MEDICO, IPS, TIPORETICA_VENTA,'
        + 'GRAVABLEIP, TASA_COM, CLITIP, NUIT, PORCON, IVATEO, RTIVA100, TASAAIU,'
        + 'NRO_TARJETA, COD_EPS, TASA_DCTO_PRONTOPAGO, RETECREEC, RETECREEV, AUTOCREE,'
        + 'NIIF_CONTA_AUTO_FAC, CREDITLMTPROV, TIPRET, TIPAUTRET, INACTIVO,  ' +
        'APLICA_RETEFUENTE)' +
        'values(:ID_N, :NIT, 13050501, 22050101, :COMPANY, :ADDR1, :ADDR2, :CITY,'
        + ':PAIS, :CONTACT1, :CARGO1, :CONTACT2, :CARGO2, :PHONE1, :EXT1, :PHONE2, :EXT2, :PHONE3,'
        + ':EXT3, :FAX, :EXT4, :NOTAS, :MEMO, :ACTIVIDAD, :GRUPO, :CATEGORIA, :ZONA, :TERMS, :TERMSP,'
        + ':GRAVABLE, :RETENEDOR, :LATE, :CREDITLMT, :ONACCOUNT, :NIVEL, :FUENTE, '
        + ':ISSUE1099, :ONETIME, :RETIVA, :IVAIN, :AUTORET, :CREDITO, :PLAZO, :CLIENTE, :PROVEEDOR, :OTRO, :EMPLEADO,'
        + ':VENDEDOR, :ICAIN, :RETEICA, :TIPOEMP, :COD_VEND, :IDVEND, :PROSPECTO, :DESCUENTO, :CV, :E, :S,'
        + ':FECHA_CREACION, :EMAIL, :TIPORETEICA, :DCTADICIONAL, :DEPARTAMENTO, :COMPANY_EXTENDIDO, :ID_TIPOCARTERA,'
        + ':COD_NIVEL, :DIAS_GRACIA, :USERNAME, :RETIVA_PROV, :DCTO_AD1, :DCTO_AD2, :MEDICO, :IPS, :TIPORETICA_VENTA,'
        + ':GRAVABLEIP, :TASA_COM, :CLITIP, :NUIT, :PORCON, :IVATEO, :RTIVA100, :TASAAIU,'
        + ':NRO_TARJETA, :COD_EPS, :TASA_DCTO_PRONTOPAGO, :RETECREEC, :RETECREEV, :AUTOCREE,'
        + ':NIIF_CONTA_AUTO_FAC, :CREDITLMTPROV, :TIPRET, :TIPAUTRET, :INACTIVO, '
        + ':APLICA_RETEFUENTE)', [pTercero.ID_N, pTercero.ID_N,
        pTercero.COMPANY, pTercero.ADDR1, pTercero.ADDR1, pTercero.CITY,
        pTercero.PAIS, pTercero.CONTACT1, pTercero.CARGO1, pTercero.CONTACT1,
        pTercero.CARGO1, pTercero.PHONE1, pTercero.EXT1, pTercero.PHONE1,
        pTercero.EXT1, pTercero.PHONE1, pTercero.EXT1, pTercero.PHONE1,
        pTercero.EXT1, pTercero.COMPANY_EXTENDIDO, pTercero.COMPANY_EXTENDIDO,
        1, 1, 1, 1, pTercero.CONCEPTO, 0, pTercero.GRAVABLE, pTercero.RETENEDOR,
        'False', pTercero.CREDITLMT, 'False', pTercero.NIVEL, 1, 'False',
        'False', 'False', 'False', pTercero.AUTORET, pTercero.CREDITO, 0,
        pTercero.CLIENTE, pTercero.PROVEEDOR, pTercero.OTRO, pTercero.EMPLEADO,
        pTercero.IDVEND, pTercero.ICAIN, pTercero.RETEICA, 999, '',
        pTercero.IDVEND, 'False', pTercero.DESCUENTO, pTercero.CV, 1, 1,
        pTercero.FECHA_CREACION, pTercero.EMAIL, pTercero.TIPORETEICA,
        pTercero.DCTADICIONAL, pTercero.DEPARTAMENTO,
        pTercero.COMPANY_EXTENDIDO, '', '', pTercero.DIAS_GRACIA, 'SAI',
        pTercero.RETIVA_PROV, 0, 0, 'False', 'False', '', pTercero.GRAVABLE, 0,
        0, pTercero.ID_N, 0, 'False', 'False', 0, '', '', 0, '', '', '', 'N', 0,
        '', '', 'N', 'S']);
      vQ.Close;
      vQ.SQl.Clear;
      vQ.ExecSQL('INSERT INTO SHIPTO  (ID_N,SUCCLIENTE,DESCRIPCION,COMPANY,' +
        'ADDR1,ADDR2,PHONE1,PHONE2,FAX,EXT1,EXT2,CONTEO,ZONA,' +
        'ID_VEND,PAIS,CONTACT1,CARGO1,EMAIL,CIRCUITO,COMUNA,BARRIO,' +
        'IMPCONSUMO,DEPARTAMENTO,CITY,RETIVA_PROV,CREDITLMT,ESTADO)' +
        'SELECT C.ID_N,0,''OFICINA PRINCIPAL'', C.COMPANY, C.ADDR1,C.ADDR2,' +
        'C.PHONE1,C.PHONE2,C.FAX,C.EXT1,C.EXT2,0,1, C.IDVEND,C.PAIS, C.CONTACT1,'
        + 'C.CARGO1, C.EMAIL, 0,0,0,''N'',C.DEPARTAMENTO,C.CITY,''False'',C.CREDITLMT,'
        + '''ACTIVO'' FROM CUST C WHERE C.ID_N = :IDN', [pTercero.ID_N]);
      Result.Exitoso := True;
      Result.Mensaje := 'Tercero creado de manera exitosa en la base de datos';
    except
      on E: Exception do
      begin
        Result.Exitoso := False;
        Result.Mensaje := E.Message;
      end;
    end;
  finally
    vQ.DisposeOf;
  end;
end;

function TWebsMetodos.DataSetACartera(pDataSet: TDataSet): TCartera;
begin
  Result := TCartera.Create;
  Result.ID_N := pDataSet.FieldByName('ID_N').AsString;
  Result.Tipo := pDataSet.FieldByName('TIPO').AsString;
  Result.BATCH := pDataSet.FieldByName('BATCH').AsInteger;
  Result.FECHA := FormatDateTime('DD/MM/YYYY', pDataSet.FieldByName('FECHA')
    .AsDateTime);
  Result.DUEDATE := FormatDateTime('DD/MM/YYYY', pDataSet.FieldByName('DUEDATE')
    .AsDateTime);
  Result.DIAS_VENCIMIENTO := pDataSet.FieldByName('DIAS_VENCIMIENTO').AsInteger;
  Result.SALDO := pDataSet.FieldByName('SALDO').AsFloat;
  Result.SALDO_US := pDataSet.FieldByName('SALDO_US').AsFloat;
end;

function TWebsMetodos.DataSetAItem(pDataSet: TDataSet): TProducto;
begin
  Result := TProducto.Create;
  Result.ITEM := pDataSet.FieldByName('ITEM').AsString;
  Result.DESCRIPCION := pDataSet.FieldByName('DESCRIPCION').AsString;
  Result.ITEMMSTR := pDataSet.FieldByName('ITEMMSTR').AsString;;
  Result.GRUPO := pDataSet.FieldByName('GRUPO').AsString;;
  Result.SUBGRUPO := pDataSet.FieldByName('CLASS').AsString;
  Result.CCOSTO := pDataSet.FieldByName('CCOSTO').AsInteger;;
  Result.DEPTO := pDataSet.FieldByName('DEPTO').AsInteger;
  Result.UOFMSALES := pDataSet.FieldByName('UOFMSALES').AsString;
  Result.UOFMORDERS := pDataSet.FieldByName('UOFMORDERS').AsString;
  Result.FACTOR := pDataSet.FieldByName('FACTOR').AsFloat;
  Result.TIPO_FACTOR := pDataSet.FieldByName('TIPO_FACTOR').AsString;
  Result.PRICE := pDataSet.FieldByName('PRICE').AsFloat;
  Result.PRICE1 := pDataSet.FieldByName('PRICE1').AsFloat;
  Result.PRICE2 := pDataSet.FieldByName('PRICE2').AsFloat;
  Result.PRICE3 := pDataSet.FieldByName('PRICE3').AsFloat;
  Result.PRICE4 := pDataSet.FieldByName('PRICE4').AsFloat;
  Result.PRICE5 := pDataSet.FieldByName('PRICE5').AsFloat;
  Result.PRECIOIVA := pDataSet.FieldByName('PRECIOIVA').AsFloat;
  Result.IVA := pDataSet.FieldByName('IVA').AsInteger;
  Result.DCTADICIONAL := pDataSet.FieldByName('DCTADICIONAL').AsFloat;
  Result.DCTFIJO := pDataSet.FieldByName('DCTFIJO').AsFloat;
  Result.MINIMO := pDataSet.FieldByName('MINIMO').AsFloat;
  Result.MAXIMO := pDataSet.FieldByName('MAXIMO').AsFloat;
  Result.KITLEVEL := pDataSet.FieldByName('KITLEVEL').AsString;
  Result.NOTAS := pDataSet.FieldByName('NOTAS').AsString;
  Result.Tipo := pDataSet.FieldByName('TIPO').AsString;
  Result.MARCA := pDataSet.FieldByName('MARCA').AsString;
  Result.MODELO := pDataSet.FieldByName('MODELO').AsString;
  Result.DESC_MAXP := pDataSet.FieldByName('DESC_MAXP').AsFloat;
  Result.COD_BARRAS := pDataSet.FieldByName('COD_BARRAS').AsString;
  Result.REFFABRICA := pDataSet.FieldByName('REFFABRICA').AsString;
  Result.Version := pDataSet.FieldByName('VERSION').AsInteger;
end;

function TWebsMetodos.DataSetATercero(pDataSet: TDataSet): TTercero;
begin
  Result := TTercero.Create;
  Result.ID_N := pDataSet.FieldByName('ID_N').AsString;
  Result.COMPANY := pDataSet.FieldByName('COMPANY').AsString;
  Result.COMPANY_EXTENDIDO := pDataSet.FieldByName('COMPANY_EXTENDIDO')
    .AsString;
  Result.ADDR1 := pDataSet.FieldByName('ADDR1').AsString;
  Result.CITY := pDataSet.FieldByName('CITY').AsString;
  Result.DEPARTAMENTO := pDataSet.FieldByName('DEPARTAMENTO').AsString;
  Result.PAIS := pDataSet.FieldByName('PAIS').AsString;
  Result.CONTACT1 := pDataSet.FieldByName('CONTACT1').AsString;
  Result.CARGO1 := pDataSet.FieldByName('CARGO1').AsString;
  Result.PHONE1 := pDataSet.FieldByName('PHONE1').AsString;
  Result.EXT1 := pDataSet.FieldByName('EXT1').AsString;
  Result.GRAVABLE := pDataSet.FieldByName('GRAVABLE').AsString;
  Result.RETENEDOR := pDataSet.FieldByName('RETENEDOR').AsString;
  Result.CREDITLMT := pDataSet.FieldByName('CREDITLMT').AsFloat;
  Result.NIVEL := pDataSet.FieldByName('NIVEL').AsString;
  Result.RETIVA := pDataSet.FieldByName('RETIVA').AsString;
  Result.AUTORET := pDataSet.FieldByName('AUTORET').AsString;
  Result.CREDITO := pDataSet.FieldByName('CREDITO').AsString;
  Result.CLIENTE := pDataSet.FieldByName('CLIENTE').AsString;
  Result.PROVEEDOR := pDataSet.FieldByName('PROVEEDOR').AsString;
  Result.OTRO := pDataSet.FieldByName('OTRO').AsString;
  Result.EMPLEADO := pDataSet.FieldByName('EMPLEADO').AsString;
  Result.VENDEDOR := pDataSet.FieldByName('VENDEDOR').AsString;
  Result.ICAIN := pDataSet.FieldByName('ICAIN').AsString;
  Result.RETEICA := pDataSet.FieldByName('RETEICA').AsString;
  Result.IDVEND := pDataSet.FieldByName('IDVEND').AsInteger;
  Result.DESCUENTO := pDataSet.FieldByName('DESCUENTO').AsFloat;
  Result.CV := pDataSet.FieldByName('CV').AsInteger;
  Result.FECHA_CREACION := FormatDateTime('YYYY/MM/dd',
    pDataSet.FieldByName('FECHA_CREACION').AsDateTime);
  // YYYY/MM/DD
  Result.EMAIL := pDataSet.FieldByName('EMAIL').AsString;
  Result.TIPORETEICA := pDataSet.FieldByName('TIPORETEICA').AsString;
  Result.DCTADICIONAL := pDataSet.FieldByName('DCTADICIONAL').AsString;
  Result.DIAS_GRACIA := pDataSet.FieldByName('DIAS_GRACIA').AsInteger;
  Result.RETIVA_PROV := pDataSet.FieldByName('RETIVA_PROV').AsString;
  Result.CONCEPTO := pDataSet.FieldByName('TERMS').AsInteger;
  Result.Version := pDataSet.FieldByName('Version').AsInteger;
end;

procedure TWebsMetodos.DSServerModuleCreate(Sender: TObject);
begin
  DBPPal.Connected := False;
  DBPPal.Params.LoadFromFile(IncludeTrailingPathDelimiter
    (ExtractFilePath(ParamSTR(0))) + 'Conf.cnf');
end;

function TWebsMetodos.EchoString(Value: string): string;
begin
  Result := Value;
end;


function TWebsMetodos.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TWebsMetodos.TraeCartera(pNit: string): TList<TCartera>;
var
  vCartera: TList<TCartera>;
begin
  QCartera.Close;
  QCartera.ParamByName('ID_N').AsString := pNit;
  QCartera.Open;

  vCartera := TList<TCartera>.Create;
  QCartera.DisableControls;
  QCartera.First;
  while not QCartera.Eof do
  begin
    vCartera.Add(DataSetACartera(QCartera));
    QCartera.Next;
  end;

  QCartera.Close;
  Result := vCartera;
end;

function TWebsMetodos.TraeEntrada(pTipo: String; pNumero: Integer)
  : TObjectList<TEntrada>;
var
  vEntrada: TEntrada;
begin
  QEntrada.Close;
  QEntrada.ParamByName('TIPO').AsString := pTipo;
  QEntrada.ParamByName('NUMBER').AsInteger := pNumero;
  QEntrada.Open;

  Result := TObjectList<TEntrada>.Create;
  QEntrada.First;
  while not QEntrada.Eof do
  begin
    vEntrada := TEntrada.Create;
    vEntrada.Tipo := QEntrada.FieldByName('tipo').AsString;
    vEntrada.FECHA := QEntrada.FieldByName('fecha').AsString;
    vEntrada.Numero := QEntrada.FieldByName('number').AsInteger;
    vEntrada.ITEM := QEntrada.FieldByName('item').AsString;
    vEntrada.CodBarrasCurvas := QEntrada.FieldByName('codbarrascurva').AsString;
    vEntrada.Cantidad := QEntrada.FieldByName('qty').AsFloat;
    vEntrada.Precio := QEntrada.FieldByName('cost').AsFloat;
    vEntrada.Tercero := QEntrada.FieldByName('id_n').AsString;
    Result.Add(vEntrada);
    QEntrada.Next;
  end;
end;

function TWebsMetodos.TraeFactura(pTipo: String; pNumero: Integer): TFactura;
var
  vFactura: TFactura;
  vFacturaDet: TFacturaDet;
begin
  QFactura.Close;
  QFactura.ParamByName('TIPO').AsString := pTipo;
  QFactura.ParamByName('NUMBER').AsInteger := pNumero;
  QFactura.Open;

  vFactura := TFactura.Create;
  vFactura.Tipo := pTipo;
  if pNumero = 0 then
    vFactura.BATCH := Random(1000)
  else
    vFactura.BATCH := pNumero;

  vFactura.ID_N := QFactura.FieldByName('ID_N').AsString;
  vFactura.FECHA := FormatDateTime('MM/DD/YYYY', QFactura.FieldByName('FECHA')
    .AsDateTime);
  vFactura.SHIPTO := QFactura.FieldByName('SHIPTO').AsInteger;
  vFactura.SUBTOTAL := QFactura.FieldByName('TOTAl').AsFloat;
  vFactura.VLR_IVA := QFactura.FieldByName('SALESTAX').AsFloat;

  QFactura.First;
  while not QFactura.Eof do
  begin
    vFacturaDet := TFacturaDet.Create;
    vFacturaDet.ITEM := QFactura.FieldByName('ITEM').AsString;
    vFacturaDet.IVA := QFactura.FieldByName('IVA').AsInteger;
    vFacturaDet.QTYSHIP := QFactura.FieldByName('QTYSHIP').AsFloat;
    vFacturaDet.PRICE := QFactura.FieldByName('PRICE').AsFloat;
    vFacturaDet.NOTES := QFactura.FieldByName('NOTES').AsString;
    vFacturaDet.DPTO := QFactura.FieldByName('DPTO').AsInteger;
    vFacturaDet.CCOST := QFactura.FieldByName('CCOST').AsInteger;
    vFacturaDet.PROY := QFactura.FieldByName('PROYECTO').AsString;
    vFacturaDet.ACTIV := QFactura.FieldByName('ACTIVIDAD').AsString;
    vFacturaDet.VLR_IVA := QFactura.FieldByName('VLR_IVA').AsFloat;
    vFactura.FacturaDet.Add(vFacturaDet);
    QFactura.Next;
  end;

  Result := vFactura;
end;

function TWebsMetodos.TraeIva(Codigo: Integer): Double;
var
  vQ: TFDQuery;

begin
  vQ := TFDQuery.Create(nil);
  vQ.Connection := DBPPal;
  vQ.Close;
  vQ.SQl.Add('SELECT RATE FROM TAXAUTH WHERE CODIGO =:CODIGO');
  vQ.ParamByName('CODIGO').AsInteger := Codigo;
  vQ.Open;
  Result := (vQ.Fields[0].AsFloat) / 100;
end;

function TWebsMetodos.TraeListaCurvas(pCodigoCurva: String): TList<TCurva>;
var
  vLista: TList<TCurva>;
  vCurva: TCurva;
begin
  vLista := TList<TCurva>.Create;
  vCurva := TCurva.Create;
  vCurva.COD_CURVA := pCodigoCurva;
  vCurva.COD_COLOR := 'AMARILLO';
  vCurva.COD_TALLA := '6';
  vCurva.ITEM := '620';
  vCurva.CODBARRASCURVA := '586663';

  vLista.Add(vCurva);

  vCurva := TCurva.Create;
  vCurva.COD_CURVA := pCodigoCurva;
  vCurva.COD_COLOR := 'NEGRO';
  vCurva.COD_TALLA := '10';
  vCurva.ITEM := '620';
  vCurva.CODBARRASCURVA := '41555';

  vLista.Add(vCurva);

  Result := vLista;
end;

function TWebsMetodos.TraeListaCurvasPorItem(pCodigoItem: String)
  : TList<TCurva>;
var
  vLista: TList<TCurva>;
  vCurva: TCurva;
begin
  vLista := TList<TCurva>.Create;
  vCurva := TCurva.Create;
  vCurva.COD_CURVA := '104';
  vCurva.COD_COLOR := 'AMARILLO';
  vCurva.COD_TALLA := '6';
  vCurva.ITEM := '620';
  vCurva.CODBARRASCURVA := '586663';

  vLista.Add(vCurva);

  Result := vLista;
end;

function TWebsMetodos.TraeListaProductos(pVersion: Integer)
  : TList<TProducto>;
var
  vProductos: TList<TProducto>;
begin
  QItems.Close;
  QItems.ParamByName('Version').AsInteger := pVersion;
  QItems.Open;

  vProductos := TList<TProducto>.Create;
  QItems.DisableControls;
  QItems.First;
  while not QItems.Eof do
  begin
    vProductos.Add(DataSetAItem(QItems));
    QItems.Next;
  end;

  QItems.Close;
  Result := vProductos;
end;

function TWebsMetodos.TraeListaTerceros(pVersion: Integer): TList<TTercero>;
var
  vTerceros: TList<TTercero>;
begin
  QTerceros.Close;
  QTerceros.ParamByName('Version').AsInteger := pVersion;
  QTerceros.Open;

  vTerceros := TList<TTercero>.Create;
  QTerceros.DisableControls;
  QTerceros.First;
  while not QTerceros.Eof do
  begin
    vTerceros.Add(DataSetATercero(QTerceros));
    QTerceros.Next;
  end;

  QTerceros.Close;
  Result := vTerceros;
end;

function TWebsMetodos.TraeNumeroFactura(pID_N: String;
  pShipto, pMes, pAno: Integer): TList<TResultadoFactura>;
var
  vFactura: TResultadoFactura;
  vFacturas: TList<TResultadoFactura>;
begin
  vFacturas := TList<TResultadoFactura>.Create;
  vFactura := TResultadoFactura.Create;
  vFactura.TIPO_FV := 'FV1';
  vFactura.BATCH_FV := 2335;

  vFacturas.Add(vFactura);

  vFactura := TResultadoFactura.Create;
  vFactura.TIPO_FV := 'FV1';
  vFactura.BATCH_FV := 4532;

  vFacturas.Add(vFactura);

  Result := vFacturas;
end;

function TWebsMetodos.TraeOrden(pTipo: String; pNumero: Integer): TOrden;
var
  vOrden: TOrden;
  vOrdenDet: TOrdenDet;
begin
  QOrden.Close;
  QOrden.ParamByName('TIPO').AsString := pTipo;
  QOrden.ParamByName('NUMBER').AsInteger := pNumero;
  QOrden.Open;

  vOrden := TOrden.Create;
  vOrden.Tipo := pTipo;
  vOrden.NUMBER := pNumero;
  vOrden.E := QOrden.ParamByName('E').AsString;
  vOrden.S := QOrden.ParamByName('S').AsString;
  vOrden.ID_N := QOrden.ParamByName('ID_N').AsString;
  vOrden.FECHA := QOrden.ParamByName('FECHA').AsString;
  vOrden.ACCT := QOrden.ParamByName('ACCT').AsFloat;
  vOrden.ESTADO := QOrden.ParamByName('ESTADO').AsString;
  vOrden.DUEDATE := QOrden.ParamByName('DUEDATE').AsString;
  vOrden.TOTAL := QOrden.ParamByName('TOTAL').AsFloat;
  vOrden.FECHA_PAGO := QOrden.ParamByName('FECHA_PAGO').AsString;
  vOrden.TOTALDCT := QOrden.ParamByName('TOTALDCT').AsFloat;
  vOrden.SUBTOTAL := QOrden.ParamByName('SUBTOTAL').AsFloat;
  vOrden.TOTALIVA := QOrden.ParamByName('TOTALIVA').AsFloat;
  vOrden.ID_N_SOLICITANTE := QOrden.ParamByName('ID_N_SOLICITANTE').AsString;
  vOrden.VALORRTICA := QOrden.ParamByName('VALORRTICA').AsFloat;
  vOrden.FECHA_REQUISICION := QOrden.ParamByName('FECHA_REQUISICION').AsString;
  QOrden.DisableControls;
  QOrden.First;

  while not QOrden.Eof do
  begin
    vOrdenDet := TOrdenDet.Create(vOrden);
    vOrdenDet.LOCATION := QOrden.ParamByName('LOCATION').AsInteger;
    vOrdenDet.QTY := QOrden.ParamByName('QTY').AsFloat;
    vOrdenDet.ITEM := QOrden.ParamByName('ITEM').AsString;
    vOrdenDet.RECIBIDO := QOrden.ParamByName('RECIBIDO').AsFloat;
    vOrdenDet.COST := QOrden.ParamByName('COST').AsFloat;
    vOrdenDet.PRICEPROV := QOrden.ParamByName('PRICEPROV').AsFloat;
    vOrdenDet.PORC_IVA := QOrden.ParamByName('PORC_IVA').AsInteger;
    // vOrden.AgregaPedidoDet(vPedidoDet);

    QOrden.Next;
  end;

  Result := vOrden;

end;



function TWebsMetodos.TraeProducto(pCodigo: String): TProducto;
begin
  QItem.Close;
  QItem.ParamByName('ITEM').AsString := pCodigo;
  QItem.Open;
  Result := DataSetAItem(QItem);
end;

function TWebsMetodos.TraeRecibo(pTipo: String; pNumero: Integer)
  : TReciboCaja;
var
  vRecibo: TReciboCaja;
  vReciboDet: TReciboCajaDet;
begin
  QRecibo.Close;
  QRecibo.ParamByName('tipo').AsString := pTipo;
  QRecibo.ParamByName('batch').AsInteger := pNumero;
  QRecibo.Open;

  vRecibo := TReciboCaja.Create;
  vRecibo.Tipo := QRecibo.FieldByName('TIPO').AsString;

  if pNumero = 0 then
    vRecibo.BATCH := Random(1000)
  else
    vRecibo.BATCH := pNumero;

  vRecibo.ID_N := QRecibo.FieldByName('ID_N').AsString;
  vRecibo.FECHA := FormatDateTime('MM/DD/YYYY', QRecibo.FieldByName('FECHA')
    .AsDateTime);
  vRecibo.USERNAME := QRecibo.FieldByName('USERNAME').AsString;
  vRecibo.OBSERV := QRecibo.FieldByName('OBSERV').AsString;
  vRecibo.SHIPTO := QRecibo.FieldByName('SHIPTO').AsInteger;

  QRecibo.First;
  while not QRecibo.Eof do
  begin
    vReciboDet := TReciboCajaDet.Create;
    vReciboDet.TIPO_FV := QRecibo.FieldByName('TIPO_FV').AsString;
    vReciboDet.NUMERO_FV := QRecibo.FieldByName('NUMERO_FV').AsString;
    vReciboDet.DESCRIPCION := QRecibo.FieldByName('DESCRIPCION').AsString;
    vReciboDet.BANCO := QRecibo.FieldByName('BANCO').AsString;
    vReciboDet.CHEQUE := QRecibo.FieldByName('CHEQUE').AsString;
    vReciboDet.CONCEPTO_PAGO := QRecibo.FieldByName('CONCEPTO_PAGO').AsInteger;
    vReciboDet.DEPTO := QRecibo.FieldByName('DPTO').AsInteger;
    vReciboDet.CCOST := QRecibo.FieldByName('CCOST').AsInteger;
    vReciboDet.ACTIVIDAD := QRecibo.FieldByName('ACTIVIDAD').AsString;
    vReciboDet.PROYECTO := QRecibo.FieldByName('PROYECTO').AsString;

    if vReciboDet.CONCEPTO_PAGO <> 0 then
    begin
      vReciboDet.VALOR := QRecibo.FieldByName('Debit').AsFloat;
    end
    else
    begin
      vReciboDet.VALOR := QRecibo.FieldByName('VALOR').AsFloat;
    end;
    vReciboDet.FECHA_CONSIG := FormatDateTime('MM/DD/YYYY',
      QRecibo.FieldByName('FECHA_CONSIG').AsDateTime);
    vRecibo.ReciboCajaDet.Add(vReciboDet);
    QRecibo.Next;
  end;

  Result := vRecibo;
end;

function TWebsMetodos.TraeTercero(pNit: String): TTercero;
var
  vTercero: TTercero;
begin
  QTercero.Close;
  QTercero.ParamByName('ID_N').AsString := pNit;
  QTercero.Open;
  Result := DataSetATercero(QTercero);
end;

function TWebsMetodos.TraeTotalCartera: TList<TCartera>;
var
  vCartera: TList<TCartera>;
begin
  QCarteraTotal.Close;
  QCarteraTotal.Open;
  vCartera := TList<TCartera>.Create;
  QCarteraTotal.DisableControls;
  QCarteraTotal.First;
  while not QCarteraTotal.Eof do
  begin
    if Round(QCarteraTotal.FieldByName('Saldo').AsFloat) <> 0 then
      vCartera.Add(DataSetACartera(QCarteraTotal));
    QCarteraTotal.Next;
  end;
  QCarteraTotal.Close;
  Result := vCartera;
end;

function TWebsMetodos.TraeUnidades(pItem: String; pBodega: String)
  : TObjectList<TUnidades>;
var
  vQ: TFDQuery;
  vUnidades: TUnidades;
begin
  try

    vQ := TFDQuery.Create(nil);
    vQ.Connection := DBPPal;
    vQ.Close;
    vQ.SQl.Add
      (' SELECT I.ITEM,I.LOCATION ,SUM(I.QTY) CANTIDAD FROM ITEMACT I WHERE ITEM =:ITEM AND'
      + ' LOCATION IN(' + pBodega + ')' + ' GROUP BY I.ITEM,I.LOCATION');
    vQ.ParamByName('ITEM').AsString := pItem;
    vQ.Open;
    Result := TObjectList<TUnidades>.Create;
    vQ.First;
    while not vQ.Eof do
    begin
      vUnidades := TUnidades.Create;
      vUnidades.ITEM := vQ.FieldByName('ITEM').AsString;
      vUnidades.BODEGA := vQ.FieldByName('LOCATION').AsInteger;
      vUnidades.CANTIDAD := vQ.FieldByName('CANTIDAD').AsFloat;
      Result.Add(vUnidades);
      vQ.Next;
    end;
  finally
    vQ.DisposeOf;
  end;
end;

function TWebsMetodos.UpdateCreaFactura(pFactura: TFactura)
  : TResultadoFactura;
begin
  Result := CreaFactura(pFactura);
end;



function TWebsMetodos.UpdateCreaRecibo(pRecibo: TReciboCaja)
  : TResultadoRecibo;
begin
  Result := CreaRecibo(pRecibo);
end;

function TWebsMetodos.UpdateCreaTercero(pTercero: TTercero)
  : TResultadoTercero;
begin
  Result := CreaTercero(pTercero);
end;

end.
