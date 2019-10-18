Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA48DCBD6
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502006AbfJRQsE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbfJRQsE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 12:48:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07E4B20854;
        Fri, 18 Oct 2019 16:48:01 +0000 (UTC)
Date:   Fri, 18 Oct 2019 12:48:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: x86/asm] x86/asm/ftrace: Mark function_hook as function
Message-ID: <20191018124800.0a7006bb@gandalf.local.home>
In-Reply-To: <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
References: <20191011115108.12392-22-jslaby@suse.cz>
        <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 18 Oct 2019 16:30:27 -0000
"tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/asm branch of tip:
> 
> Commit-ID:     f13ad88a984e8090226a8f62d75e87b770eefdf4
> Gitweb:        https://git.kernel.org/tip/f13ad88a984e8090226a8f62d75e87b770eefdf4
> Author:        Jiri Slaby <jslaby@suse.cz>
> AuthorDate:    Fri, 11 Oct 2019 13:51:01 +02:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Fri, 18 Oct 2019 11:35:41 +02:00

I just noticed this (sorry missed the original patch).

> 
> x86/asm/ftrace: Mark function_hook as function
> 
> Relabel function_hook to be marked really as a function. It is called
> from C and has the same expectations towards the stack etc.

This is wrong, function_hook is never called from C. It's called via
fentry (use to be mcount), and does not have the same semantics as a C
function. In fact, that's why it exists in assembly. Because it has to
save and restore registers to make it possible to call a C function!

-- Steve


> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: linux-arch@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86-ml <x86@kernel.org>
> Link: https://lkml.kernel.org/r/20191011115108.12392-22-jslaby@suse.cz
> ---
>  arch/x86/kernel/ftrace_32.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
> index e0061dc..219be13 100644
> --- a/arch/x86/kernel/ftrace_32.S
> +++ b/arch/x86/kernel/ftrace_32.S
> @@ -21,9 +21,9 @@ EXPORT_SYMBOL(__fentry__)
>  # define MCOUNT_FRAME			0	/* using frame = false */
>  #endif
>  
> -ENTRY(function_hook)
> +SYM_FUNC_START(function_hook)
>  	ret
> -END(function_hook)
> +SYM_FUNC_END(function_hook)
>  
>  ENTRY(ftrace_caller)
>  

