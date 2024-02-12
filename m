Return-Path: <linux-arch+bounces-2189-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A374F851726
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5231F21EEE
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71A3B191;
	Mon, 12 Feb 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gyXUYzJJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5F3AC14;
	Mon, 12 Feb 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748669; cv=none; b=B8o25g3DBScUsTtfG0uHzDNNXH7ifAWMdjo0PIt17hZ8cLmwCLDiKSizXqq8loHCP1vhn7JA5D0xcXJMNfIAoZ4VzFhLTwmpVE9IJi9sbYMOAVV6XP8bjvO4UahZk+Zl+F4o2YNCprJUl9W+AfRez5+qQIgNCfy38dfo5wNk1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748669; c=relaxed/simple;
	bh=6G5In2RGjpJX+p/sg7+3OvwPp9FLksgdLhDaOx3NPUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6kp1hFOJyXCHxu4TZ7sBnbu7Gb7xpME2ctDFSoexmFRta4AsBS9PLHnQ6TjGe8J2dXTYnLzptutLkVIfERk6sIdYUvoGOs2deNem9Wh5lCjYL64nsJf8TffjYe0ctKjkA2KF9/5Yyaap9tQsfuLvanLLFcztzmlcg5uT83iWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gyXUYzJJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AA50D40E01A9;
	Mon, 12 Feb 2024 14:37:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZKE9Nn0mHkUz; Mon, 12 Feb 2024 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707748660; bh=Nj4+Nv/GOcwQjl8Q/LRywqi7hPwofWlO7fkBl1DH+Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyXUYzJJS05nD8vOYF47esX0MHwuVXfZTZav2H1nO8ZkK7ajVHINvRit9GeIxImtM
	 fIJ7wdHqvE69eaRe2yCckj6KWO/Q6DO82RL8NiGpZG7vK9Ypea51Qlx6KOvGuJxDHi
	 +CKnhhLiSvCsk1k+CcZ9TIzvB2bAIqFOqKwY5mCilWnrkSRy9gsZWqUbJtO+jfbtmf
	 LqbaGIjTkgEtkFZUupDpFcWFSk9K7p43ySQomv8FNYtAAD2jDN53NRRTmvmhZ6LNE3
	 NEfxvz4ETTRE5/tQ3U9wQhVpNFWSdOnqghvMVarN/42VUt9Wl54FNufDJy+/hrOt0c
	 uMV7vNsdCQS7qQ21pJDJEzAPi0ljyR8YRuJoH8oFxkXPKJ8AT1Xr98/7Lo8HWdqrLV
	 KQY3Hx3yVRJNcRFyIXDmDGi/tKuYgBKURL0T5cVTaNLy8VywVL32dSZO+72g+bvrHJ
	 rNRtmCWPTbFlFCGHSK88mOiGB7GSIlySVK/LbFmAuQ7zlwO/PeH0uEv2wWpsOVGQ2M
	 yfnxJTZe2IDfxvkCyA1ydPP5YHT9BJyg9v/stWsvcae6n/2q6RWwvrCjuGRbMBh+h0
	 HObk4i48eAYjC4m8hj6+MCttDyjMB401NdKA4BqVfH/c27K6qIjQHLLAp/UCel4dK9
	 zNbcYCcNfPdszp5iUgHM/f4s=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D07D40E0196;
	Mon, 12 Feb 2024 14:37:22 +0000 (UTC)
Date: Mon, 12 Feb 2024 15:37:17 +0100
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
Subject: Re: [PATCH v3 09/19] x86/head64: Simplify GDT/IDT initialization code
Message-ID: <20240212143717.GWZcotHRH-8a3x1gTH@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-30-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:12PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> There used to be two separate code paths for programming the IDT early:
> one that was called via the 1:1 mapping, and one via the kernel virtual
> mapping, where the former used explicit pointer fixups to obtain 1:1
> mapped addresses.
> 
> That distinction is now gone so the GDT/IDT init code can be unified and
> simplified accordingly.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/head64.c | 57 +++++++-------------
>  1 file changed, 18 insertions(+), 39 deletions(-)

Ok, I don't see anything wrong here and since this one is the last of
the cleanup, lemme stop here so that you can send a new revision. We can
deal with whether we want .pi.text later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

