Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3901C41A43C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbhI1Ac1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 20:32:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:8949 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238236AbhI1Ac0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 20:32:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="221386916"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="221386916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 17:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="518782855"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2021 17:30:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 17:30:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 17:30:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 17:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8ReY5/P73anqhW/WnQqiBsOvx0QQYiZM6KIO7azvkChsCCZlkbqQ3YfflLE43gUqgBFo+nsZZd1XbOPjDPLcxjJCNt3zE1iSVauzaoufVcqnQaE3R0f5db1NUiKWAFP1amGwywFSvQb5FwTjQ6yFxmnpe11HYjBdCALjQ2g/0q+mWzs6o7y1jDxeASNoOzy9kmLCHOuxKs0jZ1MDFCydBCKzX52X2zxIiAa0FoSO4yKoI0fKSw3Ty7ZcT098IU3ubS4jm9ZBo691TYxAM/fE0NuMM42pLAvCryGYijm0r8gR16dV9XuMvHQTgBuVPfc0MPAplL2gi/tsS+OCCM2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=T5o45YlI77eVMb8CBI+uwkj93/84Q0UlmZOZI0wgVKs=;
 b=hN6QEucV3JEGviqFuDjHCMoBEzEKi69Uw5xAiSj8Fpwsy37z1XucJBDC5rWGWmsjp9sQDLhvYDsMXJnXEko9/KQmHKhjFjzwVOFtfshVhddkpA610lXkY/MbepLkz5iQigpERaz4y3psko7jJM2oAZb7yjody5JdfI4EOJDNBBm1KarLa4UbO+efSTaAmSoBafgs2gWei6quhsCNT/FhlCPtzA7K9l4SVDthQsFo2tGgbjoefUQr4DPwZhb/lnqu6sb8Sq703dszemg2vDNAOJj5EdFLu6A435GryRGDQBuA+7wHOGSFJn1dkPe686tgYSZF5RqQPfKTG+F6UwYtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5o45YlI77eVMb8CBI+uwkj93/84Q0UlmZOZI0wgVKs=;
 b=AUmQCUybcFY0aIgAmmpr++za31j8/buyXP4IyJ8IoRNku2uUmPfJr8lZL/dp4LM0dIgFb5g70hJdM5b+2u1F17P8b0q/k8Wy3u9SXhsCwOO0WehVje4LHWv/aQfG/96kPeZgXvjnacmZvspAsUx5YcEf0eX4bNwTJzJ3c2jPvDw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB2583.namprd11.prod.outlook.com (2603:10b6:a02:c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 00:30:44 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 00:30:44 +0000
Subject: Re: [RFC PATCH 07/13] x86/process/64: Add uintr task context switch
 support
To:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-8-sohil.mehta@intel.com> <877df6g603.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <10d23bbd-bc11-d5f4-4032-a814a8bd8dc1@intel.com>
Date:   Mon, 27 Sep 2021 17:30:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <877df6g603.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR02CA0058.namprd02.prod.outlook.com (2603:10b6:a03:54::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 00:30:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a70174d-c29d-4f62-a0d9-08d98217350a
X-MS-TrafficTypeDiagnostic: BYAPR11MB2583:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB2583CF49B359427EEE43AEC1E5A89@BYAPR11MB2583.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mzt9cFRPnSD/3kEuZTTabsr3OMsqG0LOSN4AJHM8sO793ZRGqq4l1AwvpsDDn+4F4lDdb0dCdzSJ8G7z+bBh1ZReibN/tKa+AflrrNxSsfz1PHbFTWcdReKOguQeyYPWMY+41lEPlwgtOywH/H2Z5pOzVkhuTHgtxqXLNvo4hG8jFvGXxvxaOxOuF1PB2ttBQu60AKlJc7wss5gmStfo4ulI1oEcHFeOsMm9hVr/bzCX2QYLa0RFiSfFi2HWFaNkrmE5Q8mQpTkwqi1ayQtFqPL11tqckzwvL0/yc3txovbvIyEXpxYv+w7tMi0hQLgN2LxKL8SK6SJr7gOxQxzpuQA6rHNZrgHvfRYTrZ+wDvdl5nLGEnN31VEv3/wAg2AloehoUARBrTJv8FDZqgDwRJyB/ylf1fhXOHtp+G6PtR7lrrejd+atKXmPWklaHP/K6eCugjdetITwOzy57KemsxQwRcRX1iT7/29rocf/urxllw9wM6BTlxhTaHMFoIkfoL6uwyGYpSu9AEPUIjuPhLXDJKqZnsCnVaH9V7c+uE2wxFnFc2uCeC+BKnaxssqGKv6bW9jRnmN5CFu0UbN2zP143EkHKyFK78ivhju3H6qH8tqm1oWDrLMLFEB4c++I0yRDwP8yj11j0139ZiICAhJ6V1CVXkbhotcrzgWT3uOGmR4IikYCxtjlMaGiSK6wNElPvZ71FjwoTXpbTyOcxYbmuURSm6zqQY5gQiL5lt6x7gla5/pnp8E8s2yhFckw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(6486002)(7416002)(38100700002)(66556008)(2906002)(4326008)(31686004)(86362001)(8936002)(8676002)(186003)(26005)(53546011)(5660300002)(316002)(36756003)(66946007)(44832011)(54906003)(508600001)(66476007)(956004)(83380400001)(2616005)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDk1ckE4WGFaSTlDRkMxMmkxUGh6MThZVkZpVnk2ci9IaWZ0RkRFbjF5bWlO?=
 =?utf-8?B?TnlXYUpremhqOU1qUWxVM2ZTckNUU01FQy9kT3lDd1Ztci9mSVRJc1VQaURP?=
 =?utf-8?B?aEQza3g3OWpHUHVPcUZtS0FFME9STFNVaWhzMlZXd253Wk5SUHQ5cDZYZytt?=
 =?utf-8?B?cU4reU92ejQ5RGo0MlBHK2hRTFdJaHB6cExjcmgyemUvd1hheTd0ZlJIb1pl?=
 =?utf-8?B?NjcrVFRlTkdpTkxwRHFnZmJOejAxeXgxYnBVYUJwR2Q1NHVWQjlsSkdPTFE1?=
 =?utf-8?B?TkpBbmptaFNNcjNvanh1WDFNdXhsTisxUjR4Z0tUOGVkaEYrSHd0aG1KK0NB?=
 =?utf-8?B?T1NpanJpd0tGUG9FTHgzSVg5d2hsNjlDZ3ZQZkdVa2dreDIycGF4Q1IzbVNM?=
 =?utf-8?B?LzlieTg4dmR3ZWpHZ2tiUmNmTkJ1ejRPRlV1QmkrVXE3dmFyRnBJOWxNa0Rl?=
 =?utf-8?B?OHhzeldVdmh3dXFMWSszaDVTaStsSFd1Zm5ndjJQRnNPMVpVUEZHaGhYb2o1?=
 =?utf-8?B?L3FIWmhKcndtV0xPY1BjU3ZKUm1KMU95T2pyTEtLdW1zampBU09wWkJlRk16?=
 =?utf-8?B?cWQvaUlDdkdmRGU0NXZ0SlFLSmVwVlNVa1Y0cmZySjNlcWRIcmRZZCt0VWR5?=
 =?utf-8?B?WWtkdUdCb2dCbWx0ZU9zaVpqV0RobEo1NU5jTzN3dXg5TXBsc0swK1FFSWFn?=
 =?utf-8?B?anRrNFg1dDlFbDFSYzAxb2I1L3puMTAyc1JzbGNwenErcmMyWFpxUFJWRkw3?=
 =?utf-8?B?U3laV1h0bXhTSU83YjNNaEtEcDFjck83enczM1VLaDY3T0RjK2dVa0l4MGMr?=
 =?utf-8?B?THRKRGczNWJib3cvUXo3WEFlTUMvdDlKTm51UFpJUmYxUzhBYXFvZUs5eHE3?=
 =?utf-8?B?UzIyZndVbHlmQ1JMdUUyNGxuLzFkaEJPbjRWelRLdUlDYmtjSnczdjQ3dUk4?=
 =?utf-8?B?N25FcGQ5dGNLNVJBU0R5K1VWcVVndVFsYzNrUXJIVnZ0VTd1TmFoUk9oQkF6?=
 =?utf-8?B?aVFVcXVQczhmRDBOYjQ0M3hwVy8yS1lnRWhnaS9QcU5ib21NVDh3U2NMRlNZ?=
 =?utf-8?B?SWtwRHQzNEZsN0FTaCtQMGRrNVNnOGJKUlJNcThCTm9rbG9hNzd3NzJQcUpE?=
 =?utf-8?B?bkQwaVYvak94QW5mc3lQbXBkbFQvRldVSUwxRlBOSjZqY3d2ZDY2S1VodkMv?=
 =?utf-8?B?b29kTnVSZ0RxZHBjYlVpeFdRbkVvS0U3WTRkNDdZRUtlNy8rVGlvTVFLekcv?=
 =?utf-8?B?ZjhpaWRWT29yWVZBWldGUkwveFplNXZIcmk4TytpbCtWQVZDbWlEdndPcmN6?=
 =?utf-8?B?S0RZQXFVSCtZdkt5N2RiUTdZNldTZmd0NTBVUm9LZjFSaWltcE5PaFFlWFZq?=
 =?utf-8?B?S3JNVnFjV2x4QjhKYTROM1lYN0xXTkU3VG1FVEhJRitzYm8vaUp0QStkMUNX?=
 =?utf-8?B?WjRZOXJvb25tYW4rSjRkWnhWcWM1M3hOd3FVUTRVQW1RRUxnc1NCU2oxYm5z?=
 =?utf-8?B?QkN4bk9VS3lqVGJCQ01oVVFyYzZTU05GbzB3cWxLTVZCTE1LemMvQnNRd2JI?=
 =?utf-8?B?VkhvZENkUlN2RXQ0WnpTbFhCTkhuVW03M3FLU2pvcTNZSXlndThPVEpoc3c5?=
 =?utf-8?B?ekhRdDRmUzZHN0xRaVdOOXdmWVJOb2VrclZLMXNZVGNTaGpGd0pJL214cUVs?=
 =?utf-8?B?MmgwczkwZWFMUEx2WnlRS0ZVcUNtTTJPUFFiNDBqVGxCSWJ2bnMrSkV5cWMr?=
 =?utf-8?Q?7dkfEVD463gadciIT80+dER9MlufG3d/AO/qZAg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a70174d-c29d-4f62-a0d9-08d98217350a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 00:30:43.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5MQZ/v117KKV9VsxCs7wcC3iG0Bn5fHutiVwi51cQrL52EX6EUsXlCwm5/ict+o2HgGsZcBHGLN/rXCS3eIuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2583
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 5:41 PM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>
>> User interrupt state is saved and restored using xstate supervisor
>> feature support. This includes the MSR state and the User Interrupt Flag
>> (UIF) value.
>>
>> During context switch update the UPID for a uintr task to reflect the
>> current state of the task; namely whether the task should receive
>> interrupt notifications and which cpu the task is currently running on.
>>
>> XSAVES clears the notification vector (UINV) in the MISC MSR to prevent
>> interrupts from being recognized in the UIRR MSR while the task is being
>> context switched. The UINV is restored back when the kernel does an
>> XRSTORS.
>>
>> However, this conflicts with the kernel's lazy restore optimization
>> which skips an XRSTORS if the kernel is scheduling the same user task
>> back and the underlying MSR state hasn't been modified. Special handling
>> is needed for a uintr task in the context switch path to keep using this
>> optimization.
> And this special handling is?


By special handling I meant programming the MSR when XRSTORS doesn't 
happen on return to userspace. The pseudo code you provided in patch 5 
comments handles this well.


>> + * cleared.
>>    */
>>   void save_fpregs_to_fpstate(struct fpu *fpu)
>>   {
>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>> index ec0d836a13b1..62b82137db9c 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -53,6 +53,7 @@
>>   #include <asm/xen/hypervisor.h>
>>   #include <asm/vdso.h>
>>   #include <asm/resctrl.h>
>> +#include <asm/uintr.h>
>>   #include <asm/unistd.h>
>>   #include <asm/fsgsbase.h>
>>   #ifdef CONFIG_IA32_EMULATION
>> @@ -565,6 +566,9 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>>   	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
>>   		     this_cpu_read(hardirq_stack_inuse));
>>   
>> +	if (static_cpu_has(X86_FEATURE_UINTR))
> cpu_feature_enabled() please.


I'll fix this and the other issues that you mentioned.

>> +		switch_uintr_prepare(prev_p);
>> +
>>   	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
>>   		switch_fpu_prepare(prev_fpu, cpu);
>>   
>> diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
>> index 2c6042a6840a..7a29888050ad 100644
>> --- a/arch/x86/kernel/uintr_core.c
>> +++ b/arch/x86/kernel/uintr_core.c
>> @@ -238,3 +238,78 @@ int do_uintr_register_handler(u64 handler)
>>   
>>   	return 0;
>>   }
>> +
>> +/* Suppress notifications since this task is being context switched out */
>> +void switch_uintr_prepare(struct task_struct *prev)
>> +{
>> +	struct uintr_upid *upid;
>> +
>> +	if (is_uintr_receiver(prev)) {
>> +		upid = prev->thread.ui_recv->upid_ctx->upid;
>> +		set_bit(UPID_SN, (unsigned long *)&upid->nc.status);
> Please add a comment why this needs to be a locked instruction.
>
>
Ok, will do.  The SN bit could be read concurrently on another CPU 
executing SENDUIPI.


> Of course this is invoked unconditionally when the CPU has
> X86_FEATURE_UINTR:
>
>> +	if (static_cpu_has(X86_FEATURE_UINTR))
>> +		switch_uintr_return();
> Why?
>
> If the sequence is:
>
>       syscall()
>       do_stuff()
>       return_to_user()
>
> then what on earth has modified that MSR state? Nothing at all, but you
> still run this code. What for?
>
>
The pseudo code in patch 5 covers this. I'll fix the code based on that.

Thanks,

Sohil


