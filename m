Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A26F811E
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 12:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjEEK74 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 May 2023 06:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEEK7z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 May 2023 06:59:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76411629;
        Fri,  5 May 2023 03:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0VXdytmZ27BtkXQspstFWr/7Sqs1FT5KRdJI8vvuVLYHEIwtVYL4vRIbjkX/g1els+SKpvQdDqQwxrKMzahCFw91pgi+fXduGlqEIGgFsObf3VEaEyiueMap3+PDqpQAbivRv6MLEiliX5k1TtrtJ4737uo9iIfhSAxpyybFmDOrelC+jQFJBncacpDya/C0Ex2z9faeXRYJW4HXTtgT3DSAFsmkstR/UUKnE/lUxejtVSBqdYUksWbwWe8+GG5+AKQWijPS8fR7WQZyRdQ65Shozm+jzo9255maf7T2fiWL4aUAAXNDOu4A4Yg1nHG5hncXGs7Ew2yrOsFnHDdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK3T3rLe3zla+NMo3GkYcCryQ4HUUo96ec9t0eBX7xE=;
 b=Els/0zbqL101yfdQxoiuOmcCUuY8yFDf9cZC2JImpxpxgmVHAcVnfmk/yOzB979BrOQGVCA90RxFt0x+XI8Tg0zLK1dxS3Mv1U/Tzel1Io7xgKpPLdjSUj+lH2Twkd9IRTFhzGN4ClVM4J+fSUB5j/RpzH1fnbaHCg2xUg9SYY7B+RtTCDIa4dx0ksnw3GdGo+rOyemgXAdyjwNhQlZIreVQvjeBuYIcaRpdj/rh2wxQ/TLVrr30Qf8rzU0BCqWGXvhVnIgXCmgtxtIRvxlMtEMHNPtpYft4ZwauhcKlCJ8p0HKZ7zXVRkHEoQUIxxNqFfOEXAHIHzRs++BeuRNLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK3T3rLe3zla+NMo3GkYcCryQ4HUUo96ec9t0eBX7xE=;
 b=P1/Cox73COA+vNxM42s9tQAfoiZi8Iu3Y/3TZ5KRc79z3wQ9Ec4dT6mV/RGU18xTOOQ1PzVlm0dFR/DyPhXd2L3CILVm+zyMHjyjoO1qKFIqURhuHi6Rg8+wCKsdMaBFnqJFpQyxO2SR2ET6oQnVyyv3ZGS6wIx0gKQSefexHCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 10:59:50 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::f8b0:cf29:9e21:380]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::f8b0:cf29:9e21:380%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 10:59:49 +0000
