Return-Path: <linux-arch+bounces-14238-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B5BF3F1B
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA50B18C65E5
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B52F2911;
	Mon, 20 Oct 2025 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vZySVlpO"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796D2F0C46;
	Mon, 20 Oct 2025 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999815; cv=none; b=RSRlSu50PYT0mKYSKnS19pyYbnypbdoxKouqNMH8+dRYGSWdonIZGLxjpthivwp+BQtiLEvVBdUWGXk9FeS6PvvNlK9hOtQtTDzN80JmbN9LolRzdPefNRy88L5ATlsv2VGZvOfW77hxM5/6i+96gw2hvzmJEmnoE2s/a1WNDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999815; c=relaxed/simple;
	bh=oAwsmojtKX1hlDXyiaKqg3VsPIxLw2dunAdcVhMc1Mo=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=CdL23ckbIpBH6eC5x6Oqi34CEqNx0zoi2Qh5yBkK+WaWf0C6InGbC065cZGDZTnw12WyNCgBVSKPbde2umkUwCMoTXQQu/AYxgYCIvNOj3lFJI4PyyrwBryLYU0skEeTn+vUE0Ovu5W9a2WqJqMHP3Lg3eBjTrrPxB3k4IME8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vZySVlpO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 036191D00149;
	Mon, 20 Oct 2025 18:36:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 20 Oct 2025 18:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760999812; x=
	1761086212; bh=xCzEtoNxSS71DBOWSJCr+vKOLnsVoIb0CZZ05NZm2s0=; b=v
	ZySVlpOqjUr2UiuoNNKy0hKoVzCr47R5TPjuxzyezI0RG8okQ4l/K77vPWkRV9kX
	VynGCYcR03rg9O4qc780NESiW7XQ81+hv1Y9lMhpRUieOxoBcTuKH4OOjTSGqYcb
	OmnKyatZhwSXtl21/uIYgRFplnonxhigIfJoHBNLTL3x/PJIBievYtPQx9dPY0ni
	pOMu4pbut+jgVSTg4TmlaW4KlOrXYz3ZEXwQeK8aZaRuGzUBApSEeGfzTW6SsJmh
	eh0R5P+cPeKMMcLEdgG3fHpd73fOAkkAS9Akn7yS+R+kNrBzIxQYdaaY7DlyD9VA
	cbKk1wAoEGYu6WQEPcQqg==
X-ME-Sender: <xms:hLn2aFq-qDHfFWFbd-IGuayqTDfJ3KMmWnMaXvlHT2WpWHWKlHxiJw>
    <xme:hLn2aNpf2B82xNVNRgEXAExJ8lPSP5qa0XBd3lDnBbppxctiolZuuojoG-jkRzTfJ
    LMWoMw2YHVXZ7CJ30c5iCA9PJkTDAXUqYact8MfNRSY2VEUlit6IQ>
X-ME-Received: <xmr:hLn2aNAU9_EJ5Dhj4grfw5cnAcdvYmo-60jTJSohZ7A7r2Fd0NBqhMRlbQkSiIWI7qceSyLy9HebvXj51-l8blO96SjzUzjxbo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkfgjfhfhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgffgtdfhhfefveeuudfgtdeugfeftedtveekieeggfduleetgeegueehgeffffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhp
    mheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghrnhguse
    grrhhnuggsrdguvgdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhmieekkhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hLn2aDvNGFVO4pG30D6KTfeP4KpaYanaAJuWp0AhCoCYCQPDOBWN7g>
    <xmx:hLn2aEIm0Wl0H6Z2vo6UV--UOFyfU68a8dr-OdTAsb5wc66JYu16ng>
    <xmx:hLn2aCYcvdm0NeKtG_hM8GOO9Yp_4hOJXzp0o-aQeTLjd053xbzW6w>
    <xmx:hLn2aOBjJXvfElF1cy5N8nxjndzGTToJ_4sel92qcIMeD3QfS8onNw>
    <xmx:hLn2aHKrTsi7w772Tt6cfSnUH5K6TuQlbOKXEZzXV35MwqnDHQGxbP1q>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 18:36:50 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Arnd Bergmann <arnd@arndb.de>,
    Boqun Feng <boqun.feng@gmail.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-arch@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-m68k@vger.kernel.org,
    Mark Rutland <mark.rutland@arm.com>
Message-ID: <98018681b75da61108b992ab15ad455569863924.1760999284.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1760999284.git.fthain@linux-m68k.org>
References: <cover.1760999284.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v4 5/5] atomic: Add option for weaker alignment check
Date: Tue, 21 Oct 2025 09:28:04 +1100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Add a new Kconfig symbol to make CONFIG_DEBUG_ATOMIC more useful on
those architectures which do not align dynamic allocations to 8-byte
boundaries. Without this, CONFIG_DEBUG_ATOMIC produces excessive
WARN splats.
---
Changed since v3:
 - Dropped #include <linux/cache.h> to avoid a build failure on arm64.
 - Rewrote Kconfig help text to better describe preferred alignment.
 - Refactored to avoid line-wrapping and duplication.
---
 include/linux/instrumented.h | 17 ++++++++++++++---
 lib/Kconfig.debug            |  8 ++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 402a999a0d6b..ca946c5860be 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -56,6 +56,17 @@ static __always_inline void instrument_read_write(const volatile void *v, size_t
 	kcsan_check_read_write(v, size);
 }
 
+static __always_inline void instrument_atomic_check_alignment(const volatile void *v, size_t size)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_ATOMIC)) {
+		unsigned int mask = size - 1;
+
+		if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_LARGEST_ALIGN))
+			mask &= sizeof(struct { long x; } __aligned_largest) - 1;
+		WARN_ON_ONCE((unsigned long)v & mask);
+	}
+}
+
 /**
  * instrument_atomic_read - instrument atomic read access
  * @v: address of access
@@ -68,7 +79,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
@@ -83,7 +94,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
@@ -98,7 +109,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
+	instrument_atomic_check_alignment(v, size);
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1c7e30cdfe04..4d3ebe501d17 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1373,6 +1373,14 @@ config DEBUG_ATOMIC
 
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


