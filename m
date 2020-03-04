Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1028517946E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgCDQFG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:05:06 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:26746 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729855AbgCDQFG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:05:06 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G0LLt020062;
        Wed, 4 Mar 2020 08:04:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=eWyggG/TwYNBpzS2wcGO1pbM5+qQ9JnQ1Tk8MFUWTQg=;
 b=Lo5SC1TcbgbzhFUctAddyT0XFkn7uV+gEa9gRpXv4D5Si09/rwd4a7S8w53mRd/q2TLB
 3dIqjlLnG3N5yEaAG7FGtOJRJGL6nMKqmGCHLt2NtCM2AAJiU2b4ytxSckeybVFcSkg5
 ZvhJB5SDJVO4sLsVaUrhrAjYQozLCxpbR8lMaduPov8oU988kjkiSlk2kts7HQhnPJ3D
 lfBS2FVe9F9izC79DJWZ5cpkPvB+mdRgB0yT57+js2hg9S4OM18/Y2JOpJ2NafMP5dEr
 i4kcuTbF5dR3gdptGJkniAnG9/wH9om0gwxq6eiQ0h7BWlD3ZlLXALlv3gtwTGTvGc95 PQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4d6vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:04:41 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:04:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:04:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4+p34H564vHzk/17y08uj3pV1lgBRoDtn+VlYHyC/uLsy0oLFiqKH0R+98xTU/GCLQtmOLRVGM1uOnaTPUsp41xCQgCPkxDC/yLWvtbJcD91nc4jUEWSZRiuJU1ParuodO2tNpAuu/4qBIK1jNONCocxkq1pziih1RwK/5MY88AQxhfETRWHCGIyWrXNH0Lh86LEqxXN2qkH97hUuaKXxs2h0RV9UAyWbYuNqduiq4BdfT6UI6reFEsQHW665Lqf8JVWIk8RhT/xpLfKEUIm+ucLc8Dq8SAkqQNaTJTnZSWuiPJqcqZe7mZ8wpihj4Ov6XOLJnpap0FFrtYDl1Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWyggG/TwYNBpzS2wcGO1pbM5+qQ9JnQ1Tk8MFUWTQg=;
 b=K0mUZJdaeT+Nl2/rj6TlRd35lkwaprRR1KuMbYxvsdcAZNu/Pt0Nb4nF6JRYq0+QOkDps25aIhSquAaCO5VFx66cNqAkaG3VKgL6Fc1+yJF2T3mbdjQR91e5pQfDW4IlGt4YND7TrQMigh90eUD8G/5PXxZWCH4UJNBIPNB0SozlOYyH52MwzpoVOcTKY1Pt872ZpbK7A9RromXNzxcQNQSX1Ytw1aGuZMg8cEeQWscfoRrAqV52a4tddQ56sh0j5CUAHjObht+xmkh69NrMcTBu6flTAyv29+q538peWh0E3vrgIWzH6ahbhFfDD8SRqOfOmMxaB0W0Rq245yRHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWyggG/TwYNBpzS2wcGO1pbM5+qQ9JnQ1Tk8MFUWTQg=;
 b=PFhnh2zlT+/NhLWEB3hFI6CwOXKLa9//v5UZEwbChhk0EqnFY2Z/aOB419Nk07B1ObG9IAf2a6AkF+fznmUnsR2RcsxSrp/Os96f/bJ9Z6dST+Tj8/hYdFResyVxAc2hlLuxO2Jo/Be2knFpSOeP432PDealFCeXSo6ohFUB5xQ=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB3061.namprd18.prod.outlook.com (2603:10b6:a03:10e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 16:04:38 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:04:38 +0000
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
Subject: [PATCH 02/12] task_isolation: vmstat: add vmstat_idle function
Thread-Topic: [PATCH 02/12] task_isolation: vmstat: add vmstat_idle function
Thread-Index: AQHV8j6apHEbg56r2UKWHgijYD7/zQ==
Date:   Wed, 4 Mar 2020 16:04:37 +0000
Message-ID: <d25c6aee46e6d3140651f29261352ad9c271c552.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af321bec-6766-4486-8032-08d7c055bd99
x-ms-traffictypediagnostic: BYAPR18MB3061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB3061A7E1BEEA75AA153055AEBCE50@BYAPR18MB3061.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39850400004)(376002)(136003)(366004)(199004)(189003)(66556008)(6506007)(2906002)(71200400001)(66476007)(64756008)(478600001)(54906003)(66446008)(2616005)(110136005)(8936002)(6512007)(66946007)(81156014)(81166006)(91956017)(8676002)(76116006)(4326008)(26005)(86362001)(36756003)(5660300002)(186003)(316002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB3061;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFiaFeB0qMV3CrnLnp6NX+RWXV5rtq/gRwBAc1JgCjOiRmyfeAiNxdWN3qXT+0j0iunPcPpVlVmSG0y/S2bMEG9ZsAi8XaFLvENtlqWBxP6gl+i6Z1Q1Ki0LCulZLpaXlVBRZM1/Z6UJIgYQ+3G9rcKAZYPW2pIpUFRUQD0BhyHTHLba1fy6IGD6+s48ADw7jjXewxlGDSkdxHk1azmDPCQq0JM6YXYfwyStqMB5BEj8kCgI1LKQkizOUlVnIwmYDpP9VF1ijbMzcHuGykpQJ1smRskWo+jxdr/UZV9E/dqg8O1YeKcvmb0FPBiNrB0ArT7in8HPGcqs4ecTgH7u0joNto/SW7SOFs1LQNYNOE6hbfgd17el7VN0v13Ea4AdTajn9sL5UjbAAWGsHQlY3Rgqz05w+Ok16Ad3ZcpKoFNlQF00R1mo7Iy+r7353wGx
x-ms-exchange-antispam-messagedata: 7nYgp1YaO7/3WtSl7Dmxai/lw3Agt8lEzMBRo161T/W6i8fmfgn2+S6PcdLDTFjhnJ7bPyxEkNgBQFr1aiLVSNn8w89V7rMU+Xy0lXOtRbpJPjCpyEq/zBNVhE3wJ3onVgOZyrmldeiPh2eNm4eSWg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C5ECF33757A4B4180F606FB4C9F5039@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af321bec-6766-4486-8032-08d7c055bd99
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:04:38.0012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhIFZNIUlsE5hJAk6SYtzGQBmih7FDNzOMiuGBIE65UTUyow6nUBKxcxQDDBKoo2hTXn8odTH0K9OJ8OcGyIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB3061
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQ2hyaXMgTWV0Y2FsZiA8Y21ldGNhbGZAbWVsbGFub3guY29tPg0KDQpUaGlzIGZ1bmN0
aW9uIGNoZWNrcyB0byBzZWUgaWYgYSB2bXN0YXQgd29ya2VyIGlzIG5vdCBydW5uaW5nLA0KYW5k
IHRoZSB2bXN0YXQgZGlmZnMgZG9uJ3QgcmVxdWlyZSBhbiB1cGRhdGUuICBUaGUgZnVuY3Rpb24g
aXMNCmNhbGxlZCBmcm9tIHRoZSB0YXNrLWlzb2xhdGlvbiBjb2RlIHRvIHNlZSBpZiB3ZSBuZWVk
IHRvDQphY3R1YWxseSBkbyBzb21lIHdvcmsgdG8gcXVpZXQgdm1zdGF0Lg0KDQpTaWduZWQtb2Zm
LWJ5OiBBbGV4IEJlbGl0cyA8YWJlbGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGlu
dXgvdm1zdGF0LmggfCAgMiArKw0KIG1tL3Ztc3RhdC5jICAgICAgICAgICAgfCAxMCArKysrKysr
KysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3Ztc3RhdC5oIGIvaW5jbHVkZS9saW51eC92bXN0YXQuaA0KaW5kZXggMmJj
NWU4NWYyNTE0Li42NmQ5YWUzMmNmMDcgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3Ztc3Rh
dC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3Ztc3RhdC5oDQpAQCAtMjcxLDYgKzI3MSw3IEBAIGV4
dGVybiB2b2lkIF9fZGVjX25vZGVfc3RhdGUoc3RydWN0IHBnbGlzdF9kYXRhICosIGVudW0gbm9k
ZV9zdGF0X2l0ZW0pOw0KIA0KIHZvaWQgcXVpZXRfdm1zdGF0KHZvaWQpOw0KIHZvaWQgcXVpZXRf
dm1zdGF0X3N5bmModm9pZCk7DQorYm9vbCB2bXN0YXRfaWRsZSh2b2lkKTsNCiB2b2lkIGNwdV92
bV9zdGF0c19mb2xkKGludCBjcHUpOw0KIHZvaWQgcmVmcmVzaF96b25lX3N0YXRfdGhyZXNob2xk
cyh2b2lkKTsNCiANCkBAIC0zNzQsNiArMzc1LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHJlZnJl
c2hfem9uZV9zdGF0X3RocmVzaG9sZHModm9pZCkgeyB9DQogc3RhdGljIGlubGluZSB2b2lkIGNw
dV92bV9zdGF0c19mb2xkKGludCBjcHUpIHsgfQ0KIHN0YXRpYyBpbmxpbmUgdm9pZCBxdWlldF92
bXN0YXQodm9pZCkgeyB9DQogc3RhdGljIGlubGluZSB2b2lkIHF1aWV0X3Ztc3RhdF9zeW5jKHZv
aWQpIHsgfQ0KK3N0YXRpYyBpbmxpbmUgYm9vbCB2bXN0YXRfaWRsZSh2b2lkKSB7IHJldHVybiB0
cnVlOyB9DQogDQogc3RhdGljIGlubGluZSB2b2lkIGRyYWluX3pvbmVzdGF0KHN0cnVjdCB6b25l
ICp6b25lLA0KIAkJCXN0cnVjdCBwZXJfY3B1X3BhZ2VzZXQgKnBzZXQpIHsgfQ0KZGlmZiAtLWdp
dCBhL21tL3Ztc3RhdC5jIGIvbW0vdm1zdGF0LmMNCmluZGV4IDFmYTBiMmQwNGFmYS4uNWM0YWVj
NjUxMDYyIDEwMDY0NA0KLS0tIGEvbW0vdm1zdGF0LmMNCisrKyBiL21tL3Ztc3RhdC5jDQpAQCAt
MTg3OSw2ICsxODc5LDE2IEBAIHZvaWQgcXVpZXRfdm1zdGF0X3N5bmModm9pZCkNCiAJcmVmcmVz
aF9jcHVfdm1fc3RhdHMoZmFsc2UpOw0KIH0NCiANCisvKg0KKyAqIFJlcG9ydCBvbiB3aGV0aGVy
IHZtc3RhdCBwcm9jZXNzaW5nIGlzIHF1aWVzY2VkIG9uIHRoZSBjb3JlIGN1cnJlbnRseToNCisg
KiBubyB2bXN0YXQgd29ya2VyIHJ1bm5pbmcgYW5kIG5vIHZtc3RhdCB1cGRhdGVzIHRvIHBlcmZv
cm0uDQorICovDQorYm9vbCB2bXN0YXRfaWRsZSh2b2lkKQ0KK3sNCisJcmV0dXJuICFkZWxheWVk
X3dvcmtfcGVuZGluZyh0aGlzX2NwdV9wdHIoJnZtc3RhdF93b3JrKSkgJiYNCisJCSFuZWVkX3Vw
ZGF0ZShzbXBfcHJvY2Vzc29yX2lkKCkpOw0KK30NCisNCiAvKg0KICAqIFNoZXBoZXJkIHdvcmtl
ciB0aHJlYWQgdGhhdCBjaGVja3MgdGhlDQogICogZGlmZmVyZW50aWFscyBvZiBwcm9jZXNzb3Jz
IHRoYXQgaGF2ZSB0aGVpciB3b3JrZXINCi0tIA0KMi4yMC4xDQoNCg==
