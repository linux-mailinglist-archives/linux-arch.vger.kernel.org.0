Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB7E59555E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiHPIdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 04:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiHPIcf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 04:32:35 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C26126968;
        Mon, 15 Aug 2022 22:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1660628802; bh=AaN7PS7L2FSUecgmfMgiALFR+SMEdOMy+KNQRzIh00g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ePfpasWIt6WwK6xyMjKf/my2vMDdoOsGUm64MeyjbJeXYo382WUMkoAj1Ket7gJob
         37ZYfaPrcITor0xWKkZErqvQgQuC03E1JUISoGRTqAlCmjqA31A2HDQOC+jhtg4WtT
         2TSTyvpggDp0hod0RUqU5v14soA4qjm98IoJPsTw=
Received: from [100.100.57.219] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id A10D86010B;
        Tue, 16 Aug 2022 13:46:41 +0800 (CST)
Message-ID: <53074d4d-b895-0afa-696e-c9358a07e109@xen0n.name>
Date:   Tue, 16 Aug 2022 13:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:105.0)
 Gecko/20100101 Thunderbird/105.0a1
Subject: Re: [PATCH] LoongArch: Add perf events support
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220815124702.3330803-1-chenhuacai@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220815124702.3330803-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022/8/15 20:47, Huacai Chen wrote:
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/Kconfig                      |   2 +
>   arch/loongarch/include/uapi/asm/perf_regs.h |  40 +
>   arch/loongarch/kernel/Makefile              |   2 +
>   arch/loongarch/kernel/perf_event.c          | 909 ++++++++++++++++++++
>   arch/loongarch/kernel/perf_regs.c           |  50 ++
>   5 files changed, 1003 insertions(+)
>   create mode 100644 arch/loongarch/include/uapi/asm/perf_regs.h
>   create mode 100644 arch/loongarch/kernel/perf_event.c
>   create mode 100644 arch/loongarch/kernel/perf_regs.c

The code seems mostly ripped from arch/mips/kernel/perf_event_mipsxx.c. 
I reviewed about half of the code then suddenly realized I might be 
looking at MIPS code, given some of the English strings there seemed way 
too "natural"...

But unfortunately, at least for 3A5000 whose micro-architecture is 
largely shared with the MIPS-implementing 3A4000, it seems inevitable to 
involve some of the more MIPS-looking logic. The 1st-generation LA 
privileged architecture is way too much MIPS-like after all, so if we 
want any support for the 3A5000 we'd have to include this.

> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 24665808cf3d..9478f9646fa5 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -93,6 +93,8 @@ config LOONGARCH
>   	select HAVE_NMI
>   	select HAVE_PCI
>   	select HAVE_PERF_EVENTS
> +	select HAVE_PERF_REGS
> +	select HAVE_PERF_USER_STACK_DUMP
>   	select HAVE_REGS_AND_STACK_ACCESS_API
>   	select HAVE_RSEQ
>   	select HAVE_SETUP_PER_CPU_AREA if NUMA
> diff --git a/arch/loongarch/include/uapi/asm/perf_regs.h b/arch/loongarch/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 000000000000..9943d418e01d
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _ASM_LOONGARCH_PERF_REGS_H
> +#define _ASM_LOONGARCH_PERF_REGS_H
> +
> +enum perf_event_loongarch_regs {
> +	PERF_REG_LOONGARCH_PC,
> +	PERF_REG_LOONGARCH_R1,
> +	PERF_REG_LOONGARCH_R2,
> +	PERF_REG_LOONGARCH_R3,
> +	PERF_REG_LOONGARCH_R4,
> +	PERF_REG_LOONGARCH_R5,
> +	PERF_REG_LOONGARCH_R6,
> +	PERF_REG_LOONGARCH_R7,
> +	PERF_REG_LOONGARCH_R8,
> +	PERF_REG_LOONGARCH_R9,
> +	PERF_REG_LOONGARCH_R10,
> +	PERF_REG_LOONGARCH_R11,
> +	PERF_REG_LOONGARCH_R12,
> +	PERF_REG_LOONGARCH_R13,
> +	PERF_REG_LOONGARCH_R14,
> +	PERF_REG_LOONGARCH_R15,
> +	PERF_REG_LOONGARCH_R16,
> +	PERF_REG_LOONGARCH_R17,
> +	PERF_REG_LOONGARCH_R18,
> +	PERF_REG_LOONGARCH_R19,
> +	PERF_REG_LOONGARCH_R20,
> +	PERF_REG_LOONGARCH_R21,
> +	PERF_REG_LOONGARCH_R22,
> +	PERF_REG_LOONGARCH_R23,
> +	PERF_REG_LOONGARCH_R24,
> +	PERF_REG_LOONGARCH_R25,
> +	PERF_REG_LOONGARCH_R26,
> +	PERF_REG_LOONGARCH_R27,
> +	PERF_REG_LOONGARCH_R28,
> +	PERF_REG_LOONGARCH_R29,
> +	PERF_REG_LOONGARCH_R30,
> +	PERF_REG_LOONGARCH_R31,
> +	PERF_REG_LOONGARCH_MAX = PERF_REG_LOONGARCH_R31 + 1,

No need for this "PERF_REG_LOONGARCH_R31 + 1" because it's what happens 
without the assignment anyway?

> +};
> +#endif /* _ASM_LOONGARCH_PERF_REGS_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index e5be17009fe8..a213e994db68 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -26,4 +26,6 @@ obj-$(CONFIG_NUMA)		+= numa.o
>   obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
>   obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
>   
> +obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
> +
>   CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
> new file mode 100644
> index 000000000000..00cdbcebaf80
> --- /dev/null
> +++ b/arch/loongarch/kernel/perf_event.c
> @@ -0,0 +1,909 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux performance counter support for LoongArch.

