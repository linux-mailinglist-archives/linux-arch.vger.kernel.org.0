Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098D961FA70
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiKGQuJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 11:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiKGQuF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 11:50:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1518B201A0;
        Mon,  7 Nov 2022 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667839805; x=1699375805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1wkUvjHR2dzwStjJG7Jrj3JYMGbmZsMLYQZ8BbmVuu4=;
  b=GBP1E/rQcaLZ5gQLI8DGU0etyFXRsxn4Wlqk4EFc9FG2HnlMptzut5dX
   f78OU1I8ayTICXFxEyzoCk7cV6yJoV9X0KCagrqYCzR1TwtRjY+PVERx3
   X1LN46o97FSbxEdlFq4wr3XJTna4uX0/YAtOMpMUFaQI/UckDGWUdjzMz
   9lj87fcYKaXFgv7zX3Cd0sxqq9waSX9bpFtBWwvTwd2CvMeedUJEGzvex
   Unpm738itVzTQmkjWcNbEzliJV4NIpBxvpWD7j6wXA7DBgqZJuPhSeevr
   mJlEur9tNlmQrsz4xeywntG987Y0gwqqJHdrGOZ/19d1ZCdyB97irQRtC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290182498"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290182498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 08:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="881139955"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="881139955"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2022 08:50:00 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 08:50:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 08:50:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 08:50:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpzzxUKQgrFZAfeWauBdm5+eEKgZbK0AT6uc2Ltookt7uBuLddivzz2kR3iKgIMEpWXIUvss3Nw05o4btrSbnRBz6tUEhsUhg/KAuHprpxnMmUK+Z4Q4h5h/bA0n1frYyXxUGE8lAOn2GjCRmJxFOEjjeIuK8n+OheNBvfZDMBAxxt/t6c6vzJPQEwQQOwEWbTw/UBJPha074O9oXg7LOvhp5fyVZNd8cdaxR0fMzFncM9JVlrlPFEG/kK5NIs9FluPYlAp+7cH/SYgW5Xhhn/AEH1mMD02FkirjGSM1Xcxjw1wm8JDZQLEtpwYmHPUZnioWX8zym/euoSCB0727JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wkUvjHR2dzwStjJG7Jrj3JYMGbmZsMLYQZ8BbmVuu4=;
 b=JnmudDNIshUGRRQYlrCRhfMJLU6Omb4A4HBw1hYk+uWPWSuJFya1srFWcmY5uTK0xHTYMrBN0HOKAvhsEHOPCsmRQ/E1x9LNeuqZURx2pQKLPPjp7zcCSr72zmbw13rSmsVZ9qpDhn3GGlICPSwc1hsmrTpiLQHC7wpFAmXTif1YH1qKzrWbOTZb7zKGID1xazFuzJlB6cvGTY7LmCkA2mUlBXD9XcKUnrP+BK34Jb0l1gATBgWLfpwrQkIKQWXGY++VCZLnkpeSuCZsf5HUE6UmYIDYh8I/yL9OWmmzRkpa+LmzXitbRILwlAE+IFhvirIgwzMlOkwbca0XVYxHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 16:49:58 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 16:49:58 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Topic: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Index: AQHY8J5g32apAoMYh0aArgmkU40OVa4vYA0AgAJEZxCAAgw+gA==
Date:   Mon, 7 Nov 2022 16:49:58 +0000
Message-ID: <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-38-rick.p.edgecombe@intel.com>
         <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
         <87iljs4ecp.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87iljs4ecp.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ2PR11MB7545:EE_
