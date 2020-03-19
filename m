Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96D218C279
	for <lists+linux-arch@lfdr.de>; Thu, 19 Mar 2020 22:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCSVph (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Mar 2020 17:45:37 -0400
Received: from mail-bn7nam10on2121.outbound.protection.outlook.com ([40.107.92.121]:38135
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbgCSVpg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Mar 2020 17:45:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5iaECNCtyQDqKehPfeH1kcMlDansDCPeH29KGEcK64eKbSn0ZDTWdPP5Lj8Manl/O6QRbPwPuEzB8fEp74styHjDZm7neViR9cldsw6j0KvLIOJ3q/z/0GJNm1wK6Udj4Nq+z8eVdJeb/zNSmX7WTVC9N9VeXH07LaXI/3iOYWk8pi19pQVAY8h+0vpFln+YovUUFOEFzmqYFqwOA+pnTboxoAsjePYxpKs+Ez0J/KFUmbWRhHGl4+6eS6MK817yZAW7Tkeytt3Xfc38oGrKQjZfPwXgRvkCms97N1rm2NO7UEOZLQRRQ9DfpqeasF5b5OCQGJoyWkjomqgnT4LCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm8HNIbwkBQkL6TY2Q3+lpEb3Oi9c9RsvQbi3rIOM5g=;
 b=gFZQNp1um1sN4QPjPYrAo8xqf+JCp+Om+3XwVprJbhXylj7epxc9SKBkYf2aR67CNjo/a+1nUDgAJEXkuWCyVhPa5LHDXmnWZUkTFhxX7MblZ76rpEG7hGPcvrKWtpxDViqD1p7pFaclB9JtY3If8gOLYxBJpd6E5bglC/aygEvBWBFO5pGpcTaWX7akrqGICShoLP4N73EFAR9ORdV6J3gb1epjWsPpsjO3wdCnFXRRLWSceAVVkelm5etiqposynad1zHH85RW/rBR6urhNnFtkkG4Rmcfihjt5I8A8u3DGoQgmoZhO9UH/RzACKDKwucbKq8XcmHc3Z+QN2IRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm8HNIbwkBQkL6TY2Q3+lpEb3Oi9c9RsvQbi3rIOM5g=;
 b=deHe6DcyaaXADZv39KVL5iOGkKuvh5MOwQwgw82jERcaTmMxuRN5N6UrcgTCQbuP8Ct3CfLiYqUk2aaakKP3tKYttuC2rPyJQKxOua6UGXMr/aKTZslPARMRnrYiL1lRjLogi0zGW022XMFVsvI9kr0h6W2T97uhDAf5cPa/4Z4=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0986.namprd21.prod.outlook.com (2603:10b6:302:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.9; Thu, 19 Mar
 2020 21:43:53 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%10]) with mapi id 15.20.2856.003; Thu, 19 Mar 2020
 21:43:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Marc Zyngier <maz@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Andy Whitcroft <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Thread-Topic: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Thread-Index: AQHV+hZH2sSK6TnWLUqKIqZdhn3BQ6hK4/SAgAACOwCAAACGAIACfgqwgAC+cYCAAlRDsA==
Date:   Thu, 19 Mar 2020 21:43:53 +0000
Message-ID: <MW2PR2101MB10520CEF065A41EEBC17FFC2D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
 <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
 <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
In-Reply-To: <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T21:43:50.6696075Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56713056-2876-4ed4-93d0-4c915dc7a2f6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cef2aaf-ec77-4ecc-6c3b-08d7cc4e9e4f
x-ms-traffictypediagnostic: MW2PR2101MB0986:|MW2PR2101MB0986:|MW2PR2101MB0986:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09861513151693324BD256D0D7F40@MW2PR2101MB0986.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(81166006)(8676002)(66446008)(66556008)(54906003)(66476007)(76116006)(81156014)(7696005)(5660300002)(186003)(478600001)(10290500003)(33656002)(9686003)(6916009)(55016002)(71200400001)(64756008)(8990500004)(7416002)(2906002)(86362001)(316002)(4326008)(52536014)(26005)(66946007)(6506007)(53546011)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0986;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Kz7Ur6ernmi1SE9El/j2MfwlUdfxD3wsJXPQSfwwAuRvCVNnlo/tRCIJPfISgGnBXwKWxg4+M+Bn53hZIfES3q8sr52BjzaYKmmRbhln2Gf9lgFJaqiURUIOHTfCxljaDdQeCAra+PJIKdTSIieZp/CKuEkhcP8whVzVUExKbjAaXcdBdLuM241BeBZZL+uUGmDdjHfrpleJIF8hg81Oc+pSsHZHbeh1wy49yetxHTxhSNIrKuyNt/DgZ/9COJdRRrESp2SEwKD+uUQPf/wTX7TepRzThtM6i28zEXWMfXrTSmtYPkqG2/8U/4SwZtqUgACmN6QNMHgyYEpqTdHpO+f0wsal8hDQFu+HMLCj1ZIK0y412I0PdIQUPZe7vwGUchXgOoWPW4kzA6hshGahxtBdhiNvUTB9CPkVkoHvZ9B1E0iAxf1MOHxnAZXTIl4
x-ms-exchange-antispam-messagedata: jr/m8580mc6xmlVtdhsoBkR3eyY116Nzqja4KR8zNALnK3p/0wp5dr4YlYTkUmL54ySF1QZsoxbiCTXm0rk+xJpnLFHe8ceUXl3YcmbFSlqMh7+ySm8nwgiDNW78MJZ1cknFmk7HxjkfTrURsIy47Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cef2aaf-ec77-4ecc-6c3b-08d7cc4e9e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 21:43:53.1195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bR7utV+okEes+rS+HUC1TKO9xknKo07vebinOG/qQjFngv++FGe29HFyujHGsf882Hbqn7ecoi28Lv/CGhj0gq64mpzic5cN/spSRULdF+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0986
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAxOCwgMjAyMCAyOjU4IEFNDQo+IA0KPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAxOjE1IEFN
IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiBGcm9t
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAy
MDIwIDE6MzMgQU0NCj4gPiA+DQo+ID4gPiBPbiBNb24sIE1hciAxNiwgMjAyMCBhdCA5OjMwIEFN
IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gPiBPbiAyMDIwLTAz
LTE2IDA4OjIyLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFNhdCwgTWFyIDE0
LCAyMDIwIGF0IDQ6MzYgUE0gTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+
DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4+ICAvKg0KPiA+ID4gPiA+PiArICogRnVuY3Rp
b25zIGZvciBhbGxvY2F0aW5nIGFuZCBmcmVlaW5nIG1lbW9yeSB3aXRoIHNpemUgYW5kDQo+ID4g
PiA+ID4+ICsgKiBhbGlnbm1lbnQgSFZfSFlQX1BBR0VfU0laRS4gVGhlc2UgZnVuY3Rpb25zIGFy
ZSBuZWVkZWQgYmVjYXVzZQ0KPiA+ID4gPiA+PiArICogdGhlIGd1ZXN0IHBhZ2Ugc2l6ZSBtYXkg
bm90IGJlIHRoZSBzYW1lIGFzIHRoZSBIeXBlci1WIHBhZ2UNCj4gPiA+ID4gPj4gKyAqIHNpemUu
IFdlIGRlcGVuZCB1cG9uIGttYWxsb2MoKSBhbGlnbmluZyBwb3dlci1vZi10d28gc2l6ZQ0KPiA+
ID4gPiA+PiArICogYWxsb2NhdGlvbnMgdG8gdGhlIGFsbG9jYXRpb24gc2l6ZSBib3VuZGFyeSwg
c28gdGhhdCB0aGUNCj4gPiA+ID4gPj4gKyAqIGFsbG9jYXRlZCBtZW1vcnkgYXBwZWFycyB0byBI
eXBlci1WIGFzIGEgcGFnZSBvZiB0aGUgc2l6ZQ0KPiA+ID4gPiA+PiArICogaXQgZXhwZWN0cy4N
Cj4gPiA+ID4gPj4gKyAqDQo+ID4gPiA+ID4+ICsgKiBUaGVzZSBmdW5jdGlvbnMgYXJlIHVzZWQg
YnkgYXJtNjQgc3BlY2lmaWMgY29kZSBhcyB3ZWxsIGFzDQo+ID4gPiA+ID4+ICsgKiBhcmNoIGlu
ZGVwZW5kZW50IEh5cGVyLVYgZHJpdmVycy4NCj4gPiA+ID4gPj4gKyAqLw0KPiA+ID4gPiA+PiAr
DQo+ID4gPiA+ID4+ICt2b2lkICpodl9hbGxvY19oeXBlcnZfcGFnZSh2b2lkKQ0KPiA+ID4gPiA+
PiArew0KPiA+ID4gPiA+PiArICAgICAgIEJVSUxEX0JVR19PTihQQUdFX1NJWkUgPCAgSFZfSFlQ
X1BBR0VfU0laRSk7DQo+ID4gPiA+ID4+ICsgICAgICAgcmV0dXJuIGttYWxsb2MoSFZfSFlQX1BB
R0VfU0laRSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiA+ID4+ICt9DQo+ID4gPiA+ID4+ICtFWFBPUlRf
U1lNQk9MX0dQTChodl9hbGxvY19oeXBlcnZfcGFnZSk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJ
IGRvbid0IHRoaW5rIHRoZXJlIGlzIGFueSBndWFyYW50ZWUgdGhhdCBrbWFsbG9jKCkgcmV0dXJu
cw0KPiA+ID4gPiA+IHBhZ2UtYWxpZ25lZA0KPiA+ID4gPiA+IGFsbG9jYXRpb25zIGluIGdlbmVy
YWwuDQo+ID4gPiA+DQo+ID4gPiA+IEkgYmVsaWV2ZSB0aGF0IGd1YXJhbnRlZSBjYW1lIHdpdGgg
NTliYjQ3OTg1YzFkYiAoIm1tLCBzbFthb3VdYjoNCj4gPiA+ID4gZ3VhcmFudGVlDQo+ID4gPiA+
IG5hdHVyYWwgYWxpZ25tZW50IGZvciBrbWFsbG9jKHBvd2VyLW9mLXR3bykiKS4NCj4gPiA+ID4N
Cj4gPiA+ID4gPiBIb3cgYWJvdXQgdXNpbmcgZ2V0X2ZyZWVfcGFnZXMoKSB0byBpbXBsZW1lbnQg
dGhpcz8NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyB3b3VsZCBjZXJ0YWlubHkgd29yaywgYXQgdGhl
IGV4cGVuc2Ugb2YgYSBsb3Qgb2Ygd2FzdGVkIG1lbW9yeSB3aGVuDQo+ID4gPiA+IFBBR0VfU0la
RSBpc24ndCA0ay4NCj4gPiA+DQo+ID4gPiBJJ20gc3VyZSB0aGlzIGlzIHRoZSBsZWFzdCBvZiB5
b3VyIHByb2JsZW1zIHdoZW4gdGhlIGd1ZXN0IHJ1bnMgd2l0aA0KPiA+ID4gYSBsYXJnZSBiYXNl
IHBhZ2Ugc2l6ZSwgeW91J3ZlIGFscmVhZHkgd2FzdGVkIG1vc3Qgb2YgeW91ciBtZW1vcnkNCj4g
PiA+IG90aGVyd2lzZSB0aGVuLg0KPiA+ID4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlcmUncyB2YWx1
ZSBpbiBrZWVwaW5nIHRoZXNlIGZ1bmN0aW9ucy4gIFRoZXJlIGFyZSA4IHVzZXMgaW4NCj4gPiBh
cmNoaXRlY3R1cmUgaW5kZXBlbmRlbnQgY29kZSBhdCB0aGUgbW9tZW50LCB3aGljaCBhZG1pdHRl
ZGx5IHNhdmVzDQo+ID4gb25seSB+MS8yIE1ieXRlIG9mIG1lbW9yeSB3aXRoIGEgNjRLIHBhZ2Ug
c2l6ZSwgYnV0IHdlIHdpbGwgaGF2ZQ0KPiA+IGFkZGl0aW9uYWwgdXNlcyB3aXRoIG1vcmUgbWVt
b3J5IHNhdmluZ3MgYXMgd2UgZ2V0IGFsbCBvZiB0aGUNCj4gPiBIeXBlci1WIHN5bnRoZXRpYyBk
cml2ZXJzIHRvIHdvcmsgd2l0aCA2NEsgcGFnZSBzaXplLiAgRnVydGhlcm1vcmUsDQo+ID4gdGhl
cmUncyBjb21pbmcgd29yayB0aGF0IHdpbGwgcmVxdWlyZSBhZGRpdGlvbmFsIHN0ZXBzIHRvIHNo
YXJlIGEgcGFnZQ0KPiA+IGJldHdlZW4gYSBndWVzdCBhbmQgdGhlIEh5cGVyLVYgaG9zdC4gIFRo
ZXNlIGZ1bmN0aW9ucyBhcmUgdGhlIHJpZ2h0DQo+ID4gcGxhY2UgdG8gcHV0IHRoZSBjb2RlIGZv
ciB0aGUgYWRkaXRpb25hbCBzaGFyaW5nIHN0ZXBzLiAgUmVtb3ZpbmcgdGhlbQ0KPiA+IG5vdyBp
biBmYXZvciBvZiBhIGJhcmUga21hbGxvYygpIGFuZCB0aGVuIGFkZGluZyB0aGVtIGJhY2sgZG9l
c24ndA0KPiA+IHNlZW0gd29ydGh3aGlsZS4NCj4gDQo+IE15IHBvaW50IHdhcyB0byBrZWVwIHRo
ZSBmdW5jdGlvbnMgYnV0IHVzZSBhbGxvY19wYWdlcygpIGludGVybmFsbHksDQo+IHNvIHlvdSBj
YW4gZGVhbCB3aXRoIHRoZSBoeXBlcnZpc29yIGhhdmluZyBhIGxhcmdlciBwYWdlIHNpemUgdGhh
bg0KPiB0aGUgZ3Vlc3QsIHdoaWNoIHNlZW1zIHRvIGJlIGEgbW9yZSBpbXBvcnRhbnQgc2NlbmFy
aW8gaWYgSSBjb3JyZWN0bHkNCj4gdW5kZXJzdGFuZCB0aGUgZGlmZmVyZW5jZXMgYmV0d2VlbiB0
aGUgd2F5IFdpbmRvd3MgYW5kIExpbnV4DQo+IGRlYWwgd2l0aCBwYWdlIGNhY2hlLg0KDQpPSywg
SSBzZWUgbm93IHdoYXQgeW91IGFyZSBnZXR0aW5nIGF0LiAgSSBzaG91bGQgc3BlbGwgb3V0IG15
DQphc3N1bXB0aW9uLCB3aGljaCBpcyB0aGUgb3Bwb3NpdGUuICBIeXBlci1WIHdvbid0IGhhdmUg
YSBwYWdlDQpzaXplIG90aGVyIHRoYW4gNEsgYW55dGltZSBpbiB0aGUgZm9yZXNlZWFibGUgZnV0
dXJlLiAgVGhlDQpjb2RlIGlzIHRvbyB3ZWRkZWQgdG8gdGhlIHg4NiA0SyBwYWdlIHNpemUsIGFu
ZCB0aGUgaG9zdC1ndWVzdA0KaW50ZXJmYWNlcyBoYXZlIGEgbG90IG9mIGltcGxpY2l0IGFzc3Vt
cHRpb25zIHRoYXQgdGhlIHBhZ2Ugc2l6ZSBpcw0KNEsgKHVuZm9ydHVuYXRlbHkpLiAgQnV0IHRo
ZSBsYXN0IHRpbWUgSSBsb29rZWQsIFJIRUwgZm9yIEFSTTY0IGlzDQpkZWxpdmVyZWQgd2l0aCBh
IDY0SyBwYWdlIHNpemUuICBTbyBteSBhc3N1bXB0aW9uIGlzIHRoYXQgdGhlIG9ubHkNCmNvbWJp
bmF0aW9uIHRoYXQgcmVhbGx5IG1hdHRlcnMgaXMgdGhlIGd1ZXN0IHBhZ2Ugc2l6ZSBiZWluZyBs
YXJnZXINCnRoYW4gdGhlIEh5cGVyLVYgcGFnZSBzaXplLiAgVGhlIG90aGVyIHdheSBhcm91bmQg
anVzdCB3b24ndA0KaGFwcGVuIHdpdGhvdXQgYSBtYWpvciBvdmVyaGF1bCB0byBIeXBlci1WLCBp
bmNsdWRpbmcgYSByZXdvcmsNCm9mIHRoZSBndWVzdC1ob3N0IGludGVyZmFjZS4NCg0KTWljaGFl
bA0KDQo+IA0KPiBBcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCB1c2luZyA2NGtiIHBhZ2VzIG9uIFdp
bmRvd3MgaXMgZ2VuZXJhbGx5DQo+IGEgd2luIGFzIHRoZSBWRlMgY29kZSBhbHJlYWR5IGRlYWxz
IHdpdGggdW5pdHMgb2YgdGhhdCBzaXplLCB3aGlsZQ0KPiBvbiBMaW51eCB0aGUgNGtiIHBhZ2Ug
c2l6ZSBpcyB0b28gZGVlcGx5IGVudHJlbmNoZWQgd2l0aGluIHRoZQ0KPiBmaWxlIHN5c3RlbSBj
b2RlIHRvIG1lc3Mgd2l0aCBpdDogV2hhdGV2ZXIgeW91IGdhaW4gaW4gdGVybXMgb2YNCj4gVExC
IHByZXNzdXJlIG9uIHdvcmtsb2FkcyB0aGF0IGNhbm5vdCB1c2UgaHVnZSBwYWdlcyBpcyBhbGwg
bG9zdA0KPiBhZ2FpbiB0aHJvdWdoIGV4dHJhIEkvTyBhbmQgd2FzdGVkIHBoeXNpY2FsIG1lbW9y
eS4NCj4gDQo+ICAgICAgICAgQXJuZA0K
