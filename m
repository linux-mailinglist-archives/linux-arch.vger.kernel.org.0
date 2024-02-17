Return-Path: <linux-arch+bounces-2470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD2F858F60
	for <lists+linux-arch@lfdr.de>; Sat, 17 Feb 2024 13:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D230F1F21AAA
	for <lists+linux-arch@lfdr.de>; Sat, 17 Feb 2024 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D716E7A714;
	Sat, 17 Feb 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DMG5e6QS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED93657B6;
	Sat, 17 Feb 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174297; cv=none; b=Ck9pUXeFRAUKW1ldphvJKe5dfdpyjSap/yPfnxdzTq3cFd/tbQoezzDZf2ODsM12F9pCsHthgCUsDpA50sCjxkzFfSb2tRxtM5pqGg5NVqtTyzRFrVkLm+bjfj3t4yLOVn0O7X4MxuxMDzHM49Pi+H1zm8QhIGxfpXbvrnoJJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174297; c=relaxed/simple;
	bh=dOMpZYdm6byi7dSGtTU7CXpz9fL2H66oVNawiZq9BTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xhw6FfYZxC7XiaHLSb6mMR51DE/ziK/tXJmoThtAfueKMppC1p9JOkddYc8xH0UB7Kc07QTNBVDW+UrS6GhcXgJox8rfCjImi3YMgOUYSOZsHwf6snCI9sgGegLjBQCByN3Yo/N9ZMT2dUcDwXvoHZb+SVRRjBq6LmpJjsc13bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DMG5e6QS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 40C1F40E01A9;
	Sat, 17 Feb 2024 12:51:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0hlCv3lIl4HE; Sat, 17 Feb 2024 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708174288; bh=qo3uSORLj3aVIspHnZOOPPN2BG8DeKw0xfrzHn1JOsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMG5e6QSKeR9ubDYe2s0ZoiU51BCQvwIEuO4RCuRvQTeQ8TmKrZw5+z0J5aEFgswY
	 dZB3Su8kRvsIYCLw1goi1lxlw6+XoLZtp9ebursTnwYRZDBmK6MHhFZwyrvaLbOCkY
	 HOMZ81djkewhE8iCb1UTKOyl3n523ot7waAzw4wPFGGazCMtJm/BYWisD714CnvEoC
	 jpv8QnvEsk0+TqoGEx5In9rBjZfucgWjYMKfShUM6qSJP6tYXHHUSOhg8u1xTn+TIe
	 tQmZmiQgUNXNt54NgYCf+Nf0/wrlcI4CxHH0EBevuyQljR2U1pxFcTUCNU6gp+a/SV
	 ry1dzpYHJexsOcX35pmggxd4d33+M7MfHqB+IU91Cm4A1vOYMd+NH3zAZOe1fUoNr7
	 mwlT4BEmTe9n9NCUWR+WKjPvK+xO1xUVMIAq4PNqx774FWt2SsnnM33FYnDZN67fiH
	 +JI6MkFtLSW8AXNjhY5aO/A+V4FU7WVTxX6P9HsFAxhGArFhushX1uBzCACkY+pfSV
	 HjVBhjZAzsliTvBpnfQSatzLe6mx38Oj5YTXDQfbZLXRZ12nsIONnKJ7dUtkEeNLkE
	 BM7/ooFdvOW1t2Du6u4bcg3yrmfN4sTGUW0leRQnLfBWqLyJPmSmTQgTHeHVn31o7j
	 DsztjJPMNkNsAcDM3brtS7E0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 969AB40E00B2;
	Sat, 17 Feb 2024 12:51:10 +0000 (UTC)
Date: Sat, 17 Feb 2024 13:51:02 +0100
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
Subject: Re: [PATCH v4 02/11] x86/startup_64: Replace pointer fixups with
 RIP-relative references
Message-ID: <20240217125102.GSZdCrtgI-DnHA8DpK@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213124143.1484862-15-ardb+git@google.com>

On Tue, Feb 13, 2024 at 01:41:46PM +0100, Ard Biesheuvel wrote:
> @@ -201,25 +201,19 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	load_delta += sme_get_me_mask();
>  
>  	/* Fixup the physical addresses in the page table */
> -
> -	pgd = fixup_pointer(early_top_pgt, physaddr);
> -	p = pgd + pgd_index(__START_KERNEL_map);
> -	if (la57)
> -		*p = (unsigned long)level4_kernel_pgt;
> -	else
> -		*p = (unsigned long)level3_kernel_pgt;
> -	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
> -
>  	if (la57) {
> -		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
> -		p4d[511] += load_delta;
> +		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
> +		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
>  	}
>  
> -	pud = fixup_pointer(level3_kernel_pgt, physaddr);
> -	pud[510] += load_delta;
> -	pud[511] += load_delta;
> +	pud = &RIP_REL_REF(level3_kernel_pgt)->pud;
> +	pud[PTRS_PER_PUD - 2] += load_delta;
> +	pud[PTRS_PER_PUD - 1] += load_delta;
> +
> +	pgd = &RIP_REL_REF(early_top_pgt)->pgd;

Let's do the pgd assignment above, where it was so that we have that
natural order of p4d -> pgd -> pud ->pmd etc manipulations.

> +	pgd[PTRS_PER_PGD - 1] = (pgdval_t)(la57 ? p4d : pud) | _PAGE_TABLE_NOENC;

I see what you mean with pgd_index(__START_KERNEL_map) always being 511
but this:

	pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)(la57 ? p4d : pud) | _PAGE_TABLE_NOENC;

says exactly what gets mapped there in the pagetable while

	PTRS_PER_PGD - 1

makes me wonder what's that last pud supposed to map.

Other than that, my gut feeling right now is, this would need extensive
testing so that we make sure there's no fallout from it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

