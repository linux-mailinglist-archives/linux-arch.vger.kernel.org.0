Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6A5F476D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJDQWe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJDQWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 12:22:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11126555E;
        Tue,  4 Oct 2022 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664900528; x=1696436528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PGzav7y+y+iYUYGFI3YYvJEzR/J4oK0N2mrZc6YRrYw=;
  b=OYdFeteo/oYTDi9egRZ1UqYot/iZ76YOH3LN7+7xIbYSaGk6cl38vN1C
   RO59NplffKxNVvVopTtY03ndy6ocCmKQmSblm7gCir6P5FKeYuuHNBaOD
   uro03qGK3gRlNIqQmhWxwtmgXqILtVv5xaWVgtCZgbVk0Y76MVfK9SVmU
   R4zlstHDzAgdE1yaYHbvWSlMyqN0Xsgts7Sbpczd3ohinyytk7rP/Hcvb
   Gk/mpB9AIqVQWXqWARZeA7iVPGuDd+1RrmkJrknUcgV37ZaVjuJYmCkzJ
   l8GpK8wurL3DKDkrHEFa3XB50W1yp+xLFw0JYPZ8Au4QpCUSZMn7MPiLK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="302932493"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="302932493"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="713067921"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="713067921"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Oct 2022 09:22:07 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:22:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:22:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 09:22:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 09:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+1EtY3kR/8XLP4mwOf04/NiMuUzmZvW/VRrDZZ2W/Q5J27OMu+VBd7JdUktpu6lEy70OJ1Te4kuZLGa3W5cGW3XZkY7fLMToBwFTHkowS8tgtxrbGWUOtT5hpufyUnoHPVz9+BJDrRJYwM3tWZy1WSWuj/WkVDArYdctfuwezhHRAmJ/NZLPxCwSzb0xjac0MTeoCOa+vANYlv4637tWPuAH6q2v0WdMHBX/p554x4U1B246/DTM5PYxy18rTT1uICCj99hjayH9CsmPwhD24Cvspssca55F0my+kSAQAsP5V+gKpJc9Zox1hBgIC8NU3B9oT2gmTIbvNIq6s87Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGzav7y+y+iYUYGFI3YYvJEzR/J4oK0N2mrZc6YRrYw=;
 b=TkX1I8YNaVBRlTte5rWEhRSSczVWmR45Y3SAaSaibmf9O61UGiLwVpjxIyiFYOyDtgP0bSnPJuPlwxHKO4+Iznkcce41CYBjyGOf9tPcQLu7Z5K0CYkZDcYIsH5ieAEHC5yNI+h0UwVN7yOs4wqF09AtEIk49bUM6Rzl12ovRcnmOiSthRlqJN8GDCIjxvvMnXWH91gHWkrHHs5+DV7TeYkTvmeHP5DopHPNSKZ6bBiFIqqPZbH1d3FW6Q5CuVDCa2IJOuuxRK1zTthRO0KzFqo2WnBaCcsO4Dp+XRPC7lzyzjl49X31VakhcIn9ezwrOCjr9DO3y0FFII4CSjWSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB6673.namprd11.prod.outlook.com (2603:10b6:510:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 16:21:59 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 16:21:59 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "nadav.amit@gmail.com" <nadav.amit@gmail.com>
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
Thread-Index: AQHY1FMa24Mj89j8rEOlmG8UPkMiXa39gFKAgADx4QA=
Date:   Tue, 4 Oct 2022 16:21:58 +0000
Message-ID: <2d42e48e16578d8cdfe174b2396382220b81e259.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-18-rick.p.edgecombe@intel.com>
         <96BFE665-4A76-4CE0-A22B-A999C4A16FFD@gmail.com>
In-Reply-To: <96BFE665-4A76-4CE0-A22B-A999C4A16FFD@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB6673:EE_
x-ms-office365-filtering-correlation-id: 45c6e0a3-2ff0-4340-3f2d-08daa6248fe1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g9gg25mTP7RAQJABJCy/mBNakRlCZXpy4Sd1x809CFJO/685uTZgpVYXuKAM449jh1hKDUxnopVpTtpenomq3w1uO+XDolXRfUGFD3HPA8znX5uKxhTqjqWN2biu3qx18uR2p69OnK8ijtXuSnPQKOgOdoDSPEayBtuxpr2v2iedJBDX1IkdWDCSjJ8/vXDu1FShob7hfyzFrciU0QVn4trWnohsc2RyuHARSWWpVORzFWEixNLrnMDTUx4U6EDwD44sn3VZsztEn+HZbgX01izlLI7KKlFvGjke/kYPvRBWwR/rgktpo7TQ8LEyryzze8UvtZBpKu+gYbZ1LBptYh7Cs01vCHwWcZermgNDsKScTrsDBgRINALkg8V1n1ExID2K9P0gWQP6C0eRccCb4MwvmxFnGm4EJr2PxtdhpKazkrweHl6rOj6QaedVogEwAVe9kcA1jBvHKevtBkWE/LRsmZuQNVu4YY1wWGEZKgNHkLlDfgZfN9FZ7NS8NVUdyfHSBOOHnHzMaj9xIFQb6NRIHDYIsH505iL9IfPz4ZSxsv4qpQjKtBwsqJRf/1NYJUYbQWV3+rD3jIVBxY1nieEEMIXLGZHOsxsZggDc8eVIr3UT5P16V4TN54TF2QD2w845zC2H46cK7AMG8btUBZoGxsUlRQIgd19nobKsR3+8F4a+3C0GyeqE/28GwkWyWsoqZxukCd+uO00gVNfQj6TOrx2DUAYMisD4HM/X/z3B9lBhult0EbqzgGotgWGCxp1fxn9fo+yLnkBWpenEjClaIsJpKoyGHgG6s/t6zcc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(64756008)(4326008)(8676002)(66556008)(66446008)(41300700001)(6916009)(71200400001)(316002)(54906003)(53546011)(26005)(6506007)(6512007)(6486002)(478600001)(66476007)(86362001)(91956017)(76116006)(66946007)(36756003)(83380400001)(38100700002)(2616005)(186003)(122000001)(38070700005)(82960400001)(2906002)(7406005)(7416002)(8936002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXdEczJBYlZ2REpQNCtYb0wyM1VyeUIyV2dhc2V1MzBpUmVnQUkrU3k4am15?=
 =?utf-8?B?amthbXdxS1VSbW1yTmI1STM0SnI5WTA5NlQ2dUd1MGhUc2tsdUc4d3N2Z1pY?=
 =?utf-8?B?UldxRFdrZWZreU5jU3ZqeWxXNE9PRFMvcVFBeUxoN09PTHRJaDJWbHFEUmxL?=
 =?utf-8?B?ZERSdzFaOVlYTmJDaVM2UE5QeXo3NUVCa0VmeFp5K29MSm1SMnhlUUY2THYx?=
 =?utf-8?B?bjdNNG94Nzg3R3ZSYzk0K2kxTjYvNHNZT2JldWFndFIvSkxiK3F3K2RMUnFl?=
 =?utf-8?B?R2duNDJDazFJbnl0V1MvVE1oZEw0VnJESzE5V3RwUG9RcWFpVEk2cHJDWkEz?=
 =?utf-8?B?V1BFUkd3cmZQVXFOR051WkRzY0xjSitlMkFnVTJ5bG9Fb1FRZ2l2THdmdzdD?=
 =?utf-8?B?azRYSmF2alRDU2dBWHd4Tm1LU2J2dGtiR0VpeU1IYmxvclB4MzRvY0lIZkJr?=
 =?utf-8?B?QmE5b0p2R29VNTJVekxSMldHSm5zSVM2U245U3J4TFllNVBxTmo0UnJQSkVX?=
 =?utf-8?B?b1hHTmtQempaNUJIWGtmRHVLc25JNkxnUjhZQUhkcFJyMEdTTXZxSzgrMENL?=
 =?utf-8?B?QU1jWVFRK0c1YnZEK2ZkN0pkN3dOT2l0ZjhZa3l4UHMrbDRodmZBL2NHLzk0?=
 =?utf-8?B?QXI0V245ZjhwMGFYYlk0ZUJLTzBxMEt6T3FGY0RmdUVZekI1MmRFdStpUGJi?=
 =?utf-8?B?V2cwUHNvQW1IODgzeFFHZ0pFelNoMHhsb2NhTm4yRUt6U2xJOXRiS21wR2VJ?=
 =?utf-8?B?dllSR080ZURtZlM5RlI5eGsrRURYOCt2NktUUWplVko5U0lpRUZNTzQzY1hn?=
 =?utf-8?B?bjlWclkwWU84WGxqZzZSbVk4V3ZkM1pMaFc1Q2RXZDJwK012bGw1VFRZWWZ2?=
 =?utf-8?B?ay9sSURsM2hrM2ZlR2FGanlJMEFBV01OaTl5bkx5RmVhaWE0Z1FPYmtpcnJT?=
 =?utf-8?B?eVJmTjlaYlRqa3pYWVBydXFKRVZ3VzNlTGhkcEpvMHlrNU5aMDFNOTc2N0lw?=
 =?utf-8?B?YXFWdHRLUFY5MDY0Y2plengwSFczVHcrdzJhVXhoWWRTaGpFaXN1bFA2ZStm?=
 =?utf-8?B?WFVQbzRURjJwQ3Q4cmNoYzI4UDV5MVNidDd2RjI2cXdQaVFNM2cvb3hyekhR?=
 =?utf-8?B?cEk2MzdEOE9ORDFkQkVZam02WUJySlpPa2dUS3VJMEIwWFNIaXVTSThobjIy?=
 =?utf-8?B?L2N2SnJwSFhLNGl0T0tNTTQ1V3FzZ0ZmMEpka2diT0cxeDFGbGdqTjJ4UXlS?=
 =?utf-8?B?Y3NTaTAvYnV0RG9RZzdzV3NuQi9vSnBhVkUvN1IvMWl4VGJ0WU8rckVieVJI?=
 =?utf-8?B?SGdPUzJzQWdnejFkalY4Tnh6ZC9HU2pTdG1wRDZNZEpJVHVGY1ZmTHc3WGpk?=
 =?utf-8?B?NUQxYm16YkQ0eFgrblR1L01MUnhrRXFuSHFaNXlqVFk0dGRTNi9NN3NxcCtq?=
 =?utf-8?B?QmYwdUltZXA4Y2syODhNTkxHSm5HeVlab3FtbjdDdFNhZ09jMURtNmlFcUgr?=
 =?utf-8?B?dndSZG1KMldUY1pYOWdUdkxKV1BvMllDdDFTcGxBdWkxVWIyd0hsZGIveG9n?=
 =?utf-8?B?OVJZUzZ3a3V6ZE1kNWxoWWJBQ3dRa2FuWDM4QktubVU1N1A5dXBQdkVBTTNY?=
 =?utf-8?B?dmt4RnhYM0RTbHZ3ajNTOUpLcitBdmp1cHBhWmd5TUQxNWpwSi9GS2Q1MVhX?=
 =?utf-8?B?d3lhbGR6V3p6S2dkQisxZk5saFd6Z0oyRkdSL1BoTzdlYXIxeVk4VWREUG13?=
 =?utf-8?B?bHpVTzY5MmszR1hlTktienQ2blpzOUpCbmRhTUN5cW5KVldhaU9YeGJITGty?=
 =?utf-8?B?Z0pncElDQ3FxcnM3ODFOcS81ZXAzSHRQUzNPSlJCaTN0U05SZVpFczdwa1ky?=
 =?utf-8?B?SE1mZmwzV0Q2NTBJMUIyeEhwdUdtTVAzVzA4UnpUMTVDVjVFMTNkS09KejhG?=
 =?utf-8?B?ODRFYy9aZW5HR0pJMEwzckhqZ1FESEIzQy9rbmxKOE9PMmdzOTZiWmE2cnVW?=
 =?utf-8?B?SStzZVJURTQwSlhib2xCd3lGdjFpRU5YbnRBVGtKUi8rc0pDVWdkOEFhVEly?=
 =?utf-8?B?V0FiV2xwdlJNRk9hVG5mYWRqSWNLanNnd2MrQjNiRi9hSUNhQWN1U3VBSFVp?=
 =?utf-8?B?VGZhQjhDVHJZZnVWb1Z5Ylh2bWVJZHVJN2ZmUjVOWDdZZkt0MHhnL21UbEpn?=
 =?utf-8?Q?1qt7xYYOWmf4lXwiS76uQHg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A62CDBF1DED7B4DB2E9410B3FB04F94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c6e0a3-2ff0-4340-3f2d-08daa6248fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 16:21:58.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNKsyn6RAZlu6cyN7WkYy5Ib4re3NOAlMezdawTeGVYVSKvDTIOqMx3fDzwH96pMHsJ5LiYrrM5emfHjWf8tuko4MwOe7d0Q03MOnEUid30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6673
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE4OjU2IC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiBI
b3BlZnVsbHkgSSB3aWxsIG5vdCB3YXN0ZSB5b3VyIHRpbWUgYWdhaW7igKYgSWYgaXQgaGFzIGJl
ZW4gZGlzY3Vzc2VkDQo+IGluIHRoZQ0KPiBsYXN0IDI2IGl0ZXJhdGlvbnMsIGp1c3QgdGVsbCBt
ZSBhbmQgaWdub3JlLg0KPiANCj4gT24gU2VwIDI5LCAyMDIyLCBhdCAzOjI5IFBNLCBSaWNrIEVk
Z2Vjb21iZSA8DQo+IHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4g
LS0tIGEvbW0vbWlncmF0ZV9kZXZpY2UuYw0KPiA+ICsrKyBiL21tL21pZ3JhdGVfZGV2aWNlLmMN
Cj4gPiBAQCAtNjA2LDggKzYwNiw3IEBAIHN0YXRpYyB2b2lkIG1pZ3JhdGVfdm1hX2luc2VydF9w
YWdlKHN0cnVjdA0KPiA+IG1pZ3JhdGVfdm1hICptaWdyYXRlLA0KPiA+IAkJCWdvdG8gYWJvcnQ7
DQo+ID4gCQl9DQo+ID4gCQllbnRyeSA9IG1rX3B0ZShwYWdlLCB2bWEtPnZtX3BhZ2VfcHJvdCk7
DQo+ID4gLQkJaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkNCj4gPiAtCQkJZW50cnkgPSBw
dGVfbWt3cml0ZShwdGVfbWtkaXJ0eShlbnRyeSkpOw0KPiA+ICsJCWVudHJ5ID0gbWF5YmVfbWt3
cml0ZShwdGVfbWtkaXJ0eShlbnRyeSksIHZtYSk7DQo+ID4gCX0NCj4gDQo+IFRoaXMgaXMgbm90
IGV4YWN0bHkgdGhlIHNhbWUgbG9naWMuIFlvdSBtaWdodCBkaXJ0eSByZWFkLW9ubHkgcGFnZXMN
Cj4gc2luY2UNCj4geW91IGNhbGwgcHRlX21rZGlydHkoKSB1bmNvbmRpdGlvbmFsbHkuIEl0IGhh
cyBiZWVuIGtub3duIG5vdCB0byBiZQ0KPiB2ZXJ5DQo+IHJvYnVzdCAoZS5nLiwgZGlydHktQ09X
IGFuZCBmcmllbmRzKS4gUGVyaGFwcyBpdCBpcyBub3QgZGFuZ2Vyb3VzDQo+IGZvbGxvd2luZw0K
PiBzb21lIHJlY2VudCBlbmhhbmNlbWVudHMsIGJ1dCB3aHkgZG8geW91IHdhbnQgdG8gdGFrZSB0
aGUgcmlzaz8NCg0KWWVhIHRob3NlIGNoYW5nZXMgbGV0IG1lIGRyb3AgYSBwYXRjaC4gQnV0LCBp
dCdzIGEgZ29vZCBwb2ludC4NCg0KPiANCj4gSW5zdGVhZCwgYWx0aG91Z2ggaXQgbWlnaHQgc2Vl
bSByZWR1bmRhbnQsIHRoZSBjb21waWxlciB3aWxsDQo+IGhvcGVmdWxseSB3b3VsZA0KPiBtYWtl
IGl0IGVmZmljaWVudDoNCj4gDQo+IAkJaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkgew0K
PiAJCQllbnRyeSA9IHB0ZV9ta2RpcnR5KGVudHJ5KTsNCj4gCQkJZW50cnkgPSBtYXliZV9ta3dy
aXRlKGVudHJ5LCB2bWEpOw0KPiAJCX0NCj4gDQoNClRoYW5rcyBOYWRhdi4gSSB0aGluayB5b3Un
cmUgcmlnaHQsIGl0IHNob3VsZCBoYXZlIHRoZSBvcGVuIGNvZGVkIGxvZ2ljDQpoZXJlIGFuZCBp
biB0aGUgZG9fYW5vbnltb3VzX3BhZ2UoKSBjaHVuayB0aGF0IGdvdCBtb3ZlZCB0byB0aGUNCnBy
ZXZpb3VzIHBhdGNoIG9uIGFjY2lkZW50Lg0K
