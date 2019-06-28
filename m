Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CC65A3A1
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2019 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF1Sdy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jun 2019 14:33:54 -0400
Received: from mail-eopbgr770129.outbound.protection.outlook.com ([40.107.77.129]:44558
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfF1Sdy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jun 2019 14:33:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwuSEc1a21ae+NZhQzAVbDuY8laT/xOpjo63M2q9Iyt9TropxbJpTJv23DAjwCKH62OhC8ivyo/jYR9bQAZi6dO7E/3wuadl81zjBKSRliZ99G324Zrj1U+G6wAExVFoZZ4fMBmmHofLEKMkV8yZwwNXn/nHGJOwAVWRYnKmqAg9s+g3u/uti1/9nLfJJtcsn/5+0b4BOtGm396ozOdhVnjgi8gocGH7uk9TVX7LD1AxEPCaXVE0+s1hwqV3naNQ7TGLu7PGUwsqfyHfkx9rWYW47XGZVwAV5gxwSBD2hW//GVy+Re7LY/a/YTyBagjGb3z3kr6M5EVzJKPvIuy2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34yH1k0ByhdX0SL4JskX1hR+6/uCYYhisYC1pTFuUq4=;
 b=Xve4PS/X1XNXJAfopXKb0kCcSw598S6J6rH0Fe3XPrlAd6e8bYkycCSEfpu+zywk8eAbP9jYG2DhjkdR7YoUzyG6SWwltDe2UrRzah2J0otJmN0ZCW8HKMExv2emm4eVN33YIP9g7lyoC8cRMGvjjCp46wZR7JxB2CUcO8Nf1NFvDqXlGEuekxd1lM8jpSccgnGMMBFXF7yWj+Nea8bdTI9t+WQo+V5qqKWx6q3e4vBshDdwuTmAq1s2ftuMb0swgNjfYsjo+PRV6mi6qfzumbw6zMKipOi8tSrA/70cJuI0B/7sZVrChwd8eZKEeODLkRAnCmFVepvJazBoz9+ZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34yH1k0ByhdX0SL4JskX1hR+6/uCYYhisYC1pTFuUq4=;
 b=T98Rkstw7eRVwCT/Ul/P3J1HWJqL/uvaH7BSd3tAi4eaS4iJQO4dpcq0FzcXgDVFMbs6RtRb0LttZnjE3o3mN9AYj9RnKXfJfFSNU0WNhAoaG21cySxTnZXCBfjl1LZ1uRvl7XeP5jHFh2tkY6trZdmCiWAhFGHnCxvCURjxGu8=
Received: from DM6PR21MB1340.namprd21.prod.outlook.com (20.179.53.83) by
 DM6PR21MB1145.namprd21.prod.outlook.com (20.179.50.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.4; Fri, 28 Jun 2019 18:33:50 +0000
Received: from DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::c817:8ed1:5d04:5a95]) by DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::c817:8ed1:5d04:5a95%6]) with mapi id 15.20.2052.005; Fri, 28 Jun 2019
 18:33:50 +0000
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
Subject: [PATCH v4 0/2] Drivers: hv: Move Hyper-V clock/timer code to separate
 clocksource driver
Thread-Topic: [PATCH v4 0/2] Drivers: hv: Move Hyper-V clock/timer code to
 separate clocksource driver
