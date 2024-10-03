Return-Path: <linux-arch+bounces-7679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F309D98F8CE
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 23:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2035E1C21C09
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760561C0DE2;
	Thu,  3 Oct 2024 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="KUBiKU/i";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q7akH2FE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YwKgSGwp"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B431AD3E5;
	Thu,  3 Oct 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990318; cv=none; b=PX0h/lLjdfXwTR/1vQqh0q1DKRZcZY3oezzPt0XBNW6CAk41uS/0S39P0kzOuFyCDLnFpS72esp3CuqobawZPEgx+5Uay31K2g/Y5KP7b6Desv2/kDPypVj4bCZjGEEB09on+cQFlkEIHeCZ3lVcHTFcqWLxR1UA3vQRuVqI/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990318; c=relaxed/simple;
	bh=fLv1+fwJm8xkorFQnNPWoD4F0TZgiDH6LtPVSl6bqgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXCI5vs0I86OoMbr44LnHsrdEyIOG2hWNu9d++70WiZ/3aNwuNUmLn20F4L7UuMbFujpMvohWOuxnCfx170XWkbgGsuxOj8x027EnbgcCbmwpzKJIFo/fCdz2ur42xGz/GNFrPraIDwXaCrWcElNg92qTXlFnjCppRzb9NK7E4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=KUBiKU/i; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q7akH2FE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YwKgSGwp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id DEAC5138021D;
	Thu,  3 Oct 2024 17:18:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 03 Oct 2024 17:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1727990313;
	 x=1728076713; bh=0ITT2ENdh4aVmD3eIhmijkArG0w3ABJjgi8K1hTvi/k=; b=
	KUBiKU/i/XGCpjSqC0w4sKIK4xtiFFrekR6cm0ww6UxZZXPe0Z8bzoYNBQdbO7or
	nW6pFphw6w4ZVM06Jnv18BTUxDzSBodAisjgYsQmzcOb1kcqz1gDIgorslFGYF1p
	kA4EiaTDX3uN5jsR/B84+hGnPScVTErQ+xHXz1zGJEA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727990313; x=
	1728076713; bh=0ITT2ENdh4aVmD3eIhmijkArG0w3ABJjgi8K1hTvi/k=; b=q
	7akH2FE9nJBdpjeW2wtRSVXsL8Gj1ZpBGPDvc5bZS9uSH/c9n0UemyC6Dviaz6D0
	TwbHYaiEI1iPImd0au/x9jB6T0t61ia9buwBX2PfCr83dWGESSYssXqEYB2IWR7m
	puhFCQ+lBBhPI2VaDq3I9yNEN/ZSFSi86sDcK02nKU3ldbYH1gR13icfmrxG9Ljb
	bgc16MWauJZyzfyki5wOOaBwJWcXT1YDl9UCqM8CXa1oBFHVQK3zMoyh785vl0IU
	AaNM9kL5bADZLebAvwwQH+6JVeb+RFIa89VGmr4mz5eIcRo04vUgN7skvg5Pcxs0
	cfcXrImqWY63AEea3r4LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727990313; x=
	1728076713; bh=0ITT2ENdh4aVmD3eIhmijkArG0w3ABJjgi8K1hTvi/k=; b=Y
	wKgSGwp2I8YpQKY+4J9x1w3ZQj8yVWNlZIfjQHUHVVVSZI2DzjCtZx0ZAtLfZ5wA
	dbSv3aW5OQNQLzCHvSxkmJqmZNNmcY2vqRv3KndCLieTKSKNUtcZ2h97ccI7+K4+
	vtKcQuVtR5NYC7qcIMHclB6rKCrun5le/Xe45UYhRx8spwlRQnRHvePnZGoCU35d
	pb88U5buncTK/DHIi0whCOpNhQpnXWPNbshlRXgFI3d6/BsNyX/5kE84z5E89k/s
	UHsbDX9niBnAHnQjkVBw4U5bm18TZpd3alXgI2TNXA63aBMsDRgb6RhGpu4TdcYG
	XmiBPLQ9i+n3dO+Or12og==
X-ME-Sender: <xms:KQr_ZrnFcmwyqJs9gd1dXK0wz9hGBr1HqiFpB4OWeqN__3Kn3UZACg>
    <xme:KQr_Zu2BBEerMHYShvK-4LurQBI1AbiRP_QcODbymIQZJLaNT_kF_HUSqxGQoZml1
    p2nUfEbtepKYBIHyQc>
