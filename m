Return-Path: <linux-arch+bounces-4381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEC8C48BD
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 23:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7391C21668
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82607824AA;
	Mon, 13 May 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+EA9s+8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5F824AB;
	Mon, 13 May 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635191; cv=none; b=ORHXL6ilw9bdP/y7n4ln7NvMFqy4OY3hctJILUxEzW8rzipEiXrbIpZaDwu5d6zD63waCdY21mq2I9g68Kk6Qpl6NezXViY9nITGe/L21u2FiNzNvXkUp0174jxwFP4kOyOQjUlaNXsU7P2IoatcyyXMTLmrhn4Wu+zOns+K3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635191; c=relaxed/simple;
	bh=tVByUd58fPx6uO1hxNe/cW2dS8fCULR6krJb8DT00W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe8OrJlv3vkqxc5mytocOhe+HBXVAF+hWfNgSrJ05kCBU8Ib8VtEUJQ2lHOjqb11ZjYOsZ49100UdwmXEFdeWDeoOcFBIpvEhztDtp2l3uBaHs26WY+epVMNDyd3a1BL2frbP68GyiRNtYSTidwV7vEpNun8zJXf10zOJ6dmSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+EA9s+8; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c99e6b8b1fso1529044b6e.1;
        Mon, 13 May 2024 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715635189; x=1716239989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QCxU+ICp2lsNCg+/s+slhR/vQQiDwQB/Vsc8SKbykM=;
        b=M+EA9s+8pf8my7Md1baiG9uzH8buPyCLgFQJD/VtfTb06ri8w12jzBrE4nRAmT+Y9W
         pOvtjnSi3OZfOuUomqCiG68uZact1YMETkpTuUF7gCecvvOrI4m3fPDEXA/wnfnuad3X
         ELc4R1R8Uafu4wla9SHCFsk4PsT4OQnzVZPjQ1M+pSGPPP4O05ZHBn6Aoc/ZoXfZjmkv
         KFZTTagRdBrBd0gBeVFZMjGUKFqw7ixagnfhdOW6Ho0m/A1hu0u10x1g67teY3aNzSON
         021Q1+G+yIf92eLmtdaw2zwrjHiSNB43NsOrUjAoPd3M2L6LbDk+V6Rjz+/LvtnXEzB+
         /SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635189; x=1716239989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QCxU+ICp2lsNCg+/s+slhR/vQQiDwQB/Vsc8SKbykM=;
        b=JBjdg8YPq/lX1dpga3o+kOoF/o4l26ec0dkmL/YIcJh+BNgAqS6U0fiyFVT4PR+56V
         mkxmfsXlUhGEczhnY+InlLSZpazkbBLt4+fg7IyKFvM8DYwXpd+6s7NV/fdeHwDarBd9
         WZ2IEkJGmjOvlm9ii1ohdReXURxve8qoow+THXnJDoB4tF4AhZjc4gsd3flx3Og5v5XN
         NY2cSTrPEA5dcvHiMBHjm+IAa7JJkz8m0Ttc4G7v7PyzhCTuW/x8yVp70zEOINjkNoPV
         jZSabq38BhsVoNi8xhbj3s7j9imjti2J+M7yKSWzy+t9EXgtIScHaLQvPdq7WbFqHOPH
         VfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdBn2RW6IuN2TfJH6aPMgII7eWyi88G/MRpXd+IIh6NqkU7LIZSFpbwqkAK9LQeUm1DFDvxjZ3g0g4bHEpoKnymy0PrE+P48V2Bv2H
X-Gm-Message-State: AOJu0Yw3XzaQX+ohAqYwsEHz1RL9JFG4oEmmM6I6FcXJAvmBkjXvPtUn
	T8YDgIvY1/rDCDZT4kX1QDcNyjtkq+8TlBXh/W8Lrf7Q/h3CEZEv
X-Google-Smtp-Source: AGHT+IH5/WVIyFCC3ZgTdeYH4qdayzBiFOKkZiwU8t2ZdQFwxw5g1+On2oSBxxkdvO17sMTQU049jg==
X-Received: by 2002:a05:6870:46a1:b0:221:8b50:f1a0 with SMTP id 586e51a60fabf-24172a9d460mr16745517fac.19.1715635188934;
        Mon, 13 May 2024 14:19:48 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc609sm493889285a.94.2024.05.13.14.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:19:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id EE90B1200077;
	Mon, 13 May 2024 17:19:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 May 2024 17:19:47 -0400
X-ME-Sender: <xms:84NCZqqtq0cVMPsdrHocNJENnQV1zbXkDIKaZRAEo-R3TGgdoUQ2KQ>
    <xme:84NCZorJzY4vumMQ1o7mypbf4ZE3u5BawZvVn53Lr_n6HNd5I_nhHCIE0Yvr7KxCl
    y6u5TUEiJiZs4igVg>
X-ME-Received: <xmr:84NCZvMjSR8ebCux6obqFnxCLtfGwb8fb1UnArEcbL-2o377jOrIgWw7fupgyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:84NCZp4MWCsXuPPc50OIAw7wzhzl3zNryuXuQ9Jt-5SzX7QFZmldDA>
    <xmx:84NCZp4Xv3HLmj_qVzxvtXfyRATTqVl7X8syYDo0LbNbi0ZlQ4TtDg>
    <xmx:84NCZpieI2jv-kXywBj1nDu8H1P5YY0WPqObE9VSyXaDhX9Fmn90NA>
    <xmx:84NCZj6oZM7rliPEYgee078QKmZFZmjROg-vd3nSxEtzpNOMK4Mc4w>
    <xmx:84NCZkIj3DUbYjxnNhi9DJVbnWeBbGycf2MN9p9UD1usUFd6a_J4Nikc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 17:19:47 -0400 (EDT)
