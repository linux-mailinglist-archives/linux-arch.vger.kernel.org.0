Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D466D6C130
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfGQS4d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 14:56:33 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:55788 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbfGQS4c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 14:56:32 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A6327C1279;
        Wed, 17 Jul 2019 18:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563389792; bh=uNcD0BXIcwwDuFoHy+gZf5RitwHTtIEY29Dxa/zj5oU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lsrRft3Zzf2D7oBOwFcV6RaAEf36KsMbcJn+24hzXvJxHbvhK4xdprDaBvJMJ/r/o
         4AT6pq2M9ScVVhc3LouBAhol8pdxeMtYgoGMGDJWwSRdPyUA7T+LycZYbmnzJW74al
         p3Qe7nyqrUVUXI3yFapmUt5bCRiAe2P46xsqMSmUgM3cQd4Zm2bI2utxW81Z2+9lsL
         bQj43YnW23NY26GARfwa4NDRwRtc1a0OPZdONTr/Z+idoXEqc8Ogiw8tx8tOMK9Nn5
         My3MGzbsdWGJjyKyl9IqotPKkEZ46ExORSjnI6v3wiPZ9uYKKH+CKp6Ay0DbOmMuvS
         KyG/YJC5QvRmA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5F00FA00B7;
        Wed, 17 Jul 2019 18:56:31 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Jul 2019 11:56:16 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 17 Jul 2019 11:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEVoxv+0i7seZiQPUK3dX7CRHQhW3DoPXgpoSAC5zCZ1ko9P2LTwNM//UrgzfPITFrUFK0irUyDXOngqUWyFZJm+vQlBWNuK/1ZeaIV4h3zB3GnAZGw6JlbOQL94t94ipSXFPqu+RPB5nFzhL6iVDbclMZ/XXDoPp/4yzVZzmpmR4dvRV3npEvg0HZf6wq9XgZkJMSn9fdgIXU/ZgWl4FmOec+XuG1E5p6ORbODlCRqUEOmZRj8CSO393ZaGWn8vt24fOWnbYa/7npuBnMTS2WzREIBGHsMYG4+sEdsZf9RIA4+s+k1ZBemKGM0EWn0b5UBbKsoZImIt2HE5VH9UWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNcD0BXIcwwDuFoHy+gZf5RitwHTtIEY29Dxa/zj5oU=;
 b=kOxPNrbQzOAppIESy5DwmUZscLnX+JX9UlPbZCi4uzgSNlqZSn/2Q2niJiBHYxzDuBE58Gi/WpxbK6j9tFNA7l8XBHOfw7PxSNng1xyriCB2BdmFDiA9roIKdZw3U2O2TB8MrPITW9PEjFjslRtecoE+esLAlkSSVezqUnhw6c6pq8m0AHMdgBQPsTAa1SnqyDMpMnuGrEQMoe4sUJAseKMGAffQ4RMmBKZh/97/uwPIVWY+aTDG6p7n93kB9Ll6FmFZb27O63aO/cbwUU+Hmbk95jgL1hbdM2917lULLgpSbNGcZtB3z1cSHs3+eAahK+n+T8YCzondpoaj+TFxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNcD0BXIcwwDuFoHy+gZf5RitwHTtIEY29Dxa/zj5oU=;
 b=UMXF1t28/LKgaQmJXEmuLTsz+/DPwUXJmnJ8kozPm84ea4ufo0VIhCPXcWZXFs7E3qzS74Hq3Jr+oeoWyG4lW1uGnzwvNVxvPnQBN43WZq+LwRPWjxz+6gMhjgGXz/taQAhr8RCmySwTn2lCdI+hQS9gfRbhKHgTwt2gex0VCQE=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2847.namprd12.prod.outlook.com (52.135.104.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 18:55:00 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::ecdd:a159:c3f7:67a]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::ecdd:a159:c3f7:67a%6]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 18:55:00 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "jbaron@redhat.com" <jbaron@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVItABmoPNpjiRbEyPVk6MS/0psabPXKOA
