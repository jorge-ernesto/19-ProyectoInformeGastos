// Notas del archivo:
// - Secuencia de comando:
//      - Biomont SL Proy Inf Gtos Des Arc (customscript_bio_sl_proy_inf_gtos_des_ar)
// - URL:
//      - https://6462530.app.netsuite.com/app/site/hosting/scriptlet.nl?script=2169&deploy=1

/**
 * @NApiVersion 2.1
 * @NScriptType Suitelet
 */
define(['./lib/Bio.Library.Helper', 'N'],

    function (objHelper, N) {

        const { log, file, render, encode, record } = N;

        /**
         * Plantillas PDF/HTML avanzadas
         *
         * 31 (STDTMPLEXPREPT)                       : Standard Expense Report PDF/HTML Template
         * 129 (CUSTTMPL_BIO_INFORME_GASTOS_AGRUPADO): Standard Expense Report PDF/HTML Template - Cuentas Agrupadas
         * 130 (CUSTTMPLPLANILLA_MOVILIDAD)          : Standard Expense Report PDF/HTML Template 2
         */

        /******************/

        // Crear PDF
        function createAdvancedPDF(button, expensereport_id, templatepdf_id) {

            // render.TemplateRenderer
            // https://6462530.app.netsuite.com/app/help/helpcenter.nl?fid=section_4412065265.html

            // TemplateRenderer.setTemplateById(options)
            // https://6462530.app.netsuite.com/app/help/helpcenter.nl?fid=section_4528552999.html

            // TemplateRenderer.addRecord(options)
            // https://6462530.app.netsuite.com/app/help/helpcenter.nl?fid=section_456543212890.html

            // Template del archivo
            let templatePdfId = templatepdf_id;

            // Crear PDF - Contenido dinamico
            let rendererPDF = render.create();
            rendererPDF.setTemplateById(templatePdfId);

            // Enviar datos a PDF
            rendererPDF.addRecord('record', record.load({
                type: 'expensereport',
                id: expensereport_id
            }));

            // Crear PDF
            pdfFile = rendererPDF.renderAsString().replace(/&/g, '&amp;');

            return { pdfFile };
        }

        /******************/

        /**
         * Defines the Suitelet script trigger point.
         * @param {Object} scriptContext
         * @param {ServerRequest} scriptContext.request - Incoming request
         * @param {ServerResponse} scriptContext.response - Suitelet response
         * @since 2015.2
         */
        function onRequest(scriptContext) {
            // log.debug('method', scriptContext.request.method);
            // log.debug('parameteres', scriptContext.request.parameters);

            if (scriptContext.request.method == 'GET') {
                // Obtener datos por url
                let button = scriptContext.request.parameters['_button'];
                let expensereport_id = scriptContext.request.parameters['_expensereport_id'];
                let templatepdf_id = scriptContext.request.parameters['_templatepdf_id'] || 31;

                if (button == 'advanced_pdf') {

                    // Crear PDF
                    let { pdfFile } = createAdvancedPDF(button, expensereport_id, templatepdf_id);

                    // Descargar PDF
                    scriptContext.response.renderPdf(pdfFile);
                }
            }
        }

        return { onRequest }

    });
