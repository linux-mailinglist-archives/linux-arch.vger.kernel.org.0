Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0379B532B79
	for <lists+linux-arch@lfdr.de>; Tue, 24 May 2022 15:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiEXNmo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 May 2022 09:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiEXNmn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2022 09:42:43 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111475226;
        Tue, 24 May 2022 06:42:41 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24ODgDUG022736;
        Tue, 24 May 2022 22:42:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24ODgDUG022736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653399734;
        bh=aNLlIgPVqKG5chGBjgSqnkX4433JxjcWB7yJEVQZ+Gg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vXA8HrUWNsrcMbb4jjxlOaE1UOW4nzjC8LOPdbOMXac6+lkDf8ercmWRWQ6PntFhp
         lbAfJ7j+CQ2UH7nNTb2juSxDe9MRJtGGZ6aySjIrlfVlcX9sJSj0BVCm/FTEkEAEbw
         A3FQPgOVjUU/yzKOkS2SqKMP52kVy5IEdmzSXSipe+inDpK4wNAA2xuR9MR32X2bYd
         de/lBb9qz4JB5gK5mtbgS7x4URxRknF7H6BevFWGGucM4329GlHTvZRGpAN6u/qHt5
         jRTks2KxEk9Lxq4w8hPRb/lid7BQBgy9Fo/YcgPj+aV9bw+6GW5vkSONg8kGGvsLzU
         PIUGgvvPbp5RQ==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id n8so15901205plh.1;
        Tue, 24 May 2022 06:42:13 -0700 (PDT)
X-Gm-Message-State: AOAM532fDD7fTgrP2PSZWbA+u73O7vrxW/J+2a+2RkvgM1c2OOfz5JLb
        SyP6IgYnglXAMWGxmPBxAYDepk5z1FlvutCIXJo=
X-Google-Smtp-Source: ABdhPJyTdv6DT7AK41vY70QzhcMH2A38iaGQn1upGmFmPJo+2BcK+NmA7eL9uIW06HJVa028vlOfajtpPNm4sy2hH34=
X-Received: by 2002:a17:90a:e004:b0:1e0:7a66:fb3a with SMTP id
 u4-20020a17090ae00400b001e07a66fb3amr2891041pjy.119.1653399732689; Tue, 24
 May 2022 06:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-2-alexandr.lobakin@intel.com> <CAK7LNAT3QTfkYLFTBKLxghY_gBQZmud3-4UJMK3tA9eOV4UeTg@mail.gmail.com>
 <20220524113337.4128239-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220524113337.4128239-1-alexandr.lobakin@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 22:40:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQus0vcWLCgSdMZNcYKam4fKYj9c8Zrb3HggZ7dTBUrxQ@mail.gmail.com>
Message-ID: <CAK7LNAQus0vcWLCgSdMZNcYKam4fKYj9c8Zrb3HggZ7dTBUrxQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] modpost: fix removing numeric suffixes
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        live-patching@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 24, 2022 at 8:34 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: Masahiro Yamada <masahiroy@kernel.org>
> Date: Tue, 24 May 2022 03:04:00 +0900
>
> > On Thu, Feb 10, 2022 at 3:59 AM Alexander Lobakin
> > <alexandr.lobakin@intel.com> wrote:
> > >
> > > `-z unique-symbol` linker flag which is planned to use with FG-KASLR
> > > to simplify livepatching (hopefully globally later on) triggers the
> > > following:
> > >
> > > ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL
> > >
> > > The reason is that for now the condition from remove_dot():
> > >
> > > if (m && (s[n + m] == '.' || s[n + m] == 0))
> > >
> > > which was designed to test if it's a dot or a '\0' after the suffix
> > > is never satisfied.
> > > This is due to that `s[n + m]` always points to the last digit of a
> > > numeric suffix, not on the symbol next to it (from a custom debug
> > > print added to modpost):
> > >
> > > param_set_uint.0, s[n + m] is '0', s[n + m + 1] is '\0'
> > >
> > > So it's off-by-one and was like that since 2014.
> > > Fix this for the sake of upcoming features, but don't bother
> > > stable-backporting, as it's well hidden -- apart from that LD flag,
> > > can be triggered only by GCC LTO which never landed upstream.
> > >
> > > Fixes: fcd38ed0ff26 ("scripts: modpost: fix compilation warning")
> > > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > ---
> > >  scripts/mod/modpost.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > index 6bfa33217914..4648b7afe5cc 100644
> > > --- a/scripts/mod/modpost.c
> > > +++ b/scripts/mod/modpost.c
> > > @@ -1986,7 +1986,7 @@ static char *remove_dot(char *s)
> > >
> > >         if (n && s[n]) {
> > >                 size_t m = strspn(s + n + 1, "0123456789");
> > > -               if (m && (s[n + m] == '.' || s[n + m] == 0))
> > > +               if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
> > >                         s[n] = 0;
> > >
> > >                 /* strip trailing .lto */
> > > --
> > > 2.34.1
> > >
> >
> > This trivial patch has not been picked up yet.
> >
> > I can apply this to my tree, if you want.
>
> It's a good idea, I'd like to!
> I don't use `-z unique-symbol` for FG-KALSR anymore*, but this fix
> is not directly related to it and can be taken independently.
> Should I change the commit message or it's ok to take it as it is?


I am fine with either way.

If you want to resubmit this with a fresh commit log,
please send it to:
  linux-kbuild@vger.kernel.org

Then, I will take care of it in this MW.

Thanks.




> >
> > Please let me know your thoughts.
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
> * I'm planning to submit a new rev of FG-KASLR series soon, but
> since I'm too busy with XDP for now, it will happen no sooner than
> in a couple months =\
>
> Thanks!
> Al



-- 
Best Regards
Masahiro Yamada
