Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D44D959
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFTSe7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 14:34:59 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:49902 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbfFTSe6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 14:34:58 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 38A15C1D6E;
        Thu, 20 Jun 2019 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561055698; bh=2Q9+5scn6KrKipSrzJyWxZQcbLpLyuZz+5BXxLmWnrc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TnOM7dnXc9kAyQ451jyM8+tFQdSMFj7Ugv+2CgXSnF5cZVNG1Ao9p2x2a0l7JqhvJ
         FoVWsxdID2mp54pfy64eDSU2kcGNRGXGrbQe4cxS3sbYyfeuem9fEeyqzPpybRUika
         QaFcriTQl4C73A5Dn/rJKIa8OeH879UpWpbiwKeAoUQFFAyUqsETh3MWADrrZdzobv
         1z4RTWS+nur9XE5xt/2L4zMlpscxJp8ycAIudtMHNBrfucw8JoDuP05IFvAEuUsn/b
         CiPcOuX8cJO43+sCrZV1GruB+bVBejxVFKLjVRNHmGEk91iazKSvu4tLwFq33RWHRE
         d0KTtsAUlQLTQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E8BA4A0095;
        Thu, 20 Jun 2019 18:34:57 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 20 Jun 2019 11:34:57 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 20 Jun 2019 11:34:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q9+5scn6KrKipSrzJyWxZQcbLpLyuZz+5BXxLmWnrc=;
 b=Yd0l9FWkhmWNEtf5M5MN+4OS/Kzei8YNATSG2Nh6EWwVVOli8+s53XLaV3mE/omnYOayEZF44kndRCTyXEA8G5K1m626VG7EvQlI50h1VJw9jsFcpXhVocmBPYXhh27R9OlEtwawnD1PRcv9Bfv9EYoxjf9Rl1xOI1sHsKX0xDc=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2653.namprd12.prod.outlook.com (52.135.103.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Thu, 20 Jun 2019 18:34:55 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::bd34:8d2b:911e:e495]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::bd34:8d2b:911e:e495%5]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 18:34:55 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
CC:     "jbaron@akamai.com" <jbaron@akamai.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVItABmoPNpjiRbEyPVk6MS/0psaakJk0AgADBxwA=
Date:   Thu, 20 Jun 2019 18:34:55 +0000
Message-ID: <a945de7d3b6f2da03c62c9e1043e125b4c4211aa.camel@synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
         <20190619081227.GL3419@hirez.programming.kicks-ass.net>
         <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
         <20190620070120.GU3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190620070120.GU3402@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a45e321f-1227-4e14-f857-08d6f5adfdf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2653;
