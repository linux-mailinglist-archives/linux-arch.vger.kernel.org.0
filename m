Return-Path: <linux-arch+bounces-4825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66543903D03
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6471F230D1
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905D017C9F9;
	Tue, 11 Jun 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DxvdD84i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C11E49E;
	Tue, 11 Jun 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112083; cv=none; b=RYN1FUhQAMG2/S2vTbxfEgyrw4kqUFf3U/vsIreIvolJ2tfWFU4i/imCq5aP7+n11ZGAqIat5DdCXLdSrcLBRMKG5HxqBvgzpnyyg71GfDmIy/LRWxftQLbl/vBZNXWwt1TtMyvijD6uz2P6jhhM1fDfhkAHIODP8WuviSOo9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112083; c=relaxed/simple;
	bh=X1hSkvk6h7lhP8sMpTcZZ7DbBkJ7/im+J+Og9GUrz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9bFYjaA7buVFWnsQ5CsIgzgxIPZ0EO2eMJNTD/vv3orkNUENsOYQn88Y+e8pYWBOKinp9GmmCmUXt/aKW3EBBLN/oTITsPIgtOrRsOj1FOChAlDygDMkcrI3eZAPp0ve64OY/NTSdvV4XXB5V6zueskLEAOOOc1ZF9+pfprUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DxvdD84i; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8AC4A40E0176;
	Tue, 11 Jun 2024 13:21:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NZ1hmuE9M5Y4; Tue, 11 Jun 2024 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718112075; bh=zQ+BxX3PrQzzODbCatHqH6d2NIV0kiBDQVnXJqq7btA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxvdD84iZ7vkwy/GvG5iLU+PF24hOVegUPStZg5nj4tulE2nolmF/5l+Jg23Mzrb5
	 pKSKtGl5mNzmXW1VQxPq15vrql+olUD1H1M8KhNjltUoUp093Y51ig1IBgtN1lfQQE
	 xLNjFs9Ayl547gAgAmk3p4p3ULlBgfCy/PL7V6laE062RfDkQUVAUh7atsd1BU9eIM
	 730R8GrY2PFFPqH7xxlFzcYqyg9un7lXmf2Gg9De99JYcLejzt4X3csmYu0PVv5Ut1
	 A+av9GKUlgUvANRvbIXCvc6XsByLhpEzigdXdK2Xzr79YOROzgrddx2Fm/M77dmn5V
	 y4TulMB4/iPnm6hleHLUjlCBWVyF22p0OLnqEndmuOCuNo0lUeonGK5q6opIl3pw7A
	 JojicZc0dVrVqCqlUzVfaHkwqeGbKoziUkrayZYt1KvJgfX/iu+SiYqlaCVtgBspM+
	 cnncKbWju/zrnotRrZeTlL7NSFiIe12cNXefqF2X7x9abige97bg82tL5ButTOPnVW
	 icFgxAZ2/thJHuzTCeE4wQc56T6eiP0f0zzK2bLMsXfs1LB5YeWcxzcSPUhpiMW+1O
	 D1jGWI6Tsi5Mxx3JtspmXlpKIPNGE9C87SeRbd43WLotmSDQ+x7LD9nn+F5jSWVEn/
	 4lt9FT9kKutm2+i6Gv+afIsc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E66540E0031;
	Tue, 11 Jun 2024 13:21:05 +0000 (UTC)
Date: Tue, 11 Jun 2024 15:21:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
Message-ID: <20240611132104.GDZmhPQNZm3vOBRA32@fat_crate.local>
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net>
 <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
 <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>

/me saves a pointer to that mail to show to eager submitters who will
want to jump on this new thing.

On Mon, Jun 10, 2024 at 11:20:21AM -0700, Linus Torvalds wrote:
> So for example, if the code could possibly be a module, it's never
> going to be able to use runtime constants.

Perfectly fine with that.

> If the code doesn't show up as "noticeable percentage of kernel time
> on real loads", it will not be a valid use for runtime constants.
> 
> The reason I did __d_lookup_rcu() is that I have optimized that
> function to hell and back before, and it *still* showed up at 14% of
> kernel time on my "empty kernel build" benchmark. And the constant
> load was a noticeable - but not dominant - part of that.

I have seen mails from you, off and on, about __d_lookup_rcu() :-P

> And yes, it shows up that high because it's all D$ misses, and the
> machine I tested on has more CPU cores than cache, so it's all kinds
> of broken. But the point ends up being that __d_lookup_rcu() is just
> very very hot on loads that just do a lot of 'stat()' calls (and such
> loads exist and aren't just microbenchmarks).

Yap.

> And yes, the benchmarks I run are odd ("why would anybody care about
> an empty kernel build?") but somewhat real to me (since I do builds
> between every pull even when they just change a couple of files).

You're not the only one - I'm building every patch too so yeah, got
a nice Threadripper for exactly that purpose too.

:-)
 
> And yes, to actually even see anything else than the CPU security
> issues on x86, you need to build without debug support, and without
> retpolines etc. So my profiles are "fake" in that sense, because they
> are the best case profiles without a lot of the horror that people
> enable.

Right, I run with the default settings because, well, we must eat our
own dogfood but yeah, all that zoo of config options to disable the
mitigations wasn't added just for fun so others will run similar
situtaions too, if they don't do that already.

> Others will have other real benchmarks, which is why I do think we'd
> end up with more uses of this. But I would expect a handful, not
> "hundreds".

That's a good rule. In talking to Peter I also didn't like the thing of
having a single ELF section per variable but if we're doing handful,
meh, ok, I guess.

> I could imagine some runtime constant in the core networking socket
> code, for example. Or in some scheduler thing. Or kernel entry code.
> 
> But not ever in a driver or a filesystem, for example. Once you've
> gotten that far off the core code path, the "load a variable" overhead
> just isn't relevant any more.

Yeah, that makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

