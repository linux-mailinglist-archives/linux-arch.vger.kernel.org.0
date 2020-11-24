Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB32C323B
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 21:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgKXU4T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 15:56:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:37915 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgKXU4P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 15:56:15 -0500
IronPort-SDR: pMNq8F+bl7V9eTaU3pzTmdpU+z/q/1lOpJdWivd1wJ62mBGCOJb4euLIfPC4yPeCOxG2eBFS4Y
 4q2o//bG+7eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="168506763"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="168506763"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 12:56:14 -0800
IronPort-SDR: WxLXB3fNfD2PnSzXjb7Hn+C5Y1LUzLgIQj3H5iOsaRvURgprY3r0U8N70nQ/D0KB/ZRpKPhGrh
 0zg+tXntDI6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="370489782"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2020 12:56:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 12:56:13 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 12:56:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Nov 2020 12:56:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 24 Nov 2020 12:56:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lnqnv83BYn22oxoWEao8krTfB3BnaaCnsZpy5A8md78hasUEBbBJ0owA0oNEoO+zRf606HpdQ30Lx1CNe+lGy5Ys3HWyIloS/L7M5kgn0pZ7fjnNGQlmMUp0R9FyoaV4cgLgXT7+6k6cEYnZzGvzwmYHJmlAqwsUqvq+60hqoG89WZYqLjepx6TxpxJKEmH928LAGaIIG3KB+YDGBpTdviLt//J1OqkcPc0s0NANFomMsi/JYzgxB7PscMghv4joPd4yXDhqahPNxhxpRk/TjMWDJlV1IBR2ma83JT2J437rWSPqQ+6FdzYtuYTi5UEvge6jJ2RM9vtjV5NXbtAN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH74Ah+qOOQTs6LRzsMr3s1sLFlWqiGBhfws6jmkTsY=;
 b=JvxiQHUaxNFwc50Pzf4HyP8zQ5y/yErtVC3Qo4Zo/L7hFcmY7jmtmg1AYcVVn7XiwEzfIgKgiPrX6RTv0PsaSKDmB/u6wLRViuWgPbZiumFCV3CLHq8DWdEl8QUFR6345PWBNtsIHfgBMznWx2KQbThUQk6B9f0ltxxmx3ul2kjZ7iIIfyB+KT8dMTZEvwoxhvD5g/Ys8oftjE3u5jTX8vN+Cxb18we4itC/AjwDx5Bs18tb7+Jnik9mKpARERA6bqHch7XcjREbQQz3P7Ff1NnIxa7AejRkKutQJWfF6UxNnHeEd4EGjNlUz102lVBh5ZfU1dAviGKUVEYvI3cJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH74Ah+qOOQTs6LRzsMr3s1sLFlWqiGBhfws6jmkTsY=;
 b=LlQYtwdkj6PaBOqGpRHll/0uYx22NpsI0PyBKsvwAV6zyAPMpPjVr3li2BHENiiRAgFQtzz/BUXkdE3CMDrP1G098T3XQQDaeZz8JXp+46ImBgHn+nT9sl3AEKMO71rCX/sP0OeQwvNk588O8Uijiog0HZAXB4mRUMoen6yWk0s=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 20:55:27 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 20:55:27 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Jann Horn <jannh@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Subject: Re: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Thread-Topic: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Thread-Index: AQHWvqcjVskyJoXuH0ORuPNb6HHBoanRpbwAgAX6YYCAAAWAAIAAIhWAgAABIYCAAAIigA==
Date:   Tue, 24 Nov 2020 20:55:27 +0000
Message-ID: <00730AF2-9727-4BA6-8C2A-164BD38738F1@intel.com>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-4-chang.seok.bae@intel.com>
 <CAG48ez1aKtwYMEHfGX6_FuX9fOruwvCqEGYVL8eLdV8bg-wHCQ@mail.gmail.com>
 <B2D7D498-D118-447E-93C6-DB03D42CBA4E@intel.com>
 <CAG48ez1JK6pMT2UD1v0FwiCQq48FbE5Eb0d3tK=kK4Sg0TG7OQ@mail.gmail.com>
 <15AB5469-3DBD-4518-9C15-DDCE7C70B1B5@intel.com>
 <CAG48ez3=0P+yiAjxGy=uEZeDUvFh+M2GUnVaGPfRoQHbJ+2qKw@mail.gmail.com>
