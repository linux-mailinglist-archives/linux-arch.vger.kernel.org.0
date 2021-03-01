Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90008327B57
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 10:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhCAJ5b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 04:57:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234321AbhCAJ4G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 04:56:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D2FE64E41;
        Mon,  1 Mar 2021 09:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614592525;
        bh=95DOR9XMb8dkAn/D5sCaGoB5Sj3iHhojCjVJgvbxEi0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rMw7eJfLJKTQ8ccjhM80sQHg/61a5XbnGlaa7RSEnETam2EKEED6adPMmTec4oJT7
         oU9M9HjY0xMiifK379VA+ZwFaDSjtRa4YcHDc3uGMPTFxmuvOf5Tzfzae6CruMEOFJ
         mCME5aIkFoDrmvVhb5BjZeIvngRy6PdSuw/Kchyz9rwpOJaZhae1K6Poj+7PtVrohb
         aPmvVl4nBXK2najDJYO4OSexSEPzymTFq31fl93y6ziXaJh19POztlAE2a6gBUTzDp
         WSNby8uNYcbsQrqmuBujsEXdfM+BnKCTHgqfQS6UEhxsJBlbRB7n+knCmT25RhSgsr
         y60WNt97wCwog==
Received: by mail-lf1-f50.google.com with SMTP id u4so24481904lfs.0;
        Mon, 01 Mar 2021 01:55:25 -0800 (PST)
X-Gm-Message-State: AOAM533ssH57+TMp14tij1Dgg4Y7dYNShxRgoHhk2VjLPGhPKbj4YPsP
        Nsu5lAtp+WQDILbn9WTL9H89WA/e0vNrxXiY3Kc=
X-Google-Smtp-Source: ABdhPJzjKtgHfhVev7fsTg5gB83QaqnPH+Fmn+8wRVlQ2VfuWdWlL503QHhx6p4qHOhRjyny5wrajYv4z36tqcBqqAQ=
X-Received: by 2002:a05:6512:3458:: with SMTP id j24mr9727381lfr.231.1614592523464;
 Mon, 01 Mar 2021 01:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20210228034300.1090149-1-guoren@kernel.org> <CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com>
In-Reply-To: <CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Mar 2021 17:55:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS_NJFdnhM+PZc981rKRkakofPPuz5SmJLNjirH2U40RA@mail.gmail.com>
Message-ID: <CAJF2gTS_NJFdnhM+PZc981rKRkakofPPuz5SmJLNjirH2U40RA@mail.gmail.com>
Subject: Re: [GIT PULL] csky changes for v5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

