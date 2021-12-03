Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70231467418
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 10:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347953AbhLCJfO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbhLCJfO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 04:35:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D69C06173E;
        Fri,  3 Dec 2021 01:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+F+jn348o8c0+qkMFF271zNvg0ImzfMnYeCjnhYAoLQ=; b=muH0znyR10BD3npxHrYXsKEwzs
        GyQkCrO8EFZ0wkALDDoo+iVtexP20q1O1LlTVxr+ktg+Q8kfrPl+0c5szhG2OE/Fm1yAikUoMHq+v
        GxY3jyStH0ykuomRP+jNm1YcicCzif8hfv6aiTrtfwPXeSNjnmGpQj1QOobYuinhNEbW6lymcNzTr
        5X6FM6AzzDIJOubFGy9z6hjf2+6mmKfaZhkLLxmlI3IzsqjlAZjNtF6XELXFU0yq1eQT38q4yU9EK
        AykHR64nIOaeOyO6MS8sK0WvpgtZ+JJWZ3OCSQyTb0xAvjMEcze0bHAjPaAZ0PU9HpJNxU6Xbrhx9
        rjDl4lsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt4uh-00815V-6J; Fri, 03 Dec 2021 09:31:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75BAD300243;
        Fri,  3 Dec 2021 10:31:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F8E62B36B3A8; Fri,  3 Dec 2021 10:31:30 +0100 (CET)
Date:   Fri, 3 Dec 2021 10:31:30 +0100
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
Subject: Re: [PATCH v8 04/14] linkage: add macros for putting ASM functions
 into own sections
Message-ID: <Yanj8qvo3Wj4ePyV@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-5-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202223214.72888-5-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 02, 2021 at 11:32:04PM +0100, Alexander Lobakin wrote:

> diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> index dbf8506decca..baaab7dece08 100644
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -355,4 +355,86 @@
>  
>  #endif /* __ASSEMBLY__ */
>  
> +/*
> + * Allow ASM symbols to have their own unique sections if they are being
> + * generated by the compiler for C functions (DCE, FG-KASLR, LTO).
> + */
> +#if (defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
> +    (defined(CONFIG_FG_KASLR) && !defined(MODULE)) || \
> +    (defined(CONFIG_MODULE_FG_KASLR) && defined(MODULE)) || \
> +    (defined(CONFIG_LTO_CLANG))
> +
> +#define SYM_TEXT_SECTION(name)				\
> +	.pushsection .text.##name, "ax"
> +
> +#define ASM_TEXT_SECTION(name)				\
> +	".text." #name
> +
> +#define ASM_PUSH_SECTION(name)				\
> +	".pushsection .text." #name ", \"ax\""
> +
> +#else /* just .text */
> +
> +#define SYM_TEXT_SECTION(name)				\
> +	.pushsection .text, "ax"
> +
> +#define ASM_TEXT_SECTION(name)				\
> +	".text"
> +
> +#define ASM_PUSH_SECTION(name)				\
> +	".pushsection .text, \"ax\""
> +
> +#endif /* just .text */

That's terribly inconsistent, SYM_TEXT_SECTION is in fact
PUSH_TEXT_SECTION, ASM_PUSH_SECTION is in fact ASM_PUSH_TEXT_SECTION and
should be stringify(PUSH_TEXT_SECTION()) or something, and they're all
repeating that ASM_TEXT_SECTION thing :/


> +
> +#ifdef __ASSEMBLY__
> +
> +#define SYM_TEXT_END_SECTION				\
> +	.popsection
> +
> +#define SYM_FUNC_START_LOCAL_ALIAS_SECTION(name)	\
> +	SYM_TEXT_SECTION(name) ASM_NL			\
> +	SYM_FUNC_START_LOCAL_ALIAS(name)
> +
> +#define SYM_FUNC_START_LOCAL_SECTION(name)		\
> +	SYM_TEXT_SECTION(name) ASM_NL			\
> +	SYM_FUNC_START_LOCAL(name)
> +
> +#define SYM_FUNC_START_NOALIGN_SECTION(name)		\
> +	SYM_TEXT_SECTION(name) ASM_NL			\
> +	SYM_FUNC_START_NOALIGN(name)
> +
> +#define SYM_FUNC_START_WEAK_SECTION(name)		\
> +	SYM_TEXT_SECTION(name) ASM_NL			\
> +	SYM_FUNC_START_WEAK(name)
> +
> +#define SYM_FUNC_START_SECTION(name)			\
> +	SYM_TEXT_SECTION(name) ASM_NL			\
> +	SYM_FUNC_START(name)
> +
> +#define SYM_CODE_START_LOCAL_NOALIGN_SECTION(name)	\
> +	SYM_TEXT_SECTION(name) ASM_NL			\
> +	SYM_CODE_START_LOCAL_NOALIGN(name)
> +
> +#define SYM_CODE_START_NOALIGN_SECTION(name)		\
> +	SYM_TEXT_SECTION(name) ASM_NL			\
> +	SYM_CODE_START_NOALIGN(name)
> +
> +#define SYM_CODE_START_SECTION(name)			\
> +	SYM_TEXT_SECTION(name) ASM_NL			\
> +	SYM_CODE_START(name)
> +
> +#define SYM_FUNC_END_ALIAS_SECTION(name)		\
> +	SYM_FUNC_END_ALIAS(name) ASM_NL			\
> +	SYM_TEXT_END_SECTION
> +
> +#define SYM_FUNC_END_SECTION(name)			\
> +	SYM_FUNC_END(name) ASM_NL			\
> +	SYM_TEXT_END_SECTION
> +
> +#define SYM_CODE_END_SECTION(name)			\
> +	SYM_CODE_END(name) ASM_NL			\
> +	SYM_TEXT_END_SECTION
> +
> +#endif /* __ASSEMBLY__ */

*URGH* why do we have to have new macros for this? SYM_FUNC_START*()
already takes the name as argument.
