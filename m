Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32BD1794C8
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbgCDQQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:16:46 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:48278 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgCDQQq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:16:46 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G515n008120;
        Wed, 4 Mar 2020 08:16:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=QqX6DBmhSYAp+Ek6zwjJxp8jOQpdgd0MftEbnabeMYM=;
 b=XVyAx5f5ucDprzGkRKf+v8ywR8w73lMqJN99G9cbaq75hlu9RYrmxWSn5JNTGrjfra0h
 SioIxO42nZ6ZGcKN0c7B1WVAWxMPC2bNdyJI9C6/rk3n8DSl+zfjYdWA8YYF1tykMmiu
 q72dBnP4n3eEwhPhjy2xMn7lu0ViDgjiPjaWQ3Gwb1aRlx+iH8BEAispCFmECOtRUNak
 NWUB6nXUBA/qeZ7WLFe6guYLJWltFqzJi40yMrAQEj/B0r8iiMlHz4Ifq1Nv5s+ah1jt
 mufJGNUXYBKeY/xby7J8wxveIthoLBffUp/OyL+wp1CZNWlt7tQT8ZsIhISno9OEYFW2 kw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0y0f7u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:16:23 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:16:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:16:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5Q8TNg/sCeBUCocYmwVVhJlo8QAQsgr+0xUfGHzcz9yboSJ7rdWp2aHsF77QRtdKLcJ0HiGw+XcqRdsyO0lujhNe5lf1GKuslNKUo3p7LasxlbdtXh1JXz0kTSG0as2KjjNrDxL+iSpeEvloinz5KRp/1lDbwfJZTiL2xKtsIN2/rUZraiu5km2e171vr21RSI8ljsvqz6rh9LeVIOuXrZygwiYtwCqvFB6l97qApryLcobM8UJ5HdCt1VEEI8zpxDMtMjp0ePuzIrh7LqYimMGTzgop+uSIKxd8ha4kgAOyoAAjGFr9s8EFt/enq1DnOM1QdmODuIBm9vX4qc75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqX6DBmhSYAp+Ek6zwjJxp8jOQpdgd0MftEbnabeMYM=;
 b=m/F4uwENtOLaAR27fBIxF9JSUA9zVUIVn8nqwGzRw1YtqQOH21L1Cb68EkPTbkiGfZgvvpN8pK+ZPa1ZhqxCGPySuc0BqI16JADx7FbGwB3oarEyxCq68Tbfgj+dBqQtJlTjKCpRJTPAwLZ88CRwwkODh5yCq53FkH6UBY74kZyNcXBnBoRLiT507mHiaOibXf/OzKi3YTezx9VZqXGRaSbYq0U6H3cN0j3c1oZ1wc6IUnvQ9BpAFy5quZ13EUGH+eyB0YbzJoi40CWiBf4TEltcVccfBQ2ntnkOE8nIf2Uagi4QxEU62/TuziijyoSkTSdgnp6+pBBg3iUrSVMvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqX6DBmhSYAp+Ek6zwjJxp8jOQpdgd0MftEbnabeMYM=;
 b=TkBS7vTHV0UXSkH7AGsqmozSmGuckaw6FOwaxNF/wsDy45YddxMldY1qRiIjhCDw/QoWdF3Ss4iowX9UUaKcsHembnMCT1/k5u+v/iKbqvs0Jo/Qt6jNinXS9C0soG+c/5Ge8QVBNSRR2uS6IlnZdqmyMSt25Ruo1j9RBIyRsws=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2727.namprd18.prod.outlook.com (2603:10b6:a03:107::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 16:16:19 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:16:19 +0000
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
Subject: [PATCH 12/12] task_isolation: CONFIG_TASK_ISOLATION prevents
 distribution of jobs to non-housekeeping CPUs
Thread-Topic: [PATCH 12/12] task_isolation: CONFIG_TASK_ISOLATION prevents
 distribution of jobs to non-housekeeping CPUs
Thread-Index: AQHV8kA8ktv8P3VeKkibLdJwQ2up2Q==
Date:   Wed, 4 Mar 2020 16:16:19 +0000
Message-ID: <3500c34366f3857329709e155b44d5a7d9af6e05.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d27dbcf3-3215-45a2-49e4-08d7c0575f8d
x-ms-traffictypediagnostic: BYAPR18MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB2727EE08753EF6BC73F0E71CBCE50@BYAPR18MB2727.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(478600001)(4326008)(26005)(36756003)(6486002)(8676002)(6512007)(8936002)(86362001)(81156014)(6506007)(71200400001)(186003)(81166006)(2616005)(64756008)(66556008)(66476007)(54906003)(110136005)(91956017)(66946007)(76116006)(316002)(66446008)(5660300002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2727;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nKw2PC4oqYhfoPtujZGEn0BRLRwtza/g6AK0gaiEzEvKJE5Ojcr9+0ucRJnLoUMk09RIGwRvt9yiG8VEjWWR5yzyZWvJLUOS0GdnVy+lri5DZ4CXSVboe7xzFGXl4sov4UC+deIG6QyNmoDdLHiGsGZWP5OK8DRopLKH8MrohRxTUXW/jR5Y1e+e6gHfNgtxfgEipEaU06cXHhMZszjekLcxoeDX6rDaX2q2MhADaPzILP0QI6fLO/oTAz90R5R9kSYBCyKRYOiQw6to7N2m+kPrMxn3G2exx/Z1q3URUIMS6Gb9KCZLzRrsWEyAYohrUmU5aEmejzB7WDFtTlA7SpU0BZRXJYPki5xynlY2vJVeYh8eRFUKclkyPe+ZjpPuTrLuW3COclNX6luIxfP+BCxrx4s4ymNkUobVIDXyZarzmrBVRV7t/Cc5zmiT4YT
x-ms-exchange-antispam-messagedata: a3h/x+u7d2gzJBXmStBZq7nuNF/IkNy9PHANbCpB/ayMVga/ux7MR5pnuaAAvJX3ehJwdLgW6mgwLNWwQMkW9xjLQsuInfXS5h1SyMEwanP2TwBDOErxUdhJWWCtGYnBOmHEgE1mPdvXx/cWBou+VQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <442E99C77B4B724185C9969BC3397046@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d27dbcf3-3215-45a2-49e4-08d7c0575f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:16:19.2148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ok8MwBH41hlQH8xntXRyysBoO75qnDsNX9KT2OWE+X0FwAy8+OQZ5yTHgy7HfMc087MmZOCv/HjUsV/lt/HUfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2727
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VGhlcmUgYXJlIHZhcmlvdXMgbWVjaGFuaXNtcyB0aGF0IHNlbGVjdCBDUFVzIGZvciBqb2JzIG90
aGVyIHRoYW4NCnJlZ3VsYXIgd29ya3F1ZXVlIHNlbGVjdGlvbi4gQ1BVIGlzb2xhdGlvbiBub3Jt
YWxseSBkb2VzIG5vdA0KcHJldmVudCB0aG9zZSBqb2JzIGZyb20gcnVubmluZyBvbiBpc29sYXRl
ZCBDUFVzLiBXaGVuIHRhc2sNCmlzb2xhdGlvbiBpcyBlbmFibGVkIHRob3NlIGpvYnMgc2hvdWxk
IGJlIGxpbWl0ZWQgdG8gaG91c2VrZWVwaW5nDQpDUFVzLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGV4
IEJlbGl0cyA8YWJlbGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcGNpL3BjaS1kcml2
ZXIuYyB8ICA5ICsrKysrKysNCiBsaWIvY3B1bWFzay5jICAgICAgICAgICAgfCA1MyArKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQogbmV0L2NvcmUvbmV0LXN5c2ZzLmMg
ICAgIHwgIDkgKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMjAg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMgYi9k
cml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMNCmluZGV4IDA0NTRjYTBlNGUzZi4uY2I4NzJjZGQxNzgy
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvcGNpLWRyaXZlci5jDQorKysgYi9kcml2ZXJzL3Bj
aS9wY2ktZHJpdmVyLmMNCkBAIC0xMiw2ICsxMiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3N0cmlu
Zy5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+
DQorI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2lzb2xhdGlvbi5oPg0KICNpbmNsdWRlIDxsaW51eC9j
cHUuaD4NCiAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KICNpbmNsdWRlIDxsaW51eC9z
dXNwZW5kLmg+DQpAQCAtMzMyLDYgKzMzMyw5IEBAIHN0YXRpYyBib29sIHBjaV9waHlzZm5faXNf
cHJvYmVkKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQogc3RhdGljIGludCBwY2lfY2FsbF9wcm9iZShz
dHJ1Y3QgcGNpX2RyaXZlciAqZHJ2LCBzdHJ1Y3QgcGNpX2RldiAqZGV2LA0KIAkJCSAgY29uc3Qg
c3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQ0KIHsNCisjaWZkZWYgQ09ORklHX1RBU0tfSVNPTEFU
SU9ODQorCWludCBoa19mbGFncyA9IEhLX0ZMQUdfRE9NQUlOIHwgSEtfRkxBR19XUTsNCisjZW5k
aWYNCiAJaW50IGVycm9yLCBub2RlLCBjcHU7DQogCXN0cnVjdCBkcnZfZGV2X2FuZF9pZCBkZGkg
PSB7IGRydiwgZGV2LCBpZCB9Ow0KIA0KQEAgLTM1Myw3ICszNTcsMTIgQEAgc3RhdGljIGludCBw
Y2lfY2FsbF9wcm9iZShzdHJ1Y3QgcGNpX2RyaXZlciAqZHJ2LCBzdHJ1Y3QgcGNpX2RldiAqZGV2
LA0KIAkgICAgcGNpX3BoeXNmbl9pc19wcm9iZWQoZGV2KSkNCiAJCWNwdSA9IG5yX2NwdV9pZHM7
DQogCWVsc2UNCisjaWZkZWYgQ09ORklHX1RBU0tfSVNPTEFUSU9ODQorCQljcHUgPSBjcHVtYXNr
X2FueV9hbmQoY3B1bWFza19vZl9ub2RlKG5vZGUpLA0KKwkJCQkgICAgICBob3VzZWtlZXBpbmdf
Y3B1bWFzayhoa19mbGFncykpOw0KKyNlbHNlDQogCQljcHUgPSBjcHVtYXNrX2FueV9hbmQoY3B1
bWFza19vZl9ub2RlKG5vZGUpLCBjcHVfb25saW5lX21hc2spOw0KKyNlbmRpZg0KIA0KIAlpZiAo
Y3B1IDwgbnJfY3B1X2lkcykNCiAJCWVycm9yID0gd29ya19vbl9jcHUoY3B1LCBsb2NhbF9wY2lf
cHJvYmUsICZkZGkpOw0KZGlmZiAtLWdpdCBhL2xpYi9jcHVtYXNrLmMgYi9saWIvY3B1bWFzay5j
DQppbmRleCAwY2I2NzJlYjEwN2MuLmRjYmMzMGE0NzYwMCAxMDA2NDQNCi0tLSBhL2xpYi9jcHVt
YXNrLmMNCisrKyBiL2xpYi9jcHVtYXNrLmMNCkBAIC02LDYgKzYsNyBAQA0KICNpbmNsdWRlIDxs
aW51eC9leHBvcnQuaD4NCiAjaW5jbHVkZSA8bGludXgvbWVtYmxvY2suaD4NCiAjaW5jbHVkZSA8
bGludXgvbnVtYS5oPg0KKyNpbmNsdWRlIDxsaW51eC9zY2hlZC9pc29sYXRpb24uaD4NCiANCiAv
KioNCiAgKiBjcHVtYXNrX25leHQgLSBnZXQgdGhlIG5leHQgY3B1IGluIGEgY3B1bWFzaw0KQEAg
LTIwNSwyOCArMjA2LDQwIEBAIHZvaWQgX19pbml0IGZyZWVfYm9vdG1lbV9jcHVtYXNrX3Zhcihj
cHVtYXNrX3Zhcl90IG1hc2spDQogICovDQogdW5zaWduZWQgaW50IGNwdW1hc2tfbG9jYWxfc3By
ZWFkKHVuc2lnbmVkIGludCBpLCBpbnQgbm9kZSkNCiB7DQotCWludCBjcHU7DQorCWNvbnN0IHN0
cnVjdCBjcHVtYXNrICptYXNrOw0KKwlpbnQgY3B1LCBtLCBuOw0KKw0KKyNpZmRlZiBDT05GSUdf
VEFTS19JU09MQVRJT04NCisJbWFzayA9IGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX0ZMQUdfRE9N
QUlOKTsNCisJbSA9IGNwdW1hc2tfd2VpZ2h0KG1hc2spOw0KKyNlbHNlDQorCW1hc2sgPSBjcHVf
b25saW5lX21hc2s7DQorCW0gPSBudW1fb25saW5lX2NwdXMoKTsNCisjZW5kaWYNCiANCiAJLyog
V3JhcDogd2UgYWx3YXlzIHdhbnQgYSBjcHUuICovDQotCWkgJT0gbnVtX29ubGluZV9jcHVzKCk7
DQotDQotCWlmIChub2RlID09IE5VTUFfTk9fTk9ERSkgew0KLQkJZm9yX2VhY2hfY3B1KGNwdSwg
Y3B1X29ubGluZV9tYXNrKQ0KLQkJCWlmIChpLS0gPT0gMCkNCi0JCQkJcmV0dXJuIGNwdTsNCi0J
fSBlbHNlIHsNCi0JCS8qIE5VTUEgZmlyc3QuICovDQotCQlmb3JfZWFjaF9jcHVfYW5kKGNwdSwg
Y3B1bWFza19vZl9ub2RlKG5vZGUpLCBjcHVfb25saW5lX21hc2spDQotCQkJaWYgKGktLSA9PSAw
KQ0KLQkJCQlyZXR1cm4gY3B1Ow0KLQ0KLQkJZm9yX2VhY2hfY3B1KGNwdSwgY3B1X29ubGluZV9t
YXNrKSB7DQotCQkJLyogU2tpcCBOVU1BIG5vZGVzLCBkb25lIGFib3ZlLiAqLw0KLQkJCWlmIChj
cHVtYXNrX3Rlc3RfY3B1KGNwdSwgY3B1bWFza19vZl9ub2RlKG5vZGUpKSkNCi0JCQkJY29udGlu
dWU7DQotDQotCQkJaWYgKGktLSA9PSAwKQ0KLQkJCQlyZXR1cm4gY3B1Ow0KKwluID0gaSAlIG07
DQorDQorCXdoaWxlIChtLS0gPiAwKSB7DQorCQlpZiAobm9kZSA9PSBOVU1BX05PX05PREUpIHsN
CisJCQlmb3JfZWFjaF9jcHUoY3B1LCBtYXNrKQ0KKwkJCQlpZiAobi0tID09IDApDQorCQkJCQly
ZXR1cm4gY3B1Ow0KKwkJfSBlbHNlIHsNCisJCQkvKiBOVU1BIGZpcnN0LiAqLw0KKwkJCWZvcl9l
YWNoX2NwdV9hbmQoY3B1LCBjcHVtYXNrX29mX25vZGUobm9kZSksIG1hc2spDQorCQkJCWlmIChu
LS0gPT0gMCkNCisJCQkJCXJldHVybiBjcHU7DQorDQorCQkJZm9yX2VhY2hfY3B1KGNwdSwgbWFz
aykgew0KKwkJCQkvKiBTa2lwIE5VTUEgbm9kZXMsIGRvbmUgYWJvdmUuICovDQorCQkJCWlmIChj
cHVtYXNrX3Rlc3RfY3B1KGNwdSwNCisJCQkJCQkgICAgIGNwdW1hc2tfb2Zfbm9kZShub2RlKSkp
DQorCQkJCQljb250aW51ZTsNCisNCisJCQkJaWYgKG4tLSA9PSAwKQ0KKwkJCQkJcmV0dXJuIGNw
dTsNCisJCQl9DQogCQl9DQogCX0NCiAJQlVHKCk7DQpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvbmV0
LXN5c2ZzLmMgYi9uZXQvY29yZS9uZXQtc3lzZnMuYw0KaW5kZXggNGM4MjZiOGJmOWIxLi4yNTM3
NThmMTAyZDkgMTAwNjQ0DQotLS0gYS9uZXQvY29yZS9uZXQtc3lzZnMuYw0KKysrIGIvbmV0L2Nv
cmUvbmV0LXN5c2ZzLmMNCkBAIC0xMSw2ICsxMSw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2lmX2Fy
cC5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NjaGVkL3Np
Z25hbC5oPg0KKyNpbmNsdWRlIDxsaW51eC9zY2hlZC9pc29sYXRpb24uaD4NCiAjaW5jbHVkZSA8
bGludXgvbnNwcm94eS5oPg0KICNpbmNsdWRlIDxuZXQvc29jay5oPg0KICNpbmNsdWRlIDxuZXQv
bmV0X25hbWVzcGFjZS5oPg0KQEAgLTcyNSw2ICs3MjYsMTQgQEAgc3RhdGljIHNzaXplX3Qgc3Rv
cmVfcnBzX21hcChzdHJ1Y3QgbmV0ZGV2X3J4X3F1ZXVlICpxdWV1ZSwNCiAJCXJldHVybiBlcnI7
DQogCX0NCiANCisjaWZkZWYgQ09ORklHX1RBU0tfSVNPTEFUSU9ODQorCWNwdW1hc2tfYW5kKG1h
c2ssIG1hc2ssIGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX0ZMQUdfRE9NQUlOKSk7DQorCWlmIChj
cHVtYXNrX3dlaWdodChtYXNrKSA9PSAwKSB7DQorCQlmcmVlX2NwdW1hc2tfdmFyKG1hc2spOw0K
KwkJcmV0dXJuIC1FSU5WQUw7DQorCX0NCisjZW5kaWYNCisNCiAJbWFwID0ga3phbGxvYyhtYXhf
dCh1bnNpZ25lZCBpbnQsDQogCQkJICAgIFJQU19NQVBfU0laRShjcHVtYXNrX3dlaWdodChtYXNr
KSksIEwxX0NBQ0hFX0JZVEVTKSwNCiAJCSAgICAgIEdGUF9LRVJORUwpOw0KLS0gDQoyLjIwLjEN
Cg0K
