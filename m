Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06D9DCCEE
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410564AbfJRRhj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 13:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405459AbfJRRhj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 13:37:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E01222BD;
        Fri, 18 Oct 2019 17:37:37 +0000 (UTC)
Date:   Fri, 18 Oct 2019 13:37:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: x86/asm] x86/asm/ftrace: Mark function_hook as function
Message-ID: <20191018133735.77e90e36@gandalf.local.home>
In-Reply-To: <20191018171354.GB20368@zn.tnic>
References: <20191011115108.12392-22-jslaby@suse.cz>
        <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
        <20191018124800.0a7006bb@gandalf.local.home>
        <20191018124956.764ac42e@gandalf.local.home>
        <20191018171354.GB20368@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 18 Oct 2019 19:13:54 +0200
Borislav Petkov <bp@suse.de> wrote:

> On Fri, Oct 18, 2019 at 12:49:56PM -0400, Steven Rostedt wrote:
> > On Fri, 18 Oct 2019 12:48:00 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > > Relabel function_hook to be marked really as a function. It is called
> > > > from C and has the same expectations towards the stack etc.    
> > >   
> > 
> > And to go even further, it *does not* have the same expectations
> > towards the stack.
> > 
> > I think this patch should not be applied.  
> 
> There are a couple more markings like that now:
> 
> $ git grep function_hook
> Documentation/asm-annotations.rst:120:    SYM_FUNC_START(function_hook)
> Documentation/asm-annotations.rst:122:    SYM_FUNC_END(function_hook)
> arch/x86/kernel/ftrace_32.S:15:# define function_hook   __fentry__
> arch/x86/kernel/ftrace_32.S:24:SYM_FUNC_START(function_hook)
> arch/x86/kernel/ftrace_32.S:26:SYM_FUNC_END(function_hook)
> arch/x86/kernel/ftrace_64.S:17:# define function_hook   __fentry__
> arch/x86/kernel/ftrace_64.S:135:SYM_FUNC_START(function_hook)
> arch/x86/kernel/ftrace_64.S:137:SYM_FUNC_END(function_hook)
> arch/x86/kernel/ftrace_64.S:251:SYM_FUNC_START(function_hook)
> arch/x86/kernel/ftrace_64.S:282:SYM_FUNC_END(function_hook)
> 
> Frankly, I wouldn't mark this function at all as it is special and I see
> a little sense to have it in stack traces but maybe Jiri has another
> angle here. I'll let him comment.

It just needs to be visible by modules and what not, otherwise linking
will fail.

> 
> I guess with the new nomenclature that can be SYM_CODE_* now...
> 
> Then, this magic "function" or a global symbol with an address or
> whatever that is (oh, there's #define trickery too) definitely deserves
> a comment above it to explain what it is. I even have to build the .s
> file to see what it turns into:

The #define was because we use to support mcount or __fentry__, now we
just support __fentry__, and function_hook describes it better ;-)

> 
> .globl __fentry__ ; .p2align 4, 0x90 ; __fentry__:
>  retq
> .type __fentry__, @function ; .size __fentry__, .-__fentry__
> 
> Yeah, it is called on every function entry:
> 
> callq  ffffffff81a01760 <__fentry__>
> 
> but can we please explain with a comment above it what it is?

Heh, I guess we could, which would probably be quite a long comment as
it's the key behind ftrace itself.

-- Steve

