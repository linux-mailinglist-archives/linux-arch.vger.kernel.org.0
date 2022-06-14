Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BCB54B602
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiFNQ3Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343903AbiFNQ2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 12:28:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46ABB193EB;
        Tue, 14 Jun 2022 09:28:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D999D16F8;
        Tue, 14 Jun 2022 09:28:23 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.41.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEF753F66F;
        Tue, 14 Jun 2022 09:28:05 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:28:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        pv-drivers@vmware.com, boris.ostrovsky@oracle.com,
        chris@zankel.net, jcmvbkbc@gmail.com, rafael@kernel.org,
        lenb@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        daniel.lezcano@linaro.org, lpieralisi@kernel.org,
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
Subject: Re: [PATCH 25/36] time/tick-broadcast: Remove RCU_NONIDLE usage
Message-ID: <Yqi3EmHbuvf3ItMI@FVFF77S0Q05N>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.507286638@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608144517.507286638@infradead.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 08, 2022 at 04:27:48PM +0200, Peter Zijlstra wrote:
> No callers left that have already disabled RCU.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/time/tick-broadcast-hrtimer.c |   29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> --- a/kernel/time/tick-broadcast-hrtimer.c
> +++ b/kernel/time/tick-broadcast-hrtimer.c
> @@ -56,25 +56,20 @@ static int bc_set_next(ktime_t expires,
>  	 * hrtimer callback function is currently running, then
>  	 * hrtimer_start() cannot move it and the timer stays on the CPU on
>  	 * which it is assigned at the moment.
> +	 */
> +	hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
> +	/*
> +	 * The core tick broadcast mode expects bc->bound_on to be set
> +	 * correctly to prevent a CPU which has the broadcast hrtimer
> +	 * armed from going deep idle.
>  	 *
> -	 * As this can be called from idle code, the hrtimer_start()
> -	 * invocation has to be wrapped with RCU_NONIDLE() as
> -	 * hrtimer_start() can call into tracing.
> +	 * As tick_broadcast_lock is held, nothing can change the cpu
> +	 * base which was just established in hrtimer_start() above. So
> +	 * the below access is safe even without holding the hrtimer
> +	 * base lock.
>  	 */
> -	RCU_NONIDLE( {
> -		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
> -		/*
> -		 * The core tick broadcast mode expects bc->bound_on to be set
> -		 * correctly to prevent a CPU which has the broadcast hrtimer
> -		 * armed from going deep idle.
> -		 *
> -		 * As tick_broadcast_lock is held, nothing can change the cpu
> -		 * base which was just established in hrtimer_start() above. So
> -		 * the below access is safe even without holding the hrtimer
> -		 * base lock.
> -		 */
> -		bc->bound_on = bctimer.base->cpu_base->cpu;
> -	} );
> +	bc->bound_on = bctimer.base->cpu_base->cpu;
> +
>  	return 0;
>  }
>  
> 
> 
