Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E112E5859AF
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jul 2022 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiG3Jkr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jul 2022 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiG3Jkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jul 2022 05:40:43 -0400
Received: from server.lespinasse.org (server.lespinasse.org [63.205.204.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2888B11446;
        Sat, 30 Jul 2022 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-79-ed;
 t=1659174032; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=weCa4etYCrU0JKpJO/Ui+2clGa/1cbP+1Ce8uxB4Z2U=;
 b=x/Ziq42GBYdLObjVTEjRxMr42JGNj1S6ikUonHkCSS9+QUAEIEusirhrUb1NLAhWCN9I/
 26gXmKmVFCvOvm8Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-79-rsa; t=1659174032; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=weCa4etYCrU0JKpJO/Ui+2clGa/1cbP+1Ce8uxB4Z2U=;
 b=xjlyRJ2PLCvlHddIpET9xkdQ9b2YJIlAuRmqVD4Zi9LYcfMqzgs3mU4rkm/FKHLXNUOaJ
 LyyP89/nFeA6CHdOEfvoMWe+2hvIc5qWIl7OAgthzIj8J1BY1lyEpfvyFmhVmffdeRhfjdo
 vMuxuuddA8OZu54a34mTh9dLsyNfUY1VEPbkQXmB5bXD5tY51a2x0Dy7lPzCrgrdbPY9jea
 g6bR8AptJZSZjsf3hgGuxahRdvKbF0nVgvjROX7b4fAX0R64UDLs/zIoRFldyB9Yfr1EawK
 tm9ki9L5Z6WkfftzLymxjgxhP/KXmf4WU+QM/fsd13mCq3dze1SIRx1wUOGA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 1452116096D; Sat, 30 Jul 2022 02:40:32 -0700 (PDT)
Date:   Sat, 30 Jul 2022 02:40:32 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Peter Zijlstra <peterz@infradead.org>, rth@twiddle.net,
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
Message-ID: <20220730094032.GA1587@lespinasse.org>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org>
 <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
 <20220729102458.GA1695@lespinasse.org>
 <20220729152622.GM2860372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729152622.GM2860372@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 29, 2022 at 08:26:22AM -0700, Paul E. McKenney wrote:> Would you be willing to try another shot in the dark, but untested
> this time?  I freely admit that this is getting strange.
> 
> 							Thanx, Paul

Yes, adding this second change got rid of the boot time warning for me.

> ------------------------------------------------------------------------
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index e374c0c923dae..279f557bf60bb 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -394,7 +394,7 @@ notrace void sched_clock_tick(void)
>  	if (!static_branch_likely(&sched_clock_running))
>  		return;
>  
> -	lockdep_assert_irqs_disabled();
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
>  
>  	scd = this_scd();
>  	__scd_stamp(scd);
