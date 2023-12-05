import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace ContentSafetyInternal;

alias ServiceTraits = SupportsRepeatableRequests &
SupportsConditionalRequests &
SupportsClientRequestId;


interface BlockOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}


interface WhitelistFeature {
  @route("whitelist/features")
  @summary("List Whitelist Features.")
  @doc("Get whitelist features.")
  op listWhitelistFeatures is RpcOperation<
    {},
    FeatureList  ,
    ServiceTraits,
    Azure.Core.Foundations.ErrorResponse
  >;
}

interface Metrics {
  @route("/metrics")
  @summary("List API Request Counts At Different Timestamps Given A Time Range.")
  @doc("List API request counts at different timestamps given a time range. Default maxpagesize is 1000.")
  listRequestCounts is BlockOps.ResourceList<
    CountPerTimestamp,
    ListQueryParametersTrait<{
      ...SkipQueryParameter,
      ...TopQueryParameter,
      ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...TimeGranularityQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ContentSafetyOperationQueryParameter,
      ...ProjectNameQueryParameter
    }>
  >;

  @route("/metrics")
  @summary("List API Request Latencies At Different Timestamps Given A Time Range.")
  @doc("List API request latencies at different timestamps given a time range. Default maxpagesize is 1000.")
  listRequestLatencies is BlockOps.ResourceList<
    LatencyPerTimestamp,
    ListQueryParametersTrait<{
      ...SkipQueryParameter,
      ...TopQueryParameter,
      ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...TimeGranularityQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ContentSafetyOperationQueryParameter,
      ...AggregationQueryParameter,
      ...ProjectNameQueryParameter
    }>
  >;

  @summary("List API Request Count At Different Timestamps Of A Specific Category Given A Time Range.")
  @doc("List API request count at different timestamps of a specific category given a time range.")
  @route("/metrics")
  listRequestCountsByCategoryAndSeverity is BlockOps.ResourceList<
    RequestCountsPerTimestamp,
    ListQueryParametersTrait<{
      ...TopQueryParameter,
          ...SkipQueryParameter,
          ...MaxPageSizeQueryParameter,
          ...StartTimeQueryParameter,
          ...EndTimeQueryParameter,
          ...TimeGranularityQueryParameter,
          ...ContentSafetyVersionQueryParameter,
          ...ModalityTypeQueryParameter,
          ...ProjectNameQueryParameter
    }>
  >;

  @route("/metrics/blocklistTopTerms")
  @summary("List Top Terms Hit In Blocklist At Different Timestamps.")
  @doc("List top terms hit in blocklist at different timestamps.")
  op listBlocklistTopTerms is RpcOperation<
    {

      ...TopTermQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ProjectNameQueryParameter
    },
    TermList  ,
    ServiceTraits,
    Azure.Core.Foundations.ErrorResponse
  >;

  @route("/metrics")
  @summary("Show Blocklist Hit Request Count At Different Timestamps.")
  @doc("Show blocklist hit request count at different timestamps.")
  op listBlocklistHitCalls is BlockOps.ResourceList<
  BlockListHitCallsPerTimestamp,
  ListQueryParametersTrait<{
    ...SkipQueryParameter,
    ...TopQueryParameter,
    ...MaxPageSizeQueryParameter,
    ...StartTimeQueryParameter,
    ...EndTimeQueryParameter,
    ...TimeGranularityQueryParameter,
    ...ContentSafetyVersionQueryParameter,
    ...ProjectNameQueryParameter
    }>
  >;

  @added(ContentSafetyInternal.Versions.v2023_10_15_Preview)
  @removed(ContentSafetyInternal.Versions.v2023_10_30_Preview)
  @route("/metrics")
  @summary("List API Reject Counts At Different Timestamps Given A Time Range.")
  @doc("List API reject counts at different timestamps given a time range. Default maxpagesize is 1000.")
  op listRejectCounts is BlockOps.ResourceList<
    RejectCountPerTimestamp,
    ListQueryParametersTrait<{
      ...SkipQueryParameter,
      ...TopQueryParameter,
      ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...TimeGranularityQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ContentSafetyOperationQueryParameter,
      ...RequiredProjectNameQueryParameter,
      ...RequiredRejectKindQueryParameter
    }>
  >;


  @added(ContentSafetyInternal.Versions.v2023_10_15_Preview)
  @added(ContentSafetyInternal.Versions.v2023_10_30_Preview)
  @added(ContentSafetyInternal.Versions.v2023_11_30_Preview)
  @route("/metrics")
  @summary("List API Detected Counts At Different Timestamps Given A Time Range.")
  @doc("List API detected counts at different timestamps given a time range. Default maxpagesize is 1000.")
  op listDetectedCounts is BlockOps.ResourceList<
    DetectedCountsPerTimestamp,
    ListQueryParametersTrait<{
      ...SkipQueryParameter,
      ...TopQueryParameter,
      ...MaxPageSizeQueryParameter,
      ...StartTimeQueryParameter,
      ...EndTimeQueryParameter,
      ...TimeGranularityQueryParameter,
      ...ContentSafetyVersionQueryParameter,
      ...ContentSafetyOperationQueryParameter,
      ...RequiredProjectNameQueryParameter,
      ...RequiredRejectKindQueryParameter
    }>
  >;

}
