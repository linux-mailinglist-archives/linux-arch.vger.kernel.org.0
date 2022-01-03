Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D715D48319E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 14:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiACNzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 08:55:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACNzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 08:55:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EDE5E2113D;
        Mon,  3 Jan 2022 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641218144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bp7Ls3jIW7OioFy5buHPAXWHWAQcKF9WssyJmKxPbcg=;
        b=ceCleNSEp/E5buzpPY3bEceRgi7vPX6LyXo9jAQXAaWU5s21DTY9xp4z8cl2wm9fVzILtM
        q/8hOLECrn9dX1HxtE+Bapekrx5Yhsrxd+YNutzZwYuooC0KwhAJKjz+mxK5dQ+X0m/KQe
        Wxk/79WuOZu7qvROwMjALGXZabC/bNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641218144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bp7Ls3jIW7OioFy5buHPAXWHWAQcKF9WssyJmKxPbcg=;
        b=zIL7Pnzdd/6fJg54rccwAz40rGXhxdEhihowTu7q3ad6bgpciI8rB5JWx8sbGxN/4/XCGN
        CPbCrCrb0B9KjJDA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07708A3B81;
        Mon,  3 Jan 2022 13:55:43 +0000 (UTC)
Date:   Mon, 3 Jan 2022 14:55:42 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     =?UTF-8?Q?F=C4=81ng-ru=C3=AC_S=C3=B2ng?= <maskray@google.com>
cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
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
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available
 to nuke pos-based search
In-Reply-To: <CAFP8O3K1mkiCGMTEeuSifZtr2piHsKTjP5TOA25nqpv2SrbzYQ@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2201031447140.15051@pobox.suse.cz>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com> <20211223002209.1092165-3-alexandr.lobakin@intel.com> <Yc2Tqc69W9ukKDI1@zn.tnic> <CAFP8O3K1mkiCGMTEeuSifZtr2piHsKTjP5TOA25nqpv2SrbzYQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1678380546-1741337215-1641218143=:15051"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678380546-1741337215-1641218143=:15051
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Dec 2021, Fāng-ruì Sòng wrote:

> On Thu, Dec 30, 2021 at 3:11 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Thu, Dec 23, 2021 at 01:21:56AM +0100, Alexander Lobakin wrote:
> > > [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available to nuke pos-based search

...

> Apologies since I haven't read the patch series.
> 
> The option does not exist in ld.lld and I am a bit concerning about
> its semantics: https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#z-unique-symbol
> 
> I thought that someone forwarded my comments (originally posted months
> on a feature request ago) here but seems not.
> (I am a ld.lld maintainer.)

Do you mean 
https://lore.kernel.org/all/20210123225928.z5hkmaw6qjs2gu5g@google.com/T/#u 
?

Unfortunately, it did not lead anywhere. I think that '-z unique-symbol' 
option should work fine as long as the live patching is concerned. Maybe I 
misunderstood but your concerns mentioned at the blog do not apply. The 
stability is not an issue for us since we (KLP) always work with already 
built and fixed kernel. And(at least) GCC already uses number suffices for 
IPA clones and it has not been a problem anywhere.

Am I wrong?

Thanks

Miroslav 
--1678380546-1741337215-1641218143=:15051--
