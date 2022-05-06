Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9272F51D439
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390428AbiEFJYs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 05:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390401AbiEFJYn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 05:24:43 -0400
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 02:20:58 PDT
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0866564BE7;
        Fri,  6 May 2022 02:20:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 93A8D2B0562D;
        Fri,  6 May 2022 05:12:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 06 May 2022 05:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651828333; x=
        1651835533; bh=G6gyLdn77rvfE254bKTLUge+Op3KXd37yTLdohreqqM=; b=v
        QKeAQx1x9oi9rnTQnxWzQZ3vTa1sCKU3qAfK8BUdnTNglj/iKAYlugS8ZO/zk5fZ
        DfF7J1EiEgVn1bVYrjCqLYS3iirT+M/yZbaX7X/uei2Gb3LNEQ7gNa/6aO4lyi6K
        Tt7s1lCuwd/NrqgJIxoWaYMl29GOUzitCCOr5c2z9gRbiPjvVQLp/zABVxIqq2ZK
        AaY9nkTVzG/mRRGYLVAR8bBcR5nX8PaiHT4MAiZq+H0Xwj5TbLVla4dy88/3+1AN
        1wI0EAxFufJY3W8/p05bkAWVyXVer+YeXe+Ib7meLr1qgWB/FfkXpkAKjyHMQsJ3
        7g4mWCiNAG2aqihJux0IA==
X-ME-Sender: <xms:YuZ0YjLV7ehbq11Iew8UcQGjF5dzNVZmWTCB44jSQAUnrEzMUanDNw>
    <xme:YuZ0YnLO3AhBi-8UDTh2IshOkP29SbDuTpdLzRv7EABfM46yVxKyoWYDYhcgeRQCS
    77vC9WxTNt6pMrOhv0>
X-ME-Received: <xmr:YuZ0Yruq9kszH8K6PStFW0G6vBqLXoDlJzZGTzPxfq_14sas55UK-gUHN-Zh2nfpt0s4gg2KHxVH05i8KORm6pMmTETF2ks5atM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:YuZ0YsYfsshGe5L3c7ZGNomVPUHUMo_s6qgakvJ4OzSu-3gGhre-ZQ>
    <xmx:YuZ0YqYvL7cbpdbLSaNh38uTGj9Rc92MFhzYVkQe0DbODJiFYPgAcA>
    <xmx:YuZ0YgAK1cXBpunCnPwlHEy_DcU5yqhXavJmM9Za0lR2vtG4vS6RVA>
    <xmx:beZ0YvPqIgZVZC0ItH0ne5dg6_12BUITfxVdxuoceofiAb6SMND9K6LMeBg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 May 2022 05:11:59 -0400 (EDT)
Date:   Fri, 6 May 2022 19:12:06 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Arnd Bergmann <arnd@kernel.org>,
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
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
In-Reply-To: <20220505195342.GA509942@bhelgaas>
Message-ID: <22bec167-241f-2cbe-829f-a3f65e40e71@linux-m68k.org>
References: <20220505195342.GA509942@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Thu, 5 May 2022, Bjorn Helgaas wrote:

> On Thu, May 05, 2022 at 07:39:42PM +0200, Arnd Bergmann wrote:
> > On Thu, May 5, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, May 04, 2022 at 11:31:28PM +0200, Arnd Bergmann wrote:
> > > >
> > > > The main goal is to avoid c), which is what happens on s390, but
> > > > can also happen elsewhere. Catching b) would be nice as well,
> > > > but is much harder to do from generic code as you'd need an
> > > > architecture specific inline asm statement to insert a ex_table
> > > > fixup, or a runtime conditional on each access.
> > >
> > > Or s390 could implement its own inb().
> > >
> > > I'm hearing that generic powerpc kernels have to run both on machines
> > > that have I/O port space and those that don't.  That makes me think
> > > s390 could do something similar.
> > 
> > No, this is actually the current situation, and it makes absolutely no
> > sense. s390 has no way of implementing inb()/outb() because there
> > are no instructions for it and it cannot tunnel them through a virtual
> > address mapping like on most of the other architectures. (it has special
> > instructions for accessing memory space, which is not the same as
> > a pointer dereference here).
> > 
> > The existing implementation gets flagged as a NULL pointer dereference
> > by a compiler warning because it effectively is.
> 
> I think s390 currently uses the inb() in asm-generic/io.h, i.e.,
> "__raw_readb(PCI_IOBASE + addr)".  I understand that's a NULL pointer
> dereference because the default PCI_IOBASE is 0.
> 
> I mooted a s390 inb() implementation like "return ~0" because that's
> what happens on most arches when there's no device to respond to the
> inb().
> 
> The HAS_IOPORT dependencies are fairly ugly IMHO, and they clutter
> drivers that use I/O ports in some cases but not others.  But maybe
> it's the most practical way.
> 

Do you mean, "the most practical way to avoid a compiler warning on s390"? 
What about "#pragma GCC diagnostic ignored"?
