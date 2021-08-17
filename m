Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EAF3EF1E1
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhHQSe1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 14:34:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:63439 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhHQSe0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Aug 2021 14:34:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215893591"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="215893591"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 11:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="676612472"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2021 11:33:44 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 17 Aug 2021 11:33:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 17 Aug 2021 11:33:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 17 Aug 2021 11:33:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 17 Aug 2021 11:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkcyyC6jfDcJAgYQ4YW2RmEbKhRx5LfYLk2lGKlbud3+Dj1u52CQGCPnJw0UaytyRTbl4njJASc5TYB3pfxDVZw//H6vdXT3vN3wzMyt2I6hP0sgFTLfrNhnepVcJ6zcb4Eslbf/R9R80SbK3+1aaIr3+BscucIjLeW/1YNE1qNThDwM0xZsjAoXt+FzQ5/dy+WKq5GMkXiqS9zwzNcVaNBN4n7bQgf5QK+HHyEuCtaHJd4gobMG4CoxwoC9cYjBlPjwaAZDCwFWpj6z6PtF8Ats+KVWKYfHu0MavGlEpBA9RAi1rwmDQAXC+GzQpryGxXuFKY0USMhReZLaH7eI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgGIE5oN3BQfU7dbcEcy8KEj0DZiPwjHlz0jJHggLvg=;
 b=CrYVqX9J+nw/yAux8ZjwPMPNZ+SBtJNQAZYVl7r+Km5lX1lz9Vxtr77VD7MGb4wfLpudy3IlT5fduPhbndrHxAoo0xL6xctlRpeqbjq3W7bVCMqZdNJI47hA47qSyI3dRIxkglA2tf1vUUhsU0IH6XUiyqMJCU3m/2s6WHgJV4WH5pja/zB6YL1SLSfUs3hlUOHFRrXrcmpQcORmWnhJJMSHt9EtluRKKpdPXdJvM9frNIlzfKUQoi6RQEZ1bVq4SCCjPeFLd5gr+oJgxnMRD5kt6WdhmoOtGyEyzzl+z62PfjrAmZzdZGFp/MgpdGOV/SjLmnIPeCqaqzjHDulZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgGIE5oN3BQfU7dbcEcy8KEj0DZiPwjHlz0jJHggLvg=;
 b=t8eoiSvqqVmzQyewgqQ6PCfA1PHfMRJpHQDCGy5wW3WjxEMNxcCBkmMvFJJnIBM8kVdlekIg2oiqIP7XWFdBZNwDt/tmGOzXIEFP/NazvbMjkjm6Ao6ZJp8ZyJR4q5tjU0ZiA89FYLaFoaM9Rm6apoxmaJkP3+JW2PVf7FdiR7A=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB3580.namprd11.prod.outlook.com (2603:10b6:5:138::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14; Tue, 17 Aug 2021 18:33:34 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%3]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:33:34 +0000
