Return-Path: <linux-arch+bounces-7675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1F98F8C8
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 23:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903351C213E8
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074741B5336;
	Thu,  3 Oct 2024 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="xiQc8KuK";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6AyC3Qs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crppWk2b"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A401A76CE;
	Thu,  3 Oct 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990316; cv=none; b=IaPiWjY43shfpP5nyWglUtYp+r/AJ1SVfZ91Ts0E3XrBFNba20xLS4QValseY/MvsuoToMe4wzHIOeiMKiTqDjlW8lkVX7A7z1oGSNvvKAJUSaqv61THkUgqUdxOSfDeuCHRp+/zPZlTe1uXE9604EAPGL8VRqwQsTEs3b90MRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990316; c=relaxed/simple;
	bh=fB4Z3BxVeo+0QrW+Ii/+Itqcp6qi1Tzmaq8LNY0yfFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqoarFDWEUHYXQk6fn2Hw4ZxBKM1U5cx2C3CZJwnijpj2gTOD9+QFfY7rsEHtc/2mvNJoF6rwgPkfvpFRIe70zacYsRgyLPq5a14ejMKYba3IZMuad2G8S2zIzTIShGongoiDFMNMpMe1KUF+Y9Nu8f9hlXdn5Xb8uejxOGfAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=xiQc8KuK; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C6AyC3Qs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crppWk2b; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E6874138027B;
	Thu,  3 Oct 2024 17:18:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 03 Oct 2024 17:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1727990313;
	 x=1728076713; bh=JO+JOZInDR3JSscjDLnxO7RphvcKtqdKqusKtWnLamo=; b=
	xiQc8KuKs6C1A0Bz82h6j1i7dL6Fkx3ExM6Z3cJzExZR9myZG2I6T2Wvi+TDDuvL
	fOKeJSRqFB/IepmkZvEEzGR4ZhxEto9ROaiKO6bt/B+ExjVM8/wyxI7rvTx6h+CI
	rkRHXwJwJicenyDr31kxo5eCdphX9VhFyRYSH+X+TqY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727990313; x=
	1728076713; bh=JO+JOZInDR3JSscjDLnxO7RphvcKtqdKqusKtWnLamo=; b=C
	6AyC3Qs0Fz0GewEeTa0S4x0fVwy1tX23WvH0Ipo/iDFaxH9tkR2egkdHDpKzRtrb
	X5RBqvo7muqKWbyXREzMVWZeyTmz1dNhBjXLe3JP/jkTOTHb4h8xdHeqoHaLw8C4
	4x/TeTNBeIBFRdeUdCaPCTObgFMW99WVs/MYkddfqAEshO2YdaxxikH0Z4GlBdKZ
	Mly8Pb8UTjWiVnfSlNxYq6jO030ZihiRNjXX2Vuxs9vWLNgpvlkfPdborpvSTwtv
	UBp8eoC8qZa5wN/KOBzQPlSii/t1qjHuwWIQNE0km2sKNVwZR8MJGx74tEgMWkFz
	UpbOMi8YB2bGahEz55w6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727990313; x=
	1728076713; bh=JO+JOZInDR3JSscjDLnxO7RphvcKtqdKqusKtWnLamo=; b=c
	rppWk2bk5QmgDq24/PSKWdoXFmXjrvgCv5axA3hilFX9c3hN7BRSefkMhULdq3R2
	rL0ngyn08v4sgcWItX6wpnhsB2uyzd3yqP850tFSkUdQHRt7fMi9MZBHsktpO1Ba
	ctVPBM4x/iGm2zqK8ojlidyqTgmD56+ZZ0iVz/fhJbYPhRZ9iw48sVbeTEtEhkJ/
	cWabe+DKOzaYU9h8TSdkI0ZQQPSYbjPO5yGqgmnOZuXoWkEDj51kXWxVw5lR2gBO
	tM/pYQij+s2IL0NfzJ6je/ojo+mWpMC1KHv2EttmpLc6tueuQIFt7GZ4ghwHgodA
	kC3j6xkis1PjTA8A3xVig==
