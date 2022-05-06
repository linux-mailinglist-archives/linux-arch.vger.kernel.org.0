Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF2151D83F
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347275AbiEFM6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 08:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392173AbiEFM6A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 08:58:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4B3606C3;
        Fri,  6 May 2022 05:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1EB3B8350D;
        Fri,  6 May 2022 12:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6736FC385C0;
        Fri,  6 May 2022 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651841648;
        bh=YEsptMS5NZ5sU5R8sBoFFmT8HhhJmSMOqqqMD1wS+1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=alicQ+HfzBRpAkO4B96ZoI58feV30vwikm/SJGBtuePZM0wfyrCA+j9vGNYsOCzoo
         HP/4IJb9wWEnTHbo9/27qz1+kGraLpz6DXj61WtLS1JeZqg546So3OIWfjv3BbABpV
         8dQUZ6ELhNVBSLsA390sbMzGuZMUij6tnXvZEXj4WfMWsq7AU0N7RHHCSWZaOfNg1L
         M/C9dzbWlAmjAIW5r+qqkvwipyU1At3FZ+hwk5GIWHPOdlH3+dt+Jqf3arEnPHd8Hc
         FOmJ1tfP+Djie6UmpJK4r2UngjgPTwpiLnjtpMMaN0N0MgVh+7XIR4gMMh9OB4ZWnh
         NQ7q+PXPPTZTw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2f7ca2ce255so80026007b3.7;
        Fri, 06 May 2022 05:54:08 -0700 (PDT)
X-Gm-Message-State: AOAM530XRFkVTU53dh/Xqfh6fB+5JBeiq+bqnJ9Tx1SDjl8DTLQxcQCh
        6vpcEal1iz2dkLJ0OTBfBCvuWUa6+WVCt1brahc=
X-Google-Smtp-Source: ABdhPJxL4gNLQQDFM+BNVTidCF+FJnD2lH7XZl8gBNCvdOYlAoSJ9hsbhzdM2mtB2NzLIM7z6wH6YyxJ1/r4G1eT6xU=
X-Received: by 2002:a81:9213:0:b0:2f6:eaae:d22f with SMTP id
 j19-20020a819213000000b002f6eaaed22fmr2535695ywg.249.1651841647017; Fri, 06
 May 2022 05:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
 <20220505161028.GA492600@bhelgaas> <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
 <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk> <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
 <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 6 May 2022 14:53:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0EMK0gHOmb-jvtfVLb1dun72kYUMKpb11T_GgXiuR9Mw@mail.gmail.com>
Message-ID: <CAK8P3a0EMK0gHOmb-jvtfVLb1dun72kYUMKpb11T_GgXiuR9Mw@mail.gmail.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select it
 as necessary
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 6, 2022 at 2:27 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Fri, 6 May 2022, Arnd Bergmann wrote:
>
> > >  If this is PCI/PCIe indeed, then an I/O access is just a different bit
> > > pattern put on the bus/in the TLP in the address phase.  So what is there
> > > inherent to the s390 architecture that prevents that different bit pattern
> > > from being used?
> >
> > The hardware design for PCI on s390 is very different from any other
> > architecture, and more abstract. Rather than implementing MMIO register
> > access as pointer dereference, this is a separate CPU instruction that
> > takes a device/bar plus offset as arguments rather than a pointer, and
> > Linux encodes this back into a fake __iomem token.
>
>  OK, that seems to me like a reasonable and quite a clean design (on the
> hardware side).
>
>  So what happens if the instruction is given an I/O rather than memory BAR
> as the relevant argument?  Is the address space indicator bit (bit #0)
> simply ignored or what?

Not sure. My best guess is that it would actually work as you'd expect,
but is deliberately left out of the architecture specification so they don't
have to to validate the correctness.  Note that only a small number of
PCIe cards are actually supported by IBM, and I think the firmware
only passes devices to the OS if they are whitelisted.

        Arnd
