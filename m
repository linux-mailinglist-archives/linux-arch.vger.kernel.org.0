Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B95FF37A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 20:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJNSPh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJNSPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 14:15:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5893F1C8;
        Fri, 14 Oct 2022 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665771335; x=1697307335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R+IGJQH9dJIzbpqrcDh0mAK53FoQBussez228AB4QOk=;
  b=DHp4kmP/pSLhswqFdtOpi2eeotYVoHQkSq3Nwd2cxKBV7k69jS4wx4Ja
   FYWizwncWIiC/bvWaC0LPzKZtS0G39GrCpFxpYsXjuUg3a983YCP5Re6V
   5v8AkgVBWWbM0hML8B1sOzyj6cgnyKgV7aYKHBVuT0aQoV7ZTmssHoTjo
   4KS/BYU3T48MH7Q0M+4rh6PQO7xCNPL2BO+xEw6IpSgL7DbAKqMpEBdt9
   gYzhmmzAuxtl1nGjW1JD/zPjieuTutTTyHZIBmwBRx9YsRm/JnVDMpT6X
   +EHeNM3OEHgysRKPOE25fVbZDOP5mhr7XEFZqBY5oOCONy+3MR5vU1mre
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="369635484"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="369635484"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 11:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="578717983"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="578717983"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 14 Oct 2022 11:15:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:15:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 11:15:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 11:15:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZZl5VfvGkjCabJpg2jnmkhOHwIn2M7PQ+YdG6ZC9anvkDjQZwFFp4d3/VT4kGWeF7oSDJuG1Y5W8aAtDNajVSq1Mgt9KeQ8V8POemDYtRZaFQ7W+IUltflgF9TL/TpGtQ9SBP2hNf+Rv+paUlETG3jjOq7fhj3qtMgu19tG85NyoIxvYI8U+0gnVUFytteT1gbIQIXPx0JwY+QvMkaFL69FsTuThtlPOHAAM8mIhvlUnQxcEcpOrWPtfOdHJXtiPhwdPguvxrjvYpv+aSM2IYXLtzmQr+rTvq0QIE8UH/mSG+60WrQ9WHOaNOgE8/9nZcEXvvwU/z2/anPkEt/4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+IGJQH9dJIzbpqrcDh0mAK53FoQBussez228AB4QOk=;
 b=d228Tpn49gazbggu2HE7lGCA7hwmu4rHRe0kcCY/UmTe7ypNuZxMmZ6nGLTyzNCi3KGCEc3MlPPehxxXmqVQP0kTGaew+0jCDTALzg+8Ys2G1Z+nvQTm0sZGCAlAmzdNmiI84rz0hOlmGH+3Xqgdn/v497QXJpIkVp/pCykiLP0ZNmyFmO17QEBjBccvXRbpsOPxTno7/3/Hm7QFsngjZ5aPUqthpXOxCJL18/JqXjTXp0bJ0BtlJgjzJiumMJomGCaprLevJMnYQEWHMAyEBrFu5X+gzs2IkugLNfNL02tWaCYZ6hKZwnI74mii1SWOWvD3oKnYUzJo7cWJxi+VUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 18:15:30 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 18:15:30 +0000
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Topic: [PATCH v2 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Index: AQHY1FMGtt5713/v+0S4tsCR0wHCkK4ON6+AgAARjIA=
Date:   Fri, 14 Oct 2022 18:15:30 +0000
Message-ID: <1f9e89ae13b49ffbcc947bf6bdee0303387c5cd4.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-5-rick.p.edgecombe@intel.com>
         <Y0mYib7ygyxbiZ2K@zn.tnic>
In-Reply-To: <Y0mYib7ygyxbiZ2K@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL3PR11MB6508:EE_
x-ms-office365-filtering-correlation-id: eae5b330-c786-40df-f32d-08daae1013d5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cKKNyl7tMsPIqqHftsj20h9snfDx43qtaslInB0HaFgvhFoB/5c/Aef/YCUjvebKVTFsUwGW/1alb06IbejUh40afskj2LrPac1g7Me8np+lyQAgDxqZLDpX9eI/zMt5n2TXGVb9dZ/Oq82ofLnUUmgi5jj7ngsk2OGHYj9AgTy9OkE8okzZvVIlKcxPKt2LO4R8QUiiAjxT4aYf1p+V/8zQ6s3m2LhLNzgfQATCClOyH/Ar4KmEAXlP2h74tCWwlaP17snlF43Wy3wCcjHqz1JpKnxZDy/fFqcFpXYfiFTeDzwhr1HuATfFOIdhHwKxJ46M1tWFenEe6RmdSrTXp4oGm2wOJ8ggp2YffAIkfkqnXR0ZPCQTA3ewZtLJJLz1PLzJZpq5+gaPOpEYYgjnddu/cFvi2JiUi6aAzLse2ogVWHR66crrXBEZCuUldN+fHLeB4S1N/hhSzJxDmUhDahCWqill0f2twbcH6Koh/wnw1Ay1pvxGEQsJV+miaBXFt+73IHkP5mgXAK4xC5nXYcDy/9ZCwGMX52pSrKUX8QOLA0ooYX9xYvrZ4gM7iWysZIakHf4rp6mvmLQrh50GzmjSm2dQTbCRFJDMHg/xUV48DT3GY4/iMtUlClNumvDjx8wgxIlhA8Hjnyhej1oTONcTQ52dUijio6iA+iK9qNdkwQh4Dtb9uTFEET4h3fjyaYIOoVK9/jHpAAFO/LBaneK+NDK3zO+QA7GTBi6SD7OgNYxeowqladdz7Jbo71ci1knG5dROHUy7mBJ4W0E8DqvRYN/W+IxAxBws1mAUwCzjk2PpGlzEQYySDHFcrEIa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(41300700001)(8936002)(66476007)(66446008)(66946007)(76116006)(8676002)(91956017)(66556008)(54906003)(64756008)(6916009)(86362001)(186003)(36756003)(2616005)(26005)(6512007)(122000001)(4326008)(4001150100001)(2906002)(316002)(6486002)(7416002)(38070700005)(6506007)(82960400001)(5660300002)(71200400001)(7406005)(38100700002)(478600001)(99106002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejZwWmlSeVFiYTB6Q1NSQzJBUzEzWlMvd3NpVUhLck1UUkgzcWtlektoR1ds?=
 =?utf-8?B?cVI3Rk14NHJjTTZma2prS3J6bWJZeGhoR2ZkRGZjS21uYWJCcytBcW5qRStN?=
 =?utf-8?B?WDZ0ajgrdUJVU2FxSEhuSCtxRGQ2Rk1iSDJGRTEveVc0V3djKzZOaWJFeEhk?=
 =?utf-8?B?N3ZlUzhLSGpOVU40bFdYQ3BLTFpwOXQrb2VhdVdubjRCb0NmRGdIb1I1ektE?=
 =?utf-8?B?aU90OGdqRzJnMStQN2JlRkY5YUY1MlpCWW44ZDUyZlhwMGJDVldySVNiRXMw?=
 =?utf-8?B?QXY4L3NWNzYrRmVUSStnaXNseWw1cjltY2ZnckZjZjhkK3lVbk85clJRRjQ4?=
 =?utf-8?B?VWFiS3dMeVZOd0FMTUpnNjViaCtiV3h0NkVhcHppaTZsdGE2UkZVWnhZWSts?=
 =?utf-8?B?SmxQUmRDZlFyQWdhVE91TTRKc2RzWkE0ZjZPQkdhVWl5d2hWWWNpOXBkWGRy?=
 =?utf-8?B?QlRSU2dWVHFDb2JURFZ1ckwveEFWdlVLMFRLNFoxVWorTTUveGFCei9USnM1?=
 =?utf-8?B?R0dEall1SVczNXFBZUc0V09yOU1tU2M2a3FpaWxyYUE2KzBvVFR3eE5DZ0dH?=
 =?utf-8?B?bDdVNUY1a0pxMHBxejg4eXdRUmZZNVFPWEExSUZxMm14MDRhRHVQVFJpanZo?=
 =?utf-8?B?a3ZyMk80WWduZFROWFpXOXdVQVZBMkJyQkRrNG5HVjJjVHIxRXNEVWlhSm5O?=
 =?utf-8?B?UVE0a2pXemRmUVV1OEpRMDBLc0haRUlIUVJ0eE9SSVRwT05wNHJDV3h1cHp5?=
 =?utf-8?B?WGZVcFAzQnZ3U2NUY29vTjl2eEk3MEt5eGtvbUNBZ3BzWm1XRUpqUUlOWWhr?=
 =?utf-8?B?N014Q2RrNEJsa294OW80R3c3K2VRa2ZaOWlKL1NGOS94aEtYZ3N5M2hFa0cx?=
 =?utf-8?B?OUt5K1VzSTZuYXVPcjJOa3ZrcHVwSUtQRmxKVC9MR0MweExiSHlZNElFVVMr?=
 =?utf-8?B?amNILzhleW5rZlBRMjhHaC9uYmk3RXZmbHp1cUZ0aWRXWVlveG9xdnJCRnFi?=
 =?utf-8?B?bW5GV01SdTdhUzlLY1hRNzlOa3hOSG5uc3QxNmZRamMzbGlFYnZlMjZQWkZ4?=
 =?utf-8?B?c2VheS9GVzA2UGlRbmpvM2gyMUpmVlZ5R3k4RUdIa2tFV3Q3MG9RL2N1Rlpu?=
 =?utf-8?B?MDlqWmdMTzN4ckk4bjFJNHBsUkpuc2xabTUvRHl0cjB5WURLcGtPYmp1cWY1?=
 =?utf-8?B?WCtUR0YyaHlqQ0dhM3BXSklWWTRKY3ArOVV1alFKT2pXRkxXUWI1TE9jaFZp?=
 =?utf-8?B?MUZ1V3prUW16blBMa0lJWUVwSEVwT2hBZGt6Y05ESWpQQXQ1bzJ0NysrZnd1?=
 =?utf-8?B?SE1yWEd2TXRVS0tHSWFnNmxhdDRFZjhuOWZwUVpBQTRFeW81Wk1hN2ZFa1Bs?=
 =?utf-8?B?OHdDc0I2Y1FEelpyYW0yZHcyR2NSMmxDWmZVN2lBV2Z4dW9tbk1yaUxuMkZN?=
 =?utf-8?B?VDZybUk0SUYvbEl4QTNrdEwzcGNwQ00wK0pHa1U0QTBjandmUTJtVTFkL0tN?=
 =?utf-8?B?V1NCcFFMYmFSZDBYRzFQY2JndWxlWTVWa3Y2ZlBnUXI3NWJTQytFT3NyZHFV?=
 =?utf-8?B?NXhsb0dKem92Mys1ZnZ5L0U5RW9Mb1BaVEduVVdLNzdLcUhqaERWWm9BNXVB?=
 =?utf-8?B?blIzT0plT1oxY29JOEZGSzF6bFg4ME9CN0hpczFuOERhR0lISmR1SVNmd2J5?=
 =?utf-8?B?a1M0aUxKcCtUcXRrVTN3QUV2SHIyTGtqMnZoVnJpYkVqZldPbmUvTHNWNUlw?=
 =?utf-8?B?VmhwVithUW1pSGFTQjNOQXdQKzE1ak1zTG5PMWVVS0wwa0U1TkZsRU9OUjg0?=
 =?utf-8?B?NjBDY0ZwZ1RzbGpiL0orc2l0MTBJbTdEa1I5cWxaWU82dEk3cUhNKzJkSEV5?=
 =?utf-8?B?TUVSRVVNOHdQZ1hBL1dEWk9OQi9Nbm95MHQ4aGVFRGJMOXkzL21lRlBVOXRW?=
 =?utf-8?B?aitrZWhrTkdMMXRXSWNiZ0hweTByRlUyd2dvNmdxb0o4OTRoK3A3cVROeWhH?=
 =?utf-8?B?eGtMUmJ5b3hRV3N6UDhENmtaYVBycEcwaEVKRjQ4WkllTXcwdDJtdW9FcXFJ?=
 =?utf-8?B?Zi9UTm1YM1lNL3d4MFVIUmJTWHc0MStTeDljNmpzVUsyS3VQQmNIODJiVmdQ?=
 =?utf-8?B?djF0RjZOWE4zNW5zSWNLZWR0clUwZ1ZuVFJqUzNOOVFUUGt1MkRxOWJJUERW?=
 =?utf-8?Q?4t493bO3LCX1gc0DLoQwyhs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <212BB660FA37B240AC74F2394206C189@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae5b330-c786-40df-f32d-08daae1013d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 18:15:30.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAuNuuXBo/fLWeHn+XeqEhe/9KxRQajNA5B76+VuNnLNwHclYwjq97mYxbFQ9O3HyPZ0OQzzoXy286C+5+Fr5CS5y8rJCUy0s7QDg3Zbagk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDE5OjEyICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjAxUE0gLTA3MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+ICAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHNldHVwX2NldChz
dHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+ID4gICB7DQo+ID4gLSAgICAgdTY0IG1zciA9IENFVF9F
TkRCUl9FTjsNCj4gPiArICAgICBib29sIGtlcm5lbF9pYnQgPSBIQVNfS0VSTkVMX0lCVCAmJg0K
PiA+IGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSUJUKTsNCj4gDQo+IFNvIEknZCBs
b3ZlIGl0IGlmIHdlIGNhbiBnZXQgcmlkIG9mIHRoYXQgSEFTX0tFUk5FTF9JQlQgdGhpbmcgYW5k
IHVzZQ0KPiB0aGUgdXN1YWwgaWZkZWZmZXJ5IHdpdGggS2NvbmZpZyBzeW1ib2xzLiBJIHdvdWxk
bid0IGxpa2UgZm9yIHlldA0KPiBhbm90aGVyIEhBU19YWFggZmVhdHVyZSBjaGVja2luZyBtZXRo
b2QgdG8gcHJvbGlmZXJhdGUgYXMgdGhpcyBpcyB0aGUNCj4gb25seSBvbmU6DQoNCkFuZHJldyBD
b29wZXIgaGFzIHN1Z2dlc3RlZCB0byBjcmVhdGUgc29tZSBzb2Z0d2FyZSBjcHUgZmVhdHVyZXMg
dG8NCmRpZmZlcmVudGlhdGUgdXNlci9zdXBlcnZpc29yIENFVCBmZWF0dXJlIHVzZS4gSXQgY291
bGQgcmVwbGFjZQ0KSEFTX0tFUk5FTF9JQlQuIEFueSBvYmplY3Rpb25zIHRvIHRoYXQgdmVyc3Vz
IEtjb25maWcgc3ltYm9scz8NCg0KW3NuaXBdDQoNCj4gY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZf
RkVBVFVSRV9JQlQpKQ0KPiANCj4gPiAgIF9fbm9lbmRiciB2b2lkIGNldF9kaXNhYmxlKHZvaWQp
DQo+ID4gICB7DQo+ID4gLSAgICAgaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
SUJUKSkNCj4gPiAtICAgICAgICAgICAgIHdybXNybChNU1JfSUEzMl9TX0NFVCwgMCk7DQo+ID4g
KyAgICAgaWYgKCEoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9JQlQpIHx8DQo+ID4g
KyAgICAgICAgICAgY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9TSFNUSykpKQ0KPiA+
ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiArICAgICB3cm1zcmwoTVNSX0lBMzJf
U19DRVQsIDApOw0KPiA+ICsgICAgIHdybXNybChNU1JfSUEzMl9VX0NFVCwgMCk7DQo+ID4gICB9
DQo+ID4gICANCj4gPiArDQo+IA0KPiBTdHJheSBuZXdsaW5lLg0KDQpPb3BzLCB3aWxsIGNsZWFu
IHRoYXQgdXAuIFRoYW5rcy4NCg==
