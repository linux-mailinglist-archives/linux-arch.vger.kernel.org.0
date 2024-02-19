Return-Path: <linux-arch+bounces-2482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB12685A10D
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 11:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197361C21796
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8762134A;
	Mon, 19 Feb 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cA5stCt1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F225569;
	Mon, 19 Feb 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338811; cv=none; b=QK+8AstvoXf1u7dffN2JyA1ehrRrhTB3PaZPxd+3j1TpQOxDvSpGGkXfij/VHQ0+kgf2SfG57THEQ0wyhJqdoBwamfqUDljfZ4PXiK2OggoYJMuiXij98P+rT00xCuU34ZInFs2PCYV7gB+rqkRpG89E+Opl8WST9tZten0WLok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338811; c=relaxed/simple;
	bh=hYm7WkcMdbIOHCa7DXRbcDKbwq23hMB8QI5GYSZ/CqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHGAwsIQWUsOf/x8YfayCqdCc9bPgS4YF7dDplGOcVZgivrQS/wjk4oQBfVOIoNhLqXJdkIDlg9EEycw+597bc9pAlrguktkd3OzK8a+q/LGMTtJqwh1flwoz5tCDu03eAp7Hy6GFq87DpAIJ5klX1ahqRoK3bGtNQhZ59AERe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cA5stCt1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6232240E0196;
	Mon, 19 Feb 2024 10:33:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iyhMtPag4SuK; Mon, 19 Feb 2024 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708338804; bh=5syt2LKb8k1pY+nLgFF678+w7+Ov0uwn7W+vhd/pEHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cA5stCt1GiCseXQkJKP2xd1f2AWMenc9Whgl+qHnRlt/L8nMZSWASReJwYQjdEc94
	 7CWyZt2TwGOPRf/6P5OqZW5eDA+bh7/kONnnHHkwDPTWhGtQbdy96QvfKCPFYtaQ4h
	 eWgs6TQ9pvEOvMkmZzeC8cKwa694wAhzNXLBULI9EK9YNbsGYCl+tgW9ZhkuuRoLcA
	 8X01OZo8wAEJ6q8go8EhyKp4M1TAGbwtlZzo5j3cArr1gcce+fDeRuw4QGh7VzVnAC
	 AQTRobkRUt838i4q1xGV32oo4TRumu5D5yQPN+lQfuSomP2a3eJkrmwOKXrm8aKTac
	 UBgwUVgv3eI3yUXGo2ZZc9uoLUpH4MX5kYh8CXZuQ1Pi65fJX7XtcrLRiQSpFNGtU3
	 qopfcMIIURjnn7fJXE5soOfogvaekD0ugnoDYAt+PT1dJ9A+mmRJ/E9ql3vyzYJIP/
	 a79WA/SYEeQ6R8rsFtS84Un5QNq6Ko2Z7XPaZyaLllhkM563LESd6YDss06rkonlqY
	 NjmzjfNtAKL5aiox0Ds9WjIPOf7cAd4Ul5wNYN1gTxSu9rbx/lKa/QLPdnb2Fkv+ak
	 bSdYUkIM8h3qvcfuGV/4imy5Um8JJMgkzBN7GXR9YM4tvv15dnpsdSfekT75RWMniS
	 iwVYin1b3xy0DhGiVPa41Xcs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF7F140E01B5;
	Mon, 19 Feb 2024 10:33:05 +0000 (UTC)
Date: Mon, 19 Feb 2024 11:32:59 +0100
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
Subject: Re: [PATCH v4 03/11] x86/startup_64: Simplify CR4 handling in
 startup code
Message-ID: <20240219103259.GAZdMuWzLGRg6SR1n9@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213124143.1484862-16-ardb+git@google.com>

On Tue, Feb 13, 2024 at 01:41:47PM +0100, Ard Biesheuvel wrote:
> -#ifdef CONFIG_X86_5LEVEL
> -	testb	$1, __pgtable_l5_enabled(%rip)
> -	jz	1f
> -	orl	$X86_CR4_LA57, %ecx
> -1:
> +	orl	$X86_CR4_MCE, %edx
>  #endif
> +	movq	%cr4, %rcx
> +	andl	%edx, %ecx

Let's just state it explicitly:

	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */

> +	btsl	$X86_CR4_PSE_BIT, %ecx
>  	movq	%rcx, %cr4

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

