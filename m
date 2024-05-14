Return-Path: <linux-arch+bounces-4397-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2D8C584D
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C6C284604
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D817BB1C;
	Tue, 14 May 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBri0pjY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC711E487;
	Tue, 14 May 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698416; cv=none; b=UbV5LgoDUq5NQVRczdhnc4GUUuim6rMnnD/vvxyWjWOsFZYL6gnM92g0FQGvj3/EHffUDCOrZxvq400iet4jnT+wBG/7ajyfdkvDh6IQHbs5WERytSDiVz1K31htvq76rPPGC+mZSl7JkQ5xM+xzFe40ep6oYUsTu5WGUoj/g/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698416; c=relaxed/simple;
	bh=OZGLkT0oDKEotX35CeqO+sNDpE6JrfeT19NwbZb8gK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om6kIdDgIdqmJw38jqN6vGDIs3uUyqqJ77GjyxgdksYJPLzwgeRLE0MSyzLEbVnIMrKWHOWcOkX10EkR3ZpOEQVTL/DjAwgW/pqM16aFCU6cyfWibsktdnPE5GNIszRaVtLwgDsJh9hRHLHQtFiI68rIRvvf5+KIQkqxInJeJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBri0pjY; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ed3587b93bso3160942a34.1;
        Tue, 14 May 2024 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715698414; x=1716303214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXisbGudY3dtAzfjTejwyHwzxNqxmrPI7H48Yup1GB0=;
        b=mBri0pjYo7q+T0V1N9J0s3g6M8qYHi95GtTYokR0/ucAfWbihx6iT8+NgWtF+oMDKv
         Am+W3b6jYOUgcyvgB/23++CYxXtDwJkMhUM37O3VdD6y9kYefdQ/s3S47eg0OGkJO5p0
         QVq5AdIov8rjBE+3qXqOwLsOPLvSnj02QHDb6PgbyzPO6GbNeK9lPXEEr/RoxcRUAT96
         TiDfFI5shTogEu9CLVLV6Z56aPnska1pVQR+q87/0NmBsn5i4TpQCnS1D5yHuF0/n4nw
         ngO+RuSOvajWp5zu4dORTt14NSJmjRdg2kYkeDXjX6YctSufBRjDm9hPYDeWKNSkKPXg
         QqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715698414; x=1716303214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXisbGudY3dtAzfjTejwyHwzxNqxmrPI7H48Yup1GB0=;
        b=vNDGTjIJL+twqCQAaOJCi3I8fEf5fQd0J9QHWT+/mmzHsc2Em7lpde4f6PQ/j6sTCI
         /PTJKddgU034l9ZI5cmkUsWEAVrdLWpfbMi72xKcPNIr9kmANcABRL9cb1Ud+UUrK85o
         UaHq+T5ip/GPM+8TK5BlVs3qKbd/je7z8fY+RXL96dX2NpWw6dHFy/iIIMr5Do8IrK6d
         oy4qh3CBPQd+AwRwPbcL9585GXN6xK8LQz6zfv2Wd1gbqja3EP3xNCiirI2fmihdO/BA
         m0wZomXnNUWYDHs3UAtP3li9TARoqwJQpu6Dc5f5mrIp7UC0T16huUNvT6VKS9vtCn3+
         EvQw==
X-Forwarded-Encrypted: i=1; AJvYcCWvpppGwyOrSysO+yZEij3/lChOx0++ZUsG/4cjABZliQU7eo8hvOuVA6x8tvPKRJGy0o4gxRTfRyBvhc3J/gYxNlvahjWA/s6FRThT
X-Gm-Message-State: AOJu0YzPrVW2GeiQT6k9v3ks9gSwsP2YmPAOL13XIwNgiXyxWJFvb5YO
	O6a78taFqjR7LjMSWCaArhktb/M4mK4In72C1kvh/qJo6BMCrCdN
X-Google-Smtp-Source: AGHT+IEAzv28vr3QpIJhr8CE5FZuNRCyskVfNxOa/BQlDd4Mcc3IJah3rBONoPpvEt1e2OsSANirIA==
X-Received: by 2002:a05:6871:1c3:b0:22e:d324:b888 with SMTP id 586e51a60fabf-24172f6b584mr13773119fac.56.1715698414222;
        Tue, 14 May 2024 07:53:34 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e046467a4sm53067841cf.83.2024.05.14.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:53:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0122D1200069;
	Tue, 14 May 2024 10:53:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 14 May 2024 10:53:33 -0400
