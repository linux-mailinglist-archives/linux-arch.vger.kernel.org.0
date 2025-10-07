Return-Path: <linux-arch+bounces-13950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA9BC3004
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 01:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7499C19E012D
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19C5255F2D;
	Tue,  7 Oct 2025 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LmXpd90W"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B12609E3;
	Tue,  7 Oct 2025 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881079; cv=none; b=IUhfmf3UsfxE9Q8E3FQKR+1oMGYAPBAiMQ4mSucYkuPWuJXljoFCBYsfz5sUwdvWzRSMrukM2MdgLnls8iASGJ7zbaZroU5exQAhKcNBZGaAo1IU23Znach4moNbjKNKd1c+aQTvWtQLR1W2fonIVtX7wg52UM430a0Rde21PLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881079; c=relaxed/simple;
	bh=GKdlckKpBwoWz5SmGQFW80sWaAJ08k8SalMYCE+PBNo=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=fHIknu7mITFZAbdR/maUbLGn59AAIfF4b+cu5PerBRuq02UQlcfrcKarn4MVcUYBtlAyNllRqu/45gLInwSg2rAMQ5zR2IVwulMuG8kXAF+5fRvyFPUtkK9XdIpcNfIXKUgRcX43UU9ipuTOEEFCqtZeoI+Ei+MansQ6L63F2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LmXpd90W; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 286547A0053;
	Tue,  7 Oct 2025 19:51:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 19:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759881077; x=
	1759967477; bh=DD225BAPYeK+qLAmHgDY4jpXzvMfC78Rnw2xeRu8mXU=; b=L
	mXpd90WTcdzuY6vfRLjk3FOg+iPrJZxa1c95OhUSKBFGEPU9vKn1FxNaoraxAoCd
	UwDjMzFZzEvkftKbZASva5DXe5CvWBoKND6GcKVOxu7PhrQGy5l+NH2zl3sOVJmE
	OkQL0K1EJPwYWrtDfMfc+M4vEW88X0q0+U28MxM/L1Yd/fE0xizoPW0QwRRC+wT8
	nt7VD6VKFVK49i6a8IxibknrOAsTh9Wb9+Bvaf1wDmTQlNoonLROEF3Qpanhs5pg
	NmecH1X3g2YbsIWA+A66w+AHLpn44eV+6FI32vTxy8diw+4jrt2NtnNzT8MI/Iwu
	RXjNajBnyh+C6B7qxQimw==
X-ME-Sender: <xms:dKflaBtMlEzHjTlLJ79x1hIXWUY9mpbCPwrjVWYi3Xkd8f_4OifBCg>
    <xme:dKflaGV8TWHjwkuRXhiqEA75Mm7kPiQpnFO59DCIqm80VMwsDeFMku9OAzOGREpTD
    4rA7ZtAFkKhfjKPzkLN8HCM2WI-hQA6PGKdhWFvopnCdq_4lK4Uz_A>
X-ME-Received: <xmr:dKflaBzQpx6oV_aePPjwyW5qWXj5t03xJHidNJE2iuAKIE09PeBNK8NILNOk8vTrfeEwZu3sJzFqiltbNMw5kp-8Sm53n3JGZPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehkeduffehjedvieevkeelleegffeiuddvgeeluefhuedugeekkeehffekgffgheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhr
    ghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehmrghrkhdrrh
    huthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggv
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dKflaNEubrEGa-UzNp4wasKj5s-qpF6Xf-FHiWlI_MRu1FXJlUrt8w>
    <xmx:dKflaGvu9ri9u3LohQi-76RXNzGZLC1SuUvJV1jPMeYitTZAzWG7Gg>
    <xmx:dKflaNDiqWLN3CgMb4Y40Q8sKIcSExqWxDc6tlw_ECJdPxN_ygM9gw>
    <xmx:dKflaBAJZ2Jl_OKPoYROVe9eqgcTRn3QzG_QVIUbeszuhUj9jto7EQ>
    <xmx:daflaI78sNz4bKXfic1PpOoLUr-LgB-uWpj4eziGZI95o4LqbPX8BNva>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 19:51:14 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Boqun Feng <boqun.feng@gmail.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Mark Rutland <mark.rutland@arm.com>,
    Arnd Bergmann <arnd@arndb.de>,
    linux-kernel@vger.kernel.org,
    linux-arch@vger.kernel.org,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-m68k@vger.kernel.org
Message-ID: <b5ac21e9c1d54d37185db39034d6c31b1dfaf2ac.1759875560.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1759875560.git.fthain@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v3 4/5] atomic: Add alignment check to instrumented atomic
 operations
Date: Wed, 08 Oct 2025 09:19:20 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

Add a Kconfig option for debug builds which logs a warning when an
instrumented atomic operation takes place that's misaligned.
Some platforms don't trap for this.

Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
---
Changed since v2:
 - Always check for natural alignment.
---
To make this useful on those architectures that don't naturally align
scalars (x86-32, m68k and sh come to mind), please also use
"[PATCH] atomic: skip alignment check for try_cmpxchg() old arg"
https://lore.kernel.org/all/20251006110740.468309-1-arnd@kernel.org/
---
 include/linux/instrumented.h |  4 ++++
 lib/Kconfig.debug            | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 711a1f0d1a73..402a999a0d6b 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_INSTRUMENTED_H
 #define _LINUX_INSTRUMENTED_H
 
+#include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
@@ -67,6 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
 }
 
 /**
@@ -81,6 +83,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
 }
 
 /**
@@ -95,6 +98,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..d82626b7d6be 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1363,6 +1363,16 @@ config DEBUG_PREEMPT
 	  depending on workload as it triggers debugging routines for each
 	  this_cpu operation. It should only be used for debugging purposes.
 
+config DEBUG_ATOMIC
+	bool "Debug atomic variables"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here then the kernel will add a runtime alignment check
+	  to atomic accesses. Useful for architectures that do not have trap on
+	  mis-aligned access.
+
+	  This option has potentially significant overhead.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
-- 
2.49.1


