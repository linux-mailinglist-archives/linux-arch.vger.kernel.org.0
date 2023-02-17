Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AE69B16E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Feb 2023 17:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBQQxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Feb 2023 11:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBQQxr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2023 11:53:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81643B845;
        Fri, 17 Feb 2023 08:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676652826; x=1708188826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w11FCLMiVeJ40Y1C6HOYdpNdSklwQag3dmXkwZAXoIU=;
  b=eYWZJfjY32SDAV6GhukjGrIJKRQgX+DQ+TA/mwgILCr9YOzTSlMwBvMK
   /McZIngAOMemFsEoWFSfLVbKs4tTJ4k3qQ/1FQZDKCpZoEsaDw/4/zihh
   6Rb7kVAWQGG2XqHkvrfdUpIDXZ8AM4C055tKXH/rMi0EuCyp0oojxKKNS
   Za+7LndG2RWTBTmtcXZmxpGiPC97vS7V3Owz90XA6OP/HZAHPn4llv6eP
   BRAZKhzArx/EdxZGzEf7riI/KwXYNAI7dwXqtYzeu6h6SoOxQrkg/izVb
   pbZNunKn/H6YmRvWDyfTrPVabFRZbz4BZxrwe0YHjOAEzFhQfRCk8AFkT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311659948"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311659948"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="663921559"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="663921559"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2023 08:53:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 08:53:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 08:53:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 17 Feb 2023 08:53:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnuUpeems2Ctv9jKGoTJyr0crx/uUIgFRIXSSgoDZETwBPmtKWeFbs+jki2EaCATvCB7rRDZTYsAgNQ48thjAlddbYspRNkKgZlw2peDaOQhOvNkofTjR0W8fvB2mmaSlr2Fm0anymvuq9mRTYMvPM3lilUWwV7IiKA7c1IzsR1QHryeeWWZM6cgA8gQonOjbyJG7GiJrS4q1k3DfREgFSCS7qhsrE2etVFLjLN+tR9LAe5yrQcaiowDxXJKVKtuKusqGinTBIXLBB2v+QvJRhdUQrZrdYxPHvbP9FqNMCE+W0tvs8kmzmC3uroTG18m+ljBIBSbeQ+zDazINxayUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w11FCLMiVeJ40Y1C6HOYdpNdSklwQag3dmXkwZAXoIU=;
 b=hLIfBWZAUvF0wnIsEB2NvMyUs5lObwhUOdMo7zALPvcTBsAS0scnlXz5GBc2I/zs/4nEGMo+0gM/chJY8f1tAJmkccbfNHPtJkGnleGd2WzPnGmG67/3AkWrbyhW2lmMUzKjGAstHzMf7LkvfI4w2vdbNHUp5GPK/GaL6wtUUz3sutk4AXhxArCtJB5EVBNJBjhdx66QUzAFk5rI1l+UwUXDTH+5G9I7vXCPwI7d2Unz3zI1g/N+RsU2dfcdOOQ9F+cjSjcdvfGPWzgTnPH/19mFu1Jb1So8UrJbSGqS4RW0pW6Og10vWQciSmd6EelDClMsMQogMBHoRSJNg0symA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 16:53:39 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 16:53:38 +0000
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
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
Thread-Index: AQHZLExwXsVvVi7azU26l2oZqLTgOK7Gx2uAgAAydACAAVyjgIAAMyIAgAryxoCAAAu+gA==
Date:   Fri, 17 Feb 2023 16:53:38 +0000
Message-ID: <53e114e06a82ed587ef566d07e95390b2e7a036a.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-12-rick.p.edgecombe@intel.com>
         <Y+T+ZxydCZS1Yjmz@zn.tnic>
         <49d20fcd197e85e8475f5170db78780f06396cc0.camel@intel.com>
         <Y+ZNL4o57lCrmwpb@zn.tnic>
         <15c76808ac5975df2294d0c7edf0abfe8587da2d.camel@intel.com>
         <Y++nN8x08RopoWJr@zn.tnic>
