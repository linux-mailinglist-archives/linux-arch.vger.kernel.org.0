Return-Path: <linux-arch+bounces-234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B67EEAA6
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 02:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DD01F23F27
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFA310F4;
	Fri, 17 Nov 2023 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyQ2yow4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76F1A8;
	Thu, 16 Nov 2023 17:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700184186; x=1731720186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ymlFB77kBZFK8rnVWHF+ALGLCQZUa3GVXoJvz6QG8ss=;
  b=eyQ2yow4D1ht0r8kqi8+qwS6xo1Vl+3GB4swCDi7FI8qXHkwGHEBGrZx
   iKqJDtf22zPIAtEqvVckfcK3pKw8q2vztesCS8tVwDh6lsyhyYGnSgNB4
   yrQCqfqRGBFBEtRPfyiwUqHAHJ4FAMgoNFZyYp3twbi9q184HJmu/k3FJ
   DSHaJVgnxAGupY+0Gmae+4VHbpZURBpmOWfQM9lyP9CSbi1T9D5+o0hEq
   pSEC5EfzPTj8v6lgiARGF2rG/W1VNx3Tx4oT23FoKj/N9+ki7e9Ccby7/
   7/Eo+qc/TmpIj8Z/Zqkb/AWHzEH1oYUHQ/ekMdHf5rveesvkMHR/0f08G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="394067706"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="394067706"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 17:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="6878154"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 17:23:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 17:23:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 17:23:04 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 17:23:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS4RXSC+Px9Mp1sNisipKhWem26yUJ1X3nBf9uDjZfk4qwdqQvE0oGi6tNadSEQNujGgV875rs5dW7KWlgGIjaFEpnailugF1BT6AXxA0VpMKBAkv53vVhwZYVCvIyKIrb7DgFZv2L62twlFjxzT0Q5hGTEvTWpq+JQF+509SmUKhnHyE/doFuDfaA2F7XZnG/78R58aGmZsgpxRS56x4sjZI5BDGE9vdd5VeX/rcLCIHsDavwiSNHtiMy1ZXhXw3INLeEPnoBNlvzNnp0Eo8ag9hrZQg68Tn+QqCs4IRmi8TowV7y6mwfSYWWuDQr2J+NJ99Xhc59vQScd/SjeLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymlFB77kBZFK8rnVWHF+ALGLCQZUa3GVXoJvz6QG8ss=;
 b=fuqkiwu3Mo5RJ4auk6DzuY1aSfPdtUSa+zrz5a9BSkvaa2fV8r5KrFPIBKlgd8KAGqOrQtl4E3/sWxz8I4rJ2giZpYMuSvCUp5BAbVaNspV9eA2CQyH98yvdINGOKAW+Q7rHb4lDSJoHvQgVJL7Nx8sTx+nwdUjoEGXGQntGHrf+DqzErwFrxiUlyo4p1rVEkxohcluEYYGCR16npMa9DkBWJOPl/WIhGThZ1woc+okoqWbBcll6GozI3YVBkjMqjXzboQwNVC7C1oNBJlVUTQrPIXAPmfSBy6KOXppKcFV+DURfRqtRvojztDHDj94ef8m27yLAgk8ybEVtd5+gfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 01:22:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Fri, 17 Nov 2023
 01:22:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "xry111@xry111.site" <xry111@xry111.site>, "andrealmeid@igalia.com"
	<andrealmeid@igalia.com>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "libc-alpha@sourceware.org"
	<libc-alpha@sourceware.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
Thread-Topic: Several tst-robust* tests time out with recent Linux kernel
Thread-Index: AQHaF2CkpUD9xWdoIUy/PHM3o7TKCbB7EvcAgAD1BQCAAbJyAA==
Date: Fri, 17 Nov 2023 01:22:56 +0000
Message-ID: <158f6a47727a40c163e3fa6041a24388549c68f2.camel@intel.com>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
	 <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
	 <20231114153100.GY8262@noisy.programming.kicks-ass.net>
	 <20231114154017.GI4779@noisy.programming.kicks-ass.net>
	 <87ttpowajb.fsf@oldenburg.str.redhat.com>
	 <20231114201402.GA25315@noisy.programming.kicks-ass.net>
	 <822f3a867e5661ce61cea075a00ce04a4e4733f3.camel@intel.com>
	 <20231115085102.GY3818@noisy.programming.kicks-ass.net>
	 <564119521b61b5a38f9bdfe6c7a41fcbb07049c9.camel@intel.com>
