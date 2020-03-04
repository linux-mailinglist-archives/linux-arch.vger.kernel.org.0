Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFD1794B5
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgCDQOy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:14:54 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:49856 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbgCDQOx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:14:53 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G6ZxW027647;
        Wed, 4 Mar 2020 08:14:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=WXoMkNEwEalfB5NFLOCsUY4eDvlrUPdU3JckQHy2fN8=;
 b=qC9nslTA50+k6ib66SUXjzrr3CKsxVO/mvAPOZTkA+lrfbpMkK+JwBqErGnGWaQgFwDA
 WBc7VQoCnUQ7h43AKsbeGVFqMBwF7v64DfW5pocxiohIOrm6fnYCEOCM11zvmguPmc2u
 qer4xLQefUMp8j4QYXoySHQUG7YcFmYxHqxRKW2N94hI8zoqDxwmrDD9eQ6jMeKndifE
 kJOzQvsNSF4S6K2MfXPzr3ZNwtwP0FVGE7Muo3DCyH8iBu0JUA3RItGlPfIPYHxrfMCR
 06awiugg43qTO3vJKN/H1rocMSzca6qX03ebtbuSVcYIIM0kTAjgZgqIkOL38SWZdw2X Aw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4da6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:14:31 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:14:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:14:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaohUtP42cutqTiWw+5QBV4pl7qmEzaLuQrsEykktphKwj+l3Df3bwfRN38ClSXuKZMojGCb97Bc89qm1mrwN/U/nAdjMMjMRv5iVTTrfZWzUTJZpNGl4x97IQwm6Fzium1y5K1CktT8TYLTmUKgipfTqZSOrX3c7XuaFILubVOrwg4X1ioHE7qNaffwwm4cBte5nXUCbbrhvU/zmBPA6C0FupVv3Pv12zImn2WHz3REDAWXMAtsuy8hJmpZJWrfXzLR8Sg5mfb6yUhfleG1pgSd4IUQsWRF0a5djVBnVHhTVAa1//Fg9QNCgPud7cJl/nxvVai4NB8YQjESEEfwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXoMkNEwEalfB5NFLOCsUY4eDvlrUPdU3JckQHy2fN8=;
 b=ZtRhbVMMVzPX7v1bV2cg8R693yWtmj3JUdTCMbKqCEvnaMVU5v39o8IgMvN55kUiPEfBcDQa8VXaVqkjHK0FnXPITu7hEdzdfOZfxynuPcknwntZ4PBY/h/7M0R0nkXm4fdWbOiLJRYGyTTVmVI/g9UKEGMmynrFqqy6Rlrl7aU/9DSOe4W63x6aCjk7DqDDaZAcy4hMD02cJxGlidw8clRM4Q8uC93P5lArSkJzIIk7DO8yiSxfkFR8+DB1IaHlIRKuh5n036V/30C6Zt3aalbpTZH13cTJ5iFIVHb4/D/fqsAszLiwli6uIFpcv5eg60srNdEhNfvmFA3PSqtP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXoMkNEwEalfB5NFLOCsUY4eDvlrUPdU3JckQHy2fN8=;
 b=g7DSi85VSRqPFkwTgn+GVq+TdVbVh3a35pTAPt8Vpyhamafe2zGa6aTqy03YfB3QXnmmrnQpiYWQBgicdyGTmYC+QT7mp1fiIU2qxb/oym3mZwx8hxS/t18qS8DVEktKITYA0ZEhfimWLwspBzEMdMqoBA//kN5G5i+ndcbCYZo=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2727.namprd18.prod.outlook.com (2603:10b6:a03:107::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 16:14:29 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:14:29 +0000
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
Subject: [PATCH 10/12] task_isolation: ringbuffer: don't interrupt CPUs
 running isolated tasks on buffer resize
Thread-Topic: [PATCH 10/12] task_isolation: ringbuffer: don't interrupt CPUs
 running isolated tasks on buffer resize
