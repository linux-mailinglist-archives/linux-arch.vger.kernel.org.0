Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EFA61FB93
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 18:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiKGRhk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 12:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiKGRhi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 12:37:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D923BD9;
        Mon,  7 Nov 2022 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667842657; x=1699378657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=enF3R25q/fPl4+p1LlX2Ru8/e6jgNG+JLozv6DZ2H6M=;
  b=Qb7wcPJGp16jaz3eDk8sNmmyHEaqjSvx7CpucdqN5o6kG9Zt5ii6M+ri
   iCkOa2YnapLfgnec1amxuDkytlTFcxYE5Gm766KMPOEoRPWj+dYt5qqET
   Pk0BkX3jwarMBZgbhmxRNN74CutkMrH4sKqqjPKmmt68gAvR5+5R1Czno
   2r/w0pIGKz/usR86b7E3a9bgel8kGLK8MptaosDnlj+0qm7TOOtQ/H+jY
   SCL4gIGfzO9hTdLNWv1GZwGLwdmHZBR4NJKznEVOZMCbBtBAqX6n7FFVG
   2GfEzzSE+e2cD0lQ7uYjmpa4XSNOSMUnsMK8ve/wF99/VoE+j8/onKuB/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="396771997"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="396771997"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 09:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="881166121"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="881166121"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2022 09:37:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 09:37:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 09:37:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 09:37:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+rg7wSC91REkhDywbS1Z4BoVy20f86Zwb9aqSlCHY0J+wLctQIw4eg+MK3excSg/cWwWPgdvAhS9thb7KOLEWIMcVQIbFeNx79+/LcZRZUatbcv/OVSYLDHWaHFDwR1vQJZt/AKLqnKU4jNUf+GDeODdjAtujKC+3wHWHX94G6FEBjICtVsJE/ZPFupHmdf936cRU5IFQMNDCxLbbA+8X010wpB4BauvEWDLFzaFcQjNdgBTzN4wau9FjEzUP/2LDqJuUqIKc1uNpf5+Fb9N49fDj7qF30InyfEyR5vS2+nGg2Y0diK2V6rqTjU3WFdsE/Poybsg1MpsZbE2uAIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enF3R25q/fPl4+p1LlX2Ru8/e6jgNG+JLozv6DZ2H6M=;
 b=ILPT0fxnL2meW3aAaOG9LLjZb17JivyBSKOTChJ7bzV2YHwEHwOabv44Yyv6nThEhetd7ZpscxvdZHFO2Aofb5RHZVf4bqv3nFaB0nMUhUHuHWADUv6ADFyvHIWUMiFFx01sSBEJJofz7Kw6Ia1b8xvvXMoKX2fNB6ZBrkaOKRtjY/+bXuIPl7yFeCS7G11EOe4Hp8HxiftV2jGPIXNxLQjrcZu10ID4cHe8w37swA7EoNxsjxxhXwzj8FexZSQgXFVSUiqypt9tMtX3BtoTnk40qMh3DWMVQm2I8JFpuLlo/GE5r5KLSUgUaXnBLAi/i9CooETgNb0cDSsdW+FnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 17:37:14 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 17:37:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Topic: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Index: AQHY8J5g32apAoMYh0aArgmkU40OVa4vYA0AgAJEZxCAAgw+gIAAAcpVgAALa4A=
Date:   Mon, 7 Nov 2022 17:37:14 +0000
Message-ID: <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-38-rick.p.edgecombe@intel.com>
         <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
         <87iljs4ecp.fsf@oldenburg.str.redhat.com>
         <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
         <87h6zaiu05.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87h6zaiu05.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB4892:EE_