Thread-Index: AQHVLeAHtKnubHleu0muzknyz7e1vg==
Date:   Fri, 28 Jun 2019 18:33:50 +0000
Message-ID: <1561746758-23216-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:903:77::29) To DM6PR21MB1340.namprd21.prod.outlook.com
 (2603:10b6:5:175::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.174.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7da63b7-23c8-47ad-6e38-08d6fbf72a27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1145;
x-ms-traffictypediagnostic: DM6PR21MB1145:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB11450539151E6D2C2F579373D7FC0@DM6PR21MB1145.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(386003)(86362001)(2616005)(54906003)(256004)(110136005)(478600001)(316002)(7416002)(7406005)(6486002)(486006)(14454004)(50226002)(2201001)(52116002)(476003)(6512007)(99286004)(4720700003)(6436002)(10290500003)(53936002)(4326008)(22452003)(25786009)(305945005)(6116002)(102836004)(5660300002)(71200400001)(71190400001)(14444005)(26005)(73956011)(66556008)(64756008)(66446008)(66476007)(186003)(36756003)(3846002)(66946007)(6506007)(7736002)(8676002)(81156014)(81166006)(66066001)(2906002)(68736007)(2501003)(10090500001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1145;H:DM6PR21MB1340.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nwrSxzjT2z1O2DIkxuKdKVv1HHBcJz9ThYMHCx4x4zfDtBTqUU8S/LldNWxPAvecfduTgccH4S+9ckY0Bv7Oxvwk4NbZr6KhYb1sxus0/uERws1AIgrDBmeod439Uh4X+l5gKlDDbTVLSXN2Tbn/OpTkdCkZ8kqqXwp/ddL+C0G9cw8xIG1IxiTOugQVY2baqwGXJS3LXwnhVDB6jYOaGotpCjE984aBL1iUkyd7wm65Y9RHTwu7QZgk4bsD4Qq2gFCCFGq1hQeQ79Tq2Z0hng8ykXn1Mk4Wovu2Ix+YORhTU30ZB9+wsFBofkoBuV6SOuvuLt/GGH7uLwGNDWnU4WZ8Rk9ODP6YYnN0ZpWTT1rIARZQ2iAULIccOdyhFIpSeZObnb98caUD2qt7tKtRsMWpRNWmFaCD+ASt+bbTfH4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7da63b7-23c8-47ad-6e38-08d6fbf72a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 18:33:50.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmlmhk@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1145
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgbW92ZXMgSHlwZXItViBjbG9jay90aW1lciBjb2RlIHRvIGEgc2Vw
YXJhdGUgSHlwZXItVg0KY2xvY2tzb3VyY2UgZHJpdmVyLiBQcmV2aW91c2x5LCBIeXBlci1WIGNs
b2NrL3RpbWVyIGNvZGUgYW5kIGRhdGENCnN0cnVjdHVyZXMgd2VyZSBtaXhlZCBpbiB3aXRoIG90
aGVyIEh5cGVyLVYgY29kZSBpbiB0aGUgSVNBIGluZGVwZW5kZW50DQpkcml2ZXJzL2h2IGNvZGUg
YXMgd2VsbCBhcyBpbiBJU0EgZGVwZW5kZW50IGNvZGUuIFRoZSBuZXcgSHlwZXItVg0KY2xvY2tz
b3VyY2UgZHJpdmVyIGlzIElTQSBpbmRlcGVuZGVudCwgd2l0aCBhIGp1c3QgZmV3IGRlcGVuZGVu
Y2llcyBvbg0KSVNBIHNwZWNpZmljIGZ1bmN0aW9ucy4gVGhlIHBhdGNoIHNlcmllcyBkb2VzIG5v
dCBjaGFuZ2UgYW55IGJlaGF2aW9yDQpvciBmdW5jdGlvbmFsaXR5IC0tIGl0IG9ubHkgcmVvcmdh
bml6ZXMgdGhlIGV4aXN0aW5nIGNvZGUgYW5kIGZpeGVzIHVwDQp0aGUgbGlua2FnZXMuIEEgZmV3
IHBsYWNlcyBvdXRzaWRlIG9mIEh5cGVyLVYgY29kZSBhcmUgZml4ZWQgdXAgdG8gdXNlDQp0aGUg
bmV3ICNpbmNsdWRlIGZpbGUgc3RydWN0dXJlLg0KDQpUaGlzIHJlc3RydWN0dXJpbmcgaXMgaW4g
cmVzcG9uc2UgdG8gTWFyYyBaeW5naWVyJ3MgcmV2aWV3IGNvbW1lbnRzDQpvbiBzdXBwb3J0aW5n
IEh5cGVyLVYgcnVubmluZyBvbiBBUk02NCwgYW5kIGlzIGEgZ29vZCBpZGVhIGluIGdlbmVyYWwu
DQpJdCBpbmNyZWFzZXMgdGhlIGFtb3VudCBvZiBjb2RlIHNoYXJlZCBiZXR3ZWVuIHRoZSB4ODYg
YW5kIEFSTTY0DQphcmNoaXRlY3R1cmVzLCBhbmQgcmVkdWNlcyB0aGUgc2l6ZSBvZiB0aGUgbmV3
IGNvZGUgZm9yIHN1cHBvcnRpbmcNCkh5cGVyLVYgb24gQVJNNjQuIEEgbmV3IHZlcnNpb24gb2Yg
dGhlIEh5cGVyLVYgb24gQVJNNjQgcGF0Y2hlcyB3aWxsDQpmb2xsb3cgb25jZSB0aGlzIGNsb2Nr
c291cmNlIHJlc3RydWN0dXJpbmcgaXMgYWNjZXB0ZWQuDQoNClRoZSBjb2RlIGlzIGRpZmYnZWQg
YWdhaW5zdCB0aGUgdXBzdHJlYW0gdGlwIHRyZWU6DQpnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgdGltZXJzL3Zkc28NCg0KQ2hhbmdlcyBp
biB2NDoNCiogUmV2aXNlZCBjb21taXQgbWVzc2FnZXMNCiogUmViYXNlZCB0byB1cHN0cmVhbSB0
aXAgdHJlZQ0KDQpDaGFuZ2VzIGluIHYzOg0KKiBSZW1vdmVkIGJvb2xlYW4gYXJndW1lbnQgdG8g
aHZfaW5pdF9jbG9ja3NvdXJjZSgpLiBBbHdheXMgY2FsbA0Kc2NoZWRfY2xvY2tfcmVnaXN0ZXIs
IHdoaWNoIGlzIG5lZWRlZCBvbiBBUk02NCBidXQgYSBuby1vcCBvbiB4ODYuDQoqIFJlbW92ZWQg
c2VwYXJhdGUgY3B1aHAgc2V0dXAgaW4gaHZfc3RpbWVyX2FsbG9jKCkgYW5kIGluc3RlYWQNCmRp
cmVjdGx5IGNhbGwgaHZfc3RpbWVyX2luaXQoKSBhbmQgaHZfc3RpbWVyX2NsZWFudXAoKSBmcm9t
DQpjb3JyZXNwb25kaW5nIFZNYnVzIGZ1bmN0aW9ucy4gIFRoaXMgbW9yZSBjbG9zZWx5IG1hdGNo
ZXMgb3JpZ2luYWwNCmNvZGUgYW5kIGF2b2lkcyBjbG9ja3NvdXJjZSBzdG9wL3Jlc3RhcnQgcHJv
YmxlbXMgb24gQVJNNjQgd2hlbg0KVk1idXMgY29kZSBkZW5pZXMgQ1BVIG9mZmxpbmluZyByZXF1
ZXN0Lg0KDQpDaGFuZ2VzIGluIHYyOg0KKiBSZXZpc2VkIGNvbW1pdCBzaG9ydCBkZXNjcmlwdGlv
bnMgc28gdGhlIGRpc3RpbmN0aW9uIGJldHdlZW4NCnRoZSBmaXJzdCBhbmQgc2Vjb25kIHBhdGNo
ZXMgaXMgY2xlYXJlciBbR3JlZ0tIXQ0KKiBSZW5hbWVkIG5ldyBjbG9ja3NvdXJjZSBkcml2ZXIg
ZmlsZXMgYW5kIGZ1bmN0aW9ucyB0byB1c2UNCmV4aXN0aW5nICJ0aW1lciIgYW5kICJzdGltZXIi
IG5hbWVzIGluc3RlYWQgb2YgaW50cm9kdWNpbmcNCiJzeW50aW1lciIuIFtWaXRhbHkgS3V6bmV0
c292XQ0KKiBJbnRyb2R1Y2VkIENPTkZJR19IWVBFUl9USU1FUiB0byBmaXggYnVpbGQgcHJvYmxl
bSB3aGVuDQpDT05GSUdfSFlQRVJWPW0gW1ZpdGFseSBLdXpuZXRzb3ZdDQoqIEFkZGVkICJTdWdn
ZXN0ZWQtYnk6IE1hcmMgWnluZ2llciINCg0KTWljaGFlbCBLZWxsZXkgKDIpOg0KICBEcml2ZXJz
OiBodjogQ3JlYXRlIEh5cGVyLVYgY2xvY2tzb3VyY2UgZHJpdmVyIGZyb20gZXhpc3RpbmcNCiAg
ICBjbG9ja2V2ZW50cyBjb2RlDQogIERyaXZlcnM6IGh2OiBNb3ZlIEh5cGVyLVYgY2xvY2tzb3Vy
Y2UgY29kZSB0byBuZXcgY2xvY2tzb3VyY2UgZHJpdmVyDQoNCiBNQUlOVEFJTkVSUyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsNCiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZtYS5j
ICAgICAgICAgICAgICAgIHwgICAyICstDQogYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyAgICAg
ICAgICAgICAgICB8ICA5MSArLS0tLS0tLS0NCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9oeXBlcnYt
dGxmcy5oICAgICAgIHwgICA2ICsNCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oICAg
ICAgICAgIHwgIDgxICsrLS0tLS0tDQogYXJjaC94ODYvaW5jbHVkZS9hc20vdmRzby9nZXR0aW1l
b2ZkYXkuaCB8ICAgMiArLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYyAgICAgICAg
ICAgfCAgIDIgKw0KIGFyY2gveDg2L2t2bS94ODYuYyAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KIGRyaXZlcnMvY2xvY2tzb3VyY2UvTWFrZWZpbGUgICAgICAgICAgICAgfCAgIDEgKw0K
IGRyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMgICAgICAgfCAzMjEgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvaHYvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDMgKw0KIGRyaXZlcnMvaHYvaHYuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAxNTYgKy0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9odi9oeXBlcnZfdm1idXMuaCAgICAg
ICAgICAgICAgICB8ICAgMyAtDQogZHJpdmVycy9odi92bWJ1c19kcnYuYyAgICAgICAgICAgICAg
ICAgICB8ICA0MiArKy0tDQogaW5jbHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaCAgICAg
ICB8IDEwNSArKysrKysrKysrDQogMTUgZmlsZXMgY2hhbmdlZCwgNDgzIGluc2VydGlvbnMoKyks
IDMzNSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbG9ja3NvdXJj
ZS9oeXBlcnZfdGltZXIuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2Nsb2Nrc291cmNl
L2h5cGVydl90aW1lci5oDQoNCi0tIA0KMS44LjMuMQ0KDQo=
