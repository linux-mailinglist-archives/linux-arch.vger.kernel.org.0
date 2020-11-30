Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D242C8F57
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 21:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgK3UlS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 15:41:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:21018 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbgK3UlS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 15:41:18 -0500
IronPort-SDR: 3lsackvgOcVC+tL3Hc96p8+MQ1xBeK1pMWV7mH+q7I1RnBscI9KR/y+59Vgw/AGOkigbJT5Swu
 Pz8wgJ0Z192w==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="160479449"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="160479449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:40:36 -0800
IronPort-SDR: D63bIqKuPfPwrTknr9ZCTNlo6M28lqWbtJFy3XoihO4Z5SEpZduBnO7Z+ygdY1A/2OBvj5BJMv
 DD0GIAE2RRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="537153532"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2020 12:40:35 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Nov 2020 12:40:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Nov 2020 12:40:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 30 Nov 2020 12:40:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etvJR20yZXsPXtYrtaSnZY/pjnJgvWZA0hlV3uSYRF2aYS2qaR9HE1BbP5aHgvam0Rq0JAY2Ks2TsOCKS1AL8BfV1I2Hy5qCySvv6sZKz4dokyk8KKE2yHLbLtclWHtQ8Xn8rYyyIUPX/Sy/QRu0atl7/cf59+TSAuFgq4U+XNpUtvrTmLX87EwAKITUhVIIdpxtcGeBIc6HRbYnFvTItO6RNR/zZCXVyFUJLakSwXHK5jBI49oVxZJp2GZ7O0zj/G8/xtN3W7mhUU30dS+j1T87gAuIHW8cc+lIhUmbrfA8k3p3ZQZYNwQR/cHrnQW5vMK7KEJPMeaDOnTmmm29nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPpWMe+fdNDRPjzQ8g2jgHAGSDm4VChy3lqbBs7Uz4w=;
 b=OjhFmhP/WVkJU6zL1/AQ7mqkDDWFDpcpjYhqPuVwctFBa6vARB7LIXdI3dF4X6LNa4KYw2PzyjZ4VhGM/+OjoDDxCfitUuNnHlEDw2O5Kalwpt2Uayvovy8H+igWyG9FrN8+5lO3e6Q/a6p2x82KzBD6AmtkjWn7BgK+J8f4jsyK5lZ59ReQMmfigxKpelgGam7nBonGKNW57RrtMoezI/L3o0YobK4i759kGNJv4w4B7ShO1vYPjG/dW/gqyUotwTtos9j7lc7q76T2zeRa9ILHrO+nWYMxz46mt0DZ30Ciy51bUlm8/ZwxLLIpeC+K7xyxChq8B4e7xHfQyuUBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPpWMe+fdNDRPjzQ8g2jgHAGSDm4VChy3lqbBs7Uz4w=;
 b=brq+93b22cWqvDRlEZT0Qua1LJgeBxqqHJo1IbCKnljbUWEX49/IJ5me1VWXR1BZwF/m7LmHx5QjCzVDYLjbWl1oz8ofPgWZjBXLzErM/YUR2pfVfyAUYmvd4eZY4Owl7M97qukaoRj5HB2yUnSqa1sA89ECq0DiZhEo2DidjDo=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Mon, 30 Nov
 2020 20:40:32 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 20:40:32 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] x86/signal: Introduce helpers to get the maximum
 signal frame size
Thread-Topic: [PATCH v2 1/4] x86/signal: Introduce helpers to get the maximum
 signal frame size
Thread-Index: AQHWvqciaZ534EQiSkSZCqnJ1GpIVKnYu80AgAh4+IA=
Date:   Mon, 30 Nov 2020 20:40:32 +0000
Message-ID: <FFC7041A-2CCA-4C7E-A9C9-6C2C30CE7D28@intel.com>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-2-chang.seok.bae@intel.com>
 <20201125111630.GA10378@zn.tnic>
