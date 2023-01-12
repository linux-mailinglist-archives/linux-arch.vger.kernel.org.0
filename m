Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE686680A2
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 21:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjALT7s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 14:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjALT7T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 14:59:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8932628;
        Thu, 12 Jan 2023 11:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uRuk42rt5J1sC1gDxlIXH9yiXjv0To5K12rtksbRl/w=; b=t/UiPYxuyWmQWx8O0dR9C23N3m
        Mql6RINO7N/qRFk28GXmIaup0931S2z3tF2gEI6MdQoOij/5MpyDJ93PUuH63HNR9QrPHDhJ1A8Oe
        r91ZkV6InpQFSdpdFg3os7aK02j12nsV24WSxmRJS0kKIVWjbMkU1+JaWypkF/gcgNI0Sb9wRM3lG
        Y69ujB959knJ2g9LZcv0UARehKAkTXfDsgP2i97QLaacDdXSmeuMauSIsBiYlC/jtcpwExNGPGi8i
        BrnpvX+u+TK0Yw2Bq1R5xaqa8UPNBlfJNWX8kZy4zpct/I/IMQgjZfiEDib73CDf0Fj9tlY/FPeci
        GndVoLoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pG3hh-005Ok6-0o; Thu, 12 Jan 2023 19:57:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0662A303469;
        Thu, 12 Jan 2023 20:57:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 520F42CD066C8; Thu, 12 Jan 2023 20:57:08 +0100 (CET)
Message-ID: <20230112195541.844982902@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 20:43:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, shawnguo@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com,
        khilman@kernel.org, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org,
        guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net,
        monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, atishp@atishpatra.org,
        Arnd Bergmann <arnd@arndb.de>, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        rostedt@goodmis.org, mhiramat@kernel.org, frederic@kernel.org,
        paulmck@kernel.org, pmladek@suse.com, senozhatsky@chromium.org,
        john.ogness@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com,
        Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 41/51] cpuidle,clk: Remove trace_.*_rcuidle()
References: <20230112194314.845371875@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

OMAP was the one and only user.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/clk.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -978,12 +978,12 @@ static void clk_core_disable(struct clk_
 	if (--core->enable_count > 0)
 		return;
 
-	trace_clk_disable_rcuidle(core);
+	trace_clk_disable(core);
 
 	if (core->ops->disable)
 		core->ops->disable(core->hw);
 
-	trace_clk_disable_complete_rcuidle(core);
+	trace_clk_disable_complete(core);
 
 	clk_core_disable(core->parent);
 }
@@ -1037,12 +1037,12 @@ static int clk_core_enable(struct clk_co
 		if (ret)
 			return ret;
 
-		trace_clk_enable_rcuidle(core);
+		trace_clk_enable(core);
 
 		if (core->ops->enable)
 			ret = core->ops->enable(core->hw);
 
-		trace_clk_enable_complete_rcuidle(core);
+		trace_clk_enable_complete(core);
 
 		if (ret) {
 			clk_core_disable(core->parent);


