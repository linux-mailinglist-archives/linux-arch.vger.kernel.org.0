Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB86E0616
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2019 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfJVOLg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Oct 2019 10:11:36 -0400
Received: from [217.140.110.172] ([217.140.110.172]:53762 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1732055AbfJVOLg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Oct 2019 10:11:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97B851764;
        Tue, 22 Oct 2019 07:11:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E6AC3F71A;
        Tue, 22 Oct 2019 07:11:06 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:11:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, npiggin@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191022141103.GE11583@lakrids.cambridge.arm.com>
References: <20191017141305.146193-1-elver@google.com>
 <20191017141305.146193-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017141305.146193-2-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marco,

On Thu, Oct 17, 2019 at 04:12:58PM +0200, Marco Elver wrote:
> Kernel Concurrency Sanitizer (KCSAN) is a dynamic data-race detector for
> kernel space. KCSAN is a sampling watchpoint-based data-race detector.
> See the included Documentation/dev-tools/kcsan.rst for more details.
> 
> This patch adds basic infrastructure, but does not yet enable KCSAN for
> any architecture.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Elaborate comment about instrumentation calls emitted by compilers.
> * Replace kcsan_check_access(.., {true, false}) with
>   kcsan_check_{read,write} for improved readability.
> * Change bug title of race of unknown origin to just say "data-race in".
> * Refine "Key Properties" in kcsan.rst, and mention observed slow-down.
> * Add comment about safety of find_watchpoint without user_access_save.
> * Remove unnecessary preempt_disable/enable and elaborate on comment why
>   we want to disable interrupts and preemptions.
> * Use common struct kcsan_ctx in task_struct and for per-CPU interrupt
>   contexts [Suggested by Mark Rutland].

This is generally looking good to me.

I have a few comments below. Those are mostly style and naming things to
minimize surprise, though I also have a couple of queries (nested vs
flat atomic regions and the number of watchpoints).

[...]

> diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
> new file mode 100644
> index 000000000000..fd5de2ba3a16
> --- /dev/null
> +++ b/include/linux/kcsan.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_KCSAN_H
> +#define _LINUX_KCSAN_H
> +
> +#include <linux/types.h>
> +#include <linux/kcsan-checks.h>
> +
> +#ifdef CONFIG_KCSAN
> +
> +/*
> + * Context for each thread of execution: for tasks, this is stored in
> + * task_struct, and interrupts access internal per-CPU storage.
> + */
> +struct kcsan_ctx {
> +	int disable; /* disable counter */

Can we call this disable_count? That would match the convention used for
preempt_count, and make it clear this isn't a boolean.

> +	int atomic_next; /* number of following atomic ops */

I'm a little unclear on why we need this given the begin ... end
helpers -- isn't knowing that we're in an atomic region sufficient?

> +
> +	/*
> +	 * We use separate variables to store if we are in a nestable or flat
> +	 * atomic region. This helps make sure that an atomic region with
> +	 * nesting support is not suddenly aborted when a flat region is
> +	 * contained within. Effectively this allows supporting nesting flat
> +	 * atomic regions within an outer nestable atomic region. Support for
> +	 * this is required as there are cases where a seqlock reader critical
> +	 * section (flat atomic region) is contained within a seqlock writer
> +	 * critical section (nestable atomic region), and the "mismatching
> +	 * kcsan_end_atomic()" warning would trigger otherwise.
> +	 */
> +	int atomic_region;
> +	bool atomic_region_flat;
> +};

I think we need to introduce nestability and flatness first. How about:

	/*
	 * Some atomic sequences are flat, and cannot contain another
	 * atomic sequence. Other atomic sequences are nestable, and may
	 * contain other flat and/or nestable sequences.
	 *
	 * For example, a seqlock writer critical section is nestable
	 * and may contain a seqlock reader critical section, which is
	 * flat.
	 *
	 * To support this we track the depth of nesting, and whether
	 * the leaf level is flat.
	 */
	int atomic_nest_count;
	bool in_flat_atomic;

That said, I'm not entirely clear on the distinction. Why would nesting
a reader within another reader not be legitimate?

> +
> +/**
> + * kcsan_init - initialize KCSAN runtime
> + */
> +void kcsan_init(void);
> +
> +/**
> + * kcsan_disable_current - disable KCSAN for the current context
> + *
> + * Supports nesting.
> + */
> +void kcsan_disable_current(void);
> +
> +/**
> + * kcsan_enable_current - re-enable KCSAN for the current context
> + *
> + * Supports nesting.
> + */
> +void kcsan_enable_current(void);
> +
> +/**
> + * kcsan_begin_atomic - use to denote an atomic region
> + *
> + * Accesses within the atomic region may appear to race with other accesses but
> + * should be considered atomic.
> + *
> + * @nest true if regions may be nested, or false for flat region
> + */
> +void kcsan_begin_atomic(bool nest);
> +
> +/**
> + * kcsan_end_atomic - end atomic region
> + *
> + * @nest must match argument to kcsan_begin_atomic().
> + */
> +void kcsan_end_atomic(bool nest);
> +

Similarly to the check_{read,write}() naming, could we get rid of the
bool argument and split this into separate nestable and flat functions?

That makes it easier to read in-context, e.g.

	kcsan_nestable_atomic_begin();
	...
	kcsan_nestable_atomic_end();

... has a more obvious meaning than:

	kcsan_begin_atomic(true);
	...
	kcsan_end_atomic(true);

... and putting the begin/end at the end of the name makes it easier to
spot the matching pair.

[...]

> +static inline bool is_enabled(void)
> +{
> +	return READ_ONCE(kcsan_enabled) && get_ctx()->disable == 0;
> +}

Can we please make this kcsan_is_enabled(), to avoid confusion with
IS_ENABLED()?

> +static inline unsigned int get_delay(void)
> +{
> +	unsigned int max_delay = in_task() ? CONFIG_KCSAN_UDELAY_MAX_TASK :
> +					     CONFIG_KCSAN_UDELAY_MAX_INTERRUPT;
> +	return IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
> +		       ((prandom_u32() % max_delay) + 1) :
> +		       max_delay;
> +}
> +
> +/* === Public interface ===================================================== */
> +
> +void __init kcsan_init(void)
> +{
> +	BUG_ON(!in_task());
> +
> +	kcsan_debugfs_init();
> +	kcsan_enable_current();
> +#ifdef CONFIG_KCSAN_EARLY_ENABLE
> +	/*
> +	 * We are in the init task, and no other tasks should be running.
> +	 */
> +	WRITE_ONCE(kcsan_enabled, true);
> +#endif

Where possible, please use IS_ENABLED() rather than ifdeffery for
portions of functions like this, e.g.

	/*
	 * We are in the init task, and no other tasks should be running.
	 */
	if (IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE))
		WRITE_ONCE(kcsan_enabled, true);

That makes code a bit easier to read, and ensures that the code always
gets build coverage, so it's less likely that code changes will
introduce a build failure when the option is enabled.

[...]

> +#ifdef CONFIG_KCSAN_DEBUG
> +	kcsan_disable_current();
> +	pr_err("KCSAN: watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
> +	       is_write ? "write" : "read", size, ptr,
> +	       watchpoint_slot((unsigned long)ptr),
> +	       encode_watchpoint((unsigned long)ptr, size, is_write));
> +	kcsan_enable_current();
> +#endif

This can use IS_ENABLED(), e.g.

	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
		kcsan_disable_current();
		pr_err("KCSAN: watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
		       is_write ? "write" : "read", size, ptr,
		       watchpoint_slot((unsigned long)ptr),
		       encode_watchpoint((unsigned long)ptr, size, is_write));
		kcsan_enable_current();
	}

