// Notas del archivo:
// - Secuencia de comando:
//      - Biomont UE Proy Inf Gtos (customscript_bio_ue_proy_inf_gtos)
// - Registro:
//      - Informe de gastos (expensereport)
// - Contexto de Localizacion:
//      - Peru

// Validación como la usa LatamReady:
// - ClientScript                   : No se ejecuta en modo ver. Solo se ejecuta en modo crear, copiar o editar.
// - En modo crear, copiar o editar : Validamos por el formulario.
// - En modo ver                    : Validamos por el pais de la subsidiaria.

/**
 * @NApiVersion 2.1
 * @NScriptType UserEventScript
 */
define(['./lib/Bio.Library.Helper', 'N'],

    function (objHelper, N) {

        const { log } = N;

        /**
         * Formularios
         *
         * 259: BIO_FRM_INFORME_GASTOS
         * 156: Informe de gastos estándar 2
         */
        const forms = [259, 156];

        /******************/

        /**
         * Defines the function definition that is executed before record is loaded.
         * @param {Object} scriptContext
         * @param {Record} scriptContext.newRecord - New record
         * @param {string} scriptContext.type - Trigger type; use values from the context.UserEventType enum
         * @param {Form} scriptContext.form - Current form
         * @param {ServletRequest} scriptContext.request - HTTP request information sent from the browser for a client action only.
         * @since 2015.2
         */
        function beforeLoad(scriptContext) {

            // Obtener el newRecord y type
            let { newRecord, type } = scriptContext;

            // Obtener datos
            let form_id = newRecord.getValue('customform') || null;
            let subsidiary_id = newRecord.getValue('subsidiary') || null;
            let country_subsidiary_id = subsidiary_id ? objHelper.getCountrySubsidiary(subsidiary_id) : null;

            // Modo ver y pais de subsidiaria "PE"
            if (type == 'view' && country_subsidiary_id == 'PE') {

                cargarPagina(scriptContext);
            }
        }

        function printHTMLSelect() {

            let html = `
                <!-- Crear select -->
                <select id='selectPrint'>
                    <option value='0'>-Seleccione-</option>
                    <option value='31'>Informe de gastos estandar</option>
                    <option value='129'>Informe de gastos cuentas agrupadas</option>
                    <option value='130'>Informe de gastos planilla movilidad</option>
                </select>

                <script>
                    require(['N/currentRecord', 'N/url'], function (currentRecord, url) {

                        function descargarPDF(value) {

                            let scriptDownloadId = 'customscript_bio_sl_proy_inf_gtos_des_ar';
                            let deployDownloadId = 'customdeploy_bio_sl_proy_inf_gtos_des_ar';

                            // Obtener el id interno del record proyecto
                            let recordContext = currentRecord.get();
                            let expensereport_id = recordContext.getValue('id');

                            // Obtener url del Suitelet mediante ID del Script y ID del Despliegue
                            let suitelet = url.resolveScript({
                                deploymentId: deployDownloadId,
                                scriptId: scriptDownloadId,
                                params: {
                                    _button: 'advanced_pdf',
                                    _expensereport_id: expensereport_id,
                                    _templatepdf_id: value
                                }
                            });

                            // Evitar que aparezca el mensaje 'Estas seguro que deseas salir de la pantalla'
                            setWindowChanged(window, false);

                            // Abrir url
                            window.open(suitelet);
                        }

                        // Setear propiedades a elemento select
                        let select = document.getElementById('selectPrint')
                        select.onchange = function () {
                            if (select.value != '0') descargarPDF(select.value);
                        };
                    });
                </script>
            `;

            return html;
        }

        function cargarPagina(scriptContext) {

            let form = scriptContext.form;

            let labelField = form.addField({
                id: 'custpage_field_html_label_print',
                label: 'Seleccione el formato de impresión',
                type: 'label'
            });

            let htmlField = form.addField({
                id: 'custpage_field_html_select_print',
                label: ' ',
                type: 'inlinehtml'
            });

            form.insertField({
                field: labelField,
                nextfield: 'tranid'
            });

            form.insertField({
                field: htmlField,
                nextfield: 'tranid'
            });

            htmlField.defaultValue = printHTMLSelect();
        }

        return { beforeLoad };

    });
