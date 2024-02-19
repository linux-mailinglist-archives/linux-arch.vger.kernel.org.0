Return-Path: <linux-arch+bounces-2480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929ED85A056
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 10:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB4F282518
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300CB25561;
	Mon, 19 Feb 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bV7MdM5w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744024B4A;
	Mon, 19 Feb 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336560; cv=none; b=XZHEIsCJ6SoubZMkXn/MytONSgSdRXvZBn3faTu8xw3gPScFCYFSDGCTqmRw6ZmfrAmYqF+ORic7ZjEYZGl1E2oEQfJJooCBQMgwI1gLis6T8UU3jNOQ4RB0y6q9vvQR5yDplyMKxJCsy/cHreXiszguNQhwIHAolomsWG3JHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336560; c=relaxed/simple;
	bh=mkFJrK9m2g9qvHsLry8sEEDtONNLADw755YVxKmZnBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUPQ0YZJwIbQmyoUJibiWRMTfuoUTKKXZ6fYm68VkZeFUY7rK6vYUyS4XHqcf1Hu3DMN2m61JDOtTw+pT9h8HXJmsBvoHdNPifibcI0fXSouyTXs4SOLnX1bcT/B5D5oSgLsBK67TB5Epo5HahhhoB8ZhP/GKc96vtL/C3kY650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bV7MdM5w; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CD0BB40E01A9;
	Mon, 19 Feb 2024 09:55:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HvnjbMRv23_K; Mon, 19 Feb 2024 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708336553; bh=4tthTyo+u7KOe2IWgTAMZfzehzzv45SAt/4Gu433d9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bV7MdM5wyxwkEX3mJQq8OfT83Ix90OtLnDD6aOtLGYGfDwY7xMGc+0FkjfjJ+YGZZ
	 MNFojlOm8hIl19xFDBlPhVFu74hqxdC/wbicF2RUwdlOmdLWTnHQIo9TX4dScnkpuI
	 iA7wpbg9q/lMYF9uE9+Z3JKBPN0Uj2dYq+QkexFXMpv17B1YFPUeptGIPRiCsLB5G7
	 9/z8dICZ2ICiAqXwYyCD9UhCBLXuLTfNGfno4fwCS+z7L8jK/v7uDRkAyuBDyW23YG
	 Yc5JzaziRgTTcxyKn/TuECsiJuGGB+3d/dZrYBu1bFXbR09Qatjbwr6IQ6kT9Bla+u
	 Ij1CobHGy7OlokSnH8FaTB/7fSDoafWQcbSJyRSpPqcqeCP2FaQuQhl8V2Dh+FioTJ
	 v0k8Y+JV8/zIiK+AY7YakIIsCzre0hPjtc39xSToHL1Ydy1/6nwZgjLcR2HruBefpP
	 h0Y6u1pMAmjkbWak+PvZuZkIEqk/jI4G5eDaotSDM1izNzZHbts0zNj/HS9HiEgy9R
	 +LHY7Pu29lOvEOTWd55+zJ/C82KbJOUEzR24HDzeFuV6A/ontzX0aODFgUL9pB9xp3
	 RqQknGBcf+D9SScbJzmnUg3wOzmSk/QcNcoCXx0p/FzzkhFy4ty9Zjm/Iw4KcNjPP3
	 RcvJdc0IPzXIbfqoglV6y6+o=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58C5740E01B5;
	Mon, 19 Feb 2024 09:55:35 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:55:30 +0100
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
Subject: Re: [PATCH v4 02/11] x86/startup_64: Replace pointer fixups with
 RIP-relative references
Message-ID: <20240219095530.GBZdMlkgf_jzDxM8XR@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-15-ardb+git@google.com>
 <20240217125102.GSZdCrtgI-DnHA8DpK@fat_crate.local>
 <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com>
 <CAMj1kXFkX2hwt7Z-_xMveC-RHrxmXWcrneVH66HsjBcXOLAH0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFkX2hwt7Z-_xMveC-RHrxmXWcrneVH66HsjBcXOLAH0g@mail.gmail.com>

On Sat, Feb 17, 2024 at 05:10:27PM +0100, Ard Biesheuvel wrote:
> Maybe this is better?

Yap, looks better.

Btw, when you paste those diffs ontop, can pls make sure you paste them
in applicable form so that I can apply them and look at them in detail?

gmail mangles them:

> +
> +               pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d |
> _PAGE_TABLE_NOENC;

For example, linebreak here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

