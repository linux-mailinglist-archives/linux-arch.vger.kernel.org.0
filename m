Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D2572D80C
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 05:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbjFMDPQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 23:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbjFMDOs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 23:14:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733AC1FF0;
        Mon, 12 Jun 2023 20:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686625997; x=1718161997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wca/Hc0qsSprtN0h0A+/3/k6B86fVp0bswPlXQ+74o0=;
  b=Wn51cEnzD8LXADerF10bb4Cd1s0R4JfH4r72jn4XODVz28KPv9VEU8lv
   xuIQP/xr96RvzruxgcXSoaGf89vFwOd+doTk7zxFjsbRoWsdwszPBgN8X
   UYQvNcJF3BuD2cyA135ejS5n+9REQWwouUjuz2mBM/FVKsKznxiT2ODUM
   d6Gay9zDFHs+iqn9AmGqPgS6awhM4DX4+5vJCEd5O3LZGNx+jkub+y4O6
   SPmNLD7YkxdhdXv+QKfFA2Rq84ejHPjl+LZoeJJUylch+9+2o7CoocgTs
   ztUJSZxcMo3Yp150znazuBkcUC3UCgJml4OUTU0wZD6TgdkjhucBpA1dc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="337851933"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="337851933"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 20:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885680074"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="885680074"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2023 20:12:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 20:12:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 20:12:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 20:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFB8MfMnMt/Xn2HibQuwgiGJ3aR+MSYfL8nvDuZiCkWPkXlQQvbfpkaVZNhS7GRxSLopjeS/GHETk50ltIJxh/2RD2HAOxWyXyu9+eLhFFttcNHrIkhWnRVfNdika0ly1nFH5tXVTsm0C5ORJepCIfut7zLdk9UhtRtr/3d/R51gBf2+xgBolkqoWty1FJZBGwrdk3tvM/2NLVNssHDWBgWeVvfTcmMmIqx1z1SYmaFu45bbkmnDlDlz9Be79NZ1VZ46p3xdevxHfLYCK1OoIZAFf6pV3aQnbTpV+jgdbKjQwRU48lkpo3Hn6aRcDCAnWYoI9XXvEgI4JCYw3gTAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wca/Hc0qsSprtN0h0A+/3/k6B86fVp0bswPlXQ+74o0=;
 b=YND5tPsGIRmzK8ZtBWc2A6hbMgEHrgVCxZ1jpeheVjqbvN38EdTmj6bEKsGs6TgBjVhs8eMJjCgVfiY4D6WiSAXJFWwHAizRm8hxwI/4mbMINkMBVfBWDrTknaexGWCH5XvfZ2/bXb+rqwRPTyJ7Fxh0WmKR1J7MKlmTSMPN6m+UeetHaIfVbIsxObNywYp6E21b+L2vcKTJshIpIysXy2oASWefpGPFz9pSYIaXRlfRer2THnNVJcCAZ1vemNTy204ldoo9vLCBquizhvInOTkgG/yhNOSDbJ5SrSyVe6DBLHaCnzZNzqy8VeITyKEucWeGR963qI2qOQHV31P+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 03:12:42 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 03:12:42 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 00/42] Shadow stacks for userspace
