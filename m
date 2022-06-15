Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6254C144
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 07:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiFOFfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 01:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbiFOFfm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 01:35:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 283F649FA0;
        Tue, 14 Jun 2022 22:35:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6EE2B80AE;
        Wed, 15 Jun 2022 05:30:54 +0000 (UTC)
Date:   Wed, 15 Jun 2022 08:35:38 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net,
        monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
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
        rcu@vger.kernel.org, Peter Vasil <petervasil@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 34.5/36] cpuidle,omap4: Push RCU-idle into
 omap4_enter_lowpower()
Message-ID: <YqlvqhdlFsNvUBeG@atomide.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.073801916@infradead.org>
 <Yqcv6crSNKuSWoTu@atomide.com>
 <YqkHto+zgAPs4kQI@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqkHto+zgAPs4kQI@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Adding Aaro Koskinen and Peter Vasil for pm24xx for n800 and n810 related
idle.

* Peter Zijlstra <peterz@infradead.org> [220614 22:07]:
> On Mon, Jun 13, 2022 at 03:39:05PM +0300, Tony Lindgren wrote:
> > OMAP4 uses full SoC suspend modes as idle states, as such it needs the
> > whole power-domain and clock-domain code from the idle path.
> > 
> > All that code is not suitable to run with RCU disabled, as such push
> > RCU-idle deeper still.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > 
> > Peter here's one more for your series, looks like this is needed to avoid
> > warnings similar to what you did for omap3.
> 
> Thanks Tony!
> 
> I've had a brief look at omap2_pm_idle() and do I understand it right
> that something like the below patch would reduce it to a simple 'WFI'?

Yes that should do for omap2_do_wfi().

> What do I do with the rest of that code, because I don't think this
> thing has a cpuidle driver to take over, effectively turning it into
> dead code.

As we are establishing a policy where deeper idle states must be
handled by cpuidle, and for most part that has been the case for at least
10 years, I'd just drop the unused functions with an explanation in the
patch why we're doing it. Or the functions could be tagged with
__maybe_unused if folks prefer that.

In the pm24xx case we are not really causing a regression for users as
there are still pending patches to make n800 and n810 truly usable with
the mainline kernel. At least the PMIC and LCD related patches need some
work [0]. The deeper idle states can be added back later using cpuidle
as needed so we have a clear path.

Aaro & Peter V, do you have any better suggestions here as this will
mostly affect you guys currently?

Regards,

Tony

[0] https://lore.kernel.org/linux-omap/20211224214512.1583430-1-peter.vasil@gmail.com/


> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -126,10 +126,20 @@ static int omap2_allow_mpu_retention(voi
>  	return 1;
>  }
>  
> -static void omap2_enter_mpu_retention(void)
> +static void omap2_do_wfi(void)
>  {
>  	const int zero = 0;
>  
> +	/* WFI */
> +	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
> +}
> +
> +#if 0
> +/*
> + * possible cpuidle implementation between WFI and full_retention above
> + */
> +static void omap2_enter_mpu_retention(void)
> +{
>  	/* The peripherals seem not to be able to wake up the MPU when
>  	 * it is in retention mode. */
>  	if (omap2_allow_mpu_retention()) {
> @@ -146,8 +157,7 @@ static void omap2_enter_mpu_retention(vo
>  		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
>  	}
>  
> -	/* WFI */
> -	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
> +	omap2_do_wfi();
>  
>  	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
>  }
> @@ -161,6 +171,7 @@ static int omap2_can_sleep(void)
>  
>  	return 1;
>  }
> +#endif
>  
>  static void omap2_pm_idle(void)
>  {
> @@ -169,6 +180,7 @@ static void omap2_pm_idle(void)
>  	if (omap_irq_pending())
>  		return;
>  
> +#if 0
>  	error = cpu_cluster_pm_enter();
>  	if (error || !omap2_can_sleep()) {
>  		omap2_enter_mpu_retention();
> @@ -179,6 +191,9 @@ static void omap2_pm_idle(void)
>  
>  out_cpu_cluster_pm:
>  	cpu_cluster_pm_exit();
> +#else
> +	omap2_do_wfi();
> +#endif
>  }
>  
>  static void __init prcm_setup_regs(void)
