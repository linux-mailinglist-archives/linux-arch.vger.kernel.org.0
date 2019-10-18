Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D261DCC6A
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502144AbfJRROM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 13:14:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:36204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388893AbfJRROM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 13:14:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 466CEAC52;
        Fri, 18 Oct 2019 17:14:10 +0000 (UTC)
Date:   Fri, 18 Oct 2019 19:13:54 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20191018171354.GB20368@zn.tnic>
References: <20191011115108.12392-22-jslaby@suse.cz>
 <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
 <20191018124800.0a7006bb@gandalf.local.home>
 <20191018124956.764ac42e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018124956.764ac42e@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 18, 2019 at 12:49:56PM -0400, Steven Rostedt wrote:
> On Fri, 18 Oct 2019 12:48:00 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > Relabel function_hook to be marked really as a function. It is called
> > > from C and has the same expectations towards the stack etc.  
> > 
> 
> And to go even further, it *does not* have the same expectations
> towards the stack.
> 
> I think this patch should not be applied.

There are a couple more markings like that now:

$ git grep function_hook
Documentation/asm-annotations.rst:120:    SYM_FUNC_START(function_hook)
Documentation/asm-annotations.rst:122:    SYM_FUNC_END(function_hook)
arch/x86/kernel/ftrace_32.S:15:# define function_hook   __fentry__
arch/x86/kernel/ftrace_32.S:24:SYM_FUNC_START(function_hook)
arch/x86/kernel/ftrace_32.S:26:SYM_FUNC_END(function_hook)
arch/x86/kernel/ftrace_64.S:17:# define function_hook   __fentry__
arch/x86/kernel/ftrace_64.S:135:SYM_FUNC_START(function_hook)
arch/x86/kernel/ftrace_64.S:137:SYM_FUNC_END(function_hook)
arch/x86/kernel/ftrace_64.S:251:SYM_FUNC_START(function_hook)
arch/x86/kernel/ftrace_64.S:282:SYM_FUNC_END(function_hook)

Frankly, I wouldn't mark this function at all as it is special and I see
a little sense to have it in stack traces but maybe Jiri has another
angle here. I'll let him comment.

I guess with the new nomenclature that can be SYM_CODE_* now...

Then, this magic "function" or a global symbol with an address or
whatever that is (oh, there's #define trickery too) definitely deserves
a comment above it to explain what it is. I even have to build the .s
file to see what it turns into:

.globl __fentry__ ; .p2align 4, 0x90 ; __fentry__:
 retq
.type __fentry__, @function ; .size __fentry__, .-__fentry__

Yeah, it is called on every function entry:

callq  ffffffff81a01760 <__fentry__>

but can we please explain with a comment above it what it is?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
