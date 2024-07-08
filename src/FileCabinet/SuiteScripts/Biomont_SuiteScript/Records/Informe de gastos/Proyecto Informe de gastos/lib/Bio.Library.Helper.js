/**
 * @NApiVersion 2.1
 * @NModuleScope SameAccount
 */
define(['N'],

    function (N) {

        const { log, runtime, record } = N;

        function getUser() {
            let user = runtime.getCurrentUser();
            return { user };
        }

        function error_log(title, data) {
            throw `${title} -- ${JSON.stringify(data)}`;
        }

        function error_message(message) {
            throw new Error(`${message}`);
        }

        /****************** Validacion ******************/

        function getCountrySubsidiary(subsidiaryId) {
            // Cargar el registro de la subsidiaria
            var subsidiaryRecord = record.load({
                type: record.Type.SUBSIDIARY,
                id: subsidiaryId
            });

            // Obtener el pais del registro de la subsidiaria
            var countrySubsidiary = subsidiaryRecord.getValue('country');

            return countrySubsidiary;
        }


        return {
            getUser,
            error_log,
            error_message,
            // Informe de gastos - Validacion
            getCountrySubsidiary
        }

    });
