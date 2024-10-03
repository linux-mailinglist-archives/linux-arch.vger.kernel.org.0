Return-Path: <linux-arch+bounces-7659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EF698F303
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 17:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89679281802
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F41A4F11;
	Thu,  3 Oct 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OARj+niQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7119F470;
	Thu,  3 Oct 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970226; cv=none; b=WD8w4PaowpV2X/WqfxFoaEXq2A/jup1zHyTPeYY3ezedFkm8HNpfiCGEBDFyAtth9p/uJFuclVBFeuDgYTYAT934iemgZWdcovoLPbMAtqJGPgjORRwJri/MNd7wsTKDRkiS/cXwoUyDds6L5Fj3ooNUXXGLz1l6aA/mW2cqfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970226; c=relaxed/simple;
	bh=vPJAhnVxIvRnoD2gmEHmfpeRxvHSSTnPvyuruN6mLDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK2QkXVAa75R+bz1oL9v0FzxeE/nSQELT/MtZ+fwvdM5EUEH9819ws9o6/gK/O1gM330hGie0UNWlp2WKILEpmXjxdOkXbVOkZBj2SzviPOC9BA8K7OufMx2raCSN2KePwtu1ncJOkBnFRhvZ7vy+O2YE/sHYAlLG4zD51WeNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OARj+niQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=24ugNSz8mDIInyh/mFAiZT8CXk8I/EkkyLnjN+zVpUk=; b=OARj+niQx+xnQOqZP/gFKJRe4w
	UeDPfQUVH5ewFg4YY1/F9By7gws6i58p58BUtC8wkjqb1JFL+aXANb04GmecuWJaIiMlPRVdr1Ki3
	xqZCLZUrX1XAOlwpFqSZMVYQ7c8Dl3y/SmXQJDb4G2mlVIokUlPrncb3p7f382Y5HlJzYqKRis/4J
	Y9Kg2AdmEdhWhHk659AdLsn+MY6rUQMzB5ICe+pqSSizg12aOoTt6zCxytmw6/Jq0nX7xlJ2yPxP3
	lty8eQDWQUyLuF1i7jOXEK5jtpZIGUkfmE+ssFOfQCJymBXepwHl7GnxfGj9j0pY/L3HclK2RRFt6
	F19DQFDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swNz6-00000003iMA-3gLY;
	Thu, 03 Oct 2024 15:43:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8025730083E; Thu,  3 Oct 2024 17:43:20 +0200 (CEST)
Date: Thu, 3 Oct 2024 17:43:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>
Subject: Re: [PATCH v2 3/6] Change the symbols order when --ffuntion-sections
 is enabled
Message-ID: <20241003154320.GX5594@noisy.programming.kicks-ass.net>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-4-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002233409.2857999-4-xur@google.com>

On Wed, Oct 02, 2024 at 04:34:02PM -0700, Rong Xu wrote:
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

Is there a down-side to using the new order unconditionally?

