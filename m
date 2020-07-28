Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61740230082
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 06:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG1EO1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 00:14:27 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43420 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbgG1EO0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 00:14:26 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 780A140121;
        Tue, 28 Jul 2020 04:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1595909666; bh=pB5MqliBswYzDwRUMHxjSwH/e2+/99t61ohwOfuFQyY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=isOrGDkGDjeXK+2UMmRTBY05qG2x14m74tgTC6Am2VrZh6J+5x1xBnRxNjyXsWoeW
         d4X/v4dfYDF3KYaWYT+wvOhzoZugqNXlnSGJtAHE8sCuU0v/hMngxAYzM9AGF+q+9f
         vIQpLHwsX0IePHfu5ybzeQ4E/RXYBZ/8m69WVyFG+qhiE9x9U6PaG9t8YhU0hlQs1O
         gm+rgfrWhe3/agT/Hng9BvcHMVOGTQ7mt/9tOIU5VjYPyrox4YG6/hgqcFes6UxbnM
         xra0CebPI4x/vIWhKXGCf5gHWwI0YxVF4cPl8RvVPPsMQw0DkKwN24x7Vn/0XiMfZM
         r9KgkLA4nh08A==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6A821A0079;
        Tue, 28 Jul 2020 04:14:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4A9A780FB6;
        Tue, 28 Jul 2020 04:14:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MEL4Wf4u";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KckpeMv6AcPZXXWUUkJXmWOEl9CWM/J3sj5mOkasSmZL67NDRgu9KNcUVysfTn5v0EvwJKk7KCcnmVUoCbMkrcAz95vBK4HIjl/zMbf9/fenRIAOpMyKkL6tFaiuMg9e9eeUPhYLpbp7nCju0k9nbhh159pKFWrkZT2e19FYQYSgAnh7j9wnM88VS9mqTpNjVV65eq13qjMnGNXtozsqXSrSWoaT9uA0XIGP74WaBNuXee8udtsoyrPArIwHJatc30x7xJKBEM9zxFCoaNcyE45bFW1R9sKvCWQkm4/GXp+lVBKwx+e135v3pB8g5bs23WRMlKegFtDN8DXCZBhBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB5MqliBswYzDwRUMHxjSwH/e2+/99t61ohwOfuFQyY=;
 b=VC8EbaNg3S5jn5/tNa9T5qiRbA4AY3KSH8Sh9FB9KovkHNALGOrXeDPQr1E+fedGvDn3Dx/960w70wPOuOWW4wh4YfKRciU8LcwD+AK1n2FjoQiCZzV0GyVD2W92LoPg5V8IpsrzqNuNu3tIF9dE9GJRqMSuU1vte6I4juuJtOok5GMoxr5fPd9UPAd7N5DjBGtqGgIAwQAxDlZ/UgpWXVaE9/+fA8HNdiyGzOSVqHp7pgEmOXN+ov/OU6HEL3apHr6cVjK+YlqcnrOZ2o94Q9XUfP2l69uFCtZDXxNq19qN1Y+4qekO4uVhkd+HGMzJbGQe6ePxq4gx37C+AKsupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB5MqliBswYzDwRUMHxjSwH/e2+/99t61ohwOfuFQyY=;
 b=MEL4Wf4u0FWXHTGDJfrZYTKSMhhb2uDp1HQxQ9fIlC5foUGOFE4mkcKxGJON2fatN50pf+xgwnNBVjxFm7ej1NhKC6B+3fgOq+c/ERZBvD1WjSIfWKcJ5OxPjhvMxsbyA1SssZ8ln68y/fTko0KnB0iJewn/x3cNlt3s03ym47I=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3480.namprd12.prod.outlook.com (2603:10b6:a03:aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 04:14:18 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4%7]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 04:14:18 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 04/24] arm: use asm-generic/mmu_context.h for no-op
 implementations
Thread-Topic: [PATCH 04/24] arm: use asm-generic/mmu_context.h for no-op
 implementations
