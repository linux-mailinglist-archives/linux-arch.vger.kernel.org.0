Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4615F422F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJDLoS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJDLoM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 07:44:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A65140A
        for <linux-arch@vger.kernel.org>; Tue,  4 Oct 2022 04:44:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j71so6350504pge.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Oct 2022 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6ZpUfgQM8l58jAA1FLv6FNtqasscnAngw/MWtVrklhs=;
        b=Bo9x/OnIeuD4yOxUQBcKmabUSqnMZ0tD37iq/OHVxEJh7l092LYUiEcByhyeKoPqQH
         6ccMpXG4qRKbkr941fgMrmTCvs7mBDKkmcyZ2TkZ97cu4Erpz6364n3eKpYtT/b1NuAZ
         pi9UC5KrZS8fHRid7zPrK2EhUttI5OrNRFHSo8P3Mb2tkDzqPas8gU17A3WN+Bdf8SsZ
         dU9egD++P5XQakRrLuSrsLxcUXmzHPNMQsJfA7zWkxd6pg+zQjqIPz81iRSpYAnZdaFW
         4XHAdmJUPlV/gsJ01s3Xsj5gKwh9HnkRQU0HSv1IiMZAjlCNlnOhbi1ezx8q34YNlXVA
         xsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6ZpUfgQM8l58jAA1FLv6FNtqasscnAngw/MWtVrklhs=;
        b=1MIWi20E+Cxh2+VEgXs+eFXNEGqAucOtTQJHGcCrw/l4TrOo6TzHw72xnMRkxqjJGt
         vToo3nb9VizBlqOZqQwfwfMBXR318Spgy+DeNW/7v9cvtstLyJieksbLaU4E1q26qiJe
         9LrtJNZY7G2dgMzdUVHjkFvqqpNsxs4ZrZnz1LXcvTWbf4CWLcWde8G+AvQHQua3vtYM
         oFEaErJzfM15AMknQzS2tAgYH1yEL0vtf+w+QJ8/wfFESDj/aTUw0tTlCosJGHC/mh6h
         6XtaWl4GGcvn/L3myFbWzVALth3IGI6B+DGUZCrNdsTtmOG2Fj+qPb8pYl8temV6VzJb
         BvKQ==
X-Gm-Message-State: ACrzQf2N8V1He7240KQRaQJg/WGdypnV1TbeU/AEsXl9hXYypUfCr3rz
        Hh18g4UKAAcvrXrroOr+2eBqJiqNbWftxYwYz2VoNw==
X-Google-Smtp-Source: AMsMyM5om3ildrb6FXKsDICcjLQng8HApyTNXbRFn0vHa6n1wlhKJZOEgXsol3CWajbZfhZ3j9+WO0SV0tqOewvj3U8=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr19098981pgk.595.1664883848385; Tue, 04
 Oct 2022 04:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org> <20220919101521.139727471@infradead.org>
 <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com>
In-Reply-To: <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Oct 2022 13:43:31 +0200
Message-ID: <CAPDyKFqGSt2NFe8aY=6rkp4P-WH7DCO1fmWrcXk4_5XNEvv25w@mail.gmail.com>
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

On Tue, 4 Oct 2022 at 13:03, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 19 Sept 2022 at 12:18, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Doing RCU-idle outside the driver, only to then temporarily enable it
> > again before going idle is daft.
> >
> > Notably: this converts all dt_init_idle_driver() and
> > __CPU_PM_CPU_IDLE_ENTER() users for they are inextrably intertwined.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

This was not (yet) my intention. Please have a look at the comments I
provided below.

Kind regards
Uffe

