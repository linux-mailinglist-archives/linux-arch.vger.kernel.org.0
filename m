Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14500543628
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbiFHPK6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243371AbiFHPK2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 11:10:28 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F246F8CE;
        Wed,  8 Jun 2022 08:01:17 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id p13so36971739ybm.1;
        Wed, 08 Jun 2022 08:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hna+hKCo48NcMl7Pqd/5P+UyLOQ1wF88gpvnodTJhxE=;
        b=vlsS08/X13NCCoVNEOmpS71IBzxKuXi6flyI8AcfeeYWsWD/ztcSRvgl1Tsni97Fy7
         QkEhN0mLSgYJExsGaITnwHmGMoJthSziLUAba15/TlVhwC0WhNa8iwkY73lsmZswROuH
         +rhfgX9pypo4uV64UijL45J0Vl1i7Bd5JwzJ9zmGe2dhVbX1R2TspTSOoBF8X76teXzP
         8DNuV0KCXQkfzCij5+Ql9h0CAcKGVtM/LasWL7HuJ3KnbdIBov/OJA3wsuhpF4kEi+O9
         B4j9EJcvnQFU8w/px8Yzrwfj6ANa8tovdUPwQw+iA+7DLshQ10g3yBCGplqsYtzR8cDQ
         AAgg==
X-Gm-Message-State: AOAM531jyaKTiKqRuT/tZdlg/N2S+bqehl07TxqGkenAdsyYkENSg+31
        ebj5j+EjBeNzNHUcDWoXex025nYdBQLWgNa6ZMU=
X-Google-Smtp-Source: ABdhPJwqalQMdxMy/pZcDZhBH1xedB7nhZhOlo0yW6lp9BXwx4h5qG3Bba3YMzpLPF7jDA8EKVOjRHlndcGghrEojUg=
X-Received: by 2002:a5b:4a:0:b0:663:7c5b:a5ba with SMTP id e10-20020a5b004a000000b006637c5ba5bamr16536948ybp.81.1654700476488;
 Wed, 08 Jun 2022 08:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144516.172460444@infradead.org>
In-Reply-To: <20220608144516.172460444@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jun 2022 17:01:05 +0200
Message-ID: <CAJZ5v0gW-zD8Mgghy70f3rFz0QoozCwZ9idyrqtFgA6SWHK5XQ@mail.gmail.com>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
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
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, chris@zankel.net,
        jcmvbkbc@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        lpieralisi@kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
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
> Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> Xeons") wrecked intel_idle in two ways:
>
>  - must not have tracing in idle functions
>  - must return with IRQs disabled
>
> Additionally, it added a branch for no good reason.
>
> Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

And do I think correctly that this can be applied without the rest of
the series?

> ---
>  drivers/idle/intel_idle.c |   48 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 11 deletions(-)
>
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -129,21 +137,37 @@ static unsigned int mwait_substates __in
>   *
>   * Must be called under local_irq_disable().
>   */
> +
> -static __cpuidle int intel_idle(struct cpuidle_device *dev,
> -                               struct cpuidle_driver *drv, int index)
> +static __always_inline int __intel_idle(struct cpuidle_device *dev,
> +                                       struct cpuidle_driver *drv, int index)
>  {
>         struct cpuidle_state *state = &drv->states[index];
>         unsigned long eax = flg2MWAIT(state->flags);
>         unsigned long ecx = 1; /* break on interrupt flag */
>
> -       if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
> -               local_irq_enable();
> -
>         mwait_idle_with_hints(eax, ecx);
>
>         return index;
>  }
>
> +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv, int index)
> +{
> +       return __intel_idle(dev, drv, index);
> +}
> +
> +static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
> +                                   struct cpuidle_driver *drv, int index)
> +{
> +       int ret;
> +
> +       raw_local_irq_enable();
> +       ret = __intel_idle(dev, drv, index);
> +       raw_local_irq_disable();
> +
> +       return ret;
> +}
> +
>  /**
>   * intel_idle_s2idle - Ask the processor to enter the given idle state.
>   * @dev: cpuidle device of the target CPU.
> @@ -1801,6 +1824,9 @@ static void __init intel_idle_init_cstat
>                 /* Structure copy. */
>                 drv->states[drv->state_count] = cpuidle_state_table[cstate];
>
> +               if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
> +                       drv->states[drv->state_count].enter = intel_idle_irq;
> +
>                 if ((disabled_states_mask & BIT(drv->state_count)) ||
>                     ((icpu->use_acpi || force_use_acpi) &&
>                      intel_idle_off_by_default(mwait_hint) &&
>
>