x-ms-office365-filtering-correlation-id: 39ca8472-d9ab-40e0-a703-08dac0e01b01
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qsx5VTw60/G0SkL8h+mjgymiHhdmsbO6sI9k40fjc8SbdXFVUoTZMMMqLwT7CxnG7qs7Egl3bkt1U+yMmfkw3ARqE8QX/4YCLKcM2uovODex/phUyZO0qnngLd8AdDb+vCmNeAeyPx280LuyE6EjFvYUpxe66i/aDwx6h5MvmcO0mhwnMULIDJ7DDhlXnV44x9A7qU5Dy0mP9MTLfX47/n315GRY8MczRufD2nWItFv6wBmFRHmk2iVup4Drn3i0AaOYXw1od8VqdHDqCxDHw/gPv080v/MJ44zXeQqvXX0PV1sjf+ptSg8a5OUJxB2dfq7zR7Foxf37yXUEmP+HAUsuE9SPP3LY1LaTG4bPLmT0ibTLrfTE+vGb8fQTwISGjcbb4Q5TZWVccQM+Wmvo5d7UMnajSoN+LSLkIdQjGKAdB0RDFVh1Pf5t2qxBFi3tkP2SwQzpcers/TToBeuGI3Q5vi6hY3o/RZh/qxRIfOXt8uUTzgAP5plpivSpIn7dzcNu6kuNGgeuFnljb2X8uRl04AxUSdKe67QWhAoEu5U2vgX7lwFx5P/0HbuaE6CVQ9kXweYTVPYL17aXkHpfbBz27qIwCnGr5+mYJvV+vknobr56dtfFik2rBwPrvP1eLhlBZVR9vs6T3IjK0gGbhvR/oo+OE2mx8ArxTm2/ojwCMgkWZLip5G06BLD3nrSI0euQ9LzHAX7oa6wDoIdVNaWcd5DrORDPtRrpWl8C0YtCDdWehCTjBX9TrjTFPRaZ1k+gWVZDjINyPmNydKsfddLqF2f/VxrHW0412WkOVgY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(6486002)(2906002)(6512007)(26005)(478600001)(36756003)(6506007)(41300700001)(8936002)(38100700002)(316002)(76116006)(122000001)(38070700005)(7416002)(66476007)(66946007)(82960400001)(66556008)(66446008)(4326008)(7406005)(64756008)(8676002)(110136005)(4744005)(86362001)(71200400001)(54906003)(5660300002)(2616005)(83380400001)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0YzRTVyakc5SEYrOCtNa2MzaFhud0tQb2EvaURUdHN4SitITU9IcUQyK3RJ?=
 =?utf-8?B?UWJKbzF2U3VZK2hJcWd0Zkx1REkzTHUrdlV3WW1henQ1cVdyeVI2cVZudXR3?=
 =?utf-8?B?c1hZOW4yRFJrL0pzTCszQjNRcU9XRTFvQlg1ZFMyNmMvQ041ODNqUlU0NllG?=
 =?utf-8?B?UzA1U3BibXB4R1JQcndobGE0VTdiQ3NIYVkybTZnV3B2MWdMUXl1NUZmMzFo?=
 =?utf-8?B?bStxdnZBWWZtdXRmVk9mZXVvOGNBT3M0dHk1RmVDdE9KdVJKMng3aVpWWHhP?=
 =?utf-8?B?ZUVBQ09lSHJXY3VUWG1SeUtrTTl1ZEI3QVJlWWR3aXZHM2dwM3h4czl4UE9l?=
 =?utf-8?B?QXpEMG9QanJWb1hxTHcxMmU4alV2L1BXNEEzRkVxQzdXOGorQjhNMlJsb3hm?=
 =?utf-8?B?U2tEeTczeE91RGNXWC9kT1dBZmVCS3RxbFdRcUwyYlc3V0FGMVdmb2EvUGZv?=
 =?utf-8?B?WTgzdi95cXRBMFV2V0k1cnlJcVVEblpxTVZ3RkdPWDVGQ2MyNktlbVI5VkFo?=
 =?utf-8?B?bjhIUFVOVVZjaWxGdllLWDdIdTZTVlY3eUZNNmFQTC9NZDRWYlFwMlQyMEg3?=
 =?utf-8?B?d05XRFlZaDR3Uk1Dc1luQVh2MlkvZlZsY3ZtaEx6S3hzNWZiajFCc3pOcFc2?=
 =?utf-8?B?cmw3UFh4MlZwTzl6RlIxL3lITkxUSk53SFpQLzVkOXgzL3N3RXVQUFI0cEdp?=
 =?utf-8?B?OEFXaW5XZ3A0WW5nS2ZsZ08vcGJUK01EeDdjUlJRYytaZTdOYUNhYkp6ZGVk?=
 =?utf-8?B?V0ZpV0dZQVJUVld2T2NjVm1jbEU4Z1hUWnRxU0REYUpMZm5oWWNGOTN3OFJJ?=
 =?utf-8?B?T3hYcVk3WlY2dUpTQ3h1N1graHlFekxtZDZISng2U2NrUkV0N2JwYmRtbFo5?=
 =?utf-8?B?Rk51cmlGVGRDMWI1MnQ3MHNzS3ZMUTRXa0F1dGZ2WXJHTThiQUo3OWdEeUVa?=
 =?utf-8?B?dVRWdkx3a1hXbHB1S2E2RVZEREFOTDROcUxRQ1loUWZMTkRXQWlCUFJ1d2Jj?=
 =?utf-8?B?bG01a3RMd1FSSTlDOS9DSUtrZTk2dUE4cGR4VGxhZUhQQ2xFQjZ5bE1WWTd6?=
 =?utf-8?B?b3BEeEd6dUY4TnlSd0poTTVXc2RFeWZWMGkwUGdRU3d0RC9qeGcwU1ZJekhQ?=
 =?utf-8?B?R2M3ckdsdzEyUWx1RXRvTXhMdG5pbm5mWlJDSmdEU3JzTHJ2c2ZReG52em00?=
 =?utf-8?B?SVN0bUJiWG5sbGNQRXFPWll3eTZsaVByc3pzYTVYRlFrVUhNVHR1N0c4WnJo?=
 =?utf-8?B?QWpGYXdYWjFyaEM2NXdaZWt6Zml2Tk92RnYwd0ZiZDcrUG5QV0hsOEhVNFZY?=
 =?utf-8?B?TFJmcE1abDRCWTV5OU1QdlNsUWtCTTl2dVZ4SzhaQ3ZwcHg4S09uT0xRaEho?=
 =?utf-8?B?R1NqRW1nQ1pxR3pFSHNuM01jWkVackdLK2YzSE44OGlsVkl3UFBUYVAvTGFM?=
 =?utf-8?B?c1MwKzkrWGFmTGdPa3J0b3huTjlQeWxzOElLZ0xqbkFwMmdYRVBzUTZYVDFT?=
 =?utf-8?B?WkVmcFowVnM3NzJjZTJ4ZDJtRXp2WjE5ZExXRkZVR2pkN3kzb0luNkFXRnV1?=
 =?utf-8?B?L213WkJOLy9oQ05KaEtJT2JENkxJSVJqc2ExL3M2eTQ5V29lT1RMOVM5MVd1?=
 =?utf-8?B?RE9pNEVIV3pkWW16REVUUUxNekVmM1gzdzV6MWhPaWpSSGJCSEJ0K3BmVlZ1?=
 =?utf-8?B?WGIwb2liNm9mVU1wSVF2YWFvbXVyL2E4bkdwQ1MwUkxJWk4zZk5BNG9ZQTAr?=
 =?utf-8?B?cEhWWUl1ampSTVE2N0tYRXkxVzRaTVgwdGhBRkdkNFN6YWgzeG1CT2FTYUs0?=
 =?utf-8?B?L1NVZFFQWkV0Zko4a0UzckZTSklicGl2eW9VakI4cUwrYStCU0RGdVlBd0FJ?=
 =?utf-8?B?dlZ2YTBURlMyZUVzRWE3cUo1STJIOHZvaC9DOXhEcnRGK1h3djBuWjQrekV1?=
 =?utf-8?B?UmpMVTRGbUZkODZzRjFzZzNqR2JWR1RHbFdCem9IemZZQXp3NkhQSDF5bVN6?=
 =?utf-8?B?WHA2Y0MrTlRtMFpvVGgxNmF5RmkxMnNZL3QrYUJYcGQwVjg1R3pYSWZ4UU9m?=
 =?utf-8?B?Y2Y1TENzbjVrVnlzMVl1di9Cd0dmOHZKNzhuTEhYOE11aUh2US9oZGhINk14?=
 =?utf-8?B?Q1hJWmZPM25TT082QzJDQ3ZiNEpzWGtNUitjZmh1dlM2T3NkN09zWXNlOU1q?=
 =?utf-8?Q?wXOKTmYUtefBLtsfz9Go+yc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C63E95FC5789364382D2804549B3F38E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ca8472-d9ab-40e0-a703-08dac0e01b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 16:49:58.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axBsfqnL9BSitePc0rs3lzNLo7w5pcpyDcSZ5ag114zSqiXX59yycRsc+vX60CCrX/9FfQ7RvsVRlrqbu8+JmkfjOO7pcO01coEVoPMuL80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU3VuLCAyMDIyLTExLTA2IGF0IDEwOjMzICswMTAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gKiBILiBKLiBMdToNCj4gDQo+ID4gVGhpcyBjaGFuZ2UgZG9lc24ndCBtYWtlIGEgYmluYXJ5
