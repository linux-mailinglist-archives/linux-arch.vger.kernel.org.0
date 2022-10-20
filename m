Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E737606A27
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 23:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJTVW1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTVW0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 17:22:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B0B18A538;
        Thu, 20 Oct 2022 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666300945; x=1697836945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AUbAAx0mn7dkEU2QGf+fM+C6EvWrlgccjIW/8IveERg=;
  b=QS+6zy7kQKbPT6WY71q/i1KA2YSVmJWXHPT5kojZdLoLn3xjyZCNiULI
   1nz/Y+cNWSfaGMiFL8NZ3HpU1OUKIlJNuXtt9gq/w/CYztczlbX+ph6lv
   kdbWUE96cCEWsm8WqO9xIpPf90AMh0mzJIluEcaxuYOsoXXz2pvVySr1N
   uNYniWo5tdnD5UWvqFsHaFguF3Kmd59g5hVyAR/CVBA1qYgY0gJ89juPl
   UREXoYH9jlAHXiGRroziKhj4xmPKzKhYjj1m4tsEV7daTnbMkmRsKxK4c
   G5tAgK0zeWTpWaqo5p78nW7uQiAZdw2v7DvD5M2tgS19f1x9qVJVat/Hj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294236151"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="294236151"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="661175480"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="661175480"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2022 14:22:23 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 14:22:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 14:22:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 14:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJLY47oRlK9YXUpgMXVGaHLiwOilE7esvYXrpCTSOibPPmLmaUpWsWJR6QqyCrdJY4JYjkcpAauTMW5DMHQU4IBlJqRsrsfxlRHZI3XsYj8NZP1IRqx9zh9Yby8dJB0VMyRvl0j/ohQlez7avWiLS1B/Xmb/daQwno8N++d0YA+rYmxe3Ob+Siv1QimeoK/DGcM+18V4JX3oMNkqx8NG6FjSVy7DIsIPGw1+EzedoLJXKUKa6bhnnjS7wbqKzK/U3GvqoyrGEKvf3RN3776nb0y+43yhZlKB5FnDzqIyBHUEBYRP6ILxMHm28KY9kZcENqlRsWxBlloRQVhcnX46gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUbAAx0mn7dkEU2QGf+fM+C6EvWrlgccjIW/8IveERg=;
 b=nFcYjbW+Oxot2ocZVbbPRtwUKrN+DMY+QOPKN1l2TrRvdFF/AM3U1YRrSq8FNpQl+EsynbibU9dftng5lahcj9kwtO/srKJWAnMFxfocnbbO8zN0hq12mYjKOyfevN+V8h9aHG5kxVcJ/yM/seVpLxszbMtjpgiUX943xGL5bFKNsLe/JxR4aakeq4pL8GeTo4pb7kFOMDSUR/hPhB35vo8cc+8gooUXIqmmWyiZ7MEZD3RjpjQSLFGuqcsqzfQuLwDlht0Luept3BHcrXWuYcLyNmNePYD3Tvrgm4diaNeBg84S0BxSPFGVLaW8Sb/Sp1hjXIE8sG5IcCZIzCg7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 21:22:18 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 21:22:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "nathan@kernel.org" <nathan@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Thread-Topic: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Thread-Index: AQHY1FMn8lBh+KlmckGpJ8Z/vQs/Tq39XyQAgAADPACAAE+7AIAAtm0AgABB7YCAAA5ogIAABFEAgBkuOQA=
Date:   Thu, 20 Oct 2022 21:22:17 +0000
Message-ID: <8d709a88251df3695579c851f9ee28032f9e7c1e.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-34-rick.p.edgecombe@intel.com>
         <202210031656.23FAA3195@keescook>
         <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
         <202210032147.ED1310CEA8@keescook> <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X>
         <ae5fea4b-8c33-c523-9d6d-3f27a9ae03d0@amd.com>
         <9e9396e207529af53b4755cce9d1744c0691e8b2.camel@intel.com>
         <YzycjLUVh/WhPtKa@dev-arch.thelio-3990X>