Message-ID: <3ec60d7a-c5e7-2570-a0f2-ef435d904cfd@amd.com>
Date:   Fri, 5 May 2023 12:59:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V5 11/15] x86/sev: Add a #HV exception handler
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-12-ltykernel@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230501085726.544209-12-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::12) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 3505e091-e529-448b-6fb9-08db4d57d88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 421vxAPrAdqwL9K0uIXR0L9IYmyN9I48VMZ4Ae2eJlexNgqhaqcefnbMHV17cCKHQj9jAcKAzjFGsNNWVJWN6smUVqUW0gWdpq0XxefTiphP/N/tcDacW+kw+V9vtoPYbjMfNRx88N2RsyhMZgY4n2OKa0BiaVGIeaMrmyfR5d9QiOphQLDQpE6VnmefkyBQkckn3jZGnIt8QZvHnt5JQgrMTe0YuBYOKbJtGmz2czRBWT82xMOpPXuhTw4F4VVkmzxzofYHym2em0j9e69jOcJb/7TAwl/Oj5//GbHqjoNPlALdU6twhusKW5Ou9Wt3PNTo/0P08L9FrYfds9ms7lCEJ6zGTM7sVSdXu8FJ3wEkJ31D56NDgYuTow0Utsi5ahyeD8syxgtgJgOx/XJJ79ZEY7ItxMaoUrn/gNfmcJ4VGr6HAtGsqw/L++3kU+2cy3pHGFv8WgZn00lPUcIhEOIcl4MThH6WgC3tEvSaU5mHzHsytWX41l94zEN6A9+P0S9/DwJ8T/TsU4YSKAXFfNoP9TGIE5kXQrGnkWrPpsWRQ793Bsb4jWv5VroTcAALFkNQMmTE3NFBwAvHWtkPoMRdbS8wxDkEqaYmQclTBHu/PT7qRkgelbkjb0q9UuO0XxRYFjmS0s1TuxoEvckFUSBd0J4vJABwuHqLuSeWTi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(45080400002)(6666004)(6486002)(478600001)(26005)(6512007)(6506007)(186003)(30864003)(2906002)(7416002)(7406005)(86362001)(66556008)(316002)(4326008)(66946007)(8936002)(8676002)(5660300002)(41300700001)(66476007)(31696002)(921005)(38100700002)(36756003)(2616005)(83380400001)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEpUL1I5ckRZTk0xbVVYRUhKYXhJdnludGhDSGJJRFFhTWV4OENkSzZzYnVx?=
 =?utf-8?B?elNWTHdlMi9keHVZRDB3WnQwUlRqLzhXOWUrUGpHNFRieGpYTi9DQUsrb1c2?=
 =?utf-8?B?KzZUb245R0hraFZKOUpZZXowbGpSU2ZDMnc0QjhiYnh2a2VaRjRGTklJT2M1?=
 =?utf-8?B?cHpOcjFaNmttL0FQb2NmanhRMUovWDVyL3dqTTMrVTdzS3RJRlpTNERLY2tw?=
 =?utf-8?B?MVlZM3hBQmJtWkphQ3RTcjNNNUxCUEg0eVpWZUFNakowTGpORW03NUpFcFpJ?=
 =?utf-8?B?emxvMmNNTk1EMGdMYUJiV2Y5T0xVcndpRmpDY3phRzN6ZCsrbmVuR0NqazdW?=
 =?utf-8?B?UzJZWTNKRTJIa3ZleGVndy9iYmY1Y3hDQjgvQVRjRTM1aU1TZzZaQzY1WkpX?=
 =?utf-8?B?MlJMUVEzZzdTRDErWGRzTjcyT042aG4yR3E0K1djY0pmQmJmMVlXVDFuazVX?=
 =?utf-8?B?RDFVWmRIZDlxS3o1NE1lSnQ1S1FCbEhNWnU4ZWdjcEJmTnlVc25LaVl0QjRU?=
 =?utf-8?B?MU4zS1VYbVdVb0txOVBtMHVScEhrSDhDb0NwdUR2bW9jMFpNOFEyekZwcnR2?=
 =?utf-8?B?dVlYZDhKU25Ra3FJc3N6dVNZd1BWTnpzNEhJWThGRlB2c1dBZ1NQQ2VWbTR4?=
 =?utf-8?B?N3VqSnRUWWtvaDlkcTRsMVB5WTFMTDRoT1FBb1RXWEtHN0lTZHZ5RkI4ekw2?=
 =?utf-8?B?OXFwK2U4N21YVEx5Qzh5eGNSUGtqZVBVZjdyZGVpZjBJcitoOEtGcjU0RHBL?=
 =?utf-8?B?dks2b1ZQZk1sQnVmbFRHUzFpWnljbHBCNVU2elFXanBNTkFURWwrVkkwRjFl?=
 =?utf-8?B?UllLUEgxblBta0svWGdTdU5NbnpVdmdOQUN2SFpidkpqOG5IMEExbUxwT3FT?=
 =?utf-8?B?ZzVpeEh0MSsrdThlTUhtdVV2c0tRSE50UlVMWVh2azgvVXhzcHQ0YXJzQ2hG?=
 =?utf-8?B?cTl2dTQySklBWml1UkJlbE9XT00vY0F5K0ZjY3pYYTJreEV3OHZFQ2lqeXZa?=
 =?utf-8?B?RjZncDVUdG5yTnZneGg1akRmbzhjdkJJdVhwb3g3ODR1MnhmL01KaXoxN2Nk?=
 =?utf-8?B?cnFYRkdxeTVvSytpRVFZME5RVWRrbm1JZnV5ZTFqVHQ3c1ZIdmt0dEpCcGZI?=
 =?utf-8?B?N1U5eW9BUy96dzRER29tMFErdXBYcnFjaEZrU0dJU1NDcGNsbmsyMS81eHVa?=
 =?utf-8?B?RkI3QU4xeXJlaTZzeEtzS0RsUUdtWXViSmpPeC9LOG1nMVJDcitVN2ltTUx1?=
 =?utf-8?B?VUxneFY5K0RuVzhWcldvOEIrOWMzK0Z2TnlTRTlrOEZtdG9xV2tJcWloL1Zs?=
 =?utf-8?B?M3UzRDdMWXpVekU5RVdVR1BwbS9ZSlE4YlNLZ09Dd0U0dXRDaGcwWWxhZjBr?=
 =?utf-8?B?VUVEeGc5YWdkb0hVbVNvVDJxdlhJMlhwcy9SRXBmcXFTRWNtdlhKOTJDZUxT?=
 =?utf-8?B?UUJzclMwSW1QeThmQjJRN1VMem5JclpuOUZ3ZWJNanNKSmFaZlVpek1lVGV6?=
 =?utf-8?B?T2IwendIWXIybUNIbEdIbHowdC95NHVVK2k1ZUt2QTRmRU9QR3NnU0lCWERh?=
 =?utf-8?B?Q3dKQndSVEg4Rk90QnBnaGF2dEUxckl1a0VKNVBkeklOOUpzM2RrLzNYK0s1?=
 =?utf-8?B?dE9TSmsvWW5remFiQmVQNGRnT2g1VUZQWTJHRjEvUXVGaFFwcS9zSWJMMTU5?=
 =?utf-8?B?MllxaDlleWNCZHRNRzVUWkgxS3ErTE1iZlRKeWlOZ1Z5bnl2elZzQnZobUl5?=
 =?utf-8?B?dGxVeWhpRURSZUF3dEorNFhDT2xJK1ZkNllBa3d4d3FYU1JxSmRqQnJyN1Rn?=
 =?utf-8?B?L0JTOWY0b29sRnhqbFNTaXV0dzNhcXc3cDd4MU9uOTZNWEpuN2pncXpDVGFE?=
 =?utf-8?B?dmMrVFpnejdSWUlHNnRMVEdEL0E0U2lMSkI4aWJYbi9ab2thdzhOTkptTUho?=
 =?utf-8?B?NWhwRTFsTjF3NTlTMnltVldCRGYrMXVTK2FjSlM4N29RbHpiOG1Sem9oNkND?=
 =?utf-8?B?MkFJNE43QU1QYjBhR3JaNWcrcXE3SjU2eDRzNTU0ZDc1Q1o0bkhsMythSHRK?=
 =?utf-8?B?VjVzYmNaOHFNM3liK3NkaC92RldsTCtXU3llV1IrRzMzc1d4Z2MvMnoxTFVy?=
 =?utf-8?Q?HvrevCJiptgtNb+4fDI6X3sQz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3505e091-e529-448b-6fb9-08db4d57d88e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 10:59:49.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTBeFRsfmlPVEw3ow7StmPyTX2abImluC3QLt1qjHhm7Cysw/qxXxAkt5seQVJZkml/TIt9aLu61dbVzOWdzhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tianyu,

