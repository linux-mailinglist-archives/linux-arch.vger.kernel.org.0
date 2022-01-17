Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A87491140
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 22:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbiAQVIE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 16:08:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39160 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbiAQVID (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jan 2022 16:08:03 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A55D1EC02DD;
        Mon, 17 Jan 2022 22:07:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642453677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x9mhOj3OPp7/NgS1SucK0b8bM2kZIWpEaBWAuEEfK7Q=;
        b=OX/VTbG+FiU93UTSILFiausMlqvvqzxTUgh0Kj76IqmgR/Wy6aYQcr0wD46a1hc5INwd5V
        4eg/6JP4DWLADsHqp4CoaG38ua8jQ/Jeq2Bju6aML1420SCC2A5w8uPfG2aUq9zTV2eSj3
        QqqJKJ3A5ygnp2E3zCvzN+GKaLD23N8=
Date:   Mon, 17 Jan 2022 22:08:00 +0100
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
Subject: Re: [PATCH v9 04/15] arch: introduce ASM function sections
Message-ID: <YeXasIO5ArXxtw1J@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <20211223002209.1092165-5-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223002209.1092165-5-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 23, 2021 at 01:21:58AM +0100, Alexander Lobakin wrote:
> Sometimes it is useful to create a separate section for every
> function (symbol in general) to be able then to selectively merge
> them back into on or several others. This is how DCE and a part of
		 ^^

"one"

DCE == Dead Code Elimination?

In any case, write it out first please and then use the abbreviation.

> LTO work.

I would've said that too but that one at least has a Kconfig entry which
explains what it is so no need.

/me looks further

Aha there is LD_DEAD_CODE_DATA_ELIMINATION. So connect the two pls.

> Currently, only C functions are in scope

You mean, currently this is done only for C functions? The "in scope"
formulation sounds weird.

> and the compilers are able to do this automatically when
> `-ffunction-section` is specified.

-ffunction-sections, plural.

> Add a basic infra for supporting ASM function sections. If any of

yah s/ASM/asm/g. It's not like it is an acronym or so.

and also, you should explain that "asm function sections" means "put a
function symbol defined in asm, into a separate section".

> the required build options (DCE, LTO, FG-KASLR later) is on and
> the target architecture claims it supports them, all ASM functions
> and "code" will be placed into separate named sections by default.
> This is achieved using --sectname-subst GAS flag which will then
> substitute "%S" in a .pushsection or .section directive with the

Thanks for explaining this. The gas manpage is very, hm, verbose
<sarcarstic eyeroll> ;-\:

"       --sectname-subst
           Honor substitution sequences in section names.
"


...

> diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> index dbf8506decca..0c0ddf4429dc 100644
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -73,6 +73,37 @@
>  #define __ALIGN_STR	".align 4,0x90"
>  #endif
>  
> +/*
> + * Allow ASM symbols to have their own unique sections if they are being
> + * generated by the compiler for C functions (DCE, LTO).
> + */
> +#if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
> +    ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
> +     (defined(CONFIG_LTO_CLANG)))
> +
> +#define SYM_PUSH_SECTION(name)				\
> +	.pushsection %S.name, "ax"
> +
> +#define SYM_POP_SECTION()				\
> +	.popsection
> +
> +#define __ASM_PUSH_SECTION(name)			\
> +	".pushsection %S." name ", \"ax\""
> +
> +#else /* Just .text */

Just .text?

> +
> +#define SYM_PUSH_SECTION(name)
> +#define SYM_POP_SECTION()
> +#define __ASM_PUSH_SECTION(name)
> +
> +#endif /* Just .text */
> +
> +#define ASM_PUSH_SECTION(name)				\
> +	__ASM_PUSH_SECTION(__stringify(name))
> +
> +#define ASM_POP_SECTION()				\
> +	__stringify(SYM_POP_SECTION())
> +
>  #ifdef __ASSEMBLY__
>  
>  /* SYM_T_FUNC -- type used by assembler to mark functions */
> @@ -209,6 +240,15 @@
>  	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
>  #endif
>  
> +/*
> + * SYM_FUNC_START_WEAK -- use where there are two global names for one

SYM_FUNC_START_WEAK_ALIAS

> + * function, and one of them is weak
> + */
> +#ifndef SYM_FUNC_START_WEAK_ALIAS
> +#define SYM_FUNC_START_WEAK_ALIAS(name)			\
> +	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)
> +#endif
> +
>  /*
>   * SYM_FUNC_START_ALIAS -- use where there are two global names for one
>   * function
> @@ -225,12 +265,24 @@
>   * later.
>   */
>  #define SYM_FUNC_START(name)				\
> +	SYM_PUSH_SECTION(name) ASM_NL			\
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
> +#endif
> +
> +/*
> + * SYM_FUNC_START_SECT -- use for global functions, will be conditionally
> + * placed into a section specified in the second argument
> + */
> +#ifndef SYM_FUNC_START_SECT
> +#define SYM_FUNC_START_SECT(name, to)			\

			      (name, sect)

"to" reads kinda unclear what it is supposed to mean.


> +	SYM_PUSH_SECTION(to) ASM_NL			\
>  	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
>  #endif
>  
>  /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
>  #ifndef SYM_FUNC_START_NOALIGN
>  #define SYM_FUNC_START_NOALIGN(name)			\
> +	SYM_PUSH_SECTION(name) ASM_NL			\
>  	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
>  #endif
>  
> @@ -238,24 +290,38 @@
>  #ifndef SYM_FUNC_START_LOCAL
>  /* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
>  #define SYM_FUNC_START_LOCAL(name)			\
> +	SYM_PUSH_SECTION(name) ASM_NL			\
>  	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
>  #endif
>  
>  /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
>  #ifndef SYM_FUNC_START_LOCAL_NOALIGN
>  #define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
> +	SYM_PUSH_SECTION(name) ASM_NL			\
> +	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
> +#endif
> +
> +/*
> + * SYM_FUNC_START_LOCAL_NOALIGN_SECT -- use for local functions, w/o alignment,
> + * will be conditionally placed into a section specified in the second argument
> + */
> +#ifndef SYM_FUNC_START_LOCAL_NOALIGN_SECT
> +#define SYM_FUNC_START_LOCAL_NOALIGN_SECT(name, to)	\

Ditto. And so on below.

...

> diff --git a/init/Kconfig b/init/Kconfig
> index 37926d19a74a..3babc0aeac61 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1386,6 +1386,17 @@ config CC_OPTIMIZE_FOR_SIZE
>  
>  endchoice
>  
> +config HAVE_ASM_FUNCTION_SECTIONS
> +	depends on ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
> +	depends on $(cc-option,-Wa$(comma)--sectname-subst)
> +	def_bool y
> +	help
> +	  This enables ASM function sections if both architecture
> +	  and toolchain supports that. It allows creating a separate

"... support it."

> +	  .text section for each ASM function in order to improve

s/.text // - the section name is specified by the macro arg.

> +	  DCE and LTO (works the same way as -ffunction-sections for
> +	  C code).
> +

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
