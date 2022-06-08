Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DBC543464
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiFHOrI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 10:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242211AbiFHOrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 10:47:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76425224E;
        Wed,  8 Jun 2022 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=p3ITF8gI2GW93+lJzbbS6NFG2q6U7tMgsXybvfaCekw=; b=LkAMiHzSQ/opHdOEFeCurG9NLG
        JO+M8wPRoXp+rjlvRp1g6p4deHSrGJRvv4d7IdwxYVZCA6fgQpHjtmLJrV4PCdmnHmGUQvAnyE2UA
        fwHv2wTNOAIYIT2wUB43GTR5ZNwxfCy55ZYqs3Y348h+pLzkkwczLn6aebzuIqWu8dokLe6hAbrDd
        HGdq3+b1S6vX0Rc7tglUdTJgdx3k3cOs/ctzEtERltWW/a158CACl3uvpcO8KTF7iW2z1cVJAFUAo
        mkT6mFk7UPVkskxcPvv+XGScuTuObwFsVrFSWvKd6APK2jNtbqiwDpZU4VuGFDFHTmU5HS3u40Eee
        GVLfhZEg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nywwx-0066BC-3C; Wed, 08 Jun 2022 14:46:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A6423005B7;
        Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3237720C0F991; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608142723.103523089@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Jun 2022 16:27:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH 00/36] cpuidle,rcu: Cleanup the mess
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All! (omg so many)

These here few patches mostly clear out the utter mess that is cpuidle vs rcuidle.

