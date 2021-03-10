Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57839334313
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 17:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhCJQbp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 11:31:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:45617 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhCJQbO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 11:31:14 -0500
IronPort-SDR: O+2BDfhOaY7LywffPWYNpgu2tMmA4pbKlhFf58iOxIlm0u7GlzS5G0PYLMyO48LbnGfQrZdOSf
 HTsOk6OKVzYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175610436"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="175610436"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:31:12 -0800
IronPort-SDR: ipDL9XX35VKOh4+Lhm8L7k1nDMppJNh3MBeQ3WlpL5xuG97wsMmGGAK77PRHyjShX4DMseODnm
 dK3zDEWEoPEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="403738730"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2021 08:31:12 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 08:31:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Mar 2021 08:31:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Mar 2021 08:31:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaFrWkImRfprdxiko8cCEHSYrqGZENhUGbaLTbKkkZvPOTZ4Vzlmc+y9K4Gysb4VadABcPg5R/FhE2QaXogodDIPPazPFKL195vclp3TjYRF/ufNfapq69j8mt6O+de7UwgVHU0Tz4nY2U8ObrSMXCeLSQtlk3KeZmw7lagLfdjMk3cEIrWOJsK37rMnzdo1zclZRxYvZvHN/bDsaSDpU19ExilghSqDFSOfeneHTxUfF5BQqq/ERH2u9fNjMGrJegV9oXmUqNCOkZD3MJVmGvkcPRA5FS3R6gEDIMZphCOE8OYUJAAlq5JmRN+ihQdAMlHnfx7atORSWp3urz5NYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXWQIcDm4DWuLOSplYrhE6SsPuVEiTIWJO/5Z7rxLwM=;
 b=NEIMvv3Y9rQ0JfRlE0AtdO7WT/FHx7/Rhkmf/5hYfsgvOpzTwZ/pkA0r1R+Sbp3AeMxKFnDjnP6ksDjIzG1+c40Yhnc2jQXBuALVaWn3Vtb10VIo5E3A9tM1ORQ5yG4VeaWdlDRTvzyZZw0SAkGFyzZfSlqBSy3JipwQsWhg+X3z7Uf/eLSBsS1pcvchjKeorUNeeji6bbi+3f/3yTXjI0p9yUn9+LbYJzFNWe5O76D/ZtDifBcrOnDdR3xGIQhRDpYpkiD4CnF2CPeunybfl5TjVI7rwbSbTfVBG2wQSANwKLLJ2mshbpw/BG85odO/cx62DwTaVQnAxWaO89MFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXWQIcDm4DWuLOSplYrhE6SsPuVEiTIWJO/5Z7rxLwM=;
 b=xPi5vvoow9oJZXHdukWJrfLyN6nXuetT/wL0n/9f4hjmcY1YP5FOK0ZaNva7a/N/oQC5ZjHVHCutinSH5aEgqINhq4V+5s7ugZ/LxEgnx2lat0wLNEo4TySzeOuUot0JmgLEAGFdthm4gTVw38WNJQhwAUbCYvgYu6bXGneloMI=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5205.namprd11.prod.outlook.com (2603:10b6:510:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Wed, 10 Mar
 2021 16:31:07 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 16:31:07 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/6] uapi: Define the aux vector AT_MINSIGSTKSZ
Thread-Topic: [PATCH v6 1/6] uapi: Define the aux vector AT_MINSIGSTKSZ
Thread-Index: AQHXDSqNBLUvGhvL40KOmwSMZEutdKpvgmGAgA340wA=
Date:   Wed, 10 Mar 2021 16:31:07 +0000
Message-ID: <96967F18-2856-46AE-A2AB-A36BBBCD999C@intel.com>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
 <20210227165911.32757-2-chang.seok.bae@intel.com>
 <20210301190909.GF32622@zn.tnic>
