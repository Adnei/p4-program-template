#include <core.p4>
#include <v1model.p4>
struct metadata {}
struct headers {}
/*
Reminder:
    ingress_port - the port on which the packet arrived
    egress_spec  - the port to which the packet should be sent to
    egress_port  - the port on which the packet is departing from
*/


// Parser
parser Parser(packet_in packet,
    out headers hdr,
    inout metadata meta,
    inout standard_metadata_t smeta ) {
        state start { transition accept; }
}
// Ingress processing
control IngressFn(inout headers hdr, inout metadata meta,
  inout standard_metadata_t std_meta){
    action set_egress_spec(bit<9> port){
        standard_metadata.egress_spec = port;
    }
    table forward {
        key = { standard_metadata.ingress_port: exact; }
        actions = {
            set_egress_spec;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }
    apply{forward.apply();}
}
// Egress processing
control EgressFn(inout headers hdr, inout metadata meta,
  inout standard_metadata_t standard_metadata){
      apply {  }
}
// Sometimes you have to verify the checksum ;)
control ChecksumVerify(in headers hdr, inout metadata meta){
    apply {  }
}
// Checksum update
control ComputeChecksum(inout headers hdr, inout metadata meta){
    apply {  }
}
// Deparser
control Deparser(inout headers hdr, inout metadata meta){
    apply {  }
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

/*
                ###########################################
                #  KEY  #  ACTION NAME    #  ACTION DATA  #
                ###########################################
                #   1   # set_egress_spec #       2       #
                #   2   # set_egress_spec #       1       #
                ###########################################
*/
