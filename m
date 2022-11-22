Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D377E6340D3
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 17:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiKVQFR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 11:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiKVQFP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 11:05:15 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37951DA53
        for <linux-arch@vger.kernel.org>; Tue, 22 Nov 2022 08:05:10 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q1so14426983pgl.11
        for <linux-arch@vger.kernel.org>; Tue, 22 Nov 2022 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKqixJN/8zapPMiYOY0ZA2E36N6vIQg16uLiOxlikFI=;
        b=Sxgb7NdwQ/FjyYXzMQLr2Ufh8inWhewppyg2kEhKfSMa5+4xLhcDZFgBkLe+YVojYR
         b1j/8R8eepdhz2QNEoN59UWxI0C8HtPNMN2hfsnJ2VXdsyzTbL+tlNksQKPnsWg/NtBp
         chCgU4N95aPK2lbuS5RzKtW5ffOhO3rTLhquzizFSUU3p/ux1MbE2BMO0btBQyCrWeJK
         WXzMJ1H0fbnItfONfrC7qjjeZVQUnHu7QZDLXM8ZsS1OkeorqU4Yt3+bnHeBb63EIVUM
         ARM0B0wTMD/PlD/5zjrBQjmOnBQvgdxEwxF1FwYHEN8lHlbB5RkK/8WK1b4hFP6jFplD
         FuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKqixJN/8zapPMiYOY0ZA2E36N6vIQg16uLiOxlikFI=;
        b=5S/y5VVlE1cJVx7dbPT2EFTBLPsl6sjErW6FYr1unnjlihKNFeM99KuSnzuUS86Lna
         RYTcGfIjXLQ9wBZS3wKkVBkcYIKrstewBA86nqRa8TGK5h240oJD4VxAYF2PpNYmo7w8
         OiHjngeBhq3HjuejRTO6LjtpnZsGVWV+edO3XcPPsshLUKWTkEkerk4Ij3nHW0JhEpMh
         iM1QMOK96dw3YGdkEeqViJJhCT5BdlV5CNKdQQVwyCEYC5hIOy60iR+JLXOnx5FnWw/2
         NVpNKnf2ixHWO5gYz6yYfI8+DVol7ggpE8aWJJnQbSb98bWTdokjOqjGmlsl8fQRaRtQ
         knsQ==
X-Gm-Message-State: ANoB5pmkJSwpTJjtDrq02EEK/HkO24X5fumhjoydEL/waZEBFeQn5S+o
        AIDqaxp66AGWEUgo4Dj+cTHtETLGKiEFWWzz+4JaVw==
X-Google-Smtp-Source: AA0mqf6JSvaqlcRgOCqphXQ3MBWuxLvJ9cnb0DNFGeizoGOcIFvJAwjnOuz3SuqXXwFDZ3Z3O+rn4vXVPvsxTfgKOLE=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr3900068pgb.541.1669133109958; Tue, 22
 Nov 2022 08:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org> <20220919101521.139727471@infradead.org>
 <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com> <Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Nov 2022 17:04:33 +0100
