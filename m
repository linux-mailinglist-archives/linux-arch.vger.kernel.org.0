Return-Path: <linux-arch+bounces-8674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F09B3EC7
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A90F1F20EDA
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB935632;
	Tue, 29 Oct 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3YQeoLX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99804623;
	Tue, 29 Oct 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160305; cv=none; b=t9vTkXaikAi4KTenorWG7sQrZtpDuIuvXQi4/1Ug86qK9T+PHBFdmquM2D2j44eZsad09JkMHzTnAVXAMJG1hhtGdXTPwmLhANPZ8ne78iO/ORjm4aXhczJj6EGHKHUPsVo3PKw8RN7wz8tUURJVJNHGv/KSIIqeFXN8kxHw6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160305; c=relaxed/simple;
	bh=y3u3gDzVsi7CD55QSPo+YZ8Qt3ypcM7i00iDNxmFwwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLoZwyXs5oKrMru+qHz6hXHSE4Mez/a5XMxqSy4+g1t6nLY9NMlZsfm0ZBDC5xjk8f1i6b0zflrvzoIy1iMxqnDNH24GRNrjthDkgG3S+5pjbyX6W5Oonx1FdCxIYiLw0wCzkPOuV8uym1o+BgJum2FZjpDB6OQX3qpdQcDCvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3YQeoLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5844DC4CECD;
	Tue, 29 Oct 2024 00:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160305;
	bh=y3u3gDzVsi7CD55QSPo+YZ8Qt3ypcM7i00iDNxmFwwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3YQeoLXBPPTkKCccJC/1Dr7T0eSRl7vPp8BLgbgcaGpkELBkc7aDyADnlj7trMMB
	 GwpHbACJHKte8LijTCV9Ehmt4qR03rqCSEB7RHVmoZwZXQ9EjZeIbUMus7WZyZBzJN
	 YgN0jtUtjHo7Sg1LHM7i1Vues/6L2V1vRBGHHYFuntKArYHRvyuKUlGev+Z9MlLzMg
	 t4hWBDGiMBZ+dtgfuPonAmSY038DrM4piKF+pdTG8iHFy8bO9dlQDUxw6pPJSLP195
	 1ad12FSKWo10zz92+RSMnOgvzU6mgbwBBqooO2fGICupMlciUXOF+2QlrBLBgtxtH/
	 DCi5eLMNHjdRg==
Date: Mon, 28 Oct 2024 17:05:02 -0700
From: Kees Cook <kees@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Maksim Panchenko <max4bolt@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yabin Cui <yabinc@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	Stephane Eranian <eranian@google.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 3/7] Adjust symbol ordering in text output section
Message-ID: <202410281700.6BE0413F@keescook>
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-4-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241026051410.2819338-4-xur@google.com>

On Fri, Oct 25, 2024 at 10:14:05PM -0700, Rong Xu wrote:
> When the -ffunction-sections compiler option is enabled, each function
> is placed in a separate section named .text.function_name rather than
> putting all functions in a single .text section.
> 
> However, using -function-sections can cause problems with the
> linker script. The comments included in include/asm-generic/vmlinux.lds.h
> note these issues.:
>   “TEXT_MAIN here will match .text.fixup and .text.unlikely if dead
>    code elimination is enabled, so these sections should be converted
>    to use ".." first.”
> 
> It is unclear whether there is a straightforward method for converting
> a suffix to "..".

While I'm not a fan of the potential loss of a page, I'm not aware of
a way to do this renaming. If we want to keep these as "cold", then this
is probably the best way to do it.

> This patch modifies the order of subsections within the text output
> section. Specifically, it repositions sections with certain fixed patterns
> (for example .text.unlikely) before TEXT_MAIN, ensuring that they are
> grouped and matched together. It also places .text.hot section at the
> beginning of a page to help the TLB performance.
> 
> Note that the limitation arises because the linker script employs glob
> patterns instead of regular expressions for string matching. While there
> is a method to maintain the current order using complex patterns, this
> significantly complicates the pattern and increases the likelihood of
> errors.
> 
> This patch also changes vmlinux.lds.S for the sparc64 architecture to
> accommodate specific symbol placement requirements.
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> Tested-by: Yonghong Song <yonghong.song@linux.dev>
> Tested-by: Yabin Cui <yabinc@google.com>
> Change-Id: I5202d40bc7e24f93c2bfb2f0d987e9dc57dec1b1

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> ---
>  arch/sparc/kernel/vmlinux.lds.S   |  5 +++++
>  include/asm-generic/vmlinux.lds.h | 19 ++++++++++++-------
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
> index d317a843f7ea9..f1b86eb303404 100644
> --- a/arch/sparc/kernel/vmlinux.lds.S
> +++ b/arch/sparc/kernel/vmlinux.lds.S
> @@ -48,6 +48,11 @@ SECTIONS
>  	{
>  		_text = .;
>  		HEAD_TEXT
> +	        ALIGN_FUNCTION();
> +#ifdef CONFIG_SPARC64
> +	        /* Match text section symbols in head_64.S first */
> +	        *head_64.o(.text)
> +#endif
>  		TEXT_TEXT
>  		SCHED_TEXT
>  		LOCK_TEXT
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index eeadbaeccf88b..fd901951549c0 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -553,19 +553,24 @@
>   * .text section. Map to function alignment to avoid address changes
>   * during second ld run in second ld pass when generating System.map
>   *
> - * TEXT_MAIN here will match .text.fixup and .text.unlikely if dead
> - * code elimination is enabled, so these sections should be converted
> - * to use ".." first.
> + * TEXT_MAIN here will match symbols with a fixed pattern (for example,
> + * .text.hot or .text.unlikely) if dead code elimination or
> + * function-section is enabled. Match these symbols first before
> + * TEXT_MAIN to ensure they are grouped together.
> + *
> + * Also placing .text.hot section at the beginning of a page, this
> + * would help the TLB performance.
>   */
>  #define TEXT_TEXT							\
>  		ALIGN_FUNCTION();					\
> +		*(.text.asan.* .text.tsan.*)				\
> +		*(.text.unknown .text.unknown.*)			\
> +		*(.text.unlikely .text.unlikely.*)			\
> +		. = ALIGN(PAGE_SIZE);					\
>  		*(.text.hot .text.hot.*)				\
>  		*(TEXT_MAIN .text.fixup)				\
> -		*(.text.unlikely .text.unlikely.*)			\
> -		*(.text.unknown .text.unknown.*)			\
>  		NOINSTR_TEXT						\
> -		*(.ref.text)						\
> -		*(.text.asan.* .text.tsan.*)
> +		*(.ref.text)
>  
>  
>  /* sched.text is aling to function alignment to secure we have same
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

-- 
Kees Cook

