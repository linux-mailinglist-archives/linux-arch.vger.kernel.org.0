Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037659627F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfHTOcs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 10:32:48 -0400
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:21728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729912AbfHTOcs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:32:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te1oeEiyQbv1jeRUKSlcsE50RiZAPeqvrBVqN3JP9YMJL0VS/9V5hLc4+OfDRH7GO3N8t92b8TF5xhhrFFRkpB2LxZCEUL4kht0dS8qutwGBo+WDo7jgPCMAo3QdlGURcGl4NSHOuvQFz4DgwuoqTIPagS0i9g2B135Sm0g6TQSjKJI03js3PQUoI1cqyLNX46Aj13NKWcxwOTN7bRVoKkM5BCWwIRMifLM1lIXC/STEJm1c8Ww8uigvw2Ko9QPr/gVYmfBiv4lWg/e3lP4ufLE9z31HeK936zdgf4oooqvMO4+UnxFQD5AJmTmsEFABDh2jSqYvzpj2dWAWriDvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAre4v4vHMOfG2FYGl9Vh4x5mXV3OL8xcAUROKmrvzg=;
 b=OSJ11NpHdOuv53EJFaLlWBs5/8vCptTNDe11AVLsImkk1WeU3wqpjH8CMjWEXiMS2SS+bd+bjRXxJsemWYHcVvGyRzXeOxjeO6w+tKR6goONlctqh+X53fPGs2grBiVbMKNIfjZM/yW0/2h9QrbePZn3XsHVedI+qHgOwP1Qrb2zw9YwbHe8pR0zW3cGl56yRam0FMX5uyFKJgH4c8UWf2rClAIPgl7zukniCFZL20loH8BWTtjApmBiolVlhzSvtJcKgLiZBX8oWefO59BkuWcfu7MUxNvPoV9Bt7kU7jysLqnCp4jUHFth4ktBRKwHQErjDa0L1WLHyhadFLoTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAre4v4vHMOfG2FYGl9Vh4x5mXV3OL8xcAUROKmrvzg=;
 b=BPLjogWPK8O/A2hElHpE7qEE/smG92PIDewpJUBHz8Dk67a5lgfjaTig7Z2wXCs+kmoxBEGg0VoarJQ9JDnQO8M6KIzG9sZ5nvA7z8fBON/KJWPnuQXU1VKNrZGeqZqrSCnOOja7htoMXvSO8XYJmLjAmuQ9nk7xe6lB9Sua7yY=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0826.namprd21.prod.outlook.com (10.173.172.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.15; Tue, 20 Aug 2019 14:32:35 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Tue, 20 Aug 2019
 14:32:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        Tianyu Lan <lantianyu1986@gmail.com>
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
Thread-Index: AQHVReKkvw+SyuWVWkKMpdqQhJI1B6bhbZoAgAACzICAABHVAIABqu0AgBTHyWCAAOLjgIALYT1w
Date:   Tue, 20 Aug 2019 14:32:35 +0000
Message-ID: <DM5PR21MB013730EB79A17AF02C170BD7D7AB0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <87zhkxksxd.fsf@vitty.brq.redhat.com>
 <20190729110927.GC31398@hirez.programming.kicks-ass.net>
 <87wog1kpib.fsf@vitty.brq.redhat.com>
 <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com>
 <DM5PR21MB0137E03AAD8C2EA61EC81ED7D7D30@DM5PR21MB0137.namprd21.prod.outlook.com>
 <87sgq5a2hq.fsf@vitty.brq.redhat.com>
In-Reply-To: <87sgq5a2hq.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-20T14:32:34.2156117Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de872eae-51bf-4937-abb2-3d70811a579d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9bc4330-75d6-48d8-4212-08d7257b3eac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0826;
x-ms-traffictypediagnostic: DM5PR21MB0826:|DM5PR21MB0826:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB082693A76A18BA410CC333E6D7AB0@DM5PR21MB0826.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(8936002)(22452003)(71190400001)(102836004)(14444005)(53936002)(66476007)(66446008)(66556008)(52536014)(53546011)(64756008)(76116006)(6116002)(5660300002)(8990500004)(66946007)(478600001)(33656002)(9686003)(55016002)(8676002)(10290500003)(6436002)(81156014)(81166006)(229853002)(7696005)(76176011)(7416002)(71200400001)(2906002)(316002)(6246003)(25786009)(256004)(476003)(3846002)(11346002)(54906003)(66066001)(110136005)(99286004)(26005)(6506007)(74316002)(7736002)(186003)(446003)(486006)(305945005)(14454004)(86362001)(10090500001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0826;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jeTobZ/DOOnT1rD+2+YAlhebiKsfI2Ir9p1Xk7X70HtNedD7V0JPPTcBFSbe47oM86gkHEqFJM0UMKOK1VbvVzY1Hem+xnkEKxFOem9gtve4GV7jwQ1APmulpGY+LXPwERCMg6aX27wcKqtu1qJI6VTK0FBNgwtAKE7rnLeqCUzqihU6cXouIZJPzifuJVGoXN/VfDjFvdfN/pc3+woVtucycfHDy5loOrYFPZP7ejgLhKt0XJHmMww5b6katZ4E+CXj+ywlUf9p8M5uH/7T045eXxCOt9WCMyeNyd2OFVMYBIBAuHhLeI5jDkNaEvIcJcsj0IidfYHxN+0FbJs33j8iNSdh3YL5cDZQcDGH6Aelnjbk6zexBGRK7ISQWlR6ITpTbZtxx/fPN+lESPnv4emYOegFpyqnYyw8HgJAvlk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bc4330-75d6-48d8-4212-08d7257b3eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 14:32:35.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWEiW0EjU1EZcZ/OCd4wl56WLtzA9FbYgy1QIy9mJoMNzfYX4FcDai3f2EbZhxJrrprVVwxUqFtgEx6XCkwN4mX4YL+i7r/LFuGzZxRbkok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0826
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogVml0YWx5IEt1em5ldHNvdiA8dmt1em5ldHNAcmVkaGF0LmNvbT4gU2VudDogVHVlc2Rh
eSwgQXVndXN0IDEzLCAyMDE5IDE6MzQgQU0NCj4gDQo+IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxl
eUBtaWNyb3NvZnQuY29tPiB3cml0ZXM6DQo+IA0KPiA+IEZyb206IFRpYW55dSBMYW4gPGxhbnRp
YW55dTE5ODZAZ21haWwuY29tPiBTZW50OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDE5IDY6NDEgQU0N
Cj4gPj4NCj4gPj4gT24gTW9uLCBKdWwgMjksIDIwMTkgYXQgODoxMyBQTSBWaXRhbHkgS3V6bmV0
c292IDx2a3V6bmV0c0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPj4gPg0KPiA+PiA+IFBldGVyIFpp
amxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JpdGVzOg0KPiA+PiA+DQo+ID4+ID4gPiBP
biBNb24sIEp1bCAyOSwgMjAxOSBhdCAxMjo1OToyNlBNICswMjAwLCBWaXRhbHkgS3V6bmV0c292
IHdyb3RlOg0KPiA+PiA+ID4+IGxhbnRpYW55dTE5ODZAZ21haWwuY29tIHdyaXRlczoNCj4gPj4g
PiA+Pg0KPiA+PiA+ID4+ID4gRnJvbTogVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBtaWNyb3NvZnQu
Y29tPg0KPiA+PiA+ID4+ID4NCj4gPj4gPiA+PiA+IEh5cGVyLVYgZ3Vlc3RzIHVzZSB0aGUgZGVm
YXVsdCBuYXRpdmVfc2NoZWRfY2xvY2soKSBpbiBwdl9vcHMudGltZS5zY2hlZF9jbG9jaw0KPiA+
PiA+ID4+ID4gb24geDg2LiAgQnV0IG5hdGl2ZV9zY2hlZF9jbG9jaygpIGRpcmVjdGx5IHVzZXMg
dGhlIHJhdyBUU0MgdmFsdWUsIHdoaWNoDQo+ID4+ID4gPj4gPiBjYW4gYmUgZGlzY29udGludW91
cyBpbiBhIEh5cGVyLVYgVk0uICAgQWRkIHRoZSBnZW5lcmljIGh2X3NldHVwX3NjaGVkX2Nsb2Nr
KCkNCj4gPj4gPiA+PiA+IHRvIHNldCB0aGUgc2NoZWQgY2xvY2sgZnVuY3Rpb24gYXBwcm9wcmlh
dGVseS4gIE9uIHg4NiwgdGhpcyBzZXRzDQo+ID4+ID4gPj4gPiBwdl9vcHMudGltZS5zY2hlZF9j
bG9jayB0byByZWFkIHRoZSBIeXBlci1WIHJlZmVyZW5jZSBUU0MgdmFsdWUgdGhhdCBpcw0KPiA+
PiA+ID4+ID4gc2NhbGVkIGFuZCBhZGp1c3RlZCB0byBiZSBjb250aW51b3VzLg0KPiA+PiA+ID4+
DQo+ID4+ID4gPj4gSHlwZXJ2aXNvciBjYW4sIGluIHRoZW9yeSwgZGlzYWJsZSBUU0MgcGFnZSBh
bmQgdGhlbiB3ZSdyZSBmb3JjZWQgdG8gdXNlDQo+ID4+ID4gPj4gTVNSLWJhc2VkIGNsb2Nrc291
cmNlIGJ1dCB1c2luZyBpdCBhcyBzY2hlZF9jbG9jaygpIGNhbiBiZSB2ZXJ5IHNsb3csDQo+ID4+
ID4gPj4gSSdtIGFmcmFpZC4NCj4gPj4gPiA+Pg0KPiA+PiA+ID4+IE9uIHRoZSBvdGhlciBoYW5k
LCB3aGF0IHdlIGhhdmUgbm93IGlzIHByb2JhYmx5IHdvcnNlOiBUU0MgY2FuLA0KPiA+PiA+ID4+
IGFjdHVhbGx5LCBqdW1wIGJhY2t3YXJkcyAoZS5nLiBvbiBtaWdyYXRpb24pIGFuZCB3ZSdyZSBi
cmVha2luZyB0aGUNCj4gPj4gPiA+PiByZXF1aXJlbWVudHMgZm9yIHNjaGVkX2Nsb2NrKCkuDQo+
ID4+ID4gPg0KPiA+PiA+ID4gVGhhdCAob2J2aW91c2x5KSBhbHNvIGJyZWFrcyB0aGUgcmVxdWly
ZW1lbnRzIGZvciB1c2luZyBUU0MgYXMNCj4gPj4gPiA+IGNsb2Nrc291cmNlLg0KPiA+PiA+ID4N
Cj4gPj4gPiA+IElPVywgaXQgYnJlYWtzIHRoZSBlbnRpcmUgcHVycG9zZSBvZiBoYXZpbmcgVFND
IGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gPj4gPg0KPiA+PiA+IEN1cnJlbnRseSwgd2UgbWFyayBy
YXcgVFNDIGFzIHVuc3RhYmxlIHdoZW4gcnVubmluZyBvbiBIeXBlci1WIChzZWUNCj4gPj4gPiA4
OGM5MjgxYTlmYmE2KSwgJ1RTQyBwYWdlJyAod2hpY2ggaXMgVFNDICogc2NhbGUgKyBvZmZzZXQp
IGlzIGJlaW5nIHVzZWQNCj4gPj4gPiBpbnN0ZWFkLiBUaGUgcHJvYmxlbSBpcyB0aGF0ICdUU0Mg
cGFnZScgY2FuIGJlIGRpc2FibGVkIGJ5IHRoZQ0KPiA+PiA+IGh5cGVydmlzb3IgYW5kIGluIHRo
YXQgY2FzZSB0aGUgb25seSByZW1haW5pbmcgY2xvY2tzb3VyY2UgaXMgTVNSLWJhc2VkDQo+ID4+
ID4gKHNsb3cpLg0KPiA+PiA+DQo+ID4+DQo+ID4+IFllcywgdGhhdCB3aWxsIGJlIHNsb3cgaWYg
SHlwZXItViBkb2Vzbid0IGV4cG9zZSBodiB0c2MgcGFnZSBhbmQNCj4gPj4ga2VybmVsIHVzZXMg
TVNSIGJhc2VkDQo+ID4+IGNsb2Nrc291cmNlLiBFYWNoIE1TUiByZWFkIHdpbGwgdHJpZ2dlciBv
bmUgVk0tRVhJVC4gVGhpcyBhbHNvIGhhcHBlbnMgb24gb3RoZXINCj4gPj4gaHlwZXJ2aXNvcnMg
KGUsZywgS1ZNIGRvZXNuJ3QgZXhwb3NlIEtWTSBjbG9jaykuIEh5cGVydmlzb3Igc2hvdWxkDQo+
ID4+IHRha2UgdGhpcyBpbnRvDQo+ID4+IGFjY291bnQgYW5kIGRldGVybWluZSB3aGljaCBjbG9j
a3NvdXJjZSBzaG91bGQgYmUgZXhwb3NlZCBvciBub3QuDQo+ID4+DQo+ID4NCj4gPiBXZSd2ZSBj
b25maXJtZWQgd2l0aCB0aGUgSHlwZXItViB0ZWFtIHRoYXQgdGhlIFRTQyBwYWdlIGlzIGFsd2F5
cyBhdmFpbGFibGUNCj4gPiBvbiBIeXBlci1WIDIwMTYgYW5kIGxhdGVyLCBhbmQgb24gSHlwZXIt
ViAyMDEyIFIyIHdoZW4gdGhlIHBoeXNpY2FsDQo+ID4gaGFyZHdhcmUgcHJlc2VudHMgYW4gSW52
YXJpYW50VFNDLg0KPiANCj4gQ3VycmVudGx5IHdlIGNoZWNrIHRoYXQgVFNDIHBhZ2UgaXMgdmFs
aWQgb24gZXZlcnkgcmVhZCBhbmQgaXQgc2VlbXMNCj4gdGhpcyBpcyByZWR1bmRhbnQsIHJpZ2h0
PyBJdCBpcyBlaXRoZXIgYXZhaWxhYmxlIG9uIGJvb3Qgb3Igbm90LiBJIGNhbg0KPiBvbmx5IGlt
YWdpbmUgbWlncmF0aW5nIGEgVk0gdG8gYSBub24tSW52YXJpYW50VFNDIGhvc3Qgd2hlbiBIeXBl
ci1WIHdpbGwNCj4gbGlrZWx5IGRpc2FibGUgdGhlIHBhZ2UgKGFuZCB3ZSBjYW4gZ2V0IHJlZW5s
aWdodGVubWVudCBub3RpZmljYXRpb24NCj4gdGhlbikuDQoNCkkgdGhpbmsgSHlwZXItViBjYW4g
aGF2ZSBicmllZiBpbnRlcnZhbHMgd2hlbiB0aGUgVFNDIHBhZ2UgaXMgbm90IHZhbGlkLCBzbw0K
dGhlIGNvZGUgY2hlY2tzIGZvciB0aGUgInNlcXVlbmNlIiB2YWx1ZSBiZWluZyB6ZXJvLiAgIE90
aGVyd2lzZSwgeWVzLCBpdA0Kc2hvdWxkIGFsd2F5cyBiZSB0aGVyZSBvciBub3QgYmUgdGhlcmUu
ICBJcyB0aGVyZSBzb21lIG90aGVyIHZhbGlkaXR5DQpjaGVjayBvbiBldmVyeSByZWFkIHRoYXQg
eW91IGFyZSB0aGlua2luZyBvZj8NCg0KPiANCj4gPiAgQnV0IHRoZSBMaW51eCBLY29uZmlnJ3Mg
YXJlIHNldCB1cCBzbw0KPiA+IHRoZSBUU0MgcGFnZSBpcyBub3QgdXNlZCBmb3IgMzItYml0IGd1
ZXN0cyAtLSBhbGwgY2xvY2sgcmVhZHMgYXJlIHN5bnRoZXRpYyBNU1INCj4gPiByZWFkcy4gIEZv
ciAzMi1iaXQsIHRoaXMgc2V0IG9mIGNoYW5nZXMgd2lsbCBhZGQgbW9yZSBvdmVyaGVhZCBiZWNh
dXNlIHRoZQ0KPiA+IHNjaGVkIGNsb2NrIHJlYWRzIHdpbGwgbm93IGJlIE1TUiByZWFkcy4NCj4g
Pg0KPiA+IEkgd291bGQgYmUgaW5jbGluZWQgdG8gZml4IHRoZSBwcm9ibGVtLCBldmVuIHdpdGgg
dGhlIHBlcmYgaGl0IG9uIDMyLWJpdCBMaW51eC4NCj4gPiBJIGRvbuKAmXQgaGF2ZSBhbnkgZGF0
YSBvbiAzMi1iaXQgTGludXggYmVpbmcgdXNlZCBpbiBhIEh5cGVyLVYgZ3Vlc3QsIGJ1dCBpdCdz
IG5vdA0KPiA+IHN1cHBvcnRlZCBpbiBBenVyZSBzbyB1c2FnZSBpcyBwcmV0dHkgc21hbGwuICBU
aGUgYWx0ZXJuYXRpdmUgd291bGQgYmUgdG8gY29udGludWUNCj4gPiB0byB1c2UgdGhlIHJhdyBU
U0MgdmFsdWUgb24gMzItYml0LCBldmVuIHdpdGggdGhlIHJpc2sgb2YgYSBkaXNjb250aW51aXR5
IGluIGNhc2Ugb2YNCj4gPiBsaXZlIG1pZ3JhdGlvbiBvciBzaW1pbGFyIHNjZW5hcmlvcy4NCj4g
DQo+IFRoZSBpc3N1ZSBuZWVkcyBmaXhpbmcsIEkgYWdyZWUsIGhvd2V2ZXIgdXNpbmcgTVNSIGJh
c2VkIGNsb2Nrc291cmNlIGFzDQo+IHNjaGVkIGNsb2NrIG1heSBnaXZlIHVzIHRvbyBiaWcgb2Yg
YSBwZXJmb3JtYW5jZSBoaXQgKG5vdCBzdXJlIHdobyBjYXJlcw0KPiBhYm91dCAzMiBiaXQgZ3Vl
c3QgcGVyZm9ybWFuY2Ugbm93YWRheXMgYnV0IHN0aWxsKS4gV2hhdCBzdG9wcyB1cyBmcm9tDQo+
IGVuYWJsaW5nIFRTQyBwYWdlIGZvciAzMiBiaXQgZ3Vlc3RzIGlmIGl0IGlzIGF2YWlsYWJsZT8N
Cg0KSSB0YWxrZWQgdG8gS1kgU3Jpbml2YXNhbiBmb3IgYW55IGhpc3RvcnkgYWJvdXQgVFNDIHBh
Z2Ugb24gMzItYml0LiAgSGUgc2FpZA0KdGhlcmUgd2FzIG5vIHRlY2huaWNhbCByZWFzb24gbm90
IHRvIGltcGxlbWVudCBpdCwgYnV0IG91ciBmb2N1cyB3YXMgYWx3YXlzDQo2NC1iaXQgTGludXgs
IHNvIHRoZSAzMi1iaXQgd2FzIG11Y2ggbGVzcyBpbXBvcnRhbnQuICBBbHNvLCBvbiAzMi1iaXQg
TGludXgsDQp0aGUgcmVxdWlyZWQgNjR4NjQgbXVsdGlwbHkgYW5kIHNoaWZ0IGlzIG1vcmUgY29t
cGxleCBhbmQgdGFrZXMgbW9yZQ0KbW9yZSBjeWNsZXMgKGNvbXBhcmUgMzItYml0IGltcGxlbWVu
dGF0aW9uIG9mIG11bF91NjRfdTY0X3NociB2cy4NCnRoZSA2NC1iaXQgaW1wbGVtZW50YXRpb24p
LCBzbyB0aGUgd2luIG92ZXIgYSBNU1IgcmVhZCBpcyBsZXNzLiAgSQ0KZG9uJ3Qga25vdyBvZiBh
bnkgYWN0dWFsIG1lYXN1cmVtZW50cyBiZWluZyBtYWRlIHRvIGNvbXBhcmUgdnMuDQpNU1IgcmVh
ZC4NCg0KTWljaGFlbA0KDQo+IA0KPiAtLQ0KPiBWaXRhbHkNCg==
