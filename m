Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5EF51C9B5
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384327AbiEET5d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 15:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345160AbiEET53 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 15:57:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F715F246;
        Thu,  5 May 2022 12:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BBBFCE3070;
        Thu,  5 May 2022 19:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68AFC385A4;
        Thu,  5 May 2022 19:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651780425;
        bh=fYxm3dr57owbquhz9mi2JlUgAayGWIYeuWXgYwjDgu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f2fc5oHeuzoxyJfE63Gjq/EPrO6txRg9hsHH/1s9bcAA7MB9R89IPW2XirzVZc74o
         JfbdqHGn2i9se2injqakFs9sJs55qbPwsXCW7U2z6292nsC5wpjZYOXUad+0rDxqWU
         dBktPS+QUeX5KA0qTdRvD/Jeg8g/VinXCSA1zNxox/sHlz0Qu+HDVGZRGj50as/vwO
         ee4WTtCWIAPTOcKicttAnfNz1to9P/EIAiFFNcHwyePB8PVEBnOd6hroIfxl+9c3Y0
         w8Ysllpp8ZwOIQgubSRRm20/01Cu9xOLyCR6eQMh+KyVf58T4+rzmnxImHp1ouw8wP
         UdmeA6sO/pypA==
Date:   Thu, 5 May 2022 14:53:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
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
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
Message-ID: <20220505195342.GA509942@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 05, 2022 at 07:39:42PM +0200, Arnd Bergmann wrote:
> On Thu, May 5, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, May 04, 2022 at 11:31:28PM +0200, Arnd Bergmann wrote:
> > >
> > > The main goal is to avoid c), which is what happens on s390, but
> > > can also happen elsewhere. Catching b) would be nice as well,
> > > but is much harder to do from generic code as you'd need an
> > > architecture specific inline asm statement to insert a ex_table
> > > fixup, or a runtime conditional on each access.
> >
> > Or s390 could implement its own inb().
> >
> > I'm hearing that generic powerpc kernels have to run both on machines
> > that have I/O port space and those that don't.  That makes me think
> > s390 could do something similar.
> 
> No, this is actually the current situation, and it makes absolutely no
> sense. s390 has no way of implementing inb()/outb() because there
> are no instructions for it and it cannot tunnel them through a virtual
> address mapping like on most of the other architectures. (it has special
> instructions for accessing memory space, which is not the same as
> a pointer dereference here).
> 
> The existing implementation gets flagged as a NULL pointer dereference
> by a compiler warning because it effectively is.

I think s390 currently uses the inb() in asm-generic/io.h, i.e.,
"__raw_readb(PCI_IOBASE + addr)".  I understand that's a NULL pointer
dereference because the default PCI_IOBASE is 0.

I mooted a s390 inb() implementation like "return ~0" because that's
what happens on most arches when there's no device to respond to the
inb().

The HAS_IOPORT dependencies are fairly ugly IMHO, and they clutter
drivers that use I/O ports in some cases but not others.  But maybe
it's the most practical way.

Bjorn
