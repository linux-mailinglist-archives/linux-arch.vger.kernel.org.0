Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031765BCB37
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiISL4J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 07:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiISLzr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 07:55:47 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335F763A3
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2022 04:54:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id g6so2223706ild.6
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2022 04:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gUsv6szv6dsUeM9asVJnwaGmSGG17UchvxqwxLA3h8g=;
        b=6l84clV/ev4Ho0Nth4fVfA2YCUlnkvOSgxbqusFUXjXpfQuFFf0cscM9H6JstjQMUy
         xw7M8POcVaD8G3v3xGng54KrmjSgvwQL7sqhL179TVnFSdqvL9DEfhAXmZU08DpaVB+z
         zSiunmo3VbmTof1vxAp/v47yQ2WgOGXeXG6GB3Gf7pE1ScGjC0bqV7TAtd/m+fpfq3CI
         YOLPMuA/GgjNIfHOrOGhD0cM6H3P5LBBOn3aCDWtNVZfJPWoGE1cWKKtEz9Dpfs/6i2d
         YxcNqnYUQtbiNuONYqqIai1SFElgvUv464Vcz0iTXK3yncl0+rss3soTmcg3IhW6Gf/K
         H/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gUsv6szv6dsUeM9asVJnwaGmSGG17UchvxqwxLA3h8g=;
        b=IVlAj+uqw9OruhyGobw64AWzn9YnbH9U2J5w3OkCFhoW/GEET+j3b4SSCxf2miUhJK
         EA4LxOCfhgQkzhhD6mKp+GvMDKAippaCAJxccETQOcaLwgnDg8aPbwU+sjqY1uO0i8bw
         aANHb4li/oDuJf95xpVCwhjgiSlPNcqS8q/z6pj01qVwMD8yDbsD9Oc1VW82jH+19UlZ
         Y443DKVGgLY3wqoV0mHkXTzxcsZFnjcjw0QngiO61+vhusf+QHRUCziqlH8Nyh3fke8K
         MAcF1pV+LcSehpJSfs56A9xOjw4dKLettI8E4Xrkuzn20iM7kbof6Eow6nAF4jZscvTt
         TdeQ==
X-Gm-Message-State: ACrzQf34vXuJTtVB9Bp0CwpKT3vjfIZQD5iVeOQD8x+nQOT0A5Jfisr4
        bw6t5r87c0W3Bv0Uf455ikHPnnzFR2vhTbdJpRzLPg==
X-Google-Smtp-Source: AMsMyM5SaQPoV1xlIMZRfmPqKRzR7kAhfhGoUGwZ5KM3JobcN8dh6yNRCyMvHHbKVsfAJAruxygcE1W13IXNCB18i9o=
X-Received: by 2002:a92:c04d:0:b0:2f5:1175:c7a3 with SMTP id
 o13-20020a92c04d000000b002f51175c7a3mr5681407ilf.165.1663588472670; Mon, 19
 Sep 2022 04:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org> <20220919101520.669962810@infradead.org>
In-Reply-To: <20220919101520.669962810@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 19 Sep 2022 17:24:19 +0530
Message-ID: <CAAhSdy004HaNUNYRD8tcn24LZWdTmOVkF1QN14uLmSw1UXuXqA@mail.gmail.com>
Subject: Re: [PATCH v2 05/44] cpuidle,riscv: Push RCU-idle into driver
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
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, atishp@atishpatra.org,
        Arnd Bergmann <arnd@arndb.de>, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        rostedt@goodmis.org, pmladek@suse.com, senozhatsky@chromium.org,
        john.ogness@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, fweisbec@gmail.com, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 19, 2022 at 3:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Doing RCU-idle outside the driver, only to then temporarily enable it
> again, at least twice, before going idle is daft.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me.

For RISC-V cpuidle:
Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -116,12 +116,12 @@ static int __sbi_enter_domain_idle_state
>                 return -1;
>
>         /* Do runtime PM to manage a hierarchical CPU toplogy. */
> -       ct_irq_enter_irqson();
>         if (s2idle)
>                 dev_pm_genpd_suspend(pd_dev);
>         else
>                 pm_runtime_put_sync_suspend(pd_dev);
> -       ct_irq_exit_irqson();
> +
> +       ct_idle_enter();
>
>         if (sbi_is_domain_state_available())
>                 state = sbi_get_domain_state();
> @@ -130,12 +130,12 @@ static int __sbi_enter_domain_idle_state
>
>         ret = sbi_suspend(state) ? -1 : idx;
>
> -       ct_irq_enter_irqson();
> +       ct_idle_exit();
> +
>         if (s2idle)
>                 dev_pm_genpd_resume(pd_dev);
>         else
>                 pm_runtime_get_sync(pd_dev);
> -       ct_irq_exit_irqson();
>
>         cpu_pm_exit();
>
> @@ -246,6 +246,7 @@ static int sbi_dt_cpu_init_topology(stru
>          * of a shared state for the domain, assumes the domain states are all
>          * deeper states.
>          */
> +       drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
>         drv->states[state_count - 1].enter = sbi_enter_domain_idle_state;
>         drv->states[state_count - 1].enter_s2idle =
>                                         sbi_enter_s2idle_domain_idle_state;
>
>
