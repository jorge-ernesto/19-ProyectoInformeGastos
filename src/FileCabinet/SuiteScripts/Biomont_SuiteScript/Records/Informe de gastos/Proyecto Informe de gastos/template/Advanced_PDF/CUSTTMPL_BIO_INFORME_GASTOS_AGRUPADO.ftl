<#setting locale="es_PE">
<#if record.expensereportcurrency=="Soles">
    <#assign symbol="S/">
<#else>
    <#assign symbol="$">
</#if>
<?xml version="1.0"?>
<!DOCTYPE pdf PUBLIC "-//big.faceless.org//report" "report-1.1.dtd">
<pdf>
<head>
	<link name="NotoSans" type="font" subtype="truetype" src="${nsfont.NotoSans_Regular}" src-bold="${nsfont.NotoSans_Bold}" src-italic="${nsfont.NotoSans_Italic}" src-bolditalic="${nsfont.NotoSans_BoldItalic}" bytes="2" />
	<#if .locale == "zh_CN">
		<link name="NotoSansCJKsc" type="font" subtype="opentype" src="${nsfont.NotoSansCJKsc_Regular}" src-bold="${nsfont.NotoSansCJKsc_Bold}" bytes="2" />
	<#elseif .locale == "zh_TW">
		<link name="NotoSansCJKtc" type="font" subtype="opentype" src="${nsfont.NotoSansCJKtc_Regular}" src-bold="${nsfont.NotoSansCJKtc_Bold}" bytes="2" />
	<#elseif .locale == "ja_JP">
		<link name="NotoSansCJKjp" type="font" subtype="opentype" src="${nsfont.NotoSansCJKjp_Regular}" src-bold="${nsfont.NotoSansCJKjp_Bold}" bytes="2" />
	<#elseif .locale == "ko_KR">
		<link name="NotoSansCJKkr" type="font" subtype="opentype" src="${nsfont.NotoSansCJKkr_Regular}" src-bold="${nsfont.NotoSansCJKkr_Bold}" bytes="2" />
	<#elseif .locale == "th_TH">
		<link name="NotoSansThai" type="font" subtype="opentype" src="${nsfont.NotoSansThai_Regular}" src-bold="${nsfont.NotoSansThai_Bold}" bytes="2" />
	</#if>
    <macrolist>
        <macro id="nlheader">
            <table class="header" style="width: 100%;">
                <tr>
                    <td rowspan="3"><#if companyInformation.logoUrl?length != 0><@filecabinet nstype="image" src="${companyInformation.logoUrl}" style="float: left; margin: 7px" /> </#if><span class="nameandaddress">${companyInformation.companyName}</span><br /><span class="nameandaddress">${companyInformation.addressText}</span></td>
                    <td align="right"><span class="title">${record@title}</span></td>
                </tr>
                <tr>
                    <td align="right"><span class="number">#${record.tranid}</span></td>
                </tr>
                <tr>
                    <td align="right">${record.trandate}</td>
                </tr>
            </table>
        </macro>
        <macro id="nlfooter">
            <table class="footer" style="width: 100%;">
                <tr>
                    <td align="right"><pagenumber/> of <totalpages/>
                    </td>
                </tr>
            </table>
        </macro>
    </macrolist>
    <style type="text/css">
		* {
		<#if .locale == "zh_CN">
			font-family: NotoSans, NotoSansCJKsc, sans-serif;
		<#elseif .locale == "zh_TW">
			font-family: NotoSans, NotoSansCJKtc, sans-serif;
		<#elseif .locale == "ja_JP">
			font-family: NotoSans, NotoSansCJKjp, sans-serif;
		<#elseif .locale == "ko_KR">
			font-family: NotoSans, NotoSansCJKkr, sans-serif;
		<#elseif .locale == "th_TH">
			font-family: NotoSans, NotoSansThai, sans-serif;
		<#else>
			font-family: NotoSans, sans-serif;
		</#if>
		}
		table {
			font-size: 9pt;
			table-layout: fixed;
		}
        th {
            font-weight: bold;
            font-size: 8pt;
            vertical-align: middle;
            padding: 5px 6px 3px;
            background-color: #e3e3e3;
            color: #333333;
        }
        td {
            padding: 4px 6px;
        }
		td p { align:left }
        b {
            font-weight: bold;
            color: #333333;
        }
        table.header td {
            padding: 0;
            font-size: 10pt;
        }
        table.footer td {
            padding: 0;
            font-size: 8pt;
        }
        table.itemtable th {
            padding-bottom: 10px;
            padding-top: 10px;
        }
        table.body td {
            padding-top: 2px;
        }
        table.total {
            page-break-inside: avoid;
            table-layout: auto;
            margin-top: 10px;
        }
        tr.totalrow td {
            background-color: #e3e3e3;
            padding-top: 10px;
            padding-bottom: 10px;
        }
        tr.totalrow td.next {
            padding-top: 0;
        }
        td.totalboxtop {
            font-size: 12pt;
            background-color: #e3e3e3;
        }
        td.addressheader {
            font-size: 8pt;
            padding-top: 6px;
            padding-bottom: 2px;
        }
        td.address {
            padding-top: 0;
        }
        td.totalboxmid {
            font-size: 28pt;
            padding-top: 20px;
            background-color: #e3e3e3;
        }
        td.totalboxbot {
            background-color: #e3e3e3;
            font-weight: bold;
        }
        span.title {
            font-size: 28pt;
        }
        span.number {
            font-size: 16pt;
        }
        hr {
            width: 100%;
            color: #d3d3d3;
            background-color: #d3d3d3;
            height: 1px;
        }
        .signatures {
            page-break-inside: avoid;
            margin-top: 40px;
        }
        .signhere {
            border-bottom: 1px solid #d3d3d3;
            height: 15px;
        }</style>
