Return-Path: <linux-arch+bounces-2481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF0885A070
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86ABBB20842
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31562555D;
	Mon, 19 Feb 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DSO0biVO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453C24B5B;
	Mon, 19 Feb 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336909; cv=none; b=O+Fgd/UPxltGsa74E+sh3tpIX/sU7A/WUQu+y4ah612SKYKC8N+MxQy81z9DVndvmIdVym0D5fkuj/AY3wl1fdW9muZKZZPX8tuoni009whXLYgsB/XjgqbPyysEexwj5UevZdT/7DbwFEaVNB3AFHM2IE6FizYFCKmSK9XknHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336909; c=relaxed/simple;
	bh=DkvBh004YMP18g+rDjXnfO1YHpF/pbeOMgSpQ2UDspE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aysarCFPEEixxXC5PM4YS1vOC+M+hop74qRx7+YTEJTV2kgiLGaSclAVIusSREKyYuJYVyhZPnVjprPYzWkH7KmdIuAo8zQjGy9TbcrrYir7dBY7LCTXr9p6M3qkieUErbyhGdjpni6+xAdcuChYm4TrUj8Tind6btfon6JqQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DSO0biVO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CAC3640E0196;
	Mon, 19 Feb 2024 10:01:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0cwy7_kgpFrq; Mon, 19 Feb 2024 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708336903; bh=jgU0oM8BzJYSGmIptTsYlIeGEq2K0D5cBNjOZMTjfVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSO0biVOpZubmEGrEOsfI0JHBzxWT/BPPO16AdNMtVINssQLY8BIb+EuOj7ybPRjE
	 k2LLYi6/o2p0QQJ2PXfZ6TXqEZMEsBFxLHzrTzdOeCXREzBP7e6qyrxVGiClCaRSfB
	 bUbvUNwGv7zBUpdKVIJpK5Uz4y6Alvxw+7BptdNodHeQJLGizOAE4DHiU8SorkQze/
	 EWvBhW1ZNyRMU7wIaWwRc+ExZvT8y339KxLMIJKxx+sKpHodd0PgqYceHspRj7EdBz
	 O6aShMaav1Z2DpDqoKNl4FzBICh6GbVNxhLeg1fOjxMKkt+YmkWtPI1RfFx3WROONz
	 pYvpFakqpugG7GJQofQAOuwdbslyrEOKRRABSj+t0e/NGX4g6A1BGLUtbTWLDkSr7a
	 lBHtKa79hZMGlPtmkmhB2SVdZ/GsQyJcFD3qYGNmqhDcQEJe6kYaThhtFlgH4krSmj
	 q6yBB+X6QgG0GFRW5gJV5xxVtzhUSMNw6OhFK6RAfg0ZDreUgZbg/swg7hqhzdOLGZ
	 OJTeQ6eUBgu50yLMmcZsir4h/wEDf5m3jr3MtuX38MgVLpxJAEBulpmqIQ/WFz89lN
	 lu4dtzSiRg7RJVyVVVMNTTYMJqvq2WUFrtInh0FPQ8/FhDvW9+L29zvBIGUEhCPNEb
	 /SpSfRpm8JV5WqV1xcGUR1zc=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28AD540E016C;
	Mon, 19 Feb 2024 10:01:25 +0000 (UTC)
Date: Mon, 19 Feb 2024 11:01:24 +0100
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
Message-ID: <20240219100124.GCZdMm9IAWoMcfEKhF@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-15-ardb+git@google.com>
 <20240217125102.GSZdCrtgI-DnHA8DpK@fat_crate.local>
 <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com>

On Sat, Feb 17, 2024 at 02:58:29PM +0100, Ard Biesheuvel wrote:
> More testing is always good, but I am not particularly nervous about
> these changes.

Perhaps but there's a big difference between testing everything as much
as one can and *then* queueing it - vs testing a bit, not being really
nervous about the changes and then someone reporting a snafu when the
patches are already in Linus' tree.

Means dropping everything and getting on that. And then imagine a couple
more breakages happening in parallel and needing urgent attention.

Not something you wanna deal with. Speaking from my experience, at
least.

> I could split this up into 3+ patches so we could bisect any resulting
> issues more effectively.

Yeah, splitting changes into separate bits - ala, one logical change per
patch - is always a good idea.

In this particular case, I don't mind splitting them even more so that
it is perfectly clear what happens and looking at those changes doesn't
make people have to go look at the source to figure out what the change
actually looks like applied, in order to fully grok it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

