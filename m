Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D021AC064
	for <lists+linux-arch@lfdr.de>; Thu, 16 Apr 2020 13:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634437AbgDPLzn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Apr 2020 07:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634140AbgDPLxx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Apr 2020 07:53:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3819221D7F;
        Thu, 16 Apr 2020 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587038032;
        bh=0mpxLSIOs3tq2gfBo7MJk3NNjMvIOABD4VUjv69CESM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCqjLq2W5XYIiSSVO2KE0QKiNjuGCtb5Ex8H0ZZdRq3LQoHTd2bP8ewMSsmQeIwqq
         mJVyQEl8WTXSxlDKofHHmrLMVE8SgZ/X49eFy3V712/en9UsSFjDE5EqhQWd0rKObH
         mZcywS+Y8Tzz1YG0vKKcvGjUK1+QeM6W5XSt2W0U=
Date:   Thu, 16 Apr 2020 12:53:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 05/12] arm64: csum: Disable KASAN for do_csum()
Message-ID: <20200416115342.GA32443@willie-the-truck>
References: <20200415165218.20251-1-will@kernel.org>
 <20200415165218.20251-6-will@kernel.org>
 <20200415172813.GA2272@lakrids.cambridge.arm.com>
 <20200415192605.GA21804@willie-the-truck>
 <20200416093106.GB4987@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416093106.GB4987@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 16, 2020 at 10:31:06AM +0100, Mark Rutland wrote:
> On Wed, Apr 15, 2020 at 08:26:05PM +0100, Will Deacon wrote:
> > I think abusing a relaxed concurrency primitive for this is
> > not the right thing to do, particularly when the __no_sanitize_address
> > annotation is available. I fact, it's almost an argument in favour
> > of removing READ_ONCE_NOCHECK() so that people use the annotation instead!
> 
> Arguably we *are* using it as a relaxed concurrency primitive, to get a
> snapshot of a varaible undergoing concurrent modification.

That's fair, so it's only the checksum code that was abusing this, which
I've fixed.

> FWIW, for the arm64 unwind code we could add a helper to snapshot the
> frame record, and mark that as __no_sanitize_address, e.g.
> 
> /*
>  * Get a snapshot of a frame record that might be undergoing concurrent
>  * modification (and hence we must also avoid a KASAN splat).
>  */
> static __no_sanitize_address snapshot_frame(struct stackframe *frame,
> 					    unsigned long fp)
> {
> 	frame->fp = READ_ONCE(*(unsigned long *)(fp));
> 	frame->pc = READ_ONCE(*(unsigned long *)(fp + 8));
> }
> 
> ... we'd need to do likewied in a few bits of unwind code:
> 
> arch/s390/kernel/unwind_bc.c:	       READ_ONCE_NOCHECK(regs->psw.mask) & PSW_MASK_PSTATE;
> arch/s390/kernel/unwind_bc.c:		ip = READ_ONCE_NOCHECK(sf->gprs[8]);
> arch/s390/kernel/unwind_bc.c:		sp = READ_ONCE_NOCHECK(sf->back_chain);
> arch/s390/kernel/unwind_bc.c:			ip = READ_ONCE_NOCHECK(sf->gprs[8]);
> arch/s390/kernel/unwind_bc.c:			ip = READ_ONCE_NOCHECK(regs->psw.addr);
> arch/s390/kernel/unwind_bc.c:			sp = READ_ONCE_NOCHECK(regs->gprs[15]);
> arch/s390/kernel/unwind_bc.c:		ip = READ_ONCE_NOCHECK(sf->gprs[8]);
> arch/x86/include/asm/atomic.h:	 * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
> arch/x86/include/asm/unwind.h:		val = READ_ONCE_NOCHECK(x);		\
> arch/x86/kernel/dumpstack.c:			unsigned long addr = READ_ONCE_NOCHECK(*stack);
> arch/x86/kernel/process.c:	fp = READ_ONCE_NOCHECK(((struct inactive_task_frame *)sp)->bp);
> arch/x86/kernel/process.c:		ip = READ_ONCE_NOCHECK(*(unsigned long *)(fp + sizeof(unsigned long)));
> arch/x86/kernel/process.c:		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
> arch/x86/kernel/unwind_frame.c:			word = READ_ONCE_NOCHECK(*sp);
> arch/x86/kernel/unwind_guess.c:	addr = READ_ONCE_NOCHECK(*state->sp);
> arch/x86/kernel/unwind_guess.c:			unsigned long addr = READ_ONCE_NOCHECK(*state->sp);
> arch/x86/kernel/unwind_orc.c:	*val = READ_ONCE_NOCHECK(*(unsigned long *)addr);
> arch/x86/kernel/unwind_orc.c:		state->bp = READ_ONCE_NOCHECK(frame->bp);
> arch/x86/kernel/unwind_orc.c:		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
> include/linux/compiler.h: * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
> include/linux/compiler.h:#define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
> kernel/trace/trace_stack.c:			 * The READ_ONCE_NOCHECK is used to let KASAN know that
> kernel/trace/trace_stack.c:			if ((READ_ONCE_NOCHECK(*p)) == stack_dump_trace[i]) {

Indeed. For now, I'm going to keep this simple with the change below, but
I'll revisit this later on because I have another series removing
smp_read_barrier_depends() which makes this a lot simpler.

Will

--->8

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 00a68063d9d5..c363d8debc43 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -212,18 +212,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	(typeof(x))__x;							\
 })
 
-/*
- * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
- * to hide memory access from KASAN.
- */
-#define READ_ONCE_NOCHECK(x)						\
+#define READ_ONCE(x)							\
 ({									\
 	compiletime_assert_rwonce_type(x);				\
 	__READ_ONCE_SCALAR(x);						\
 })
 
-#define READ_ONCE(x)	READ_ONCE_NOCHECK(x)
-
 #define __WRITE_ONCE(x, val)				\
 do {							\
 	*(volatile typeof(x) *)&(x) = (val);		\
@@ -247,6 +241,24 @@ do {							\
 # define __no_kasan_or_inline __always_inline
 #endif
 
+static __no_kasan_or_inline
+unsigned long __read_once_word_nocheck(const void *addr)
+{
+	return __READ_ONCE(*(unsigned long *)addr);
+}
+
+/*
+ * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
+ * word from memory atomically but without telling KASAN. This is usually
+ * used by unwinding code when walking the stack of a running process.
+ */
+#define READ_ONCE_NOCHECK(x)						\
+({									\
+	unsigned long __x = __read_once_word_nocheck(&(x));		\
+	smp_read_barrier_depends();					\
+	__x;								\
+})
+
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {
