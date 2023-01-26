Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547CF67D614
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 21:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjAZUTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 15:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZUTP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 15:19:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06E93A840;
        Thu, 26 Jan 2023 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674764354; x=1706300354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gsLaayqG0uRfadqpBGnxDAJZY6jm7ccVZQRB23x82QU=;
  b=nFVOeJFCKOVcqPf85V5CI6yQHTSxGDGMLwfsPTvOFh+dqIxEDdJ+KgnU
   UsB+EPSJHBj4572Ij3lGU4CWUZkJNE2i7+2RxYuwUp7xLANixRVgP5TiT
   uUTBm+l/jM1ptfvBg4PbGPSYgjwc26aCgJXtyXUhwUn3yAeyADyche4Xd
   9Kvbzwn7bCe4cAzStfNaHx8lh6uH5qUH16ksbkHGXe5eMlB8wHSCyisID
   5KnnBddiwXuc4IcSxC5uGpmdq49yB0IHDKds6Oh2LvnYToQFayrKFMP6N
   k9NQqcZjTzh3XqEMDi74XVNNsWODQJTdCh4G41jCYyFMc84QrNOepkvVk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354230671"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354230671"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 12:19:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="751721281"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="751721281"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2023 12:19:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 12:19:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 12:19:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 12:19:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrIL091kjGBKfemR+JBIAfbUXN5iChSBhYfqLaD96PpwWuFQkmVq3Cfi0RvV6VbDSVrpLo0HtEfmmp6fzTVXEMn2sgIdCxU7e99LvSYJel8wuAP42OfE4QqzF1XX1o/Dwsky5r6VXkbSNk2Bb/AyU0Es3vC+VqDa6afzHoJfxn0VFkJk6Gpt4EipJ3ugFz1bN/2hniwFkMkGux2oM944CNubfWvsgJNAJURrfsHy89CCEuIvWiPjx8Jeq2+t8+jJfsvJ42Xw/9cKG+FeSOD+rZiwLEdoQBnB4VEeu2AFp+S+t4aWTDsCoEEizij1CDV95Pjztf0gzmty8cyYauyi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsLaayqG0uRfadqpBGnxDAJZY6jm7ccVZQRB23x82QU=;
 b=oe3cs9ihcHe8c0t+dNfP3DLn/gxuViEg+3lkYGqKtU+H47CTBeaMGTeLUBkKQZw4oCuyv2YKJjUEp9W0DUo1IQX7Pw70uaWkX+HBRbhjQJZsCsEX2jKuJTtEjQWxDATkuQXmSifmgP2DSvSoj5MYQc0z24amIFWaiZNL8maE8BhL70Yghbo1tpgAlfBxRjRWtn10+Y03c4DH2bOw2UTqFL9Xo9+xT9jT4LVb2myMWRhvUte6pDa44ZopqX8nTRDVR/EtnJA//FR1u7fN0fIEqO8ZVgOCHq7HrbOz6u9DnLU5oTa4phcp2J/fXNKVyC03Cd4kKBoRk2MH/kZzq2NSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 20:19:05 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 20:19:05 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
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
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Topic: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4CAAUjWAIAAHt0AgAD++ACAAJuKAIAAaOSAgACChICAAMGNAA==
Date:   Thu, 26 Jan 2023 20:19:05 +0000
Message-ID: <27b141c06c37da78afca7214ec7efeaf730162d9.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-19-rick.p.edgecombe@intel.com>
         <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
         <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
         <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
         <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
         <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
         <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
         <899d8f3baaf45b896cf335dec2143cd0969a2d8a.camel@intel.com>
         <ad7d94dd-f0aa-bf21-38c3-58ef1e9e46dc@redhat.com>
