Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFDD6C15E4
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjCTO6u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjCTO6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 10:58:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3561125A7;
        Mon, 20 Mar 2023 07:56:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FD62AD7;
        Mon, 20 Mar 2023 07:57:13 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAA413F71E;
        Mon, 20 Mar 2023 07:56:26 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:56:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux@armlinux.org.uk,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 07/51] cpuidle,psci: Push RCU-idle into driver
Message-ID: <ZBh0FPlF1oeqHftc@FVFF77S0Q05N.cambridge.arm.com>
References: <20230112194314.845371875@infradead.org>
 <20230112195539.760296658@infradead.org>
 <ff338b9f-4ab0-741b-26ea-7b7351da156@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff338b9f-4ab0-741b-26ea-7b7351da156@linux-m68k.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On Tue, Mar 07, 2023 at 05:40:08PM +0100, Geert Uytterhoeven wrote:
> 	Hoi Peter,
> 
> (reduced the insane CC list)

Helpfully you dropped me from Cc, so I missed this until just now...

> On Thu, 12 Jan 2023, Peter Zijlstra wrote:
> > Doing RCU-idle outside the driver, only to then temporarily enable it
> > again, at least twice, before going idle is daft.
> > 
> > Notably once implicitly through the cpu_pm_*() calls and once
> > explicitly doing ct_irq_*_irqon().
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Thanks for your patch, which is now commit e038f7b8028a1d1b ("cpuidle,
> psci: Push RCU-idle into driver") in v6.3-rc1.
> 
> I have bisected a PSCI checker regression on Renesas R-Car Gen3/4 SoCs
> to commit a01353cf1896ea5b ("cpuidle: Fix ct_idle_*() usage") (the 7
> commits before that do not compile):
>
> psci_checker: PSCI checker started using 2 CPUs
> psci_checker: Starting hotplug tests
> psci_checker: Trying to turn off and on again all CPUs
> psci: CPU0 killed (polled 0 ms)
> Detected PIPT I-cache on CPU0
> CPU0: Booted secondary processor 0x0000000000 [0x411fd073]
> psci_checker: Trying to turn off and on again group 0 (CPUs 0-1)
> psci: CPU0 killed (polled 0 ms)
> Detected PIPT I-cache on CPU0
> CPU0: Booted secondary processor 0x0000000000 [0x411fd073]
> psci_checker: Hotplug tests passed OK
> psci_checker: Starting suspend tests (10 cycles per state)
> psci_checker: CPU 0 entering suspend cycles, states 1 through 1
> psci_checker: CPU 1 entering suspend cycles, states 1 through 1
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 177 at kernel/context_tracking.c:141 ct_kernel_exit.constprop.0+0xd8/0xf4

So that's:

  WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));

... and the PSCI checker doens't run in the context of the idle thread, so the
warning is correct, and we're violating the expectation of the context tracking
code.

The PSCI checker is very much a special case, and I'm not sure how we can fix
this without removing the warning in the cases we want it. It'd be nicer if we
could "queue" the idle into the relevant idle thread. :/

I'm very tempted to say we should just rip the checker code out, rather than
contorting the rest of the code to make that work.

Thanks,
Mark.