On Mon, Mar 1, 2021 at 4:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So this is entirely unrelated to the csky pull request, and is more of
> a generic "the perf CPU hotplug thing seems a complete mess".
>
> The csky thing is just the latest - of many - that have been bitten by
> the mess, and the one that added yet another hotplug state, and
> finally made me go "Let's at least talk about this"
>
> For csky, the problem is this:
>
> On Sat, Feb 27, 2021 at 7:43 PM <guoren@kernel.org> wrote:
> >
> > arch/csky patches for 5.12-rc1
> >
> >  - Fixup perf probe failed
>
> and in this case it is 398cb92495cc ("csky: Fixup perf probe failed")
> in my current -git tree.
>
> But it's also
>
>     cf6acb8bdb1d ("s390/cpumf: Add support for complete counter set extraction")
>     dcb5cdf60a1f ("powerpc/perf/hv-gpci: Add cpu hotplug support")
>     1a8f0886a600 ("powerpc/perf/hv-24x7: Add cpu hotplug support")
>     6b7ce8927b5a ("irqchip: RISC-V per-HART local interrupt controller driver")
>     e9b880581d55 ("coresight: cti: Add CPU Hotplug handling to CTI driver")
>     e0685fa228fd ("arm64: Retrieve stolen time as paravirtualized guest")
>     6282edb72bed ("clocksource/drivers/exynos_mct: Increase priority
> over ARM arch timer")
>     78f4e932f776 ("x86/microcode, cpuhotplug: Add a microcode loader
> CPU hotplug callback")
>     72c69dcddce1 ("powerpc/perf: Trace imc events detection and cpuhotplug")
>     5861381d4866 ("PM / arch: x86: Rework the
> MSR_IA32_ENERGY_PERF_BIAS handling")
>     69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
>     ...
>
> and that's not even the complete list.
>
> Does it really make sense to have this kind of silly enumeration of
> many (MANY!) different arch CPU hotplug state indexes, where most of
> them are relevant only to that particular architecture..
>
> No, I don't think this is a _problem_, but it's kind of ugly, wouldn't
> you agree?
>
> Wouldn't it be better to just reserve N different states for the
> architecture hotplug state, and then let each architecture decide how
> they want to order them?
>
> Or better yet, make at least some of them architecture-neutral.
> Because now there are drivers that clearly are very tied to one
> architecture - or SoCs (look at various timer things) - do they really
> want or need their own architecture- or SoC-specific hotplug state?
> IOW, do we really need all of these:
>
>         CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>         CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
>         CPUHP_AP_JCORE_TIMER_STARTING,
>         CPUHP_AP_QCOM_TIMER_STARTING,
>         CPUHP_AP_TEGRA_TIMER_STARTING,
>         CPUHP_AP_ARMADA_TIMER_STARTING,
>         CPUHP_AP_MARCO_TIMER_STARTING,
>         CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>         CPUHP_AP_ARC_TIMER_STARTING,
>         CPUHP_AP_RISCV_TIMER_STARTING,
>         CPUHP_AP_CLINT_TIMER_STARTING,
>         CPUHP_AP_CSKY_TIMER_STARTING,
>         CPUHP_AP_HYPERV_TIMER_STARTING,
>         CPUHP_AP_KVM_ARM_TIMER_STARTING,
>         CPUHP_AP_DUMMY_TIMER_STARTING,
>
> as separate hotplug events?
>
> Whatever. I don't really care deeply, but this just smells a bit to me.
>
> Comments?

We could use CPUHP_AP_ONLINE_DYN to reduce most of the above.

Here is the example of csky:

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index e5f1842..ccc27c3 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1319,10 +1319,10 @@ int csky_pmu_device_probe(struct platform_device *pdev,
                pr_notice("[perf] PMU request irq fail!\n");
        }

-       ret = cpuhp_setup_state(CPUHP_AP_PERF_CSKY_ONLINE, "AP_PERF_ONLINE",
+       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
"arch/csky/perf_event:starting",
                                csky_pmu_starting_cpu,
                                csky_pmu_dying_cpu);
-       if (ret) {
+       if (ret < 0) {
                csky_pmu_free_irq();
                free_percpu(csky_pmu.hw_events);
                return ret;
diff --git a/drivers/clocksource/timer-mp-csky.c
b/drivers/clocksource/timer-mp-csky.c
index 183a995..fc17d77 100644
--- a/drivers/clocksource/timer-mp-csky.c
+++ b/drivers/clocksource/timer-mp-csky.c
@@ -151,11 +151,11 @@ static int __init csky_mptimer_init(struct
device_node *np)
        clocksource_register_hz(&csky_clocksource, timer_of_rate(to));
        sched_clock_register(sched_clock_read, 32, timer_of_rate(to));

-       ret = cpuhp_setup_state(CPUHP_AP_CSKY_TIMER_STARTING,
+       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
                                "clockevents/csky/timer:starting",
                                csky_mptimer_starting_cpu,
                                csky_mptimer_dying_cpu);
-       if (ret)
+       if (ret < 0)
                return -EINVAL;

        return 0;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f14adb8..5abcfda 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -134,7 +134,6 @@ enum cpuhp_state {
        CPUHP_AP_ARC_TIMER_STARTING,
        CPUHP_AP_RISCV_TIMER_STARTING,
        CPUHP_AP_CLINT_TIMER_STARTING,
-       CPUHP_AP_CSKY_TIMER_STARTING,
        CPUHP_AP_HYPERV_TIMER_STARTING,
        CPUHP_AP_KVM_STARTING,
        CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
@@ -186,7 +185,6 @@ enum cpuhp_state {
        CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
        CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
        CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
-       CPUHP_AP_PERF_CSKY_ONLINE,
        CPUHP_AP_WATCHDOG_ONLINE,
        CPUHP_AP_WORKQUEUE_ONLINE,
        CPUHP_AP_RCUTREE_ONLINE,


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
