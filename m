Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29D868FBA6
	for <lists+linux-arch@lfdr.de>; Thu,  9 Feb 2023 00:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBHXxh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Feb 2023 18:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBHXxg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2023 18:53:36 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA11E5FE;
        Wed,  8 Feb 2023 15:53:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/f/nBCGqTQYORK3ORAGsfZM0i6NAkm2+vOaBV2f5kyfuQn3VNwxKzinUQ67ZrQVVAvjXzHAllpbpExlDP1tyAxA8N/mt8j5n7uAReR+QUHR6wb4lMIkstbltjX7sYdVpzw347BZJMcmq6VyIt6oZumbOLJ0d5zoBbwCLTqgS7IibPTM0+PIK6dO2+UNJHPawPWUYQmZa0JHpEi8STZ5lTJzPad476sJcCybyBg4K3QFwk1FMqSrgHQTT66eHXLCs9LIPDN+e4Ho2wLgIWkisC3+MmHTGMOQEyg6estd+fHGGqVg4OfYKkYQG6KLtvwiQEJE+hSe8lLm2Y0RXciyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbRZtOE5rVJtEkOevHhJ0PclJIjbS/3bUfNCWt9KmMs=;
 b=ha/ZubTOqv+mW16ru1GnRc3G1jLCd2oh6O9dweylMovAClB8FpWabRXkuJ6rVz1ghxmroy3nrfQCYY1ldU/HG5d5mKorv3Q17iIuIUzi8Mc0mECaS5AM3JzZFuSS2D/6YB+iDMfgu64jGasKVdYnisLyn4jYFsrT2JL0c6J1OtwaTn4BlUbkHoRE4SWqTmscGRz1mudPv47WnqwzB4Oro9DTGGIdTa1ArcJbMn8KEWwzMGD+qWyn0QCubW6fO5rd990r3AYAHs5Ph62pgZiaKFailI2N5J0/PMjL++onXITOOX0Kg2mqsQvVhDXGVoFFfEn8iWe3s7DJh7ygwsEA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbRZtOE5rVJtEkOevHhJ0PclJIjbS/3bUfNCWt9KmMs=;
 b=NK4gMK3UU86CUYwuwr34jcpZP0EBLvgFT0y6T9bnehim5C2dwbKmnLeCIMXrV3U5sjL8M8pAM5UJj1qCw2gBTQd7yGPBfjuBCkwmS13x9dFbJZBRwg60nrHWfGuJI65rJCKaFJIvxETPMXWgzlGRxNjuDswmecLH1K4ncuUln5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 23:53:26 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::dc5d:6248:1c13:4a3]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::dc5d:6248:1c13:4a3%7]) with mapi id 15.20.6064.029; Wed, 8 Feb 2023
 23:53:26 +0000
Message-ID: <29220594-6f45-d85a-c46d-7259df304a98@amd.com>
Date:   Wed, 8 Feb 2023 17:53:15 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH V3 16/16] x86/sev: Fix interrupt exit code paths from
 #HV exception
