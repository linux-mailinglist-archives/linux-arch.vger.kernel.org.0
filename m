Return-Path: <linux-arch+bounces-2089-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E08497EE
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 11:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB10328591E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 10:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83CB182DD;
	Mon,  5 Feb 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hen6ilYr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778E182D8;
	Mon,  5 Feb 2024 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129679; cv=none; b=RLfaEviG9WXhj5XloNPT4jWkFbNvpoFh1J6lZRNWYQcGMZ8jBPxKN5wHnKj1lUo+uh1ckGRqM8HPRQD26oFs7irfyd0qaAf7WxI+c2NDkUaxd2VktO4rNHEcR8/NLEJ+apHre8/1bA4NrZNzZpzm8bOcD0wTJ2kNRfqx5iBYjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129679; c=relaxed/simple;
	bh=wssURT5v7um6YcanCz/wfG32MiB35I/5gzvQQspAiwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxndj2iSc/8LUcedVkGmD8G28xt7hHdOusilj4Wja+wUyKJULPwbbX4zhPqgw93aMZRmo1/2i2G09S6+q732Kp4926oFAgu2sZrvyEDexshvqoQa1ybSofISM8IeK4HVK1jxngOY5l8nDNyeA6HYj4WYppEkzYNIIDpM106tPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hen6ilYr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 03FCF40E023B;
	Mon,  5 Feb 2024 10:41:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vy97vtsPc2wl; Mon,  5 Feb 2024 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707129666; bh=OmsWebiGN1qyvPWoDA+cPPiX53nBdnIUWelFJrj95ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hen6ilYr/nMmO0Op77bBmLHDxGwIGP5TzW3PENBHg8qXtm7vv4s8QQwIMjbE68Rri
	 hdGxQa5sv6ikRzOjZb4XFfY1G2Xi2WwhJcTHZwBm+uDvxqgsCowHPu5mzn6BGP8mEU
	 G5l2B+yOZ6pjxWbKLfznwOxY/AlfPfYsY1sBYcKj5ziczH1Cbn4aEuZQeoy+XbsuDj
	 78PXe5+OFPJRU8cZrzzKSrEHzV2eBrH03ULU9JOqPJR4o0ISwivZteEcznkvUN+n5U
	 DtWhv1UMeSEFOCDu6aSHfvsYuFkng1Hmhpx3+sThg7cPFLbsIb9jUZf2Cr2bKjUlTg
	 W3yk2kakDCCVuFi0G9fDkqEq6Oe+xmnQS9VNchkpbx1UxYsD6cuHDYlVp5OX8+imOw
	 5aYTzhQ4uI+XOhtREqCqjG5Cd5tmp1CJJ/YRkuz/WAe2nnV+PsnT/jjRW8yzQQihQy
	 zZRI4A/NR2Y4PTjTPQ5FI7tuHcCj3PnUEchCmjbxw99iNAWYZvPJOPcrHAHzqDF+xT
	 e1kqH+q6slm7Rc3J4zQwLBXGbgwuJ14Ke+MSWMHP+qkm/2Dts03BN2jKxBqrBtUy6k
	 bbWNkrSvCLedHDYsa5mN72aXbq0gvM15szPcN1s+XZJUQn6j4G4fZ/uDxsNZvMcYsb
	 akKY3eE3Ush9ae87yS1mXAh0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B16B940E00B2;
	Mon,  5 Feb 2024 10:40:47 +0000 (UTC)
Date: Mon, 5 Feb 2024 11:40:41 +0100
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
Subject: Re: [PATCH v3 04/19] x86/startup_64: Simplify calculation of initial
 page table address
Message-ID: <20240205104041.GNZcC7KctURKeu_3wf@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-25-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:07PM +0100, Ard Biesheuvel wrote:
> This is all very straight-forward, but the current code makes a mess of
> this.

That's because of a lot of histerical raisins and us not wanting to
break this. I'm single-stepping through all these changes very carefully
to make sure nothing breaks.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

