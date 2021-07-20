Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BEA3D0241
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhGTTF3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 15:05:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:58430 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhGTTFK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jul 2021 15:05:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="198588176"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="198588176"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 12:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="500879191"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2021 12:45:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 12:45:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 12:45:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 20 Jul 2021 12:45:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 20 Jul 2021 12:45:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA7GM8olQ5hiMeNVn2mL87B6coSmxieej82G0XTqmQ8oN8y7TKDW1D42F+D2jB+IZxHguFaM0v0agTk5sJ/BWEfRt8L5d2ETnP17J2vtpYxMkSWCG1orJO0JAn3qBtw2PMy0ajbdnTNp44tM9kzTyOesHOvtfICWwlcXUt6onMUPUkCET4Bbz4Z3rFAXvcqilf8hUtT2Ox+1amgsBdZTaGFiS2ipyUN7EzmKtLaXFJLtXxOoYn2X4BB56OPk8tJwFUnmBXq4Hva+riY6ANOjHKj4HPM6vHCOmEUDY7wLpTiYtbFIS2T5vtuWOQsLf7ML9cWiW9TMPOLV5LNG9ipXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUNGOfAezCO/67HcFVZlN8bhzb2wVbu/wRVqr7fP560=;
 b=khVCPHysQRqDKxcYfzLjS0Nz7s/iwyA8svU4veosqvMtO/ui7Pxl9ix+y9W7/FTpMjr0yPvYuipIo6j1g2hr84uMiQJ+Zun+IsbBEd8dH/Eh6ShUFxMuxqKLMOJec/nNcz/0eju9u/5NsUwgVv07ODdnEzh8aZNEGbKuq4DhVyVYG24az9N6ajI4MuQptLrlPcYoV81fFBk/XCQ5VNwrWwuY7mqX5P+FeUM0BfnDXTmMugtuJkxS57HOoMmdgpSqVoO3zCgq+MqgZEfhVpVCjrof8CSbe9iC4e6toDMghkPr9xFMwvbiazvJ4BNBSsp/VBbvDp07e6EkcOPfY58fKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUNGOfAezCO/67HcFVZlN8bhzb2wVbu/wRVqr7fP560=;
 b=HBJh9/bsa7Am5jEbX6clS8BdZ+d4bBD3QWKFlFqOIncGJs/73Ykm56t2BCQenjm0yyOmLBypkrQfF563wOyCyqUB3fAu05q7Dw4N2BK5eQiyZ/t21b2EXJAqkukC6mTCD7iij6gDUNe0sbeVTeBWhYiRjvIDkyG/WW3WYnX5B+A=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB3373.namprd11.prod.outlook.com (2603:10b6:805:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.30; Tue, 20 Jul
 2021 19:45:29 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::4046:c957:f6a9:27db]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::4046:c957:f6a9:27db%5]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 19:45:29 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v27 06/10] x86/cet/ibt: Update arch_prctl functions for
 Indirect Branch Tracking
Thread-Topic: [PATCH v27 06/10] x86/cet/ibt: Update arch_prctl functions for
 Indirect Branch Tracking
Thread-Index: AQHXfLzqqlbuDRHG5ECh81TtFyLv96tKnFOAgAF+Q4CAACuFAA==
Date:   Tue, 20 Jul 2021 19:45:29 +0000
Message-ID: <9ff5f160b54f48870ac16f698d32a476c3fd3424.camel@intel.com>
References: <20210521221531.30168-1-yu-cheng.yu@intel.com>
         <20210521221531.30168-7-yu-cheng.yu@intel.com>
         <31008f559a7263d2a4042f9c061efcd4e86b5a69.camel@intel.com>
         <964c71f8-1dcf-4eb5-1858-e985e77e5b6d@intel.com>