In-Reply-To: <YzycjLUVh/WhPtKa@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB7173:EE_
x-ms-office365-filtering-correlation-id: 1d83e492-cef1-421e-3aa1-08dab2e12a5d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igcEnsS9rG6r2A1EWGyXB+clOrPJ++PAhR/EZKPvbpSWl7dk4SFO5DU2bV6qBwE/TI7P0meaXrqk0ZvHA8GqD2GmvJ1VOSopJgaj/tt7KIpohR3l8N9BCRxfEdeM0Q+uXJ6VZ9KXED0WbXgYRrEv91L3aRMmrN/lMESZ4oMriUjFP5Fa3C2jxNriPRmX0uT4wwp1dDTXveVKm35yggNHdtmwanLMXdmMPIp3Boy3ZK3pCZ/Xadz586jLvxb+Nv1IP5EXm94qvyJerWfg1BIEa7IjATGkT8/SJYi66q9mK+zid19SmUTttALyrd1MSgnLfIYMXS90ZelkkuoLu3jjJ3e4+xdjCVxj+I/pL+gBV5Wf5Yiz2Atwi7Csp8y7vJv2WRnnaaqH94Jh8XEeb7eNBMtVnlV2DRmbHgzWjmkGv7QfGqjYmsilj7IjkVo5e0+h/MwGcmCIzEmoBPVqTzMZyelHM1mM2bTPzJdlCW5SDoZpg6w0jByN/sUavRSd2SX90vfZHvPslw/w9gabP2/4y3IwW/xt4Z2xfdVpyS9uNOdnpqlC/pGCSekLMbthM1jyRz10bx2Dhx9KV9UnZSfv2+++I0t0IX8pN7YYcLfx3AwfR4zVgiAYhc5RJ1E8NwlkSmUG8sf9Ie5ZZw384/PtmlKFtb97iisBCQ0QD4atc0rPl60qomlEIbjMbdMNXn5XSBUsxMhLnUu2DfvpYJ4yJEdWAg5NLTMDqEzCtoe5aEnCeCcxX3lCmLHSihgKic1ZjB3Duarnpc323rXj2SkLiJ3yGDuMovLRnQFfwpdt2Pc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(41300700001)(7416002)(8936002)(7406005)(5660300002)(2906002)(36756003)(64756008)(76116006)(71200400001)(6916009)(54906003)(91956017)(38100700002)(53546011)(38070700005)(6486002)(478600001)(66476007)(6506007)(66446008)(4326008)(66556008)(8676002)(66946007)(26005)(6512007)(86362001)(83380400001)(186003)(316002)(122000001)(82960400001)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxvdFl3ZW5hK3lWbWlwWkVqbncyRmNtTTVxN0ovWk8rcUJ5ZFpxbENjSHNY?=
 =?utf-8?B?S1ROUE1iaFRvVHJRVmlJK1I4Ni9VWjZkU0VEbHVrUjNYV1pTWlpQT3UyMEg1?=
 =?utf-8?B?ai9IeG5Tc1d5Y0VONXQvZmViay9OTlNMeFFQRHB2dnV5UERLSGlmalBCN0dV?=
 =?utf-8?B?eGZ2QnVhTWg5U0RZMnA5TGFWTytXQit6NlpXMS8wV3lxVm9wUVdWVHlOb3E2?=
 =?utf-8?B?ZUtnTDBhRGRCMG8wZUMyZ2RpdFZWNWk3NzljL080ay9RQ2N5d2JtLytpQ0JV?=
 =?utf-8?B?dEZrdWNWT2JBRHR5c1k1Tnh1V3VmenB2c1VvK29rR2VaczJvdThGSXZiOWhq?=
 =?utf-8?B?QmZEWXUvUno2Wm1ZcGQ5b3RzdFFhd05hRFhwbHZ0S1QvNTQ1VUh2MGZXTHZi?=
 =?utf-8?B?UFlENVhJL2lxQ0UzNEJoSGxwK09wQWxZdGV6UWRqSUZqQ3BXL3VHOXZqdFNt?=
 =?utf-8?B?bFQ3cE9jT1IzdmsxUzkwNC9ZMGJjS0k2R2tXM0MxWG1pbjF1SVplT3FoZmVk?=
 =?utf-8?B?eldqaTRMcVdGTWltL3NEanJyMnV1ckRSc3QxSnFvejA5Y1RVa3kxa3pnMzRs?=
 =?utf-8?B?UWJJd0t2bnczK29xdDdYUTBZbWNuV203REJJcHpWcFplZnZRc2U2OVZnQWY4?=
 =?utf-8?B?bnVoRXE2SmZTRUN0eW5sYkgveEtZd2h2VVRUV2lzZk1PV0VITmpzSG1JNWo1?=
 =?utf-8?B?T1ZVRVR1Wk8wMmtrU0l5Q1l3cHpNejJVQ0w0ejdRa25nRmpOeGxSVE0xWTB4?=
 =?utf-8?B?MjVOcDhmME00ZUtzL2JHZktDbGZLMVl2ZklVbnZyYnk0aklkSThndENyMWpl?=
 =?utf-8?B?VGtvc243ejgrcGIxQm1NQlZlYWZQU3hoVWZrdVVCbkRLUFdydHlteWI3bTFG?=
 =?utf-8?B?Q1ljZi9aMEt3UWNZY3AyTmZyckxPM2ozdkl5U3NrUDhvdWgxRzlHTElKTjBk?=
 =?utf-8?B?WVl2dFRtY2c4S01DY2xUZHB1cCswWGU3VEdIWWNHY0RmUlN3VHNuMllFNXox?=
 =?utf-8?B?NnZsN1FEdEVJVk02a0cxT0xSUG5LNUl0L0JkMjBmTXp3bmQ4Y1R6RVdWc3lP?=
 =?utf-8?B?L1VjV3B5NU1ZTFB5YkNYazRmSTM1Nm1aRHJ4NFB5dlowKzNTbGd1L0lNQmN1?=
 =?utf-8?B?ZG42WHBhTDd0V0VxWTB1YmpJMGlTVmNDQjBGSzhDakpCZCtaSHRVbkpnamk2?=
 =?utf-8?B?UFBjQkcrZzVjekJQOFdaUVdCenhucUU4WG1iU09lV0NHWklnOFhlOW9mbnIx?=
 =?utf-8?B?dk5LYUhUUTBWbjFlbkRYRzVSSXlGeHVnQUVEVzhaYkEwMEtJWEZVYjUxUDMv?=
 =?utf-8?B?Ri8xQ2JnenRiYTZVNW05TnJoTG1RRHo5aW02dGhUNGFvdlc4czVyalRKd0Za?=
 =?utf-8?B?bDFHRTd0TEc0d0FnVVJ6VTRSanZicTJZeVNkZFgvWFM1Qk5RMURMeHQzME1B?=
 =?utf-8?B?aVhIb0xIS2hCeGhKT0FCQWthOTg2b1hXS0s1d0FYeGJHM1UyeU1ERStCV2VR?=
 =?utf-8?B?R0VyTDJZeHlDRFUrd2NFTlg5NkM4YmdQeGpLWkF0clF2U2pnR3RrN0k1VWFw?=
 =?utf-8?B?eVF2eHpXZmU1NExTSnY4Z0RyQTF0UjBJUDB2aVhNWUhTMWlOTGtUZXhacTJ4?=
 =?utf-8?B?TndFUlp2Yzc0UE1idjgyWXhRSUxnbDRSQW1NVER3VHJjVks3bzRXU0hFZjQz?=
 =?utf-8?B?SFd3MzEvL3BuQzhKWEptOHg1bW5VRHhhUTJnTWhIc1lxQnRrM3R5MzFRL3Vu?=
 =?utf-8?B?a290Y1B2Z1ZvVHE4cjk0VUgwbDkzZWtKY3VTVzhzZ1NLR3lpbFRtMTJVQUw0?=
 =?utf-8?B?OG1NT2IwTmJuV09leDQrbS9zdllTaUJNS1ZCeVpzN2pXb1c0RDErcUgySUp5?=
 =?utf-8?B?cmFWU056ZDN3d01GcHljaFZvamkzeittMUptb1hFaGlvdlJvNDQwUEhWczNR?=
 =?utf-8?B?S3JKNTNSbGk0aGNkNHd2d3VZcmxXa0NzRmFWQmxGeUlwVnlVUkd0bUMwaktm?=
 =?utf-8?B?aE9Wd3pCUjBQRDV5Smd0aGFpa3RaYjd2QWxXOGRlSFFGMml6RWVVbVM2eUp0?=
 =?utf-8?B?L0hJTTBvei9zQVZaQVpMQVlIWUVudHV2ZVdwejg4ZEhFSE52b2R1YWhBK1dk?=
 =?utf-8?B?OGFvVjJtWHVRaEhEM3VPNWtJK3N5Zm5HMlA4S2daOTMyeHIvcFN5QkFXMTYy?=
 =?utf-8?Q?9XV0I0K/UCGadZJVDGxk8Mc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FFCBD84268503469214AA91A1131F23@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d83e492-cef1-421e-3aa1-08dab2e12a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 21:22:17.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnVXlhKLU274ordGLWn2GMkXHOsi6PiXHrmcQWc913hM2k+nNz40avOx1qnCLwKOb+JJSt+C7vkChMUhCKYQGzicPXWSX1EYGxqnjs5c6bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDEzOjUwIC0wNzAwLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90
