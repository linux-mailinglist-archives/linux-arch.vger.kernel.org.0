Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81D7543B6A
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 20:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiFHSWe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiFHSWc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 14:22:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F2527D6;
        Wed,  8 Jun 2022 11:22:28 -0700 (PDT)
Received: from mail-ot1-f45.google.com ([209.85.210.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MBDWo-1nu1Aj0jpW-00Cl9L; Wed, 08 Jun 2022 20:22:27 +0200
Received: by mail-ot1-f45.google.com with SMTP id h15-20020a9d600f000000b0060c02d737ecso5325214otj.1;
        Wed, 08 Jun 2022 11:22:24 -0700 (PDT)
X-Gm-Message-State: AOAM530s+8fiOlM+i9vE1dNfx4Y17sS04XwwMs2CnmG4HRYgD36isAZk
        0D3RFZgRb20DbfrU9Et6+2gq3VSbgjIfVUWmwNc=
X-Google-Smtp-Source: ABdhPJzNVjvOg+I4TKoqtI9Mj5r7eGnKl4yZEYVHLzTr22uimte8bgKc1nTgREfDsecVqzQDeuxH8v8jGezndj85u8s=
X-Received: by 2002:a25:e64b:0:b0:663:ffad:eac5 with SMTP id
 d72-20020a25e64b000000b00663ffadeac5mr3789690ybh.550.1654705730388; Wed, 08
 Jun 2022 09:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144518.010587032@infradead.org>
In-Reply-To: <20220608144518.010587032@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jun 2022 18:28:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
Message-ID: <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
Subject: Re: [PATCH 33/36] cpuidle,omap3: Use WFI for omap3_pm_idle()
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
X-Provags-ID: V03:K1:i13j6eoMFgPYw3MZijIlP+qsFdvpj6/skYv1EqsVW2MmaUt+4Gs
 TKbWFeC1OzuDFS2sWqGbpOsgmluCHecsmMhvkDcgDwZS7kTjkmCj52WVEg2IIi3r6+pRG+z
 rzU45Su9pBqdNiYGOn02kRSdYKHiXsPEK9v/SLC483IzBlr4JkNRrD5CpMvQol8uZlyYl3Z
 OrAoelai5SvzI6Si/N0ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qIZsoC3MLcE=:Fi7WALlfM393s9u3Q7GGEB
 U6nTQb9ZAacqVnVQIr5fu17PUS75NyrNwLU5KpsjdOVVfBfc8uArE2cxpw6c12hFBhX3dhwkf
 KDI5vh18Ywps+uzJdfZKSopuaSVtmt2s2HQdvEeWBprr7+EduCNhV80K0DwtYoA49ORgWusIu
 ujW9tDYBNpG67UDpVkgfsc3ttzz5uc3Xy0sibuPOAykcL0B5AWSqXzIwKWSXIqirRpqArM7E7
 bETP35dIOFK763UjdjbSoFLhR5SrzIR4UeUXf187+Wme9F6W+Rws6rNL6LzGBawb+ySvCswKZ
 MxFrfJOrtU1Y5BUpQdQwOfjb/PHv7vpbVgz8Zs+GoV4WIFtnKElc+cEITWimsy5PM7hafJWRo
 ROjdn03L8PdlPiYR9lYz+00O41lyVziINRWp9+rSC+t4izpUJoNiNs0csm+SKXzPwneljD4LH
 uN2dnzR6p74/xizBeD1YT9+hM1UpmUSukws+7Hc45MYcWX96x+MXAVQK4wsQ8GmEpkQ08x70j
 iyJax4TAxM9P+mlFEmgRAjGLAWq444DkLCUNHxPk1wT02l4SRMMmmrrxGvs4qkmfIwcIDZQAp
 e6a0iHSNYKFinZ4hANQsKZuj2y9VHGeV5PmMb5EJByFVPq4TYP7YGcz8UWZWLc+iLwAnwSXbm
 cIFx/XBMVAvoiqowG3xdiyI2k8M8LX0MoMQEU3oc9WC1G+QLWHhb7arsG7/2d6TPKSWodGwqw
 yUuV/IiHJ5ckO0YgIEJv8/5UNepD5mZVAQB/gNkY4V3xVnKHQxig1e/FYsA9nPjODiwDrYbYU
 XnTtm1tjRQolVfjeUVdYRd2R1w/Sd0wxx8M1JP3fM/zYO5/ypsmHXlRItKsXyOD5klxJBLwRm
 prbqkXHR/m6SdehHj67w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 8, 2022 at 4:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> arch_cpu_idle() is a very simple idle interface and exposes only a
> single idle state and is expected to not require RCU and not do any
> tracing/instrumentation.
>
> As such, omap_sram_idle() is not a valid implementation. Replace it
> with the simple (shallow) omap3_do_wfi() call. Leaving the more
> complicated idle states for the cpuidle driver.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I see similar code in omap2:

omap2_pm_idle()
 -> omap2_enter_full_retention()
     -> omap2_sram_suspend()

Is that code path safe to use without RCU or does it need a similar change?

        Arnd
