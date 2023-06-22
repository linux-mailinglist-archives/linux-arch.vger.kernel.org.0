Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2510F73A684
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjFVQxA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjFVQwg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 12:52:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E84E9;
        Thu, 22 Jun 2023 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687452755; x=1718988755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=meEsvdLd5DufhQ1CTtffPbSV3R7g/ZUvVjIyxg2qXmU=;
  b=FmAHNiLSWVxBR0ki+LkF3W7qvzML7AfDuiNtL313dGyHuEVgSwRo0AMn
   vF9PG7DpQ+Nzno3xfWCIedoqxNO/Rcai/tPdS9rRFnTWgAadkT4G9Vf5I
   pAA6MS9PiDSHTZF5ktmwoN5cy/BXWfz3aLAOqAQ1Zh7MfzDem/UVRDpDD
   CuCG0HlK3fnTSTfRgWbV9prMMEEdNtwsEPoM/2dQl52gcSqjjIyPY9vTq
   MvMWrfX4efvrGPijirL8ycS0RsuwlJPhhtTWpGmwqu6Ge3b6raMC7Gnc5
   vaj6vaZ08EO5koN0gxkQGBaGbCEHeySd58d3P0xosk71COd5VD1TmT1Zt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350304863"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350304863"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 09:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961631102"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="961631102"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 09:46:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 09:46:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 09:46:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 09:46:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 09:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8rVNvmcX7hNsuRecq7t7pTKn4/uKz8VycVjLeWfDlrdWg7JE4b4oSnDt5BrQpOovh4DxTqHvbhti8y39KKh5mL24x5xGmZ3Nb/HqSbvZ352gooA6CkVXJCz+SFwglHTsqG7KdIeXPjlprZhX1inyuxllV1bMs/Q/E9tUM09zRFNbLTZDcmW9BybcBdfSXnPC5ONeYL9h0Z2L9FwStGTJpvppsWp/I9tJ1aZYjLxFnFSok6TGRp5egkAHeiYJGBASNT4NIgLssExMK/rWTH3zB063BLpOed+fn+Q0LDB3fLTyuOdMHHzR44BZeDGZ5CK8O31nrX78a2i3jqIaAa3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meEsvdLd5DufhQ1CTtffPbSV3R7g/ZUvVjIyxg2qXmU=;
 b=nMNEAJIA6HJRsvy+3El3iTetTa8UIg7lNE2d3qoYr6mFqcqk7PmbVMI7bpLYfxgi2o8NMb8AO9/jim1S3MGlraW9G2DC9N2sHy6WjvC1Pi/wRLz3V6KpGNT0g4/GeKKdMFBVXq2tK+1m+9E+IVp/URM3ZCtxrdyhLP9KNTN9JiyOhrDOHpRNHwL5LenDl6i1gDdUuceRGc71ytXpSYCT5W2mhtMsypfQ2nPotCsnBEarQQIceyZPuK+zgGZSh3/53ZKo4G+CcBGGPiiJu/tNjQxgP3TIbMDbPWI7ANs8Dfw/wHAi8c+I8X7DQjIDwudrraUAPv0bY6IH/nayv5FihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.39; Thu, 22 Jun
 2023 16:46:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 16:46:20 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAEU5AIAAkNiAgACYg4A=
Date:   Thu, 22 Jun 2023 16:46:20 +0000
Message-ID: <39786e2e74013d3006cc6081e4f7faffadcab8f2.camel@intel.com>
References: <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <CAMe9rOrmgfmy-7QGhNtU+ApUJgG1rKAC-oUvmGMeEm0LHFM0hw@mail.gmail.com>
         <ZJP664odSJC+tGzT@arm.com>