At the end of the ride there's only 2 real RCU_NONIDLE() users left

  arch/arm64/kernel/suspend.c:            RCU_NONIDLE(__cpu_suspend_exit());
  drivers/perf/arm_pmu.c:                 RCU_NONIDLE(armpmu_start(event, PERF_EF_RELOAD));
  kernel/cfi.c:   RCU_NONIDLE({

(the CFI one is likely dead in the kCFI rewrite) and there's only a hand full
of trace_.*_rcuidle() left:

  kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
  kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
  kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
  kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
  kernel/trace/trace_preemptirq.c:                trace_preempt_enable_rcuidle(a0, a1);
  kernel/trace/trace_preemptirq.c:                trace_preempt_disable_rcuidle(a0, a1);

All of them are in 'deprecated' code that is unused for GENERIC_ENTRY.

I've touched a _lot_ of code that I can't test and likely broken some of it :/
In particular, the whole ARM cpuidle stuff was quite involved with OMAP being
the absolute 'winner'.

I'm hoping Mark can help me sort the remaining ARM64 bits as he moves that to
GENERIC_ENTRY. I've also got a note that says ARM64 can probably do a WFE based
idle state and employ TIF_POLLING_NRFLAG to avoid some IPIs.

---
 arch/alpha/kernel/process.c          |    1 
 arch/alpha/kernel/vmlinux.lds.S      |    1 
 arch/arc/kernel/process.c            |    3 +
 arch/arc/kernel/vmlinux.lds.S        |    1 
 arch/arm/include/asm/vmlinux.lds.h   |    1 
 arch/arm/kernel/process.c            |    1 
 arch/arm/kernel/smp.c                |    6 +--
 arch/arm/mach-gemini/board-dt.c      |    3 +
 arch/arm/mach-imx/cpuidle-imx6q.c    |    4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c   |    5 ++
 arch/arm/mach-omap2/cpuidle34xx.c    |   16 ++++++++
 arch/arm/mach-omap2/cpuidle44xx.c    |   29 +++++++++------
 arch/arm/mach-omap2/pm.h             |    2 -
 arch/arm/mach-omap2/pm34xx.c         |   14 +++++--
 arch/arm/mach-omap2/powerdomain.c    |   10 ++---
 arch/arm64/kernel/idle.c             |    1 
 arch/arm64/kernel/smp.c              |    4 +-
 arch/arm64/kernel/vmlinux.lds.S      |    1 
 arch/csky/kernel/process.c           |    1 
 arch/csky/kernel/smp.c               |    2 -
 arch/csky/kernel/vmlinux.lds.S       |    1 
 arch/hexagon/kernel/process.c        |    1 
 arch/hexagon/kernel/vmlinux.lds.S    |    1 
 arch/ia64/kernel/process.c           |    1 
 arch/ia64/kernel/vmlinux.lds.S       |    1 
 arch/loongarch/kernel/vmlinux.lds.S  |    1 
 arch/m68k/kernel/vmlinux-nommu.lds   |    1 
 arch/m68k/kernel/vmlinux-std.lds     |    1 
 arch/m68k/kernel/vmlinux-sun3.lds    |    1 
 arch/microblaze/kernel/process.c     |    1 
 arch/microblaze/kernel/vmlinux.lds.S |    1 
 arch/mips/kernel/idle.c              |    8 +---
 arch/mips/kernel/vmlinux.lds.S       |    1 
 arch/nios2/kernel/process.c          |    1 
 arch/nios2/kernel/vmlinux.lds.S      |    1 
 arch/openrisc/kernel/process.c       |    1 
 arch/openrisc/kernel/vmlinux.lds.S   |    1 
 arch/parisc/kernel/process.c         |    2 -
 arch/parisc/kernel/vmlinux.lds.S     |    1 
 arch/powerpc/kernel/idle.c           |    5 +-
 arch/powerpc/kernel/vmlinux.lds.S    |    1 
 arch/riscv/kernel/process.c          |    1 
 arch/riscv/kernel/vmlinux-xip.lds.S  |    1 
 arch/riscv/kernel/vmlinux.lds.S      |    1 
 arch/s390/kernel/idle.c              |    1 
 arch/s390/kernel/vmlinux.lds.S       |    1 
 arch/sh/kernel/idle.c                |    1 
 arch/sh/kernel/vmlinux.lds.S         |    1 
 arch/sparc/kernel/leon_pmc.c         |    4 ++
 arch/sparc/kernel/process_32.c       |    1 
 arch/sparc/kernel/process_64.c       |    3 +
 arch/sparc/kernel/vmlinux.lds.S      |    1 
 arch/um/kernel/dyn.lds.S             |    1 
 arch/um/kernel/process.c             |    1 
 arch/um/kernel/uml.lds.S             |    1 
 arch/x86/coco/tdx/tdcall.S           |   15 +-------
 arch/x86/coco/tdx/tdx.c              |   25 +++----------
 arch/x86/events/amd/brs.c            |   13 ++-----
 arch/x86/include/asm/irqflags.h      |   11 ++---
 arch/x86/include/asm/mwait.h         |   14 +++----
 arch/x86/include/asm/nospec-branch.h |    2 -
 arch/x86/include/asm/paravirt.h      |    6 ++-
 arch/x86/include/asm/perf_event.h    |    2 -
 arch/x86/include/asm/shared/io.h     |    4 +-
 arch/x86/include/asm/shared/tdx.h    |    1 
 arch/x86/include/asm/special_insns.h |    6 +--
 arch/x86/include/asm/xen/hypercall.h |    2 -
 arch/x86/kernel/paravirt.c           |   14 ++++++-
 arch/x86/kernel/process.c            |   65 +++++++++++++++++------------------
 arch/x86/kernel/vmlinux.lds.S        |    1 
 arch/x86/xen/enlighten_pv.c          |    2 -
 arch/x86/xen/irq.c                   |    2 -
 arch/xtensa/kernel/process.c         |    1 
 arch/xtensa/kernel/vmlinux.lds.S     |    1 
 drivers/acpi/processor_idle.c        |   46 ++++++++++++++----------
 drivers/base/power/runtime.c         |   24 ++++++------
 drivers/clk/clk.c                    |    8 ++--
 drivers/cpuidle/cpuidle-arm.c        |    1 
 drivers/cpuidle/cpuidle-big_little.c |    8 +++-
 drivers/cpuidle/cpuidle-mvebu-v7.c   |    7 +++
 drivers/cpuidle/cpuidle-psci.c       |   10 +++--
 drivers/cpuidle/cpuidle-qcom-spm.c   |    1 
 drivers/cpuidle/cpuidle-riscv-sbi.c  |   10 +++--
 drivers/cpuidle/cpuidle-tegra.c      |   21 ++++++++---
 drivers/cpuidle/cpuidle.c            |   21 +++++------
 drivers/cpuidle/dt_idle_states.c     |    2 -
 drivers/cpuidle/poll_state.c         |   10 ++++-
 drivers/idle/intel_idle.c            |   29 ++++++++++++---
 include/asm-generic/vmlinux.lds.h    |    9 +---
 include/linux/compiler_types.h       |    8 +++-
 include/linux/cpu.h                  |    3 -
 include/linux/cpuidle.h              |   33 +++++++++++++++++
 include/linux/cpumask.h              |    4 +-
 include/linux/sched/idle.h           |   40 ++++++++++++++++-----
 include/linux/thread_info.h          |   18 +++++++++
 include/linux/tracepoint.h           |   13 ++++++-
 kernel/cpu_pm.c                      |    9 ----
 kernel/printk/printk.c               |    2 -
 kernel/rcu/tree.c                    |    9 +---
 kernel/sched/idle.c                  |   47 +++++++------------------
 kernel/time/tick-broadcast-hrtimer.c |   29 ++++++---------
 kernel/time/tick-broadcast.c         |    6 ++-
 kernel/trace/trace.c                 |    3 +
 tools/objtool/check.c                |   15 +++++++-
 104 files changed, 449 insertions(+), 342 deletions(-)