[...]
> +#ifdef CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> +		kcsan_report(ptr, size, is_write, smp_processor_id(),
> +			     kcsan_report_race_unknown_origin);
> +#endif

This can also use IS_ENABLED().

[...]

> diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> new file mode 100644
> index 000000000000..429479b3041d
> --- /dev/null
> +++ b/kernel/kcsan/kcsan.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _MM_KCSAN_KCSAN_H
> +#define _MM_KCSAN_KCSAN_H
> +
> +#include <linux/kcsan.h>
> +
> +/*
> + * Total number of watchpoints. An address range maps into a specific slot as
> + * specified in `encoding.h`. Although larger number of watchpoints may not even
> + * be usable due to limited thread count, a larger value will improve
> + * performance due to reducing cache-line contention.
> + */
> +#define KCSAN_NUM_WATCHPOINTS 64

Is there any documentation as to how 64 was chosen? It's fine if it's
arbitrary, but it would be good to know either way.

I wonder if this is something that might need to scale with NR_CPUS (or
nr_cpus).

> +enum kcsan_counter_id {
> +	/*
> +	 * Number of watchpoints currently in use.
> +	 */
> +	kcsan_counter_used_watchpoints,

Nit: typically enum values are capitalized (as coding-style.rst says).
That helps to make it clear each value is a constant rather than a
variable. Likewise for the other enums here.

Thanks,
Mark.
