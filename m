Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE955FF1D2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 17:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJNP4H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 11:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJNP4F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 11:56:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A360437E0;
        Fri, 14 Oct 2022 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665762964; x=1697298964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jc6zZqQD2FPbb+Y8JBwwWkELF34kagos4URpOQmBdVc=;
  b=EWRjEQ8+xOfLZPQqw9hyP76V0CWUFTg87MfcT0Ka4PiN9QkMy7N8VwzW
   JgZwu2i8qAYYh1ctxb0sIKhUwhwucl45uAZIxUr13k0ZGS2/Fvs3NFt1s
   RxP5vL0aZu0QMd7Y3lJGmEt7VdrbBsYLxoBISqpYmiNt7MhcPzvxaDHon
   Mbh+fPYc03oOD8pQmVPFjoSxd9L6o99idAJzcUMYngmQGsy5TiYnwHGDq
   U2RYWVwhPXPZUkT/ybekeuQOiaZ/y6S+JPCTCEoEb5R6omJsQq/FLwpfy
   OsuJXJrOGsMrKpDV/6Erk6OHGBgipiK2XKUpwOwMagccLF6bVQAdADOFJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="303022113"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="303022113"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 08:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="578669891"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="578669891"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 14 Oct 2022 08:56:03 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 08:56:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 08:56:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 08:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSjIl7spUiTcAVh8FxZtihbvxtZFeCB2UctO7LPSnMTFSukYz6TPk55Jg5ch89FwGlTAeLMC30xXZ/oLpLTO9S9P0T00XfP/epxFlTl1xh+fN4h7Y5JwjDmvZ9uSJXpIEq43FF+tbo5peeqXRZW3eh0ueOFihKfkAhj0knkhRP+EVmVrWPkjZHUs2SS0byVSsqWBrWYZxDm7njpBmMg2LHBxPEY6xp6RAeWhblgehFbnBB9oeJ2jjzYrwy8KsP/qTlRHGVXglkftMGDtkjdhLIwCATmuoaXuTGyh70ML2f9dbIyzoXpd7CdN8julbXHCK/7QMuU41h8vKesEOtEmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc6zZqQD2FPbb+Y8JBwwWkELF34kagos4URpOQmBdVc=;
 b=jH9WDa41qNRliJl/0kGiRRo/i4Gn5kC0POm3NuZhzHijB+P6oaxqX/HvRwC6Hplxz6xKgqI2QyEVUrFRYTzozxED5KiREkyYvV/gvWG4o3gh2C1CR2ZYykSPnWFOnTkBTM/4iMs/c/Xf9BFHtkak4SFYVIcgXuBIr5AczbkVP57k+Gk8aAYVdgjo+wrfdT4wHmh6PE5Q1Tnof3m+6Wm8k7SG1uab47tX32QBKklJIUcRL1LVAiWGfHnCW8MgHIso3cHvC9doGFes9W9kmnEzvpwhIhxOfzdjFfaZbe6uiyeHbL421A7Rxv7sG0IHbhZq9YFKe6wB2de1L6fyOzoC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS7PR11MB6127.namprd11.prod.outlook.com (2603:10b6:8:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 15:56:00 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 15:56:00 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
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
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite()
 directly
Thread-Topic: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite()
 directly
Thread-Index: AQHY1FMa24Mj89j8rEOlmG8UPkMiXa4OIS0AgAABFIA=
Date:   Fri, 14 Oct 2022 15:56:00 +0000
Message-ID: <e568eee5a05b0908423b29e608400dbfec56069b.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-18-rick.p.edgecombe@intel.com>
         <Y0mFqGvtSrw/kS4b@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0mFqGvtSrw/kS4b@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS7PR11MB6127:EE_
x-ms-office365-filtering-correlation-id: 7aa4a58d-d921-482a-02e0-08daadfc96eb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEtrGiE+PMO28p61fEdpEYStbmXBYOydDgBxQJH5CPpuAGXUfUjZDsjNhDb81yeFfX16TCbkTaeqhL235SAJqVXAi5Wghw1oy8J6tK6vmG47Xd//4PImvvuv92aa3g69cl8geyZ6i3BVdoFtmbvS3QoHJ19P3SW8KkJTq82a7gFNGOEIYiS3s60yEP02vMKSjvRrnboX6Eg0CCrFSwp0FeoGWrC7rLzPvZMAM3mhZ/av+cYMe7zEEveMq1/FH9doOSaA2WPdFIZGL0Or2dk8PuPnF6NlkjPns5pKcBKL2R3TN+ivHIeEh79acVKfsYMGEYsGNphwEuD/dJvVXA4bcNbUfqRuUiwDD6wIlNEeq/3iBGfvuTaoKLfMBDOzWc4MPNEyj/MdZkhHdi+qXfEs1WYawSfc1isUrgJsuoL8gl8tGrBHTRstv4QTrOcUOGkPQTWbpQ92LAjJhhAVG0oWi+ly7K3O7X6IovIe3vOwZYw1hW0Nu52HlgVj2CPocHrcwX0grW/8yG1Df11Wpq0aWO5vBfOy/aYia2dnYraUzqmXkEiLhoIwIHp9huUIOz8ycviqpuu9PjgT48c6dqqFjg9h6KIlUF4gtmHfv3JL7Qde9hw45ryOEr/BN2R/rYD1+ODAgusyumxDolrYeT2FCNoVA4ppk4RLfEPwcNmAZ54+TPVpqjq04OLF63GkdwOG3nx1Mtg/nVS/vUleYh9n8RLE9v4GC/H5TCpy7JEuod1T8rfkfDYDoxMATCykDLYhcpKN1czcllIKVDxjZRlG1cusXmqI+XEoH0/Z7Jk/4Ws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199015)(36756003)(76116006)(66556008)(8676002)(2906002)(4001150100001)(6916009)(54906003)(316002)(4326008)(66946007)(66446008)(8936002)(91956017)(41300700001)(64756008)(66476007)(82960400001)(38100700002)(26005)(122000001)(6512007)(478600001)(5660300002)(7406005)(7416002)(71200400001)(38070700005)(86362001)(6506007)(6486002)(83380400001)(186003)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkZBV3NkaGtYdEo4THF4aG95bXR1ZEJJZy9aTmhXWWFNQkNCSUNZQVVYSzht?=
 =?utf-8?B?dGNMN1M5ZUliSTcxTEd5UWtzY1UvRndlZmtwbmx5Ri9GVDAwZDhBcjFIZFVv?=
 =?utf-8?B?RTQ1TExlUjBNVUx4YVh1LzY3ZDF1MTBRamVxcDUrQTVWUXpQdllNR2JlYm1r?=
 =?utf-8?B?Z0d4S3JsZ1BtR2ZxdlUzWEpkalhBeC80VjJUQTRwVVJpOGJna2FDczRheTNp?=
 =?utf-8?B?aHgwemxvN255Tmt5SU1Ja3kwTExtejdVYkFrb1FMbWttQnNHT1c5R0lWTzdy?=
 =?utf-8?B?bnVQNDlOeGpjWjk5NmVrYXdlM1BNSDg0YXVZODdnOUdXMXU1N0IvdTVrUVh1?=
 =?utf-8?B?RWdxTlNBZnpXMGhrVldGeTlqOXFIM2NYRTVXNncydUxhMHcrUUtBWGw2akg4?=
 =?utf-8?B?TFNiSnNSNnBBVmFZdFd1Zyt5U3pXVU5yNmJ6SC9rZEp5OE16WmJ5WmxkMW1l?=
 =?utf-8?B?U0E3MWcvL25mdFhhTzJjNGNLQlBJY0hETysrNlVkUWxlaEtjZ2t4bkI5RmFh?=
 =?utf-8?B?QW5rVFVjYmgxb2NwNDFwOURZcjY2RFZyeEN6TExac29FNGJyM3lGbWloOThi?=
 =?utf-8?B?MlR1Y1J5ZUo4cXdFUVhIRDZHWXh3TXVwVWhWYTJVR01SVlg0Sk9BUlAwRmxT?=
 =?utf-8?B?aS9uM2NHWjFHU1JiU2E4Vk1RUi9qdURxSkM0UWVZODUzQ0ZQdWY4MnRVdFNG?=
 =?utf-8?B?NktYK0EyK1VvU2RjQTFMYXZ6Y05jb2haSUthWGtOUXNXWFVNenNHRjZJK0tV?=
 =?utf-8?B?bks2MlpFS0w2REZ5OWJFcGZsK3Q0M0ZMekF3NWtiOHMzZThJR1pWQnd6azFy?=
 =?utf-8?B?aW5NL1RyblY2akNrc0lYSU41bmlMSks4b1FhaHFNVDZXWVRvanhLV21DUWpD?=
 =?utf-8?B?R1hGSGRlOFYzc3JiYmJJbllXdG52K1lITnFzRGRPUk5UT3JjUzc3RzFDMDE1?=
 =?utf-8?B?TVgxWnNhR2ZDQkJJMllVcExUOG4xcWNpMlZFR2NKejlobEp1TmlqNHhEMVhn?=
 =?utf-8?B?dCtNSjhDbmdFQzNDOHVwaFFkeTYzaS8wZ1FJL2puU2ovcUYyZGNEZEQrSWdR?=
 =?utf-8?B?aEU0TW5XUFVXQXJ3SkdIdDJuQXI5aElxTHBQdDBRMlhIUHBSMXdSMG1ZKzJm?=
 =?utf-8?B?Y0hPTk85MThnOW1NSkVlMGpaMG1tNjZaRGFXMG93ajdacUdHcGpqT08vdG1a?=
 =?utf-8?B?bkF1ZytVeCtIZjR2L2FReFk5b3E5Z2hJNmwxcXB0N1o3MVdxL2lsOElpVXZC?=
 =?utf-8?B?Z2FrTWlOS0lidE1zQ3VVRHFhR0d1VUMwQmRMbzlrSUhVcXZNTlN2K29XTG8r?=
 =?utf-8?B?NXlYeStzTWlsWll6MTdMRVZ1WVBHelFwNEk0YWVPdFNudmpqc2lRY2E5ZU91?=
 =?utf-8?B?bDVHRXlKU01TQUNranF6T2tadEovK1JuMkRkTmhGWGhwNDJXRzVHZXFUbHFW?=
 =?utf-8?B?cnJpUGNGVXp3cGFJcDJuU2dDMDNiVEtCOXBnRU9mMnlTV25EOXZwVUkvZkNF?=
 =?utf-8?B?ZzhPd0t2cVk2clREdEpydzJWRjhLVlZDaFR0TkE4VU83OEVEdm40WjhjTTBU?=
 =?utf-8?B?SFpibTY1ejFDaTRNNmtLR2ZPNlozWGcvdkU0a3dnd1BvVldIaVVHb1E0MUI0?=
 =?utf-8?B?QUVKWDVXcHViWFVnekdEaGs2bUtsRHR4UHFtbFpiVHYzbmFOWU5pSWNBd3Mw?=
 =?utf-8?B?Nk42Z2hnaUFNeDNBSkpvN3BoT3pMcUdNS2N2aWlDdE5KVWNpTjF6OEsyeDkx?=
 =?utf-8?B?ejNxQ3l0WW5jSnJKYWMrNXVGeU9wU3hkUXNLSHhIVnAvWU5hZTNyTG9uZWlB?=
 =?utf-8?B?bzkrUUMzMGN1cWx3WEpJZVIwUkwvUnJxN0RObUVscDRwYy9QakVTMUhHYUVW?=
 =?utf-8?B?MlNKSzFLVjl1YjU5RXZWVEhNZHY0L3BDNmRhc3J3RU00dzdwUmpmN0FQem02?=
 =?utf-8?B?NTIvRXc1alZlNEVoK3ZDQ2hmd1ZiRjZDSW9mQ1B6RXdIektQa2tvUkNNQXBX?=
 =?utf-8?B?ejAvS0puYm11dGRZdFd5U2VHcHVKbGoyY2N0U1p6enM3VXhHOElaMEY2TjVN?=
 =?utf-8?B?MzRudG84clg3SkVhN25LL3pMMXJaeWZRYWhLVUgzcC9DbXpTS3hsdnBEZGU0?=
 =?utf-8?B?ajdua1VFM2xXcEthYVJOU1Z2MkRFQUxSWkR3Sm5lT0xFc1J5OEEwUEpsbjI3?=
 =?utf-8?Q?rGO3E1V6wGH9tbSiRNQy5l4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D16F5A143C05D245B2D4CACABEAAFA66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa4a58d-d921-482a-02e0-08daadfc96eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 15:56:00.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgL+bHVm+hzWjyUttn7e5ShDA8zGhMYuxJnMcLOHGctaRBG80J/iUL7IvKHkE3o4ZhUk94M+C7PwEB+yEne3mHK389JFmWdsiWQ1xp4qk5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6127
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDE3OjUyICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDM6Mjk6MTRQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL21tL3VzZXJmYXVsdGZkLmMgYi9tbS91c2VyZmF1
bHRmZC5jDQo+ID4gaW5kZXggNzMyN2IyNTczZjdjLi5iNDkzNzJjN2RlNDEgMTAwNjQ0DQo+ID4g
LS0tIGEvbW0vdXNlcmZhdWx0ZmQuYw0KPiA+ICsrKyBiL21tL3VzZXJmYXVsdGZkLmMNCj4gPiBA
QCAtNjMsNiArNjMsNyBAQCBpbnQgbWZpbGxfYXRvbWljX2luc3RhbGxfcHRlKHN0cnVjdCBtbV9z
dHJ1Y3QNCj4gPiAqZHN0X21tLCBwbWRfdCAqZHN0X3BtZCwNCj4gPiAgICAgICAgaW50IHJldDsN
Cj4gPiAgICAgICAgcHRlX3QgX2RzdF9wdGUsICpkc3RfcHRlOw0KPiA+ICAgICAgICBib29sIHdy
aXRhYmxlID0gZHN0X3ZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURTsNCj4gPiArICAgICBib29sIHNo
c3RrID0gZHN0X3ZtYS0+dm1fZmxhZ3MgJiBWTV9TSEFET1dfU1RBQ0s7DQo+ID4gICAgICAgIGJv
b2wgdm1fc2hhcmVkID0gZHN0X3ZtYS0+dm1fZmxhZ3MgJiBWTV9TSEFSRUQ7DQo+ID4gICAgICAg
IGJvb2wgcGFnZV9pbl9jYWNoZSA9IHBhZ2UtPm1hcHBpbmc7DQo+ID4gICAgICAgIHNwaW5sb2Nr
X3QgKnB0bDsNCj4gPiBAQCAtODMsOSArODQsMTIgQEAgaW50IG1maWxsX2F0b21pY19pbnN0YWxs
X3B0ZShzdHJ1Y3QgbW1fc3RydWN0DQo+ID4gKmRzdF9tbSwgcG1kX3QgKmRzdF9wbWQsDQo+ID4g
ICAgICAgICAgICAgICAgd3JpdGFibGUgPSBmYWxzZTsNCj4gPiAgICAgICAgfQ0KPiA+ICAgDQo+
ID4gLSAgICAgaWYgKHdyaXRhYmxlKQ0KPiA+IC0gICAgICAgICAgICAgX2RzdF9wdGUgPSBwdGVf
bWt3cml0ZShfZHN0X3B0ZSk7DQo+ID4gLSAgICAgZWxzZQ0KPiA+ICsgICAgIGlmICh3cml0YWJs
ZSkgew0KPiA+ICsgICAgICAgICAgICAgaWYgKHNoc3RrKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBfZHN0X3B0ZSA9IHB0ZV9ta3dyaXRlX3Noc3RrKF9kc3RfcHRlKTsNCj4gPiArICAgICAg
ICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgX2RzdF9wdGUgPSBwdGVfbWt3
cml0ZShfZHN0X3B0ZSk7DQo+ID4gKyAgICAgfSBlbHNlDQo+ID4gICAgICAgICAgICAgICAgLyoN
Cj4gPiAgICAgICAgICAgICAgICAgKiBXZSBuZWVkIHRoaXMgdG8gbWFrZSBzdXJlIHdyaXRlIGJp
dCByZW1vdmVkOyBhcw0KPiA+IG1rX3B0ZSgpDQo+ID4gICAgICAgICAgICAgICAgICogY291bGQg
cmV0dXJuIGEgcHRlIHdpdGggd3JpdGUgYml0IHNldC4NCj4gDQo+IFVyZ2guLiB0aGF0J3MgdW5m
b3J0dW5hdGUuIEJ1dCB5ZWFoLCBJIGRvbid0IHNlZSBhIHdheSB0byBtYWtlIHRoYXQNCj4gcHJl
dHR5IGVpdGhlci4NCg0KTmFkYXYgcG9pbnRlZCBvdXQgdGhhdDoNCmVudHJ5ID0gbWF5YmVfbWt3
cml0ZShwdGVfbWtkaXJ0eShlbnRyeSksIHZtYSk7DQoNCmFuZDoNCmlmICh2bWEtPnZtX2ZsYWdz
ICYgVk1fV1JJVEUpDQoJZW50cnkgPSBwdGVfbWt3cml0ZShwdGVfbWtkaXJ0eShlbnRyeSkpOw0K
DQpBcmUgbm90IGFjdHVhbGx5IHRoZSBzYW1lLCBiZWNhdXNlIGluIHRoZSBmb3JtZXIgdGhlIG5v
bi13cml0YWJsZSBQVEUNCmdldHMgbWFya2VkIGRpcnR5LiBTbyBJIHdhcyBhY3R1YWxseSBnb2lu
ZyB0byBhZGQgdHdvIG1vcmUgY2FzZXMgbGlrZQ0KdGhlIHVnbHkgY2FzZS4NCg==