I tried to understand some details of this patch. Please find below
some comments/questions.

Thanks,


> Add a #HV exception handler that uses IST stack.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V2:
>         * Remove unnecessary line in the change log.
> ---
>   arch/x86/entry/entry_64.S             | 22 +++++++----
>   arch/x86/include/asm/cpu_entry_area.h |  6 +++
>   arch/x86/include/asm/idtentry.h       | 40 +++++++++++++++++++-
>   arch/x86/include/asm/page_64_types.h  |  1 +
>   arch/x86/include/asm/trapnr.h         |  1 +
>   arch/x86/include/asm/traps.h          |  1 +
>   arch/x86/kernel/cpu/common.c          |  1 +
>   arch/x86/kernel/dumpstack_64.c        |  9 ++++-
>   arch/x86/kernel/idt.c                 |  1 +
>   arch/x86/kernel/sev.c                 | 53 +++++++++++++++++++++++++++
>   arch/x86/kernel/traps.c               | 40 ++++++++++++++++++++
>   arch/x86/mm/cpu_entry_area.c          |  2 +
>   12 files changed, 165 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index eccc3431e515..653b1f10699b 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -496,7 +496,7 @@ SYM_CODE_END(\asmsym)
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   /**
> - * idtentry_vc - Macro to generate entry stub for #VC
> + * idtentry_sev - Macro to generate entry stub for #VC
>    * @vector:		Vector number
>    * @asmsym:		ASM symbol for the entry point
>    * @cfunc:		C function to be called
> @@ -515,14 +515,18 @@ SYM_CODE_END(\asmsym)
>    *
>    * The macro is only used for one vector, but it is planned to be extended in
>    * the future for the #HV exception.
> - */
> -.macro idtentry_vc vector asmsym cfunc
> +*/
> +.macro idtentry_sev vector asmsym cfunc has_error_code:req
>   SYM_CODE_START(\asmsym)
>   	UNWIND_HINT_IRET_REGS
>   	ENDBR
>   	ASM_CLAC
>   	cld
>   
> +	.if \vector == X86_TRAP_HV
> +		pushq	$-1			/* ORIG_RAX: no syscall */
> +	.endif
> +
>   	/*
>   	 * If the entry is from userspace, switch stacks and treat it as
>   	 * a normal entry.
> @@ -545,7 +549,12 @@ SYM_CODE_START(\asmsym)
>   	 * stack.
>   	 */
>   	movq	%rsp, %rdi		/* pt_regs pointer */
> -	call	vc_switch_off_ist
> +	.if \vector == X86_TRAP_VC
> +		call	vc_switch_off_ist

