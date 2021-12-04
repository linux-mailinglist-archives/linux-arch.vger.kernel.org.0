Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E801468360
	for <lists+linux-arch@lfdr.de>; Sat,  4 Dec 2021 09:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384301AbhLDIfQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Dec 2021 03:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384278AbhLDIfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Dec 2021 03:35:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F516C061751;
        Sat,  4 Dec 2021 00:31:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C83AB807E4;
        Sat,  4 Dec 2021 08:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97A2C341DD;
        Sat,  4 Dec 2021 08:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638606707;
        bh=sjxIy15k4SzsvZ32dYqzU6rAx1xmDB5EFetzASD4t8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AO5+j9PPnG3pZTh7eQqBRXgGWXRfdKfANVZmZzYPBGST3AiaWOuZZAmrGej/JC000
         S9adzJQ0yWZxgZnTtFpgzPBCV3LOt3UqGXa0wQ0oiNe7xzU5/dneblUpSWPPux74t5
         nSGM6SL5MLvep7TCSpU4usx0a4m8Jf5X+1tUw2Gh2g8oThQ9DD/76BkB+zZwGOERsZ
         G16/r7EsWJBQR4SqTNUlfC0D+21VAEUddGcD+g4OynQIwbEA3iqMl9K5d0JZE6YKCc
         QUfoWyU+yAt6iMuzzQZZbsvYOA/2IOeqH2CfjYIh/gCXfVnY3PM770wZxbbMVd1bbd
         t4uWVgZZA0tGQ==
Received: by mail-oi1-f179.google.com with SMTP id be32so10635509oib.11;
        Sat, 04 Dec 2021 00:31:46 -0800 (PST)
X-Gm-Message-State: AOAM533AIha0bNRtuxlmXfxTGLTseLawaCTO7b218uyjQTftDMFzq21F
        DeVIU61usP9FXAXFP9ub/VJW4nKaH0E+5gWOT6g=
X-Google-Smtp-Source: ABdhPJyn4NdGHzLPLyNqpl1/AkUOXDqgnkodOajUO6/cACrbmxliVgYb+PBdbCBD0mfwx7JzHi4Aryi8jeqgWKgstGY=
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr14503710oib.33.1638606705790;
 Sat, 04 Dec 2021 00:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-6-alexandr.lobakin@intel.com> <Yanm6tJ2obi1aKv6@hirez.programming.kicks-ass.net>
 <20211203141051.82467-1-alexandr.lobakin@intel.com> <20211203163424.GK16608@worktop.programming.kicks-ass.net>
 <28856p61-r54s-791n-q6s1-27575s62r2q9@syhkavp.arg>
In-Reply-To: <28856p61-r54s-791n-q6s1-27575s62r2q9@syhkavp.arg>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 4 Dec 2021 09:31:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG-+d-ak9od9z-VxOk9Y+fp_KDSbLP=ns_ZfVEXjrzKsg@mail.gmail.com>
Message-ID: <CAMj1kXG-+d-ak9od9z-VxOk9Y+fp_KDSbLP=ns_ZfVEXjrzKsg@mail.gmail.com>
Subject: Re: [PATCH v8 05/14] x86: conditionally place regular ASM functions
 into separate sections
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, X86 ML <x86@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        live-patching@vger.kernel.org, llvm@lists.linux.dev,
        hjl.tools@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 3 Dec 2021 at 20:46, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Fri, 3 Dec 2021, Peter Zijlstra wrote:
>
> > On Fri, Dec 03, 2021 at 03:10:51PM +0100, Alexander Lobakin wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Date: Fri, 3 Dec 2021 10:44:10 +0100
> > >
> > > > On Thu, Dec 02, 2021 at 11:32:05PM +0100, Alexander Lobakin wrote:
> > > > > Use the newly introduces macros to create unique separate sections
> > > > > for (almost) every "regular" ASM function (i.e. for those which
> > > > > aren't explicitly put into a specific one).
> > > > > There should be no leftovers as input .text will be size-asserted
> > > > > in the LD script generated for FG-KASLR.
> > > >
> > > > *groan*...
> > > >
> > > > Please, can't we do something like:
> > > >
> > > > #define SYM_PUSH_SECTION(name)    \
> > > > .if section == .text              \
> > > > .push_section .text.##name        \
> > > > .else                             \
> > > > .push_section .text               \
> > > > .endif
> > > >
> > > > #define SYM_POP_SECTION() \
> > > > .pop_section
> > > >
> > > > and wrap that inside the existing SYM_FUNC_START*() SYM_FUNC_END()
> > > > macros.
> > >
> > > Ah I see. I asked about this in my previous mail and you replied
> > > already (: Cool stuff, I'll use it, it simplifies things a lot.
> >
> > Note, I've no idea if it works. GAS and me aren't really on speaking
> > terms. It would be my luck for that to be totally impossible, hjl?
>
> Surely this would do it:
>
> http://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=451133cefa839104
>

That seems rather useful, actually. It will also fix a problem with
subsections, which are sometimes difficult to construct from a macro,
as they cannot be created using pushsection/popsection unless you know
the current section name, and the alternative syntax (.subsection /
.previous) does not permit nesting. This makes their use from a macro
risky, given that it may not be obvious to the macro's caller that it
uses a subsection under the hood.
