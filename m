Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8556B2B7B
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 18:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCIRC4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 12:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCIRBn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 12:01:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151CD56533;
        Thu,  9 Mar 2023 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678381002; x=1709917002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l4v0aSdyBjSDKGKXUytfFA9QYHvOkJsaobnGJ6QQjaA=;
  b=M1bK2zLkuXgeOlXbnrS1qNpGxJXsUMxrOHwQfTEosASmN4WVyZoe6Azf
   ok6BsPBES9Pgs6fGgQ5hE00I1hK7UlJSW5/2yVWeExU5DXdIGAvlXsSwq
   WU5msM+xIcjivNynVOcdG7wyouBvjFEGubBnxyVkxhrjiDGQ36GBmbPxC
   yfthsMvGTY/DyWByRi5jjLHzRdhIxr02RINwlclNj0LWWv/2AM6wbq/27
   /dYAg73R/9SmJKWtSe05ALwJ6pZV+RtVe356Nly4SaNC9FGLqa/3VZL7+
   xjgQu87PahTgOSQPnapgBLB+c0Thr3sn2g/i2klXTSy/tngpZIFF9oo2v
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364142337"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="364142337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 08:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801238345"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="801238345"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 08:56:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 08:56:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 08:56:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 08:56:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCuaoDkcgOwgp6RJ/UE3sLsjyja7YGHOT6mkMop3GpHuhQLTrpiJWwlCGvqmCBTcVqb2PaY9DZi/tx/LjPa0BM2LRk64BckLdgkxGWpWPPWerHSti/cr5JXBms+q09m+uK2mozXG+tfFykIDHE6Vlzn/CbQ7UKr3QACuRMVY7xc3KE/oPVRYdYTQUFbuftO1x8COlBohbIEF0q91Aos+FV9DyTfrZOK08M9U0QARc2W8SZ7WU6WPSqNFbgozsDxkKgOLZdizE2S036yFkGoNtWYNtbPHU4z87UqiwMUr1sPIVYxUI75tMUi43YiLCpGEUr+9cDh9vXRon1g/ghGx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4v0aSdyBjSDKGKXUytfFA9QYHvOkJsaobnGJ6QQjaA=;
 b=edkbTdVhPY2m6S7pUACOGqrB2eyhlHINdIIZl+2IWB4RHxD69KMI4E0X9J5LsrUD+5iAAuhEUsrv2YgU7iCN2QRZd05ieKiw4/ZFE0E/wYyfyiBzoX//Ra3wc0ZNwah9FCfH0EKjwmYZsTbBCZ/JNpZg5HfGUMH7wsdDItt8ODK4Y08di9hw5l7qWYwFuFiYqWMsYDfzQb+xQApUmwnWL0Q1qlPQRZ9ciSVdcJ5U3f9S0NJlaFv6XOAL3Gr4/wMzPrZJJ18ItDEA8n+CjOSkgHUrgcHlBUN6s9lYs+PVs4enLQGQ0qLYBux9HIa3ATmTERyWzIWKOYmOOGgTWLGRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 16:56:38 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 16:56:37 +0000
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Topic: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Index: AQHZSvtC0qoWAoXd0kKURn+giTskNK7wu1QAgADbO4CAAOD+AIAAQrQA
Date:   Thu, 9 Mar 2023 16:56:37 +0000
Message-ID: <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-29-rick.p.edgecombe@intel.com>
         <ZAhjLAIm91rJ2Lpr@zn.tnic>
         <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
         <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local>
