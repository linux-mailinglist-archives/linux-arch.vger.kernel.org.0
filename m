Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0772B6640D2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 13:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbjAJMrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 07:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjAJMrt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 07:47:49 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C55006C;
        Tue, 10 Jan 2023 04:47:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXp3XIqRkEHh8wN0BjeGSLEX+LpruwMuIU2qRa7l1Cfa6mRu29chDKQkvKTEjvmP0Mvw96RaeP0WltClek9/iD5V+JNzAkp4YwpYbBBlDAYkStArsqpKSV7A/6+Fo09eDsCnJM3yjXsQPIarRphPRUEVcQKOaMYm/RKVHCTcei7MzUuSOw3MLOOEBoEBxBfhpvBSYG1/UMPe2AzdmszwbvwaAsK6wZ5DFEbRxwuwK1+ICiimB53AO2X38Y//MLcM/bD8kAKiheRFR4zfhMGFOSbr5RHM6JSXpaFJtjFbm6+k6ckI0H8Ky0UDcBrMPytgFY2OicO5379RYUO4jP1YwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+1fRhlrzf7Xuhq0OpbZEIOs7cx+71g0G63hKIspmEA=;
 b=YZI8W50ULhT9l9cg4X/xfsmcL5D0ifIg/a/g8xcisHQGfDYWJeiCxvR7B93PKWsYpADa4x/Bor8ANhcayG3ovFh0xDDHY7BZeKJ/DxDXYrKrrw+TMDlhNWkje/w9RqZ/nwqh2xeER69v1xhm3oPLEjVePGlI2TteOsw0BJdWPhrIM9zPTH4bcWaOsX0cG+8wJsNzVl7R8w4avyvfclzCI+e4UiJVaeExmi8SDPG5yS4md00gPX9ihV/94l7voqKCjIl9JGXeaZVJp+jFAM4cyh6+IcY+il8Y5xBuE9dxrtVGe1OaG3z2XfVxQiUVhdzw8iQJOP7DxsocE8iMEphwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+1fRhlrzf7Xuhq0OpbZEIOs7cx+71g0G63hKIspmEA=;
 b=Bc4m+Kqc04u3fHTxcJVPBunLfmmXPcDhRCYQPTUfgGkz2fU+c0EnV4QrUKSc3KPJOLXuXykw8S65f9R5qx9KbnHNrnGcdaWeSqhD8J+93MfWLPzFXY+/8Twfj1Y1tswXarXvZ1Yzobd3cwRyNS3uIveqkULqpdxJbFM5AFUNb+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 10 Jan 2023 12:47:44 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::c2ca:f7ae:4ba4:eff5]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::c2ca:f7ae:4ba4:eff5%2]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 12:47:44 +0000
