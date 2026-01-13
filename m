Return-Path: <linux-arch+bounces-15761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53885D16B98
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 06:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E39C30312EF
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 05:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0C2E091B;
	Tue, 13 Jan 2026 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYyhii0f"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2535B127;
	Tue, 13 Jan 2026 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282726; cv=none; b=biQsDk3XsPsS/XcVT1F/zHkTFeiuONoZhOJQbOdUyhlYqO5jMOdRrhwo41lngueWHf6bE4ENwLJicWK0Kbs34GCQBtP0i1gnPa0pjNF+VVPka1phdgNtL7rInyj/a5HOmx2TVQToi5Z6F2whnUeaUx8twK8LMCrO1EgmPVjzFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282726; c=relaxed/simple;
	bh=OWh8njjsogK8OZKE0gH6MErCWwee1eb7vZZ80vE+0TE=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=FFWwn7QDnMeIwMfXjnxE702bZIul1fUUThOPk+EoIGCgHXE4PwVoZJkZtmqFYWmQmyb/XXGF10dQaLF+KnXnIreOAVqdx88/+KMxLHD1f2+rfYiPRiE6gdvvmJ+SrJq7mvWGWznlvu4cYtxcO0tQlbv7NpK26QYQZ7bDh1UpoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYyhii0f; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C7F531D00142;
	Tue, 13 Jan 2026 00:38:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 13 Jan 2026 00:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768282724; x=
	1768369124; bh=ycpRkHG759Ns/LsRddK7ctIaYu+SsUoRWuefNhT6tys=; b=i
	Yyhii0fzWjaiSQ+kRHXhEEV6wQMWKKtiv59fCZDrdXyo9vlZWAjASXOvsDjoQkY4
	BO0Fp3BhFe4vQXcYN9zTvhBjy5HGEK05PNOz1EZqvlEbpGeF1kYG4MEUxhgPfpvY
	vpBemnfhGcm+HkxaTc7vY4yG5W5jEtff97qqB9W/Ojw3Lyj7Y6O/5vJJ1MfQT0Cf
	tWq1O5Zp1N2YRer2PFZ2DHI0b+hvEXI6uSwo5qGiYV2ChdXBy4EclNf767A8ectC
	dAv8r2yTRCKzzh0OTEIBoiFE6YAt/Fw4RDYrUwm0HAQid+BEaacB1pOez0BypOz2
	qAVCrX8ywMVOW5JAWDU+A==
X-ME-Sender: <xms:ZNplaZQOhomhhxip7ZaY5bzdiMoP32TZ_irYZobh6VC82xALF97BXw>
    <xme:ZNplaQKWXVvGA6EUkmwdECQdRD9LRBlf1TBH95wzNvkmUA-6JNWwcmh5TPDinsw5A
    -Dwu97tZakkExRB0HyLQM-Gb3s0LyV-fLTcVgFiVAgNPU1fBFDHKg>
X-ME-Received: <xmr:ZNplaYW76MPoorYwdSussJKRulV5l5LWJt-lGqWtQCBDMNzNHUzkoSwNlO93voyirdrxTM_u8N-0Qt-gejHZWIgR9BaN6hNy0ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgffgtdfhhfefveeuudfgtdeugfeftedtveekieeggfduleetgeegueehgeffffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhguse
    grrhhnuggsrdguvgdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehmrg
    hrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhgt
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZNplacQXqEDJXX51NobZwDfReEZ7dhS2TKy9BEoG1UoZjU5PhM0BYg>
    <xmx:ZNplaYC8FNBNzAQ5jrA6fV7VTIANHlQlsh7MsJwNaSBJwmzrYASDQA>
    <xmx:ZNplaTKGffdnYUnFknnoa5D3etEqCkyIzcNry-5BTwG1mlZ5ieM2_w>
    <xmx:ZNplaTDi_y-WWlqYtjmJATYT9wX9KcGu6IA-HHfeR2hNmDbKgnGU3g>
    <xmx:ZNplaadJr2mD4dVAoWPRvmwQjw1J3JUGLfG-kivd_8uCIvOsoh828eI_>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 00:38:42 -0500 (EST)
To: Andrew Morton <akpm@linux-foundation.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Gary Guo <gary@garyguo.net>,
    Mark Rutland <mark.rutland@arm.com>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org
Message-ID: <6d25a12934fe9199332f4d65d17c17de450139a8.1768281748.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1768281748.git.fthain@linux-m68k.org>
References: <cover.1768281748.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v7 4/4] atomic: Add option for weaker alignment check
Date: Tue, 13 Jan 2026 16:22:28 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Add a new Kconfig symbol to make CONFIG_DEBUG_ATOMIC more useful on
those architectures which do not align dynamic allocations to 8-byte
boundaries. Without this, CONFIG_DEBUG_ATOMIC produces excessive
WARN splats.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v6:
 - Rebased.

Changed since v5:
 - Rebased.

Changed since v3:
 - Dropped #include <linux/cache.h> to avoid a build failure on arm64.
 - Rewrote Kconfig help text to better describe preferred alignment.
 - Refactored to avoid line-wrapping and duplication.
---
 include/linux/instrumented.h | 8 +++++++-
 lib/Kconfig.debug            | 8 ++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index e34b6a557e0a..a1b4cf81adc2 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -59,7 +59,13 @@ static __always_inline void instrument_read_write(const volatile void *v, size_t
 static __always_inline void instrument_atomic_check_alignment(const volatile void *v, size_t size)
 {
 #ifndef __DISABLE_EXPORTS
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	if (IS_ENABLED(CONFIG_DEBUG_ATOMIC)) {
+		unsigned int mask = size - 1;
+
+		if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_LARGEST_ALIGN))
+			mask &= sizeof(struct { long x; } __aligned_largest) - 1;
+		WARN_ON_ONCE((unsigned long)v & mask);
+	}
 #endif
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4b4d1445ef9c..977a2c9163a2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1369,6 +1369,14 @@ config DEBUG_ATOMIC
 
 	  This option has potentially significant overhead.
 
+config DEBUG_ATOMIC_LARGEST_ALIGN
+	bool "Check alignment only up to __aligned_largest"
+	depends on DEBUG_ATOMIC
+	help
+	  If you say Y here then the check for natural alignment of
+	  atomic accesses will be constrained to the compiler's largest
+	  alignment for scalar types.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
-- 
2.49.1