I think the stack switching logic is similar for #VC & #HV.
So, we can use common function. Just the corresponding fallback
stack switching is different. Maybe we can pass the hint as an
argument (%rsi?) to something like "sev_switch_off_ist()", and use
the corresponding (#HV or #VC) fallbacks stack?

> +	.else
> +		call	hv_switch_off_ist	
> +	.endif
> +
>   	movq	%rax, %rsp		/* Switch to new stack */
>   
>   	ENCODE_FRAME_POINTER
> @@ -568,10 +577,7 @@ SYM_CODE_START(\asmsym)
>   
>   	/* Switch to the regular task stack */
>   .Lfrom_usermode_switch_stack_\@:
> -	idtentry_body user_\cfunc, has_error_code=1
> -
> -_ASM_NOKPROBE(\asmsym)
> -SYM_CODE_END(\asmsym)
> +	idtentry_body user_\cfunc, \has_error_code
>   .endm
>   #endif
>   
> diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
> index 462fc34f1317..2186ed601b4a 100644
> --- a/arch/x86/include/asm/cpu_entry_area.h
> +++ b/arch/x86/include/asm/cpu_entry_area.h
> @@ -30,6 +30,10 @@
>   	char	VC_stack[optional_stack_size];			\
>   	char	VC2_stack_guard[guardsize];			\
>   	char	VC2_stack[optional_stack_size];			\
> +	char	HV_stack_guard[guardsize];			\
> +	char	HV_stack[optional_stack_size];			\
> +	char	HV2_stack_guard[guardsize];			\
> +	char	HV2_stack[optional_stack_size];			\
>   	char	IST_top_guard[guardsize];			\
>   
>   /* The exception stacks' physical storage. No guard pages required */
> @@ -52,6 +56,8 @@ enum exception_stack_ordering {
>   	ESTACK_MCE,
>   	ESTACK_VC,
>   	ESTACK_VC2,
> +	ESTACK_HV,
> +	ESTACK_HV2,
>   	N_EXCEPTION_STACKS
>   };
>   
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index b241af4ce9b4..b0f3501b2767 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -317,6 +317,19 @@ static __always_inline void __##func(struct pt_regs *regs)
>   	__visible noinstr void kernel_##func(struct pt_regs *regs, unsigned long error_code);	\
>   	__visible noinstr void   user_##func(struct pt_regs *regs, unsigned long error_code)
>   
> +
> +/**
> + * DECLARE_IDTENTRY_HV - Declare functions for the HV entry point
> + * @vector:	Vector number (ignored for C)
> + * @func:	Function name of the entry point
> + *
> + * Maps to DECLARE_IDTENTRY_RAW, but declares also the user C handler.
> + */
> +#define DECLARE_IDTENTRY_HV(vector, func)				\
> +	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func);			\
> +	__visible noinstr void kernel_##func(struct pt_regs *regs);	\
> +	__visible noinstr void   user_##func(struct pt_regs *regs)
> +
>   /**
>    * DEFINE_IDTENTRY_IST - Emit code for IST entry points
>    * @func:	Function name of the entry point
> @@ -376,6 +389,26 @@ static __always_inline void __##func(struct pt_regs *regs)
>   #define DEFINE_IDTENTRY_VC_USER(func)				\
>   	DEFINE_IDTENTRY_RAW_ERRORCODE(user_##func)
>   
> +/**
> + * DEFINE_IDTENTRY_HV_KERNEL - Emit code for HV injection handler
> + *			       when raised from kernel mode
> + * @func:	Function name of the entry point
> + *
> + * Maps to DEFINE_IDTENTRY_RAW
> + */
> +#define DEFINE_IDTENTRY_HV_KERNEL(func)					\
> +	DEFINE_IDTENTRY_RAW(kernel_##func)
> +
> +/**
> + * DEFINE_IDTENTRY_HV_USER - Emit code for HV injection handler
> + *			     when raised from user mode
> + * @func:	Function name of the entry point
> + *
> + * Maps to DEFINE_IDTENTRY_RAW
> + */
> +#define DEFINE_IDTENTRY_HV_USER(func)					\
> +	DEFINE_IDTENTRY_RAW(user_##func)
> +
>   #else	/* CONFIG_X86_64 */
>   
>   /**
> @@ -463,8 +496,10 @@ __visible noinstr void func(struct pt_regs *regs,			\
>   	DECLARE_IDTENTRY(vector, func)
>   
>   # define DECLARE_IDTENTRY_VC(vector, func)				\
> -	idtentry_vc vector asm_##func func
> +	idtentry_sev vector asm_##func func has_error_code=1
>   
> +# define DECLARE_IDTENTRY_HV(vector, func)				\
> +	idtentry_sev vector asm_##func func has_error_code=0
>   #else
>   # define DECLARE_IDTENTRY_MCE(vector, func)				\
>   	DECLARE_IDTENTRY(vector, func)
> @@ -618,9 +653,10 @@ DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
>   DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP,	exc_control_protection);
>   #endif
>   
> -/* #VC */
> +/* #VC & #HV */
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   DECLARE_IDTENTRY_VC(X86_TRAP_VC,	exc_vmm_communication);
> +DECLARE_IDTENTRY_HV(X86_TRAP_HV,	exc_hv_injection);
>   #endif
>   
>   #ifdef CONFIG_XEN_PV
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index e9e2c3ba5923..0bd7dab676c5 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -29,6 +29,7 @@
>   #define	IST_INDEX_DB		2
>   #define	IST_INDEX_MCE		3
>   #define	IST_INDEX_VC		4
> +#define	IST_INDEX_HV		5
>   
>   /*
>    * Set __PAGE_OFFSET to the most negative possible address +
> diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
> index f5d2325aa0b7..c6583631cecb 100644
> --- a/arch/x86/include/asm/trapnr.h
> +++ b/arch/x86/include/asm/trapnr.h
> @@ -26,6 +26,7 @@
>   #define X86_TRAP_XF		19	/* SIMD Floating-Point Exception */
>   #define X86_TRAP_VE		20	/* Virtualization Exception */
>   #define X86_TRAP_CP		21	/* Control Protection Exception */
> +#define X86_TRAP_HV		28	/* HV injected exception in SNP restricted mode */
>   #define X86_TRAP_VC		29	/* VMM Communication Exception */
>   #define X86_TRAP_IRET		32	/* IRET Exception */
>   
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index 47ecfff2c83d..6795d3e517d6 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -16,6 +16,7 @@ asmlinkage __visible notrace
>   struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
>   void __init trap_init(void);
>   asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
> +asmlinkage __visible noinstr struct pt_regs *hv_switch_off_ist(struct pt_regs *eregs);
>   #endif
>   
>   extern bool ibt_selftest(void);
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 8cd4126d8253..5bc44bcf6e48 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2172,6 +2172,7 @@ static inline void tss_setup_ist(struct tss_struct *tss)
>   	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
>   	/* Only mapped when SEV-ES is active */
>   	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
> +	tss->x86_tss.ist[IST_INDEX_HV] = __this_cpu_ist_top_va(HV);
>   }
>   
>   #else /* CONFIG_X86_64 */
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index f05339fee778..6d8f8864810c 100644
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -26,11 +26,14 @@ static const char * const exception_stack_names[] = {
>   		[ ESTACK_MCE	]	= "#MC",
>   		[ ESTACK_VC	]	= "#VC",
>   		[ ESTACK_VC2	]	= "#VC2",
> +		[ ESTACK_HV	]	= "#HV",
> +		[ ESTACK_HV2	]	= "#HV2",
> +		
>   };
>   
>   const char *stack_type_name(enum stack_type type)
>   {
> -	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
> +	BUILD_BUG_ON(N_EXCEPTION_STACKS != 8);
>   
>   	if (type == STACK_TYPE_TASK)
>   		return "TASK";
> @@ -89,6 +92,8 @@ struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
>   	EPAGERANGE(MCE),
>   	EPAGERANGE(VC),
>   	EPAGERANGE(VC2),
> +	EPAGERANGE(HV),
> +	EPAGERANGE(HV2),
>   };
>   
>   static __always_inline bool in_exception_stack(unsigned long *stack, struct stack_info *info)
> @@ -98,7 +103,7 @@ static __always_inline bool in_exception_stack(unsigned long *stack, struct stac
>   	struct pt_regs *regs;
>   	unsigned int k;
>   
> -	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
> +	BUILD_BUG_ON(N_EXCEPTION_STACKS != 8);
>   
>   	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
>   	/*
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index a58c6bc1cd68..48c0a7e1dbcb 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -113,6 +113,7 @@ static const __initconst struct idt_data def_idts[] = {
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   	ISTG(X86_TRAP_VC,		asm_exc_vmm_communication, IST_INDEX_VC),
> +	ISTG(X86_TRAP_HV,		asm_exc_hv_injection, IST_INDEX_HV),
>   #endif
>   
>   	SYSG(X86_TRAP_OF,		asm_exc_overflow),
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 20f3fd8ade2f..7b06d7c0914f 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2006,6 +2006,59 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
>   	irqentry_exit_to_user_mode(regs);
>   }
>   
> +static bool hv_raw_handle_exception(struct pt_regs *regs)
> +{
> +	return false;
> +}
> +
> +static __always_inline bool on_hv_fallback_stack(struct pt_regs *regs)
> +{

Don't see this functioned used yet?

> +	unsigned long sp = (unsigned long)regs;
> +
> +	return (sp >= __this_cpu_ist_bottom_va(HV2) && sp < __this_cpu_ist_top_va(HV2));
> +}
> +
> +DEFINE_IDTENTRY_HV_USER(exc_hv_injection)
> +{
> +	irqentry_enter_from_user_mode(regs);
> +	instrumentation_begin();
> +
> +	if (!hv_raw_handle_exception(regs)) {
> +		/*
> +		 * Do not kill the machine if user-space triggered the
> +		 * exception. Send SIGBUS instead and let user-space deal
> +		 * with it.
> +		 */
> +		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
> +	}
> +
> +	instrumentation_end();
> +	irqentry_exit_to_user_mode(regs);
> +}
> +
> +DEFINE_IDTENTRY_HV_KERNEL(exc_hv_injection)
> +{
> +	irqentry_state_t irq_state;
> +
> +	irq_state = irqentry_enter(regs);

Any reason for not using "irqentry_nmi_enter" here?
We are dispatching both irqs & NMI's right?

Thanks,
Pankaj
> +	instrumentation_begin();
> +
> +	if (!hv_raw_handle_exception(regs)) {
> +		pr_emerg("PANIC: Unhandled #HV exception in kernel space\n");
> +
> +		/* Show some debug info */
> +		show_regs(regs);
> +
> +		/* Ask hypervisor to sev_es_terminate */
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
> +
> +		panic("Returned from Terminate-Request to Hypervisor\n");
> +	}
> +
> +	instrumentation_end();
> +	irqentry_exit(regs, irq_state);
> +}
> +
>   bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>   {
>   	unsigned long exit_code = regs->orig_ax;
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index d317dc3d06a3..d29debec8134 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -905,6 +905,46 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
>   
>   	return regs_ret;
>   }
> +
> +asmlinkage __visible noinstr struct pt_regs *hv_switch_off_ist(struct pt_regs *regs) > +{
> +	unsigned long sp, *stack;
> +	struct stack_info info;
> +	struct pt_regs *regs_ret;
> +
> +	/*
> +	 * In the SYSCALL entry path the RSP value comes from user-space - don't
> +	 * trust it and switch to the current kernel stack
> +	 */
> +	if (ip_within_syscall_gap(regs)) {
> +		sp = this_cpu_read(pcpu_hot.top_of_stack);
> +		goto sync;
> +	}
> +
> +	/*
> +	 * From here on the RSP value is trusted. Now check whether entry
> +	 * happened from a safe stack. Not safe are the entry or unknown stacks,
> +	 * use the fall-back stack instead in this case.
> +	 */
> +	sp    = regs->sp;
> +	stack = (unsigned long *)sp;
> +
> +	if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
> +	    info.type > STACK_TYPE_EXCEPTION_LAST)
> +		sp = __this_cpu_ist_top_va(HV2);
> +sync:
> +	/*
> +	 * Found a safe stack - switch to it as if the entry didn't happen via
> +	 * IST stack. The code below only copies pt_regs, the real switch happens
> +	 * in assembly code.
> +	 */
> +	sp = ALIGN_DOWN(sp, 8) - sizeof(*regs_ret);
> +
> +	regs_ret = (struct pt_regs *)sp;
> +	*regs_ret = *regs;
> +
> +	return regs_ret;
> +}
>   #endif
>   
>   asmlinkage __visible noinstr struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index e91500a80963..97554fa0ff30 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -160,6 +160,8 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
>   		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
>   			cea_map_stack(VC);
>   			cea_map_stack(VC2);
> +			cea_map_stack(HV);
> +			cea_map_stack(HV2);
>   		}
>   	}
>   }

