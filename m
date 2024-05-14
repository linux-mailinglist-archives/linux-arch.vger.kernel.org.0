Return-Path: <linux-arch+bounces-4398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105478C586E
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180631C21994
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700517EB82;
	Tue, 14 May 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHyHF8CG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F971448C8;
	Tue, 14 May 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698976; cv=none; b=imq/iTErfFzO8NJ57B1nf7ZyeAm21/OojeyQ4q/dPeuYycvp2wSoWhUek0c5+TX5C4hIPLXguyg7MWSYmauvWo2niweIvijIFmWjxzyyrd//rWr4dostOfotkmuuerXsA4n4EAdFieuH42XRw8YzUZqL4oX4YIKU+mFdLWEJcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698976; c=relaxed/simple;
	bh=qXSXhAaDwGgQP2ADIwaMUOx4lgpbJlAYOhbtaN38fGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+qhlBUmXVp3XzdHcu7QWNYEbWadsrNEcfAvD7EF/Pzp4IHF5nvnVxNStCF9ejhgO8V6JoYPp6YAlrKPXt8qVGSOV2g8OstdvESBWaCIsxxsMrwFEObK+G35fhrkMnKTJMMaMujYpmUdw1qqrwFsjrokYSsLGaLlNKloh2h+/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHyHF8CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEE0C2BD10;
	Tue, 14 May 2024 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715698975;
	bh=qXSXhAaDwGgQP2ADIwaMUOx4lgpbJlAYOhbtaN38fGg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nHyHF8CGKQ+uulpBZyC6m4NeeRAGCL4A+cI+S7UJOyHF2b4uZD7bPE3e073LH+yZM
	 fD5mZupiBIBMhHGLPJwYwwy2txzGX+Q3aiS2HmrWPh1nU/ICVj2g0LDIkjGQ+DcapZ
	 gUzLNYJvF1mzFjbcJvCj3t1JSBrxTtZWjqSIr+9+QFq6s1ptfaCgX4UnpOKp/su+pE
	 iyKFc/rC8m0txhtipaiWFa7owIfRIXynvx4Q2RW4T79MO1jcmeWOthlxS4xHEJqaT2
	 1qPTDu7cmrs3c6iS4SMdUf1r2FeeiJgM3R5J9YaNCGcNXm4+kqsk90/nTWUKsG5yUB
	 xONt5vl49UOnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1D979CE0485; Tue, 14 May 2024 08:02:55 -0700 (PDT)
Date: Tue, 14 May 2024 08:02:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 cmpxchg 09/13] lib: Add one-byte emulation function
Message-ID: <a4451340-fa42-4255-9940-fecd4f0c4269@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-9-paulmck@kernel.org>
 <ZkInMNOsLO5XbDj5@boqun-archlinux>
 <9f0ff126-2806-488e-97cc-7258eff0c574@paulmck-laptop>
 <ZkI4XPJLeCtabfGh@boqun-archlinux>
 <ZkKD6UqXZozp1p-W@boqun-archlinux>
 <29f1d801-9fb4-4ecb-8d5e-cecb7d7a76e1@paulmck-laptop>
 <ZkN64LAeOfHAXyUM@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkN64LAeOfHAXyUM@boqun-archlinux>