Content-Language: en-US
To:     Zhi Wang <zhi.wang.linux@gmail.com>,
        Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-17-ltykernel@gmail.com>
 <20230203012028.00005ff3@gmail.com>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20230203012028.00005ff3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::8) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 3070863b-37c1-41a9-0dad-08db0a2fab9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJZghfqXMdQM9deWMq8BD708W2ndS3Sz5Lv+In4CZjyju4yYqd9kXv7WI71x8Fu/wS5+qXh0UubIKptppQai8hyYeu1M8cUeBPvDWO+0r9F+MpTPLcIJJo6nDk+HoET57KkotXvdNvmANLDtW5iUAz2AGZF+xDrL8E35o6CRJjPy59Ai+OWR57DZTRvJMION/ICUJIdJPW82R6h5UzrYQF7iEOdyF8UH7RS4BsMuBdLkMMmDumJIHVZ81AUyDyTQ4+KCf0+NePLolEyJNhXC2nwfkm0FQ+Sbmb2Ny+grf6avzM1PEEWVdqvYAGXmXzU8p3sfTgTCKDeStaHbm8t6qEqmp1LJsP3b9WRWKaXwJ2oW5if2nrTW2WPvSNLvxO1W6BRqpIef7JwIoIEwb3/08STO8IieqBJD+IvdBJ3UQV6yklxOuk3mQUo/QjORb1889+F3YHCxsR8UyVrXtpxRDPAmopt7ZPOMQjXvXUAzZeVWw2lea+VkDLDmjqNF5J0rfE6oB4fPFqXw82kRoMCwN4xUhu1zd0lHAGEWYBHNt58R/i85+PffLjrDxt1dVCIfvYiDeWM5hX5nlJIhvcz7tsLYKXLmJtUCjpSNuQX2R9jBmLTSjPRmg/O/LAKhavJ4URND+vxwigDWYWc1LDSaX3ptKuIxJ0vn2ZAv3KtQre0HUMpx8Usm3OJtwIYQAnwvb3eINnHJBePq/PIZnJ7oUMyQGMyB9khIjdEL7mxenJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199018)(41300700001)(66556008)(26005)(38100700002)(53546011)(316002)(186003)(6506007)(110136005)(6486002)(36756003)(478600001)(31696002)(6666004)(86362001)(6512007)(2616005)(8676002)(66476007)(4326008)(8936002)(5660300002)(7406005)(7416002)(31686004)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFKQnVPR2svUmk2NG4veHI5Wk5rODk1S2hOQUJrdjdPYXcrL3RucVlCY3ly?=
 =?utf-8?B?aER3UHFzOHhJMlc3SHZmSXB4TjZ4VHJUVk1xVnMrcE5mUlA2cEJXRnVMUXhn?=
 =?utf-8?B?TTlKOHNmdExZT0VsTFQ0ODZ5dnMvZVBsOWhsZmw5TmpmWWFqR1R2ODZ6SUMy?=
 =?utf-8?B?d3IwcmVQbStIVGx5eGhzSGVVaFhMRVpQQ29obWVrTEdwcHdoQnR0eE02aTBN?=
 =?utf-8?B?VlJPSklkdU56UjQ5TVZQRGVRVVcraTBCMUNvenpqa0JxeHg2Y3VBNWhsYVd5?=
 =?utf-8?B?WHN6alJsMEdXNlZVZUlYMlE4UmdPcXE1M0VyWVZ2MmZaeU40dDZJR1Rrdkgz?=
 =?utf-8?B?N3BsdWpzVnpXY1pGbnpSaG9keUpIM3ZLS3dnczR5bmdCbmpMdWNObmVEWGdt?=
 =?utf-8?B?ckFaOFk5WGdJSlpRUTA3YUhuazdFdXE0S3Qvajl4c0h3QWVHRmhnWVlzQWkz?=
 =?utf-8?B?MlNzRjFEdkdIeVZaN2l2aVBJZ3pqQjRkLzFJa3lMM2kzdFRrRDZwNm5HNXFP?=
 =?utf-8?B?d1F5Y1ZRNzJEdEd1aDRGU3dnandVdlZ0NHZDVEpvMHNGcnFnWGNQZnl4cElR?=
 =?utf-8?B?dzZ5ekRzS3dqUDlRcXJueWcyZURqVXdwSUFSc1d5dmhKc3p6YVpEZHNBeEZm?=
 =?utf-8?B?T2F4THZOV3EwVEZNNjBWN2dvYUprYlMxWmFGUmdYRmx0M1JZQXdDbE53UzdR?=
 =?utf-8?B?d0h3SkkvMU4yWVF1Tlo4aTVrRm5PZEluQlR4WG5TVmF1RlF0dWlJdWUrQjl1?=
 =?utf-8?B?OGpQYldMQWlpNlVOZ2IyRWxNaytkbXBwYUhDQW8vVjRXeEhCdDlCRDRZa2NB?=
 =?utf-8?B?TzFyZ1pvYVlFTXl0cXhCbVlPZVJsLzRNbUJXRXpKL1RjazFobEpLSEZRVkda?=
 =?utf-8?B?SjEyb0F6eHJ1andvVXFGMFNSTjZwWlBxOHdNRFJ3eEt4dDlVeitYY2s5MSsw?=
 =?utf-8?B?NDM4R2Q3LzgxV0RKeXRVdkJIeWt3bXpYTi94ZC81d01oRURidXF0YzcvV2RG?=
 =?utf-8?B?cnowWU1Wc1lLdVJ1cnVIdHoxV3JzUXRnVittZUJrbjU2ZnVVd1prTVd6cGVN?=
 =?utf-8?B?eWVGdHB4ZlJWampSdllBYVZYai9TOW8xdzFPTWczRUZuR0NnY2hsTDNYVWQr?=
 =?utf-8?B?STNYVWNTMHlZeStXdEp5ME1hT2grL3RlNTdWa083dC9yY0xvWjVpeFEzcW9l?=
 =?utf-8?B?NmhPTmdHVTg3NHhQcXRlTldISTg2T2ZQTjJCQ0E3V3h2S3ZhWWZNZ0lENDk1?=
 =?utf-8?B?Q1B4MzhVby9wQU9YaUxoZzI4cFExUEVMSjBNUUtTVVlNaUlWdDkydXRtZGpo?=
 =?utf-8?B?Nm5NNk9DTm9ZV1FEc3pLb1MzenplNmhIRjd3UlhUV3NTYzF4MGdFVWFsK2tQ?=
 =?utf-8?B?a25rdGxhUjd5VERtaVFNRElDKzdvdElGdk03bGk2bUNTMmEyWUFuZmRXbUd4?=
 =?utf-8?B?eVNXLzF2R0NnNWx1VGhOSitZWWRCc0lpWERTZmc0ZDltUVhVdHBlaWptWWwr?=
 =?utf-8?B?Q0tnck8vUkNNbkV6dGZndlhnRXdCYS9tM2p3RkV3NmsrQVNQMEdHVHdxcW5S?=
 =?utf-8?B?QW56OSt4YVlPN2dvMFRyT3lmKzlZb3h3VFkyOENZcGF6K0hmOUdPQTU1TFl3?=
 =?utf-8?B?TWc0WTcyb09sOGJWNU90cWsxVTRNMVJkK0QrVHljcDRyVEpyYUphR0VSVTFr?=
 =?utf-8?B?d0EzRHQva0EzUVg4VkFmdmpZMnNhOE9WMktyZU5lNCt6U1kzc0RtQzc4UUxK?=
 =?utf-8?B?RkRjQlllQjhSWDhheDI2Sm1GR3BwYVpaZFZ6WTNJd3NRZG1wOW1odElWZndF?=
 =?utf-8?B?LzUxT3F0NlRraE5yQTBUakwvcC9sUTZ3VE15ZDFPMmZUcnZvY2ZnbndLUEV3?=
 =?utf-8?B?VUFLVHdHUlFITnpCdmdDOVE1c3UrYnpEdG56bHRYS0d5Y2VlMGNZUG4yNXNj?=
 =?utf-8?B?MzN2QitCZjJtazdFbDNTNDVjcDZpbFI1K0ZUZlRPb0ZUbWVVTnRTektUNkdo?=
 =?utf-8?B?U1hRTjNvT1BEVnpwMmtWYUlEMXRnSHYydVpzbm5wam54WG5CUkkzTzRsdmJ1?=
 =?utf-8?B?YkpEQzZYR1cvWFVwU2xsejFhTnZPUUdBamg5bWU5QnZWdUJacXpqN2FMS1Jv?=
 =?utf-8?Q?vBXQJkvABiBoEfTj/WMpiAUMU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3070863b-37c1-41a9-0dad-08db0a2fab9a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 23:53:26.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPL+/MHIzZlbYlemtZRvbu9BJqTMgBYMe/rZT2gYzGI4jt5TU+v4Amo273r1jjRWGbBJX6v1HISg+yaNzohYYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/2/2023 5:20 PM, Zhi Wang wrote:
