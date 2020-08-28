Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7B255BDC
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgH1ODP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:03:15 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:48320 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgH1ODM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 10:03:12 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07CC0641C1;
        Fri, 28 Aug 2020 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598620289;
        bh=krfQlqmlfNt/GfKNiSWO7+FkIFivJ3e+kNmJesWJ/v8=; h=From:To:Date;
        b=Lkv9qZmCfyqsTMMkRaI8UT6MfO7Dwmp6F9tJIMEDZu76F4p4C/gYCEfQn7ABr4/vq
         M/K89mCcgqZCpnPKqATMl5DsKA6iaM49h+YmeE4mIpPfbTBUHL1iw/xXvOVIHtLWUd
         B7FaK/kCjdR58WN/444LQtjMpHZ6fl5JznfMFaAk=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DD3641C0;
        Fri, 28 Aug 2020 06:11:18 -0700 (PDT)
Received: from SJDC-EXNABU01.us.trendnet.org (unknown [10.45.175.97])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Fri, 28 Aug 2020 06:11:18 -0700 (PDT)
Received: from ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) by
 SJDC-EXNABU01.us.trendnet.org (10.45.175.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Fri, 28 Aug 2020 06:11:18 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Fri, 28 Aug 2020 13:11:15 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::35d2:8fa6:df0c:6aae]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::35d2:8fa6:df0c:6aae%18]) with mapi id
 15.01.1979.003; Fri, 28 Aug 2020 13:11:15 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "cameron@moodycamel.com" <cameron@moodycamel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: RE: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Thread-Topic: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Thread-Index: AQHWfI4t/nsBli3py0KTZQaFFkmSRalNd/2Q