Message-ID: <CAPDyKFqzmJdVVrcuJ6Hmr5nNgtpd9Oke_exmUKuTGZEb=PjvjQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/44] cpuidle,dt: Push RCU-idle into driver
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com,
        linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org,
        pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org,
        vincent.guittot@linaro.org, mpe@ellerman.id.au,
        chenhuacai@kernel.org, christophe.leroy@csgroup.eu,
        linux-acpi@vger.kernel.org, agross@kernel.org,
        geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org,
        mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net,
        pmladek@suse.com, linux-pm@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-um@lists.infradead.org, npiggin@gmail.com,
        tglx@linutronix.de, linux-omap@vger.kernel.org,
        dietmar.eggemann@arm.com, andreyknvl@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
        svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        mark.rutland@arm.com, linux-ia64@vger.kernel.org,
        dave.hansen@linux.intel.com,
        virtualization@lists.linux-foundation.org,
        James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
        thierry.reding@gmail.com, kernel@xen0n.name, cl@linux.com,
        linux-s390@vger.kernel.org, vschneid@redhat.com,
        john.ogness@linutronix.de, ysato@users.sourceforge.jp,
        linux-sh@vger.kernel.org, festevam@gmail.com, deller@gmx.de,
        daniel.lezcano@linaro.org, jonathanh@nvidia.com, dennis@kernel.org,
        lenb@kernel.org, linux-xtensa@linux-xtensa.org,
        kernel@pengutronix.de, gor@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        shorne@gmail.com, chris@zankel.net, sboyd@kernel.org,
        dinguyen@kernel.org, bristot@redhat.com,
        alexander.shishkin@linux.intel.com, fweisbec@gmail.com,
        lpieralisi@kernel.org, atishp@atishpatra.org,
        linux@rasmusvillemoes.dk, kasan-dev@googlegroups.com,
        will@kernel.org, boris.ostrovsky@oracle.com, khilman@kernel.org,
        linux-csky@vger.kernel.org, pv-drivers@vmware.com,
        linux-snps-arc@lists.infradead.org, mgorman@suse.de,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        ulli.kroll@googlemail.com, linux-clk@vger.kernel.org,
        rostedt@goodmis.org, ink@jurassic.park.msu.ru, bcain@quicinc.com,
        tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
        ryabinin.a.a@gmail.com, sudeep.holla@arm.com, shawnguo@kernel.org,
        davem@davemloft.net, dalias@libc.org, tony@atomide.com,
        amakhalov@vmware.com, konrad.dybcio@somainline.org,
        bjorn.andersson@linaro.org, glider@google.com, hpa@zytor.com,
        sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-riscv@lists.infradead.org, vincenzo.frascino@arm.com,
        anton.ivanov@cambridgegreys.com, jonas@southpole.se,
        yury.norov@gmail.com, richard@nod.at, x86@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, aou@eecs.berkeley.edu,
        hca@linux.ibm.com, richard.henderson@linaro.org,
        stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
        acme@kernel.org, paul.walmsley@sifive.com,
        linux-tegra@vger.kernel.org, namhyung@kernel.org,
        andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org,
        dvyukov@google.com, jgross@suse.com, monstr@monstr.eu,
        linux-mips@vger.kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, bp@alien8.de, johannes@sipsolutions.net,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 16 Nov 2022 at 16:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Sorry; things keep getting in the way of finishing this :/
>
> As such, I need a bit of time to get on-track again..
>
> On Tue, Oct 04, 2022 at 01:03:57PM +0200, Ulf Hansson wrote:
>
> > > --- a/drivers/acpi/processor_idle.c
> > > +++ b/drivers/acpi/processor_idle.c
> > > @@ -1200,6 +1200,8 @@ static int acpi_processor_setup_lpi_stat
> > >                 state->target_residency = lpi->min_residency;
> > >                 if (lpi->arch_flags)
> > >                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > > +               if (lpi->entry_method == ACPI_CSTATE_FFH)
> > > +                       state->flags |= CPUIDLE_FLAG_RCU_IDLE;
> >
> > I assume the state index here will never be 0?
> >
> > If not, it may lead to that acpi_processor_ffh_lpi_enter() may trigger
> > CPU_PM_CPU_IDLE_ENTER_PARAM() to call ct_cpuidle_enter|exit() for an
> > idle-state that doesn't have the CPUIDLE_FLAG_RCU_IDLE bit set.
>
> I'm not quite sure I see how. AFAICT this condition above implies
> acpi_processor_ffh_lpi_enter() gets called, no?
>
> Which in turn is an unconditional __CPU_PM_CPU_IDLE_ENTER() user, so
> even if idx==0, it ends up in ct_idle_{enter,exit}().

Seems like I was overlooking something here, you are right, this
shouldn't really be a problem.

