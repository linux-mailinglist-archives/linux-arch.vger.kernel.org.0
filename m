Return-Path: <linux-arch+bounces-1889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2387484392C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 09:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F751C26857
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525B953E3D;
	Wed, 31 Jan 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zwrvtkcc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3037149;
	Wed, 31 Jan 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690143; cv=none; b=J6AtOLzfvZGwbfuv4/1dMFE1ImrdH9OTCsfhBCZs8pUNOMuDe243i17JUJXPIetKSLf86xkccfBsUYmg9Y0RRZtzXB/dK5XFzx+hbnPDFjKa/FKVa7Cavt8pGjb38AazFBUhu+jAgSgqUDGiHu+XkSMu+eMuHg+LUEanMl71A1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690143; c=relaxed/simple;
	bh=NxDDW81zyrs7kxVhirPfAM74ZB+GArrAzsWzsR1+ixE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUpK7uIXMZ/QfebutzFrdosrwLxPFM914MJS0eYny1a2JI+ZB3kGat9zlW/kh006bQa71DKlviqhIfC7oMsQqhNXS26IdYHb0qof0C76LvRd/X9vomwun9FsyIF3kWNYi6f48WZD3LuEL+xU2o8eFFeJPLEPiUInInSM4lXwgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zwrvtkcc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9450740E01A2;
	Wed, 31 Jan 2024 08:35:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D5H5JuvwD2rP; Wed, 31 Jan 2024 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706690135; bh=xURQLsUGYaQ4/5XRPeN2ACN4Xrra60hRGTkIk7Y7YVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwrvtkccKRg8bZ4jDh5jU+s8+WM4ifbbsjg+wXsL2donJtWAqneLDVYfm08FM62Ra
	 YPLh191VjLFBI7rRLM6CEp1/ktGJlxM0IqwLUxDSdmwENcwn5igyTeiNC7+rS0QPyZ
	 XRHo9AermmOti0ktm7qZoxExEgowg0+lKv+2otVwACXWH6wHRMlpJzrUhprR50DDbl
	 zsrYKhO1EUgfIR7s9BElmeW8krpFJ8mvkwdh+f/bp3YNOFPvycYCdRez7qfhOllRHq
	 xpiTcYQeroQSLbIPucbC3bnOej1Dujs+Lj2Fy90s9Z3+FURoXePGM6WXPdLev/ARYv
	 6SGNY3znons6uz74ShM+Ny7fpDPthIsEWEsBfIH3mi+cdo7nDlFxdVnP8igtE0YNMC
	 /wruhQizA/JXLI5vBXHWklIugIKP6mRFVidy2jENyI7cQzCWcuUpHjEy/HDksvBZ++
	 4+U2FACoZwKIEYvuSjHWKfVfvkyJ/tapIMRU3CXVNTORUBUycxhSWP9QILGVJFIYGM
	 8kgHS3WxhnRn6IisC5Se0f3zJMyitRRZSSmmz7pcc6CJMn0HJ+F07+YhzboVHsp6h/
	 FZaQZNEjLmAWXALLxZhI4G+9H8gQ/yZOfq5PU2qxyaX/o2hA0YKAARjjKqortoq4Zx
	 Y+YPK5O+MowySqghsgYgENrY=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 580E340E016C;
	Wed, 31 Jan 2024 08:35:17 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:35:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 02/19] x86/boot: Move mem_encrypt= parsing to the
 decompressor
Message-ID: <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-23-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:05PM +0100, Ard Biesheuvel wrote:
> +/*
> + * Set the memory encryption xloadflag based on the mem_encrypt= command line
> + * parameter, if provided. If not, the consumer of the flag decides what the
> + * default behavior should be.
> + */
> +static void set_mem_encrypt_flag(struct setup_header *hdr)

parse_mem_encrypt

> +{
> +	hdr->xloadflags &= ~(XLF_MEM_ENCRYPTION | XLF_MEM_ENCRYPTION_ENABLED);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT)) {

That's unconditionally enabled on x86:

	select ARCH_HAS_MEM_ENCRYPT

in x86/Kconfig.

Which sounds like you need a single XLF_MEM_ENCRYPT and simplify this
more.

> +		int on = cmdline_find_option_bool("mem_encrypt=on");
> +		int off = cmdline_find_option_bool("mem_encrypt=off");
> +
> +		if (on || off)
> +			hdr->xloadflags |= XLF_MEM_ENCRYPTION;
> +		if (on > off)
> +			hdr->xloadflags |= XLF_MEM_ENCRYPTION_ENABLED;
> +	}
> +}

Otherwise, I like the simplification.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