In-Reply-To: <ad7d94dd-f0aa-bf21-38c3-58ef1e9e46dc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB5118:EE_
x-ms-office365-filtering-correlation-id: c93e653e-98b0-44ce-c55a-08daffda9292
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLXcWE0W94ID/SgCvj0TIvWUi/mPiKuYyIQ9ywLQdztlC6Y2Ur9gEwkhAuPcTq6ZRMxTCvNL6Xlu25ntbj6gSSv33IBw9po1UkOBwy/5c0hSCMW6uEVwiVt5X8IZrWSuaYueRwj8xRbO6hhBYI23NcO+l1161NFciRU4JOWU0lletuZYy8cAnecBqfKksbBcLEQXqGG13uMZEGU6S3dCQCNgeDO9RVEMmerA+yMV4X2M4Qd2l/951rMj8XE6+cvrWPdl3eojJbho9qEx7XCxgCz7lQk7L2oGiWE1ovbrYcebOkxXuFhnqT9Dwhxe/ic8+/fz2el1++HCvyNU+On7LxscY/Veqce1u1MD+Pm+f9sZxw28HbjzWXIP7iVLtEsuRBiN0bbrWXHWw0ZXlZZWjqQJUmUkDlGX2Z6vyR6wGmHKDqv3Hmk+CkPfZLqXB8HhFyxnWJCDCtE9BAM/aDmrWhIFbZz9Qe6Kjz2CpV6Y0nkLwdKsbL4yomDW+iu0GsViDNxHdBN2AfbnBFyG78/J338ql+2yRY7qpBPdQn7A6+KoME68cPbR5/dzPqZTMUjlFn/oQ+Dwq1GIJnQbPeho3hWIc6typM6Rp88BQ7Sot5+T6tXXB/B7HMJpdf0TVQvoYlnGEOXNtkKWWvlRV8caakcPl18ymbBzynaUlzhAX+igy7pVBgDknWT+8XZYsJ4fKn23+y4J7cYfPsps7utzo5DH3+wR29wOh9oLjARx4BH0rO8v36OLKhmDaZVI5cAqO7qAPC5nhVCXt/zEQdfkCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(122000001)(2906002)(38100700002)(38070700005)(6486002)(921005)(2616005)(6512007)(6506007)(186003)(26005)(53546011)(86362001)(83380400001)(76116006)(82960400001)(64756008)(66476007)(66446008)(66556008)(4326008)(7406005)(7416002)(5660300002)(66946007)(8676002)(36756003)(41300700001)(316002)(71200400001)(110136005)(8936002)(478600001)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnpncGJrL0RYYkNZN3lxRG84Y1pjVVg2Yk83dDdmSk5pNDZkTnJFYmdPTWJ4?=
 =?utf-8?B?bk84Q2hITzk5aURIdGdXb1VYZVhTQW1RZzRuaTlPOTA1cHMwcytnaW54cDh0?=
 =?utf-8?B?UUZzUWkxV3dCc2FCcXpoYmcwZnIvVW9uWmNiRjVJS0pPYVp5RTBEZUZoN0VW?=
 =?utf-8?B?R3JaeEduMGRob0FQWmRrMFdMSFVhMTdxb1NlYm14SmU0dlVSWmhuRDAwOVFa?=
 =?utf-8?B?TU5ZaWRib0lqeGI5NWhFMzArRGxNd1pLbGR2dXp5NHRqYzBQc1B5NW1mYndm?=
 =?utf-8?B?NmNhUGx6UTdEQ1hOQUdNalNYd0dQUGZWY1BUY1VVWkdNWGp5YVpDQmhMOWQ2?=
 =?utf-8?B?UHYvS0hZYTNQalc1RVkyVmFUblhjYVAzRzE4S3NPWVpuUDZUZWlocFRFaTJp?=
 =?utf-8?B?NlpXV2NReTBPdEJGTERGdXFRWTBZaUdWZUV6a0E1b2xHNFN6L3ErVGhkcGhF?=
 =?utf-8?B?MFNCeWIxN0dlTUFWd2d6NDIxVTNFQTFmdjNrUXE3UG5PeENoZzYzSmVaM0E0?=
 =?utf-8?B?NlFVbWJMM2JxR284VUNSUFJSY1BIWHdiZ3J0OFNvNmhKdzEyMUFDZ01MK0dQ?=
 =?utf-8?B?cjg2WEVKaHlERnVDRjlFbDhMLzhhY0UyUUlOSnJIbzlpdVBMa3VLNTVxKzJZ?=
 =?utf-8?B?aU0rS2RhNzZRSm9JL1Z0T0tBM25lZ0tFUk05d3luS0xmdFlNM2Y5RmYwWkwz?=
 =?utf-8?B?NUlTNVBpU3A2SmVVb1ZaU25jS3JNSm93dTAwTVFKR0xaQ3BOVU9MRHREOWxi?=
 =?utf-8?B?cksvVmVYMlV1Wk01Z3lNUUhzUlJLQnBYTDhpcUhUVjZzYUh3TVVxdFRHTXdw?=
 =?utf-8?B?QldxTVdicGt6SjUyNDN5R3VkMFRZSE5tVk84bmozSWpJZ1AwS3R6VlYra3h4?=
 =?utf-8?B?eHVZTmFJWmc4U2dvc1I5U0llNGsyQko5QTRrOXhHSThmUUxIL3BZbFd2RWtv?=
 =?utf-8?B?ZXoyTzcrU2syZk5vcGM0a3F0c1JUcHhZNVVZNUlmNTdYc1JoOHp4bzNJUURz?=
 =?utf-8?B?cXVkUGdJSXRoMHdYYjIwUTJMeXRuMUFlM1Ywckp0OFJkMVhLWHcrSExSdkhJ?=
 =?utf-8?B?MmtIQ3ZLNkttVDhkSHpzdS9PbUN3eWMrcVNMQWs3WGQ4RUkwMU44VC9pWjln?=
 =?utf-8?B?dTBDTnBWVno0bEFTSllFNVdHLzVGRlZ3dXZySElOL0o1M1BuU3BVN3VTMDhy?=
 =?utf-8?B?WTkzaDJZb0dZazQvSUFTeS9VT1BFR0FPbnl0dGFKYVM3akE4bGRIeGpVTTVu?=
 =?utf-8?B?blZzMXdZdVRlTXhNeGMvOWRwbkFhOEs5Q1A5ZmpYVTF3L1VHSGRoVEJQakZk?=
 =?utf-8?B?eDAzakQ3dlRhVGt1alJwMDdGOGxHRGRaVk9xdEErSnlNYVJXZTM3eENUQ0tU?=
 =?utf-8?B?NktLOGhsaXFxRnRLVjF4bnI5SGRrdVhGbXI4UDBhK0g1b3FWQzI1MlJySUhu?=
 =?utf-8?B?b01Fb1RoYm5jOGVCYy8wd3lMRExzbXVoVThHL2llTTE1UmJhc2MzdHBEU09U?=
 =?utf-8?B?WGVTNWFvVmRvTzVka3F4NTl6UmQveG9QU3c3VG1QSUxNNGcvOExHQWQ5VjhQ?=
 =?utf-8?B?NmJLZ2RaZGFsWEM5OFM4VG02ZXN6UllQaVRZdEI3QWZNUHlRWUdxd2I1SXpB?=
 =?utf-8?B?SGtiVTdkakJPZWFwK2piajBSa1dMVjR3NVh0dGREUzZHek4xNlB3bnBBSG96?=
 =?utf-8?B?azlBTWE2V24vWkxEVkdXdk9NUEh5Z2Ixenozc0dWL0lsZ2Z5OC95ZURXVEtK?=
 =?utf-8?B?K1RQTmNBdEk4WXQxMzZmbW5obHBCYlJyb2lnRWF6MDBrYk1wWWJ6dkZPb0xK?=
 =?utf-8?B?QU85cng0dGdzSTh4OE9KQ2VxM3JiT3hqenphVkhnNks3dE1pU3lvNEorQmcw?=
 =?utf-8?B?VEZwRU40TmxGbW04bUlrNmd4TVlMN2NlSmY5dnRjZExaZEkyVE1hbXRmVWdh?=
 =?utf-8?B?djk3bUhEQXdUL2hTWkNZeGFpZkxBVlhucWhhMFVnK2gxQ21aUko1cExZMFlJ?=
 =?utf-8?B?d002aVEzbFFEc0RHT1NEZUlnQXJWUGEzK1JuT2NkRDd0dGhJM0RVQ3lzeURG?=
 =?utf-8?B?Z1htcXo0VEdwWWhhYTdSNmpyZGlzNVBySzZucHg4T3NScnZtKzA5aGkvYlFj?=
 =?utf-8?B?WnRhcUpoM1ZtWUpjbmRwNHQ1aFl1Q1lzYkRhWVBSN1pTaGtjWlpyU2ViaE5O?=
 =?utf-8?Q?qZj4A9T6Fr1hbXlzt6qwZw0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BD6ABE9E18FB040BA5E6692F4601D13@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93e653e-98b0-44ce-c55a-08daffda9292
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 20:19:05.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhZDJ3sNmH1fnbe8oAmf02dF5BATMAH1snHjtdXlWW9OPUl6LnPNWUB0CVyKtknK3RIBWoDxOVe4+fX3T1dls/JpaEj5fh1lctYDq77o8d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTI2IGF0IDA5OjQ2ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMjYuMDEuMjMgMDE6NTksIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+IE9u
IFdlZCwgMjAyMy0wMS0yNSBhdCAxMDo0MyAtMDgwMCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+
ID4gPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMgYW5kIGlkZWFzIGhlcmUsIEknbGwgZ2l2ZSB0
aGU6DQo+ID4gPiBwdGVfdCBwdGVfbWt3cml0ZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwg
cHRlX3QgcHRlKQ0KPiA+ID4gLi4uc29sdXRpb24gYSB0cnkuDQo+ID4gDQo+ID4gV2VsbCwgaXQg
dHVybnMgb3V0IHRoZXJlIGFyZSBzb21lIHB0ZV9ta3dyaXRlKCkgY2FsbGVycyBpbiBvdGhlcg0K
PiA+IGFyY2gncw0KPiA+IHRoYXQgb3BlcmF0ZSBvbiBrZXJuZWwgbWVtb3J5IGFuZCBkb24ndCBo
YXZlIGEgVk1BLiBTbyBpdCBuZWVkZWQgYQ0KPiA+IG5ldw0KPiANCj4gV2h5IG5vdCBwYXNzIGlu
IE5VTEwgYXMgVk1BIHRoZW4gYW5kIGRvY3VtZW50IHRoZSBzZW1hbnRpY3M/IFRoZQ0KPiBsZXNz
IA0KPiBzaW1pbGFybHkgbmFtZWQgYnV0IHNsaWdodGx5IGRpZmZlcmVudCBmdW5jdGlvbnMsIHRo
ZSBiZXR0ZXIgOikNCg0KSG1tLiBUaGUgeDg2IGFuZCBnZW5lcmljIHZlcnNpb25zIHNob3VsZCBw
cm9iYWJseSBoYXZlIHRoZSBzYW1lDQpzZW1hbnRpY3MsIHNvIHRoZW4gaWYgeW91IHBhc3MgYSBO
VUxMLCBpdCB3b3VsZCBkbyBhIHJlZ3VsYXINCnB0ZV9ta3dyaXRlKCkgSSBndWVzcz8NCg0KSSBz
ZWUgYW5vdGhlciBiZW5lZml0IG9mIHJlcXVpcmluZyB0aGUgdm1hIGFyZ3VtZW50LCBzdWNoIHRo
YXQgcmF3DQpwdGVfbWt3cml0ZSgpcyBhcmUgbGVzcyBsaWtlbHkgdG8gYXBwZWFyIGluIGNvcmUg
TU0gY29kZS4gQnV0IEkgdGhpbmsNCnRoZSBOVUxMIGlzIGF3a3dhcmQgYmVjYXVzZSBpdCdzIG5v
dCBvYnZpb3VzLCB0byBtZSBhdCBsZWFzdCwgd2hhdCB0aGUNCmltcGxpY2F0aW9ucyBvZiB0aGF0
IHNob3VsZCBiZS4NCg0KU28gaXQgd2lsbCBiZSBjb25mdXNpbmcgdG8gcmVhZCBpbiB0aGUgTlVM
TCBjYXNlcyBmb3IgdGhlIG90aGVyIGFyY2hzLg0KV2UgYWxzbyBoYXZlIHNvbWUgd2FybmluZ3Mg
dG8gY2F0Y2ggbWlzcyBjYXNlcyBpbiB0aGUgUFRFIHRlYXIgZG93bg0KY29kZSwgc28gdGhlIHNj
ZW5hcmlvIG9mIG5ldyBjb2RlIGFjY2lkZW50YWxseSBtYXJraW5nIHNoYWRvdyBzdGFjaw0KUFRF
cyBhcyB3cml0YWJsZSBpcyBub3QgdG90YWxseSB1bmNoZWNrZWQuDQoNClRoZSB0aHJlZSBmdW5j
dGlvbnMgdGhhdCBkbyBzbGlnaHRseSBkaWZmZXJlbnQgdGhpbmdzIGFyZToNCg0KcHRlX21rd3Jp
dGUoKToNCk1ha2VzIGEgUFRFIGNvbnZlbnRpb25hbGx5IHdyaXRhYmxlLCBvbmx5IHRha2VzIGEg
UFRFLiBWZXJ5IGNsZWFyIHRoYXQNCml0IGlzIGEgbG93IGxldmVsIGhlbHBlciBhbmQgd2hhdCBp
dCBkb2VzLg0KDQptYXliZV9ta3dyaXRlKCk6DQpNaWdodCBtYWtlIGEgUFRFIHdyaXRhYmxlIGlm
IHRoZSBWTUEgYWxsb3dzIGl0Lg0KDQpwdGVfbWt3cml0ZV92bWEoKToNCk1ha2VzIGEgUFRFIHdy
aXRhYmxlIGluIGEgc3BlY2lmaWMgd2F5IGRlcGVuZGluZyBvbiB0aGUgVk1BDQoNCkkgd29uZGVy
IGlmIHRoZSBuYW1lIHB0ZV9ta3dyaXRlX3ZtYSgpIGlzIG1heWJlIGp1c3Qgbm90IGNsZWFyIGVu
b3VnaC4NCkl0IHRha2VzIGEgVk1BLCB5ZXMsIGJ1dCB3aGF0IGRvZXMgaXQgZG8gd2l0aCBpdD8N
Cg0KV2hhdCBpZiBpdCB3YXMgY2FsbGVkIHB0ZV9ta3dyaXRlX3R5cGUoKSBpbnN0ZWFkPyBTb21l
IGFyY2gncyBoYXZlDQphZGRpdGlvbmFsIHR5cGVzIG9mIHdyaXRhYmxlIG1lbW9yeSBhbmQgdGhp
cyBmdW5jdGlvbiBjcmVhdGVzIHRoZW0uIE9mDQpjb3Vyc2UgdGhleSBhbHNvIGhhdmUgdGhlIG5v
cm1hbCB0eXBlIG9mIHdyaXRhYmxlIG1lbW9yeSwgYW5kDQpwdGVfbWt3cml0ZSgpIGNyZWF0ZXMg
dGhhdCBsaWtlIHVzdWFsLiBEb2Vzbid0IGl0IHNlZW0gbW9yZSByZWFkYWJsZT8NCg==
