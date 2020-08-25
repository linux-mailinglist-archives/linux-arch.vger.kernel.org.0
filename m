Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9F252348
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 00:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHYWEc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 18:04:32 -0400
Received: from mail-bn8nam12on2111.outbound.protection.outlook.com ([40.107.237.111]:55840
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgHYWEb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 18:04:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyEJ7G9kIzEFiWhboRyTZ1vwlidhX19NPRRguIri2YhfXY1uuoEtz+d0o6CTNfQBqQfYQ9WSQAEySQDeLCsKJpbpAq2Cs4xjO4j9BCB5zwvwD5LhuiHqhjZtI9CzvPq0ZIHcE/UjEN+UPqRcXyAl7l/EtsrhLUoy1IRdhPaDocjY02Br2BAiI+v3GGlLpogf/V4k5n4RpknLd2sxNuYoEJQ/GTdKieFjq3PkSikdMwThHTiaMA/+xGDFztaiy2Rm4D9ZaDOqb2+DabEseh25tqT1kypzzHv8frBlogc8IpM3m5a1jJuaz1HpPTXE638SxYXVLrLIb9jdNE1Y2c8luQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE8Z/tWl+u4WnQFE2uXbt0anWEgaR73AMU2h9uQ7S2U=;
 b=V/NfCYQyWMZxqQNc6SI13OHIkF8ChjEQlDnW1VAW4fqkkT3tIwvm3HEJElWtjnSM1G5SbJ7QimubKjBOhDil532So2YcYfpy6e5MfjXK7W0Wx2LrDArfWlq+GgwTMZRGG3XE/rPDRcXt2BrR7Dj6JYlwk1/neadaj6ZVB1wVdlOK7KMjDZk5l+fGG9TLU3LqJOkxBdkjlYJLVEI3JWPKyUb5y8QLI30toEvgy2RaYJ6ZiSIPoiplyVqQS9axR0HUiAEnyURzqWdlsfSZPXzEUGZM8nJKG2ygNj7uGiY+apeTkb0OO6qPA+yZAEiSGdauJIR0l8qNWIaNU74Pl4IEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE8Z/tWl+u4WnQFE2uXbt0anWEgaR73AMU2h9uQ7S2U=;
 b=I8ouyZLOoKtQOkt9qeaMr2bOqkm8pKxGLIMpk+yM+SulEjzwcCcXje7S6rlPVz4ZVtB9HlEDji/lXpszVlJjqaST91ci4pv0uZlkMk5l4i1zEYLcj47qO6qv8YnKMLW1t048gbbY22EkcQEdOdnF3vQ+ZJB0meeeBkO+cOSxChI=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1114.namprd21.prod.outlook.com (2603:10b6:302:a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Tue, 25 Aug
 2020 22:04:25 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%4]) with mapi id 15.20.3348.004; Tue, 25 Aug 2020
 22:04:25 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH v7 05/10] arm64: hyperv: Add interrupt handlers for VMbus
 and stimer
Thread-Topic: [PATCH v7 05/10] arm64: hyperv: Add interrupt handlers for VMbus
 and stimer
