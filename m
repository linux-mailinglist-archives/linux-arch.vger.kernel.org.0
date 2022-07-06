Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969EF568A58
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiGFN7l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiGFN7i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 09:59:38 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4EA18E13;
        Wed,  6 Jul 2022 06:59:33 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31cac89d8d6so71276737b3.2;
        Wed, 06 Jul 2022 06:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Onduqp6mjVbUTy8onn0jWt/mqpI9kGBQEYh+QUeZcBU=;
        b=0cMUwTkAAVvw+UNO02IWyceWodYmhCDcBP9pequ0hZ1hN3XzdMVPegHdPc9D/E/CfB
         L2kWvRP4z5KjqsLuu/fSiyz/ZCU7FEXJUfuVjNJc/Dmdq891LnjpdcUELB4uakW9sl3V
         nM6urUU7UKgxL8lVgXpHZeUNVyTzGaa9ZQvX3o3AVLOVQnhulI1d+Ok2tTqDwvmeAGKZ
         v+pR84yNvxLCwk0u+Rh67ibdA5e0LB5Hj6ohbH+/JKUjB7V8KaWU1FP+xwEyuJTfPyQ2
         vYen9kOzd+zuYvRYze3gjvuzvVo4K4cabXJJryPLyBJfVHc6cnL+Y/guIs1Z2JOLASP4
         /OdQ==
X-Gm-Message-State: AJIora/9LuZKkijMpe8AtJ/J1dJrHEjvs2XegfMP5EZtc4AyAydXM3GV
        G/SE1BZglgSvpfi1JAmXJnCIKUDa6ksQ8LoGIcg=
X-Google-Smtp-Source: AGRyM1tNbC/Hml4tsQcA7xFkjwPTBe4V9sculTi4g4WqVg8ltnNA+flCFfg0CHpb2ZdV5OvqewQ30xyxgoEo0qXCWHo=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr45117410ywb.326.1657115972382; Wed, 06
 Jul 2022 06:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144516.998681585@infradead.org>
In-Reply-To: <20220608144516.998681585@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Jul 2022 15:59:21 +0200
Message-ID: <CAJZ5v0jSfvUoReFHjA5A+brExnnEKidak-GnjTbY0CKoaWpGVQ@mail.gmail.com>
Subject: Re: [PATCH 17/36] acpi_idle: Remove tracing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org,
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
        Chris Zankel <chris@zankel.net>, jcmvbkbc@gmail.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
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
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        linux-arch <linux-arch@vger.kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> All the idle routines are called with RCU disabled, as such there must
> not be any tracing inside.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This actually does some additional code duplication cleanup which
would be good to mention in the changelog.  Or even move to a separate
patch for that matter.

Otherwise LGTM.

> ---
>  drivers/acpi/processor_idle.c |   24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -108,8 +108,8 @@ static const struct dmi_system_id proces
>  static void __cpuidle acpi_safe_halt(void)
>  {
>         if (!tif_need_resched()) {
> -               safe_halt();
> -               local_irq_disable();
> +               raw_safe_halt();
> +               raw_local_irq_disable();
>         }
>  }
>
> @@ -524,16 +524,21 @@ static int acpi_idle_bm_check(void)
>         return bm_status;
>  }
>
> -static void wait_for_freeze(void)
> +static __cpuidle void io_idle(unsigned long addr)
>  {
> +       /* IO port based C-state */
> +       inb(addr);
> +
>  #ifdef CONFIG_X86
>         /* No delay is needed if we are in guest */
>         if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>                 return;
>  #endif
> -       /* Dummy wait op - must do something useless after P_LVL2 read
> -          because chipsets cannot guarantee that STPCLK# signal
> -          gets asserted in time to freeze execution properly. */
> +       /*
> +        * Dummy wait op - must do something useless after P_LVL2 read
> +        * because chipsets cannot guarantee that STPCLK# signal
> +        * gets asserted in time to freeze execution properly.
> +        */
>         inl(acpi_gbl_FADT.xpm_timer_block.address);
>  }
>
> @@ -553,9 +558,7 @@ static void __cpuidle acpi_idle_do_entry
>         } else if (cx->entry_method == ACPI_CSTATE_HALT) {
>                 acpi_safe_halt();
>         } else {
> -               /* IO port based C-state */
> -               inb(cx->address);
> -               wait_for_freeze();
> +               io_idle(cx->address);
>         }
>
>         perf_lopwr_cb(false);
> @@ -577,8 +580,7 @@ static int acpi_idle_play_dead(struct cp
>                 if (cx->entry_method == ACPI_CSTATE_HALT)
>                         safe_halt();
>                 else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
> -                       inb(cx->address);
> -                       wait_for_freeze();
> +                       io_idle(cx->address);
>                 } else
>                         return -ENODEV;
>
>
>
