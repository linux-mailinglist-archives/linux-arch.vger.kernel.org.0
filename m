Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4C2CF425
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 19:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgLDSfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 13:35:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:9650 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387808AbgLDSfK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Dec 2020 13:35:10 -0500
IronPort-SDR: YUUPXtUjipgbubEhWEMH2pU8N8BAvgTR+LnfqpYshDAdGLbCcxbykRVAvA+dZVOTkDFyxvegzn
 DmkdfesKiCdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="170853484"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="170853484"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 10:34:23 -0800
IronPort-SDR: tPKCsCIsjaF9dOnF3PXL9UEw8PpV8g81HLxuIn8i5KKmdZrZrfnV6/5kM3N4riwAFwF1i23UOI
 gr5ZhFgD7yuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="346683882"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2020 10:34:22 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Dec 2020 10:34:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 4 Dec 2020 10:34:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 4 Dec 2020 10:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXQvFWFtb3h1D6lnPNnk7rOcOBbK4R7SpzkBNa2UgHvTejo6b0vwQZhD0082v2OapkK/h2Kq3MZusA7RP4zlgvOvxxjpnYggzmaC37TPSMHuDe1BIa+hp+/YEBctTDt2tbN7U4ZLu173zLUB1LZjL3YRvSV6BuTToexCTvNnDjA5Bq0HDJdRyyWhUjd1DtWY7kz4pkBMHV3gsYOjaOXBV2n5e9JtfN8q8nE0CbRUYZ8HhfACFrW9vsirouqAh95TD2JF1dXmDi8LTHVIHoVP5PLuFxceP1Is2S2N7Jj3a+ScxWNa5RA8NatQQObW/rrCEpqsRPNLRmwBj1uZc8Bccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pGihKPDGqIg+SlU+jk6TfFt/GR8szYzraWqbP0Xxfo=;
 b=mkKMPtANqwEsJVwgLn7lLHs54Riu+aPlDqKgXvzGo2cx052bnPLCwNGtI4K7+alRMwO52HNVgFp0IkxBTi3/WZ6Ghatevk3NVEYmWdvKSHwaodVw4QockfSGBqoXpfAtoO6NKhRrStUheSKMyPKcLE8sy84NQIrEaVhNwtB8kvCnL1fSerZSEnmwP6KcSQkP7qCQ/mNE93cZpQBn4lrvDHlo9DNgeLrk1ct+RYm6TiZ3AHFR/+tUPKr2hqU+hafd1ZQ+AbM0PsUzvT1ypAwWdURLrjMhv3X8LVTEEMVoBkStqBt4Mq+bhzBabMrAIM2wJeDO0+JbEDjplZajBZ35hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pGihKPDGqIg+SlU+jk6TfFt/GR8szYzraWqbP0Xxfo=;
 b=SotSdOYDGdjPwr6AEuK3TMgQiN1NiCC1CyseEfY1E77hdSRgqOgZZUM9DY8rDr3uX6hCLKAPr+Fxor4DIoYpLwAxNx//S8/5hU7ls6JaYYNw+mSRppGZQn/1daYh1CInaeksp04K8Ox/0LzrbdXIBBssKerRO8LMR3wqdVNQYC0=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 18:33:54 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412%6]) with mapi id 15.20.3611.025; Fri, 4 Dec 2020
 18:33:54 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 11/12] mm/vmalloc: Hugepage vmalloc mappings
Thread-Topic: [PATCH v8 11/12] mm/vmalloc: Hugepage vmalloc mappings
Thread-Index: AQHWx0IouDnRaQC0zE26j1j/vLv2yqnhHkOAgAV9xQCAAK16AA==
Date:   Fri, 4 Dec 2020 18:33:54 +0000
Message-ID: <2e8e1f3e47736e8f5e749cee85b7036cbf9cb1b5.camel@intel.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
         <20201128152559.999540-12-npiggin@gmail.com>
         <e9d3a50e1b18f9ea1cdfdc221bef75db19273417.camel@intel.com>
         <1607068679.lfd133za4h.astroid@bobo.none>
