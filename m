Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51990C422B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfJAVAA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 17:00:00 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43984 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfJAVAA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 17:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OvremvH5B8AyvNHHwXgBILQ+CF0VODoow+40l4kJHXI=; b=Iag3wI95n0QQk7hUYfmsZV/1P
        FciJvA9JlYjtXtbb0P3AOt4/FN9P15EXiiATbN+zTulY7EjEDAwTOVKvfBaqeCVSrI1r34uuI18gF
        piB6S7zmhW9I/SA3qLCEgcxT3T4bgLFlaQmyyUyAElEdOnKwVZ9RrjHgw+X8zFclOJk64gp5o3/6w
        iVyIfaTzRl3UEtxxY8IFYPFry1p2qcu748NEmnPo//8Tt28AfyPOAHmqx0AF9HT2L/yPsC051opPf
        PAoXRFVZzxp3Sr3sG+nzSf3ymz+HBmRCclKIuci0rPE43WHcskhk4r1ypPH9UEtMsqeztx1hYY3AS
        JAkYMsOOA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46410)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFPFI-0004dA-85; Tue, 01 Oct 2019 21:59:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFPFC-0008V1-KP; Tue, 01 Oct 2019 21:59:38 +0100
Date:   Tue, 1 Oct 2019 21:59:38 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191001205938.GM25745@shell.armlinux.org.uk>
References: <20190930121803.n34i63scet2ec7ll@willie-the-truck>
 <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
 <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk>
 <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 01, 2019 at 01:21:44PM -0700, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 11:14 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Oct 01, 2019 at 11:00:11AM -0700, Nick Desaulniers wrote:
> > > On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> > > > > I apologize; I don't mean to be difficult.  I would just like to avoid
> > > > > surprises when code written with the assumption that it will be
> > > > > inlined is not.  It sounds like we found one issue in arm32 and one in
> > > > > arm64 related to outlining.  If we fix those two cases, I think we're
> > > > > close to proceeding with Masahiro's cleanup, which I view as a good
> > > > > thing for the health of the Linux kernel codebase.
> > > >
> > > > Except, using the C preprocessor for this turns the arm32 code into
> > > > yuck:
> > > >
> > > > 1. We'd need to turn get_domain() and set_domain() into multi-line
> > > >    preprocessor macro definitions, using the GCC ({ }) extension
> > > >    so that get_domain() can return a value.
> > > >
> > > > 2. uaccess_save_and_enable() and uaccess_restore() also need to
> > > >    become preprocessor macro definitions too.
> > > >
> > > > So, we end up with multiple levels of nested preprocessor macros.
> > > > When something goes wrong, the compiler warning/error message is
> > > > going to be utterly _horrid_.
> > >
> > > That's why I preferred V1 of Masahiro's patch, that fixed the inline
> > > asm not to make use of caller saved registers before calling a
> > > function that might not be inlined.
> >
> > ... which I objected to based on the fact that this uaccess stuff is
> > supposed to add protection against the kernel being fooled into
> > accessing userspace when it shouldn't.  The whole intention there is
> > that [sg]et_domain(), and uaccess_*() are _always_ inlined as close
> > as possible to the call site of the accessor touching userspace.
> 
> Then use the C preprocessor to force the inlining.  I'm sorry it's not
> as pretty as static inline functions.
> 
> >
> > Moving it before the assignments mean that the compiler is then free
> > to issue memory loads/stores to load up those registers, which is
> > exactly what we want to avoid.
> >
> >
> > In any case, I violently disagree with the idea that stuff we have
> > in header files should be permitted not to be inlined because we
> > have soo much that is marked inline.
> 
> So there's a very important subtly here.  There's:
> 1. code that adds `inline` cause "oh maybe it would be nice to inline
> this, but if it isn't no big deal"
> 2. code that if not inlined is somehow not correct.
> 3. avoid ODR violations via `static inline`
> 
> I'll posit that "we have soo much that is marked inline [is
> predominantly case 1 or 3, not case 2]."  Case 2 is a code smell, and
> requires extra scrutiny.
> 
> > Having it moved out of line,
> > and essentially the same function code appearing in multiple C files
> > is really not an improvement over the current situation with excessive
> > use of inlining.  Anyone who has looked at the code resulting from
> > dma_map_single() will know exactly what I'm talking about, which is
> > way in excess of the few instructions we have for the uaccess_* stuff
> > here.
> >
> > The right approach is to move stuff out of line - and by that, I
> > mean _actually_ move the damn code, so that different compilation
> > units can use the same instructions, and thereby gain from the
> > whole point of an instruction cache.
> 
> And be marked __attribute__((noinline)), otherwise might be inlined via LTO.
> 
> >
> > The whole "let's make inline not really mean inline" is nothing more
> > than a band-aid to the overuse (and abuse) of "inline".
> 
> Let's triple check the ISO C11 draft spec just to be sure:
> § 6.7.4.6: A function declared with an inline function specifier is an
> inline function. Making a
> function an inline function suggests that calls to the function be as
> fast as possible.
> The extent to which such suggestions are effective is
> implementation-defined. 139)
> 139) For example, an implementation might never perform inline
> substitution, or might only perform inline
> substitutions to calls in the scope of an inline declaration.
> § J.3.8 [Undefined Behavior] Hints: The extent to which suggestions
> made by using the inline function specifier are effective (6.7.4).
> 
> My translation:
> "Please don't assume inline means anything."
> 
> For the unspecified GNU C extension __attribute__((always_inline)), it
> seems to me like it's meant more for performing inlining (an
> optimization) at -O0.  Whether the compiler warns or not seems like a
> nice side effect, but provides no strong guarantee otherwise.
> 
> I'm sorry that so much code may have been written with that
> assumption, and I'm sorry to be the bearer of bad news, but this isn't
> a recent change.  If code was written under false assumptions, it
> should be rewritten. Sorry.

You may quote C11, but that is not relevent.  The kernel is coded to
gnu89 standard - see the -std=gnu89 flag.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
