Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B081B7739
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgDXNmq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 09:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgDXNmp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 09:42:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D4020776;
        Fri, 24 Apr 2020 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587735764;
        bh=67dvcDj8u9CAOswPgM9wyi7nZigMq7TnPlS+X3gBeP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWKgFZb0bE2Z200/xRvvqneJW1ZBWIccZZqULcE7CS9oO/yYEhqW43FTI3PpTpeZ0
         0vgDEMwwZXWwXbSQVNfTfaY5rUkHWLez/uVXU5bZXvEBgmA5QwwKv0PB2s+IGdizC2
         bsuUNnBZifMX+22wAZ4bFRCtlrplZabBR61daMU8=
Date:   Fri, 24 Apr 2020 14:42:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>, elver@google.com,
        dvyukov@google.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
Message-ID: <20200424134238.GE21141@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
 <20200422081838.GA29541@willie-the-truck>
 <20200422113721.GA20730@hirez.programming.kicks-ass.net>
 <20200422122626.GA676@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422122626.GA676@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

[+KCSAN folks]

On Wed, Apr 22, 2020 at 01:26:27PM +0100, Will Deacon wrote:
> On Wed, Apr 22, 2020 at 01:37:21PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 22, 2020 at 09:18:39AM +0100, Will Deacon wrote:
> > > On Tue, Apr 21, 2020 at 11:42:56AM -0700, Linus Torvalds wrote:
> > > > On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
> > > > >
> > > > > It's me again. This is version four of the READ_ONCE() codegen improvement
> > > > > patches [...]
> > > > 
> > > > Let's just plan on biting the bullet and do this for 5.8. I'm assuming
> > > > that I'll juet get a pull request from you?
> > > 
> > > Sure thing, thanks. I'll get it into -next along with the arm64 bits for
> > > 5.8, but I'll send it as a separate pull when the time comes. I'll also
> > > include the sparc32 changes because otherwise the build falls apart and
> > > we'll get an army of angry robots yelling at us (they seem to form the
> > > majority of the active sparc32 user base afaict).
> > 
> > So I'm obviously all for these patches; do note however that it collides
> > most mighty with the KCSAN stuff, which I believe is still pending.
> 
> That stuff has been pending for the last two releases afaict :/
> 
> Anyway, I'm happy to either provide a branch with this series on, or do
> the merge myself, or send this again based on something else. What works
> best for you? The only thing I'd obviously like to avoid is tightly
> coupling this to KCSAN if there's a chance of it missing the merge window
> again.

FWIW, I had a go at rebasing onto linux-next, just to get an idea for how
bad it is. It's fairly bad, and I don't think it's fair to inflict it on
sfr. I've included the interesting part of the resulting compiler.h below
for you and the KCSAN crowd to take a look at (yes, there's room for
subsequent cleanup, but I was focussing on the conflict resolution for now).

So, I think the best bet is either for my changes to go into -tip on top
of the KCSAN stuff, or for the KCSAN stuff to be dropped from -next (it's
been there since at least January). Do you know if they are definitely
supposed to be going in for 5.8?

Any other ideas?

Cheers,

Will

--->8

/*
 * Prevent the compiler from merging or refetching reads or writes. The
 * compiler is also forbidden from reordering successive instances of
 * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
 * particular ordering. One way to make the compiler aware of ordering is to
 * put the two invocations of READ_ONCE or WRITE_ONCE in different C
 * statements.
 *
 * These two macros will also work on aggregate data types like structs or
 * unions.
 *
 * Their two major use cases are: (1) Mediating communication between
 * process-level code and irq/NMI handlers, all running on the same CPU,
 * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
 * mutilate accesses that either do not require ordering or that interact
 * with an explicit memory barrier or atomic instruction that provides the
 * required ordering.
 */
#include <asm/barrier.h>
#include <linux/kasan-checks.h>
#include <linux/kcsan-checks.h>

/*
 * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
 * atomicity or dependency ordering guarantees. Note that this may result
 * in tears!
 */
#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))

#define __READ_ONCE_SCALAR(x)						\
({									\
	typeof(x) *__xp = &(x);						\
	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
	kcsan_disable_current();					\
	({								\
		__unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);	\
		kcsan_enable_current();					\
		smp_read_barrier_depends();				\
		(typeof(x))__x;						\
	});								\
})

#define READ_ONCE(x)							\
({									\
	compiletime_assert_rwonce_type(x);				\
	__READ_ONCE_SCALAR(x);						\
})

#define __WRITE_ONCE(x, val)						\
do {									\
	*(volatile typeof(x) *)&(x) = (val);				\
} while (0)

#define __WRITE_ONCE_SCALAR(x, val)					\
do {									\
	typeof(x) *__xp = &(x);						\
	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
	kcsan_disable_current();					\
	__WRITE_ONCE(*__xp, val);					\
	kcsan_enable_current();						\
} while (0)

#define WRITE_ONCE(x, val)						\
do {									\
	compiletime_assert_rwonce_type(x);				\
	__WRITE_ONCE_SCALAR(x, val);					\
} while (0)

#ifdef CONFIG_KASAN
/*
 * We can't declare function 'inline' because __no_sanitize_address conflicts
 * with inlining. Attempt to inline it may cause a build failure.
 *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
 * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
 */
# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
# define __no_sanitize_or_inline __no_kasan_or_inline
#else
# define __no_kasan_or_inline __always_inline
#endif

#define __no_kcsan __no_sanitize_thread
#ifdef __SANITIZE_THREAD__
/*
 * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
 * compilation units where instrumentation is disabled. The attribute 'noinline'
 * is required for older compilers, where implicit inlining of very small
 * functions renders __no_sanitize_thread ineffective.
 */
# define __no_kcsan_or_inline __no_kcsan noinline notrace __maybe_unused
# define __no_sanitize_or_inline __no_kcsan_or_inline
#else
# define __no_kcsan_or_inline __always_inline
#endif

#ifndef __no_sanitize_or_inline
#define __no_sanitize_or_inline __always_inline
#endif

static __no_sanitize_or_inline
unsigned long __read_once_word_nocheck(const void *addr)
{
	return __READ_ONCE(*(unsigned long *)addr);
}

/*
 * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
 * word from memory atomically but without telling KASAN/KCSAN. This is
 * usually used by unwinding code when walking the stack of a running process.
 */
#define READ_ONCE_NOCHECK(x)						\
({									\
	unsigned long __x = __read_once_word_nocheck(&(x));		\
	smp_read_barrier_depends();					\
	__x;								\
})

static __no_kasan_or_inline
unsigned long read_word_at_a_time(const void *addr)
{
	kasan_check_read(addr, 1);
	return *(unsigned long *)addr;
}

/**
 * data_race - mark an expression as containing intentional data races
 *
 * This data_race() macro is useful for situations in which data races
 * should be forgiven.  One example is diagnostic code that accesses
 * shared variables but is not a part of the core synchronization design.
 *
 * This macro *does not* affect normal code generation, but is a hint
 * to tooling that data races here are to be ignored.
 */
#define data_race(expr)                                                        \
	({                                                                     \
		typeof(({ expr; })) __val;                                     \
		kcsan_disable_current();                                       \
		__val = ({ expr; });                                           \
		kcsan_enable_current();                                        \
		__val;                                                         \
	})
