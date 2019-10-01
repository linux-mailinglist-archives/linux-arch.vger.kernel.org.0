Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F541C4351
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 23:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJAV6u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 17:58:50 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44712 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfJAV6t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 17:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Exk+Gmz2dV80jT3PJWsusPiReJ0a0LJ3sfaKxNGSGAs=; b=0CbGVzawzd0J8yJnlJAJtNZtx
        aHYjA6M45hN2RNGGl6svc1qGVXFNlZmRe+XkXZYzxYCmhh9g+cnCp+exLrZPY10b5RCPaqgOdAuIg
        21JQU8TESfk1Z25L+EG96K5ahGc9Q2jLq/ksCq2Fr85GVTv1ArkPEsUrdBag29MDosivH2Fug/yhM
        FyNSzfaMhSbdot9hxskC7Jmc9gHBbdg01N1kS44HihDJOZhCMEgnaskCtirX90eSRWHxiJkGrWsOy
        jFpCIQJTyaA1nQbCiu7DT87fPQXmxV5zItonExGOWk9A4mmf0FrHveXLFNu4uaSoLzDFgOCUkKqa/
        6/DPmG4ug==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46432)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFQAB-0004y6-9i; Tue, 01 Oct 2019 22:58:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFQA7-000068-VG; Tue, 01 Oct 2019 22:58:27 +0100
Date:   Tue, 1 Oct 2019 22:58:27 +0100
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
Message-ID: <20191001215827.GP25745@shell.armlinux.org.uk>
References: <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
 <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk>
 <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <20191001205938.GM25745@shell.armlinux.org.uk>
 <20191001212608.GN25745@shell.armlinux.org.uk>
 <CAKwvOdmkmdM14BNurK3WwyG3Qc5wOFeajMtQ1D+na9mLfkim+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmkmdM14BNurK3WwyG3Qc5wOFeajMtQ1D+na9mLfkim+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 01, 2019 at 02:32:54PM -0700, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 2:26 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Oct 01, 2019 at 09:59:38PM +0100, Russell King - ARM Linux admin wrote:
