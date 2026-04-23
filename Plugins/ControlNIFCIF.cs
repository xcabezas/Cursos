using System;
using System.Text;
using Microsoft.Xrm.Sdk;
using Microsoft.Xrm.Sdk.Query;

namespace SincronizarDatosDeIusUpConBC
{
    public class ControlNIFCIF : IPlugin
    {
        public void Execute(IServiceProvider serviceProvider)
        {
            var tracing = (ITracingService)serviceProvider.GetService(typeof(ITracingService));
            var context = (IPluginExecutionContext)serviceProvider.GetService(typeof(IPluginExecutionContext));
            var service = ((IOrganizationServiceFactory)serviceProvider.GetService(typeof(IOrganizationServiceFactory)))
                .CreateOrganizationService(context.UserId);

            if (context.Depth > 1)
                return;

            if (!context.InputParameters.Contains("Target"))
                return;

            if (context.MessageName != "Create" && context.MessageName != "Update")
                return;

            var target = (Entity)context.InputParameters["Target"];

            if (target.LogicalName != "account")
                return;

            // PreImage solo disponible en Update
            Entity preImage = null;
            if (context.MessageName == "Update" &&
                context.PreEntityImages != null &&
                context.PreEntityImages.Contains("PreImage"))
            {
                preImage = context.PreEntityImages["PreImage"];
            }

            tracing.Trace($"ControlNIFCIF ejecutado en {context.MessageName}");

            SincronizarGrupoIVA(target, preImage, service, tracing);
            SincronizarFormaPago(target, preImage, service, tracing);
            SincronizarTerminosPago(target, preImage, service, tracing);
        }

        // =====================================================
        // SINCRONIZACIÓN DE CAMPOS
        // Cada método sincroniza el campo entidad correspondiente
        // siempre que el campo texto esté informado, ya sea porque
        // fue actualizado en esta operación (target) o porque ya
        // tenía valor previamente (preImage).
        // =====================================================

        private static void SincronizarGrupoIVA(
            Entity target, Entity preImage, IOrganizationService service, ITracingService tracing)
        {
            string texto = ObtenerTexto(target, preImage, "iusupa_grupocontableivaclientetexto");
            if (string.IsNullOrWhiteSpace(texto))
                return;

            var refIVA = BuscarGrupoIVA(service, texto.Trim(), tracing);
            if (refIVA == null)
                return;

            target["iusupa_grupocontableivacliente"] = refIVA;
            target["iusupa_grupocontableivaclientetexto"] = refIVA.Name;

            tracing.Trace($"✅ Grupo IVA sincronizado: {refIVA.Name}");
        }

        private static void SincronizarFormaPago(
            Entity target, Entity preImage, IOrganizationService service, ITracingService tracing)
        {
            string texto = ObtenerTexto(target, preImage, "iusupa_formasdepagotexto");
            if (string.IsNullOrWhiteSpace(texto))
                return;

            var refPago = BuscarFormaPago(service, texto.Trim(), tracing);
            if (refPago == null)
                return;

            target["iusupa_formasdepago"] = refPago;
            target["iusupa_formasdepagotexto"] = refPago.Name;

            tracing.Trace($"✅ Forma de pago sincronizada: {refPago.Name}");
        }

        private static void SincronizarTerminosPago(
            Entity target, Entity preImage, IOrganizationService service, ITracingService tracing)
        {
            string texto = ObtenerTexto(target, preImage, "iusupa_terminosdepagotexto");
            if (string.IsNullOrWhiteSpace(texto))
                return;

            var refTermino = BuscarTerminosPago(service, texto.Trim(), tracing);
            if (refTermino == null)
                return;

            target["iusupa_terminosdepago"] = refTermino;
            target["iusupa_terminosdepagotexto"] = refTermino.Name;

            tracing.Trace($"✅ Término de pago sincronizado: {refTermino.Name}");
        }