Subject: Re: [PATCH v28 12/32] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-13-yu-cheng.yu@intel.com> <YRqL4QyYPaCXSmi+@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <e0da31b8-418f-ce48-bb03-d7c325e2615b@intel.com>
Date:   Tue, 17 Aug 2021 11:33:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <YRqL4QyYPaCXSmi+@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0069.namprd14.prod.outlook.com
 (2603:10b6:300:81::31) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MWHPR14CA0069.namprd14.prod.outlook.com (2603:10b6:300:81::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Tue, 17 Aug 2021 18:33:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dd98a43-193f-47d9-ebb4-08d961ad8534
X-MS-TrafficTypeDiagnostic: DM6PR11MB3580:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3580F4448F6D27AB4EA6393DABFE9@DM6PR11MB3580.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: as+2loOde+15PXnlRMibNU16NatNUaAX0nJ5MIGghBkoojNUY77IiV/CpolIe1nx5CbiJbL19B1pKGbIS30xC/VQw1hPJK34ty9JS6rCrkj5wbwWNbyyjQTnIPMGYj+mrfFpgZEdJDO7MRhPEPWLOEhopRKJ0SFJV+L0/47KJNcacE5G6jrTS6wMBDvGO9p/vcvcZyIc7MSnp9w88MC78AxMu+EjCzBxU9DBhFv5HTRL5m3RgKi4Ws0/1velmc8/nX+seMx7EplFhCVCS8qNOC3DLFOY+BMNAwJcMYIPbgMGnAYBCUBKA0ckXvRq1lZnulzRUnWmVcN9rbMmoX2A4a1ADFEZMwWUI5LKODmeQeg4Gqdi1YCwPffRnwy2T5/7RLUT8P8FBnUlTB4iX+SKg/VgAFMnnab4ucfhFVCONPrVZTPM1wqU10MCIfoi84qTFDrUDXHdnvvPktYuldof7YAe/4PF0ixfw1eJ1XZhCa1i4R75W1osOjHil5uIBny2WsjMg7fUPm0pokkPbY8OQysElGauvsqZQEePLDTysX7zVitkjJUOVti/uHfDwM3rmdA6J6RqdmEDbYdEPGQ7lruzI6CSVxwLIusqHFFUaxbwOQ4w2db46d1Ji5t0qcjeqq6Y8SaTgcisVT60uugRXGz0ShxcvvsogFJty2P6ectsv6wZAADHK8//mmPbVFOQVKUaLpcRwidRll55VsJ0tacWHJnUWXbXwjZzrjr/EsmTo8ziBhQUVbiXoq5TOoFb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(2906002)(83380400001)(478600001)(38100700002)(6486002)(53546011)(15650500001)(8676002)(956004)(8936002)(54906003)(5660300002)(6666004)(26005)(7416002)(6916009)(86362001)(31696002)(66476007)(316002)(66556008)(66946007)(4326008)(2616005)(16576012)(36756003)(31686004)(186003)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGFRRFYxWDhyakRkR1RFd2JCYkFyajRJbnVGeWpXT1ZKYk5BK3VPVkNkdUNG?=
 =?utf-8?B?cmE5QnpmdndlQ0FaR3NaWFJFSFZ2ekNaMGkrRjF0cXFBekM2dURYREUvbmFK?=
 =?utf-8?B?WnBCZEZ6UVMwYXJ1LzBKd3FncUNZTzFpeE11MVpZR2taSm54WUMwTVFFbXg3?=
 =?utf-8?B?SXg0ZVZFT2xjbFF1R3pMVmZ1aFc4UzFBWXNKWS9OWWQvSGx6M28zODlvTFdH?=
 =?utf-8?B?WFNuQUtOeGhTbS9ZSGtsdG9tZTBEZE0yT0xNNkU3d0NZRURSZUkyc05iVC8x?=
 =?utf-8?B?OTRCNVFQcW44WE5Ubm1QQyt1TW03cE1aa1RmNnFvaitjYTJuay9jeDBudXBs?=
 =?utf-8?B?SU4vLzNlUjNCWnZoK1VnQ3RnNlhuRDFMSkgyV3NmZndPZ0pBaVZrTjlmaGVD?=
 =?utf-8?B?cWUwRVBHTENocUF1bnpCejhHNkdjM2ZCU2t1NWJXZng2UUZJRjRPazVTU1F2?=
 =?utf-8?B?V3dGR0h1cUx6S3RXblZSMVBTeWhWMG1IMHNWRUs4NWZIc3lUSWlWVk1URVYy?=
 =?utf-8?B?Ri9YZEkvRTJXQWtzTnZ1MEFOb0E1ZFFyQnZoajZJWWl4TG96VjJnZTRKSkZk?=
 =?utf-8?B?QzJFNE5UWUhpclY1R3d2VjNvQkZyZUxDMjlOY2hJNmJ1di9DRXpDcUNKU0tH?=
 =?utf-8?B?VThLdVo4NkFWanQyamZnM1N1ekhtbkc2Z010MHFUMTF1ODgrZ1FCYUxWQjh2?=
 =?utf-8?B?Y1AraGMyNFVjRW1QUWFxZ3BtZXYxUE1lQjdCTkpyOWl0MUhwcEF0VU1Jb1Yy?=
 =?utf-8?B?SWtIV2Q0M21ZblpFTElDeUhXRTI5RlEvS1pGQ3FrR1VMMCt2OElvVHpGaE1i?=
 =?utf-8?B?R3M3U0djL2dzbHIxUitoci9qRmtIRjF4N3dpMHB2ZEhnMzhQRHlnVlZPT1Nl?=
 =?utf-8?B?L0ZiNmk2UUtFMTh2WVhlNzhvNm5QNURwb3RyLytkN2FyN2RzK1pka29KYVYy?=
 =?utf-8?B?SjlFRzJEUzRtZUlXa1BmdUxlOUgxU1dJamsxNzYreVRZUFRRc3F5TjU4MzdN?=
 =?utf-8?B?OFl5dCs2ZkpMdnBGMmp1Y1JrWFAyZ2NIUlR6bkhOV2JmQTR3ODBuSE9EYjdk?=
 =?utf-8?B?RVAvMkxnb1VtWkZtSzYyYnhiTk1WK2xYSVFLekNNc2dSNXBNOUVHTW01NGZp?=
 =?utf-8?B?K0huNUIwbWJnUFRVYU1IODJ2d0N1bzc0R09WQlNsclNLS2hWSWtpY0VtaHJN?=
 =?utf-8?B?T3pBYUN3Q1EzRTJnRmJBQ2Z3WFEyOCs3Rzg4YUdsTmhLenJyRjIwa2ZNZjZY?=
 =?utf-8?B?VURJOUcrZUVBYWRaRnBzMUNlZjViNU9GRVlIUTRubjlZb3pud2RlNUhrNFRP?=
 =?utf-8?B?Ni9OTzN1ckZWVVZlSnRBUlB1VEN5RzJOdEhJODB5VVpjY0ZOTUxJZXV6MCtv?=
 =?utf-8?B?Rk1YRkFlRWxwN0pIZzZvTGg5RlExckhmNFR2K2xnQnBRay9nbk1pVmZEclRz?=
 =?utf-8?B?NmZRbmg4VkhZVUtwUm5naE1MQ1QwSjJHc1JmU3JDa0xXaUVlV050Q1pRbnRT?=
 =?utf-8?B?V09WMGR4N1lPZ1lGSGluN2NkTXYwSFpoMVVtdzFPRXV3d3VpOTUrREVHMms1?=
 =?utf-8?B?bEJwaXNZc1Zkdnk5WjFRNWNvODNvR0pmUk1WRWpvUCtKanRmdUltTkRNbVNw?=
 =?utf-8?B?TFhMMm9UeXBCcGpxYkRXMGxEVG9lN1VYaURRSG1oMlg3eVJCaE1ZQVRkd0tH?=
 =?utf-8?B?Ky9tdkEwUzg2UnJaY2FpWmRpZGNyZkk2ZTJXTDkwVm8zR21NYWJhNU5KM20r?=
 =?utf-8?Q?80ODgJNMdy3w16Ik+C5uBju0rOvMekcLJk9HPGi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd98a43-193f-47d9-ebb4-08d961ad8534
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:33:34.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy3S0REKDlI+dlF97LmQUjNCV0tS8lpzcMfgaGDW7xXKHa/RvE2y9RJamgzuMjdm3KF4OVhBEvJpqQi0tM41DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3580
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/16/2021 9:01 AM, Borislav Petkov wrote:
> On Thu, Jul 22, 2021 at 01:51:59PM -0700, Yu-cheng Yu wrote:
>> When Shadow Stack is introduced, [R/O + _PAGE_DIRTY] PTE is reserved for
>> shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].
>>
>> When a PTE goes from [R/W + _PAGE_DIRTY] to [R/O + _PAGE_COW], it could
>> become a transient shadow stack PTE in two cases:
>>
>> The first case is that some processors can start a write but end up seeing
>> a read-only PTE by the time they get to the Dirty bit, creating a transient
>> shadow stack PTE.  However, this will not occur on processors supporting
>> Shadow Stack, and a TLB flush is not necessary.
>>
>> The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
>> atomically, a transient shadow stack PTE can be created as a result.
>> Thus, prevent that with cmpxchg.
>>
>> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
>> insights to the issue.  Jann Horn provided the cmpxchg solution.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> ---
>>   arch/x86/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index cf7316e968df..df4ce715560a 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1278,6 +1278,24 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>>   static inline void ptep_set_wrprotect(struct mm_struct *mm,
>>   				      unsigned long addr, pte_t *ptep)
>>   {
>> +	/*
>> +	 * If Shadow Stack is enabled, pte_wrprotect() moves _PAGE_DIRTY
>> +	 * to _PAGE_COW (see comments at pte_wrprotect()).
>> +	 * When a thread reads a RW=1, Dirty=0 PTE and before changing it
>> +	 * to RW=0, Dirty=0, another thread could have written to the page
>> +	 * and the PTE is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
>> +	 * PTE changes and update old_pte, then try again.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pte_t old_pte, new_pte;
>> +
>> +		old_pte = READ_ONCE(*ptep);
>> +		do {
>> +			new_pte = pte_wrprotect(old_pte);
>> +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
>> +
>> +		return;
>> +	}
>>   	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
>>   }
>>   
>> @@ -1322,6 +1340,24 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
>>   static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>>   				      unsigned long addr, pmd_t *pmdp)
>>   {
>> +	/*
>> +	 * If Shadow Stack is enabled, pmd_wrprotect() moves _PAGE_DIRTY
>> +	 * to _PAGE_COW (see comments at pmd_wrprotect()).
>> +	 * When a thread reads a RW=1, Dirty=0 PMD and before changing it
>> +	 * to RW=0, Dirty=0, another thread could have written to the page
>> +	 * and the PMD is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
>> +	 * PMD changes and update old_pmd, then try again.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pmd_t old_pmd, new_pmd;
>> +
>> +		old_pmd = READ_ONCE(*pmdp);
>> +		do {
>> +			new_pmd = pmd_wrprotect(old_pmd);
>> +		} while (!try_cmpxchg((pmdval_t *)pmdp, (pmdval_t *)&old_pmd, pmd_val(new_pmd)));
> 
> Why is that try_cmpxchg() call doing casting to its operands instead of
> like the pte one above?
> 
> I.e., why aren't you doing here the same thing as above:
> 
> 		...
> 		} while (!try_cmpxchg(&pmdp->pmd, &old_pmd.pmd, new_pmd.pmd));
> 
> ?

If !(CONFIG_PGTABLE_LEVELS > 2), we don't have pmd_t.pmd.

> 
> Thx.
>