In-Reply-To: <ZJP664odSJC+tGzT@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7137:EE_
x-ms-office365-filtering-correlation-id: 33542eba-3cb8-4df0-8050-08db734034c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3SkXmvqp2Jpk0gwx+KHb9qANWTKh+DUymXbq1Viajc6PaMNCrLLZefSOC3wLs/h1Bf26E5iTuFFTwQbFt9OfN5rh1CB8ATjzaXvcADi5GfyYnrYEbYptSBfqQ0numgqoaQmJUcmAoEbCtOVYupZWiYahRjdSp9+I7/g5Y8s4IoFW6KHAfI8QvxGRK5N/BqV2bk1zWYMFuA60UMkuvvkvtviqtG3HQdQAlFArP4TpgBbPRgJKETbnPutU/1pav+J7Cpv9U2DwQoOJNOtdqWQTIZZPcuK8o8qnNm2G6rJqSY3jVy9RrZAiIvV4/cUgHF7O/k/AuOA5W+Fn+nveYjdvNQlXOapEJs9WiVg+NPfSHN+k7nKYaLT/g0Ap/QrYznN66xToK/JTVTIIxYIhw9GT5F5gjCZ69XPpJPDDcN/mxUfoq6czicGQTqAzNjevQaVscCjI7G3B2/ELsRxNIcjZfmoe5WW2y8/DzkwTzF7h/nb+piXHML9Fa/g5npGts/9klSesOH0JUdpno3441Vqi3v0/sJpZ+KoED9OY9pgigpaMU01efiADKEBDkjMwJENCDQaHrqndCx5D2zz1AmLLhl3ycroRYmxnFmUu2f2Mo4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(2906002)(38070700005)(66946007)(76116006)(6486002)(66446008)(66476007)(66556008)(64756008)(4326008)(478600001)(36756003)(71200400001)(316002)(91956017)(110136005)(86362001)(54906003)(186003)(6512007)(26005)(6506007)(2616005)(38100700002)(53546011)(82960400001)(122000001)(7406005)(5660300002)(8936002)(966005)(41300700001)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVpiOXNkZFgxdHgzcldYY1FGeWViRG9HZzVsSWduRmxhY0VDTDBxWURWWEk0?=
 =?utf-8?B?dEpQd0h3VWkrZEJ0SmpoTW1NTy9nL2w2MzdTV21KM3J4d0FMODVSVjVsakJm?=
 =?utf-8?B?UUJST0E4blNCUklHZ24rRWhzeTliL1cvVUt0U2ZpU1I0LzQ5TENBVk5zeWV6?=
 =?utf-8?B?MnRBU0xpcmg1RzZwRDB2QnhKaXRtcVVVaTRkbk1BcUJWRmtrUzdHVG0vakRn?=
 =?utf-8?B?bzRjZ1grQ044SFg4YTI2ZXJwdlNxRW8wRGkzenpNK01WVUpURHhwdzVtdjlo?=
 =?utf-8?B?d3BMK0xuTW5INDlRaVRqN1QvYVRGT2FMMFUyY1RFMC9GcllsVklueXcreDRt?=
 =?utf-8?B?Qk96Mm4yZjJpdlgybjhtc0R5ZXp1OUwxTW80c1kwUzdKZHZ2eGZwQWVjdXlx?=
 =?utf-8?B?S1V0S3V4L1A1dTllUUx6dXNjWFBkVkJlZ2pJSFBacFVJNkVDZlpNdXJxU3No?=
 =?utf-8?B?dTNJYU9GZjhRZWVib205OHZ3WG95dG15Z2VjaGNoKzk0cDA0VmxGRTdrS3h2?=
 =?utf-8?B?SnJQcnhPYUMzeU1NZnB0TEkraDZxekRSK0xtNGpJUTJOTk5QdlVZYk9TZmsx?=
 =?utf-8?B?V1greE1zdlJUbFd3cmpvbzhMU3VQaVBoMW81dXRpMW9FSytJV1prNTc2dWxn?=
 =?utf-8?B?eVlNaHZYNlFHUHVmbUxlYlIzTFNPdTUvT01IanVMVytnUllzbi9FTndHQnNw?=
 =?utf-8?B?VG1NZlJJalpWZU5PV25YRVptRm1paGFUd1VaUGJvT1NOWloxdjIzTXlsdVVV?=
 =?utf-8?B?cUVKUnpqcjBNKzkzK0hseVBwclpOZktreFBtWkJLMjRBbDlYNjRSa3BKN0Vm?=
 =?utf-8?B?N0laU0FsVlhBakdJcXpSL2QwSngzUUlWb0pPL1h6KzdHSmowWkpEallZd1Ur?=
 =?utf-8?B?aGxDNUptZU1qV0hFMTEwMEJ0UjBPQk9TT0dMSTRJekdpdmVxeFR3TmdlOHhO?=
 =?utf-8?B?SEs4WnlJVjRSc25kNVFKdERCU3E2OWcxWTNmN3VQeFNTSXVPZG5yeCtuOStN?=
 =?utf-8?B?MUR4MkNvd2FoT0d1aXloRm8rYWFVYzBScmlmR2hVWWZTVjdIeXZnNVdNRlRL?=
 =?utf-8?B?a3AzOXV5bFdVVlJ4dnEwWHRjYm9DQ0hXMWlvVmVpbnFWZVY1cFp6d0FYTmdN?=
 =?utf-8?B?QTJudkFWTnpYRy9IRnFJbHhNMDVuNVBLb1pJMUlrWmJNUEpSenBPQnlNOTVK?=
 =?utf-8?B?TUVHUlVhVE9jT21Yc1ozdU9ycEZMR0w1dlFjejJyMVArZVk5TU0vN2NVdi9p?=
 =?utf-8?B?NVFURTloc1VzbnoyRUJERFlCcUNUWUM0MWdJbW0zdlhEMjRhdmFhb0NtYzY4?=
 =?utf-8?B?RXFOTlYrRXZ6MzNBaDdFbVkwUDhZeGs1VEJHWnVweGpqYTRIM0FYYXZOenNm?=
 =?utf-8?B?aWZQaEpZUWU2T2k3MFFiSHNzL242Z2JmVG5WRlYxbjRjczVISk9lSTRwTldj?=
 =?utf-8?B?bUc0SXVaamtWTU9wU0tlNnBNWWJMZUJrRU4yMTVzNFhDREhDckM1NzcvTFYz?=
 =?utf-8?B?aEFoNWJHNkR5cWVQckJ6bmZ0QWtJSWhERXZRYVZkQlNUSkJWZWhIY0pYaDNU?=
 =?utf-8?B?ZjVQNWdHZU91V21hbEFwc2RLZVBFR25mODZTYk5pQkRLWWw1dzNNTGVWeG9M?=
 =?utf-8?B?azZpK0hRZlF1a2pqUzh0TnFTVUEvbDZRNkF6Mk83akttRUtZUjdFOE54cytk?=
 =?utf-8?B?bzQrellBcERiVnRLaVBKWnpUZi81OWtveHcyTExJMXFSTmRFem1CdTN6M0JC?=
 =?utf-8?B?VmkvbTZWK3dnbDExaUovU1Y2anU5MlRqaGwrMWZJU1U0T0xoWEJLM05TdGVk?=
 =?utf-8?B?eEVMUmFib3c0UWhaQXhzOGdmMDgxK3hpZmJncGt1SEkyaStVU3NEYzFPSHFR?=
 =?utf-8?B?YXFzZnB6eDNtejlwYVR5a1dRWTFrSEpPaEFJNFgrSTA0ZUxpV0hhM2Jua1lJ?=
 =?utf-8?B?M2EyTmkzbWkrTkhUNCt0Z2I3cFlzaXRIWFA5Z0JLM3hoZFQwWkFQRmlsT1pj?=
 =?utf-8?B?bGpXb0c5cS9jNDNpSDhRdXdUTHVoNVBRekRBVGlqNzNwYVc2NHJFalc1bDYr?=
 =?utf-8?B?TXBROXZKVncxQXNlU3hoUFpvV3paOUc0TWdueDJtdi84aWk0S0IvUlVMUVVl?=
 =?utf-8?B?NERNL0tRaXF6elFnYWJ5ZlAybnBscFNHVFVhVkJucXAxM01hbHZsNFN1ZUMx?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03C8AECB7F7B6B468EB37B0DC4EEBB74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33542eba-3cb8-4df0-8050-08db734034c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 16:46:20.3022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/3f7lUGQIv1hFVH1PhmWfBKFFe+d6QCFibNxJFYu6d1OI1iThwWWK/P5hZ3/IEoV3gQ/2DHqfpw6hb8fecv1x0MVGvJsmkSI+zWDw00pCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
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

