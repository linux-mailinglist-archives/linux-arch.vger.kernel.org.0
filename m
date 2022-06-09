Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96660544834
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jun 2022 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiFIKCO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jun 2022 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiFIKCN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2022 06:02:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921714E94C;
        Thu,  9 Jun 2022 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UbbDgBiwip0YBZOTZVQugfugvsZnYOECFEm/sChB2KE=; b=pk5LmI1A6aszGw6bJBfBOEp2aD
        U1h+ZFFSSnK8VqAlyB4JuyYAdX13KUgLZiqkzxfwMXZ9rLcXV72vPGCzoT5Nh/jWgfuAo9rvsnY2d
        uR5AV7hvfyPjralHm1TpJmT+OCcad3LiNA+fq5wN7wYCWN4JhRiwUwGBAslMEHFWQWn5ULi2Lub4P
        i+EEJRnbfwtH5eutwugIAwcmhtxvbG1a5W2y8SzA+C4Ts7dxbLHpQKmAmovezzT8tR42G7Z3XpfnO
        yc0zC9lSe7OtjlT7qvzvuP3LXJVZDKeRWF3xOE4FMAliLG0o07t6jIPvQ35THQypS5lZSRykYm4f6
        U90A/TjQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzEzM-00DRgJ-Mk; Thu, 09 Jun 2022 10:02:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E614981287; Thu,  9 Jun 2022 12:02:04 +0200 (CEST)
Date:   Thu, 9 Jun 2022 12:02:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        linux@armlinux.org.uk, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, shawnguo@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com,
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
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
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
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Message-ID: <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.444659212@infradead.org>
 <YqG6URbihTNCk9YR@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqG6URbihTNCk9YR@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 09, 2022 at 11:16:46AM +0200, Petr Mladek wrote:
> On Wed 2022-06-08 16:27:47, Peter Zijlstra wrote:
> > The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
> > tracepoint"), was printk usage from the cpuidle path where RCU was
> > already disabled.
> > 
> > Per the patches earlier in this series, this is no longer the case.
> 
> My understanding is that this series reduces a lot the amount
> of code called with RCU disabled. As a result the particular printk()
> call mentioned by commit fc98c3c8c9dc ("printk: use rcuidle console
> tracepoint") is called with RCU enabled now. Hence this particular
> problem is fixed better way now.
> 
> But is this true in general?
> Does this "prevent" calling printk() a safe way in code with
> RCU disabled?

On x86_64, yes. Other architectures, less so.

Specifically, the objtool noinstr validation pass will warn at build
time (DEBUG_ENTRY=y) if any noinstr/cpuidle code does a call to
non-vetted code like printk().

At the same time; there's a few hacks that allow WARN to work, but
mostly if you hit WARN in entry/noinstr you get to keep the pieces in
any case.

On other architecture we'll need to rely on runtime coverage with
PROVE_RCU. That is, if a splat like in the above mentioned commit
happens again, we'll need to fix it by adjusting the callchain, not by
mucking about with RCU state.

> I am not sure if anyone cares. printk() is the best effort
> functionality because of the consoles code anyway. Also I wonder
> if anyone uses this trace_console().

This is the tracepoint used to spool all of printk into ftrace, I
suspect there's users, but I haven't used it myself.

> Therefore if this patch allows to remove some tricky tracing
> code then it might be worth it. But if trace_console_rcuidle()
> variant is still going to be available then I would keep using it.

My ultimate goal is to delete trace_.*_rcuidle() and RCU_NONIDLE()
entirely. We're close, but not quite there yet.
