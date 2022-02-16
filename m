Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766F44B8C30
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiBPPPg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 10:15:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiBPPPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 10:15:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C521D11C0F;
        Wed, 16 Feb 2022 07:15:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5D49C218B0;
        Wed, 16 Feb 2022 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645024521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBnvgUiufkd6hqXyIL1xCUzZ9EdBPJ7jQt3pk+22Jeo=;
        b=aWHBGySjkoi4X4eJw6em22aIBrUvu9NxLgBGA1YPe5teGkVd+OZMbfz5mAR/H5p27cqtNr
        eTyibmLvFW46B/0440TTtOsAILpkMgsqB/KGMtndC8IzoufDHI25QQen3Or6hJ/HuWla6K
        Pa5Mx18v2FogkqbxvqZV2A45oG5hbUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645024521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBnvgUiufkd6hqXyIL1xCUzZ9EdBPJ7jQt3pk+22Jeo=;
        b=LP1Mp5P/8Rc3AyVBb8kXt+yBGl6ouToT79WXn4Nyw3u61X15U3AEuc87d4w0SeVJ1668cR
        KD0RqNXhlm6bqmAA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBB23A3B83;
        Wed, 16 Feb 2022 15:15:20 +0000 (UTC)
Date:   Wed, 16 Feb 2022 16:15:20 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     =?UTF-8?Q?F=C4=81ng-ru=C3=AC_S=C3=B2ng?= <maskray@google.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
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
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
 unique-symbol` is available
In-Reply-To: <20220211183529.q7qi2qmlyuscxyto@treble>
Message-ID: <alpine.LSU.2.21.2202161606430.1475@pobox.suse.cz>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-3-alexandr.lobakin@intel.com> <20220211174130.xxgjoqr2vidotvyw@treble> <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com>
 <20220211183529.q7qi2qmlyuscxyto@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1678380546-2016212218-1645024395=:1475"
Content-ID: <alpine.LSU.2.21.2202161614020.1475@pobox.suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678380546-2016212218-1645024395=:1475
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LSU.2.21.2202161614021.1475@pobox.suse.cz>

On Fri, 11 Feb 2022, Josh Poimboeuf wrote:

> On Fri, Feb 11, 2022 at 10:05:02AM -0800, Fāng-ruì Sòng wrote:
> > On Fri, Feb 11, 2022 at 9:41 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Wed, Feb 09, 2022 at 07:57:39PM +0100, Alexander Lobakin wrote:
> > > > Position-based search, which means that if there are several symbols
> > > > with the same name, the user needs to additionally provide the
> > > > "index" of a desired symbol, is fragile. For example, it breaks
> > > > when two symbols with the same name are located in different
> > > > sections.
> > > >
> > > > Since a while, LD has a flag `-z unique-symbol` which appends
> > > > numeric suffixes to the functions with the same name (in symtab
> > > > and strtab). It can be used to effectively prevent from having
> > > > any ambiguity when referring to a symbol by its name.
> > >
> > > In the patch description can you also give the version of binutils (and
> > > possibly other linkers) which have the flag?
> > 
> > GNU ld>=2.36 supports -z unique-symbol. ld.lld doesn't support -z unique-symbol.
> > 
> > I subscribe to llvm@lists.linux.dev and happen to notice this message
> > (can't keep up with the changes...)
> > I am a bit concerned with this option and replied last time on
> > https://lore.kernel.org/r/20220105032456.hs3od326sdl4zjv4@google.com
> > 
> > My full reasoning is on
> > https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#z-unique-symbol
> 
> Ah, right.  Also discussed here:
> 
>   https://lore.kernel.org/all/20210123225928.z5hkmaw6qjs2gu5g@google.com/T/#u
>   https://lore.kernel.org/all/20210125172124.awabevkpvq4poqxf@treble/
> 
> I'm not qualified to comment on LTO/PGO stability issues, but it doesn't
> sound good.  And we want to support livepatch for LTO kernels.

Hm, bear with me, because I am very likely missing something which is 
clear to everyone else...

Is the stability really a problem for the live patching (and I am talking 
about the live patching only here. It may be a problem elsewhere, but I am 
just trying to understand.)? I understand that two different kernel builds 
could have a different name mapping between the original symbols and their 
unique renames. Not nice. But we can prepare two different live patches 
for these two different kernels. Something one would like to avoid if 
possible, but it is not impossible. Am I missing something?
 
> Also I realized that this flag would have a negative effect on
> kpatch-build, as it currently does its analysis on .o files.  So it
> would have to figure out how to properly detect function renames, to
> avoid patching the wrong function for example.

Yes, that is unfortunate. And not only for kpatch-build.

> And if LLD doesn't plan to support the flag then it will be a headache
> for livepatch (and the kernel in general) to deal with the divergent
> configs.

True.

The position-based approach clearly shows its limits. I like <file+func> 
approach based on kallsyms tracking, that you proposed elsewhere in the 
thread, more.

Miroslav
--1678380546-2016212218-1645024395=:1475--
