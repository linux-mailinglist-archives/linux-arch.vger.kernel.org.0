Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D257E04D
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 12:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiGVKyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVKyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 06:54:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5281BB5CE;
        Fri, 22 Jul 2022 03:54:02 -0700 (PDT)
Received: from mail-oi1-f177.google.com ([209.85.167.177]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJmX3-1nvOWu050r-00K5gp; Fri, 22 Jul 2022 12:54:01 +0200
Received: by mail-oi1-f177.google.com with SMTP id i126so5220642oih.4;
        Fri, 22 Jul 2022 03:54:00 -0700 (PDT)
X-Gm-Message-State: AJIora+xpurf2KILrysRy7oGYUpuRPSdAu4QMiJ9Nb6hq6LmT+Vae1av
        UuPrUeeuSNKJJCc6OllWh5GfBSa09svJwBVKJwA=
X-Google-Smtp-Source: AGRyM1vy78FVr9qHehqDiblEj3V70Xauesbczc+NWbVsp5PyEl2CXocctR2Sg0IIOFpYE1nv6PajH1Yeg0LPhB77W8o=
X-Received: by 2002:a05:6808:1511:b0:33a:b4f1:5247 with SMTP id
 u17-20020a056808151100b0033ab4f15247mr1728223oiw.188.1658487239317; Fri, 22
 Jul 2022 03:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220718004114.3925745-3-shorne@gmail.com> <mhng-3ae42214-abe0-4fad-9fa9-8f19809fa4d9@palmer-mbp2014>
 <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jul 2022 12:53:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0FwLmFO6Ew6kkJv=rOGRdQ+cyXok4b1kRr1RQP499wKA@mail.gmail.com>
Message-ID: <CAK8P3a0FwLmFO6Ew6kkJv=rOGRdQ+cyXok4b1kRr1RQP499wKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
To:     Rob Herring <robh@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Stafford Horne <shorne@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FoFxno0xkIhsDoFbIXSNi5cy7WTtphRUBIdOPzBUUA+/0M/CLQr
 O/NKi2oROZus9z4FMWnAvJSjIE2YbqbkhwR+O3xIfDe+wG4o5jNX6SsgVWXvNDlHSRtgAZC
 gw12tgqNJnL0cZBxH/59FmWMdi1ncKWBC7tTE1fhLpdPj2+DOmfeUOgtKKlbG0cYJM2bxrx
 XoPuRydAlWWqYqe0iGZAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8cr+Qc0vdfQ=:mGbVvIfnyOe3OhpyX+V784
 s9ruaf4OlU6C4JY5HmrWud7cD+/UKeuSExkcb0Sz8P35uHg13A+zuaqdCOKl0eFzo9p7HPA/0
 jF0cuN7kUyyLFz5M/ipTM78LS8uNslnA37qP1cYAWPhZ1Cr19k7+Z+p2U8nlI9cIMg/hNq0+D
 VIzBjmnjmai3/zXEi975/fXlDMFXd9eoQA7cYw9puno8BYryWlIthfIYMsFgTz1sEa/3dwL36
 3bJfKuqM8eZppIQJCfdV5CcJig7dmCKRLDkAQRMcDG8YNHGxei7SBRovbm873pfHYFlO2dYAK
 z98tkK0Z2xS+7yD28wm4LlHbBGThES8lC76OZIwECJXlRfjxZPa8uQlPLmpi8XWOIXfXn13yI
 wcUrvOhduPPovSRTR0Kv9N7w+PFmF4dqx5oYwmCJ2Iua9kARthu9UwVySDMpSH+cvjAvh6Uii
 IB2tblQSuVAPAr8NySF4XolYvK4M8PVsZn3Lo7/YxZRphO+dF0s4c9Vfnzm63wU/X/3yN6hvA
 gxHSPTfO4+T3tfttFQdf90lCla89UWc9+3WoDjo0lo1JsjuX4FeZcG5kgBlZJgT1d1oHGpRq+
 xrvcDi85h6vU3A3pT9DzvLRH9JFz1QYWdOz71S9+BdJJXxvVYNAmp5YNMOfdqUL5j20EczRpT
 jhMRjPGm4mb/DA7Zh/Ga2L/Gbg6swNhuHr9lDxAWI/lqxAtUI3LNizmnDZ3CGi/r3ZxZaPULw
 r9wZ5bZUn3ltSWsocBZ5YIUPD6wp5b8BFf6/2eAJdLeiZ3logYJczJAMsw1IpLMV+FR9cvYHb
 u4biSvKmXnyIDe+8kbU/WjxaLzUwIe1bjFZUNLjPQQDvnVhuO1hY+tLbAchTkd5ZqnE6NmNDX
 hPEopyH285qyXR51gVVA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 22, 2022 at 1:06 AM Rob Herring <robh@kernel.org> wrote:
> On Tue, Jul 19, 2022 at 9:59 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > On Sun, 17 Jul 2022 17:41:14 PDT (-0700), shorne@gmail.com wrote:

> > > diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> > > index 7fd52a30e605..12ce8150cfb0 100644
> > > --- a/arch/riscv/include/asm/pci.h
> > > +++ b/arch/riscv/include/asm/pci.h
> > > @@ -12,29 +12,7 @@
> > >
> > >  #include <asm/io.h>
> > >
> > > -#define PCIBIOS_MIN_IO               0
> > > -#define PCIBIOS_MIN_MEM              0
> >
> > My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing
> > out address 0 to devices").  Do you mind either splitting out the
> > arch/riscv bits or having this in via some sort of shared tag?
>
> Shouldn't the values not matter here if the IO and mem resources are
> described in the DT (and don't use 0)? The values of 4 and 16 look
> odd.

I think it's different for the two types: For memory resources, this only
matters if the bus actually contains MMIO address zero. In most cases
the MMIO addresses are the same as the address seen by the CPU
and already nonzero based on the SoC design.

For the I/O port numbers, the port numbers tend to be more dynamic,
but you'd normally have addresses 0 through 0xffff on each PCI host
bridge with memory mapped I/O ports, so this can clearly happen.

Still, it seems better to not address the port zero issue in architecture
specific code but instead do it in the PCI core code. Ideally
we'd just use the 0x1000 minimum, which also helps stay out of
the ISA port numbers that may be used by things like
VGA or SATA adapters in legacy mode. The only reason I can
see for allowed smaller port numbers is for machines that have
a very limited I/O port window and do not have ports over
0x1000 at all.

        Arnd
