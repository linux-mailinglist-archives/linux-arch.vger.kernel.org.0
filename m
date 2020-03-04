Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C7179484
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgCDQIm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:08:42 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46234 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728278AbgCDQIl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:08:41 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G6SFj027616;
        Wed, 4 Mar 2020 08:08:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=eKyiWOyb7mGY09JGCOUAgJtIqRjdq+w2kAqgu8vtudY=;
 b=LBBua8Ms9vHQoTUCO6Fqq0F9lO/GXS8wHbQkR9gaZogrCFz3dQXLDtYvvR4gceU+jvtO
 OEefQXACeopuths5HflGTLMyrUZB3p4okuygWjFq81pRrAV1RM/tCjVsDhNXZCxMO49A
 WPgyaD2RmqAk4kbr1yUhkNG7t9AyppEVbZ+K6i/dIMckUFxI2auDNtFiCWPMbTSR2LT0
 e5Sq9aM8wIMJq1gtPLODO9jz7Usjhc7SgG3HY5fxMbjMHy89ZgAJqgtkmvA2jGLw4k7j
 RpWGeDzSRdnWkEp2mCMiuSJRPSdodXICPlJ4t/oX+NEW0nvCEcfJa1m4OWJYdtbXAUV0 xw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4d8tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:08:19 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:08:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:08:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikGuOUvr63tEPvIs9MPxDEhm9Y3VYTGtNt9uqRtMi37J9QKQUNhvzD5P3TeaSdmitOzWc3YrL/9cMial8cKEDjVkK0HiC9OPAICVMXuppFrmdB8RUvuOZ7H2AfEJxEl0VMVy+ZyHJdrtmHQKWECD/bcn1vqzwYOL3uyo04Pju48WvWV84rb55XLZ3LZzldv2bo0nxxVJPo7xYt2R9VnBCRmV4fjx2DobtR1dvwi+EZjUMInzfIwRuTXTC2lQFory9WXSRAHnoR7d/Gy8WeuirLG+EM6YSQHzjoDMCV2mipAJIUqCPJeDIsyRiWDg76XLX8iT9DehoMFIRiGMXJToGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKyiWOyb7mGY09JGCOUAgJtIqRjdq+w2kAqgu8vtudY=;
 b=RP2Yj2dYoocVjUSYLqRSWOwRgwyZ0rZGAI5OTXxZlFGnJI1zo5hiOo1cmdPI6SZOvFtyLUkpyHe45wblzTLMj6XxR2FRA/jo8VNmnbMJ64TemaRCl/986F2XdNZXC9wNCdutfOsIvGMH/h27z9b/31Xekk9yKAlts8Tr8P1eh6BjXtpwUd8rmQ80tg1+veOR9jnrwQZndzli5ceS05N5NgN1JgjEQ79QBnOjDsB3V8FdrOuKhdLg8Mi0+qs6IDhIh1Bx0pQoz/FLReTVzqhlQefHg9auDHRdMkmDLhLWSxd+Qd9uqk+pnQE2XqCdaKYaucZCJxVmAZtYiC8fuNCbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKyiWOyb7mGY09JGCOUAgJtIqRjdq+w2kAqgu8vtudY=;
 b=RSAaR3vA678bMeIHdp7hQEj4A4p3f5lgIPnlXbkscY69AYHcxNG8onT2DdXcrl7p5yA8KzIGevotAPrAexs+NyxIPiG8ykrJgBpVnfJo1qWp1IieMwf7tM/CTXEGMX6OOJoEwvwEnAa43UWCoYy6CLYYgDs35hQk+0mJJazOcu0=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2695.namprd18.prod.outlook.com (2603:10b6:a03:10a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 16:08:16 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:08:16 +0000
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
Subject: [PATCH 04/12] task_isolation: Add task isolation hooks to
 arch-independent code
Thread-Topic: [PATCH 04/12] task_isolation: Add task isolation hooks to
 arch-independent code
Thread-Index: AQHV8j8demKJq/qh+0KiYzi4W+Hwog==
Date:   Wed, 4 Mar 2020 16:08:16 +0000
Message-ID: <f2b414a445d4ffa343d6e074310b9f08301f8cc1.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c77b699d-580b-42fb-4ab5-08d7c0563fda
x-ms-traffictypediagnostic: BYAPR18MB2695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB269568113EB56884D0B8F76CBCE50@BYAPR18MB2695.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(91956017)(66946007)(86362001)(478600001)(66446008)(64756008)(66556008)(2906002)(66476007)(76116006)(6486002)(6506007)(6512007)(5660300002)(8676002)(4326008)(54906003)(26005)(81166006)(2616005)(36756003)(81156014)(110136005)(186003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2695;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYFf6q9qFAevkmPvVgqb1hTT1qXGYG1wQtVIXn4Mwv82izYsoAcSxtRHxuinHOihZUosemMelzInRcV0uayY2KIPOJKwHpgswH3UkvvZCK35WEj1Su5QQRQ1sSKw1NRDg1bS3qRowlMGqqCKFPvs+lgZFxBAr8a88Cq0ktp46o79RIis4m++U1+zo8dRdMZ7s5TUpRVYv5g/8gBAldm9xUVuDEc6VyzwNRmOC4RKxUudWP/sX5gAzG+QNqkaDpqTsydRjtEcDnUHXTZizY3u4WNxf8x5ReC8KCzO2DVQa+pptrWEnPkbgsqwH6dampf9e64W34kpBa4tPUm8hksxQE04XgLSZkeRM8K5I9pNJ4h4rt8OmHbOO7btTUxkfV3WcfHm5QrzCji/tTnSCQ0Qb+599oIyhz7Q4tmqzeR/m8HWWJWRkWekVOGbPaDytS4N
x-ms-exchange-antispam-messagedata: qDyMUUZAaySw8nclNNZrMEMt974We3ubEWyaqpHuBodSS6CRfEWE3cq2iF/OeQlf8k4SXhSL5J3Pt7kEgX9anqCftU1OkNLyD2vRfCNY4lw68gawgeMcMW+h8I6ZNCpiuk6L7qHhHLx4M+3KtoqbJg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1A3992A7D59F34FB63E47FFAC8380BA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c77b699d-580b-42fb-4ab5-08d7c0563fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:08:16.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1+U9qbD5Dr7JWR0AufEYkcz+TuXQm9hWs+DKsapfmrOjHY/OgyKm1kvfbr12a3g9JVc9MdQVXCgXBze6/Jemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2695
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQ2hyaXMgTWV0Y2FsZiA8Y21ldGNhbGZAbWVsbGFub3guY29tPg0KDQpUaGlzIGNvbW1p
dCBhZGRzIHRhc2sgaXNvbGF0aW9uIGhvb2tzIGFzIGZvbGxvd3M6DQoNCi0gX19oYW5kbGVfZG9t
YWluX2lycSgpIGdlbmVyYXRlcyBhbiBpc29sYXRpb24gd2FybmluZyBmb3IgdGhlDQogIGxvY2Fs
IHRhc2sNCg0KLSBpcnFfd29ya19xdWV1ZV9vbigpIGdlbmVyYXRlcyBhbiBpc29sYXRpb24gd2Fy
bmluZyBmb3IgdGhlIHJlbW90ZQ0KICB0YXNrIGJlaW5nIGludGVycnVwdGVkIGZvciBpcnFfd29y
aw0KDQotIGdlbmVyaWNfZXhlY19zaW5nbGUoKSBnZW5lcmF0ZXMgYSByZW1vdGUgaXNvbGF0aW9u
IHdhcm5pbmcgZm9yDQogIHRoZSByZW1vdGUgY3B1IGJlaW5nIElQSSdkDQoNCi0gc21wX2NhbGxf
ZnVuY3Rpb25fbWFueSgpIGdlbmVyYXRlcyBhIHJlbW90ZSBpc29sYXRpb24gd2FybmluZyBmb3IN
CiAgdGhlIHNldCBvZiByZW1vdGUgY3B1cyBiZWluZyBJUEknZA0KDQpDYWxscyB0byB0YXNrX2lz
b2xhdGlvbl9yZW1vdGUoKSBvciB0YXNrX2lzb2xhdGlvbl9pbnRlcnJ1cHQoKSBjYW4NCmJlIHBs
YWNlZCBpbiB0aGUgcGxhdGZvcm0taW5kZXBlbmRlbnQgY29kZSBsaWtlIHRoaXMgd2hlbiBkb2lu
ZyBzbw0KcmVzdWx0cyBpbiBmZXdlciBsaW5lcyBvZiBjb2RlIGNoYW5nZXMsIGFzIGZvciBleGFt
cGxlIGlzIHRydWUgb2YNCnRoZSB1c2VycyBvZiB0aGUgYXJjaF9zZW5kX2NhbGxfZnVuY3Rpb25f
KigpIEFQSXMuIE9yLCB0aGV5IGNhbiBiZQ0KcGxhY2VkIGluIHRoZSBwZXItYXJjaGl0ZWN0dXJl
IGNvZGUgd2hlbiB0aGVyZSBhcmUgbWFueSBjYWxsZXJzLA0KYXMgZm9yIGV4YW1wbGUgaXMgdHJ1
ZSBvZiB0aGUgc21wX3NlbmRfcmVzY2hlZHVsZSgpIGNhbGwuDQoNCkEgZnVydGhlciBjbGVhbnVw
IG1pZ2h0IGJlIHRvIGNyZWF0ZSBhbiBpbnRlcm1lZGlhdGUgbGF5ZXIsIHNvIHRoYXQNCmZvciBl
eGFtcGxlIHNtcF9zZW5kX3Jlc2NoZWR1bGUoKSBpcyBhIHNpbmdsZSBnZW5lcmljIGZ1bmN0aW9u
IHRoYXQNCmp1c3QgY2FsbHMgYXJjaF9zbXBfc2VuZF9yZXNjaGVkdWxlKCksIGFsbG93aW5nIGdl
bmVyaWMgY29kZSB0byBiZQ0KY2FsbGVkIGV2ZXJ5IHRpbWUgc21wX3NlbmRfcmVzY2hlZHVsZSgp
IGlzIGludm9rZWQuIEJ1dCBmb3Igbm93LCB3ZQ0KanVzdCB1cGRhdGUgZWl0aGVyIGNhbGxlcnMg
b3IgY2FsbGVlcyBhcyBtYWtlcyBtb3N0IHNlbnNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGV4IEJl
bGl0cyA8YWJlbGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGtlcm5lbC9pcnEvaXJxZGVzYy5jIHwg
OSArKysrKysrKysNCiBrZXJuZWwvaXJxX3dvcmsuYyAgICB8IDUgKysrKy0NCiBrZXJuZWwvc21w
LmMgICAgICAgICB8IDYgKysrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL2lycS9pcnFkZXNjLmMgYi9r
ZXJuZWwvaXJxL2lycWRlc2MuYw0KaW5kZXggOThhNWYxMGQxOTAwLi5lMmI4MWQwMzVmYTEgMTAw
NjQ0DQotLS0gYS9rZXJuZWwvaXJxL2lycWRlc2MuYw0KKysrIGIva2VybmVsL2lycS9pcnFkZXNj
LmMNCkBAIC0xNiw2ICsxNiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2JpdG1hcC5oPg0KICNpbmNs
dWRlIDxsaW51eC9pcnFkb21haW4uaD4NCiAjaW5jbHVkZSA8bGludXgvc3lzZnMuaD4NCisjaW5j
bHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQogDQogI2luY2x1ZGUgImludGVybmFscy5oIg0KIA0K
QEAgLTY3MCw2ICs2NzEsMTAgQEAgaW50IF9faGFuZGxlX2RvbWFpbl9pcnEoc3RydWN0IGlycV9k
b21haW4gKmRvbWFpbiwgdW5zaWduZWQgaW50IGh3aXJxLA0KIAkJaXJxID0gaXJxX2ZpbmRfbWFw
cGluZyhkb21haW4sIGh3aXJxKTsNCiAjZW5kaWYNCiANCisJdGFza19pc29sYXRpb25faW50ZXJy
dXB0KChpcnEgPT0gaHdpcnEpID8NCisJCQkJICJpcnEgJWQgKCVzKSIgOiAiaXJxICVkICglcyBo
d2lycSAlZCkiLA0KKwkJCQkgaXJxLCBkb21haW4gPyBkb21haW4tPm5hbWUgOiAiIiwgaHdpcnEp
Ow0KKw0KIAkvKg0KIAkgKiBTb21lIGhhcmR3YXJlIGdpdmVzIHJhbmRvbWx5IHdyb25nIGludGVy
cnVwdHMuICBSYXRoZXINCiAJICogdGhhbiBjcmFzaGluZywgZG8gc29tZXRoaW5nIHNlbnNpYmxl
Lg0KQEAgLTcxMSw2ICs3MTYsMTAgQEAgaW50IGhhbmRsZV9kb21haW5fbm1pKHN0cnVjdCBpcnFf
ZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGludCBod2lycSwNCiANCiAJaXJxID0gaXJxX2ZpbmRf
bWFwcGluZyhkb21haW4sIGh3aXJxKTsNCiANCisJdGFza19pc29sYXRpb25faW50ZXJydXB0KChp
cnEgPT0gaHdpcnEpID8NCisJCQkJICJOTUkgaXJxICVkICglcykiIDogIk5NSSBpcnEgJWQgKCVz
IGh3aXJxICVkKSIsDQorCQkJCSBpcnEsIGRvbWFpbiA/IGRvbWFpbi0+bmFtZSA6ICIiLCBod2ly
cSk7DQorDQogCS8qDQogCSAqIGFja19iYWRfaXJxIGlzIG5vdCBOTUktc2FmZSwganVzdCByZXBv
cnQNCiAJICogYW4gaW52YWxpZCBpbnRlcnJ1cHQuDQpkaWZmIC0tZ2l0IGEva2VybmVsL2lycV93
b3JrLmMgYi9rZXJuZWwvaXJxX3dvcmsuYw0KaW5kZXggODI4Y2MzMDc3NGJjLi44ZmQ0ZWNlNDNk
ZDggMTAwNjQ0DQotLS0gYS9rZXJuZWwvaXJxX3dvcmsuYw0KKysrIGIva2VybmVsL2lycV93b3Jr
LmMNCkBAIC0xOCw2ICsxOCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KICNpbmNsdWRl
IDxsaW51eC9ub3RpZmllci5oPg0KICNpbmNsdWRlIDxsaW51eC9zbXAuaD4NCisjaW5jbHVkZSA8
bGludXgvaXNvbGF0aW9uLmg+DQogI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4NCiANCiANCkBA
IC0xMDIsOCArMTAzLDEwIEBAIGJvb2wgaXJxX3dvcmtfcXVldWVfb24oc3RydWN0IGlycV93b3Jr
ICp3b3JrLCBpbnQgY3B1KQ0KIAlpZiAoY3B1ICE9IHNtcF9wcm9jZXNzb3JfaWQoKSkgew0KIAkJ
LyogQXJjaCByZW1vdGUgSVBJIHNlbmQvcmVjZWl2ZSBiYWNrZW5kIGFyZW4ndCBOTUkgc2FmZSAq
Lw0KIAkJV0FSTl9PTl9PTkNFKGluX25taSgpKTsNCi0JCWlmIChsbGlzdF9hZGQoJndvcmstPmxs
bm9kZSwgJnBlcl9jcHUocmFpc2VkX2xpc3QsIGNwdSkpKQ0KKwkJaWYgKGxsaXN0X2FkZCgmd29y
ay0+bGxub2RlLCAmcGVyX2NwdShyYWlzZWRfbGlzdCwgY3B1KSkpIHsNCisJCQl0YXNrX2lzb2xh
dGlvbl9yZW1vdGUoY3B1LCAiaXJxX3dvcmsiKTsNCiAJCQlhcmNoX3NlbmRfY2FsbF9mdW5jdGlv
bl9zaW5nbGVfaXBpKGNwdSk7DQorCQl9DQogCX0gZWxzZSB7DQogCQlfX2lycV93b3JrX3F1ZXVl
X2xvY2FsKHdvcmspOw0KIAl9DQpkaWZmIC0tZ2l0IGEva2VybmVsL3NtcC5jIGIva2VybmVsL3Nt
cC5jDQppbmRleCBkMGFkYTM5ZWI0ZDQuLjNhOGJjYmRkNGNlNiAxMDA2NDQNCi0tLSBhL2tlcm5l
bC9zbXAuYw0KKysrIGIva2VybmVsL3NtcC5jDQpAQCAtMjAsNiArMjAsNyBAQA0KICNpbmNsdWRl
IDxsaW51eC9zY2hlZC5oPg0KICNpbmNsdWRlIDxsaW51eC9zY2hlZC9pZGxlLmg+DQogI2luY2x1
ZGUgPGxpbnV4L2h5cGVydmlzb3IuaD4NCisjaW5jbHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQog
DQogI2luY2x1ZGUgInNtcGJvb3QuaCINCiANCkBAIC0xNzYsOCArMTc3LDEwIEBAIHN0YXRpYyBp
bnQgZ2VuZXJpY19leGVjX3NpbmdsZShpbnQgY3B1LCBjYWxsX3NpbmdsZV9kYXRhX3QgKmNzZCwN
CiAJICogbG9ja2luZyBhbmQgYmFycmllciBwcmltaXRpdmVzLiBHZW5lcmljIGNvZGUgaXNuJ3Qg
cmVhbGx5DQogCSAqIGVxdWlwcGVkIHRvIGRvIHRoZSByaWdodCB0aGluZy4uLg0KIAkgKi8NCi0J
aWYgKGxsaXN0X2FkZCgmY3NkLT5sbGlzdCwgJnBlcl9jcHUoY2FsbF9zaW5nbGVfcXVldWUsIGNw
dSkpKQ0KKwlpZiAobGxpc3RfYWRkKCZjc2QtPmxsaXN0LCAmcGVyX2NwdShjYWxsX3NpbmdsZV9x
dWV1ZSwgY3B1KSkpIHsNCisJCXRhc2tfaXNvbGF0aW9uX3JlbW90ZShjcHUsICJJUEkgZnVuY3Rp
b24iKTsNCiAJCWFyY2hfc2VuZF9jYWxsX2Z1bmN0aW9uX3NpbmdsZV9pcGkoY3B1KTsNCisJfQ0K
IA0KIAlyZXR1cm4gMDsNCiB9DQpAQCAtNDY2LDYgKzQ2OSw3IEBAIHN0YXRpYyB2b2lkIHNtcF9j
YWxsX2Z1bmN0aW9uX21hbnlfY29uZChjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbWFzaywNCiAJfQ0K
IA0KIAkvKiBTZW5kIGEgbWVzc2FnZSB0byBhbGwgQ1BVcyBpbiB0aGUgbWFwICovDQorCXRhc2tf
aXNvbGF0aW9uX3JlbW90ZV9jcHVtYXNrKGNmZC0+Y3B1bWFza19pcGksICJJUEkgZnVuY3Rpb24i
KTsNCiAJYXJjaF9zZW5kX2NhbGxfZnVuY3Rpb25faXBpX21hc2soY2ZkLT5jcHVtYXNrX2lwaSk7
DQogDQogCWlmICh3YWl0KSB7DQotLSANCjIuMjAuMQ0KDQo=
