Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4B4B19B7
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 00:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345820AbiBJXmn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 18:42:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbiBJXmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 18:42:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5884AF;
        Thu, 10 Feb 2022 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644536562; x=1676072562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gfceuEOeor2orn49pTlLbuIsoYiE1GtmYOFTUJWlp+0=;
  b=NNfGQTppUHUNPGmIFdm/NQb5ppOt78Yg7+PONtAre6c4aKUCcaRtK2d6
   hTexP9/IBhmpFVmrxBaKdsnPtXMUA/Ql/HMA0rKEWV47kSo5yZHSTAXMK
   kIo521CnZkP/1T3DQcGTzlGVaanXLwf2XEAdNfqmT6ooTlCQIHohAaTxg
   dfu1YOT6MrKsjg4zsesSRR2fq1gc6wl64lzbZw3BrxvX3Lq59MMRwRxCt
   r4epBkrg1LAC1sKiK/lpSSYCv4OsiuUWZh6BXC/yYFQVV5R7RdaHbHRj2
   wU/X9CO0YYQwKOiHJ49eGxe2ASLFsDrPb+ItRxq8M611nbWncD+yW0Y9t
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249369664"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249369664"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 15:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="623031613"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2022 15:42:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 15:42:41 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 15:42:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 15:42:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 15:42:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXlE6rE6Pe+ObYTR6WDKp0J6n/uwJ0KwizNt/6XLOspxl3cu+38tV0+54VaE0HMu9P0WbLPuZ4J+8oFqhJFdVE8nZsDAo14zdkVxoNPAZtx7PDDYXY2JVOTgE7SF28+26wFlGxZAMxEHeQlKa5rL7L7M2wNrPfeeC9Sev9h1WE53jTKI0C6Bt4uCns3FAgKZfs7yq34PYPQu+ig/lO/hqw+8rc4TPBzdMPUBXabdet1t0y89iaoXztUeDuj/qqs5ZBg1mZI4H9F9cBzrT2XtO15jf7N5a/gfZBo/G1zNgEucyOAmMcV3cUtUr2SyvxeTV/RjqI7cbCBHMPQdl/P42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfceuEOeor2orn49pTlLbuIsoYiE1GtmYOFTUJWlp+0=;
 b=lx4ZGVSQ5m62xr0i3wFlD3lcreCYUPFS18V9fR212IA4p3OWfigY8YbQE6FiPKUyoKli76eyQmt/tCaquwJ3x6SU3GTCgBvRUP/ZCFPOSzJ+u/pCVgjsM2p6/aUUQJ/xvBK9+eAg7pQMxXDiNxykwfxCsWxN3+M1BMalmey+KdeT3TK4u8asoWNNXbuVmWT3BEJ4JNhZurxNgwr948mwsKtHhxPhRRQR/c2pQnZpTTVPBRmzyme0NmpskKGxI2JOatjmL+1r/m4m7xxsEaZKbBmfEESlRBcgQYcbRgkvgrXXMdhwsd3ISowTjne6Mfjl0CFt19I98U4Uo4GNi66Hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY4PR1101MB2358.namprd11.prod.outlook.com (2603:10b6:903:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 23:42:37 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 23:42:37 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Index: AQHYFh91Wc0p4+RWw0irm7tPRuygp6yL2y6AgAGWhoCAABHQAA==
Date:   Thu, 10 Feb 2022 23:42:37 +0000
Message-ID: <6a4c11e506874293df13cb94b9dd578bba1819d7.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-19-rick.p.edgecombe@intel.com>
         <f92c5110-7d97-b68d-d387-7e6a16a29e49@intel.com>
         <1b5d83dc4cd84309823f012a3dce24f0@AcuMS.aculab.com>
In-Reply-To: <1b5d83dc4cd84309823f012a3dce24f0@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5f8713b-b326-4245-3a59-08d9ecef0513
x-ms-traffictypediagnostic: CY4PR1101MB2358:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR1101MB235828D91110FE805A04FAF2C92F9@CY4PR1101MB2358.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYKkfNrlpEwJYzykeCzSWmCP6FZtYLb7Z6aDRKDhh3T5NofA/r9pfpvhDp7HxGeb/tq3r+uQw3BNlWJPxymUohiOOsRTDFsQos09a0zoyp0L2URtzZ1tPNusWPJrwlrJ411TB7KtstSsfDgcZZaUgQbhGwwM1oWj3/1BYBAu+w1L/7HF4p+zgZmpAlKfozn0JakiWkMKQu2SVkUQRUoW+RGHU31dDGcEoQ2Mn8KVNrperH39X45VUFbgbmta6ewBvmcMT0qK9LeyGl1TmPXa79E7aGVsSFf9N/YAz8We7NMsiOjjC/dP2v6N+RwibUkdmLMxglI8DdYD9KYHZ8iVwZFITBHb5XTfuFKiUhbYLunIr9R7kE/f60irQD8V/WoD/EDaPMxWZP3f42nhwx0imuXWBmKiNMpOixVVQyIivrCsdC6FKcjrOgeMl/IF7q6bM4HD/suY+e8TZerUtWPnnqhvq+Z/KjSuXPFOXxwA9O3uB/cJEb0H12Cs8Jej6gQY0ycfODB/+QNWBMhYcR3SB6rvIulYSf6Q3jozzoTbh0gyMeQEJzuqJ/0+lGGLaT++aZAqolfqByhmGiL+L5u6db7bZAux1434QV0Npu5CveXMgtw7OHObU8pT98pNhqIUbUZ3/cFOaBRtjL+eBCg9wYy9Y3uUsuoV9il5AjPbRWjUY8shDSdeHAo6H84aYfLtE69V4TrJFPnlPxLfv5maFRDKvjF/ui+KX+dafYS6KM47sbygxb5tv/pZdp9rYUKi2IlbnbbiN2Q5+AAd9+xubMlZL1l07NJdsQOjHpGy0pse0rfM7eNyucyc8QSnPEQFlZgh3iDrHYNPXaIx064DSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(36756003)(38070700005)(966005)(110136005)(316002)(2906002)(86362001)(6512007)(508600001)(921005)(6506007)(7416002)(7406005)(82960400001)(4744005)(66446008)(26005)(186003)(2616005)(66946007)(38100700002)(5660300002)(66556008)(64756008)(66476007)(8936002)(8676002)(122000001)(76116006)(4326008)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWNudWVLN2hVY2hLc09LeDdRWEVLaDNadzZjNWxuaEJMK0lZME5LT0VqREEy?=
 =?utf-8?B?ZUF2UlRibE5JN1Vjc1pZdHhNeEhDbzFtN01UeFhNUjkvck8xRFVmajZkVXUy?=
 =?utf-8?B?U2w0dGpJVzluRHAvUkpJRXhaWG5Wc1Z1YnN2NWJ4OC80V1VLcmhLOCtLczlw?=
 =?utf-8?B?cm9nZWhYUTc4dWlTOCtJcGtTZTRDZTZhR3NhT3duVkNpU2xSOG1HaTMwbTgv?=
 =?utf-8?B?SnIyN2U3UnRTazkxa2duOEJiN2FOMEFsenQ2R1Z4cTVPelFsU0FnYmVuNXVR?=
 =?utf-8?B?TGdvZHZIcWFuS2l2S0hFeUtsQThRRHExaGhNRmpsVUFnN3plOCtQcEVBM3VP?=
 =?utf-8?B?di9CR1JjTGxPM05jeERERitnQjBLVEpPSEQ3cnVRUERQd0pMcE51blBIV0dK?=
 =?utf-8?B?RElXZDJEbndva1NtSWJmMUlZOFo2Q2IyUHpvZlZMYitKSHF1eHh3R0tyaXpW?=
 =?utf-8?B?eWJlWnJVYlZzeXREU2EyLyt6V1BXM2gzZDQ0bElIbkcwMmlHanNqcE5pRGRC?=
 =?utf-8?B?SENjNkdSbE1iLzRHOEFZZit2UWpKRDFWU2lMYUlzUkw5Z3BzN08xWUp6YWZX?=
 =?utf-8?B?SlBkUGRXL1pxRnU5eGNHdmFQSEw3TkFiN05zQll4YzRsRE8xSDlla1JqNmVL?=
 =?utf-8?B?NE9jb1E4UHo4YWZ5L2doamhwTWRNQXcrcHNGcHg4WGNZekUrclFCeHJucDhY?=
 =?utf-8?B?bEpGSUlZZjhoSzduaFRPSXNjc1hocmRyY3dYTjljaFRTb0huRzVmaUVXbnVR?=
 =?utf-8?B?N3UwUkpsc2hXTk5kRzBFc3VjaWlJdUZrazlMOU1kbEtOc291eXl3d1p6MTl0?=
 =?utf-8?B?SVA1SVIyRy9FTXdiVXFGMnBndnZFM0tiVFM3SFF4b0l2bU1Wc2k3WVAyQlRa?=
 =?utf-8?B?Z3dqK1luRFQ1a2lkWVA0MUNYOFYyaEhGMlFKNlFXTlhtTmxJVnZsaC9aQUc3?=
 =?utf-8?B?dU8zbnl1YWpNREl0bXM3d1dtUXNnZW9uUmN3SWt3YVE1RzhvSkFuYnA1aENs?=
 =?utf-8?B?SURhN2h0eUFuNVJoNVgvelZLRnJGL213V1dSYnAzejNrNDNNR1Rza1Z3WjVW?=
 =?utf-8?B?ZTlqZEFrRGhkWm5RRmkwc3M1RktHSE9IaEUwZEJJSTI2b1c5TElxK0FtaU1D?=
 =?utf-8?B?VlRla1RPSDZLZ0xOdWZaaFJZd3VFV2dyT2tYZEZ3OWgwSk9yRTlEMUM5d3l4?=
 =?utf-8?B?My96RktBN0RoR1RNVGp2dG9iRFRwRTFibGUxMkpEamNEV1pXMEJTMSsrc2Yw?=
 =?utf-8?B?RG1RNDlqQTZXdk9BRmRQbXlMSkVuYzMwWjNjN1BLOUVGWEx3SWpHbWRFTmlS?=
 =?utf-8?B?d2lMVlFZNGdra0pkTUNFUmRoZkZISWtMVFlmYzdsZEkrN0w1UndsYWQ4SWtG?=
 =?utf-8?B?ckU1WCs5cVBObDNmK21HTDh1WHFRYlVjZjZmSGlmdXE4ckZGdmlMK2lIU0p5?=
 =?utf-8?B?Ky9VWmluV0lqNDNWYStHdHNwTVJOY2I4TTU2aXdJMDdFbEhRZWFnNWlrbllB?=
 =?utf-8?B?Z1hyY0FKS1B3RE5FSDJSVml4VVZ4VllQMGR5WW95RlpiTlgzbnpIRFFiRk5t?=
 =?utf-8?B?eXVSWHVTeWtrdHAzUHhQSkJ0S21tY3ZUSVpOZC8rQ0JTRHRoZ1p4NXRKL3V6?=
 =?utf-8?B?SHRvTlRVcTUxejRaa2NqRFNsUHhjUlBXdnN1WUMzcXJVVWZJejJCNVEvcEVk?=
 =?utf-8?B?MU1EVUJJNXVlUU1VNURxRHJXblpsZk1ONzdSSWt2QWE0d0t4YnREbjJnZkNE?=
 =?utf-8?B?NGVKUmRQWmNYUW9aTGFndkxLLzRBRzVWWkxQL2JyUXN5a0ZraDhIaU5IV1I4?=
 =?utf-8?B?NXdOSDhVSmVkZUlDVXFkSkdWQnVOekNKbnR1OWJrSXhyVEFkdVE5SUdqakpZ?=
 =?utf-8?B?a2N6QkQ4YVBYeElMcC9lYy9sbC9kK3dIT1NwVTJPbzUySUsvZXFwM1l0Z3U4?=
 =?utf-8?B?WFZqVHdmWUUvOUR6K3J0OFZ5TVA1U1NoVVdCZElkSVBOcll0MXpodlBEWjRo?=
 =?utf-8?B?bHRKaVlvZlFDVzA1clU5elovL2plTkQwTzJiYVZOU1hnVS9FQnFsSy8wY3I5?=
 =?utf-8?B?cUdPMmczMmdZWEJIZGRCVlVIMVdtWnlVT0dZeXU1YldjRW9CUFFzaE5OR0pW?=
 =?utf-8?B?cDk1L2d4MlpIbWhYSXZNUWw1YWRjbjNDR0tYMWR5MURvQzRuOXpHcU54Mm9W?=
 =?utf-8?B?T1VRdFlCaUFHQTB3ZWI2dTNRVURBVVFrRjQwWkhkTVhxUU5PZTROVGZpdDNu?=
 =?utf-8?Q?95s23DdwnNuW8tg3AXF/3Sva5eh3tFc7/JkJWtZ+oA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C786D4445919B14F91E32BF7D4B3C8FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f8713b-b326-4245-3a59-08d9ecef0513
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 23:42:37.5339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHhUrbjuOOY1p2OqqEbuqtDgobECu0nARiQXl+pzbYGvCw3w9Gz5JY4mFUFJ/CHc/I4p3wzKnKLWphj0/51acSDdGpLN9rb7WllPQFQ0aTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTEwIGF0IDIyOjM4ICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
IERvIHlvdSBuZWVkIGEgcmVhbCBndWFyZCBwYWdlPw0KPiBPciBpcyBpdCBqdXN0IGVub3VnaCB0
byBlbnN1cmUgdGhhdCB0aGUgYWRqYWNlbnQgcGFnZSBpc24ndCBhbm90aGVyDQo+IHNoYWRvdyBz
dGFjayBwYWdlPw0KPiANCj4gQW55IG90aGVyIHBhZ2Ugd2lsbCBjYXVzZSBhIGZhdWx0IGJlY2F1
c2UgdGhlIFBURSBpc24ndA0KPiByZWFkb25seStkaXJ0eS4NCj4gDQo+IEknbSBub3Qgc3VyZSBo
b3cgY29tbW9uIHNpbmdsZSBwYWdlIGFsbG9jYXRlcyBhcmUgaW4gTGludXguDQoNCkkgdGhpbmsg
aXQgY2FtZSBmcm9tIHRoaXMgZGlzY3Vzc2lvbjoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9DQUc0OGV6MXl0T2ZReU5aTU5QRnA3WHFLY3BkN19hUmFpOUc1czdyeDBWPThaRytyMkFA
bWFpbC5nbWFpbC5jb20vI3QNCg0KPiBCdXQgYWRqYWNlbnQgc2hhZG93IHN0YWNrcyBtYXkgYmUg
cmFyZSBhbnl3YXkuDQo+IFNvIGEgY2hlY2sgYWdhaW5zdCBib3RoIGFkamFjZW50IFBURSBlbnRy
aWVzIHdvdWxkIHN1ZmZpY2UuDQo+IE9yIG1heWJlIGFsd2F5cyBhbGxvY2F0ZSBhbiBldmVuIChv
ciBvZGQpIG51bWJlcmVkIHBhZ2UuDQoNCkl0IGp1c3QgbmVlZHMgdG8gbm90IGJlIGFkamFjZW50
IHRvIHNoYWRvdyBzdGFjayBtZW1vcnkgdG8gZG8gdGhlIGpvYi4NCldvdWxkIHRoYXQgYmUgc21h
bGwgdG8gaW1wbGVtZW50PyBJdCBtaWdodCBiZSBhIHRyYWRlb2ZmIG9mIGNvZGUNCmNvbXBsZXhp
dHkuDQo=
