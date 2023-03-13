Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6346B8617
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCMXcJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Mar 2023 19:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCMXcI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2023 19:32:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D0302AA;
        Mon, 13 Mar 2023 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678750326; x=1710286326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5ds/9rNVCCfo36o+DLvOVaHl1IkS4O1SoIM4bYnQPcE=;
  b=lhM3WCet7Px09i8LVnnmh9l7SimFB03FDq/F5uVWlWuO03fxptb1VRaF
   1B4afw3jvfNjC8fBooiK+m/E2vx5PJt7TnTPoPE+XGfi+r5TJRwnTyD8L
   FLuCtCRglaTGlaVHg7guQjBg0ZjtT7N+B5RQZHAcNRkL6QUjjKP5x9uuC
   NzV/NAN7CJgVUP3Vvz5f4qPhnzv4cQ6AyN/jhhzNRsX/+DcfzJhJgFcts
   x6C9+wuEX1D+hQ32EZsAT/f0lITVwzqz6dnnyMT/CjlXDN5BFKpB2HQOm
   0ksAgW3luZ/bSJeveiJ7wKpZRM7W0LV9gJPrstIOO8cntfRhP8XjFZFXW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399875094"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="399875094"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 16:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="672093017"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="672093017"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2023 16:32:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 16:32:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 16:32:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 16:32:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMruw21ct4KvlVYWe+0QXQxOq/LS+ri+lZq41V3fsItxL/FYouKe3ff82+/gMmhN9NofkHs5b79kyy5oWZgOEV5pi4CRfHcZi27n0naPNvQFPdX+jQT954DG+wMzAHyxcj3Moskm5ZpvbGneRrM1HFBYw/Za+sRbXQzAxso5fVgaN2XhhnD/R8nHRGsBQGq3c23VTACJwTu/A/93Z9oaoEPBVr/yTnnkZAp0OIH5pBcO3ZRrnfO/mpwCTYwxUlIifs4q803TpI//FtHUQhKSkbaf2F0cq8F8k9wx/N8IuCuvB6kNraC3BFLWXTpiecXsN+kP6Z5udJ7X1v0WrCmNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ds/9rNVCCfo36o+DLvOVaHl1IkS4O1SoIM4bYnQPcE=;
 b=WodEzrc7Czt7E4oVy3UdLdb7Uk9SMWvMySFITJRYbGFuxiOTpIxoE+Hbm+suf1J4CeYp/sajqUMPhersaZVMyR+VM2U5oyIk9oAyVnsj22ZzZciYsN+sQqV59U2HoXNXzft9u64oEOhaLrWKU0SxFlJvwrBQt6tQuF9ySPHZg4fjEh2UVGkwzUSCAlBLgwLD3BmbNKoYuwMeoPXacbUgmnsdoJ03OnPuY9TjqbZ+Mt+QZvCjtSNfftR5n7e4JHYMgYKBK2IOv7w8/7Xoa8zD9FgKDqRyMvZM2TwSohparSXFz+icvJJSt+ND4oju60j2yFCjR/O68ypO3GCqikw6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 23:32:00 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 23:32:00 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 38/41] x86/fpu: Add helper for initing features
Thread-Topic: [PATCH v7 38/41] x86/fpu: Add helper for initing features
Thread-Index: AQHZSvtH//l8GkMHSEuT277fH1R14q71m1QAgAJ6WACAAItGgIAAVasAgAAQ2oCAAGqTgA==
Date:   Mon, 13 Mar 2023 23:31:59 +0000
Message-ID: <46894d1c79815739faeffa657dadbabaee437068.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-39-rick.p.edgecombe@intel.com>
         <ZAx6Egh6U5SCZEby@zn.tnic>
         <3385eaf888f4178607ce4621ae2103d08ba79994.camel@intel.com>
         <20230313110335.GAZA8DB6PNSMGOGHpw@fat_crate.local>
         <04f821e6d4a8a736e6df2eb73ce811022cd42537.camel@intel.com>
         <20230313171031.GEZA9ZB01FRjCo98pr@fat_crate.local>