Thread-Index: AQHWejZULKiXaQlu5UG1gu+Nr5/wR6lHm48AgAG7GLA=
Date:   Tue, 25 Aug 2020 22:04:25 +0000
Message-ID: <MW2PR2101MB105201EF9EB186AA9BF31A74D7570@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-6-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1hDBVembCd+6=ENUWYFz=72JBTFMrKYZ2aFd+_Q04F+g@mail.gmail.com>
In-Reply-To: <CAK8P3a1hDBVembCd+6=ENUWYFz=72JBTFMrKYZ2aFd+_Q04F+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-25T22:04:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=75afd81d-5921-49f1-9e74-9e99c2cbe0ef;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee7984f4-7883-4e9e-d3ad-08d84942d458
x-ms-traffictypediagnostic: MW2PR2101MB1114:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB111423213200FF4BDE425446D7570@MW2PR2101MB1114.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmZJnYdDtoDeHV80fXPkYSjc1654zCGjpwFa6p59aB2OANFK2QkVComPGzf46t8hGjgCUq4ax4/ehPz8OwvtQJutS0JRLuDiREyZqaCa/wcHGHD9WBpA8cRDtbosCLcYAH6NJPA+mhd4KdLo7/Q5lco5v7/EiITyng5va6DTWwLdyKZ6P75sZcedAIuy+SrQvkYGMpLwFUPqmuMeOPtaml/EeWyQj4Xfe7SoDa049gC/E+oVs+FN7zvQ8QaUH1heiX5j4ipxgJInQTmpv9+VmCuPoyuigfTECStoa1i74YkNti2ZiOY6tMBphroO4pil8+CR/KV5YTjSrtQj8zzrkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(54906003)(8990500004)(316002)(7696005)(6506007)(53546011)(8676002)(64756008)(7416002)(2906002)(76116006)(66946007)(186003)(10290500003)(66446008)(66556008)(66476007)(26005)(86362001)(82950400001)(5660300002)(6916009)(82960400001)(33656002)(83380400001)(71200400001)(4326008)(8936002)(55016002)(9686003)(478600001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cDmXkqYOu2plpuMS7aDYB1g+Pt6O52dxLzzIpjlHvNiVi9x7tUWx8QnC7l/LZF6D5O2wBlh2iRO2Wv4b7VfeRH9yQPcxyqAYL789TFhXBWFV5EhMFjfTDWUQu34cmpYHsm6gJRTOgLnBPoeNSwjJxwy5vewLymA17EmfcmH380baogcYWSzVP9JF7bhUjdYgTytp1ntPDBIhjnOjNToMOYrqHNrXuDRXoGKmsp5Y+FBkHVS3avQiV2rjXHhoB3V/M13cxRBhQ76ROP7XmYaVCXVRdkGsyamVrGMJjvVorGf2pl7w8+68TcryFocrxt/yemp6tyTGZO6gllepBAXACd0U1lMd3GZQoBe+qf3QW1G7ppvI0XnWXqN2bBl/qVDO7BQ6sUD/MHwPXNvc/gDbyV7CymzNYa6LAKLNomklUr0gxU9XjMUDwbvSyH9jlaHBoTN+DIwcjaNw+gmkTNYTxsCole8K59QS6gGCZCOmCZXHjiuvWsQrUQNaTEQcmw+rIhB6g4yMEy+EtPN8yBTzPQ83oRfF4vr8Kc6ixlLIVEjUbYqUmAWMtrjxg1+LfJr6m5/DiWpMrXMN52xB6EI829Z3m0ipwWlKEQ9f+D+07NFecPATjzpMNtl898b91+N5d0R11QDP4g3ZA03wqAMBgA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7984f4-7883-4e9e-d3ad-08d84942d458
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 22:04:25.1176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EQER2tDCtDAu3JnaMs87oFkKCEsIBRzNFXk3jZTN380xnErFa/dreL+y7u+82eIMRnI2np0gCwjDrpmqhBYakZznS0QKF21370yiImEquw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1114
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogTW9uZGF5LCBBdWd1c3Qg
MjQsIDIwMjAgMTE6NTQgQU0NCj4gDQo+IE9uIE1vbiwgQXVnIDI0LCAyMDIwIGF0IDY6NDYgUE0g
TWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
QWRkIEFSTTY0LXNwZWNpZmljIGNvZGUgdG8gc2V0IHVwIGFuZCBoYW5kbGUgdGhlIGludGVycnVw
dHMNCj4gPiBnZW5lcmF0ZWQgYnkgSHlwZXItViBmb3IgVk1idXMgbWVzc2FnZXMgYW5kIGZvciBz
dGltZXIgZXhwaXJhdGlvbi4NCj4gPg0KPiA+IFRoaXMgY29kZSBpcyBhcmNoaXRlY3R1cmUgZGVw
ZW5kZW50IGFuZCBpcyBtb3N0bHkgZHJpdmVuIGJ5DQo+ID4gYXJjaGl0ZWN0dXJlIGluZGVwZW5k
ZW50IGNvZGUgaW4gdGhlIFZNYnVzIGRyaXZlciBhbmQgdGhlDQo+ID4gSHlwZXItViB0aW1lciBj
bG9ja3NvdXJjZSBkcml2ZXIuDQo+ID4NCj4gPiBUaGlzIGNvZGUgaXMgYnVpbHQgb25seSB3aGVu
IENPTkZJR19IWVBFUlYgaXMgZW5hYmxlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2Fy
bTY0L2h5cGVydi9NYWtlZmlsZSAgICAgICAgfCAgIDIgKy0NCj4gPiAgYXJjaC9hcm02NC9oeXBl
cnYvbXNoeXBlcnYuYyAgICAgIHwgMTMzDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCB8ICA3MCAr
KysrKysrKysrKysrKysrKysrKw0KPiANCj4gSSBzdGlsbCBoYXZlIHRoZSBmZWVsaW5nIHRoYXQg
bW9zdCBvZiB0aGUgY29kZSBpbiBhcmNoL2FybTY0L2h5cGVydi8gaXMNCj4gbWlzcGxhY2VkOiB0
aGUgb25seSBjYWxsZXJzIGFyZSBsb2FkYWJsZSBtb2R1bGVzIGluIGRyaXZlcnMvaHYvLCBhbmQg
dGhlDQo+IGNvZGUgaXMgbm90IHJlYWxseSBwYXJ0IG9mIHRoZSBhcmNoaXRlY3R1cmUgYnV0IHBh
cnQgb2YgdGhlIHBsYXRmb3JtLg0KPiANCj4gRm9yIHRoZSBhcm02NCBhcmNoaXRlY3R1cmUsIHdl
IGhhdmUgYSBydWxlIHRoYXQgcGxhdGZvcm0gc3BlY2lmaWMNCj4gY29kZSBiZWxvbmdzIGludG8g
ZGV2aWNlIGRyaXZlcnMgcmF0aGVyIHRoYW4gaW50byB0aGUgYXJjaGl0ZWN0dXJlDQo+IGNvZGUg
YXMgd2UgdXNlZCB0byBkbyBpbiB0aGUgbGludXgtMi42IGRheXMgZm9yIGFyY2gvYXJtLy4NCj4g
DQo+IEkgZG9uJ3Qgc2VlIGh5cGVydiBiZWluZyB2aXJ0dWFsIHJhdGhlciB0aGFuIGFuIFNvQyBh
cyBhIGRpZmZlcmVudGlhdG9yDQo+IGVpdGhlcjsgaXQncyBzdGlsbCBqdXN0IG9uZSBvZiBtYW55
IHBsYXRmb3Jtcy4gSWYgeW91IGxvb2sgYXQNCj4gYXJjaC9hcm02NC94ZW4vLCB5b3UgY2FuIHNl
ZSB0aGF0IHRoZXkgaGF2ZSBtYW5hZ2VkIHRvIGdldA0KPiB0byBhIG11Y2ggc2ltcGxlciBpbXBs
ZW1lbnRhdGlvbiBpbiBjb21wYXJpc29uLg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoYXQgdGhlIGNv
cnJlY3Qgc29sdXRpb24gc2hvdWxkIGJlLCBidXQgd2hhdCBJJ2QgdHJ5IHRvDQo+IGRvIGhlcmUg
aXMgdG8gbW92ZSBldmVyeSBmdW5jdGlvbiB0aGF0IGp1c3QgY29uc2lkZXJzIHRoZSBwbGF0Zm9y
bQ0KPiByYXRoZXIgdGhhbiB0aGUgYXJjaGl0ZWN0dXJlIHNvbWV3aGVyZSBpbnRvIGRyaXZlcnMv
aHYgd2hlcmUgaXQNCj4gY2FuIGJlIGxpbmtlZCBpbnRvIHRoZSBzYW1lIG1vZHVsZXMgYXMgdGhl
IGV4aXN0aW5nIGZpbGVzIHdoZW4NCj4gYnVpbGRpbmcgZm9yIGFybTY0LCB3aGlsZSB0cnlpbmcg
dG8ga2VlcCBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgY29kZQ0KPiBpbiB0aGUgaGVhZGVyIGZpbGUg
d2hlcmUgaXQgY2FuIGJlIGluY2x1ZGVkIGZyb20gdGhvc2UgbW9kdWxlcy4NCg0KT0suICBUaGUg
Y29uY2VwdCBvZiBzZXBhcmF0aW5nIHBsYXRmb3JtIGZyb20gYXJjaGl0ZWN0dXJlIG1ha2VzDQpz
ZW5zZSB0byBtZS4gIFRoZSBvcmlnaW5hbCBzZXBhcmF0aW9uIG9mIHRoZSBIeXBlci1WIGNvZGUg
aW50bw0KYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IHBvcnRpb25zIGFuZCB4ODYtc3BlY2lmaWMg
cG9ydGlvbnMgY291bGQNCnVzZSBzb21lIHR3ZWFraW5nIG5vdyB0aGF0IHdlJ3JlIGRlYWxpbmcg
d2l0aCBuPTIgYXJjaGl0ZWN0dXJlcy4gIFdpdGgNCnRoYXQgdHdlYWtpbmcsIEkgY2FuIHJlZHVj
ZSB0aGUgYW1vdW50IG9mIEh5cGVyLVYgY29kZSB1bmRlciBhcmNoL3g4Ng0KYW5kIHVuZGVyIGFy
Y2gvYXJtNjQuDQoNCk9uIHRoZSBmbGlwIHNpZGUsIHRoZSBIeXBlci1WIGltcGxlbWVudGF0aW9u
IG9uIHg4NiBhbmQgQVJNNjQgaGFzDQpkaWZmZXJlbmNlcyB0aGF0IGFyZSBzZW1pLXJlbGF0ZWQg
dG8gdGhlIGFyY2hpdGVjdHVyZS4gIEZvciBleGFtcGxlLCBvbg0KeDg2IEh5cGVyLVYgdXNlcyBz
eW50aGV0aWMgTVNScyBmb3IgYSBsb3Qgb2YgZ3Vlc3QtaHlwZXJ2aXNvciBzZXR1cCwgd2hpbGUN
Cmh5cGVyY2FsbHMgYXJlIHJlcXVpcmVkIG9uIEFSTTY0LiAgU28gSSdtIGFzc3VtaW5nIHRob3Nl
IGRpZmZlcmVuY2VzDQp3aWxsIGVuZCB1cCBpbiBjb2RlIHVuZGVyIGFyY2gveDg2IGFuZCBhcmNo
L2FybTY0LiAgQXJndWFibHksIEkgY291bGQNCmludHJvZHVjZSBhIGxldmVsIG9mIGluZGlyZWN0
aW9uIChzdWNoIGFzIENPTkZJR19IWVBFUlZfVVNFX01TUlMgdnMuDQpDT05GSUdfSFlQRVJWX1VT
RV9IWVBFUkNBTExTKSB0byBkaXN0aW5ndWlzaCB0aGUgdHdvIGJlaGF2aW9ycy4NClRoZSBzZWxl
Y3Rpb24gd291bGQgYmUgdGllZCB0byB0aGUgYXJjaGl0ZWN0dXJlLCBhbmQgdGhlbiBjb2RlIGlu
DQpkcml2ZXJzL2h2IGNhbiAjaWZkZWYgdGhlIHR3byBjYXNlcy4gIEJ1dCBJIHdvbmRlciBpZiBn
ZXR0aW5nIGNvZGUgb3V0IG9mDQphcmNoL3g4NiBhbmQgYXJjaC9hcm02NCBpcyB3b3J0aCB0aGF0
IGFkZGl0aW9uYWwgbWVzc2luZXNzLg0KDQpMb29raW5nIGF0IHRoZSBYZW4gY29kZSBpbiBkcml2
ZXJzL3hlbiwgaXQgbG9va3MgbGlrZSBhIGxvdCBvZiB0aGUgWGVuIGZ1bmN0aW9uYWxpdHkNCmlz
IGltcGxlbWVudGVkIGluIGh5cGVyY2FsbHMgdGhhdCBjYW4gYmUgY29uc2lzdGVudCBhY3Jvc3Mg
YXJjaGl0ZWN0dXJlcywNCnRob3VnaCBJIHdhcyBhIGJpdCBzdXJwcmlzZWQgdG8gc2VlIGEgZG96
ZW4gb3Igc28gaW5zdGFuY2VzIG9mICNpZmRlZiBDT05GSUdfWDg2Lg0KWGVuIGFsc28gI2lmZGVm
cyBvbiBQViB2cy4gUFZIVk0sIHdoaWNoIG1heSBoYW5kbGUgc29tZSBhcmNoaXRlY3R1cmUNCmRp
ZmZlcmVuY2VzIGltcGxpY2l0bHkuICBCdXQgSSdtIGFzc3VtaW5nIHRoYXQgZG9pbmcgI2lmZGVm
IDxhcmNoaXRlY3R1cmU+DQppbiB0aGUgSHlwZXItViBjb2RlIGluIG9yZGVyIHRvIHJlZHVjZSBj
b2RlIHVuZGVyIGFyY2gveDg2IG9yIGFyY2gvYXJtNjQNCmlzIG5vdCB0aGUgcmlnaHQgd2F5IHRv
IGdvLg0KDQpNaWNoYWVsDQoNCj4gDQo+ICAgICAgIEFybmQNCg==
