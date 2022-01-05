Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B964858A5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 19:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbiAESqG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 13:46:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37122 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238501AbiAESqG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Jan 2022 13:46:06 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA3301EC0409;
        Wed,  5 Jan 2022 19:45:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641408359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fEZIiIW8f9y+YhRxy3dl8vhei2PQdN236Vujn7RBTdY=;
        b=pSCYqwvRR+jUpjU5YwAa8zN64Y5dn0sO3OHpyZf1+yxRZ18xu5tPEhOKWwUz+wGg1ynCeV
        srFP8tI2NsIn+W3JysHUBTIqtFvLXC3aA5kU9TejCQRlI7MqcHt/QI0jlXIK7G6/i2VYZj
        H3B6FMt0oByYncE3nPCCef6orbqe1Vo=
Date:   Wed, 5 Jan 2022 19:46:01 +0100
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
Subject: Re: [PATCH v9 03/15] kallsyms: Hide layout
Message-ID: <YdXnaYM9P3Grwz/C@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <20211223002209.1092165-4-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223002209.1092165-4-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 23, 2021 at 01:21:57AM +0100, Alexander Lobakin wrote:
> @@ -687,11 +697,12 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
>  	iter->name[0] = '\0';
>  	iter->nameoff = get_symbol_offset(new_pos);
>  	iter->pos = new_pos;
> -	if (new_pos == 0) {

	if (!iter->show_layout)
		return;

> +	if (iter->show_layout && new_pos == 0) {
>  		iter->pos_arch_end = 0;
>  		iter->pos_mod_end = 0;
>  		iter->pos_ftrace_mod_end = 0;
>  		iter->pos_bpf_end = 0;
> +		iter->pos_end = 0;
>  	}
>  }

...

> @@ -838,16 +860,54 @@ static int kallsyms_open(struct inode *inode, struct file *file)
>  	 * using get_symbol_offset for every symbol.
>  	 */
>  	struct kallsym_iter *iter;
> -	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
> -	if (!iter)
> -		return -ENOMEM;
> -	reset_iter(iter, 0);
> +	/*
> +	 * This fake iter is needed for the cases with unprivileged
> +	 * access. We need to know the exact number of symbols to
> +	 * randomize the display layout.
> +	 */
> +	struct kallsym_iter fake;
> +	size_t size = sizeof(*iter);
> +	loff_t pos;
> +
> +	fake.show_layout = true;
> +	reset_iter(&fake, 0);
>  
>  	/*
>  	 * Instead of checking this on every s_show() call, cache
>  	 * the result here at open time.
>  	 */
> -	iter->show_value = kallsyms_show_value(file->f_cred);
> +	fake.show_layout = kallsyms_show_value(file->f_cred);
> +	if (fake.show_layout)
> +		goto open;

There are those silly labels again:

	if (!fake.show_layout) {
		for (... )
			;
		size = ...
	}

	iter = __seq_open_private(...

> +
> +	for (pos = kallsyms_num_syms; update_iter_mod(&fake, pos); pos++)
> +		;
> +
> +	size = struct_size(iter, shuffled_pos, fake.pos_end + 1);
> +
> +open:
> +	iter = __seq_open_private(file, &kallsyms_op, size);
> +	if (!iter)
> +		return -ENOMEM;
> +
> +	iter->show_layout = fake.show_layout;
> +	reset_iter(iter, 0);
> +
> +	if (iter->show_layout)
> +		return 0;
> +
> +	/* Copy the bounds since they were already discovered above */
> +	iter->pos_arch_end = fake.pos_arch_end;
> +	iter->pos_mod_end = fake.pos_mod_end;
> +	iter->pos_ftrace_mod_end = fake.pos_ftrace_mod_end;
> +	iter->pos_bpf_end = fake.pos_bpf_end;
> +	iter->pos_end = fake.pos_end;
> +
> +	for (pos = 0; pos <= iter->pos_end; pos++)
> +		iter->shuffled_pos[pos] = pos;
> +
> +	shuffle_array(iter->shuffled_pos, iter->pos_end + 1);
> +
>  	return 0;
>  }

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