ZToNCj4gT24gVHVlLCBPY3QgMDQsIDIwMjIgYXQgMDg6MzQ6NTRQTSArMDAwMCwgRWRnZWNvbWJl
LCBSaWNrIFAgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIyLTEwLTA0IGF0IDE0OjQzIC0wNTAwLCBK
b2huIEFsbGVuIHdyb3RlOg0KPiA+ID4gT24gMTAvNC8yMiAxMDo0NyBBTSwgTmF0aGFuIENoYW5j
ZWxsb3Igd3JvdGU6DQo+ID4gPiA+IEhpIEtlZXMsDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBNb24s
IE9jdCAwMywgMjAyMiBhdCAwOTo1NDoyNlBNIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
PiA+ID4gT24gTW9uLCBPY3QgMDMsIDIwMjIgYXQgMDU6MDk6MDRQTSAtMDcwMCwgRGF2ZSBIYW5z
ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiAxMC8zLzIyIDE2OjU3LCBLZWVzIENvb2sgd3JvdGU6
DQo+ID4gPiA+ID4gPiA+IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjMwUE0gLTA3MDAs
IFJpY2sgRWRnZWNvbWJlDQo+ID4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IFNo
YWRvdyBzdGFjayBpcyBzdXBwb3J0ZWQgb24gbmV3ZXIgQU1EIHByb2Nlc3NvcnMsIGJ1dA0KPiA+
ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+IGtlcm5lbA0KPiA+ID4gPiA+ID4gPiA+
IGltcGxlbWVudGF0aW9uIGhhcyBub3QgYmVlbiB0ZXN0ZWQgb24gdGhlbS4gUHJldmVudA0KPiA+
ID4gPiA+ID4gPiA+IGJhc2ljDQo+ID4gPiA+ID4gPiA+ID4gaXNzdWVzIGZyb20NCj4gPiA+ID4g
PiA+ID4gPiBzaG93aW5nIHVwIGZvciBub3JtYWwgdXNlcnMgYnkgZGlzYWJsaW5nIHNoYWRvdyBz
dGFjaw0KPiA+ID4gPiA+ID4gPiA+IG9uDQo+ID4gPiA+ID4gPiA+ID4gYWxsIENQVXMgZXhjZXB0
DQo+ID4gPiA+ID4gPiA+ID4gSW50ZWwgdW50aWwgaXQgaGFzIGJlZW4gdGVzdGVkLiBBdCB3aGlj
aCBwb2ludCB0aGUNCj4gPiA+ID4gPiA+ID4gPiBsaW1pdGF0aW9uIHNob3VsZCBiZQ0KPiA+ID4g
PiA+ID4gPiA+IHJlbW92ZWQuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPA0KPiA+ID4gPiA+ID4gPiA+IHJpY2sucC5lZGdl
Y29tYmVAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gU28gcnVubmlu
ZyB0aGUgc2VsZnRlc3RzIG9uIGFuIEFNRCBzeXN0ZW0gaXMgc3VmZmljaWVudA0KPiA+ID4gPiA+
ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiBkcm9wIHRoaXMNCj4gPiA+ID4gPiA+ID4gcGF0Y2g/DQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFllcywgdGhhdCdzIGVub3VnaC4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gSSBfdGhvdWdodF8gdGhlIEFNRCBmb2xrcyBwcm92aWRlZCBzb21lIHRl
c3RlZC1ieSdzIGF0IHNvbWUNCj4gPiA+ID4gPiA+IHBvaW50IGluIHRoZQ0KPiA+ID4gPiA+ID4g
cGFzdC4gIEJ1dCwgbWF5YmUgSSdtIGNvbmZ1c2luZyB0aGlzIGZvciBvbmUgb2YgdGhlIG90aGVy
DQo+ID4gPiA+ID4gPiBzaGFyZWQNCj4gPiA+ID4gPiA+IGZlYXR1cmVzLiAgRWl0aGVyIHdheSwg
SSdtIHN1cmUgbm8gdGVzdGVkLWJ5J3Mgd2VyZSBkcm9wcGVkDQo+ID4gPiA+ID4gPiBvbg0KPiA+
ID4gPiA+ID4gcHVycG9zZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSdtIHN1cmUgUmlj
ayBpcyBlYWdlciB0byB0cmltIGRvd24gaGlzIHNlcmllcyBhbmQgdGhpcw0KPiA+ID4gPiA+ID4g
d291bGQNCj4gPiA+ID4gPiA+IGJlIGEgZ3JlYXQNCj4gPiA+ID4gPiA+IHBhdGNoIHRvIGRyb3Au
ICBEb2VzIGFueW9uZSB3YW50IHRvIG1ha2UgdGhhdCBlYXN5IGZvcg0KPiA+ID4gPiA+ID4gUmlj
az8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPGhpbnQ+IDxoaW50Pg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEhleSBHdXN0YXZvLCBOYXRoYW4sIG9yIE5pY2shIEkga25vdyB5J2FsbCBoYXZl
IHNvbWUgZmFuY3kNCj4gPiA+ID4gPiBBTUQNCj4gPiA+ID4gPiB0ZXN0aW5nDQo+ID4gPiA+ID4g
cmlncy4gR290IGEgbW9tZW50IHRvIHNwaW4gdXAgdGhpcyBzZXJpZXMgYW5kIHJ1biB0aGUNCj4g
PiA+ID4gPiBzZWxmdGVzdHM/DQo+ID4gPiA+ID4gOikNCj4gPiA+ID4gDQo+ID4gPiA+IEkgZG8g
aGF2ZSBhY2Nlc3MgdG8gYSBzeXN0ZW0gd2l0aCBhbiBFUFlDIDc1MTMsIHdoaWNoIGRvZXMgaGF2
ZQ0KPiA+ID4gPiBTaGFkb3cNCj4gPiA+ID4gU3RhY2sgc3VwcG9ydCAoSSBjYW4gc2VlICdzaHN0
aycgaW4gdGhlICJGbGFncyIgc2VjdGlvbiBvZg0KPiA+ID4gPiBsc2NwdQ0KPiA+ID4gPiB3aXRo
DQo+ID4gPiA+IHRoaXMgc2VyaWVzKS4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCBpdCwgQU1EIG9u
bHkgYWRkZWQgU2hhZG93DQo+ID4gPiA+IFN0YWNrDQo+ID4gPiA+IHdpdGggWmVuIDM7IG15IHJl
Z3VsYXIgQU1EIHRlc3Qgc3lzdGVtIGlzIFplbiAyIChwcm9iYWJseQ0KPiA+ID4gPiBzaG91bGQN
Cj4gPiA+ID4gbG9vayBhdA0KPiA+ID4gPiBwcm9jdXJyaW5nIGEgWmVuIDMgb3IgWmVuIDQgb25l
IGF0IHNvbWUgcG9pbnQpLg0KPiA+ID4gPiANCj4gPiA+ID4gSSBhcHBsaWVkIHRoaXMgc2VyaWVz
IG9uIHRvcCBvZiA2LjAgYW5kIHJldmVydGVkIHRoaXMgY2hhbmdlDQo+ID4gPiA+IHRoZW4NCj4g
PiA+ID4gYm9vdGVkDQo+ID4gPiA+IGl0IG9uIHRoYXQgc3lzdGVtLiBBZnRlciBidWlsZGluZyB0
aGUgc2VsZnRlc3QgKHdoaWNoIGRpZA0KPiA+ID4gPiByZXF1aXJlDQo+ID4gPiA+ICdtYWtlIGhl
YWRlcnNfaW5zdGFsbCcgYW5kIGEgc21hbGwgYWRkaXRpb24gdG8gbWFrZSBpdCBidWlsZA0KPiA+
ID4gPiBiZXlvbmQNCj4gPiA+ID4gdGhhdCwgc2VlIGJlbG93KSwgSSByYW4gaXQgYW5kIHRoaXMg
d2FzIHRoZSByZXN1bHQuIEkgYW0gbm90DQo+ID4gPiA+IHN1cmUNCj4gPiA+ID4gaWYNCj4gPiA+
ID4gdGhhdCBpcyBleHBlY3RlZCBvciBub3QgYnV0IHRoZSBvdGhlciByZXN1bHRzIHNlZW0gcHJv
bWlzaW5nDQo+ID4gPiA+IGZvcg0KPiA+ID4gPiBkcm9wcGluZyB0aGlzIHBhdGNoLg0KPiA+ID4g
PiANCj4gPiA+ID4gICAgICQgLi90ZXN0X3NoYWRvd19zdGFja182NA0KPiA+ID4gPiAgICAgW0lO
Rk9dICBuZXdfc3NwID0gN2Y4YTM2YzlmZmY4LCAqbmV3X3NzcCA9IDdmOGEzNmNhMDAwMQ0KPiA+
ID4gPiAgICAgW0lORk9dICBjaGFuZ2luZyBzc3AgZnJvbSA3ZjhhMzc0YTBmZjAgdG8gN2Y4YTM2
YzlmZmY4DQo+ID4gPiA+ICAgICBbSU5GT10gIHNzcCBpcyBub3cgN2Y4YTM2Y2EwMDAwDQo+ID4g
PiA+ICAgICBbT0tdICAgIFNoYWRvdyBzdGFjayBwaXZvdA0KPiA+ID4gPiAgICAgW09LXSAgICBT
aGFkb3cgc3RhY2sgZmF1bHRzDQo+ID4gPiA+ICAgICBbSU5GT10gIENvcnJ1cHRpbmcgc2hhZG93
IHN0YWNrDQo+ID4gPiA+ICAgICBbSU5GT10gIEdlbmVyYXRlZCBzaGFkb3cgc3RhY2sgdmlvbGF0
aW9uIHN1Y2Nlc3NmdWxseQ0KPiA+ID4gPiAgICAgW09LXSAgICBTaGFkb3cgc3RhY2sgdmlvbGF0
aW9uIHRlc3QNCj4gPiA+ID4gICAgIFtJTkZPXSAgR3VwIHJlYWQgLT4gc2hzdGsgYWNjZXNzIHN1
Y2Nlc3MNCj4gPiA+ID4gICAgIFtJTkZPXSAgR3VwIHdyaXRlIC0+IHNoc3RrIGFjY2VzcyBzdWNj
ZXNzDQo+ID4gPiA+ICAgICBbSU5GT10gIFZpb2xhdGlvbiBmcm9tIG5vcm1hbCB3cml0ZQ0KPiA+
ID4gPiAgICAgW0lORk9dICBHdXAgcmVhZCAtPiB3cml0ZSBhY2Nlc3Mgc3VjY2Vzcw0KPiA+ID4g
PiAgICAgW0lORk9dICBWaW9sYXRpb24gZnJvbSBub3JtYWwgd3JpdGUNCj4gPiA+ID4gICAgIFtJ
TkZPXSAgR3VwIHdyaXRlIC0+IHdyaXRlIGFjY2VzcyBzdWNjZXNzDQo+ID4gPiA+ICAgICBbSU5G
T10gIENvdyBndXAgd3JpdGUgLT4gd3JpdGUgYWNjZXNzIHN1Y2Nlc3MNCj4gPiA+ID4gICAgIFtP
S10gICAgU2hhZG93IGd1cCB0ZXN0DQo+ID4gPiA+ICAgICBbSU5GT10gIFZpb2xhdGlvbiBmcm9t
IHNoc3RrIGFjY2Vzcw0KPiA+ID4gPiAgICAgW09LXSAgICBtcHJvdGVjdCgpIHRlc3QNCj4gPiA+
ID4gICAgIFtPS10gICAgVXNlcmZhdWx0ZmQgdGVzdA0KPiA+ID4gPiAgICAgW0ZBSUxdICBBbHQg
c2hhZG93IHN0YWNrIHRlc3QNCj4gPiA+IA0KPiA+ID4gVGhlIHNlbGZ0ZXN0IGlzIGxvb2tpbmcg
T0sgb24gbXkgc3lzdGVtIChEZWxsIFBvd2VyRWRnZSBSNjUxNSB3Lw0KPiA+ID4gRVBZQw0KPiA+
ID4gNzcxMykuIEkgYWxzbyBqdXN0IHB1bGxlZCBhIGZyZXNoIDYuMCBrZXJuZWwgYW5kIGFwcGxp
ZWQgdGhlDQo+ID4gPiBzZXJpZXMNCj4gPiA+IGluY2x1ZGluZyB0aGUgZml4IE5hdGhhbiBtZW50
aW9ucyBiZWxvdy4NCj4gPiA+IA0KPiA+ID4gJCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYv
dGVzdF9zaGFkb3dfc3RhY2tfNjQNCj4gPiA+IFtJTkZPXSAgbmV3X3NzcCA9IDdmMzBjY2NjNWZm
OCwgKm5ld19zc3AgPSA3ZjMwY2NjYzYwMDENCj4gPiA+IFtJTkZPXSAgY2hhbmdpbmcgc3NwIGZy
b20gN2YzMGNkNGM2ZmYwIHRvIDdmMzBjY2NjNWZmOA0KPiA+ID4gW0lORk9dICBzc3AgaXMgbm93
IDdmMzBjY2NjNjAwMA0KPiA+ID4gW09LXSAgICBTaGFkb3cgc3RhY2sgcGl2b3QNCj4gPiA+IFtP
S10gICAgU2hhZG93IHN0YWNrIGZhdWx0cw0KPiA+ID4gW0lORk9dICBDb3JydXB0aW5nIHNoYWRv
dyBzdGFjaw0KPiA+ID4gW0lORk9dICBHZW5lcmF0ZWQgc2hhZG93IHN0YWNrIHZpb2xhdGlvbiBz
dWNjZXNzZnVsbHkNCj4gPiA+IFtPS10gICAgU2hhZG93IHN0YWNrIHZpb2xhdGlvbiB0ZXN0DQo+
ID4gPiBbSU5GT10gIEd1cCByZWFkIC0+IHNoc3RrIGFjY2VzcyBzdWNjZXNzDQo+ID4gPiBbSU5G
T10gIEd1cCB3cml0ZSAtPiBzaHN0ayBhY2Nlc3Mgc3VjY2Vzcw0KPiA+ID4gW0lORk9dICBWaW9s
YXRpb24gZnJvbSBub3JtYWwgd3JpdGUNCj4gPiA+IFtJTkZPXSAgR3VwIHJlYWQgLT4gd3JpdGUg
YWNjZXNzIHN1Y2Nlc3MNCj4gPiA+IFtJTkZPXSAgVmlvbGF0aW9uIGZyb20gbm9ybWFsIHdyaXRl
DQo+ID4gPiBbSU5GT10gIEd1cCB3cml0ZSAtPiB3cml0ZSBhY2Nlc3Mgc3VjY2Vzcw0KPiA+ID4g
W0lORk9dICBDb3cgZ3VwIHdyaXRlIC0+IHdyaXRlIGFjY2VzcyBzdWNjZXNzDQo+ID4gPiBbT0td
ICAgIFNoYWRvdyBndXAgdGVzdA0KPiA+ID4gW0lORk9dICBWaW9sYXRpb24gZnJvbSBzaHN0ayBh
Y2Nlc3MNCj4gPiA+IFtPS10gICAgbXByb3RlY3QoKSB0ZXN0DQo+ID4gPiBbT0tdICAgIFVzZXJm
YXVsdGZkIHRlc3QNCj4gPiA+IFtPS10gICAgQWx0IHNoYWRvdyBzdGFjayB0ZXN0Lg0KPiA+IA0K
PiA+IFRoYW5rcyBmb3IgdGhlIHRlc3RpbmcuIEJhc2VkIG9uIHRoZSB0ZXN0LCBJIHdvbmRlciBp
ZiB0aGlzIGNvdWxkDQo+ID4gYmUgYQ0KPiA+IFNXIGJ1Zy4gTmF0aGFuLCBjb3VsZCBJIHNlbmQg
eW91IGEgdHdlYWtlZCB0ZXN0IHdpdGggc29tZSBtb3JlDQo+ID4gZGVidWcNCj4gPiBpbmZvcm1h
dGlvbj8NCj4gDQo+IFllcywgbW9yZSB0aGFuIGhhcHB5IHRvIGhlbHAgeW91IGxvb2sgaW50byB0
aGlzIGZ1cnRoZXIhDQoNCkluZGVlZCB0aGlzIHdhcyBhIFNXIGJ1ZyBhbmQgaGFkIG5vdGhpbmcg
dG8gZG8gd2l0aCB0aGUgQ1BVIG1vZGVsLiBUaGUNCmFsdHNoc3RrIHNlbGZ0ZXN0IHdhcyBub3Qg
ZnVsbHkgaW5pdGlhbGl6aW5nIHRoZSBzdGFja190IHN0cnVjdCwgYW5kDQpnZXR0aW5nIGx1Y2t5
IG9uIHNvbWUgY29tcGlsZXJzLiBUaGFua3MgdG8gTmF0aGFuIGZvciBoZWxwaW5nIG1lIGRlYnVn
DQppdC4NCg0KDQo=
