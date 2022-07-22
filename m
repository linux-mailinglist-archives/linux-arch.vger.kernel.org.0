Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5457E74B
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiGVTXk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 15:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiGVTXj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 15:23:39 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A35EE5F13D;
        Fri, 22 Jul 2022 12:23:38 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 94A7192009C; Fri, 22 Jul 2022 21:23:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8971D92009B;
        Fri, 22 Jul 2022 20:23:36 +0100 (BST)
Date:   Fri, 22 Jul 2022 20:23:36 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Rob Herring <robh@kernel.org>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org, PCI <linux-pci@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
In-Reply-To: <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2207222006140.48997@angie.orcam.me.uk>
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com> <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014> <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 22 Jul 2022, Rob Herring wrote:

> > Maybe the right thing to do here is actually to make the default
> > definitions of these macros non-zero, or to add some sort of ARCH_
> > flavor of them and move that non-zero requirement closer to where it
> > comes from?  From the look of it any port that uses the generic port I/O
> > functions and has 0 for these will be broken in the same way.
> >
> > That said, I'm not really a PCI guy so maybe Bjorn or Maciej has a
> > better idea?
> 
> >From fu740:
>                        ranges = <0x81000000  0x0 0x60080000  0x0
> 0x60080000 0x0 0x10000>,      /* I/O */
>                                  <0x82000000  0x0 0x60090000  0x0
> 0x60090000 0x0 0xff70000>,    /* mem */
>                                  <0x82000000  0x0 0x70000000  0x0
> 0x70000000 0x0 0x1000000>,    /* mem */
>                                  <0xc3000000 0x20 0x00000000 0x20
> 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
> 
> So again, how does one get a 0 address handed out when that's not even
> a valid region according to DT? Is there some legacy stuff that
> ignores the bridge windows?

 It doesn't matter as <asm/pci.h> just sets it as a generic parameter for 
the platform, reflecting the limitation of PCI core, which in the course 
of the discussion referred was found rather infeasible to remove.  The 
FU740 does not decode to PCI at 0, but another RISC-V device could.  And I 
think that DT should faithfully describe hardware and not our software 
limitations.

 Mind that PCI has originated from the x86 world where decoding low 24-bit 
memory space to ISA has been implied (implicitly decoded on PCI systems by 
the southbridge) for areas not decoded to DRAM by the memory controller. 
So the inability of our PCI core to handle MMIO at 0 did not matter at the 
time it was introduced as the value of 0 would never be used for a memory 
BAR.

  Maciej