In-Reply-To: <964c71f8-1dcf-4eb5-1858-e985e77e5b6d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4db3468-48c0-40bb-8233-08d94bb6edf5
x-ms-traffictypediagnostic: SN6PR11MB3373:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3373F08A83EA4E134AD5C0ABC9E29@SN6PR11MB3373.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnz6Gp9fzaFomN9fuDUIxwBsuyETWAN85d+PBgJhgBavudFCsI6hGmaaFKNUvXH6/4IKqRrbx+SjsKx0VRyDhSx5q54sGbpfjSU8QfIH9hrw/xeamroRlGBTmoYso5nyd4bhyCZPgJUFfiWHtJhc0ujvElreGo/5gYsIFAVBfVrZp/u3E23Vc+GF3B3zg4vTGdF1cBkbpK93Y6yHb6C2AEa1w8LBr6YnUyhTSeXp4n58YmPWl14b4DnIjsBD3IJJEokX8+xJLCFBFRaPQsehuIJ990NFhhpASaA15aMtUV7WbJE4lOVZNFd2eZF5MvhvomPB4DYLJMmNE8aaMcnRtt5L4AJueXzDXM5oEv8AC27g0Nyhs6ETjCymaaX6pbKQq4D5MeFFDPBA0ihmYZ3dLRFHM3cOXOiHqK7k8c+/uic5GT0nRrMgfjQqIFKfzpgjb3HzPZes3KzRJvVuEzQjI/EjNtGjGPNIjyv+JbtElE8EejOrrls4+WFQrGh8JQS0HxT8LLkZApkcGDiFo0wBQgM3P3u5cUxk3UDzsoDw70d3vU/bN+GIMyJbUTUSDYtOhE6ap+ttVLSBpaTNBtNXytL3Iv813UaU7muTS5tx729NgkuQH69W4lDcicZPgU1H4N7zwZ88Q3UQHAng5zjYyZiz9D9iUzWmGMokWOp96XJiba2jJ13/+RFyD+J1aLOTQUnTnpimLUkouLaMSTEO4FF/l8V2/0PW6o2EzOLTb6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(316002)(6486002)(110136005)(478600001)(5660300002)(6512007)(8676002)(921005)(2616005)(83380400001)(26005)(8936002)(2906002)(186003)(36756003)(76116006)(6506007)(91956017)(71200400001)(53546011)(15650500001)(64756008)(66556008)(7416002)(66946007)(122000001)(38100700002)(66446008)(66476007)(86362001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFBRdHVLZXBScjIwdUJqTVZTd21wWFR6VjZyblBUSjExQ2ZtUlJBWXVBYW1n?=
 =?utf-8?B?czk3ZS9GL1pqVEhqbDJyamhUWGlveUZ5TkxJN0l1Zk8xTExwcU5tNFdsQisr?=
 =?utf-8?B?REgxeXV4MDhlU0F5WGZ5ejl0RFdUM2d3d3FTbUtPVktaemlEaWdDZm9yUWV0?=
 =?utf-8?B?VUxtbTRMZERUS1dnV3Bjd2xlY3NZTDV0bklLTmxKR3p4cTVZTWJZcFlaZGU3?=
 =?utf-8?B?TndTVERDMHZPUzlSeGkrb3h1MWFYYXE5MzVFZXlsMGpQR0hkTlVXTUJkSGtP?=
 =?utf-8?B?Z290WERXNkpjcXNrbzFCWlBHNFU4bWwyYnRkcmZVeUdxbCtoaFZ6Sm1QSzNM?=
 =?utf-8?B?YVh0Y2NoeSs5VkpMYjEzd2pEWmNqQzZVVG5FWGo2dG4yWHVuTlduejhDVFRR?=
 =?utf-8?B?U3ZLUk52ZndxVHNaVUdSNlMzSDkxdnpnYm5kOE9jaWN6MGdYU0RmSVFvb01L?=
 =?utf-8?B?RjZYQ0FOUkxHQzR6c1RERW9acVB2UkdFTGthUkhvd09oL3d1UFh3eDNKWVlX?=
 =?utf-8?B?NEwyV3NaYlYwSGFtLzJrME9uRFYvRW1scnlTbDBSSDhScFNBbTZKVE01aXFC?=
 =?utf-8?B?dEFxQ2pVZTBINTRtWksxR2ErZXZUVWhXTzJwc0lOMmIxdkRrQWlBN2lkM3Zl?=
 =?utf-8?B?UjNERXd5NHFPMEh3WTB3QU82WngrTVFkVjhmOVVUR2liZ1BJbnE4YmtrZkJN?=
 =?utf-8?B?MGVJS2JUWXRFdDFzNE9idWpBZzJlRC81NjlsVkV4Ukg5VXZIeWR5aUpiQWhj?=
 =?utf-8?B?ZlZ4Y3FDMnpSYTJqSUMvUlpqbFVZaEprR2tFSnNrTklIYmczdGtjNUJId3or?=
 =?utf-8?B?c1RCLzBpR291WDdOK1U1aEJzVmh6SjU0Mnh3L3duS1N5V2RsMWgybmxmRDFJ?=
 =?utf-8?B?aEE3clVhWjFWVHBvUmRxQU5Ob25HU2hTamtLd3JCSTVJKytwcUVXanlFMXF5?=
 =?utf-8?B?U2kwcysrNndrSzVQYkRUNlRjckV3OFcxbFhWKzhHbFAwVStmanpTQTFrSGFw?=
 =?utf-8?B?N25qdDVsNXRseHFibjZMNmhuSEdDTUlIWU5mWmhSZlphemV5ZVFQT3RMMnpS?=
 =?utf-8?B?Wm44Tlh2VUxzOGpDUEZCWURuVVptVWxFZHNaRmxmV2ZCUVNiV05YeXoyNDJL?=
 =?utf-8?B?NEpzMUdPc21ZYjY0aVhTbHhvMUFXOWY0ZjdCWTUrRlAvYUdNVkcvS0pTZXVx?=
 =?utf-8?B?aC9mbkxMdmZTTm1kbFhkQWNwcHJLRnluR1JRUUoveGRtbVJXUFF6bGg1N2I3?=
 =?utf-8?B?UDBubTBNQ0k1MmtzRytRbjJKZU41M3NRcG84VkNoSlFLa1hxQjBKZ3k2TzZB?=
 =?utf-8?B?K0lkUjF2WlFpOWNHbDdZSkZKdjc3Sy95WmJRSEttYXFaSFllQVRSdldvTjVh?=
 =?utf-8?B?a1Jxdno1b2VhczNvQTFZaWtsK3VlL2FycmJZRk9vM2xPeHdqNStDWkVuUFUy?=
 =?utf-8?B?b1ZsQWdpZVVNVzlJQlc3dCtkOWhMaExFNkJabzJ5RlhEVTMrZC9xNkZLNTFC?=
 =?utf-8?B?UEN6Z0paRmNweDVjQjFWTHZBWjRiWUNlUS9IOU5BV3cxblpCNXpaWm93ODdQ?=
 =?utf-8?B?UTlVL3ptbTVOUWNXQ1NtaW9hNFNSOXdRa2xLVFBGd0pSZ2UwUjFJd2swM2lL?=
 =?utf-8?B?S3pYNFUyeEFIbDlHOVk4QlJtMzViZy9LbUpkYk1TelJKdFh3aytNSWJLQTZu?=
 =?utf-8?B?UW5CMnlsbmRpOVBsVjMxQzJLTFVRbTVPQ1FWS2NxdVpGcVpUZlMzakFRUEkw?=
 =?utf-8?Q?jg3JxTyZx51NaYC4FTKobXInXJMTGYBnN1baq++?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ECC66F76E68FD4E9959B0FF540F30BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4db3468-48c0-40bb-8233-08d94bb6edf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 19:45:29.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wS4HZBGccOY0BdaTCt8n/aI/HPql1cHhSOlSqVlspeum/OtoApRamLD2fE2+OzHscwrV4MjF8qUmMv2RbU/2XHJAxM1GnkIffDyNf2LlK8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3373
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTIwIGF0IDEwOjA5IC0wNzAwLCBZdSwgWXUtY2hlbmcgd3JvdGU6DQo+
IE9uIDcvMTkvMjAyMSAxMToyMSBBTSwgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4gT24g
RnJpLCAyMDIxLTA1LTIxIGF0IDE1OjE1IC0wNzAwLCBZdS1jaGVuZyBZdSB3cm90ZToNCj4gPiA+
IEZyb206ICJILkouIEx1IiA8aGpsLnRvb2xzQGdtYWlsLmNvbT4NCj4gPiA+IA0KPiA+ID4gVXBk
YXRlIEFSQ0hfWDg2X0NFVF9TVEFUVVMgYW5kIEFSQ0hfWDg2X0NFVF9ESVNBQkxFIGZvciBJbmRp
cmVjdA0KPiA+ID4gQnJhbmNoDQo+ID4gPiBUcmFja2luZy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogSC5KLiBMdSA8aGpsLnRvb2xzQGdtYWlsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gPiBSZXZpZXdlZC1i
eTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+ID4gPiAtLS0NCj4gPiA+IMKg
wqBhcmNoL3g4Ni9rZXJuZWwvY2V0X3ByY3RsLmMgfCA1ICsrKysrDQo+ID4gPiDCoMKgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva2VybmVsL2NldF9wcmN0bC5jDQo+ID4gPiBiL2FyY2gveDg2L2tlcm5lbC9jZXRfcHJj
dGwuYw0KPiA+ID4gaW5kZXggYjQyNmQyMDBlMDcwLi5iZDNjODBkNDAyZTcgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY2V0X3ByY3RsLmMNCj4gPiA+ICsrKyBiL2FyY2gveDg2
L2tlcm5lbC9jZXRfcHJjdGwuYw0KPiA+ID4gQEAgLTIyLDYgKzIyLDkgQEAgc3RhdGljIGludCBj
ZXRfY29weV9zdGF0dXNfdG9fdXNlcihzdHJ1Y3QNCj4gPiA+IHRocmVhZF9zaHN0ayAqc2hzdGss
IHU2NCBfX3VzZXIgKnVidWYpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnVmWzJdID0gc2hzdGstPnNpemU7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4g
PiDCoCANCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChzaHN0ay0+aWJ0KQ0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1ZlswXSB8PSBHTlVfUFJPUEVSVFlfWDg2X0ZFQVRV
UkVfMV9JQlQ7DQo+ID4gPiArDQo+ID4gQ2FuIHlvdSBoYXZlIElCVCBlbmFibGVkIGJ1dCBub3Qg
c2hhZG93IHN0YWNrIHZpYSBrZXJuZWwNCj4gPiBwYXJhbWV0ZXJzPw0KPiA+IE91dHNpZGUgdGhp
cyBkaWZmIGl0IGhhczoNCj4gPiBpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
U0hTVEspKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT1RTVVBQOw0KPiANCj4gSWYg
c2hhZG93IHN0YWNrIGlzIGRpc2FibGVkIGJ5IHRoZSBrZXJuZWwgcGFyYW1ldGVyLCBJQlQgaXMg
YWxzbw0KPiBkaXNhYmxlZC4NClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uDQoNCj4gDQo+
ID4gU28gaWYgIm5vX3VzZXJfc2hzdGsiIGlzIHNldCwgdGhpcyBjYW4ndCBiZSB1c2VkIGZvciBJ
QlQuIEJ1dCB0aGUNCj4gPiBrZXJuZWwgd291bGQgYXR0ZW1wdCB0byBlbmFibGUgSUJULg0KPiAN
Cj4gSXQgd2lsbCBub3QuDQpPaCB5ZWEsIEkgc2VlIHRoZSBjcHVpZF9kZXBzIHBhcnQgbm93LiBT
b3JyeS4NCg0KPiANCj4gPiBBbHNvIGlmIHNvLCB0aGUgQ1I0IGJpdCBlbmFibGluZyBsb2dpYyBu
ZWVkcyBhZGp1c3RpbmcgaW4gdGhpcyBJQlQNCj4gPiBzZXJpZXMuIElmIG5vdCwgd2Ugc2hvdWxk
IHByb2JhYmx5IG1lbnRpb24gdGhpcyBpbiB0aGUgZG9jcyBhbmQNCj4gPiBlbmZvcmNlDQo+ID4g
aXQuIEl0IHdvdWxkIHRoZW4gZm9sbG93IHRoZSBsb2dpYyBpbiBLY29uZmlnLCBzbyBtYXliZSB0
aGUNCj4gPiBzaW1wbGVzdC4NCj4gPiBMaWtlIG1heWJlIGluc3RlYWQgb2Ygbm9fdXNlcl9zaHN0
aywganVzdCBub191c2VyX2NldD8NCj4gDQo+IElmIHNoYWRvdyBzdGFjayBpcyBkaXNhYmxlZCAo
ZnJvbSBlaXRoZXIgS2NvbmZpZyBvciBrZXJuZWwgDQo+IGNvbW1hbmQtbGluZSksIHRoZW4gSUJU
IGlzIGFsc28gZGlzYWJsZWQuwqAgSG93ZXZlciwgd2Ugc3RpbGwgbmVlZCB0d28NCj4ga2VybmVs
IHBhcmFtZXRlcnMgYmVjYXVzZSBub191c2VyX2lidCBjYW4gYmUgdXNlZnVsIHNvbWV0aW1lcy7C
oCBJDQo+IHdpbGwgDQo+IGFkZCBhIHNlbnRlbmNlIGluIHRoZSBkb2N1bWVudCB0byBpbmRpY2F0
ZSB0aGF0IElCVCBkZXBlbmRzIG9uIHNoYWRvdw0KPiBzdGFjay4NCj4gDQo+IA0KWWVhLCBub191
c2VyX2lidCBzZWVtcyB1c2VmdWwuIEkgbWVhbnQgdGhhdCByZW5hbWluZyBub191c2VyX3Noc3Rr
IHRvDQpub191c2VyX2NldCAob3Igc2ltaWxhcikgd291bGQgYmUgbW9yZSBjbGVhciBhbmQgc2Vs
ZiBkb2N1bWVudGluZywNCnNpbmNlIGl0IGludGVuZHMgdG8gZGlzYWJsZSBhbGwgdXNlciBjZXQg
ZmVhdHVyZXMgYW5kIG5vdCBqdXN0DQpzaGFkb3dzdGFjay4gQW5kIGxlYXZpbmcgbm9fdXNlcl9p
YnQgYXMgaXMuIERvY3VtZW50YXRpb24gd29ya3MgYXMgd2VsbA0KdGhvdWdoLiBOb3QgbWFqb3Ig
aW4gYW55IGNhc2UuDQoNCg==