> On Sat, 21 Jan 2023 21:46:06 -0500
> Tianyu Lan <ltykernel@gmail.com> wrote:
> 
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> Add checks in interrupt exit code paths in case of returns
>> to user mode to check if currently executing the #HV handler
>> then don't follow the irqentry_exit_to_user_mode path as
>> that can potentially cause the #HV handler to be
>> preempted and rescheduled on another CPU. Rescheduled #HV
>> handler on another cpu will cause interrupts to be handled
>> on a different cpu than the injected one, causing
>> invalid EOIs and missed/lost guest interrupts and
>> corresponding hangs and/or per-cpu IRQs handled on
>> non-intended cpu.
>>
> 
> Why doesn't this problem happen in #VC handler? As #VC handler doesn't have
> this special handling.
> 

Because the #VC handler does not invoke common_interrupt() handler to do 
IRQ processing. Doing IRQ handling is specific to #HV exception handler 
as all guest interrupt handling is invoked from #HV exception handler 
once restricted interrupt injection support is enabled.

Thanks,
Ashish

>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/include/asm/idtentry.h | 66 +++++++++++++++++++++++++++++++++
>>   arch/x86/kernel/sev.c           | 30 +++++++++++++++
>>   2 files changed, 96 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>> index 652fea10d377..45b47132be7c 100644
>> --- a/arch/x86/include/asm/idtentry.h
>> +++ b/arch/x86/include/asm/idtentry.h
>> @@ -13,6 +13,10 @@
>>   
>>   #include <asm/irq_stack.h>
>>   
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state);
>> +#endif
>> +
>>   /**
>>    * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
>>    *		      No error code pushed by hardware
>> @@ -176,6 +180,7 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
>>   #define DECLARE_IDTENTRY_IRQ(vector, func)				\
>>   	DECLARE_IDTENTRY_ERRORCODE(vector, func)
>>   
>> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>>   /**
>>    * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
>>    * @func:	Function name of the entry point
>> @@ -205,6 +210,26 @@ __visible noinstr void func(struct pt_regs *regs,			\
>>   }									\
>>   									\
>>   static noinline void __##func(struct pt_regs *regs, u32 vector)
>> +#else
>> +
>> +#define DEFINE_IDTENTRY_IRQ(func)					\
>> +static void __##func(struct pt_regs *regs, u32 vector);		\
>> +									\
>> +__visible noinstr void func(struct pt_regs *regs,			\
>> +			    unsigned long error_code)			\
>> +{									\
>> +	irqentry_state_t state = irqentry_enter(regs);			\
>> +	u32 vector = (u32)(u8)error_code;				\
>> +									\
>> +	instrumentation_begin();					\
>> +	kvm_set_cpu_l1tf_flush_l1d();					\
>> +	run_irq_on_irqstack_cond(__##func, regs, vector);		\
>> +	instrumentation_end();						\
>> +	irqentry_exit_hv_cond(regs, state);				\
>> +}									\
>> +									\
>> +static noinline void __##func(struct pt_regs *regs, u32 vector)
>> +#endif
>>   
>>   /**
>>    * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
>> @@ -221,6 +246,7 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
>>   #define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
>>   	DECLARE_IDTENTRY(vector, func)
>>   
>> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>>   /**
>>    * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
>>    * @func:	Function name of the entry point
>> @@ -245,6 +271,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
>>   }									\
>>   									\
>>   static noinline void __##func(struct pt_regs *regs)
>> +#else
>> +
>> +#define DEFINE_IDTENTRY_SYSVEC(func)					\
>> +static void __##func(struct pt_regs *regs);				\
>> +									\
>> +__visible noinstr void func(struct pt_regs *regs)			\
>> +{									\
>> +	irqentry_state_t state = irqentry_enter(regs);			\
>> +									\
>> +	instrumentation_begin();					\
>> +	kvm_set_cpu_l1tf_flush_l1d();					\
>> +	run_sysvec_on_irqstack_cond(__##func, regs);			\
>> +	instrumentation_end();						\
>> +	irqentry_exit_hv_cond(regs, state);				\
>> +}									\
>> +									\
>> +static noinline void __##func(struct pt_regs *regs)
>> +#endif
>> +
>> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>>   
>>   /**
>>    * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
>> @@ -274,6 +320,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
>>   }									\
>>   									\
>>   static __always_inline void __##func(struct pt_regs *regs)
>> +#else
>> +
>> +#define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
>> +static __always_inline void __##func(struct pt_regs *regs);		\
>> +									\
>> +__visible noinstr void func(struct pt_regs *regs)			\
>> +{									\
>> +	irqentry_state_t state = irqentry_enter(regs);			\
>> +									\
>> +	instrumentation_begin();					\
>> +	__irq_enter_raw();						\
>> +	kvm_set_cpu_l1tf_flush_l1d();					\
>> +	__##func(regs);						\
>> +	__irq_exit_raw();						\
>> +	instrumentation_end();						\
>> +	irqentry_exit_hv_cond(regs, state);				\
>> +}									\
>> +									\
>> +static __always_inline void __##func(struct pt_regs *regs)
>> +#endif
>>   
>>   /**
>>    * DECLARE_IDTENTRY_XENCB - Declare functions for XEN HV callback entry point
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index b1a98c2a52f8..23f15e95838b 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -147,6 +147,10 @@ struct sev_hv_doorbell_page {
>>   
>>   struct sev_snp_runtime_data {
>>   	struct sev_hv_doorbell_page hv_doorbell_page;
>> +	/*
>> +	 * Indication that we are currently handling #HV events.
>> +	 */
>> +	bool hv_handling_events;
>>   };
>>   
>>   static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
>> @@ -200,6 +204,8 @@ static void do_exc_hv(struct pt_regs *regs)
>>   	union hv_pending_events pending_events;
>>   	u8 vector;
>>   
>> +	this_cpu_read(snp_runtime_data)->hv_handling_events = true;
>> +
>>   	while (sev_hv_pending()) {
>>   		pending_events.events = xchg(
>>   			&sev_snp_current_doorbell_page()->pending_events.events,
>> @@ -234,6 +240,8 @@ static void do_exc_hv(struct pt_regs *regs)
>>   			common_interrupt(regs, pending_events.vector);
>>   		}
>>   	}
>> +
>> +	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
>>   }
>>   
>>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
>> @@ -2529,3 +2537,25 @@ static int __init snp_init_platform_device(void)
>>   	return 0;
>>   }
>>   device_initcall(snp_init_platform_device);
>> +
>> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state)
>> +{
>> +	/*
>> +	 * Check whether this returns to user mode, if so and if
>> +	 * we are currently executing the #HV handler then we don't
>> +	 * want to follow the irqentry_exit_to_user_mode path as
>> +	 * that can potentially cause the #HV handler to be
>> +	 * preempted and rescheduled on another CPU. Rescheduled #HV
>> +	 * handler on another cpu will cause interrupts to be handled
>> +	 * on a different cpu than the injected one, causing
>> +	 * invalid EOIs and missed/lost guest interrupts and
>> +	 * corresponding hangs and/or per-cpu IRQs handled on
>> +	 * non-intended cpu.
>> +	 */
>> +	if (user_mode(regs) &&
>> +	    this_cpu_read(snp_runtime_data)->hv_handling_events)
>> +		return;
>> +
>> +	/* follow normal interrupt return/exit path */
>> +	irqentry_exit(regs, state);
>> +}
> 