In-Reply-To: <564119521b61b5a38f9bdfe6c7a41fcbb07049c9.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7380:EE_
x-ms-office365-filtering-correlation-id: 64693b6e-abc3-4033-f13e-08dbe70bbae7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bx1XD0kddUN7Fiin69H9+ETrKJ1/Esjf0IQzFVF8UWIFo131yz/JT38ixXRRSqFcA0940sCrclA4h1upfNR++9d38exckidfMyshWgS8LJM93c+G225kYSlcdZjhLVLdfRrhOKk7i4Tr7Ho1xMSNFlAskIq0yihpJQVVNXJ3mCp/COn2uUt6ptTI30Si33n/QH1RXfkwfaTtDpuBmg2X2Su2QFvdb/ikP7dW/Jr8toRSiZujUFJ4zM58XJ8bjXv8HIalJXUKaahg8HJ7J1oesgAJhREQkPMVgWlHh4OSJ+SWdfkyJyU6WTleK6zsUUJ/m6b3fn54afPSnTiy/0N1eH91bvcSTAEWvsipb9iWHbELRagmytjy63i+EeJYWh/A6n9m1ngrQd2KQ8oLT7Q2DEuIAZyCtKY6OgP21Dcq1WsCzharQwPSBhefJCqN1y5qYARTSeZmfd0q/s5SSaioUSFPeRtGaehprcivUSAgxr9Ll4MrD2inLhI+8jTtrxJ6KyW7LsC+BTN4vypO10MvC6o4m/XLzHy11qzwwV3WJmTaDxVSMUaX2rNLp/9Ko0Io9LWCHVd0R7ZXimvN3kxL0VTeAaB+jgzZ81Es2D5wqJAzW6PBkluxSesyg4V1C23VV/zQpI5bCYL0WeF3u4jirA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(71200400001)(122000001)(83380400001)(2616005)(6512007)(6506007)(82960400001)(26005)(316002)(38100700002)(91956017)(76116006)(6916009)(54906003)(66556008)(66476007)(66446008)(64756008)(66946007)(38070700009)(4744005)(7416002)(5660300002)(2906002)(41300700001)(86362001)(8936002)(4326008)(8676002)(36756003)(478600001)(966005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0VqaE96VStiZEpoTWtqbXZ4N3E5SzAwcFdWZElvTDg2TGRYMGN0NXJYZGJ4?=
 =?utf-8?B?N1VBNkJvVFl0ek8zaE4rV043Zzc1Tms4dG1RMW1vbjBJUDlJUXJnZmxRWHc5?=
 =?utf-8?B?c01vRkpsb3pGL0kxUlFtUGE4N0lWSkZoMWNzM0lTVlE5QmdIalNWbTQvZjVT?=
 =?utf-8?B?RXc5Vm1vd1RXbGNTc2VER1Z4a2dQTFU4V3huckpncVVyd3RRanlhK1BXTjRn?=
 =?utf-8?B?bkVhN0pRQWltc3BDRXE3MEVuSG0zZk9YandYVWZncm9zRGhmTFRnbXcvMzdr?=
 =?utf-8?B?YnlQR0JVRVFGWjBtNmdrbW5JbzB1Nk1nM3R5MC9jWGRXbm4zazM0UVpNSVlv?=
 =?utf-8?B?SDZHeDFBci9xNjFDakhMZzdDMjhqUU0yVFVyclRHcXk4T2k2NWxLb0lBYVZE?=
 =?utf-8?B?UkFHZFpxNGVuRUE2bkVjQ3Z6b1pLNjJLZGtDWk9LZ1ZBVUhvOGRmVlpVejE3?=
 =?utf-8?B?aisxUGZFcDRXd0h2LzdVWUtwYXNyRDRsWUxrSVEyejBydEdjOWZGczRuSXR1?=
 =?utf-8?B?WGZsVjFuWFg5WWVJZmthRmd2SUhOTXpnQ2pSby9DbnRmZ041cXNHOUk0d0dK?=
 =?utf-8?B?RGx4LzBHU3N6ZWxzTTZtUzE3RnVGbFJvZnEyV3MyNnplc3FMOVFuaDVTNFJE?=
 =?utf-8?B?Z1l4S2pzQ0tZM0ViOEVYTDR3dGdtQURwSEtmTWxhU2JDY0NmVGRra2R2NlFo?=
 =?utf-8?B?cGZHUHVMYWd1ZTlsRFQ0bVNQSlVNQU9DOXBvaThIeUxOUVRmRmpIZWtQNm40?=
 =?utf-8?B?NUNkb2J3U2U5SVd3dnNPSFhXd1V2dmtIT041NC9mQU5vMnhRSDdYZmVFWld4?=
 =?utf-8?B?RTNjU0g3L1l0dHMyZWZvRE85QVhHVFhXSnh0UHcwMzQ5UUtJczJxTXlaUVJT?=
 =?utf-8?B?MkJVNCtKOWpmRGVzUmI1NkJkbDc4QUpsM3JFRWlNTkFPVk96dnhrV0M3MVl3?=
 =?utf-8?B?VTg4KzljTzVSdW1xOFZRUHpGcXpkWHIxVHJnVkdDb0dXZWNYUmdKWnowS1FM?=
 =?utf-8?B?TzJmQmdva2dXbktsQXZ5a005b0JkZXFIS2lDMmExcW9MaUhSTXZKRWNkOEZm?=
 =?utf-8?B?RFlYQUNGU3I3WTVUN3M4a1BMMkw5dy96VHE4M0ZHN1kremE4Sm9HbmFKZ3V5?=
 =?utf-8?B?WXZTbEQzYklMQVVlUmdoaW5xSFI5NE5VcjhmaXZ0Wnl2Wjh3YzROc2JNd1I3?=
 =?utf-8?B?WitsVnpXNHJxWGhXTzRSNlJ5S2pSaU1RdS9MSzZsY2NvcFBzRVFFM2toY200?=
 =?utf-8?B?R1llNEkyRThTc2ZYckM0LzFieVA1c25UVjJWUHNtUktHTXI1R25nQTQ1amJh?=
 =?utf-8?B?RC9SbXRvR3lxaDJHdG01dFIwcWtYMERPdGY0S0RMYXVOaVplckdjYTRUK25w?=
 =?utf-8?B?Q3VrZno0OEVkdXd5NWs4RDd2YkhLdXg1YTZUUDdDVlREdzZVOC9iWjdlK3hE?=
 =?utf-8?B?UEZoMjlNVlk4MVpDRlU4eVdqeUxwR0FVQm9HVlFjck00SHBDS0xDZnZUbTNl?=
 =?utf-8?B?Y1YzQ0N0R1hHaGVMYkl5M0Q2K05YNEtWV3BPVGlLclJHTHJwODJET2d1a3RB?=
 =?utf-8?B?bzRvSTREYWVxQXFaSEFxQlRXWnZXU0xJekhuOGI1WmVNOUwzbXR1YS9qSTFJ?=
 =?utf-8?B?Zk52OW4xaUZ5Q1lMR012YzR1eVAxb1J0RFJnbVhBbDRIWjkxS2VnZkZ3MHJl?=
 =?utf-8?B?aDYwSHlEMXIxVWZuVzFkaVZCZ0d2TnhxRERaczl4NmcxUFhUVXIzVVVpbFRq?=
 =?utf-8?B?bEZXcml1cWhTU1Q5ek1MbWZtaVdTUlNZbXE1NGhNMVBjaGJwL1dEalkvck1w?=
 =?utf-8?B?UHQwVnhDVVRMT3VZUCtKcUp4RTFUbzF0V2xMRDFOeHFIM2dxV0JuZEhKQklZ?=
 =?utf-8?B?VFBSbDNjNDlvcmhDTnphdmNHRjkwQzZ6Mzg1aks3bUJGZ2lRK2lKRVlXWWpu?=
 =?utf-8?B?Yi9NRGgvMldFUU9aVGI2eGdxc3o5ZkhWMjdwSi9oQWUveFhkd0VCZTVOYVJC?=
 =?utf-8?B?Z2h2RUNRTi9jZVhpRWxMNE9KQzc2T3h6cXFycGhqWEswOUxRaHBmWHhlSTc0?=
 =?utf-8?B?MzRYRHEzY3l1RldvcmpnakUzMjcwZ3JGSDJUT1ZFUGJuVDEzYWFsS3pVRW96?=
 =?utf-8?B?eE1CWVZraEMyUGwrS0o0S3kxUEZ6Q1pxUXZobXFiUUFCMjJIYUhWNDZmbWZK?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A52C80FD39610A4782718AEC8C20E70C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64693b6e-abc3-4033-f13e-08dbe70bbae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:22:56.9294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EESyr/E8aqWfg66mPcnb8cRUwRUw3lP/kNWTL5WbuB4aYDs/RpZkterEEVHut4CsRYUYMeSPYDpTM3boUm7nUbWeiwMJYaDsu5bdD26khQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
X-OriginatorOrg: intel.com

QSBiaXQgbW9yZSBpbmZvLi4uDQoNClRoZSBlcnJvciByZXR1cm5lZCB0byB1c2Vyc3BhY2UgaXMg
b3JpZ2luYXRpbmcgZnJvbToNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9i
L21hc3Rlci9rZXJuZWwvZnV0ZXgvcGkuYyNMMjk1DQoNCid1dmFsJyBpcyBvZnRlbiB6ZXJvIGlu
IHRoYXQgZXJyb3IgY2FzZSwgYnV0IHNvbWV0aW1lcyBqdXN0IGENCm1pc21hdGNoaW5nIHZhbHVl
IGxpa2U6IHV2YWw9MHg1NjcsIHRhc2tfcGlkX3ZucigpPTB4NTY0DQoNCg0KRGVwZW5kaW5nIG9u
IHRoZSBudW1iZXIgb2YgQ1BVcyB0aGUgVk0gaXMgcnVubmluZyBvbiBpdCByZXByb2R1Y2VzIG9y
DQpub3QuIFdoZW4gaXQgZG9lcyByZXByb2R1Y2UsIHRoZSBuZXdseSBhZGRlZCBwYXRoIGhlcmUg
aXMgdGFrZW46DQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIv
a2VybmVsL2Z1dGV4L3BpLmMjTDExODUNClRoZSBwYXRoIGlzIHRha2VuIGEgbG90IGR1cmluZyB0
aGUgdGVzdCwgc29tZXRpbWVzID40MDAgdGltZXMgYmVmb3JlDQp0aGUgYWJvdmUgbGlua2VkIGVy
cm9yIGlzIGdlbmVyYXRlZCBkdXJpbmcgdGhlIHN5c2NhbGwuIFdoZW4gaXQgZG9lc24ndA0KcmVw
cm9kdWNlLCBJIG5ldmVyIHNhdyB0aGF0IG5ldyBwYXRoIHRha2VuLg0KDQpNb3JlIHByaW50IHN0
YXRlbWVudHMgbWFrZSB0aGUgcmVwcm9kdWN0aW9uIGxlc3MgcmVsaWFibGUsIHNvIGl0IGRvZXMN
CnNlZW0gdG8gaGF2ZSBhIHJhY2UgaW4gdGhlIG1peCBhdCBsZWFzdCBzb21ld2hhdC4gT3RoZXJ3
aXNlLCBJIGhhdmVuJ3QNCnRyaWVkIHRvIHVuZGVyc3RhbmQgd2hhdCBpcyBnb2luZyBvbiBoZXJl
IHdpdGggYWxsIHRoaXMgaGlnaHdpcmUNCmxvY2tpbmcuDQoNCkhvcGUgaXQgaGVscHMuDQo=