Date: Mon, 13 May 2024 14:19:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 cmpxchg 09/13] lib: Add one-byte emulation function
Message-ID: <ZkKD6UqXZozp1p-W@boqun-archlinux>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-9-paulmck@kernel.org>
 <ZkInMNOsLO5XbDj5@boqun-archlinux>
 <9f0ff126-2806-488e-97cc-7258eff0c574@paulmck-laptop>
 <ZkI4XPJLeCtabfGh@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkI4XPJLeCtabfGh@boqun-archlinux>

On Mon, May 13, 2024 at 08:57:16AM -0700, Boqun Feng wrote:
> On Mon, May 13, 2024 at 08:41:27AM -0700, Paul E. McKenney wrote:
> [...]
> > > > +#include <linux/types.h>
> > > > +#include <linux/export.h>
> > > > +#include <linux/instrumented.h>
> > > > +#include <linux/atomic.h>
> > > > +#include <linux/panic.h>
> > > > +#include <linux/bug.h>
> > > > +#include <asm-generic/rwonce.h>
> > > > +#include <linux/cmpxchg-emu.h>
> > > > +
> > > > +union u8_32 {
> > > > +	u8 b[4];
> > > > +	u32 w;
> > > > +};
> > > > +
> > > > +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > > > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > > > +{
> > > > +	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > > > +	int i = ((uintptr_t)p) & 0x3;
> > > > +	union u8_32 old32;
> > > > +	union u8_32 new32;
> > > > +	u32 ret;
> > > > +
> > > > +	ret = READ_ONCE(*p32);
> > > > +	do {
> > > > +		old32.w = ret;
> > > > +		if (old32.b[i] != old)
> > > > +			return old32.b[i];
> > > > +		new32.w = old32.w;
> > > > +		new32.b[i] = new;
> > > > +		instrument_atomic_read_write(p, 1);
> > > > +		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
> > > 
> > > Just out of curiosity, why is this `data_race` needed? cmpxchg is atomic
> > > so there should be no chance for a data race?
> > 
> > That is what I thought, too.  ;-)
> > 
> > The problem is that the cmpxchg() covers 32 bits, and so without that
> > data_race(), KCSAN would complain about data races with perfectly
> > legitimate concurrent accesses to the other three bytes.
> > 
> > The instrument_atomic_read_write(p, 1) beforehand tells KCSAN to complain
> > about concurrent accesses, but only to that one byte.
> > 
> 
> Oh, I see. For that purpose, maybe we can just use raw_cmpxchg() here,
> i.e. a cmpxchg() without any instrument in it. Cc Mark in case I'm
> missing something.
> 

I just realized that the KCSAN instrumentation is already done in
cmpxchg() layer:

	#define cmpxchg(ptr, ...) \
	({ \
		typeof(ptr) __ai_ptr = (ptr); \
		kcsan_mb(); \
		instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
		raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
	})

and, this function is lower in the layer, so it shouldn't have the
instrumentation itself. How about the following (based on today's RCU
dev branch)?

Regards,
Boqun

-------------------------------------------->8
Subject: [PATCH] lib: cmpxchg-emu: Make cmpxchg_emu_u8() noinstr

Currently, cmpxchg_emu_u8() is called via cmpxchg() or raw_cmpxchg()
which already makes the instrumentation decision:

* cmpxchg() case:

	cmpxchg():
	  kcsan_mb();
	  instrument_atomic_read_write(...);
	  raw_cmpxchg():
	    arch_cmpxchg():
	      cmpxchg_emu_u8();

... should have KCSAN instrumentation.

* raw_cmpxchg() case:

	raw_cmpxchg():
	  arch_cmpxchg():
	    cmpxchg_emu_u8();

... shouldn't have KCSAN instrumentation.

Therefore it's redundant to put KCSAN instrumentation in
cmpxchg_emu_u8() (along with the data_race() to get away the
instrumentation).

So make cmpxchg_emu_u8() a noinstr function, and remove the KCSAN
instrumentation inside it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/cmpxchg-emu.h |  4 +++-
 lib/cmpxchg-emu.c           | 14 ++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
index 998deec67740..c4c85f41d9f4 100644
--- a/include/linux/cmpxchg-emu.h
+++ b/include/linux/cmpxchg-emu.h
@@ -10,6 +10,8 @@
 #ifndef __LINUX_CMPXCHG_EMU_H
 #define __LINUX_CMPXCHG_EMU_H
 
-uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
+#include <linux/compiler.h>
+
+noinstr uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
 
 #endif /* __LINUX_CMPXCHG_EMU_H */
diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
index 27f6f97cb60d..788c22cd4462 100644
--- a/lib/cmpxchg-emu.c
+++ b/lib/cmpxchg-emu.c
@@ -21,8 +21,13 @@ union u8_32 {
 	u32 w;
 };
 
-/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
-uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
+/*
+ * Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg.
+ *
+ * This function is marked as 'noinstr' as the instrumentation should be done at
+ * outer layer.
+ */
+noinstr uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
 {
 	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
 	int i = ((uintptr_t)p) & 0x3;
@@ -37,8 +42,9 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
 			return old32.b[i];
 		new32.w = old32.w;
 		new32.b[i] = new;
-		instrument_atomic_read_write(p, 1);
-		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
+
+		// raw_cmpxchg() is used here to avoid instrumentation.
+		ret = raw_cmpxchg(p32, old32.w, new32.w); // Overridden above.
 	} while (ret != old32.w);
 	return old;
 }
-- 
2.44.0


