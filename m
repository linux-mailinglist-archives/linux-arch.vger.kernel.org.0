Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D1A5BD073
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiISPSv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 11:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiISPSX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 11:18:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A24371BD;
        Mon, 19 Sep 2022 08:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C525B81D70;
        Mon, 19 Sep 2022 15:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47AEC433D6;
        Mon, 19 Sep 2022 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663600657;
        bh=SGRWSsWxhYnFNcVdXVanCp7r8VhObbFain7vrJ2pf9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxVxz+v2ZKRYGR2RcB+jwqcdhOAyWFuA63mrtcEpyRTpMkbyS6WHs4N4WpL6wD55y
         MEw4vseCOHKlzHluXBoBp/tNbhBozucjByJQwggqB8cSL766iSR/fB5p7HP2XX3V5a
         W432aviHiF1CtVbY9+02lVZyqI6r7f0Y+oEmkgLbQeCLJ6mZ8QHUtL9Cb1Rt7pnsGN
         oU9BgJeognmYR5a7tpyKmtArG/qTrOVW6g6oNhiIq3bF6GOaiMj1jdkgNeNp7u/R+2
         PWnZiOvApDwvdE77MAQCyvfpVSOU+ZSH1CmsYL840fIy4Yva2osOuqdAr10RKbdLw3
         uLMmSqj+LM5sA==
Date:   Mon, 19 Sep 2022 17:17:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
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
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        anup@brainfault.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, jacob.jun.pan@linux.intel.com,
        atishp@atishpatra.org, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, fweisbec@gmail.com,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 08/44] cpuidle,imx6: Push RCU-idle into driver
Message-ID: <20220919151734.GB62211@lothringen>
References: <20220919095939.761690562@infradead.org>
 <20220919101520.869531945@infradead.org>
 <20220919144941.GA62211@lothringen>
 <YyiEqDSJVOZrQYg8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyiEqDSJVOZrQYg8@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 19, 2022 at 05:03:04PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 19, 2022 at 04:49:41PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 19, 2022 at 11:59:47AM +0200, Peter Zijlstra wrote:
> > > Doing RCU-idle outside the driver, only to then temporarily enable it
> > > again, at least twice, before going idle is daft.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/arm/mach-imx/cpuidle-imx6sx.c |    5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > > @@ -47,7 +47,9 @@ static int imx6sx_enter_wait(struct cpui
> > >  		cpu_pm_enter();
> > >  		cpu_cluster_pm_enter();
> > >  
> > > +		ct_idle_enter();
> > >  		cpu_suspend(0, imx6sx_idle_finish);
> > > +		ct_idle_exit();
> > >  
> > >  		cpu_cluster_pm_exit();
> > >  		cpu_pm_exit();
> > > @@ -87,7 +89,8 @@ static struct cpuidle_driver imx6sx_cpui
> > >  			 */
> > >  			.exit_latency = 300,
> > >  			.target_residency = 500,
> > > -			.flags = CPUIDLE_FLAG_TIMER_STOP,
> > > +			.flags = CPUIDLE_FLAG_TIMER_STOP |
> > > +				 CPUIDLE_FLAG_RCU_IDLE,
> > >  			.enter = imx6sx_enter_wait,
> > 
> > There is a second one below that also uses imx6sx_enter_wait.
> 
> Oh, above you mean; but only @index==2 gets us into the whole PM crud.
> @index==1 is fine afaict.

Ah ok, got it, hence why you didn't touch cpu_do_idle()...
May need to comment that somewhere...

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
