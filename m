Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92284824B7
	for <lists+linux-arch@lfdr.de>; Fri, 31 Dec 2021 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhLaQEp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Dec 2021 11:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLaQEo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Dec 2021 11:04:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2807DC061574;
        Fri, 31 Dec 2021 08:04:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E78B2B81D9B;
        Fri, 31 Dec 2021 16:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56E0C36AF4;
        Fri, 31 Dec 2021 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640966681;
        bh=pu3EOtLhubDoxaVwiYbh4e/NfH+lhjOkYe7VbmME5Z0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=raXMVpPTRAf3vF8B62lkOgsA/cVfsPOPEGtrByVh26tgU6FewLliwwvE5oVSxTfvJ
         1isY+reYV6wkTVj9kZeXXITYA4ZLSnegTHP2FPOPl+zVGpV7aOvkSmkBLyhNAOgHR1
         2sxK+Ewu9K8opb6D6pVml2o8615MS9DLn+olxHqwVzvT8Xh5P7+RRwmCSJfOODKM51
         uCDoa4le3AzkzvHOK55tCCwn96EKQBOHpr853njIbdmLrUqgvOFCO+ErxSuQhW1ZUE
         /E5E7A34ZTJ7Vtr7fXqJFcLl8V4bz4PcNAUhmkNNyPOu/FhFcut4rQ7dYvKY+75A6Q
         F+kxB9VuFSY/g==
Received: by mail-lf1-f50.google.com with SMTP id h2so50380521lfv.9;
        Fri, 31 Dec 2021 08:04:41 -0800 (PST)
X-Gm-Message-State: AOAM532KKP2lW9+vigWtiFAVx+ScumiyAxB4mgB6XqwFtA2NIAGwSqYP
        /MOKLXDGej5zOzL+XyY78CNLeGxPzFIzBbu32fc=
X-Google-Smtp-Source: ABdhPJzApDVGjcuVEHw18tz1R9gDPlbk/Ui+m3pYQWhrQTDSy0tEhDoMzOEccUFjcDO7rPU48bSeyrks7IEcpaugXLU=
X-Received: by 2002:adf:f051:: with SMTP id t17mr29442418wro.192.1640966669503;
 Fri, 31 Dec 2021 08:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com> <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
 <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com> <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
 <1f90f145-219e-1cad-6162-9959d43a27ad@gmail.com> <CAK8P3a3NqU-3nUZ9ve=QyPPB5Uep3eK+_hicjjSiP8VuL4FYfA@mail.gmail.com>
 <0211719b-8402-9865-8e5d-5c0a35715816@gmail.com>
In-Reply-To: <0211719b-8402-9865-8e5d-5c0a35715816@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 31 Dec 2021 11:04:12 -0500
X-Gmail-Original-Message-ID: <CAK8P3a2GGGuP0miLRy8w2+8vdSsGRNioBHEZ-ervSBrYbuZ+5w@mail.gmail.com>
Message-ID: <CAK8P3a2GGGuP0miLRy8w2+8vdSsGRNioBHEZ-ervSBrYbuZ+5w@mail.gmail.com>
Subject: Re: [RFC 02/32] Kconfig: introduce HAS_IOPORT option and select it as necessary
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Karol Gugala <kgugala@antmicro.com>,
        Jeff Dike <jdike@addtoit.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 29, 2021 at 10:44 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 30.12.2021 um 14:48 schrieb Arnd Bergmann:
> > On Tue, Dec 28, 2021 at 11:15 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > What some other architectures do is to rely on inb()/outb() to have a
> > zero-based offset, and use an io_offset in PCI buses to ensure that a
> > low port number on the bus gets translated into a pointer value for the
> > virtual mapping in the kernel, which is then represented as an unsigned
> > int.
>
> M54xx does just that for Coldfire:
>
> arch/m68k/include/asm/io_no.h:
> #define PCI_IO_PA       0xf8000000              /* Host physical address */
>
> (used to set PCI BAR mappings, so matches your definition above).

I think coldfire gets it right here, using PCI_IOBASE to find the start of
the window and a zero io_offset:

#define PCI_IOBASE ((void __iomem *) PCI_IO_PA)

> All other (MMU) m68k users of inb()/outb() apply an io_offset in the
> platform specific address translation:
>
> arch/m68k/include/asm/io_mm.h:
>
> #define q40_isa_io_base  0xff400000
> #define enec_isa_read_base  0xfffa0000
> #define enec_isa_write_base 0xfffb0000
>
> arch/m68k/include/asm/amigayle.h:
>
> #define GAYLE_IO                (0xa20000+zTwoBase)     /* 16bit and
> even 8bit registers */
> #define GAYLE_IO_8BITODD        (0xa30000+zTwoBase)     /* odd 8bit
> registers */
>
> (all constants used in address translation inlines that are used by the
> m68k inb()/outb() macros - you can call that the poor man's version of
> PCI BAR mappings ...).

This still looks like the same thing to me, where you have inb() take a
zero-based port number, not a pointer. The effect is the same as the
coldfire version, it just uses a custom inline function instead of the
version from asm-generic/io.h.

> So as long as support for any of the m68k PCI or ISA bridges is selected
> in the kernel config, the appropriate IO space mapping is applied. If no
> support for PCI or ISA bridges is selected, we already fall back to zero
> offset mapping (but as far as I can tell, it shouldn't be possible to
> build a kernel without bridge support but drivers that require it).

Right.

> > As this is indistinguishable from architectures that just don't have
> > a base address for I/O ports (we unfortunately picked 0 as the default
> > PCI_IOBASE value), my suggestion was to start marking architectures
> > that may have this problem as using HAS_IOPORT in order to keep
> > the existing behavior unchanged. If m68k does not suffer from this,
> > making HAS_IOPORT conditional on those config options that actually
> > need it would of course be best.
>
> Following your description, HAS_IOPORT would be required for neither of
> PCI, ISA or ATARI_ROM_ISA ??

For these three options, we definitely need HAS_IOPORT, which would
imply that some version of inb()/outb() is provided. The difference between
using a custom PCI_IOBASE (or an open-coded equivalent) and using
a zero PCI_IOBASE in combination with registering PCI using a custom
io_offset is whether we can use drivers with hardcoded port numbers.
These should depend on a different Kconfig symbol to be introduced
(CONFIG_HARDCODED_IOPORT or similar) once we introduce them,
and you could decide for m68k whether to allow those or not, I would
assume you do want them in order to use certain legacy ISA drivers.

       Arnd