x-ms-traffictypediagnostic: SN6PR12MB2653:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2653A0384DC7B95C168B1BF0DEE40@SN6PR12MB2653.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(99286004)(6506007)(53546011)(476003)(446003)(6436002)(486006)(11346002)(2616005)(110136005)(6306002)(6512007)(86362001)(3846002)(76176011)(6486002)(229853002)(6636002)(316002)(26005)(6116002)(186003)(2906002)(118296001)(256004)(68736007)(8936002)(25786009)(71200400001)(71190400001)(36756003)(66066001)(6246003)(7736002)(478600001)(305945005)(966005)(81156014)(81166006)(8676002)(102836004)(14454004)(53936002)(2501003)(54906003)(66446008)(66476007)(66556008)(64756008)(4326008)(73956011)(66946007)(76116006)(91956017)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2653;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JicIwXbQJHUCXt/Z/OkMIzUbTLKYgr4Jymur8+PZHelZMS10Ck7j6jDx9jDBpG/izef8U3KEKRBFWvj44PRgWk5jbr5SxX2fE1n3WaotccsVhjfeRA+jw4ArnLHfvjzGR1C7pnFqkY9aqsQA23QGEM/kCLiFJdCpQ05HukzzRyPCyVJ4t3eAKTqCixio7pM6cODEuddK9KbF9NerpwcfrpKp44UX8O1QL5zJ1GsuOLLBOX1+MHuKlaERoEQSLfjC2jcrXRhh7mbziCp9EbAHHJay/h3ehupU0KOYgEFqr5tq8L0H5EYDLrrm1ox3e3uHT5qjc5uNBqhw8Sp95SFCO6JFTtcZPD6ZKNfMZvjA8PWTn6ehZq0+Z+MBFxILFrJBsjA9RGwSYU+EReLuR9dwYGQZDQA64Xj2J5HRg8cLCB4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1AC54EE21D2C340AE47EB1977599190@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a45e321f-1227-4e14-f857-08d6f5adfdf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 18:34:55.7699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2653
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgUGV0ZXIsDQpPbiBUaHUsIDIwMTktMDYtMjAgYXQgMDk6MDEgKzAyMDAsIFBldGVyIFppamxz
dHJhIHdyb3RlOg0KPiBPbiBXZWQsIEp1biAxOSwgMjAxOSBhdCAxMTo1NTo0MVBNICswMDAwLCBW
aW5lZXQgR3VwdGEgd3JvdGU6DQo+ID4gT24gNi8xOS8xOSAxOjEyIEFNLCBQZXRlciBaaWpsc3Ry
YSB3cm90ZToNCj4gPiA+IEknbSBhc3N1bWluZyB5b3UndmUgbG9va2VkIGF0IHdoYXQgeDg2IGN1
cnJlbnRseSBkb2VzIGFuZCBmb3VuZA0KPiA+ID4gc29tZXRoaW5nIGxpa2UgdGhhdCBkb2Vzbid0
IHdvcmsgZm9yIEFSQz8NCj4gPiANCj4gPiBKdXN0IGxvb2tlZCBhdCB4ODYgY29kZSBhbmQgaXQg
c2VlbXMgc2ltaWxhcg0KPiANCj4gSSB0aGluayB5b3UgbWlzc2VkIGEgYml0Lg0KPiANCj4gPiA+
ID4gPiArCVdSSVRFX09OQ0UoKmluc3RyX2FkZHIsIGluc3RyKTsNCj4gPiA+ID4gPiArCWZsdXNo
X2ljYWNoZV9yYW5nZShlbnRyeS0+Y29kZSwgZW50cnktPmNvZGUgKyBKVU1QX0xBQkVMX05PUF9T
SVpFKTsNCj4gPiA+IFNvIGRvIHlvdSBoYXZlIGEgMiBieXRlIG9wY29kZSB0aGF0IHRyYXBzIHVu
Y29uZGl0aW9uYWxseT8gSW4gdGhhdCBjYXNlDQo+ID4gPiBJJ20gdGhpbmtpbmcgeW91IGNvdWxk
IGRvIHNvbWV0aGluZyBsaWtlIHg4NiBkb2VzLiBBbmQgaXQgd291bGQgYXZvaWQNCj4gPiA+IHRo
YXQgTk9QIHBhZGRpbmcgeW91IGRvIHRvIGdldCB0aGUgYWxpZ25tZW50Lg0KPiA+IA0KPiA+IEp1
c3QgdG8gYmUgY2xlYXIgdGhlcmUgaXMgbm8gdHJhcHBpbmcgZ29pbmcgb24gaW4gdGhlIGNhbm9u
aWNhbCBzZW5zZSBvZiBpdC4gVGhlcmUNCj4gPiBhcmUgcmVndWxhciBpbnN0cnVjdGlvbnMgZm9y
IE5PLU9QIGFuZCBCcmFuY2guDQo+ID4gV2UgZG8gaGF2ZSAyIGJ5dGUgb3Bjb2RlcyBmb3IgYm90
aCBidXQgYXMgZGVzY3JpYmVkIHRoZSBicmFuY2ggb2Zmc2V0IGlzIHRvbw0KPiA+IGxpbWl0ZWQg
c28gbm90IHVzYWJsZS4NCj4gDQo+IEluIHBhcnRpY3VsYXIgd2UgZG8gbm90IG5lZWQgdGhlIGFs
aWdubWVudC4NCj4gDQo+IFNvIHdoYXQgdGhlIHg4NiBjb2RlIGRvZXMgaXM6DQo+IA0KPiAgLSBv
dmVyd3JpdGUgdGhlIGZpcnN0IGJ5dGUgb2YgdGhlIGluc3RydWN0aW9uIHdpdGggYSBzaW5nbGUg
Ynl0ZSB0cmFwDQo+ICAgIGluc3RydWN0aW9uDQo+IA0KPiAgLSBtYWNoaW5lIHdpZGUgSVBJIHdo
aWNoIHN5bmNocm9uaXplcyBJJA0KPiANCj4gQXQgdGhpcyBwb2ludCwgYW55IENQVSB0aGF0IGVu
Y291bnRlcnMgdGhpcyBpbnN0cnVjdGlvbiB3aWxsIHRyYXA7IGFuZA0KPiB0aGUgdHJhcCBoYW5k
bGVyIHdpbGwgZW11bGF0ZSB0aGUgJ25ldycgaW5zdHJ1Y3Rpb24gLS0gdHlwaWNhbGx5IGEganVt
cC4NCj4gDQo+ICAgLSBvdmVyd3JpdGUgdGhlIHRhaWwgb2YgdGhlIGluc3RydWN0aW9uIChpZiB0
aGVyZSBpcyBhIHRhaWwpDQo+IA0KPiAgIC0gbWFjaGluZSB3aWRlIElQSSB3aGljaCBzeW5jcmhv
bml6ZXMgSSQNCj4gDQo+IEF0IHRoaXMgcG9pbnQsIG5vYm9keSB3aWxsIGV4ZWN1dGUgdGhlIHRh
aWwsIGJlY2F1c2Ugd2UnbGwgc3RpbGwgdHJhcCBvbg0KPiB0aGF0IGZpcnN0IHNpbmdsZSBieXRl
IGluc3RydWN0aW9uLCBidXQgaWYgdGhleSB3ZXJlIHRvIHJlYWQgdGhlDQo+IGluc3RydWN0aW9u
IHN0cmVhbSwgdGhlIHRhaWwgbXVzdCBiZSB0aGVyZS4NCj4gDQo+ICAgLSBvdmVyd3JpdGUgdGhl
IGZpcnN0IGJ5dGUgb2YgdGhlIGluc3RydWN0aW9uIHRvIG5vdyBoYXZlIGEgY29tcGxldGUNCj4g
ICAgIGluc3RydWN0aW9uLg0KPiANCj4gICAtIG1hY2hpbmUgd2lkZSBJUEkgd2hpY2ggc3luY3Jo
b25pemVzIEkkDQo+IA0KPiBBdCB0aGlzIHBvaW50LCBhbnkgQ1BVIHdpbGwgZW5jb3VudGVyIHRo
ZSBuZXcgaW5zdHJ1Y3Rpb24gYXMgYSB3aG9sZSwNCj4gaXJyZXNwZWN0aXZlIG9mIGFsaWdubWVu
dC4NCj4gDQo+IA0KPiBTbyB0aGUgYmVuZWZpdCBvZiB0aGlzIHNjaGVtZSBpcyB0aGF0IGlzIHdv
cmtzIGlycmVzcGVjdGl2ZSBvZiB0aGUNCj4gaW5zdHJ1Y3Rpb24gZmV0Y2ggd2luZG93IHNpemUg
YW5kIGRvbid0IG5lZWQgdGhlICdmdW5ueScgYWxpZ25tZW50DQo+IHN0dWZmLg0KPiANCg0KVGhh
bmtzIGZvciBleHBsYW5hdGlvbi4gTm93IEkgdW5kZXJzdGFuZCBob3cgdGhpcyB4ODYgbWFnaWMg
d29ya3MuDQoNCkhvd2V2ZXIgaXQgbG9va3MgbGlrZSBldmVuIG1vcmUgY29tcGxleCB0aGFuIEFS
TSBpbXBsZW1lbnRhdGlvbi4NCkFzIEkgdW5kZXJzdGFuZCBvbiBBUk0gdGhleSBkbyBzb21ldGhp
bmcgbGlrZSB0aGF0Og0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0Kb25fZWFjaF9jcHUgew0KCXdyaXRlX2luc3RydWN0aW9uDQoJZmx1c2hf
ZGF0YV9jYWNoZV9yZWdpb24NCglpbnZhbGlkYXRlX2luc3RydWN0aW9uX2NhY2hlX3JlZ2lvbg0K
fQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xL3NvdXJjZS9hcmNoL2Fy
bS9rZXJuZWwvcGF0Y2guYyNMMTIxDQoNClllcCwgdGhlcmUgaXMgc29tZSBvdmVyaGVhZCAtIGFz
IHdlIGRvbid0IG5lZWQgdG8gZG8gd2hpdGUgYW5kIEQkIGZsdXNoIG9uIGVhY2ggY3B1DQpidXQg
dGhhdCBtYWtlcyBjb2RlIHNpbXBsZSBhbmQgYXZvaWRzIGFkZGl0aW9uYWwgY2hlY2tzLg0KDQpB
bmQgSSBkb24ndCB1bmRlcnN0YW5kIGluIHdoaWNoIGNhc2VzIHg4NiBhcHByb2FjaCB3aXRoIHRy
YXAgaXMgYmV0dGVyLg0KSW4gdGhpcyBBUk0gaW1wbGVtZW50YXRpb24gd2UgZG8gb25lIG1hY2hp
bmUgd2lkZSBJUEkgaW5zdGVhZCBvZiB0aHJlZSBpbiB4ODYgdHJhcCBhcHByb2FjaC4NCg0KUHJv
YmFibHkgdGhlcmUgaXMgc29tZSB4ODYgc3BlY2lmaWNzIEkgZG9uJ3QgZ2V0Pw0KDQoNCj4gTm93
LCBJJ3ZlIG5vIGlkZWEgaWYgc29tZXRoaW5nIGxpa2UgdGhpcyBpcyBmZWFzaWJsZSBvbiBBUkM7
IGZvciBpdCB0bw0KPiB3b3JrIHlvdSBuZWVkIHRoYXQgMiBieXRlIHRyYXAgaW5zdHJ1Y3Rpb24g
LS0gc2luY2UgYWxsIGluc3RydWN0aW9ucyBhcmUNCj4gMiBieXRlIGFsaWduZWQsIHlvdSBjYW4g
YWx3YXlzIHBva2UgdGhhdCB3aXRob3V0IGlzc3VlLg0KDQpZZXAgd2UgaGF2ZSAyIGJ5dGUgdHJh
cCAodHJhcF9zIGluc3RydWN0aW9uKS4NCg0KQWN0dWFsbHkgdGhlcmUgYXJlIGV2ZW4gdHdvIGNh
bmRpZGF0ZXMgYW5vdGhlciBjYW5kaWRhdGVzIHdoaWNoIGNhbiBiZSB1c2VkDQppbnN0ZWFkIHRy
YXBfcyB0byBhdm9pZCBhZGRpbmcgYWRkaXRpb25hbCBjb2RlIHRvIHRyYXAgaGFuZGxlcjoNClNX
SV9TIC0gc29mdHdhcmUgaW50ZXJydXB0DQphbmQNClVOSU1QX1MgLSBpbnN0cnVjdGlvbiB3aXRo
IGZ1bm55IG5hbWUgJ3VuaW1wbGVtZW50ZWQgaW5zdHJ1Y3Rpb24nDQoNCg0KLS0gDQogRXVnZW5p
eSBQYWx0c2V2DQo=
