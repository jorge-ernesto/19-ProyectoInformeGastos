// Notas del archivo:
// - Secuencia de comando:
//      - Biomont SL Proy Inf Gtos Des Arc (customscript_bio_sl_proy_inf_gtos_des_arc)
// - URL:
//      - https://6462530.app.netsuite.com/app/site/hosting/scriptlet.nl?script=2169&deploy=1

/**
 * @NApiVersion 2.1
 * @NScriptType Suitelet
 */
define(['./lib/Bio.Library.Helper', 'N'],

    function (objHelper, N) {

        const { log, file, render, encode, record } = N;

        /******************/

        // Crear PDF
        function createPDF(button, expense_id) {

            if (button == 'advanced_pdf') {

                // render.TemplateRenderer
                // https://6462530.app.netsuite.com/app/help/helpcenter.nl?fid=section_4412065265.html

                // Template del archivo
                let templatePdf = 'CUSTTMPL_BIO_INFORME_GASTOS_AGRUPADO';

                // Crear PDF - Contenido dinamico
                let pdfContent = file.load(`./template/Advanced_PDF/${templatePdf}.ftl`).getContents();
                let rendererPDF = render.create();
                rendererPDF.templateContent = pdfContent

                // Enviar datos a PDF
                rendererPDF.addRecord('record', record.load({
                    type: 'expensereport',
                    id: expense_id
                }));

                // Crear PDF
                pdfFile = rendererPDF.renderAsString().replace(/&/g, '&amp;');

                return { pdfFile };
            }
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
                let button = scriptContext.request.parameters['_button'] || 'advanced_pdf';
                let expense_id = scriptContext.request.parameters['_expense_id'] || 1152231;

                if (button == 'advanced_pdf') {

                    // Crear PDF
                    let { pdfFile } = createPDF(button, expense_id);

                    // Descargar PDF
                    scriptContext.response.renderPdf(pdfFile);
                }
            }
        }

        return { onRequest }

    });
