Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A46F3351
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjEAQCn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEAQCl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 12:02:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD42E42;
        Mon,  1 May 2023 09:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwSgqYllit5ZalSTk00XREwc5pA9ZqoiBax41PnzRNxqRkdS8ikCynQTF4scArFUokVb5ejUlJv4OGL87AiCV5GarOeNqK8A+z7BEOk0gdpY+sw+0qFfA5fLjXGPDbcRS2sG9G1Z9HykVALEVPBHKq9Z86wWeqySzX9zA1T2Y0KBfRoSBDz14VOPhf0L02g0lYoArnOyexF8hZ9hrG2GATynZpihSW5yRFJSd6CUDbb2hsBzQBv9ip1fYPSLO2hu+llxmMGFA45KGdhpp0iaZM6z9LjrHUTkKFPgld20La7jFpQF3h4p7y+DSLz5rEM0LY/r62RrtfnfbJ6zvcbLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HCVsc9ZWe3zN+esxHeAq9fwsyR3rqx2WSPsZEhEDdo=;
 b=OEr9NWr+sEMFD6bAGdBas1u4eRGcVZu7dzT2lDR5LLs0ADvqZ1Ws0rZP8yWnaD9EEtIWqnxfP3PLx+Z8Kh77nc5gTFqVcmRSCW015PwoWuoPI648FvAZpnD7l+brphlwWSfBPHrk+kpyBODfr+zB8VSh8DVtU5+KyLWeGTaGUATGf06HvSby+VrY4IbmikelUnKJ9ZS74A8DlzAfwjMjP4JwACplFWsqGvfm1Hdi1kj52+2wzQVcKmJgaq8YPQghUdSZuyhEwF+hIfRugf86HRAzZbCR1rDPCIDB09014C++KAEiLWfN4ZAoT7l9P7uuUZFT5e0qMuaj+fcgahAQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HCVsc9ZWe3zN+esxHeAq9fwsyR3rqx2WSPsZEhEDdo=;
 b=nM2ML+G52qf1LG0dze0HSmk0UD3L72IjuH+li3RCLT6UCRQkE5olW7fs+ulR79K3ZZwxFyhFHY7XJ/ImlFrUC/a/v/sQt0LwNHv9rddbRz2wZysgJADLXiHyPSZ2G2g85qmbeMVlKFBs39ZZolFjWPT1YI1lbO0rHNc1LDe2bDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 16:02:37 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 16:02:37 +0000