In-Reply-To: <1607068679.lfd133za4h.astroid@bobo.none>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e2f56a9-81a6-4c21-6768-08d898832777
x-ms-traffictypediagnostic: SN6PR11MB2671:
x-microsoft-antispam-prvs: <SN6PR11MB2671D440327043090A7CD029C9F10@SN6PR11MB2671.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWmu2O6yU0Gt4BzEwOVEokPs9O7IRCLaPhI5Qe1zyiqY7IU6vfh9zQZ8NodzUTnqHFEgJWCtxXRcMJPUrK4oEMaEky5vcKBei6tQNpuoAjhZGd6DW7TIouZShOQwQXUJF0UtGiUZ8rTss0BKocdC+uFGsYGqQubMpGYf7TZoslBHzp2Yv6r7GCX0VV8tbVchTpzL+ligcQIveu+ODjUqFGmON9tugdh2JyLwQUNZLRL6B5ndA609KGghScFsE84FVi6p7+LlFmo+q1Tv31A1cx230oBeD3o1sblEt+hKQH8KGP+Tjaaops/XjjujiJDc4bO6AhFt+0UvQld+B9+qOASRkm04WPtgFA/FQjdmzGFS4ZUH6TpvdBOexnE59qqUmqjyNZtYqcT+Pd4t6Dtbyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66946007)(2906002)(6486002)(316002)(71200400001)(478600001)(7416002)(4326008)(8936002)(110136005)(5660300002)(54906003)(83380400001)(6506007)(86362001)(2616005)(8676002)(6512007)(66446008)(4001150100001)(66556008)(66476007)(36756003)(91956017)(186003)(26005)(64756008)(966005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c3dVRGdaNFZyM0NQbzdSalhELzI2TzBkREhjNWl3dDNUNHJ0cmh3bWdIS0pq?=
 =?utf-8?B?TWw5MDUrbGM1L0h4T1hvLzcyQ2RMVEdtK0dtRHlwdkRBdmoxUVd6TkJVcjl1?=
 =?utf-8?B?aUdBTisxS2dQTlMwZ25LUWZWZnlrYytmN0lHWDdYUGJOOWVtUDRrM1FVV1Av?=
 =?utf-8?B?ZjZtbVRuRS9QQmNxbjNHNjZXK1JnUkVPUjNTS0tSZ3hFd3NhNnpsRlpERzlu?=
 =?utf-8?B?QjhLTTNCdzZ0YTUxMUhVYnBKVi9maSs5UHF5RlVwbFJINXFxZGJPOXkvYjVj?=
 =?utf-8?B?aDM2ck05ZkkyZU1XYm9ET2ZGSGFrL1pZdFhITmxwZ1RBaEVBZTc0aWsyMSsr?=
 =?utf-8?B?TDRITFZ0ZTRrREFjVFZNM3lRQVovZkpNWlYrTFJCcUhQVEFhbDc1TkQyeTl5?=
 =?utf-8?B?c1FlZ3gvU3oySkU2RGNqWFA1dGg0YzhZSVd1QlMwZHpVKzlZWHM2Nzl5Z0hB?=
 =?utf-8?B?dzV6anNxQjJ1R0YrYWkvVGs5WHREdSswbjRGUzNQallCR3liNXRzVW9FWWVY?=
 =?utf-8?B?NThGbEZVQVU4dkZQWnlrYWxtOXdNblF5dzEwUlhyN20zcnIxMEVWcXArQlRp?=
 =?utf-8?B?NFhVQnJRbnM3azZjaERCTWlxMWZmZHRWVzdTTzVXUHpHWXhBMmdyWHVZdEpx?=
 =?utf-8?B?L2VEcmlEL1RWeUczRGNnc2U3WmNUUlQ4WjNTcWFpRFZnbWxEWUdSNFlzWEhB?=
 =?utf-8?B?M081b0JtT1VVZWQ1ZTFOY2dEYWEyMzB1cGgrMHNxRDEzQ0JTRWRRZkhDTEt2?=
 =?utf-8?B?QUlWWXdNWFl4TXV6NWI4V1hRRzhhSFI3YUVBR3lXVVVMQm9lUzJSa0hEWFJK?=
 =?utf-8?B?SmhRQ2RObWJCbCtmRFc3dTFhcmo2S0lJSGZVWEYzYVNGUUxmOEZNbjhua2RO?=
 =?utf-8?B?aGdmVENXbm1iazB3M0pPbmNKZEd5Qk93RXl6Z0g0bjBkYTVEanZSNXhWZVE4?=
 =?utf-8?B?WHk4MmlobzBZM1hGL0ZqeHlpNlpyMkRqTUo1Z1hwNHdhS01JdVgxQm52SEpo?=
 =?utf-8?B?enpsL1RMa3BGbUNpM2FsTlBBdXh2cHhDWHdJTDJLMXVqKzRudzE2OWJCV2E0?=
 =?utf-8?B?S3R1QzdGZ0ZkZVh6U3ltZFBRd0Y5aDZHUEpUdDB5bjFRK3hOUG1aYjdCdnlS?=
 =?utf-8?B?a0M4dTRpa3Byc1p0VFliWmRQN2EreStyWlpKWTc3aTFRMmZoU1BoRm5iV3RH?=
 =?utf-8?B?dTV3U3dSR3hJWlhCZnQxOHV3dmh1eDJuY3FPaEM1TmNPSHdrdFM4QWpaNHJS?=
 =?utf-8?B?cXRQUTNicHprK2JJTFFxZDg2R1J2Uksvd3BVZlI2NkFQWkpSQlR0ajlNR2Fw?=
 =?utf-8?Q?fu8LMUzxAUmZoSTPSSo9JJR0kIP+8WAKAN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4389A573289C0445932317275B5476BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2f56a9-81a6-4c21-6768-08d898832777
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 18:33:54.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NQ7GZEi6tehexOw+UmCtv8DVoX7TXdqoAe//7e+Gsjo2eYkd+7Yl035It+yL0I9Wf253XdjjGwA7mXeu0bKjihsICvbiXsUfFRApHBM6tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2671
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDE4OjEyICsxMDAwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6
DQo+IEV4Y2VycHRzIGZyb20gRWRnZWNvbWJlLCBSaWNrIFAncyBtZXNzYWdlIG9mIERlY2VtYmVy
IDEsIDIwMjAgNjoyMQ0KPiBhbToNCj4gPiBPbiBTdW4sIDIwMjAtMTEtMjkgYXQgMDE6MjUgKzEw
MDAsIE5pY2hvbGFzIFBpZ2dpbiB3cm90ZToNCj4gPiA+IFN1cHBvcnQgaHVnZSBwYWdlIHZtYWxs
b2MgbWFwcGluZ3MuIENvbmZpZyBvcHRpb24NCj4gPiA+IEhBVkVfQVJDSF9IVUdFX1ZNQUxMT0MN
Cj4gPiA+IGVuYWJsZXMgc3VwcG9ydCBvbiBhcmNoaXRlY3R1cmVzIHRoYXQgZGVmaW5lIEhBVkVf
QVJDSF9IVUdFX1ZNQVANCj4gPiA+IGFuZA0KPiA+ID4gc3VwcG9ydHMgUE1EIHNpemVkIHZtYXAg
bWFwcGluZ3MuDQo+ID4gPiANCj4gPiA+IHZtYWxsb2Mgd2lsbCBhdHRlbXB0IHRvIGFsbG9jYXRl
IFBNRC1zaXplZCBwYWdlcyBpZiBhbGxvY2F0aW5nDQo+ID4gPiBQTUQNCj4gPiA+IHNpemUNCj4g
PiA+IG9yIGxhcmdlciwgYW5kIGZhbGwgYmFjayB0byBzbWFsbCBwYWdlcyBpZiB0aGF0IHdhcyB1
bnN1Y2Nlc3NmdWwuDQo+ID4gPiANCj4gPiA+IEFsbG9jYXRpb25zIHRoYXQgZG8gbm90IHVzZSBQ
QUdFX0tFUk5FTCBwcm90IGFyZSBub3QgcGVybWl0dGVkIHRvDQo+ID4gPiB1c2UNCj4gPiA+IGh1
Z2UgcGFnZXMsIGJlY2F1c2Ugbm90IGFsbCBjYWxsZXJzIGV4cGVjdCB0aGlzIChlLmcuLCBtb2R1
bGUNCj4gPiA+IGFsbG9jYXRpb25zIHZzIHN0cmljdCBtb2R1bGUgcnd4KS4NCj4gPiANCj4gPiBT
ZXZlcmFsIGFyY2hpdGVjdHVyZXMgKHg4NiwgYXJtNjQsIG90aGVycz8pIGFsbG9jYXRlIG1vZHVs
ZXMNCj4gPiBpbml0aWFsbHkNCj4gPiB3aXRoIFBBR0VfS0VSTkVMIGFuZCBzbyBJIHRoaW5rIHRo
aXMgdGVzdCB3aWxsIG5vdCBleGNsdWRlIG1vZHVsZQ0KPiA+IGFsbG9jYXRpb25zIGluIHRob3Nl
IGNhc2VzLg0KPiANCj4gQWgsIHRoYW5rcy4gSSBndWVzcyBhcmNocyBtdXN0IGFkZGl0aW9uYWxs
eSBlbnN1cmUgdGhhdCB0aGVpcg0KPiBQQUdFX0tFUk5FTCBhbGxvY2F0aW9ucyBhcmUgc3VpdGFi
bGUgZm9yIGh1Z2UgcGFnZSBtYXBwaW5ncyBiZWZvcmUNCj4gZW5hYmxpbmcgdGhlIG9wdGlvbi4N
Cj4gDQo+IElmIHRoZXJlIGlzIGludGVyZXN0IGZyb20gdGhvc2UgYXJjaHMgdG8gc3VwcG9ydCB0
aGlzLCBJIGhhdmUgYW4NCj4gZWFybHkgKHVuLXBvc3RlZCkgcGF0Y2ggdGhhdCBhZGRzIGFuIGV4
cGxpY2l0IFZNX0hVR0UgZmxhZyB0aGF0IGNvdWxkDQo+IG92ZXJyaWRlIHRoZSBwZXNzZW1pc3Rp
YyBhcmNoIGRlZmF1bHQuIEl0J3Mgbm90IG11Y2ggdHJvdWJsZSB0byBhZGQNCj4gdGhpcyANCj4g
dG8gdGhlIGxhcmdlIHN5c3RlbSBoYXNoIGFsbG9jYXRpb25zLiBJdCdzIHZlcnkgb3V0IG9mIGRh
dGUgbm93IGJ1dA0KPiBJIA0KPiBjYW4gYXQgbGVhc3QgZ2l2ZSB3aGF0IEkgaGF2ZSB0byBhbnlv
bmUgZG9pbmcgYW4gYXJjaCBzdXBwb3J0IHRoYXQNCj4gd2FudHMgaXQuDQoNCkFoaCwgc29ycnks
IEkgdG90YWxseSBtaXNzZWQgdGhhdCB0aGlzIHdhcyBvbmx5IGVuYWJsZWQgZm9yIHBvd2VycGMu
DQoNClRoYXQgcGF0Y2ggbWlnaHQgYmUgdXNlZnVsIGZvciBtZSBhY3R1YWxseS4gT3IgbWF5YmUg
YSBWTV9OT0hVR0UsIHNpbmNlDQp0aGVyZSBhcmUgb25seSBhIGZldyBwbGFjZXMgd2hlcmUgZXhl
Y3V0YWJsZSB2bWFsbG9jcyBhcmUgY3JlYXRlZD8gSSdtDQpub3Qgc3VyZSB3aGF0IHRoZSBvdGhl
ciBpc3N1ZXMgYXJlLg0KDQpJIGFtIGVuZGVhdm9yaW5nIHRvIGhhdmUgc21hbGwgbW9kdWxlIGFs
bG9jYXRpb25zIHNoYXJlIGxhcmdlIHBhZ2VzLCBzbw0KdGhpcyBpbmZyYXN0cnVjdHVyZSBpcyBh
IGJpZyBoZWxwIGFscmVhZHkuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAxMTIw
MjAyNDI2LjE4MDA5LTEtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20vDQoNClRoYW5rcyENCg==
