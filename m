Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61FF14D10C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2020 20:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgA2TNs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jan 2020 14:13:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgA2TNs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jan 2020 14:13:48 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C476B205F4;
        Wed, 29 Jan 2020 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580325227;
        bh=92ff4QxUOJxWhCCK6LSimpjMkzXTi+lzOK+GW8Ovhh8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0zQWbA7VpvkVjjcsooqJF/p4CoSQfkGAT8SsS1x9SUtpQJses139aJ6Q6F9W4Se0W
         y3CsJMxfjtFbiVognmRpXHnJ3QN6m9lLtApZnbI/4Fj2ko8q8GVZpJ/HJJtOXQwMai
         bXHRejPpx48jD36ovimq2JBngR/lM5Lvh34EfSaU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 668C53521AEF; Wed, 29 Jan 2020 11:13:47 -0800 (PST)
Date:   Wed, 29 Jan 2020 11:13:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Axtens <dja@axtens.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, cyphar@cyphar.com,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] include/linux: Add instrumented.h infrastructure
Message-ID: <20200129191347.GA21972@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200121160512.70887-1-elver@google.com>
 <CACT4Y+aRk5=7UoPb9zmDm5XL9CcJDv9YnzndjXYtt+3FKd8maw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aRk5=7UoPb9zmDm5XL9CcJDv9YnzndjXYtt+3FKd8maw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 12:22:56PM +0100, Dmitry Vyukov wrote:
> On Tue, Jan 21, 2020 at 5:05 PM 'Marco Elver' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > This adds instrumented.h, which provides generic wrappers for memory
> > access instrumentation that the compiler cannot emit for various
> > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > future this will also include KMSAN instrumentation.
> >
> > Note that, copy_{to,from}_user should use special instrumentation, since
> > we should be able to instrument both source and destination memory
> > accesses if both are kernel memory.
> >
> > The current patch only instruments the memory access where the address
> > is always in kernel space, however, both may in fact be kernel addresses
> > when a compat syscall passes an argument allocated in the kernel to a
> > real syscall. In a future change, both KASAN and KCSAN should check both
> > addresses in such cases, as well as KMSAN will make use of both
> > addresses. [It made more sense to provide the completed function
> > signature, rather than updating it and changing all locations again at a
> > later time.]
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

I have applied this and the other four with Dmitry's Reviewed-by.

Thank you all!

							Thanx, Paul

> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Acked-by: Alexander Potapenko <glider@google.com>
> > ---
> > v2:
> > * Simplify header, since we currently do not need pre/post user-copy
> >   distinction.
> > * Make instrument_copy_{to,from}_user function arguments match
> >   copy_{to,from}_user and update rationale in commit message.
> > ---
> >  include/linux/instrumented.h | 109 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 include/linux/instrumented.h
> >
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > new file mode 100644
> > index 000000000000..43e6ea591975
> > --- /dev/null
> > +++ b/include/linux/instrumented.h
> > @@ -0,0 +1,109 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This header provides generic wrappers for memory access instrumentation that
> > + * the compiler cannot emit for: KASAN, KCSAN.
> > + */
> > +#ifndef _LINUX_INSTRUMENTED_H
> > +#define _LINUX_INSTRUMENTED_H
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/kasan-checks.h>
> > +#include <linux/kcsan-checks.h>
> > +#include <linux/types.h>
> > +
> > +/**
> > + * instrument_read - instrument regular read access
> > + *
> > + * Instrument a regular read access. The instrumentation should be inserted
> > + * before the actual read happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_read(v, size);
> > +       kcsan_check_read(v, size);
> > +}
> > +
> > +/**
> > + * instrument_write - instrument regular write access
> > + *
> > + * Instrument a regular write access. The instrumentation should be inserted
> > + * before the actual write happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_write(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_write(v, size);
> > +       kcsan_check_write(v, size);
> > +}
> > +
> > +/**
> > + * instrument_atomic_read - instrument atomic read access
> > + *
> > + * Instrument an atomic read access. The instrumentation should be inserted
> > + * before the actual read happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_read(v, size);
> > +       kcsan_check_atomic_read(v, size);
> > +}
> > +
> > +/**
> > + * instrument_atomic_write - instrument atomic write access
> > + *
> > + * Instrument an atomic write access. The instrumentation should be inserted
> > + * before the actual write happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_write(v, size);
> > +       kcsan_check_atomic_write(v, size);
> > +}
> > +
> > +/**
> > + * instrument_copy_to_user - instrument reads of copy_to_user
> > + *
> > + * Instrument reads from kernel memory, that are due to copy_to_user (and
> > + * variants). The instrumentation must be inserted before the accesses.
> > + *
> > + * @to destination address
> > + * @from source address
> > + * @n number of bytes to copy
> > + */
> > +static __always_inline void
> > +instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> > +{
> > +       kasan_check_read(from, n);
> > +       kcsan_check_read(from, n);
> > +}
> > +
> > +/**
> > + * instrument_copy_from_user - instrument writes of copy_from_user
> > + *
> > + * Instrument writes to kernel memory, that are due to copy_from_user (and
> > + * variants). The instrumentation should be inserted before the accesses.
> > + *
> > + * @to destination address
> > + * @from source address
> > + * @n number of bytes to copy
> > + */
> > +static __always_inline void
> > +instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
> > +{
> > +       kasan_check_write(to, n);
> > +       kcsan_check_write(to, n);
> > +}
> > +
> > +#endif /* _LINUX_INSTRUMENTED_H */
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200121160512.70887-1-elver%40google.com.