> > > On Tue, Oct 01, 2019 at 01:21:44PM -0700, Nick Desaulniers wrote:
> > > > On Tue, Oct 1, 2019 at 11:14 AM Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > The whole "let's make inline not really mean inline" is nothing more
> > > > > than a band-aid to the overuse (and abuse) of "inline".
> > > >
> > > > Let's triple check the ISO C11 draft spec just to be sure:
> > > > § 6.7.4.6: A function declared with an inline function specifier is an
> > > > inline function. Making a
> > > > function an inline function suggests that calls to the function be as
> > > > fast as possible.
> > > > The extent to which such suggestions are effective is
> > > > implementation-defined. 139)
> > > > 139) For example, an implementation might never perform inline
> > > > substitution, or might only perform inline
> > > > substitutions to calls in the scope of an inline declaration.
> > > > § J.3.8 [Undefined Behavior] Hints: The extent to which suggestions
> > > > made by using the inline function specifier are effective (6.7.4).
> > > >
> > > > My translation:
> > > > "Please don't assume inline means anything."
> > > >
> > > > For the unspecified GNU C extension __attribute__((always_inline)), it
> > > > seems to me like it's meant more for performing inlining (an
> > > > optimization) at -O0.  Whether the compiler warns or not seems like a
> > > > nice side effect, but provides no strong guarantee otherwise.
> > > >
> > > > I'm sorry that so much code may have been written with that
> > > > assumption, and I'm sorry to be the bearer of bad news, but this isn't
> > > > a recent change.  If code was written under false assumptions, it
> > > > should be rewritten. Sorry.
> > >
> > > You may quote C11, but that is not relevent.  The kernel is coded to
> > > gnu89 standard - see the -std=gnu89 flag.
> >
> > There's more to this and why C11 is entirely irrelevant.  The "inline"
> > you see in our headers is not the compiler keyword that you find in
> > various C standards, it is a macro that gets expanded to either:
> >
> > #define inline inline __attribute__((__always_inline__)) __gnu_inline \
> >         __maybe_unused notrace
> >
> > or
> >
> > #define inline inline                                    __gnu_inline \
> >         __maybe_unused notrace
> >
> > __gnu_inline is defined as:
> >
> > #define __gnu_inline                    __attribute__((__gnu_inline__))
> >
> > So this attaches the gnu_inline attribute to the function:
> >
> > `gnu_inline'
> >      This attribute should be used with a function that is also declared
> >      with the `inline' keyword.  It directs GCC to treat the function
> >      as if it were defined in gnu90 mode even when compiling in C99 or
> >      gnu99 mode.
> > ...
> >      Since ISO C99 specifies a different semantics for `inline', this
> >      function attribute is provided as a transition measure and as a
> >      useful feature in its own right.  This attribute is available in
> >      GCC 4.1.3 and later.  It is available if either of the
> >      preprocessor macros `__GNUC_GNU_INLINE__' or
> >      `__GNUC_STDC_INLINE__' are defined.  *Note An Inline Function is
> >      As Fast As a Macro: Inline.
> >
> > which is quite clear that C99 semantics do not apply to _this_ inline.
> > The manual goes on to explain:
> >
> >  GCC implements three different semantics of declaring a function
> > inline.  One is available with `-std=gnu89' or `-fgnu89-inline' or when
> > `gnu_inline' attribute is present on all inline declarations, another
> > when `-std=c99', `-std=c11', `-std=gnu99' or `-std=gnu11' (without
> > `-fgnu89-inline'), and the third is used when compiling C++.
> 
> (I wrote the kernel patch for gnu_inline; it only comes into play when
> `inline` appears on a function *also defined as `extern`*).

From what I can tell reading the GCC manual, the patch adding
gnu_inline should have no effect.  Maybe it was written before
-std=gnu89 was in use by the kernel makefiles?

> > I'd suggest gnu90 mode is pretty similar to gnu89 mode, and as we build
> > the kernel in gnu89 mode, that is the inlining definition that is
> > appropriate.
> >
> > When it comes to __always_inline, the GCC manual is the definitive
> > reference, since we use the GCC attribute for that:
> >
> > #define __always_inline                 inline __attribute__((__always_inline__))
> >
> > and I've already quoted what the GCC manual says for always_inline.
> >
> > Arguing about what the C11 spec says about inlining when we aren't
> > using C11 dialect in the kernel, but are using GCC features, does
> > not move the discussion on.
> >
> > Thanks anyway, maybe it will become relevent in the future if we
> > decide to move to C11.
> 
> It's not like the semantics of inline are better specified by an older
> standard, or changed (The only real semantic change involving `inline`
> between ISO C90 and ISO C99 has to do with whether `extern inline`
> emits the function with external linkage as you noted).  But that's
> irrelevant to the discussion.).  I quoted C11 because ctrl+f doesn't
> work for the C90 ISO spec pdf.  C90 spec doesn't even have a section
> on Function Specifiers.  From what I can tell, `inline` wasn't
> specified until ISO C99.
> 
> GNU modes are often modifiers off of ISO C bases; gnu89 corresponds to
> ISO C90.  They may permit the use of features from newer ISO C specs
> and GNU C extensions without warning under -Wpedantic.  There aren't a
> whole lot of semantic differences, at least that I'm aware of.

Right, so GCC had inlining support before ISO C added it (which I
distinctly remember, I've been involved in Linux since 1994.)

Unless ISO C based their definition in some way off GCC's
implementation, I still don't see how quoting ISO C documents
helps this discussion when it's the GCC feature that we're using.

And none of this is relevent anyway if we use the GCC
always_inline extension *which is obviously the right way to
resolve this instance*.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
