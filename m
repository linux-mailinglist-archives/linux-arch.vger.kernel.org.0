Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510393E7CCF
	for <lists+linux-arch@lfdr.de>; Tue, 10 Aug 2021 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhHJPv0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Aug 2021 11:51:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:20427 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhHJPvZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Aug 2021 11:51:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="202112715"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="202112715"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 08:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="506186473"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2021 08:50:59 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 08:50:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 08:50:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 08:50:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 08:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njt0GHK5Y5fVKy43tnrT/mO4nc1iWpm0DAeMu6oIGuEE0a2ryc12HjvyGE9W0sk/ZqdryNoXyID30+ux6LKj1aZpLWodxEOYPLyCu6zUoM6LmSnn3UrvQLNt8Ck10ahbh1VBLrGFup6sBCugmMjq+A4z6knFpQSVd785iodvAaFv3VIsRp+AgNvnRa+Eq0oYdXe5XjflzVt6b0AvdSbUutxnMBrAyfpyqdOc9HSKEc1yMolOH1XVxUiZSqlSL9WOzG3KQ5/5jqCI1wkB7TaF6rDZIpK8RpbyTe2adBr+LzFyP9FVtZtWCx6Erwt2OU6JeFIc6OF/wvFDQdkW1i4fRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLp5GCM1rPPnq8P/vja4k16/G/Y2V2aRS6YUeRFgq9g=;
 b=Nee3bi/2rMs8R3zdvB7Up2t/jCJ3NV9FL0omeXCOEPKsbPxPP1G7bSM0fDiTx1zdy6xy8TKjhOIjStHgFW56w+tbx31OWEb9euC9VmtYjhQHB42lwC6rgXXhZSOWLh2Z5ZATVpSSW+CNb1JTkXtaz+3pMQK11aQkBOOfP6h/hCUmEj0sd/b4Y67Kf6nv2pSne5rcU1/S6CZqHeyDWhiDVvfMVlC7yYdNUmViod5KpR6/+vSBgA+NBdVVSY/vZF1Ub05byn7rxrjG62iZgiFqsUTTYBiMq7ajNLOk3UI19eDRaSlwzYBvWtYuQGBaHT0fOHWYxqWjzPqym4aa2CowUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLp5GCM1rPPnq8P/vja4k16/G/Y2V2aRS6YUeRFgq9g=;
 b=uUCIaxVirBGK1pSEYzKtLxTIHxHuBwc/n007H7N98Se8ei8yPByjr4najplOTc1qRFLMRq30nZlVjjty/ThLKjz+y07GJLpzp15g8yVCzhsuesUrNj4xe4zCZUEsj96ZB7TcSXoRSbcJGZ2r43aNL8B2Aouy8lLHmcxyy+0pPa4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM5PR11MB0026.namprd11.prod.outlook.com (2603:10b6:4:62::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Tue, 10 Aug 2021 15:50:52 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 15:50:52 +0000
Subject: Re: [PATCH v28 05/32] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-6-yu-cheng.yu@intel.com> <YRFb9eShKnKckDQp@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <0854cdc9-0329-18c5-8f81-e39b58955352@intel.com>
Date:   Tue, 10 Aug 2021 08:50:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <YRFb9eShKnKckDQp@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:300:4b::24) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Tue, 10 Aug 2021 15:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c37d9b8d-9633-4d59-b615-08d95c16a1f0
X-MS-TrafficTypeDiagnostic: DM5PR11MB0026:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB00269302D8EF746398EA08A6ABF79@DM5PR11MB0026.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmwlcHz7stHWrJHZFXmYRLfpq+/IbUYi66Z7JzHH5x+J6ixOfuo2Czrvh6nDc9awYFdFv+lce8AaFFlA0yaX9B7ppsVcF75LdwjHFT1inpFVlkWiq2Hx7WS1BImdfGNvH826l8M7UMVKfQcH9taJATMduy8pRNREHquYFUxqKyuwZNUANSxCieXoElM7xAkKuexOn2kX4WFyzNSi9a4sS2lFEeVaAIAHI7vQeQdy/tutNt2fexbjyExw/R/5kkrJszRc8qyPDBfepiyuQzFfiVVk6aBIURokGZiOiO0CmhIHQ4iMYfeS+qX8AWuuLJEZ3qYXn3SC5B2V53ZNx7PzE4bQoApgfvjBQXpFmHYfAiYHSJjKsVhh5RSNODTwudWFGo49oL0KY9WqBxdU/h88auF7wtB8smppyxbhXthbioQDRiMgg1m9nMrLQpLbsngxaix0IB9UHtG2Quj1/DldTecIniLA4SXrcefRixhA0xOGayZ/+7Eb2OK7S1S3kNMXXPZ4bfDcdLVlFJMCTu/J7e/I2zghJqUBRialrjjCcRkQuW7mdToXzGGaOb1QLVN4FQoOZGXbztDS+Z1hkCUWSf0TnTDSlgrZ6zPqXCfWYqP2hgNzHQHKEel0QUupkFQ1DtKc1H3RvF+8hxiVahvT39Fy5f0dq716ySqAltdmSku6nHEgqG8pBCudGB1tYzj7cHZaakdV83eDaHKCrzOGlIuMGI68GQWN4igUTamckpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(956004)(2616005)(86362001)(186003)(38100700002)(26005)(36756003)(4326008)(66556008)(66946007)(53546011)(83380400001)(66476007)(5660300002)(31686004)(8936002)(2906002)(478600001)(54906003)(31696002)(6486002)(8676002)(16576012)(6916009)(7416002)(6666004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNORk9KV1JRNjY3V1VuaG9YNmxhTlVzSUM4V2NPRHJiZ2Voam1vVTQxN2sv?=
 =?utf-8?B?K1BDdHRtOVJ6ekRNamRTOFY2VmhhWnFoU2xvajZ6M1ZBZ2JwKzlvOER4ZER2?=
 =?utf-8?B?amk3ZDFLK291cVY2MHA5aUMvLzYzOUdsM3lsS2grUUJFNjhMcEtuZE1xWEdk?=
 =?utf-8?B?VjkrZVM5ODVVSFNkb2c3Q0MrMEswN24rVzNyN0JUbERHVlltOGNSUjdLVVJm?=
 =?utf-8?B?QWV4eHpoeG5CY3RDWUo3VW5GdjVsamQ2TXMvSWt0dnBnUy82aGVUdE9yUSsr?=
 =?utf-8?B?dVNQQlA5aFJNR2RycllLNHNDcEdreFZVQlpLbWRPaXZDL24wR2NTNE1kME9L?=
 =?utf-8?B?Z1luUmpuM0VCUlJEZndIL01WaEtod3Ixdnk1bjBBWHpOUXE1V0thRjdRd3lx?=
 =?utf-8?B?YVdzL29KRi9YRWpFYmtPTFFHZTVoTTIrOWcrbDlVTmFNWG9KSjkwaWowWVVC?=
 =?utf-8?B?ckxMMnhJQ2E1Z1crWFREV20wSUYyMU9LTXBHUmNkZURROHJ5ckRtSmVsc0RQ?=
 =?utf-8?B?K21HRm1XQzBETCt5UWJYM1RBZ2dlNVhWdWVyQkRRdGxVS0haYlN3bWNGMTBT?=
 =?utf-8?B?bW1RMTJZdjR2YnBvWEFsTWZWU3R6NWloK2NRb0lzcitjcnVqRlhzOUJVYnVo?=
 =?utf-8?B?UzkzYW52UmE0VW1aVk5PQUFjRzdzVy9ScWxaK2dNT3l3UTJydjFBNHhPbDQ2?=
 =?utf-8?B?MHhUY0JLMG9pRnpRYWRZY05PQVhmemg2UVlQbHNTdFVGYWlPZDZTN1Qwa1h5?=
 =?utf-8?B?Z012aUxuZ21lQXhPL0dHS1k5cWxnSFJ0UjZmREF5V1ljQVNoT093WEZ0UFFs?=
 =?utf-8?B?YjlQMy85Y25EaXVPcUhidXJIL1U5UW83djRDM0NRdzVoUXNkV1I2WHdiOUt0?=
 =?utf-8?B?VUUxOG9pWVU1YXpqWExJK292UmdMOVVXd2oramFLcVQxeTBkUHc2c2o4ekps?=
 =?utf-8?B?azZITDZkbEFxSWgycFFkZFVpRStla3JTbHhJWWhPLyszaHFSR0dsTG5ZUWJl?=
 =?utf-8?B?ZSt2bm5SVlJYOEVoUFhwaE5URjAvWi9xblpEYktxWkhhMWdxWlNIdXpMejVH?=
 =?utf-8?B?OXFlcnhGVnlWWDJCOWd1QnZWbnR2bkc2Wk5IV1FyMm11Nnh1RGtwclp2Wk1p?=
 =?utf-8?B?R1p1QW82N3hBQzZETys3ajF4Y09YcVpMS1ZWcWxmZTRFTlJqOTFBdWdaZ29Z?=
 =?utf-8?B?YUdhU2FIYlBxdk9POTBmRm0xdmF6V0hqdkJOQUFPN0NDMmZycmcxSjNzWGZX?=
 =?utf-8?B?M0dnT3k5QkIwQU5pREdNeEttNnNENm9rV2g2cjA3cW4xL0pVS3FBOFVzM0Zz?=
 =?utf-8?B?MzN3U21FUjdqSGhXYmg1WS90cmJtT2tEekFwRDUwaFVwcHJHbkp2NVBFWlRu?=
 =?utf-8?B?RFk3WjJVekIzVnBXUVFQeEpiYmtCZ2Rra2Y2VTdXaGkwRXg3Mk9QWkFSMnQy?=
 =?utf-8?B?SHNqcmRwQ1QxRVY1SDVxdzZ0bEp2anVoY0NpRy8yc2dSZ1lwRkNRRnhERmNP?=
 =?utf-8?B?d2xjNU5FRE1NOHIwNjZHcmtReCtjbU1QeTF2eUtDY21lTWxnMkQ4elhIdjMr?=
 =?utf-8?B?QkR1VGwzVjVYK0J3V1RZMkVUZUhOdzI3cTdweTlsOThZOWx3bUJrZ3BaU3VC?=
 =?utf-8?B?VFBvaUFQS0txUDc3ckNERWFrZDRMWWhGUWdKbUN3dFJ6SlN1K1lsRzI4aEJ2?=
 =?utf-8?B?OWhmNmZCN1RwbnplY3lkVUtXTUdZVkdacWI3QnFva2xDVklCcDh6Qk94d0py?=
 =?utf-8?Q?LRQGxQYZvWpJJH4JZ7jr/agMANCh+9yeqjqorZz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c37d9b8d-9633-4d59-b615-08d95c16a1f0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 15:50:52.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku4EwOlXwmu8erbuFsbIptHC5xBjpx0zsbsslLmY9s9XFDhh5IorC+kkyMoQPmHWFCGZwp5SDi5NA65n9o33mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0026
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/9/2021 9:46 AM, Borislav Petkov wrote:
> On Thu, Jul 22, 2021 at 01:51:52PM -0700, Yu-cheng Yu wrote:
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index a7c413432b33..b529f42ddaae 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -939,4 +939,23 @@
>>   #define MSR_VM_IGNNE                    0xc0010115
>>   #define MSR_VM_HSAVE_PA                 0xc0010117
>>   
>> +/* Control-flow Enforcement Technology MSRs */
>> +#define MSR_IA32_U_CET		0x000006a0 /* user mode cet setting */
>> +#define MSR_IA32_S_CET		0x000006a2 /* kernel mode cet setting */
>> +#define CET_SHSTK_EN		BIT_ULL(0)
>> +#define CET_WRSS_EN		BIT_ULL(1)
>> +#define CET_ENDBR_EN		BIT_ULL(2)
>> +#define CET_LEG_IW_EN		BIT_ULL(3)
>> +#define CET_NO_TRACK_EN		BIT_ULL(4)
>> +#define CET_SUPPRESS_DISABLE	BIT_ULL(5)
>> +#define CET_RESERVED		(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
>> +#define CET_SUPPRESS		BIT_ULL(10)
>> +#define CET_WAIT_ENDBR		BIT_ULL(11)
>> +
>> +#define MSR_IA32_PL0_SSP	0x000006a4 /* kernel shadow stack pointer */
>> +#define MSR_IA32_PL1_SSP	0x000006a5 /* ring-1 shadow stack pointer */
>> +#define MSR_IA32_PL2_SSP	0x000006a6 /* ring-2 shadow stack pointer */
>> +#define MSR_IA32_PL3_SSP	0x000006a7 /* user shadow stack pointer */
>> +#define MSR_IA32_INT_SSP_TAB	0x000006a8 /* exception shadow stack table */
>> +
>>   #endif /* _ASM_X86_MSR_INDEX_H */
> 
> Merge the following hunk ontop of yours pls:
> 

I will do that.

Yu-cheng

> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index b529f42ddaae..14ce136bcfa8 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -362,6 +362,26 @@
>   
>   
>   #define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
> +
> +/* Control-flow Enforcement Technology MSRs */
> +#define MSR_IA32_U_CET			0x000006a0 /* user mode cet setting */
> +#define MSR_IA32_S_CET			0x000006a2 /* kernel mode cet setting */
> +#define CET_SHSTK_EN			BIT_ULL(0)
> +#define CET_WRSS_EN			BIT_ULL(1)
> +#define CET_ENDBR_EN			BIT_ULL(2)
> +#define CET_LEG_IW_EN			BIT_ULL(3)
> +#define CET_NO_TRACK_EN			BIT_ULL(4)
> +#define CET_SUPPRESS_DISABLE		BIT_ULL(5)
> +#define CET_RESERVED			(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
> +#define CET_SUPPRESS			BIT_ULL(10)
> +#define CET_WAIT_ENDBR			BIT_ULL(11)
> +
> +#define MSR_IA32_PL0_SSP		0x000006a4 /* kernel shadow stack pointer */
> +#define MSR_IA32_PL1_SSP		0x000006a5 /* ring-1 shadow stack pointer */
> +#define MSR_IA32_PL2_SSP		0x000006a6 /* ring-2 shadow stack pointer */
> +#define MSR_IA32_PL3_SSP		0x000006a7 /* user shadow stack pointer */
> +#define MSR_IA32_INT_SSP_TAB		0x000006a8 /* exception shadow stack table */
> +
>   #define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
>   #define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
>   
> @@ -939,23 +959,4 @@
>   #define MSR_VM_IGNNE                    0xc0010115
>   #define MSR_VM_HSAVE_PA                 0xc0010117
>   
> -/* Control-flow Enforcement Technology MSRs */
> -#define MSR_IA32_U_CET		0x000006a0 /* user mode cet setting */
> -#define MSR_IA32_S_CET		0x000006a2 /* kernel mode cet setting */
> -#define CET_SHSTK_EN		BIT_ULL(0)
> -#define CET_WRSS_EN		BIT_ULL(1)
> -#define CET_ENDBR_EN		BIT_ULL(2)
> -#define CET_LEG_IW_EN		BIT_ULL(3)
> -#define CET_NO_TRACK_EN		BIT_ULL(4)
> -#define CET_SUPPRESS_DISABLE	BIT_ULL(5)
> -#define CET_RESERVED		(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
> -#define CET_SUPPRESS		BIT_ULL(10)
> -#define CET_WAIT_ENDBR		BIT_ULL(11)
> -
> -#define MSR_IA32_PL0_SSP	0x000006a4 /* kernel shadow stack pointer */
> -#define MSR_IA32_PL1_SSP	0x000006a5 /* ring-1 shadow stack pointer */
> -#define MSR_IA32_PL2_SSP	0x000006a6 /* ring-2 shadow stack pointer */
> -#define MSR_IA32_PL3_SSP	0x000006a7 /* user shadow stack pointer */
> -#define MSR_IA32_INT_SSP_TAB	0x000006a8 /* exception shadow stack table */
> -
>   #endif /* _ASM_X86_MSR_INDEX_H */
> 
> 