On Tue, May 14, 2024 at 07:53:20AM -0700, Boqun Feng wrote:
> On Tue, May 14, 2024 at 07:22:47AM -0700, Paul E. McKenney wrote:
> > On Mon, May 13, 2024 at 02:19:37PM -0700, Boqun Feng wrote:
> > > On Mon, May 13, 2024 at 08:57:16AM -0700, Boqun Feng wrote:
> > > > On Mon, May 13, 2024 at 08:41:27AM -0700, Paul E. McKenney wrote:
> > > > [...]
> > > > > > > +#include <linux/types.h>
> > > > > > > +#include <linux/export.h>
> > > > > > > +#include <linux/instrumented.h>
> > > > > > > +#include <linux/atomic.h>
> > > > > > > +#include <linux/panic.h>
> > > > > > > +#include <linux/bug.h>
> > > > > > > +#include <asm-generic/rwonce.h>
> > > > > > > +#include <linux/cmpxchg-emu.h>
> > > > > > > +
> > > > > > > +union u8_32 {
> > > > > > > +	u8 b[4];
> > > > > > > +	u32 w;
> > > > > > > +};
> > > > > > > +
> > > > > > > +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > > > > > > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > > > > > > +{
> > > > > > > +	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > > > > > > +	int i = ((uintptr_t)p) & 0x3;
> > > > > > > +	union u8_32 old32;
> > > > > > > +	union u8_32 new32;
> > > > > > > +	u32 ret;
> > > > > > > +
> > > > > > > +	ret = READ_ONCE(*p32);
> > > > > > > +	do {
> > > > > > > +		old32.w = ret;
> > > > > > > +		if (old32.b[i] != old)
> > > > > > > +			return old32.b[i];
> > > > > > > +		new32.w = old32.w;
> > > > > > > +		new32.b[i] = new;
> > > > > > > +		instrument_atomic_read_write(p, 1);
> > > > > > > +		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
> > > > > > 
> > > > > > Just out of curiosity, why is this `data_race` needed? cmpxchg is atomic
> > > > > > so there should be no chance for a data race?
> > > > > 
> > > > > That is what I thought, too.  ;-)
> > > > > 
> > > > > The problem is that the cmpxchg() covers 32 bits, and so without that
> > > > > data_race(), KCSAN would complain about data races with perfectly
> > > > > legitimate concurrent accesses to the other three bytes.
> > > > > 
> > > > > The instrument_atomic_read_write(p, 1) beforehand tells KCSAN to complain
> > > > > about concurrent accesses, but only to that one byte.
> > > > > 
> > > > 
> > > > Oh, I see. For that purpose, maybe we can just use raw_cmpxchg() here,
> > > > i.e. a cmpxchg() without any instrument in it. Cc Mark in case I'm
> > > > missing something.
> > > > 
> > > 
> > > I just realized that the KCSAN instrumentation is already done in
> > > cmpxchg() layer:
> > > 
> > > 	#define cmpxchg(ptr, ...) \
> > > 	({ \
> > > 		typeof(ptr) __ai_ptr = (ptr); \
> > > 		kcsan_mb(); \
> > > 		instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> > > 		raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
> > > 	})
> > > 
> > > and, this function is lower in the layer, so it shouldn't have the
> > > instrumentation itself. How about the following (based on today's RCU
> > > dev branch)?
> > 
> > The raw_cmpxchg() looks nicer than the added data_race()!
> > 
> > One question below, though.
> > 
> > 							Thanx, Paul
> > 
> > > Regards,
> > > Boqun
> > > 
> > > -------------------------------------------->8
> > > Subject: [PATCH] lib: cmpxchg-emu: Make cmpxchg_emu_u8() noinstr
> > > 
> > > Currently, cmpxchg_emu_u8() is called via cmpxchg() or raw_cmpxchg()
> > > which already makes the instrumentation decision:
> > > 
> > > * cmpxchg() case:
> > > 
> > > 	cmpxchg():
> > > 	  kcsan_mb();
> > > 	  instrument_atomic_read_write(...);
> > > 	  raw_cmpxchg():
> > > 	    arch_cmpxchg():
> > > 	      cmpxchg_emu_u8();
> > > 
> > > ... should have KCSAN instrumentation.
> > > 
> > > * raw_cmpxchg() case:
> > > 
> > > 	raw_cmpxchg():
> > > 	  arch_cmpxchg():
> > > 	    cmpxchg_emu_u8();
> > > 
> > > ... shouldn't have KCSAN instrumentation.
> > > 
> > > Therefore it's redundant to put KCSAN instrumentation in
> > > cmpxchg_emu_u8() (along with the data_race() to get away the
> > > instrumentation).
> > > 
> > > So make cmpxchg_emu_u8() a noinstr function, and remove the KCSAN
> > > instrumentation inside it.
> > > 
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  include/linux/cmpxchg-emu.h |  4 +++-
> > >  lib/cmpxchg-emu.c           | 14 ++++++++++----
> > >  2 files changed, 13 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> > > index 998deec67740..c4c85f41d9f4 100644
> > > --- a/include/linux/cmpxchg-emu.h
> > > +++ b/include/linux/cmpxchg-emu.h
> > > @@ -10,6 +10,8 @@
> > >  #ifndef __LINUX_CMPXCHG_EMU_H
> > >  #define __LINUX_CMPXCHG_EMU_H
> > >  
> > > -uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> > > +#include <linux/compiler.h>
> > > +
> > > +noinstr uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> > >  
> > >  #endif /* __LINUX_CMPXCHG_EMU_H */
> > > diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> > > index 27f6f97cb60d..788c22cd4462 100644
> > > --- a/lib/cmpxchg-emu.c
> > > +++ b/lib/cmpxchg-emu.c
> > > @@ -21,8 +21,13 @@ union u8_32 {
> > >  	u32 w;
> > >  };
> > >  
> > > -/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > > -uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > > +/*
> > > + * Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg.
> > > + *
> > > + * This function is marked as 'noinstr' as the instrumentation should be done at
> > > + * outer layer.
> > > + */
> > > +noinstr uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > >  {
> > >  	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > >  	int i = ((uintptr_t)p) & 0x3;
> > > @@ -37,8 +42,9 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > >  			return old32.b[i];
> > >  		new32.w = old32.w;
> > >  		new32.b[i] = new;
> > > -		instrument_atomic_read_write(p, 1);
> > 
> > Don't we need to keep that instrument_atomic_read_write() in order
> > to allow KCSAN to detect data races with plain C-language reads?
> > Or is that being handled some other way?
> > 
> 
> I think that's already covered by the current code, cmpxchg_emu_u8() is
> called from cmpxchg() macro, which has a:
> 
> 	instrument_atomic_read_write(p, sizeof(*p));
> 
> in it, and in the cmpxchg((u8*), ..) case, 'sizeof(*p)' is obviously 1
> ;-)

I believe you, but could you nevertheless please test it?  ;-)

							Thanx, Paul

> Regards,
> Boqun
> 
> > > -		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
> > > +
> > > +		// raw_cmpxchg() is used here to avoid instrumentation.
> > > +		ret = raw_cmpxchg(p32, old32.w, new32.w); // Overridden above.
> > >  	} while (ret != old32.w);
> > >  	return old;
> > >  }
> > > -- 
> > > 2.44.0
> > > 

