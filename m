Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03190DEFA9
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2019 16:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfJUOdh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Oct 2019 10:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfJUOdh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Oct 2019 10:33:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C3D20656;
        Mon, 21 Oct 2019 14:33:35 +0000 (UTC)
Date:   Mon, 21 Oct 2019 10:33:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/ftrace: Get rid of function_hook
Message-ID: <20191021103333.066d152c@gandalf.local.home>
In-Reply-To: <20191021141038.GC7014@zn.tnic>
References: <20191011115108.12392-22-jslaby@suse.cz>
        <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
        <20191018124800.0a7006bb@gandalf.local.home>
        <20191018124956.764ac42e@gandalf.local.home>
        <20191018171354.GB20368@zn.tnic>
        <20191018133735.77e90e36@gandalf.local.home>
        <20191018194856.GC20368@zn.tnic>
        <20191018163125.346e078d@gandalf.local.home>
        <20191019073424.GA27353@zn.tnic>
        <20191021141038.GC7014@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 21 Oct 2019 16:10:38 +0200
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> function_hook is used as a better name than the default __fentry__
> which is the profiling counter which gcc adds before every function's
> prologue. Thus, it is not called from C and cannot have the same
> semantics as a pure C function - it saves/restores regs so that a C
> function can be called.
> 
> Drop the function_hook symbol and use __fentry__ directly for better
> alignment with gcc's documentation.
> 
> Switch the marking to SYM_CODE_START/_END which is reserved for
> non-standard, special functions.

I would break this into two patches. One that removes the function_hook
name, and the other to convert to the SYM_CODE_START/END.

For the removal of the function_hook patch, be sure to state some of
the history for why the function_hook was created in the first place.
Which would be something like this:

"When ftrace first was introduced to the kernel, it used gcc's
mcount profiling mechanism. The mcount mechanism would add a call to
"mcount" at the start of every function but after the stack frame was
set up. Later, in gcc 4.6, gcc introduced -mfentry, that would create a
call to "__fentry__" instead of "mcount", before the stack frame was
set up. In order to handle both cases, ftrace defined a macro
"function_hook" that would be either "mcount" or "__fentry__" depending
on which one was being used.

The Linux kernel no longer supports the "mcount" method, thus there's
no reason to keep the "function_hook" define around. Simply use
"__fentry__", as there is no ambiguity to the name anymore."

-- Steve


> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> ---
>  Documentation/asm-annotations.rst |  4 ++--
>  arch/x86/kernel/ftrace_32.S       |  8 +++-----
>  arch/x86/kernel/ftrace_64.S       | 13 ++++++-------
>  3 files changed, 11 insertions(+), 14 deletions(-)
> 