Thread-Index: AQHWZJWPTsO8E3Tk50qowEQAEpCHaw==
Date:   Tue, 28 Jul 2020 04:14:18 +0000
Message-ID: <86611bf1-13b2-65e5-50d5-b0701020cd3e@synopsys.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-5-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-5-npiggin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [73.222.250.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 044b8976-e8d6-433b-54ba-08d832acb267
x-ms-traffictypediagnostic: BYAPR12MB3480:
x-microsoft-antispam-prvs: <BYAPR12MB34805C3C983502455EDABB01B6730@BYAPR12MB3480.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:60;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaj7I4PuBDc5L+DPgrx6gb3FI/Q+8y9QPmLW3ukc+hufBJZCIzm/WWKOlteNFSvWTKxtAwCVcU8+yoZJRjfx2COiLsUMGu12ezokv6DOwA4jUsOZdwIm3TVHZ/ry38juQ86jyRFOTFvmAfGb/rUypOjBpuQ+bLpEgoVtFtbpdzg1ijx8I4XeOyOflS8qvJrISNsNZffQhaDIn9irrZWiryCCFqj0cMrMz4XTvGQrCXrFlsSr5toXCeEAYbSTLOzdH/fOk6S2MIFx4CdoxJJGbaAmv47vw/F+BWMcUDMsIEe/l+kCdRzyp6aVuelhplrm6rCHa70OOPX+zFfTAk42Ri5fngXfokSKzOKWiJ30BMlloxyIHDfO34l2nz3xv8gfWSOBGspqsFkKteWpUmXJeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(376002)(396003)(39860400002)(31686004)(86362001)(8936002)(6486002)(83380400001)(110136005)(54906003)(31696002)(8676002)(2616005)(36756003)(26005)(66446008)(64756008)(66476007)(4326008)(76116006)(66946007)(2906002)(478600001)(53546011)(186003)(6512007)(66556008)(316002)(5660300002)(6506007)(71200400001)(41533002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PFgVnW46YDUQZ7+MnVSYGnDy4dGYGpH431MjnBXpkmqk+RBeRKV7CrjTn/lkLVw1AQ6nVw/AED2/fx17qTZ1H3vkNC6npJM8cd61u5v1Pr+vm107Q/jdPQaXtztNgIPorXp9TXPlzuYqWkj9RC0k5wUWE8cFno0rUpb0e/Zjkms1aK5SC7CcNxDTD2cZkqI6oBrR1AQBtWMxtIjCOmXGleL4SiyKLuDHbhWXqi2F4H9MUjvi5sdE/rWJ/P4/bCWzoVW0LgV+gaRljdY2fOvoKDaX1x9UwugYbjSP7PbtE96gyXOGJ3emaIhZcHCXH3+8+uWuhSPXpXmAVEEIbE5dGfRiT6FD5dTngq/6dAB9lHOQBowVU+855OJ0QuX9DxLR+tBOWeYoVYaQ93lqnon8QYUKkYzirTxF+K6AJllMGbQX7UCDXh4XhcxsFd7npcejIpa+Y+WR3yzr1VHzpNvF5oX/gOFZ9EWkl6vzf9a1+vmj8YWTUtQXWjkTDwBAeBt8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C31602D99210B240A81A2567C2C2840E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044b8976-e8d6-433b-54ba-08d832acb267
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 04:14:18.1205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JSmi/kAQDmVya2vUJIqXFeL+toD0xfNM2Q1o5eRUp6g7aPN2FD8IfnkO1h6tTBC+jjdmSGetRVmAR7GDAqJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3480
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNy8yNy8yMCA4OjMzIFBNLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6DQo+IENjOiBSdXNzZWxs
IEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBQaWdnaW4gPG5waWdn
aW5AZ21haWwuY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL21tdV9jb250ZXh0
LmggfCAyNiArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL21tdV9j
b250ZXh0LmgNCj4gaW5kZXggZjk5ZWQ1MjRmZTQxLi44NGU1ODk1NmZjYWIgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmgNCj4gKysrIGIvYXJjaC9hcm0v
aW5jbHVkZS9hc20vbW11X2NvbnRleHQuaA0KPiBAQCAtMjYsNiArMjYsOCBAQCB2b2lkIF9fY2hl
Y2tfdm1hbGxvY19zZXEoc3RydWN0IG1tX3N0cnVjdCAqbW0pOw0KPiAgI2lmZGVmIENPTkZJR19D
UFVfSEFTX0FTSUQNCj4gIA0KPiAgdm9pZCBjaGVja19hbmRfc3dpdGNoX2NvbnRleHQoc3RydWN0
IG1tX3N0cnVjdCAqbW0sIHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKTsNCj4gKw0KPiArI2RlZmlu
ZSBpbml0X25ld19jb250ZXh0IGluaXRfbmV3X2NvbnRleHQNCj4gIHN0YXRpYyBpbmxpbmUgaW50
DQo+ICBpbml0X25ld19jb250ZXh0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLCBzdHJ1Y3QgbW1f
c3RydWN0ICptbSkNCj4gIHsNCj4gQEAgLTkyLDMyICs5NCwxMCBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgZmluaXNoX2FyY2hfcG9zdF9sb2NrX3N3aXRjaCh2b2lkKQ0KPiAgDQo+ICAjZW5kaWYJLyog
Q09ORklHX01NVSAqLw0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIGludA0KPiAtaW5pdF9uZXdfY29u
dGV4dChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgc3RydWN0IG1tX3N0cnVjdCAqbW0pDQo+IC17
DQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gLQ0KPiAgI2VuZGlmCS8qIENPTkZJR19DUFVf
SEFTX0FTSUQgKi8NCj4gIA0KPiAtI2RlZmluZSBkZXN0cm95X2NvbnRleHQobW0pCQlkbyB7IH0g
d2hpbGUoMCkNCj4gICNkZWZpbmUgYWN0aXZhdGVfbW0ocHJldixuZXh0KQkJc3dpdGNoX21tKHBy
ZXYsIG5leHQsIE5VTEwpDQoNCkFjdHVhbGx5IHRoaXMgY2FuIGFsc28gZ28gYXdheSB0b28uDQoN
CkFSTSBzd2l0Y2hfbW0ocHJldiwgbmV4dCwgdHNrKSAtPiBjaGVja19hbmRfc3dpdGNoX2NvbnRl
eHQobmV4dCwgdHNrKSBidXQgbGF0dGVyDQpkb2Vzbid0IHVzZSBAdHNrIGF0IGFsbC4gV2l0aCBw
YXRjaCBiZWxvdywgeW91IGNhbiByZW1vdmUgYWJvdmUgYXMgd2VsbC4uLg0KDQotLS0tLS0tLT4N
CkZyb20gNjcyZTBmNzhhOTQ4OTI3OTQwNTdhNWE3NTQyZDg1YjcxYzEzNjljNCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDENCkZyb206IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4N
CkRhdGU6IE1vbiwgMjcgSnVsIDIwMjAgMjE6MTI6NDIgLTA3MDANClN1YmplY3Q6IFtQQVRDSF0g
QVJNOiBtbTogY2hlY2tfYW5kX3N3aXRjaF9jb250ZXh0KCkgZG9lc24ndCB1c2UgQHRzayBhcmcN
Cg0KU2lnbmVkLW9mZi1ieTogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KLS0t
DQogYXJjaC9hcm0vaW5jbHVkZS9hc20vZWZpLmggICAgICAgICB8IDIgKy0NCiBhcmNoL2FybS9p
bmNsdWRlL2FzbS9tbXVfY29udGV4dC5oIHwgNSArKy0tLQ0KIGFyY2gvYXJtL21tL2NvbnRleHQu
YyAgICAgICAgICAgICAgfCAyICstDQogMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9lZmku
aCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2VmaS5oDQppbmRleCA1ZGNmM2M2MDExYjcuLjA5OTVi
MzA4MTQ5ZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2VmaS5oDQorKysgYi9h
cmNoL2FybS9pbmNsdWRlL2FzbS9lZmkuaA0KQEAgLTM3LDcgKzM3LDcgQEAgaW50IGVmaV9zZXRf
bWFwcGluZ19wZXJtaXNzaW9ucyhzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCmVmaV9tZW1vcnlfZGVz
Y190ICptZCk7DQoNCiBzdGF0aWMgaW5saW5lIHZvaWQgZWZpX3NldF9wZ2Qoc3RydWN0IG1tX3N0
cnVjdCAqbW0pDQogew0KLQljaGVja19hbmRfc3dpdGNoX2NvbnRleHQobW0sIE5VTEwpOw0KKwlj
aGVja19hbmRfc3dpdGNoX2NvbnRleHQobW0pOw0KIH0NCg0KIHZvaWQgZWZpX3ZpcnRtYXBfbG9h
ZCh2b2lkKTsNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5o
IGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaA0KaW5kZXggZjk5ZWQ1MjRmZTQx
Li5jOTYzNjBmYTM0NjYgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9tbXVfY29u
dGV4dC5oDQorKysgYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oDQpAQCAtMjUs
NyArMjUsNyBAQCB2b2lkIF9fY2hlY2tfdm1hbGxvY19zZXEoc3RydWN0IG1tX3N0cnVjdCAqbW0p
Ow0KDQogI2lmZGVmIENPTkZJR19DUFVfSEFTX0FTSUQNCg0KLXZvaWQgY2hlY2tfYW5kX3N3aXRj
aF9jb250ZXh0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzayk7
DQordm9pZCBjaGVja19hbmRfc3dpdGNoX2NvbnRleHQoc3RydWN0IG1tX3N0cnVjdCAqbW0pOw0K
IHN0YXRpYyBpbmxpbmUgaW50DQogaW5pdF9uZXdfY29udGV4dChzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRzaywgc3RydWN0IG1tX3N0cnVjdCAqbW0pDQogew0KQEAgLTQ3LDggKzQ3LDcgQEAgc3RhdGlj
IGlubGluZSB2b2lkIGExNV9lcnJhdHVtX2dldF9jcHVtYXNrKGludCB0aGlzX2NwdSwgc3RydWN0
DQptbV9zdHJ1Y3QgKm1tLA0KDQogI2lmZGVmIENPTkZJR19NTVUNCg0KLXN0YXRpYyBpbmxpbmUg
dm9pZCBjaGVja19hbmRfc3dpdGNoX2NvbnRleHQoc3RydWN0IG1tX3N0cnVjdCAqbW0sDQotCQkJ
CQkgICAgc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQorc3RhdGljIGlubGluZSB2b2lkIGNoZWNr
X2FuZF9zd2l0Y2hfY29udGV4dChzdHJ1Y3QgbW1fc3RydWN0ICptbSkNCiB7DQogCWlmICh1bmxp
a2VseShtbS0+Y29udGV4dC52bWFsbG9jX3NlcSAhPSBpbml0X21tLmNvbnRleHQudm1hbGxvY19z
ZXEpKQ0KIAkJX19jaGVja192bWFsbG9jX3NlcShtbSk7DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bW0vY29udGV4dC5jIGIvYXJjaC9hcm0vbW0vY29udGV4dC5jDQppbmRleCBiNzUyNWI0MzNmM2Uu
Ljg2YzQxMWUxZDdjYiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL21tL2NvbnRleHQuYw0KKysrIGIv
YXJjaC9hcm0vbW0vY29udGV4dC5jDQpAQCAtMjM0LDcgKzIzNCw3IEBAIHN0YXRpYyB1NjQgbmV3
X2NvbnRleHQoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGludCBjcHUpDQogCXJldHVy
biBhc2lkIHwgZ2VuZXJhdGlvbjsNCiB9DQoNCi12b2lkIGNoZWNrX2FuZF9zd2l0Y2hfY29udGV4
dChzdHJ1Y3QgbW1fc3RydWN0ICptbSwgc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQordm9pZCBj
aGVja19hbmRfc3dpdGNoX2NvbnRleHQoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQogew0KIAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KIAl1bnNpZ25lZCBpbnQgY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgp
Ow0KLS0gDQoyLjIwLjENCg0K
