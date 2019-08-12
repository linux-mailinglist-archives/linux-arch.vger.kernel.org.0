Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E498A702
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 21:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfHLTWa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 15:22:30 -0400
Received: from mail-eopbgr720105.outbound.protection.outlook.com ([40.107.72.105]:44208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbfHLTWa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 15:22:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcuKcVlzzHCeGFnMcsTt/Mp8CBxbViGWQYyMjqF7l1PS8Z/6d5PuoIrDhCy03e9OzglPIiz0qejEIQLOXayX9JJVUjU//jYbAQ+1vA2HxCYQyJGqWsQ+JjSNFEhBwEu+jiKcLvLAAD0gdDcgtn3rXSeCu173tjqQC/3Hle4ssa44pPbi46bQCy9KL+1eCEvWJyS5/TFtvYNAivk2U4L7S2y1HPg1/e35Rhcq1GtKovHnbEk4IZ17gunpGteH9oRI+nVfjPrq8CNrDbVqLoPtsscXrVOm82mSjQLMTh+AzAFdyBH1o/qDNXEnJe8EnkZZacYmXnWqhEopAnkLShxcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPqqxAczbvigbesof2J6ywxU/c4tMKPhOjS0EphTUyY=;
 b=Zcq1QWC57nDQ93g5h9K36tRwbIf+0G/kqGi7I67ChCRFQ3QfBud/THe1ZXecilVa3OqSXZYeLFdgehuEcSwQg/pScO0gKOmzUnPUlpVO3kDF0iyPg6fuXPec+px8jx/QQZrehuMZTlM1syMmQihPHdk+k1uMOeY4jFZrr/ZjIXsdLZSyCWOps9JM/n4eZ0nH8f5YquAsxnWM5TbhbpuniNKo969Ej9ul9cFYqqddMLY6hfNFtYfhyzh4remgi5oMIoQYOFC3knBvzKKUfWBV7QgD+601eUWlOaGGrjiceQhj6mSBe5JwrVRmv6Asvro2xaVtgEZWYSwHo+sl8d2AYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPqqxAczbvigbesof2J6ywxU/c4tMKPhOjS0EphTUyY=;
 b=ciLKkuwqeyF9lJ2z11WOpvAy4vZviwPk5qc6RhOCrZF95PDwp3TRaeTp/UQD8ochSwzuw2ajV+rjo5qZnLZhkYGItUuFr+bUnngnrNZzSzlGRyVnAa4nZgrztkHVMFxAFxzIov89EBS49N85LVGye2o5FQWMp5nmhqcI7RXuWL8=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0827.namprd21.prod.outlook.com (10.173.172.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.6; Mon, 12 Aug 2019 19:22:25 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd%2]) with mapi id 15.20.2157.011; Mon, 12 Aug 2019
 19:22:25 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Tianyu Lan <lantianyu1986@gmail.com>,
        vkuznets <vkuznets@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "ashal@kernel.org" <ashal@kernel.org>
Subject: RE: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock
 function
Thread-Topic: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched
 clock function
Thread-Index: AQHVReKkvw+SyuWVWkKMpdqQhJI1B6bhbZoAgAACzICAABHVAIABqu0AgBTHyWA=
Date:   Mon, 12 Aug 2019 19:22:25 +0000
Message-ID: <DM5PR21MB0137E03AAD8C2EA61EC81ED7D7D30@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <87zhkxksxd.fsf@vitty.brq.redhat.com>
 <20190729110927.GC31398@hirez.programming.kicks-ass.net>
 <87wog1kpib.fsf@vitty.brq.redhat.com>
 <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com>
