Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6650851B019
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 23:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358312AbiEDVMV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiEDVMU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 17:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2AC4ECF8;
        Wed,  4 May 2022 14:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED0AA6193E;
        Wed,  4 May 2022 21:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F213FC385A4;
        Wed,  4 May 2022 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651698522;
        bh=y1eZ0VyTuh3OSu3SZE5hnm+6Lqgi7WUL9wuM4x9LDoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OV+zeMEqAJx67x4OYYs/T+PwaB9EPFjKfNsjZzrWwMVM3NvLvNFpPf0wDtRgV6hPg
         C/vW0RHXE+D3VHZkPbIlT7vV9H8IzZjwKHGMG7joXJdlZZ7WJg8oDJqQBcpyc4rw/O
         yxAB78m6HEpQDrzbacEayJr8iiRcV1EWi7mSGZxb5IDhBXSg0dvOB0Jpz0xpdKT8q1
         53W71wtG3ZAAJTFq4C2Bw331IYIMqmF+azzr+0ky2kC+20quz/B/hGbW52VPMkvf2m
         sc7xISbNbAO/Ktfv/RlrnLm3f7ClaHPrrdpfMsEfr0tf1mKOlzAyEBnIbIHem9sEJj
         ZVekgou/eHQhA==
Date:   Wed, 4 May 2022 16:08:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
Message-ID: <20220504210840.GA469916@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-2-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:49:59PM +0200, Niklas Schnelle wrote:
> We introduce a new HAS_IOPORT Kconfig option to indicate support for
> I/O Port access. In a future patch HAS_IOPORT=n will disable compilation
> of the I/O accessor functions inb()/outb() and friends on architectures
> which can not meaningfully support legacy I/O spaces such as s390 or
> where such support is optional. 

So you plan to drop inb()/outb() on architectures where I/O port space
is optional?  So even platforms that have I/O port space may not be
able to use it?

This feels like a lot of work where the main benefit is to keep
Kconfig from offering drivers that aren't of interest on s390.

Granted, there may be issues where inb()/outb() does the wrong thing
such as dereferencing null pointers when I/O port space isn't
implemented.  I think that's a defect in inb()/outb() and could be
fixed there.

Bjorn
