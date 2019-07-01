Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382D05B393
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 06:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfGAE1Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 00:27:24 -0400
Received: from mail-eopbgr710128.outbound.protection.outlook.com ([40.107.71.128]:20608
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfGAE1X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jul 2019 00:27:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+5ztHcB5/MWlAS3mC7dDWDzvuAkKVtBntRETHtGvR615+JetjEe0160wL3WxU7lKQd7mkQDMF8R4lHR2Xf8AbkAKeLzHeR8nZbrJLyiTECsgJmdM85ypvpgoKoRc/lo+GsWjeWDD5BcdYcZVZ1TgR4cYrXtKqc8Zdxbdg2r/8X8B3GjJ0B/dkwv8rYSX6PepqVopRFxsI/Hpff8YWzOBX3Nd+V+0GP+RNPJjSQ6kj8zMyjy3sJc8kuxmDd9YdQRea7OUxf8TMsNe8isU6oygyCrynuqVW6+vOIM/Z6SB8FaZMYlKxa7PWguFJyeL2ZslFHZYp3n5euCz/ClKn1OgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUx8dYZJZoQZhtqoA5Q0kVb1rYbNVyU6TcS8PN0kZDY=;
 b=nvHekDrRmTL+n3q7KQMjd/qoye1pBXcrK8XncKydwHu5Q5GSyWhNavWlSLDEve13HiaSbNU7ahewpfsZyOnxk4QvyR3102sssw/VGqivwhDDQRXStA0M2ARaLFX8Xw3kHI/Iff+6jN2N2weMduJ3I3TVGZ4GuAzCOHEiJmER5PCg9RxXjee6EtrbSnWguE0yIZDBH56WN+l09A3Ri0wVD/v/Q73HacqUzs/Xm5q5tX4oHByuR8O5iq2lpl250SaZPYtFM4MpmMRm4yiROFjhUKku4OSB+DYpLXwznwt5z95rscfKmexQebRgz5f/I4U8RnTrwi2hkjjL+Li22RUMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUx8dYZJZoQZhtqoA5Q0kVb1rYbNVyU6TcS8PN0kZDY=;
 b=HhLOhuhXdJ8aM6VVJ4aJMFaZNgULHgw+IRxQml9gQpa1AHSEGwLGDXnMbpR5NokN6NBeIP7pgdccqTAmD7SrVmq6rh4d+ON89s+mH5fFBEM7wQcNRexHoKa42p7ZBcF3Gu4vjEkr7yBK2C4o8qnM6bAwjUtDaHOcBvTYBYTVwps=
Received: from BYAPR21MB1335.namprd21.prod.outlook.com (20.179.60.209) by
 BYAPR21MB1159.namprd21.prod.outlook.com (20.179.56.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.1; Mon, 1 Jul 2019 04:25:41 +0000
Received: from BYAPR21MB1335.namprd21.prod.outlook.com
 ([fe80::71df:6122:56a2:2a4f]) by BYAPR21MB1335.namprd21.prod.outlook.com
 ([fe80::71df:6122:56a2:2a4f%2]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 04:25:41 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "salyzyn@android.com" <salyzyn@android.com>,
        "pcc@google.com" <pcc@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "huw@codeweavers.com" <huw@codeweavers.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [PATCH v5 0/2] clocksource/drivers: Create new Hyper-V clocksource
 driver
Thread-Topic: [PATCH v5 0/2] clocksource/drivers: Create new Hyper-V
 clocksource driver
Thread-Index: AQHVL8UKgEXPGJ6KoU20QYR9G1GCKQ==
Date:   Mon, 1 Jul 2019 04:25:41 +0000
Message-ID: <1561955054-1838-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR01CA0015.prod.exchangelabs.com (2603:10b6:903:1f::25)
 To BYAPR21MB1335.namprd21.prod.outlook.com (2603:10b6:a03:115::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [167.220.2.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10c65511-f8aa-49bd-e704-08d6fddc2cea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1159;
x-ms-traffictypediagnostic: BYAPR21MB1159:|BYAPR21MB1159:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB115912E3CA85AAFB1E06DA34D7F90@BYAPR21MB1159.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(6436002)(54906003)(4326008)(316002)(110136005)(8676002)(10090500001)(6486002)(86362001)(81166006)(2616005)(476003)(486006)(81156014)(256004)(186003)(7736002)(2501003)(6116002)(3846002)(6512007)(36756003)(14444005)(66946007)(305945005)(73956011)(66446008)(66476007)(66556008)(64756008)(8936002)(22452003)(53936002)(4720700003)(25786009)(68736007)(26005)(99286004)(2906002)(5660300002)(50226002)(71200400001)(386003)(71190400001)(6506007)(10290500003)(102836004)(478600001)(14454004)(52116002)(2201001)(66066001)(7416002)(7406005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1159;H:BYAPR21MB1335.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w2CeG83ZpwAQKnT3VJDdZ04wc8aIMQpQQPe9X7ul5S7jDQ9HcOwzfvWKkriE+sAAp8YvxMHZVS2QH8Ei8U4Yk07zQXw91r1mvunmpd7Rna4U0laXEMXO6BSdtwgnrgqQKVzXwyXCpDkSs2rCsZObWKxqIjFcuNVABjGCxMo7cofoRfHQHd+KL0ZmyVqGNaRbggRqXgYnEtX6t1zIGBKZzq6kkIkQaUdBr2s9JRy7CV/yfO/N/jPFL5QESa/w1Ag6hQs7X2KfHduTJdpegEdFkwxlsdhTxRdQu1JleJU4ow5qskQ4iF+wRB6Q/2I/eI09QBY/c/nK/whLG4HzDzHoVcx7njOmMMbBKjwio29xD4O2mTbK12t+7okF2MbZHNjcMTI82ssQMcj+Kg0GfmaYeSkfmfeMcUz2R49TqOCIGFI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c65511-f8aa-49bd-e704-08d6fddc2cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 04:25:41.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmlmhk@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1159
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgbW92ZXMgSHlwZXItViBjbG9jay90aW1lciBjb2RlIHRvIGEgc2Vw
YXJhdGUgSHlwZXItVg0KY2xvY2tzb3VyY2UgZHJpdmVyLiBQcmV2aW91c2x5LCBIeXBlci1WIGNs
b2NrL3RpbWVyIGNvZGUgYW5kIGRhdGENCnN0cnVjdHVyZXMgd2VyZSBtaXhlZCBpbiB3aXRoIG90
aGVyIEh5cGVyLVYgY29kZSBpbiB0aGUgSVNBIGluZGVwZW5kZW50DQpkcml2ZXJzL2h2IGNvZGUg
YXMgd2VsbCBhcyBpbiBJU0EgZGVwZW5kZW50IGNvZGUuIFRoZSBuZXcgSHlwZXItVg0KY2xvY2tz
b3VyY2UgZHJpdmVyIGlzIElTQSBhZ25vc3RpYywgd2l0aCBhIGp1c3QgZmV3IGRlcGVuZGVuY2ll
cyBvbg0KSVNBIHNwZWNpZmljIGZ1bmN0aW9ucy4gVGhlIHBhdGNoIHNlcmllcyBkb2VzIG5vdCBj
aGFuZ2UgYW55IGJlaGF2aW9yDQpvciBmdW5jdGlvbmFsaXR5IC0tIGl0IG9ubHkgcmVvcmdhbml6
ZXMgdGhlIGV4aXN0aW5nIGNvZGUgYW5kIGZpeGVzIHVwDQp0aGUgbGlua2FnZXMuIEEgZmV3IHBs
YWNlcyBvdXRzaWRlIG9mIEh5cGVyLVYgY29kZSBhcmUgZml4ZWQgdXAgdG8gdXNlDQp0aGUgbmV3
ICNpbmNsdWRlIGZpbGUgc3RydWN0dXJlLg0KDQpUaGlzIHJlc3RydWN0dXJpbmcgaXMgaW4gcmVz
cG9uc2UgdG8gTWFyYyBaeW5naWVyJ3MgcmV2aWV3IGNvbW1lbnRzDQpvbiBzdXBwb3J0aW5nIEh5
cGVyLVYgcnVubmluZyBvbiBBUk02NCwgYW5kIGlzIGEgZ29vZCBpZGVhIGluIGdlbmVyYWwuDQpJ
dCBpbmNyZWFzZXMgdGhlIGFtb3VudCBvZiBjb2RlIHNoYXJlZCBiZXR3ZWVuIHRoZSB4ODYgYW5k
IEFSTTY0DQphcmNoaXRlY3R1cmVzLCBhbmQgcmVkdWNlcyB0aGUgc2l6ZSBvZiB0aGUgbmV3IGNv
ZGUgZm9yIHN1cHBvcnRpbmcNCkh5cGVyLVYgb24gQVJNNjQuIEEgbmV3IHZlcnNpb24gb2YgdGhl
IEh5cGVyLVYgb24gQVJNNjQgcGF0Y2hlcyB3aWxsDQpmb2xsb3cgb25jZSB0aGlzIGNsb2Nrc291
cmNlIHJlc3RydWN0dXJpbmcgaXMgYWNjZXB0ZWQuDQoNClRoZSBjb2RlIGlzIGRpZmYnZWQgYWdh
aW5zdCB0aGUgdXBzdHJlYW0gdGlwIHRyZWU6DQpnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgdGltZXJzL3Zkc28NCg0KQ2hhbmdlcyBpbiB2
NToNCiogUmV2aXNlZCBjb21taXQgc3VtbWFyaWVzIFtUaG9tYXMgR2xlaXhuZXJdDQoqIFJlbW92
ZWQgY2FsbCB0byBjbG9ja2V2ZW50c191bmJpbmRfZGV2aWNlKCkgW1Rob21hcyBHbGVpeG5lcl0N
CiogUmVzdHJ1Y3R1cmVkIGh2X2luaXRfY2xvY2tzb3VyY2UoKSBbVGhvbWFzIEdsZWl4bmVyXQ0K
KiBWYXJpb3VzIG90aGVyIHNtYWxsIGNvZGUgY2xlYW51cHMgW1Rob21hcyBHbGVpeG5lcl0NCg0K
Q2hhbmdlcyBpbiB2NDoNCiogUmV2aXNlZCBjb21taXQgbWVzc2FnZXMNCiogUmViYXNlZCB0byB1
cHN0cmVhbSB0aXAgdHJlZQ0KDQpDaGFuZ2VzIGluIHYzOg0KKiBSZW1vdmVkIGJvb2xlYW4gYXJn
dW1lbnQgdG8gaHZfaW5pdF9jbG9ja3NvdXJjZSgpLiBBbHdheXMgY2FsbA0Kc2NoZWRfY2xvY2tf
cmVnaXN0ZXIsIHdoaWNoIGlzIG5lZWRlZCBvbiBBUk02NCBidXQgYSBuby1vcCBvbiB4ODYuDQoq
IFJlbW92ZWQgc2VwYXJhdGUgY3B1aHAgc2V0dXAgaW4gaHZfc3RpbWVyX2FsbG9jKCkgYW5kIGlu
c3RlYWQNCmRpcmVjdGx5IGNhbGwgaHZfc3RpbWVyX2luaXQoKSBhbmQgaHZfc3RpbWVyX2NsZWFu
dXAoKSBmcm9tDQpjb3JyZXNwb25kaW5nIFZNYnVzIGZ1bmN0aW9ucy4gIFRoaXMgbW9yZSBjbG9z
ZWx5IG1hdGNoZXMgb3JpZ2luYWwNCmNvZGUgYW5kIGF2b2lkcyBjbG9ja3NvdXJjZSBzdG9wL3Jl
c3RhcnQgcHJvYmxlbXMgb24gQVJNNjQgd2hlbg0KVk1idXMgY29kZSBkZW5pZXMgQ1BVIG9mZmxp
bmluZyByZXF1ZXN0Lg0KDQpDaGFuZ2VzIGluIHYyOg0KKiBSZXZpc2VkIGNvbW1pdCBzaG9ydCBk
ZXNjcmlwdGlvbnMgc28gdGhlIGRpc3RpbmN0aW9uIGJldHdlZW4NCnRoZSBmaXJzdCBhbmQgc2Vj
b25kIHBhdGNoZXMgaXMgY2xlYXJlciBbR3JlZ0tIXQ0KKiBSZW5hbWVkIG5ldyBjbG9ja3NvdXJj
ZSBkcml2ZXIgZmlsZXMgYW5kIGZ1bmN0aW9ucyB0byB1c2UNCmV4aXN0aW5nICJ0aW1lciIgYW5k
ICJzdGltZXIiIG5hbWVzIGluc3RlYWQgb2YgaW50cm9kdWNpbmcNCiJzeW50aW1lciIuIFtWaXRh
bHkgS3V6bmV0c292XQ0KKiBJbnRyb2R1Y2VkIENPTkZJR19IWVBFUl9USU1FUiB0byBmaXggYnVp
bGQgcHJvYmxlbSB3aGVuDQpDT05GSUdfSFlQRVJWPW0gW1ZpdGFseSBLdXpuZXRzb3ZdDQoqIEFk
ZGVkICJTdWdnZXN0ZWQtYnk6IE1hcmMgWnluZ2llciINCg0KTWljaGFlbCBLZWxsZXkgKDIpOg0K
ICBjbG9ja3NvdXJjZS9kcml2ZXJzOiBNYWtlIEh5cGVyLVYgY2xvY2tzb3VyY2UgSVNBIGFnbm9z
dGljDQogIGNsb2Nrc291cmNlL2RyaXZlcnM6IENvbnRpbnVlIG1ha2luZyBIeXBlci1WIGNsb2Nr
c291cmNlIElTQSBhZ25vc3RpYw0KDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMiArDQogYXJjaC94ODYvZW50cnkvdmRzby92bWEuYyAgICAgICAgICAgICAg
ICB8ICAgMiArLQ0KIGFyY2gveDg2L2h5cGVydi9odl9pbml0LmMgICAgICAgICAgICAgICAgfCAg
OTEgKy0tLS0tLS0tDQogYXJjaC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMuaCAgICAgICB8
ICAgNiArDQogYXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCAgICAgICAgICB8ICA4MSAr
LS0tLS0tLQ0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Zkc28vZ2V0dGltZW9mZGF5LmggfCAgIDIg
Ky0NCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMgICAgICAgICAgIHwgICA0ICstDQog
YXJjaC94ODYva3ZtL3g4Ni5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVy
cy9jbG9ja3NvdXJjZS9NYWtlZmlsZSAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9jbG9j
a3NvdXJjZS9oeXBlcnZfdGltZXIuYyAgICAgICB8IDMzOSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQogZHJpdmVycy9odi9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MyArDQogZHJpdmVycy9odi9odi5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE1NiArLS0t
LS0tLS0tLS0tLQ0KIGRyaXZlcnMvaHYvaHZfdXRpbC5jICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KIGRyaXZlcnMvaHYvaHlwZXJ2X3ZtYnVzLmggICAgICAgICAgICAgICAgfCAgIDMgLQ0K
IGRyaXZlcnMvaHYvdm1idXNfZHJ2LmMgICAgICAgICAgICAgICAgICAgfCAgNDIgKystLQ0KIGlu
Y2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmggICAgICAgfCAxMDUgKysrKysrKysrKw0K
IDE2IGZpbGVzIGNoYW5nZWQsIDUwMyBpbnNlcnRpb25zKCspLCAzMzYgZGVsZXRpb25zKC0pDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaA0KDQot
LSANCjEuOC4zLjENCg0K
