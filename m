Return-Path: <linux-arch+bounces-4842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027B90467F
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 23:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB7F286C93
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9D153BE6;
	Tue, 11 Jun 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJL3IIlI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FD153BE2;
	Tue, 11 Jun 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142959; cv=none; b=gqRUdR2X0YAZbGcvi6lCQHYstUTCCjasQR21DAKe9SRl9nXR5XdCnyP9x33lO0gqqF4CuRSCNDB0DnnDYs/DKgPxI6cv4OMjmUH6KLxGp2cg3hnmSxsb8cO+90AKXLROwZND5GczobqyNInzXu2y21ZOMD/mnjKwpjUSxULTfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142959; c=relaxed/simple;
	bh=aHnNpOpxBam7cV7S26yxOrl6yEGYk9YSZ3F06NWlAdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcV/ptWuCGSNX8PBeSsy1+9iW8TeijXwRO2PtjdrwlEzcyVuhPd/+71pBf5o2Jl9WXBzHRYoKtR3aYdQMfImEvhlo3aey18bbj7GP/ScBDGq8XUmFAeVh9WWX/lLTt3g/GEbb0Xpr9ARE/6hS15/yS44Kailxxp6J+CcvTy7BiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJL3IIlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC0AC4AF52;
	Tue, 11 Jun 2024 21:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718142959;
	bh=aHnNpOpxBam7cV7S26yxOrl6yEGYk9YSZ3F06NWlAdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJL3IIlIE1K7zmXV5J+jP9tGO8NIuwCZW5RvE3fY57eUex6fgR30LSUGzyguhx6Qb
	 N/kaVdrftLpPK2Rx2kCxzQPpDZhJqAysZJ78lRqlQXcoKRQFW0XuvsyixIdgdYlT2N
	 MvTeH15XMuLy80H5liDy2T39OaTzVao3Wb3Ww0tQ50K6rsw0NsoQmg5ffzP1fdWgVc
	 om1juoiZnlZf4kIRjtC6I8OOD6bgJmBOqaJCa6fz4W9QLolALYxTDw6qoiO7j9a0jS
	 HCqV91LLhTWdlsymXDN7/EZSENm4VKkqWoOtl7phdsh2+vF2aGbXn2TPEo9me1d8OU
	 kdBZUnWNnK4Zg==
Date: Tue, 11 Jun 2024 14:55:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 6/7] arm64: start using 'asm goto' for put_user() when
 available
Message-ID: <20240611215556.GA3021057@thelio-3990X>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-7-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610204821.230388-7-torvalds@linux-foundation.org>

Hi Linus,

On Mon, Jun 10, 2024 at 01:48:20PM -0700, Linus Torvalds wrote:
> This generates noticeably better code with compilers that support it,
> since we don't need to test the error register etc, the exception just
> jumps to the error handling directly.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  arch/arm64/include/asm/uaccess.h | 77 +++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 23c2edf517ed..4ab3938290ab 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -294,29 +294,41 @@ do {									\
>  	} while (0);							\
>  } while (0)
>  
> -#define __put_mem_asm(store, reg, x, addr, err, type)			\
> +#ifdef CONFIG_CC_HAS_ASM_GOTO

This symbol was eliminated two years ago with commit a0a12c3ed057 ("asm
goto: eradicate CC_HAS_ASM_GOTO") since all supported compilers have
support for it.

> +#define __put_mem_asm(store, reg, x, addr, label, type)			\
> +	asm goto(							\
> +	"1:	" store "	" reg "0, [%1]\n"			\
> +	"2:\n"								\
> +	_ASM_EXTABLE_##type##ACCESS_ZERO(1b, %l2)			\
> +	: : "rZ" (x), "r" (addr) : : label)
> +#else
> +#define __put_mem_asm(store, reg, x, addr, label, type) do {		\
> +	int __pma_err = 0;						\
>  	asm volatile(							\
>  	"1:	" store "	" reg "1, [%2]\n"			\
>  	"2:\n"								\
>  	_ASM_EXTABLE_##type##ACCESS_ERR(1b, 2b, %w0)			\
> -	: "+r" (err)							\
> -	: "rZ" (x), "r" (addr))
> +	: "+r" (__pma_err)						\
> +	: "rZ" (x), "r" (addr));					\
> +	if (__pma_err) goto label;					\
> +} while (0)
> +#endif

Cheers,
Nathan

