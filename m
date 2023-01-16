Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1E66CC00
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jan 2023 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjAPRVN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Jan 2023 12:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjAPRUv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2023 12:20:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7CE036B1E;
        Mon, 16 Jan 2023 08:59:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3313015A1;
        Mon, 16 Jan 2023 09:00:09 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0403F67D;
        Mon, 16 Jan 2023 08:59:10 -0800 (PST)
Date:   Mon, 16 Jan 2023 16:59:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, shawnguo@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com,
        khilman@kernel.org, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org,
        guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net,
        monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        pv-drivers@vmware.com, boris.ostrovsky@oracle.com,
        chris@zankel.net, jcmvbkbc@gmail.com, rafael@kernel.org,
        lenb@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, atishp@atishpatra.org,
        Arnd Bergmann <arnd@arndb.de>, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        rostedt@goodmis.org, mhiramat@kernel.org, frederic@kernel.org,
        paulmck@kernel.org, pmladek@suse.com, senozhatsky@chromium.org,
        john.ogness@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com,
        Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 00/51] cpuidle,rcu: Clean up the mess
Message-ID: <Y8WCWAuQSHN651dA@FVFF77S0Q05N.cambridge.arm.com>
References: <20230112194314.845371875@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112194314.845371875@infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 12, 2023 at 08:43:14PM +0100, Peter Zijlstra wrote:
> Hi All!

Hi Peter,

> The (hopefully) final respin of cpuidle vs rcu cleanup patches. Barring any
> objections I'll be queueing these patches in tip/sched/core in the next few
> days.

I'm sorry to have to bear some bad news on that front. :(

I just had a go at testing this on a Juno dev board, using your queue.git
sched/idle branch and defconfig + CONFIG_PROVE_LOCKING=y +
CONFIG_DEBUG_LOCKDEP=y + CONFIG_DEBUG_ATOMIC_SLEEP=y.

With that I consistently see RCU at boot time (log below).

| =============================
| WARNING: suspicious RCU usage
| 6.2.0-rc3-00051-gced9b6eecb31 #1 Not tainted
| -----------------------------
| include/trace/events/ipi.h:19 suspicious rcu_dereference_check() usage!
| 
| other info that might help us debug this:
| 
| 
| rcu_scheduler_active = 2, debug_locks = 1
| RCU used illegally from extended quiescent state!
| no locks held by swapper/0/0.
| 
| stack backtrace:
| CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc3-00051-gced9b6eecb31 #1
| Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II May 16 2021
| Call trace:
|  dump_backtrace.part.0+0xe4/0xf0
|  show_stack+0x18/0x30
|  dump_stack_lvl+0x98/0xd4
|  dump_stack+0x18/0x34
|  lockdep_rcu_suspicious+0xf8/0x10c
|  trace_ipi_raise+0x1a8/0x1b0
|  arch_irq_work_raise+0x4c/0x70
|  __irq_work_queue_local+0x48/0x80
|  irq_work_queue+0x50/0x80
|  __wake_up_klogd.part.0+0x98/0xe0
|  defer_console_output+0x20/0x30
|  vprintk+0x98/0xf0
|  _printk+0x5c/0x84
|  lockdep_rcu_suspicious+0x34/0x10c
|  trace_lock_acquire+0x174/0x180
|  lock_acquire+0x3c/0x8c
|  _raw_spin_lock_irqsave+0x70/0x150
|  down_trylock+0x18/0x50
|  __down_trylock_console_sem+0x3c/0xd0
|  console_trylock+0x28/0x90
|  vprintk_emit+0x11c/0x354
|  vprintk_default+0x38/0x4c
|  vprintk+0xd4/0xf0
|  _printk+0x5c/0x84
|  lockdep_rcu_suspicious+0x34/0x10c
|  printk_sprint+0x238/0x240
|  vprintk_store+0x32c/0x4b0
|  vprintk_emit+0x104/0x354
|  vprintk_default+0x38/0x4c
|  vprintk+0xd4/0xf0
|  _printk+0x5c/0x84
|  lockdep_rcu_suspicious+0x34/0x10c
|  trace_irq_disable+0x1ac/0x1b0
|  trace_hardirqs_off+0xe8/0x110
|  cpu_suspend+0x4c/0xfc
|  psci_cpu_suspend_enter+0x58/0x6c
|  psci_enter_idle_state+0x70/0x170
|  cpuidle_enter_state+0xc4/0x464
|  cpuidle_enter+0x38/0x50
|  do_idle+0x230/0x2c0
|  cpu_startup_entry+0x24/0x30
|  rest_init+0x110/0x190
|  arch_post_acpi_subsys_init+0x0/0x18
|  start_kernel+0x6f8/0x738
|  __primary_switched+0xbc/0xc4

IIUC what's happenign here is the PSCI cpuidle driver has entered idle and RCU
is no longer watching when arm64's cpu_suspend() manipulates DAIF. Our
local_daif_*() helpers poke lockdep and tracing, hence the call to
trace_hardirqs_off() and the RCU usage.

I think we need RCU to be watching all the way down to cpu_suspend(), and it's
cpu_suspend() that should actually enter/exit idle context. That and we need to
make cpu_suspend() and the low-level PSCI invocation noinstr.

I'm not sure whether 32-bit will have a similar issue or not.

I'm surprised no-one else who has tested has seen this; I suspect people
haven't enabled lockdep and friends. :/

Thanks,
Mark. 