In-Reply-To: <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB5179:EE_
x-ms-office365-filtering-correlation-id: f77f758f-919e-4162-e455-08db20bf3f44
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGDT130fxCo20tNCmcA5594JzZfool2CbcESMctEEVMTwBB3y7cvDa+0P6E9R2CambIwdANq10ZxsKcSX5Kl7gOg98SzkD/49lB52a3wL2zfmZOOjmceDY0shCpOrCdYO6+h/GBel8bnCAfDF92Swpv7COxVBSKEwTcA6rgZF5s3+/+dcgGJ7geVZ81j9i6ORQzbJNhUqXnT7MfDfNE2Qc07kUgUvWeandI7uxSW/yNpXIwJu7fioyI1ElqBCWAbZjl26WWkZ6Z7dREtos/yFZNByd1qYLDI19Dyu0Ck3YlZ+aOTfzswbFNjJ8NSh8DAro6yo+SAM6tuYe//e/w6y9WGqdlOMOWXWg3G70sVjNg/Qw+lxrdQbiPAPBw+o7Wf7diBbhscppd+1BX4Us310GGtLIwyxXu47v37wt0oteWq0F14K1IPi3nrGgZio+NcUwwPRj0mVwuDgtfMtDo5WeAlchruGsxsDcvnAd9XAC10XaYdHY+VOVJIIbHYYtaYnrUxkM8rLqDRd7Y9m9fQCQ4cWWPmBL+Ky/YiwvZ41QGNPcrS92WCL3rZCchZzyMBlxABAHTjG1m2aPS77p3IFc7OSxSKN6T4bOowBRJ0VBZeIQCyIXDRUD3Lrk4S8GsQ7wGHr+RksCpN74o5Hz4DFaFPo51QUAPmwAlDEw7exX9tXVDqPAiDjk/rOsfoyLm03nNQX2a1REQGUau1pSTyY7lG1t0ZYGBTb97vSiMCYU4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199018)(36756003)(54906003)(478600001)(6486002)(316002)(71200400001)(5660300002)(7416002)(7406005)(76116006)(8936002)(2906002)(66556008)(8676002)(91956017)(66476007)(64756008)(66446008)(66946007)(4326008)(6916009)(41300700001)(82960400001)(122000001)(86362001)(38070700005)(38100700002)(2616005)(186003)(26005)(6512007)(6506007)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDRZTkRjVkpHSFVWd1lEbFg4RXg2V2Q4OFR2TVFCamFIMWhPcWM0Z3Vicmov?=
 =?utf-8?B?cTJ4MTM5aFM5UDJieHJaenFySW1DS1h1TnJVOVhTOEE1TWhCNW8yTGZLUXk1?=
 =?utf-8?B?SGJlYllzdE90SW9meUhBTjRZUWhVWVBCQkpDOGpIMWFod3YyL1h5OUVseTRD?=
 =?utf-8?B?UWl0Mms1T1k2OFVSSm1TS3dQb3dZUWU2RTZFa1UzRTl4amQwQmpvN3Z6MGFM?=
 =?utf-8?B?c0JVdjYwRXgyTE5RZkNNQllUemtXZ1Y1bCtrcWIvcWI0YmdFVGhEUFJMVW5z?=
 =?utf-8?B?MlpZSk5nSEdIL09GamwrejZwZVlCNDJLUlBpT056ek1FN1RuRVRkblFzVktI?=
 =?utf-8?B?eHozNGRlTzBWSUdzSmI5cGcyWVJpSDVTMDg1ekZ4OUdQRE5qS2ZPamZBM1Jl?=
 =?utf-8?B?SHhlSHZqQjdDbUxiTS9XNFdNWExLSUdNZHpjSC9BYXJOR3FGNUlPNkkrdmlQ?=
 =?utf-8?B?djZpREFvQ040emRjMlpwN3FhZjZnODNlb2tnby9ySHQwbEtzWjFtVXgyeHRa?=
 =?utf-8?B?WTVHVU1JZHhBUk0zZWtJUlhVdW8xV2F3US9sQ1lTd2hkMm81bzIvOEJzTWFG?=
 =?utf-8?B?RWk5S0NTNEo1YVRKT3ljZFd2ZDFlVGpjM2hNUDMvOWwvVUJ1ZTVnYnQ3Z3Zu?=
 =?utf-8?B?RHhsSmxJNUF5TEN6YnZZeHFRblUvT3hvNThEdzZBSEpXTFNVeW4xSXhSTWdh?=
 =?utf-8?B?Ty93a2pwc0wvelNtc0U5bW4ySnVBTjlhaCtUR1Q3VGM0VG5iVzQvZVlkWE85?=
 =?utf-8?B?MjY4UHVXdnVqU0U4NkkyeHZQdm1CbkNzS3dTTXVMeFlHT2pEOENnMS8wMGVn?=
 =?utf-8?B?Y0JJWk12Unp1eWs5ZEwvck9FcjluTWVhVFZobnk3MDQwMkwxTmQ0QmFUWW4y?=
 =?utf-8?B?cEYwRlQwamxUNno1YzZMRUFJd0FML2JMTVc5R241eUpOL2duUnNyc2lEU0ZI?=
 =?utf-8?B?ZkQyTzBxRkdwSDIya2Y5R0tXVVIvSHJ6STVFVHRiNlduallVdXU3RW44RVkv?=
 =?utf-8?B?TGQ2ZEV5cS9wb2pIRFpNc0ZNb21zYW4vd3hOVUhBd1NqVk5VQ1l2aXowNGsr?=
 =?utf-8?B?TCtYMUQzSk55OUtDbmY5dG92Vnlkc3hVMDZIOG56eFN0VmcxNTd1Y3ZZTXZ4?=
 =?utf-8?B?dWQvd2c3TjF0bVFITnJCYzVDTmhiMFdDRnFVQkx3TVVLZ21pQ1BSamNLY25Q?=
 =?utf-8?B?bk0wcG5VcnppbzJoZE15ajFtaEZOME1Dc2QrYUZEVHpDNXR0RHNsVjgzaDlM?=
 =?utf-8?B?MWJZQkpVT1NXOHU0L1oxbDg5a09yc0ozLzhlV2pnRkthdGxTU2dRaG9HZXR6?=
 =?utf-8?B?cXR0QVRwdlFqV3lsSVU4UU1ENzdiemVOeVRmemwrT3NlWjRrT2Q2dXJSTHgz?=
 =?utf-8?B?UG4wWVVwTEVwMUMxSUdZeHk1dDF4cjdYOGd2MjhPWjhkdUFGL3ZsOGhNVzFG?=
 =?utf-8?B?UXprLzhHTEg2dXRGcTVJK1NicnAwNUkxQ3hwM3QxTk53L0p6TmtIeUZvWWlG?=
 =?utf-8?B?cnUrbkpvRXJPWUZkVGxTczUrWjFVTFI0eTd6Q1VIQWZoWDEyMGNBU2x4K2hm?=
 =?utf-8?B?ZHZzOWtZVkEvSlU2N296ek5CMnVKdzAreElsV2xLbTBMVVpCNVViaTRiQy9t?=
 =?utf-8?B?dVc0bXcwOEtFRXVZWnhRSmlkOUhiVUZzZWdhTTE2L0xmU0lsZjBldUhCTlZk?=
 =?utf-8?B?dTVjcGE1Slgvdkp2VVFIYkY5ZjJoMTdab2hiRnQvbVNXby9yYWlxVHBQUDI5?=
 =?utf-8?B?azVENUFBeVlxNy80Ykluck10OS9EUVNad0l2RVZRY2N2ZWRLM3dmR0lGQmQx?=
 =?utf-8?B?akp0eVBtTHVJMGU3cEZWbmhPenNJTGZnMzRFb1IwMjk1Y0pBU3RmbEpkbVlR?=
 =?utf-8?B?RkFHN2QydVJRZlJzZmNHRStKaUROQXBRNDA2NUZYcjZXcHVFVU5zRzR1UVJZ?=
 =?utf-8?B?bTBIWHNCSFNqMEJTTlAxc2k2Nlkwemlzekp1WkdYb1VWY3FmQ1BpYXZqa0Yy?=
 =?utf-8?B?cnplMm0xdkF3MERuZEJ0U2NHYkRGSVJLeTlXeWxNeVAvTDdtaHlGT1gyTEhX?=
 =?utf-8?B?VDBOaytnYXNDcXNtVy9ZNXozUHNueWJZY21EL0NtMXRJZE94aVd5bDhhVWdr?=
 =?utf-8?B?OWJqTEw2OCtCY1Raa3U3SDBTLzloRkM0SnB4VUFLWDg4NW5pRWN1Smltelll?=
 =?utf-8?Q?j+2CRSB8KlTPnXAUvXCZ8R8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02976E2EE0A3984CB636323DF8A643D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77f758f-919e-4162-e455-08db20bf3f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 16:56:37.4910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIk2aLBu+7TunThKjdLiyrEt31CiQE+Le0dDV+NGyCzv6MJh3sZXJUTuwWu7wRk8vj58Elc9XJZsoEhrGpJJ3o+iqQFv3SGswmEX+K1VGcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
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

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDEzOjU3ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IFNvIHRoaXMgYWxsIHNvdW5kcyB3ZWlyZC4gRXNwZWNpYWxseSBmcm9tIGEgdXNlciBwb2lu
dCBvZiB2aWV3Lg0KPiANCj4gTm93IGxldCdzIGltYWdpbmUgdGhlcmUncyBhIExpbnV4IHVzZXIg
Y2FsbGVkIEJvcmlzIGFuZCBoZSBnb2VzIGFuZA0KPiBidXlzDQo+IGEgQ1BVIHdoaWNoIHN1cHBv
cnRzIHNoYWRvdyBzdGFjaywgZ2V0cyBhIGRpc3RybyB3aGljaCBoYXMgc2hhZG93DQo+IHN0YWNr
DQo+IGVuYWJsZWQuIEFsbCBnb29kLg0KPiANCj4gTm93LCBhdCBzb21lIHBvaW50IGhlIGxvYWRz
IGEgcHJvZ3JhbSB3aGljaCBwdWxscyBpbiBhbiBvbGQgbGlicmFyeQ0KPiB3aGljaCBoYXNuJ3Qg
YmVlbiBlbmFibGVkIGZvciBzaGFkb3cgc3RhY2sgeWV0Lg0KPiANCj4gSW4gdGhlIG5hbWUgb2Yg
bm90IGJyZWFraW5nIHN0dWZmLCBoaXMgZ2xpYmMgaXMgY29uZmlndXJlZCBpbg0KPiBwZXJtaXNz
aXZlDQo+IG1vZGUgYnkgZGVmYXVsdCBzbyB0aGF0IHByb2dyYW0gbG9hZHMgYW5kIHNoYWRvdyBz
dGFjayBmb3IgaXQgaXMNCj4gZGlzYWJsZWQuDQo+IA0KPiBBbmQgQm9yaXMgZG9lc24ndCBldmVu
IGtub3cgYW5kIGNvbnRpbnVlcyBvbiBoaXMgbWVycnkgd2F5IHRoaW5raW5nDQo+IHRoYXQNCj4g
aGUgaGFzIGFsbCB0aGF0IGNvb2wgUk9QIHByb3RlY3Rpb24uDQoNClRoZXJlIGlzIGEgcHJvYyB0
aGF0IHNob3dzIGlmIHNoYWRvdyBzdGFjayBpcyBlbmFibGVkIGluIGEgdGhyZWFkLiBJdA0KZG9l
cyBpbmRlZWQgY29tZSBsYXRlciBpbiB0aGUgc2VyaWVzLg0KDQo+IA0KPiBTbyB3aGVyZSBpcyB0
aGUga25vYiB0aGF0IHNheXMsICJkaXNhYmxlIHBlcm1pc3NpdmUgbW9kZSI/DQoNCmdsaWJjIGhh
cyBhbiBlbnZpcm9ubWVudCB2YXJpYWJsZSB0aGF0IGNhbiBjaGFuZ2UgdGhlIGxvYWRlcidzDQpi
ZWhhdmlvci4gVGhlcmUgaXMgYWxzbyBhIGNvbXBpbGUgdGltZSBjb25maWcgZm9yIHRoZSBkZWZh
dWx0IG1vZGUuIEJ1dA0KdGhpcyAicGVybWlzc2l2ZSBtb2RlIiBpcyBhIGdsaWJjIHRoaW5nLiBU
aGUga2VybmVsIGRvZXNuJ3QgaW1wbGVtZW50DQppdCBwZXItc2UsIGp1c3QgcHJvdmlkZXMgYnVp
bGRpbmcgYmxvY2tzLg0KDQo+IA0KPiBPciBhdCBsZWFzdCB3aGVyZSBkb2VzIHRoZSB1c2VyIGdl
dCBhIHdhcm5pbmcgc2F5aW5nLCAiaGV5LCB0aGlzIGFwcA0KPiBkb2Vzbid0IGRvIHNoYWRvdyBz
dGFjayBhbmQgd2UgZGlzYWJsZWQgaXQgZm9yIHlhIHNvIHRoYXQgaXQgY2FuDQo+IHN0aWxsDQo+
IHdvcmsiPw0KPiANCj4gT3IgYW0gSSB3YXkgb2ZmPw0KDQpJIGRvbid0IHRoaW5rIHNvLiBUaGUg
d2hvbGUgIndoZW4gdG8gZW5hYmxlIHNoYWRvdyBzdGFjayIgcXVlc3Rpb24gaXMNCnRob3JuaWVy
IHRoYW4gaXQgbWlnaHQgc2VlbSB0aG91Z2gsIGFuZCB3aGF0IHdlIGhhdmUgaGVyZSBpcyBiYXNl
ZCBvbg0Kc29tZSB0cmFkZSBvZmZzIGluIHRoZSBkZXRhaWxzLg0KDQo+IA0KPiBJIGhvcGUgeW91
J3JlIGNhdGNoaW5nIG15IGRyaWZ0LiBCZWNhdXNlIGlmIHRoZXJlJ3Mgbm8gZW5mb3JjZW1lbnQg
b2YNCj4gc2hzdGsgYW5kIHdlIGRvIHRoaXMgcGVybWlzc2l2ZSBtb2RlIGJ5IGRlZmF1bHQsIHRo
aXMgd2hvbGUgb3ZlcmhlYWQNCj4gaXMNCj4ganVzdCBhIHVubmVjZXNzYXJ5IG51aXNhbmNlLi4u
DQoNCkluIHRoZSBleGlzdGluZyBnbGliYyBwYXRjaGVzLCBhbmQgdGhpcyBpcyBoaWdobHkgcmVs
YXRlZCB0byBnbGliYw0KYmVoYXZpb3IgYmVjYXVzZSB0aGUgZGVjaXNpb25zIGFyb3VuZCBlbmFi
bGluZyBhbmQgbG9ja2luZyBoYXZlIGJlZW4NCnB1c2hlZCB0aGVyZSwgdGhlcmUgYXJlIHR3byBy
ZWFzb25zIHdoeSBzaGFkb3cgc3RhY2sgd291bGQgZ2V0IGRpc2FibGVkDQpvbiBhbiBzdXBwb3J0
aW5nIGV4ZWN1dGFibGUgYWZ0ZXIgaXQgZ2V0cyBlbmFibGVkLg0KMS4gQW4gZXhlY3V0YWJsZSBp
cyBsb2FkZWQgYW5kIG9uZSBvZiB0aGUgc2hhcmVkIG9iamVjdHMgKHRoZSBvbmVzIHRoYXQNCmNv
bWUgb3V0IG9mIGxkZCkgZG9lcyBub3Qgc3VwcG9ydCBzaGFkb3cgc3RhY2sNCjIuIEFuIGV4ZWN1
dGFibGUgaXMgbG9hZGVkIGluIHBlcm1pc3NpdmUgbW9kZSwgYW5kIG11Y2ggbGF0ZXIgZHVyaW5n
DQpleGVjdXRpb24gZGxvcGVuKClzIGEgRFNPIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBzaGFkb3cg
c3RhY2suDQoNCk9uZSBvZiB0aGUgY2hhbGxlbmdlcyB3aXRoIGVuYWJsaW5nIHNoYWRvdyBzdGFj
ayBpcyB5b3Ugb25seSBzdGFydA0KcmVjb3JkaW5nIHRoZSBzaGFkb3cgc3RhY2sgaGlzdG9yeSB3
aGVuIHlvdSBlbmFibGUgaXQuIElmIHlvdSBlbmFibGUgaXQNCmF0IHNvbWUgcG9pbnQsIGFuZCB0
aGVuIHJldHVybiBmcm9tIHRoYXQgZnVuY3Rpb24geW91IHVuZGVyZmxvdyB0aGUNCnNoYWRvdyBz
dGFjayBhbmQgZ2V0IGEgdmlvbGF0aW9uLiBTbyBpZiB0aGUgc2hhZG93IHN0YWNrIHdpbGwgYmUN
CmxvY2tlZCwgaXQgaGFzIHRvIGJlIGVuYWJsZWQgYXQgdGhlIGVhcmxpZXN0IHBvaW50IGl0IG1p
Z2h0IHJldHVybiB0bw0KYXQgc29tZSBwb2ludCAoZm9yIGV4YW1wbGUgYWZ0ZXIgcmV0dXJuaW5n
IGZyb20gbWFpbigpKS4NCg0KU28gaW4gMSwgdGhlIGV4aXN0aW5nIGxvZ2ljIG9mIGdsaWJjIGlz
IHRvIGVuYWJsZSBzaGFkb3cgc3RhY2sgYXQgdGhlDQp2ZXJ5IGJlZ2lubmluZyBvZiB0aGUgbG9h
ZGVyLiBUaGVuIGdvIHRocm91Z2ggdGhlIHdob2xlIGxvYWRpbmcvbGlua2luZw0KcHJvY2Vzcy4g
SWYgcHJvYmxlbXMgYXJlIGZvdW5kLCBkaXNhYmxlIHNoYWRvdyBzdGFjay4gSWYgbm8gcHJvYmxl
bXMNCmFyZSBmb3VuZCwgdGhlbiBsb2NrIGl0Lg0KDQpJJ3ZlIHdvbmRlcmVkIGlmIHRoaXMgc3Vw
ZXIgZWFybHkgZ2xpYmMgZW5hYmxpbmcgYmVoYXZpb3IgaXMgcmVhbGx5DQpuZWVkZWQgYW5kIGlm
IHRoZXkgY291bGQgZW5hYmxlIGl0IGFmdGVyIHByb2Nlc3NpbmcgdGhlIGxpbmtlZA0KbGlicmFy
aWVzIGluIHRoZSBlbGYuIFRoZW4gc2F2ZSB0aGUgd29yayBvZiBlbmFibGluZyBhbmQgZGlzYWJs
aW5nDQpzaGFkb3cgc3RhY2sgZm9yIHNpdHVhdGlvbnMgdGhhdCBkb24ndCBzdXBwb3J0IGl0LiBU
byBtZSB0aGlzIGlzIHRoZQ0KYmlnIHdhcnQgaW4gdGhlIHdob2xlIHRoaW5nLCBidXQgSSBkb24n
dCB0aGluayB0aGUga2VybmVsIGNhbiBoZWxwDQpyZXNvbHZlIGl0LiBJZiBnbGliYyBjYW4gZW5h
YmxlIGxhdGVyLCB0aGVuIHdlIGNhbiBjb21iaW5lIHRoZSBsb2NraW5nDQphbmQgZW5hYmxpbmcg
aW50byBhIHNpbmdsZSBvcGVyYXRpb24uIEJ1dCBpdCBvbmx5IHNhdmVzIGEgc3lzY2FsbCBhbmQN
Cml0IG1pZ2h0IHByZXZlbnQgc29tZSBvdGhlciBsaWJjIHRoYXQgbmVlZHMgdG8gZG8gdGhpbmdz
IGxpa2UgZ2xpYmMNCmRvZXMgY3VycmVudGx5LCBmcm9tIGJlaW5nIGFibGUgdG8gbWFrZSBpdCB3
b3JrIGF0IGFsbC4NCg0KSW4gMiwgdGhlIGVuYWJsaW5nIGhhcHBlbnMgbGlrZSBub3JtYWwgYW5k
IHRoZSBsb2NraW5nIGlzIHNraXBwZWQsIHNvDQp0aGF0IHNoYWRvdyBzdGFjayBjYW4gYmUgZW5h
YmxlZCBkdXJpbmcgYSBkbG9wZW4oKS4gQnV0IGdsaWJjDQpwZXJtaXNzaXZlIG1vZGUgcHJvbWlz
ZXMgbW9yZSB0aGFuIGl0IGRlbGl2ZXJzLiBTaW5jZSBpdCBjYW4gb25seQ0KZGlzYWJsZSBzaGFk
b3cgc3RhY2sgcGVyLXRocmVhZCwgaXQgbGVhdmVzIHRoZSBvdGhlciB0aHJlYWRzIGVuYWJsZWQu
DQpNYWtpbmcgYSB3b3JraW5nIHBlcm1pc3NpdmUgbW9kZSBpcyBzb3J0IG9mIGFuIHVuc29sdmVk
IHByb2JsZW0uIFRoZXJlDQphcmUgc29tZSBwcm9wb3NhbHMgdG8gbWFrZSBpdCB3b3JrIGluIGp1
c3QgdXNlcnNwYWNlLCBhbmQgc29tZSB0aGF0DQp3b3VsZCBuZWVkIGFkZGl0aW9uYWwga2VybmVs
IHN1cHBvcnQuIElmIHlvdSBhcmUgaW50ZXJlc3RlZCBJIGNhbiBnbw0KaW50byB3aHkgcGVyLXBy
b2Nlc3MgZGlzYWJsaW5nIGlzIG5vdCBzdHJhaWdodGZvcndhcmQuDQoNClNvIHRoZSBsb2NraW5n
IGlzIG5lZWRlZCBmb3IgdGhlIGJhc2ljIHN1cHBvcnQgaW4gMSBhbmQgdGhlIHdlYWsNCnBlcm1p
c3NpdmUgbW9kZSBpbiAyIHVzZXMgaXQuIEkgYW0gY29uc2lkZXJpbmcgdGhpcyBzZXJpZXMgdG8g
c3VwcG9ydA0KMSwgYnV0IHBlb3BsZSBtYXkgZW5kIHVwIHVzaW5nIDIgdG8gZ2V0IHNvbWUgcGVy
bWlzc2l2ZS1uZXNzLiBJbg0KZ2VuZXJhbCB0aGUgaWRlYSBvZiB0aGlzIEFQSSBpcyB0byBwdXNo
IHRoZSBlbmFibGluZyBkZWNpc2lvbnMgaW50bw0KdXNlcnNwYWNlIGJlY2F1c2UgdGhhdCBpcyB3
aGVyZSB0aGUgaW5mb3JtYXRpb24gZm9yIG1ha2luZyB0aGUgZGVjaXNpb24NCmlzIGtub3duLiBX
ZSBwcmV2aW91c2x5IHRyaWVkIHRvIGFkZCBzb21lIGJhdGNoIG9wZXJhdGlvbnMgdG8gaW1wcm92
ZQ0KdGhlIHBlcmZvcm1hbmNlLCBidXQgdGdseCBoYWQgc3VnZ2VzdGVkIHRvIHN0YXJ0IHdpdGgg
c29tZXRoaW5nIHNpbXBsZS4NClNvIHdlIGVuZCB1cCB3aXRoIHRoaXMgc2ltcGxlIGNvbXBvc2Fi
bGUgQVBJLg0KDQo=