Message-ID: <af54107e-a509-8f95-6044-b155539a590d@amd.com>
Date:   Tue, 10 Jan 2023 13:47:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V2 15/18] x86/sev: Add a #HV exception handler
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
 <20221119034633.1728632-16-ltykernel@gmail.com>
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221119034633.1728632-16-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 023e6a22-8ea3-4428-41e9-08daf308de48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9kHCBTXWxE92hqntUH5isaj1m7u4uOgprfXyKK5BMMd7zoO5MVi4fM4UGjXeOwg7XjZ9yZvTgKsVIMlHlOhBvQA1aWXZOh47R8ZrpkWR6HocYRQpbdLjkO9IWP72PHUmGqkQFGcS2qUScefea06cB977xwLhs5TDjzBCI/0F20gWfyF/PhDPR39PIP6oEnGOeBIuw8HrfjMv3OeXStQc/VGRo3JSUpM7gh4ZCJi5tQaip33VDrwZNq04O7tU3YEpsZbvRu/xUje2gX9nJEvsq/r8f20AGk3wYySUZFrtVT3Ri5u8YIdBj04P4s6a8C0I8VExIUxlhE9RbrmZ0ix06ARr47693cNH6/tj616VwEQ6gSM1kLvBQdS01c2ozk5pTDuip4IOjUHDZXc3Bs1tyD7pn1pEHa6y3k6XLIDGtRkPDqrUjkI0embrQgb3qzj8SuKylZnCdoPhutNlhDhD2CpLD642W7KzZCYi0FjwDP38KXDWDEaCNwzpRiPD0yFIZLAg/yxBsKFfKCr7GqiFgFy4+mqwMGs5Zgm6deQJEqq1PVnvWrWHDjMSxJmAtHRfYkveWiwr390STTH1dVXTLYUETSA6Z6GT1aDcWVWqrPX7e4itzzKZ7pdg1e7Jcx3hi7Lq5rm77gnIcfaI580MPYedQqAzioYPNX8QEGF2cTQ2GCvkMG+r/YjSvcoacQzEGCUBzWWER2PhnLqarjvEZHQdUNiCEldwcdNJicg95kss2M7J6rwsvRPJExmFxZ6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(41300700001)(8676002)(5660300002)(6666004)(478600001)(316002)(66556008)(66476007)(66899015)(66946007)(8936002)(4326008)(7416002)(45080400002)(2906002)(6486002)(921005)(6506007)(30864003)(38100700002)(86362001)(186003)(26005)(6512007)(2616005)(36756003)(7406005)(31686004)(83380400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJtcXJSTDJSYXZzWFJXaFpEM2pSZExGWWtjY0tJVWNTQ1RVSjlUelY1NGh0?=
 =?utf-8?B?L1hRd3lHM1BJMFViVk5qTmNIczZSWlV2anA5L0d2anZJWnJiNDFOWEs4U1Za?=
 =?utf-8?B?S3NKdGVrczJsd1pNcFV5bldkd0RPUnJKZVBpaTdwT3Q5Wm9uZ0RNd2d0MDhr?=
 =?utf-8?B?bVdrMVhmNCswc3pvY2VISFdCcGxNUXJhd1YvVHBpMXNQQW5DTUQ2bWtRMFZO?=
 =?utf-8?B?dGxsZW1ON3Y2ekV1a2dGelJ0eS94Y2hvcDNwVjJOOWxITE9zcTJpTjhyWXJ2?=
 =?utf-8?B?clpKM1JJTnpGTkYxVmVWbG5CbTV4UXFIcWwydXBWbDM4dGg5eGF3cU1XRURN?=
 =?utf-8?B?S0Q1YlJJN3d4Z3oyTzhmalY5em1rSm83bFpMeUt2MXlORUROdVFNMXQwRTZK?=
 =?utf-8?B?NTBmZmV6OFo3N1BZNlVRUGpuYkJQVThhUHFrWllZQ0VtVXdMOUlOVFFsYXA3?=
 =?utf-8?B?V2F1Nk5Qd0MwZUZYMCtLWHNmMkIzQlhLTjdvQnl0eFl2YnJQT2xzQ2NOUnlE?=
 =?utf-8?B?aDNicUpIVlRkVDlKZXREMlB3MHN2TE56Tm9WS0l4dURlc3BkMVZQdlBSczl6?=
 =?utf-8?B?bHVLcy8yY2FXbk5UZE5jdCswMWswMVpzZGNCajU1enlYL084UjNmekg0YmZo?=
 =?utf-8?B?T0JuVFlwbytTWGRwWEQ3aG9rakc2QVZ1R0JNaUIyV0NLVGViN0lUbC9GL1B3?=
 =?utf-8?B?dk5ib0toclprMWJteUI5ZldoazZMOWtCeUk1Q3ArSHU4MWlaeGZWWnJaNVJs?=
 =?utf-8?B?S3RJaUdxbGg0aFlMb203TkJWMy9nZkZtYzdFNW1wRVFXdGE3OE9LZUN1QS8r?=
 =?utf-8?B?U0tTM2FOU1Rtb01xLzViSjFxSjFlUlNETCt0c2VhQUdkUDhNL01lNGF5QlNz?=
 =?utf-8?B?L1VwRTBJUjNySnFVSHFEN3hlTk1nc1d1d2h1TVRySHRhMFQ3ZEtKSytCKzE3?=
 =?utf-8?B?UWRCUUpsR0Q1TnQrdzZldVJNV1kwVVVHRFcxR0VJQ25iUWFOTVpzb041QkV3?=
 =?utf-8?B?RXZraGZqMERDV0RqVlc1U1ZJNUI5S1FtMVNjUUMxV1pna1BtYWN4ZWZuY1Ft?=
 =?utf-8?B?SU9jenFub2hwc3NEMmdOQUZHYzZHMENhSHRZczFXeEVzZi9tUHZzbGNVZWY3?=
 =?utf-8?B?NWVqSmZlUlpyWml0c2MyNzQwTUFFMmRVdHJNNVJodGx6MnlGbzIwWWo4ZDQ3?=
 =?utf-8?B?SzNNRmRsUWVKK3ZMSHBJaGlrVkFBVU13VUd2NUs4blhEcHRPeWRYSFNDc3Nq?=
 =?utf-8?B?R25teERDVDdpbVFpazFpRXVjZlJ3dTJiQVlJd2NCd2xxenBObXgrVWlPbU9v?=
 =?utf-8?B?bExNL0VSTS9nWHpCKzNOR3VQNzdGSXExVlpvRFQ1RnNnaG4ybmpuMzRIdXJW?=
 =?utf-8?B?RmRPWjlDUTRJZncrbGo5WlFlWGZzbFNFQ2RmR2tNRksrZVplMU0wYTdPNUxp?=
 =?utf-8?B?SkExeGw4SDI0YWoyUnpvNm9ZZStvb0k5UENWZU5TUE1KMXJvRUY3bVB2Wm1w?=
 =?utf-8?B?cWh3V2pod3JZbmY4eGR5bDJGaVduUkxnNFZvZDFPbUcxOVVDL0xCV1lITVZH?=
 =?utf-8?B?SnFEU1E4dGtsMlgzbzk0MnJ5Y0lGU2tjM2JxVVlzQkp5ZFIrcWtSYlpFUm90?=
 =?utf-8?B?VmxTenlVZFpUdUN1UURUNlBUKzVCN0trdSs3cENMbkdMMFZmeGpqNk94RHFu?=
 =?utf-8?B?ajhWS0N1SXEwOTNDSjRVWWZ1RUxDWHlSN1BSZUtzQThXYm9ZOCtSR1ZLSEpi?=
 =?utf-8?B?eDk2YTBmc1NndTdxL1ZVWUdyQ29ybmYrMGoxeXF2WjJRakRTNWJHV0FZKzQv?=
 =?utf-8?B?Rm5uUEtVa2tpVjNMTTJ0YmFMSXBpYjNOc1JubC9pQ0hiRVFrdzZHNGRYQW45?=
 =?utf-8?B?bTVvTnV4b2dSZEV2TmNkVnhvWHhmMlJYUmg3SFFMaDZHNVJsZmJadnRCZlU4?=
 =?utf-8?B?YmhJWDlEYmlLQ0pnWE9ZTFNvMG8yRXg1SElYMHNOVXFNZi9nMEN0V3FiMEtk?=
 =?utf-8?B?cVVSQWtueTY1M1RiN0t3UXF1WXlrQ0h5Z3NxS1laaXdWVDU3eXVUd3ZmRHZH?=
 =?utf-8?B?UE5LTDJhNUxOQTZlMFUwSjVCYjhPQ2daTVU2LzJ4VXhIMW1OSjFaZUdyZFVp?=
 =?utf-8?Q?eRJETnFZJnoj/F3TDt+g5PPyB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023e6a22-8ea3-4428-41e9-08daf308de48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 12:47:44.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBkBbaOJS7lb2kPOzhVEcsB2IhdbNiLzgD+s1D5iAVBLmMHz9uQj2gFr/ytn73+rsNiDZ8eb6PH8cTvnbb+/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Add a #HV exception handler that uses IST stack.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/entry/entry_64.S             | 58 +++++++++++++++++++++++++++
>   arch/x86/include/asm/cpu_entry_area.h |  6 +++
>   arch/x86/include/asm/idtentry.h       | 39 +++++++++++++++++-
>   arch/x86/include/asm/page_64_types.h  |  1 +
>   arch/x86/include/asm/trapnr.h         |  1 +
>   arch/x86/include/asm/traps.h          |  1 +
>   arch/x86/kernel/cpu/common.c          |  1 +
>   arch/x86/kernel/dumpstack_64.c        |  9 ++++-
>   arch/x86/kernel/idt.c                 |  1 +
>   arch/x86/kernel/sev.c                 | 53 ++++++++++++++++++++++++
>   arch/x86/mm/cpu_entry_area.c          |  2 +
>   11 files changed, 169 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 9953d966d124..b2059df43c57 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -560,6 +560,64 @@ SYM_CODE_START(\asmsym)
>   .Lfrom_usermode_switch_stack_\@:
>   	idtentry_body user_\cfunc, has_error_code=1
>   
> +_ASM_NOKPROBE(\asmsym)
> +SYM_CODE_END(\asmsym)
> +.endm
> +/*
> + * idtentry_hv - Macro to generate entry stub for #HV
> + * @vector:		Vector number
> + * @asmsym:		ASM symbol for the entry point
> + * @cfunc:		C function to be called
> + *
> + * The macro emits code to set up the kernel context for #HV. The #HV handler
> + * runs on an IST stack and needs to be able to support nested #HV exceptions.
> + *
> + * To make this work the #HV entry code tries its best to pretend it doesn't use
> + * an IST stack by switching to the task stack if coming from user-space (which
> + * includes early SYSCALL entry path) or back to the stack in the IRET frame if
> + * entered from kernel-mode.
> + *
> + * If entered from kernel-mode the return stack is validated first, and if it is
> + * not safe to use (e.g. because it points to the entry stack) the #HV handler
> + * will switch to a fall-back stack (HV2) and call a special handler function.
> + *
> + * The macro is only used for one vector, but it is planned to be extended in
> + * the future for the #HV exception.

Noticed same comment line in the #VC exception handling section (macro 
idtentry_vc). Just wondering we need to remove this line as the patch 
being proposed for the #HV exception handling? unless this is planned to 
be extended in some other way.

Thanks,
Pankaj

> + */
> +.macro idtentry_hv vector asmsym cfunc
> +SYM_CODE_START(\asmsym)
> +	UNWIND_HINT_IRET_REGS
> +	ASM_CLAC
> +	pushq	$-1			/* ORIG_RAX: no syscall to restart */
> +
> +	testb	$3, CS-ORIG_RAX(%rsp)
> +	jnz	.Lfrom_usermode_switch_stack_\@
> +
> +	call	paranoid_entry
> +
> +	UNWIND_HINT_REGS
> +
> +	/*
> +	 * Switch off the IST stack to make it free for nested exceptions.
> +	 */
> +	movq	%rsp, %rdi		/* pt_regs pointer */
> +	call	hv_switch_off_ist
> +	movq	%rax, %rsp		/* Switch to new stack */
> +
> +	UNWIND_HINT_REGS
> +
> +	/* Update pt_regs */
> +	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
> +	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> +
> +	movq	%rsp, %rdi		/* pt_regs pointer */
> +	call	kernel_\cfunc
> +
> +	jmp	paranoid_exit
> +
> +.Lfrom_usermode_switch_stack_\@:
> +	idtentry_body user_\cfunc, has_error_code=1
> +
>   _ASM_NOKPROBE(\asmsym)
>   SYM_CODE_END(\asmsym)
>   .endm
> diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
> index 75efc4c6f076..f173a16cfc59 100644
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
> index 72184b0b2219..652fea10d377 100644
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
> @@ -465,6 +498,9 @@ __visible noinstr void func(struct pt_regs *regs,			\
>   # define DECLARE_IDTENTRY_VC(vector, func)				\
>   	idtentry_vc vector asm_##func func
>   
> +# define DECLARE_IDTENTRY_HV(vector, func)				\
> +	idtentry_hv vector asm_##func func
> +
>   #else
>   # define DECLARE_IDTENTRY_MCE(vector, func)				\
>   	DECLARE_IDTENTRY(vector, func)
> @@ -622,9 +658,10 @@ DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
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
> index 3e508f239098..87afa3a4c8b1 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2165,6 +2165,7 @@ static inline void tss_setup_ist(struct tss_struct *tss)
>   	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
>   	/* Only mapped when SEV-ES is active */
>   	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
> +	tss->x86_tss.ist[IST_INDEX_HV] = __this_cpu_ist_top_va(HV);
>   }
>   
>   #else /* CONFIG_X86_64 */
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index 6c5defd6569a..23aa5912c87a 100644
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
> index a428c62330d3..b54ee3ba37b0 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2004,6 +2004,59 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
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
> +	irq_state = irqentry_nmi_enter(regs);
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
> +	irqentry_nmi_exit(regs, irq_state);
> +}
> +
>   bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>   {
>   	unsigned long exit_code = regs->orig_ax;
> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index 6c2f1b76a0b6..8b1670fa2b81 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -115,6 +115,8 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
>   		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
>   			cea_map_stack(VC);
>   			cea_map_stack(VC2);
> +			cea_map_stack(HV);
> +			cea_map_stack(HV2);
>   		}
>   	}
>   }