In-Reply-To: <20230313171031.GEZA9ZB01FRjCo98pr@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB7989:EE_
x-ms-office365-filtering-correlation-id: 1e8a415e-614c-44ca-5a0f-08db241b245b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYNnog+e4r8mwCwQiDFVAKiD1PCWEn4glLCZDS1n4J2MUjaG6hdHtEZNDnqhIyS4+jSe4ITHPbXVX7AblXfrNOia7ehEpfm1w8pGJYJEKpmzNuM1xDGLzvl+Ewmxyv+SSiGc6986FAr8aEGNy0L7v5A1UuYHYFsdK1yOSvYlcNJ9Aa89cOdnirE7dwW2YEdlgS8fuzrLKEZSDCXDvenW6h3Xe1AM/rgf7gAde9MNuynR40kyRe+XzMv5IRiaOAsn2hBpkK5BgXYISmPWrablX0NzxDgEBRUhBCjon6uygGOZiH+lapyM09VMXcKNLECuF3H9m9wHauSgE40E+z95RxG2BGJZUfH83s+NaoyoCm2Rs8fBOQUOkic3c37sEe3fB0s+KSY7C+HbRAIuYwPMe+4foH0r6Zprw+4a5TIZO44G/8rbSuNs5ORVQbWuff8OJ6aB+J+dZ7r9TOuLpcfsEuoConDLKKBysHR/p98h7HRqsaM4zGhFQ6TrPV+hUrUIPM/OrG0iBOgG3ZaPs1qpyrhOhxLVyO7OtOKDRaPeObIjDSJnPOBEEhGX6htC2Ec5uW4X0TBwC3odYlbkBXtzmm51LhM98dY+7fS2fRmvqzvLqmgqbNdAh9ZwW8eBPExAJY8E0LtMtLD6WU33EIZ1Rvo15xZgmYW72pTMIwnBFWGWlambou41kHx2ejTqKPNTD7YR/Ex0CGc6dERNC4lG6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(7406005)(8936002)(6916009)(7416002)(5660300002)(2616005)(6512007)(41300700001)(6506007)(186003)(4326008)(26005)(86362001)(36756003)(2906002)(4744005)(83380400001)(66946007)(66446008)(76116006)(8676002)(6486002)(91956017)(316002)(71200400001)(66556008)(54906003)(478600001)(66476007)(38070700005)(122000001)(38100700002)(64756008)(82960400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmhVdUc5ZG8yQU5XcU1MS1Q0Q05yOUpYQU5mVGFGRklyNTRjWTNGRmhlelNR?=
 =?utf-8?B?ejYzRm5TWmltVWt6bmZNUmNxWlhWaEZMMnpGU1JUbHBXWDg5QmtFV3UyUnFw?=
 =?utf-8?B?dVlKSWFhRG94VjV4UVVGaDhpTWc1M043Mk0xZ2tYSGpuL3hhaW5GczNKRnZ5?=
 =?utf-8?B?ekdwSm02ZFRkbjFYSG1qbVVBUDY1bWI5Qm1iYW1WcGU4QTNKaUtydXdncHJx?=
 =?utf-8?B?UU1DS3o1dGdVclFpYWNpTWpyWXkyR0NLeFVualZxVFE3ZDMxcDhVUjhFV3A2?=
 =?utf-8?B?Vnk3Y3RjcGc0ek9zRW4yV2pibkVmRnlUZUs2R2xRVC9nK0t5NStpWGtpYlNB?=
 =?utf-8?B?MXZycWhhK25rNEo2bnVwYkMxaUUzT1pWTGFjemZvd0p3ZXlXaFpsYkxNaFFj?=
 =?utf-8?B?Q2MrMG9VUHFaNWpQLzNrUlFUeHA2OGd2RVNjNEIyMEhTYmZpbGVVamIzTVh6?=
 =?utf-8?B?S09Bd3NWS3k3RWFhNkhRd2pGNnVCT2QyMlJFem9pMkpzdlBZNHhieE9rVi9w?=
 =?utf-8?B?ZGNydkVlUm9YbWYzVWZSS0tDMm5YWnErQ3hkcUc5cXVXaVU3NFg5R3F4cFll?=
 =?utf-8?B?TDZiY0lhQ0lLTkpTWXJjMldwZ1lHQ3F0TlYyNWxZN0M5TjlYVDkzeDBFMity?=
 =?utf-8?B?a0RWano3TjZDdHM0anhDbkNYUGEvWStNUW1PT3VCaGRpWndaVWZuRDBUZnRr?=
 =?utf-8?B?UkhLZ2VKM0FGdE9OZGMzNXRHZWhZeUZ1aElwRU51czgvcGNoMWk4c0l6MXNm?=
 =?utf-8?B?TzJXN2M1QVVNanlBZC9nWjU0Q1prQ0ptbFFSaGRWSkJCMHNva2RaSXRoNmVP?=
 =?utf-8?B?aDR4VExYTTNKODJwVm5LNXFIWUxBaEVqSVlJLzZJalpVbDFMVVpHemhNTDJ0?=
 =?utf-8?B?aU5RVXlXWTNaL3ZUcVZ0WEJublgvMEZKdlFTL0hQQU5aOWo5Z1VYRCtVcjZt?=
 =?utf-8?B?Y05oSTVyL3lwWHRkVzlzYzYxMW1tYzVlK05iOFpQSDVFSHU0b3FHdWN1NUFU?=
 =?utf-8?B?djFwM2RZK2xZcTVKMjhFSnJpdVEwQWI2Qk9TR1FSbkQ2TkZ0YlRZWFZhTXNJ?=
 =?utf-8?B?Kzk4ZERzWHBXbDI2ODFnUVFURE9GeTRTYlRvM09Kd1FtS0F5ejdhbXQxcnlJ?=
 =?utf-8?B?UHNrQUhqNGk0K21QQUw3V2NpTTM5d2l4Rlk3cnRHZzJFY3lXd3NMcEN2VFY4?=
 =?utf-8?B?ZWRtUkwxNzFFZWRjWmNMUjJKNzFJVXdPY0lRYWJrQ1grV09WNHRkLytkZjJC?=
 =?utf-8?B?YWpoTTd5TEtjVTBialFJcDNBSDM3UGJ2dmNzd0IzdTZzYm91NTAzREFPUXV0?=
 =?utf-8?B?S2tYc1RFT0UvWWQ2L3BDYm5YU3QranRVUi84emNDQ3YrbEFPeFBxODlvSjl6?=
 =?utf-8?B?SE5QL2ZrcXFZTGlWeXEwRW5zQU9RYXQ4a3FrNjRnU1M4WGg4akNhNytOK2tK?=
 =?utf-8?B?ZmZUQTZpQnJUT0F0cWUrNUZlOThGcWl3YWY1cjRBS2Z6VEJhYVF3MU5wMDFs?=
 =?utf-8?B?TDdXL2N3d1J0UnkwNCs3TDNOdkxWVmd0a1ZVUWZJL0tzODhEOU5uOHhHUnVH?=
 =?utf-8?B?d3JYTlF3VEF3N3A3N0hoQ01yL2pGSHNWQzV1V3dXUEoxalIzUVY3K0ltYjZz?=
 =?utf-8?B?djMrbzlhQTlMT2M5eWsyQ3ZjcmlYTVBqYkhmekF5TFRpVDQ4VnNOdnprS3Rl?=
 =?utf-8?B?MlR2TnNDTW9HVUdIeFF2WjllcWNvS0RtOWRMVzdoM3F5cmhaV1ErcGowdjB4?=
 =?utf-8?B?a0R6NjZVekZ2U1dvRWorWWs2R0tqQ2JWY2ZzNTZCMXZwMzk4MGN0ZjJsS3Zo?=
 =?utf-8?B?QXYzUFZ0cUErR2wrcEdDbU9NWjliZkx5QVBvbWdMcVFMMlNla2pNLzlrL1lK?=
 =?utf-8?B?NjRhK2IvU2lLWVM4alk5L1pGUUxXdTAwRC9peWdlYU1ScWdyQ1hZRzlwNmxp?=
 =?utf-8?B?bjlJdU81UmhWTitoTGhGUE5ZM1NuTnZqN0Z6cTltSnNhUmQ0VFZNYjZtcUNN?=
 =?utf-8?B?ZGp3SWtqSGxINmJadE5KUUh5MHhqRFMvOU9FeFRUM0R1ZGpDNW1QMlBTS1FE?=
 =?utf-8?B?WWg1UWlWRmVWbVBCcFFEVVpIVzliVWdUdjBvUkwxcFFNY09iYUVlYVpDVTVu?=
 =?utf-8?B?b3JKQVpuUnlDWnpmQkd3L1AybE54UjNFenVQS21SR0lqM25kMmxIUkNLUHlq?=
 =?utf-8?Q?CEwDFZE/sdmlbmja8TUegh8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6A5CF908F1036429C9A920055F7AB5B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8a415e-614c-44ca-5a0f-08db241b245b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 23:31:59.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYU1frSMZ0yuQ2ccXOPy8Nn0iPXew+3V+evpQgStdFnhxh8CUY2MJv2PiSnHcsMCiqkKbNoL9aTMPASljj+mocwgf+XknWUia8p3SAvmSeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE4OjEwICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+ID4gVGhpcyBtZWFucyB0aGF0IENFVF9VIHdpbGwgYWx3YXlzIGhhdmUgYXQgbGVhc3QgdGhl
IENFVF9TSFNUS19FTg0KPiA+IGJpdA0KPiA+IHNldCBhbmQgc28gbm90IGJlIGluIHRoZSBpbml0
IHN0YXRlLiBTbyB0aGlzIGNhbiBwcm9iYWJseSBqdXN0IHdhcm4NCj4gPiBhbmQgYmFpbCBpZiBp
dCBzZWVzIGFuIGluaXQgc3RhdGUuDQo+IA0KPiBJIGRvbid0IG1pbmQgdGhlIGFkZGl0aW9uYWwg
Y2hlY2tzIGFzIHRoaXMgaXMgYSBzZWN1cml0eSB0aGluZyBzbw0KPiBzYW5pdHkgY2hlY2tzIGFy
ZSBnb29kLCBlc3BlY2lhbGx5IGlmIHRoZXkncmUgY2hlYXAuDQo+IA0KPiBBbmQgeW91IGRvbid0
IG5lZWQgdG8gcmVpbml0IHRoZSBidWZmZXIgLSBqdXN0IHNjcmVhbSBsb3VkbHkgd2hlbg0KPiBn
ZXRfeHNhdmVfYWRkcigpDQo+IHJldHVybnMgTlVMTC4NCg0KT2ssIHdpbGwgZG8gdGhpcyBpbnN0
ZWFkIGluICJ4ODY6IEFkZCBQVFJBQ0UgaW50ZXJmYWNlIGZvciBzaGFkb3cNCnN0YWNrIi4NCg==