In-Reply-To: <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-12T19:22:21.7916910Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ced8f482-a73e-45f8-92e4-2074234ad65c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa223bf6-0442-4b90-d361-08d71f5a6849
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0827;
x-ms-traffictypediagnostic: DM5PR21MB0827:|DM5PR21MB0827:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB0827A77A38A70CF32A0B5385D7D30@DM5PR21MB0827.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(10090500001)(71190400001)(86362001)(25786009)(66476007)(53546011)(6506007)(64756008)(76176011)(71200400001)(76116006)(7696005)(229853002)(66556008)(66446008)(305945005)(8676002)(476003)(6246003)(14454004)(66946007)(81156014)(8990500004)(446003)(5660300002)(486006)(54906003)(4326008)(7736002)(11346002)(52536014)(74316002)(99286004)(81166006)(33656002)(14444005)(7416002)(53936002)(186003)(10290500003)(256004)(478600001)(110136005)(22452003)(55016002)(6436002)(316002)(26005)(3846002)(102836004)(6116002)(2906002)(66066001)(9686003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0827;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Wocw55KhuB5MXoIwlyGnps4JyV/xbK7jYsRguesbrpXe7mH8XTGwu3Ur5mo9QDSF6rrxSZkBlr1hCqyopBXmFECm5jDk4dskJJXWfZuur64tn5VW3YOHBAuKasMFnKWLSxBezqpT+xBykmQY7gmhFWMKjqB8hqVCMZ0xHMbxjEWEopGk2FMyXQ7mEe1pJouIPWGpEM3Uoza+6uhOSgBkvrA98gnmbXEdzjWY27dyBzffVGCmInoNOuH6nypHnybvnPyXeoe3IrNWNYzSq/JblH5fhLnp2QdBMOoKKM1sKChnz4NnFXIkLhIpVk8lgSum1RdriSeFIlyh/mQTqvEHJrbKcSylzkfcuIvZIUmxouIhqkpXDY8TLmlBehxSkaPWvzwHkU5WBIRCrjc9eHcJ/VNRJr28ig1Mio8lqSDJHE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa223bf6-0442-4b90-d361-08d71f5a6849
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 19:22:25.1891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z20t5uHMCk4AaDIMaAARssNgmRDFcEDvI5rjyNCWT2WCtNH9Ds2Z6qflZNciaa1mEZrGW3xSCHjSXKL/R2T8KnaXBgZoK96vOcMEBUtODBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0827
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogVGlhbnl1IExhbiA8bGFudGlhbnl1MTk4NkBnbWFpbC5jb20+IFNlbnQ6IFR1ZXNkYXks
IEp1bHkgMzAsIDIwMTkgNjo0MSBBTQ0KPiANCj4gT24gTW9uLCBKdWwgMjksIDIwMTkgYXQgODox
MyBQTSBWaXRhbHkgS3V6bmV0c292IDx2a3V6bmV0c0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0K
PiA+IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JpdGVzOg0KPiA+DQo+
ID4gPiBPbiBNb24sIEp1bCAyOSwgMjAxOSBhdCAxMjo1OToyNlBNICswMjAwLCBWaXRhbHkgS3V6
bmV0c292IHdyb3RlOg0KPiA+ID4+IGxhbnRpYW55dTE5ODZAZ21haWwuY29tIHdyaXRlczoNCj4g
PiA+Pg0KPiA+ID4+ID4gRnJvbTogVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBtaWNyb3NvZnQuY29t
Pg0KPiA+ID4+ID4NCj4gPiA+PiA+IEh5cGVyLVYgZ3Vlc3RzIHVzZSB0aGUgZGVmYXVsdCBuYXRp
dmVfc2NoZWRfY2xvY2soKSBpbiBwdl9vcHMudGltZS5zY2hlZF9jbG9jaw0KPiA+ID4+ID4gb24g
eDg2LiAgQnV0IG5hdGl2ZV9zY2hlZF9jbG9jaygpIGRpcmVjdGx5IHVzZXMgdGhlIHJhdyBUU0Mg
dmFsdWUsIHdoaWNoDQo+ID4gPj4gPiBjYW4gYmUgZGlzY29udGludW91cyBpbiBhIEh5cGVyLVYg
Vk0uICAgQWRkIHRoZSBnZW5lcmljIGh2X3NldHVwX3NjaGVkX2Nsb2NrKCkNCj4gPiA+PiA+IHRv
IHNldCB0aGUgc2NoZWQgY2xvY2sgZnVuY3Rpb24gYXBwcm9wcmlhdGVseS4gIE9uIHg4NiwgdGhp
cyBzZXRzDQo+ID4gPj4gPiBwdl9vcHMudGltZS5zY2hlZF9jbG9jayB0byByZWFkIHRoZSBIeXBl
ci1WIHJlZmVyZW5jZSBUU0MgdmFsdWUgdGhhdCBpcw0KPiA+ID4+ID4gc2NhbGVkIGFuZCBhZGp1
c3RlZCB0byBiZSBjb250aW51b3VzLg0KPiA+ID4+DQo+ID4gPj4gSHlwZXJ2aXNvciBjYW4sIGlu
IHRoZW9yeSwgZGlzYWJsZSBUU0MgcGFnZSBhbmQgdGhlbiB3ZSdyZSBmb3JjZWQgdG8gdXNlDQo+
ID4gPj4gTVNSLWJhc2VkIGNsb2Nrc291cmNlIGJ1dCB1c2luZyBpdCBhcyBzY2hlZF9jbG9jaygp
IGNhbiBiZSB2ZXJ5IHNsb3csDQo+ID4gPj4gSSdtIGFmcmFpZC4NCj4gPiA+Pg0KPiA+ID4+IE9u
IHRoZSBvdGhlciBoYW5kLCB3aGF0IHdlIGhhdmUgbm93IGlzIHByb2JhYmx5IHdvcnNlOiBUU0Mg
Y2FuLA0KPiA+ID4+IGFjdHVhbGx5LCBqdW1wIGJhY2t3YXJkcyAoZS5nLiBvbiBtaWdyYXRpb24p
IGFuZCB3ZSdyZSBicmVha2luZyB0aGUNCj4gPiA+PiByZXF1aXJlbWVudHMgZm9yIHNjaGVkX2Ns
b2NrKCkuDQo+ID4gPg0KPiA+ID4gVGhhdCAob2J2aW91c2x5KSBhbHNvIGJyZWFrcyB0aGUgcmVx
dWlyZW1lbnRzIGZvciB1c2luZyBUU0MgYXMNCj4gPiA+IGNsb2Nrc291cmNlLg0KPiA+ID4NCj4g
PiA+IElPVywgaXQgYnJlYWtzIHRoZSBlbnRpcmUgcHVycG9zZSBvZiBoYXZpbmcgVFNDIGluIHRo
ZSBmaXJzdCBwbGFjZS4NCj4gPg0KPiA+IEN1cnJlbnRseSwgd2UgbWFyayByYXcgVFNDIGFzIHVu
c3RhYmxlIHdoZW4gcnVubmluZyBvbiBIeXBlci1WIChzZWUNCj4gPiA4OGM5MjgxYTlmYmE2KSwg
J1RTQyBwYWdlJyAod2hpY2ggaXMgVFNDICogc2NhbGUgKyBvZmZzZXQpIGlzIGJlaW5nIHVzZWQN
Cj4gPiBpbnN0ZWFkLiBUaGUgcHJvYmxlbSBpcyB0aGF0ICdUU0MgcGFnZScgY2FuIGJlIGRpc2Fi
bGVkIGJ5IHRoZQ0KPiA+IGh5cGVydmlzb3IgYW5kIGluIHRoYXQgY2FzZSB0aGUgb25seSByZW1h
aW5pbmcgY2xvY2tzb3VyY2UgaXMgTVNSLWJhc2VkDQo+ID4gKHNsb3cpLg0KPiA+DQo+IA0KPiBZ
ZXMsIHRoYXQgd2lsbCBiZSBzbG93IGlmIEh5cGVyLVYgZG9lc24ndCBleHBvc2UgaHYgdHNjIHBh
Z2UgYW5kDQo+IGtlcm5lbCB1c2VzIE1TUiBiYXNlZA0KPiBjbG9ja3NvdXJjZS4gRWFjaCBNU1Ig
cmVhZCB3aWxsIHRyaWdnZXIgb25lIFZNLUVYSVQuIFRoaXMgYWxzbyBoYXBwZW5zIG9uIG90aGVy
DQo+IGh5cGVydmlzb3JzIChlLGcsIEtWTSBkb2Vzbid0IGV4cG9zZSBLVk0gY2xvY2spLiBIeXBl
cnZpc29yIHNob3VsZA0KPiB0YWtlIHRoaXMgaW50bw0KPiBhY2NvdW50IGFuZCBkZXRlcm1pbmUg
d2hpY2ggY2xvY2tzb3VyY2Ugc2hvdWxkIGJlIGV4cG9zZWQgb3Igbm90Lg0KPiANCg0KV2UndmUg
Y29uZmlybWVkIHdpdGggdGhlIEh5cGVyLVYgdGVhbSB0aGF0IHRoZSBUU0MgcGFnZSBpcyBhbHdh
eXMgYXZhaWxhYmxlDQpvbiBIeXBlci1WIDIwMTYgYW5kIGxhdGVyLCBhbmQgb24gSHlwZXItViAy
MDEyIFIyIHdoZW4gdGhlIHBoeXNpY2FsDQpoYXJkd2FyZSBwcmVzZW50cyBhbiBJbnZhcmlhbnRU
U0MuICBCdXQgdGhlIExpbnV4IEtjb25maWcncyBhcmUgc2V0IHVwIHNvDQp0aGUgVFNDIHBhZ2Ug
aXMgbm90IHVzZWQgZm9yIDMyLWJpdCBndWVzdHMgLS0gYWxsIGNsb2NrIHJlYWRzIGFyZSBzeW50
aGV0aWMgTVNSDQpyZWFkcy4gIEZvciAzMi1iaXQsIHRoaXMgc2V0IG9mIGNoYW5nZXMgd2lsbCBh
ZGQgbW9yZSBvdmVyaGVhZCBiZWNhdXNlIHRoZQ0Kc2NoZWQgY2xvY2sgcmVhZHMgd2lsbCBub3cg
YmUgTVNSIHJlYWRzLg0KDQpJIHdvdWxkIGJlIGluY2xpbmVkIHRvIGZpeCB0aGUgcHJvYmxlbSwg
ZXZlbiB3aXRoIHRoZSBwZXJmIGhpdCBvbiAzMi1iaXQgTGludXguDQpJIGRvbuKAmXQgaGF2ZSBh
bnkgZGF0YSBvbiAzMi1iaXQgTGludXggYmVpbmcgdXNlZCBpbiBhIEh5cGVyLVYgZ3Vlc3QsIGJ1
dCBpdCdzIG5vdA0Kc3VwcG9ydGVkIGluIEF6dXJlIHNvIHVzYWdlIGlzIHByZXR0eSBzbWFsbC4g
IFRoZSBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0byBjb250aW51ZQ0KdG8gdXNlIHRoZSByYXcgVFND
IHZhbHVlIG9uIDMyLWJpdCwgZXZlbiB3aXRoIHRoZSByaXNrIG9mIGEgZGlzY29udGludWl0eSBp
biBjYXNlIG9mDQpsaXZlIG1pZ3JhdGlvbiBvciBzaW1pbGFyIHNjZW5hcmlvcy4NCg0KTWljaGFl
bA0K
