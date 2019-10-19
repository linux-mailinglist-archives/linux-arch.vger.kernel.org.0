Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA4DD724
	for <lists+linux-arch@lfdr.de>; Sat, 19 Oct 2019 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfJSHeh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Oct 2019 03:34:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:47598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbfJSHeg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Oct 2019 03:34:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2057DB149;
        Sat, 19 Oct 2019 07:34:34 +0000 (UTC)
Date:   Sat, 19 Oct 2019 09:34:24 +0200
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
Message-ID: <20191019073424.GA27353@zn.tnic>
References: <20191011115108.12392-22-jslaby@suse.cz>
 <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
 <20191018124800.0a7006bb@gandalf.local.home>
 <20191018124956.764ac42e@gandalf.local.home>
 <20191018171354.GB20368@zn.tnic>
 <20191018133735.77e90e36@gandalf.local.home>
 <20191018194856.GC20368@zn.tnic>
 <20191018163125.346e078d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018163125.346e078d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 18, 2019 at 04:31:25PM -0400, Steven Rostedt wrote:
> Still looks ugly ;-)

See below. I think it's not so bad. It is only built-tested on 64-bit and
objtool complains about something again:

arch/x86/kernel/ftrace_64.o: warning: objtool: .entry.text+0x0: unreachable instruction

but I think it is the better thing to do.

> I do the talks hoping someone else will finally sit down and write the
> documentation!

Well, you can put down the outline of the doc and flesh out section by
section gradually. Besides, you have all the text in your slides so it
is actually more or less a copy+paste.

---
diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 29ccd6e61fe5..f55c2bb74d00 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -117,9 +117,9 @@ This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
   So in most cases, developers should write something like in the following
   example, having some asm instructions in between the macros, of course::
 
-    SYM_FUNC_START(function_hook)
+    SYM_FUNC_START(memset)
         ... asm insns ...
-    SYM_FUNC_END(function_hook)
+    SYM_FUNC_END(memset)
 
   In fact, this kind of annotation corresponds to the now deprecated ``ENTRY``
   and ``ENDPROC`` macros.
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 8ed1f5d371f0..77be7e7e5e59 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -12,18 +12,16 @@
 #include <asm/frame.h>
 #include <asm/asm-offsets.h>
 
-# define function_hook	__fentry__
-EXPORT_SYMBOL(__fentry__)
-
 #ifdef CONFIG_FRAME_POINTER
 # define MCOUNT_FRAME			1	/* using frame = true  */
 #else
 # define MCOUNT_FRAME			0	/* using frame = false */
 #endif
 
-SYM_FUNC_START(function_hook)
+SYM_CODE_START(__fentry__)
 	ret
-SYM_FUNC_END(function_hook)
+SYM_CODE_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 
 SYM_CODE_START(ftrace_caller)
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 69c8d1b9119e..3029fe4f8547 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -14,9 +14,6 @@
 	.code64
 	.section .entry.text, "ax"
 
-# define function_hook	__fentry__
-EXPORT_SYMBOL(__fentry__)
-
 #ifdef CONFIG_FRAME_POINTER
 /* Save parent and function stack frames (rip and rbp) */
 #  define MCOUNT_FRAME_SIZE	(8+16*2)
@@ -132,9 +129,10 @@ EXPORT_SYMBOL(__fentry__)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-SYM_FUNC_START(function_hook)
+SYM_CODE_START(__fentry__)
 	retq
-SYM_FUNC_END(function_hook)
+SYM_CODE_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 
 SYM_FUNC_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
@@ -248,7 +246,7 @@ SYM_FUNC_END(ftrace_regs_caller)
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
-SYM_FUNC_START(function_hook)
+SYM_CODE_START(__fentry__)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -279,7 +277,8 @@ trace:
 	restore_mcount_regs
 
 	jmp fgraph_trace
-SYM_FUNC_END(function_hook)
+SYM_CODE_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