X-ME-Received: <xmr:KQr_ZhqYgo1iqBy4f0bHihabOAmvEtZgGRlyo1EMk8bVC8lK4vmybYSjUkGVucqf5Ilh9IhNNvxRH-BbECw6TpzuF5v-sotm3WwK9aqTsOQniUheMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudeitdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:KQr_ZjmLHZ5oy2bCsXkgybq5c6VuW5i22Fu-Y3uNZwDDA4AXbQ0HMQ>
    <xmx:KQr_Zp1BeeD2wQ8a4-vNtpv3ICRNIylb4FPXoQTiTRORJ8jEvuqLeA>
    <xmx:KQr_ZiuaNqixmksVosKEmgIwjcRUotXGllLjons2LfFZAwHun7ZE7w>
    <xmx:KQr_ZtXXA4qKW0x5VYHgE_c3NU7dzbJBmb2BGNrglbDU75VKkPi59g>
    <xmx:KQr_ZjoL8REec30TiUFt5ZmYQ0dCnPX9BCh5v-Sk4xVhtb3VOsXfWX1Y>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:18:33 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 99DF5E3CD84;
	Thu,  3 Oct 2024 17:18:32 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] asm-generic/div64: optimize/simplify __div64_const32()
Date: Thu,  3 Oct 2024 17:16:14 -0400
Message-ID: <20241003211829.2750436-3-nico@fluxnic.net>
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

Several years later I just realized that this code could be greatly
simplified.

First, let's formalize the need for overflow handling in
__arch_xprod64(). Assuming n = UINT64_MAX, there are 2 cases where
an overflow may occur:

1) If a bias must be added, we have m_lo * n_lo + m or
   m_lo * 0xffffffff + ((m_hi << 32) + m_lo) or
   ((m_lo << 32) - m_lo) + ((m_hi << 32) + m_lo) or
   (m_lo + m_hi) << 32 which must be < (1 << 64). So the criteria for no
   overflow is m_lo + m_hi < (1 << 32).

2) The cross product m_lo * n_hi + m_hi * n_lo or
   m_lo * 0xffffffff + m_hi * 0xffffffff or
   ((m_lo << 32) - m_lo) + ((m_hi << 32) - m_hi). Assuming the top
   result from the previous step (m_lo + m_hi) that must be added to
   this, we get (m_lo + m_hi) << 32 again.

So let's have a straight and simpler version when this is true.
Otherwise some reordering allows for taking care of possible overflows
without any actual conditionals. And prevent from generating both code
variants by making sure this is considered only if m is perceived as
constant by the compiler.

This, in turn, allows for greatly simplifying __div64_const32(). The
"special case" may go as well as the regular case works just fine
without needing a bias. Then reduction should be applied all the time as
minimizing m is the key.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 include/asm-generic/div64.h | 114 +++++++++++-------------------------
 1 file changed, 35 insertions(+), 79 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 13f5aa68a4..5d59cf7e73 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -74,7 +74,8 @@
 	 * do the trick here).						\
 	 */								\
 	uint64_t ___res, ___x, ___t, ___m, ___n = (n);			\
-	uint32_t ___p, ___bias;						\
+	uint32_t ___p;							\
+	bool ___bias = false;						\
 									\
 	/* determine MSB of b */					\
 	___p = 1 << ilog2(___b);					\
@@ -87,22 +88,14 @@
 	___x = ~0ULL / ___b * ___b - 1;					\
 									\
 	/* test our ___m with res = m * x / (p << 64) */		\
-	___res = ((___m & 0xffffffff) * (___x & 0xffffffff)) >> 32;	\
-	___t = ___res += (___m & 0xffffffff) * (___x >> 32);		\
-	___res += (___x & 0xffffffff) * (___m >> 32);			\
-	___t = (___res < ___t) ? (1ULL << 32) : 0;			\
-	___res = (___res >> 32) + ___t;					\
-	___res += (___m >> 32) * (___x >> 32);				\
-	___res /= ___p;							\
+	___res = (___m & 0xffffffff) * (___x & 0xffffffff);		\
+	___t = (___m & 0xffffffff) * (___x >> 32) + (___res >> 32);	\
+	___res = (___m >> 32) * (___x >> 32) + (___t >> 32);		\
+	___t = (___m >> 32) * (___x & 0xffffffff) + (___t & 0xffffffff);\
+	___res = (___res + (___t >> 32)) / ___p;			\
 									\
