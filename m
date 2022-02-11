Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC34B2C66
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 19:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352474AbiBKSFU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 13:05:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352426AbiBKSFR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 13:05:17 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B9D4E
        for <linux-arch@vger.kernel.org>; Fri, 11 Feb 2022 10:05:14 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id o19so27121395ybc.12
        for <linux-arch@vger.kernel.org>; Fri, 11 Feb 2022 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bQCacAqu6AD3L5T1l4m/Dw/zcsi+Jlaw1qBbQHQJ5n8=;
        b=kLbjkhoYZDNiub72bMg9ZqtXNwhvLpNO+yW5ASu4uizUywougb5IgTN3A9j7vUzPCV
         ilbbSa1H6KXx7RaT+aD1shRHdR+F7jQhMY0UN+PZf0soTx4mDFCLBkN12LSn14MUXJMC
         bNY8Rs4cIcMre3iQE1bY1Ur1vW/u69KzewdCW2nJGe9IgAG6nvcuHwrTzvL46TewNu1r
         U+zUpHn0Hef8B9vTL4zTS59BQuQ6aJP1KPP4mXq58IjfIWdD1mYgt7ZNd5gv/gf0TIGs
         jwIuFW4tMTPcYA5dGPBW7M+tfiAM/VQkuwm1hqfpeOplL17TdnC+4+tTNbwqFwdIJkQ3
         7MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bQCacAqu6AD3L5T1l4m/Dw/zcsi+Jlaw1qBbQHQJ5n8=;
        b=v2kECMnFY/Ha41MB6lHn5bbqB8b6SxGzA6/Y12/5lByvF9gC892gubFiDBBFenGYc0
         1UcjzcfHN95TlwTAM3MD6yvqjioNrmAbu54gs40l2wdWZssIQgML9n+UuYI63qUT9AK8
         JtLT+V0bljjunkPKGpplIXgYT/KvwETeUmsghME+uaD7h/xZdECmfvyRFkmXuy//QhX2
         GbRFLNhbQQVXmKf+A4sqX3ejbHtj0bOdWGfX96W0sYaSKQQaBSBiNPc79wCVHqSVx1OU
         eqL2fl87DC0hcrhoFOlZCr5FoHEfqkxiZxR++9YEekQ9jk4E0f5MtSrWmQ3Yl7b6e8cp
         77kA==
X-Gm-Message-State: AOAM533vHdO9t2E+OXdDsWjTUAqkjcYDwAeJ6fQdiXVwgnB352fbltDc
        mrKrJ5HIsJwaEftms0JhXBZ37SVa3RmVnviGNw8Exg==
X-Google-Smtp-Source: ABdhPJwqwn2kG4R0P3X04f1gmCys5jwU2Zxegllqb4PCZmn/bHZrdEndwiA5mCsWiE6z6c7BUFdhF4f1GQkwwBkxWBE=
X-Received: by 2002:a81:ce09:: with SMTP id t9mr2890290ywi.254.1644602713368;
 Fri, 11 Feb 2022 10:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-3-alexandr.lobakin@intel.com> <20220211174130.xxgjoqr2vidotvyw@treble>
In-Reply-To: <20220211174130.xxgjoqr2vidotvyw@treble>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Fri, 11 Feb 2022 10:05:02 -0800
Message-ID: <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com>
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
 unique-symbol` is available
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
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
        Masahiro Yamada <masahiroy@kernel.org>,
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
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 11, 2022 at 9:41 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Feb 09, 2022 at 07:57:39PM +0100, Alexander Lobakin wrote:
> > Position-based search, which means that if there are several symbols
> > with the same name, the user needs to additionally provide the
> > "index" of a desired symbol, is fragile. For example, it breaks
> > when two symbols with the same name are located in different
> > sections.
> >
> > Since a while, LD has a flag `-z unique-symbol` which appends
> > numeric suffixes to the functions with the same name (in symtab
> > and strtab). It can be used to effectively prevent from having
> > any ambiguity when referring to a symbol by its name.
>
> In the patch description can you also give the version of binutils (and
> possibly other linkers) which have the flag?

GNU ld>=3D2.36 supports -z unique-symbol. ld.lld doesn't support -z unique-=
symbol.

I subscribe to llvm@lists.linux.dev and happen to notice this message
(can't keep up with the changes...)
I am a bit concerned with this option and replied last time on
https://lore.kernel.org/r/20220105032456.hs3od326sdl4zjv4@google.com

My full reasoning is on
https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#z-unique-symb=
ol

> > Check for its availability and always prefer when the livepatching
> > is on. It can be used unconditionally later on after broader testing
> > on a wide variety of machines, but for now let's stick to the actual
> > CONFIG_LIVEPATCH=3Dy case, which is true for most of distro configs
> > anyways.
>
> Has anybody objected to just enabling it for *all* configs, not just for
> livepatch?
>
> I'd much prefer that: the less "special" livepatch is (and the distros
> which enable it), the better.  And I think having unique symbols would
> benefit some other components.
>
> > +++ b/kernel/livepatch/core.c
> > @@ -143,11 +143,13 @@ static int klp_find_callback(void *data, const ch=
ar *name,
> >       args->count++;
> >
> >       /*
> > -      * Finish the search when the symbol is found for the desired pos=
ition
> > -      * or the position is not defined for a non-unique symbol.
> > +      * Finish the search when unique symbol names are enabled
> > +      * or the symbol is found for the desired position or the
> > +      * position is not defined for a non-unique symbol.
> >        */
> > -     if ((args->pos && (args->count =3D=3D args->pos)) ||
> > -         (!args->pos && (args->count > 1)))
> > +     if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL) ||
> > +         (args->pos && args->count =3D=3D args->pos) ||
> > +         (!args->pos && args->count > 1))
> >               return 1;
>
> There's no real need to do this.  The code already works as-is, even if
> there are no unique symbols.
>
> Even if there are no duplicates, there's little harm in going through
> all the symbols anyway, to check for errors just in case something
> unexpected happened with the linking (unexpected duplicate) or the patch
> creation (unexpected sympos).  It's not a hot path, so performance isn't
> really a concern.
>
> When the old linker versions eventually age out, we can then go strip
> out all the sympos stuff.
>
> > @@ -169,6 +171,13 @@ static int klp_find_object_symbol(const char *objn=
ame, const char *name,
> >       else
> >               kallsyms_on_each_symbol(klp_find_callback, &args);
> >
> > +     /*
> > +      * If the LD's `-z unique-symbol` flag is available and enabled,
> > +      * sympos checks are not relevant.
> > +      */
> > +     if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL))
> > +             sympos =3D 0;
> > +
>
> Similarly, I don't see a need for this.  If the patch is legit then
> sympos should already be zero.  If not, an error gets reported and the
> patch fails to load.
>
> --
> Josh
>
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
