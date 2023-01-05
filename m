Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C665E280
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 02:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjAEB30 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 20:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEB3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 20:29:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695122F789;
        Wed,  4 Jan 2023 17:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672882164; x=1704418164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZEkf+ZGHe5+nef3De50bdvLICX5MnSdykGDE/XWqBu8=;
  b=WiTnCYbUGbtgXcBYgsJVzwQI+AGy23V2UjhSd8Eiih+yXB7nzEMmZFHY
   9m+GnZ4dNO4exbvwL2mzmQH2hxWKXXdMWR2VIDlTZXAdPMZ8HFRlkb/Yq
   bhdI7ZOeCiIwMhRoeXZwCYMljg6EnpIThv85O5xtcYl2RZPTiXYyAPdoU
   jOEdCuZ69HNEvssTq6GBTjX62V6xMmIxSoNOTd2J8AYsNugAr2ly3dikR
   UxxDksrnUChOgD7Rhr3eRgsKIwDlZnEOztsmPnif4KI6q/A1heVz87sbL
   MEBOR9c9AEFaxO0AJ3nW6oZnm/Y8ZNNNtAMaI5Mlbw5zvyhr/ocipMzur
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319794184"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="319794184"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 17:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="984115500"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="984115500"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2023 17:29:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 17:29:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 17:29:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 17:29:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 17:29:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhtxxhFVKY8Ck4zb5bWYQ6aN3EVgMbUXjBhbsJgDkXQ+5IsKUZrm4LJ3hsDaCYE73MDQyukqGxbhQZeb4Iw8pFnt4aQ9XigDjcjpcdlxHvJmp9OaaVyGYbgtetK6pIFdIGcdLEj+F3SUfLuTYVbajvnSxaG+b0tu+EATME/MnOKVEUUVEW/MB36rUOW7EmdKhn7GtIZkv7YAt79rdF52bCHl5OIyCco9EuXAB7yVrL/l1A+mK7sI4e/oyfIGRQfb7zqxLAOznC3J7hnwHOKOyaCvRASyVvXRK13L4zzB5S/VN0VWq+x1bFvK7FpSwv6uLI4h6IZOKMEw3CpfQ5W7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEkf+ZGHe5+nef3De50bdvLICX5MnSdykGDE/XWqBu8=;
 b=TAiqbg+bc0qEhFuw6u6Fz7TxJnocSo1w6pLQMEKOvYAqFl9wYFHsRTtMTTDaTsatD5lffw0rilZUdX9yEyIFfV4g9su+6UvwnRGfk1T8rBddv4E6zahAOQPzVmrlH4V8faOJmwR1zSWs9tiQjYf79lglOsqfEpKc9sXkM6veYKNEDzmFGM7PVfCY6kNDtuyzYGpGbuDcyrCMAFQxl9J3G7dgDu8F49dJoRMmT4x23VSSA/vAg8yND+rkdR7vNgNEFvihu8rrRPfoVgKC860uKPGQdkgHi8DMyFPyW614O2CpnT+tEpUYGDsOY/o4JhC6IdtEqVZ8TAjfCbsdUIux1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5397.namprd11.prod.outlook.com (2603:10b6:208:308::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:29:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 01:29:13 +0000
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
Subject: Re: [PATCH v4 16/39] x86/mm: Check Shadow Stack page fault errors
Thread-Topic: [PATCH v4 16/39] x86/mm: Check Shadow Stack page fault errors
Thread-Index: AQHZBq9m9iO15HXqSUybhmPw5zUrEq6OhUOAgAC3mQA=
Date:   Thu, 5 Jan 2023 01:29:13 +0000
Message-ID: <c96c5f7d651729e414e0a9aac3adeaa2544a3d04.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-17-rick.p.edgecombe@intel.com>
         <Y7WN5WxENBrhkJXU@zn.tnic>
In-Reply-To: <Y7WN5WxENBrhkJXU@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB5397:EE_
x-ms-office365-filtering-correlation-id: 5e9ab16c-8de4-4a48-a3d1-08daeebc409e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62Z5FqFHc9ESjnHQdnuel3lz8aYEW5a324pK2u8GrcdYRJeLyIUEXOjH6fbC1Ktq2uSjauxtdicBMeBSKVmhD8VjfatvokAt0VbIuOeYuPO/s3k151ltotvHE1IgAATOZCGtNXfQOvDPzhlcMULHc6Aj41oabbx623mSpeH/jmZTyP2Dw/dMGVIQGdJrKU1T8LOhGu3Lph28SkIZ2Zde2NTR53OD1vrm2M84l5k5WVSmDGIIkrNeOZ8jMvdWeUPrfc3DVkL2aqAmsZqujqlXsiznWZ5JNbSAGZxPpGLzjqkZK5Eli2FUvlGl9MOz5zeYs07ajEFApvWkNvjFlY3b8JniheYmxf0PPAG+GmRdloD9jMJgJslTlcMxNV2wweXLAkWfW7fCUwMdQFtvZ8pYdKXhnUwvExxkFP1VcO2l9WtQpFzZMaT/EyZ07jueusGH78wEaMpVaOJIWw5/4c/s4Thg7X1yXwzunOCdrn74Z8dDqC8iX4VGmy8TlblBW0foh25SqGgkFfkV9rrGmnEqDTobRRJqTlTbNKUoSNIHHqXYwKTHKlolUhMmlmZW7SJUQoogW3IhU9Anzz50NLzLLMDiS/DJRB0PEGmTIgyBkmBXZvs/LBwkK1ZIzjsw2fZRtIZBt0EcMwlSOYpezSEDCxSSNewFSLYlbeCetpJYGA0jos3slqCzVrcLw+GILxG1orh9SRJ/kDE6UcleddtIeHR5erMlB2T+BzYW7ZA2+lrDMqydHKM984xJQPJ1p2OJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(6506007)(478600001)(36756003)(86362001)(82960400001)(122000001)(38070700005)(38100700002)(6512007)(966005)(186003)(26005)(2616005)(83380400001)(71200400001)(6486002)(66946007)(7406005)(7416002)(8676002)(5660300002)(76116006)(64756008)(91956017)(8936002)(66476007)(66556008)(66446008)(4326008)(2906002)(316002)(41300700001)(54906003)(6916009)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDhEL3RDUmhHdjZOMFdaNnV4QlA0a3ZXK0MrQVFYVFhlNUV5Yk9EMFZoZ2pC?=
 =?utf-8?B?bXhvck1nbktOSDlhZ1ZiTHlSc2VwYzd6WHZVQ3RTMUxBbkRob2JTVS9HMHMz?=
 =?utf-8?B?bG13aUJKUlE3NDNPVXZ3Z0IxME5zZWliZk5qVk82MVRsd09zWGpIbndrYVE4?=
 =?utf-8?B?OWNzbGdjMWVtUi9mQW1aYXl1YWE2bkhrbXhoZk8zQ0RWb1JsSnVTOGxMMDNU?=
 =?utf-8?B?RjI0dzloWDF4WlBCU3ZwQXFFNGFzL3ZrZllMTjY3K05pS1Z0Tnd6RGkwN1Ns?=
 =?utf-8?B?TG9nRWp3dmRYSEpBV3l0ZjR1ek9UY2dvRHowcURWMEE3Z3Y4MmlOWDB4MVBs?=
 =?utf-8?B?Y0dmcm5WV1VVb0RQdkRMZnNaTXp2K09paHhRVVlkODd2TURkRldZdDJpelpX?=
 =?utf-8?B?MHBVdHVrUFN5MmIyd1pobDF6bm5MUWdhM0NoUFdNb2pOYnRpbFo3bGVKMHE5?=
 =?utf-8?B?N0hRb0pLYjIxR2NkMDBEZDUrd3dLUTFyajZHcWpxLzJkZUhHNEQ2YVl6SGJn?=
 =?utf-8?B?OHRzbkE0Rkl3SUFsRGtnak05Wm1MNU41SE40ZGNqUE1Pb0VsZnM4U1pVcTNQ?=
 =?utf-8?B?Rnh6OGs2Ynh2OG03N2t0cENJbmNkSmFFNVN1cVR1NlF5aUFOR3dkSkRrL0d2?=
 =?utf-8?B?cy9xQVFnSnVjSjJMaTZTdjJyZTlvTDA0ZjlJTlNwWU9GNTl6N0Q2SG56Z2Ey?=
 =?utf-8?B?MEdQZWtCTWcwKzJLUzVBMDdqVzRDZTZnK3VhNG5YalNMWFdoOE81M25xclIx?=
 =?utf-8?B?SWVIQTlTYUdOM3pJSllhbGZOZGtpSUw5azJmeEhhU0lrNVNiQkpuMFZQSzRt?=
 =?utf-8?B?OUpMWnBaRitNRzRDZHRkbU5aR3h2OHhMWnl2ZVExYTdYS0dYeVROajVyOHFG?=
 =?utf-8?B?MFkxNDdVQUJ3cFlVYytWVkl0a1h1RFR4MHZOeVlBb1RDZ3l1VUlWQ3BPb3Qv?=
 =?utf-8?B?NnZvTmNobVNRaXQ2ZFVZaGdTankvUUJoRmswWHZuNDZGbG9SQUlpTWVvTVA2?=
 =?utf-8?B?SXQvVGNLQ2dxdWhyL1FlRm1iVlhlQ1BoNmdYTUY1NzZLaFhicXlwaGE1NmpU?=
 =?utf-8?B?MXpBL0swRzVld096VUhYcTJIRXE4b09vL0VqaDJsdUZQMHYzbFpDMDVoNVJH?=
 =?utf-8?B?UGNDQWtZdmtKOFd1QXhNM3kzNUx1R3pUVU5YMnAzZEF1TUNTYjBaVlZWYVUx?=
 =?utf-8?B?OGtlQ29BUXdlK0NvVUFtdWJuNnZSdlZkcVZjenFxNmZOa0lUL0k4SjFpSDkw?=
 =?utf-8?B?UURJTTNiQUpiMUc4Q2h2YUllREhSNTlaQVE1dkt6WWNQOGJ5UDJGMDFiZkVE?=
 =?utf-8?B?dkNxY1FwZWE4T0UzWTV6aHBiM2twejJZSUZ3Nlg5TzdlbHZoSTlTNkorY2d0?=
 =?utf-8?B?LzVDcE5LM0pBVjY1UnZBeVFaQ25sd1hidVpJaVE4dmljdG5UdElOVnFPa2ZV?=
 =?utf-8?B?eWhPdGt0RFZVZTRqdy9wWWpUYUtRSXNCRkYveWVQV1AyZ1JEVnZjUExNY2w1?=
 =?utf-8?B?SFFGOFZNMUdsT1RwcFVCOG0rWElWMjRGSnEzOW1ETVRvL3g4cXhMa1J2VXh0?=
 =?utf-8?B?aXF3aW1qdGhiaE1nOW1IbjFoTm5BeUZVeDFVT0UwemVvZnd6ZFJ2QncxMzZZ?=
 =?utf-8?B?OWhNWkQrRUN3VTByTGFUWERybFJhZmV2MFYvL25XTm1yNXd4bjdhRXR5QXcx?=
 =?utf-8?B?UEI2Qmx0aWpIS3EvVFY0b1pDODZlY00xYUJzWWZZbG1YUHBUV0pwOHRhdW9a?=
 =?utf-8?B?QVFzRVA0Yk1LNXlnQlI2Y0lsL0VPOGVJWi9GR0Fvdi9sOE12Z1ZVYk91WXJN?=
 =?utf-8?B?VURuRlNCY1kreDVIQm9vYURSTkRLY1dHTHVCVmFUZVQxS1BlSnc5NkxmTXFY?=
 =?utf-8?B?bGVZWkNuUTl4d1V3YjYxbTA1aENXaU02WHdIZ0hJUEFWUEdVRlFxT1JhTFc5?=
 =?utf-8?B?MXlsYXNsT09OSDNmRVFmR2k2U2xkd2g1RFovWmd2RFMwRHRKSmRhejdpMDFN?=
 =?utf-8?B?bTA0YXFMRXE1TUswN0s1YktJMkRwdTlBWkp0QnlXR1RuMk9kdlRVZ3AxOUV4?=
 =?utf-8?B?aG95RUhBOHdnR0NCeXdsOWNXRHNNM1RyZXJvSENqNTFwL2M0TjQvckd0dFE4?=
 =?utf-8?B?SlJpL2l5UUZqOEh4SkVEcno2dEJoZFp4Um41aHlkS2hPdzRJM2NaT3BHSzc2?=
 =?utf-8?Q?cpfTNnY4E13Q+sw5hagmHhY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F6EAB71DEAAE34E8BC15C73BF4A199B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9ab16c-8de4-4a48-a3d1-08daeebc409e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 01:29:13.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DF2awzGlyumHMZ4NLK6UqpD19mPIkTIlFZGVxBwMWMejZRj/9yr4yK3sDaJto8h4HD+cq6eCUOvkUO1FM+B520EbLvutgvdux6UzJ7WDT+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5397
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTA0IGF0IDE1OjMyICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjQzUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gVGhlIENQVSBwZXJmb3JtcyAic2hhZG93IHN0YWNrIGFjY2Vzc2VzIiB3aGVu
IGl0IGV4cGVjdHMgdG8NCj4gPiBlbmNvdW50ZXINCj4gPiBzaGFkb3cgc3RhY2sgbWFwcGluZ3Mu
IFRoZXNlIGFjY2Vzc2VzIGNhbiBiZSBpbXBsaWNpdCAodmlhIENBTEwvUkVUDQo+ID4gaW5zdHJ1
Y3Rpb25zKSBvciBleHBsaWNpdCAoaW5zdHJ1Y3Rpb25zIGxpa2UgV1JTUykuDQo+ID4gDQo+ID4g
U2hhZG93IHN0YWNrcyBhY2Nlc3NlcyB0byBzaGFkb3ctc3RhY2sgbWFwcGluZ3MgY2FuIHNlZSBm
YXVsdHMgaW4NCj4gPiBub3JtYWwsDQo+ID4gdmFsaWQgb3BlcmF0aW9uIGp1c3QgbGlrZSByZWd1
bGFyIGFjY2Vzc2VzIHRvIHJlZ3VsYXIgbWFwcGluZ3MuDQo+ID4gU2hhZG93DQo+ID4gc3RhY2tz
IG5lZWQgc29tZSBvZiB0aGUgc2FtZSBmZWF0dXJlcyBsaWtlIGRlbGF5ZWQgYWxsb2NhdGlvbiwg
c3dhcA0KPiA+IGFuZA0KPiA+IGNvcHktb24td3JpdGUuIFRoZSBrZXJuZWwgbmVlZHMgdG8gdXNl
IGZhdWx0cyB0byBpbXBsZW1lbnQgdGhvc2UNCj4gPiBmZWF0dXJlcy4NCj4gPiANCj4gPiBUaGUg
YXJjaGl0ZWN0dXJlIGhhcyBjb25jZXB0cyBvZiBib3RoIHNoYWRvdyBzdGFjayByZWFkcyBhbmQg
c2hhZG93DQo+ID4gc3RhY2sNCj4gPiB3cml0ZXMuIEFueSBzaGFkb3cgc3RhY2sgYWNjZXNzIHRv
IG5vbi1zaGFkb3cgc3RhY2sgbWVtb3J5IHdpbGwNCj4gPiBnZW5lcmF0ZQ0KPiA+IGEgZmF1bHQg
d2l0aCB0aGUgc2hhZG93IHN0YWNrIGVycm9yIGNvZGUgYml0IHNldC4NCj4gDQo+IFlvdSBsb3N0
IG1lIGhlcmU6IGJ5ICJzaGFkb3cgc3RhY2sgYWNjZXNzIHRvIG5vbi1zaGFkb3cgc3RhY2sgbWVt
b3J5Ig0KPiB5b3UgbWVhbg0KPiB0aGUgZXhwbGljaXQgb25lIHVzaW5nIFdSVSpTUz8NCg0KU2hh
ZG93IHN0YWNrIGFjY2Vzc2VzIGNhbiBiZSBXUipTUywgc2hhZG93IHN0YWNrIHB1c2hlcy9wb3Bz
IGZyb20NCmNhbGwvcmV0IG9yIGluY3NzcC4gQmFzaWNhbGx5IHRoZSBpbnN0cnVjdGlvbnMgdGhh
dCBpbnRlbmQgdG8gcmVhZCBvcg0Kd3JpdGUgdG8gYSBzaGFkb3cgc3RhY2suDQoNCj4gDQo+ID4g
VGhpcyBtZWFucyB0aGF0LCB1bmxpa2Ugbm9ybWFsIHdyaXRlIHByb3RlY3Rpb24sIHRoZSBmYXVs
dCBoYW5kbGVyDQo+ID4gbmVlZHMNCj4gPiB0byBjcmVhdGUgYSB0eXBlIG9mIG1lbW9yeSB0aGF0
IGNhbiBiZSB3cml0dGVuIHRvICh3aXRoDQo+ID4gaW5zdHJ1Y3Rpb25zIHRoYXQNCj4gPiBnZW5l
cmF0ZSBzaGFkb3cgc3RhY2sgd3JpdGVzKSwgZXZlbiB0byBmdWxmaWxsIGEgcmVhZCBhY2Nlc3Mu
IFNvIGluDQo+ID4gdGhlDQo+ID4gY2FzZSBvZiBDT1cgbWVtb3J5LCB0aGUgQ09XIG5lZWRzIHRv
IHRha2UgcGxhY2UgZXZlbiB3aXRoIGEgc2hhZG93DQo+ID4gc3RhY2sNCj4gPiByZWFkLg0KPiAN
Cj4gSSBndWVzcyBJJ20gbWlzc2luZyBhbiBleGFtcGxlIGhlcmU6IGFyZSB3ZSB0YWxraW5nIGhl
cmUgYWJvdXQgYSB1c2VyDQo+IHByb2Nlc3MNCj4gZ2V0dGluZyBpdHMgc2hhZG93IHN0YWNrIHBh
Z2VzIGFsbG9jYXRlZCBhbmQgdGhlbSBiZWluZyBDT1cgZmlyc3QgYW5kDQo+IG9uIHRoZQ0KPiBm
aXJzdCBzaHN0ayBvcGVyYXRpb24sIGl0IHdvdWxkIGdlbmVyYXRlIHRoYXQgZmF1bHQ/DQoNClNv
IGlmIHlvdSBoYXZlIGEgc2hhZG93IHN0YWNrLCB0aGVuIGZvcmsoKSBzbyB0aGUgc2hhZG93IHN0
YWNrIFBURXMNCmJlY29tZSByZWFkLW9ubHkuIFRoZW4geW91IFJFVCBhbmQgdGhlIHNoYWRvdyBz
dGFjayBnZXQncyBwb3BwZWQgdG8NCmNvbXBhcmUgaXQgdG8gdGhlIG5vcm1hbCBzdGFjayB2YWx1
ZS4gSW4gdGhpcyBjYXNlIGl0IG9ubHkgbmVlZHMgdG8NCnJlYWQgdGhlIHNoYWRvdyBzdGFjaywg
YnV0IGl0IGRvZXMgdGhpcyB3aXRoIGEgInNoYWRvdyBzdGFjayByZWFkIiwNCndoaWNoIHdpbGwg
ZmF1bHQgaWYgbWVtb3J5IGlzIG5vdCBzaGFkb3cgc3RhY2suIFNvIHRoZSBmYXVsdCBpcyBhIHJl
YWQNCmZhdWx0LCBidXQgaXQgbmVlZHMgdG8gbWFrZSB0aGUgUFRFIHNoYWRvdyBzdGFjayBpbiBv
cmRlciB0byByZXNvbHZlDQppdC4gU28gaXQgbmVlZHMgdG8gdHJpZ2dlciBDT1csIG90aGVyd2lz
ZSB0aGUgc2hhcmVkIHBhZ2Ugd291bGQgYmUNCmNoYW5nZWFibGUgZnJvbSB1c2Vyc3BhY2UuIE1h
a2Ugc2Vuc2U/IEkgZ3Vlc3MgSSBjYW4gYWRkIGFuIGV4YW1wbGUgaWYNCnlvdSB0aGluayBpdCB3
b3VsZCBoZWxwLg0KDQo+IA0KPiA+IEBAIC0xMzMxLDYgKzEzNDUsMzAgQEAgdm9pZCBkb191c2Vy
X2FkZHJfZmF1bHQoc3RydWN0IHB0X3JlZ3MNCj4gPiAqcmVncywNCj4gPiAgDQo+ID4gIAlwZXJm
X3N3X2V2ZW50KFBFUkZfQ09VTlRfU1dfUEFHRV9GQVVMVFMsIDEsIHJlZ3MsIGFkZHJlc3MpOw0K
PiA+ICANCj4gPiArCS8qDQo+ID4gKwkgKiBXaGVuIGEgcGFnZSBiZWNvbWVzIENPVyBpdCBjaGFu
Z2VzIGZyb20gYSBzaGFkb3cgc3RhY2sNCj4gPiBwZXJtaXNzaW9uZWQNCj4gDQo+IFVua25vd24g
d29yZCBbcGVybWlzc2lvbmVkXSBpbiBjb21tZW50Lg0KDQpJIGNhbiBjaGFuZ2UgaXQuDQoNCj4g
DQo+ID4gKwkgKiBwYWdlIChXcml0ZT0wLERpcnR5PTEpIHRvIChXcml0ZT0wLERpcnR5PTAsQ29X
PTEpLCB3aGljaCBpcw0KPiA+IHNpbXBseQ0KPiA+ICsJICogcmVhZC1vbmx5IHRvIHRoZSBDUFUu
IFdoZW4gc2hhZG93IHN0YWNrIGlzIGVuYWJsZWQsIGEgUkVUDQo+ID4gd291bGQNCj4gPiArCSAq
IG5vcm1hbGx5IHBvcCB0aGUgc2hhZG93IHN0YWNrIGJ5IHJlYWRpbmcgaXQgd2l0aCBhICJzaGFk
b3cNCj4gPiBzdGFjaw0KPiA+ICsJICogcmVhZCIgYWNjZXNzLiBIb3dldmVyLCBpbiB0aGUgQ09X
IGNhc2UgdGhlIHNoYWRvdyBzdGFjaw0KPiA+IG1lbW9yeSBkb2VzDQo+ID4gKwkgKiBub3QgaGF2
ZSBzaGFkb3cgc3RhY2sgcGVybWlzc2lvbnMsIGl0IGlzIHJlYWQtb25seS4gU28gaXQNCj4gPiB3
aWxsDQo+ID4gKwkgKiBnZW5lcmF0ZSBhIGZhdWx0Lg0KPiA+ICsJICoNCj4gPiArCSAqIEZvciBj
b252ZW50aW9uYWxseSB3cml0YWJsZSBwYWdlcywgYSByZWFkIGNhbiBiZSBzZXJ2aWNlZA0KPiA+
IHdpdGggYQ0KPiA+ICsJICogcmVhZCBvbmx5IFBURSwgYW5kIENPVyB3b3VsZCBub3QgaGF2ZSB0
byBoYXBwZW4uIEJ1dCBmb3INCj4gPiBzaGFkb3cNCj4gPiArCSAqIHN0YWNrLCB0aGVyZSBpc24n
dCB0aGUgY29uY2VwdCBvZiByZWFkLW9ubHkgc2hhZG93IHN0YWNrDQo+ID4gbWVtb3J5Lg0KPiA+
ICsJICogSWYgaXQgaXMgc2hhZG93IHN0YWNrIHBlcm1pc3Npb25lZCwgaXQgY2FuIGJlIG1vZGlm
aWVkIHZpYQ0KPiA+IENBTEwgYW5kDQo+IA0KPiBEaXR0by4NCj4gDQo+ID4gKwkgKiBSRVQgaW5z
dHJ1Y3Rpb25zLiBTbyBDT1cgbmVlZHMgdG8gaGFwcGVuIGJlZm9yZSBhbnkgbWVtb3J5DQo+ID4g
Y2FuIGJlDQo+ID4gKwkgKiBtYXBwZWQgd2l0aCBzaGFkb3cgc3RhY2sgcGVybWlzc2lvbnMuDQo+
ID4gKwkgKg0KPiA+ICsJICogU2hhZG93IHN0YWNrIGFjY2Vzc2VzIChyZWFkIG9yIHdyaXRlKSBu
ZWVkIHRvIGJlIHNlcnZpY2VkDQo+ID4gd2l0aA0KPiA+ICsJICogc2hhZG93IHN0YWNrIHBlcm1p
c3Npb25lZCBtZW1vcnksIHNvIGluIHRoZSBjYXNlIG9mIGEgc2hhZG93DQo+ID4gc3RhY2sNCj4g
DQo+IElzIHRoaXMgc29tZSBuZXcgZm9ybXVsYXRpb24gSSBoYXZlbid0IGhlYXJkIGFib3V0IHll
dD8NCj4gDQo+ICJQZXJtaXNzaW9uZWQgPHNvbWV0aGluZz4iPw0KDQpJdCBsb29rcyBsaWtlIGl0
J3Mgbm90IGFuIG9mZmljaWFsIGRpY3Rpb25hcnkgd29yZCwgYnV0IEkndmUgc2VlbiBpdA0KZnJv
bSB0aW1lIHRvIHRpbWU6DQpodHRwczovL2VuLndpa3Rpb25hcnkub3JnL3dpa2kvcGVybWlzc2lv
bmVkDQoNCj4gDQo+ID4gKwkgKiByZWFkIGFjY2VzcywgdHJlYXQgaXQgYXMgYSBXUklURSBmYXVs
dCBzbyBib3RoIENPVyB3aWxsDQo+ID4gaGFwcGVuIGFuZA0KPiA+ICsJICogdGhlIHdyaXRlIGZh
dWx0IHBhdGggd2lsbCB0aWNrbGUgbWF5YmVfbWt3cml0ZSgpIGFuZCBtYXAgdGhlDQo+ID4gbWVt
b3J5DQo+ID4gKwkgKiBzaGFkb3cgc3RhY2suDQo+ID4gKwkgKi8NCj4gPiArCWlmIChlcnJvcl9j
b2RlICYgWDg2X1BGX1NIU1RLKQ0KPiA+ICsJCWZsYWdzIHw9IEZBVUxUX0ZMQUdfV1JJVEU7DQo+
ID4gIAlpZiAoZXJyb3JfY29kZSAmIFg4Nl9QRl9XUklURSkNCj4gPiAgCQlmbGFncyB8PSBGQVVM
VF9GTEFHX1dSSVRFOw0KPiA+ICAJaWYgKGVycm9yX2NvZGUgJiBYODZfUEZfSU5TVFIpDQo+ID4g
LS0gDQo+ID4gMi4xNy4xDQo+ID4gDQo+IA0KPiANCg==
