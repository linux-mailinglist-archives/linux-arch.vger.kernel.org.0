Return-Path: <linux-arch+bounces-5672-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7893F119
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE68B214D8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0919140363;
	Mon, 29 Jul 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gK9W/wTR"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4898E140369;
	Mon, 29 Jul 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245340; cv=none; b=EdYV1q0/3prnbhHhivsy9+0LSRSfxRzKOdmg43WBRzlGVzo73TBHztMZRHk2V+Aqih/6pJm8adlYaO7N88nXXz8Gxe4IV1tHZmB048VxPo5PcL1ZXlZocu37yFUV3OekWeZSzeRRvVcBIaBHf3bMneqE/x4w8N8bT+hTCwt8wHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245340; c=relaxed/simple;
	bh=U5EVK+j7cGMFHeZTM7A6uc78H5Q+lVyBvC6iROso8Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJKaA1e2bCnLQwJ2PVuKLxXJuj5Tgp0Ce/lh2ihVyVtRIRi0heJbROFRRLaPqYGzz/NsDKT7EbbhE1onvBEaX6aqxxCDNTeod9ifBcpvAfZEfizPtRPdUW6zHnzFVknh5YNciCphGv/Y3139cbdNPwRlBEMaB0zZ6SdY7M9DG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gK9W/wTR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3UrHTOhOAWYJ8gu6wnB9kvfmZNeJ4TRjNEt1t3Ty48=; b=gK9W/wTRvBy88/533TCIr09Gjq
	qupTuOqocF/ODia6MFGrjeUcKrKp8kUD3oL+TZYaUUxaGM3Kgo5BA2peB/But6TlDYCCkGFBTXV8C
	whTzC/wdNZ4pVn9aP85OoKOk5i1dBCWL7OxWZ4yNCD7bd/yCVPxRmLZ//e8ms+P2fbHrvdZ+Lj5hZ
	ppVV9ple4XoFZm7FrxX02ebYlJLgfSiL11cGg2jdJ3UFY4YGa/po15qHYi6owccO/cb8+s59Bhzkp
	GZZs6x4X0YFBqMTfGRrSLl4yrkxdGF1vLUCemld35G/sNNsqIC5uJea0BxmXUMnfM5Fz/yJ0L43VS
	8lQr3C0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYMgL-0000000DQQH-04ve;
	Mon, 29 Jul 2024 09:28:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 41D8B300439; Mon, 29 Jul 2024 11:28:40 +0200 (CEST)
Date: Mon, 29 Jul 2024 11:28:40 +0200
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
Subject: Re: [PATCH 2/6] objtool: Fix unreachable instruction warnings for
 weak funcitons
Message-ID: <20240729092840.GB37996@noisy.programming.kicks-ass.net>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-3-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728203001.2551083-3-xur@google.com>

On Sun, Jul 28, 2024 at 01:29:55PM -0700, Rong Xu wrote:
> In the presence of both weak and strong function definitions, the
> linker drops the weak symbol in favor of a strong symbol, but
> leaves the code in place. Code in ignore_unreachable_insn() has
> some heuristics to suppress the warning, but it does not work when
> -ffunction-sections is enabled.
> 
> Suppose function foo has both strong and weak definitions.
> Case 1: The strong definition has an annotated section name,
> like .init.text. Only the weak definition will be placed into
> .text.foo. But since the section has no symbols, there will be no
> "hole" in the section.
> 
> Case 2: Both sections are without an annotated section name.
> Both will be placed into .text.foo section, but there will be only one
> symbol (the strong one). If the weak code is before the strong code,
> there is no "hole" as it fails to find the right-most symbol before
> the offset.
> 
> The fix is to use the first node to compute the hole if hole.sym
> is empty. If there is no symbol in the section, the first node
> will be NULL, in which case, -1 is returned to skip the whole
> section.
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> ---
>  tools/objtool/elf.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 3d27983dc908..fa88bb254ccc 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -224,12 +224,15 @@ int find_symbol_hole_containing(const struct section *sec, unsigned long offset)
>  	if (n)
>  		return 0; /* not a hole */
>  
> -	/* didn't find a symbol for which @offset is after it */
> -	if (!hole.sym)
> -		return 0; /* not a hole */
> +	/*
> +	 * @offset >= sym->offset + sym->len, find symbol after it.
> +	 * Use the first node in rb_tree when hole.sym is NULL.
> +	 */

	/*
	 * If we are not right of any symbol, the next symbol must be
	 * the first symbol. Either way, the next symbol -- if there is
	 * one -- provides the rightmost boundary of the hole.
	 */
	if (!hole.sym)
		n = rb_first_cached(&sec->symbol_tree);
	else
		n = rb_next(&hole.sym->node);


That tells us more of why, rather than of what. Hmm?

> +	if (hole.sym)
> +		n = rb_next(&hole.sym->node);
> +	else
> +		n = rb_first_cached(&sec->symbol_tree);
>  
> -	/* @offset >= sym->offset + sym->len, find symbol after it */
> -	n = rb_next(&hole.sym->node);
>  	if (!n)
>  		return -1; /* until end of address space */
>  
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 

