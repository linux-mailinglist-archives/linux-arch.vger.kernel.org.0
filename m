Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75BF51D87F
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392249AbiEFNMt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 09:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiEFNMq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 09:12:46 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C820BED;
        Fri,  6 May 2022 06:09:02 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id kl21so5346495qvb.9;
        Fri, 06 May 2022 06:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2s+AM5Z/cEWfKtZbdmffBUO5M791JT3EdrRSPC+WgI=;
        b=KDdd7fWVz2Gc3n3evTji4Ff9SHDMtj2TXkoOPsceaxAiVKLV+xGG/zABuL+2yU/BEe
         AhwuSV0HEF9UAwNTd1a2GizHrHcIx8wPUC1fygO+P3uNk9mDKpEARIf57sRrMRZFptJ/
         JnWjeJrZAZnuH4d4yyWqxzQ+pno0rHdaiDCNZHyuVo8Uzuaw5wz/OCmtD7n6odg5ENdx
         VG/vH11Xxx04yZV6fMLGBzFuhux9teiMZQYg7I6cIG5wFaerG+hEydGg9Wks1SSciTMd
         0hnzwEvVc9QEWbitrYzTmwvX5JDNsec44fVG/Oktpr27UzCotE1jRg85SMZ/aGUvMYjG
         1Jug==
X-Gm-Message-State: AOAM5319qGOEzbYnPsXr/HiOa2BfYkHy7njGh2WiQ0ibzeA6lWE4KYwK
        3bHlOofu0owjQHoMomzDEM+VIP1+hbJ+4g==
X-Google-Smtp-Source: ABdhPJxoWF15l2pE5rsqRrPDge7Jqaw0/TSKcM3KXUAwMjqt8C0KWsu8AztoHz5SQOqLwomuqzUqJQ==
X-Received: by 2002:a0c:c3c6:0:b0:42c:17e4:9a75 with SMTP id p6-20020a0cc3c6000000b0042c17e49a75mr2596825qvi.124.1651842541158;
        Fri, 06 May 2022 06:09:01 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id x13-20020ac86b4d000000b002f39b99f69asm2539395qts.52.2022.05.06.06.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 06:08:59 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id i38so12717763ybj.13;
        Fri, 06 May 2022 06:08:58 -0700 (PDT)
X-Received: by 2002:a25:4506:0:b0:648:cfc2:301d with SMTP id
 s6-20020a254506000000b00648cfc2301dmr2250498yba.380.1651842538339; Fri, 06
 May 2022 06:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
 <20220505161028.GA492600@bhelgaas> <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
 <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk> <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
 <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk> <5239892986c94239a122ab2f7a18a7a5@AcuMS.aculab.com>
In-Reply-To: <5239892986c94239a122ab2f7a18a7a5@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 May 2022 15:08:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWj5rmrP941DF7bsUXbiiemE-o2=8XqnAS-chgmpFFPQg@mail.gmail.com>
Message-ID: <CAMuHMdWj5rmrP941DF7bsUXbiiemE-o2=8XqnAS-chgmpFFPQg@mail.gmail.com>
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

On Fri, May 6, 2022 at 2:56 PM David Laight <David.Laight@aculab.com> wrote:
> From: Maciej W. Rozycki
> > Sent: 06 May 2022 13:27
> > On Fri, 6 May 2022, Arnd Bergmann wrote:
> > > >  If this is PCI/PCIe indeed, then an I/O access is just a different bit
> > > > pattern put on the bus/in the TLP in the address phase.  So what is there
> > > > inherent to the s390 architecture that prevents that different bit pattern
> > > > from being used?
> > >
> > > The hardware design for PCI on s390 is very different from any other
> > > architecture, and more abstract. Rather than implementing MMIO register
> > > access as pointer dereference, this is a separate CPU instruction that
> > > takes a device/bar plus offset as arguments rather than a pointer, and
> > > Linux encodes this back into a fake __iomem token.
> >
> >  OK, that seems to me like a reasonable and quite a clean design (on the
> > hardware side).
> >
> >  So what happens if the instruction is given an I/O rather than memory BAR
> > as the relevant argument?  Is the address space indicator bit (bit #0)
> > simply ignored or what?
>
> You don't understand something...
>
> For a memory BAR pci_ioremap() returns a token that can be used with readl().
> On most architectures readl() is just a memory access.
> This all fails on an I/O BAR.
>
> For an I/O BAR you want a similar pair of functions.
> On x86 the access function would need to use the 'in/out' instructions but
> there is no requirement for the token to be the native io port number.
> On many non-x86 architectures the access function would be a simple memory
> access - but a specific system (eg many ppc) may never actually allow
> such mappings to succeed.
>
> You might also want a third PCI mapping function that can map a memory
> BAR or an I/O BAR - with a suitable access function.
> On x86 this would need something like ioread8() for accesses.
> Except that function uses small integers for io port numbers
> (which is inherently dangerous).
>
> Nothing except the architecture specific implementation of the function
> to access an io BAR would ever go near a function called inb().
>
> The same is really true for other bus type - including ISA and EISA.
> (Ignoring the horrid of probing ISI bus devices - hopefully they
> are in the ACPI tables??_
> If a driver is probed on a ISA bus there ought to be functions
> equivalent to pci_ioremap() (for both memory and IO addresses)
> that return tokens appropriate for the specific bus.
>
> That is all a different load of churn.

A loooong time ago,  it was suggested to add register accessor
functions to struct device, so e.g. readl(dev, offset) would call
into these accessors, which would implement the bus-specific behavior.
No more worries about readl(), __raw_readl(), ioread32b(), or whatever
quirk is needed, at the (small on nowadays' machines) expense of
some indirection...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