Date:   Wed, 17 Jul 2019 18:54:59 +0000
Message-ID: <401bc54416a106141b0ec785bfd9198ed56a84d8.camel@synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
         <57076361ad37f4fe7a5584643ae47adf30a99d35.camel@synopsys.com>
         <BN6PR1201MB0035E304FF25609CBCACBD09B6C90@BN6PR1201MB0035.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR1201MB0035E304FF25609CBCACBD09B6C90@BN6PR1201MB0035.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b721bd-5070-4b45-27a9-08d70ae844eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2847;
x-ms-traffictypediagnostic: SN6PR12MB2847:
x-microsoft-antispam-prvs: <SN6PR12MB2847612E62BF8D70086FF861DEC90@SN6PR12MB2847.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(6246003)(446003)(6436002)(6486002)(53936002)(561944003)(6512007)(3846002)(6116002)(2616005)(25786009)(476003)(11346002)(4326008)(316002)(2906002)(66066001)(118296001)(91956017)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(102836004)(8676002)(5660300002)(76176011)(53546011)(6506007)(186003)(2501003)(7736002)(305945005)(26005)(36756003)(256004)(14444005)(229853002)(478600001)(486006)(68736007)(110136005)(99286004)(8936002)(14454004)(71190400001)(71200400001)(54906003)(81156014)(81166006)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2847;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2OcZVksu6qDJw5CGcmmFhXnVqcJ/qzB6bc+QsfzTVU+5ohYdMIbN/jlCe0NVgGirxcxU1QcfehSIO7208KYseiKMA7NEy9VVYODvAGRAuf4jA2GhU9ngZFvglXH2Y0/my722PDC95Kfoj0s0u27Azpx+y74gh1tsPo9NDlcoFJpeXpu0ho/eS+F3f80fggM3VJesa6AcHrxlbYWt/iZHBDS3t/u2VEVdG9pkzaWMpevF14e5w5WqUKPxh+6Hd38XyAmdx8r/BMDhT6AIj0LC6OfIEOcR+LTxSBIjbGeq88UYDfaxqHk9/3u/AJSHQu37hS1DDW0YEyqf45p+lDUrwGSh+260bwem3UtgC/0Na1mYEfzv6VCxxJn9G9Mhylkm2KDkY13M/s6brqMhjOzXchlLU4f8TwLINuOY+gnQXG8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6BC058B74D4F0438B6DC07104F51623@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b721bd-5070-4b45-27a9-08d70ae844eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 18:55:00.0587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTE3IGF0IDE3OjQ1ICswMDAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDcvMTcvMTkgODowOSBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiA+ID4gPiArLyog
SGFsdCBzeXN0ZW0gb24gZmF0YWwgZXJyb3IgdG8gbWFrZSBkZWJ1ZyBlYXNpZXIgKi8NCj4gPiA+
ID4gKyNkZWZpbmUgYXJjX2psX2ZhdGFsKGZvcm1hdC4uLikJCQkJCQlcDQo+ID4gPiA+ICsoewkJ
CQkJCQkJCVwNCj4gPiA+ID4gKwlwcl9lcnIoSlVNUExBQkVMX0VSUiBmb3JtYXQpOwkJCQkJXA0K
PiA+ID4gPiArCUJVRygpOwkJCQkJCQkJXA0KPiA+ID4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGJy
aW5nIGRvd24gdGhlIHdob2xlIHN5c3RlbSB2cy4gZmFpbGluZyBhbmQgcmV0dXJuaW5nLg0KPiA+
ID4gSSBzZWUgdGhlcmUgaXMgbm8gZXJyb3IgcHJvcGFnYXRpb24gdG8gY29yZSBjb2RlLCBidXQg
c3RpbGwuDQo+ID4gSSB0b3RhbGx5IGFncmVlIHdpdGggUGV0ZXIsIGFuZCBJIHByZWZlciB0byBz
dG9wIHRoZSBzeXN0ZW0gb24gdGhpcyBlcnJvcnMuIEhlcmUgaXMgZmV3IGFyZ3VtZW50czoNCj4g
PiBBbGwgdGhpcyBjaGVja3MgY2FuJ3QgYmUgdG9nZ2xlIGluIHN5c3RlbSBvcGVyYXRpbmcgbm9y
bWFsbHkgYW5kIG9ubHkgbWF5IGJlIGNhdXNlZCBieSBiYWQgY29kZSBnZW5lcmF0aW9uIChvciBz
b21lIGNvZGUvZGF0YSBjb3JydXB0aW9uKToNCj4gPiAxKSBXZSBnb3Qgb3VyIGluc3RydWN0aW9u
IHRvIHBhdGNoIHVuYWxpZ25lZCBieSA0IGJ5dGVzIChkZXNwaXRlIHRoZSBmYWN0IHRoYXQgd2Ug
dXNlZCAnLmJhbGlnbiA0JyB0byBhbGlnbiBpdCkNCj4gPiAyKSBXZSBnb3QgYnJhbmNoIG9mZnNl
dCB1bmFsaWduZWQgKHdoaWNoIG1lYW5zIHRoYXQgd2UgY2FsY3VsYXRlIGl0IHdyb25nIGF0IGJ1
aWxkIHRpbWUgb3IgY29ycnVwdCBpdCBpbiBydW4gdGltZSkNCj4gPiAzKSBXZSBnb3QgYnJhbmNo
IG9mZnNldCB3aGljaCBub3QgZml0cyBpbnRvIHMyNS4gQXMgdGhpcyBpcyBvZmZzZXQgaW5zaWRl
IG9uZSBmdW5jdGlvbiAoaW5zaWRlIG9uZSAnaWYnIHN0YXRlbWVudCBhY3R1YWxseSkgd2UgbmV3
ZXIgZ2V0IHN1Y2ggaHVnZQ0KPiA+IG9mZnNldCBpbiByZWFsIGxpZmUgaWYgY29kZSBnZW5lcmF0
aW9uIGlzIG9rLg0KPiANCj4gSSB1bmRlcnN0YW5kIHRoYXQuIEJ1dCBBRkFJS1IgaW4gaW1wbGVt
ZW50YXRpb24gYXJjX2psX2ZhdGFsKCkgZ2V0cyBjYWxsZWQgYmVmb3JlDQo+IHdlIGhhdmUgZG9u
ZSB0aGUgYWN0dWFsIGNvZGUgcGF0Y2hpbmcgYW5kL29yIGZsdXNoaW5nIHRoZSBjYWNoZXMNCg0K
Q29ycmVjdC4NCg0KPiAgdG8gdGhhdCBlZmZlY3QuDQo+IFNvIGhhcm0gaGFzIGJlZW4gZG9uZSBq
dXN0IHlldC4gV2UganVzdCBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IGFueSBib29rLWtlZXBpbmcg
b2YNCj4gdHJ1ZS9mYWxzZSBpcyBub3QgeWV0IGRvbmUgb3IgdW5yb2xsZWQuDQoNCkNhbiB5b3Ug
ZGVzY3JpYmUgeW91ciBwcm9wb3NhbCBpbiBtb3JlIGRldGFpbD8NCg0KQmUgbm90ZWQgdGhhdCBp
biBjYXNlICgyKSBvciAoMykgd2Uga25vdyB0aGF0IHdlIGFyZSBub3QgYWJsZSB0byBnZW5lcmF0
ZSBjb3JyZWN0IGluc3RydWN0aW9uIGZvciByZXBsYWNlIGV4aXN0aW5nIG9uZS4gQW5kIHdlIGRv
bid0IGtub3cgYW55dGhpbmcNCmFib3V0IHRoZSByZWFsIGNhdXNlLg0KU28gd2hhdCB3ZSBjYW4g
ZG8gaGVyZSBiZXNpZGVzIHRoYXQgd2Ugd2FybiBhYm91dCBpdD8NCg0KLVdlIGNhbiBoYWx0IHRo
ZSBzeXN0ZW0gdG8gbWFrZSBkZWJ1ZyBlYXN5ICh3aGljaCBJIHByb3Bvc2UpDQotV2UgY2FuIGdl
bmVyYXRlIGludmFsaWQgaW5zdHJ1Y3Rpb24uDQotV2UgY2FuIGp1c3Qgc2tpcCB0aGlzIHBhdGNo
aW5nLiBJbiB0aGF0IGNhc2Ugd2UnbGwgZW5kIHdpdGggc29tZSAnaWYnIHN0YXRlbWVudHMgW2lu
IGtlcm5lbCBjb2RlXSB3b3JraW5nIGluY29ycmVjdGx5LiBJIHJlYWxseSBkb24ndCB3YW50IHRv
IGRlYnVnDQp0aGlzLg0KDQpHaXZlbiB0aGF0IHdlJ2xsIG5ldmVyIGZhY2Ugd2l0aCB0aGlzIGFz
c2VydHMgaW4gYW55IGNvbnNpc3RlbnQgc3RhdGUgSSBkb24ndCBzZWUgYW55IHJlYXNvbiB3aHkg
d2Ugc2hvdWxkbid0IHNpbXBseSBjYWxsIEJVRygpIGhlcmUuDQoNCj4gDQo+ID4gSWYgd2Ugb25s
eSB3YXJuIHRvIGxvZyBhbmQgcmV0dXJuIHdlIHdpbGwgZmFjZSB3aXRoIGNvbXByb21pc2VkIGtl
cm5lbCBmbG93IGxhdGVyLg0KPiA+IEkuRS4gaXQgY291bGQgYmUgJ2lmJyBzdGF0ZW1lbnQgaW4g
a2VybmVsIHRleHQgd2hpY2ggaXMgc3dpdGNoZWQgdG8gd3Jvbmcgc3RhdGU6IHRoZSBjb25kaXRp
b24gaXMgdHJ1ZSBidXQgd2UgdGFrZSB0aGUgZmFsc2UgYnJhbmNoLg0KPiA+IEFuZCBJdCB3aWxs
IGJlIHRoZSBpc3N1ZSB3aGljaCBpcyBtdWNoIG1vcmUgZGlmZmljdWx0IHRvIGRlYnVnLg0KPiA+
IA0KPiA+IERvZXMgaXQgc291bmQgcmVhc29uYWJseT8NCj4gDQo+IEknbSBzdGlsbCBub3QgY29u
dmluY2VkIHRoYXQgYnkgaGl0dGluZyB0aGUgX2ZhdGFsKCkgd2UgYXJlIGluIHNvbWUgaW5jb25z
aXN0ZW50DQo+IHN0YXRlIGFscmVhZHkuIEJ1dCBpZiB1IGZlZWwgc3Ryb25nbHkgbGV0cyBrZWVw
IGl0Lg0KPiANCj4gPiBJZiB5b3UgcmVhbGx5IGRvbid0IHdhbnQgdG8gaGF2ZSBCVUcgaGVyZSwg
SSBjYW4gbWFrZSBpdCBjb25kaXRpb25hbGx5IGVuYWJsZWQNCj4gDQo+IE5vdCBhIGdvb2QgaWRl
YS4gSXQgaXMgdW5jb25kaXRpb25hbGx5IHByZXNlbnQgb3Igbm90LiBOb3Qgc29tZXRoaW5nIGlu
IGJldHdlZW4uDQo+IA0KPiA+IGluIGRlcGVuZCBvbiBDT05GSUdfQVJDX1NUQVRJQ19LRVlTX0RF
QlVHIGFzIEkgd2FudCB0byBoYXZlIGl0IGVuYWJsZWQgYXQgbGVhc3Qgb24gQVJDIGRldmVsb3Bt
ZW50IHBsYXRmb3Jtcy4NCj4gDQo+IA0KLS0gDQogRXVnZW5peSBQYWx0c2V2DQo=
