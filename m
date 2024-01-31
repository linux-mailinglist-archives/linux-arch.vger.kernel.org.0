Return-Path: <linux-arch+bounces-1928-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C874084448B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E97283EBF
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0512BF07;
	Wed, 31 Jan 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FT0Fzc15"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A010A16;
	Wed, 31 Jan 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718617; cv=none; b=mKzsT6QyZZtVmQFiqG9LJWRWjYDIMCpvbYTPV6Op1mtTmddzXQPrhj7sNZO9GnMZT8B3D5gBC4CSS1rg8GLVIoixhYSmIAALBTeg+tjIHT0J5GHDq3nfRaTLVfHZT/HTPVo+ajMEjgWiJh5TO9HH7oQv6pivLRFGeovoybAk8cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718617; c=relaxed/simple;
	bh=7V1fSgM4dCw5mlPpFTAU48pNl+7Y50/umf6DNk56DA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHMdwxjSi0DAd594tgdjm9JZGu3asSkLrXSl+1+QGA5I39orG7tZUCImTjeniTHI+LXgS3oXaBkoUtZGTYW4R3vfsCS39FIV5Ftkb4DCdcftTQNVEKqSXH9kuL2NlWadlv1O8yZ8XlqAlcq8MO0ps5Izw30Xo7E7NJIUGGX+NRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FT0Fzc15; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6290E40E0177;
	Wed, 31 Jan 2024 16:30:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7GQ7zRmXTudR; Wed, 31 Jan 2024 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706718611; bh=CwEErEB3kf4RV79ZYL4VTQTVVr1r+pmwOOZjB2GqHX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FT0Fzc15Ik8qxsIJb/DkO7GGIGwKyf5+d/2niv86eGi9vZs09M+9SRHZ0CaxTAkew
	 qQX/Hc0GsOcQDyshkSAOGiYxmlWV79/k8hs22cMauUhYQI3hfQ4DnCg3sC9ZYyLrGM
	 ot4jMX0I7B2caZfGD+YRNt6C3gDweittOAm1YTBM9fYGznDfpbyX4vKXd8AByNK3E8
	 ne8iXgwIhTDXWV7uyMN2ozEA+uoLzz6oXQtFyOlhjz7XTiCdbM5d/r2+Drq6gdjPsw
	 yak8/RlmQKstxU3LjZrjIG7aN6Hb7ENIsHb+Oaa5rOFq0P3wNnTQ7NxF3mVCcqEeWL
	 1N2yJ6/9axAyvjKOGeJORYRPMYrHxGKgTGgDID+IwbW9/RRDfY6Zjo6C+JNrE7eTP4
	 DJyST6GQnuc/DVlJlNSmM4yf++toYjZ0BxgbqQ3Vt1htYp81aA4wWm0X4vKMjpD2Oh
	 fGLKEvRC4hYYdUpIOGQ1xZCw/T8PcjY8Clue4YWYr6YAGwpl3iag6KLy4vQGZIDhhC
	 PMajdU1cEQI2GKS4LAN1OzKGjTisOLQlXeSSQNf5fS2sLGgLtMLUGaTU2MEu+bC8rv
	 sPTFWWpxh8qzdcTIUe55IWH3RxALfhpJwe/HewWL4t7b5komTAU5tKAoY6QHBYMe2s
	 rjlBaZ71WYEFlOQNT+aA6+fQ=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 256DC40E00C5;
	Wed, 31 Jan 2024 16:29:53 +0000 (UTC)
Date: Wed, 31 Jan 2024 17:29:52 +0100
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
Subject: Re: [PATCH v3 03/19] x86/startup_64: Drop long return to
 initial_code pointer
Message-ID: <20240131162952.GHZbp1gH7C7lNMRUru@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-24-ardb+git@google.com>
 <20240131134431.GJZbpOvz3Ibhg4VhCl@fat_crate.local>
 <CAMj1kXF7T4morB+Z3BDy-UaeHoeU6fHtnaa-7HJY_NR3RVC5sg@mail.gmail.com>
 <CAMj1kXGk1QivyoK4H5CVp7p-tfYoQSTuethpkm8bWBcTO_UMGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGk1QivyoK4H5CVp7p-tfYoQSTuethpkm8bWBcTO_UMGw@mail.gmail.com>

On Wed, Jan 31, 2024 at 03:07:50PM +0100, Ard Biesheuvel wrote:
> > s/int3/RET seems to do the trick.
> >
> or ud2, even better,

Yap, that does it. And yes, we don't return here. I guess objtool
complains because

"7. file: warning: objtool: func()+0x5c: stack state mismatch

   The instruction's frame pointer state is inconsistent, depending on
   which execution path was taken to reach the instruction.

   ...

   Another possibility is that the code has some asm or inline asm which
   does some unusual things to the stack or the frame pointer.  In such
   cases it's probably appropriate to use the unwind hint macros in
   asm/unwind_hints.h.
"

Lemme test this one a bit on my machines and queue it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