Thread-Topic: [PATCH v9 00/42] Shadow stacks for userspace
Thread-Index: AQHZnYu1AGwEUQxptkKuIexmuYma76+H81+AgAAbXYA=
Date:   Tue, 13 Jun 2023 03:12:42 +0000
Message-ID: <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com>
In-Reply-To: <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6977:EE_
x-ms-office365-filtering-correlation-id: bf91b0a1-709b-4462-e6eb-08db6bbc0d7a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +7+XS6ZsMYoyE3mLGEf16FPyvT+kWvOkvek1tEbgRWtEedirsaKJ8rn9f5d3C11+jIjPGcjkPBhY6n+Gayptfn49lX6c2DnOpm/HDZDN+uvry1RydKUlnqAdyOz+7RcMAebCLjbJIbO6Tak8O3IX5BDpdmomxSAsFqjVFg2vym9pVDiGoZILKG0RL6PfpslwCgnTvKEB3wxHqnVqgmEFzckFtVgopVCrIioamUMdCCfQaJ1Z6O9IC9Xq9kHMWJlfscOaLCS6VDFgyAeShLDvVrCAChfqRTNEp0NmfIaKF9r2GIvJsVP0k3U1IWHwZl+UYvjtEzZmCdAEqokyQJ+9VJMxF7G5ljI2SkI2cLzMbq1tBt2nJ4T0PghlhkD37c7WmCU1AIUBLmHUhEjsVcWUB9f86Z51qsCGZc6I4eKEzTu2I0t1B3XbPvr5MiQP2+29f8qKHOGxoU7uFf9l1vLO3QuFKwgohfulDQcAg+KLbMJwvE3Ucp9rNOSAydDuRebNfYqupCrZq2t5suqgUbDCbZHA4aXnajiLwaBGkLCZyoc3fabegZhHUsxCu83o8zOrvUREcBxXk4H71FZ+RvT23UH2klfUBpZrOgi4L2ECinSyg266s/lvMya+/gmzJHUPQ2izdtkDc7rOCce4VhPsGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(2616005)(478600001)(6486002)(54906003)(122000001)(91956017)(82960400001)(71200400001)(4326008)(5660300002)(41300700001)(8936002)(8676002)(66946007)(76116006)(66446008)(66556008)(64756008)(66476007)(6916009)(38100700002)(316002)(186003)(83380400001)(966005)(6512007)(6506007)(53546011)(26005)(86362001)(7416002)(7406005)(2906002)(36756003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFJPVjQvb1hlMlE3cjB6SWtzZk1yQUJRUGh1RHNrS2E5bHNTMFRQeDYybjg5?=
 =?utf-8?B?cC9EcUpqc2o0YmZkOTBQUGhLWm92ZTdHemlIREtQWUFOUHlIUUdPbk9xbTZD?=
 =?utf-8?B?RENCaUkxN2pLMU9BT2NTOUNXTVBPS0xxZE5UZ0ZQd1JvUGdkc3I1VDVMc3pQ?=
 =?utf-8?B?ZmowUWlud1p4S1g2YjhaV0ZXQ0hXVG5idXNLWmpJNm8vK0xST2ZWNDdNdllN?=
 =?utf-8?B?QTlxSTB4R204UHBZemdBZ2tDWW5wZ0pyayt6ZCt3MVc2aTM5VGpwV0hwK3pH?=
 =?utf-8?B?ejA0cTdZTnZORW5FRUNFdG9rRXY3TVBZeHpVYzJvV0xaSEI2dGZaRnhRcW1M?=
 =?utf-8?B?cC9uY0xVeU1uY0JvQnIreEdESThOMjhtOTdtTnB2clBITlZmZWk3Z1VuL0w1?=
 =?utf-8?B?MmQ0ZU1WVXRzeVV5a1A1TVhFRDcyZXFCdHNiV1V6SERyMHpoNTNJbXlSb2tI?=
 =?utf-8?B?cW9QdURYRXMvcUI1T1pLTHVQMFU3TS9HSnA5TlpaS1V2ejAyMFRhTVBHOCtB?=
 =?utf-8?B?Y3VGTythR1Nma1kxQWZoKzlHeFQ3ZUVwVWY3VDNxSVBUd0ZMYUJSRU9SM3JE?=
 =?utf-8?B?K1NQMnVveVlKOU1FTU5obkRUeW9lTWEvVTlVa1EwL2tucVRLeTRMbWFhdnhJ?=
 =?utf-8?B?WnVDc3h6YVFMcmF6RDA0WFJrTmdmb3FMbElJTG9XVS9HK1dHK283YU5yZjhv?=
 =?utf-8?B?Q0VtOGVqOWp3OFQ0TDg1enBuZkpzV1BPbENYUFZwK1VvTUdnRTJ1b0FvWlNU?=
 =?utf-8?B?REFuNTBScGIvVXFZekY0QjBIaUlxK085SEc3MTNWUXA5VlV1N1Frb25QRlF4?=
 =?utf-8?B?Yi80dUlIMWNYMVlMbVVuRWZ0VWtKaWI3dFpOalQ2UzVod2U3Z095cjVUZGdK?=
 =?utf-8?B?aVhhdWVNTmVxVWpNLy9ZQTQxR2ZPeUtSSlBZTlNTSDNTMC9vbTVFYTBhQWRJ?=
 =?utf-8?B?MURkZmszUGtzcTlKdWhaVWZQcXB6aFhhNVhKWFVlKzhQZFE4aXBtUU0vSFBX?=
 =?utf-8?B?dW8xaTJXSGU2UjlVaHdBZ3puTVpVT2thZ3dJQzYxSTNkMnhuVkpmTXFoSFY0?=
 =?utf-8?B?T2J3M1RmOHhRcG1rU0JKai9qVkRFZVVJR1Y5SGNrQU9XMXA3Q2NIeHptNU1S?=
 =?utf-8?B?cjdHZ3NUY0ZGemFDdHhQRU1FUXh6dzZ2MmNETzhHRDdrWWowWEV4TVkwR3dS?=
 =?utf-8?B?NnAzM0pTM3lHcjhMMDJqYXIwYW4zWnhCQnBvTzFWd2hMbmtvNHJTZkZSY0xx?=
 =?utf-8?B?b3FSeXBqYVFsSTJCZGp6RmhQQ2M2NzM1dXF0NFpDRk5lODMzL05mcHg0SFdU?=
 =?utf-8?B?d1V3bkltLzYxRHltNktiQTVjSVo1NTRmRDBQWmxnSzVIWjRWQmdtMkpOSjY0?=
 =?utf-8?B?ZEc3OFVJMkhKYUhBSDZhQUJmeGRoL1E2dlRmelovOHNIRU9VZVU0S0w2Sy9h?=
 =?utf-8?B?bHRuc0xLY2xKdlZTTDR6aHJtVHBQdW1FRHRKUXRIV2hiWTRkd1MxWFIvY2xa?=
 =?utf-8?B?ai9pMFFXWlJ6QmFvVWcxWVIvT3lTeWR2L2RVem9pVUFnNlg1UkJ1QVl2c2ZI?=
 =?utf-8?B?aGZHcG5oY0pUb2VlV1dwRnlUWThUa0czdXB6Y0xFc2tVWmM5NCtwU0N1cVNn?=
 =?utf-8?B?aFRrVWJ4UE1PT1RwZTZoZmdUTFpLL3NXbHRxN05XTnZRNmt0MnZrM2ZZWEJk?=
 =?utf-8?B?Z3V4NFkxSHZVS2VCV004Zmh2Unk5ZkxEVHg5dkhwVitaWnJQWUR4WU1wMFZB?=
 =?utf-8?B?bzR3YnBxaDNKVVpyZXF5d0Z1SzFvMFRLU1FZclNJVmFpM1hRcDVPdXlGQTVv?=
 =?utf-8?B?ZFZSNkJnSzdqTWRoN2RTVlNLc3QwRnV4N2ZWKzdSeVZEb1Fvd1BmeTNXZ255?=
 =?utf-8?B?WFdpbjF3ZjhqZWFLMG45ZktzWmErdGNpOXJCaVVTQzZhTXBsVXhMT1BhcVN2?=
 =?utf-8?B?c0UvZnRZWUkzR2plSG1USGhlQUJIQ2VpVE9WV04vS2VsRHJtc29ZT0lHbmNj?=
 =?utf-8?B?Nk1uYlhoakUzUGJ3QlU3L0I5RElIblc3QUxNWkMrYjdQUTdDbFptMWtQdzFF?=
 =?utf-8?B?bVJqWnJPRXdPemI2Qm91QTlqeUhROW1oSFR5cTJld2hWemcwSGZMMmwwOVFl?=
 =?utf-8?B?Y2VKWWhCWXFtbFU1Mi9mQnNHVUU0Z1k2WjB2RGwzWTNpdnh0ai90Y05TLzQ2?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F275CE83AEAFA428BEC64A13110DAB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf91b0a1-709b-4462-e6eb-08db6bbc0d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 03:12:42.6628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T09v9z1SX1z1J4UCCYUi7ksPq/g/+2cUzf/Cp6Ul0/GXSramFgpKT8BvfQSSJD432NNpdZaNnJcz0xKYPVa0Ysbsuwq0lpbPpFLB74mNTBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTEyIGF0IDE4OjM0IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgNToxNOKAr1BNIFJpY2sgRWRnZWNvbWJlDQo+IDxy
aWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gVGhpcyBzZXJpZXMg
aW1wbGVtZW50cyBTaGFkb3cgU3RhY2tzIGZvciB1c2Vyc3BhY2UgdXNpbmcgeDg2J3MNCj4gPiBD
b250cm9sLWZsb3cNCj4gPiBFbmZvcmNlbWVudCBUZWNobm9sb2d5IChDRVQpLg0KPiANCj4gRG8g
eW91IGhhdmUgdGhpcyBpbiBhIGdpdCB0cmVlIHNvbWV3aGVyZT8gRm9yIHNlcmllcyB3aXRoIHRo
aXMgbWFueQ0KPiBwYXRjaGVzLCBJIGZpbmQgaXQgZWFzaWVyIHRvIGp1c3QgZG8gYSAiZ2l0IGZl
dGNoIiBhbmQgImdpdGsNCj4gLi5GRVRDSF9IRUFEIiB0aGVzZSBkYXlzLCBhbmQgdGhlbiByZXBs
eSBieSBlbWFpbCBvbiBhbnl0aGluZyBJIGZpbmQuDQo+IA0KPiBUaGF0J3MgcGFydGx5IGJlY2F1
c2UgaXQgbWFrZXMgaXQgcmVhbGx5IGVhc3kgdG8gem9vbSBpbiBvbiBzb21lDQo+IHBhcnRpY3Vs
YXIgYXJlYSAoZWcgImxldCdzIGxvb2sgYXQganVzdCBtbS8gYW5kIHRoZSBnZW5lcmljIGluY2x1
ZGUNCj4gZmlsZXMiKQ0KDQpTdXJlLiBJIHByb2JhYmx5IHNob3VsZCBoYXZlIGluY2x1ZGVkIHRo
YXQgdXBmcm9udC4gSGVyZSBpcyBhIGdpdGh1Yg0KcmVwbzoNCmh0dHBzOi8vZ2l0aHViLmNvbS9y
cGVkZ2Vjby9saW51eC90cmVlL3VzZXJfc2hzdGtfdjkNCg0KSSB3ZW50IGFoZWFkIGFuZCBpbmNs
dWRlZCB0aGUgdGFnc1swXSBmcm9tIGxhc3QgdGltZSBpbiBjYXNlIHRoYXQncw0KdXNlZnVsLCBi
dXQgdW5mb3J0dW5hdGVseSB0aGUgZ2l0aHViIHdlYiBpbnRlcmZhY2UgaXMgbm90IHZlcnkNCmNv
bmR1Y2l2ZSB0byB2aWV3aW5nIHRoZSB0YWctYmFzZWQgc2VnbWVudGF0aW9uIG9mIHRoZSBzZXJp
ZXMuIElmDQpoYXZpbmcgaXQgaW4gYSBrb3JnIHJlcG8gd291bGQgYmUgdXNlZnVsLCBwbGVhc2Ug
bGV0IG1lIGtub3cuDQoNClswXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC80NDMzYzM1
OTVkYjIzZjdjNzc5YjY5YjIyMjk1ODE1MWI2OWRkZDcwLmNhbWVsQGludGVsLmNvbS8NCg==
