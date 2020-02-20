Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BCE165D60
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 13:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgBTMRe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 07:17:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45908 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgBTMRe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 07:17:34 -0500
Received: from zn.tnic (p200300EC2F0ADE008C2E3AE544E50E0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:de00:8c2e:3ae5:44e5:e0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C76071EC0304;
        Thu, 20 Feb 2020 13:17:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582201052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GHsRYld0xfiWTAFa2iAQEWWjuxSWqN7yTT7gbGMHIis=;
        b=fJVY7q+gdDI0ItvEVUNDDOPRWGNPal8VzHyxsdcxN906vvkCWwEDWjUqmb0kz8lAh/yY+q
        1VOS4XNZcQl5APvPctdgQ7FptOHdrPsfwEEhUx04gT+okd6yBmt0X9ObeDAvj8qj8gvsnT
        R1spuYpWhS+l5BNHr5PDkcvzsGs6umc=
Date:   Thu, 20 Feb 2020 13:17:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com,
        frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Message-ID: <20200220121727.GB507@zn.tnic>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
 <20200219154031.GE18400@hirez.programming.kicks-ass.net>
 <20200219155715.GD14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219155715.GD14946@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 04:57:15PM +0100, Peter Zijlstra wrote:
> -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> +		for (i = 0; i < count; i++) {
> +			int idx = (dst <= src) ? i : count - i;
> +			dst[idx] = src[idx];
> +		}

Or, you can actually unroll it. This way it even documents clearly what
it does:

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index fe38015ed50a..2b790a574ba5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -298,6 +298,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 		regs->ip == (unsigned long)native_irq_return_iret)
 	{
 		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		unsigned long *p = (unsigned long *)regs->sp;
 
 		/*
 		 * regs->sp points to the failing IRET frame on the
@@ -305,7 +306,11 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 		 * in gpregs->ss through gpregs->ip.
 		 *
 		 */
-		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
+		gpregs->ip	= *p;
+		gpregs->cs	= *(p + 1);
+		gpregs->flags	= *(p + 2);
+		gpregs->sp	= *(p + 3);
+		gpregs->ss	= *(p + 4);
 		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
 
 		/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
