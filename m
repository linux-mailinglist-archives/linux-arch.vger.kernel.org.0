Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7264B078
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 08:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiLMHh5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 02:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiLMHh4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 02:37:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD251B9D8;
        Mon, 12 Dec 2022 23:37:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF9D6Ns1KxC3Dxeu5muFhgfkR6BqQg5FC7tpvx3zb0L2SOYgj004aN9b/piJ/04C6bllhw/+KmTQ5f3KF2ce6ZyICTM0KUh8MzF8BjdtDcxGdt+rnxAvAJaho4zvoTF+YslZPd0U49dXOpyA8EIm+4r9OtloeLYCU3l1jh4rtI1W2067RC8rsanaJni9iHFk7M6vbg31Cv0KnYy38J4b8+54iZSaQNIIyU1tMItYtEL0HHaily7k7v+4jlpC0fnhxNYfdEwzNwjkjNNaA7zUXNIro6zHNnZFIttr/ySnPN+GNnCRTOhrWorElKGys1YY8Zi2fEGmDaMBopsZA6eLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0viQ2dPRq3x2BkZRAtkKB6ohN3ihipvwMl5DxLb5zg=;
 b=F0xNkf6/pmjVViY4lxr9SgZW+Dyp6hHbhftfBXVXIg2ETHFMQ+bcWB5l4afIHHyohUx3nKDGLhOwBr7TXWG/0F9VFafuHYYXwstgxDAJUjnT1olpa6U8bKzPiQcoNfuuRUGJvVx4fVAVP3rVajl2PS4Zhwbg/ftAHYPEyNhrfvPXxsWSDZV0aeECnuM/xAm8JGtelSc+SSVRBameSdoTDEndFtb0x7Nr44Ri9VNsW+sCTo7A9kzYwsu+g4JO8gppAUI3N1rrz5GHHYO/lJrZZJ7zHeWKw8PP6TcEb2veXxvUsv6GYpLwEIhL5d6uSiPgrXzZ1tnJsl9b4R3kRfLNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0viQ2dPRq3x2BkZRAtkKB6ohN3ihipvwMl5DxLb5zg=;
 b=r+aIpLOMXuYjQzuqoRZ5L739G7mfx+B6DXrdrtmUdoOxgPUUrTAvJ/aCJqR1LYOeYiV+/nZipD6B2oDjwDAQZQiwewl9Gjducqb5DnMxdNgAKJZY1TC4JiGeB3HSGTsm1BNN+e89ht4WfhLAsAyYe/rgLN2jNGtyea7E/8AHcUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Tue, 13 Dec 2022 07:37:52 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 07:37:51 +0000
Message-ID: <29c7aac6-3995-0a9f-929d-a2865aededb5@amd.com>
Date:   Tue, 13 Dec 2022 08:37:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 18/18] x86/sev: Fix interrupt exit code paths from
 #HV exception