IENFVCBjb21wYXRpYmxlLiAgSXQganVzdCByZXF1aXJlcw0KPiA+IHRoYXQgdGhlIHRvb2xjaGFp
biBtdXN0IGJlIHVwZGF0ZWQgYW5kIGFsbCBiaW5hcmllcyBoYXZlIHRvIGJlDQo+ID4gcmVjb21w
aWxlZCB3aXRoIHRoZSBuZXcgdG9vbGNoYWluIHRvIGVuYWJsZSBDRVQuICBJdCBkb2Vzbid0IHNv
bHZlDQo+ID4gYW55DQo+ID4gaXNzdWUgd2hpY2ggY2FuJ3QgYmUgc29sdmVkIGJ5IG5vdCB1cGRh
dGluZyBnbGliYy4NCj4gDQo+IFJpZ2h0LCBhbmQgaXQgZG9lc24ndCBldmVuIGFkZHJlc3MgdGhl
IGxpYnJhcnkgY2FzZSAodGhlIGtlcm5lbCB3b3VsZA0KPiBoYXZlIHRvIGhvb2sgaW50byBtbWFw
IGZvciB0aGF0KS4gIFRoZSBrZXJuZWwgc2hvdWxkbid0IGRvIHRoaXMuDQoNClNoYWRvdyBzdGFj
ayBzaG91bGRuJ3QgZW5hYmxlIGFzIGEgcmVzdWx0IG9mIGxvYWRpbmcgYSBsaWJyYXJ5LCBpZg0K
dGhhdCdzIHdoYXQgeW91IG1lYW4uDQo=