X-ME-Sender: <xms:7HpDZvNCTL3FROdqKKeLuEmgM2oTz9TdexX8jhQkgUmvarTRjv8rHw>
    <xme:7HpDZp_vmNex3p1L34dA4kSbnqgjqAGYPn_XLUtxMriZ7J7x0Rj2-qpWpuuwoOV9g
    1f9QqGus0nxnJWsBQ>
X-ME-Received: <xmr:7HpDZuQ4W_M66MfbxJ9ZeBT0v5uqZTk__f5Ne1LSiNEoOF2e8dkR5LHSsFQsQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:7HpDZjt9BwLVg56D1emvrs-lQLI-b6KMVQVjjCA-9JT3g3JrIfLgYw>
    <xmx:7HpDZncYW3Cq0hLnjVVVHXQJChAqRqvLxrnOCDdfsVEwFPV6S-WvMg>
    <xmx:7HpDZv3wXu96_bJAZ4Cv7bG9UluNTMr0L0qxaJcmDd4RWee58_mg9w>
    <xmx:7HpDZj97yTm38BlGU6MAIeVyG9YkiWJmU_w6f0kXd6CKtFNb0AX0ZA>
    <xmx:7HpDZq_gSOhNuo9-15LZGMlAABXW58_LaoU6DSSLmdtnwIWdyYYw18ST>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 10:53:32 -0400 (EDT)
Date: Tue, 14 May 2024 07:53:20 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 cmpxchg 09/13] lib: Add one-byte emulation function
Message-ID: <ZkN64LAeOfHAXyUM@boqun-archlinux>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-9-paulmck@kernel.org>
 <ZkInMNOsLO5XbDj5@boqun-archlinux>
 <9f0ff126-2806-488e-97cc-7258eff0c574@paulmck-laptop>
 <ZkI4XPJLeCtabfGh@boqun-archlinux>
 <ZkKD6UqXZozp1p-W@boqun-archlinux>
 <29f1d801-9fb4-4ecb-8d5e-cecb7d7a76e1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f1d801-9fb4-4ecb-8d5e-cecb7d7a76e1@paulmck-laptop>

