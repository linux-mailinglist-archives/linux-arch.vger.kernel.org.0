Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9B8F01C
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfHOQGh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 12:06:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfHOQGg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 12:06:36 -0400
Received: from zn.tnic (p200300EC2F0B52001DDC45CCE62FC494.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:1ddc:45cc:e62f:c494])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A5CD1EC04CD;
        Thu, 15 Aug 2019 18:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565885195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bPhqNHq9xLg3oM0xhMw8/A7vsTm8jGZ/OhyfKfI6CJw=;
        b=S0+BEgcYrFPvV35Uu8HTodRJwAgyRR//ra0yGHJdXMdijeCgSL++u86I7+Wves5VqY+XqN
        0WYfoVGCvH2pIC1PL3gSieEnBrkrrtbNgKg/rwLbm7/tEKwybLQUPGNfs+Phba8leQO7Of
        JzhKlHYmuqZ48IAnzt2BZsYjEuSimQY=
Date:   Thu, 15 Aug 2019 18:07:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/28] x86/asm: annotate local pseudo-functions
Message-ID: <20190815160719.GI15313@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-6-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-6-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 08, 2019 at 12:38:31PM +0200, Jiri Slaby wrote:
> Use the newly added SYM_CODE_START_LOCAL* to annotate starts of all
> pseudo-functions (those ending END until now) which do not have ".globl"
> annotation. This is needed to balance END for tools that generate
> debuginfo. Note that we switch from END to SYM_CODE_END too so that
> everybody can see the pairing.

Please get rid of the "we" etc personal pronouns in the commit messages
and make them all impartial and passive.

> We are not annotating C-like functions (which handle frame ptr etc.)
> here, hence we use SYM_CODE_* macros here, not SYM_FUNC_*.  Note that
> early_idt_handler_common already had ENDPROC -- switch that to
> SYM_CODE_END for the same reason as above.
> 
> bogus_64_magic, bad_address, bad_get_user*, and bad_put_user are now
> aligned, as they are separate functions. They do not mind to be aligned
> -- no need to be compact there.
> 
> early_idt_handler_common is aligned now too, as it is after
> early_idt_handler_array, so as well no need to be compact there.
> 
> verify_cpu is self-standing and included in other .S files, so align it
> too.
> 
> The others have alignment preserved to what it used to be (using the
> _NOALIGN variant of macros).
> 
> [v3] annotate more functions
> [v4] describe the alignments changes
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> ---
>  arch/x86/entry/entry_64.S        | 3 ++-
>  arch/x86/kernel/acpi/wakeup_64.S | 3 ++-
>  arch/x86/kernel/head_32.S        | 4 ++--
>  arch/x86/kernel/head_64.S        | 4 ++--
>  arch/x86/kernel/verify_cpu.S     | 4 ++--
>  arch/x86/lib/getuser.S           | 6 ++++--
>  arch/x86/lib/putuser.S           | 3 ++-
>  7 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 9701464341e4..68cb3a9ee65e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1059,7 +1059,7 @@ EXPORT_SYMBOL(native_load_gs_index)
>  	_ASM_EXTABLE(.Lgs_change, bad_gs)
>  	.section .fixup, "ax"
>  	/* running with kernelgs */
> -bad_gs:
> +SYM_CODE_START_LOCAL_NOALIGN(bad_gs)
>  	SWAPGS					/* switch back to user gs */
>  .macro ZAP_GS
>  	/* This can't be a string because the preprocessor needs to see it. */
> @@ -1070,6 +1070,7 @@ bad_gs:
>  	xorl	%eax, %eax
>  	movl	%eax, %gs
>  	jmp	2b
> +SYM_CODE_END(bad_gs)
>  	.previous
>  

That can be made a local label:

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index be9ca198c581..ed4f2b6e29d5 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1058,11 +1058,12 @@ ENTRY(native_load_gs_index)
 ENDPROC(native_load_gs_index)
 EXPORT_SYMBOL(native_load_gs_index)
 
-	_ASM_EXTABLE(.Lgs_change, bad_gs)
+	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
 	.section .fixup, "ax"
 	/* running with kernelgs */
-bad_gs:
+.Lbad_gs:
 	SWAPGS					/* switch back to user gs */
+
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
 	movl $__USER_DS, %eax

>  /* Call softirq on interrupt stack. Interrupts are off. */
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index a142c5ee0d4f..9f1852428a2d 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -37,8 +37,9 @@ ENTRY(wakeup_long64)
>  	jmp	*%rax
>  ENDPROC(wakeup_long64)
>  
> -bogus_64_magic:
> +SYM_CODE_START_LOCAL(bogus_64_magic)
>  	jmp	bogus_64_magic
> +SYM_CODE_END(bogus_64_magic)

That thing is not really needed if we do the below.

It even tries to say that the magic was bad in %rcx if you can inspect
registers when the endless loop happens...