In-Reply-To: <20201125111630.GA10378@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [112.148.21.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc5dc4e0-fe5a-4148-201d-08d895702eb7
x-ms-traffictypediagnostic: SJ0PR11MB5150:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5150E9C64B12C3C10DE56C81D8F50@SJ0PR11MB5150.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VUKftNLaStQYYveAg77JyFSzpwVyBMkON7v6J9NtX9nS2uVob6qYP1qlc23qapfXIirEFOgfzBi+DJgz/Ut0oVkaXuxLzMoWLkagVmDZe+3umvxywxSnbHM4eiK/40VY8FG0NIHpgGUaGL0dkLwiCjwh03IwBdCkdfFtkALI72nlP6Y/8UWjzMWGrSYqb6/Z/1tR0qBDSr7HD8aBtcOSZX+23xG42UYoDpVNHwgdTADwPQWFEzGLKcFo2IDOGQl54R6Q16oCmQ9x+rxj9+UdEoT1cSLl6fmDxPb/iXtiOQUjUJLSJzbE6T3ita98azyDS1l1Z+OtTRCk+1gTsakWAbTtEjc+TgKy0DMO5C66vJXJJkD3GsrfPzK/QqNnDoLWPEyTPLN9iMPh2smQhJwEKC2iS63Dl/a132vPosA4n/kge5AlWOmvD6pQORGllVsxuAkNfubCm23zuKfk700ADA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(8936002)(966005)(71200400001)(83380400001)(2616005)(53546011)(478600001)(6506007)(7416002)(66556008)(86362001)(6512007)(5660300002)(186003)(76116006)(4326008)(66946007)(33656002)(26005)(66476007)(64756008)(91956017)(54906003)(36756003)(6916009)(2906002)(6486002)(8676002)(66446008)(316002)(15583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c1ZlRzFwMm5RQ2NkUUZ2eDVzK2xldGQwanlpYWl4KzdaaDIvVzJVemhUajh6?=
 =?utf-8?B?K2EwQk9uTWN0UTJQcEJGNVdIWkhNT1M0VVlXWmdUaWRhdzBaMUI0K1Ayd2Np?=
 =?utf-8?B?ZXo5TzhiTEcyQ1JkbVdnUjBVTzIyTEZrOVQ2ZGQ1YklJRjdyTVZlbzZwYUtE?=
 =?utf-8?B?OFhySEZQMEFvZEtjRklRUG5XaEM1a3FmdXJkdXZPR2lUQy83U3dlVVN4Mm1w?=
 =?utf-8?B?Qjk4QVY4ZG5aNGI0NVB5cVZZSmJqRjlYL2dxL3AzSEV4TW53NkFBb0hOTVpV?=
 =?utf-8?B?T2NhV3V5bVZxUDB0dXRlK3Q2cldNQWRzSVU1d2crT0xxVXNkR2FURjNZOHJw?=
 =?utf-8?B?bWNranRGNVMxWkhwZHJDcFF2b09tRHdLQUxGVGpYR081ZzNtdVhheVFZbGg0?=
 =?utf-8?B?a0RNalBHbTNZb045cWExem9iekpidERYNzVHdE9VemZnTXpoWlphOWhjTWFR?=
 =?utf-8?B?TTNSc0dacTUvU1NOWTJqN0ZFeURVMlVGbzh1VVljRTJOVzJrSmQ5Uk9wVDRM?=
 =?utf-8?B?YkhVUitTeTNSckszS2RvTFJmRGFwZHFPSm1Ba3RWSFRzeWNvM2h2QW1LcXdZ?=
 =?utf-8?B?aHZlSmdnbnN3SWN3U0o5SW1SZmFJZGxNdERyOHpCMWFyNFREMVl0d2VTeHNN?=
 =?utf-8?B?eG81aXJ0ZXVTZnEvbmJ3NjAvY0grVE9HZFZXSFRLN2R4MUVkbEtneGFTZTZN?=
 =?utf-8?B?VHNrZmkvWHhGbURITkY5MWZHdTB3YVpOY3E5K25tcEFOY1Z4eHZ1QWVGNnIr?=
 =?utf-8?B?VVl1NC9xQTdDNDg1T3lsdkM1UzFHWFBuWnFKd0loV01PcXNqVk10UFpJSjRE?=
 =?utf-8?B?TnR3YjQyQTJIQ3MyZnVTNnZIRVFEV1RkYm1jc0F0clE5cVNMRExZbjZnZ0lo?=
 =?utf-8?B?UkxJRTJKQll5MnNIYytEM21yN1cvYW03Rk1NVHJwa1lBTzZKRXNpR2syKzV0?=
 =?utf-8?B?cVVuSGwvdnAvdWY2NThiSVg2M0JxdGk2SXpBWWdFWWdrNmJrbWNCR2lrb0tP?=
 =?utf-8?B?aVNldUVJMDlGdUtBVnFsWS9hR2l6MmxJdjNsRzRURUluSnZreVJlbFc5dTEy?=
 =?utf-8?B?RlJhUmlCU3JRcGF3MjhNNHpxQ2NTTldXMGFtdmNSSnJqOElJangxaURuUGsv?=
 =?utf-8?B?S2hadW5IK3QyQklVTkVkcFNVMkFoREo1R25FSzgwTENHL0QzS1piRlM5TzVq?=
 =?utf-8?B?U1NEUU1kNTY1WlhneHhnWks5RlpyUWF5OGJuU2xlbmN3bkxPTWZJR1NHYmRT?=
 =?utf-8?B?NWhzN2hxY2lrMThCbXhIZTRkOHVBR1NPb3Y0cFk2eUlBbER6NVF2SnlkdEdx?=
 =?utf-8?Q?jCyXV0884udTjp3byDb7Eq3VtMLa5Yen2k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17DF51F3E413DF43B7291BA87FD15F75@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5dc4e0-fe5a-4148-201d-08d895702eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 20:40:32.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrCzXRCBE9+AOJ3NhKEfHDyIne7H/2An6k5IUBoaYaTMdMQWzQv1VULdrdh8kHHZcRYoiPHTUkheudMMtC+sTsH1xRhHI9CVRDOLpzI5R+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5150
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQo+IE9uIE5vdiAyNSwgMjAyMCwgYXQgMjA6MTcsIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTm92IDE5LCAyMDIwIGF0IDExOjAyOjM0QU0gLTA4
MDAsIENoYW5nIFMuIEJhZSB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9zaWdmcmFtZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc2lnZnJhbWUuaA0KPj4gaW5k
ZXggODRlYWIyNzI0ODc1Li5hYzc3ZjNmOTBiYzkgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9zaWdmcmFtZS5oDQo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaWdm
cmFtZS5oDQo+PiBAQCAtNTIsNiArNTIsMTUgQEAgc3RydWN0IHJ0X3NpZ2ZyYW1lX2lhMzIgew0K
Pj4gCWNoYXIgcmV0Y29kZVs4XTsNCj4+IAkvKiBmcCBzdGF0ZSBmb2xsb3dzIGhlcmUgKi8NCj4+
IH07DQo+PiArDQo+PiArI2RlZmluZSBTSVpFT0Zfc2lnZnJhbWVfaWEzMglzaXplb2Yoc3RydWN0
IHNpZ2ZyYW1lX2lhMzIpDQo+PiArI2RlZmluZSBTSVpFT0ZfcnRfc2lnZnJhbWVfaWEzMglzaXpl
b2Yoc3RydWN0IHJ0X3NpZ2ZyYW1lX2lhMzIpDQo+PiArDQo+PiArI2Vsc2UNCj4+ICsNCj4+ICsj
ZGVmaW5lIFNJWkVPRl9zaWdmcmFtZV9pYTMyCTANCj4+ICsjZGVmaW5lIFNJWkVPRl9ydF9zaWdm
cmFtZV9pYTMyCTANCj4+ICsNCj4+ICNlbmRpZiAvKiBkZWZpbmVkKENPTkZJR19YODZfMzIpIHx8
IGRlZmluZWQoQ09ORklHX0lBMzJfRU1VTEFUSU9OKSAqLw0KPj4gDQo+PiAjaWZkZWYgQ09ORklH
X1g4Nl82NA0KPj4gQEAgLTgxLDggKzkwLDIyIEBAIHN0cnVjdCBydF9zaWdmcmFtZV94MzIgew0K
Pj4gCS8qIGZwIHN0YXRlIGZvbGxvd3MgaGVyZSAqLw0KPj4gfTsNCj4+IA0KPj4gKyNkZWZpbmUg
U0laRU9GX3J0X3NpZ2ZyYW1lX3gzMglzaXplb2Yoc3RydWN0IHJ0X3NpZ2ZyYW1lX3gzMikNCj4+
ICsNCj4+ICNlbmRpZiAvKiBDT05GSUdfWDg2X1gzMl9BQkkgKi8NCj4+IA0KPj4gKyNkZWZpbmUg
U0laRU9GX3J0X3NpZ2ZyYW1lCXNpemVvZihzdHJ1Y3QgcnRfc2lnZnJhbWUpDQo+PiArDQo+PiAr
I2Vsc2UNCj4+ICsNCj4+ICsjZGVmaW5lIFNJWkVPRl9ydF9zaWdmcmFtZQkwDQo+PiArDQo+PiAj
ZW5kaWYgLyogQ09ORklHX1g4Nl82NCAqLw0KPj4gDQo+PiArI2lmbmRlZiBTSVpFT0ZfcnRfc2ln
ZnJhbWVfeDMyDQo+PiArI2RlZmluZSBTSVpFT0ZfcnRfc2lnZnJhbWVfeDMyCTANCj4+ICsjZW5k
aWYNCj4gDQo+IFRob3NlIGFyZSBkZWZpbmVkIGhlcmUgdG8gYmUgdXNlZCBpbiBvbmx5IG9uZSBw
bGFjZSAtDQo+IGluaXRfc2lnZnJhbWVfc2l6ZSgpIC0gd2hlcmUgdGhlcmUgYWxyZWFkeSBpcyBp
ZmRlZmZlcnkuIEp1c3QgdXNlIHRoZQ0KPiBub3JtYWwgc2l6ZW9mKCkgb3BlcmF0b3IgdGhlcmUg
aW5zdGVhZCBvZiBhZGRpbmcgbW9yZSBndW5rIGhlcmUuDQoNClsgSnVzdCB3YW50IHRvIGNsYXJp
ZnkgeW91ciBjb21tZW50LiBdDQoNCkFkbWl0dGVkbHksIHRoaXMgaXMgYW4gKHVnbHkpIHdvcmth
cm91bmQgdG8gYXZvaWQgY29tcGlsZSBlcnJvcnMuDQoNCkUuZy4gd2hlbiBjb2RlIGlzIHdyaXR0
ZW4gbGlrZSB0aGlzIGluIHRoZSBmdW5jdGlvbjoNCg0KCWlmIChJU19FTkFCTEVEKENPTkZJR19Y
ODZfWDMyX0FCSSkpDQoJCXNpemUgPSBtYXgoc2l6ZSwgc2l6ZW9mKHN0cnVjdCBydF9zaWdmcmFt
ZV94MzIpKTsNCg0KYW5kIGNvbXBpbGUgd2l0aCBDT05GSUdfWDg2X1gzMl9BQkk9biwgZ290IHN1
Y2ggYSBtZXNzYWdlOg0KDQoJImludmFsaWQgYXBwbGljYXRpb24gb2YgJ3NpemVvZicgdG8gaW5j
b21wbGV0ZSB0eXBlICdzdHJ1Y3QNCglzaWdmcmFtZV9pYTMy4oCZIg0KDQpXaGlsZSB0aGUgY29k
aW5nLXN0eWxlIGRvYyBbMV0gc2VlbXMgdG8gbWVudGlvbiB0aGlzOg0KDQogICAiSG93ZXZlciwg
dGhpcyBhcHByb2FjaCBzdGlsbCBhbGxvd3MgdGhlIEMgY29tcGlsZXIgdG8gc2VlIHRoZQ0KICAg
IGNvZGUgaW5zaWRlIHRoZSBibG9jaywgYW5kIGNoZWNrIGl0IGZvciBjb3JyZWN0bmVzcyAoc3lu
dGF4LCANCiAgICB0eXBlcywgc3ltYm9sIHJlZmVyZW5jZXMsIGV0YykuIFRodXMsIHlvdSBzdGls
bCBoYXZlIHRvIHVzZSBhbiANCiAgICAjaWZkZWYgaWYgdGhlIGNvZGUgaW5zaWRlIHRoZSBibG9j
ayByZWZlcmVuY2VzIHN5bWJvbHMgdGhhdCANCiAgICB3aWxsIG5vdCBleGlzdCBpZiB0aGUgY29u
ZGl0aW9uIGlzIG5vdCBtZXQu4oCdDQoNCkluIGdlbmVyYWwsIHB1dHRpbmcgI2lmZGVmIGluIGEg
QyBmaWxlIGlzIGFkdmlzZWQgdG8gYXZvaWQuIEkgd29uZGVyDQp3aGV0aGVyIGl0IGlzIG9rYXkg
dG8gaW5jbHVkZSAjaWZkZWYgaW4gdGhlIEMgZmlsZSBpbiB0aGlzIGNhc2UuDQoNClRoYW5rcywN
CkNoYW5nDQoNClsxXSBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y1LjkvcHJvY2Vz
cy9jb2Rpbmctc3R5bGUuaHRtbA==
