Return-Path: <linux-arch+bounces-2188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 686FE8516E0
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 15:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCEE1F214D2
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF353A8C9;
	Mon, 12 Feb 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DhAUe4nz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D63A28E;
	Mon, 12 Feb 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747525; cv=none; b=PvziyZvakNDAXDNYMyZ/3tw8ubu+DUP9ZHMaFGdGXYSkhJTsIXXEapxTr6SEuaHHbe2G6mvKJDPqC1VPd2/18DHF7KCKpe11eVvngcHMDDNXiE7tDQNJm4u/mU5B5P6U6rvXLdhUUk3zB7JmugxPqFgRt8wqH/X2W+ii8q6Velo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747525; c=relaxed/simple;
	bh=diPelT6Y5PrLF1JoSluZSPxFcNd3XxVYAnkF1E99aTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMrqqj1C3CuB/RPqoOlA57mscb0lfFO7zB6wJz+4zuH/gQhxAL4kY9ITVcTDCe8W6BcaqkVlpzxKM+CdDT1v5ozu1pzdwkc1xkm7Wyut4U3AzHRM2H34SaZpPWnrALVqps8PWYyK4DI5ED0Em8uucbE3UpvgB3zYsP/i3nCQPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DhAUe4nz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7747340E01BB;
	Mon, 12 Feb 2024 14:18:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nUZNN3hS0edi; Mon, 12 Feb 2024 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707747518; bh=Mbg10JQUB0lPBCtUWFlsiStYjE1OGMMzSdgwiAyceo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DhAUe4nzS0Hdh0Z391hKMbHgSf4e6xOHu++V8YdbKN5S+TlLEVNgEye38Kbi3UZ1q
	 y7LAamRaJ8Ve5Qdq1157SPrmjCz4mQ4mZbLvxDxXwAwh6lo06GZLr88r0Xyy7OcJVP
	 X027AmgWooiL95mCdCrhMNULBRh3RqOAIIFN59ZrVauKutOrnYThdc23FKkukNfSFR
	 UzWWx5gvOCDc+nOG0HpCklblR7wUpSVV/uvbEqPRkq53yPUCYK4++Er1fWa8Tup/dv
	 2d6snO2wIPPOGBhSYJ0yNEoVQDIUU8vn3DzFbR4P/+jwQB03RUhmgOo16eIpicCYiN
	 yf/L899rtLp6dbJgm2zxgDXN+XW2rRKp6rAMINoCiqJvEvRZWqGXGfVxzVX6WE6nrq
	 1orKZ1Zk0BjOBcnNUkqSFaIsgSe3a5nKHaSlqtoWt5DFWLuZNGHraAsyLeAclFmW0f
	 XFRCER6PhOMV4PnGYtNn0Um/0wnHzJ7/BIt25ODF/1szqbp5mwlG85wHuJwMdi6Yel
	 UPAb4rSeTd1BDSK4Op98DNp8+HZn/9Si1o4AVNyfLzpiYd0S60HEFK1MMyn2nTdXkX
	 987LeLXCMwx9fjDOPfVSELrbmxjd/qu1v3cpor3IMY4VBL21CZVaYQPybJk4mxRXDt
	 Uc8rbmrcCsvsufPteW2JvfWM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA46C40E0196;
	Mon, 12 Feb 2024 14:18:19 +0000 (UTC)
Date: Mon, 12 Feb 2024 15:18:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v3 08/19] x86/head64: Replace pointer fixups with PIE
 codegen
Message-ID: <20240212141815.GDZcoop-AL-a6kiHcY@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-29-ardb+git@google.com>
 <20240212102901.GVZcny7WeK_ZWt0HEP@fat_crate.local>
 <CAMj1kXH2uwLT-EgqYFRcC0OH524W=sYtDoFC-x+isifzsia17w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXH2uwLT-EgqYFRcC0OH524W=sYtDoFC-x+isifzsia17w@mail.gmail.com>

On Mon, Feb 12, 2024 at 12:52:01PM +0100, Ard Biesheuvel wrote:
> Yeah. That would means adding PIE_CFLAGS_REMOVE alongside PIE_CFLAGS
> and applying both in every place it is used, but we are only dealing
> with a handful of object files here.

Right.

And we already have such a thing with PURGATORY_CFLAGS_REMOVE.

> Thanks. But now that we have RIP_REL_REF(), I might split the cleanup
> from the actual switch to -fpie, which I am still a bit on the fence
> about, given different compiler versions, LTO, etc.

Tell me about it. Considering how much jumping through hoops we had to
do in recent years to accomodate building the source with the different
compilers, I'm all for being very conservative here.

> RIP_REL_REF(foo) just turns into 'foo' when compiling with -fpie and
> we could drop those piecemeal once we are confident that -fpie does
> not cause any regressions.

Ack.

> Note that I have some reservations now about .pi.text as well: it is a
> bit intrusive, and on x86, we might just as well move everything that
> executes from the 1:1 mapping into .head.text, and teach objtool that
> those sections should not contain any ELF relocations involving
> absolute addresses. But this is another thing that I want to spend a
> bit more time on before I respin it, so I will just do the cleanup in
> the next revision, and add the rigid correctness checks the next
> cycle.

I am fully onboard with being conservative and doing things in small
steps considering how many bugs tend to fall out when the stuff hits
upstream. So going slowly and making sure our sanity is intact is a very
good idea!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