</head>
<body header="nlheader" header-height="10%" footer="nlfooter" footer-height="20pt" padding="0.5in 0.5in 0.5in 0.5in" size="Letter">
    <table style="width: 100%; margin-top: 10px;">
        <tr>
            <td class="addressheader" colspan="3"><b>${record.billaddress@label}</b></td>
            <td class="addressheader" colspan="3"><b>${record.shipaddress@label}</b></td>
            <td class="totalboxtop" colspan="5"><b>${record.total@label?upper_case}</b></td>
        </tr>
        <tr>
            <td class="address" colspan="3" rowspan="3">${record.billaddress}</td>
            <td class="address" colspan="3" rowspan="3">${record.shipaddress}</td>
            <td align="right" class="totalboxmid" colspan="5">${record.total}</td>
        </tr>
        <tr>
            <td align="right" class="totalboxbot" colspan="5"><b>${record.duedate@label}:</b> ${record.duedate}</td>
        </tr>
        <#if record.expensereportcurrency?has_content>
            <tr>
                <td align="right" class="totalboxbot" colspan="5"><b>${record.expensereportcurrency@label}:</b> ${record.expensereportcurrency}</td>
            </tr>
        </#if>
    </table>
    <table class="body" style="width: 100%; margin-top: 10px;">
        <tr>
            <th>${record.entity@label}</th>
            <th>${record.duedate@label}</th>
            <th>${record.otherrefnum@label}</th>
            <th>${record.memo@label}</th>
        </tr>
        <tr>
            <td>${record.entity}</td>
            <td>${record.duedate}</td>
            <td>${record.otherrefnum}</td>
            <td>${record.memo}</td>
        </tr>
    </table>
    <#if record.expense?has_content>
    <#assign expense_grossamt_total = 0>
    <table class="itemtable" style="width: 100%; margin-top: 10px;"><!-- start expenses -->
        <#list record.expense as expense>
            <#if expense_index==0>
                <thead>
                <tr>
                    <th colspan="12">Categoría</th>
                    <th align="right" colspan="4">Importe</th>
                </tr>
                </thead>
                <tr>
                    <td colspan="16"><b>Reimbursable Expenses</b></td>
                </tr>
            </#if>
            <#if ((expense.isnonreimbursable?is_boolean && !expense.isnonreimbursable) || (expense.isnonreimbursable?is_string && expense.isnonreimbursable = "F")) && ((expense.corporatecreditcard?is_boolean && !expense.corporatecreditcard) || (expense.corporatecreditcard?is_string && expense.corporatecreditcard = "F"))>

                <!-- DEBUG -->
                <!-- <tr> -->
                    <!-- <td colspan="12">${expense_index}</td> -->
                    <!-- <td colspan="12">${expense_index + 1}</td> -->
                    <!-- <td colspan="12">${record.expense?size}</td> -->
					<!-- <td colspan="12">${expense.category}</td> -->
					<!-- <td align="right" colspan="4">${expense.grossamt}</td> -->
				<!-- </tr> -->
                <!-- CERRAR -->

                <!-- REQUERIMIENTO CONTABILIDAD - AGRUPAR CUENTAS CONTABLES -->
                <#assign expense_grossamt_total = expense_grossamt_total + expense.grossamt> <!-- Acumular totales -->

                <#if (expense_index + 1 != record.expense?size)> <!-- Validar que no es el ultimo registro -->
                    <#if (expense.category != record.expense[expense_index + 1].category)> <!-- Si es el ultimo registro, hay un error pq se intenta acceder a un index que no existe -->
                        <tr>
                            <td colspan="12">${expense.category}</td>
                            <td align="right" colspan="4">${symbol}${expense_grossamt_total?string("#,##0.00")}</td>
                        </tr>
                        <#assign expense_grossamt_total = 0>
                    </#if>
                </#if>

                <#if (expense_index + 1 == record.expense?size)> <!-- Validar que es el ultimo registro -->
                    <tr>
                        <td colspan="12">${expense.category}</td>
                        <td align="right" colspan="4">${symbol}${expense_grossamt_total?string("#,##0.00")}</td>
                    </tr>
                    <#assign expense_grossamt_total = 0>
                </#if>
                <!-- CERRAR -->

            </#if>
        </#list>
		<#list record.expense as expense>
			<#if expense_index==0>
                <tr>
					<td colspan="16"><b>Credit Card Expenses</b></td>
				</tr>
			</#if>
			<#if ((expense.corporatecreditcard?is_boolean && expense.corporatecreditcard) || (expense.corporatecreditcard?is_string && expense.corporatecreditcard = "T"))>
                <tr>
					<td colspan="12">${expense.category}</td>
					<td align="right" colspan="4">${symbol}${expense.grossamt?string("#,##0.00")}</td>
				</tr>
			</#if>
		</#list><!-- end expenses -->
        <#list record.expense as expense>
            <#if expense_index==0>
                <tr>
                    <td colspan="16"><b>Non-reimbursable Expenses</b></td>
                </tr>
            </#if>
            <#if ((expense.isnonreimbursable?is_boolean && expense.isnonreimbursable) || (expense.isnonreimbursable?is_string && expense.isnonreimbursable = "T"))>
                <tr>
                    <td colspan="12">${expense.category}</td>
                    <td align="right" colspan="4">${symbol}${expense.grossamt?string("#,##0.00")}</td>
                </tr>
            </#if>
        </#list><!-- end expenses -->
    </table>
    <hr />
    </#if>
    <table class="total" align="right">
        <tr>
            <td align="right"><b>Importe Depositado</b></td>
            <td align="right">${record.custbody171}</td>
        </tr>
        <tr class="totalrow">
            <td align="right"><b>${record.total@label}</b></td>
            <td align="right">${record.total}</td>
        </tr>
        <tr class="totalrow">
            <td align="right"><b>(+) Devolución/(-) Reembolso</b></td>
            <td align="right">${record.custbody_bio_cam_infgast_excedente}</td>
        </tr>
    </table>
    <hr />
    <table class="total" align="left">
        <tr><td><b>Datos de Devolución</b></td></tr>
        <tr class="totalrow">
            <td align="right"><b>Banco</b></td>
            <td align="right">${record.custbody_bio_cam_infgast_banco}</td>
        </tr>
        <tr class="totalrow">
            <td align="right"><b>Fecha Devolución</b></td>
            <td align="right">${record.custbody_bio_cam_infgast_fecha_dev}</td>
        </tr>
        <tr class="totalrow">
            <td align="right"><b>Num. Operación</b></td>
            <td align="right">${record.custbody_bio_cam_infgast_numoper}</td>
        </tr>
    </table>
    <hr />
</body>
</pdf>