Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027F217D22D
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 08:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgCHHQv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 03:16:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55176 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgCHHQv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Mar 2020 03:16:51 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0287B7gn030309;
        Sat, 7 Mar 2020 23:16:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=gzO8Tl3YLa+u6ZehKN64iZkIyT1kHCEci/GsUozWtRo=;
 b=SdRWlDWzD1Koxaan19q7V3fdoAGmWiwen6X5pwxDvv68duXfqE9AlQkym5MSVjqZvqN4
 o5NG/umhjJQ2iPQ5sIDuXyNJAJRgaSCRQi/2sAW5B/E3vBR1fGXxp+SqzeaZjvakVLGP
 JCaQ6j43hqfmmPlVpUikzqnX7b+pvU7njIhptfi+isaQHpC32irpHkSUTJVpbVlA+79+
 8BFlkbxAwUbG6xOKEPDIyEktxfP0+ZKMUnjINF+iaOf3849hFYVRaqWzDRcAw2EcwyHJ
 KlrawZDuQbVPrrcLysRCyVnfWxj9yBZftXr3jzsrlVwQ0nM948gTY6VUEBkNvQLNVYKv Aw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2ymc0sjd6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 07 Mar 2020 23:16:10 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 7 Mar
 2020 23:16:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sat, 7 Mar 2020 23:16:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmPNk8yexV0Ju1hUPAQfxwjJ2Y5fynjB5zMwqvqxeuWbZ8eG3dJeVCLCIQNbmQUH5TQugsaqhoPbXgImYFsMIaFYHnW13V533rngmBxAui7YtvIcpgorUhy88jt/9raLHws0Qrqxe6FHJ0V0FsTexNL+97ZvhrrQ+wb7Zqott6Ru2P4tudXAqqyBwNhXH0FFwDG0yOg76R/A2GWN/mhpUUhkNrDXOLgw6cctr/Rnw8fSmnIMdkJapZZ0KcpRrXvbdJY/1uzwdMG7CzoBto0XJlddcHIMUYN8AoTAR5iAnKCOi1BhIuAZqP44DAi8ptnhOcSyGFKvHc7ck7A5Wtw7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzO8Tl3YLa+u6ZehKN64iZkIyT1kHCEci/GsUozWtRo=;
 b=fmYkBqvZZsBsESZok8V0JDX1h/IkOv44qqM8ErLtrT1wnqrr2oVc0FFiLVN7XNjZw5X8Mhpt9kDuU7d+LG65i2vvnSVEtY2v+iGA0M0kcH0A9qC110iqIQTl51FALt0psIuVds62HogS6DxSutsSKL/rUHlnI8+IC697pbLYIBU4B9HYcqrO2QhmjWu0lWogdbxumZcCY6nMhuaJO4rFdMgOkKITuU++4KLD3QO0ZcVUJW4xiRqaz5EZmZg+43bBQ0pKcphH14tdhFWwRjS3FmeO0L758gjbbsOZPLY6BahDy37DnVTE3LyN9n2uE4U9G9OlF5XVBZc5WGIxxL0Kwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzO8Tl3YLa+u6ZehKN64iZkIyT1kHCEci/GsUozWtRo=;
 b=WKAQuhxGAt6L8hIMjI5WFtcM8+Wvq4hKhY01G/oqRphqDG8WJY0I/kQ1Ii5RZ2QZ8il8v+nmWomFG+Oqk2OeMHkizfH2NRol/oX55sLgaBDhucKL4UaYBcdOYxeMjfRrpxYDgi3W9+NF00fYTjsk8z/z0ah+bqsw6tauWHOdD54=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2982.namprd18.prod.outlook.com (2603:10b6:a03:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Sun, 8 Mar
 2020 07:16:06 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2793.013; Sun, 8 Mar 2020
 07:16:06 +0000
From:   Alex Belits <abelits@marvell.com>
To:     "frederic@kernel.org" <frederic@kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Prasun Kapoor" <pkapoor@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 03/12] task_isolation: userspace hard isolation
 from kernel
Thread-Topic: [EXT] Re: [PATCH 03/12] task_isolation: userspace hard isolation
 from kernel
Thread-Index: AQHV8j73SZ7gA0FMRkuOSCw4mVFsAKg7vEEAgAKSHYA=
Date:   Sun, 8 Mar 2020 07:16:06 +0000
Message-ID: <3dc31856d82141e6600946d2227033a305f7a2b6.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <36d84b8dd168a38e6a56549dedc15dd6ebf8c09e.camel@marvell.com>
         <20200306160035.GD8590@lenoir>
In-Reply-To: <20200306160035.GD8590@lenoir>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53987f91-db06-4f83-962f-08d7c33091b5
x-ms-traffictypediagnostic: BYAPR18MB2982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB2982D049A84A1366BD0BF218BCE10@BYAPR18MB2982.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03361FCC43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39850400004)(396003)(366004)(189003)(199004)(6916009)(6512007)(6486002)(4326008)(6506007)(2906002)(71200400001)(54906003)(186003)(26005)(316002)(2616005)(478600001)(5660300002)(66476007)(66946007)(66556008)(66446008)(64756008)(36756003)(81166006)(81156014)(8936002)(91956017)(76116006)(8676002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2982;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yEKhDGzJ7PFNpKR+lrqHKw3fUPz9t8CtGTsC0EJYk8CkW2D8Bn9X07FjRU+VhSFG7oPSXXUvvfxxS7lFr7AeQEPWwiwaD2T23JjGr9wPW4odnj05VxgaFwvJe1TPDzsi5hl41mSS9xMZUIjrQ1vw96cM/haXQvGKWc5pfQl+NKX2jLmuW5gUAddE6Vmqh50AgXYwj9s3HlVhwkMPvQU/MVZOp5cVXbs8Z5TQkGXrjYKPk3ShZZ5MYpS30jA3K7IESpTrmzB8QzAEP3kJd3a5Y9JqcVSAlBloY/VnIIplRYzcDaxt+7850KYQypZs7WTJmnxIwvCgSnXwadN2uPMUj7RzzNhqyH4XfLNAiPysSo20GqkdptUMVlxwrNC7M7nuaBcUypy/FN83I2twWwwoVtS+Q5O9wXLepI1tVwsR7G3e67ejA7pw1smlT1aEjQtO
x-ms-exchange-antispam-messagedata: 9ElubIqEI8RGFMX5F6Mx8kCKOXPLwZNi/CWmHPhcjwL1gfkNmXqCWbSwvvf7byh1NVk9KYU1UWf5Tv/a4rhaSnbgf8mtasWuZQdRoQG/nZUBY20sLsFkqI/1FPvWowcnBZtXN+/Nf7NVbcDQyEZOVw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA5F4171FE118B469D0E2E1BA562D3E1@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53987f91-db06-4f83-962f-08d7c33091b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2020 07:16:06.4788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4IhKLQybgZkyc2PQs1fFwGD/lpJwDbrMp+adnAHF3uUXAa+MX39r/qJPVJaof+3qgIpuCkiEVIMdLXve1ZTrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2982
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-08_01:2020-03-06,2020-03-08 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTA2IGF0IDE3OjAwICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiBPbiBXZWQsIE1hciAwNCwgMjAyMCBhdCAwNDowNzoxMlBNICswMDAwLCBBbGV4IEJl
bGl0cyB3cm90ZToNCj4gPiArI2lmZGVmIENPTkZJR19UQVNLX0lTT0xBVElPTg0KPiA+ICtpbnQg
dHJ5X3N0b3BfZnVsbF90aWNrKHZvaWQpDQo+ID4gK3sNCj4gPiArCWludCBjcHUgPSBzbXBfcHJv
Y2Vzc29yX2lkKCk7DQo+ID4gKwlzdHJ1Y3QgdGlja19zY2hlZCAqdHMgPSB0aGlzX2NwdV9wdHIo
JnRpY2tfY3B1X3NjaGVkKTsNCj4gPiArDQo+ID4gKwkvKiBGb3IgYW4gdW5zdGFibGUgY2xvY2ss
IHdlIHNob3VsZCByZXR1cm4gYSBwZXJtYW5lbnQgZXJyb3INCj4gPiBjb2RlLiAqLw0KPiA+ICsJ
aWYgKGF0b21pY19yZWFkKCZ0aWNrX2RlcF9tYXNrKSAmIFRJQ0tfREVQX01BU0tfQ0xPQ0tfVU5T
VEFCTEUpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJaWYgKCFjYW5fc3Rv
cF9mdWxsX3RpY2soY3B1LCB0cykpDQo+ID4gKwkJcmV0dXJuIC1FQUdBSU47DQo+IA0KPiBOb3Rl
IHRoYXQgdGhlIHN0b3BfdGljayBuYW1pbmcgaW4gbm9oeiBjYW4gYmUgbWlzbGVhZGluZy4gSXQg
bWVhbnMNCj4gd2UgYWN0dWFsbHkgbGVhdmUgdGhlIHBlcmlvZGljIG1vZGUgYW5kIHdlIGVudGVy
IGluIGR5bmFtaWMgdGljaw0KPiBtb2RlLg0KPiANCj4gSW4gcHJhY3RpY2UgaXQgbWVhbnMgdGhh
dCB0aGUgdGljayBpcyBkZWxheWVkIHVudGlsIHRoZSBuZXh0IGV2ZW50LA0KPiB3aGljaA0KPiBp
biB0aGUgd29yc3QgY2FzZSBtYXkgd2VsbCBiZSBpbiAxIG1zIGFuZCBpbiB0aGUgYmVzdCBjYXNl
IG5ldmVyLiBTbw0KPiB3aGF0DQo+IHlvdSBwcm9iYWJseSB3YW50IHRvIGNoZWNrIGluc3RlYWQg
aXMgd2hldGhlciB0aGUgdGljayBoYXMgYmVlbg0KPiBlbnRpcmVseQ0KPiBzdG9wcGVkIChpZTog
d2UgY2FsbGVkIGhydGltZXJfY2FuY2VsKCZ0cy0+c2NoZWRfdGltZXIpKS4NCg0KVGhpcyBpcyBh
IHBhcnQgb2Ygc29sdXRpb24gd2hlcmUgbGlidG1jIGluIHVzZXJzcGFjZSBjaGVja3MgZm9yIHRp
bWVycw0KZnJvbSBhbm90aGVyIGNvcmUgYmVmb3JlIGl0IGNvbmZpcm1zIHRoYXQgdGhlIGNvcmUg
dGhhdCBpcyBlbnRlcmluZw0KaXNvbGF0aW9uIGNhbiBjb250aW51ZS4gU2luY2UsIGluZGVlZCwg
aXQgaXMgcG9zc2libGUgdGhhdCBzb21lIGV2ZW50cw0KYXJlIHBlbmRpbmcsIGl0IGlzIHVwIHRv
IHVzZXJzcGFjZSB0byB0ZWxsIHRoZSB0YXNrIHRoYXQgaXQncyBub3QNCnJlYWxseSBpc29sYXRl
ZCB5ZXQsIHNob3VsZCBleGl0IGFuZCByZS1lbnRlciBpc29sYXRpb24gd2hlbiBldmVyeXRoaW5n
DQppcyBkb25lLiBPciB0aGF0IGl0IHdpbGwgYmUgdG9vIG11Y2ggb2YgdGhlIHdhaXQsIGFuZCBp
dCBzaG91bGQgYmUgc2Vlbg0KYXMgYW4gZXJyb3IsIHJlcG9ydGVkLCBldGMuDQoNCk1heWJlIGl0
IHdvdWxkIGJlIGJldHRlciBpZiB3ZSBjaGVja2VkIGZvciB0aW1lciBzdGF0ZSBhbmQgcmV0dXJu
ZWQNCi1FQUdBSU4gd2hlbiBpdCBpcyBydW5uaW5nIGF0IHRoaXMgcG9pbnQsIGFuZCBsZWZ0IHVz
ZXJzcGFjZSBjaGVjayBmb3INCnRob3NlIGNhc2VzIHdoZW4gdGhpcyBkaWQgbm90IHdvcmsgZHVl
IHRvIHNvbWUgcmFjZSBhbmQgcHJlZW1wdGlvbi4NCkhvd2V2ZXIgSSBzdGlsbCB3YW50IHRvIGFz
c3VtZSB0aGF0IGFzIGxvbmcgYXMgdGhlcmUgaXMgbm8gY29tcGxldGUNCnByb2hpYml0aW9uIG9m
IHNjaGVkdWxpbmcgdGhpbmdzIG9uIGlzb2xhdGVkIENQVXMsIHRoZXJlIG1pZ2h0IGJlDQp0aGlu
Z3MgdGhhdCB3aWxsIGVuYWJsZSB0aGlzIHRpbWVyIGF0IHVuZXhwZWN0ZWQgdGltZXMgd2hpbGUg
d2UgYXJlDQpyZXR1cm5pbmcgdG8gdXNlcnNwYWNlIG9yIGV2ZW4gaW1tZWRpYXRlbHkgYWZ0ZXIg
d2UgZ290IGludG8gdXNlcnNwYWNlLg0KDQo+IA0KPiBUaGFua3MuDQo+IA0KPiA+ICsNCj4gPiAr
CXRpY2tfbm9oel9zdG9wX3NjaGVkX3RpY2sodHMsIGNwdSk7DQo+ID4gKwlyZXR1cm4gMDsNCj4g
PiArfQ0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gIHN0YXRpYyBib29sIGNhbl9zdG9wX2lkbGVf
dGljayhpbnQgY3B1LCBzdHJ1Y3QgdGlja19zY2hlZCAqdHMpDQo+ID4gIHsNCj4gPiAgCS8qDQo+
ID4gLS0gDQo+ID4gMi4yMC4xDQo+ID4gDQo=