:-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index a142c5ee0d4f..2ae21cc5a67c 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -18,10 +18,16 @@ ENTRY(wakeup_long64)
 	movq	saved_magic, %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
-	jne	bogus_64_magic
+	je	2f
 
+	/* stop here on a saved_magic mismatch */
+	movq	$0xbad0fa61c, %rcx
+1:
+	jmp	1b
+
+2:
 	movw	$__KERNEL_DS, %ax
-	movw	%ax, %ss	
+	movw	%ax, %ss
 	movw	%ax, %ds
 	movw	%ax, %es
 	movw	%ax, %fs
@@ -37,9 +43,6 @@ ENTRY(wakeup_long64)
 	jmp	*%rax
 ENDPROC(wakeup_long64)
 
-bogus_64_magic:
-	jmp	bogus_64_magic
-
 ENTRY(do_suspend_lowlevel)
 	FRAME_BEGIN
 	subq	$8, %rsp

>  
>  ENTRY(do_suspend_lowlevel)
>  	FRAME_BEGIN
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index d1e213da4782..0bae769b7b59 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -409,7 +409,7 @@ ENTRY(early_idt_handler_array)
>  	.endr
>  ENDPROC(early_idt_handler_array)
>  	
> -early_idt_handler_common:
> +SYM_CODE_START_LOCAL(early_idt_handler_common)
>  	/*
>  	 * The stack is the hardware frame, an error code or zero, and the
>  	 * vector number.
> @@ -460,7 +460,7 @@ early_idt_handler_common:
>  	decl	%ss:early_recursion_flag
>  	addl	$4, %esp	/* pop pt_regs->orig_ax */
>  	iret
> -ENDPROC(early_idt_handler_common)
> +SYM_CODE_END(early_idt_handler_common)
>  
>  /* This is the default interrupt "handler" :-) */
>  ENTRY(early_ignore_irq)

Can be a local label...

> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 6c1bf7ae55ff..6fedcda37634 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -291,7 +291,7 @@ ENTRY(early_idt_handler_array)
>  	UNWIND_HINT_IRET_REGS offset=16
>  END(early_idt_handler_array)
>  
> -early_idt_handler_common:
> +SYM_CODE_START_LOCAL(early_idt_handler_common)
>  	/*
>  	 * The stack is the hardware frame, an error code or zero, and the
>  	 * vector number.
> @@ -333,7 +333,7 @@ early_idt_handler_common:
>  20:
>  	decl early_recursion_flag(%rip)
>  	jmp restore_regs_and_return_to_kernel
> -END(early_idt_handler_common)
> +SYM_CODE_END(early_idt_handler_common)
>  
>  	__INITDATA
>  

Ditto:

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 6fedcda37634..68e8d0332873 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -283,7 +283,7 @@ ENTRY(early_idt_handler_array)
 		UNWIND_HINT_IRET_REGS offset=8
 	.endif
 	pushq $i		# 72(%rsp) Vector number
-	jmp early_idt_handler_common
+	jmp .Learly_idt_handler_common
 	UNWIND_HINT_IRET_REGS
 	i = i + 1
 	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
@@ -291,7 +291,7 @@ ENTRY(early_idt_handler_array)
 	UNWIND_HINT_IRET_REGS offset=16
 END(early_idt_handler_array)
 
-SYM_CODE_START_LOCAL(early_idt_handler_common)
+SYM_CODE_START_LOCAL(.Learly_idt_handler_common)
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
@@ -333,7 +333,7 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 20:
 	decl early_recursion_flag(%rip)
 	jmp restore_regs_and_return_to_kernel
-SYM_CODE_END(early_idt_handler_common)
+SYM_CODE_END(.Learly_idt_handler_common)
 
 	__INITDATA
 

> diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
> index a024c4f7ba56..641f0fe1e5b4 100644
> --- a/arch/x86/kernel/verify_cpu.S
> +++ b/arch/x86/kernel/verify_cpu.S
> @@ -31,7 +31,7 @@
>  #include <asm/cpufeatures.h>
>  #include <asm/msr-index.h>
>  
> -ENTRY(verify_cpu)
> +SYM_FUNC_START_LOCAL(verify_cpu)
>  	pushf				# Save caller passed flags
>  	push	$0			# Kill any dangerous flags
>  	popf
> @@ -137,4 +137,4 @@ ENTRY(verify_cpu)
>  	popf				# Restore caller passed flags
>  	xorl %eax, %eax
>  	ret
> -ENDPROC(verify_cpu)
> +SYM_FUNC_END(verify_cpu)

All except this one can be local labels and be removed from vmlinux'
symtable:

$ readelf -a vmlinux | grep -E "(bad_(gs|(get|put)_user)|bogus_64_magic|early_idt_handler_common|verify_cpu)"
    45: ffffffff810000e0   241 FUNC    LOCAL  DEFAULT    1 verify_cpu
$

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
