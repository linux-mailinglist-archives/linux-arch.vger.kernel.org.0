Return-Path: <linux-arch+bounces-2553-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60D85D532
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51A1286683
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF963D579;
	Wed, 21 Feb 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZTB+XIku"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22F3D39A;
	Wed, 21 Feb 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510186; cv=none; b=S/IR2Cim4Rrq5BiQtteGxUqx3cC9QOiPntjrog0ki/Ddi9cyXroh4QUwX9jcEVbLgB0UsHYyn9jrNRa7cPMdG+dmnZ1rIyl246l2RerpNY40c7G5nv3ZG5CNMu4vfRqxkXAtJzgJ8O8yFK/PjxgVb6LheA5f9vZtQEOeeGWjG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510186; c=relaxed/simple;
	bh=r5moT70R+oUVljSoprUOEoJfl4/tp6MaAnZM9QhoZhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPREaOB+sVHxFekEL9D+3fYk0PZ0Jwsc5xKw1AxfFNyXncnsFMs/5m9OoUIbOdfS6BvrU5p1NcNRHK2YDoRafiECY+gAzrcYurF8kuMyhAeBo1mRqhZlFlaJTKMdEpA2/Z3GjwhMlqnZK2MjG+fA96qvi3QaYGeLfnMThyjI+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZTB+XIku; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 48B7040E016D;
	Wed, 21 Feb 2024 10:09:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Dsl6LZ2KmMpX; Wed, 21 Feb 2024 10:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708510179; bh=/J8Kak/gbtX4KB6FH/imEHmEzO+kxDuIp4ODj+Ng24s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTB+XIkup8g+SSBh84HQ2Xcyp6++sEo5vmXc7I0izLOkKGf2BMVCAiuIUN+J+qKE5
	 5CXWJw7yjMzTjlgXV3JCpNCYOoXoiFx0N65k9rOnoCecF58ILlHlP+X104H19IrP5x
	 PsQj39A4azG3Q5napBKwLx6385WsADYKzPMRdone3iNlPF6ls5/y27AzgEZOcfXFQw
	 lWbqGJCNC4m3IF5jso1uyaMo8UkdSULyXOdQWOz1jRXP4jAhWquWOmdZ5z+bN8XQPw
	 VYHeqfvAL3o/89V8NqzTeZcUm+iI+5p+o49J4ToOX0bamV1i+rI+rhdzmAiv3Z6SsF
	 aaMQztGzhLA5FRh5y2PMxY5D1GL7aixLW9EtqB0ykOv+dt6fcfxP9XWNe833tUFUby
	 odn0T9fFKyFsodwduVs8L3rI3i0eaL3C8G/PsM9O0Ct1WaCxz2OM81e5IBp4yKNG+n
	 qfakPcaaHBXJKZEmGY+FrShbtGhwRaRk17nPmVLWEnJ6lVPGg73U6RwpFCNxLt8la1
	 4nQiuuUrt8RnSv5MYExPIxBjNzHQtizbfexkKVH3eJZ6DOOUVoXZFwFQD2Su6olgrF
	 fq0EyD5JYRKf0RtFBIb85lRyDIePbLBFx00mc4wNiasrcsuuB02rQoU4Q6cLORr07a
	 Z1GWl04RB1Hh1uCo6fBJHm8s=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F15C840E01A9;
	Wed, 21 Feb 2024 10:09:21 +0000 (UTC)
Date: Wed, 21 Feb 2024 11:09:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>,
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
Subject: Re: [PATCH v4 04/11] x86/startup_64: Defer assignment of 5-level
 paging global variables
Message-ID: <20240221100916.GCZdXLzHb-31GMw-f-@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-17-ardb+git@google.com>
 <20240220184513.GAZdTzOQN33Nccwkno@fat_crate.local>
 <CAMj1kXF=cGHR4FVUqGrobjB4HxTmm=1upn3TpVEC-_8D9GM=uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXF=cGHR4FVUqGrobjB4HxTmm=1upn3TpVEC-_8D9GM=uQ@mail.gmail.com>

On Wed, Feb 21, 2024 at 12:33:08AM +0100, Ard Biesheuvel wrote:
> Right, this is the same issue as in #11 - in both cases, the extern
> declaration of __pgtable_l5_enabled needs to be visible regardless of
> CONFIG_X86_5LEVEL.

Yap, I don't mind something like below.

5LEVEL will be practically enabled everywhere.

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 158da0fd01d2..eeb1744215f2 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -52,13 +52,11 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
-#ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
-#endif
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

