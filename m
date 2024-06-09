Return-Path: <linux-arch+bounces-4762-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BCA9015F0
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 13:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9112228119B
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470023749;
	Sun,  9 Jun 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YRHmiY2l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA581865C;
	Sun,  9 Jun 2024 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717932184; cv=none; b=HSrGIcJSlZzuSnv4kMCvHKRBtXKBRQivk2zRumtRpjbTmZ7imC9DLZBOKTX86tO9jkiIG9IVg7l+7g+5+qsgjQkZhvwdx9whr3gC/fI4xjcCEmS+4/jN40dJ8qBw2VuVOmm55vzmjfWuBkPL6LoaS5dylUnKG598DjBLraUVnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717932184; c=relaxed/simple;
	bh=VE6QwhzHXGGsL6EN23G7rodAUHJBH/uKxOmJM1ROGLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGT3DAkq5FAZR++GDED/hd0qrQ7A093itAFGhM91NIMnZTffiTHjQtBv+7v2Ejbz8t/G2waS0pphlSO0xXuUELu100IdDKzJtnle4h3WHkDtUuvaUYTYF4Sy2NOsYAxbd6tWp0MbDvXXCOIq8lyD6P8uXiyxNc/hTui0Xe6hHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YRHmiY2l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 192A340E016E;
	Sun,  9 Jun 2024 11:22:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1fvZKEsG9R5s; Sun,  9 Jun 2024 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717932175; bh=Wvqqzt8mRbBVpIrsNZaWXP6FfYaMmAg35B1wSRhrLn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRHmiY2lq5i9UbRqPmzL5EHzi+yjVKQEqYQ6+jkT/MPUKhEJ37/IkH26uRyV+zotS
	 vCnF2wJKPy8bDiGMwMTWntUn8504NQkZkhXzUB1VZtO+OIKxu99LHXbqO6r4RhyJ2j
	 N01Lg8tsVCtnh4QK8eQsK1dSii6HwWR0Ep2XJRD1gp+dy+UJolT6PrkwU68jpUA76C
	 e40CPRJz5RpwQynC+YSJBgAFcEI6ahIBCcxUsUmNywbX14g8j5B9MzwEhuPPqG5WtO
	 VEutse9TFvEUOaYI3b/wXvSU15acCtPM+2u+1rZr0Jz+ihzK4YhCz9zDaVwMSDhgYw
	 uXHMOBmeQDtQ+N8sJT5ZnL1kRS7pbE2nl9XxH6olFh91yPMwlykGlQkhCEj/iSshcI
	 PeXp4m29nF/FqAD+L1MtAfMes3EITQKxRRro+R6h/IxbOuryhsxa5NCd11nY/G/QDJ
	 l6XsHBTXt65NNSpu2BG44Z8O6encs1VxNP0GS5Y6LHVjcOiTCbIE4SORJmIu1qnu/Z
	 rvD6IOrwZSJFsF5zKfu09DhVyGtjs/lPmT3QtKIvvmIoFqMy1WcKKP7OCZKWgIt5yL
	 e8EGRMjF2/X0FdQyoL97AacrUSpWTzEPgsHX9bruxu71nxlxqgLuYmuY0B2BiMVA7S
	 +5KcQGE6/YiUW4HXgnFRC3oc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD72F40E016A;
	Sun,  9 Jun 2024 11:22:45 +0000 (UTC)
Date: Sun, 9 Jun 2024 13:22:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
Message-ID: <20240609112240.GBZmWQgNQXguD_8Nc8@fat_crate.local>
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240608193504.429644-2-torvalds@linux-foundation.org>

On Sat, Jun 08, 2024 at 12:35:05PM -0700, Linus Torvalds wrote:
> Ingo / Peter / Borislav - I enabled this for 32-bit x86 too, because it
> was literally trivial (had to remove a "q" from "movq").  I did a
> test-build and it looks find, but I didn't actually try to boot it. 

Will do once you have your final version. I still have an Atom, 32-bit
only laptop lying around here.

> +#define runtime_const_ptr(sym) ({				\
> +	typeof(sym) __ret;					\
> +	asm("mov %1,%0\n1:\n"					\
> +		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
> +		".long 1b - %c2 - .\n\t"			\
> +		".popsection"					\
> +		:"=r" (__ret)					\
> +		:"i" ((unsigned long)0x0123456789abcdefull),	\
> +		 "i" (sizeof(long)));				\
> +	__ret; })

You might wanna use asm symbolic names for the operands so that it is
more readable:

#define runtime_const_ptr(sym) ({                                               \
        typeof(sym) __ret;                                                      \
        asm("mov %[constant] ,%[__ret]\n1:\n"                                   \
                ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"                   \
                ".long 1b - %c[sizeoflong] - .\n\t"                             \
                ".popsection"                                                   \
                : [__ret] "=r" (__ret)                                          \
                : [constant] "i" ((unsigned long)0x0123456789abcdefull),        \
                  [sizeoflong] "i" (sizeof(long)));                             \
        __ret; })

For example.

> +// The 'typeof' will create at _least_ a 32-bit type, but
> +// will happily also take a bigger type and the 'shrl' will
> +// clear the upper bits

Can we pls use the multiline comments, like you do below in the same
file.

Otherwise, it looks ok to me and it boots in a guest.

I'll take the final version for a spin on real hw in a couple of days,
once the review dust settles.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

