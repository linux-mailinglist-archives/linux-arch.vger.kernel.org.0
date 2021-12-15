Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA53475E9E
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245525AbhLORX2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 12:23:28 -0500
Received: from foss.arm.com ([217.140.110.172]:58410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245334AbhLORXA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 12:23:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D148C6D;
        Wed, 15 Dec 2021 09:22:59 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DAEF3F5A1;
        Wed, 15 Dec 2021 09:22:54 -0800 (PST)
Date:   Wed, 15 Dec 2021 17:22:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/43] kmsan: skip shadow checks in files doing context
 switches
Message-ID: <YbokbOfHTQXfGq39@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-26-glider@google.com>
 <Ybn39Z5dwcbrbs0O@FVFF77S0Q05N>
 <CAG_fn=XOOoCQhEkN1oeOXUX99P+AQ+ApPiUQXPFxR6yeT-Tf=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XOOoCQhEkN1oeOXUX99P+AQ+ApPiUQXPFxR6yeT-Tf=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 15, 2021 at 05:28:21PM +0100, Alexander Potapenko wrote:
> On Wed, Dec 15, 2021 at 3:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Dec 14, 2021 at 05:20:32PM +0100, Alexander Potapenko wrote:
> > > When instrumenting functions, KMSAN obtains the per-task state (mostly
> > > pointers to metadata for function arguments and return values) once per
> > > function at its beginning.
> >
> > How does KMSAN instrumentation acquire the per-task state? What's used as the
> > base for that?
> >
> 
> To preserve kernel ABI (so that instrumented functions can call
> non-instrumented ones and vice versa) KMSAN uses a per-task struct
> that keeps shadow values of function call parameters and return
> values:
> 
> struct kmsan_context_state {
>   char param_tls[...];
>   char retval_tls[...];
>   char va_arg_tls[...];
>   char va_arg_origin_tls[...];
>   u64 va_arg_overflow_size_tls;
>   depot_stack_handle_t param_origin_tls[...];
>   depot_stack_handle_t retval_origin_tls;
> };
> 
> It is mostly dealt with by the compiler, so its layout isn't really important.
> The compiler inserts a call to __msan_get_context_state() at the
> beginning of every instrumented function to obtain a pointer to that
> struct.
> Then, every time a function pointer is used, a value is returned, or
> another function is called, the compiler adds code that updates the
> shadow values in this struct.
> 
> E.g. the following function:
> 
> int sum(int a, int b) {
> ...
>   result = a + b;
>   return result;
> }
> 
> will now look as follows:
> 
> int sum(int a, int b) {
>   struct kmsan_context_state *kcs = __msan_get_context_state();
>   int s_a = ((int)kcs->param_tls)[0];  // shadow of a
>   int s_b = ((int)kcs->param_tls)[1];  // shadow of b
> ...
>   result = a + b;
>   s_result = s_a | s_b;
>   ((int)kcs->retval_tls)[0] = s_result;  // returned shadow
>   return result;
> }

Ok; thanks for that description, that makes it much easier to understand where
there could be problems.

> > > To deal with that, we need to apply __no_kmsan_checks to the functions
> > > performing context switching - this will result in skipping all KMSAN
> > > shadow checks and marking newly created values as initialized,
> > > preventing all false positive reports in those functions. False negatives
> > > are still possible, but we expect them to be rare and impersistent.
> > >
> > > To improve maintainability, we choose to apply __no_kmsan_checks not
> > > just to a handful of functions, but to the whole files that may perform
> > > context switching - this is done via KMSAN_ENABLE_CHECKS:=n.
> > > This decision can be reconsidered in the future, when KMSAN won't need
> > > so much attention.
> >
> > I worry this might be the wrong approach (and I've given some rationale below),
> > but it's not clear to me exactly how this goes wrong. Could you give an example
> > flow where stale data gets used?
> 
> The scheme I described above works well until a context switch occurs.
> Then, IIUC, at some point `current` changes, so that the previously
> fetched KMSAN context state becomes stale:
> 
> void foo(...) {
> baz(...);
> // context switch here changes `current`
> baz(...);
> }
> 
> In this case we'll have foo() setting up kmsan_context_state for the
> old task when calling bar(), but bar() taking shadow for its arguments
> from the new task's kmsan_context_state.
> 
> Does this make sense?

I understand where you're coming from, but I think this affects less code than
you think it does, due to the way the switch works.

Importantly, the value of `current` only changes within low-level arch code.
From the PoV of the core scheduler code, `current` never changes. For example,
form the PoV of a single thread, thread_a, calling into the scheduler's
context-switch:

context_switch(rq, thread_a, thread_b, rf)
{
	...
	/* `current` is `thread_a` here */
	// call blocks for an indefinite period while another thread runs
	switch_to(thread_a, thread_b, thread_a);
	/* `current` is `thread_a` here */
	...
}

You're correct that on x86 `current` does change within the __switch_to()
function, since `current` is implemented as a per-cpu variable called
`current_task`, updated within __switch_to().

So not instrumenting arch/86/kernel/process_64.c might be necessary, but I
don't see any reason to aovid instrumenting kernel/sched/core.c, since current
should never change from the PoV of code that lives there.

For contrast, on arm64 we place place `current` within the SP_EL0 register, and
switch that in our cpu_switch_to() assembly along with the GPRs and stack, so
it never changes from the PoV of any C code.

It might make sense to have x86 do likewise and update `current_task` in asm,
or to split the raw context-switch code out into a separate file, since it
should probably all be noinstr anyway...

> > As above, the actual context-switch occurs in arch code --I assume the
> > out-of-line call *must* act as a clobber from the instrumentation's PoV or we'd
> > have many more problems.
> 
> Treating a function call as a clobber of kmsan_context_state() is
> actually an interesting idea.
> Adding yet another call to __msan_get_context_state() after every
> function call may sound harsh, but we already instrument every memory
> access anyway.

As above, I don't think that clobbering is necessary after all; you only need
to ensure the function which performs the switch and whatever it calls are not
instrumented.

> What remains unclear is handling the return value of the innermost
> function that performed the switch: it will be saved to the old task's
> state, but taken from that of the new task.

As above, I think you just need ot protect x86-64's __switch_to() and callees,
and perhaps wherever this is first initiailized for a CPU.

> > I also didn't spot any *explciit* state switching
> > being added there that would seem to affect KMSAN.
> >
> > ... so I don't understand why checks need to be inhibited for the core sched code.
> 
> In fact for a long time there were only three functions annotated with
> __no_kmsan_checks right in arch/x86/kernel/process_64.c and
> kernel/sched/core.c
> We decided to apply this attribute to every function in both files,
> just to make sure nothing breaks too early while upstreaming KMSAN.

I appreciate that rationale, but I think it would be better to be precise for
now; otherwise it'll be much harder to remove the limitation in future as we
won't know what we're actually protecting, and it means the other code in those
files will benefit from KMSAN.

Thanks,
Mark.