> Modules linked in:
> CPU: 1 PID: 177 Comm: psci_suspend_te Not tainted 6.2.0-rc1-salvator-x-00052-ga01353cf1896 #1415
> Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : ct_kernel_exit.constprop.0+0xd8/0xf4
> lr : ct_kernel_exit.constprop.0+0xc8/0xf4
> sp : ffffffc00b73bd30
> x29: ffffffc00b73bd30 x28: ffffff807fbadc90 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> x23: ffffff800981e140 x22: 0000000000000001 x21: 0000000000010000
> x20: ffffffc0086be1d8 x19: ffffff807fbac070 x18: 0000000000000000
> x17: ffffff80083d1000 x16: ffffffc00841fff8 x15: ffffffc00b73b990
> x14: ffffffc00895be78 x13: 0000000000000001 x12: 0000000000000000
> x11: 00000000000001aa x10: 00000000ffffffea x9 : 000000000000000f
> x8 : ffffffc00b73bb68 x7 : ffffffc00b73be18 x6 : ffffffc00815ff34
> x5 : ffffffc00a6a0c30 x4 : ffffffc00801ce00 x3 : 0000000000000000
> x2 : ffffffc008dc3070 x1 : ffffffc008dc3078 x0 : 0000000004208040
> Call trace:
>  ct_kernel_exit.constprop.0+0xd8/0xf4
>  ct_idle_enter+0x18/0x20
>  psci_enter_idle_state+0xa4/0xfc
>  suspend_test_thread+0x238/0x2f0
>  kthread+0xd8/0xe8
>  ret_from_fork+0x10/0x20
> irq event stamp: 0
> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> hardirqs last disabled at (0): [<ffffffc0080798b0>] copy_process+0x608/0x13dc
> softirqs last  enabled at (0): [<ffffffc0080798b0>] copy_process+0x608/0x13dc
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 177 at kernel/context_tracking.c:186 ct_kernel_enter.constprop.0+0x78/0xa4
> Modules linked in:
> CPU: 1 PID: 177 Comm: psci_suspend_te Tainted: G        W          6.2.0-rc1-salvator-x-00052-ga01353cf1896 #1415
> Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : ct_kernel_enter.constprop.0+0x78/0xa4
> lr : ct_kernel_enter.constprop.0+0x68/0xa4
> sp : ffffffc00b73bd30
> x29: ffffffc00b73bd30 x28: ffffff807fbadc90 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> x23: ffffff800981e140 x22: 0000000000000001 x21: 00000000ffffffa1
> x20: ffffffc0086be1d8 x19: 00000000000000c0 x18: 0000000000000000
> x17: ffffff80083d1000 x16: ffffffc00841fff8 x15: ffffffc00b73b990
> x14: ffffffc00895be78 x13: ffffff800e325180 x12: ffffffc076de9000
> x11: 0000000034d4d91d x10: 0000000000000008 x9 : 0000000000001000
> x8 : ffffffc008012800 x7 : 0000000000000000 x6 : ffffff807fbac070
> x5 : ffffffc008dc3070 x4 : 0000000000000000 x3 : 000000000001a9fc
> x2 : 0000000000000003 x1 : ffffffc008dc3070 x0 : 0000000004208040
> Call trace:
>  ct_kernel_enter.constprop.0+0x78/0xa4
>  ct_idle_exit+0x18/0x38
>  psci_enter_idle_state+0xdc/0xfc
>  suspend_test_thread+0x238/0x2f0
>  kthread+0xd8/0xe8
>  ret_from_fork+0x10/0x20
> irq event stamp: 0
> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> hardirqs last disabled at (0): [<ffffffc0080798b0>] copy_process+0x608/0x13dc
> softirqs last  enabled at (0): [<ffffffc0080798b0>] copy_process+0x608/0x13dc
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> ---[ end trace 0000000000000000 ]---
> psci_checker: Failed to suspend CPU 1: error -1 (requested state 1, cycle 0)
> psci_checker: CPU 0 suspend test results: success 0, shallow states 10, errors 0
> mmcblk0rpmb: mmc0:0001 BGSD3R 4.00 MiB, chardev (243:0)
> psci_checker: CPU 1 suspend test results: success 0, shallow states 9, errors 1
> psci_checker: 1 error(s) encountered in suspend tests
> psci_checker: PSCI checker completed
> 
> > ---
> > drivers/cpuidle/cpuidle-psci.c |    9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -69,12 +69,12 @@ static int __psci_enter_domain_idle_stat
> > 		return -1;
> > 
> > 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
> > -	ct_irq_enter_irqson();
> > 	if (s2idle)
> > 		dev_pm_genpd_suspend(pd_dev);
> > 	else
> > 		pm_runtime_put_sync_suspend(pd_dev);
> > -	ct_irq_exit_irqson();
> > +
> > +	ct_idle_enter();
> > 
> > 	state = psci_get_domain_state();
> > 	if (!state)
> > @@ -82,12 +82,12 @@ static int __psci_enter_domain_idle_stat
> > 
> > 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> > 
> > -	ct_irq_enter_irqson();
> > +	ct_idle_exit();
> > +
> > 	if (s2idle)
> > 		dev_pm_genpd_resume(pd_dev);
> > 	else
> > 		pm_runtime_get_sync(pd_dev);
> > -	ct_irq_exit_irqson();
> > 
> > 	cpu_pm_exit();
> > 
> > @@ -240,6 +240,7 @@ static int psci_dt_cpu_init_topology(str
> > 	 * of a shared state for the domain, assumes the domain states are all
> > 	 * deeper states.
> > 	 */
> > +	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
> > 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
> > 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
> > 	psci_cpuidle_use_cpuhp = true;
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