T24gVGh1LCAyMDIzLTA2LTIyIGF0IDA4OjQwICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IFRoZSAwNi8yMS8yMDIzIDE2OjAyLCBILkouIEx1IHdyb3RlOg0KPiA+IE9uIFdl
ZCwgSnVuIDIxLCAyMDIzIGF0IDExOjU04oCvQU0gRWRnZWNvbWJlLCBSaWNrIFANCj4gPiA8cmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gSEosIGNhbiB5b3UgbGluayB5
b3VyIHBhdGNoIHRoYXQgbWFrZXMgaXQgZXh0ZW5zaWJsZSBhbmQgd2UgY2FuDQo+ID4gPiBjbGVh
cg0KPiA+ID4gdGhpcyB1cD8gTWF5YmUgdGhlIGlzc3VlIGV4dGVuZHMgYmV5b25kIGZub24tY2Fs
bC1leGNlcHRpb25zLCBidXQNCj4gPiA+IHRoYXQNCj4gPiA+IGlzIHdoZXJlIEkgcmVwcm9kdWNl
ZCBpdC4NCj4gPiANCj4gPiBIZXJlIGlzIHRoZSBwYXRjaDoNCj4gPiANCj4gPiBodHRwczovL2dp
dGxhYi5jb20veDg2LWdjYy9nY2MvLS9jb21taXQvYWFiNGMyNGI2N2I1ZjA1YjcyZTUyYTNlYWFl
MDA1YzIyNzc3MTBiOQ0KPiANCj4gb2sgaSBkb24ndCBzZWUgaG93IHRoaXMgaXMgcmVsYXRlZCB0
byBmbm9uLWNhbGwtZXhjZXB0aW9ucy4uDQoNCkkgZG9uJ3Qga25vdyB3aGF0IHRvIHRlbGwgeW91
LiBJJ20gbm90IGEgY29tcGlsZXIgZXhwZXJ0LCBidXQgYSBzaW1wbGUNCmZub24tY2FsbC1leGNl
cHRpb25zIHRlc3Qgd2FzIGhvdyBJIHJlcHJvZHVjZWQgaXQuIElmIHRoZXJlIGlzIHNvbWUNCm90
aGVyIHVzZSBjYXNlIGZvciB0aHJvd2luZyBhbiBleGNlcHRpb24gb3V0IG9mIGEgc2lnbmFsIGhh
bmRsZXIsIEkNCmRvbid0IHNlZSBob3cgaXQgbWFrZXMgZm5vbi1jYWxsLWV4Y2VwdGlvbnMgdW5y
ZWxhdGVkLg0KDQo+IA0KPiBidXQgaXQgaXMgd3JvbmcgaWYgdGhlIHNoc3RrIGlzIGV2ZXIgZGlz
Y29udGlub3VzIGV2ZW4gdGhvdWdoIHRoZQ0KPiBzaHN0ayBmb3JtYXQgd291bGQgYWxsb3cgdGhh
dC4gdGhpcyB3YXMgbXkgb3JpZ2luYWwgcG9pbnQgaW4gdGhpcw0KPiB0aHJlYWQ6IHdpdGggY3Vy
cmVudCB1bndpbmRlciBjb2RlIHlvdSBjYW5ub3QgYWRkIGFsdHNoc3RrIGxhdGVyLg0KPiBhbmQg
bm8sIGludHJvZHVjaW5nIG5ldyBiaW5hcnkgbWFya2luZ3MgYW5kIHJlYnVpbGQgdGhlIHdvcmxk
IGp1c3QNCj4gZm9yIGFsdHNoc3RrIGlzIG5vdCBPSy4gc28gd2UgaGF2ZSB0byBkZWNpZGUgbm93
IGlmIHdlIHdhbnQgYWx0DQo+IHNoc3RrIGluIHRoZSBmdXR1cmUgb3Igbm90LCBpIGdhdmUgcmVh
c29ucyB3aHkgd2Ugd291bGQgd2FudCBpdC4NCg0KVGhlIHBvaW50IHdhcyB0aGF0IHRoZSBvbGQg
R0NDcyByZXN0cmljdCBleHBhbmRpbmcgdGhlIHNoYWRvdyBzdGFjaw0Kc2lnbmFsIGZyYW1lLCB3
aGljaCBpcyBhIHByZXJlcXVpc2l0ZSB0byBzdXBwb3J0aW5nIGFsdCBzaGFkb3cgc3RhY2tzLg0K
DQpTbyB0aGUgZXhpc3RpbmcgdXNlcnNwYWNlIHByZXZlbnRzIHVzIGZyb20gc3VwcG9ydGluZyBy
ZWd1bGFyIGFsdA0Kc2hhZG93IHN0YWNrLCBiZWZvcmUgd2UgZXZlbiBnZXQgdG8gZmFuY3kgdW53
aW5kaW5nIGFsdCBzaGFkb3cgc3RhY2suDQpTb21lIGtpbmQgb2YgQUJJIG9wdCBpbiB3aWxsIGxp
a2VseSBiZSByZXF1aXJlZC4gTWF5YmUgYSBuZXcgZWxmIGJpdCwNCmF0IHdoaWNoIHBvaW50IHdl
IGNhbiB0YWtlIGFkdmFudGFnZSBvZiB3aGF0IHdlIGxlYXJuZWQuDQoNCllvdSBwcmV2aW91c2x5
IHNhaWQ6DQoNCk9uIFdlZCwgMjAyMy0wNi0yMSBhdCAxMjozNiArMDEwMCwgc3phYm9sY3MubmFn
eUBhcm0uY29tIHdyb3RlOg0KPiBhcyBmYXIgYXMgaSBjYW4gdGVsbCB0aGUgY3VycmVudCB1bndp
bmRlciBoYW5kbGVzIHNoc3RrIHVud2luZGluZw0KPiBjb3JyZWN0bHkgYWNyb3NzIHNpZ25hbCBo
YW5kbGVycyAoc3luYyBvciBhc3luYyBhbmQNCj4gY2xlYW51cC9leGNlcHRpb25zDQo+IGhhbmRs
ZXJzIHRvbyksIGkgc2VlIG5vIGlzc3VlIHdpdGggImZpeGVkIHNoYWRvdyBzdGFjayBzaWduYWwg
ZnJhbWUNCj4gc2l6ZSBvZiA4IGJ5dGVzIiBvdGhlciB0aGFuIGZ1dHVyZSBleHRlbnNpb25zIGFu
ZCBkaXNjb250aW5vdXMgc2hzdGsuDQoNCkkgdG9vayB0aGF0IHRvIG1lYW4gdGhhdCB5b3UgZGlk
bid0IHNlZSBob3cgdGhlIHRoZSBleGlzdGluZyB1bndpbmRlcg0KcHJldmVudGVkIGFsdCBzaGFk
b3cgc3RhY2tzLiBIb3BlZnVsbHkgd2UncmUgYWxsIG9uIHRoZSBzYW1lIHBhZ2Ugbm93LsKgDQoN
CkJUVywgd2hlbiBhbHQgc2hhZG93IHN0YWNrJ3Mgd2VyZSBQT0NlZCwgSSBoYWRuJ3QgZW5jb3Vu
dGVyZWQgdGhpcyBHQ0MNCmJlaGF2aW9yIHlldC4gU28gaXQgd2FzIGFzc3VtZWQgaXQgY291bGQg
YmUgYm9sdGVkIG9uIGxhdGVyIHdpdGhvdXQNCmRpc3R1cmJpbmcgYW55dGhpbmcuIElmIExpbnVz
IG9yIHNvbWVvbmUgd2FudHMgdG8gc2F5IHdlJ3JlIG9rIHdpdGgNCmJyZWFraW5nIHRoZXNlIG9s
ZCBHQ0NzIGluIHRoaXMgd2F5LCB0aGUgZmlyc3QgdGhpbmcgSSB3b3VsZCBkbyB3b3VsZA0KYmUg
dG8gcGFkIHRoZSBzaGFkb3cgc3RhY2sgc2lnbmFsIGZyYW1lIHdpdGggcm9vbSBmb3IgYWx0IHNo
YWRvdyBzdGFjaw0KYW5kIG1vcmUuIEkgYWN0dWFsbHkgaGF2ZSBhIHBhdGNoIHRvIGRvIHRoaXMs
IGJ1dCBhbGFzIHdlIGFyZSBhbHJlYWR5DQpwdXNoaW5nIGl0IHJlZ3Jlc3Npb24gd2lzZS4NCg==
