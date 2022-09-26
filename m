Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965D15EB054
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 20:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiIZSmx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 14:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiIZSlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 14:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AC41982;
        Mon, 26 Sep 2022 11:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D516120E;
        Mon, 26 Sep 2022 18:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8346C433D7;
        Mon, 26 Sep 2022 18:40:49 +0000 (UTC)
Date:   Mon, 26 Sep 2022 14:41:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
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
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
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
        cl@linux.com, pmladek@suse.com, senozhatsky@chromium.org,
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
Subject: Re: [PATCH v2 33/44] ftrace: WARN on rcuidle
Message-ID: <20220926144157.0406dfbb@gandalf.local.home>
In-Reply-To: <20220919101522.573936213@infradead.org>
References: <20220919095939.761690562@infradead.org>
        <20220919101522.573936213@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Nit, the subject should have "tracing:" an not "ftrace:" as the former
encompasses the tracing infrastructure and the latter is for the function
hook part of that.

On Mon, 19 Sep 2022 12:00:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> CONFIG_GENERIC_ENTRY disallows any and all tracing when RCU isn't
> enabled.
> 
> XXX if s390 (the only other GENERIC_ENTRY user as of this writing)
> isn't comfortable with this, we could switch to
> HAVE_NOINSTR_VALIDATION which is x86_64 only atm.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/tracepoint.h |   13 ++++++++++++-
>  kernel/trace/trace.c       |    3 +++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -178,6 +178,16 @@ static inline struct tracepoint *tracepo
>  #endif /* CONFIG_HAVE_STATIC_CALL */
>  
>  /*
> + * CONFIG_GENERIC_ENTRY archs are expected to have sanitized entry and idle
> + * code that disallow any/all tracing/instrumentation when RCU isn't watching.
> + */
> +#ifdef CONFIG_GENERIC_ENTRY
> +#define RCUIDLE_COND(rcuidle)	(rcuidle)
> +#else

Should probably move the below comment to here:

 /* srcu can't be used from NMI */

> +#define RCUIDLE_COND(rcuidle)	(rcuidle && in_nmi())
> +#endif
> +
> +/*
>   * it_func[0] is never NULL because there is at least one element in the array
>   * when the array itself is non NULL.
>   */
> @@ -189,7 +199,8 @@ static inline struct tracepoint *tracepo
>  			return;						\
>  									\
>  		/* srcu can't be used from NMI */			\

And remove the above.

-- Steve

> -		WARN_ON_ONCE(rcuidle && in_nmi());			\
> +		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
> +			return;						\
>  									\
>  		/* keep srcu and sched-rcu usage consistent */		\
>  		preempt_disable_notrace();				\
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3104,6 +3104,9 @@ void __trace_stack(struct trace_array *t
>  		return;
>  	}
>  
> +	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_GENERIC_ENTRY)))
> +		return;
> +
>  	/*
>  	 * When an NMI triggers, RCU is enabled via ct_nmi_enter(),
>  	 * but if the above rcu_is_watching() failed, then the NMI
> 

