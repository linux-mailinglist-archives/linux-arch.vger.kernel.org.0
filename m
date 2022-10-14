Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5D5FF1BC
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiJNPwF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 11:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJNPwD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 11:52:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5B1C39EA;
        Fri, 14 Oct 2022 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665762723; x=1697298723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4bAdY5Q6iTds+9ebHC5NQR+Ki3aHdOBwIeu9CyNjtVo=;
  b=kLU600WwzOoWdgErWIbwcHjajrY8B6qiQXiIwMxdo0LUcZryOmlQuZcB
   +c5RvIMvF5h4HSEcrnHW1/xjBjBZ6RNBNzzVqUM9Yfwb5fZba5cqsVI9L
   Qr9PG2IFHeiyB7cIgNS/xQgSba/FY6TLQpkyJPVYlUVN+95URNIc1OksM
   JY6QsOjaHpjRABYplo7w1mazBQBCZ+5zq1V8MNpHuH1wO9opm6ekOLWHZ
   GxholIw0IoCcwvAAketaRD2hSl4Nkvf2K4JuKB7r7jobH/2tS15FVNma8
   p4ed0aa48aNX6QL2O4oBDMxfalqDHLPlAhg0n0vDhPw2fTljo3tdNM4N8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="288693533"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="288693533"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 08:52:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="622571206"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="622571206"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2022 08:52:02 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 08:52:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 08:52:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 08:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+XEJ34/6IAqAErouCvsgBs3Iun9KHhLVMwpdu/s7h22yXqSHBXfimwkloOpuXFOV4hthNjFl85PlQhHu+bF5eNYWDE5szcveDuMRv23+HAKU51WD7NRxrAQfmoaN6Qc8yzoHvT4HnR4s7CybAixYS6PlmW9OQ+khdf4mbash+/k1NGVbw0seImi0/j+M+jc+RXWPcyrYttj6S9Fm0S2xnevr8GYCCRmsz1SKasR4ktobWILC0f6PNGUc1hHhUTB0BZnhTdpRHalSSzx0kfKdQ+QZZ2EpRb/SzSePBjtJ3wq9ZOx4DgpDnc8Nj9eMvyMIYUeNU5tjxKqibs6ejlcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bAdY5Q6iTds+9ebHC5NQR+Ki3aHdOBwIeu9CyNjtVo=;
 b=CWrqtmILrNCT9Mvc8Qo4gzoZ+DqI0maOtSk5OZKDjkw8LUQcJ7fmBwMi57wBpUQbgVdS5fe16I9I2LgHsPvt5tf2XvDh4k+Gw5x/rsp6X3W6zTIzN20rEV0ftcJ7LcUWlKeJKGDKpGeCSfLYW/lCjCpxbIXsmFB6HKA/NuTMlZuyTqf/fFU8dK6tvniVPCW/2d7ZUiFKqT3tZbdlqSax+lJszBvgq2SynS0JVhzYVmQoB0HPuWT5gDlZAwjjJB+FjBNt2tUarzLhDK2pQ17yKLcG6lD++VM+FWQcXt47cUuLyO6GlVtxjXpuu5XDu8xNvPSRCtrbWU5QqAtuC+9ipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 15:52:00 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 15:52:00 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
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
Subject: Re: [PATCH v2 15/39] x86/mm: Check Shadow Stack page fault errors
Thread-Topic: [PATCH v2 15/39] x86/mm: Check Shadow Stack page fault errors
Thread-Index: AQHY1FMb4OqGm3CkWkagG+jysqWlUa4NwMkAgABgWoA=
Date:   Fri, 14 Oct 2022 15:51:59 +0000
Message-ID: <f782111cf57a4666219b7976c04112c6330d108b.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-16-rick.p.edgecombe@intel.com>
         <Y0k0zJK7biH+EMlO@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0k0zJK7biH+EMlO@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB7007:EE_
