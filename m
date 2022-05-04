Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2B51B0A3
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 23:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354421AbiEDVf1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347126AbiEDVf0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 17:35:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB84838E;
        Wed,  4 May 2022 14:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAD48B829E8;
        Wed,  4 May 2022 21:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D62C385BF;
        Wed,  4 May 2022 21:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651699906;
        bh=zFvzT8pCm+1ful8W/hZ4LOb35c/AZPHiTAR5f5uq/tc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=psHr6IyS0tCkPqNjtn0h6gBlwY40lOhbh/uw16bstSHWVYnmtHqEoZ532Dc9rtOal
         DUtXfgn3DdLZgWPENyY+MDgzz08W+auqjcYPklLCUJDhHdzEXeeuxWe7LpvbPQY9kJ
         FOxNi34XKyPTNO9nguLWvf12if7tv0axSjj5zB31OByn/knBsjbgNK9SEZoOb9mk2H
         8Mi5Plsbv3ClcTw6udErx8u6A9v1Ng1bHEjpGoMpucB2QcZFN6TMAvSYQ6IMdui25o
         P6nUGl1dzSr93wmpQQ9rPDjMiV7wf6pGhiZS8ljqSo0VQ8Lm9E+/x0iZSoSI081EGu
         qotf+DUD3i/vA==
Received: by mail-wr1-f51.google.com with SMTP id k2so3657498wrd.5;
        Wed, 04 May 2022 14:31:46 -0700 (PDT)
X-Gm-Message-State: AOAM530m3z7+Lq1wthZl3Ou4DDusfe+YzKGwkK3E99iNDWFIQi4smzAh
        db83aG6SCEY16rFZw+Bo71+iWvSUabbsMWpWX3Y=
X-Google-Smtp-Source: ABdhPJxAVZcK+UbsrIHV3UqhufeJ7C2MWsg9y8caQR3XP4mze6wyb/qHpchpXkh4iCCt0pJlSodAlnXDA871Nj1pC0U=
X-Received: by 2002:adf:e106:0:b0:20a:b31b:213d with SMTP id
 t6-20020adfe106000000b0020ab31b213dmr17558428wrz.219.1651699904306; Wed, 04
 May 2022 14:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220429135108.2781579-2-schnelle@linux.ibm.com> <20220504210840.GA469916@bhelgaas>
In-Reply-To: <20220504210840.GA469916@bhelgaas>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 May 2022 23:31:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
Message-ID: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select it
 as necessary
To:     Bjorn Helgaas <helgaas@kernel.org>
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

On Wed, May 4, 2022 at 11:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Apr 29, 2022 at 03:49:59PM +0200, Niklas Schnelle wrote:
> > We introduce a new HAS_IOPORT Kconfig option to indicate support for
> > I/O Port access. In a future patch HAS_IOPORT=n will disable compilation
> > of the I/O accessor functions inb()/outb() and friends on architectures
> > which can not meaningfully support legacy I/O spaces such as s390 or
> > where such support is optional.
>
> So you plan to drop inb()/outb() on architectures where I/O port space
> is optional?  So even platforms that have I/O port space may not be
> able to use it?
>
> This feels like a lot of work where the main benefit is to keep
> Kconfig from offering drivers that aren't of interest on s390.
>
> Granted, there may be issues where inb()/outb() does the wrong thing
> such as dereferencing null pointers when I/O port space isn't
> implemented.  I think that's a defect in inb()/outb() and could be
> fixed there.

The current implementation in asm-generic/io.h implements inb()/outb()
using readb()/writeb() with a fixed architecture specific offset.

There are three possible things that can happen here:

a) there is a host bridge driver that maps its I/O ports to this window,
    and everything works
b) the address range is reserved and accessible but no host bridge
   driver has mapped its registers there, so an access causes a
   page fault
c) the architecture does not define an offset, and accessing low I/O
    ports ends up as a NULL pointer dereference

The main goal is to avoid c), which is what happens on s390, but
can also happen elsewhere. Catching b) would be nice as well,
but is much harder to do from generic code as you'd need an
architecture specific inline asm statement to insert a ex_table
fixup, or a runtime conditional on each access.

         Arnd