Content-Language: en-US
To:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-19-ltykernel@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221119034633.1728632-19-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::27) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: a29cf212-718b-4e72-b2ee-08dadcdcf08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcO4+cFWOt1n+NWBEyPidxW7wCkszCKOgV8b6crgvGNPbA2+M4n1j3RImkoDxQYHNvWo/Y75oLE4ochmzQdeH2SEpd1QnnVfT4ICnMpiXJo8Zi8mUB0MY+aOKQ1GuHWpGTw/TGmzcI+rR16/TJQ7NZVfTAWCnoVEgpoNjMGi+Zm4CeTtqXnyr6Bu1hv3Uey8OBGiq8oExc9tDtSZS62By9TPXxrFpxTPmSMzbvl5diPyLEM0mpxjMX4sUqyWV+4Xkv/k915uxFPJb0yGnjLHTcKry55gPMuigj7eJ8iIQF63URRyadRS+f+6uzC+qeg+aGNXAITBBxVFRx/vQOsu/+EK3aJ1Guiw38BJqirB/TiJqakULILrRcSejt0SVzi2YyZrM+HH/rw76NdbDky1OPlhPhweY3VJWvc1mAZMWWn2480NoRqewHkh4ig2CbankGRK3QjEYCUB2KLEKs2ahUORJwIb/fDAsKR9O2gL6mxhu0e9t3rEZ3l7UOjbxgqQwlrzTg6j00I+4QMdfMG3Rm3KyJVSeQqgExV3i6ak3ncmTdVr5Wi8tr06E54Km1N9ykBz045mplnmgc74sKh5norcVvbq/YfURyepBKXLF3fIUV7/iSrn0PdwTqMJGuaYbJYCUgltkeVffwyCm0O+H9RlQ9+Z1RaZFczGZSznOJC+SUE6VfRBC0HjUsRhIDwcMT5Qg8rW0JiatU/JF6AWjTT7HjYE/MJL+GrE6g4J/op6vtlIqded4ABVgO8vB8h7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(31696002)(86362001)(4326008)(41300700001)(7406005)(66556008)(8676002)(66476007)(8936002)(2616005)(36756003)(7416002)(316002)(66946007)(921005)(6666004)(38100700002)(26005)(186003)(5660300002)(6486002)(478600001)(6506007)(6512007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVd3QlRiUGNrRjE2a3U4NVcwc0c5ZXVzZlhrMGtZN3FUZHZKbEo1M1VOSGVN?=
 =?utf-8?B?d0RMSzVKZXBpcHRYMHU1a0l3YlRvRFQyaVlEMXZJOURmclBEOStLSlp3WDk5?=
 =?utf-8?B?QmgrVDBtZ2hVU0xvUUN0aDFsbmQ3LzJRb1V0ekZxdGQ1QWVhTWJ1a3l6TWNp?=
 =?utf-8?B?SDY1cDlmQnlhdzBKMXh0MGFQN0I2MmFiemxkRHRqdjVBdzNySFZEcDNIY1pJ?=
 =?utf-8?B?aVhTZFVzQW12NjJaYXVSNUx2UU54dFVHTjZtMnFlMXRuTGNHM3I3MGZ6RGFQ?=
 =?utf-8?B?OHlTZHpoSU1oMDRNOTBoNjhoeWFnMU8wLzZZeDB1TDJPaWhnbnEwWkFCM29E?=
 =?utf-8?B?eE4yRFczckdjKzZlVUlidnJFTy84ajNuUjBjOThkNFFycjdUbnl1cXFyRmNI?=
 =?utf-8?B?TFlla3RoYThHVElwOHVBbS9ldFQ0YUswZXRJUGZYaVBORVpuSXFZV2h3d0xp?=
 =?utf-8?B?Mk9JR2w3THIxU3M1NnlpZEJveHByaCt1RlA0Tnh5RUZTeDNnM1JmY3BIUFR1?=
 =?utf-8?B?dHAzODBxaVVSc21NR200eUQrSi93VEtrY0liWjNoaHZ2VFY1d2tLOU51NEdK?=
 =?utf-8?B?YS85Y1lvK1ppR09OUzhLOVdGd2laWWZvZER2REJZQlc2bVpPV2JqYUorWEtX?=
 =?utf-8?B?Zlo1K1F3dEYvcWUxUVlDNFNzMjZvODlRUFdmdmh1YnJWR3k0QVgzTjhVRmIy?=
 =?utf-8?B?d2FRa2xJT2s5YzNRYm96anNXMGNLZjFrdlZ2bzZMTzhzQkxqWjFSRTBLeFVr?=
 =?utf-8?B?ZldYZ3h0VkszbzNzVEpjTTlhS2laR0xoV1FKcm5tcGxQaWJBRE1ISVNhV1ln?=
 =?utf-8?B?Ky9YQWd4YmQ3bmNhZVI0ekRBeExwYmtjRUxSVGhoMG1TSld5VTMzcXhiQzRG?=
 =?utf-8?B?UlJKM0xsUjEvcUtJM2lMK0lKOC9ERWZSczhLMGF1YzZHekI4N01NNkQyK1ZD?=
 =?utf-8?B?Q0FxOFlrVmJ6MlNnZmRDMzVGemsxaHFka3RwYXlrSnRZSGgwWndVQVFDSjho?=
 =?utf-8?B?MHRTZ1V6RklQUWt0d0h5VXZrMTl6OUk3amk5UEl6NVF5enpWbHZsWGVKTGlM?=
 =?utf-8?B?Y0EwSyt0emxjUnhmWUlJZld1YjFpTDRIMTQxVThXTFJDaVpRT3FKQWh1VjlZ?=
 =?utf-8?B?KzlzanZZNUtEcHVzeWhzd2xxWTY4Uy9Zb21Gems0YkdsZFJScFFpeEZWbzdF?=
 =?utf-8?B?K2NFZmtvcGpmNUNwaE4vTTdHUDdpSDYycTc0T0NEdDNxc0pyak5tVDlyeWky?=
 =?utf-8?B?ZFZrRERoWXRJRzJ6UFFtZGRCVDUyZGpzejlnNGZzN3Y1MGZrT3cvNGdqTkdU?=
 =?utf-8?B?cURyQ3FmTE95MzVoY1FmNXJydmM2MWQ5Q2d0S29PR3k3MTUwVEZqenM0Q2hs?=
 =?utf-8?B?OC9vcTZGYnpGVS9BWXo0Z0dJKzF6YTdhV1hMbVlyVUc2MGNzNFRSd0Q1Y0dZ?=
 =?utf-8?B?bVd3UEM2ZmdkQS9FSnNXcFV2TFA1UnlCZnlHcE1QQTBCUFNHVllnL3dPck56?=
 =?utf-8?B?d2pNK3pDSkIzbnQ1VGtkRGNxY09rai9RbC9aelZwQlZqOXFsc1ErODAwZWVC?=
 =?utf-8?B?T2w4TkdBblVJS0hXcWFidWN1VXIrSnU2QVNudWtJV1l3V3lTeDhrQTBGSW92?=
 =?utf-8?B?UklBcVRxSjZ6ZmM1UFA4ck9xeHJMcjFuZjk4RmVXcFBiNVB1Q1FGcGtMTGVj?=
 =?utf-8?B?enRYZDNXVzZFWm1oa3hHSzRkbERBOTlKNnZmb2VNbDMyNTNRNHJvbDBzSzFh?=
 =?utf-8?B?N0pFQk1OWjFCTEc4L0twZWltc1JsY25XVERVbU9pdnN6bU85VUFHbmFiRGoy?=
 =?utf-8?B?MWJ5Y1R0Rk1CbG1TclA2V0F4eWttenQxOUkwWlV4YzV4RUREb281eDJTbDgv?=
 =?utf-8?B?Vnl6MU4zMzkreWd3bmFJcmQzZldZMEFPVmJtRU9ZZkNTUG5DVEx4VjVOWTMw?=
 =?utf-8?B?T3FVWXk4ZzlwNVJuQThTUWlYaWVaajJGaHlDTmhJS3BBR09PSEVseUw5dVIv?=
 =?utf-8?B?S0g0YzJCU09obENDa24wejVXS3ZCam9nNC9uNEF3TXdKV200Sk5tY3pabDB3?=
 =?utf-8?B?ZXA3Yk1LWUw0MkxqMStMaTlmUXBueTlMYzltbEY4SWwzUXJHTkZUWFlkY3ZT?=
 =?utf-8?Q?IjoXRqr0Ww8Ew5HcjQeBMQZae?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29cf212-718b-4e72-b2ee-08dadcdcf08c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 07:37:51.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meeFIjfNuvFLoW92QXhfi8J46UPnn7ahCMp76WkLvXmD3Hw0ZPkm/iATfGRQYb49dr7WfHy0dgVIdUOckf1jOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Add checks in interrupt exit code paths in case of returns
> to user mode to check if currently executing the #HV handler
> then don't follow the irqentry_exit_to_user_mode path as
> that can potentially cause the #HV handler to be
> preempted and rescheduled on another CPU. Rescheduled #HV
> handler on another cpu will cause interrupts to be handled
> on a different cpu than the injected one, causing
> invalid EOIs and missed/lost guest interrupts and
> corresponding hangs and/or per-cpu IRQs handled on
> non-intended cpu.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>   arch/x86/include/asm/idtentry.h | 66 +++++++++++++++++++++++++++++++++
>   arch/x86/kernel/sev.c           | 30 +++++++++++++++
>   2 files changed, 96 insertions(+)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 652fea10d377..45b47132be7c 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -13,6 +13,10 @@
>   
>   #include <asm/irq_stack.h>
>   
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state);