Message-ID: <3c91e1ab-29f4-09cb-1268-52fd9c3e34f4@amd.com>
Date:   Mon, 1 May 2023 11:02:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH V5 15/15] x86/sev: Fix interrupt exit code paths from
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
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-16-ltykernel@gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230501085726.544209-16-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 16158bd6-4ea3-4a1b-2897-08db4a5d7ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVpuExDYp+f57mvb4JCi6rDB8boLiXO2Y7CCCN7D/Irrzy1R+z5Wtc/7BH0V+eSZXzezueZPIdt7BsV9DtGWpa3M2q5hnWyFxZnCw8m1HUsoeSBke6PlvieJEu7BCe87ZYrQV7ef1wiaTpBC0ob9s2X3pBQ0dkBzh4lolw+NiH0eligFxZhBjrrJGVauh1Vh/QjRbTdZzquKqUgshgLJL6oSG4+a+pBatOIHFBRJQSJ9unIW1E4H0HAzUU+VPsQfDlxVXoqryrljsuHGL8oaqaSXQl8MBf6vvDjnbgVckVWzV1sDLmJwQ54otvQ1wgiEhthorgdDA/b4dMh77JYOvjbjFK0KPgc5dr3db7kuqnvvvuMKfBIsfXmvgqv3X4d5b5dkldqhSED9ZXXR6DctrIIhhyWRb8YaDLk/SPe3w1k3N/DSOvquJoRr91sn97xAkz/qVsS23Rec8yQglv/zbzbIciV0tIednnGdmn4pjoJ90NdSk5cdGCFfzM4p2nrc38fTdebAuco0IYwRzXyLdFJx2VbAfyxFVhMio3ct0LYSHA4av1kyGy/IETKml93sE4JP+JICRaPA76TrxH0DbHe973+KOIzB1jYrHONV+CLzWFCrPvcii4GnokhZMYIkCKQQIsn8guPlsam36A7FxzsPY4idjbd8nnx9sFvP/aA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(316002)(6486002)(478600001)(31696002)(36756003)(6666004)(86362001)(26005)(6512007)(2906002)(6506007)(2616005)(38100700002)(53546011)(31686004)(83380400001)(7416002)(7406005)(5660300002)(8676002)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW5YRXpqc0dERXpHZ3pwRVVxUEFGNFhZMnlaNUg3MkpySTZIb2NBT3V5UHNZ?=
 =?utf-8?B?Zi80QXlPU1RKdzlvZSsydGhHMWxYK3Y1SVFUSVNWaFhFNk5maW9ReE11dDJS?=
 =?utf-8?B?OFAzb2hJSUZnT0JoS2xKQTdYZGtaRTFNYnFFbXJCQm5qQU14eHZZdTZNWFk3?=
 =?utf-8?B?ZUR5K0I5a1EvWW92ems5U2pJaDZhZnozcytJa3RJYzMwWGFrVkxWVUdmVWFQ?=
 =?utf-8?B?NlU1Z2tUVElFKzM2R1dHcC9SVzB2bG55NmxzWmlpZkMyOTA4Y2Zvb0JUaUlY?=
 =?utf-8?B?KzVUZHphR0I2ZDR1aDNlUlppaTJlaERRb2xaVUpuN2k5REVwT1l3algwTVJR?=
 =?utf-8?B?Vk82MkpQV1pHUGtrTWQ4NDJmMUY3S0RlNEVCellFRU9FMDhTSE1CcjArdU5k?=
 =?utf-8?B?dFM4bFZjUEVnbkJ3anBxeHlSSnRSYzlFNHJEdys2anA0YlpBU3h5VVNaczJ5?=
 =?utf-8?B?Mks0SXh5Q2NGSzN3dmlCblZYRzFaWE1UaGpnb0wrcVVCOURGanZlbzFsSGl1?=
 =?utf-8?B?dEJ1cWE3c0xlVDVId2E2NnY0Ni9wdmhkVWhYZHpqMVhqeE5IaVhZRUV3V2Ji?=
 =?utf-8?B?QktOZENsRDgwcXVqT2t1ZmhDRE1ONDM5OHhqbDFvd09xNXhHRzliREZFa1Uw?=
 =?utf-8?B?WkZvTUExSHVIZGhXSllkc0t2SVF3YS9zZ25YWWJOZmpWcHh1NEVRSXVhUVJK?=
 =?utf-8?B?RFRqN3NMazhkTDkvUjdIZm1OZm01RWRGUEg1MnNYM0FlNXEwWUFaUnY0SHBI?=
 =?utf-8?B?dm1hUjRqVnJzSEFhRzQrSlJUQjdIVVBGUDZuSENJV2hIaUdNNG03T3R1TGtW?=
 =?utf-8?B?RytINnBtYmlWWnFKeWNWRXR1L29Qc3RtUzdrUXNGanNwRVRiRTI0NnlQL2hQ?=
 =?utf-8?B?eEY5WEhqc1RMbzJ2RWhLRlRqdG5LQndOUzdVNmo2MFhuYmFVREw3cGFxVGEr?=
 =?utf-8?B?dms0eFNGTURROEZocG9ZY0IzRWlFVXQ2ZjJrREhqUitoS0JlYXFGSUxtaVdY?=
 =?utf-8?B?Y0l4MzMvRnRRYjR5MHF4dlJHZ0d5RFM2S0gxczJpbkxrMDBoSUd4eTJ3eGNs?=
 =?utf-8?B?VjlJNFUwaGEyc1RoaDAvekxMajBWOTdYa2JIcGhXWE5mZVJ5M0xVcHlkbDMv?=
 =?utf-8?B?QXlJREFRUi9qd3NHN1NiSjZaM2xXT1hhcUpxMWd3N1Bxdkg5MDFsKzlVeXdB?=
 =?utf-8?B?L0JGYnMrS01Pb1g5MlJRYVlnQy96NGUzOHhweUx4cWZ6S1pMRElPdTFxL2tK?=
 =?utf-8?B?UnFBUXJkNFY0MDNudWxTTFRUTml2UjdGVytybTFvcmhmb2JraENVS3h1UE1u?=
 =?utf-8?B?N0dvbGtjdk90dGpCMG5WZnlZRGNEUGFKRC9TcGllS3drSG5tYTBoU0VQVmFV?=
 =?utf-8?B?c3dSbUNWSjE5alNUSEhvV1FJSy9MVTRVNUdkSjBVZFdXSzA0NVZKVHUxbDQy?=
 =?utf-8?B?SmNCcExUWGJnc1BpRzFQdERLQm1sY3pTL05xR2dDMDk2Qkc1QlVON1ZRRnht?=
 =?utf-8?B?VEx3YUJxV2p5MmFoc2RVcUljSnRMcU5QM0QwRXNyU1UzV3ZuMk5la1BHT0Q3?=
 =?utf-8?B?SExwUVJ3Nkg2WEFHWjBnTHE3MUYzSGhhTHVDYk9aQlQ2bUhEVmVocGF2TjNk?=
 =?utf-8?B?dm00dzliS0VUMnNIRmJwMW5kMlNLb2tHOE1pM2NLSE1zSGlYSFVwTVpsZ09x?=
 =?utf-8?B?RmVIT1ZBVHVjSFJrUXhmVWFLSzIxUXVmQks3aVpMTmdyTy81cWxtZjRHVlE0?=
 =?utf-8?B?WTFJTzQ1VEhDR0hQUEgyNnRFVEl2NTBMNlQwNzRjcDFXTzhwN3NWeXZIN2RL?=
 =?utf-8?B?c0tXVUQ1YWg5RUhhbThBekwvZWppa0VjL3pMWk43TUR3U01ja2YrRGQwdWdH?=
 =?utf-8?B?VWlId3E0eGNZNzNESmFSVktQUUErdGpmWkdhVW5OdGQrRk1INTNnOTFkUkIy?=
 =?utf-8?B?bFFENVNhMlhDNVUyUG5oZFpEN0xiWlJtcWEzVjJZVmZjWndSRklUekR0dGcx?=
 =?utf-8?B?WjJTYWV0TmF4VXhmdnJUbGNCOWd0Rm9tUDhMb1RvYTBOdnhZS3p5S3pjTFJX?=
 =?utf-8?B?bUVPMHU3cGdremVhWnpaRlpsdzJXUk56emVaL3ZtWmpHMjcrODlQdFBlOHNT?=
 =?utf-8?Q?QwbHXM2Kq6lD0wnsskAGRhYhK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16158bd6-4ea3-4a1b-2897-08db4a5d7ba1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 16:02:37.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc+jzGlKB1bSX2ogNpfifNSnOnJXSpP64csSRSwc9B9FOf/1XTyd7C6WINkAML7xERGRZ+KubCsXMc9L0uMsoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/1/23 03:57, Tianyu Lan wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
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

