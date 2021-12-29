Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB7480F54
	for <lists+linux-arch@lfdr.de>; Wed, 29 Dec 2021 04:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhL2Dlo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 22:41:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34734 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhL2Dln (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 22:41:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64B43B817AB;
        Wed, 29 Dec 2021 03:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA1FC36AF2;
        Wed, 29 Dec 2021 03:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640749300;
        bh=sMe3q8ad98okMs4HLXxIEZG5eWgoWBzrycggRgzNn0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gfBUGGZtKlSdchISLRCbgoh5ApvOms88vBNDBueg3GSAqIXPSkyv3hT3+JLM3V8rd
         NBXbvcDdAfWC4ZFlxNGOThtvDBg9TpHafmYp6AoKHdo7tXLFlhXn/lylE8k/3yGTpP
         qaq0Iy+2+aSp302rKXO4x7uVkeduQCA9T79BgtkTt8BYVlCGkm7lz25aZ+zHWTEd0S
         9pUWnmx3E/895Wpun2xbxI2jymz5JySeYBwqar7GOpedMrFMwNkqar44IVWO2AO8sP
         JiT1Dd1gOzEi7FZfU/lHPGKEXgT7N7xI/S78pUQVJ5QyKVMrZUQVQPCKosaR34UMGK
         rebkE+b3YsYqw==
Received: by mail-wm1-f50.google.com with SMTP id g132so12789352wmg.2;
        Tue, 28 Dec 2021 19:41:40 -0800 (PST)
X-Gm-Message-State: AOAM532T8c2HGy6epaz094iKuhVcj1hQ9WeTPLevmuDbcKD+iDwQpZ53
        bEstIlkuSlWny1luVuugVfS8iYNL/sFTrCvmOP4=
X-Google-Smtp-Source: ABdhPJwExVf1S5yWbdFaQXvSS7m+9fv3xxH0eSVAhqrz/dUiLqmyF5p5xrdPthuPvZdKvgQOvhEXVEuNpJp0LGzgDhQ=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr20244545wmc.82.1640749287841;
 Tue, 28 Dec 2021 19:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com> <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
 <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com>
In-Reply-To: <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Dec 2021 22:41:18 -0500
X-Gmail-Original-Message-ID: <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
Message-ID: <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
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
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org,
        linux-s390@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 28, 2021 at 8:20 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.12.2021 um 23:08 schrieb Geert Uytterhoeven:
> > On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> >> We introduce a new HAS_IOPORT Kconfig option to gate support for
> >> I/O port access. In a future patch HAS_IOPORT=n will disable compilation
> >> of the I/O accessor functions inb()/outb() and friends on architectures
> >> which can not meaningfully support legacy I/O spaces. On these platforms
> >> inb()/outb() etc are currently just stubs in asm-generic/io.h which when
> >> called will cause a NULL pointer access which some compilers actually
> >> detect and warn about.
> >>
> >> The dependencies on HAS_IOPORT in drivers as well as ifdefs for
> >> HAS_IOPORT specific sections will be added in subsequent patches on
> >> a per subsystem basis. Then a final patch will ifdef the I/O access
> >> functions on HAS_IOPORT thus turning any use not gated by HAS_IOPORT
> >> into a compile-time warning.
> >>
> >> Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
> >> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> >> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> >> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/m68k/Kconfig
> >> +++ b/arch/m68k/Kconfig
> >> @@ -16,6 +16,7 @@ config M68K
> >>         select GENERIC_CPU_DEVICES
> >>         select GENERIC_IOMAP
> >>         select GENERIC_IRQ_SHOW
> >> +       select HAS_IOPORT
> >>         select HAVE_AOUT if MMU
> >>         select HAVE_ASM_MODVERSIONS
> >>         select HAVE_DEBUG_BUGVERBOSE
> >
> > This looks way too broad to me: most m68k platform do not have I/O
> > port access support.
> >
> > My gut feeling says:
> >
> >     select HAS_IOPORT if PCI || ISA
> >
> > but that might miss some intricate details...
>
> In particular, this misses the Atari ROM port ISA adapter case -
>
>         select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA
>
> might do instead.

Right, makes sense. I had suggested to go the easy way and assume that
each architecture would select HAS_IOPORT if any configuration supports
it, but it looks like for m68k there is a clearly defined set of platforms that
do.

Note that for the platforms that don't set any of the three symbols, the
fallback makes inb() an alias for readb() with a different argument type,
so there may be m68k specific drivers that rely on this, but those would
already be broken if ATARI_ROM_ISA is set.

          Arnd
