Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2648851E75C
	for <lists+linux-arch@lfdr.de>; Sat,  7 May 2022 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442286AbiEGNSZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 May 2022 09:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357403AbiEGNSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2022 09:18:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906A4666F;
        Sat,  7 May 2022 06:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B00BB80833;
        Sat,  7 May 2022 13:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE553C385A9;
        Sat,  7 May 2022 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651929274;
        bh=9uTgmNAvlTbzN50Cu5IwNYqzF7atwTKQUljfe2kjZUc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NYZWIxr7bdtZV5TCcT29L1SoUFnfl0Drt2zM3YTpcRSmzMXOH2zT2baV4RKv/+juu
         BeDMU08ud7wEyHs+PdV76d+h0FPoWNnkiKsYboYXuD0asYcJpn1MYIybfLSkxaveRD
         uQQFXFWzr9gQFnG/xPzoBv9obxrCScP/SadNv3PCPo2G03s6CjQbtW7kU30vam9nvR
         Gf9YIXbw31u1k0y0AlA3If+Fygh/BycEfiWjNZ4jYfFCmNDyTDxL258IRkv/OGg8DJ
         x/as86QX/Y3tXnRDq/97ZySrx3YSbvxuVWbYl92I7gnkngH5rRb0u87EFe1JeEtcqb
         h3B3YManvPOXw==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso105856877b3.5;
        Sat, 07 May 2022 06:14:34 -0700 (PDT)
X-Gm-Message-State: AOAM5324RKs/khNVpfgto0nIU6Tw7t5R03GZYazMMiGH6m4oKC3eUQGE
        4aM8eXq+3QcHFlQ8KhlBeB5lY/Q4ExXiQrTN8lU=
X-Google-Smtp-Source: ABdhPJxbpJWGFV6icMBoxijo70JK/8WaaDtoVIOoN93PiTf8ADZqw87+hT03oX7HblceCPV66kg3inBF049Gp/XoA2E=
X-Received: by 2002:a81:1697:0:b0:2fa:32f9:78c8 with SMTP id
 145-20020a811697000000b002fa32f978c8mr6670913yww.135.1651929273816; Sat, 07
 May 2022 06:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220505195342.GA509942@bhelgaas> <22bec167-241f-2cbe-829f-a3f65e40e71@linux-m68k.org>
 <105ccec439f709846e82b69cb854ac825d7a6a49.camel@linux.ibm.com> <7dfa7578-039-e132-c573-ad89bd3215@linux-m68k.org>
In-Reply-To: <7dfa7578-039-e132-c573-ad89bd3215@linux-m68k.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 7 May 2022 15:14:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3tds8O+Gg2nF3MfrVVcmtLbtdQ2TnCJaDYz28cyhhWkg@mail.gmail.com>
Message-ID: <CAK8P3a3tds8O+Gg2nF3MfrVVcmtLbtdQ2TnCJaDYz28cyhhWkg@mail.gmail.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select it
 as necessary
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
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

On Sat, May 7, 2022 at 2:01 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Fri, 6 May 2022, Niklas Schnelle wrote:
> > On Fri, 2022-05-06 at 19:12 +1000, Finn Thain wrote:
> > > On Thu, 5 May 2022, Bjorn Helgaas wrote:
> > > >
> > > > I mooted a s390 inb() implementation like "return ~0" because that's
> > > > what happens on most arches when there's no device to respond to the
> > > > inb().
> > > >
> > > > The HAS_IOPORT dependencies are fairly ugly IMHO, and they clutter
> > > > drivers that use I/O ports in some cases but not others.  But maybe
> > > > it's the most practical way.
> > > >
> > >
> > > Do you mean, "the most practical way to avoid a compiler warning on
> > > s390"? What about "#pragma GCC diagnostic ignored"?
> >
> > This actually happens with clang.
>
> That suggests a clang bug to me. If you believe GCC should behave like
> clang, then I guess the pragma above really is the one you want. If you
> somehow feel that the kernel should cater to gcc and clang even where they
> disagree then you would have to use "#pragma clang diagnostic ignored".

I don't see how you can blame the compiler for this. On architectures
with a zero PCI_IOBASE, an inb(0x2f8) literally becomes

        var = *(u8*)((NULL + 0x2f8);

If you run a driver that does this, the kernel gets a page fault for
the NULL page
and reports an Oops. clang tells you 'warning: performing pointer
arithmetic on a null pointer has undefined behavior', which is not exactly
spot on, but close enough to warn you that you probably shouldn't do this. gcc
doesn't warn here, but it does warn about an array out-of-bounds access when
you pass such a pointer into memcpy or another string function.

> > Apart from that, I think this would also fall under the same argument as
> > the original patch Linus unpulled. We would just paint over someting
> > that we know at compile time won't work:
> >
> > https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
> >
>
> I wasn't advocating adding any warnings.
>
> If you know at compile time that a driver won't work, the usual solution
> is scripts/config -d CONFIG_SOME_UNDESIRED_DRIVER. Why is that no
> longer appropriate for drivers that use IO ports?

This was never an option, we rely on 'make allmodconfig' to build without
warnings on all architectures for finding regressions. Any driver that depends
on architecture specific interfaces must not get selected on architectures that
don't have those interfaces.

         Arnd
