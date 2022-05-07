Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1683E51EA9B
	for <lists+linux-arch@lfdr.de>; Sun,  8 May 2022 02:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiEHADo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 May 2022 20:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiEHADn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2022 20:03:43 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E603A2BF9;
        Sat,  7 May 2022 16:59:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 62C585810CD;
        Sat,  7 May 2022 19:59:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 07 May 2022 19:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651967990; x=
        1651975190; bh=QTgRzNLqn7nTVpn4kEmk9hjonN4SIouDolNH8iVgiLs=; b=x
        yhXwE5TnGDXuuNwf54vPo1myGUH3NoA0fbqOh35QFU69RQVVilaeCqHjF4940KGW
        ObQCxFRPvPnismpi8nsZySyqcbu72zxQxx+eLsmlVQKIh8aN2Mac6nsj6wtJHNaa
        EWebIh9iDQOmBp75hegASiIr+LraEUUQQHN/TtU/mWjGf1OH5vKlxzYzxlEy7B7g
        r9dNK0XzD7Za9S2u8mjB85p/tkE3XYzle24fsW3pI/MrTI6I58Jqfuh35WmmvmRE
        GBFK1VnfhrO5G5PO+YBhtHiXZgJ/7MTB3Wjzi80yCETO2PpoyypGdjh7Dig1WtGZ
        y+/DWCIgG0ZchwYn4Uebg==
X-ME-Sender: <xms:7Ad3YgzFozHLPh-Tuvv9Gqa4JW7NHgoXVD6uHnxvGJEZ-tkIihVCDA>
    <xme:7Ad3YkTKyZysYg2yiwmXhP33c2XVZ7wWIz7D3BIhSt0Rngayh0bii6CYLN5SiPksG
    -cNLBt1xruZDjtSVV4>
X-ME-Received: <xmr:7Ad3YiWPtHMCCzEwEeO0M89qLJMqu8cAc2Md3CmzBWr_Ga-NWofXlYyUHOriwh52P-UrqY86yVyM6vrfUu01QnBZ1skBohaDr88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeigddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepfeeiheejvdetgfeitddutefhkeeilefhveehgfdvtdekkedvkeehffdtkeev
    vdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehk
    rdhorhhg
X-ME-Proxy: <xmx:7Ad3Yuice80PD-V4uxHnQ1Erm7oI19uB5cOkarRVxo8MljzuuE853Q>
    <xmx:7Ad3YiADvp59I8imKHk5XlTEJp7UmvBetFQM0RlFZ9BlDwZ444knHQ>
    <xmx:7Ad3YvKwHHBZFwpac1G-LQnfrNPsBIz1Q832CQdz3sq_FGN8sc0f2A>
    <xmx:9gd3Yk2F_FbIkiIJajz3nA0al_jEr6hrURnhe-kUGx-pn8yEEL4ZWg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 May 2022 19:59:34 -0400 (EDT)
Date:   Sun, 8 May 2022 09:59:37 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
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
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
In-Reply-To: <CAK8P3a3tds8O+Gg2nF3MfrVVcmtLbtdQ2TnCJaDYz28cyhhWkg@mail.gmail.com>
Message-ID: <6f33385-5612-7042-e1b3-aa32895e91e0@linux-m68k.org>
References: <20220505195342.GA509942@bhelgaas> <22bec167-241f-2cbe-829f-a3f65e40e71@linux-m68k.org> <105ccec439f709846e82b69cb854ac825d7a6a49.camel@linux.ibm.com> <7dfa7578-039-e132-c573-ad89bd3215@linux-m68k.org>
 <CAK8P3a3tds8O+Gg2nF3MfrVVcmtLbtdQ2TnCJaDYz28cyhhWkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi Arnd,

On Sat, 7 May 2022, Arnd Bergmann wrote:

> On Sat, May 7, 2022 at 2:01 AM Finn Thain <fthain@linux-m68k.org> wrote:
> > On Fri, 6 May 2022, Niklas Schnelle wrote:
> > > On Fri, 2022-05-06 at 19:12 +1000, Finn Thain wrote:
> > > > On Thu, 5 May 2022, Bjorn Helgaas wrote:
> > > > >
> > > > > I mooted a s390 inb() implementation like "return ~0" because that's
> > > > > what happens on most arches when there's no device to respond to the
> > > > > inb().
> > > > >
> > > > > The HAS_IOPORT dependencies are fairly ugly IMHO, and they clutter
> > > > > drivers that use I/O ports in some cases but not others.  But maybe
> > > > > it's the most practical way.
> > > > >
> > > >
> > > > Do you mean, "the most practical way to avoid a compiler warning on
> > > > s390"? What about "#pragma GCC diagnostic ignored"?
> > >
> > > This actually happens with clang.
> >
> > That suggests a clang bug to me. If you believe GCC should behave like
> > clang, then I guess the pragma above really is the one you want. If you
> > somehow feel that the kernel should cater to gcc and clang even where they
> > disagree then you would have to use "#pragma clang diagnostic ignored".
> 
> I don't see how you can blame the compiler for this. On architectures
> with a zero PCI_IOBASE, an inb(0x2f8) literally becomes
> 
>         var = *(u8*)((NULL + 0x2f8);
> 
> If you run a driver that does this, the kernel gets a page fault for
> the NULL page
> and reports an Oops. clang tells you 'warning: performing pointer
> arithmetic on a null pointer has undefined behavior', which is not exactly
> spot on, but close enough to warn you that you probably shouldn't do this. gcc
> doesn't warn here, but it does warn about an array out-of-bounds access when
> you pass such a pointer into memcpy or another string function.
> 

The appeal to UB is weak IMHO. Pointer arithmetic with a zero value is 
unambiguous and the compiler generates the code to implement the expected 
behaviour just fine.

UB is literally an omission in the standard. Well, low level programming 
has always been beyond the scope of C standards. If architectural-level 
code wants to do arithmetic with an arbitrary integer values, and the 
compiler doesn't like it, then the relevant warnings should be disabled 
for those expressions.

> > > Apart from that, I think this would also fall under the same argument as
> > > the original patch Linus unpulled. We would just paint over someting
> > > that we know at compile time won't work:
> > >
> > > https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
> > >
> >
> > I wasn't advocating adding any warnings.
> >
> > If you know at compile time that a driver won't work, the usual solution
> > is scripts/config -d CONFIG_SOME_UNDESIRED_DRIVER. Why is that no
> > longer appropriate for drivers that use IO ports?
> 
> This was never an option, we rely on 'make allmodconfig' to build 
> without warnings on all architectures for finding regressions.

"All modules on all architectures with all compilers and checkers with all 
warnings enabled"? That's not even vaguely realistic.

How about, "All modules on all architectures with a nominated compiler 
with the appropriate warnings enabled."

> Any driver that depends on architecture specific interfaces must not get 
> selected on architectures that don't have those interfaces.
> 

Kconfig always met that need before we got saddled with -Werror.

That suggests to me that we need a "bool CONFIG_WARINGS_INTO_ERRORS" to 
control -Werror, which could be disabled for .config files (like make 
allmodconfig) where it is not helping.