Thread-Index: AQHV8j/7ALIHiMasDUewTuILAelrGA==
Date:   Wed, 4 Mar 2020 16:14:28 +0000
Message-ID: <426ee885b89985f6bf348d64909eeb6a2cd83162.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13ce92aa-b089-467e-e882-08d7c0571df4
x-ms-traffictypediagnostic: BYAPR18MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB2727DCD201D4A6DCF656516EBCE50@BYAPR18MB2727.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(478600001)(4326008)(26005)(36756003)(6486002)(8676002)(6512007)(8936002)(86362001)(81156014)(6506007)(71200400001)(186003)(81166006)(2616005)(64756008)(66556008)(66476007)(54906003)(110136005)(91956017)(66946007)(76116006)(316002)(66446008)(5660300002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2727;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWbyOHnimLrEptrhaXYr0FmB2PtAsIiIRuj9fBFDKA65i/SnITr3DxxpWwI7E8iCcfPeyoY3UH5+LB27fSYCGKAnVl7+CFkKbAWyNfJ2/ZLNhnCVWQ6s80OGCEv1JrLQ38UhTtm2ecZWjnASY3I+Qwuuzkr4Y6S8/Rr0YHzNI820Z3abmz0pPCaSrs87yoebqOPgKR0xj6nJDVQf4uHLfIswNgE9MQxpRIQFcrjmrXvKLR8zF+mlH0MrTjuyM3boUxpc5jgVitwbWPngun6dhZEL+E4Tw/x7DZCFwCsQNhlRh/O9gu2akhlX8c1vGR+17lZLPA7f0DBZi006m2WLGYo15ycYPSQpKgYOhnOzRbUzy+yUlmsCuxHQVkiJuFBtU712YE8l5JZBEXTMcWM3W7rHsdsURjrvpDTkRq1EEao8Ijaew3ttmtsGL0M8ez5M
x-ms-exchange-antispam-messagedata: XgLjSnZUNhEWr1B+QD9UX23JiQtJLWM07Pi6I4SbOWcHjsdmNrVTkcyfCbw1yk0RA9EaZ5Sw1wwrUC5kYAFbf0+8XOXQZ3XTQd9U1KvCFAagiOPCe1ORqx3stus6Ocl3tGM5tNg79ZXDrO3e6OUqgw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E153F72FDB45B04287EDA1D4247A88EA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ce92aa-b089-467e-e882-08d7c0571df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:14:29.1792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHPb32g3OpHw2CmBvwL+vG3f3gdCGNvuG0NIb/RiZXa3/D/r0WDd4WiCpXmtRa+3pU9DsrfNwDEJ0LNIaDsi8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2727
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpDUFVzIHJ1bm5pbmcgaXNv
bGF0ZWQgdGFza3MgYXJlIGluIHVzZXJzcGFjZSwgc28gdGhleSBkb24ndCBoYXZlIHRvDQpwZXJm
b3JtIHJpbmcgYnVmZmVyIHVwZGF0ZXMgaW1tZWRpYXRlbHkuIElmIHJpbmdfYnVmZmVyX3Jlc2l6
ZSgpDQpzY2hlZHVsZXMgdGhlIHVwZGF0ZSBvbiB0aG9zZSBDUFVzLCBpc29sYXRpb24gaXMgYnJv
a2VuLiBUbyBwcmV2ZW50DQp0aGF0LCB1cGRhdGVzIGZvciBDUFVzIHJ1bm5pbmcgaXNvbGF0ZWQg
dGFza3MgYXJlIHBlcmZvcm1lZCBsb2NhbGx5LA0KbGlrZSBmb3Igb2ZmbGluZSBDUFVzLg0KDQpB
IHJhY2UgY29uZGl0aW9uIGJldHdlZW4gdGhpcyB1cGRhdGUgYW5kIGlzb2xhdGlvbiBicmVha2lu
ZyBpcyBhdm9pZGVkDQphdCB0aGUgY29zdCBvZiBkaXNhYmxpbmcgcGVyX2NwdSBidWZmZXIgd3Jp
dGluZyBmb3IgdGhlIHRpbWUgb2YgdXBkYXRlDQp3aGVuIGl0IGNvaW5jaWRlcyB3aXRoIGlzb2xh
dGlvbiBicmVha2luZy4NCg0KU2lnbmVkLW9mZi1ieTogQWxleCBCZWxpdHMgPGFiZWxpdHNAbWFy
dmVsbC5jb20+DQotLS0NCiBrZXJuZWwvdHJhY2UvcmluZ19idWZmZXIuYyB8IDYxICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDU1IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2Uvcmlu
Z19idWZmZXIuYyBiL2tlcm5lbC90cmFjZS9yaW5nX2J1ZmZlci5jDQppbmRleCA2MWYwZTkyYWNl
OTkuLjZjNzQ3OWI2NDExZCAxMDA2NDQNCi0tLSBhL2tlcm5lbC90cmFjZS9yaW5nX2J1ZmZlci5j
DQorKysgYi9rZXJuZWwvdHJhY2UvcmluZ19idWZmZXIuYw0KQEAgLTIxLDYgKzIxLDcgQEANCiAj
aW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNs
dWRlIDxsaW51eC9pbml0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2lzb2xhdGlvbi5oPg0KICNpbmNs
dWRlIDxsaW51eC9oYXNoLmg+DQogI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCiAjaW5jbHVkZSA8
bGludXgvY3B1Lmg+DQpAQCAtMTcwMSw2ICsxNzAyLDM3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9w
YWdlc19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCiAJY29tcGxldGUoJmNwdV9i
dWZmZXItPnVwZGF0ZV9kb25lKTsNCiB9DQogDQorc3RhdGljIGJvb2wgdXBkYXRlX2lmX2lzb2xh
dGVkKHN0cnVjdCByaW5nX2J1ZmZlcl9wZXJfY3B1ICpjcHVfYnVmZmVyLA0KKwkJCSAgICAgICBp
bnQgY3B1KQ0KK3sNCisJYm9vbCBydiA9IGZhbHNlOw0KKw0KKwlpZiAodGFza19pc29sYXRpb25f
b25fY3B1KGNwdSkpIHsNCisJCS8qDQorCQkgKiBDUFUgaXMgcnVubmluZyBpc29sYXRlZCB0YXNr
LiBTaW5jZSBpdCBtYXkgbG9zZQ0KKwkJICogaXNvbGF0aW9uIGFuZCByZS1lbnRlciBrZXJuZWwg
c2ltdWx0YW5lb3VzbHkgd2l0aA0KKwkJICogdGhpcyB1cGRhdGUsIGRpc2FibGUgcmVjb3JkaW5n
IHVudGlsIGl0J3MgZG9uZS4NCisJCSAqLw0KKwkJYXRvbWljX2luYygmY3B1X2J1ZmZlci0+cmVj
b3JkX2Rpc2FibGVkKTsNCisJCS8qIE1ha2Ugc3VyZSwgdXBkYXRlIGlzIGRvbmUsIGFuZCBpc29s
YXRpb24gc3RhdGUgaXMgY3VycmVudCAqLw0KKwkJc21wX21iKCk7DQorCQlpZiAodGFza19pc29s
YXRpb25fb25fY3B1KGNwdSkpIHsNCisJCQkvKg0KKwkJCSAqIElmIENQVSBpcyBzdGlsbCBydW5u
aW5nIGlzb2xhdGVkIHRhc2ssIHdlDQorCQkJICogY2FuIGJlIHN1cmUgdGhhdCBicmVha2luZyBp
c29sYXRpb24gd2lsbA0KKwkJCSAqIGhhcHBlbiB3aGlsZSByZWNvcmRpbmcgaXMgZGlzYWJsZWQs
IGFuZCBDUFUNCisJCQkgKiB3aWxsIG5vdCB0b3VjaCB0aGlzIGJ1ZmZlciB1bnRpbCB0aGUgdXBk
YXRlDQorCQkJICogaXMgZG9uZS4NCisJCQkgKi8NCisJCQlyYl91cGRhdGVfcGFnZXMoY3B1X2J1
ZmZlcik7DQorCQkJY3B1X2J1ZmZlci0+bnJfcGFnZXNfdG9fdXBkYXRlID0gMDsNCisJCQlydiA9
IHRydWU7DQorCQl9DQorCQlhdG9taWNfZGVjKCZjcHVfYnVmZmVyLT5yZWNvcmRfZGlzYWJsZWQp
Ow0KKwl9DQorCXJldHVybiBydjsNCit9DQorDQogLyoqDQogICogcmluZ19idWZmZXJfcmVzaXpl
IC0gcmVzaXplIHRoZSByaW5nIGJ1ZmZlcg0KICAqIEBidWZmZXI6IHRoZSBidWZmZXIgdG8gcmVz
aXplLg0KQEAgLTE3ODQsMTMgKzE4MTYsMjIgQEAgaW50IHJpbmdfYnVmZmVyX3Jlc2l6ZShzdHJ1
Y3QgdHJhY2VfYnVmZmVyICpidWZmZXIsIHVuc2lnbmVkIGxvbmcgc2l6ZSwNCiAJCQlpZiAoIWNw
dV9idWZmZXItPm5yX3BhZ2VzX3RvX3VwZGF0ZSkNCiAJCQkJY29udGludWU7DQogDQotCQkJLyog
Q2FuJ3QgcnVuIHNvbWV0aGluZyBvbiBhbiBvZmZsaW5lIENQVS4gKi8NCisJCQkvKg0KKwkJCSAq
IENhbid0IHJ1biBzb21ldGhpbmcgb24gYW4gb2ZmbGluZSBDUFUuDQorCQkJICoNCisJCQkgKiBD
UFVzIHJ1bm5pbmcgaXNvbGF0ZWQgdGFza3MgZG9uJ3QgaGF2ZSB0bw0KKwkJCSAqIHVwZGF0ZSBy
aW5nIGJ1ZmZlcnMgdW50aWwgdGhleSBleGl0DQorCQkJICogaXNvbGF0aW9uIGJlY2F1c2UgdGhl
eSBhcmUgaW4NCisJCQkgKiB1c2Vyc3BhY2UuIFVzZSB0aGUgcHJvY2VkdXJlIHRoYXQgcHJldmVu
dHMNCisJCQkgKiByYWNlIGNvbmRpdGlvbiB3aXRoIGlzb2xhdGlvbiBicmVha2luZy4NCisJCQkg
Ki8NCiAJCQlpZiAoIWNwdV9vbmxpbmUoY3B1KSkgew0KIAkJCQlyYl91cGRhdGVfcGFnZXMoY3B1
X2J1ZmZlcik7DQogCQkJCWNwdV9idWZmZXItPm5yX3BhZ2VzX3RvX3VwZGF0ZSA9IDA7DQogCQkJ
fSBlbHNlIHsNCi0JCQkJc2NoZWR1bGVfd29ya19vbihjcHUsDQotCQkJCQkJJmNwdV9idWZmZXIt
PnVwZGF0ZV9wYWdlc193b3JrKTsNCisJCQkJaWYgKCF1cGRhdGVfaWZfaXNvbGF0ZWQoY3B1X2J1
ZmZlciwgY3B1KSkNCisJCQkJCXNjaGVkdWxlX3dvcmtfb24oY3B1LA0KKwkJCQkJJmNwdV9idWZm
ZXItPnVwZGF0ZV9wYWdlc193b3JrKTsNCiAJCQl9DQogCQl9DQogDQpAQCAtMTgyOSwxMyArMTg3
MCwyMiBAQCBpbnQgcmluZ19idWZmZXJfcmVzaXplKHN0cnVjdCB0cmFjZV9idWZmZXIgKmJ1ZmZl
ciwgdW5zaWduZWQgbG9uZyBzaXplLA0KIA0KIAkJZ2V0X29ubGluZV9jcHVzKCk7DQogDQotCQkv
KiBDYW4ndCBydW4gc29tZXRoaW5nIG9uIGFuIG9mZmxpbmUgQ1BVLiAqLw0KKwkJLyoNCisJCSAq
IENhbid0IHJ1biBzb21ldGhpbmcgb24gYW4gb2ZmbGluZSBDUFUuDQorCQkgKg0KKwkJICogQ1BV
cyBydW5uaW5nIGlzb2xhdGVkIHRhc2tzIGRvbid0IGhhdmUgdG8gdXBkYXRlDQorCQkgKiByaW5n
IGJ1ZmZlcnMgdW50aWwgdGhleSBleGl0IGlzb2xhdGlvbiBiZWNhdXNlIHRoZXkNCisJCSAqIGFy
ZSBpbiB1c2Vyc3BhY2UuIFVzZSB0aGUgcHJvY2VkdXJlIHRoYXQgcHJldmVudHMNCisJCSAqIHJh
Y2UgY29uZGl0aW9uIHdpdGggaXNvbGF0aW9uIGJyZWFraW5nLg0KKwkJICovDQogCQlpZiAoIWNw
dV9vbmxpbmUoY3B1X2lkKSkNCiAJCQlyYl91cGRhdGVfcGFnZXMoY3B1X2J1ZmZlcik7DQogCQll
bHNlIHsNCi0JCQlzY2hlZHVsZV93b3JrX29uKGNwdV9pZCwNCisJCQlpZiAoIXVwZGF0ZV9pZl9p
c29sYXRlZChjcHVfYnVmZmVyLCBjcHVfaWQpKQ0KKwkJCQlzY2hlZHVsZV93b3JrX29uKGNwdV9p
ZCwNCiAJCQkJCSAmY3B1X2J1ZmZlci0+dXBkYXRlX3BhZ2VzX3dvcmspOw0KLQkJCXdhaXRfZm9y
X2NvbXBsZXRpb24oJmNwdV9idWZmZXItPnVwZGF0ZV9kb25lKTsNCisJCQkJd2FpdF9mb3JfY29t
cGxldGlvbigmY3B1X2J1ZmZlci0+dXBkYXRlX2RvbmUpOw0KKwkJCX0NCiAJCX0NCiANCiAJCWNw
dV9idWZmZXItPm5yX3BhZ2VzX3RvX3VwZGF0ZSA9IDA7DQotLSANCjIuMjAuMQ0KDQo=
