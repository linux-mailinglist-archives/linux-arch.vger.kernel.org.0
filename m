Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9613F4674B7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379823AbhLCK1U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 05:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbhLCK1U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 05:27:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE3C06173E;
        Fri,  3 Dec 2021 02:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WDJ7DRgTIJi/G608Ewn/RZmWDD8diylwBXPBUlmJ67Q=; b=tAGWACfEhPD9yiB9avdDZw/3D+
        u1zeKcjJBBX7BlGGG9yjkYMGpDrMSUAsGinn9VupILRwY3PCGRQ0mBbTY5hbbArnNK07glNj3Wjrz
        2DcKNoe59YMJW3ScyhGWJLlYbLAMYnJVoEixt7SfGMjHg+e/mbuiTdlDtQf7ciC+lgg1FVTxgjF5A
        IkSpa8q0dSesDMLHaXZjYUzpYF4fZuVzUP335nbXvDzpjGcbBebGeLo9Z8vxHTl1ppx3wEruwSLvC
        84GoyS6A1M8FTLB4MJBtZgbRxyVjWXD3Ca8OrI7XEJ6zYB2p/YJi9DrRTEJGj0neUazl0QVpKocUD
        EMpJjwCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt5iy-008BaQ-Jh; Fri, 03 Dec 2021 10:23:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5CF54300293;
        Fri,  3 Dec 2021 11:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 424512B36B3B7; Fri,  3 Dec 2021 11:23:27 +0100 (CET)
Date:   Fri, 3 Dec 2021 11:23:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
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
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 11/14] module: Reorder functions
Message-ID: <YanwH4bgCgJnwsRW@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-12-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202223214.72888-12-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 02, 2021 at 11:32:11PM +0100, Alexander Lobakin wrote:
> +/*
> + * shuffle_text_list()
> + * Use a Fisher Yates algorithm to shuffle a list of text sections.
> + */
> +static void shuffle_text_list(Elf_Shdr **list, int size)
> +{
> +	u32 i, j;
> +
> +	for (i = size - 1; i > 0; i--) {
> +		/*
> +		 * pick a random index from 0 to i
> +		 */
> +		j = get_random_u32() % (i + 1);
> +
> +		swap(list[i], list[j]);
> +	}
> +}

I'm sure I've seen pretty much that exact function earlier in this
series; does we really need two of them?

#define shuffle_me_harder(_base, _size, _nr)				\
do {									\
	struct { unsigned char _[_size]; } _t, *_a = (void *)(_base);	\
	int _i, _j;							\
	for (_i = (_nr)-1; _i > 0; _i--) {				\
		_j = get_random_u32() % (_i + 1);			\
		_t = _a[_i];						\
		_a[_i] = _a[_j];					\
		_a[_j] = _t;						\
	}								\
} while (0)

#define shuffle_array(_array)	shuffle_me_harder(_array, sizeof(_array[0]), sizeof(_array)/sizeof(_array[0]))

Or something like that...