-	/* Now sanitize and optimize what we've got. */			\
-	if (~0ULL % (___b / (___b & -___b)) == 0) {			\
-		/* special case, can be simplified to ... */		\
-		___n /= (___b & -___b);					\
-		___m = ~0ULL / (___b / (___b & -___b));			\
-		___p = 1;						\
-		___bias = 1;						\
-	} else if (___res != ___x / ___b) {				\
+	/* Now validate what we've got. */				\
+	if (___res != ___x / ___b) {					\
 		/*							\
 		 * We can't get away without a bias to compensate	\
 		 * for bit truncation errors.  To avoid it we'd need an	\
@@ -111,45 +104,18 @@
 		 *							\
 		 * Instead we do m = p / b and n / b = (n * m + m) / p.	\
 		 */							\
-		___bias = 1;						\
+		___bias = true;						\
 		/* Compute m = (p << 64) / b */				\
 		___m = (~0ULL / ___b) * ___p;				\
 		___m += ((~0ULL % ___b + 1) * ___p) / ___b;		\
-	} else {							\
-		/*							\
-		 * Reduce m / p, and try to clear bit 31 of m when	\
-		 * possible, otherwise that'll need extra overflow	\
-		 * handling later.					\
-		 */							\
-		uint32_t ___bits = -(___m & -___m);			\
-		___bits |= ___m >> 32;					\
-		___bits = (~___bits) << 1;				\
-		/*							\
-		 * If ___bits == 0 then setting bit 31 is  unavoidable.	\
-		 * Simply apply the maximum possible reduction in that	\
-		 * case. Otherwise the MSB of ___bits indicates the	\
-		 * best reduction we should apply.			\
-		 */							\
-		if (!___bits) {						\
-			___p /= (___m & -___m);				\
-			___m /= (___m & -___m);				\
-		} else {						\
-			___p >>= ilog2(___bits);			\
-			___m >>= ilog2(___bits);			\
-		}							\
-		/* No bias needed. */					\
-		___bias = 0;						\
 	}								\
 									\
+	/* Reduce m / p to help avoid overflow handling later. */	\
+	___p /= (___m & -___m);						\
+	___m /= (___m & -___m);						\
+									\
 	/*								\
-	 * Now we have a combination of 2 conditions:			\
-	 *								\
-	 * 1) whether or not we need to apply a bias, and		\
-	 *								\
-	 * 2) whether or not there might be an overflow in the cross	\
-	 *    product determined by (___m & ((1 << 63) | (1 << 31))).	\
-	 *								\
-	 * Select the best way to do (m_bias + m * n) / (1 << 64).	\
+	 * Perform (m_bias + m * n) / (1 << 64).			\
 	 * From now on there will be actual runtime code generated.	\
 	 */								\
 	___res = __arch_xprod_64(___m, ___n, ___bias);			\
@@ -165,7 +131,7 @@
  * Semantic:  retval = ((bias ? m : 0) + m * n) >> 64
  *
  * The product is a 128-bit value, scaled down to 64 bits.
- * Assuming constant propagation to optimize away unused conditional code.
+ * Hoping for compile-time optimization of  conditional code.
  * Architectures may provide their own optimized assembly implementation.
  */
 static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
@@ -174,38 +140,28 @@ static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
 	uint32_t m_hi = m >> 32;
 	uint32_t n_lo = n;
 	uint32_t n_hi = n >> 32;
-	uint64_t res;
-	uint32_t res_lo, res_hi, tmp;
-
-	if (!bias) {
-		res = ((uint64_t)m_lo * n_lo) >> 32;
-	} else if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
-		/* there can't be any overflow here */
-		res = (m + (uint64_t)m_lo * n_lo) >> 32;
-	} else {
-		res = m + (uint64_t)m_lo * n_lo;
-		res_lo = res >> 32;
-		res_hi = (res_lo < m_hi);
-		res = res_lo | ((uint64_t)res_hi << 32);
-	}
-
-	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
-		/* there can't be any overflow here */
-		res += (uint64_t)m_lo * n_hi;
-		res += (uint64_t)m_hi * n_lo;
-		res >>= 32;
+	uint64_t x, y;
+
+	/* Determine if overflow handling can be dispensed with. */
+	bool no_ovf = __builtin_constant_p(m) &&
+		      ((m >> 32) + (m & 0xffffffff) < 0x100000000);
+
+	if (no_ovf) {
+		x = (uint64_t)m_lo * n_lo + (bias ? m : 0);
+		x >>= 32;
+		x += (uint64_t)m_lo * n_hi;
+		x += (uint64_t)m_hi * n_lo;
+		x >>= 32;
+		x += (uint64_t)m_hi * n_hi;
 	} else {
-		res += (uint64_t)m_lo * n_hi;
-		tmp = res >> 32;
-		res += (uint64_t)m_hi * n_lo;
-		res_lo = res >> 32;
-		res_hi = (res_lo < tmp);
-		res = res_lo | ((uint64_t)res_hi << 32);
+		x = (uint64_t)m_lo * n_lo + (bias ? m_lo : 0);
+		y = (uint64_t)m_lo * n_hi + (uint32_t)(x >> 32) + (bias ? m_hi : 0);
+		x = (uint64_t)m_hi * n_hi + (uint32_t)(y >> 32);
+		y = (uint64_t)m_hi * n_lo + (uint32_t)y;
+		x += (uint32_t)(y >> 32);
 	}
 
-	res += (uint64_t)m_hi * n_hi;
-
-	return res;
+	return x;
 }
 #endif
 
-- 
2.46.1