Please indicate its MIPS origin and copyright info ;-)

> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/cpumask.h>
> +#include <linux/interrupt.h>
> +#include <linux/smp.h>
> +#include <linux/kernel.h>
> +#include <linux/perf_event.h>
> +#include <linux/uaccess.h>
> +#include <linux/sched/task_stack.h>
> +
> +#include <asm/irq.h>
> +#include <asm/irq_regs.h>
> +#include <asm/stacktrace.h>
> +#include <asm/unwind.h>
> +
> +/*
> + * Get the return address for a single stackframe and return a pointer to the
> + * next frame tail.
> + */
> +static unsigned long
> +user_backtrace(struct perf_callchain_entry_ctx *entry, unsigned long fp)
> +{
> +	struct stack_frame buftail;
> +	unsigned long err;
> +	unsigned long __user *user_frame_tail = (unsigned long *)(fp - sizeof(struct stack_frame));
> +
> +	/* Also check accessibility of one struct frame_tail beyond */
> +	if (!access_ok(user_frame_tail, sizeof(buftail)))
> +		return 0;
> +
> +	pagefault_disable();
> +	err = __copy_from_user_inatomic(&buftail, user_frame_tail, sizeof(buftail));
> +	pagefault_enable();
> +
> +	if (err || (unsigned long)user_frame_tail >= buftail.fp)
> +		return 0;
> +
> +	perf_callchain_store(entry, buftail.ra);
> +
> +	return buftail.fp;
> +}
> +
> +void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
> +			 struct pt_regs *regs)
> +{
> +	unsigned long fp;
> +
> +	if (perf_guest_state()) {
> +		/* We don't support guest os callchain now */
> +		return;
> +	}
> +
> +	perf_callchain_store(entry, regs->csr_era);
> +
> +	fp = regs->regs[22];
> +
> +	while (entry->nr < entry->max_stack && fp && !((unsigned long)fp & 0xf))
> +		fp = user_backtrace(entry, fp);
> +}
> +
> +void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
> +			   struct pt_regs *regs)
> +{
> +	struct unwind_state state;
> +	unsigned long addr;
> +
> +	for (unwind_start(&state, current, regs);
> +	      !unwind_done(&state); unwind_next_frame(&state)) {
> +		addr = unwind_get_return_address(&state);
> +		if (!addr || perf_callchain_store(entry, addr))
> +			return;
> +	}
> +}
> +
> +#define LOONGARCH_MAX_HWEVENTS 4
> +
> +struct cpu_hw_events {
> +	/* Array of events on this cpu. */
> +	struct perf_event	*events[LOONGARCH_MAX_HWEVENTS];
> +
> +	/*
> +	 * Set the bit (indexed by the counter number) when the counter
> +	 * is used for an event.
> +	 */
> +	unsigned long		used_mask[BITS_TO_LONGS(LOONGARCH_MAX_HWEVENTS)];
> +
> +	/*
> +	 * Software copy of the control register for each performance counter.
> +	 * LoongArch CPUs vary in performance counters. They use this differently,
> +	 * and even may not use it.

I can't easily make sense of the paragraph. "Software copy" could mean 
"Saved copy", but how do "use differently" and "even may not use it" 
mean? For the latter I can't deduce if it's originally "some even may 
not exist" in someone's head, and for the former I can't imagine what's 
the possible cases and why we would care.

Maybe explain a little bit more?

> +	 */
> +	unsigned int		saved_ctrl[LOONGARCH_MAX_HWEVENTS];
> +};
> +static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
> +	.saved_ctrl = {0},
> +};
> +
> +/* The description of LoongArch performance events. */
> +struct loongarch_perf_event {
> +	unsigned int event_id;
> +};
> +
> +static struct loongarch_perf_event raw_event;
> +static DEFINE_MUTEX(raw_event_mutex);
> +
> +#define C(x) PERF_COUNT_HW_CACHE_##x
> +#define HW_OP_UNSUPPORTED		0xffffffff
> +#define CACHE_OP_UNSUPPORTED		0xffffffff
> +
> +#define PERF_MAP_ALL_UNSUPPORTED					\
> +	[0 ... PERF_COUNT_HW_MAX - 1] = {HW_OP_UNSUPPORTED}
> +
> +#define PERF_CACHE_MAP_ALL_UNSUPPORTED					\
> +[0 ... C(MAX) - 1] = {							\
> +	[0 ... C(OP_MAX) - 1] = {					\
> +		[0 ... C(RESULT_MAX) - 1] = {CACHE_OP_UNSUPPORTED},	\
> +	},								\
> +}
> +
> +struct loongarch_pmu {
> +	u64		max_period;
> +	u64		valid_count;
> +	u64		overflow;
> +	const char	*name;
> +	u64		(*read_counter)(unsigned int idx);
> +	void		(*write_counter)(unsigned int idx, u64 val);
> +	const struct loongarch_perf_event *(*map_raw_event)(u64 config);
> +	const struct loongarch_perf_event (*general_event_map)[PERF_COUNT_HW_MAX];
> +	const struct loongarch_perf_event (*cache_event_map)
> +				[PERF_COUNT_HW_CACHE_MAX]
> +				[PERF_COUNT_HW_CACHE_OP_MAX]
> +				[PERF_COUNT_HW_CACHE_RESULT_MAX];

Apparently general_event_map and cache_event_map are not function 
pointers? So the parens around the field name should be removed.

> +	unsigned int	num_counters;
> +};
> +
> +static struct loongarch_pmu loongarch_pmu;
> +
> +#define M_PERFCTL_EVENT(event)	(event & CSR_PERFCTRL_EVENT)
> +
> +#define M_PERFCTL_COUNT_EVENT_WHENEVER	(CSR_PERFCTRL_PLV0 |	\
> +					CSR_PERFCTRL_PLV1 |	\
> +					CSR_PERFCTRL_PLV2 |	\
> +					CSR_PERFCTRL_PLV3 |	\
> +					CSR_PERFCTRL_IE)
> +
> +#define M_PERFCTL_CONFIG_MASK		0x1f0000
> +
> +#define CNTR_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))