This should be merged into one of the appropriate #HV patches and just add 
Ashish with a Co-developed-by: tag where appropriate. This would be 
appropriate as a separate only if discovered after the series was merged.

> ---
> Change since RFC v3:
>         * Add check of hv_handling_events in the do_exc_hv()
>         	 to avoid nested entry.
> ---
>   arch/x86/include/asm/idtentry.h | 66 +++++++++++++++++++++++++++++++++
>   arch/x86/kernel/sev.c           | 37 +++++++++++++++++-
>   2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index b0f3501b2767..415b7e14c227 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -13,6 +13,10 @@
>   
>   #include <asm/irq_stack.h>
>   
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state);
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

This seems like a lot of code duplication. Can't the difference (which is 
the call to irqentry_exit() vs irqentry_exit_hv_cond() be #ifdef'd in the 
current defintion?

Ditto for the changes below, too?

Thanks,
Tom

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
> index b6becf158598..69b55075ddfe 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -149,6 +149,10 @@ struct sev_hv_doorbell_page {
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
> @@ -204,6 +208,12 @@ static void do_exc_hv(struct pt_regs *regs)
>   {
>   	union hv_pending_events pending_events;
>   
> +	/* Avoid nested entry. */
> +	if (this_cpu_read(snp_runtime_data)->hv_handling_events)
> +		return;
> +
> +	this_cpu_read(snp_runtime_data)->hv_handling_events = true;
> +
>   	while (sev_hv_pending()) {
>   		pending_events.events = xchg(
>   			&sev_snp_current_doorbell_page()->pending_events.events,
> @@ -218,7 +228,7 @@ static void do_exc_hv(struct pt_regs *regs)
>   #endif
>   
>   		if (!pending_events.vector)
> -			return;
> +			goto out;
>   
>   		if (pending_events.vector < FIRST_EXTERNAL_VECTOR) {
>   			/* Exception vectors */
> @@ -238,6 +248,9 @@ static void do_exc_hv(struct pt_regs *regs)
>   			common_interrupt(regs, pending_events.vector);
>   		}
>   	}
> +
> +out:
> +	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
>   }
>   
>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
> @@ -2542,3 +2555,25 @@ static int __init snp_init_platform_device(void)
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
