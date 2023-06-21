Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3B7392F0
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 01:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjFUXPi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUXPh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 19:15:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D47BC;
        Wed, 21 Jun 2023 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687389336; x=1718925336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mYDX0ricAzL73ubgTmZaEdykmrc4dlZLv9spAy7xaKc=;
  b=RLVTE1qH9vT/ZiFWMOCqi/yt83cMzyID6HHcJ0IBJjOJoS+1QLwgbVtS
   7w6x4b6RhnR0zimJ9EIcZAFT+Uh7p6hbETXrawsKudubhDAmbOwnHuYQH
   PAbYJ2EPe9SRz2PjGOAzs+aXEafxxM2l7BUyWfv82f4jQC7WGwyTvAJ6m
   dfGYFk+U2BWmeMPcNXmYLp5XGPrMaORitwm8vlCUOy9fViKAyzLSWQx9I
   IdYc3P+ydmyZXAP+pe6AUl1S1lXU5cavT+//AOvvvzRtn/ajmKuGJIx4K
   nngEEZI1P9v87VnpwWUj6hVNi6y9VQnVyFsUcBZy8nQGogkLvm9sJDU9C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="446712176"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="446712176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 16:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="692026725"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="692026725"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 16:15:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:15:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 16:15:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 16:15:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEVhtzldpF1Ak2z4UruW5cnNzYfq3Jf+ygL2j1fydUfB/l0lTAmR/lYjBjRrLqPnCnqz/D2X4hZxg9yGvBamz0H8v5YD5AxfcrgFlRDwchD/kbKXHXIcxus/W5GzkYpG4WdkfyxAf+zfjhZU4qlR6ELIg6yWg92B/AvA9A2dCGSwdLK8ews03XcTe0kjsvb9QSeh4cnwosHnRg28c+xCiYUzVzwsMZXQCahQFVSiBon1wjRS21mOXfOr85GDLaahGPqY+JrV9gn/XiNcH5o0S5LvdzQeYbYnfQz4Ae0BPLfa/AlqlSue+vp9cvwX4PEwCGA7x2MscPUhK0y7A54VFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYDX0ricAzL73ubgTmZaEdykmrc4dlZLv9spAy7xaKc=;
 b=frqIPagROAz6IAPOPoL64o50LEHgfK+xoZxWD5nrGiBODZmkGMCLZUhXJyqBWOaI4PHBcpmWyqb5T+L/+Nm8dZvA/0HRTf1A4tvlwYTSbfvV8xa8xW/2L0sXTx5HOJcX3mEXLAtBUgXsbhgKGK+UnLisC4iHtd5mcQwYkfmzlcWuIXf6Y/QUW9iwSw2hSx1e42Ks4eqPqd/9qBjB6JniA8Nmd/V0FFCIMukf8VI4m4HW0mHfYMAHzKn1w9jPPaRWbrw/Cb+Rbgob0dq0Mzg99QyPs0kJqKzqMykA+2QctxpDTUmvaj36mWmEEUg2FkadQYNKRnMSu/uCj7YgiARLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 21 Jun
 2023 23:15:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 23:15:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "david@redhat.com" <david@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
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
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAADpMAIAAC9qAgAAC1YA=
Date:   Wed, 21 Jun 2023 23:15:30 +0000
Message-ID: <c7df57a7489ff555fc531d19a5a4a689f6f99a7c.camel@intel.com>
References: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
         <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
         <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
         <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
         <CAMe9rOpZYwD=v0vcseBrjNvMy4J3Kgy2i8hCcBsU+1gNUcR9qA@mail.gmail.com>