Date:   Fri, 28 Aug 2020 13:11:15 +0000
Message-ID: <7df0a1af432040d9908517661c32dc34@trendmicro.com>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.359432340@infradead.org>
In-Reply-To: <20200827161754.359432340@infradead.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25630.007
X-TM-AS-Result: No--26.521-5.0-31-10
X-TMASE-MatchedRID: oWWGYrlt3s/UL3YCMmnG4vHkpkyUphL9Ud7Bjfo+5jTw9qL6KtqraGHc
        cQC5M+QDo95EdER7vBaGDu7ShAWPZ9XHt2PHEP03uwdUMMznEA9dm+F15tBIr0btou1PeiP7wsb
        DDvMRD0iw6C/crbkfac8bFMQN3nGuAdgI1PXGN/NWfOVCJoTbWjdYa+/U0XX531GU/N5W5BAMwu
        JBqQIpuSFxdHijRu1bmXo47E3f2NPqYCMwwh+POYS/TV9k6ppArFP4l9ANsI/hWjjGhpcHLzOij
        9XxY1UVGVdQXDXAdLbS3NH/B9C2N8X6zzMWVMJET7O/YHJhINCwqLgRdvwAioRYHyK7IaoJ8kk4
        4E19kClpMDrWrGKemtwujfl9TYCdGuZxtGrsTzhQv6U9dFo+qcVRnurwepAU7649n0TgA4k7yUi
        WtMo7o0SE6cDIXfLWysK+7TtkkV25UpxrNQf5nQD9gX5aXd4fQABNUkvqrhfLmsnRFz6pJtEYhx
        Noldm1jqkhdl7xWKbGYTYwx24fmXj7PwsdQyXdiPIR0a1i6hdXgkPfc7vKCTUQfiU3MhlISB+g0
        L+JM1DrcFn67wIg3cpjK4dbPxs8Qv21zJNl0CyDGx/OQ1GV8mgVPcrOkeoT4Hwn1pZzW/9XKaQs
        z6vtVOJGF26G8SWy5yM0c1ktj9M=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.520800-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25630.007
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-SNTS-SMTP: F8DFD644581174E9C80188AA89A419CB62997D2EAF878C3A6654191FC96723642000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--26.521-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBaaWpsc3RyYSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDI4LCAyMDIwIDEyOjEz
IEFNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtaGlyYW1hdEBrZXJuZWwu
b3JnDQo+IENjOiBFZGR5IFd1IChSRC1UVykgPEVkZHlfV3VAdHJlbmRtaWNyby5jb20+OyB4ODZA
a2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcm9zdGVkdEBnb29kbWlzLm9yZzsNCj4g
bmF2ZWVuLm4ucmFvQGxpbnV4LmlibS5jb207IGFuaWwucy5rZXNoYXZhbXVydGh5QGludGVsLmNv
bTsgbGludXgtYXJjaEB2Z2VyLmtlcm5lbC5vcmc7IGNhbWVyb25AbW9vZHljYW1lbC5jb207DQo+
IG9sZWdAcmVkaGF0LmNvbTsgd2lsbEBrZXJuZWwub3JnOyBwYXVsbWNrQGtlcm5lbC5vcmc7IHBl
dGVyekBpbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFtSRkNdW1BBVENIIDMvN10ga3Byb2Jlczog
UmVtb3ZlIGtyZXRwcm9iZSBoYXNoDQo+DQo+IEBAIC0xOTM1LDcxICsxOTMyLDQ1IEBAIHVuc2ln
bmVkIGxvbmcgX19rcmV0cHJvYmVfdHJhbXBvbGluZV9oYW4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgdHJhbXBvbGluZV9hZGRyZXNzLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZnJhbWVfcG9p
bnRlcikNCj4gIHsNCj4gLy8gLi4uIHJlbW92ZWQNCj4gLy8gTlVMTCBoZXJlDQo+ICsgICAgICAg
Zmlyc3QgPSBub2RlID0gY3VycmVudC0+a3JldHByb2JlX2luc3RhbmNlcy5maXJzdDsNCj4gKyAg
ICAgICB3aGlsZSAobm9kZSkgew0KPiArICAgICAgICAgICAgICAgcmkgPSBjb250YWluZXJfb2Yo
bm9kZSwgc3RydWN0IGtyZXRwcm9iZV9pbnN0YW5jZSwgbGxpc3QpOw0KPg0KPiAtICAgICAgICAg
ICAgICAgb3JpZ19yZXRfYWRkcmVzcyA9ICh1bnNpZ25lZCBsb25nKXJpLT5yZXRfYWRkcjsNCj4g
LSAgICAgICAgICAgICAgIGlmIChza2lwcGVkKQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICBw
cl93YXJuKCIlcHMgbXVzdCBiZSBibGFja2xpc3RlZCBiZWNhdXNlIG9mIGluY29ycmVjdCBrcmV0
cHJvYmUgb3JkZXJcbiIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmktPnJw
LT5rcC5hZGRyKTsNCj4gKyAgICAgICAgICAgICAgIEJVR19PTihyaS0+ZnAgIT0gZnJhbWVfcG9p
bnRlcik7DQo+DQo+IC0gICAgICAgICAgICAgICBpZiAob3JpZ19yZXRfYWRkcmVzcyAhPSB0cmFt
cG9saW5lX2FkZHJlc3MpDQo+ICsgICAgICAgICAgICAgICBvcmlnX3JldF9hZGRyZXNzID0gKHVu
c2lnbmVkIGxvbmcpcmktPnJldF9hZGRyOw0KPiArICAgICAgICAgICAgICAgaWYgKG9yaWdfcmV0
X2FkZHJlc3MgIT0gdHJhbXBvbGluZV9hZGRyZXNzKSB7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIC8qDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAqIFRoaXMgaXMgdGhlIHJlYWwgcmV0
dXJuIGFkZHJlc3MuIEFueSBvdGhlcg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgKiBpbnN0
YW5jZXMgYXNzb2NpYXRlZCB3aXRoIHRoaXMgdGFzayBhcmUgZm9yDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAqIG90aGVyIGNhbGxzIGRlZXBlciBvbiB0aGUgY2FsbCBzdGFjaw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7
DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgICAgICAgIG5vZGUgPSBub2Rl
LT5uZXh0Ow0KPiAgICAgICAgIH0NCj4NCg0KSGksIEkgZm91bmQgYSBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UgaGVyZSwgd2hlcmUgY3VycmVudC0+a3JldHByb2JlX2luc3RhbmNlcy5maXJzdCA9
PSBOVUxMIGluIHRoZXNlIHR3byBzY2VuYXJpbzoNCg0KMSkgSW4gdGFzayAicnM6bWFpbiBROlJl
ZyINCiMgaW5zbW9kIHNhbXBsZXMva3Byb2Jlcy9rcmV0cHJvYmVfZXhhbXBsZS5rbyBmdW5jPXNj
aGVkdWxlDQojIHBraWxsIHNkZG0tZ3JlZXRlcg0KDQoyKSBJbiB0YXNrICJsbHZtcGlwZS0xMCIN
CiMgaW5zbW9kIHNhbXBsZXMva3Byb2Jlcy9rcmV0cHJvYmVfZXhhbXBsZS5rbyBmdW5jPXNjaGVk
dWxlDQpsb2dpbiBwbGFzbWFzaGVsbCBzZXNzaW9uIGZyb20gc2RkbSBncmFwaGljYWwgaW50ZXJm
YWNlDQoNCmJhc2VkIG9uIE1hc2FtaSdzIHYyICsgUGV0ZXIncyBsb2NrbGVzcyBwYXRjaCwgSSds
bCB0cnkgdGhlIG5ldyBicmFuY2ggb25jZSBJIGNhbiBjb21waWxlIGtlcm5lbA0KDQpTdGFja3Ry
YWNlIG1heSBub3QgYmUgcmVhbGx5IHVzZWZ1bCBoZXJlOg0KWyAgNDAyLjAwODYzMF0gQlVHOiBr
ZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDE4
DQpbICA0MDIuMDA4NjMzXSAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1v
ZGUNClsgIDQwMi4wMDg2NDJdICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQg
cGFnZQ0KWyAgNDAyLjAwODY0NF0gUEdEIDAgUDREIDANClsgIDQwMi4wMDg2NDZdIE9vcHM6IDAw
MDAgWyMxXSBQUkVFTVBUIFNNUCBQVEkNClsgIDQwMi4wMDg2NDldIENQVTogNyBQSUQ6IDE1MDUg
Q29tbTogbGx2bXBpcGUtMTAgS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA1LjkuMC1yYzItMDAx
MTEtZzcyMDkxZWMwOGYwMy1kaXJ0eSAjNDUNClsgIDQwMi4wMDg2NTBdIEhhcmR3YXJlIG5hbWU6
IFZNd2FyZSwgSW5jLiBWTXdhcmUgVmlydHVhbCBQbGF0Zm9ybS80NDBCWCBEZXNrdG9wIFJlZmVy
ZW5jZSBQbGF0Zm9ybSwgQklPUyA2LjAwIDA3LzI5LzIwMTkNClsgIDQwMi4wMDg2NTNdIFJJUDog
MDAxMDpfX2tyZXRwcm9iZV90cmFtcG9saW5lX2hhbmRsZXIrMHhiOC8weDE3Zg0KWyAgNDAyLjAw
ODY1NV0gQ29kZTogNjUgNGMgOGIgMzQgMjUgODAgNmQgMDEgMDAgNGMgODkgZTIgNDggYzcgYzcg
OTEgNmIgODUgOTEgNDkgOGQgYjYgMzggMDcgMDAgMDAgZTggZDEgMWEgZjkgZmYgNDggODUgZGIg
NzQgMDYgNDggM2IgNWQgZDAgNzUgMTYgPDQ5PiA4YiA3NSAxOCA0OCBjNyBjNyBhMCA2YyA4NSA5
MSA0OA0KIDhiIDU2IDI4IGU4IGIyIDFhIGY5IGZmIDBmIDBiDQpbICA0MDIuMDA4NjU1XSBSU1A6
IDAwMTg6ZmZmZmFiNDA4MTQ3YmRlMCBFRkxBR1M6IDAwMDEwMjQ2DQpbICA0MDIuMDA4NjU2XSBS
QVg6IDAwMDAwMDAwMDAwMDAwMjEgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDAwMDAw
MDAwMDAwMg0KWyAgNDAyLjAwODY1N10gUkRYOiAwMDAwMDAwMDgwMDAwMDAyIFJTSTogZmZmZmZm
ZmY5MTg5NzU3ZCBSREk6IDAwMDAwMDAwZmZmZmZmZmYNClsgIDQwMi4wMDg2NThdIFJCUDogZmZm
ZmFiNDA4MTQ3YmUyMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAwMDA5NTVj
DQpbICA0MDIuMDA4NjU4XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDQgUjExOiAwMDAwMDAwMDAwMDAw
MDAwIFIxMjogMDAwMDAwMDAwMDAwMDAwMA0KWyAgNDAyLjAwODY1OV0gUjEzOiAwMDAwMDAwMDAw
MDAwMDAwIFIxNDogZmZmZjkwNzM2ZDMwNWY0MCBSMTU6IDAwMDAwMDAwMDAwMDAwMDANClsgIDQw
Mi4wMDg2NjFdIEZTOiAgMDAwMDdmMjBmNmZmZDcwMCgwMDAwKSBHUzpmZmZmOTA3Mzc4MWMwMDAw
KDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANClsgIDQwMi4wMDg2NzVdIENTOiAgMDAxMCBE
UzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNClsgIDQwMi4wMDg2NzhdIENS
MjogMDAwMDAwMDAwMDAwMDAxOCBDUjM6IDAwMDAwMDAxZWQyNTYwMDYgQ1I0OiAwMDAwMDAwMDAw
MzcwNmUwDQpbICA0MDIuMDA4Njg0XSBDYWxsIFRyYWNlOg0KWyAgNDAyLjAwODY4OV0gID8gZWxm
Y29yZWhkcl9yZWFkKzB4NDAvMHg0MA0KWyAgNDAyLjAwODY5MF0gID8gZWxmY29yZWhkcl9yZWFk
KzB4NDAvMHg0MA0KWyAgNDAyLjAwODY5MV0gIHRyYW1wb2xpbmVfaGFuZGxlcisweDQyLzB4NjAN
ClsgIDQwMi4wMDg2OTJdICBrcmV0cHJvYmVfdHJhbXBvbGluZSsweDJhLzB4NTANClsgIDQwMi4w
MDg2OTNdIFJJUDogMDAxMDprcmV0cHJvYmVfdHJhbXBvbGluZSsweDAvMHg1MA0KDQpUUkVORCBN
SUNSTyBFTUFJTCBOT1RJQ0UNCg0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGVt
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgaXMgY29uZmlkZW50aWFsIGFuZCBtYXkgYmUgc3ViamVj
dCB0byBjb3B5cmlnaHQgb3Igb3RoZXIgaW50ZWxsZWN0dWFsIHByb3BlcnR5IHByb3RlY3Rpb24u
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUgbm90IGF1dGhv
cml6ZWQgdG8gdXNlIG9yIGRpc2Nsb3NlIHRoaXMgaW5mb3JtYXRpb24sIGFuZCB3ZSByZXF1ZXN0
IHRoYXQgeW91IG5vdGlmeSB1cyBieSByZXBseSBtYWlsIG9yIHRlbGVwaG9uZSBhbmQgZGVsZXRl
IHRoZSBvcmlnaW5hbCBtZXNzYWdlIGZyb20geW91ciBtYWlsIHN5c3RlbS4NCg0KRm9yIGRldGFp
bHMgYWJvdXQgd2hhdCBwZXJzb25hbCBpbmZvcm1hdGlvbiB3ZSBjb2xsZWN0IGFuZCB3aHksIHBs
ZWFzZSBzZWUgb3VyIFByaXZhY3kgTm90aWNlIG9uIG91ciB3ZWJzaXRlIGF0OiBSZWFkIHByaXZh
Y3kgcG9saWN5PGh0dHA6Ly93d3cudHJlbmRtaWNyby5jb20vcHJpdmFjeT4NCg==
