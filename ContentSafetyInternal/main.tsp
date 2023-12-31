import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
  title: "Content Safety Internal",
})
@versioned(ContentSafetyInternal.Versions)
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@server(
  "{endpoint}/contentsafety/internal",
  "Content safety internal service",
  {
    @doc("""
Supported Cognitive Services endpoints (protocol and hostname, for example:
https://<resource-name>.cognitiveservices.azure.com).
""")
    endpoint: string,
  }
)
@doc("Content safety internal service")
namespace ContentSafetyInternal;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_30_Preview: "2023-04-30-preview",
  v2023_05_30_Preview: "2023-05-30-preview",
  v2023_10_01: "2023-10-01",
  v2023_10_15_Preview: "2023-10-15-preview",
  v2023_10_30_Preview: "2023-10-30-preview",
  v2023_11_30_Preview: "2023-11-30-preview",
}
