Return-Path: <linux-arch+bounces-13804-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84053BABABB
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 08:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AB47A5366
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D266296BDC;
	Tue, 30 Sep 2025 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QiXX5ucK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEk9Ij26"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29E3A8F7;
	Tue, 30 Sep 2025 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214180; cv=none; b=GeV7xvAYoIs2HZX7Ypq7Cwa5aqp7p7+ThebAcnOglTrUH8mXiGhpVwvg2synGTecR36LnmqPkCtEtD5It8PdJueNSgsWKv0SKsIdRR8dYVMMY+gWhk4kiND/+2hR22J/cD+s6BoFREf9MlBxxusmHxlJ3sa2KCnBW5AHxuet8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214180; c=relaxed/simple;
	bh=escCiC2Y+Qmi4NIJqd5Q2Nyq3gDImlglEHJRkSusNf0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PQ1dgxpMtcKIudmgAJ6Tvni0VPW3iJ2fsq+kB+hWPjIHMh36BdSx1ZlY6UxwaWjUOosiEMUPKeQkWpGQi6Eb+ekWhOJup2DjCPFqABp53F3YWHzHt3ZVIWIMRsi606Pu5tKjoSue9srwZ7SQ6OS3tOR2EtC7WmHj7UhKm+bmj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QiXX5ucK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEk9Ij26; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35A761400153;
	Tue, 30 Sep 2025 02:36:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 30 Sep 2025 02:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759214177;
	 x=1759300577; bh=qlwPCct/R/LhaOvINFfIvCIH1zji2SOzEGosNeDTPVc=; b=
	QiXX5ucKCfrvt8rR2NchXeXc8cJ8lbU+r06ac68x8RuIoeDejjaDPVFCiEO6X9R0
	uBdcWH6dJiAQoGoUlFCbarVrXYl9hFW6ZtopKwYCwaGTEMY1/p/RxCntYWYGViJU
	JuT8TSlWEJYe/s6YgH4HnF3XdvzQD+v5kMbxJ8o3q+Jdhdbip6iQLjCz9a8/YkY7
	R+d2ZZ4qcIyYiTJBy2/x+eHfqo3RfJ+zSwlZK/4PlvBAYxdYBb+Ar3NgYXcqC2uI
	TRrH/UaVCicRW+LWomae3PyKnmWnDfjBdawZ/OFoim7PEJHzzf1ii6y/74A2YeY6
	uZG00M8SsO50v7O/zZLa+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759214177; x=
	1759300577; bh=qlwPCct/R/LhaOvINFfIvCIH1zji2SOzEGosNeDTPVc=; b=E
	Ek9Ij26F3NVs/BXejaq8pzeni9HWCsvi1peCdIzzKkU8hV1xHE1f+FsafXNCQO4R
	9eIe3JYq/YD/AZ2GkqW+XXsb/paMXXOrF+AdwWUqlplOqyJHcPo7imwnr/4Xs1sT
	UnxDKcodN8Tb3ERKcwttSv3rWo6j3yRaAynErbbvNBpX6cP0EcxBiGRrUK/h6rfq
	bsQgtraIpJIveOx9aw8hPrvYO6SY+uILo3afISCqPW3weldvSkSsaAQ5eE+6Wgek
	/pB1NgVu13QOL0EOjA4iIVkTgd1ytF876hfuvTL2t4CzlRn+jQszbw0pClNiUKjv
	n0AG7YXqU+/E6KYxkb0ag==
X-ME-Sender: <xms:YHrbaGWxeBAy_kOMpdtHyRj2tWTh5xgyxZaM23nFbQF-ZNHfkKnaAA>
    <xme:YHrbaNYZb20xpraF_Ti9PWeEMXlgSH12OV2U5lAoVJqjSuscDGK9CwWZLw6NQxWzu
    KdiMO5ypdD7lD1vhu6s46S6WpHcz3x-J6YKLilW4ms9Abo6Wh81vr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlrghntggv
    rdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnh
    gvth
