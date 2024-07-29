Return-Path: <linux-arch+bounces-5673-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4193F135
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806A8285F8F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5A13AA26;
	Mon, 29 Jul 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vRnJ603h"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879E770E1;
	Mon, 29 Jul 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245663; cv=none; b=mHJuU3BPchROOrWu+G1NAtXANO7E5YIYdjki8MEa6ctWZ9CZHD9b6Z1tP1b7xAlJrvEI9HdEN0NHdmovS6+2I8Dny+tu1aq/SzA+Xi57J2l/4wuNcke1Ki6398A5mge3uoXCW2I/I5wfN6UemcOV1cd1y9Jo7vAF7VUvBMztW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245663; c=relaxed/simple;
	bh=3jPwdF87VODfvLYMSLQ6a8U5V6bwkM9aoC2LVJskl4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEreezV5t9lnUxTuIBdJa3YFmVyFHMeZ+n7QNbh7ZIwpX6QeAt3bF8Mtnpx/g13V16i+NrbC+c1ZkeSVMLz9Gkv7Ns8w4ma5q0ROW6JV5kpIANkUoQsRpCphC4G/oRry1ZSxfKiW/GRlyVMvkXx7MlEH6iI/iwK/uwabXbv0in8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vRnJ603h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8JC9Mk7PKGPRsFj1tUJdTnT65oycReDEnXbNeaPrch8=; b=vRnJ603hG2qrYgjH37cZsIaTty
	kbnnWa7CjLIqvatukxS67LykRqrQgJkaCNBwfmtKqR4SlBruRVepVz5alu67HS0JQAWmWFRDO/N7A
	od/rHvVXsl6oM7N955Rb5sa+a8xJ97rYORUGm4fgJ0xmlyJRcR61xnGllcfSu8IugcJKiLpqzkKKL
	HNYmPh4hrfJvQaXquK4Ni9lzRMMLs3Q9e6TGSXZ66gAPNwb34qKpVNmOJaPXE5x4r/pDx9bKMuD0C
	1mbVBy9VfyT+tWOqSqsD/HTRS0rn5NIr7IuXjdIvHSXxuBOWoKqZIdmq+4NYePiNAVqodzmMhz/UQ
	9oYkfk/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYMla-0000000DQiR-1KUO;
	Mon, 29 Jul 2024 09:34:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EAFEC300439; Mon, 29 Jul 2024 11:34:05 +0200 (CEST)
Date: Mon, 29 Jul 2024 11:34:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	John Moon <john@jmoon.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Benjamin Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Krzysztof Pszeniczny <kpszeniczny@google.com>
Subject: Re: [PATCH 3/6] Change the symbols order when --ffuntion-sections is
 enabled
Message-ID: <20240729093405.GC37996@noisy.programming.kicks-ass.net>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-4-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728203001.2551083-4-xur@google.com>

On Sun, Jul 28, 2024 at 01:29:56PM -0700, Rong Xu wrote:
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
> a suffix to "..". This patch modifies the order of subsections within the
> text output section when the -ffunction-sections flag is enabled.
> Specifically, it repositions sections with certain fixed patterns (for
> example .text.unlikely) before TEXT_MAIN, ensuring that they are grouped
> and matched together.
> 
> Note that the limitation arises because the linker script employs glob
> patterns instead of regular expressions for string matching. While there
> is a method to maintain the current order using complex patterns, this
> significantly complicates the pattern and increases the likelihood of
> errors.
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5703526d6ebf..f3de66bda293 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -582,9 +582,21 @@
>   * during second ld run in second ld pass when generating System.map
>   *
>   * TEXT_MAIN here will match .text.fixup and .text.unlikely if dead
> - * code elimination is enabled, so these sections should be converted
> - * to use ".." first.
> + * code elimination or function-section is enabled. Match these symbols
> + * first when in these builds.
>   */
> +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
> +#define TEXT_TEXT							\
> +		*(.text.asan.* .text.tsan.*)				\
> +		*(.text.unknown .text.unknown.*)			\
> +		*(.text.unlikely .text.unlikely.*)			\
> +		ALIGN_FUNCTION();					\

Why leave the above text sections unaligned?

> +		*(.text.hot .text.hot.*)				\
> +		*(TEXT_MAIN .text.fixup)				\
> +		NOINSTR_TEXT						\
> +		*(.ref.text)						\
> +	MEM_KEEP(init.text*)
> +#else
>  #define TEXT_TEXT							\
>  		ALIGN_FUNCTION();					\
>  		*(.text.hot .text.hot.*)				\
> @@ -594,7 +606,8 @@
>  		NOINSTR_TEXT						\
>  		*(.ref.text)						\
>  		*(.text.asan.* .text.tsan.*)				\
> -	MEM_KEEP(init.text*)						\
> +	MEM_KEEP(init.text*)
> +#endif
>  
>  
>  /* sched.text is aling to function alignment to secure we have same
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 

