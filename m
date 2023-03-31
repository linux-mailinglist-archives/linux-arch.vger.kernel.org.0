Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B676D2484
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 17:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjCaP5c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Mar 2023 11:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjCaP53 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 11:57:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB4D51A;
        Fri, 31 Mar 2023 08:57:19 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C1F91EC063A;
        Fri, 31 Mar 2023 17:57:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680278238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0rD3I7pDpzoNaSFC4TdHBq3s3XmiqLHEPo2QS3bW4YQ=;
        b=nZHaTl+2ItWGRQjk4Mi0AMnoMOfozXzlwllzqzhmqYQrDKcl1umRlwGNz90hJxrZOwPiIH
        edhamtvG6EZeSHa5v/SlFdtMiOwLFI5MH7UKUwjou+THlsPgNPu9UM2LacfWOotC8PVyAb
        PnyiUejhtkO3TkYtzCYAAhH8NA8Q6Cg=
Date:   Fri, 31 Mar 2023 17:57:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
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
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V3 12/16] x86/sev: Add a #HV exception handler
Message-ID: <20230331155714.GCZCcC2pHVZgIHr8k8@fat_crate.local>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-13-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230122024607.788454-13-ltykernel@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 21, 2023 at 09:46:02PM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Add a #HV exception handler that uses IST stack.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V2:
>        * Remove unnecessary line in the change log.
> ---
>  arch/x86/entry/entry_64.S             | 58 +++++++++++++++++++++++++++
>  arch/x86/include/asm/cpu_entry_area.h |  6 +++
>  arch/x86/include/asm/idtentry.h       | 39 +++++++++++++++++-
>  arch/x86/include/asm/page_64_types.h  |  1 +
>  arch/x86/include/asm/trapnr.h         |  1 +
>  arch/x86/include/asm/traps.h          |  1 +
>  arch/x86/kernel/cpu/common.c          |  1 +
>  arch/x86/kernel/dumpstack_64.c        |  9 ++++-
>  arch/x86/kernel/idt.c                 |  1 +
>  arch/x86/kernel/sev.c                 | 53 ++++++++++++++++++++++++
>  arch/x86/kernel/traps.c               | 40 ++++++++++++++++++
>  arch/x86/mm/cpu_entry_area.c          |  2 +
>  12 files changed, 209 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 15739a2c0983..6baec7653f19 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -563,6 +563,64 @@ SYM_CODE_START(\asmsym)
>  .Lfrom_usermode_switch_stack_\@:
>  	idtentry_body user_\cfunc, has_error_code=1
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
> + */
> +.macro idtentry_hv vector asmsym cfunc
> +SYM_CODE_START(\asmsym)

...

why is this so much duplicated code instead of sharing it with
idtentry_vc and all the facilities it does?

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
>  _ASM_NOKPROBE(\asmsym)
>  SYM_CODE_END(\asmsym)
>  .endm
> diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
> index 462fc34f1317..2186ed601b4a 100644
> --- a/arch/x86/include/asm/cpu_entry_area.h
> +++ b/arch/x86/include/asm/cpu_entry_area.h
> @@ -30,6 +30,10 @@
>  	char	VC_stack[optional_stack_size];			\
>  	char	VC2_stack_guard[guardsize];			\
>  	char	VC2_stack[optional_stack_size];			\
> +	char	HV_stack_guard[guardsize];			\
> +	char	HV_stack[optional_stack_size];			\
> +	char	HV2_stack_guard[guardsize];			\
> +	char	HV2_stack[optional_stack_size];			\
>  	char	IST_top_guard[guardsize];			\
>  
>  /* The exception stacks' physical storage. No guard pages required */
> @@ -52,6 +56,8 @@ enum exception_stack_ordering {
>  	ESTACK_MCE,
>  	ESTACK_VC,
>  	ESTACK_VC2,
> +	ESTACK_HV,
> +	ESTACK_HV2,
>  	N_EXCEPTION_STACKS

Ditto.

And so on...

Please share code - not duplicate.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
