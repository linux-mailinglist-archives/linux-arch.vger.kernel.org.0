Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63A683A8E
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 00:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjAaXdk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 18:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjAaXdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 18:33:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786985141E;
        Tue, 31 Jan 2023 15:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675208017; x=1706744017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rdwD2VilglIAewt39VazeH6Uzv0bC5Qj7ZMbL2rv/Y4=;
  b=aSCbwVucCrkHryMU7zFJm6+jp8DEngeYJZDf2tnpf8qhk3vr/NvnpMqS
   kqGAfecgc+QK+B/Fy4LE6rvec457BVDTj2KIJ4dQSV6ArifaE12kHpRJX
   oBLVviOGVjC5qI5Q6rC5i0hs+N88pFcswcft5P+ilnEafJ2PcCGoLFCRb
   1e6i6S34wyPhd7L6NbyT5ypzl/WX3Y2EgMKgrVgWj8hGEFeLyi7XnZS4S
   /ZMA99elg+Am2aIWseSQRDpc3Ach8Lz0IPTU68Y/axXBcROqZhdVip+bC
   cNJ+KWVSVBUIlY4De4iNBsbdjo1Qs5IJVeXoDaTWNpyqet0WU4KChz2I/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308334327"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308334327"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:33:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="664666490"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="664666490"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2023 15:33:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 15:33:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 15:33:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 15:33:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tigo32YJTWnt8R8oQCeQmfy2PWuJzMjKQXuPkCmxw/oeWB6wA1C84dYPs9xTRoIB4Yb1l5pcninwrFMK+Fmpi+W4EDkhHgHUgZCwhcNYhXYEqsw5ortPpjg6m1gQjmNiznKTCC7YnV8r6T3bFLGfNI0osp0aQiXApX7Ps7lKwFnhZTrOOksOdlg0gPDPp1O9FTmfNwp7TB0BCfhIMOVwz5XBvXX6XXGwSwhznHT4/syIAmUhyeLRRaBR5gKdmerhvsSddyWKSYRAV6pU8BJ6P27rtMvxRXx1avLZqxJ2dS/ODDLOs3m3iU3WGUg9mr6K7Qo2P4bizqpimpmY9ZG6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdwD2VilglIAewt39VazeH6Uzv0bC5Qj7ZMbL2rv/Y4=;
 b=i6zF8bLS9g+DBRIaDg5vURJ6dLfYgUM9VPpG2tzNFSUkDWhx2nCLp5dzcI3t/ismgDL/ZhevtePtxBy9jbGfzazbRzD0W6vyrc3HNJrY4gFj7JI3y8AfT6NZ7oneqVT5EMc1KjuJZTkeFd8pPw6CXNlvwGVPVpG5WNrd7+PFov+bp5jhK15K+EiCBmHQgz8ijDHL0x1VGiqkNCi0x5GrHMWyIzZEc35NpR4LwJxD82g65sIg/urBjN2/Vi75TB8XQwqZ05tSIGz6X8PToyRM90HKZCCcBA969Pu5wsmlNR5qRHbrC++rqQM4PdbDtILJnR0owR9JVJNCx0UFs1SoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Tue, 31 Jan
 2023 23:33:33 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 23:33:32 +0000
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
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
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
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4CAAUjWAIAAHt0AgAD++ACAAJuKAIAAaOSAgACChICAAMGNAIABTW0AgACQ4gCABTvWgIAA99iA
Date:   Tue, 31 Jan 2023 23:33:32 +0000
Message-ID: <f337d3b0e401c210b67a6465bf35f66f6a46fc3d.camel@intel.com>
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
         <27b141c06c37da78afca7214ec7efeaf730162d9.camel@intel.com>
         <f4b62ed9-21a9-4b23-567e-51b339a643ac@redhat.com>
         <6a38779c1539c2bcfeb6bc8251ed04aa9b06802e.camel@intel.com>
         <0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com>
