Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5976923DD
	for <lists+linux-arch@lfdr.de>; Fri, 10 Feb 2023 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjBJRAe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 12:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjBJRA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 12:00:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5473B109;
        Fri, 10 Feb 2023 09:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676048425; x=1707584425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gm3w6BV0INSs5OCfIY5Sm9q4TZflIJJobXwnvPkUmG8=;
  b=Dngze/mfcet+WqL44ST9o+eLr1M+G7zyYjQydW+lP0IQs18+Xt8SZxN5
   dnhfksjYv9poNxp6K04iTPqraG1BbEPmQdHTOZVHuNW1xAvL+ZDyLfqwb
   pNmSDhRmPXNZlaffM5UmY3Q7VqKJyJB85lziIt5fK1PG1hI6IViP2SxeY
   siRL/ieRJY/sQSRHfYGImihmrlhB8pFco3l0ZRH/YPG9pzoqUU6Xe1UcZ
   67Kkaytw0MfcGTMUg6ajIOdMc87bc8Omv58fXYmcUnR5lrp5bxjtRwufB
   TV6krLWwbfBgAaCX5/Omu26/1SuHCJUcK0mo8zFrgRdPC+iFY45Hoj1ub
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="314111934"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="314111934"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 09:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756847099"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756847099"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 09:00:09 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 09:00:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 09:00:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 09:00:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbfBc33mLhdBXujplsVfpAC9ieensJX0oHJfWe264spCMf1GiF9Bk9Xijdek+PZr0W+XqL2HQoVgn9jk3JgNC1ese+k4kC4hqmjsAsU4cNbdcctjnkUEBjCMZqhq76zgwzBUhk1Izu7ZKDObXGVjNqqhjt9JQFhR7uxbEN22Q2w/r8zuZCSAd35axDXbWfnTuwxDNKb92cRfyZXicbDk2HcI7CIx90PWO12WxhKqOdA4+72a5LNjfMsHArpeB7uCj7KDHYL85aC2aPvpSeV3R5rPS0Anz3mcnF2cBfBhfNCNo0QD1ticFnqWAa/HZruUoJEJqXEQx0/Olh3FMXKBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm3w6BV0INSs5OCfIY5Sm9q4TZflIJJobXwnvPkUmG8=;
 b=Plo7cios8kh0oYWUIrim6j9/z4RHtyY1zLUJq07pirw2YrxSrPU9vVzlWq7WyE7v5GtOtaB7knsp5VCTUkH5CUBhlvObxgwFEWgvRhOd83XSUIZj+PT6+IErQvYxBu9EdsET1HSWdirNLuhD8ooE/m0KivyvjisE3INGimNAtNKmLnIiXogM0Q4dgqeIfr+YlWxNtEFA3mBPOvNy1HqqygDrX380jXpzDDyyF6XWjvUymcLXEnoVtPsrSHrAzHMbc5lzdciEKtTmFQG21+QfUM/k2ZfyUEUAkwfkmcrEVbZpQKiboc4O+J5fvawbU83Ywi4DA7OQ0BenHSfaoSpyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 17:00:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 17:00:06 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Thread-Topic: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Thread-Index: AQHZLExwXsVvVi7azU26l2oZqLTgOK7Gx2uAgAAydACAAVyjgIAAMyIA
Date:   Fri, 10 Feb 2023 17:00:05 +0000
Message-ID: <15c76808ac5975df2294d0c7edf0abfe8587da2d.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-12-rick.p.edgecombe@intel.com>
         <Y+T+ZxydCZS1Yjmz@zn.tnic>
         <49d20fcd197e85e8475f5170db78780f06396cc0.camel@intel.com>
         <Y+ZNL4o57lCrmwpb@zn.tnic>