x-ms-office365-filtering-correlation-id: 05ebcde5-284f-460a-9a63-08daadfc07c8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1PB1L22lqxbqXqyQe9bJDsdtAmxCtGMYdENKUq1/6qNlx2bBWXCTsPxqjeKpCprWbkOoHZ8qSk/EDOGisN2nWVoefbbdWJRtsn1eJFcMsHhdfuvdmBNlBd7Ds+K1e2p2CE7DpY6oa7n8mAql5bLTeEGBPlsdYmmvjRghIUHlEoMTNthpnKK4gT0EjuD8VyiIoi3eAQHZgvQ2k0hEw13+ABkJfqdEjBS/rv8NOUElp02JG3ukrWH5uUuzrUSusoHlCwH2/bQbJWF1UA4+Yz4BeZRAzP5noDw0xWuOQYjatGwvMlxswEc7jbwWdMRZcEKkTNVriTFYp5zO+NdGXAw0pkASclYxFTL6CxNGRAGNg3waP86t5o0zFb7cHMpOtBcgjJv6gl17Lo/ucHXcCmTNhO1/nSfi4HQ1XZnqyCtrd6rJh0amHtVLJ1zJasOHTMvb4nGkTl7GiYwCOJ82l9E/MZVH5YqV2606/UAvKzQ3M6r3vTNCKnv4mV+ytXY0CaYBU5EHhZztdC8VrK2q4fQjIi5qfspxdO5G3gGJlS1LBwlMOqLjJX/6Vqad6WWYspAsIZrY0vw2fPdoCjKOvB9Nom7zTH7wzpvMyQQ3FtRnkwmEKlG5V3omGHQzejtnYfL2KeShQ/eiU7zr322RzLOd2ZFLHrj1VkhnTSYDdtY9rSY2anGEuPFj+v6gnEqB+OwOAebqA99NNrx5APc3bsjVhQHBlriLqEaFbVMebSzWY910Mlz19Dxnfx3EdOP/aIqrHgAS4+9itOH4rbSKViagshPVScKqm5oAzRHE/oYDoQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(4001150100001)(7406005)(7416002)(2906002)(2616005)(186003)(5660300002)(6506007)(41300700001)(6512007)(8936002)(26005)(38100700002)(82960400001)(558084003)(86362001)(38070700005)(36756003)(122000001)(54906003)(6916009)(316002)(478600001)(6486002)(66946007)(76116006)(91956017)(8676002)(4326008)(66556008)(66476007)(66446008)(64756008)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QngwcmE5c1pOZG53YXdNTGM4eXZvTlpiTnZnYjhiK1ArMWg4bkdSMGNTVVkv?=
 =?utf-8?B?cHBHSWplQVpnZUM1OTNEdThkeklZVGFqM1kwc3FGbld2RTkwT0xleWE3TkQw?=
 =?utf-8?B?eHducGVZbFFZVU1zVVBQRkhXUTJaN1A0b1NEU0hDcmROWHh3bE1yQXdYVllL?=
 =?utf-8?B?RVhWRmlWenF6NzZGMExHYWkzWFM1NVJTbFIyakZUWDhhMEh2a3lVbno0V1NK?=
 =?utf-8?B?Tzc1RmVMRFNTMGlpNURlUEJ5REo5L0xWRDg5RTNZc2ZLWlJwcUQ3TW1VSWRq?=
 =?utf-8?B?ZUMvSThLUHpDOWNDZWJoMW8zZ2ZGeTlpeUFpemhUeCtlaythV1Fsa3MxQVhy?=
 =?utf-8?B?N0JtZTdlR3JVbkdEMEJySk5LeEkvdXMzVlhmdEV1bTREeGN0RHo3cml3djhL?=
 =?utf-8?B?Q2VHNGFDM2RPVi8xb0prWHMzNUdZdm1qeXpNR210Qzh5NUVjSVc4T1JheE5M?=
 =?utf-8?B?SlBFdURyeFJCSmQ0VUNGaS95b0p0cUNJK3VDZUU5QnJGY09HR0RweTdLNlZv?=
 =?utf-8?B?U2RLV3U3dWpWaVNvWkVpeVVXcWZ2cWg1SnZJN2hlVE5nZTdOV3hhQmV0OVdx?=
 =?utf-8?B?WHJOYy9WV0dZbnEwMXJXc3VhNVB1Z2hvVU9HQXlqZGhnY3FqZkZOYTdpMHE3?=
 =?utf-8?B?TDd0RnkvYXNCUFlRU29NNFpGMFdvVFdzVE9zbXhBQ0NHQmRIMXVZMTRzb1Z4?=
 =?utf-8?B?eGJZb2VaUjdhQlpoM1duYTNyb1AzM0Q1OXloYnJwWFY5dXBOWjJlaStHTDZh?=
 =?utf-8?B?czJyNzd5aGRuUG5LZWdtRWdxMXF4QTBySU1uMTYzV2tCU3FLemRUQjhXaXAx?=
 =?utf-8?B?bjIzREducnpsaWpkOUw3WEgyU09TdHRESUg0QkZVMFdIWXZOVTNJNXQrT1N6?=
 =?utf-8?B?MEcvNk84ZWI0YWM5K3RGd0dwOUlJaWc5eDhHcldjc2R0OUpQZkFhRFZBTENX?=
 =?utf-8?B?Nzl4T3ptM3h0ZlpVZW90SjBtN1VKaVFOMDJBTXhOK0M2RjFvZU96dFpVSllj?=
 =?utf-8?B?clBMU2pZdDdCT3BMMjhBcmNENlE4aVpmaTF1akE5VHZUUDlJRDI3K2dBd01u?=
 =?utf-8?B?c043T1JUeE44Yzg2SGJwVTJuS2ZiNEJ1cG9XbzgzcSsvUVZZV1RRM2NBQUda?=
 =?utf-8?B?QmxWUC9aVnZmT3lhSGZNQUZQRURyYjlNS0NPajQ5enNRUUlkNkZ2V0EvajRH?=
 =?utf-8?B?c0pkVWdGM2IwOW5XaFlRZlZGUEI2UStrNEZzYjE3Q016S0ZabktpWFpZeTA3?=
 =?utf-8?B?V2hublhFMjJndW84VFl1V3dLSm1vMFJDcTJvUmlIc1cybllwMThZcWhtUWw2?=
 =?utf-8?B?NGwvYnR4bGNVeU9sNlhaSE9DQlBDcGlPMStva0RIb20zMkNzenZpdHprOEx3?=
 =?utf-8?B?QTc5MmVRQzlwL3RWZ3FsZlZMWUt4YUhWczg3M2VvV0ZzZE1Pam9icUtWckwx?=
 =?utf-8?B?UXhQc2pmMWpHS0VKS2VLa2pqZndzdWc5c2x0ZEszSkJyNWFZMVRlR0hvSkti?=
 =?utf-8?B?WHdLbGExc05BN3VLdTB1WnpBVWx5WmVQeFZQbENKSTFZWXpvYy9sYjkxUXc4?=
 =?utf-8?B?OXRvaFB5ZldseTBzZUNzZDgwa2dTRHIvVm1YbUNPRDBQRlp1alMvUjBLbjkz?=
 =?utf-8?B?VzI0SzNGQTRFYkloZFQxWXNUMjMyaTJHVGNmaG5KdDdNZFo1UVE2Z3U1NzAr?=
 =?utf-8?B?RWpPTWFrRmJYb3hKbE1DbUdRRVlmRmFiZ1FSYlhwV3Zrb2t0ZTJyWXJibFBN?=
 =?utf-8?B?d3FDc3o0b3lIVDVWemRLcTNjcmFidW8vRU1sSUxYc1djM09GYjhzNWU3SUMy?=
 =?utf-8?B?aE5OWUozcDN2cjY0MElNWTMydWI1TTlTY3NNdDFraGZ0V1pZV0dpQzJIQ2Z0?=
 =?utf-8?B?SmJDOTEybVF1cllaZjZ0RjRJL3k1VUdSSjNiQ3RiQ2JIcXJuNG1xbmRlQkRm?=
 =?utf-8?B?TWNTWjV3SzNFY1dlUzErWlhRSGhwWmxoQXVUY1pSSGQ4VzdYMEcrM2F2RW9E?=
 =?utf-8?B?Z01OQlV6Q1ZTeEI5YnF6TWVNVUpERTNPU1Z4T3VUWWFrZC9jNFRFN1JRWm4v?=
 =?utf-8?B?dGNIUWFmM0FvY1ZhaXNiN21Fbzd0MGpEdnc2S1Jqc0ZHMEl5NXpOd255RkRk?=
 =?utf-8?B?Z0lKVVhvUFR4YUs2ODFadldDZlplcUl4bzdnQm5GTzhxTWpLQlpUdlFHTVFt?=
 =?utf-8?Q?DdRTxljoIJcb75mDWqBTv9g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D157971B70B27A4FB3C1A30F40EB98F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ebcde5-284f-460a-9a63-08daadfc07c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 15:51:59.9672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V722hS5r5PEzX+15NNT3LGvnvxKTQg1cSzk4LyeTnHW121kjkCz3wSKEr/PoJEMX5BghGmPYpDDCETW6e7Jry8k+u6rWC4luRd3gwYM9PB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDEyOjA3ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gVGhhdCBeIHNob3VsZCBiZSBtb3ZlZCBpbnRvIHRoZSBjb21tZW50IGJlbG93DQoNCk9rLCBn
b29kIGlkZWEuIFRoYW5rcy4NCg==