In-Reply-To: <0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB8200:EE_
x-ms-office365-filtering-correlation-id: 6cfaae95-5394-4230-1b6e-08db03e390c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NnVNj2D9/+VljRx1BxFlLi4TDCUIWHJO3DIqCjgO5Na/qF+u1mY70bnkNon5Wrn0glR1Fpdl6MjZ9ecXQr7H2lFmF/UgDrnAYYb96/dkAFAZreOwAY+FISiyXA4TgEHIVRhA2espTC/SBEeOhwujXK60dlawXs/Xs+/Nn5sNQzRuYEomLMD92Ige3BV0wntwMJ9x2JT4DljGwPgKBmBv7HrDuFFX/4o/JoudEo0fTmk9ckjHGiQfTgyk16+Pt3NbXHAcwQmRCFwkec9cPp7h3XFES0K7DcsdaMVEJGEHX2S0pOTMMhpSaU/A7oD9wpffbD0ikW3M//lsa0zs2UvNvuSklp2Xj5EgynRnk+oRA01u+/FlKT7v8kEuG/fmbX88mV3dvFPnBOYvWkBt/lgr0JqoUtlsnEW69PIYP9Azj2RVLebsyYWIrrDaDiOZmRdfWL+IdE26dwliYDnjZRbaEwF1gTGUu6/eSYCE4edT1kXh7PMSEVlwQD8arF+kMBvPMuUqSw42/mHiB0zJ9KstxSYEL0QnrPKPUpS+7ehanlObcj6gnvlDvEy3VlXZLBq4uuuv9HcqXS066l8D3Mvb+1nls/R2W0amAsi6uFOsy33cWU1QLhH3sbBedsaXNcq+SyH1Slm0E7g6CMTYpUdysgmxgKpjMR5H6cz8j1g5rv8jwsTNxJWDZwo5IxiXE6tJshlPWwgye+YUL/Zc4asRoU5LmfNXnkEmtCJqZTnoKxAlLpSSqJPup+8uKnKk/Cn1uuJRl+AFHJT3iAfz2iypQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(38070700005)(921005)(36756003)(82960400001)(122000001)(38100700002)(86362001)(4326008)(91956017)(110136005)(66446008)(2616005)(76116006)(66946007)(71200400001)(66556008)(64756008)(66476007)(6486002)(8676002)(6506007)(478600001)(186003)(6512007)(26005)(7416002)(316002)(2906002)(41300700001)(5660300002)(7406005)(8936002)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW9mNHlFTnp3aGdFM0FhZTFYdmpnVmNEN2hVcXFuRU1xcnpJZDJLcDB6bmhr?=
 =?utf-8?B?YU45QXBNMzJHaW5DUVRwYlkyR1NGVlpkNVJwWWVZQjZzaEdBYkxBaXVNcER6?=
 =?utf-8?B?RmZqZ3pBMjJXV3A5NlNqQzJqd3JHVWlLdXEvZFJKR0h3K0w0RVhxbTNML05M?=
 =?utf-8?B?STFEUjZ4SDUxZkd2dTZ3MGZ1MEVhTEQwMjRFeGRQdXk3VnRkOTFxSmFCNnpx?=
 =?utf-8?B?NEdZNWg4cXhTTzJBa1ZTMm5hbkhLeDlmcVV1azMrbEhuT21HbUw2YWtYdkpq?=
 =?utf-8?B?RjB6NmRhMWJUeVFTZVN0Z1hmcXhHZFo4YjMxeGpubzRUcjAveHRzRXlRclg5?=
 =?utf-8?B?Z0svL0NPQ3JYRExYYXUyZG1OV3owdjNqNyt0Y0VxK29raGFVYUZHZ2Z5ZXNt?=
 =?utf-8?B?ODdQaUNydlNTUnpORWY0eng3TkpldFNHb2RUbjA4OGdIT0pHMnl2NE53Y2t6?=
 =?utf-8?B?ejdzT29IZE5zTUViM05xSkQwYWhlQlB3d2xuNS9MS3JsWU91c0xReHFvM0pI?=
 =?utf-8?B?em9hRHlWYVNpODZXVEVjNFBVL3BSbG9wODJmQi9Bb1pOSDRhVjNyczBsbnNw?=
 =?utf-8?B?THI4SEo4cVJOMXhITnpqRGdVOGhmTm5KdnZobFNOZkd2eHcrQTYwRmNzTCtq?=
 =?utf-8?B?c3RLWU41YUI2NnNMOHJqMUdOWlJXcTdLbEdnTDQrbjVJZmphYzV3T3RlUkJu?=
 =?utf-8?B?TDNyNlRhM05VZm1GUVZkSGZmeW1sOXhwZGFmYmxFa05TRHlHZEhTN0d4NDkv?=
 =?utf-8?B?M256RS9zeCtEZUZnQmZRQlFMaTIyejlRSGQ4TFp4WEE5Rlo2cHlycm9EdjJs?=
 =?utf-8?B?VEl2QkdxQ04zalRTTTFGZkNwc1RQT251MFpsR3pLOXZ5MjhLbnhYQVo1T2NG?=
 =?utf-8?B?SFhueVN0TnZYWjNkbGlNSWNNR1U3NkF4WE9Bb2xpWVJQY3BMN2NGVm1QeGNy?=
 =?utf-8?B?TWx1MytPRkQwdnozeGNnN3hLTTFFNG9GeDkyaTA1Uit0OWUwUUZyL2tadnhY?=
 =?utf-8?B?a2NJTVBOU0RkY1pocjR1cFVLaFNDbkNqdjVvOGRFc2hFYzVBME15S3JrVFli?=
 =?utf-8?B?eit0cjF0dS9jTnZjbitLLzg1RVpMMEJRbkFQTS9Bd0c1bk5LKzNYdE9Zdjl6?=
 =?utf-8?B?WnZJaEhNYjhyclBrMUNwWUg5WGxJOEgyT0x4Zm1NNWcyK3NVL3NONHd4SHEy?=
 =?utf-8?B?bmNSNm11Wjl2OFVzNDc4amJBNTJSS1NnZys2YUlZaldMcjJWZXlBVllGQVB1?=
 =?utf-8?B?NnV0enQ4M0hia0N0aGM0emhoellzTk8zWEtJZ2s5SlMwOWdxdnUrT2JzOUZD?=
 =?utf-8?B?RGs0bDNtWHZKMDQzK1pPVmhqb3JlRkVqS3hoZmFvd01XNk5sVVUwbmQxV0lQ?=
 =?utf-8?B?c0YvQ1BRRGZCMzJKRkY5cDhkWEpOQ3hUY0VtRzlwaVFJRXZhMmVmMmlJVUh3?=
 =?utf-8?B?NjdXR25qRW81QzFUNGF1Y3BlR0pxZWhweENDWW8rVFJUMDJNbmtyWGhtUzJm?=
 =?utf-8?B?dUMxT1pNZU1saUJEVmM1TDhHdElsclZaVW52Sk5SVTJ0blYwdnlXcXRxVkNH?=
 =?utf-8?B?OHFSYnZIb3dVY1RLN21DeE1OSUFVRXppQTRpZC9nQmRJY0MwMHhSd2ZFTHhG?=
 =?utf-8?B?VUtVbklmbm1tY2pUUk1pdlUva3JnVEVYQ25SQmhXUGpvVFc4S01MaVB5VDE2?=
 =?utf-8?B?QWVaUUNGclF3N1hjNUxXbzVQWDJSQ1JUU1ppQ2syS21lWjk3emJCU3JOSXRj?=
 =?utf-8?B?L0VUUTN2eDhmKzNiZndlTS9XdG5pbUxoSno0dFdwV1p5blp6NXVqWCs0VFUr?=
 =?utf-8?B?TTRuNkh6OFVjVjQ2VmF2MDlvbEZlL3JLS3l6U1ZuSThpU2g1QXNuOGoyVEpO?=
 =?utf-8?B?TE0rNFgwZjZKVWY0ZWRZWW1JV3hFRGRxNkdCcWlIalVhb0dhN2l3U0pCa0N1?=
 =?utf-8?B?K2VSbUFwL2Nwd2hSbXdPZlRHeWVhcHpLK0NtSjBjNGQvdmJQeFYwQ1NyUlB4?=
 =?utf-8?B?cUx5WU5jaE1LQVNncDdBcEdTaWdmcDhXY1l0OFc5T2JKMzNhbkVsZTZoTXB3?=
 =?utf-8?B?bTdTZVhWaHpMckg3TnVvbTFHcmJ6WXQ4ZTQ4ZzBVd3B5Y1VpOFllcnpocWk4?=
 =?utf-8?B?c1JzdXBzT3lack0veDZhSmF2NTBUQm9VRHRYR1lHc3o4OGdtbG9ReStpUTg3?=
 =?utf-8?Q?EQp7poWOT/w9G9SZj5hUkzM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87A738B211BA7140B7C5B02A6FEE56E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfaae95-5394-4230-1b6e-08db03e390c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 23:33:32.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMC5fFMR6a7Ne7OYQkvzKIFLus5+7I6ynlZmpqG1ejEfbukFh+sT49pW1BxRasnXndRxEROYznpFlyTH9M2sxuKeIA0kNPzRK5Xo7Kp4m4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8200
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTMxIGF0IDA5OjQ2ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gU3VyZSAuLi4NCj4gDQo+IGJ1dCBJIHJlY29uc2lkZXJlZCA6KQ0KPiANCj4gTWF5YmUg
dGhlcmUgaXMgYSBjbGVhbmVyIHdheSB0byBkbyBpdCBhbmQgYXZvaWQgdGhlICJOVUxMIiBhcmd1
bWVudC4NCj4gDQo+IFdoYXQgYWJvdXQgaGF2aW5nICh3aGlsZSB5b3UncmUgZ29pbmcgb3ZlciBl
dmVyeXRoaW5nIGFscmVhZHkpOg0KPiANCj4gcHRlX21rd3JpdGUocHRlLCB2bWEpDQo+IHB0ZV9t
a3dyaXRlX2tlcm5lbChwdGUpDQo+IA0KPiBUaGUgbGF0dGVyIHdvdWxkIG9ubHkgYmUgdXNlZCBp
biB0aGF0IGFyY2ggY29kZSB3aGVyZSB3ZSdyZSB3b3JraW5nDQo+IG9uIA0KPiBrZXJuZWwgcGd0
YWJsZXMuIFdlIGFscmVhZHkgaGF2ZSBwdGVfb2Zmc2V0X2tlcm5lbCgpIGFuZCANCj4gcHRlX2Fs
bG9jX2tlcm5lbF90cmFjaygpLCBzbyBpdCdzIG5vdCB0b28gd2VpcmQuDQoNCkhtbSwgb25lIGRv
d25zaWRlIGlzIHRoZSAibWsiIHBhcnQgbWlnaHQgbGVhZCBwZW9wbGUgdG8gZ3Vlc3MNCnB0ZV9t
a3dyaXRlX2tlcm5lbCgpIHdvdWxkIG1ha2UgaXQgd3JpdGFibGUgQU5EIGEga2VybmVsIHBhZ2Ug
KGxpa2UNClUvUz0wIG9uIHg4NikuIEluc3RlYWQgb2YgYmVpbmcgYSBta3dyaXRlKCkgdGhhdCdz
IHVzZWZ1bCBmb3Igc2V0dGluZw0Kb24ga2VybmVsIFBURXMuDQoNClRoZSBvdGhlciBwcm9ibGVt
IGlzIHRoYXQgb25lIG9mIE5VTEwgcGFzc2VycyBpcyBub3QgZm9yIGtlcm5lbCBtZW1vcnkuDQpo
dWdlX3B0ZV9ta3dyaXRlKCkgY2FsbHMgcHRlX21rd3JpdGUoKS4gU2hhZG93IHN0YWNrIG1lbW9y
eSBjYW4ndCBiZQ0KY3JlYXRlZCB3aXRoIE1BUF9IVUdFVExCLCBzbyBpdCBpcyBub3QgbmVlZGVk
LiBVc2luZw0KcHRlX21rd3JpdGVfa2VybmVsKCkgd291bGQgbG9vayB3ZWlyZCBpbiB0aGlzIGNh
c2UsIGJ1dCBtYWtpbmcNCmh1Z2VfcHRlX21rd3JpdGUoKSB0YWtlIGEgVk1BIHdvdWxkIGJlIGZv
ciBubyByZWFzb24uIE1heWJlIG1ha2luZw0KaHVnZV9wdGVfbWt3cml0ZSgpIHRha2UgYSBWTUEg
aXMgdGhlIGJldHRlciBvZiB0aG9zZSB0d28gb3B0aW9ucy4gT3INCmtlZXAgdGhlIE5VTEwgc2Vt
YW50aWNzLi4uICBBbnkgdGhvdWdodHM/DQoNCg0KDQoNCg==
