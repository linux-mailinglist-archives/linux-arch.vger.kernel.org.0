Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F215F4170
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJDLF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 07:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJDLFj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 07:05:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE3919289
        for <linux-arch@vger.kernel.org>; Tue,  4 Oct 2022 04:05:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 70so12571458pjo.4
        for <linux-arch@vger.kernel.org>; Tue, 04 Oct 2022 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8dOAtcXqtbDTbOtGHdeMRx2lSxGZ/p81xoeulWg88O8=;
        b=ALPYtY9NECpkdz09jpHMZbs0aH+hKiq7zCwXfK1hWKvM2elz9mNR/JJb0byGfir59h
         CWc9izoQX0glvUd9bdjzB+GxZIKg7cZ1wWKnb5xSlDD9fDdUtUduD7qTiOAX8rgJzNMY
         16i4fnybYgh61uFsRfFa0jFHaMm217pAorBQUItONSq5D0pjQfmpgEbFEG0ovD83XmiY
         JRBnUwctQs5MU4QsxdCrYJ2mV5ubOvxFCDZOs+xf+eBgsrQVN1CIV6SHGqFX6RFQbzq7
         D2ARCpgG/orA8SpRSFPIMnoc2IRLOYljdFwc8QX3tXFa2vpA/P7Kkd/ZsaWnXMh+ArFb
         1Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8dOAtcXqtbDTbOtGHdeMRx2lSxGZ/p81xoeulWg88O8=;
        b=IbBOEGUxRKIpYe1EfLsx7lJjbPXp2oIYI7BwZ6Y8jvwY+wzezfpwtXwAn/7uGa4z+a
         ogpcf27odGC1EosjlowULJbMblivZSqe4y7xYArx9zUBXWwyJKF/SSfXSZhfVO/btEKX
         +z3eAkBbvpxX0WMmkp5YpVMACANB6Y9f2IhugxssE6LqyhspPWmymtoNoKSgsItXK4s+
         mzvB7kMA1ekzd4nn6tmqiNzlkP00ciRwnqAkDEDbjzE71nA02x508pBpvKfofjUhZVCj
         hjkjbyoeA1x/yBBdVrIF4ZtaDLotKyMf0FAp3kRH54hHYeRmKeN8XK8U01qNCkTbC17g
         68cw==
X-Gm-Message-State: ACrzQf1g3UlELsj6C63FojyLOQb+/vpav/O7qescRVeqzBu54+6Xq26Z
        8JOcL5IMNcEkopoCLYM8iNF9A9LhN/RRW2IQFjoFPA==
X-Google-Smtp-Source: AMsMyM4crcx6LouSmUkordoRMp2FZSPTtuc3An5Wuzy+BH6M/IICg47GwaPPyycgbJ/QSQxkTeG6xy+CkgFRgaEAD/g=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr17203785pjb.164.1664881533975; Tue, 04
 Oct 2022 04:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org> <20220919101521.274051658@infradead.org>
In-Reply-To: <20220919101521.274051658@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Oct 2022 13:04:57 +0200
Message-ID: <CAPDyKFquBVkYmKsriPD+BfVrrz62ih7oCxb7HwOML+Zzs-5U_Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/44] cpuidle,cpu_pm: Remove RCU fiddling from cpu_pm_{enter,exit}()
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

On Mon, 19 Sept 2022 at 12:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> All callers should still have RCU enabled.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  kernel/cpu_pm.c |    9 ---------
>  1 file changed, 9 deletions(-)
>
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -30,16 +30,9 @@ static int cpu_pm_notify(enum cpu_pm_eve
>  {
>         int ret;
>
> -       /*
> -        * This introduces a RCU read critical section, which could be
> -        * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
> -        * this.
> -        */
> -       ct_irq_enter_irqson();
>         rcu_read_lock();
>         ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
>         rcu_read_unlock();
> -       ct_irq_exit_irqson();
>
>         return notifier_to_errno(ret);
>  }
> @@ -49,11 +42,9 @@ static int cpu_pm_notify_robust(enum cpu
>         unsigned long flags;
>         int ret;
>
> -       ct_irq_enter_irqson();
>         raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
>         ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
>         raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
> -       ct_irq_exit_irqson();
>
>         return notifier_to_errno(ret);
>  }
>
>