Isn't this just GENMASK(n - 1, 0)?

> +
> +static void resume_local_counters(void);
> +static void pause_local_counters(void);
> +
> +static u64 loongarch_pmu_read_counter(unsigned int idx)
> +{
> +	u64 val = -1;
> +
> +	switch (idx) {
> +	case 0:
> +		val = read_csr_perfcntr0();
> +		break;
> +	case 1:
> +		val = read_csr_perfcntr1();
> +		break;
> +	case 2:
> +		val = read_csr_perfcntr2();
> +		break;
> +	case 3:
> +		val = read_csr_perfcntr3();
> +		break;
> +	default:
> +		WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
> +		return 0;
> +	}
> +
> +	return val;
> +}
> +
> +static void loongarch_pmu_write_counter(unsigned int idx, u64 val)
> +{
> +	switch (idx) {
> +	case 0:
> +		write_csr_perfcntr0(val);
> +		return;
> +	case 1:
> +		write_csr_perfcntr1(val);
> +		return;
> +	case 2:
> +		write_csr_perfcntr2(val);
> +		return;
> +	case 3:
> +		write_csr_perfcntr3(val);
> +		return;

Want a default branch for this function, similar to the read case?

> +	}
> +}
> +
> +static unsigned int loongarch_pmu_read_control(unsigned int idx)
> +{
> +	unsigned int val = -1;
> +
> +	switch (idx) {
> +	case 0:
> +		val = read_csr_perfctrl0();
> +		break;
> +	case 1:
> +		val = read_csr_perfctrl1();
> +		break;
> +	case 2:
> +		val = read_csr_perfctrl2();
> +		break;
> +	case 3:
> +		val = read_csr_perfctrl3();
> +		break;
> +	default:
> +		WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
> +		return 0;
> +	}
> +
> +	return val;
> +}
> +
> +static void loongarch_pmu_write_control(unsigned int idx, unsigned int val)
> +{
> +	switch (idx) {
> +	case 0:
> +		write_csr_perfctrl0(val);
> +		return;
> +	case 1:
> +		write_csr_perfctrl1(val);
> +		return;
> +	case 2:
> +		write_csr_perfctrl2(val);
> +		return;
> +	case 3:
> +		write_csr_perfctrl3(val);
> +		return;

Similarly here.

> +	}
> +}
> +
> +static int loongarch_pmu_alloc_counter(struct cpu_hw_events *cpuc,
> +				    struct hw_perf_event *hwc)
> +{
> +	int i;
> +
> +	for (i = loongarch_pmu.num_counters - 1; i >= 0; i--) {
> +		if (!test_and_set_bit(i, cpuc->used_mask))
> +			return i;
> +	}
> +
> +	return -EAGAIN;
> +}
> +
> +static void loongarch_pmu_enable_event(struct hw_perf_event *evt, int idx)
> +{
> +	struct perf_event *event = container_of(evt, struct perf_event, hw);
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	unsigned int cpu;
> +
> +	WARN_ON(idx < 0 || idx >= loongarch_pmu.num_counters);
> +
> +	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base & 0xff) |
> +		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
> +		/* Make sure interrupt enabled. */
> +		CSR_PERFCTRL_IE;
> +
> +	cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
> +
> +	pr_debug("Enabling perf counter for CPU%d\n", cpu);
> +	/*
> +	 * We do not actually let the counter run. Leave it until start().
> +	 */
> +}
> +
> +static void loongarch_pmu_disable_event(int idx)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	unsigned long flags;
> +
> +	WARN_ON(idx < 0 || idx >= loongarch_pmu.num_counters);
> +
> +	local_irq_save(flags);
> +	cpuc->saved_ctrl[idx] = loongarch_pmu_read_control(idx) &
> +		~M_PERFCTL_COUNT_EVENT_WHENEVER;
> +	loongarch_pmu_write_control(idx, cpuc->saved_ctrl[idx]);
> +	local_irq_restore(flags);
> +}
> +
> +static int loongarch_pmu_event_set_period(struct perf_event *event,
> +				    struct hw_perf_event *hwc,
> +				    int idx)
> +{
> +	u64 left = local64_read(&hwc->period_left);
> +	u64 period = hwc->sample_period;
> +	int ret = 0;
> +
> +	if (unlikely((left + period) & (1ULL << 63))) {
> +		/* left underflowed by more than period. */
> +		left = period;
> +		local64_set(&hwc->period_left, left);
> +		hwc->last_period = period;
> +		ret = 1;
> +	} else	if (unlikely((left + period) <= period)) {
> +		/* left underflowed by less than period. */
> +		left += period;
> +		local64_set(&hwc->period_left, left);
> +		hwc->last_period = period;
> +		ret = 1;
> +	}
> +
> +	if (left > loongarch_pmu.max_period) {
> +		left = loongarch_pmu.max_period;
> +		local64_set(&hwc->period_left, left);
> +	}
> +
> +	local64_set(&hwc->prev_count, loongarch_pmu.overflow - left);
> +
> +	loongarch_pmu.write_counter(idx, loongarch_pmu.overflow - left);
> +
> +	perf_event_update_userpage(event);
> +
> +	return ret;
> +}
> +
> +static void loongarch_pmu_event_update(struct perf_event *event,
> +				 struct hw_perf_event *hwc,
> +				 int idx)
> +{
> +	u64 delta;
> +	u64 prev_raw_count, new_raw_count;
> +
> +again:
> +	prev_raw_count = local64_read(&hwc->prev_count);
> +	new_raw_count = loongarch_pmu.read_counter(idx);
> +
> +	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> +				new_raw_count) != prev_raw_count)
> +		goto again;
> +
> +	delta = new_raw_count - prev_raw_count;
> +
> +	local64_add(delta, &event->count);
> +	local64_sub(delta, &hwc->period_left);
> +}
> +
> +static void loongarch_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (flags & PERF_EF_RELOAD)
> +		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> +
> +	hwc->state = 0;
> +
> +	/* Set the period for the event. */
> +	loongarch_pmu_event_set_period(event, hwc, hwc->idx);
> +
> +	/* Enable the event. */
> +	loongarch_pmu_enable_event(hwc, hwc->idx);
> +}
> +
> +static void loongarch_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (!(hwc->state & PERF_HES_STOPPED)) {
> +		/* We are working on a local event. */
> +		loongarch_pmu_disable_event(hwc->idx);
> +		barrier();
> +		loongarch_pmu_event_update(event, hwc, hwc->idx);
> +		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	}
> +}
> +
> +static int loongarch_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +	int err = 0;
> +
> +	perf_pmu_disable(event->pmu);
> +
> +	/* To look for a free counter for this event. */
> +	idx = loongarch_pmu_alloc_counter(cpuc, hwc);
> +	if (idx < 0) {
> +		err = idx;
> +		goto out;
> +	}
> +
> +	/*
> +	 * If there is an event in the counter we are going to use then
> +	 * make sure it is disabled.
> +	 */
> +	event->hw.idx = idx;
> +	loongarch_pmu_disable_event(idx);
> +	cpuc->events[idx] = event;
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	if (flags & PERF_EF_START)
> +		loongarch_pmu_start(event, PERF_EF_RELOAD);
> +
> +	/* Propagate our changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +out:
> +	perf_pmu_enable(event->pmu);
> +	return err;
> +}
> +
> +static void loongarch_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	WARN_ON(idx < 0 || idx >= loongarch_pmu.num_counters);
> +
> +	loongarch_pmu_stop(event, PERF_EF_UPDATE);
> +	cpuc->events[idx] = NULL;
> +	clear_bit(idx, cpuc->used_mask);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void loongarch_pmu_read(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* Don't read disabled counters! */
> +	if (hwc->idx < 0)
> +		return;
> +
> +	loongarch_pmu_event_update(event, hwc, hwc->idx);
> +}
> +
> +static void loongarch_pmu_enable(struct pmu *pmu)
> +{
> +	resume_local_counters();
> +}
> +
> +static void loongarch_pmu_disable(struct pmu *pmu)
> +{
> +	pause_local_counters();
> +}
> +
> +static atomic_t active_events = ATOMIC_INIT(0);
> +static DEFINE_MUTEX(pmu_reserve_mutex);
> +
> +static void reset_counters(void *arg);
> +static int __hw_perf_event_init(struct perf_event *event);
> +
> +static void hw_perf_event_destroy(struct perf_event *event)
> +{
> +	if (atomic_dec_and_mutex_lock(&active_events,
> +				&pmu_reserve_mutex)) {
> +		/*
> +		 * We must not call the destroy function with interrupts
> +		 * disabled.
> +		 */
> +		on_each_cpu(reset_counters,
> +			(void *)(long)loongarch_pmu.num_counters, 1);
> +		mutex_unlock(&pmu_reserve_mutex);
> +	}
> +}
> +
> +/* This is needed by specific irq handlers in perf_event_*.c */
> +static void handle_associated_event(struct cpu_hw_events *cpuc,
> +				    int idx, struct perf_sample_data *data,
> +				    struct pt_regs *regs)
> +{
> +	struct perf_event *event = cpuc->events[idx];
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	loongarch_pmu_event_update(event, hwc, idx);
> +	data->period = event->hw.last_period;
> +	if (!loongarch_pmu_event_set_period(event, hwc, idx))
> +		return;
> +
> +	if (perf_event_overflow(event, data, regs))
> +		loongarch_pmu_disable_event(idx);
> +}
> +
> +static irqreturn_t pmu_handle_irq(int irq, void *dev)
> +{
> +	int handled = IRQ_NONE;
> +	unsigned int counters = loongarch_pmu.num_counters;
> +	u64 counter;
> +	struct pt_regs *regs;
> +	struct perf_sample_data data;
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	/*
> +	 * First we pause the local counters, so that when we are locked
> +	 * here, the counters are all paused. When it gets locked due to
> +	 * perf_disable(), the timer interrupt handler will be delayed.
> +	 *
> +	 * See also loongarch_pmu_start().
> +	 */
> +	pause_local_counters();
> +
> +	regs = get_irq_regs();
> +
> +	perf_sample_data_init(&data, 0, 0);
> +
> +	switch (counters) {
> +#define HANDLE_COUNTER(n)						\
> +	case n + 1:							\
> +		if (test_bit(n, cpuc->used_mask)) {			\
> +			counter = loongarch_pmu.read_counter(n);	\
> +			if (counter & loongarch_pmu.overflow) {		\
> +				handle_associated_event(cpuc, n, &data, regs); \
> +				handled = IRQ_HANDLED;			\
> +			}						\
> +		}
> +	HANDLE_COUNTER(3)
> +		fallthrough;
> +	HANDLE_COUNTER(2)
> +		fallthrough;
> +	HANDLE_COUNTER(1)
> +		fallthrough;
> +	HANDLE_COUNTER(0)
> +	}
> +
> +	resume_local_counters();
> +
> +	/*
> +	 * Do all the work for the pending perf events. We can do this
> +	 * in here because the performance counter interrupt is a regular
> +	 * interrupt, not NMI.
> +	 */
> +	if (handled == IRQ_HANDLED)
> +		irq_work_run();
> +
> +	return handled;
> +}
> +
> +static int get_pmc_irq(void)
> +{
> +	struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
> +
> +	if (d)
> +		return irq_create_mapping(d, EXCCODE_PMC - EXCCODE_INT_START);
> +
> +	return -EINVAL;
> +}
> +
> +static int loongarch_pmu_event_init(struct perf_event *event)
> +{
> +	int r, irq;
> +	unsigned long flags;
> +
> +	/* does not support taken branch sampling */
> +	if (has_branch_stack(event))
> +		return -EOPNOTSUPP;
> +
> +	switch (event->attr.type) {
> +	case PERF_TYPE_RAW:
> +	case PERF_TYPE_HARDWARE:
> +	case PERF_TYPE_HW_CACHE:
> +		break;
> +
> +	default:
> +		/* Init it to avoid false validate_group */
> +		event->hw.event_base = 0xffffffff;
> +		return -ENOENT;
> +	}
> +
> +	if (event->cpu >= 0 && !cpu_online(event->cpu))
> +		return -ENODEV;
> +
> +	irq = get_pmc_irq();
> +	flags = IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_THREAD | IRQF_NO_SUSPEND | IRQF_SHARED;
> +	if (!atomic_inc_not_zero(&active_events)) {
> +		mutex_lock(&pmu_reserve_mutex);
> +		if (atomic_read(&active_events) == 0) {
> +			r = request_irq(irq, pmu_handle_irq,
> +					flags, "Perf_PMU", &loongarch_pmu);
> +			if (r < 0) {
> +				pr_warn("PMU IRQ request failed\n");
> +				return -ENODEV;
> +			}
> +		}
> +		atomic_inc(&active_events);
> +		mutex_unlock(&pmu_reserve_mutex);
> +	}
> +
> +	return __hw_perf_event_init(event);
> +}
> +
> +static struct pmu pmu = {
> +	.pmu_enable	= loongarch_pmu_enable,
> +	.pmu_disable	= loongarch_pmu_disable,
> +	.event_init	= loongarch_pmu_event_init,
> +	.add		= loongarch_pmu_add,
> +	.del		= loongarch_pmu_del,
> +	.start		= loongarch_pmu_start,
> +	.stop		= loongarch_pmu_stop,
> +	.read		= loongarch_pmu_read,
> +};
> +
> +static unsigned int loongarch_pmu_perf_event_encode(const struct loongarch_perf_event *pev)
> +{
> +	return (pev->event_id & 0xff);
> +}
> +
> +static const struct loongarch_perf_event *loongarch_pmu_map_general_event(int idx)
> +{
> +	const struct loongarch_perf_event *pev;
> +
> +	pev = &(*loongarch_pmu.general_event_map)[idx];
> +
> +	if (pev->event_id == HW_OP_UNSUPPORTED)
> +		return ERR_PTR(-ENOENT);
> +
> +	return pev;
> +}
> +
> +static const struct loongarch_perf_event *loongarch_pmu_map_cache_event(u64 config)
> +{
> +	unsigned int cache_type, cache_op, cache_result;
> +	const struct loongarch_perf_event *pev;
> +
> +	cache_type = (config >> 0) & 0xff;
> +	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	cache_op = (config >> 8) & 0xff;
> +	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	cache_result = (config >> 16) & 0xff;
> +	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	pev = &((*loongarch_pmu.cache_event_map)
> +					[cache_type]
> +					[cache_op]
> +					[cache_result]);
> +
> +	if (pev->event_id == CACHE_OP_UNSUPPORTED)
> +		return ERR_PTR(-ENOENT);
> +
> +	return pev;
> +}
> +
> +static int validate_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	struct cpu_hw_events fake_cpuc;
> +
> +	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
> +
> +	if (loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
> +		return -EINVAL;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
> +			return -EINVAL;
> +	}
> +
> +	if (loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void reset_counters(void *arg)
> +{
> +	int counters = (int)(long)arg;
> +
> +	switch (counters) {
> +	case 4:
> +		loongarch_pmu_write_control(3, 0);
> +		loongarch_pmu.write_counter(3, 0);
> +		fallthrough;
> +	case 3:
> +		loongarch_pmu_write_control(2, 0);
> +		loongarch_pmu.write_counter(2, 0);
> +		fallthrough;
> +	case 2:
> +		loongarch_pmu_write_control(1, 0);
> +		loongarch_pmu.write_counter(1, 0);
> +		fallthrough;
> +	case 1:
> +		loongarch_pmu_write_control(0, 0);
> +		loongarch_pmu.write_counter(0, 0);
> +	}
> +}
> +
> +static const struct loongarch_perf_event loongson_new_event_map[PERF_COUNT_HW_MAX] = {
> +	PERF_MAP_ALL_UNSUPPORTED,
> +	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00 },
> +	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x01 },
> +	[PERF_COUNT_HW_CACHE_REFERENCES] = { 0x08 },
> +	[PERF_COUNT_HW_CACHE_MISSES] = { 0x09 },
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x02 },
> +	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x03 },
> +};
> +
> +static const struct loongarch_perf_event loongson_new_cache_map
> +				[PERF_COUNT_HW_CACHE_MAX]
> +				[PERF_COUNT_HW_CACHE_OP_MAX]
> +				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> +PERF_CACHE_MAP_ALL_UNSUPPORTED,
> +[C(L1D)] = {
> +	/*
> +	 * Like some other architectures (e.g. ARM), the performance
> +	 * counters don't differentiate between read and write
> +	 * accesses/misses, so this isn't strictly correct, but it's the
> +	 * best we can do. Writes and reads get combined.
> +	 */
> +	[C(OP_READ)] = {
> +		[C(RESULT_ACCESS)]	= { 0x8 },
> +		[C(RESULT_MISS)]	= { 0x9 },
> +	},
> +	[C(OP_WRITE)] = {
> +		[C(RESULT_ACCESS)]	= { 0x8 },
> +		[C(RESULT_MISS)]	= { 0x9 },
> +	},
> +	[C(OP_PREFETCH)] = {
> +		[C(RESULT_ACCESS)]	= { 0xaa },
> +		[C(RESULT_MISS)]	= { 0xa9 },
> +	},
> +},
> +[C(L1I)] = {
> +	[C(OP_READ)] = {
> +		[C(RESULT_ACCESS)]	= { 0x6 },
> +		[C(RESULT_MISS)]	= { 0x7 },
> +	},
> +},
> +[C(LL)] = {
> +	[C(OP_READ)] = {
> +		[C(RESULT_ACCESS)]	= { 0xc },
> +		[C(RESULT_MISS)]	= { 0xd },
> +	},
> +	[C(OP_WRITE)] = {
> +		[C(RESULT_ACCESS)]	= { 0xc },
> +		[C(RESULT_MISS)]	= { 0xd },
> +	},
> +},
> +[C(ITLB)] = {
> +	[C(OP_READ)] = {
> +		[C(RESULT_MISS)]    = { 0x3b },
> +	},
> +},
> +[C(DTLB)] = {
> +	[C(OP_READ)] = {
> +		[C(RESULT_ACCESS)]	= { 0x4 },
> +		[C(RESULT_MISS)]	= { 0x3c },
> +	},
> +	[C(OP_WRITE)] = {
> +		[C(RESULT_ACCESS)]	= { 0x4 },
> +		[C(RESULT_MISS)]	= { 0x3c },
> +	},
> +},
> +[C(BPU)] = {
> +	/* Using the same code for *HW_BRANCH* */
> +	[C(OP_READ)] = {
> +		[C(RESULT_ACCESS)]  = { 0x02 },
> +		[C(RESULT_MISS)]    = { 0x03 },
> +	},
> +},
> +};
> +
> +static int __hw_perf_event_init(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	struct hw_perf_event *hwc = &event->hw;
> +	const struct loongarch_perf_event *pev;
> +	int err;
> +
> +	/* Returning LoongArch event descriptor for generic perf event. */
> +	if (PERF_TYPE_HARDWARE == event->attr.type) {
> +		if (event->attr.config >= PERF_COUNT_HW_MAX)
> +			return -EINVAL;
> +		pev = loongarch_pmu_map_general_event(event->attr.config);
> +	} else if (PERF_TYPE_HW_CACHE == event->attr.type) {
> +		pev = loongarch_pmu_map_cache_event(event->attr.config);
> +	} else if (PERF_TYPE_RAW == event->attr.type) {
> +		/* We are working on the global raw event. */
> +		mutex_lock(&raw_event_mutex);
> +		pev = loongarch_pmu.map_raw_event(event->attr.config);
> +	} else {
> +		/* The event type is not (yet) supported. */
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (IS_ERR(pev)) {
> +		if (PERF_TYPE_RAW == event->attr.type)
> +			mutex_unlock(&raw_event_mutex);
> +		return PTR_ERR(pev);
> +	}
> +
> +	/*
> +	 * We allow max flexibility on how each individual counter shared
> +	 * by the single CPU operates (the mode exclusion and the range).
> +	 */
> +	hwc->config_base = CSR_PERFCTRL_IE;
> +
> +	hwc->event_base = loongarch_pmu_perf_event_encode(pev);
> +	if (PERF_TYPE_RAW == event->attr.type)
> +		mutex_unlock(&raw_event_mutex);
> +
> +	if (!attr->exclude_user) {
> +		hwc->config_base |= CSR_PERFCTRL_PLV3;
> +		hwc->config_base |= CSR_PERFCTRL_PLV2;
> +	}
> +	if (!attr->exclude_kernel) {
> +		hwc->config_base |= CSR_PERFCTRL_PLV0;
> +	}
> +	if (!attr->exclude_hv) {
> +		hwc->config_base |= CSR_PERFCTRL_PLV1;
> +	}
> +
> +	hwc->config_base &= M_PERFCTL_CONFIG_MASK;
> +	/*
> +	 * The event can belong to another cpu. We do not assign a local
> +	 * counter for it for now.
> +	 */
> +	hwc->idx = -1;
> +	hwc->config = 0;
> +
> +	if (!hwc->sample_period) {
> +		hwc->sample_period  = loongarch_pmu.max_period;
> +		hwc->last_period    = hwc->sample_period;
> +		local64_set(&hwc->period_left, hwc->sample_period);
> +	}
> +
> +	err = 0;
> +	if (event->group_leader != event)
> +		err = validate_group(event);
> +
> +	event->destroy = hw_perf_event_destroy;
> +
> +	if (err)
> +		event->destroy(event);
> +
> +	return err;
> +}
> +
> +static void pause_local_counters(void)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int ctr = loongarch_pmu.num_counters;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	do {
> +		ctr--;
> +		cpuc->saved_ctrl[ctr] = loongarch_pmu_read_control(ctr);
> +		loongarch_pmu_write_control(ctr, cpuc->saved_ctrl[ctr] &
> +					 ~M_PERFCTL_COUNT_EVENT_WHENEVER);
> +	} while (ctr > 0);
> +	local_irq_restore(flags);
> +}
> +
> +static void resume_local_counters(void)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int ctr = loongarch_pmu.num_counters;
> +
> +	do {
> +		ctr--;
> +		loongarch_pmu_write_control(ctr, cpuc->saved_ctrl[ctr]);
> +	} while (ctr > 0);
> +}
> +
> +static const struct loongarch_perf_event *loongarch_pmu_map_raw_event(u64 config)
> +{
> +	raw_event.event_id = config & 0xff;
> +
> +	return &raw_event;
> +}
> +
> +static int __init
> +init_hw_perf_events(void)
> +{
> +	int counters = 4;
> +
> +	if (!cpu_has_pmp)
> +		return -ENODEV;
> +
> +	pr_info("Performance counters: ");
> +
> +	loongarch_pmu.num_counters = counters;
> +	loongarch_pmu.max_period = (1ULL << 63) - 1;
> +	loongarch_pmu.valid_count = (1ULL << 63) - 1;
> +	loongarch_pmu.overflow = 1ULL << 63;
> +	loongarch_pmu.name = "loongarch/loongson64";
> +	loongarch_pmu.read_counter = loongarch_pmu_read_counter;
> +	loongarch_pmu.write_counter = loongarch_pmu_write_counter;
> +	loongarch_pmu.map_raw_event = loongarch_pmu_map_raw_event;
> +	loongarch_pmu.general_event_map = &loongson_new_event_map;
> +	loongarch_pmu.cache_event_map = &loongson_new_cache_map;
> +
> +	on_each_cpu(reset_counters, (void *)(long)counters, 1);
> +
> +	pr_cont("%s PMU enabled, %d %d-bit counters available to each "
> +		"CPU.\n", loongarch_pmu.name, counters, 64);
> +
> +	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
> +
> +	return 0;
> +}
> +early_initcall(init_hw_perf_events);
> diff --git a/arch/loongarch/kernel/perf_regs.c b/arch/loongarch/kernel/perf_regs.c
> new file mode 100644
> index 000000000000..a5e9768e8414
> --- /dev/null
> +++ b/arch/loongarch/kernel/perf_regs.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited

