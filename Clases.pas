{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit Clases;

interface

uses Generics.Collections, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TConsecutivo = class
    FConexion: TFDConnection;

  public
    class function GetConsecutivo(pConexion: TFDConnection; pPrefijo: String)
      : Integer; static;
    class function IncrementaConsecutivo(pConexion: TFDConnection;
      pPrefijo: String): Integer; static;

  end;

type
  TOrden = class
  private
    FE: String;
    FNUMBER: Integer;
    FS: String;
    FTIPO: String;
    FID_N: String;
    FFECHA: String;
    FACCT: Double;
    FESTADO: String;
    FDUEDATE: String;
    FTOTAL: Double;
    FFECHA_PAGO: String;
    FTOTALDCT: Double;
    FSUBTOTAL: Double;
    FTOTALIVA: Double;
    FID_N_SOLICITANTE: String;
    FVALORRTICA: Double;
    FFECHA_REQUISICION: String;
  public
    property E: String read FE write FE;
    property S: String read FS write FS;
    property TIPO: String read FTIPO write FTIPO;
    property NUMBER: Integer read FNUMBER write FNUMBER;
    property ID_N: String read FID_N write FID_N;
    property ACCT: Double read FACCT write FACCT;
    property FECHA: String read FFECHA write FFECHA;
    property ESTADO: String read FESTADO write FESTADO;
    property DUEDATE: String read FDUEDATE write FDUEDATE;
    property TOTAL: Double read FTOTAL write FTOTAL;
    property FECHA_PAGO: String read FFECHA_PAGO write FFECHA_PAGO;
    property TOTALDCT: Double read FTOTALDCT write FTOTALDCT;
    property TOTALIVA: Double read FTOTALIVA write FTOTALIVA;
    property SUBTOTAL: Double read FSUBTOTAL write FSUBTOTAL;
    property ID_N_SOLICITANTE: String read FID_N_SOLICITANTE
      write FID_N_SOLICITANTE;
    property VALORRTICA: Double read FVALORRTICA write FVALORRTICA;
    property FECHA_REQUISICION: String read FFECHA_REQUISICION
      write FFECHA_REQUISICION;
  end;

type
  TOrdenDet = class
  private
    FLOCATION: Integer;
    FQTY: Double;
    FE: String;
    FITEM: String;
    FNUMBER: Integer;
    FS: String;
    FTIPO: String;
    FRECIBIDO: Double;
    FCOST: Double;
    FPRICEPROV: Double;
    FPORC_IVA: Integer;

  public

    property E: String read FE write FE;
    property S: String read FS write FS;
    property TIPO: String read FTIPO write FTIPO;
    property NUMBER: Integer read FNUMBER write FNUMBER;
    property ITEM: String read FITEM write FITEM;
    property LOCATION: Integer read FLOCATION write FLOCATION;
    property QTY: Double read FQTY write FQTY;
    property RECIBIDO: Double read FRECIBIDO write FRECIBIDO;
    property COST: Double read FCOST write FCOST;
    property PORC_IVA: Integer read FPORC_IVA write FPORC_IVA;
    property PRICEPROV: Double read FPRICEPROV write FPRICEPROV;
    constructor Create(AOwner: TObject);
  end;

type
  TCartera = class
  private
    FTIPO: String;
    FBATCH: Integer;
    FFECHA: String;
    FDUEDATE: String;
    FDIAS_VENCIMIENTO: Integer;
    FSALDO: Double;
    FID_N: String;
    FSALDO_US: Double;
  public
    property ID_N: String read FID_N write FID_N;
    property TIPO: String read FTIPO write FTIPO;
    property BATCH: Integer read FBATCH write FBATCH;
    property FECHA: String read FFECHA write FFECHA;
    property DUEDATE: String read FDUEDATE write FDUEDATE;
    property DIAS_VENCIMIENTO: Integer read FDIAS_VENCIMIENTO
      write FDIAS_VENCIMIENTO;
    property SALDO: Double read FSALDO write FSALDO;
    property SALDO_US: Double read FSALDO_US write FSALDO_US;
  end;

type
  TTercero = class
  private
    FTIPORETEICA: String;
    FCREDITLMT: Double;
    FCV: Integer;
    FRETEICA: String;
    FEMAIL: String;
    FDIAS_GRACIA: Integer;
    FID_N: String;
    FFECHA_CREACION: String;
    FIDVEND: Integer;
    FRETIVA: String;
    FRETENEDOR: String;
    FPHONE1: String;
    FCOMPANY: String;
    FDCTADICIONAL: String;
    FDESCUENTO: Double;
    FCLIENTE: String;
    FAUTORET: String;
    FCOMPANY_EXTENDIDO: String;
    FRETIVA_PROV: String;
    FGRAVABLE: String;
    FVENDEDOR: String;
    FPROVEEDOR: String;
    FNIVEL: String;
    FCARGO1: String;
    FDEPARTAMENTO: String;
    FCONTACT1: String;
    FADDR1: String;
    FEXT1: String;
    FICAIN: String;
    FCITY: String;
    FEMPLEADO: String;
    FOTRO: String;
    FCREDITO: String;
    FPAIS: String;
    FVersion: Integer;
    FTERMS: Integer;
  public
    property ID_N: String read FID_N write FID_N;
    property COMPANY: String read FCOMPANY write FCOMPANY;
    property COMPANY_EXTENDIDO: String read FCOMPANY_EXTENDIDO
      write FCOMPANY_EXTENDIDO;
    property ADDR1: String read FADDR1 write FADDR1;
    property CITY: String read FCITY write FCITY;
    property DEPARTAMENTO: String read FDEPARTAMENTO write FDEPARTAMENTO;
    property PAIS: String read FPAIS write FPAIS;
    property CONTACT1: String read FCONTACT1 write FCONTACT1;
    property CARGO1: String read FCARGO1 write FCARGO1;
    property PHONE1: String read FPHONE1 write FPHONE1;
    property EXT1: String read FEXT1 write FEXT1;
    property GRAVABLE: String read FGRAVABLE write FGRAVABLE;
    property RETENEDOR: String read FRETENEDOR write FRETENEDOR;
    property CREDITLMT: Double read FCREDITLMT write FCREDITLMT;
    property NIVEL: String read FNIVEL write FNIVEL;
    property RETIVA: String read FRETIVA write FRETIVA;
    property AUTORET: String read FAUTORET write FAUTORET;
    property CREDITO: String read FCREDITO write FCREDITO;
    property CLIENTE: String read FCLIENTE write FCLIENTE;
    property PROVEEDOR: String read FPROVEEDOR write FPROVEEDOR;
    property OTRO: String read FOTRO write FOTRO;
    property EMPLEADO: String read FEMPLEADO write FEMPLEADO;
    property VENDEDOR: String read FVENDEDOR write FVENDEDOR;
    property ICAIN: String read FICAIN write FICAIN;
    property RETEICA: String read FRETEICA write FRETEICA;
    property IDVEND: Integer read FIDVEND write FIDVEND;
    property DESCUENTO: Double read FDESCUENTO write FDESCUENTO;
    property CV: Integer read FCV write FCV;
    property FECHA_CREACION: String read FFECHA_CREACION write FFECHA_CREACION;
    property EMAIL: String read FEMAIL write FEMAIL;
    property TIPORETEICA: String read FTIPORETEICA write FTIPORETEICA;
    property DCTADICIONAL: String read FDCTADICIONAL write FDCTADICIONAL;
    property DIAS_GRACIA: Integer read FDIAS_GRACIA write FDIAS_GRACIA;
    property RETIVA_PROV: String read FRETIVA_PROV write FRETIVA_PROV;
    property Version: Integer read FVersion write FVersion;
    property CONCEPTO: Integer read FTERMS write FTERMS;
  end;

type
  TProducto = class
  private
    FKITLEVEL: String;
    FPRICE3: Double;
    FUOFMSALES: String;
    FDCTFIJO: Double;
    FPRICE1: Double;
    FPRICE4: Double;
    FTIPO_FACTOR: String;
    FITEMMSTR: String;
    FNOTAS: String;
    FPRICE5: Double;
    FIVA: Integer;
    FPRICE: Double;
    FDESC_MAXP: Double;
    FDCTADICIONAL: Double;
    FMAXIMO: Double;
    FCCOSTO: Integer;
    FCOD_BARRAS: String;
    FMODELO: String;
    FPRECIOIVA: Double;
    FITEM: String;
    FFACTOR: Double;
    FDEPTO: Integer;
    FREFFABRICA: String;
    FMINIMO: Double;
    FUOFMORDERS: String;
    FMARCA: String;
    FSUBGRUPO: String;
    FTIPO: String;
    FGRUPO: String;
    FDESCRIPCION: String;
    FPRICE2: Double;
    FVersion: Integer;
  public
    property ITEM: String read FITEM write FITEM;
    property DESCRIPCION: String read FDESCRIPCION write FDESCRIPCION;
    property ITEMMSTR: String read FITEMMSTR write FITEMMSTR;
    property GRUPO: String read FGRUPO write FGRUPO;
    property SUBGRUPO: String read FSUBGRUPO write FSUBGRUPO;
    property CCOSTO: Integer read FCCOSTO write FCCOSTO;
    property DEPTO: Integer read FDEPTO write FDEPTO;
    property UOFMSALES: String read FUOFMSALES write FUOFMSALES;
    property UOFMORDERS: String read FUOFMORDERS write FUOFMORDERS;
    property FACTOR: Double read FFACTOR write FFACTOR;
    property TIPO_FACTOR: String read FTIPO_FACTOR write FTIPO_FACTOR;
    property PRICE: Double read FPRICE write FPRICE;
    property PRICE1: Double read FPRICE1 write FPRICE1;
    property PRICE2: Double read FPRICE2 write FPRICE2;
    property PRICE3: Double read FPRICE3 write FPRICE3;
    property PRICE4: Double read FPRICE4 write FPRICE4;
    property PRICE5: Double read FPRICE5 write FPRICE5;
    property PRECIOIVA: Double read FPRECIOIVA write FPRECIOIVA;
    property IVA: Integer read FIVA write FIVA;
    property DCTADICIONAL: Double read FDCTADICIONAL write FDCTADICIONAL;
    property DCTFIJO: Double read FDCTFIJO write FDCTFIJO;
    property MINIMO: Double read FMINIMO write FMINIMO;
    property MAXIMO: Double read FMAXIMO write FMAXIMO;
    property KITLEVEL: String read FKITLEVEL write FKITLEVEL;
    property NOTAS: String read FNOTAS write FNOTAS;
    property TIPO: String read FTIPO write FTIPO;
    property MARCA: String read FMARCA write FMARCA;
    property MODELO: String read FMODELO write FMODELO;
    property DESC_MAXP: Double read FDESC_MAXP write FDESC_MAXP;
    property COD_BARRAS: String read FCOD_BARRAS write FCOD_BARRAS;
    property REFFABRICA: String read FREFFABRICA write FREFFABRICA;
    property Version: Integer read FVersion write FVersion;
  end;

  type
  TUnidades = class
  private
    FITEM: String;
    FBODEGA: Integer;
    FCANTIDAD: Double;
  public
    property ITEM: String read FITEM write FITEM;
    property BODEGA: Integer read FBODEGA write FBODEGA;
    property CANTIDAD: Double read FCANTIDAD write FCANTIDAD;
  end;

type
  TCurva = class
  private
    FCOD_TALLA: String;
    FCOD_CURVA: String;
    FITEM: String;
    FCOD_COLOR: String;
    FCODBARRASCURVA: String;
  public
    property COD_CURVA: String read FCOD_CURVA write FCOD_CURVA;
    property COD_COLOR: String read FCOD_COLOR write FCOD_COLOR;
    property COD_TALLA: String read FCOD_TALLA write FCOD_TALLA;
    property ITEM: String read FITEM write FITEM;
    property CODBARRASCURVA: String read FCODBARRASCURVA write FCODBARRASCURVA;
  end;

type
  TSaldoFactura = class
  private
    FSALDO_FV: Double;
    FTIPO_FV: String;
    FBATCH_FV: Integer;
  public
    property TIPO_FV: String read FTIPO_FV write FTIPO_FV;
    property BATCH_FV: Integer read FBATCH_FV write FBATCH_FV;
    property SALDO_FV: Double read FSALDO_FV write FSALDO_FV;
  end;

type
  TResultadoPedido = class
  private
    FTIPO_PE: String;
    FBATCH_PE: Double;
  public
    property TIPO_PE: String read FTIPO_PE write FTIPO_PE;
    property BATCH_PE: Double read FBATCH_PE write FBATCH_PE;
  end;

type
  TResultadoFactura = class
  private
    FTIPO_FV: String;
    FBATCH_FV: Double;
  public
    property TIPO_FV: String read FTIPO_FV write FTIPO_FV;
    property BATCH_FV: Double read FBATCH_FV write FBATCH_FV;
  end;

type
  TResultadoTercero = class

  private
    FExitoso: Boolean;
    FMensaje: String;
  public
    property Exitoso: Boolean read FExitoso write FExitoso;
    property Mensaje: String read FMensaje write FMensaje;
  end;

type
  TResultadoRecibo = class
  private
    FTIPO: String;
    FBATCH: Integer;
    FSaldoFacturas: TList<TSaldoFactura>;
  public
    property TIPO_RC: String read FTIPO write FTIPO;
    property BATCH_RC: Integer read FBATCH write FBATCH;
    property SaldoFacturas: TList<TSaldoFactura> read FSaldoFacturas
      write FSaldoFacturas;

    constructor Create;
  end;

type
  TFacturaDet = class
  private
    FITEM: String;
    FDPTO: Integer;
    FIVA: Integer;
    FPRICE: Double;
    FCCOST: Integer;
    FNOTES: String;
    FQTYSHIP: Double;
    FCODBARRASCURVA: String;
    FPROY: String;
    FACTIV: String;
    FVLR_IVA: Double;

  public
   property VLR_IVA: Double read FVLR_IVA write FVLR_IVA;
    property ITEM: String read FITEM write FITEM;
    property IVA: Integer read FIVA write FIVA;
    property QTYSHIP: Double read FQTYSHIP write FQTYSHIP;
    property PRICE: Double read FPRICE write FPRICE;
    property NOTES: String read FNOTES write FNOTES;
    property DPTO: Integer read FDPTO write FDPTO;
    property CCOST: Integer read FCCOST write FCCOST;
    property CODBARRASCURVA: String read FCODBARRASCURVA write FCODBARRASCURVA;
    property PROY: String read FPROY write FPROY;
    property ACTIV: String read FACTIV write FACTIV;
  end;

type

  TFactura = class
  private
    FTIPO: String;
    FID_N: String;
    FFECHA: String;
    FSUBTOTAL: Double;
    FBATCH: Integer;
    FSHIPTO: Integer;
    FVLR_IVA: Double;
    FFacturaDet: TObjectList<TFacturaDet>;
    FCONCEPTO_PAGO: Integer;
  public
    property TIPO: String read FTIPO write FTIPO;
    property BATCH: Integer read FBATCH write FBATCH;
    property ID_N: String read FID_N write FID_N;
    property FECHA: String read FFECHA write FFECHA;
    property SHIPTO: Integer read FSHIPTO write FSHIPTO;
    property SUBTOTAL: Double read FSUBTOTAL write FSUBTOTAL;
    property VLR_IVA: Double read FVLR_IVA write FVLR_IVA;
    property CONCEPTO_PAGO: Integer read FCONCEPTO_PAGO write FCONCEPTO_PAGO;
    property FacturaDet: TObjectList<TFacturaDet> read FFacturaDet
      write FFacturaDet;
    constructor Create;
  end;

type
  TConfigWS = class
  private
    FCodigo: Integer;
    FNombre: String;
    FValor_String: String;
    FValor_Entero: Integer;
    FValor_Float: Double;
    FValor_Fecha: TDate;
    FValor_Hora: TTime;
    FValor_Blob: String;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nombre: String read FNombre write FNombre;
    property Valor_String: String read FValor_String write FValor_String;
    property Valor_Entero: Integer read FValor_Entero write FValor_Entero;
    property Valor_Float: Double read FValor_Float write FValor_Float;
    property Valor_Fecha: TDate read FValor_Fecha write FValor_Fecha;
    property Valor_Hora: TTime read FValor_Hora write FValor_Hora;
    property Valor_Blob: String read FValor_Blob write FValor_Blob;
  end;

type
  TReciboCajaDet = class
  private
    FBANCO: String;
    FVALOR: Double;
    FCONCEPTO_PAGO: Integer;
    FNUMERO_FV: String;
    FFECHA_CONSIG: String;
    FTIPO_FV: String;
    FCHEQUE: String;
    FDESCRIPCION: String;
    FCCOST: Integer;
    FACTIVIDAD: String;
    FDEPTO: Integer;
    FPROYECTO: String;
  public
    property TIPO_FV: String read FTIPO_FV write FTIPO_FV;
    property NUMERO_FV: String read FNUMERO_FV write FNUMERO_FV;
    property DESCRIPCION: String read FDESCRIPCION write FDESCRIPCION;
    property BANCO: String read FBANCO write FBANCO;
    property CHEQUE: String read FCHEQUE write FCHEQUE;
    property CONCEPTO_PAGO: Integer read FCONCEPTO_PAGO write FCONCEPTO_PAGO;
    property FECHA_CONSIG: String read FFECHA_CONSIG write FFECHA_CONSIG;
    property VALOR: Double read FVALOR write FVALOR;
    property DEPTO: Integer read FDEPTO write FDEPTO;
    property CCOST: Integer read FCCOST write FCCOST;
    property ACTIVIDAD: String read FACTIVIDAD write FACTIVIDAD;
    property PROYECTO: String read FPROYECTO write FPROYECTO;
  end;

type
  TReciboCaja = class
  private
    FTIPO: String;
    FBATCH: Integer;
    FOBSERV: String;
    FID_N: String;
    FFECHA: String;
    FSHIPTO: Integer;
    FUSERNAME: String;
    FReciboCajaDet: TList<TReciboCajaDet>;
  public
    property TIPO: String read FTIPO write FTIPO;
    property BATCH: Integer read FBATCH write FBATCH;
    property ID_N: String read FID_N write FID_N;
    property FECHA: String read FFECHA write FFECHA;
    property USERNAME: String read FUSERNAME write FUSERNAME;
    property OBSERV: String read FOBSERV write FOBSERV;
    property SHIPTO: Integer read FSHIPTO write FSHIPTO;
    property ReciboCajaDet: TList<TReciboCajaDet> read FReciboCajaDet
      write FReciboCajaDet;
    constructor Create;
  end;

type
  TEntrada = class
  private
    FTIPO: String;
    FFECHA: String;
    FNumero: Integer;
    FITEM: String;
    FCodBarrasCurvas: String;
    FCantidad: Double;
    FPrecio: Double;
    FTercero: String;
  public
    property TIPO: String read FTIPO write FTIPO;
    property FECHA: String read FFECHA write FFECHA;
    property Numero: Integer read FNumero write FNumero;
    property ITEM: String read FITEM write FITEM;
    property CodBarrasCurvas: String read FCodBarrasCurvas
      write FCodBarrasCurvas;
    property Cantidad: Double read FCantidad write FCantidad;
    property Precio: Double read FPrecio write FPrecio;
    property Tercero: String read FTercero write FTercero;
  end;

function TraeConfigWS(pConexion: TFDConnection; pCodigo: Integer): TConfigWS;

implementation

{ TReciboCaja }

constructor TReciboCaja.Create;
begin
  FReciboCajaDet := TList<TReciboCajaDet>.Create;
end;

function TraeConfigWS(pConexion: TFDConnection; pCodigo: Integer): TConfigWS;
var
  vQ: TFDQuery;
begin
  vQ := TFDQuery.Create(nil);
  try
    vQ.Connection := pConexion;
    vQ.Open('select CODIGO, NOMBRE, VALOR_STRING, VALOR_ENTERO, VALOR_FLOAT, VALOR_FECHA,'
      + 'VALOR_HORA from CONFIG_WS where CODIGO = :CODIGO', [pCodigo],
      [TFieldType.ftInteger]);
    Result := TConfigWS.Create;
    Result.Codigo := vQ.FieldByName('CODIGO').AsInteger;
    Result.Nombre := vQ.FieldByName('NOMBRE').AsString;
    Result.Valor_String := vQ.FieldByName('VALOR_STRING').AsString;
    Result.Valor_Entero := vQ.FieldByName('VALOR_ENTERO').AsInteger;
    Result.Valor_Float := vQ.FieldByName('VALOR_FLOAT').AsFloat;
    Result.Valor_Fecha := vQ.FieldByName('VALOR_FECHA').AsDateTime;
    Result.Valor_Hora := vQ.FieldByName('VALOR_HORA').AsDateTime;
  finally
    vQ.DisposeOf;
  end;
end;

{ TResultadoRecibo }
constructor TResultadoRecibo.Create;
begin
  FSaldoFacturas := TList<TSaldoFactura>.Create;
end;

{ TFactura }

constructor TFactura.Create;
begin
  FFacturaDet := TObjectList<TFacturaDet>.Create;
end;

{ TConsecutivo }

class function TConsecutivo.GetConsecutivo(pConexion: TFDConnection;
  pPrefijo: String): Integer;
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := pConexion;
  try
    vQuery.SQL.Add
      ('select consecutivo from tipdoc where trim(clase)=trim(:clase)');
    vQuery.ParamByName('clase').AsString := pPrefijo;
    vQuery.Open;
    Result := vQuery.Fields[0].AsInteger;
  finally
    vQuery.Free;
  end;
end;

class function TConsecutivo.IncrementaConsecutivo(pConexion: TFDConnection;
  pPrefijo: String): Integer;
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := pConexion;
  try
    vQuery.SQL.Add
      ('update tipdoc set consecutivo=consecutivo+1 where trim(clase)=trim(:clase)');
    vQuery.SQL.Add('returning consecutivo {into :consecutivo}');
    vQuery.ParamByName('clase').AsString := pPrefijo;
    vQuery.ExecSQL;
    Result := vQuery.ParamByName('consecutivo').AsInteger;
  finally
    vQuery.Free;
  end;
end;

{ TOrdenDet }

constructor TOrdenDet.Create(AOwner: TObject);
begin
  if AOwner.ClassType = TOrden then
  begin
    FTIPO := TOrden(AOwner).TIPO;
    FNUMBER := TOrden(AOwner).NUMBER;
  end;
end;



end.
