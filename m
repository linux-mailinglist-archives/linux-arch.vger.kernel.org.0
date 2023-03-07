Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D06AE6F7
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCGQnh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Mar 2023 11:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCGQnN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2023 11:43:13 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3897B5E
        for <linux-arch@vger.kernel.org>; Tue,  7 Mar 2023 08:40:41 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:614d:21b0:703:d0f9])
        by albert.telenet-ops.be with bizsmtp
        id VUg82900A3mNwr406Ug80J; Tue, 07 Mar 2023 17:40:24 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZaMC-00BCRZ-9r;
        Tue, 07 Mar 2023 17:40:08 +0100
Date:   Tue, 7 Mar 2023 17:40:08 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Frederic Weisbecker <frederic@kernel.org>,
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
In-Reply-To: <20230112195539.760296658@infradead.org>
Message-ID: <ff338b9f-4ab0-741b-26ea-7b7351da156@linux-m68k.org>
References: <20230112194314.845371875@infradead.org> <20230112195539.760296658@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

 	Hoi Peter,

(reduced the insane CC list)

On Thu, 12 Jan 2023, Peter Zijlstra wrote:
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, at least twice, before going idle is daft.
>
> Notably once implicitly through the cpu_pm_*() calls and once
> explicitly doing ct_irq_*_irqon().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch, which is now commit e038f7b8028a1d1b ("cpuidle,
psci: Push RCU-idle into driver") in v6.3-rc1.

I have bisected a PSCI checker regression on Renesas R-Car Gen3/4 SoCs
to commit a01353cf1896ea5b ("cpuidle: Fix ct_idle_*() usage") (the 7
commits before that do not compile):

psci_checker: PSCI checker started using 2 CPUs
psci_checker: Starting hotplug tests
psci_checker: Trying to turn off and on again all CPUs
psci: CPU0 killed (polled 0 ms)
Detected PIPT I-cache on CPU0
CPU0: Booted secondary processor 0x0000000000 [0x411fd073]
psci_checker: Trying to turn off and on again group 0 (CPUs 0-1)
psci: CPU0 killed (polled 0 ms)
Detected PIPT I-cache on CPU0
CPU0: Booted secondary processor 0x0000000000 [0x411fd073]
psci_checker: Hotplug tests passed OK
psci_checker: Starting suspend tests (10 cycles per state)
psci_checker: CPU 0 entering suspend cycles, states 1 through 1
psci_checker: CPU 1 entering suspend cycles, states 1 through 1
------------[ cut here ]------------
WARNING: CPU: 1 PID: 177 at kernel/context_tracking.c:141 ct_kernel_exit.constprop.0+0xd8/0xf4
Modules linked in:
CPU: 1 PID: 177 Comm: psci_suspend_te Not tainted 6.2.0-rc1-salvator-x-00052-ga01353cf1896 #1415
Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ct_kernel_exit.constprop.0+0xd8/0xf4
lr : ct_kernel_exit.constprop.0+0xc8/0xf4
sp : ffffffc00b73bd30
x29: ffffffc00b73bd30 x28: ffffff807fbadc90 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: ffffff800981e140 x22: 0000000000000001 x21: 0000000000010000
x20: ffffffc0086be1d8 x19: ffffff807fbac070 x18: 0000000000000000
x17: ffffff80083d1000 x16: ffffffc00841fff8 x15: ffffffc00b73b990
x14: ffffffc00895be78 x13: 0000000000000001 x12: 0000000000000000
x11: 00000000000001aa x10: 00000000ffffffea x9 : 000000000000000f
x8 : ffffffc00b73bb68 x7 : ffffffc00b73be18 x6 : ffffffc00815ff34
x5 : ffffffc00a6a0c30 x4 : ffffffc00801ce00 x3 : 0000000000000000
x2 : ffffffc008dc3070 x1 : ffffffc008dc3078 x0 : 0000000004208040
Call trace:
  ct_kernel_exit.constprop.0+0xd8/0xf4
  ct_idle_enter+0x18/0x20
  psci_enter_idle_state+0xa4/0xfc
  suspend_test_thread+0x238/0x2f0
  kthread+0xd8/0xe8
  ret_from_fork+0x10/0x20
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffc0080798b0>] copy_process+0x608/0x13dc
softirqs last  enabled at (0): [<ffffffc0080798b0>] copy_process+0x608/0x13dc
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 177 at kernel/context_tracking.c:186 ct_kernel_enter.constprop.0+0x78/0xa4
Modules linked in:
CPU: 1 PID: 177 Comm: psci_suspend_te Tainted: G        W          6.2.0-rc1-salvator-x-00052-ga01353cf1896 #1415
Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ct_kernel_enter.constprop.0+0x78/0xa4
lr : ct_kernel_enter.constprop.0+0x68/0xa4
sp : ffffffc00b73bd30
x29: ffffffc00b73bd30 x28: ffffff807fbadc90 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: ffffff800981e140 x22: 0000000000000001 x21: 00000000ffffffa1
x20: ffffffc0086be1d8 x19: 00000000000000c0 x18: 0000000000000000
x17: ffffff80083d1000 x16: ffffffc00841fff8 x15: ffffffc00b73b990
x14: ffffffc00895be78 x13: ffffff800e325180 x12: ffffffc076de9000
x11: 0000000034d4d91d x10: 0000000000000008 x9 : 0000000000001000
x8 : ffffffc008012800 x7 : 0000000000000000 x6 : ffffff807fbac070
x5 : ffffffc008dc3070 x4 : 0000000000000000 x3 : 000000000001a9fc
x2 : 0000000000000003 x1 : ffffffc008dc3070 x0 : 0000000004208040
Call trace:
  ct_kernel_enter.constprop.0+0x78/0xa4
  ct_idle_exit+0x18/0x38
  psci_enter_idle_state+0xdc/0xfc
  suspend_test_thread+0x238/0x2f0
  kthread+0xd8/0xe8
  ret_from_fork+0x10/0x20
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffc0080798b0>] copy_process+0x608/0x13dc
softirqs last  enabled at (0): [<ffffffc0080798b0>] copy_process+0x608/0x13dc
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
psci_checker: Failed to suspend CPU 1: error -1 (requested state 1, cycle 0)
psci_checker: CPU 0 suspend test results: success 0, shallow states 10, errors 0
mmcblk0rpmb: mmc0:0001 BGSD3R 4.00 MiB, chardev (243:0)
psci_checker: CPU 1 suspend test results: success 0, shallow states 9, errors 1
psci_checker: 1 error(s) encountered in suspend tests
psci_checker: PSCI checker completed

> ---
> drivers/cpuidle/cpuidle-psci.c |    9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -69,12 +69,12 @@ static int __psci_enter_domain_idle_stat
> 		return -1;
>
> 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
> -	ct_irq_enter_irqson();
> 	if (s2idle)
> 		dev_pm_genpd_suspend(pd_dev);
> 	else
> 		pm_runtime_put_sync_suspend(pd_dev);
> -	ct_irq_exit_irqson();
> +
> +	ct_idle_enter();
>
> 	state = psci_get_domain_state();
> 	if (!state)
> @@ -82,12 +82,12 @@ static int __psci_enter_domain_idle_stat
>
> 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
>
> -	ct_irq_enter_irqson();
> +	ct_idle_exit();
> +
> 	if (s2idle)
> 		dev_pm_genpd_resume(pd_dev);
> 	else
> 		pm_runtime_get_sync(pd_dev);
> -	ct_irq_exit_irqson();
>
> 	cpu_pm_exit();
>
> @@ -240,6 +240,7 @@ static int psci_dt_cpu_init_topology(str
> 	 * of a shared state for the domain, assumes the domain states are all
> 	 * deeper states.
> 	 */
> +	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
> 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
> 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
> 	psci_cpuidle_use_cpuhp = true;

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
