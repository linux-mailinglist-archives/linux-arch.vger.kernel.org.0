Return-Path: <linux-arch+bounces-13921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D97BBD6FD
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D81893F5F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF4266EE7;
	Mon,  6 Oct 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FJL1k0kr"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C112690D5;
	Mon,  6 Oct 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742733; cv=none; b=RIHkymBOOOkXKwyXThDWn5wEUSnJ9F7XuSna7RR2noGQSMFQhE53jnuAF3ROkT/9UxDCD+l5Z7j4O3MvnIgHMRvpBwm8yA3Vs6Xnn9XgWXXmMurdMhNj7KC/jsPwJW8PsLTWgr2d1FBtR3KNeHZneZnC8nDzEvZ+eNBa5G7ZWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742733; c=relaxed/simple;
	bh=R6wq/0ECdxmdAS9ozwPMla9UBXyiejwLuVyM57M7x+8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TCw1CXdKYc0DDpmqXTIDp+AJQ9nxyFO1UK/dMsGFV5O5U1KK7wR+Cp/YRPL5apfiJcby8tVZSxM+La4wGRNtSiYBd5JT5XAazA9cmpEObrqL3CP00loLy0Sfdd5JXp2kIawRlOVwqyZ9wrEdQlgZplqUDw+8U0fgVYdJNu7vnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FJL1k0kr; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69D447A001D;
	Mon,  6 Oct 2025 05:25:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Oct 2025 05:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759742729; x=1759829129; bh=0MH0LJMlOe1MZQnPNMpJz9niI+z5sxtWGJK
	DRhPfrtg=; b=FJL1k0kr0VWwZJHEW5DVIjWuf6O9uTuFhn6LGhysbx5Hyjn7yB0
	CUwuy0GYGWoYlYx/nj+zKKn41dz08ToYu/ZSwPGUrO+A0Oqt0hR+iCs2X/mdceYI
	gaQW/of/xXtz8l2KW/QgdeuktoDxGSBbVM0SA2vedd0nai9TSbnQq4JyThjuYDEv
	s47Fd7SRsejkGp8LZCWDt+PW65GhM8c05kNCv7xXbwKzl84Z3QtJ1wcIMx4r0XFQ
	FuS2YzdU2XdJLa1krvDis84k7lys+Bz+y40shd91+UIXaAz/Q/a+FVtu0JZwxKOq
	XAVE5iqxmNn4fZJvrdTRTo8XK7qhGBH1hgQ==
X-ME-Sender: <xms:CIvjaBu5nn3VATrxoW6ZrWN8Y8g8_XViQxxn9MPaJUd8VQxeWKwSZw>
    <xme:CIvjaCnkxVD1Hv75CZbf3Lamz1kwQXcCf3YIZO_9026MyNsq9u25yrgHO0u5P86S6
    0JTIkRruFcbClyFU6FBSiYyC_Y1MFvOVFh4euL-R8DAHgoF7unsArzc>
X-ME-Received: <xmr:CIvjaEQJpNxo50QZxaIlUEYSDEhiKQoZLWT4DHsiOCuQTloDMc59_P2Ug8JABfm7J5Da34K3H0Kr8dE_kFWmV7kiiD9wJUAnuOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpth
    htohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepphgvthgv
    rhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgr
    nhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CIvjaIKIRScJpK4179O840zX3E7CIXKHDqpHMWH7Ph4ZUuy_aXAF7A>
    <xmx:CIvjaOEMCEKQR3AqvpdsaJgMDVpmc7DLhilFACtCBML23Oxs3PbhnQ>
    <xmx:CIvjaF1B2btK8R66galIPGhO79n86dESgNfdZMq85VumPWYEmqbZbA>
    <xmx:CIvjaGJt4Kx3orESA3P97UShI7sUejpB9ZHm365bNYJKR-gH2Og7sQ>
    <xmx:CYvjaHDkAH8ddbVJsMxuy-bAfLZUJxjdM6wFdFMnxPO-2z0IzZvdimDt>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 05:25:26 -0400 (EDT)
Date: Mon, 6 Oct 2025 20:25:33 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
    Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
    Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
In-Reply-To: <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
Message-ID: <257a045a-f39d-8565-608f-f01f7914be21@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org> <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com> <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org> <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 30 Sep 2025, Arnd Bergmann wrote:

> On Tue, Sep 30, 2025, at 04:18, Finn Thain wrote:
> 
> > It turned out that the problem wasn't dynamic allocations, it was a 
> > local variable in the core locking code (kernel/locking/rwsem.c): a 
> > misaligned long used with an atomic operation (cmpxchg). To get 
> > natural alignment for 64-bit quantities, I had to align other local 
> > variables as well, such as the one in ktime_get_real_ts64_mg() that's 
> > used with atomic64_try_cmpxchg(). The atomic_t branch in my github 
> > repo has the patches I wrote for that.
> 
> It looks like the variable you get the warning for is not even the 
> atomic64_t but the 'old' argument to atomic64_try_cmpxchg(), at least in 
> some of the cases you found if not all of them.
> 
> I don't see where why there is a requirement to have that aligned at 
> all, even if we do require the atomic64_t to be naturally aligned, and I 
> would expect the same warning to hit on x86-32 and the other 
> architectures with 4-byte alignment of u64 variable on stack and .data.
> 
> ...
> 
> Since there is nothing telling the compiler that the 'old' argument to 
> atomic*_try_cmpcxchg() needs to be naturally aligned, maybe that check 
> should be changed to only test for the ABI-guaranteed alignment? I think 
> that would still be needed on x86-32.
>  
>       Arnd
> 
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index 9409a6ddf3e0..e57763a889bd 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1276,7 +1276,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
>  {
>  	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
> -	instrument_atomic_read_write(old, sizeof(*old));
> +	instrument_atomic_read_write(old, alignof(*old));
>  	return raw_atomic_try_cmpxchg(v, old, new);
>  }
>  

In the same file, we have:

#define try_cmpxchg(ptr, oldp, ...) \
({ \
        typeof(ptr) __ai_ptr = (ptr); \
        typeof(oldp) __ai_oldp = (oldp); \
        kcsan_mb(); \
        instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
        instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
        raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
})

In try_cmpxchg(), unlike atomic_try_cmpxchg(), the 'old' parameter is 
checked by instrument_read_write() instead of 
instrument_atomic_read_write(), which suggests a different patch. This 
header is generated by a script so the change below would be more 
complicated in practice.

diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 9409a6ddf3e0..ce3890bcd903 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1276,7 +1276,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg(v, old, new);
 }
 
@@ -1298,7 +1298,7 @@ static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -1321,7 +1321,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_release(v, old, new);
 }
 
@@ -1343,7 +1343,7 @@ static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -2854,7 +2854,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg(v, old, new);
 }
 
@@ -2876,7 +2876,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -2899,7 +2899,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_release(v, old, new);
 }
 
@@ -2921,7 +2921,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -4432,7 +4432,7 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg(v, old, new);
 }
 
@@ -4454,7 +4454,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -4477,7 +4477,7 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_release(v, old, new);
 }
 
@@ -4499,7 +4499,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_relaxed(v, old, new);
 }
 