In-Reply-To: <Y++nN8x08RopoWJr@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB7351:EE_
x-ms-office365-filtering-correlation-id: b349a922-d3ac-4210-cd41-08db11078464
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3/q/nxU2IpkKGn+NGd/UfPMAsv4X1CmJJnn9kB1VeJkYrqPSCM4BE4OIr3fyS10vAiMgVRUyBmX4W3fcvbSSXXfDFbKXm+uB/xw5KnTET2//WPJo9H0n/ZifdmiCZ+FKo8YjS0eZle9ZZxK+HsGmbCxlmIe/v34xq5ZCs4nWWlcNmyqwf/1ENlrV/JNBhDCZN3YBeAs1FIYvyDlCgFYQYD1ZzOrwkaXvc6RHRZ4HolOhtFpdgcftL251mZKRk9Dv1i3Ph2RnVa3gbehNApb6nT+XMQXglWLNsAiXgFT4uUyi9qF7rNK6bmPF+XtsHXpi7Ona7tilZm4F+4pHzkvjfExmpAc4Z0j/vYzeogmhyhEL7Fgr1ZyO9VEc5YmYzDqW3XsQDnu14xY3E1IFEa7DBk03CPr1XorpSdvRniTdejgTPvTaxJ3q36GIT8EiWRWCwspHe9OkhkEF+gZd4tiKJmyGgIxOMlBhXkyKmShWB5GgpZEuaBXFnFDi6BuVBkhkJnXGOijiqLOMkvqjfESu7293Vp9GrqswFGzh/W+hpINgO4CRrtFjZGBgLm7Z/hYwQwOfr/02NXQQRRgaUwl6s3jBxr706XRypQnA75CUaa2e913CyAdN4bLlxkNInCyj5k+QF3mZ0U7rDMaQE8lmTdeqKlrejDn88feRl4XdMHae9SHWRz3LgrrCyTBXliH/zbgDAYUfSDulB55rlW9+nLIm2Ug4/xdOxD6ndKgw85A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199018)(36756003)(38070700005)(86362001)(71200400001)(91956017)(66556008)(66476007)(4326008)(66446008)(8676002)(6916009)(64756008)(76116006)(66946007)(83380400001)(316002)(54906003)(6506007)(2616005)(26005)(6512007)(186003)(6486002)(478600001)(38100700002)(122000001)(82960400001)(8936002)(5660300002)(7416002)(7406005)(41300700001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXlaWkYvUllBUjVKTEllK255MHIxeko0VEptUEc1OWdyUDk1UG1FcDN3M1N4?=
 =?utf-8?B?L2J0TjNERXJYcWpyRnZscHI5cElXRXFlK3RPT0x3N0w5VUQ4dVlGbk1EVTFS?=
 =?utf-8?B?Y21leXlPSjkvcXMyRDlYeG81Y0R1NFI0TDZvR1c3Y3hrUUZXcVVZblJTc0k3?=
 =?utf-8?B?MUszQ3R3YmNrcTZNNSs3bUIrTHZlMVhJbGVwWms1bzRSK29vSWhUUnFHZTQ0?=
 =?utf-8?B?VGZXNXl4d0lxVDI2YXRxOTlLenpEUEtia3BOM1hSZ01jQThqQXZuUTdWTlNF?=
 =?utf-8?B?WVFQQ3U5eG0vblVlU2dxd292WnQvSE5hdmFFdmVDaVpYUllMV3JLRFBYaWNK?=
 =?utf-8?B?Q0RNTXM3aEtnUVNMNDFhSVR4N2lQbDZpV2UrQzErL0RWNVZoc2FFSUFnd0px?=
 =?utf-8?B?djJ6WllTYXRlUVZxTG0rTmpURkNRUmE1WHBZZjloV0gvcmtEbmZjbEprZCt0?=
 =?utf-8?B?M0hoU1lKSTlUelhPK01ySnR4NTVhRld4RjNoSHRMS3Uyb3I3eE9ROThQb25k?=
 =?utf-8?B?Q2ozOENRUEw0Y1p2N1NsLzc4cU9GOGVzS0FCQmRJZ08wWGE2NlZaS2ZQRW45?=
 =?utf-8?B?ZDduZ1UzVWVzWVFESlVJendmT2NYSHRWM3crT3d4bmxzcXNNZzZ1blp5aE45?=
 =?utf-8?B?VDFMUUVBS2FFUHk5TWtFTTNOeTRSSkdkWTRScUMycDcxU2p2N2toVmZjdTRZ?=
 =?utf-8?B?d1Z5UW8wT0hadzgvR1VaSHV4SVEyY2JBT2piTzVXNnVXV3BXdU5IY1AwZDRF?=
 =?utf-8?B?aXl4SFRMWXJsUDZ5RFFDOWNEdkRUM1BFQWN6Y254MDAxcDU5Zk9xUy9yYmw1?=
 =?utf-8?B?OUFPQmFBWllxQnJySExCUHBWVTNuWFRLc0dNZmFmbkJvUU9KdDlETHYyS2hP?=
 =?utf-8?B?QWdkQWlwMmN2Nkh6SCtTT29sVVV1bVpjL05RKzU4cTl0R3cyR09xUk83L2hB?=
 =?utf-8?B?NlUzbEUrUzdGMXpGbjEwUkxYTWpIdWN5LzZyQjM2TjZveVlJVnhYNnZhM05S?=
 =?utf-8?B?VkczSWZ2TnpGUCtva3hQTHhmYk5vUklFcVRLZ2NaK1FKaFFVcWVsNktqS1Fv?=
 =?utf-8?B?eVp4cjNsR2xjOWNkN29uN3pEd2FCVUlLZDdDZHdFeVlicTVaWFFVQXI5UGZZ?=
 =?utf-8?B?d0tPbFdHeHRxdC9HcDl2NmRNcFBnT1VyZFg5dGNpVFFYM1ArTTdxZlRjN21C?=
 =?utf-8?B?NndyMjFGMHplNHhqeTQ3UFlEWWs1Z1JqbUdLK1Nsck9DRFlMdStQUWFwQ2Rk?=
 =?utf-8?B?YzdyVHhsOTFVQnBZblIwR1pJeUVLRFVQNmdPSVM0eWZvdlVMd3Y2ZWJKMnFG?=
 =?utf-8?B?R0FJMW53OHdNOWhoQ3RlaThnbkpoRE1yZitEbEhrVVdJa3EwSWQvbDQ4aU4y?=
 =?utf-8?B?RWNoSU9FR2R2Sm5uVzlKemlHREhKK1lQaEZWVDViRmVQUDc3NnJSMm1yVUpw?=
 =?utf-8?B?RkVxSWJsQVdEaXRyOEVURG5PeU4xbERUNEo2T2xmcytxSlZCb2doNGtjenV1?=
 =?utf-8?B?OE96TzN6UUZlWnlNYTBGKzdqMGZ2TjFTYjQ3MHAybnU3RTU3UEZ3b20zc2NE?=
 =?utf-8?B?ZVRMbWNPL1FBZ2RuNHlTWjVXTlRhMGlSaDlHT0l1RWVuNkVhVyttOEhsdGF6?=
 =?utf-8?B?WTZrSTlCb2FucHJYY3JPQk1hWHd4RCt2ODd1RmtxRmovZE1xOEtRNm96TUJX?=
 =?utf-8?B?M3A1Z0JlcTBBYW55RWVhR01XMElxWVdnOXkxZUpFK2thV292dUJqTEg0bUxu?=
 =?utf-8?B?eFgwRnp2WUVqMlBQWCtuVDNMTDNKNXl0UXJjOEM1TXFhOFUvT2NxdHpyZE95?=
 =?utf-8?B?ZlV2RU9FNzMxREhQZ3g2R2RNY1BYVmJYWkNtMEhJQ3JFNzJpQlRmTFZlTWE4?=
 =?utf-8?B?azRZMTdtYmNqU2prL25JQ0ExUEsyaEZ3dmhWaDRqend0TDFuaGRoR3BYSi9E?=
 =?utf-8?B?aXVXQklwc2g5bk1lcjFWeTUvRHRQNlZnb2VFRU9BK1pSd051c1h0Y2tZL0Ra?=
 =?utf-8?B?a1V1MlUvb2w5Zml2QUZyUDkxdjJHWSsyL2k3dm1XclFFWFRVRTEzUTJpTUEz?=
 =?utf-8?B?N2lWdWxacjJ5UTZqbVBvMW41bDgvYlJYQVZ3TzVZTkFGakM3U014aDNqS0lG?=
 =?utf-8?B?Y3hBMWZ3YUp2QzZRUVVudUtSM3E4TSsrMGxvL0Qrd3lTN3ZsL0hZRXNlMmd6?=
 =?utf-8?Q?1lV1v5ld1x8746QEg4mYXbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EB388DF165FEB409CFE93D723637A40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b349a922-d3ac-4210-cd41-08db11078464
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 16:53:38.6542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iuZY90oTQ7kyZ8xXsT5vRAmvzK+1MxuA32efYiFCKn/eEoNxPOanPbY2cSEdPxdwFUd0avt7eHkNyfXbex8HWyxn38S2/URgq3jPfPS0Y2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTE3IGF0IDE3OjExICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRmViIDEwLCAyMDIzIGF0IDA1OjAwOjA1UE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+ICAgICAgICAvKg0KPiA+ICAgICAgICAgKiBEaXJ0eSBiaXQgaXMg
bm90IHByZXNlcnZlZCBhYm92ZSBzbyBpdCBjYW4gYmUgZG9uZQ0KPiA+ICAgICAgICAgKiBpbiBh
IHNwZWNpYWwgd2F5IGZvciB0aGUgc2hhZG93IHN0YWNrIGNhc2UsIHdoZXJlIGl0DQo+ID4gICAg
ICAgICAqIG1heSBuZWVkIHRvIHNldCBfUEFHRV9TQVZFRF9ESVJUWS4gX19wdGVfbWtkaXJ0eSgp
IHdpbGwNCj4gPiBkbw0KPiA+ICAgICAgICAgKiB0aGlzIGluIHRoZSBjYXNlIG9mIHNoYWRvdyBz
dGFjay4NCj4gPiAgICAgICAgICovDQo+ID4gICAgICAgIGlmIChvbGR2YWwgJiBfUEFHRV9ESVJU
WSkNCj4gPiAgICAgICAgICAgICAgICBpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVS
RV9VU0VSX1NIU1RLKSAmJg0KPiA+ICAgICAgICAgICAgICAgICAgICAhcHRlX3dyaXRlKHB0ZV9y
ZXN1bHQpKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgcHRlX3NldF9mbGFncyhwdGVfcmVz
dWx0LA0KPiA+IF9QQUdFX1NBVkVEX0RJUlRZKTsNCj4gPiAgICAgICAgICAgICAgICBlbHNlDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICBwdGVfc2V0X2ZsYWdzKHB0ZV9yZXN1bHQsIF9QQUdF
X0RJUlRZKTsNCj4gPiAgICAgICAgfQ0KPiA+IA0KPiA+ICAgICAgICByZXR1cm4gcHRlX3Jlc3Vs
dDsNCj4gPiB9DQo+ID4gDQo+ID4gU28gdGhlIGxhdGVyIGxvZ2ljIG9mIGRvaW5nIHRoZSBfUEFH
RV9TQVZFRF9ESVJUWSAoX1BBR0VfQ09XKSBwYXJ0DQo+ID4gaXMNCj4gPiBub3QgY2VudHJhbGl6
ZWQuIEl0J3Mgb2s/DQo+IA0KPiBJIHRoaW5rIHNvLg0KPiANCj4gMS4gSWYgeW91IGhhdmUgYSBz
aW5nbGUgcHRlX21rZGlydHkoKSBhbmQgbm90IGFsc28gYSBfXyBoZWxwZXIsIHRoZW4NCj4gICAg
dGhlcmUncyBsZXNzIGNvbmZ1c2lvbiBmb3IgY2FsbGVycyBhcyB0byB3aGljaCBpbnRlcmZhY2Ug
dGhleQ0KPiBzaG91bGQgYmUNCj4gICAgdXNpbmcNCj4gDQo+IDIuIFRoZSBub3QgY2VudHJhbGl6
ZWQgcGFydCBpcyBhIHNpbmdsZSBjb25kaXRpb25hbCBzbyBpdCdzIG5vdCBsaWtlDQo+ICAgIHlv
dSdyZSBzYXZpbmcgb24gZ2F6aWxsaW9uIGNvZGUgbGluZXMNCj4gDQo+IFNvIEknZCBwcmVmZXIg
dGhhdC4NCj4gDQo+IA0KRmFpciBlbm91Z2gsIEknbGwgYWRqdXN0IGl0LiBUaGFua3MhDQo=
