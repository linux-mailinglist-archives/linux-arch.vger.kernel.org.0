Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82F317948B
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCDQKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:10:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:8758 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbgCDQKL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:10:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G6ZZY027644;
        Wed, 4 Mar 2020 08:09:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ZdAK4ktWzI/AyH4WrwVZsnfplvIX6L8CdN243OjpFqA=;
 b=FTIk0m8r0eYKVbY7qbOHXLTLxfmfS0cYTa/0g2stxybl7mPLEr2+eWCoW1Rvq29hOEMJ
 NMQW9oZx9YoLEs4klvZevxkFHAsxe4OgPRx4Jywhb/SGdfxeAxI8I39KpT8KNxCdkun1
 Vd8Q/pNyvtGiNCpmSzo52raLx0U82wKuzEsv4DePca49KnWLkZMRsWZBsu+Vi8JHHJjc
 fPIQRQ+G/IeLB4aBfx7NaKAjdF9QuvHnhxFpiyuhilpo9AoIrjEhjyUeCmRlofZ0b1xq
 YVTnBWXt2b4qaay9YS59aW8AZGddI0Pcdtn7SdtTJJ+pvxDasI6Y8UFNeFZbwdI0h03N oA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4d947-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:09:37 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:09:35 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:09:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:09:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brk9Mmwa9jNuj3VOhTdeXX/DkaX03pZZ/WXS8koV+k2UYB5khTgPG0+C9goEbfY+kd9ljHd/xtLBNXVG5NA0Q5dceKVbJHukGGNb3VIV4fVL2PiC4zwkG3abXxPVta5sP146U/6OhB4O8FYpfUT7cwTXcYNuc00vRxt28zhvO15qQQ7lPZ6bdQyt/JFX+14plCn5+2DmXe1s3v50SVb897BzzWDLvC7DqIAQ0hwkdc9eBasjWFPKqGJNqeNS4z6fDFBPJVmgdH0ohFWx1rr7I91uhfU978OcSTQWsnwocasvsTFOWH4bCBQ9iEF33aq6IeVap2N4DLkBRZ6HLpgu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdAK4ktWzI/AyH4WrwVZsnfplvIX6L8CdN243OjpFqA=;
 b=dPiERX5sGSg36Y8UlCsSGwK3qNHpFjJfMwkOXZ2afPQK4PMP8TUysnhXCRcYMt5Krwhut9wRe+8kScJLek2e6znK16TAkqZxz0jNjx98b1c+R7GxPPqB0sUIk+2m8XeQj+dG55G2QB/CXTtZYFi+aHwrhBb8z6nmlnpTI+2zvV6RyJNZbh5WsmfqvgbY/wixTfILrxryGoj+F6+GSlSqbJekMiiwxDlec4R1sY5OR8Dc73j4Hu27Hx9FSaseT5OrDxqXO1pIiGBZIVGZ2U1gaSjZiSPQypFCT/THfw5800JOZxodjR8sAc7fHYKjXZfd7sfBXSNsZb0p5dzW0skOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdAK4ktWzI/AyH4WrwVZsnfplvIX6L8CdN243OjpFqA=;
 b=JXN2lsxX3pwUolnEoC9mvAS1lvedD65Y2bJxWxWnFIMtnwIPIo5pFJ57BP65MKdP8thOSUGoXzDvsAdgL/KWw+AumcLsCiPSupBiqBL5d6r7EG8MDfVp2dQnHBeDE3tyvdB5MCIpMAh20xMQaboiXuiQBzsvmy6lbjjDvr7kRdI=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2470.namprd18.prod.outlook.com (2603:10b6:a03:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Wed, 4 Mar
 2020 16:09:33 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:09:33 +0000
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
Subject: [PATCH 05/12] task_isolation: arch/x86: enable task isolation
 functionality
Thread-Topic: [PATCH 05/12] task_isolation: arch/x86: enable task isolation
 functionality
Thread-Index: AQHV8j9KllHftcaEs0OK+M6IZ0Dgyw==
Date:   Wed, 4 Mar 2020 16:09:33 +0000
Message-ID: <f5d7e4fb571861faa3d0bc5ada72affcb655466f.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c69da5c-bde4-45b2-c58e-08d7c0566d7e
x-ms-traffictypediagnostic: BYAPR18MB2470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB247080E1EC98C1F924B9D50ABCE50@BYAPR18MB2470.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(189003)(478600001)(2906002)(8676002)(86362001)(5660300002)(91956017)(6486002)(4326008)(36756003)(76116006)(81166006)(81156014)(2616005)(66446008)(71200400001)(66946007)(66556008)(110136005)(64756008)(316002)(26005)(66476007)(8936002)(54906003)(6506007)(186003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2470;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/eBoGwVPE6v3l54vQUuxElUnz+r0rSze+pmbN86oI5eqvEEBfJJatL2XrT6Nzx4J6RIuMY09PHZrVvQYMhy5OuaCyM+tAnMjNIjp6/P8B0rAPXOljeUIRrO7JoG4ihSQoD+iVQnYKjwHpj30lY0sZZ090xJCQSouPsO1/r8Nu5SM6umoRSPu5fbdvqN/PD4mQHf+WZQyXinBUGCNr8x72v6MPRrYCKaDQ5CepcQ737Vw1sk1B2CHVXLKBYo+H1vsQT7rOydng5v31jUf6HRkg+Rop6rQNBUaRI1nnZCZOQPdVBB53mpLfEb6vDJdkuW2Li/SiIaa3feOCTl+CCno/TC8kRCfDYCnu2vRJDYuX6z2Dc4Bx3SEUu1WPD7OP9atrR/byYyFt4PiAGPOY/wdxoXK23IBoYX+KbjdzGEABqeXWhzKrHQVRmt1ybOYnPZ
x-ms-exchange-antispam-messagedata: aRBLmFuG+2HrQXJ/wcfqzWYnskjYgy1fBzQNbrpm/XjnEIeDu8Jr21PCrDlW6Y1jx62+m4EADi7AEONwl44nd48gHQKEf7PeCEAOiM2R48U+/IMpCXrVi7Byl5gb9aA3rNUyJIoM9rN/kPsIrVtSHA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C2D77ACF2E0BA4F9CC469C6E7D958FA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c69da5c-bde4-45b2-c58e-08d7c0566d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:09:33.1450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYQDmsqH8rCBG9gO1cKN5IrmlQ4sblMyglDQRM9W4v8hXEiURjpa0rZDc5F2De/ZCnJS6pY54pjKu50yyvpr6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2470
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQ2hyaXMgTWV0Y2FsZiA8Y21ldGNhbGZAbWVsbGFub3guY29tPg0KDQpJbiBwcmVwYXJl
X2V4aXRfdG9fdXNlcm1vZGUoKSwgY2FsbCB0YXNrX2lzb2xhdGlvbl9zdGFydCgpIGZvcg0KVElG
X1RBU0tfSVNPTEFUSU9OIHRhc2tzLg0KDQpJbiBzeXNjYWxsX3RyYWNlX2VudGVyX3BoYXNlMSgp
LCBhZGQgdGhlIG5lY2Vzc2FyeSBzdXBwb3J0IGZvcg0KcmVwb3J0aW5nIHN5c2NhbGxzIGZvciB0
YXNrLWlzb2xhdGlvbiBwcm9jZXNzZXMuDQoNCkFkZCB0YXNrX2lzb2xhdGlvbl9yZW1vdGUoKSBj
YWxscyBmb3IgdGhlIGtlcm5lbCBleGNlcHRpb24gdHlwZXMNCnRoYXQgZG8gbm90IHJlc3VsdCBp
biBzaWduYWxzLCBuYW1lbHkgbm9uLXNpZ25hbGxpbmcgcGFnZSBmYXVsdHMuDQoNClNpZ25lZC1v
ZmYtYnk6IEFsZXggQmVsaXRzIDxhYmVsaXRzQG1hcnZlbGwuY29tPg0KLS0tDQogYXJjaC94ODYv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAxICsNCiBhcmNoL3g4Ni9lbnRyeS9jb21tb24u
YyAgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrKw0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2Fw
aWMuaCAgICAgICAgfCAgMyArKysNCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5o
IHwgIDQgKysrLQ0KIGFyY2gveDg2L2tlcm5lbC9hcGljL2lwaS5jICAgICAgICAgfCAgMiArKw0K
IGFyY2gveDg2L21tL2ZhdWx0LmMgICAgICAgICAgICAgICAgfCAgNCArKysrDQogNiBmaWxlcyBj
aGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9LY29uZmlnIGIvYXJjaC94ODYvS2NvbmZpZw0KaW5kZXggYmVlYTc3MDQ2ZjliLi45
ZWE2ZDNlNmU3N2QgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9LY29uZmlnDQorKysgYi9hcmNoL3g4
Ni9LY29uZmlnDQpAQCAtMTQ0LDYgKzE0NCw3IEBAIGNvbmZpZyBYODYNCiAJc2VsZWN0IEhBVkVf
QVJDSF9DT01QQVRfTU1BUF9CQVNFUwlpZiBNTVUgJiYgQ09NUEFUDQogCXNlbGVjdCBIQVZFX0FS
Q0hfUFJFTDMyX1JFTE9DQVRJT05TDQogCXNlbGVjdCBIQVZFX0FSQ0hfU0VDQ09NUF9GSUxURVIN
CisJc2VsZWN0IEhBVkVfQVJDSF9UQVNLX0lTT0xBVElPTg0KIAlzZWxlY3QgSEFWRV9BUkNIX1RI
UkVBRF9TVFJVQ1RfV0hJVEVMSVNUDQogCXNlbGVjdCBIQVZFX0FSQ0hfU1RBQ0tMRUFLDQogCXNl
bGVjdCBIQVZFX0FSQ0hfVFJBQ0VIT09LDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvY29t
bW9uLmMgYi9hcmNoL3g4Ni9lbnRyeS9jb21tb24uYw0KaW5kZXggOTc0Nzg3Njk4MGI1Li4xOTEz
MjdmNGY4MDIgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9lbnRyeS9jb21tb24uYw0KKysrIGIvYXJj
aC94ODYvZW50cnkvY29tbW9uLmMNCkBAIC0yNiw2ICsyNiw3IEBADQogI2luY2x1ZGUgPGxpbnV4
L2xpdmVwYXRjaC5oPg0KICNpbmNsdWRlIDxsaW51eC9zeXNjYWxscy5oPg0KICNpbmNsdWRlIDxs
aW51eC91YWNjZXNzLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lzb2xhdGlvbi5oPg0KIA0KICNpbmNs
dWRlIDxhc20vZGVzYy5oPg0KICNpbmNsdWRlIDxhc20vdHJhcHMuaD4NCkBAIC04Niw2ICs4Nywx
NSBAQCBzdGF0aWMgbG9uZyBzeXNjYWxsX3RyYWNlX2VudGVyKHN0cnVjdCBwdF9yZWdzICpyZWdz
KQ0KIAkJCXJldHVybiAtMUw7DQogCX0NCiANCisJLyoNCisJICogSW4gdGFzayBpc29sYXRpb24g
bW9kZSwgd2UgbWF5IHByZXZlbnQgdGhlIHN5c2NhbGwgZnJvbQ0KKwkgKiBydW5uaW5nLCBhbmQg
aWYgc28gd2UgYWxzbyBkZWxpdmVyIGEgc2lnbmFsIHRvIHRoZSBwcm9jZXNzLg0KKwkgKi8NCisJ
aWYgKHdvcmsgJiBfVElGX1RBU0tfSVNPTEFUSU9OKSB7DQorCQlpZiAodGFza19pc29sYXRpb25f
c3lzY2FsbChyZWdzLT5vcmlnX2F4KSA9PSAtMSkNCisJCQlyZXR1cm4gLTFMOw0KKwkJd29yayAm
PSB+X1RJRl9UQVNLX0lTT0xBVElPTjsNCisJfQ0KICNpZmRlZiBDT05GSUdfU0VDQ09NUA0KIAkv
Kg0KIAkgKiBEbyBzZWNjb21wIGFmdGVyIHB0cmFjZSwgdG8gY2F0Y2ggYW55IHRyYWNlciBjaGFu
Z2VzLg0KQEAgLTIwNCw2ICsyMTQsOSBAQCBfX3Zpc2libGUgaW5saW5lIHZvaWQgcHJlcGFyZV9l
eGl0X3RvX3VzZXJtb2RlKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KIAlpZiAodW5saWtlbHkoY2Fj
aGVkX2ZsYWdzICYgX1RJRl9ORUVEX0ZQVV9MT0FEKSkNCiAJCXN3aXRjaF9mcHVfcmV0dXJuKCk7
DQogDQorCWlmIChjYWNoZWRfZmxhZ3MgJiBfVElGX1RBU0tfSVNPTEFUSU9OKQ0KKwkJdGFza19p
c29sYXRpb25fc3RhcnQoKTsNCisNCiAjaWZkZWYgQ09ORklHX0NPTVBBVA0KIAkvKg0KIAkgKiBD
b21wYXQgc3lzY2FsbHMgc2V0IFRTX0NPTVBBVC4gIE1ha2Ugc3VyZSB3ZSBjbGVhciBpdCBiZWZv
cmUNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hcGljLmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9hcGljLmgNCmluZGV4IDE5ZTk0YWY5Y2M1ZC4uNzExNDlhYmJiMGEwIDEwMDY0
NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5oDQorKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9hcGljLmgNCkBAIC0zLDYgKzMsNyBAQA0KICNkZWZpbmUgX0FTTV9YODZfQVBJQ19I
DQogDQogI2luY2x1ZGUgPGxpbnV4L2NwdW1hc2suaD4NCisjaW5jbHVkZSA8bGludXgvaXNvbGF0
aW9uLmg+DQogDQogI2luY2x1ZGUgPGFzbS9hbHRlcm5hdGl2ZS5oPg0KICNpbmNsdWRlIDxhc20v
Y3B1ZmVhdHVyZS5oPg0KQEAgLTUyNCw2ICs1MjUsNyBAQCBleHRlcm4gdm9pZCBpcnFfZXhpdCh2
b2lkKTsNCiANCiBzdGF0aWMgaW5saW5lIHZvaWQgZW50ZXJpbmdfaXJxKHZvaWQpDQogew0KKwl0
YXNrX2lzb2xhdGlvbl9pbnRlcnJ1cHQoImlycSIpOw0KIAlpcnFfZW50ZXIoKTsNCiAJa3ZtX3Nl
dF9jcHVfbDF0Zl9mbHVzaF9sMWQoKTsNCiB9DQpAQCAtNTM2LDYgKzUzOCw3IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBlbnRlcmluZ19hY2tfaXJxKHZvaWQpDQogDQogc3RhdGljIGlubGluZSB2b2lk
IGlwaV9lbnRlcmluZ19hY2tfaXJxKHZvaWQpDQogew0KKwl0YXNrX2lzb2xhdGlvbl9pbnRlcnJ1
cHQoImFjayBpcnEiKTsNCiAJaXJxX2VudGVyKCk7DQogCWFja19BUElDX2lycSgpOw0KIAlrdm1f
c2V0X2NwdV9sMXRmX2ZsdXNoX2wxZCgpOw0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3RocmVhZF9pbmZvLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oDQpp
bmRleCBjZjQzMjc5ODZlOTguLjYwZDEwN2Y3ODRlZSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVh
ZF9pbmZvLmgNCkBAIC05Miw2ICs5Miw3IEBAIHN0cnVjdCB0aHJlYWRfaW5mbyB7DQogI2RlZmlu
ZSBUSUZfTk9DUFVJRAkJMTUJLyogQ1BVSUQgaXMgbm90IGFjY2Vzc2libGUgaW4gdXNlcmxhbmQg
Ki8NCiAjZGVmaW5lIFRJRl9OT1RTQwkJMTYJLyogVFNDIGlzIG5vdCBhY2Nlc3NpYmxlIGluIHVz
ZXJsYW5kICovDQogI2RlZmluZSBUSUZfSUEzMgkJMTcJLyogSUEzMiBjb21wYXRpYmlsaXR5IHBy
b2Nlc3MgKi8NCisjZGVmaW5lIFRJRl9UQVNLX0lTT0xBVElPTgkxOAkvKiB0YXNrIGlzb2xhdGlv
biBlbmFibGVkIGZvciB0YXNrICovDQogI2RlZmluZSBUSUZfTk9IWgkJMTkJLyogaW4gYWRhcHRp
dmUgbm9oeiBtb2RlICovDQogI2RlZmluZSBUSUZfTUVNRElFCQkyMAkvKiBpcyB0ZXJtaW5hdGlu
ZyBkdWUgdG8gT09NIGtpbGxlciAqLw0KICNkZWZpbmUgVElGX1BPTExJTkdfTlJGTEFHCTIxCS8q
IGlkbGUgaXMgcG9sbGluZyBmb3IgVElGX05FRURfUkVTQ0hFRCAqLw0KQEAgLTEyMiw2ICsxMjMs
NyBAQCBzdHJ1Y3QgdGhyZWFkX2luZm8gew0KICNkZWZpbmUgX1RJRl9OT0NQVUlECQkoMSA8PCBU
SUZfTk9DUFVJRCkNCiAjZGVmaW5lIF9USUZfTk9UU0MJCSgxIDw8IFRJRl9OT1RTQykNCiAjZGVm
aW5lIF9USUZfSUEzMgkJKDEgPDwgVElGX0lBMzIpDQorI2RlZmluZSBfVElGX1RBU0tfSVNPTEFU
SU9OCSgxIDw8IFRJRl9UQVNLX0lTT0xBVElPTikNCiAjZGVmaW5lIF9USUZfTk9IWgkJKDEgPDwg
VElGX05PSFopDQogI2RlZmluZSBfVElGX1BPTExJTkdfTlJGTEFHCSgxIDw8IFRJRl9QT0xMSU5H
X05SRkxBRykNCiAjZGVmaW5lIF9USUZfSU9fQklUTUFQCQkoMSA8PCBUSUZfSU9fQklUTUFQKQ0K
QEAgLTE0MCw3ICsxNDIsNyBAQCBzdHJ1Y3QgdGhyZWFkX2luZm8gew0KICNkZWZpbmUgX1RJRl9X
T1JLX1NZU0NBTExfRU5UUlkJXA0KIAkoX1RJRl9TWVNDQUxMX1RSQUNFIHwgX1RJRl9TWVNDQUxM
X0VNVSB8IF9USUZfU1lTQ0FMTF9BVURJVCB8CVwNCiAJIF9USUZfU0VDQ09NUCB8IF9USUZfU1lT
Q0FMTF9UUkFDRVBPSU5UIHwJXA0KLQkgX1RJRl9OT0haKQ0KKwkgX1RJRl9OT0haIHwgX1RJRl9U
QVNLX0lTT0xBVElPTikNCiANCiAvKiBmbGFncyB0byBjaGVjayBpbiBfX3N3aXRjaF90bygpICov
DQogI2RlZmluZSBfVElGX1dPUktfQ1RYU1dfQkFTRQkJCQkJXA0KZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2tlcm5lbC9hcGljL2lwaS5jIGIvYXJjaC94ODYva2VybmVsL2FwaWMvaXBpLmMNCmluZGV4
IDZjYTBmOTEzNzJmZC4uYjRkZmFhZDZhNDQwIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVs
L2FwaWMvaXBpLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL2lwaS5jDQpAQCAtMiw2ICsy
LDcgQEANCiANCiAjaW5jbHVkZSA8bGludXgvY3B1bWFzay5oPg0KICNpbmNsdWRlIDxsaW51eC9z
bXAuaD4NCisjaW5jbHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQogDQogI2luY2x1ZGUgImxvY2Fs
LmgiDQogDQpAQCAtNjcsNiArNjgsNyBAQCB2b2lkIG5hdGl2ZV9zbXBfc2VuZF9yZXNjaGVkdWxl
KGludCBjcHUpDQogCQlXQVJOKDEsICJzY2hlZDogVW5leHBlY3RlZCByZXNjaGVkdWxlIG9mIG9m
ZmxpbmUgQ1BVIyVkIVxuIiwgY3B1KTsNCiAJCXJldHVybjsNCiAJfQ0KKwl0YXNrX2lzb2xhdGlv
bl9yZW1vdGUoY3B1LCAicmVzY2hlZHVsZSBJUEkiKTsNCiAJYXBpYy0+c2VuZF9JUEkoY3B1LCBS
RVNDSEVEVUxFX1ZFQ1RPUik7DQogfQ0KIA0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2ZhdWx0
LmMgYi9hcmNoL3g4Ni9tbS9mYXVsdC5jDQppbmRleCBmYTRlYTA5NTkzYWIuLjIxNzVhODY1NWE3
ZCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L21tL2ZhdWx0LmMNCisrKyBiL2FyY2gveDg2L21tL2Zh
dWx0LmMNCkBAIC0xOCw2ICsxOCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4JCS8q
IGZhdWx0aGFuZGxlcl9kaXNhYmxlZCgpCSovDQogI2luY2x1ZGUgPGxpbnV4L2VmaS5oPgkJCS8q
IGVmaV9yZWNvdmVyX2Zyb21fcGFnZV9mYXVsdCgpKi8NCiAjaW5jbHVkZSA8bGludXgvbW1fdHlw
ZXMuaD4NCisjaW5jbHVkZSA8bGludXgvaXNvbGF0aW9uLmg+CQkvKiB0YXNrX2lzb2xhdGlvbl9p
bnRlcnJ1cHQgICAgICovDQogDQogI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+CQkvKiBib290
X2NwdV9oYXMsIC4uLgkJKi8NCiAjaW5jbHVkZSA8YXNtL3RyYXBzLmg+CQkJLyogZG90cmFwbGlu
a2FnZSwgLi4uCQkqLw0KQEAgLTE0ODMsNiArMTQ4NCw5IEBAIHZvaWQgZG9fdXNlcl9hZGRyX2Zh
dWx0KHN0cnVjdCBwdF9yZWdzICpyZWdzLA0KIAkJcGVyZl9zd19ldmVudChQRVJGX0NPVU5UX1NX
X1BBR0VfRkFVTFRTX01JTiwgMSwgcmVncywgYWRkcmVzcyk7DQogCX0NCiANCisJLyogTm8gc2ln
bmFsIHdhcyBnZW5lcmF0ZWQsIGJ1dCBub3RpZnkgdGFzay1pc29sYXRpb24gdGFza3MuICovDQor
CXRhc2tfaXNvbGF0aW9uX2ludGVycnVwdCgicGFnZSBmYXVsdCBhdCAlI2x4IiwgYWRkcmVzcyk7
DQorDQogCWNoZWNrX3Y4MDg2X21vZGUocmVncywgYWRkcmVzcywgdHNrKTsNCiB9DQogTk9LUFJP
QkVfU1lNQk9MKGRvX3VzZXJfYWRkcl9mYXVsdCk7DQotLSANCjIuMjAuMQ0KDQo=
