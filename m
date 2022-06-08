Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5870543E8D
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiFHVZ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiFHVZY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 17:25:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3F19799D;
        Wed,  8 Jun 2022 14:25:20 -0700 (PDT)
Received: from mail-yb1-f173.google.com ([209.85.219.173]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNc1T-1oNa4K0QrT-00P2e5; Wed, 08 Jun 2022 23:25:19 +0200
Received: by mail-yb1-f173.google.com with SMTP id s39so11077928ybi.0;
        Wed, 08 Jun 2022 14:25:16 -0700 (PDT)
X-Gm-Message-State: AOAM533ccHmRHAtjzIENuM22dhcJwyw6Hc9WOvf6/we8Lwl3909SSkO9
        yJ1qPPUY++2J0XerrodTaoB3zDcjNnsRmNA1OYw=
X-Google-Smtp-Source: ABdhPJzN5kbTwiXruPcKSpnmqojFIl1cGQUBuhNCCdRneCrpSwm0deMOGKvKLmavgOJ05DHkpAoCHNV4Fm5CQu/QOU4=
X-Received: by 2002:a0d:efc2:0:b0:2fe:d2b7:da8 with SMTP id
 y185-20020a0defc2000000b002fed2b70da8mr36982567ywe.42.1654705351589; Wed, 08
 Jun 2022 09:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144517.188449351@infradead.org>
In-Reply-To: <20220608144517.188449351@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jun 2022 18:22:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2y5+nrQFzhjrTTZe+d57Ug261J3kwLNe8Mu8i2qxtG2w@mail.gmail.com>
Message-ID: <CAK8P3a2y5+nrQFzhjrTTZe+d57Ug261J3kwLNe8Mu8i2qxtG2w@mail.gmail.com>
Subject: Re: [PATCH 20/36] arch/idle: Change arch_cpu_idle() IRQ behaviour
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Juergen Gross <jgross@suse.com>, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, Pv-drivers <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        gregkh <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        lpieralisi@kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        quic_neeraju@quicinc.com, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        vschneid@redhat.com, jpoimboe@kernel.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ULl6cVPERAdL9PyvM7zONDpiWVA4ZyVCOCwcYzHyZ73ntMV0dXB
 Qnmv/scTxLAGN5u/O+hL+EvSWO+2o8nUrHr2/SapIIJB48TQzNuq7Qo4YjkkFjKlpP+8WrN
 4s3kxn7SJ8r4HuxEedkCiCX/mZHBl+eq1ayzzhuhSO7yKbwkoJTbbR4YNjb9FqeLSzEM19Q
 Mc4EFUXFXKH6dwoj9trfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:grSfKAphyzs=:I2pHeW7GZh5+m3dVZkq2mK
 h1vxzn78vi6v74anukEMbJA1NmbhPJsQ61amenlQ+l0eulwQnAphYlpg9L/wLMXysg2mrtIGl
 Gp6gy8nUKSm98lf1bCp1OxghGzjwMcNPmNXf5rYaGmYlJ302EfJJIkdXy8WIyogSODZwIx/bz
 3f+Nsz1yJK25RbaEF/EZbTgAlScnruIzkAQVSYdXSD4p8hwt9yyxpxEdwpWFME0gZVyl0Madr
 CnUhu1DEnNYkWJFwfn7u8hClLiS4MEG6k3Ky2lXVWaR6SiADuD0pKXkSs2enFIUKnR+gYR0Wg
 dAGrhJOqTbTrQrgegZe1uqIvesGeKPhJompxYd4WbtuGF6eRQ34yEbu25ehPmNTRuz/E4/1qj
 bJUCwmofNaGObBLn+2Y9Hhm8AzONXvsj0IRq/m7qjUM1HW6+qOAZ6w07tpskpivABnTlBAoJR
 WGVCRozSSODlc+KobCiXeme9quMYCEj/FNJXz+OvOOk3tq2oFvCGV5W1Q8ARC9voBU+Xfy07W
 PIM4H4LdTHtBpF8FRkPrLY/V0M0nCbnMVyrgdDfMDJIt2aIL7LVsvK0v1GiSmU7WpSftyf7Bj
 9ITI5IZa5QnwqoB5fpLA2b3ZFrZyWarhYbocWot6ttZMKakPG8BWsAGlDPmiDLIMcJsMcbXaT
 /dy88hAw+iE4MJDule9bvMH3EWaEWM1eitRY4U1FocIBhFqhIs92e2Eb27yRQvF7HJ7vm9Cwk
 JAIdAD3nS81Vjs1JQiiVSKI3+N63yI7FxXR9SIi14rGMtCP8uYH1U/2a3Vjo0x54NTLCjRYe8
 +QzdDdWQFo6qvnBiB98ReMOXm3z+vjpl1jmW9gc9BS/K/v5869ib5kHyzx2wjbkj2SN04il97
 QjAJudU8GsAAsFtr5+6CJL724hA/0VuLfc4wXv+9Q=
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 8, 2022 at 4:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Current arch_cpu_idle() is called with IRQs disabled, but will return
> with IRQs enabled.
>
> However, the very first thing the generic code does after calling
> arch_cpu_idle() is raw_local_irq_disable(). This means that
> architectures that can idle with IRQs disabled end up doing a
> pointless 'enable-disable' dance.
>
> Therefore, push this IRQ disabling into the idle function, meaning
> that those architectures can avoid the pointless IRQ state flipping.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I think you now need to add the a raw_local_irq_disable(); in loongarch
as well.

       Arnd
