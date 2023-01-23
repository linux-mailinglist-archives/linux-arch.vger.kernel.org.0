Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0B6775A0
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 08:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjAWHeC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 02:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAWHeB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 02:34:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6114518AB7;
        Sun, 22 Jan 2023 23:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH+dfU2UnrVM9uo3vnzilr9f26vGDEWh7XLzWCQJvItG8LgwgscFtrTulZZguExDkRYVs2KgZDBC6shoHLzh2Cr0F6iW/swc0DLl1JE/guuZj7YqF92WzsZ5HHFpA+smgiTDSscgPRR3TEVPBe+7m2h4ee9Sx+gWAvReKI2RxcCl7qRqVZ51QOJdGqbVqjW8TUXJA5uA01pS5sXaL+J0lJpne81QhGQycnW7NhDwl68D1sR/rJ4Rd6oXegufCKUTDMBbay9UmI3ufXvtWLsexSvi/kqEIhTo3ApQZSeTjHKnD88CAIURsPK0D/PO9sgadZIv2CdX05npm94YQ/xL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QahO2BI9cIcDiSHhB2Fv1Rd2uyX6n2wOQJgDs16dLZg=;
 b=NEXdiyc8iIF0gecFphnZ3wA5wD8mImJv2hoaElqPsrVilFfGal22BGwLcX7pFl1+4r+T/cH9ZfRgW5/ujT9HSLwkuFXRwaxAi6yW4NEhDNNJz/gsIty/IUEFQm34YEUU/FwxJCuuBHWLD70DvY7Smp3xGvHrRHo7BB/dVbDD/TfgbBNa2J3mTzY439RQ4Hvq9cnp/O9OkFvBtzYvQQYPw0Pxo1Zr2IWAN65RLGJaq37AtXbLe7hHhAtRtOF1P1rf4KD2Lpb5AiFsGp4bDvArgE86+rPzkqofzJicXR4pPiUna4ocx/0XBWqX3zxZh7Ozese92+YrucjRmjGeXXU5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QahO2BI9cIcDiSHhB2Fv1Rd2uyX6n2wOQJgDs16dLZg=;
 b=U7bLMzxXkqhPXzMrnJGoTIxCH8Y+lKevaRTUKYpjmM8OobeGrShqNHl9lrZTo+1VGt02IQ8UX6yEST2VXQ7OOHOb+jsL8MxABp6dwZnSMBpJndVK4QypTVQ5HFRU4W3xP+Ri1LLvuZkFegOnCE1kK8u9mck6DJ9P3ToHdng4wUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Mon, 23 Jan 2023 07:33:53 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::c2ca:f7ae:4ba4:eff5]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::c2ca:f7ae:4ba4:eff5%2]) with mapi id 15.20.6002.027; Mon, 23 Jan 2023
 07:33:43 +0000
