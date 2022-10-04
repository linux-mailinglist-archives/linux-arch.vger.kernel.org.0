Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C55F4179
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJDLIr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJDLIk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 07:08:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C35853D09
        for <linux-arch@vger.kernel.org>; Tue,  4 Oct 2022 04:08:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so1525356pjs.0
        for <linux-arch@vger.kernel.org>; Tue, 04 Oct 2022 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Gtwwkxm3K9zy3ub+GhlddjjtZ7fh91sG2Y46OOYgmCM=;
        b=EnhlO7DcICPKJpPG1jb7KTMLBU7DAMNWLzZM/l8aLFUsRZkWp+mkSVMMBmLZ1zgxaC
         wxY3CYIRcHyRXss5NtxD4hq5yFum2Xsa/Xfa8NFMZbQ3tgmqUq13E1Fcil8BIgM2OEw6
         m+P6TSNsaCcBVdUXpgo0TEJ7VOVGVt6KKPFMuMhn/bj0r2dm5zCuaEvX7UiZOqeeJEdX
         h1wGhs9cmKjNMVwi5bkackIBv98JM8+NjLMoMPaPS3klw1yQNu9dahurEQIN+cDnqkmM
         Hbcu0L1M6U3Rd654P0n2Hh4Q6bzGWuS7xOAcwB9SuDvPVBJ1Tctv5MAKRuD35o1eodHl
         dgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Gtwwkxm3K9zy3ub+GhlddjjtZ7fh91sG2Y46OOYgmCM=;
        b=OXQlb31m8xpLW+Iamlcp9qpAl8YWZnN1RTphpiiv0lbGmNR7vlaBZuxfhY0ee5zxCV
         bawqSh9dcz/ad6903y5D9ijH2P/totVlbE8WCEB4IidFvLBGrXy7/3mTMVWQXHWkJNow
         Pb8SkC2F+AEMawRYkq8MymiTa9RVmy0OvsV3PS707yIL4UThQRUuqtH21gK4PYgwFCtX
         vBK97+glaJciNMFJwwHqeo/yq9U5QmoXOKa1GnYn6Xf1hVnD9bWZVuh5+o4cOPO74isi
         ex80nIkpk2nzJLfQYt1KMyiFoIM3kQjT1w8MUki1LPAlDRwCSGXDgupNqVQ8TCFTCa4i
         4wkQ==
X-Gm-Message-State: ACrzQf2NeqKZnzkWbueHKGadzWwxkOKrHM4n63B4RAGZxeevZid4wNDq
        RfgSuTgAAcm1hA9hBTlV+5ub71YAJ4rDUFOJ68/ZAQ==
X-Google-Smtp-Source: AMsMyM6cCdnxuhXSy92rYBN/YepwF/hndLawv3zc1vUJoDTHY6JL7u1f8y1gp2OsfAUCoRgnjKuog3OS/wqaN/v/F3w=
X-Received: by 2002:a17:90b:1b06:b0:202:cce0:2148 with SMTP id
 nu6-20020a17090b1b0600b00202cce02148mr17035330pjb.84.1664881717434; Tue, 04
 Oct 2022 04:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org> <20220919101521.886766952@infradead.org>
In-Reply-To: <20220919101521.886766952@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Oct 2022 13:08:00 +0200
Message-ID: <CAPDyKFoMidikoTPe0Xd+wZQdBBJSoy+CZ2ZmJShfLkbGZZRYDQ@mail.gmail.com>
Subject: Re: [PATCH v2 23/44] arm,smp: Remove trace_.*_rcuidle() usage
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

On Mon, 19 Sept 2022 at 12:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> None of these functions should ever be ran with RCU disabled anymore.
>
> Specifically, do_handle_IPI() is only called from handle_IPI() which
> explicitly does irq_enter()/irq_exit() which ensures RCU is watching.
>
> The problem with smp_cross_call() was, per commit 7c64cc0531fa ("arm: Use
> _rcuidle for smp_cross_call() tracepoints"), that
> cpuidle_enter_state_coupled() already had RCU disabled, but that's
> long been fixed by commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
> deeper into the idle path").
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/kernel/smp.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -639,7 +639,7 @@ static void do_handle_IPI(int ipinr)
>         unsigned int cpu = smp_processor_id();
>
>         if ((unsigned)ipinr < NR_IPI)
> -               trace_ipi_entry_rcuidle(ipi_types[ipinr]);
> +               trace_ipi_entry(ipi_types[ipinr]);
>
>         switch (ipinr) {
>         case IPI_WAKEUP:
> @@ -686,7 +686,7 @@ static void do_handle_IPI(int ipinr)
>         }
>
>         if ((unsigned)ipinr < NR_IPI)
> -               trace_ipi_exit_rcuidle(ipi_types[ipinr]);
> +               trace_ipi_exit(ipi_types[ipinr]);
>  }
>
>  /* Legacy version, should go away once all irqchips have been converted */
> @@ -709,7 +709,7 @@ static irqreturn_t ipi_handler(int irq,
>
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  {
> -       trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
> +       trace_ipi_raise(target, ipi_types[ipinr]);
>         __ipi_send_mask(ipi_desc[ipinr], target);
>  }
>
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
