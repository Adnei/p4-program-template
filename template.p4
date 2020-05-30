#include <core.p4>
#include <v1model.p4>

struct metadata {}
struct headers {
    ethernet_t ethernet;
    ipv4_t ipv4;
}

// Parser
parser Parser(packet_in packet,
    out headers hdr,
    inout metadata meta,
    inout standard_metadata_t smeta ) {
        // states and such...
}
// Ingress processing
control IngressFn(inout headers hdr,
    inout metadata meta,
    inout standard_metadata_t std_meta){
    // apply {...}
}
// Egress processing
control EgressFn(inout headers hdr,
    inout metadata meta,
    inout standard_metadata_t standard_metadata){
    // apply {...}
}
// Sometimes you have to verify the checksum ;)
control ChecksumVerify(in headers hdr, inout metadata meta){
    // ...
}
// Checksum update
control ComputeChecksum(inout headers hdr,
    inout metadata meta){
    // ...
}
// Deparser
control Deparser(inout headers hdr,
    inout metadata meta){
    // ...
}
// SWITCH
V1Switch(
    Parser(),
    ChecksumVerify(),
    IngressFn(),
    EgressFn(),
    ComputeChecksum(),
    Deparser()
) main;