X-ME-Sender: <xms:KQr_ZuZvdFMOF8oNOPrytTgzQ9GBO07bTGPtaAOtygiWYUyaMX0nAg>
    <xme:KQr_ZhZlGgkfjT3NhJ6VSlm7p9YH5n7FZhFP9H8TRjGsM-gaSQPqCTWmtjapjtmcX
    JaqsdIcEa0VvGaQpkU>
X-ME-Received: <xmr:KQr_Zo8mt9KeKC6ihqL32Ues4sa11hSaJGhKPpWPKps4DuAVud1HCGynYUc6uEjIbDjYzgMVu242pJ2-ZMCzzplWsQQ8ldtqKiXvd2D87_KKAwSPqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpedtjeeuieeiheeiueffuddvffelheekleegkedu
    keeffffhudffudegvdetiefhteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrghrmhhlih
    hnuhigrdhorhhgrdhukhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghp
    thhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KQr_ZgpRVxeygztM41AeUb-spO1qZ7bZRPqqTz_ZJ8FZrxU2MZJiGw>
    <xmx:KQr_ZppBeABkvqHXCqm_bk4eXmpLZMQ5R99m833Gr9RJmbNRx18ZRg>
    <xmx:KQr_ZuTmAsXIGTGB1KHFGINQLmOmD_MMzw3yQE75cuH3zW6GXpaH8A>
    <xmx:KQr_Zpq4eoKOJAwCINCHK3XA6zzoaQ1w8-J3swhSD7Hms3OBjv7mGg>
    <xmx:KQr_ZqeaFbkJkHgEdIPsPUBkv46A0r4Vwkod4E_unArZL7dnnYIga36W>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:18:33 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C8528E3CD87;
	Thu,  3 Oct 2024 17:18:32 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] __arch_xprod64(): make __always_inline when optimizing for performance
Date: Thu,  3 Oct 2024 17:16:16 -0400
Message-ID: <20241003211829.2750436-5-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003211829.2750436-1-nico@fluxnic.net>
References: <20241003211829.2750436-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

Recent gcc versions started not systematically inline __arch_xprod64()
and that has performance implications. Give the compiler the freedom to
decide only when optimizing for size.

Here's some timing numbers from lib/math/test_div64.c

Using __always_inline:

```
test_div64: Starting 64bit/32bit division and modulo test
test_div64: Completed 64bit/32bit division and modulo test, 0.048285584s elapsed
```

Without __always_inline:

```
test_div64: Starting 64bit/32bit division and modulo test
test_div64: Completed 64bit/32bit division and modulo test, 0.053023584s elapsed
```

Forcing constant base through the non-constant base code path:

```
test_div64: Starting 64bit/32bit division and modulo test
test_div64: Completed 64bit/32bit division and modulo test, 0.103263776s elapsed
```

It is worth noting that test_div64 does half the test with non constant
divisors already so the impact is greater than what those numbers show.
And for what it is worth, those numbers were obtained using QEMU. The
gcc version is 14.1.0.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm/include/asm/div64.h | 7 ++++++-
 include/asm-generic/div64.h  | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 562d5376ae..d3ef8e416b 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -52,7 +52,12 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
 
 #else
 
-static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
+#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
+static __always_inline
+#else
+static inline
+#endif
+uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 {
 	unsigned long long res;
 	register unsigned int tmp asm("ip") = 0;
diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 5d59cf7e73..25e7b4b58d 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -134,7 +134,12 @@
  * Hoping for compile-time optimization of  conditional code.
  * Architectures may provide their own optimized assembly implementation.
  */
-static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
+#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
+static __always_inline
+#else
+static inline
+#endif
+uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
 {
 	uint32_t m_lo = m;
 	uint32_t m_hi = m >> 32;
-- 
2.46.1


