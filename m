Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF6179452
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgCDQEA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:04:00 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57500 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbgCDQD7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:03:59 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G0Kxt019967;
        Wed, 4 Mar 2020 08:03:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=6Ia5hejk1p7fo1vsqEEg4rbEQ2G5bHK728yKEil991s=;
 b=jjWbqRmFLVE2EZ4aA+er6bE7sD0S9n3V+XO1fOd9pv/ui7x6RsOjyawOchQAgYbIUmOV
 edmuw6hw8vTe570HMcWPTVo16X2/gJ7nsNMG2oyVvrN6NH4yqZzsOo5iDNAQiFieLU3y
 7/CeY2p7czemKtmrf33sGlp4DAg6a3ClYSRQ9Dq8Wp0hXRBWylnPdhG3CIKyradQhTne
 ZZj4aGs3EJPiwYvRbBftn3UGL69FcFU+h+ey06enkeAZ1z1vOwZ/Q2tgxkLTols05JC8
 x2IES80miaS0nKIQyR2q+DX4rb2boOCJUDkxZr4TrBP8SJwQpRov4YJtYnLE0sJcvS1L TA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4d6n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:03:36 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:03:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:03:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNvSOT/2Kz3WEW3XkYUjNSvj6U70C2sigjT6hP19iGIelZj2Q/CJeu8ykCGxhjCXwjeudm1neztyJUo8cT2cWszCxwUqHLYl7LkNBVxePZMT5zyCK/ARvjHdx66AXSs+sBCyS+8tpyrj5dYSikRamTcbHGBV6p5Xfz7kiiRPJ/VWX/9GAdsWjuINjXofm8Ir/IrA/wFliEyBAc+umIIzaBZcZrA9fmsiJmyVdNVkjTfcXuMMdVG3G0mxxigoomjbgbCzVnYMxoxhqvMlxqAycFDkp0LDJR5GOuSW2OMsckBWAcKU9JgYWb4Y7P8eNtGSWwIg5wd+vlm1Ns3U1x0gdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ia5hejk1p7fo1vsqEEg4rbEQ2G5bHK728yKEil991s=;
 b=I9gFy61hw7Z7d7jfSimWEJsD5CyKjpDgQcsu3dwqQGvNPJvcI1OjIZ2A/152NrRJncMmJAuI7AJiqT1Pi8BZB4kRNhABr9b3h5MPVm9SNlCLtHmbX4Cmdax1zzN8tfwUKu8bUhJamK1Q+7FYo1j7e9Fl3+hVhUW0v8diuybn+dIswlNic4yE4qpvA2aBoo1URGQ1lOPz2O9zypqfOO3EHAurChxtLuUfOjXjFFgJ1FnhLhSaeueDLhi3f8XfcSVFASM35TppWx5G4KX8rYMNxJDWE0CwkZ/5SjO49P/DsuubteHs/CfB54R8u1Hk6xOP40ppi1sQbCnju0JBPivQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ia5hejk1p7fo1vsqEEg4rbEQ2G5bHK728yKEil991s=;
 b=DIL3kR9zZI4jOxDE85ztBM9IXVKdcfFwljEJELk3jF+VY911FdE38zjb5RDJoMoib7G7YnW17s7Q+USYFqBjjLGDV2HQoE69SRFzFG/D8hqAnh2ANAfgIJLqPESJkdl8mvurBRqBQ7VE+l97c2O2XQikUi7/zX8q8Twh7Pkf8R0=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2695.namprd18.prod.outlook.com (2603:10b6:a03:10a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 16:03:33 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:03:33 +0000
From:   Alex Belits <abelits@marvell.com>
To:     "frederic@kernel.org" <frederic@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH 01/12] task_isolation: vmstat: add quiet_vmstat_sync function
Thread-Topic: [PATCH 01/12] task_isolation: vmstat: add quiet_vmstat_sync
 function