X-ME-Proxy: <xmx:YHrbaORyMVriqtU-Nnv4-Xb4ysZ3Zlh6Ib2nwhZLY7VfHAcs4zkU4w>
    <xmx:YHrbaKJB4ciaHj50Ymt95o7clf09TgnZkABhKmkVtbX1ays5Pj04GQ>
    <xmx:YHrbaIGfKGPa6jX43FkoFWX-QcNl1G20Mi4fnxNN0ZxQLtwS4Re1GA>
    <xmx:YHrbaH1v8wUbwdSuNIf6E_NHZ-GOdw7Es1JrmXRrHnKP9_-GUQ78pA>
    <xmx:YXrbaPsgn386nS8xeHhii7v5CZMeNpVMUYU2cWTm4yl1Is_ifvY3MNQT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 42B54700069; Tue, 30 Sep 2025 02:36:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_uXtpTlO07
Date: Tue, 30 Sep 2025 08:35:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Finn Thain" <fthain@linux-m68k.org>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
 "Lance Yang" <lance.yang@linux.dev>
Message-Id: <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
In-Reply-To: <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
 <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 30, 2025, at 04:18, Finn Thain wrote:
> On Tue, 23 Sep 2025, I wrote:
>> 
>> ... there's still some kmem cache or other allocator somewhere that has 
>> produced some misaligned path and dentry structures. So we get 
>> misaligned atomics somewhere in the VFS and TTY layers. I was unable to 
>> find those allocations.
>> 
>
> It turned out that the problem wasn't dynamic allocations, it was a local 
> variable in the core locking code (kernel/locking/rwsem.c): a misaligned 
> long used with an atomic operation (cmpxchg). To get natural alignment for 
> 64-bit quantities, I had to align other local variables as well, such as 
> the one in ktime_get_real_ts64_mg() that's used with 
> atomic64_try_cmpxchg(). The atomic_t branch in my github repo has the 
> patches I wrote for that.

It looks like the variable you get the warning for is not
even the atomic64_t but the 'old' argument to atomic64_try_cmpxchg(),
at least in some of the cases you found if not all of them.

I don't see where why there is a requirement to have that
aligned at all, even if we do require the atomic64_t to
be naturally aligned, and I would expect the same warning
to hit on x86-32 and the other architectures with 4-byte
alignment of u64 variable on stack and .data.

> To silence the misalignment WARN from CONFIG_DEBUG_ATOMIC, for 64-bit 
> atomic operations, for my small m68k .config, it was also necesary to 
> increase ARCH_SLAB_MINALIGN to 8. However, I'm not advocating a 
> ARCH_SLAB_MINALIGN increase, as that wastes memory.

Have you tried to quantify the memory waste here? I assume
that most slab allocations are already 8-byte aligned, at
least kmalloc() with size>4, while custom caches are usually
done for larger structures where an extra average of 2 bytes
per allocation may not be that bad.

> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 402a999a0d6b..cd569a87c0a8 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -68,7 +68,7 @@ static __always_inline void 
> instrument_atomic_read(const volatile void *v, size_
>  {
>  	kasan_check_read(v, size);
>  	kcsan_check_atomic_read(v, size);
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 
> (size - 1)));
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 
> (size - 1) & 3));
>  }

What is the alignment of stack variables on m68k? E.g. if you
have a function with two local variables, would that still
be able to trigger the check?

int f(atomic64_t *a)
{
     u16 pad;
     u64 old;
     
     g(&pad);
     atomic64_try_cmpxchg(a, &old, 0);
}

Since there is nothing telling the compiler that
the 'old' argument to atomic*_try_cmpcxchg() needs to
be naturally aligned, maybe that check should be changed
to only test for the ABI-guaranteed alignment? I think
that would still be needed on x86-32.
 
      Arnd

diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 9409a6ddf3e0..e57763a889bd 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1276,7 +1276,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic_try_cmpxchg(v, old, new);
 }
 
@@ -1298,7 +1298,7 @@ static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -1321,7 +1321,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic_try_cmpxchg_release(v, old, new);
 }
 
@@ -1343,7 +1343,7 @@ static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -2854,7 +2854,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic64_try_cmpxchg(v, old, new);
 }
 
@@ -2876,7 +2876,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -2899,7 +2899,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic64_try_cmpxchg_release(v, old, new);
 }
 
@@ -2921,7 +2921,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -4432,7 +4432,7 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic_long_try_cmpxchg(v, old, new);
 }
 
@@ -4454,7 +4454,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic_long_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -4477,7 +4477,7 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic_long_try_cmpxchg_release(v, old, new);
 }
 
@@ -4499,7 +4499,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_atomic_read_write(old, alignof(*old));
 	return raw_atomic_long_try_cmpxchg_relaxed(v, old, new);
 }
 

