Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45545436CF
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiFHPN5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbiFHPMV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 11:12:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD82A276;
        Wed,  8 Jun 2022 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ukp02Ivtbnt/qfD+Hr8nM4W5X9OZTZ1VV5qELeaRbZ8=; b=FdbZDiHXxrw9R5zBFDpdZ4bCmw
        5EqLEtrQA4GAVtuQ4l7BXUjKrV0kbnuMXyTU0mKTl97PPyywe9dKH6V1TaR7+s04jt3vgRI5mst7b
        MvEdRR4E7DMNS+4fdoyozYSMS3CHHYGRsbjSFC/FX969Mb3h5fENFOU77m6PPad0SmQklQKh0IO7h
        IYy8ICeQDWkRRib9aqgM2U3yBaV/wh14vGpv4jtvEIXl8fZxQ7fVbucEOetEIOGb+PV/8PBB6Vpkx
        USv7ghtiy/ArNAWwKGQZiEeZRhk2g1lrtCnBLBi4x8H1pqA+N9vGsS/o8HP+yXb0C4r8mRSmFSQx5
        Ih95USug==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxEj-0067hZ-CL; Wed, 08 Jun 2022 15:04:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25903301BEC;
        Wed,  8 Jun 2022 17:04:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 089E520C0B5D8; Wed,  8 Jun 2022 17:04:41 +0200 (CEST)
Date:   Wed, 8 Jun 2022 17:04:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
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
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
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
Subject: Re: [PATCH 34/36] cpuidle,omap3: Push RCU-idle into omap_sram_idle()
Message-ID: <YqC6iJx4ygSmry0G@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.073801916@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608144518.073801916@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 08, 2022 at 04:27:57PM +0200, Peter Zijlstra wrote:
> @@ -254,11 +255,18 @@ void omap_sram_idle(void)
>  	 */
>  	if (save_state)
>  		omap34xx_save_context(omap3_arm_context);
> +
> +	if (rcuidle)
> +		cpuidle_rcu_enter();
> +
>  	if (save_state == 1 || save_state == 3)
>  		cpu_suspend(save_state, omap34xx_do_sram_idle);
>  	else
>  		omap34xx_do_sram_idle(save_state);
>  
> +	if (rcuidle)
> +		rcuidle_rcu_exit();

*sigh* so much for this having been exposed to the robots for >2 days :/