On Tue, May 14, 2024 at 07:22:47AM -0700, Paul E. McKenney wrote:
> On Mon, May 13, 2024 at 02:19:37PM -0700, Boqun Feng wrote:
> > On Mon, May 13, 2024 at 08:57:16AM -0700, Boqun Feng wrote:
> > > On Mon, May 13, 2024 at 08:41:27AM -0700, Paul E. McKenney wrote:
> > > [...]
> > > > > > +#include <linux/types.h>
> > > > > > +#include <linux/export.h>
> > > > > > +#include <linux/instrumented.h>
> > > > > > +#include <linux/atomic.h>
> > > > > > +#include <linux/panic.h>
> > > > > > +#include <linux/bug.h>
> > > > > > +#include <asm-generic/rwonce.h>
> > > > > > +#include <linux/cmpxchg-emu.h>
> > > > > > +
> > > > > > +union u8_32 {
> > > > > > +	u8 b[4];
> > > > > > +	u32 w;
> > > > > > +};
> > > > > > +
> > > > > > +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > > > > > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > > > > > +{
> > > > > > +	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > > > > > +	int i = ((uintptr_t)p) & 0x3;
> > > > > > +	union u8_32 old32;
> > > > > > +	union u8_32 new32;
> > > > > > +	u32 ret;
> > > > > > +
> > > > > > +	ret = READ_ONCE(*p32);
> > > > > > +	do {
> > > > > > +		old32.w = ret;
> > > > > > +		if (old32.b[i] != old)
> > > > > > +			return old32.b[i];
> > > > > > +		new32.w = old32.w;
> > > > > > +		new32.b[i] = new;
> > > > > > +		instrument_atomic_read_write(p, 1);
> > > > > > +		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
> > > > > 
> > > > > Just out of curiosity, why is this `data_race` needed? cmpxchg is atomic
> > > > > so there should be no chance for a data race?
> > > > 
> > > > That is what I thought, too.  ;-)
> > > > 
> > > > The problem is that the cmpxchg() covers 32 bits, and so without that
> > > > data_race(), KCSAN would complain about data races with perfectly
> > > > legitimate concurrent accesses to the other three bytes.
> > > > 
> > > > The instrument_atomic_read_write(p, 1) beforehand tells KCSAN to complain
> > > > about concurrent accesses, but only to that one byte.
> > > > 
> > > 
> > > Oh, I see. For that purpose, maybe we can just use raw_cmpxchg() here,
> > > i.e. a cmpxchg() without any instrument in it. Cc Mark in case I'm
> > > missing something.
> > > 
> > 
> > I just realized that the KCSAN instrumentation is already done in
> > cmpxchg() layer:
> > 
> > 	#define cmpxchg(ptr, ...) \
> > 	({ \
> > 		typeof(ptr) __ai_ptr = (ptr); \
> > 		kcsan_mb(); \
> > 		instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> > 		raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
> > 	})
> > 
> > and, this function is lower in the layer, so it shouldn't have the
> > instrumentation itself. How about the following (based on today's RCU
> > dev branch)?
> 
> The raw_cmpxchg() looks nicer than the added data_race()!
> 
> One question below, though.
> 
> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > -------------------------------------------->8
> > Subject: [PATCH] lib: cmpxchg-emu: Make cmpxchg_emu_u8() noinstr
> > 
> > Currently, cmpxchg_emu_u8() is called via cmpxchg() or raw_cmpxchg()
> > which already makes the instrumentation decision:
> > 
> > * cmpxchg() case:
> > 
> > 	cmpxchg():
> > 	  kcsan_mb();
> > 	  instrument_atomic_read_write(...);
> > 	  raw_cmpxchg():
> > 	    arch_cmpxchg():
> > 	      cmpxchg_emu_u8();
> > 
> > ... should have KCSAN instrumentation.
> > 
> > * raw_cmpxchg() case:
> > 
> > 	raw_cmpxchg():
> > 	  arch_cmpxchg():
> > 	    cmpxchg_emu_u8();
> > 
> > ... shouldn't have KCSAN instrumentation.
> > 
> > Therefore it's redundant to put KCSAN instrumentation in
> > cmpxchg_emu_u8() (along with the data_race() to get away the
> > instrumentation).
> > 
> > So make cmpxchg_emu_u8() a noinstr function, and remove the KCSAN
> > instrumentation inside it.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  include/linux/cmpxchg-emu.h |  4 +++-
> >  lib/cmpxchg-emu.c           | 14 ++++++++++----
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> > index 998deec67740..c4c85f41d9f4 100644
> > --- a/include/linux/cmpxchg-emu.h
> > +++ b/include/linux/cmpxchg-emu.h
> > @@ -10,6 +10,8 @@
> >  #ifndef __LINUX_CMPXCHG_EMU_H
> >  #define __LINUX_CMPXCHG_EMU_H
> >  
> > -uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> > +#include <linux/compiler.h>
> > +
> > +noinstr uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> >  
> >  #endif /* __LINUX_CMPXCHG_EMU_H */
> > diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> > index 27f6f97cb60d..788c22cd4462 100644
> > --- a/lib/cmpxchg-emu.c
> > +++ b/lib/cmpxchg-emu.c
> > @@ -21,8 +21,13 @@ union u8_32 {
> >  	u32 w;
> >  };
> >  
> > -/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > -uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > +/*
> > + * Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg.
> > + *
> > + * This function is marked as 'noinstr' as the instrumentation should be done at
> > + * outer layer.
> > + */
> > +noinstr uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> >  {
> >  	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> >  	int i = ((uintptr_t)p) & 0x3;
> > @@ -37,8 +42,9 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> >  			return old32.b[i];
> >  		new32.w = old32.w;
> >  		new32.b[i] = new;
> > -		instrument_atomic_read_write(p, 1);
> 
> Don't we need to keep that instrument_atomic_read_write() in order
> to allow KCSAN to detect data races with plain C-language reads?
> Or is that being handled some other way?
> 

I think that's already covered by the current code, cmpxchg_emu_u8() is
called from cmpxchg() macro, which has a:

	instrument_atomic_read_write(p, sizeof(*p));

in it, and in the cmpxchg((u8*), ..) case, 'sizeof(*p)' is obviously 1
;-)

Regards,
Boqun

> > -		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
> > +
> > +		// raw_cmpxchg() is used here to avoid instrumentation.
> > +		ret = raw_cmpxchg(p32, old32.w, new32.w); // Overridden above.
> >  	} while (ret != old32.w);
> >  	return old;
> >  }
> > -- 
> > 2.44.0
> > 