>
> > ---
> >  arch/arm/mach-omap2/cpuidle34xx.c    |    4 ++--
> >  drivers/acpi/processor_idle.c        |    2 ++
> >  drivers/cpuidle/cpuidle-arm.c        |    1 +
> >  drivers/cpuidle/cpuidle-big_little.c |    8 ++++++--
> >  drivers/cpuidle/cpuidle-psci.c       |    1 +
> >  drivers/cpuidle/cpuidle-qcom-spm.c   |    1 +
> >  drivers/cpuidle/cpuidle-riscv-sbi.c  |    1 +
> >  drivers/cpuidle/dt_idle_states.c     |    2 +-
> >  include/linux/cpuidle.h              |    4 ++++
> >  9 files changed, 19 insertions(+), 5 deletions(-)
> >
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -1200,6 +1200,8 @@ static int acpi_processor_setup_lpi_stat
> >                 state->target_residency = lpi->min_residency;
> >                 if (lpi->arch_flags)
> >                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > +               if (lpi->entry_method == ACPI_CSTATE_FFH)
> > +                       state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>
> I assume the state index here will never be 0?
>
> If not, it may lead to that acpi_processor_ffh_lpi_enter() may trigger
> CPU_PM_CPU_IDLE_ENTER_PARAM() to call ct_cpuidle_enter|exit() for an
> idle-state that doesn't have the CPUIDLE_FLAG_RCU_IDLE bit set.
>
> >                 state->enter = acpi_idle_lpi_enter;
> >                 drv->safe_state_index = i;
> >         }
> > --- a/drivers/cpuidle/cpuidle-arm.c
> > +++ b/drivers/cpuidle/cpuidle-arm.c
> > @@ -53,6 +53,7 @@ static struct cpuidle_driver arm_idle_dr
> >          * handler for idle state index 0.
> >          */
> >         .states[0] = {
> > +               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
>
> Comparing arm64 and arm32 idle-states/idle-drivers, the $subject
> series ends up setting the CPUIDLE_FLAG_RCU_IDLE for the ARM WFI idle
> state (state zero), but only for the arm64 and psci cases (mostly
> arm64). For arm32 we would need to update the ARM_CPUIDLE_WFI_STATE
> too, as that is what most arm32 idle-drivers are using. My point is,
> the code becomes a bit inconsistent.
>
> Perhaps it's easier to avoid setting the CPUIDLE_FLAG_RCU_IDLE bit for
> all of the ARM WFI idle states, for both arm64 and arm32?
>
> >                 .enter                  = arm_enter_idle_state,
> >                 .exit_latency           = 1,
> >                 .target_residency       = 1,
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -64,7 +64,8 @@ static struct cpuidle_driver bl_idle_lit
> >                 .enter                  = bl_enter_powerdown,
> >                 .exit_latency           = 700,
> >                 .target_residency       = 2500,
> > -               .flags                  = CPUIDLE_FLAG_TIMER_STOP,
> > +               .flags                  = CPUIDLE_FLAG_TIMER_STOP |
> > +                                         CPUIDLE_FLAG_RCU_IDLE,
> >                 .name                   = "C1",
> >                 .desc                   = "ARM little-cluster power down",
> >         },
> > @@ -85,7 +86,8 @@ static struct cpuidle_driver bl_idle_big
> >                 .enter                  = bl_enter_powerdown,
> >                 .exit_latency           = 500,
> >                 .target_residency       = 2000,
> > -               .flags                  = CPUIDLE_FLAG_TIMER_STOP,
> > +               .flags                  = CPUIDLE_FLAG_TIMER_STOP |
> > +                                         CPUIDLE_FLAG_RCU_IDLE,
> >                 .name                   = "C1",
> >                 .desc                   = "ARM big-cluster power down",
> >         },
> > @@ -124,11 +126,13 @@ static int bl_enter_powerdown(struct cpu
> >                                 struct cpuidle_driver *drv, int idx)
> >  {
> >         cpu_pm_enter();
> > +       ct_idle_enter();
> >
> >         cpu_suspend(0, bl_powerdown_finisher);
> >
> >         /* signals the MCPM core that CPU is out of low power state */
> >         mcpm_cpu_powered_up();
> > +       ct_idle_exit();
> >
> >         cpu_pm_exit();
> >
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -357,6 +357,7 @@ static int psci_idle_init_cpu(struct dev
> >          * PSCI idle states relies on architectural WFI to be represented as
> >          * state index 0.
> >          */
> > +       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
> >         drv->states[0].enter = psci_enter_idle_state;
> >         drv->states[0].exit_latency = 1;
> >         drv->states[0].target_residency = 1;
> > --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> > +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> > @@ -72,6 +72,7 @@ static struct cpuidle_driver qcom_spm_id
> >         .owner = THIS_MODULE,
> >         .states[0] = {
> >                 .enter                  = spm_enter_idle_state,
> > +               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> >                 .exit_latency           = 1,
> >                 .target_residency       = 1,
> >                 .power_usage            = UINT_MAX,
> > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > @@ -332,6 +332,7 @@ static int sbi_cpuidle_init_cpu(struct d
> >         drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> >
> >         /* RISC-V architectural WFI to be represented as state index 0. */
> > +       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
> >         drv->states[0].enter = sbi_cpuidle_enter_state;
> >         drv->states[0].exit_latency = 1;
> >         drv->states[0].target_residency = 1;
> > --- a/drivers/cpuidle/dt_idle_states.c
> > +++ b/drivers/cpuidle/dt_idle_states.c
> > @@ -77,7 +77,7 @@ static int init_state_node(struct cpuidl
> >         if (err)
> >                 desc = state_node->name;
> >
> > -       idle_state->flags = 0;
> > +       idle_state->flags = CPUIDLE_FLAG_RCU_IDLE;
> >         if (of_property_read_bool(state_node, "local-timer-stop"))
> >                 idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> >         /*
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -282,14 +282,18 @@ extern s64 cpuidle_governor_latency_req(
> >         int __ret = 0;                                                  \
> >                                                                         \
> >         if (!idx) {                                                     \
> > +               ct_idle_enter();                                        \
>
> According to my comment above, we should then drop these calls to
> ct_idle_enter and ct_idle_exit() here. Right?
>
> >                 cpu_do_idle();                                          \
> > +               ct_idle_exit();                                         \
> >                 return idx;                                             \
> >         }                                                               \
> >                                                                         \
> >         if (!is_retention)                                              \
> >                 __ret =  cpu_pm_enter();                                \
> >         if (!__ret) {                                                   \
> > +               ct_idle_enter();                                        \
> >                 __ret = low_level_idle_enter(state);                    \
> > +               ct_idle_exit();                                         \
> >                 if (!is_retention)                                      \
> >                         cpu_pm_exit();                                  \
> >         }                                                               \
> >
>
> Kind regards
> Uffe