In-Reply-To: <Y+ZNL4o57lCrmwpb@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN0PR11MB5988:EE_
x-ms-office365-filtering-correlation-id: 279e1baa-3072-4184-e3cf-08db0b884233
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UuWpkhkBkFSVSkkfg78oK3UWwT7IbRbGXz5C6F9rocqa/n0b7Ug1cYUAPXvMA3vXE7IO4tXHT8d2QsezI7rWhLIvRgEhBsl9RW2j0fKS6feOy2IoLNwqYXBxwhYCtVeXhhZL7eREojuVS2NKzE42FhzgSgQzIuZ+Pml6e8Qf4HvhMJCd9M32eqte3a36w/fSnryO1LVv9N2gHailfgiIeJLDlxVCz+WvSw30XEBWyWeXKy8t3VQYdm93eEmgpZx6+CIfZhNVcIuB52DVF/KHt3fmqtIPJ6WhCrLf9/AV+4uAzJFtxZRERPM4xqbxRaKhXxxFG56zcYqxSQNGcvoIeH8mXKlNWOtUBs3c4fP8NXiKQDaS1+qyCsMZNc7Gjozpm82BTimTZTfVcLx9+uQ3vnwBj8lbAWYFogTFx1FO3lmXQM4t/k0AhCR//VfKjE9/UJwOoxUTQNH8vsPbfTDpbUntdflXQtT17HHlGe7XNYpbHvBS1rOlgGYDkQPpdugwy/57OrZ86ZJAK2qywlMKWvWGL3UcoHAMWxPes0ZIzNGrOU9nYC0eLqsMLP94TcwtlsZ4whqedD63KOXeohk4UY5rupU5Js/yssH/5Iq//NI1hLbYVUJwiD2buN141QG/1ujQnX5cUs5vxkPuc3wFYlXZ+ysGrjwCMNnw3HACBxdumyBpqAbHOQDEhdg/sOXytm/QN3Oa0caO2zxHv3t3JW0v8H6oweBPPlI6ESpx8qY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(91956017)(4326008)(66446008)(8676002)(6916009)(82960400001)(6486002)(64756008)(54906003)(316002)(8936002)(76116006)(66476007)(66946007)(7416002)(66556008)(41300700001)(7406005)(5660300002)(36756003)(86362001)(38070700005)(71200400001)(478600001)(122000001)(186003)(26005)(6506007)(6512007)(2616005)(2906002)(15650500001)(38100700002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODhSY0ZZVWpDODlaZnkxb0kxMndhbUJXb3FSNW1pcE1IZHc4T3ViNktnNEF5?=
 =?utf-8?B?OG1Bbkh1L2kxci9pWHFFQ1lpWVBnT09uS25Oc1V6aWcvNk9mOTJQeVhneHVr?=
 =?utf-8?B?a2NMdjlqMmVRWnFsN3BkS1RqSFNYKzlLcnFZSzhGWDdWa3NRMXVGbzJMaFV0?=
 =?utf-8?B?VTVjc2N1QjZVT0NGWmJReXBoTkxubkUyTTZMTitQZDk2QUpzQnNneFV2RG5O?=
 =?utf-8?B?ZlByZWhzc2tIRzAyL3d2S1NhQVJMRjRYT3gzd1dPelNBOUl6Ri9JWHJSU0Fk?=
 =?utf-8?B?NlFrazczQm95dkRyN0w5SStLWUVUdXY3Mks3ZWQycUpyS2lvVGFBTnJIWFVF?=
 =?utf-8?B?a1h6NHZGdVN3N3hRWHBGdUxYWWhKWDJpRlZUOTBNbXdZdStnVFNoU0pZOVR4?=
 =?utf-8?B?Sk8vNUF0MzZWbEVwTHRpWTdITitPSmlUaDJ1ejluS0NXbGQyR1BhamlmdUtQ?=
 =?utf-8?B?ZFdDN0RTSi9VSHhBeStMNmlMaWRxb21HY3Q1VDZmaTdCbUlMd0R5WTdWeHJi?=
 =?utf-8?B?MjU5eE9Jcm1ZZE9RSGVVeEx2ZTRJV3k5RDBwUnVXUG5IWFQ2VmczaFhIaFkv?=
 =?utf-8?B?Q0kxRFVpVnF2VVgvZm1jMlIwYitOb0pOS2YzbnpvQ2pkSjN3VnU2WUtoQXhv?=
 =?utf-8?B?L2hWS05leWp2VCtmTjhjT3lZRkNVNmFibmRiaUU3V1AzRlJKQUY5a1pwYXdx?=
 =?utf-8?B?bS80bkc3OEplOS9nNE8vMENXakcvMS9uQmk4cHRoSjkvWS9PZXZUOUpOZ2Vx?=
 =?utf-8?B?RW82bWU4RVJkNnV4eWxrYXZUSWJ4L0dscEs2VFBTZEl6UWhNaTFlYVpkRUQy?=
 =?utf-8?B?azJVN1hIbFIzcDRSRUdpZ0I0YjRpOW1hRWdUbWhBREFIOVdWSDNaZ1lVVXcr?=
 =?utf-8?B?dDJtQ0VKNWJndlFueHRTRUpRam9CcmRUaEN0bEN2QnJKd2V6Q01qU2JuZkF2?=
 =?utf-8?B?ZnJkT2Mycjh2dmhJUk15Y290a0h1OGtyQ2VyWnl2SHcvWE5kb2F6bmxxVUl6?=
 =?utf-8?B?SjFGNS9RSnAvdit1ZEtROGVTb3FHMzlxdXVURkMzdndWSm9CdHMyUjNhbnZz?=
 =?utf-8?B?VUttK1dMdEdYSnlUQzdNZHZzZDZYRGRjWFZ1NHJXV3JBSWc0OFg0V01wWTk0?=
 =?utf-8?B?eWUwVFBxQVBJWkVmaFVLcUgzVDkvcXBwSWw1a0JUZCtCbXZDVFdJMDRXS0JN?=
 =?utf-8?B?d2JMOFN1SXQ1dkhsdWI1TzJwTVFYYmpYVFRvOHJKc1NFdlRkeitkbFhXSXBI?=
 =?utf-8?B?OUR0ZUc2RGlSb3EvVG1qSGc3WkVSbkJTVkJNN1NqMzhOMFdNNkJkQW1iQllX?=
 =?utf-8?B?MWlzMkpTNmtmUHlONlIwa29MVGFjZDZNRTRsODlTM21DclFWdGlicHJjaERM?=
 =?utf-8?B?OWlQUG43NFplL0tSVSt0N2NDd0p2TnJkSWZmUnpOT2ZmRGN3SzZUUkFQNFRY?=
 =?utf-8?B?REdyTTdKUWtYM2prNVdob3BaWjQ5MTFRZUY2eW9sU1A3Mi9Qbml3L2FBd1Q3?=
 =?utf-8?B?MTlJMkpiN1JtaFNraEdpaEN0cFIvR0t5dm80Z2FWREh1K3crKzlLTlB3cGMw?=
 =?utf-8?B?R0JpU1NJcGcwdFhWaTY3M2k2bEdRL2cvaGVVamVnSTVUakM4dHYwNk8vLzRD?=
 =?utf-8?B?NXdxcDB4K04xVzhWNmhqc1pucEo4OTJKaWR6VC9aWUs2YUFIMUJUOEFlMDdz?=
 =?utf-8?B?UDNUbWZnSEdqMldMc3p3ejUyY2V0em1kSDdLOEdGczhCQit0SzlyQ0hER05W?=
 =?utf-8?B?QmdNV05JNGdQODQ0RjlZMG1kczNDd01mOUNFdTZ6V1drSHFQZk9yZTZvMytD?=
 =?utf-8?B?K1IzeXhnQmlrcFZ0Zy9rTEcyUWoydDNBckh3c2RrUnRtWlI1WjVUa1VVS3E0?=
 =?utf-8?B?ZTNHcFBzYjRyb2w4VmZNb1NYb2ZHczJ1YTFwRW40eFZrbDV3MmNQeHZWMlpw?=
 =?utf-8?B?Q2NEalNaOWJUVlNtMXp3K2d1WGJ1czJyMG94VTBIWmN0VzNwemVQd3c5Rlhu?=
 =?utf-8?B?QW42MU5renRST3UvWmU5ZlRlUUh1S0FURnhicGV1RVpuTHdxUVY1K296NThU?=
 =?utf-8?B?MWpGZTlKek1CTTRjUEI3bEVlMWlXU25pNzZiU0VDSmdoZHd6QjNweXZBekVl?=
 =?utf-8?B?ZVFnbytIVi9LWE1RdHhPVDFQWUhjN3BhRXhDOTVmZm1IQ0d4UENIcldNN3ZK?=
 =?utf-8?Q?j/q8rKBqWhoqlKcrG0m8t6c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ECEF16CF1F9C94CA20E4451FCC8539C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279e1baa-3072-4184-e3cf-08db0b884233
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 17:00:05.7055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nKMhEh7Uu4FDEkM0UpO2sf9d6+VC3X7fAe6HJnsV27s5sg3w/ZuHim3OMqljleY0XeRqCzfGIOEEiudbwKTsrGd+DJIoFIpzjBcJLj2k68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDE0OjU3ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IEBAIC03NDksMTQgKzc0MCw4IEBAIHN0YXRpYyBpbmxpbmUgcHRlX3QgcHRlX21vZGlmeShw
dGVfdCBwdGUsDQo+IHBncHJvdF90IG5ld3Byb3QpDQo+ICANCj4gICAgICAgICBwdGVfcmVzdWx0
ID0gX19wdGUodmFsKTsNCj4gIA0KPiAtICAgICAgIC8qDQo+IC0gICAgICAgICogRGlydHkgYml0
IGlzIG5vdCBwcmVzZXJ2ZWQgYWJvdmUgc28gaXQgY2FuIGJlIGRvbmUNCj4gLSAgICAgICAgKiBp
biBhIHNwZWNpYWwgd2F5IGZvciB0aGUgc2hhZG93IHN0YWNrIGNhc2UsIHdoZXJlIGl0DQo+IC0g
ICAgICAgICogbWF5IG5lZWQgdG8gc2V0IF9QQUdFX0NPVy4gX19wdGVfbWtkaXJ0eSgpIHdpbGwg
ZG8gdGhpcyBpbg0KPiAtICAgICAgICAqIHRoZSBjYXNlIG9mIHNoYWRvdyBzdGFjay4NCj4gLSAg
ICAgICAgKi8NCj4gICAgICAgICBpZiAocHRlX2RpcnR5KHB0ZSkpDQo+IC0gICAgICAgICAgICAg
ICBwdGVfcmVzdWx0ID0gX19wdGVfbWtkaXJ0eShwdGVfcmVzdWx0LCBmYWxzZSk7DQo+ICsgICAg
ICAgICAgICAgICBwdGVfcmVzdWx0ID0gcHRlX3NldF9mbGFncyhwdGVfcmVzdWx0LCBfUEFHRV9E
SVJUWSk7DQo+ICANCj4gICAgICAgICByZXR1cm4gcHRlX3Jlc3VsdDsNCj4gIH0NCj4gDQoNCk9o
LCBJIHNlZSB3aGF0IHlvdSBhcmUgc2VlaW5nIG5vdy4gRGlkIHlvdSBub3RpY2UgdGhhdCAgdGhl
DQpfX3B0ZV9ta2RpcnR5KCkgbG9naWMgZ290IGV4cGFuZGVkIGluICJ4ODYvbW06IFN0YXJ0IGFj
dHVhbGx5IG1hcmtpbmcNCl9QQUdFX0NPVyI/IFNvIGlmIHdlIGRvbid0IHB1dCB0aGF0IGxvZ2lj
IGluIGEgdXNhYmxlIGhlbHBlciwgaXQgZW5kcw0KdXAgb3BlbiBjb2RlZCB3aXRoIHB0ZV9tb2Rp
ZnkoKSBsb29raW5nIHNvbWV0aGluZyBsaWtlIHRoaXM6DQpzdGF0aWMgaW5saW5lIHB0ZV90IHB0
ZV9tb2RpZnkocHRlX3QgcHRlLCBwZ3Byb3RfdCBuZXdwcm90KQ0Kew0KCXB0ZXZhbF90IHZhbCA9
IHB0ZV92YWwocHRlKSwgb2xkdmFsID0gdmFsOw0KCXB0ZV90IHB0ZV9yZXN1bHQ7DQoNCgkvKg0K
CSAqIENob3Agb2ZmIHRoZSBOWCBiaXQgKGlmIHByZXNlbnQpLCBhbmQgYWRkIHRoZSBOWCBwb3J0
aW9uIG9mDQoJICogdGhlIG5ld3Byb3QgKGlmIHByZXNlbnQpOg0KCSAqLw0KCXZhbCAmPSAoX1BB
R0VfQ0hHX01BU0sgJiB+X1BBR0VfRElSVFkpOw0KCXZhbCB8PSBjaGVja19wZ3Byb3QobmV3cHJv
dCkgJiB+X1BBR0VfQ0hHX01BU0s7DQoJdmFsID0gZmxpcF9wcm90bm9uZV9ndWFyZChvbGR2YWws
IHZhbCwgUFRFX1BGTl9NQVNLKTsNCg0KCXB0ZV9yZXN1bHQgPSBfX3B0ZSh2YWwpOw0KDQoJLyoN
CgkgKiBEaXJ0eSBiaXQgaXMgbm90IHByZXNlcnZlZCBhYm92ZSBzbyBpdCBjYW4gYmUgZG9uZQ0K
CSAqIGluIGEgc3BlY2lhbCB3YXkgZm9yIHRoZSBzaGFkb3cgc3RhY2sgY2FzZSwgd2hlcmUgaXQN
CgkgKiBtYXkgbmVlZCB0byBzZXQgX1BBR0VfU0FWRURfRElSVFkuIF9fcHRlX21rZGlydHkoKSB3
aWxsIGRvDQoJICogdGhpcyBpbiB0aGUgY2FzZSBvZiBzaGFkb3cgc3RhY2suDQoJICovDQoJaWYg
KG9sZHZhbCAmIF9QQUdFX0RJUlRZKQ0KCQlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVB
VFVSRV9VU0VSX1NIU1RLKSAmJg0KCQkgICAgIXB0ZV93cml0ZShwdGVfcmVzdWx0KSkNCgkJCXB0
ZV9zZXRfZmxhZ3MocHRlX3Jlc3VsdCwgX1BBR0VfU0FWRURfRElSVFkpOw0KCQllbHNlDQoJCQlw
dGVfc2V0X2ZsYWdzKHB0ZV9yZXN1bHQsIF9QQUdFX0RJUlRZKTsNCgl9DQoNCglyZXR1cm4gcHRl
X3Jlc3VsdDsNCn0NCg0KU28gdGhlIGxhdGVyIGxvZ2ljIG9mIGRvaW5nIHRoZSBfUEFHRV9TQVZF
RF9ESVJUWSAoX1BBR0VfQ09XKSBwYXJ0IGlzDQpub3QgY2VudHJhbGl6ZWQuIEl0J3Mgb2s/DQoN
Cg==
