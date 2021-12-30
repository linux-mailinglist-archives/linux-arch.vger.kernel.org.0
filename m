Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3738B481B9C
	for <lists+linux-arch@lfdr.de>; Thu, 30 Dec 2021 12:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhL3LKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Dec 2021 06:10:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54450 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235057AbhL3LKf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Dec 2021 06:10:35 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C816D1EC04FB;
        Thu, 30 Dec 2021 12:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640862630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WjXaYdKmX/cmmPvuYrY2hWWHNh1ZAY2fZFweo/fg3nQ=;
        b=oTPY28eQr2gsdWN44FWwvQo3AzqwsMEMjqP2W17h+qVzaVI/w4zw1Pk+oK6zD9/0/ax1X7
        ahu86OoibFH24lv+h3YPgrrRta+OKlHmhVXZUip8Rhws/cSrF15Vws3iT28NEVxpQBvUI2
        KU4KpPig8rKLV1S1VhX9WgkGdpDCAP4=
Date:   Thu, 30 Dec 2021 12:10:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
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
Message-ID: <Yc2Tqc69W9ukKDI1@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <20211223002209.1092165-3-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223002209.1092165-3-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 23, 2021 at 01:21:56AM +0100, Alexander Lobakin wrote:
> [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available to nuke pos-based search

nuke?

I think you wanna say something about avoiding position-based search if
toolchain supports -z ...

> Position-based search, which means that if we have several symbols
> with the same name, we additionally need to provide an "index" of
> the desired symbol, is fragile. Par exemple, it breaks when two
				  ^^^^^^^^^^^^

We already have hard time with the English in commit messages, let's
avoid the French pls.

> symbols with the same name are located in different sections.
> 
> Since a while, LD has a flag `-z unique-symbol` which appends
> numeric suffixes to the functions with the same name (in symtab
> and strtab).
> Check for its availability and always prefer when the livepatching
> is on.

Why only then?

It looks to me like we want this unconditionally, no?

> This needs a little adjustment to the modpost to make it
> strip suffixes before adding exports.
> 
> depmod needs some treatment as well, tho its false-positibe warnings

Unknown word [false-positibe] in commit message, suggestions:
        ['false-positive', 'false-positioned', 'prepositional']

Please introduce a spellchecker into your patch creation workflow.

> about unknown symbols are harmless and don't alter the return code.
> And there is a bunch more livepatch code to optimize-out after
> introducing this, but let's leave it for later.

...

> @@ -171,17 +173,21 @@ static int klp_find_object_symbol(const char *objname, const char *name,
>  
>  	/*
>  	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
> -	 * otherwise ensure the symbol position count matches sympos.
> +	 * otherwise ensure the symbol position count matches sympos. If the LD
> +	 * `-z unique` flag is enabled, sympos checks are not relevant.
	   ^^^^^^^^^^^

-z unique-symbol

>  	 */
> -	if (args.addr == 0)
> +	if (args.addr == 0) {
>  		pr_err("symbol '%s' not found in symbol table\n", name);
> -	else if (args.count > 1 && sympos == 0) {
> +	} else if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)) {
> +		goto out_ok;

This is silly - just do it all here.

> +	} else if (args.count > 1 && sympos == 0) {
>  		pr_err("unresolvable ambiguity for symbol '%s' in object '%s'\n",
>  		       name, objname);
>  	} else if (sympos != args.count && sympos > 0) {
>  		pr_err("symbol position %lu for symbol '%s' in object '%s' not found\n",
>  		       sympos, name, objname ? objname : "vmlinux");
>  	} else {
> +out_ok:
>  		*addr = args.addr;
>  		return 0;
>  	}

Looks straight-forward otherwise but I'm no livepatcher so I'd prefer if
they have a look too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
