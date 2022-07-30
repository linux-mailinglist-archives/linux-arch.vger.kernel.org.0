Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14451585B86
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jul 2022 20:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiG3SQo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jul 2022 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiG3SQo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jul 2022 14:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2365D1583F;
        Sat, 30 Jul 2022 11:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4F860EEA;
        Sat, 30 Jul 2022 18:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95708C433C1;
        Sat, 30 Jul 2022 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659204999;
        bh=YJXP6A7d+KZPrg8HQv8x+gqLEMy1sjVdzXnl/qX62uw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gJSpKVSsAKz8pom4RuAB5Je2VfXHGMhI5S8QuPgLw6sbq0QnDrcsB984Q3KCjMEP4
         SYUjeqdnSm23czJoxrwT8/cSChg2wZ3j8oXxKHXQSMFJwdsOWYkZ8L3yHTrxHHHv/B
         PCAYHs9Jnrby4wbTToGryEY6Ex3TIpS7AHVXuUJU6nS/OoMCgZLC69/yQVKdeU26z2
         g1F1UjpLlSrDEHmQXbwyZ9oeANnc2U7/KwPArewe4hoBbjnHbzgEqXp6HAhF3f96Ro
         rfGOh77ykaTrG15ZCImyvdTTA95ZiEUj+F32tOHQ6Prrb5v2smeceYH3zHnZYF0uH1
         p/j3tMujFTrgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3BA285C0266; Sat, 30 Jul 2022 11:16:39 -0700 (PDT)
Date:   Sat, 30 Jul 2022 11:16:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        linux@armlinux.org.uk, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, shawnguo@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com,
        khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net,
        monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, James.Bottomley@HansenPartnership.com,
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
        frederic@kernel.org, quic_neeraju@quicinc.com,
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
        rcu@vger.kernel.org, rh0@fb.com
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Message-ID: <20220730181639.GS2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org>
 <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
 <20220729102458.GA1695@lespinasse.org>
 <20220729152622.GM2860372@paulmck-ThinkPad-P17-Gen-1>
 <20220730094032.GA1587@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730094032.GA1587@lespinasse.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 30, 2022 at 02:40:32AM -0700, Michel Lespinasse wrote:
> On Fri, Jul 29, 2022 at 08:26:22AM -0700, Paul E. McKenney wrote:> Would you be willing to try another shot in the dark, but untested
> > this time?  I freely admit that this is getting strange.
> > 
> > 							Thanx, Paul
> 
> Yes, adding this second change got rid of the boot time warning for me.

OK, I will make a real patch.  May I have your Tested-by?

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index e374c0c923dae..279f557bf60bb 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -394,7 +394,7 @@ notrace void sched_clock_tick(void)
> >  	if (!static_branch_likely(&sched_clock_running))
> >  		return;
> >  
> > -	lockdep_assert_irqs_disabled();
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
> >  
> >  	scd = this_scd();
> >  	__scd_stamp(scd);