For linux host, CONFIG_AMD_MEM_ENCRYPT also gets enabled at host side 
(for SME) and 'irqentry_exit_hv_cond' gets called. So, we need to handle 
the below cases even when host CONFIG_AMD_MEM_ENCRYPT is enabled?

Thanks,
Pankaj

> +#endif
> +
>   /**
>    * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
>    *		      No error code pushed by hardware
> @@ -176,6 +180,7 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
>   #define DECLARE_IDTENTRY_IRQ(vector, func)				\
>   	DECLARE_IDTENTRY_ERRORCODE(vector, func)
>   
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>   /**
>    * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
>    * @func:	Function name of the entry point
> @@ -205,6 +210,26 @@ __visible noinstr void func(struct pt_regs *regs,			\
>   }									\
>   									\
>   static noinline void __##func(struct pt_regs *regs, u32 vector)
> +#else
> +
> +#define DEFINE_IDTENTRY_IRQ(func)					\
> +static void __##func(struct pt_regs *regs, u32 vector);		\
> +									\
> +__visible noinstr void func(struct pt_regs *regs,			\
> +			    unsigned long error_code)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +	u32 vector = (u32)(u8)error_code;				\
> +									\
> +	instrumentation_begin();					\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	run_irq_on_irqstack_cond(__##func, regs, vector);		\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static noinline void __##func(struct pt_regs *regs, u32 vector)
> +#endif
>   
>   /**
>    * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
> @@ -221,6 +246,7 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
>   #define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
>   	DECLARE_IDTENTRY(vector, func)
>   
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>   /**
>    * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
>    * @func:	Function name of the entry point
> @@ -245,6 +271,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
>   }									\
>   									\
>   static noinline void __##func(struct pt_regs *regs)
> +#else
> +
> +#define DEFINE_IDTENTRY_SYSVEC(func)					\
> +static void __##func(struct pt_regs *regs);				\
> +									\
> +__visible noinstr void func(struct pt_regs *regs)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	run_sysvec_on_irqstack_cond(__##func, regs);			\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static noinline void __##func(struct pt_regs *regs)
> +#endif
> +
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>   
>   /**
>    * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
> @@ -274,6 +320,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
>   }									\
>   									\
>   static __always_inline void __##func(struct pt_regs *regs)
> +#else
> +
> +#define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
> +static __always_inline void __##func(struct pt_regs *regs);		\
> +									\
> +__visible noinstr void func(struct pt_regs *regs)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	__irq_enter_raw();						\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	__##func(regs);						\
> +	__irq_exit_raw();						\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static __always_inline void __##func(struct pt_regs *regs)
> +#endif
>   
>   /**
>    * DECLARE_IDTENTRY_XENCB - Declare functions for XEN HV callback entry point
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 5a2f59022c98..ef6a123c50fe 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -153,6 +153,10 @@ struct sev_hv_doorbell_page {
>   
>   struct sev_snp_runtime_data {
>   	struct sev_hv_doorbell_page hv_doorbell_page;
> +	/*
> +	 * Indication that we are currently handling #HV events.
> +	 */
> +	bool hv_handling_events;
>   };
>   
>   static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
> @@ -206,6 +210,8 @@ static void do_exc_hv(struct pt_regs *regs)
>   	union hv_pending_events pending_events;
>   	u8 vector;
>   
> +	this_cpu_read(snp_runtime_data)->hv_handling_events = true;
> +
>   	while (sev_hv_pending()) {
>   		asm volatile("cli" : : : "memory");
>   
> @@ -244,6 +250,8 @@ static void do_exc_hv(struct pt_regs *regs)
>   
>   		asm volatile("sti" : : : "memory");
>   	}
> +
> +	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
>   }
>   
>   void check_hv_pending(struct pt_regs *regs)
> @@ -2541,3 +2549,25 @@ static int __init snp_init_platform_device(void)
>   	return 0;
>   }
>   device_initcall(snp_init_platform_device);
> +
> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state)
> +{
> +	/*
> +	 * Check whether this returns to user mode, if so and if
> +	 * we are currently executing the #HV handler then we don't
> +	 * want to follow the irqentry_exit_to_user_mode path as
> +	 * that can potentially cause the #HV handler to be
> +	 * preempted and rescheduled on another CPU. Rescheduled #HV
> +	 * handler on another cpu will cause interrupts to be handled
> +	 * on a different cpu than the injected one, causing
> +	 * invalid EOIs and missed/lost guest interrupts and
> +	 * corresponding hangs and/or per-cpu IRQs handled on
> +	 * non-intended cpu.
> +	 */
> +	if (user_mode(regs) &&
> +	    this_cpu_read(snp_runtime_data)->hv_handling_events)
> +		return;
> +
> +	/* follow normal interrupt return/exit path */
> +	irqentry_exit(regs, state);
> +}