And this file.

> + */
> +
> +#include <linux/perf_event.h>
> +
> +#include <asm/ptrace.h>
> +
> +#ifdef CONFIG_32BIT
> +u64 perf_reg_abi(struct task_struct *tsk)
> +{
> +	return PERF_SAMPLE_REGS_ABI_32;
> +}
> +#else /* Must be CONFIG_64BIT */
> +u64 perf_reg_abi(struct task_struct *tsk)
> +{
> +	if (test_tsk_thread_flag(tsk, TIF_32BIT_REGS))
> +		return PERF_SAMPLE_REGS_ABI_32;
> +	else
> +		return PERF_SAMPLE_REGS_ABI_64;
> +}
> +#endif /* CONFIG_32BIT */
> +
> +int perf_reg_validate(u64 mask)
> +{
> +	if (!mask)
> +		return -EINVAL;
> +	if (mask & ~((1ull << PERF_REG_LOONGARCH_MAX) - 1))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +u64 perf_reg_value(struct pt_regs *regs, int idx)
> +{
> +	if (WARN_ON_ONCE((u32)idx >= PERF_REG_LOONGARCH_MAX))
> +		return 0;
> +
> +	if ((u32)idx == PERF_REG_LOONGARCH_PC)
> +		return regs->csr_era;
> +
> +	return regs->regs[idx];
> +}
> +
> +void perf_get_regs_user(struct perf_regs *regs_user,
> +			struct pt_regs *regs)
> +{
> +	regs_user->regs = task_pt_regs(current);
> +	regs_user->abi = perf_reg_abi(current);
> +}

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

