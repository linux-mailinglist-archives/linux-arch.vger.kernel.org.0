Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218D4D7DD4
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 19:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfJORbf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 13:31:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34076 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfJORbf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 13:31:35 -0400
Received: from zn.tnic (p200300EC2F15780025EDCDA5BE6BD269.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:7800:25ed:cda5:be6b:d269])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C6251EC0C9F;
        Tue, 15 Oct 2019 19:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571160693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cFw5Due+VSFCyYkmIjMbJP3VojTnvQLW8Rym4nhL1EE=;
        b=XDVJJIBJ/ZL1XC+z8ExW3BsGImQQoJDtqsoq93W1VtJAlOusLYUjpFDKUJduHc8FA+Jhpz
        c18/qEIgoYBcvQ1EPyi4jp00mfJs3Uwjn03bsoHFf58xy+0zsABkr/Efn0UKPHHCVVaENg
        5SjiwseSDFyywMPyhd36nrxgA2ONguQ=
Date:   Tue, 15 Oct 2019 19:31:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v9 17/28] x86/asm: Use SYM_INNER_LABEL instead of GLOBAL
Message-ID: <20191015173124.GF596@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-18-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-18-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 01:50:57PM +0200, Jiri Slaby wrote:
> The GLOBAL macro had several meanings and is going away. In this patch,
> convert all the inner function labels marked with GLOBAL to use
> SYM_INNER_LABEL instead.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@amacapital.net>
> ---
>  arch/x86/entry/entry_64.S                |  6 +++---
>  arch/x86/entry/entry_64_compat.S         |  4 ++--
>  arch/x86/entry/vdso/vdso32/system_call.S |  2 +-
>  arch/x86/kernel/ftrace_32.S              |  2 +-
>  arch/x86/kernel/ftrace_64.S              | 16 ++++++++--------
>  arch/x86/realmode/rm/reboot.S            |  2 +-
>  6 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 607e25f54ff4..57d246048ac6 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -162,7 +162,7 @@ ENTRY(entry_SYSCALL_64)
>  	pushq	%r11					/* pt_regs->flags */
>  	pushq	$__USER_CS				/* pt_regs->cs */
>  	pushq	%rcx					/* pt_regs->ip */
> -GLOBAL(entry_SYSCALL_64_after_hwframe)
> +SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>  	pushq	%rax					/* pt_regs->orig_ax */
>  
>  	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
> @@ -621,7 +621,7 @@ ret_from_intr:
>  	call	prepare_exit_to_usermode
>  	TRACE_IRQS_IRETQ
>  
> -GLOBAL(swapgs_restore_regs_and_return_to_usermode)
> +SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
>  #ifdef CONFIG_DEBUG_ENTRY
>  	/* Assert that pt_regs indicates user mode. */
>  	testb	$3, CS(%rsp)
> @@ -679,7 +679,7 @@ retint_kernel:
>  	 */
>  	TRACE_IRQS_IRETQ
>  
> -GLOBAL(restore_regs_and_return_to_kernel)
> +SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
>  #ifdef CONFIG_DEBUG_ENTRY
>  	/* Assert that pt_regs indicates kernel mode. */
>  	testb	$3, CS(%rsp)

Do this too, while at it?

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 57d246048ac6..e73369858556 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -247,7 +247,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * We win! This label is here just for ease of understanding
 	 * perf profiles. Nothing jumps here.
 	 */
-syscall_return_via_sysret:
+SYM_INNER_LABEL(syscall_return_via_sysret, SYM_L_GLOBAL)
 	/* rcx and r11 are already restored (see code above) */
 	UNWIND_HINT_EMPTY
 	POP_REGS pop_rdi=0 skip_r11rcx=1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