In-Reply-To: <20210301190909.GF32622@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb518002-1018-4b01-ff2c-08d8e3e1e82e
x-ms-traffictypediagnostic: PH0PR11MB5205:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB520507918657639227879CC5D8919@PH0PR11MB5205.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPObIGWuyOtY5ADKbXLoaVAwOFY0wFlmSqoslZH/TYaPHbG8ye0rR6mSN6Stg7V6djLEgXH/cIk4ijeP146R4LpG2c0inQR5Z/hp3iYoTVEQi3zh+KT7CpVqM6qk7P1oeJAq9gRFAQ8qlZNZhp/r1IVbeynyJidG1xlrBgsqTaQ2VwEp6IlbGScaePVk4yGtHXqFe+PXzrRLBN7ho1k2qAmvQbVGtqBxmk2nvRpg4+MoD0lKLIZAJh56Aq7NOR9Yqi5N50RvtHxZOTz0GrSsUxyf+5/LPf5a7EpEY8qZAvppELRgQHU8DNkd++ErsbPV6ihjmGwKuKTD/p5PgqRY2iSzW7JIIG+yybGvnC54rq3VRfPLe6kuaJSqCpOuQQ59RpA1ZqKCOD4eJ8UNBt6qAiDCMNGKuB3FSVEo8b/rTVM3jv//m8xKz+0Y5d6OSmu7pptOzUpInmsPoZRnl3PF2wwMzwNaueHAcPXuF6e+8HNictL25bjn2W5Dp7S2F11VHEg2Fhni7tz3d1rJoXzGwye1Qctasq3Y6ajGGnn+2O9X0RMXT9JdL7QwmiKRO7Hprm9dLiZCtMmnOl1XSuswEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(7416002)(53546011)(186003)(6512007)(316002)(33656002)(36756003)(26005)(71200400001)(66556008)(64756008)(76116006)(66446008)(2906002)(4326008)(8676002)(66476007)(6486002)(54906003)(66946007)(8936002)(478600001)(5660300002)(6506007)(6916009)(4744005)(86362001)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NzZKR21CZFRxcXdIbmVlbnFhN0Q0YkloY2pQL2doenR5QjJaL2dacHhtNENw?=
 =?utf-8?B?NU5zTVRBWmtLa3ZKR1lSMEtRMjB0Ym5xeDVTVGoyenlrY0JyTE10ZnF6SmQ4?=
 =?utf-8?B?SnV0YTBadHdvdGx2eWhGeVlXT2tSQzVFb01zcjUzK3V2MlRSRVJNbDZoZEp2?=
 =?utf-8?B?OEJkb2ttR2NkTGM1L0ZXQ1huUzhwOGwwb214OFYzVU5laVlRYXhPdkJTSElw?=
 =?utf-8?B?Mm4vclhudTFCdnMyV0pvaUl3WkhRc1p2eVpaZ1dabjZwUnpIQ2xSTk9iTjFV?=
 =?utf-8?B?TVRUTXN3OC9LNUR3aTJxN2I1bjBpVWdteklIelRjY05CTE5RU2FTUTBuMys3?=
 =?utf-8?B?RDJMdXVSZXp4WkFSV05uTDFTZ29KVVlIVWdoMEVpSlJyTEZtcGxBK3hwTSth?=
 =?utf-8?B?aUVyWWNRMnhUVGhkcUt2dHF0Y3d4SThQYm1tL2R4MWdVbHR0SkRsdCtsTEhW?=
 =?utf-8?B?eDU1Wk9jZERxcHZiYUZTNEZndXd0Q2FTaHZtaTB0TWJLVVQ0WWxqT2EzTUls?=
 =?utf-8?B?KzdiWkdvRk9xeUtnNlhtUjdiUzY4Yyt2eUI1QWZ4SEYvRGtPcHYvL01uTklz?=
 =?utf-8?B?WWNqQWdRL1M1MlJkb25ab3FtS3lyeVhDelVsaTVua085c05TRHlVZmNCSkNa?=
 =?utf-8?B?TUhabUorVVJ6dzZvdE9XYWNyUkNNRDVEdUdoaXc1QlkvTGVhbkZEMkxLcXJz?=
 =?utf-8?B?QllVUHg1SjJ3Rm5Fa1MvYy9MZ21hczBmVERzRVFVUktKK0NiUkRtb3BhOXI5?=
 =?utf-8?B?dFVPQWwzQUF6SVhNTlNpOTdydXlxdk5qekZOV2hnWFQzMmNaK1RhMndqVnFR?=
 =?utf-8?B?cmIvWEhhT09uU3FpMlBmNlNSOStOTnhjRFRlaGROeXFPWGpUZlpVd3ljcUtl?=
 =?utf-8?B?eGtidlF4YjhseGZhdGJkYXhYS3Y0aXZJOTBNNmUrS1JjdmN5eTBPazR6UFMy?=
 =?utf-8?B?T24xTVU3YS8zaDI3Wm93c3NSS1Z0NmtNVTJBNjRwcE5ETndnSHhLaW5sMXBv?=
 =?utf-8?B?Q0RtV0tWM2VWb3pXcER5ZkROemp5SHo2dmNJRE1TTjZrdjgyN0VBRi81Qlpn?=
 =?utf-8?B?bjMzOUZOaXUzREQvVEl6eEJZR04zTFF4OUMzRHd4OG5TMTZNb0ZLYTVIZXRT?=
 =?utf-8?B?cmNSbFVOTHlYbGFOUE9XOUpZR0ROeTdpanZXUE9uZm9pV0V2LzNLc0dYZVdV?=
 =?utf-8?B?QWpEUkdYSTlCL1FhR3dkOWZBOW1LbE12RTM3NU5aQ3REVG45Q0FWanlETFZW?=
 =?utf-8?B?cFNrYXo2RkdkNDExYUF6WDBRUXhYSmZkckw2V2dqL2FabnZtUXQveDNZb2c1?=
 =?utf-8?B?Um1KZVNuYmltRmhyTE1uR05Kdnh2L0o2NU9EZmtIV05raVg4ODlaUGdYcTZF?=
 =?utf-8?B?ek4yaStkMGhFNEorY2tCeCtHOEJFMzU5K2JaVDVDTm5ucUsva1lFVVhINkVr?=
 =?utf-8?B?cVJhWmpHZG0vZ285L0tzbVZqNUc4a29WVmZvdm01Y05yS1RKYy9SajJmREhV?=
 =?utf-8?B?SUxxckhvelY4bGl1ZjdpYytTUklzZm1iRExlUGVvQ1BvQkFQaHVPY29uc2R4?=
 =?utf-8?B?cTc3NjdZSzhVcWFXVzJGczN0eHdjcDk5QXg4azJNUW8rdU8wZVdJaFhRZlBt?=
 =?utf-8?B?WFZqVkJQdEU2eTNnUEQwbEJrQVJWUWxPL2w1eEYzUU9MeDlBbjNCdmlCd2Fh?=
 =?utf-8?B?T0llQXRTWFRQSWpQcUJFYlJOTk8wbzZDZFhNbFVQMFFYRWthaUFnNHcwRS8r?=
 =?utf-8?Q?MyAfz/Lz67vyVzjbi1VH0OvtOqvEwlWydqy4QVP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <736B0DA35C39D149A198CC07660B2446@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb518002-1018-4b01-ff2c-08d8e3e1e82e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 16:31:07.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2huCZJ87xIM/9EjXeE+NTwoXfg6msLz1v+2ePtpx/w7DrbR4i8AvJ1MmZh+wyvy4tPexwUJgr1C+Dv5uweTMW1AiLGNwAKtO3AAflAwe6Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5205
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTWFyIDEsIDIwMjEsIGF0IDExOjA5LCBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+IHdy
b3RlOg0KPiBPbiBTYXQsIEZlYiAyNywgMjAyMSBhdCAwODo1OTowNkFNIC0wODAwLCBDaGFuZyBT
LiBCYWUgd3JvdGU6DQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYXV4
dmVjLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYXV4dmVjLmgNCj4+IGluZGV4IGFiZTVmMmI2NTgx
Yi4uMTViZTk4Yzc1MTc0IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2F1eHZl
Yy5oDQo+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYXV4dmVjLmgNCj4+IEBAIC0zMyw1ICsz
Myw4IEBADQo+PiANCj4+ICNkZWZpbmUgQVRfRVhFQ0ZOICAzMQkvKiBmaWxlbmFtZSBvZiBwcm9n
cmFtICovDQo+PiANCj4+ICsjaWZuZGVmIEFUX01JTlNJR1NUS1NaDQo+PiArI2RlZmluZSBBVF9N
SU5TSUdTVEtTWgk1MQkvKiBzdGFjayBuZWVkZWQgZm9yIHNpZ25hbCBkZWxpdmVyeSAgKi8NCj4g
DQo+IEkga25vdyBnbGliYydzIGNvbW1lbnQgc2F5cyBhIHNpbWlsYXIgdGhpbmcgYnV0IHRoZSBj
b3JyZWN0IHRoaW5nIHRvIHNheQ0KPiBoZXJlIHNob3VsZCBiZSAibWluaW1hbCBzdGFjayBzaXpl
IGZvciBzaWduYWwgZGVsaXZlcnkiIG9yIHNvLiBFdmVuIHRoZQ0KPiB2YXJpYWJsZSBuYW1lIGFs
bHVkZXMgdG8gdGhhdCB0b28uDQoNClllYWgsIHlvdeKAmXJlIHJpZ2h0Lg0KDQpUaGFua3MsDQpD
aGFuZw==