>
> >
> > >                 state->enter = acpi_idle_lpi_enter;
> > >                 drv->safe_state_index = i;
> > >         }
> > > --- a/drivers/cpuidle/cpuidle-arm.c
> > > +++ b/drivers/cpuidle/cpuidle-arm.c
> > > @@ -53,6 +53,7 @@ static struct cpuidle_driver arm_idle_dr
> > >          * handler for idle state index 0.
> > >          */
> > >         .states[0] = {
> > > +               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> >
> > Comparing arm64 and arm32 idle-states/idle-drivers, the $subject
> > series ends up setting the CPUIDLE_FLAG_RCU_IDLE for the ARM WFI idle
> > state (state zero), but only for the arm64 and psci cases (mostly
> > arm64). For arm32 we would need to update the ARM_CPUIDLE_WFI_STATE
> > too, as that is what most arm32 idle-drivers are using. My point is,
> > the code becomes a bit inconsistent.
>
> True.
>
> > Perhaps it's easier to avoid setting the CPUIDLE_FLAG_RCU_IDLE bit for
> > all of the ARM WFI idle states, for both arm64 and arm32?
>
> As per the below?
>
> >
> > >                 .enter                  = arm_enter_idle_state,
> > >                 .exit_latency           = 1,
> > >                 .target_residency       = 1,
>
> > > --- a/include/linux/cpuidle.h
> > > +++ b/include/linux/cpuidle.h
> > > @@ -282,14 +282,18 @@ extern s64 cpuidle_governor_latency_req(
> > >         int __ret = 0;                                                  \
> > >                                                                         \
> > >         if (!idx) {                                                     \
> > > +               ct_idle_enter();                                        \
> >
> > According to my comment above, we should then drop these calls to
> > ct_idle_enter and ct_idle_exit() here. Right?
>
> Yes, if we ensure idx==0 never has RCU_IDLE set then these must be
> removed.
>
> > >                 cpu_do_idle();                                          \
> > > +               ct_idle_exit();                                         \
> > >                 return idx;                                             \
> > >         }                                                               \
> > >                                                                         \
> > >         if (!is_retention)                                              \
> > >                 __ret =  cpu_pm_enter();                                \
> > >         if (!__ret) {                                                   \
> > > +               ct_idle_enter();                                        \
> > >                 __ret = low_level_idle_enter(state);                    \
> > > +               ct_idle_exit();                                         \
> > >                 if (!is_retention)                                      \
> > >                         cpu_pm_exit();                                  \
> > >         }                                                               \
> > >
>
> So the basic premise is that everything that needs RCU inside the idle
> callback must set CPUIDLE_FLAG_RCU_IDLE and by doing that promise to
> call ct_idle_{enter,exit}() themselves.
>
> Setting RCU_IDLE is required when there is RCU usage, however even if
> there is no RCU usage, setting RCU_IDLE is fine, as long as
> ct_idle_{enter,exit}() then get called.

Right, I was thinking that it could make sense to shrink the window
for users getting this wrong. In other words, we shouldn't set the
CPUIDLE_FLAG_RCU_IDLE unless we really need to.

And as I said, consistent behaviour is also nice to have.

>
>
> So does the below (delta) look better to you?

Yes, it does!

Although, one minor comment below.

>
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1218,7 +1218,7 @@ static int acpi_processor_setup_lpi_stat
>                 state->target_residency = lpi->min_residency;
>                 if (lpi->arch_flags)
>                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> -               if (lpi->entry_method == ACPI_CSTATE_FFH)
> +               if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
>                         state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>                 state->enter = acpi_idle_lpi_enter;
>                 drv->safe_state_index = i;
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -53,7 +53,7 @@ static struct cpuidle_driver arm_idle_dr
>          * handler for idle state index 0.
>          */
>         .states[0] = {
> -               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> +               .flags                  = 0,

Nitpick: I don't think we need to explicitly clear the flag, as it
should already be zeroed by the compiler from its static declaration.
Right?

>                 .enter                  = arm_enter_idle_state,
>                 .exit_latency           = 1,
>                 .target_residency       = 1,
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -357,7 +357,7 @@ static int psci_idle_init_cpu(struct dev
>          * PSCI idle states relies on architectural WFI to be represented as
>          * state index 0.
>          */
> -       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
> +       drv->states[0].flags = 0;
>         drv->states[0].enter = psci_enter_idle_state;
>         drv->states[0].exit_latency = 1;
>         drv->states[0].target_residency = 1;
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -72,7 +72,7 @@ static struct cpuidle_driver qcom_spm_id
>         .owner = THIS_MODULE,
>         .states[0] = {
>                 .enter                  = spm_enter_idle_state,
> -               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> +               .flags                  = 0,
>                 .exit_latency           = 1,
>                 .target_residency       = 1,
>                 .power_usage            = UINT_MAX,
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -337,7 +337,7 @@ static int sbi_cpuidle_init_cpu(struct d
>         drv->cpumask = (struct cpumask *)cpumask_of(cpu);
>
>         /* RISC-V architectural WFI to be represented as state index 0. */
> -       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
> +       drv->states[0].flags = 0;
>         drv->states[0].enter = sbi_cpuidle_enter_state;
>         drv->states[0].exit_latency = 1;
>         drv->states[0].target_residency = 1;
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -282,9 +282,7 @@ extern s64 cpuidle_governor_latency_req(
>         int __ret = 0;                                                  \
>                                                                         \
>         if (!idx) {                                                     \
> -               ct_idle_enter();                                        \
>                 cpu_do_idle();                                          \
> -               ct_idle_exit();                                         \
>                 return idx;                                             \
>         }                                                               \
>                                                                         \

Kind regards
Uffe
