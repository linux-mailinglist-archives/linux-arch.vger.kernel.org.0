Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C074A3B4
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGFSZZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFSZX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 14:25:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6891BC3;
        Thu,  6 Jul 2023 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688667922; x=1720203922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rZNz2zs/clgX93c8a4NPMLbcB8ZeCcXwRZ2Ub0i5euA=;
  b=DjgCBUWTTSAFCoWOY3euo+H0WWMXSEMK0wBu8QkWAbxeS3gh6gt59CdQ
   5zKjxkkD7oh+b+wHKxiX84Ne5R7PwJn5POsi/oB1wwGUVgoomRcNEOaPL
   pxR2JDwLJe28gb/Qo7KKEpkEZc/ndWBfdmJPzj20tQxSmMe1vl7qD82fQ
   CHy6pAohft+ye1LqaakQn1LUNcJKlQW2IgfSzoyxhYbTfRSnNGxRLrgOs
   F83REfcXJgFwW+rAepUmAxZSf0udzkAP+WEcOOVH2JUbh0oq41A4Q20D4
   29nwsAqRdH5ongrgZbztDhHym4lzLv7H7JIkI8sbXKHG/wPkSJk1fIFVB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427368790"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="427368790"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 11:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713674414"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="713674414"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2023 11:25:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 11:25:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 11:25:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 11:25:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 11:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmIRLzk9acbpEUryNFXZuxja2n5MFjIxwa/bRM4LxpAjxTgd+vbZbu55eXMateb0j/49twIT3uUUC4AeMXTpWGG7UwaQNlokC+4K3NL10FZZuQqFdnjUimBUbscwuujQaLBM8k1qTjR730ZnaMb2xQ6zCiSIyjG9aePo8DbUvhgemZPPQ1MqgqDDcOKviFTZC5XYpg0bieVdfz0Epv9gOeAZ+q0btSzjyH2EBtaKUNP0cGitYU2TTTKDi06rF5U0jyh8wsqs/+lPn3R0IXnw4XJ7YFKHko/i0YO9fy6NMlL0R1K+AYpirFKGaC0G+5as1CCXCTR9xxK9iCoOjnB7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZNz2zs/clgX93c8a4NPMLbcB8ZeCcXwRZ2Ub0i5euA=;
 b=JikTqY5YkkmHBR14ubSvJQYn/DUVtCXyjEmAjNPpb3yo53XqnVywpJ4WiznmljQp4d1f/s9rH8uMrAXHhrP5S+kXvOHln4dnHvgbN3MkaPLoMNpyNbULsZ+UDujWXWQceXans+iBeEcbHywy5lzUB6QEKUmVgGLX5QqncViz6pSQEPJi8e8BgvfhbgLUHAfyF8jzPKDrHbbS1yFhoUW65d5HapB7E2PGEWxkMkXhjkVBiuCIrIR8HIB7WeZGlR84fhwOcuorEOsDgKhs5WRfRTtwQT32hNyks3iqmSg+RuOiHJdmGqxcxA9of41yqoGuXaplaMy8HsB+Z9Il4cc4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7667.namprd11.prod.outlook.com (2603:10b6:806:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:25:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 18:25:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAPF/AIAAZrmAgAAVNICAAG62AIAKh/oAgATXZwCAAZabAIADLBsAgAEz1ACAAFjMgA==
Date:   Thu, 6 Jul 2023 18:25:14 +0000
Message-ID: <68b7f983ffd3b7c629940b6c6ee9533bb55d9a13.camel@intel.com>
References: <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <ZJQR7slVHvjeCQG8@arm.com>
         <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
         <ZJR545en+dYx399c@arm.com>
         <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
         <ZJ2sTu9QRmiWNISy@arm.com>
         <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
         <ZKMRFNSYQBC6S+ga@arm.com>
         <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
         <ZKa8jB4lOik/aFn2@arm.com>
In-Reply-To: <ZKa8jB4lOik/aFn2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7667:EE_
x-ms-office365-filtering-correlation-id: c4ac2476-24b1-4ddf-2766-08db7e4e5762
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fkXyqj8AoPKGBCU6uccPuGms0Mx4Dht9NKuGVdwyMV8SW48meHO8ANkorv3eZNnqu/cI/2uk6fJiN4xQtVkT7vgBFcYlxydQI5r+Zadkt2siFnck1BCtwR1FPcw4zb5KYnlvJzq0on8biDb4TzyZYa6FPK2Hv6b3q7NI2p/gXKjXKw4MkHJz90kxz0Kya6+leBO3MRInryRDioNdgHW+o3yAt3bjJwhBZ8VUCw/MzOn9O/1IZiP3NvmYHFw7c7lqfczBnDzJAXwcrb428eqTRfYhAPn6wg2JX0nC68pWEIm31QgstTO63w3NfnhF/c7z3zOTiCiMM/f7wy2TtI6QxkVZe7/oC2wG2hvLrwICJWruKSxBk3cnS61T3OOcSOIeEg5mXOjA+E1+gfHRp9iMKA5Ce91Pxd4SDOkarHUD6lhv0BXXl2LFrhyWge79pVRdH3eOqB4LvRHq/NhlkaAbYFYT12cUy1+PlzZwaDOM3r0sL/FqBf711R6q+XhmyDL/k1YS3BQg7gPqk8y39Z0MSQIf3kiUOMLgOpiNqklid+rbVDyE1yjVEBFntRuiQzPbf0+pJyimkGwBiwbdkI+9YoaNPKPFYiED5rjD0q3yHsjYoVdJh3GjWLWXC5Qz4kQ+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(66899021)(71200400001)(6486002)(478600001)(110136005)(76116006)(91956017)(54906003)(38100700002)(2616005)(83380400001)(36756003)(86362001)(38070700005)(2906002)(66946007)(26005)(6506007)(186003)(6512007)(122000001)(82960400001)(66476007)(4326008)(66556008)(66446008)(41300700001)(316002)(64756008)(5660300002)(8936002)(8676002)(7416002)(7406005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFJ2VkNRMldRVFBPQ2NjamtaOUNQd3JSdGNwNU5mWjlNcHU3cWVTNmtUdmkv?=
 =?utf-8?B?ZDlZazBFanZVV0xRRlJBSTBZbUxUMlhFR3RuQWRkVW1xa2xKYVo0enNCUU94?=
 =?utf-8?B?NlJKVkZreHlkUVN5dTlxUC9lcTBUTmViS2NkOXRaZ3BKSWlLcGJ4aEt0bGIy?=
 =?utf-8?B?dU40ODFjSnFZRW1pb2pKOTJ2YmVuREtyd0x6cllqdHZ5N3l0Z0JaK04yeUJP?=
 =?utf-8?B?TkMxZUFsZXJnc1QxaHlzVEZSSDlCNmtDV2lvam1FanU2cDY4TkptRll2WExz?=
 =?utf-8?B?Z2JLVkJoTzdMN1RIQ2RaRE5hRkJ5OTBnZzFqSXVkVmxiK0pKQXBTQ080VmRG?=
 =?utf-8?B?VzZMQWNwZlcwQ0o0T1BYd2daQW9RUjVYRFhPVWlNalJ4d04vM1E5V2FHdlBR?=
 =?utf-8?B?eG1MWHh4NEtjZHRVTEVoNDNlTjJlbjBFM2pBaXpjUGVNZVRBUXhHUzNISVY3?=
 =?utf-8?B?MG8vNS9CMGthd0tSTEZRQVlDbUZtekw4b1pUTWNvUTNWcCtoTzBnL05sSmtD?=
 =?utf-8?B?UVpsdEJ6RzgxZVpUN25XMU5PWlN2YlJiWmlha1MvOVhOcWlMdTRSeGt6cXFj?=
 =?utf-8?B?aXh2Qm8ycUJDUkJVQ0F5UkJzZzN4cFgvMUNyeWthL1ExZ2d4UlZKMFN6QWNm?=
 =?utf-8?B?ei8wOW1Xb0xNeDljNUZLcERENjdjZVg5bXJkUXVCZGxRWnNXM1EwdXl0TG5O?=
 =?utf-8?B?aisyckh2MEpnQUZYVGJoMEp4WVFoLytMSzQ4eUMzenpsb2lLRnFyRWEzWVcx?=
 =?utf-8?B?U0ROTGhwazVuenJQL2ZhbmxkNHAzQ3pJSWtNOHpFdjczUDJCYWh2ZU5nY3Vp?=
 =?utf-8?B?WEdqTU9YQ2pkdUF6L1dvUS9GcTVGaERLZHVtM1RWOUNrYloxamdsT0NxZld0?=
 =?utf-8?B?YTZjbnBQWHdZTUZlRVY0Z3JiNUZYNnc0NU50eis3elVGYlhTR3FYcWVqM1Rx?=
 =?utf-8?B?VXFxd00wbzVpVFhpY0pJdTVDZy9zMGczUVdPRHF0UUVhV281cmxlY0lhQ0xO?=
 =?utf-8?B?eFNydTIxYUFIVU45eGoyc0RuNkI2Yno4ZkYrU2puNHFwdzhPUXB4aVVPWTRS?=
 =?utf-8?B?QTFTV3dzS3pZRVoxTTJ5SzAxdXUvSGFQVWlHRmZiTXpmcXA0Z29NRURoS3Nz?=
 =?utf-8?B?bGRLR2gxYlhzanAvMHdzTTRhcm5SMEFmUHI4SzVwZEhMK2wvdmZEL1J4K2wy?=
 =?utf-8?B?UkRDTThXbzFJVS94Ymt6ZHpObEEycS9VWFRhdnJZVHMvc2s3cTJiRGc0QUs1?=
 =?utf-8?B?WFhXd29QY1N6a3FyRUtIQTA5Y3ZaaFkyelpGS05wVzdsM2JYWFY4ZHhvZTl1?=
 =?utf-8?B?K2RucVBrbWg1cGJlSTh0QzVkc1pRZmNaVTNUUGJvWW9ka3NFeTllQzRiaElm?=
 =?utf-8?B?V3gwY1daNm9BVGUrd1FiaW9VNkNMOWJiRHRmRFV2VW5lYVp3eUZUcjNsZWt3?=
 =?utf-8?B?T1NIRGpZMS84SUVjSiswMVozTXI5cHR4a1JPdzN1K1VSQU5PRHJwMU5hSE1p?=
 =?utf-8?B?MW5oTWZSSVhNUGJpYUZ6MXBxM0hnazBxY2RqSXo5R0FLT2ZpK1A5QW5hMDN2?=
 =?utf-8?B?Z3Z0Q0ZsU3NReHVneUpzMXM1c2VUTWlFcW1xQy9UamFYT0JlQkdhS1dIeWxZ?=
 =?utf-8?B?OENFZkhadTRNQUxCNW1CdG9WNXFPWWdPMnB6dmIreWtGVDJwQmhhWkhjZU13?=
 =?utf-8?B?YUZmUWhvY0dFUnRZVTV5c2hHQUhKR0xSOFRROVNHWFFlbUEwZzNDbmc5dUtl?=
 =?utf-8?B?TjJQTlYzeXJJcjIvTWw5S0tXQUFmcXlJdjU2dnd1M3BNaVhGUEIzbUdSRnY1?=
 =?utf-8?B?SmRueGhKY2NqR05HM3ZuVTFQckdmUW9nbkhtZUlBa0JRWjNISFRPejdicXQx?=
 =?utf-8?B?YmxwOUMvMXAydXJPRlFLckVMczlQOGhJWmFLUGYvdGxvRzJGeVpHZkdBR1ZV?=
 =?utf-8?B?Rlk4UEl3L1cxZjJTYW5GMkZXbUZqaEpqdFFucDhiYmUySzdDTHNGNkcvUlI2?=
 =?utf-8?B?cnV4cC9XN1haWGNlc2dvRnZuU3BrOUhYNG50UVd5K1pZWmlSamRRbk1mYXZC?=
 =?utf-8?B?MUZ6akNLM1ZNbkZzUFRuVnptRUFGdXBQWXR5M1BibC91TFBHOXVVQWp4ZCtt?=
 =?utf-8?B?cmprYUtpc0sxd0ovZjAranlPWGdCeUhVNXhheE53T0VjTHJEaldiQkc4dGRV?=
 =?utf-8?Q?2X+dzpKMVX+90C3bOpsdBH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ECF3F0EAB5EF146866A6A6D4215FEBC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ac2476-24b1-4ddf-2766-08db7e4e5762
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 18:25:14.1337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egi8Yz2lU7jDCoBgKJtvH4DyO8SWKY29Ovel2FsEnpxaO0w0tWm5kzzVfLUhNeqBEft8neT36bM18pE10m1SrKcV9n8+WJjP48XSR60w3wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7667
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTA2IGF0IDE0OjA3ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQoNClsgc25pcCBdDQo+IA0KPiBpbnN0ZWFkIG9mIHByaW9yaXR5LCBpJ2Qgc2F5ICJw
b3NpeCBjb25mb3JtIGMgYXBwcyB3b3JrDQo+IHdpdGhvdXQgY2hhbmdlIiBpcyBhIGJlbmNobWFy
ayBpIHVzZSB0byBzZWUgaWYgdGhlIGRlc2lnbg0KPiBpcyBzb3VuZC4NCg0KVGhpcyBpbnZvbHZl
cyBsZWFraW5nIHNoYWRvdyBzdGFja3MgZm9yIHNpZ2FsdHN0YWNrIGFuZCBtYWtlY29udGV4dCwN
CnRob3VnaCwgcmlnaHQ/IFRoaXMgc2VlbXMga2luZCBvZiB3cm9uZy4gSXQgbWlnaHQgYmUgdXNl
ZnVsIGZvcg0KYXZvaWRpbmcgY3Jhc2hlcyBhdCBhbGwgY29zdHMsIGJ1dCBwcm9iYWJseSBzaG91
bGRuJ3QgYmUgdGhlIGxvbmcgdGVybQ0Kc29sdXRpb24uIEkgdGhvdWdodCB5b3VyIEFQSSB1cGRh
dGVzIHdlcmUgdGhlIHJpZ2h0IGRpcmVjdGlvbi4NCg0KQnV0LCBJJ20gb2YgY291cnNlIG5vdCBh
IGdsaWJjIGRldmVsb3Blci4gSEogYW5kIGZyaWVuZHMgd291bGQgaGF2ZSB0bw0KYWdyZWUgdG8g
YWxsIG9mIHRoYXQuDQoNCj4gDQo+IGkgZG8gbm90IGhhdmUgYSBwYXJ0aWN1bGFyIHdvcmtsb2Fk
IChvciBkaXN0cm8pIGluIG1pbmQsIHNvDQo+IGkgaGF2ZSB0byByZWFzb24gdGhyb3VnaCB0aGUg
Y2FzZXMgdGhhdCBtYWtlIHNlbnNlIGFuZCB0aGUNCj4gY3VycmVudCBsaW51eCBzeXNjYWxsIGFi
aSBhbGxvd3MsIGJ1dCBmYWlsIG9yIGRpZmZpY3VsdCB0bw0KPiBzdXBwb3J0IHdpdGggc2hhZG93
IHN0YWNrcy4NCj4gDQo+IG9uZSBzdWNoIGNhc2UgaXMganVtcGluZyBiYWNrIHRvIGFuIGFsdCBz
dGFjayAoaS5lLiBpbmFjdGl2ZQ0KPiBsaXZlIGFsdCBzdGFjayk6DQo+IA0KPiAtIHdpdGggc2hh
cmVkIHNoYWRvdyBzdGFjayB0aGlzIGRvZXMgbm90IHdvcmsgaW4gbWFueSBjYXNlcy4NCj4gDQo+
IC0gd2l0aCBhbHQgc2hhZG93IHN0YWNrIHRoaXMgZXh0ZW5kcyB0aGUgbGlmZXRpbWUgYmV5b25k
IHRoZQ0KPiDCoCBwb2ludCBpdCBiZWNvbWUgaW5hY3RpdmUgKHNvIGl0IGNhbm5vdCBiZSBmcmVl
ZCkuDQo+IA0KPiBpZiB0aGVyZSBhcmUgbm8gaW5hY3RpdmUgbGl2ZSBhbHQgc3RhY2tzIHRoZW4g
KmJvdGgqIHNoYXJlZA0KPiBhbmQgaW1wbGljaXQgYWx0IHNoYWRvdyBzdGFjayB3b3Jrcy4gYW5k
IHRvIG1lIGl0IGxvb2tlZA0KPiBsaWtlIGltcGxpY2l0IGFsdCBzaGFkb3cgc3RhY2sgaXMgc2lt
cGx5IGJldHRlciBvZiB0aG9zZSB0d28NCj4gKG1vcmUgYWx0IHNoYWRvdyBzdGFjayB1c2UtY2Fz
ZXMgYXJlIHN1cHBvcnRlZCwgc2hhZG93IHN0YWNrDQo+IG92ZXJmbG93IGNhbiBiZSBoYW5kbGVk
LiBkcmF3YmFjazogY29tcGxpY2F0aW9ucyBkdWUgdG8gdGhlDQo+IGRpc2NvbnRpbm91cyBzaGFk
b3cgc3RhY2suKQ0KPiANCj4gb24gYXJtNjQgaSBwZXJzb25hbGx5IGRvbid0IGxpa2UgdGhlIGlk
ZWEgb2YgImRlYWwgd2l0aCBhbHQNCj4gc2hhZG93IHN0YWNrIGxhdGVyIiBiZWNhdXNlIGl0IGxp
a2VseSByZXF1aXJlcyBhIHYyIGFiaQ0KPiBhZmZlY3RpbmcgdGhlIHVud2luZGVyIGFuZCBqdW1w
IGltcGxlbWVudGF0aW9ucy4gKGxhdGVyDQo+IGV4dGVuc2lvbnMgYXJlIGZpbmUgaWYgdGhleSBh
cmUgYncgY29tcGF0IGFuZCBkaXNjb3ZlcmFibGUpDQoNCkkgdGhpbmsgeW91IGNvdWxkIGRvIGl0
LCBpZiB5b3VyIHNpZ25hbCBoYW5kbGVyIGNhbiBwdXNoIGRhdGEgb24gdGhlDQpzaGFkb3cgc3Rh
Y2sgbGlrZSB4ODYgZG9lcy4gSSdkIHN0YXJ0IHdpdGggYSBwYWRkZWQgc2hhZG93IHN0YWNrIHNp
Z25hbA0KZnJhbWUgdGhvdWdoLCBhbmQgbm90IHRydXN0IHVzZXJzcGFjZSB0byBwYXJzZSBpdC4N
Cg0KPiANCj4gb25lIG5hc3R5IGNhc2UgaXMgc2hhZG93IHN0YWNrIG92ZXJmbG93IGhhbmRsaW5n
LCBidXQgaQ0KPiB0aGluayBpIGhhdmUgYSBzb2x1dGlvbiBmb3IgdGhhdCAobm90IHRoZSBuaWNl
c3QgdGhpbmc6DQo+IGl0IGludm9sdmVzIHNldHRpbmcgdGhlIHRvcCBiaXQgb24gdGhlIGxhc3Qg
ZW50cnkgb24gdGhlDQo+IHNoYWRvdyBzdGFjayBpbnN0ZWFkIG9mIGFkZGluZyBhIG5ldyBlbnRy
eSB0byBpdC4gKyBhIG5ldw0KPiBzeXNjYWxsIHRoYXQgY2FuIHN3aXRjaCB0byB0aGlzIGVudHJ5
LiBpIGhhdmVudCBjb252aW5jZWQNCj4gbXlzZWxmIGFib3V0IHRoaXMgeWV0KS4NCg0KVGhlcmUg
bWlnaHQgYmUgc29tZSBjb21wbGljYXRlZCB0aGluZyBhcm91bmQgc3RvcmluZyB0aGUgbGFzdCBz
aGFkb3cNCnN0YWNrIGVudHJ5IGludG8gdGhlIHNoYWRvdyBzdGFjayBzaWdmcmFtZSBhbmQgcmVz
dG9yaW5nIGl0IG9uDQpzaWdyZXR1cm4uIFRoZW4gd3JpdGluZyBhIHRva2VuIGZyb20gdGhlIGtl
cm5lbCB0byB3aGVyZSB0aGUgc2F2ZWQNCmZyYW1lIHdhcyB0byBsaXZlIHRoZXJlIGluIHRoZSBt
ZWFudGltZS4NCg0KQnV0IHRvIG1lIHRoaXMgd2hvbGUgc2VhcmNoLCByZXN0b3JlIGFuZCBJTkNT
U1AgdGhpbmcgaXMgc3VzcGVjdCBhdA0KdGhpcyBwb2ludCB0aG91Z2guIFdlIGNvdWxkIGFsc28g
aW5jcmVhc2UgY29tcGF0aWJpbGl0eSBhbmQgcGVyZm9ybWFuY2UNCm1vcmUgc2ltcGx5LCBieSBh
ZGRpbmcga2VybmVsIGhlbHAsIGF0IHRoZSBleHBlbnNlIG9mIHNlY3VyaXR5Lg0KDQoNClsgc25p
cCBdDQoNCj4gc2xvdyBsb25nam1wIGlzIGJhZC4gKHdlbGwgbG9uZ2ptcCBpcyBhY3R1YWxseSBh
bHdheXMgc2xvdw0KPiBpbiBnbGliYyBiZWNhdXNlIGl0IHNldHMgdGhlIHNpZ25hbG1hc2sgd2l0
aCBhIHN5c2NhbGwsIGJ1dA0KPiB0aGVyZSBhcmUgb3RoZXIganVtcCBvcGVyYXRpb25zIHRoYXQg
ZG9uJ3QgZG8gdGhpcyBhbmQgd2FudA0KPiB0byBiZSBmYXN0IHNvIHllcyB3ZSB3YW50IGZhc3Qg
anVtcCB0byBiZSBwb3NzaWJsZSkuDQo+IA0KPiBqdW1waW5nIHVwIHRoZSBzaGFkb3cgc3RhY2sg
aXMgYXQgbGVhc3QgbGluZWFyIHRpbWUgaW4gdGhlDQo+IG51bWJlciBvZiBmcmFtZXMganVtcGVk
IG92ZXIgKHdoaWNoIGFscmVhZHkgc291bmRzIHNpZ25pZmljYW50DQo+IHNsb3dkb3duIGhvd2V2
ZXIgdGhpcyBpcyBhbW9ydGl6ZWQgYnkgdGhlIGZhY3QgdGhhdCB0aGUgc3RhY2sNCj4gZnJhbWVz
IGhhZCB0byBiZSBjcmVhdGVkIGF0IHNvbWUgcG9pbnQgYW5kIHRoYXQgaXMgYWN0dWFsbHkgYQ0K
PiBsb3QgbW9yZSBleHBlbnNpdmUgYmVjYXVzZSBpdCBpbnZvbHZlcyB3cml0ZSBvcGVyYXRpb25z
LCBzbyBhDQo+IHplcm8gY29zdCBqdW1wIHdpbGwgbm90IGRvIGFueSBhc3ltcHRvdGljIHNwZWVk
dXAgY29tcGFyZWQgdG8NCj4gYSBsaW5lYXIgY29zdCBqdW1wIGFzIGZhciBhcyBpIGNhbiBzZWUu
KS4NCj4gDQo+IHdpdGggbXkgcHJvcG9zZWQgc29sdXRpb24gdGhlIGp1bXAgaXMgc3RpbGwgbGlu
ZWFyLiAoaSBrbm93DQo+IHg4NiBpbmNzc3AgY2FuIGp1bXAgbWFueSBlbnRyaWVzIGF0IGEgdGlt
ZSBhbmQgZG9lcyBub3QgaGF2ZQ0KPiB0byBhY3R1YWxseSByZWFkIGFuZCBjaGVjayB0aGUgZW50
cmllcywgYnV0IHRlY2huaWNhbGx5IGl0J3MNCj4gbGluZWFyIHRpbWUgdG9vOiB5b3UgaGF2ZSB0
byBkbyBhdCBsZWFzdCBvbmUgcmVhZCBwZXIgcGFnZSB0bw0KPiBoYXZlIHRoZSBndWFyZHBhZ2Ug
cHJvdGVjdGlvbikuIHRoaXMgYWxsIGxvb2tzIGZpbmUgdG8gbWUNCj4gZXZlbiBmb3IgZXh0cmVt
ZSBtYWRlIHVwIHdvcmtsb2Fkcy4NCg0KV2VsbCBJIGd1ZXNzIHdlIGFyZSB0YWxraW5nIGFib3V0
IGh5cG90aGV0aWNhbCBwZXJmb3JtYW5jZS4gQnV0IGxpbmVhcg0KdGltZSBpcyBzdGlsbCB3b3Jz
ZSB0aGFuIE8oMSkuIEFuZCBJIHRob3VnaHQgbG9uZ2ptcCgpIHdhcyBzdXBwb3NlZCB0bw0KYmUg
YW4gTygxKSB0eXBlIHRoaW5nLg0KDQoNClNlcGFyYXRlIGZyb20gYWxsIG9mIHRoaXMuLi5ub3cg
dGhhdCBhbGwgdGhlIGNvbnN0cmFpbnRzIGFyZSBjbGVhcmVyLA0KaWYgeW91IGhhdmUgY2hhbmdl
ZCB5b3VyIG1pbmQgb24gd2hldGhlciB0aGlzIHNlcmllcyBpcyByZWFkeSwgY291bGQNCnlvdSBj
b21tZW50IGF0IHRoZSB0b3Agb2YgdGhpcyB0aHJlYWQgc29tZXRoaW5nIHRvIHRoYXQgZWZmZWN0
PyBJJ20NCmltYWdpbmluZyBub3QgbWFueSBhcmUgcmVhZGluZyBzbyBmYXIgZG93biBhdCB0aGlz
IHBvaW50Lg0KDQpGb3IgbXkgcGFydCwgSSB0aGluayB3ZSBzaG91bGQgZ28gZm9yd2FyZCB3aXRo
IHdoYXQgd2UgaGF2ZSBvbiB0aGUNCmtlcm5lbCBzaWRlLCB1bmxlc3MgZ2xpYmMvZ2NjIGRldmVs
b3BlcnMgd291bGQgbGlrZSB0byBzdGFydCBieQ0KZGVwcmVjYXRpbmcgdGhlIGV4aXN0aW5nIGJp
bmFyaWVzLiBJIGp1c3QgdGFsa2VkIHdpdGggSEosIGFuZCBoZSBoYXMNCm5vdCBjaGFuZ2VkIGhp
cyBwbGFucyBhcm91bmQgdGhpcy4gSWYgYW55b25lIGVsc2UgaW4gdGhhdCBjb21tdW5pdHkgaGFz
DQooRmxvcmlhbj8pLCBwbGVhc2Ugc3BlYWsgdXAuIEJ1dCBvdGhlcndpc2UgSSB0aGluayBpdCdz
IGJldHRlciB0byBzdGFydA0KZ2V0dGluZyByZWFsIHdvcmxkIGZlZWRiYWNrIGFuZCBncm93IGJh
c2VkIG9uIHRoYXQuDQoNCg==
