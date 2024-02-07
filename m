Return-Path: <linux-arch+bounces-2113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3C84CD3F
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00E828B5CB
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1277E58E;
	Wed,  7 Feb 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H39KQxHa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8137762B;
	Wed,  7 Feb 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317484; cv=none; b=uLx+MIy52Fnr1rhQJfpNwsmXPB5zdHCGTjayalXNk4RXZ5b96MRgLXtIxcV8FIB1ZVMPOBxbj1dEEWGGa9/9YCDwSY7SOB58Z/elGCo8hbGbvgbS/qY+aD6dQ3soiCuagzow/2pUIxceHWp7vyAttrmisQOlfAUHZ0iHKUJ1N54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317484; c=relaxed/simple;
	bh=OOAbHlyRd6MHrlmkd/eS+sHShxOzcKIxp2jLwSfF0uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUoGSfFEbqxTbtQ63vs7mvcHDVeiZwnko0A5/tDQRrBnBDUjE1jopR1ybjfh4gGLkhk1iORWfZRgLNhKQnZ9DPvGfcSq0eG1m42aikO2bQOThS6htjeu7MiyRvhOCMVPc8Tt75lvOdtc1w52dDIC6/rdybRGvseirQG1BgvueQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H39KQxHa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CE7740E0192;
	Wed,  7 Feb 2024 14:51:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1zpc7Z4YBbwU; Wed,  7 Feb 2024 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707317477; bh=fX2I7dCXTcSn6Im5QL1hau5DXO0GnphgpIzn3tO3/5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H39KQxHaDOeU+IPzVVl2coXNiV/RFBMlJ+rauVCMVyCxKfBrgE31Km/KpaSjaIwya
	 21cu7wgUem8ZVTlivTa3+1nMfd+iggQjLzn08CDSyjzgafPaJhS2cTOJfaQezLO6Ys
	 mpMCwUcT46xixuVTLwXLRU1s2qayhSasN39PRt5m8i1Fq3B6e08wCwoIFInSjqaFip
	 +0scplbRZF34+iFWewB1Ui2ogPRuX+h8FlEImZsaL9R/rbsoLjC5iLmkckDxVRU8NK
	 KGfKNOLXT2cS5HD08xakmKwvVg6SgRXkDGPuN3QXSnyJWWWGjIqZLedzjfWeoJHTE0
	 TGvUXq6T3f4OEox1rOTd49a28CXH6iamAkPq4Pi7Is69fhU8E9IXA1JKRJ/X6Nqf5d
	 N67fR0LPmk5Qfwu6TqO1Mb7Z140H4EJkO4CLP8fyQuaq4gy0hIWIzDEfGYT94lqvN4
	 5wS5QjFl/OsjsqL4dYw/nzknxlqs95AkXGf82b8tlZpnHacDAYTkydQVnQBPbRj1xy
	 75rfxlKLCE4qX5kImyxNAcykgTTyFI0jm1mYRlJkJsdEpIumOf9pPfmZ+3RUZVdClN
	 uUDdTdnBqfl7CAot1EsBvxm4ixRYVS7Is+iEXSxqR3VGeLvLk8sWbDPJpLgdeZ6Neb
	 lRwzsXz/oq93H7GJEm2EcshU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2449240E00B2;
	Wed,  7 Feb 2024 14:50:59 +0000 (UTC)
Date: Wed, 7 Feb 2024 15:50:53 +0100
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
Subject: Re: [PATCH v3 07/19] x86/startup_64: Simplify virtual switch on
 primary boot
Message-ID: <20240207145053.GTZcOYze6ZBizogwf5@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-28-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-28-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:10PM +0100, Ard Biesheuvel wrote:
> +SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
> +	UNWIND_HINT_END_OF_STACK
> +	ANNOTATE_NOENDBR // above
			^^^^^^^^^^

leftover comment.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

