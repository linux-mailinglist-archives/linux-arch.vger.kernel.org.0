Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446F9483188
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 14:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiACNo6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 08:44:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38308 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiACNo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 08:44:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9DB211F38B;
        Mon,  3 Jan 2022 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641217496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTJ1dFgK+e5nEjMCy1hx4JFFE95pm729J/0lTIXNYPQ=;
        b=mj/DmFRpnAQn6IsHlOFXXObU9OcYXvK0jsyh+ZGcLL1aRwhrlgcwlyqpLesy26E7TcXv2r
        C2FsSdeaVOAAG0b+6tEscjs264JEFqMhWjZu7GVZsBpjyOwQWx25m9Dc2eOAFtYFG/uLFO
        GUGIzHt3y/sAqQ9s1xoPs9kLRHm0Fyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641217496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTJ1dFgK+e5nEjMCy1hx4JFFE95pm729J/0lTIXNYPQ=;
        b=d/FL6e2yBkq7hBqztokwqPKphOccyHc7hm6myfbJoGFBNUPn0kCU/krfro7FkpPomzr8nD
        QZ5nL5sD+G3EvJBA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3E6D3A3B8D;
        Mon,  3 Jan 2022 13:44:54 +0000 (UTC)
Date:   Mon, 3 Jan 2022 14:44:09 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
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
        Borislav Petkov <bp@alien8.de>,
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
In-Reply-To: <20211223002209.1092165-3-alexandr.lobakin@intel.com>
Message-ID: <alpine.LSU.2.21.2201031438350.15051@pobox.suse.cz>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com> <20211223002209.1092165-3-alexandr.lobakin@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -143,11 +143,13 @@ static int klp_find_callback(void *data, const char *name,
>  	args->count++;
>  
>  	/*
> -	 * Finish the search when the symbol is found for the desired position
> -	 * or the position is not defined for a non-unique symbol.
> +	 * Finish the search when unique symbol names are enabled
> +	 * or the symbol is found for the desired position or the
> +	 * position is not defined for a non-unique symbol.
>  	 */
> -	if ((args->pos && (args->count == args->pos)) ||
> -	    (!args->pos && (args->count > 1)))
> +	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL) ||
> +	    (args->pos && args->count == args->pos) ||
> +	    (!args->pos && args->count > 1))
>  		return 1;
>  
>  	return 0;
> @@ -171,17 +173,21 @@ static int klp_find_object_symbol(const char *objname, const char *name,
>  
>  	/*
>  	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
> -	 * otherwise ensure the symbol position count matches sympos.
> +	 * otherwise ensure the symbol position count matches sympos. If the LD
> +	 * `-z unique` flag is enabled, sympos checks are not relevant.
>  	 */
> -	if (args.addr == 0)
> +	if (args.addr == 0) {
>  		pr_err("symbol '%s' not found in symbol table\n", name);
> -	else if (args.count > 1 && sympos == 0) {
> +	} else if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)) {
> +		goto out_ok;
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

I think it would be better to return to something like

if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL))
        sympos = 0;

in klp_find_object_symbol() just after kallsyms search is performed.

You would not need the above changes at all. I did not like it before when 
sympos clearing was proposed, but the situation was different back then. 
'-z unique-symbol' was not available. It has changed and we have a 
guarantee that symbols are unique now. There would not be any impact on 
the user.

What do you think?

Miroslav
