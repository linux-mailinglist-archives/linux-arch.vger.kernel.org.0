Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467676DD5E9
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDKIu2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Apr 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDKIu1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 04:50:27 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C1101;
        Tue, 11 Apr 2023 01:50:26 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-54c061acbc9so285360717b3.11;
        Tue, 11 Apr 2023 01:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XsMmfYvpqHWFGERwzpiHyCVbGoq54hxk7fbEhr0Ujk=;
        b=gfAYPExta6MleGPD+nd+rTxmcmy4Bc6Bn/RSsPM/cfsFpurvTZiYmmuTKJImLgstl3
         AJYXN4jZOMkXuxnCUrG04dri5sCt5amnERkJoWuk9salhzD+NkWJBfRTI/3UPPHhgU0K
         b2YNHzFKhlr67ESquawigRjAwv3GZWPy9IIaYm5ONcn8QxheL/GqB/grIItNa3syIw2n
         TRU8Zf4ZkW/P7A2bdIMiqX59ufEmWwBx9CKefseXNF99qgpAWuz0bUm7/bR6YWkVgiTS
         us2gRobn68Maeqfcp5oX0AGkuo/rzWC9E2Kqol/i1kxlL+kpSb0YTCEpv/6s58MwEMh4
         P1gA==
X-Gm-Message-State: AAQBX9di4HuniKI6CcYAHipFof6dhMa+imwmTJWbmfCcfZpiBMxTX/M1
        GRE9VYAE5DC4PLPlgyw9UTyhPfWBr5gQ5Q==
X-Google-Smtp-Source: AKy350ZmUM+9oPC28qYyEH5g/lMjw167mxKQhqA3h1nHhbJcwY8e3Nn1gzDvvKnRfUHfC890wEXFvQ==
X-Received: by 2002:a0d:e894:0:b0:54f:6f2d:8d9b with SMTP id r142-20020a0de894000000b0054f6f2d8d9bmr1386726ywe.18.1681203025424;
        Tue, 11 Apr 2023 01:50:25 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id k16-20020a81ff10000000b0054651519898sm3363403ywn.59.2023.04.11.01.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:50:25 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-54c12009c30so252705247b3.9;
        Tue, 11 Apr 2023 01:50:25 -0700 (PDT)
X-Received: by 2002:a81:bc08:0:b0:54e:e490:d190 with SMTP id
 a8-20020a81bc08000000b0054ee490d190mr1268334ywi.4.1681203004780; Tue, 11 Apr
 2023 01:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230323163354.1454196-1-schnelle@linux.ibm.com>
 <248a41a536d5a3c9e81e8e865b34c5bf74cd36d4.camel@linux.ibm.com>
 <B1EC1AC7-6BB5-4B66-B171-24687C3CBFB3@zytor.com> <d8686aaf-f12e-446b-9a80-335bb4266a4d@app.fastmail.com>
 <ccff565cde1440b8bff92d96f94a32b5@AcuMS.aculab.com>
In-Reply-To: <ccff565cde1440b8bff92d96f94a32b5@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Apr 2023 10:49:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe+U3yOOfy+z19apZaT0q7WhrR2beR=t0Jkbd3ODYbyw@mail.gmail.com>
Message-ID: <CAMuHMdWe+U3yOOfy+z19apZaT0q7WhrR2beR=t0Jkbd3ODYbyw@mail.gmail.com>
Subject: Re: [PATCH v4] Kconfig: introduce HAS_IOPORT option and select it as necessary
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.osdn.me>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi David,

On Wed, Apr 5, 2023 at 11:37 PM David Laight <David.Laight@aculab.com> wrote:
> From: Linuxppc-dev Arnd Bergmann
> > Sent: 05 April 2023 21:32
> >
> > On Wed, Apr 5, 2023, at 22:00, H. Peter Anvin wrote:
> > > On April 5, 2023 8:12:38 AM PDT, Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > >>On Thu, 2023-03-23 at 17:33 +0100, Niklas Schnelle wrote:
> > >>> We introduce a new HAS_IOPORT Kconfig option to indicate support for I/O
> > >>> Port access. In a future patch HAS_IOPORT=n will disable compilation of
> > >>> the I/O accessor functions inb()/outb() and friends on architectures
> > >>> which can not meaningfully support legacy I/O spaces such as s390.
> > >>> >>
> > >>Gentle ping. As far as I can tell this hasn't been picked to any tree
> > >>sp far but also hasn't seen complains so I'm wondering if I should send
> > >>a new version of the combined series of this patch plus the added
> > >>HAS_IOPORT dependencies per subsystem or wait until this is picked up.
> > >
> > > You need this on a system supporting not just ISA but also PCI.
> > >
> > > Typically on non-x86 architectures this is simply mapped into a memory window.
> >
> > I'm pretty confident that the list is correct here, as the HAS_IOPORT
> > symbol is enabled exactly for the architectures that have a way to
> > map the I/O space. PCIe generally works fine without I/O space, the
> > only exception are drivers for devices that were around as early PCI.
>
> Isn't there a difference between cpu that have inb()/outb() (probably
> only x86?) and architectures (well computer designs) that can generate
> PCI 'I/O' cycles by some means.
> It isn't even just PCI I/O cycles, I've used an ARM cpu (SA1100)
> that mapped a chuck of physical address space onto PCMCIA I/O cycles.
>
> If the hardware can map a PCI 'IO' bar into normal kernel address
> space then the bar and accesses can be treated exactly like a memory bar.
> This probably leaves x86 as the outlier where you need (IIRC) io_readl()
> and friends that can generate in/out instructions for those accesses.
>
> There are also all the x86 ISA devices which need in/out instructions.
> But (with the likely exception of the UART) they are pretty much
> platform specific.
>
> So, to my mind at least, HAS_IOPORT is just the wrong question.

Not all PCI controllers support mapping the I/O bar in MMIO space, so
in general you cannot say that CONFIG_PCI=y means CONFIG_HAS_IOPORT=y.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
