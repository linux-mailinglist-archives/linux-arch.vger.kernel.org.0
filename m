Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ADB585BDB
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jul 2022 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiG3Twt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jul 2022 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiG3Tws (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jul 2022 15:52:48 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127E13F39;
        Sat, 30 Jul 2022 12:52:46 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id n8so13219366yba.2;
        Sat, 30 Jul 2022 12:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0QwwjVOIVs4sR9ljVmsJX6Xu2S4+tvcr+oBVAjM+ePA=;
        b=e8a+uAA9tupGiL3yo8EkLFat/Yo8hfOL0dEjkN03EunifrpH5WDt1ik8Q1l2EEocjT
         fVLKUVbPQ9p/jM9rZc9eF9zc1WhebYD91WFyUJRwIVfjf9eCUMB2ZXT2bKXo1vYd8xMc
         50i0dubF4/84MjJhKF4f85UL/b1J0h+2706rL4zlKw4tJHsRIFOrc5kAycR6TXvyhJ9j
         CllXK+t+T+a1NuZN8RfaIE0i+YPlr+Ffb4JjIxKgdpkG9WV3WEADKavvYeM3AYhjh8Iu
         gcsyrORxqg7xbZQpjRPJZ9seachiStWce2u60xdb874MBo8w5IRxW8i7Qr+4fXWv/6+q
         E64w==
X-Gm-Message-State: ACgBeo3OxYk4mfg72HXbMBbEY4LajVRBqucZ4mdHqCYye8RS04nh7S16
        hmWROudYRZmXM0tYeJDe4uYZSSldbIvoGgz0A8I=
X-Google-Smtp-Source: AA6agR5p+lnEO42NEIBehm6hZLFrmXewKv2ogwUWOYz3LvGYShyipeAc9YxoFpIxLibrvw9Jcl6WeqKY+cLq4G0/mNE=
X-Received: by 2002:a25:3458:0:b0:673:5bca:3b45 with SMTP id
 b85-20020a253458000000b006735bca3b45mr6304433yba.633.1659210766011; Sat, 30
 Jul 2022 12:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org> <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
 <20220729102458.GA1695@lespinasse.org> <CAJZ5v0gyPtX=ksCibo2ZN_BztCqUn9KRtRu+gsJ5KetB_1MwEQ@mail.gmail.com>
 <20220730094800.GB1587@lespinasse.org>
In-Reply-To: <20220730094800.GB1587@lespinasse.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 30 Jul 2022 21:52:34 +0200
Message-ID: <CAJZ5v0hXVjsWab=qYZfXBTqcjkpWV0CFT9_oQBKQ28rFG3_VLw@mail.gmail.com>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, vgupta@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        ulli.kroll@googlemail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>,
        kernel@xen0n.name, Geert Uytterhoeven <geert@linux-m68k.org>,
        sammy@sammy.net, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi,
        Stafford Horne <shorne@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@kernel.org, namhyung@kernel.org,
        Juergen Gross <jgross@suse.com>, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, senozhatsky@chromium.org,
        John Ogness <john.ogness@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        quic_neeraju@quicinc.com, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, rcu@vger.kernel.org,
        rh0@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 30, 2022 at 11:48 AM Michel Lespinasse
<michel@lespinasse.org> wrote:
>
> On Fri, Jul 29, 2022 at 04:59:50PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Jul 29, 2022 at 12:25 PM Michel Lespinasse
> > <michel@lespinasse.org> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 10:20:53AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Jul 25, 2022 at 12:43:06PM -0700, Michel Lespinasse wrote:
> > > > > On Wed, Jun 08, 2022 at 04:27:27PM +0200, Peter Zijlstra wrote:
> > > > > > Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> > > > > > Xeons") wrecked intel_idle in two ways:
> > > > > >
> > > > > >  - must not have tracing in idle functions
> > > > > >  - must return with IRQs disabled
> > > > > >
> > > > > > Additionally, it added a branch for no good reason.
> > > > > >
> > > > > > Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> > > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > >
> > > > > After this change was introduced, I am seeing "WARNING: suspicious RCU
> > > > > usage" when booting a kernel with debug options compiled in. Please
> > > > > see the attached dmesg output. The issue starts with commit 32d4fd5751ea
> > > > > and is still present in v5.19-rc8.
> > > > >
> > > > > I'm not sure, is this too late to fix or revert in v5.19 final ?
> > > >
> > > > I finally got a chance to take a quick look at this.
> > > >
> > > > The rcu_eqs_exit() function is making a lockdep complaint about
> > > > being invoked with interrupts enabled.  This function is called from
> > > > rcu_idle_exit(), which is an expected code path from cpuidle_enter_state()
> > > > via its call to rcu_idle_exit().  Except that rcu_idle_exit() disables
> > > > interrupts before invoking rcu_eqs_exit().
> > > >
> > > > The only other call to rcu_idle_exit() does not disable interrupts,
> > > > but it is via rcu_user_exit(), which would be a very odd choice for
> > > > cpuidle_enter_state().
> > > >
> > > > It seems unlikely, but it might be that it is the use of local_irq_save()
> > > > instead of raw_local_irq_save() within rcu_idle_exit() that is causing
> > > > the trouble.  If this is the case, then the commit shown below would
> > > > help.  Note that this commit removes the warning from lockdep, so it
> > > > is necessary to build the kernel with CONFIG_RCU_EQS_DEBUG=y to enable
> > > > equivalent debugging.
> > > >
> > > > Could you please try your test with the -rce commit shown below applied?
> > >
> > > Thanks for looking into it.
> > >
> > > After checking out Peter's commit 32d4fd5751ea,
> > > cherry picking your commit ed4ae5eff4b3,
> > > and setting CONFIG_RCU_EQS_DEBUG=y in addition of my usual debug config,
> > > I am now seeing this a few seconds into the boot:
> > >
> > > [    3.010650] ------------[ cut here ]------------
> > > [    3.010651] WARNING: CPU: 0 PID: 0 at kernel/sched/clock.c:397 sched_clock_tick+0x27/0x60
> > > [    3.010657] Modules linked in:
> > > [    3.010660] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc1-test-00005-g1be22fea0611 #1
> > > [    3.010662] Hardware name: LENOVO 30BFS44D00/1036, BIOS S03KT51A 01/17/2022
> > > [    3.010663] RIP: 0010:sched_clock_tick+0x27/0x60
> > > [    3.010665] Code: 1f 40 00 53 eb 02 5b c3 66 90 8b 05 2f c3 40 01 85 c0 74 18 65 8b 05 60 88 8f 4e 85 c0 75 0d 65 8b 05 a9 85 8f 4e 85 c0 74 02 <0f> 0b e8 e2 6c 89 00 48 c7 c3 40 d5 02 00
> > >  89 c0 48 03 1c c5 c0 98
> > > [    3.010667] RSP: 0000:ffffffffb2803e28 EFLAGS: 00010002
> > > [    3.010670] RAX: 0000000000000001 RBX: ffffc8ce7fa07060 RCX: 0000000000000001
> > > [    3.010671] RDX: 0000000000000000 RSI: ffffffffb268dd21 RDI: ffffffffb269ab13
> > > [    3.010673] RBP: 0000000000000001 R08: ffffffffffc300d5 R09: 000000000002be80
> > > [    3.010674] R10: 000003625b53183a R11: ffffa012b802b7a4 R12: ffffffffb2aa9e80
> > > [    3.010675] R13: ffffffffb2aa9e00 R14: 0000000000000001 R15: 0000000000000000
> > > [    3.010677] FS:  0000000000000000(0000) GS:ffffa012b8000000(0000) knlGS:0000000000000000
> > > [    3.010678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    3.010680] CR2: ffffa012f81ff000 CR3: 0000000c99612001 CR4: 00000000003706f0
> > > [    3.010681] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [    3.010682] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [    3.010683] Call Trace:
> > > [    3.010685]  <TASK>
> > > [    3.010688]  cpuidle_enter_state+0xb7/0x4b0
> > > [    3.010694]  cpuidle_enter+0x29/0x40
> > > [    3.010697]  do_idle+0x1d4/0x210
> > > [    3.010702]  cpu_startup_entry+0x19/0x20
> > > [    3.010704]  rest_init+0x117/0x1a0
> > > [    3.010708]  arch_call_rest_init+0xa/0x10
> > > [    3.010711]  start_kernel+0x6d8/0x6ff
> > > [    3.010716]  secondary_startup_64_no_verify+0xce/0xdb
> > > [    3.010728]  </TASK>
> > > [    3.010729] irq event stamp: 44179
> > > [    3.010730] hardirqs last  enabled at (44179): [<ffffffffb2000ccb>] asm_sysvec_apic_timer_interrupt+0x1b/0x20
> > > [    3.010734] hardirqs last disabled at (44177): [<ffffffffb22003f0>] __do_softirq+0x3f0/0x498
> > > [    3.010736] softirqs last  enabled at (44178): [<ffffffffb2200332>] __do_softirq+0x332/0x498
> > > [    3.010738] softirqs last disabled at (44171): [<ffffffffb16c760b>] irq_exit_rcu+0xab/0xf0
> > > [    3.010741] ---[ end trace 0000000000000000 ]---
> >
> > Can you please give this patch a go:
> > https://patchwork.kernel.org/project/linux-pm/patch/Yt/AxPFi88neW7W5@e126311.manchester.arm.com/
> > ?
>
> I tried, but it didn't change the picture for me.
>
> I'm not sure if that was the patch you meant to send though, as it
> seems it's only adding a tracepoint so shouldn't make any difference
> if I'm not actually using the tracepoint ?

You are right, it looks like I pasted a link to a different patch by
mistake.  Sorry about that.

I meant this one:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm&id=d295ad34f236c3518634fb6403d4c0160456e470

which will appear in the final 5.19.
