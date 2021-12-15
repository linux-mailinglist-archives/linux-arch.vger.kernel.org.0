Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6E9475A59
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 15:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbhLOONS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 09:13:18 -0500
Received: from foss.arm.com ([217.140.110.172]:53092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243206AbhLOONR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 09:13:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05DE3142F;
        Wed, 15 Dec 2021 06:13:17 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372A03F774;
        Wed, 15 Dec 2021 06:13:12 -0800 (PST)
Date:   Wed, 15 Dec 2021 14:13:09 +0000
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
Message-ID: <Ybn39Z5dwcbrbs0O@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-26-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-26-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:32PM +0100, Alexander Potapenko wrote:
> When instrumenting functions, KMSAN obtains the per-task state (mostly
> pointers to metadata for function arguments and return values) once per
> function at its beginning.

How does KMSAN instrumentation acquire the per-task state? What's used as the
base for that?

> If a function performs a context switch, instrumented code won't notice
> that, and will still refer to the old state, possibly corrupting it or
> using stale data. This may result in false positive reports.
> 
> To deal with that, we need to apply __no_kmsan_checks to the functions
> performing context switching - this will result in skipping all KMSAN
> shadow checks and marking newly created values as initialized,
> preventing all false positive reports in those functions. False negatives
> are still possible, but we expect them to be rare and impersistent.
> 
> To improve maintainability, we choose to apply __no_kmsan_checks not
> just to a handful of functions, but to the whole files that may perform
> context switching - this is done via KMSAN_ENABLE_CHECKS:=n.
> This decision can be reconsidered in the future, when KMSAN won't need
> so much attention.

I worry this might be the wrong approach (and I've given some rationale below),
but it's not clear to me exactly how this goes wrong. Could you give an example
flow where stale data gets used?

> 
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/Id40563d36792b4482534c9a0134965d77a5581fa
> ---
>  arch/x86/kernel/Makefile | 4 ++++
>  kernel/sched/Makefile    | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 0b9fc3ecce2de..308d4d0323263 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -38,6 +38,10 @@ KCSAN_SANITIZE := n
>  KMSAN_SANITIZE_head$(BITS).o				:= n
>  KMSAN_SANITIZE_nmi.o					:= n
>  
> +# Some functions in process_64.c perform context switching.
> +# Apply __no_kmsan_checks to the whole file to avoid false positives.
> +KMSAN_ENABLE_CHECKS_process_64.o			:= n

Which state are you worried about here? The __switch_to() funciton is
tail-called from __switch_to_asm(), so the GPRs and SP should all be consistent
with the new task.

Are you concerned with the segment registers? Something else?

> +
>  OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
>  
>  ifdef CONFIG_FRAME_POINTER
> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index c7421f2d05e15..d9bf8223a064a 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -17,6 +17,10 @@ KCOV_INSTRUMENT := n
>  # eventually.
>  KCSAN_SANITIZE := n
>  
> +# Some functions in core.c perform context switching. Apply __no_kmsan_checks
> +# to the whole file to avoid false positives.
> +KMSAN_ENABLE_CHECKS_core.o := n

As above, the actual context-switch occurs in arch code --I assume the
out-of-line call *must* act as a clobber from the instrumentation's PoV or we'd
have many more problems. I also didn't spot any *explciit* state switching
being added there that would seem to affect KMSAN.

... so I don't understand why checks need to be inhibited for the core sched code.

Thanks
Mark.

> +
>  ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
>  # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
>  # needed for x86 only.  Why this used to be enabled for all architectures is beyond
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
