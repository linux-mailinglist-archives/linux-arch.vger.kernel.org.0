Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDC66E243
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jan 2023 16:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjAQPfj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Jan 2023 10:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjAQPfh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jan 2023 10:35:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78EE341B52;
        Tue, 17 Jan 2023 07:35:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9822A165C;
        Tue, 17 Jan 2023 07:36:16 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACA663F67D;
        Tue, 17 Jan 2023 07:35:17 -0800 (PST)
Date:   Tue, 17 Jan 2023 15:35:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
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
        shorne@gmail.com, James.Bottomley@hansenpartnership.com,
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
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anup@brainfault.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, jacob.jun.pan@linux.intel.com,
        atishp@atishpatra.org, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, rostedt@goodmis.org, mhiramat@kernel.org,
        frederic@kernel.org, paulmck@kernel.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
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
Message-ID: <Y8bALvyrPpdg++/J@FVFF77S0Q05N.cambridge.arm.com>
References: <20230112194314.845371875@infradead.org>
 <Y8WCWAuQSHN651dA@FVFF77S0Q05N.cambridge.arm.com>
 <Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net>
 <Y8afpbHtDOqAHq9M@FVFF77S0Q05N.cambridge.arm.com>
 <20230117142140.g423hxisv7djudof@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117142140.g423hxisv7djudof@bogus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 17, 2023 at 02:21:40PM +0000, Sudeep Holla wrote:
> On Tue, Jan 17, 2023 at 01:16:21PM +0000, Mark Rutland wrote:
> > On Tue, Jan 17, 2023 at 11:26:29AM +0100, Peter Zijlstra wrote:
> > > On Mon, Jan 16, 2023 at 04:59:04PM +0000, Mark Rutland wrote:
> > > 
> > > > I'm sorry to have to bear some bad news on that front. :(
> > > 
> > > Moo, something had to give..
> > > 
> > > 
> > > > IIUC what's happenign here is the PSCI cpuidle driver has entered idle and RCU
> > > > is no longer watching when arm64's cpu_suspend() manipulates DAIF. Our
> > > > local_daif_*() helpers poke lockdep and tracing, hence the call to
> > > > trace_hardirqs_off() and the RCU usage.
> > > 
> > > Right, strictly speaking not needed at this point, IRQs should have been
> > > traced off a long time ago.
> > 
> > True, but there are some other calls around here that *might* end up invoking
> > RCU stuff (e.g. the MTE code).
> > 
> > That all needs a noinstr cleanup too, which I'll sort out as a follow-up.
> > 
> > > > I think we need RCU to be watching all the way down to cpu_suspend(), and it's
> > > > cpu_suspend() that should actually enter/exit idle context. That and we need to
> > > > make cpu_suspend() and the low-level PSCI invocation noinstr.
> > > > 
> > > > I'm not sure whether 32-bit will have a similar issue or not.
> > > 
> > > I'm not seeing 32bit or Risc-V have similar issues here, but who knows,
> > > maybe I missed somsething.
> > 
> > I reckon if they do, the core changes here give us the infrastructure to fix
> > them if/when we get reports.
> > 
> > > In any case, the below ought to cure the ARM64 case and remove that last
> > > known RCU_NONIDLE() user as a bonus.
> > 
> > The below works for me testing on a Juno R1 board with PSCI, using defconfig +
> > CONFIG_PROVE_LOCKING=y + CONFIG_DEBUG_LOCKDEP=y + CONFIG_DEBUG_ATOMIC_SLEEP=y.
> > I'm not sure how to test the LPI / FFH part, but it looks good to me.
> > 
> > FWIW:
> > 
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Sudeep, would you be able to give the LPI/FFH side a spin with the kconfig
> > options above?
> > 
> 
> Not sure if I have messed up something in my mail setup, but I did reply
> earlier.

Sorry, that was my bad; I had been drafting my reply for a while and forgot to
re-check prior to sending.

> I did test both DT/cpuidle-psci driver and  ACPI/LPI+FFH driver
> with the fix Peter sent. I was seeing same splat as you in both DT and
> ACPI boot which the patch fixed it. I used the same config as described by
> you above.

Perfect; thanks!

Mark.
