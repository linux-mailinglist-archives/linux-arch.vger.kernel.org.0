Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7407B51D6AC
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391353AbiEFLhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346328AbiEFLhH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 07:37:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963160C9;
        Fri,  6 May 2022 04:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC1A0B8358E;
        Fri,  6 May 2022 11:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40408C385BE;
        Fri,  6 May 2022 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651836800;
        bh=mPb8Q8Ok2oNk7WAjedaRk8DoRYKS47EIw5ypxOHVuLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MEhcEVVROzt7JNAkcDasKjP6BiznNx2llyEJNiQphooQOz3sWxo0NeoXq1qGjma3j
         4Zt4jDF3Ol/xJAYGhMV7xEI6p4hpnR/gRU7+VCsgRasl9P+SdnFoiymfONZVvlYETt
         Boao+8XuCNnL8WJt+Ku2LRimxFR5pkFhCoiv4Gx3lyU9EAL5a8k+iOgArRRLkDSEJW
         AaBLP7ncLeAs7u+HKJRBautcMPZHX2Pkrx+vHRF9kJ799TJSl12whMXRpdvA/BCx/X
         tyIj+uq91VCi3tKMnerH0qkv3BEzLb7m0J7sSBXjzflmqbSrTeB5I+mO87mHoSsyFq
         2FwMAHSG49yNQ==
Received: by mail-yb1-f172.google.com with SMTP id y76so12363630ybe.1;
        Fri, 06 May 2022 04:33:20 -0700 (PDT)
X-Gm-Message-State: AOAM533WkIphyq6CzJGfB6I7e5q6tTbO0f97sEmW1Xub1pG1AICBETHh
        I9cLEU4Z246x1tvEj71v40UpF5ZDwattFWn81Lk=
X-Google-Smtp-Source: ABdhPJy5Vv8YTgA/+Yk25Xv8xMKQhcEw8LiqaQy/3bb0wg6KVBd/5y4hLeqVF7Zu5FslZtdBqz1tOtNTiterOIoDfDE=
X-Received: by 2002:a25:d3c2:0:b0:645:74df:f43d with SMTP id
 e185-20020a25d3c2000000b0064574dff43dmr1886331ybf.394.1651836798896; Fri, 06
 May 2022 04:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
 <20220505161028.GA492600@bhelgaas> <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
 <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 6 May 2022 13:33:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
Message-ID: <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
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

On Fri, May 6, 2022 at 12:20 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> On Thu, 5 May 2022, Arnd Bergmann wrote:
>  I think I'm missing something here.  IIUC we're talking about a PCI/PCIe
> bus used with s390 hardware, right?
>
>  (It has to be PCI/PCIe, because other than x86/IA-64 host buses there are
> only PCI/PCIe and EISA/ISA buses out there that define I/O access cycles
> and EISA/ISA have long been obsoleted except perhaps from some niche use.)
>
>  If this is PCI/PCIe indeed, then an I/O access is just a different bit
> pattern put on the bus/in the TLP in the address phase.  So what is there
> inherent to the s390 architecture that prevents that different bit pattern
> from being used?

The hardware design for PCI on s390 is very different from any other
architecture, and more abstract. Rather than implementing MMIO register
access as pointer dereference, this is a separate CPU instruction that
takes a device/bar plus offset as arguments rather than a pointer, and
Linux encodes this back into a fake __iomem token.

>  If anything, I could imagine the same limitation as with current POWER9
> implementations, that is whatever glue is used to wire PCI/PCIe to the
> rest of the system does not implement a way to use said bit pattern (which
> has nothing to do with the POWER9 processor instruction set).
>
>  But that has nothing to do with the presence or absence of any specific
> processor instructions.  It's just a limitation of bus glue.  So I guess
> it's just that all PCI/PCIe glue logic implementations for s390 have such
> a limitation, right?

There are separate instructions for PCI memory and config space, but
no instructions for I/O space, or for non-PCI MMIO that it could be mapped
into.

       Arnd