In-Reply-To: <CAG48ez3=0P+yiAjxGy=uEZeDUvFh+M2GUnVaGPfRoQHbJ+2qKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d765fa5-1f1b-4d1b-6f4e-08d890bb4592
x-ms-traffictypediagnostic: SJ0PR11MB4944:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4944DC7325B2F0D3821ABFD7D8FB0@SJ0PR11MB4944.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+AEe+FXOCNz0Q+u0TMG8URVaRYxchz5EKRfqkRUIP3CijzRxGI4cDncsB8PUHH/7a8OmB395qYxxAixb3upDZ466UNw+Yk6ZK1ygceXbPJQFk/y1x2E1QXjC2fYGui7bTBizWrPRmkq1vmYTK6hSPfy1E3FiSYtgzm4/nehMPMY/6QdF+FIsQw4G35AtNkkDUgQz7CtdVruLke+nY30ObLFSWkajKtKtds13C/gcEYe6sHFT1W5xKQlHhgNZTfGBJzYaApG96RUSefyA5wx+VByc7XphZqudBPdemY2NZ+1Z/dvOsnVMQS11HUwZ9WGptxAyEo1xJcSBcyYKBPfyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(66476007)(6506007)(71200400001)(36756003)(6486002)(478600001)(64756008)(316002)(8676002)(66556008)(66946007)(66446008)(2906002)(5660300002)(7416002)(33656002)(53546011)(76116006)(8936002)(91956017)(6916009)(186003)(54906003)(83380400001)(86362001)(4326008)(2616005)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Um1McS9FRDFVZk9LK2tQc0sxSnpQNUo2K0hZZlJuSnE3WUZ4YmZ1MXJsOU9S?=
 =?utf-8?B?M3oxS0tiT3BPRnJWYTRuNXZ2UVNCRHNva1lJV25HUnVWTEtXc0FydVJROUhJ?=
 =?utf-8?B?S1NuN0N6RktXbUpyQWZrQitEWEVCTjRRL3kwR21oVE92L2VQY0RoNG1yUG5C?=
 =?utf-8?B?TjNSdUlCNjFkZjF3alUxRXlwUDJSS3JOeUVXL29uazVCRDY4Q0pRd3p0VlJO?=
 =?utf-8?B?YjdYcno5c2RGaXVscEs5WXB2cjNUYTVWV0VqNnNHWm82S2pDVmVRVXJrTDBG?=
 =?utf-8?B?U2E0b2lkdVlLOTY0VUdPNXZ3YTlWZ2Y5NTlCV0l1ME5sSjAxNzc3M0llTHBv?=
 =?utf-8?B?ZE5MaVVXNEc3MzQ4R1J3Q1lacThMUUQ5SFNTUFBnV0haakcveXorNkZZWjNE?=
 =?utf-8?B?dUF5SVBVMHNSMW4rdzNCbVpKZFhGNGF3ZmlKaURVMTV2amUzTld4ZkRkV0Mw?=
 =?utf-8?B?L3ZlTjVnOHc0emJpSXFTT2l0NWdDTU5Ia0REMExxaXZDTU13VW1YZFp6dnpH?=
 =?utf-8?B?RzYyaFNyQU9jaG5mUWRwVmMvVVRPUmtER0lZaDBSS3EvSmwwZFJCaHVtVU1s?=
 =?utf-8?B?eHNPWmpTUnhyamR0RjMwVnJqY3llOWNHUGMvUmd3UHA5MnREY1RwTUVJU2Z4?=
 =?utf-8?B?b3Z5TENYQlFKUEtBR01VZDhQLzY5VDFRSll3eVlDWmo0dTJCdnpQMDVvL2ly?=
 =?utf-8?B?RW1ockliWGxTUTdTNzFLOUViL21UVTNzNGloSEVNSTJOcmsxVFFheHFMRUJO?=
 =?utf-8?B?SDdEYUZNYjBBb2Y5M0h6WlBBK1pFT0ozYnhlSlNhb01JdEM4dUF4RkZlM3By?=
 =?utf-8?B?OVZWTEtaME0yNGZORmNyb1V6YjlvMnJ1SmRuVkljYStmRDdrR01KeVd4Tkt2?=
 =?utf-8?B?TDUrMDNaNWZTczc4UnZvYytqNEZEZmlOWGYxWHVOUy9VOTZTaCtTc2RlWVR5?=
 =?utf-8?B?K2h0Vm1JbzArZGhvOHJQcnkxQ1pLZjJGajBZWUsvN1JwUXlQRjk5cHplb05N?=
 =?utf-8?B?SmJnVjBSL01xVFN0WWo0VjFvZXpVMGQxcEZmejlYMmtCR1NOUXJ4Uzdjd3Zu?=
 =?utf-8?B?bTBaaU9PTGJHZXl5VHlwczdoRTlKdDdiWU53ZTFtZVlmNVJieWhLMHlYZ0ZC?=
 =?utf-8?B?TWprOUMvZkR6YzJsdTBCYlpQQnJtR2RHNitYbGRwVWFSeVlRQkVxVFJFOThz?=
 =?utf-8?B?UkFoVUpJRjZxMXVTNUpNcTd3OUtqek5lRVVKaUdzRUNldnNTTHlCVk1QdjV2?=
 =?utf-8?B?b2xlcjRSZGJMajFKaExJTlRpZWxmaUFTL25VdE84SU1zazVNVzlBcjJQSjZw?=
 =?utf-8?Q?K86D8QCpEX5n1VpovRtjOdSmehkd32Vhvq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E80D3BCF461BDA449917591EF1D2E681@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d765fa5-1f1b-4d1b-6f4e-08d890bb4592
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 20:55:27.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGEbjSNRJto6d4iLf0NDqzmfD6/orhXU/QZghC44B4OHC7WTZTUlk0fRg6SoOYcOx+dPk2HDC7L9BQsKyxuwLc923lQUE8vygyaFOnOPf8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCj4gT24gTm92IDI0LCAyMDIwLCBhdCAxMjo0NywgSmFubiBIb3JuIDxqYW5uaEBnb29nbGUu
Y29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgTm92IDI0LCAyMDIwIGF0IDk6NDMgUE0gQmFlLCBD
aGFuZyBTZW9rDQo+IDxjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20+IHdyb3RlOg0KPj4+IE9uIE5v
diAyNCwgMjAyMCwgYXQgMTA6NDEsIEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNvbT4gd3JvdGU6
DQo+Pj4gT24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgNzoyMiBQTSBCYWUsIENoYW5nIFNlb2sNCj4+
PiA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+IE9uIE5vdiAyMCwgMjAy
MCwgYXQgMTU6MDQsIEphbm4gSG9ybiA8amFubmhAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+Pj4+PiBP
biBUaHUsIE5vdiAxOSwgMjAyMCBhdCA4OjQwIFBNIENoYW5nIFMuIEJhZSA8Y2hhbmcuc2Vvay5i
YWVAaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL3NpZ25hbC5jIGIvYXJjaC94ODYva2VybmVsL3NpZ25hbC5jDQo+Pj4+Pj4gaW5k
ZXggZWU2ZjFjZWFhN2EyLi5jZWU0MWQ2ODRkYzIgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL3NpZ25hbC5jDQo+Pj4+Pj4gKysrIGIvYXJjaC94ODYva2VybmVsL3NpZ25hbC5j
DQo+Pj4+Pj4gQEAgLTI1MSw4ICsyNTEsMTMgQEAgZ2V0X3NpZ2ZyYW1lKHN0cnVjdCBrX3NpZ2Fj
dGlvbiAqa2EsIHN0cnVjdCBwdF9yZWdzICpyZWdzLCBzaXplX3QgZnJhbWVfc2l6ZSwNCj4+Pj4+
PiANCj4+Pj4+PiAgICAgIC8qIFRoaXMgaXMgdGhlIFgvT3BlbiBzYW5jdGlvbmVkIHNpZ25hbCBz
dGFjayBzd2l0Y2hpbmcuICAqLw0KPj4+Pj4+ICAgICAgaWYgKGthLT5zYS5zYV9mbGFncyAmIFNB
X09OU1RBQ0spIHsNCj4+Pj4+PiAtICAgICAgICAgICAgICAgaWYgKHNhc19zc19mbGFncyhzcCkg
PT0gMCkNCj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKHNhc19zc19mbGFncyhzcCkgPT0gMCkg
ew0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIC8qIElmIHRoZSBhbHRzdGFjayBtaWdo
dCBvdmVyZmxvdywgZGllIHdpdGggU0lHU0VHVjogKi8NCj4+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoIWFsdHN0YWNrX3NpemVfb2soY3VycmVudCkpDQo+Pj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gKHZvaWQgX191c2VyICopLTFMOw0KPj4+Pj4+
ICsNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICBzcCA9IGN1cnJlbnQtPnNhc19zc19zcCAr
IGN1cnJlbnQtPnNhc19zc19zaXplOw0KPj4+Pj4+ICsgICAgICAgICAgICAgICB9DQo+Pj4+PiAN
Cj4+Pj4+IEEgY291cGxlIGxpbmVzIGZ1cnRoZXIgZG93biwgd2UgaGF2ZSB0aGlzIChzaW5jZSBj
b21taXQgMTRmYzlmYmM3MDBkKToNCj4+Pj4+IA0KPj4+Pj4gICAgICAvKg0KPj4+Pj4gICAgICAg
KiBJZiB3ZSBhcmUgb24gdGhlIGFsdGVybmF0ZSBzaWduYWwgc3RhY2sgYW5kIHdvdWxkIG92ZXJm
bG93IGl0LCBkb24ndC4NCj4+Pj4+ICAgICAgICogUmV0dXJuIGFuIGFsd2F5cy1ib2d1cyBhZGRy
ZXNzIGluc3RlYWQgc28gd2Ugd2lsbCBkaWUgd2l0aCBTSUdTRUdWLg0KPj4+Pj4gICAgICAgKi8N
Cj4+Pj4+ICAgICAgaWYgKG9uc2lnc3RhY2sgJiYgIWxpa2VseShvbl9zaWdfc3RhY2soc3ApKSkN
Cj4+Pj4+ICAgICAgICAgICAgICByZXR1cm4gKHZvaWQgX191c2VyICopLTFMOw0KPj4+Pj4gDQo+
Pj4+PiBJcyB0aGF0IG5vdCB3b3JraW5nPw0KPj4+PiANCj4+Pj4gb25zaWdzdGFjayBpcyBzZXQg
YXQgdGhlIGJlZ2lubmluZyBoZXJlLiBJZiBhIHNpZ25hbCBoaXRzIHVuZGVyIG5vcm1hbCBzdGFj
aywNCj4+Pj4gdGhpcyBmbGFnIGlzIG5vdCBzZXQuIFRoZW4gaXQgd2lsbCBtaXNzIHRoZSBvdmVy
Zmxvdy4NCj4+Pj4gDQo+Pj4+IFRoZSBhZGRlZCBjaGVjayBhbGxvd3MgdG8gZGV0ZWN0IHRoZSBz
aWdhbHRzdGFjayBvdmVyZmxvdyAoYWx3YXlzKS4NCj4+PiANCj4+PiBBaCwgSSB0aGluayBJIHVu
ZGVyc3RhbmQgd2hhdCB5b3UncmUgdHJ5aW5nIHRvIGRvLiBCdXQgd291bGRuJ3QgdGhlDQo+Pj4g
YmV0dGVyIGFwcHJvYWNoIGJlIHRvIGVuc3VyZSB0aGF0IHRoZSBleGlzdGluZyBvbl9zaWdfc3Rh
Y2soKSBjaGVjayBpcw0KPj4+IGFsc28gdXNlZCBpZiB3ZSBqdXN0IHN3aXRjaGVkIHRvIHRoZSBz
aWduYWwgc3RhY2s/IFNvbWV0aGluZyBsaWtlOg0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvc2lnbmFsLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMNCj4+PiBpbmRl
eCBiZTBkN2Q0MTUyZWMuLjJmNTc4NDJmYjRkNiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvc2lnbmFsLmMNCj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMNCj4+PiBA
QCAtMjM3LDcgKzIzNyw3IEBAIGdldF9zaWdmcmFtZShzdHJ1Y3Qga19zaWdhY3Rpb24gKmthLCBz
dHJ1Y3QNCj4+PiBwdF9yZWdzICpyZWdzLCBzaXplX3QgZnJhbWVfc2l6ZSwNCj4+PiAgICAgICB1
bnNpZ25lZCBsb25nIG1hdGhfc2l6ZSA9IDA7DQo+Pj4gICAgICAgdW5zaWduZWQgbG9uZyBzcCA9
IHJlZ3MtPnNwOw0KPj4+ICAgICAgIHVuc2lnbmVkIGxvbmcgYnVmX2Z4ID0gMDsNCj4+PiAtICAg
ICAgIGludCBvbnNpZ3N0YWNrID0gb25fc2lnX3N0YWNrKHNwKTsNCj4+PiArICAgICAgIGJvb2wg
b25zaWdzdGFjayA9IG9uX3NpZ19zdGFjayhzcCk7DQo+Pj4gICAgICAgaW50IHJldDsNCj4+PiAN
Cj4+PiAgICAgICAvKiByZWR6b25lICovDQo+Pj4gQEAgLTI0Niw4ICsyNDYsMTAgQEAgZ2V0X3Np
Z2ZyYW1lKHN0cnVjdCBrX3NpZ2FjdGlvbiAqa2EsIHN0cnVjdA0KPj4+IHB0X3JlZ3MgKnJlZ3Ms
IHNpemVfdCBmcmFtZV9zaXplLA0KPj4+IA0KPj4+ICAgICAgIC8qIFRoaXMgaXMgdGhlIFgvT3Bl
biBzYW5jdGlvbmVkIHNpZ25hbCBzdGFjayBzd2l0Y2hpbmcuICAqLw0KPj4+ICAgICAgIGlmIChr
YS0+c2Euc2FfZmxhZ3MgJiBTQV9PTlNUQUNLKSB7DQo+Pj4gLSAgICAgICAgICAgICAgIGlmIChz
YXNfc3NfZmxhZ3Moc3ApID09IDApDQo+Pj4gKyAgICAgICAgICAgICAgIGlmIChzYXNfc3NfZmxh
Z3Moc3ApID09IDApIHsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgc3AgPSBjdXJyZW50LT5z
YXNfc3Nfc3AgKyBjdXJyZW50LT5zYXNfc3Nfc2l6ZTsNCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICBvbnNpZ3N0YWNrID0gdHJ1ZTsNCj4+PiArICAgICAgICAgICAgICAgfQ0KPj4+ICAgICAg
IH0gZWxzZSBpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2XzMyKSAmJg0KPj4+ICAgICAgICAgICAg
ICAgICAgIW9uc2lnc3RhY2sgJiYNCj4+PiAgICAgICAgICAgICAgICAgIHJlZ3MtPnNzICE9IF9f
VVNFUl9EUyAmJg0KPj4gDQo+PiBZZWFoLCBidXQgd291bGRuJ3QgaXQgYmV0dGVyIHRvIGF2b2lk
IG92ZXJ3cml0aW5nIHVzZXIgZGF0YSBpZiB3ZSBjYW4/IFRoZSBvbGQNCj4+IGNoZWNrIHJhaXNl
cyBzZWdmYXVsdCAqYWZ0ZXIqIG92ZXJ3cml0dGVuLg0KPiANCj4gV2hlcmUgaXMgdGhhdCBvdmVy
d3JpdGUgaGFwcGVuaW5nPyBCZXR3ZWVuIHRoZSBwb2ludCB3aGVyZSB5b3VyIGNoZWNrDQo+IGhh
cHBlbnMsIGFuZCB0aGUgcG9pbnQgd2hlcmUgdGhlIG9sZCBjaGVjayBpcywgdGhlIG9ubHkgY2Fs
bHMgYXJlIHRvDQo+IGZwdV9fYWxsb2NfbWF0aGZyYW1lKCkgYW5kIGFsaWduX3NpZ2ZyYW1lKCks
IHJpZ2h0Pw0KPiBmcHVfX2FsbG9jX21hdGhmcmFtZSgpIGp1c3QgZG9lcyBzb21lIHNpemUgY2Fs
Y3VsYXRpb25zIGFuZCBkb2Vzbid0DQo+IHdyaXRlIGFueXRoaW5nLiBhbGlnbl9zaWdmcmFtZSgp
IGFsc28ganVzdCBkb2VzIHNpemUgY2FsY3VsYXRpb25zLiBBbQ0KPiBJIG1pc3Npbmcgc29tZXRo
aW5nPw0KDQpZZWFoLCB5b3XigJlyZSByaWdodC4gUmlnaHQgbm93LCBJ4oCZbSB0aGlua2luZyB5
b3VyIGFwcHJvYWNoIGlzIHNpbXBsZXIgYW5kDQpwcm92aWRpbmcgYWxtb3N0IHRoZSBzYW1lIGZ1
bmN0aW9uICh1bmxlc3MgSeKAmW0gbWlzc2luZyBoZXJlKS4NCg0KVGhhbmtzLA0KQ2hhbmcNCg0K
