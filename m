Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50654B68C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiFNQos (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiFNQoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 12:44:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA35919037;
        Tue, 14 Jun 2022 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=lGPDnVOvpW5cJYkNK5aiO+HQt8YloxSeZZcAt0L3T+0=; b=MN0E+GuQLLm4tM+GK8hWccQUFL
        PxmHsP4/A97SKIR0+ews6BPbY8JdimA4zzl8B8x1wTlPZj26+HyDjOVxj1Wvti7DkxrdahnIWXznf
        Sck8K5ryGTb2H97Q25XV5ua07NtZrt8RBovpr0tuOchGW9iLxyJb1i6ZL47+Eas56Gb5nEQiTe9bW
        l/5aGjKZFL1yA3gACFUDFeCqx4zcJMLiRKrPP5Wx+chh5o0sU6RQZsB3HldVraUQWhIlzWIv4ONvZ
        B8VU2ERHT/yK/yX47pqt+Uyn9a6PeiG9bFg6pm7fHV4nB44DfSKBjrV02VjqvtliTo2mpR5esSTG4
        vZhkhfdg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o19eA-000KXf-9W; Tue, 14 Jun 2022 16:44:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEA18300372;
        Tue, 14 Jun 2022 18:44:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1F7228B3F630; Tue, 14 Jun 2022 18:44:02 +0200 (CEST)
Date:   Tue, 14 Jun 2022 18:44:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sammy@sammy.net" <sammy@sammy.net>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rth@twiddle.net" <rth@twiddle.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        Will Deacon <will@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>, Mel Gorman <mgorman@suse.de>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "ulli.kroll@googlemail.com" <ulli.kroll@googlemail.com>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "bcain@quicinc.com" <bcain@quicinc.com>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dalias@libc.org" <dalias@libc.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "richard@nod.at" <richard@nod.at>, X86 ML <x86@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "stefan.kristiansson@saunalahti.fi" 
        <stefan.kristiansson@saunalahti.fi>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Pv-drivers] [PATCH 29/36] cpuidle,        xenpv: Make more
 PARAVIRT_XXL noinstr clean
Message-ID: <Yqi60lnN6MQpysBw@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.759631860@infradead.org>
 <510b9b68-7d53-7d4d-5a05-37fbd199eb4b@csail.mit.edu>
 <BAE566A0-AEA3-493E-8AC5-912C795BF1DE@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAE566A0-AEA3-493E-8AC5-912C795BF1DE@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 13, 2022 at 07:23:13PM +0000, Nadav Amit wrote:
> On Jun 13, 2022, at 11:48 AM, Srivatsa S. Bhat <srivatsa@csail.mit.edu> wrote:
> 
> > ⚠ External Email
> > 
> > On 6/8/22 4:27 PM, Peter Zijlstra wrote:
> >> vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0xde: call to wbinvd() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: default_idle+0x4: call to arch_safe_halt() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: xen_safe_halt+0xa: call to HYPERVISOR_sched_op.constprop.0() leaves .noinstr.text section
> >> 
> >> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> > 
> >> 
> >> -static inline void wbinvd(void)
> >> +extern noinstr void pv_native_wbinvd(void);
> >> +
> >> +static __always_inline void wbinvd(void)
> >> {
> >>      PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
> >> }
> 
> I guess it is yet another instance of wrong accounting of GCC for
> the assembly blocks’ weight. I guess it is not a solution for older
> GCCs, but presumably ____PVOP_ALT_CALL() and friends should have
> used asm_inline or some new “asm_volatile_inline” variant.

Partially, some of the *SAN options also generate a metric ton of
nonsense when enabled and skew the compilers towards not inlining
things.
