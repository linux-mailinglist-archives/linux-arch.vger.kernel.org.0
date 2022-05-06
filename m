Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8687551DB59
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 17:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442565AbiEFPGF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbiEFPGE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 11:06:04 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA313396B6;
        Fri,  6 May 2022 08:02:20 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id js14so5584893qvb.12;
        Fri, 06 May 2022 08:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T95DKyI860o0Ni6h4dJD+E7diEEpmm2y8EkaKK0YMZc=;
        b=LIEt+Hj0vorrPId2XXAkIzYrafDHh4aGVFsTJERz19t6ZBEGg4QqxOeWZIiZm1IzdA
         TP9/Gzt6OcBeCGJrc5ptrAoRAptT87/ed4fEOYP5rjMkxZ08BRCzZdUivGPaflqOrxid
         UdUX9guNF636lqAAqf2X6uu7i5yfhqe2peiWMfrHN17BblyZntp85mXqSYolGtsOeahP
         Bqhw8nXJb6yqqbGYgDVz49P6My1uYqB1fumdV7cjG5TbC6cor52Dz28WyGQi30JeLABb
         BwvMlRhRT0caLQGmbZHgEmqY572uMTBhKKCF09qxgDuhQCaEESY+w7YTVJqhTkeqT76H
         ghGQ==
X-Gm-Message-State: AOAM532tB31TEiA294rcJNQ3ykT0zHFdc8p261lVpD/VsfCDQiBtEcEQ
        J6moxrX2XxBrpszDFBVA1FtpGT0qW2d+VQ==
X-Google-Smtp-Source: ABdhPJynUG3F533fte8dV60hdIv+ozcQx1diqhjWoKACMR0xOo9dFfthI5Vt9H+fq9TJ1Fj5nJKqwQ==
X-Received: by 2002:a05:6214:29c1:b0:45a:e0e5:7b2b with SMTP id gh1-20020a05621429c100b0045ae0e57b2bmr2778900qvb.44.1651849339531;
        Fri, 06 May 2022 08:02:19 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id bm25-20020a05620a199900b0069fc13ce22asm2625608qkb.91.2022.05.06.08.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 08:02:19 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id w187so13355019ybe.2;
        Fri, 06 May 2022 08:02:18 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr2817893ybu.604.1651849338111; Fri, 06
 May 2022 08:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
 <20220505161028.GA492600@bhelgaas> <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
 <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk> <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
 <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk> <5239892986c94239a122ab2f7a18a7a5@AcuMS.aculab.com>
 <CAMuHMdWj5rmrP941DF7bsUXbiiemE-o2=8XqnAS-chgmpFFPQg@mail.gmail.com> <62c1bf6687ac4abc98d4015852930241@AcuMS.aculab.com>
In-Reply-To: <62c1bf6687ac4abc98d4015852930241@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 May 2022 17:02:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1HpUNKdZDqd0e5BKfr-FqGrwGJJ_xTKw5Z55bdEJa+Q@mail.gmail.com>
Message-ID: <CAMuHMdV1HpUNKdZDqd0e5BKfr-FqGrwGJJ_xTKw5Z55bdEJa+Q@mail.gmail.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select it
 as necessary
To:     David Laight <David.Laight@aculab.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Arnd Bergmann <arnd@kernel.org>, Rich Felker <dalias@libc.org>,
        "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi David

On Fri, May 6, 2022 at 4:05 PM David Laight <David.Laight@aculab.com> wrote:
> From: Geert Uytterhoeven
> > Sent: 06 May 2022 14:09
> > > The same is really true for other bus type - including ISA and EISA.
> > > (Ignoring the horrid of probing ISI bus devices - hopefully they
> > > are in the ACPI tables??_
> > > If a driver is probed on a ISA bus there ought to be functions
> > > equivalent to pci_ioremap() (for both memory and IO addresses)
> > > that return tokens appropriate for the specific bus.
> > >
> > > That is all a different load of churn.
> >
> > A loooong time ago,  it was suggested to add register accessor
> > functions to struct device, so e.g. readl(dev, offset) would call
> > into these accessors, which would implement the bus-specific behavior.
> > No more worries about readl(), __raw_readl(), ioread32b(), or whatever
> > quirk is needed, at the (small on nowadays' machines) expense of
> > some indirection...
>
> I was just thinking that the access functions might need a 'device'.
> Although you also need the BAR (or equivalent).
> So readl(dev, bar_token, offset) or readl(dev, bar_token + offset).

Note that we do have such a system: regmap.

> Clearly the 'dev' parameter could be compiled out for non-DEBUG
> build on x86 - leaving the current(ish) object code.

Assumed all devices are PCI devices.
E.g. USB devices would still need the indirection.

> You don't want an indirect call (this year), but maybe real
> function call and a few tests won't make that much difference.
> They might affect PCIe writes, but PCIe reads are so slow you
> need to avoid them whenever possible.
> I've not timed reads into something like an ethernet chip,
> but into our fpga they are probably 1000 clocks+.
>
> OTOH I wouldn't want any overhead on the PIO fifo reads
> on one of our small ppc devices.
> We push a lot of data though that fifo and anything extra
> would kill performance.

Right.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