x-ms-office365-filtering-correlation-id: f28edbf1-3681-422c-ea9a-08dac0e6b563
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3Y2u4VvH83s6q0PnsybHOod2yRy2oTkozu8rHTOZ4fXyCEwIvl/IXbtOWleuBKmow9aCeI1jhmilHdVXHerbXFS9p6ykwIIBgHWGZaZ7C609/WT3qwzVyYf0uiRGYqHsbnvUN/l8cclNQMhQpcg8AZp5vuG8MsYszRoEQ4/mkWThJvMnSsU+kxv3O5eW+MmJ/ikOKR4hWTv/DMFI+DxucrdLqEsjGgj5RxJs+lq2fsbxJlSxrXfriiAOkJyHmqVfRZv7zq+aTbkK0l2nbR7aqZtMdHCavfvwJTX0/vuWe4AVnzdj0N8xEugR45zjdKKJm6zmDUNe7K1Tux37ALKKhLNHHOa1mjyff+ZiUdjk2k/z22Zl9U5LRmkR3rq3O9CSy8RUlyNO3kkTrXoYooZBzPwrgtf+zgHS88gAhNxwo35XYQDrKTZw5rqQ8o/eaXDXnCs4+TPGYf+z7eYGrSuwEnDkiVguqb8v6B21WZIBwYLWIM8t9EYoVYTKtfhNyMSGiti+esLMVWCrYOTbUJIsztZJK3nf9PEom3SwdBODzDpQMjbMhZQZn3tBsOpMJvyAWJXKJFVLTxPM8aMm4dtnUmkrswZA5QuwJPnA8qn2EANAQD08FN1r1ZMPbE3+zNQsMlAXNL/fFC5hKWBUZ/FrJ0qEFCYuNm8PnsRBr6BJ4j6F6/87IbCW8Mn8IBaOQuAIl1Azqmz02tqjeLRRh0rJamgCPdtabtHT696nFOBjpB/sCZdHO/SpCd4lRtBl4YPMfzRJkv92BLG3D7hJYezgjrdDuu5Q6x4NSIMyfkCHEo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(66899015)(36756003)(54906003)(8936002)(5660300002)(6486002)(7406005)(7416002)(66946007)(71200400001)(38070700005)(83380400001)(2906002)(478600001)(66556008)(4326008)(66476007)(41300700001)(66446008)(8676002)(64756008)(76116006)(316002)(26005)(2616005)(6512007)(186003)(6916009)(122000001)(82960400001)(38100700002)(86362001)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RitjWnFIa1BiOWw3OFZLbkZJTXRjU2JzWlRlTk5BRkk3cnJVbFV1eUQzbnNr?=
 =?utf-8?B?ZDNiTEFBamdNTkNaSG5rYlNPeWFpOENveGp1Q25kTFRHa3B4amhVM1ZqRHpB?=
 =?utf-8?B?NWRuZUVjYWlUNVVZZ09pZ2JGaCs3MndSQlNDa2VmT0xObUw3NTNkMTNvaEFR?=
 =?utf-8?B?UjVNLzVNVTBGVk5YSzlMMmkweS9wTWhKWkg0OUlMTndkQzVmbXZWejgvNEJS?=
 =?utf-8?B?YmFmcHo0LysyaDBwZldsbHROQkx2M21nZU90cFcvS1NNM1ZJS2o3QkVYeXRU?=
 =?utf-8?B?eTh5L3ZRVHMzYkU4R3BJdmNJdDk0TWxaNDVjV2F5eXJ1NWRvYmJmazZVWDQx?=
 =?utf-8?B?N05Zc01pU1FtMHR5RU5IcElkcGtwQklFai9IRG1TejhoT05YOEpsTmd1aWFi?=
 =?utf-8?B?TXVGR3ZBSXIxbUVVRFN1bTNPVERzd0tjVEZmMncyNjlvOWExenZPLzJBM3JZ?=
 =?utf-8?B?WlREMnlVeGd1MFlBN2hacVZlUEVaNVZxK2M2WDBtQjFLQlozenk4TzNCWGxx?=
 =?utf-8?B?ZWRkUVRIWWtiSzBYczhhWTNNeG9ZeHhGaGdUN3lzWkdOVFhkSTFybG40Y2pj?=
 =?utf-8?B?Tk9xbGRBSGQ1aCt2QzRFeVVWamphVUMwK295QkNJRE1CbFhUYWJRNjJUUHlO?=
 =?utf-8?B?b284NUQ0L0ttVThvM1U0MWxMYWZKY21oNXVkNG5HMlhLd2pudnYxcnNCcksy?=
 =?utf-8?B?WHEzVytZV2NFWU9QcUYrbEMwSGxwNW1XZmZXL0VmeDFoZDFKaDhuOXlzMlpi?=
 =?utf-8?B?WVVmZmZxUGd4Zk92SHFaTzFwa1BJTTZnMXFqMThtTDIxdUlkU0owR0JRQ0Fo?=
 =?utf-8?B?SzhoemZNUFFQeGVKbjdBbDZTTGYrSFZYMjVlbkVzcTZvdlhvcFNQYlc3M01X?=
 =?utf-8?B?QXJEMkpIQTdEU0Q2cUVTQWNta01obXBxRkxwL2RvUExwaVIzTDVJakJla293?=
 =?utf-8?B?TjMzc0J4YTN2ZDVZNUJFOERZOXpRMVQvNjV5bzRWcStoeXYxeDRUSk5lLzhT?=
 =?utf-8?B?RjZWWmxOS21vNy9aZTZEbjU0Tm5YNXpDVjRHS2VOY0FPVHNwUW96Vnhaeldy?=
 =?utf-8?B?Wmw1aTh4S2Z5Qi84WVdsbnM0M3BjOFFCUDZVMldCLzFrMWU4SkxqdWE0SGxW?=
 =?utf-8?B?amJ3WWVLTS8wRE5kekdsVldZQjRvZllhS1Z4VE9LRWoyYUt3Q1dHUE9YK1A1?=
 =?utf-8?B?VFRmU3pTcDZDUm4rNmZIUUlySXV2N0FZbWQ5SUdwcVZOMHQ4L0RXRFptYjRK?=
 =?utf-8?B?OW5ObHhLRGFyYzZUaWh3M2ltYlRxQjJQZmxaZjRpNERTSGM2T25NN1F1d05w?=
 =?utf-8?B?VnhGRTJXZ0hTOUN0V3JiN2o3dmh4RDZkUEVyQ1RmY2dRcXNsMEZNUWV3SnBj?=
 =?utf-8?B?NVo4NnRYek4ycWNudlF3YmxENUd1UDh1ZkRzd0lHYXEwQWw1Q1dmR0M5MXU1?=
 =?utf-8?B?dzArdGJIQmZOcmtBN052ZjkxaVRUTjVhVjJodjJ1VEMrMkFLN3lweXdDaUZj?=
 =?utf-8?B?RDFGMlpEcE9CbUxqcmVRMWxqTENwK3lLNzZYOXRUSG15bDNCY2xndGhONlI1?=
 =?utf-8?B?RWxRYnpVallhVGU0N2hNVHNpZnhGZ0Q0OFdvdzV0MkJRbUp0dVFUQ0JDUkZw?=
 =?utf-8?B?SWtMR2U2N29qY0RGM2FnWDRhK0dJS05pV3VCZC80ams4cnY3UnR5NVpLc1Rk?=
 =?utf-8?B?L0tuVVhhZ2JvT05qZ3RrcmZSZyt2K0FwOERzVnV4Uml6ZHhRb1lySVllTk03?=
 =?utf-8?B?blZJOHJNWDhKUkxOZU12MFA4T0Z1bVZndjZGRjJRazlxTkpnSHRRMGEzblBL?=
 =?utf-8?B?UWw0c3JMeXo1bmlPeUd3Yi9ON25Vd3RuNEN0NzVBbjNxMHFia2dHMjRMWEdR?=
 =?utf-8?B?S0MwYnlEd21pVWFaYnZDZU4wL2t3RlB2RFpUUmE5SThNY2t3NnpqQWRFYkhW?=
 =?utf-8?B?SklqQTZBbkhpSHM3KzJFamk3T1p3b0pldWljRXllUHVaRDFCRDFVVS9rQjFT?=
 =?utf-8?B?eW5pYm1weTIybUZQVjkwVi8veFg0NnVmV00wZFNWR3d6MGhxZ0lGb0JDNlNF?=
 =?utf-8?B?VTFEcnNvaFoxL09XRFN2NmtkcVkwZXVKUDBzQjlRd1NLQVpzTHBUY1NZbyth?=
 =?utf-8?B?alhHb0dCSlJFLytGTHF2QmNXdVJMVE5WOFlvV3IxY2hhN1Nic2xzZERPa0tx?=
 =?utf-8?Q?VHNeQV5IluimRqt4sTzV99g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABE2AB7889A6B24B86174240EF0D4A5D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28edbf1-3681-422c-ea9a-08dac0e6b563
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 17:37:14.4425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZI/GRdQAlef+H+3Unt8pyjYgYUduxk4vc/0yxhK8mH6FUnt24Q2joX9sG0iswBsMvON/61qcGw5DpOHppHWJp7SvbOu3eLGVwsEgKWsB0vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDE3OjU1ICswMTAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gKiBSaWNrIFAuIEVkZ2Vjb21iZToNCj4gDQo+ID4gT24gU3VuLCAyMDIyLTExLTA2IGF0IDEw
OjMzICswMTAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToNCj4gPiA+ICogSC4gSi4gTHU6DQo+ID4g
PiANCj4gPiA+ID4gVGhpcyBjaGFuZ2UgZG9lc24ndCBtYWtlIGEgYmluYXJ5IENFVCBjb21wYXRp
YmxlLiAgSXQganVzdA0KPiA+ID4gPiByZXF1aXJlcw0KPiA+ID4gPiB0aGF0IHRoZSB0b29sY2hh
aW4gbXVzdCBiZSB1cGRhdGVkIGFuZCBhbGwgYmluYXJpZXMgaGF2ZSB0byBiZQ0KPiA+ID4gPiBy
ZWNvbXBpbGVkIHdpdGggdGhlIG5ldyB0b29sY2hhaW4gdG8gZW5hYmxlIENFVC4gIEl0IGRvZXNu
J3QNCj4gPiA+ID4gc29sdmUNCj4gPiA+ID4gYW55DQo+ID4gPiA+IGlzc3VlIHdoaWNoIGNhbid0
IGJlIHNvbHZlZCBieSBub3QgdXBkYXRpbmcgZ2xpYmMuDQo+ID4gPiANCj4gPiA+IFJpZ2h0LCBh
bmQgaXQgZG9lc24ndCBldmVuIGFkZHJlc3MgdGhlIGxpYnJhcnkgY2FzZSAodGhlIGtlcm5lbA0K
PiA+ID4gd291bGQNCj4gPiA+IGhhdmUgdG8gaG9vayBpbnRvIG1tYXAgZm9yIHRoYXQpLiAgVGhl
IGtlcm5lbCBzaG91bGRuJ3QgZG8gdGhpcy4NCj4gPiANCj4gPiBTaGFkb3cgc3RhY2sgc2hvdWxk
bid0IGVuYWJsZSBhcyBhIHJlc3VsdCBvZiBsb2FkaW5nIGEgbGlicmFyeSwgaWYNCj4gPiB0aGF0
J3Mgd2hhdCB5b3UgbWVhbi4NCj4gDQo+IEl0J3MgdGhlIG9wcG9zaXRl4oCUbG9hZGluZyBpbmNv
bXBhdGlibGUgbGlicmFyaWVzIG5lZWRzIHRvIGRpc2FibGUNCj4gc2hhZG93DQo+IHN0YWNrIChv
ciBpZGVhbGx5LCBub3QgZW5hYmxlIGl0IGluIHRoZSBmaXJzdCBwbGFjZSkuDQoNClRoZSBnbGli
YyBjaGFuZ2VzIEkgaGF2ZSBiZWVuIHVzaW5nIHdvdWxkIG5vdCBoYXZlIGVuYWJsZWQgc2hhZG93
IHN0YWNrDQppbiB0aGUgZmlyc3QgcGxhY2UgdW5sZXNzIHRoZSBleGVjaW5nIGJpbmFyeSBoYXMg
dGhlIGVsZiBiaXQuIFNvIHRoZQ0KYmluYXJ5IHdvdWxkIHJ1biBhcyBpZiBzaGFkb3cgc3RhY2sg
d2FzIG5vdCBlbmFibGVkIGluIHRoZSBrZXJuZWwgYW5kDQp0aGVyZSBzaG91bGQgYmUgbm90aGlu
ZyB0byBkaXNhYmxlIHdoZW4gYW4gaW5jb21wYXRpYmxlIGJpbmFyeSBpcw0KbG9hZGVkLiBHbGli
YyB3aWxsIGhhdmUgdG8gZGV0ZWN0IHRoaXMgYW5kIGFjdCBhY2NvcmRpbmdseSBiZWNhdXNlIG5v
dA0KYWxsIGtlcm5lbHMgd2lsbCBoYXZlIHNoYWRvdyBzdGFjayBjb25maWd1cmVkLg0KDQo+ICAg
VGVjaG5pY2FsbHksIEkNCj4gdGhpbmsgbW9zdCBpbmNvbXBhdGlibGUgY29kZSByZXNpZGVzIGlu
IGxpYnJhcmllcywgc28gdGhpcyBrZXJuZWwNCj4gY2hhbmdlDQo+IGFjaGlldmVzIG5vdGhpbmcg
YmVzaWRlcyBwdW5pc2hpbmcgZWFybHkgaW1wbGVtZW50YXRpb25zIG9mIHRoZQ0KPiBwdWJsaXNo
ZWQtYXMtZmluYWxpemVkIHg4Ni02NCBBQkkuDQoNCkl0J3MgdW5kZXIgdGhlIGFzc3VtcHRpb24g
dGhhdCBub3QgYnJlYWtpbmcgdGhpbmdzIGlzIG1vcmUgaW1wb3J0YW50DQp0aGFuIGhhdmluZyBz
aGFkb3cgc3RhY2sgZW5hYmxlZC4gU28gaXQgaXMgbm90IGludGVuZGVkIGFzIGEgcHVuaXNobWVu
dA0KZm9yIHVzZXJzIGF0IGFsbCwgcmF0aGVyIHRoZSBvcHBvc2l0ZS4NCg0KSSdtIG5vdCBzdXJl
IGhvdyBtdWNoIHRoZSBzcGVjIG1hbmRhdGVzIHRoaW5ncyBieSB0aGUgbGV0dGVyIG9mIGl0LCBi
dXQNCmluIGFueSBjYXNlIHRoaW5ncyBoYXZlIGdvbmUgd3JvbmcgaW4gdGhlIHJlYWwgd29ybGQu
IEkgYW0gdmVyeSBvcGVuIHRvDQpkaXNjdXNzaW9uIGhlcmUuIEkgb25seSB3ZW50IHRoaXMgd2F5
IGFzIGEgbGFzdCByZXNvcnQgYmVjYXVzZSBJIGRpZG4ndA0KaGVhciBiYWNrIG9uIHRoZSBsYXN0
IHRocmVhZC4NCg==