Message-ID: <0098b974-7ceb-664a-aa53-afac8cc26d47@amd.com>
Date:   Mon, 23 Jan 2023 08:33:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 12/16] x86/sev: Add a #HV exception handler
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
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-13-ltykernel@gmail.com>
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230122024607.788454-13-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 400f3620-55ac-46dd-0069-08dafd142761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoXyqH6n7SDzGjdAfRA+YsFPHyjvRxnP1uTrqsOekMWkd4rpwWfzhQ3F9ycUu+xwUOp1yo6AGP4PEATmgeG9nE5uR5Sc8eDTTXRMyJ3aZd/QoodSxmUe6BOCq1Ln4P9cF53V8hx+Zoh+5NXFs5vFLlysATdGQ8ZDAKqW6tpN1mmj9NSYCQIuWT2B+1FjUbTlImqbYxBTL9RMRAKpxAy9v10r+dvzJxUbkBMcuV4sLS5/eIZP42jJUBoklTkdnQuiM4c00NuMqdDM6b5K9rnmAYJzfQii4y7XwQNj1gRlL79ZyV/Es1UNpK3J8ujvp3ldiB4WlholugrTyzkFG7ViJOF40lilqTYgI0KilLlEkWVuWKavsGkXNcNVxuEkEU1i9W6LKLccA72ijGeI6ziUmeSlAZlZQu1xlM7HRuS6Wm1pul7hFjJAcdc6ts5+tMvl9nLn+NkiI/t2pW/oCl1OIJfqllQNHNIJ9qrYeq1JfmwfvoTJOkLqKQGHboP2/uQ3x+zOocFih6Mb1Cm6F0ejbrLNHO2hdMHhcQ8V6SmH2ecXLXcXrpMHKUzVQ37OfFwPJyo+V49v1tQPTLhkslSOR23Ts4UZ+j0R5c7djnJS/JfuwRzbYQf+RFN9I98qPFS2Il6qAlBvjhfiDADiQ1imlsSNbTu+n7PWHEdgsVAEllTsIL2gdwIqe6ksM1T+sRk6w3yyaVJXQlemjBNAVR9au1LQLmB/SUrK3im8uRc/u6AorYeoXe3sr+PsV0xlBifiZjIG0Abf+mS6btFEDeXZSyI1ulODCkNL9FOPX5SV0pE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199015)(38100700002)(36756003)(921005)(31696002)(86362001)(6666004)(186003)(26005)(6506007)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(6486002)(966005)(478600001)(45080400002)(6512007)(2616005)(31686004)(2906002)(7416002)(7406005)(5660300002)(30864003)(83380400001)(41300700001)(8936002)(66899015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkt6emZxalRwZjJTK1Vyd3h0cmFxUFY0Tlo3c1FiNnM5eFYwc1JOdXFHWkNs?=
 =?utf-8?B?TmROMVVmbUFiZkxiMHgxV0RGbTNvMFFoeHQ3UTk2Syt4ZjdlVEl4Zm5KdmtB?=
 =?utf-8?B?bEk1aTl3NE12NFo5OHN6RHRrUE5pcGhSWTNna21aS1RWalpPRlREWTZabWFC?=
 =?utf-8?B?TGFEVEs5U1RQMlk1Ung4K3FPQ2JpYnJKcVE5V0hGZ2htY1g4UW9vZklQUDAy?=
 =?utf-8?B?Skw1aDRVUThQMDc2a0ppWmI0M2UwWk9WVVk4MW9ac2lvQjdEY2lnalNiSVNa?=
 =?utf-8?B?c3VMVFRoVFp5WStPMzZSM2ZGSXp4ZmIyUjA1MmljeHlYbEQ1aUJqMGlrd3lx?=
 =?utf-8?B?TC9sRUtSUXdsUWtFeTVvT3pQeHh1Y0E1OWJLelc1YTVaSDRsYkttaUdCbVZM?=
 =?utf-8?B?RjZPcEdUa1F2c2tUQ3FxdzZHVlZPUjUxRTBINlVTbjV6WWNYU1kyWXhlU0dC?=
 =?utf-8?B?Y0pwVG9YMEtyQlRHaU9RbmlVbzh3aWNSTE50U3FJUVNlbll1ZE9BNm5aZkxu?=
 =?utf-8?B?QW5pWHdJdmcrVzFsVE03Zk9Nd0FBSHNHcUxlVXdVaTM2N3ROTDUraUpDRXg4?=
 =?utf-8?B?UnUwd254SDJpSk1lRGo5S2tycGM3aEhoOXY1ZFZJTDBJd0xPTWN4bVRrQ2JH?=
 =?utf-8?B?akltaTJneXRoZUFQOEF6blVZZkg1Ky9EQWI0Wmw1YlVoN3djZ2RTam9aVTJ0?=
 =?utf-8?B?WmtjTE9vSzBxREQ1U1ZLMGxwaktUK1lPNjFJUVhDOUpIb1RqNmRybzdtYlR1?=
 =?utf-8?B?cUMxUHlYZ2hRQjFPdlN0NG9lQWl4TlAzeTBFZVdQY3BUM0JLN2ZqQlNwVjBG?=
 =?utf-8?B?dDJZeVhqS0JUQXUxeWxmZXNId3RpQmFkaWE0NVMrWGYvNlk0bkNGRGF6eVNp?=
 =?utf-8?B?bkJWVllsMSszMDdOZ25FaFdIa3lNU0Q5L2prL0R2blhVSVNtYUExalYwYjUx?=
 =?utf-8?B?ZGwrTm96UlZRYXdTZWtLYi9Vd25LK3RvNHEwbXR3aElMU2lqZ01WcnhZby9Q?=
 =?utf-8?B?UjFjU09McU0rVkRiSXRvbDRLbGJlWDhsTUZrY1FFRTB6S3M2Z0ZFeWNYS3RU?=
 =?utf-8?B?SlpxY09ud0h3b2IvMFp0K3pBaHhwTEU5dzJweHh5L0VMSXRXOFRxZHliZFJn?=
 =?utf-8?B?cThyOFZXaVNhbkJIdGZBck4vdTd1MFo1L3RMamY5dDQ5NGp4a29XeHhYSENa?=
 =?utf-8?B?dVNQN1VBL004dWFQMkF2UUlQQVFtT01FN2ZkMEtBZUN6cWFUcTdxZEpCc0FU?=
 =?utf-8?B?ZUpJR0NrLzZXQmZERnNrUnlpa0RZSDdoNkRhQjVscG5TUzViL0tSY092R2F5?=
 =?utf-8?B?SFNzR2VJbXFoam9QTXdIRmZXZHA1RVBKbFVvN0xCNWt5NThXZ2RCMllHTms0?=
 =?utf-8?B?Q0kvVDljMm4rUzRROVNVTVhOMVFINDJSOTlqSFNiYzNPcWc3RklkZE01ajFZ?=
 =?utf-8?B?UDh2U1RQckF6ZEhsMnpHZXhQS0llQUFwSklZZVB6aGFtcGpDY2thTGxTUFlj?=
 =?utf-8?B?U0piNCtmSjNjaWJuRzErL01hRmZabkVORlA0Mm56cGc4Ym5STmd6Z3I5ZVVz?=
 =?utf-8?B?bTNoTWY0c2U3K0RkVjUvaXJESzVHNFdYcS8yYy9PaTRkZGh6Z1llVzVpeE5I?=
 =?utf-8?B?eGtqdjJzUHQ1UmZJaU9QbG9wVHdZRDNDR2Nmc1pjN0xlUlZkQUVueWp2WldI?=
 =?utf-8?B?dkxXY0tGMTk5ZldUYW9neDRFSzZ6dXF1aDg3clJuc1ZaNFQyVWkvQ2lRd1dO?=
 =?utf-8?B?M2JXclRDRHR2ZnAzQnFoMThVN3lmck5qSy9IQldnUFhRTGs0V1ptZ2NYVzJN?=
 =?utf-8?B?c2dkaDBlcFFaTXhoZ2FIOEpkRU5SaHV1UndOSE93bHI3MG9YS1NtdHFlMHht?=
 =?utf-8?B?OE1XVVgwTVUyMW1wVDkvKzVIa1diWFdYdzBacEFKeVorQml2ZER3UXlSL25T?=
 =?utf-8?B?RUZiZkQrcWtGTkdSakttVE5SQ0NCNThjM1JqbGFyN2laclF2MkVlZld2cDJ4?=
 =?utf-8?B?WTlHN3dMVzdmN0poNEtseXJuZDRMTk5EMzJnS0JtSGtIMy84dHNvOFkwbjVx?=
 =?utf-8?B?NHFERUt6VnVyNURBOEtkN01ZWUNhckNvQWNKSWt2L1hFZkw2dEZKKy96cXlo?=
 =?utf-8?Q?Rn2DNvfcSS69Xga0u8PMUKyb0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400f3620-55ac-46dd-0069-08dafd142761
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 07:33:43.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apXeZWXoeCEN5KsHIJZRdwjEDvCBfOmSC9pYlIzokRYIYMTfLd+SxmQoh3kflKW3WbmRy3Zc2C+LrwdtcqHESg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tianyu,

Just trying to skim over what all changed in this version.

> From: Tianyu Lan <tiala@microsoft.com>
> 
> Add a #HV exception handler that uses IST stack.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V2:
>         * Remove unnecessary line in the change log.
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
>   arch/x86/kernel/traps.c               | 40 ++++++++++++++++++
>   arch/x86/mm/cpu_entry_area.c          |  2 +
>   12 files changed, 209 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 15739a2c0983..6baec7653f19 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -563,6 +563,64 @@ SYM_CODE_START(\asmsym)
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

seems you did not remove this line in the comment.

> + */
> +.macro idtentry_hv vector asmsym cfunc
> +SYM_CODE_START(\asmsym)
> +	UNWIND_HINT_IRET_REGS
> +	ASM_CLAC

Did you get a chance to review the new instructions
added at the start similar to idtentry_vc and comments
added assuggested here?

https://lore.kernel.org/lkml/16e50239-39b2-4fb4-5110-18f13ba197fe@amd.com/

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
> index 9cfca3d7d0e2..e48a489777ec 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2162,6 +2162,7 @@ static inline void tss_setup_ist(struct tss_struct *tss)
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
> index 679026a640ef..a8862a2eff67 100644
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
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index d317dc3d06a3..d29debec8134 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -905,6 +905,46 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
>   
>   	return regs_ret;
>   }
> +
> +asmlinkage __visible noinstr struct pt_regs *hv_switch_off_ist(struct pt_regs *regs)
> +{
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
> index 7316a8224259..3ec844cef652 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -153,6 +153,8 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
>   		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
>   			cea_map_stack(VC);
>   			cea_map_stack(VC2);
> +			cea_map_stack(HV);
> +			cea_map_stack(HV2);
>   		}
>   	}
>   }

