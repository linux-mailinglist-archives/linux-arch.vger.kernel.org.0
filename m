Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D58BE8FC
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 01:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbfIYXf3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Sep 2019 19:35:29 -0400
Received: from mail-eopbgr1310101.outbound.protection.outlook.com ([40.107.131.101]:37171
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728876AbfIYXf3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Sep 2019 19:35:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITqXaQc2qgNI7cZlkGn4VO77yr2ZjQO4jdmydvLRZ8Psgh+NlBLCxHWM+EFA2u26wASbLJNh4mEiUpcg2sOnPYBXX3vpAuPgB06N16ZjixOFDx1t/XRfE/fP5CMCS7wyzJHH67o25t6Wky+0WPMwzj/joCTyyN5Q5KEpRZ9J+d4c5m9cfpQe8q9ZVelAfB+BdDRqEIP4J6hiHFjjWcjlKZRRQktiYJOUmuUfQZtNSXD7j7fWErGyFKGhOgtylIwjtM5gAjsUNjVKfVhgNkv+PaQXfNwiLBztzrxr9guU64hgKxB9uk7aFw/c0YhoG7lZEahlMcXZ+bVRvOuWV/2JAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4piu0DfMGs4Dz6ShCcCahkWEkVUcxK8oVExZ5c/5oc=;
 b=XJQO612TX+eHwqMA+N7x583ATHOqAj1ZXwG+ZBSxTaRLLzsYpq94Lo3imdkMjoixMo6GebAJhhelV/c85U+Ig6oSahFvdU49kBmVCblnzgg6xD3GdTGC0BgHmik0CEFlaGUherzAMGWCYagfCzaNTHAAf02fim4KWNtlujaWtM69v0wibmVuzeeJ41rltTAHjvdWZtl5YqcAOiiwT1ievinXrODgJBZxS/5JS0FqqmA5iYcZhtIqBGGF6+BjjFGtqJMiorkA5uMujWVVQIcRlh+/RG273Oj21pkjJW3+xTO46TvpwyNS8RQykC9KbzFiZmxk60NWAxMxpHZbloasnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4piu0DfMGs4Dz6ShCcCahkWEkVUcxK8oVExZ5c/5oc=;
 b=PJGjXs82KI3FfT1X7o0bbaK7EsbbrOwYubwXE00+31pJma//i/+P8HZEOJtJ+uka5Qrg+hFolgPXaxwpSbDJ+asdYKXsdCTltKARGTUOl/5GXEfuxWqTmNdVZsylEPiN/xTKvtrT7GvjslVIHXXaZbuGkmvEUugJzY2rTRBDjyA=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.5; Wed, 25 Sep 2019 23:35:18 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 23:35:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Topic: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Index: AQHVc/fwSon8M7RoH0Cu+okwDUbU56c9CFiQ
Date:   Wed, 25 Sep 2019 23:35:18 +0000
Message-ID: <PU1P153MB0169A28B05A7CDE04A57AA58BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-4-git-send-email-decui@microsoft.com>
 <8ba5e2fd-6a9f-b61b-685e-23a69cabe3a2@linaro.org>
In-Reply-To: <8ba5e2fd-6a9f-b61b-685e-23a69cabe3a2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-25T23:35:15.9030009Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=47e669de-0e0b-4a54-8f04-fada6bf4e618;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:35f9:636:b84a:df21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10b12606-6f9f-415f-f5c8-08d74211066e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0139:|PU1P153MB0139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB013917B8D55F0EE875F4C1A6BF870@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(10290500003)(52536014)(1511001)(5660300002)(110136005)(478600001)(81166006)(6636002)(2501003)(7416002)(8990500004)(74316002)(7736002)(6246003)(4326008)(316002)(81156014)(8676002)(6116002)(446003)(11346002)(486006)(305945005)(8936002)(2906002)(2201001)(33656002)(476003)(14454004)(55016002)(229853002)(6436002)(86362001)(186003)(99286004)(14444005)(256004)(15650500001)(10090500001)(66946007)(9686003)(66476007)(76116006)(66446008)(64756008)(66556008)(7696005)(102836004)(76176011)(71190400001)(25786009)(71200400001)(53546011)(6506007)(46003)(22452003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUS4uwy2zkmGX23NBnf+TCH+Sfr7yfx0nZtgktVAiVtefr/Ov1sCg72gTIAG13P4cVprtuO68S2cnxYUZeJbBMp/3/4VKp7C9w5gZkyjZ+uAJENJcHcyMYYMMXirN+6cSLJs+BI/mu9ztaxRChDSNlqLlIqc2MRhv8dIrhBoPnJnzYolrEvGf2CAe+dUEVWz5VsUDoid11irdCpe3YgcGMm9e1UyObg50LrWZSWXEKjRqm5aQBG0gbyQwvffZ+FpWtiZ83B94rD4Tvl5V5Tc16kdJhR3uJN+fZtFQOld+/jtSOKpLXA9cJDUfPzZtr09Y39lv7wUg+Oke7lc/kJ/P2PB8NTTxQCPB+hlSZ+/Qhez4sc6wdNyBn0EJ1IGNz1mP2EFTX8zg51e7OVA9ezq+g5YTP1uAXEmWDVTFbKkyTE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b12606-6f9f-415f-f5c8-08d74211066e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 23:35:18.1629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afAzjQ6falO30Mfnrf9zinqS33RwzxnMVSApmwl3cNfvJjDt/BXSLX80X0cTlkxAavAxMi9dUIba8qsAqIXAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjUsIDIwMTkgNDoyMSBQTQ0KPiBUbzogRGV4dWFuIEN1
aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47IGFybmRAYXJuZGIuZGU7IGJwQGFsaWVuOC5kZTsNCj4g
SGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IGhwYUB6eXRvci5jb207IEtZ
IFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29tPjsgbGludXgtaHlwZXJ2QHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWluZ29AcmVkaGF0LmNv
bTsgc2FzaGFsQGtlcm5lbC5vcmc7IFN0ZXBoZW4NCj4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNy
b3NvZnQuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOyB4ODZAa2VybmVsLm9yZzsNCj4gTWljaGFl
bCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+OyBTYXNoYSBMZXZpbg0KPiA8QWxleGFu
ZGVyLkxldmluQG1pY3Jvc29mdC5jb20+DQo+IENjOiBsaW51eC1hcmNoQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvM10gY2xvY2tzb3VyY2UvZHJpdmVyczogU3Vz
cGVuZC9yZXN1bWUgSHlwZXItVg0KPiBjbG9ja3NvdXJjZSBmb3IgaGliZXJuYXRpb24NCj4gDQo+
IE9uIDA2LzA5LzIwMTkgMDA6NDcsIERleHVhbiBDdWkgd3JvdGU6DQo+ID4gVGhpcyBpcyBuZWVk
ZWQgZm9yIGhpYmVybmF0aW9uLCBlLmcuIHdoZW4gd2UgcmVzdW1lIHRoZSBvbGQga2VybmVsLCB3
ZSBuZWVkDQo+ID4gdG8gZGlzYWJsZSB0aGUgImN1cnJlbnQiIGtlcm5lbCdzIFRTQyBwYWdlIGFu
ZCB0aGVuIHJlc3VtZSB0aGUgb2xkIGtlcm5lbCdzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTWljaGFl
bCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+IA0KPiBJIGNhbiB0YWtlIHRoaXMg
cGF0Y2ggaWYgbmVlZGVkLg0KDQpUaGFua3MsIERhbmllbCEgVXN1YWxseSB0Z2x4IHRha2VzIGNh
cmUgb2YgdGhlIHBhdGNoZXMsIGJ1dCBpdCBsb29rcyByZWNlbnRseSBoZQ0KbWF5IGJlIHRvbyBi
dXN5IHRvIGhhbmRsZSB0aGUgMyBwYXRjaGVzLiANCg0KSSBndWVzcyB5b3UgY2FuIHRha2UgdGhl
IHBhdGNoLCBpZiB0Z2x4IGhhcyBubyBvYmplY3Rpb24uIDotKQ0KSWYgeW91IHRha2UgdGhlIHBh
dGNoLCBwbGVhc2UgdGFrZSBhbGwgdGhlIDMgcGF0Y2hlcy4NCg0KVGhhbmtzLA0KLS0gRGV4dWFu
DQo=