In-Reply-To: <CAMe9rOpZYwD=v0vcseBrjNvMy4J3Kgy2i8hCcBsU+1gNUcR9qA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6289:EE_
x-ms-office365-filtering-correlation-id: 890f9b2c-f69e-4780-00fc-08db72ad6850
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOwb7E2XcG9B2raMXaLYfNUbKjSWIjDQb6W4/BWrBBs34mLLHVc8G2/UUBInpSquQKiEfGSlOVnRPjWnPyRapmhcpAufPbZ5Bbk3D1WHmitOdQiVftgTmaI1CipVyQ5hyHI7G1KkOWutJCIb131MmoVgvgRScrKf9Sg+dc3MmtuyCsNpAbuqKsezj7YIUi5Mi5grq0IR3c0xcSwKUTeN5fdbfSWxac+AtByOhFPoMt8Fs9XhNrDazfwVyn9qbm6soO7VZZPlSvrfG0kfkB26ca123fTQ87nyIWtBaoD24Wfc5NEmn6S+8h8uQRsJyqlLQ3Nq9b5NxkoJqw/e6DhxJsa5DJ3I65mm8CjsT2Fvcdbx84t2tsR6VmbsNOu/VFXG9iNqbdYnCla4HeGeXMXpvnS8CXzdZJT4oYxg/lziaDbRK9mGYr1pgNQCcbx44nzjoX1luPPGKkVCpVBNsr2D8tg6SAZ+7Jhn8AnSeNWuUp/TaiqNtWVlp3x0I5IWJuRrMKfYupXcgYoxOlDOKCpatkv5dpCwIytSa8awFN9fNOVMuTrEuGizQAQWtBJuuS/BSpvMTsLdVTe08/9Ssrd7pOVQTG9UpDMbPmqelXchYvk6HRaF5y2JUiytOaXp7AyN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(5660300002)(4744005)(7416002)(7406005)(2906002)(6506007)(26005)(6512007)(8676002)(186003)(8936002)(41300700001)(36756003)(83380400001)(478600001)(38100700002)(122000001)(82960400001)(71200400001)(2616005)(76116006)(66946007)(316002)(4326008)(86362001)(6916009)(66476007)(66556008)(64756008)(66446008)(91956017)(38070700005)(54906003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVpjWkt6U3duTDR3UEdGWEVydW94SUNrU3hucWRoQjdNZWxWb3Q2NDZaOFp3?=
 =?utf-8?B?SGFKNzgrY0gxUlFnTjZiM24xN2ZRMzMxbzJCdTM5SWtuMzNQaG00QWFWVHF1?=
 =?utf-8?B?Tk9vS0lrVTVxZlU3ZWdqRzhDdlRrZ21FN002LzYwR0RRMHBDdXlvTjNveUd4?=
 =?utf-8?B?S2FvcExidUIwU3VTOHJTV1pRQlhzTXFFb0E4d2VJT0NIYkk0Z0xQNk14dWda?=
 =?utf-8?B?TkpDSVNDSU9QS3hTejUxaW43VXhkcDhWbUtab0FUUFdHNy9IK3N2QnBzMExT?=
 =?utf-8?B?S0Q5OEVHa2RGYnhBdWxudktFMXBPYWNVZFluNDBJZjA1aWZFaXV0SDFYaXZD?=
 =?utf-8?B?Y2N4aGpKRWdQU0wrUmdDZ0NwVDd6RnlMaXR3RXZiSTM4VkdqZnhsNmg2V1ow?=
 =?utf-8?B?dG9wNU1xRHlFcnYvT3R1Mjl1VWxMUi9EcmtYOC9QS0RlOW56OXl3aVhTdXdQ?=
 =?utf-8?B?KzlSWmtvK242N0R1RWNsYWVHWUduYXR5aENDbjlLN2hudXB5aDNnbGdCSkZ3?=
 =?utf-8?B?R2xKVUQzODJ0Y3pyM3Z0cHZVeEphdVZyREp0YlFTNTBKZUVmNlArVnNUMWlR?=
 =?utf-8?B?VHJSQUlxTVVBYk4vU3VMdklLOE5rZWUyYnYzeVNhZU5pMmh1RWk5NE16cUdQ?=
 =?utf-8?B?ZVE2RlY0UjdnZ3cyY1E3ZzJuV01PU043Mk5Nc0NURmQ2VUdNVGw4alBTNFVD?=
 =?utf-8?B?aURZR2MvalJsWWtVc0VDZUl5dnk0YXVBR3krYmpWa0dLOUtSK25EUlZmZmhn?=
 =?utf-8?B?NG10VVM2ZFpoK2FEdlZralF5KzdBNmNnQTd2ZGVPNVd2czJndnFhWEtDMzJp?=
 =?utf-8?B?OTVENjMvUGo1MlI1amdCeks3YUl0WjdJZlFDSUZtTlBYVElxMG1wVUQrekto?=
 =?utf-8?B?OTlmWDZsZDU5MTd0UlNDRGhZM0U0ZU9vS0RnMkQ0MkRsNnlmcHRUWTNIUU5v?=
 =?utf-8?B?L1JiaXVLaEtlbVNEdUZFQUhqVEMrMFJEMVRMdEdaU3MrZUFVR3BROVdQNmRT?=
 =?utf-8?B?bnNYd0RrZlY2SWlJbW9QTnI3cGF2Y05FVVE0YzZ4T1grMFh3N0ZhM3F2Sitx?=
 =?utf-8?B?TGdzY2RwT2dGU3lZTmdKZnMyL1hkTnJ1dXpoeEFXMmpzOStxcDN5dDAzM1dG?=
 =?utf-8?B?dFdBTTFlaGxxMnB2TnRUWlNQVEFoYzdXRERqMFhWcWgrTm9CVU1jODA3ZkxF?=
 =?utf-8?B?eWNvU2xLTFRzakZyeGVhN0F4T3hubVlqRGNHVHR6RzBZWFAzQTJiZzFYeDhO?=
 =?utf-8?B?alNlSnNCSHVPY09nOXBLckJHWTNPK1Nuc2dtSktwZ0Rvbk9ReVpPRXA2dW53?=
 =?utf-8?B?TEtnQm9INllucWR3TUdTZW5OenUzZXVUdVNMcjJ6UHFxQThmN2xzUS9VTG9u?=
 =?utf-8?B?OXNFUnYrakVPMjYrS3pyekx5SVpncDBmSlZzY3laNE1KeWhzOFQya0tSWHlO?=
 =?utf-8?B?ZE1XTFJIemlBRkpmRURCSXljNERHalp3MXplSm44R1lLNVNjZXZ4UWZFVyts?=
 =?utf-8?B?WWxBckVTVGE2dXVqWCtXS1N2YVBuNWVrd1RNOWMxSTYydU9tQUlFbDFGaG1M?=
 =?utf-8?B?UUFTWXRmQzAvWTdJdFBXNlRsd3hDRmJiQnFKSUw1dU5jbVFtbGhCelM2K0Zo?=
 =?utf-8?B?bmlxTEcwUjFmcVVGd3NycTBldnpWY21CM0g3Tmt0NS8wejRIR2RVK1Y2cDdP?=
 =?utf-8?B?YXY0T3NYQXE1SWFnS29Ram0zTkwrY2xodHIzYmR5N0UwY0lEY1RwdjRMT0JS?=
 =?utf-8?B?RVhKak9NSzJYSFlBS0ZweEFhTUdGVTR6Q3YrclpsY1psZnFCQzlseXY0aFJy?=
 =?utf-8?B?L1VzRlBndUc3bVhRbW51NDBLZjJQVW9JU3RxY2E3S3BBWjI2MVoxRmdVK0Zh?=
 =?utf-8?B?Sm9iVFo3d2FVTFVYeWdnUWtDN0cxVFFRa2RKUzFCcW1lKzBSaktXR0dNSVVC?=
 =?utf-8?B?VEpyRjdUdjFJait6ZzgvMmV3MC9VL3h4aVY4RmR0TlM3VHRwN0JrMjM3eVg1?=
 =?utf-8?B?d1BUYVkzbXNNUmw2RG85eHZsNXMyVlpYajVZbWFFUjRxTFhhWnlvcDFpY3RC?=
 =?utf-8?B?N2c2Q1lJYSsxN0FOYnNzOFpRQ3JCbzJhL0JPNWU4d2Y0bmd3NVBHemdKdW9I?=
 =?utf-8?B?ejl6c2lFQlZndFZmTEMwWFJreXIycStWTzRyd0VUbkJBQm9LK2tKTVcyNHlQ?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AE444A116E111449BC3A33C11221FF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890f9b2c-f69e-4780-00fc-08db72ad6850
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 23:15:30.7873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3w+YQozvtt9pBzVoLLUwxkOkr+NfsTN+seMPowbdfuH1SUEjFsygLj5FfT7x1/Noai/SgC9trgT1Odl4Kki3VsKphrTGT5ybPR0c4bF81A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDE2OjA1IC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiA+IFdo
aWNoIG1ha2VzIG1lIHRoaW5rIGlmIHdlIGRpZCB3YW50IHRvIG1ha2UgYSBtb3JlIGNvbXBhdGli
bGUNCj4gPiBsb25nam1wKCkNCj4gPiBhIGJldHRlciB0aGUgd2F5IHRvIGRvIGl0IG1pZ2h0IGJl
IGFuIGFyY2hfcHJjdGwgdGhhdCBlbWl0cyBhIHRva2VuDQo+ID4gYXQNCj4gPiB0aGUgY3VycmVu
dCBTU1AuIFRoaXMgd291bGQgYmUgbG9vc2VuaW5nIHVwIHRoZSBzZWN1cml0eSBzb21ld2hhdA0K
PiA+IChoYXZlDQo+ID4gdG8gYmUgYW4gb3B0LWluKSwgYnV0IGxlc3Mgc28gdGhlbiBlbmFibGlu
ZyBXUlNTLiBCdXQgaXQgd291bGQgYWxzbw0KPiA+IGJlDQo+ID4gd2F5IHNpbXBsZXIsIHdvcmsg
Zm9yIGFsbCBjYXNlcyAoSSB0aGluayksIGFuZCBiZSBmYXN0ZXIgKG1heWJlPykNCj4gPiB0aGFu
DQo+ID4gSU5DU1NQaW5nIHRocm91Z2ggYSBidW5jaCBvZiBzdGFja3MuDQo+IA0KPiBTaW5jZSBs
b25nam1wIGlzbid0IHJlcXVpcmVkIHRvIGJlIGNhbGxlZCBhZnRlciBzZXRqbXAsIGxlYXZpbmcg
YQ0KPiByZXN0b3JlDQo+IHRva2VuIGRvZXNuJ3Qgd29yayB3aGVuIGxvbmdqbXAgaXNuJ3QgY2Fs
bGVkLg0KDQpPaCBnb29kIHBvaW50LiBIbW0uDQo=