        // =====================================================
        // HELPER: obtiene el texto de un campo desde target o preImage.
        //
        // Prioridad:
        //   1. Si el campo viene en target (fue modificado en esta
        //      operación), se usa ese valor.
        //   2. Si no, se busca en preImage (ya estaba informado antes).
        //
        // Esto garantiza que el campo entidad se sincroniza siempre
        // que el texto esté informado, independientemente de si fue
        // modificado en la operación actual.
        // =====================================================
        private static string ObtenerTexto(Entity target, Entity preImage, string campo)
        {
            if (target.Contains(campo))
                return target.GetAttributeValue<string>(campo);

            if (preImage != null && preImage.Contains(campo))
                return preImage.GetAttributeValue<string>(campo);

            return null;
        }

        // =====================================================
        // BÚSQUEDAS SEGURAS (SIN GUID VACÍO)
        // =====================================================

        private static EntityReference BuscarGrupoIVA(
            IOrganizationService service, string nombre, ITracingService tracing)
        {
            var query = new QueryExpression("iusupa_grupocontableivacliente")
            {
                ColumnSet = new ColumnSet("iusupa_name")
            };

            foreach (var e in service.RetrieveMultiple(query).Entities)
            {
                if (!string.Equals(
                    e.GetAttributeValue<string>("iusupa_name")?.Trim(),
                    nombre,
                    StringComparison.OrdinalIgnoreCase))
                    continue;

                if (e.Id == Guid.Empty)
                    return null;

                return new EntityReference("iusupa_grupocontableivacliente", e.Id)
                {
                    Name = e.GetAttributeValue<string>("iusupa_name")
                };
            }

            return null;
        }

        private static EntityReference BuscarFormaPago(
            IOrganizationService service, string nombre, ITracingService tracing)
        {
            var query = new QueryExpression("iusupa_formassdepago")
            {
                ColumnSet = new ColumnSet("iusupa_name")
            };

            foreach (var e in service.RetrieveMultiple(query).Entities)
            {
                if (!string.Equals(
                    e.GetAttributeValue<string>("iusupa_name")?.Trim(),
                    nombre,
                    StringComparison.OrdinalIgnoreCase))
                    continue;

                if (e.Id == Guid.Empty)
                    return null;

                return new EntityReference("iusupa_formassdepago", e.Id)
                {
                    Name = e.GetAttributeValue<string>("iusupa_name")
                };
            }

            return null;
        }

        private static EntityReference BuscarTerminosPago(
            IOrganizationService service, string nombre, ITracingService tracing)
        {
            string buscado = Normalizar(nombre);

            var query = new QueryExpression("iusupa_terminosdepago")
            {
                ColumnSet = new ColumnSet("iusupa_name")
            };

            foreach (var e in service.RetrieveMultiple(query).Entities)
            {
                if (Normalizar(e.GetAttributeValue<string>("iusupa_name")) != buscado)
                    continue;

                if (e.Id == Guid.Empty)
                    return null;

                return new EntityReference("iusupa_terminosdepago", e.Id)
                {
                    Name = e.GetAttributeValue<string>("iusupa_name")
                };
            }

            return null;
        }

        // =====================================================
        // NORMALIZACIÓN DE TEXTO
        // Elimina tildes, ñ y caracteres no alfanuméricos para
        // hacer comparaciones más tolerantes.
        // =====================================================
        private static string Normalizar(string texto)
        {
            if (string.IsNullOrWhiteSpace(texto))
                return string.Empty;

            texto = texto.ToLowerInvariant();
            var sb = new StringBuilder();

            foreach (char c in texto)
            {
                if (!char.IsLetterOrDigit(c))
                    continue;

                switch (c)
                {
                    case 'á': case 'à': case 'ä': sb.Append('a'); break;
                    case 'é': case 'è': case 'ë': sb.Append('e'); break;
                    case 'í': case 'ì': case 'ï': sb.Append('i'); break;
                    case 'ó': case 'ò': case 'ö': sb.Append('o'); break;
                    case 'ú': case 'ù': case 'ü': sb.Append('u'); break;
                    case 'ñ':                     sb.Append('n'); break;
                    default:                      sb.Append(c);   break;
                }
            }

            return sb.ToString();
        }
    }
}