Thread-Index: AQHV8j500OMS/2K1JkC9DzqFQP/fyQ==
Date:   Wed, 4 Mar 2020 16:03:33 +0000
Message-ID: <2d4bc017d5b7d2f176bd7c0045d8d3a52f550d67.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6406fbc2-7ab6-4d70-5718-08d7c05596e9
x-ms-traffictypediagnostic: BYAPR18MB2695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB26951D56B88E426278175211BCE50@BYAPR18MB2695.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(91956017)(66946007)(86362001)(478600001)(66446008)(64756008)(66556008)(2906002)(66476007)(76116006)(6486002)(6506007)(6512007)(5660300002)(8676002)(4326008)(54906003)(26005)(81166006)(2616005)(36756003)(81156014)(110136005)(186003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2695;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1+yVTBmqxYs/dinkYHXM2yeDVMinQv2K2Uep2KfR+8ITlqAbGvVUwzr1mJhvlWcla4fR2aLj+RHKpLVOI1yO3k+VLF3j7OZr8l4sA82+AfTS9z2QO1rOt/+xi0meWO80O6+jCClKv0Uyngd+ZZXnVUpI0aROUiTrKH/qsfQEpmKqAKirHapqQtnOyl7C9JjNpydl52yM97jOnI2QeHiT63O9CEA9WdjtXRjypVATVIePOBnQNDmfzw4iE9HI9Bfk2bDKsDSQNGlUyBt9oGxif63cIMCWCXH7eozFMfIsHgZwFUhQXRv3gRyd79MwTIItAwcz68wj2SWfQb22mqX9qWY7qvsvLD8YnwQmOMV6e1pg1dR/3NVGmjBJIwb1Y7IZAfTrrLZ90dsupUjn84EwjZo9StORii3IFNlsLleIMk8U/btkSn8E8PJ3HW6tkVz
x-ms-exchange-antispam-messagedata: jQ17sTQBGOh/QBdvkakY3P5crLRU7GXSERA9TAQChEroQuz2HRy5yXtYige6T1aUmHjr40eC9OQuR20Arxk1TLYjOATi0bY9WQB4q3/2RcLVT6tNiSmudCWnSNIRDKVzSRkIPyN9JbJyQtm6qWLHWA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C07494FD0D486344BF2763B91FC2091C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6406fbc2-7ab6-4d70-5718-08d7c05596e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:03:33.1213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceUXsSZ19gUcptd5jXXDuF2H3vIkAWAP1yR12Nv+6rtbt7+mwgZb78bgfxc8b35eGwPlH+wpQeX85SfK1BpcFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2695
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQ2hyaXMgTWV0Y2FsZiA8Y21ldGNhbGZAbWVsbGFub3guY29tPg0KDQpJbiBjb21taXQg
ZjAxZjE3ZDM3MDViICgibW0sIHZtc3RhdDogbWFrZSBxdWlldF92bXN0YXQgbGlnaHRlciIpDQp0
aGUgcXVpZXRfdm1zdGF0KCkgZnVuY3Rpb24gYmVjYW1lIGFzeW5jaHJvbm91cywgaW4gdGhlIHNl
bnNlIHRoYXQNCnRoZSB2bXN0YXQgd29yayB3YXMgc3RpbGwgc2NoZWR1bGVkIHRvIHJ1biBvbiB0
aGUgY29yZSB3aGVuIHRoZQ0KZnVuY3Rpb24gcmV0dXJuZWQuICBGb3IgdGFzayBpc29sYXRpb24s
IHdlIG5lZWQgYSBzeW5jaHJvbm91cw0KdmVyc2lvbiBvZiB0aGUgZnVuY3Rpb24gdGhhdCBndWFy
YW50ZWVzIHRoYXQgdGhlIHZtc3RhdCB3b3JrZXINCndpbGwgbm90IHJ1biBvbiB0aGUgY29yZSBv
biByZXR1cm4gZnJvbSB0aGUgZnVuY3Rpb24uICBBZGQgYQ0KcXVpZXRfdm1zdGF0X3N5bmMoKSBm
dW5jdGlvbiB3aXRoIHRoYXQgc2VtYW50aWMuDQoNClNpZ25lZC1vZmYtYnk6IEFsZXggQmVsaXRz
IDxhYmVsaXRzQG1hcnZlbGwuY29tPg0KLS0tDQogaW5jbHVkZS9saW51eC92bXN0YXQuaCB8IDIg
KysNCiBtbS92bXN0YXQuYyAgICAgICAgICAgIHwgOSArKysrKysrKysNCiAyIGZpbGVzIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdm1zdGF0
LmggYi9pbmNsdWRlL2xpbnV4L3Ztc3RhdC5oDQppbmRleCAyOTI0ODVmM2QyNGQuLjJiYzVlODVm
MjUxNCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvdm1zdGF0LmgNCisrKyBiL2luY2x1ZGUv
bGludXgvdm1zdGF0LmgNCkBAIC0yNzAsNiArMjcwLDcgQEAgZXh0ZXJuIHZvaWQgX19kZWNfem9u
ZV9zdGF0ZShzdHJ1Y3Qgem9uZSAqLCBlbnVtIHpvbmVfc3RhdF9pdGVtKTsNCiBleHRlcm4gdm9p
ZCBfX2RlY19ub2RlX3N0YXRlKHN0cnVjdCBwZ2xpc3RfZGF0YSAqLCBlbnVtIG5vZGVfc3RhdF9p
dGVtKTsNCiANCiB2b2lkIHF1aWV0X3Ztc3RhdCh2b2lkKTsNCit2b2lkIHF1aWV0X3Ztc3RhdF9z
eW5jKHZvaWQpOw0KIHZvaWQgY3B1X3ZtX3N0YXRzX2ZvbGQoaW50IGNwdSk7DQogdm9pZCByZWZy
ZXNoX3pvbmVfc3RhdF90aHJlc2hvbGRzKHZvaWQpOw0KIA0KQEAgLTM3Miw2ICszNzMsNyBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgX19kZWNfbm9kZV9wYWdlX3N0YXRlKHN0cnVjdCBwYWdlICpwYWdl
LA0KIHN0YXRpYyBpbmxpbmUgdm9pZCByZWZyZXNoX3pvbmVfc3RhdF90aHJlc2hvbGRzKHZvaWQp
IHsgfQ0KIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfdm1fc3RhdHNfZm9sZChpbnQgY3B1KSB7IH0N
CiBzdGF0aWMgaW5saW5lIHZvaWQgcXVpZXRfdm1zdGF0KHZvaWQpIHsgfQ0KK3N0YXRpYyBpbmxp
bmUgdm9pZCBxdWlldF92bXN0YXRfc3luYyh2b2lkKSB7IH0NCiANCiBzdGF0aWMgaW5saW5lIHZv
aWQgZHJhaW5fem9uZXN0YXQoc3RydWN0IHpvbmUgKnpvbmUsDQogCQkJc3RydWN0IHBlcl9jcHVf
cGFnZXNldCAqcHNldCkgeyB9DQpkaWZmIC0tZ2l0IGEvbW0vdm1zdGF0LmMgYi9tbS92bXN0YXQu
Yw0KaW5kZXggNzhkNTMzNzhkYjk5Li4xZmEwYjJkMDRhZmEgMTAwNjQ0DQotLS0gYS9tbS92bXN0
YXQuYw0KKysrIGIvbW0vdm1zdGF0LmMNCkBAIC0xODcwLDYgKzE4NzAsMTUgQEAgdm9pZCBxdWll
dF92bXN0YXQodm9pZCkNCiAJcmVmcmVzaF9jcHVfdm1fc3RhdHMoZmFsc2UpOw0KIH0NCiANCisv
Kg0KKyAqIFN5bmNocm9ub3VzbHkgcXVpZXQgdm1zdGF0IHNvIHRoZSB3b3JrIGlzIGd1YXJhbnRl
ZWQgbm90IHRvIHJ1biBvbiByZXR1cm4uDQorICovDQordm9pZCBxdWlldF92bXN0YXRfc3luYyh2
b2lkKQ0KK3sNCisJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKHRoaXNfY3B1X3B0cigmdm1zdGF0
X3dvcmspKTsNCisJcmVmcmVzaF9jcHVfdm1fc3RhdHMoZmFsc2UpOw0KK30NCisNCiAvKg0KICAq
IFNoZXBoZXJkIHdvcmtlciB0aHJlYWQgdGhhdCBjaGVja3MgdGhlDQogICogZGlmZmVyZW50aWFs
cyBvZiBwcm9jZXNzb3JzIHRoYXQgaGF2ZSB0aGVpciB3b3JrZXINCi0tIA0KMi4yMC4xDQoNCg==
