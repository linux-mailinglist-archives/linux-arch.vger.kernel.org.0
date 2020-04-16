Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9DD1ABCCD
	for <lists+linux-arch@lfdr.de>; Thu, 16 Apr 2020 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502394AbgDPJbP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Apr 2020 05:31:15 -0400
Received: from foss.arm.com ([217.140.110.172]:57890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502117AbgDPJbL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Apr 2020 05:31:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3815C14;
        Thu, 16 Apr 2020 02:31:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23D23F73D;
        Thu, 16 Apr 2020 02:31:08 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:31:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20200416093106.GB4987@lakrids.cambridge.arm.com>
References: <20200415165218.20251-1-will@kernel.org>
 <20200415165218.20251-6-will@kernel.org>
 <20200415172813.GA2272@lakrids.cambridge.arm.com>
 <20200415192605.GA21804@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415192605.GA21804@willie-the-truck>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 15, 2020 at 08:26:05PM +0100, Will Deacon wrote:
> On Wed, Apr 15, 2020 at 06:28:14PM +0100, Mark Rutland wrote:
> > On Wed, Apr 15, 2020 at 05:52:11PM +0100, Will Deacon wrote:
> > > do_csum() over-reads the source buffer and therefore abuses
> > > READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
> > > READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
> > > '__no_sanitize_address' annotation, just annotate do_csum() explicitly
> > > and fall back to normal loads.
> > 
> > I'm confused by this. The whole point of READ_ONCE_NOCHECK() is that it
> > isn't checked by KASAN, so if that semantic is removed it has no reason
> > to exist.
> 
> Oh, I thought it was there to be used by things like KASAN itself and
> because READ_ONCE() was implemented using a static function, then that
> function had to be marked as __no_sanitize_address when used in these
> cases. Now that it's just a macro, that's not necessary so it's just
> the same as normal READ_ONCE().

I believe that the KASAN core files are compiled without
instrumentation, so they can use either without issue.

> Do we have a "nocheck" version where we don't require the READ_ONCE()
> semantics? 

For the unwind code we rely on the ONCE semantic (but arguably don't
need single-copy-atomicity) so that we operate on a consistent snapshot.

> I think abusing a relaxed concurrency primitive for this is
> not the right thing to do, particularly when the __no_sanitize_address
> annotation is available. I fact, it's almost an argument in favour
> of removing READ_ONCE_NOCHECK() so that people use the annotation instead!

Arguably we *are* using it as a relaxed concurrency primitive, to get a
snapshot of a varaible undergoing concurrent modification.

FWIW, for the arm64 unwind code we could add a helper to snapshot the
frame record, and mark that as __no_sanitize_address, e.g.

/*
 * Get a snapshot of a frame record that might be undergoing concurrent
 * modification (and hence we must also avoid a KASAN splat).
 */
static __no_sanitize_address snapshot_frame(struct stackframe *frame,
					    unsigned long fp)
{
	frame->fp = READ_ONCE(*(unsigned long *)(fp));
	frame->pc = READ_ONCE(*(unsigned long *)(fp + 8));
}

... we'd need to do likewied in a few bits of unwind code:

arch/s390/kernel/unwind_bc.c:	       READ_ONCE_NOCHECK(regs->psw.mask) & PSW_MASK_PSTATE;
arch/s390/kernel/unwind_bc.c:		ip = READ_ONCE_NOCHECK(sf->gprs[8]);
arch/s390/kernel/unwind_bc.c:		sp = READ_ONCE_NOCHECK(sf->back_chain);
arch/s390/kernel/unwind_bc.c:			ip = READ_ONCE_NOCHECK(sf->gprs[8]);
arch/s390/kernel/unwind_bc.c:			ip = READ_ONCE_NOCHECK(regs->psw.addr);
arch/s390/kernel/unwind_bc.c:			sp = READ_ONCE_NOCHECK(regs->gprs[15]);
arch/s390/kernel/unwind_bc.c:		ip = READ_ONCE_NOCHECK(sf->gprs[8]);
arch/x86/include/asm/atomic.h:	 * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
arch/x86/include/asm/unwind.h:		val = READ_ONCE_NOCHECK(x);		\
arch/x86/kernel/dumpstack.c:			unsigned long addr = READ_ONCE_NOCHECK(*stack);
arch/x86/kernel/process.c:	fp = READ_ONCE_NOCHECK(((struct inactive_task_frame *)sp)->bp);
arch/x86/kernel/process.c:		ip = READ_ONCE_NOCHECK(*(unsigned long *)(fp + sizeof(unsigned long)));
arch/x86/kernel/process.c:		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
arch/x86/kernel/unwind_frame.c:			word = READ_ONCE_NOCHECK(*sp);
arch/x86/kernel/unwind_guess.c:	addr = READ_ONCE_NOCHECK(*state->sp);
arch/x86/kernel/unwind_guess.c:			unsigned long addr = READ_ONCE_NOCHECK(*state->sp);
arch/x86/kernel/unwind_orc.c:	*val = READ_ONCE_NOCHECK(*(unsigned long *)addr);
arch/x86/kernel/unwind_orc.c:		state->bp = READ_ONCE_NOCHECK(frame->bp);
arch/x86/kernel/unwind_orc.c:		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
include/linux/compiler.h: * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
include/linux/compiler.h:#define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
kernel/trace/trace_stack.c:			 * The READ_ONCE_NOCHECK is used to let KASAN know that
kernel/trace/trace_stack.c:			if ((READ_ONCE_NOCHECK(*p)) == stack_dump_trace[i]) {

> > I would like to keep the unwinding robust in the first case, even if the
> > second case doesn't apply, and I'd prefer to not mark the entirety of
> > the unwinding code as unchecked as that's sufficiently large an subtle
> > that it could have nasty bugs.
> 
> Hmm, maybe. I don't really see what's wrong with annotating the unwinding
> code, though. You can still tell kasan about the accesses you're making,
> like we do in the checksumming code here, and it's not hard to move the
> frame-pointer chasing code into a separate function.

Sure; agreed as above. We just need to fix up a number of places.

> > Is there any way we keep something like READ_ONCE_NOCHECK() around even
> > if we have to give it reduced functionality relative to READ_ONCE()?
> > 
> > I'm not enirely sure why READ_ONCE_NOCHECK() had to go, so if there's a
> > particular pain point I'm happy to take a look.
> 
> I got rid if it because I thought it wasn't required now that it's
> implemented entirely as a macro. I'd be reluctant to bring it back if
> there isn't a non-ONCE version of the helper.

As above, I think that we *do* care about the ONCE-ness for the unwind
code, but I'm happy for those to be dealt with by special helpers.

Thanks,
Mark.
