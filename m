Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC923646429
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 23:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLGWgK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 17:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWgI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 17:36:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E3767210;
        Wed,  7 Dec 2022 14:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670452564; x=1701988564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9QP8xfgzXuiqrzBWsRGwghB5HCYaR+FYOzwJtuuL3B4=;
  b=EImFF4z2ez0kJa4n1n4QxbZb3BqlgbPsYoGQSlqqbQr+3i/q8d2UJbVU
   Gs9wQtLkyY4CJfeMUwk6pXqDDTYR0HnRhDSv+3S3QbrduZ/HYBSJIwKVv
   A6ebGhDH62PuuQccZ9zt9hEK+pIAhncp/+2rIyxjnQ1u0INpzFOLRZ6Sc
   gKoZrq/tGTSXowBzhQ1axpVLHvWXMIn1TWagPuTfuFcLcK3Wv7F7c5PEh
   oRTkdK3C3Vq5ey/Blb1//rWFKWciuZyZJJVVJGhYI1m2SMaRYi98nOq1f
   uwYNmUQzCNSx9g8qZ8hn5Oouw4/r2LuZUCKxTsEJopKHc/00IiFDb6F92
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="317030600"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="317030600"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 14:36:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="679299921"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="679299921"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2022 14:36:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 14:36:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 14:36:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 14:36:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 14:36:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzU11fx+On9mJeiIuMwUxFXwl06KYoQoYTMFTp+SnumWQnpYYoS7Y/oJ9Lv8dPbObnKgGj1HLS7ND5HVbjGttllemsU0JuHw4xSLrviQRrpN58oBRzMZYOD0cZnxBif3ZXXh+3sya5c/hkaFCs7h2Vd9q8t2t9i+dGDjcOnezvPMhAdxFrrMd9jq9PCE49+vrAekvAXclt04yaDaOuB8ixeHs+LRqr+Zvikl92d9Ulscw0hQxIU9vSRXcZ7SsYeI781jhgoVOT/bjv25FgFILKvZSKAmb02kb2h5DHKTI+e9BvKT+fUaTcbD4Ga5k5o8avdkyohaWngRH3swWobEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QP8xfgzXuiqrzBWsRGwghB5HCYaR+FYOzwJtuuL3B4=;
 b=ghNz94WtY7qiiAiYX1g8NnHdxvNHMhqUlCHku6caJheADFO7AtG+cZnue41LI06pBuO8es1hsxB5Amj81J45x5SZ6GHIRho8FoU7vp3BDenLI0dyQ55qxVpFOswO8TOyvQnACx9d4mBqGhsuJKvRShtJJZFS6YyY/VOhx8PpEgUi1DiqPI2qH2Sf66vY+2mfFI0OoLrHU7R8/r3sArshmVLvobiFQy/PULNJtDXqu+0EH8J4d3lhzhqZtIxuyfVcyPyfZ72Eio6GK+qgdxpDlR/9iw9F6vjVJs+lxsxBSZrDFqfooXe5GLTqYqHPlV4x0mYP10CE/2PF7nmppe4yew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 7 Dec
 2022 22:35:59 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 22:35:59 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v4 03/39] x86/cpufeatures: Add CPU feature flags for
 shadow stacks
Thread-Topic: [PATCH v4 03/39] x86/cpufeatures: Add CPU feature flags for
 shadow stacks
Thread-Index: AQHZBq9P6foD+mjitEm+M0R8QR7zt65iSPYAgADCOAA=
Date:   Wed, 7 Dec 2022 22:35:59 +0000
Message-ID: <63ea77f5d14739f8184ea51a4df939a58b4764ab.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-4-rick.p.edgecombe@intel.com>
         <Y5ByYmOZ/x5BbS9o@zn.tnic>
In-Reply-To: <Y5ByYmOZ/x5BbS9o@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB6451:EE_
x-ms-office365-filtering-correlation-id: 428445a1-9ee0-45a6-3d9c-08dad8a369ed
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ji4U5O8AIVufVbZz8g3VvC9qL3Ny92zGadxJmDoFxPEkz3Vygn3tLpRGJuCohvCRVJXwFyd1Bcb/NGNIMtlOmTlyrAAVjfqEHGHwNq1hpyuZUDuvw2c4bAF80UnHCtDRO9zWpkn+Ae4AtHckpTmLAJp53rVbPb1lphxyf9wTaI64SVp0cIDpjATQtd7wvhd7pLZDyMbZYfugRBsqKQiRNm1IgetO+niCjm35WTYMpFAJZ6/opuAGMPJOw6nTP5I2zEMfbHFTQHzF19v9zZWxGR3+WWaG04oRfohUmoU9Sxe7rzsdaPrhMlKd8v7FBZ2X3i8N9Fwwo3ixyFrWIer0vaWjFHs6NrQ7ZaEy25Qlr6AYS5QWbC8/aPqV2PRA4P1x5py4qPQSMRWbqR6GCxfaDdxd4mUOcD23ym1zZ0Dhz0EZMzxKMS0oXQM6jctpMZ0zahhMy93f6qhqh7nPIfxT1h9a0PTjfw895tKNWUVHd/UTdkQJqVKH56DGcmQm2axsxL0w6ZnBVX9v8CoP/M1V5c1wFXyugoZPef5DA23vxw1AaD1Qg6x6qLwJfV8xFJbCvtlsxjbZaQDHS+J8nMc6TjB7FdkMhoYcRo9QAg6WG63+B9kA8SNNjx8t868cGQMiYH3g91o8U9nlcv1+Qa/7o+D3IK7Ot5ymfEmlvVTNtNfg+El5lUp/D+s+jx0iHffi7eF8O3Ek2zTVygBQ1SSYav9JJdCZ5MfgEFNABLA+E2c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(7406005)(54906003)(36756003)(5660300002)(478600001)(6916009)(7416002)(71200400001)(6486002)(316002)(6512007)(122000001)(82960400001)(38070700005)(86362001)(6506007)(2616005)(41300700001)(38100700002)(8936002)(186003)(26005)(2906002)(66476007)(66556008)(64756008)(66446008)(4326008)(76116006)(66946007)(91956017)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlVqeXk0b0ZPdFRleTlSZWQrOHFhWHE5S1NoNFpmamtvSWtzYys4dHA0OTFn?=
 =?utf-8?B?UlZLRGhNdlplMmVHRTZhRjRkaElaRU1BbEFYU1RTQnhYdzM3RGU4NVEvVk1Z?=
 =?utf-8?B?SEpuY0FmZ3NhbDI2eitZazl2Rk8zSVlxa0MzRXpESjZUUzRoKzliRDd3d0xJ?=
 =?utf-8?B?Um1DUHI2cVBROWpkTWZHWEFCMmRCa3ducjhJaVBFcFJ2WXBjSk11WGt6RXhV?=
 =?utf-8?B?T3c0OGI0SFlEVzdUQ3doRWlKT3ZGVGV1SytIN1R1R3o4NDhEWm5tTlZyeTA1?=
 =?utf-8?B?MExyb3M4elRhd2lFNXJqK1VJVSt4eXdQeWNzb0tZOFNvcFBMcjQyVng2VWtk?=
 =?utf-8?B?SkZ2L3phblhQRGorUXhaSWlQbkNIWGpLOWZTUDZRRGl4UlVFVUYySlJXbE8v?=
 =?utf-8?B?Q2djeTZURkt3anE2aVJBcERaUC9RckJFSm96M0ZVYVJuWW13cmxRMjVBNzU4?=
 =?utf-8?B?VDlHdWE3VDRmdG1yMFBCV085VFZ0WnozczNMUmg4N1U0TmJuaitMT1pEYWxO?=
 =?utf-8?B?T1VLaENqRHFrLzl5UmxHVVc5cHJjTlY0SFFjeklOUzhETEVUci9udVNRSGNs?=
 =?utf-8?B?T2xWeXg1S2pWK1Z0bUFmMDNkVDhJWEdLOFAyZjFKMlhtSGlKQ0U4djl1OEtV?=
 =?utf-8?B?L05wWTRuTTNYclo1R0pHRlZEdkp2M3R3UkxpUmMwT2FaRnRkOWxNd1NjTi85?=
 =?utf-8?B?Zmd2VlpNMjhYakpONS9WNTFlOGdEQ3BLc1BMQnJRTTV4OS9aTTFmUE9ycHZZ?=
 =?utf-8?B?bUZDbUFIQkpPbG91ajJTaEkxR0VHZ2xOdEdzQ0QxK2drcjRQSy9wbVNkemYz?=
 =?utf-8?B?TlBKc09vMDVtZHlvakoyZC8xM3FXd29BYWVVTWpFNVlGeXpOWjlnRkJGdHNU?=
 =?utf-8?B?bU9GRFlaWTZyMC9ramgya3pqazVDV0pKaThsK3RrNUVsbzAwZlQ0ZU5OVXVr?=
 =?utf-8?B?MkFlRjVLM3Nqa0xmTExtaW53N3FsRTJGN0xreW9CekRKb3VkTkVqcDZkbnRS?=
 =?utf-8?B?cWwxTmowR0xuS3ZVYWdCSjlxdDZ1T0ZjMTVBdzVUQ0tESmU1aVlPYmxCMDd2?=
 =?utf-8?B?UjY2YXVKZkl4Z0tsY01ibElqM0V6cUs4cG82SVdCM3AvZXI0YkNSUDB3dEpj?=
 =?utf-8?B?RjJrdUFnbjBrRTdPQ2hzckJsZHdUNTZSU0M1UHRUeDlYcHJ5RzhYS2FKTlkw?=
 =?utf-8?B?TUZ2WnFuQlJ3Q0RyQ2Q1VDlLQ1VrT1NiZFEvTUUybytDR3E1U1N5bE8vOEND?=
 =?utf-8?B?QkcrMHMzekpBT2ZpZGR2aGNuQ2JlWFVXWlVSUkRqQ3BoTGg4cFBRaWFWV1cx?=
 =?utf-8?B?S1dBWDRick84b29yTkx1czR0T1Fad0NhUmFnWUlnbU5oUG01d0UyM2d6QzN4?=
 =?utf-8?B?eXk1RnpnTWl2b0NaYWY4aWxzczhmdnFsdFVtejBMSXFsRmQrcVM3WWgvR0V0?=
 =?utf-8?B?V3kvMzZvZWxyNkR3QjFIU05qYVEyQ1MyOUJiais3WEVRK3pmcnRtYlk1NCs0?=
 =?utf-8?B?YjlkamgybnpiNWhVK2F2OXpOZzR3cTZKUlozbW1GbjhQRVoxRDhvQzhIbTU2?=
 =?utf-8?B?c3poQkN5VnEyeEhXZGVBdHdERFVzMHhuSGduczhnVWdIbE02VGVQb3lINXR2?=
 =?utf-8?B?RHZlemliWHEzSU9jdGxnVEpNMXhnYW5mc1Jsd2dBWFR2SWJocWJTbDI2cmMv?=
 =?utf-8?B?eWJwMGFsYS9qRnpLWW1lR3FKdnhvZ0VmTmgvVmluR0V5eDFpTXBZQWVPNk5z?=
 =?utf-8?B?NE5XV3FoU2JSWlZpWnB5dFZVZXVJb2VLVkhzTFhEZjhvWml2Z3YzT3JOVzJt?=
 =?utf-8?B?bEtIM3RGTXNsOVlwU2hMQlVtSCtXazcydHdydFFOMWhPUUw5Q3NUSzRTL0NB?=
 =?utf-8?B?cVk3ME9qU2dRbmMveitRZkZQQzVsU2NOalM5RWRpcFN0MjJGRzJQMHN4b0ZH?=
 =?utf-8?B?em5nR0tRWCtoYnFhUkIwdDc4cVlqM2tYNGRhbTRXdi9Oblp0ekE2VVdQTkcy?=
 =?utf-8?B?MHV6bWMrTVFobGxuVzFVOVJPdCtBY1EzVXNWdHJFOEd3azR2MkxvTWRpR1Fa?=
 =?utf-8?B?Vk9kRitRMDhFNlV2NVp6REVhd0hkNnB2SnExZ2tGaW1DaGF1clFneDNLZk45?=
 =?utf-8?B?cmRrTEQvbnNySnoyUmpZZDhqamFnUkpKY1RMS3VNWmhpazgzcFdCZWg5SW1v?=
 =?utf-8?Q?B9PCdc7m1jaQUmvu1OA5efw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <213A20207056504BA2DE58E2CAAAF861@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428445a1-9ee0-45a6-3d9c-08dad8a369ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 22:35:59.4145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1eqYrgIXXCPXwOa5I/yegkFfSO84+85ZB41lKOKakPDmOAs1CS9qCtnHIuOUZ0bKYSelUTqYvz5ZY/C65s3FxnAvVmYD8boq6J/KYpwrE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6451
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTA3IGF0IDEyOjAwICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjMwUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0
dXJlcy5oDQo+ID4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlcy5oDQo+ID4gaW5k
ZXggMTFhMGUwNjM2MmU0Li5hYWI3ZmE0MTA0ZDcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2NwdWZlYXR1cmVzLmgNCj4gPiBAQCAtMzA3LDYgKzMwNyw3IEBADQo+ID4gICAjZGVmaW5lIFg4
Nl9GRUFUVVJFX1NHWF9FREVDQ1NTQSAgICAgKDExKjMyKzE4KSAvKiAiIiBTR1gNCj4gPiBFREVD
Q1NTQSB1c2VyIGxlYWYgZnVuY3Rpb24gKi8NCj4gPiAgICNkZWZpbmUgWDg2X0ZFQVRVUkVfQ0FM
TF9ERVBUSCAgICAgICAgICAgICAgICgxMSozMisxOSkgLyogIiINCj4gPiBDYWxsIGRlcHRoIHRy
YWNraW5nIGZvciBSU0Igc3R1ZmZpbmcgKi8NCj4gPiAgICNkZWZpbmUgWDg2X0ZFQVRVUkVfTVNS
X1RTWF9DVFJMICAgICAoMTEqMzIrMjApIC8qICIiIE1TUg0KPiA+IElBMzJfVFNYX0NUUkwgKElu
dGVsKSBpbXBsZW1lbnRlZCAqLw0KPiA+ICsjZGVmaW5lIFg4Nl9GRUFUVVJFX1VTRVJfU0hTVEsg
ICAgICAgICAgICAgICAoMTEqMzIrMjEpIC8qIFNoYWRvdw0KPiA+IHN0YWNrIHN1cHBvcnQgZm9y
IHVzZXIgbW9kZSBhcHBsaWNhdGlvbnMgKi8NCj4gPiAgIA0KPiA+ICAgLyogSW50ZWwtZGVmaW5l
ZCBDUFUgZmVhdHVyZXMsIENQVUlEIGxldmVsIDB4MDAwMDAwMDc6MSAoRUFYKSwNCj4gPiB3b3Jk
IDEyICovDQo+ID4gICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0FWWF9WTk5JICAgICAgICAgKDEyKjMy
KyA0KSAvKiBBVlggVk5OSQ0KPiA+IGluc3RydWN0aW9ucyAqLw0KPiA+IEBAIC0zNjksNiArMzcw
LDcgQEANCj4gPiAgICNkZWZpbmUgWDg2X0ZFQVRVUkVfT1NQS0UgICAgICAgICAgICAoMTYqMzIr
IDQpIC8qIE9TIFByb3RlY3Rpb24NCj4gPiBLZXlzIEVuYWJsZSAqLw0KPiA+ICAgI2RlZmluZSBY
ODZfRkVBVFVSRV9XQUlUUEtHICAgICAgICAgICgxNiozMisgNSkgLyoNCj4gPiBVTU9OSVRPUi9V
TVdBSVQvVFBBVVNFIEluc3RydWN0aW9ucyAqLw0KPiA+ICAgI2RlZmluZSBYODZfRkVBVFVSRV9B
Vlg1MTJfVkJNSTIgICAgICgxNiozMisgNikgLyogQWRkaXRpb25hbA0KPiA+IEFWWDUxMiBWZWN0
b3IgQml0IE1hbmlwdWxhdGlvbiBJbnN0cnVjdGlvbnMgKi8NCj4gPiArI2RlZmluZSBYODZfRkVB
VFVSRV9TSFNUSyAgICAgICAgICAgICgxNiozMisgNykgLyogU2hhZG93IFN0YWNrICovDQo+ID4g
ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0dGTkkgICAgICAgICAgICAgKDE2KjMyKyA4KSAvKiBHYWxv
aXMgRmllbGQNCj4gPiBOZXcgSW5zdHJ1Y3Rpb25zICovDQo+ID4gICAjZGVmaW5lIFg4Nl9GRUFU
VVJFX1ZBRVMgICAgICAgICAgICAgKDE2KjMyKyA5KSAvKiBWZWN0b3IgQUVTICovDQo+ID4gICAj
ZGVmaW5lIFg4Nl9GRUFUVVJFX1ZQQ0xNVUxRRFEgICAgICAgICAgICAgICAoMTYqMzIrMTApIC8q
IENhcnJ5LQ0KPiA+IExlc3MgTXVsdGlwbGljYXRpb24gRG91YmxlIFF1YWR3b3JkICovDQo+IA0K
PiBXaGF0IGlzIHRoZSBlbmQgZ29hbCBoZXJlPw0KPiANCj4gVG8gaGF2ZSBYODZfRkVBVFVSRV9L
RVJORUxfU0hTVEsgb3Igc28gc29tZWRheSB0b28/DQo+IA0KPiBJZiBzbywgdGhlbiB0aGUgaGFy
ZHdhcmUgYml0IFg4Nl9GRUFUVVJFX1NIU1RLIHNob3VsZCBiZSBoaWRkZW4gaW4NCj4gL3Byb2Mv
Y3B1aW5mbywgaS5lLiwNCj4gDQo+ICNkZWZpbmUgWDg2X0ZFQVRVUkVfU0hTVEsgICAgICAgICAg
ICAoMTYqMzIrIDcpIC8qICIiIFNoYWRvdyBTdGFjaw0KPiBoYXJkd2FyZSBzdXBwb3J0ICovDQo+
IA0KPiBub3RlIHRoZSAiIiwgb3RoZXJ3aXNlIHlvdSdsbCBoYXZlIHBlb3BsZSBnbzoNCj4gDQo+
ICJoZXksIEkgaGF2ZSAic2hzdGsiIGluIC9wcm9jL2NwdWluZm8gb24gbXkgbWFjaGluZS4gV2h5
IGRvZXNuJ3QgaXQNCj4gZG8NCj4gYW55dGhpbmc/Ig0KPiANCj4gT3IgYW0gSSBtaXNyZWFkaW5n
IHdoZXJlIHRoaXMgaXMgaGVhZGVkPw0KDQpZZXMsIHRoZSBzdWdnZXN0aW9uIHdhcyB0byBoYXZl
IG9uZSBmb3Iga2VybmVsIGFuZCBvbmUgZm9yIHVzZXIuIEJ1dCBJDQp3YXMgYWxzbyB0aGlua2lu
ZyBhYm91dCBob3cgS1ZNIGNvdWxkIGh5cG90aGV0aWNhbGx5IHN1cHBvcnQgc2hhZG93DQpzdGFj
ayBpbiBndWVzdHMgaW4gdGhlIG5vbiAhQ09ORklHX1g4Nl9VU0VSX1NIQURPV19TVEFDSyBjYXNl
IChpdCBvbmx5DQpuZWVkcyBDRVRfVSB4c2F2ZSBzdXBwb3J0KS4gU28gdGhhdCBjb25maWd1cmF0
aW9uIHdvdWxkbid0IGV4cG9zZQ0KdXNlcl9zaHN0ayBhbmQgc2luY2UgS1ZNJ3MgZ3Vlc3QgZmVh
dHVyZSBzdXBwb3J0IGlzIHJldHJpZXZlZA0KcHJvZ3JhbW1hdGljYWxseSwgaXQgY291bGQgYmUg
bmljZSB0byBoYXZlIHNvbWUgaGludCBmb3IgS1ZNIHVzZXJzIHRoYXQNCnRoZXkgY291bGQgdHJ5
LiBNYXliZSBpdCdzIHNpbXBsZXIgdG8ganVzdCB0aWUgS1ZNIGFuZCBob3N0IHN1cHBvcnQNCnRv
Z2V0aGVyIHRob3VnaC4gSSdsbCByZW1vdmUgInNoc3RrIi4NCg0K
