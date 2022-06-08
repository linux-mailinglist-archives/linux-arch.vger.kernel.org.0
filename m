Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAEF543563
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbiFHOvI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242096AbiFHOqz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 10:46:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B162318FA70;
        Wed,  8 Jun 2022 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+nBTmu8be4dn87X4h4i4v5hXqWi/FDQJ2e0V2G49JnI=; b=c0sBpB4EJtpUlMJmM1BtzQg1jI
        4PcdDgJzYOowDoMnmKAFYhNbpvRYzsV7kRFyLJf62+ZuPqPEFAxeBvm38jC9EIzinrmdPRpzRnIth
        ZjcGrFN3FC2OLDiPw1MQ9GiO/ueu64sxGeUIVMfNNGZ1I6IAzUSGlYS50yZYH/qpVkumUW9sz9ylw
        NiQ4O2XB8H8Hk/RXSmU/7i/042dpY1RsaqJxDbzJ3hgd+h+vW2daHvNujHxeLDb2O3c/EAvt6fmpH
        /CT3Hd5fJEQuF8uryywQG23Lx98/8viggcr1njgwvu2L7IHYIVv/w/rdZa7aTRE+XIf9ro7DYS6a3
        okJs1Mxg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nywx2-00ChXN-TW; Wed, 08 Jun 2022 14:46:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4C2B302F11;
        Wed,  8 Jun 2022 16:46:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9DB8020C10EDE; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608144517.507286638@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Jun 2022 16:27:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org, linux@armlinux.org.uk,
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
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
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
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH 25/36] time/tick-broadcast: Remove RCU_NONIDLE usage
References: <20220608142723.103523089@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No callers left that have already disabled RCU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/tick-broadcast-hrtimer.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -56,25 +56,20 @@ static int bc_set_next(ktime_t expires,
 	 * hrtimer callback function is currently running, then
 	 * hrtimer_start() cannot move it and the timer stays on the CPU on
 	 * which it is assigned at the moment.
+	 */
+	hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
+	/*
+	 * The core tick broadcast mode expects bc->bound_on to be set
+	 * correctly to prevent a CPU which has the broadcast hrtimer
+	 * armed from going deep idle.
 	 *
-	 * As this can be called from idle code, the hrtimer_start()
-	 * invocation has to be wrapped with RCU_NONIDLE() as
-	 * hrtimer_start() can call into tracing.
+	 * As tick_broadcast_lock is held, nothing can change the cpu
+	 * base which was just established in hrtimer_start() above. So
+	 * the below access is safe even without holding the hrtimer
+	 * base lock.
 	 */
-	RCU_NONIDLE( {
-		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
-		/*
-		 * The core tick broadcast mode expects bc->bound_on to be set
-		 * correctly to prevent a CPU which has the broadcast hrtimer
-		 * armed from going deep idle.
-		 *
-		 * As tick_broadcast_lock is held, nothing can change the cpu
-		 * base which was just established in hrtimer_start() above. So
-		 * the below access is safe even without holding the hrtimer
-		 * base lock.
-		 */
-		bc->bound_on = bctimer.base->cpu_base->cpu;
-	} );
+	bc->bound_on = bctimer.base->cpu_base->cpu;
+
 	return 0;
 }
 


