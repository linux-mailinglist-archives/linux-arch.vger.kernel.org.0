Return-Path: <linux-arch+bounces-5298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AFA92991F
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A51C2090B
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123A9535DC;
	Sun,  7 Jul 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NxiLjVup";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Hkl9tnds"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E32E64B;
	Sun,  7 Jul 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720372770; cv=none; b=uzywNtEgN+/iiOElfvuvZWM/wCTTLY60jicsWYo6vYzCGV8cGCNya3L2Pmf9b3ZP8xDYe2BobZXI0eJC3g2EvtNIQyKrIjzcH5OALBDcsDRRUtPO+VuNPNErxRtS4kykm25XK+2CqWdLmN+opIG3+6+W6RuqITyjPDanVhxDggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720372770; c=relaxed/simple;
	bh=mMSq6t9G/IHT+FHiu7gS6S1bs9WXkhLQQHcvmvK3aeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+eSTPbcYArj7a3Bh0c7r50ZIgvY90okkhcc3tUtSYeMxKDpElK/ij36TdmhbNispWbPVhH4uTwrq+OVnkRh1pA7MaJZ1m//ERU2HwUDeub34cNgBP2J2HWn5UZ2akNCCjkg2CEJGg3g0b8cFUQvOhnSEcPk2o3zDAKKXrhntJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NxiLjVup; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Hkl9tnds reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F206229CA;
	Sun,  7 Jul 2024 13:19:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=mMSq6t9G/IHT+FHiu7gS6S1bs
	9WXkhLQQHcvmvK3aeA=; b=NxiLjVup3iVMKNwamW1lGj69isG2pBcFhcBKepCHb
	ROk12rtWeieaIwvn3ebcderG64SrmC36r8wmjCUvG8zvXwJytLgsD5gatLOkxSM7
	gKV/q6nv1Vest86ktc2ivhzw96x2dZmo90IEyAh8588C7NRkAu28tZTV6sX32ivU
	zI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16357229C9;
	Sun,  7 Jul 2024 13:19:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=/DDnUJ29jmXhWLjJfdTuobMgv2bC3GfpHPNMc0mP3CQ=; b=Hkl9tndsRYl9+AiRsccyXbVxfmSyfXyP047VPzEZQU2uOUgkSiUukNonRfIjPpAdWaLnwAqkyRsC9SaHyVQ7drOug571dneU5ST6+Egxd0PVu16k+FYh/7Y0UeBqUvM1GBjG6FR2544Z/IwB5qXAdk7iumF7kg1oJI5cBTDVAwc=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73181229C6;
	Sun,  7 Jul 2024 13:19:26 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 420D4D3B28C;
	Sun,  7 Jul 2024 13:19:25 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] asm-generic/div64: optimize/simplify __div64_const32()
Date: Sun,  7 Jul 2024 13:17:34 -0400
Message-ID: <20240707171919.1951895-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707171919.1951895-1-nico@fluxnic.net>
References: <20240707171919.1951895-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 0FC817C2-3C85-11EF-9833-5B6DE52EC81B-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Several years later I just realized that this code could be greatly
simplified.

First, let's formalize the need for overflow handling in
__arch_xprod64(). Assuming n =3D UINT64_MAX, there are 2 cases where
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
 	uint64_t ___res, ___x, ___t, ___m, ___n =3D (n);			\
-	uint32_t ___p, ___bias;						\
+	uint32_t ___p;							\
+	bool ___bias =3D false;						\
 									\
 	/* determine MSB of b */					\
 	___p =3D 1 << ilog2(___b);					\
@@ -87,22 +88,14 @@
 	___x =3D ~0ULL / ___b * ___b - 1;					\
 									\
 	/* test our ___m with res =3D m * x / (p << 64) */		\
-	___res =3D ((___m & 0xffffffff) * (___x & 0xffffffff)) >> 32;	\
-	___t =3D ___res +=3D (___m & 0xffffffff) * (___x >> 32);		\
-	___res +=3D (___x & 0xffffffff) * (___m >> 32);			\
-	___t =3D (___res < ___t) ? (1ULL << 32) : 0;			\
-	___res =3D (___res >> 32) + ___t;					\
-	___res +=3D (___m >> 32) * (___x >> 32);				\
-	___res /=3D ___p;							\
+	___res =3D (___m & 0xffffffff) * (___x & 0xffffffff);		\
+	___t =3D (___m & 0xffffffff) * (___x >> 32) + (___res >> 32);	\
+	___res =3D (___m >> 32) * (___x >> 32) + (___t >> 32);		\
+	___t =3D (___m >> 32) * (___x & 0xffffffff) + (___t & 0xffffffff);\
+	___res =3D (___res + (___t >> 32)) / ___p;			\
 									\
-	/* Now sanitize and optimize what we've got. */			\
-	if (~0ULL % (___b / (___b & -___b)) =3D=3D 0) {			\
-		/* special case, can be simplified to ... */		\
-		___n /=3D (___b & -___b);					\
-		___m =3D ~0ULL / (___b / (___b & -___b));			\
-		___p =3D 1;						\
-		___bias =3D 1;						\
-	} else if (___res !=3D ___x / ___b) {				\
+	/* Now validate what we've got. */				\
+	if (___res !=3D ___x / ___b) {					\
 		/*							\
 		 * We can't get away without a bias to compensate	\
 		 * for bit truncation errors.  To avoid it we'd need an	\
@@ -111,45 +104,18 @@
 		 *							\
 		 * Instead we do m =3D p / b and n / b =3D (n * m + m) / p.	\
 		 */							\
-		___bias =3D 1;						\
+		___bias =3D true;						\
 		/* Compute m =3D (p << 64) / b */				\
 		___m =3D (~0ULL / ___b) * ___p;				\
 		___m +=3D ((~0ULL % ___b + 1) * ___p) / ___b;		\
-	} else {							\
-		/*							\
-		 * Reduce m / p, and try to clear bit 31 of m when	\
-		 * possible, otherwise that'll need extra overflow	\
-		 * handling later.					\
-		 */							\
-		uint32_t ___bits =3D -(___m & -___m);			\
-		___bits |=3D ___m >> 32;					\
-		___bits =3D (~___bits) << 1;				\
-		/*							\
-		 * If ___bits =3D=3D 0 then setting bit 31 is  unavoidable.	\
-		 * Simply apply the maximum possible reduction in that	\
-		 * case. Otherwise the MSB of ___bits indicates the	\
-		 * best reduction we should apply.			\
-		 */							\
-		if (!___bits) {						\
-			___p /=3D (___m & -___m);				\
-			___m /=3D (___m & -___m);				\
-		} else {						\
-			___p >>=3D ilog2(___bits);			\
-			___m >>=3D ilog2(___bits);			\
-		}							\
-		/* No bias needed. */					\
-		___bias =3D 0;						\
 	}								\
 									\
+	/* Reduce m / p to help avoid overflow handling later. */	\
+	___p /=3D (___m & -___m);						\
+	___m /=3D (___m & -___m);						\
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
 	___res =3D __arch_xprod_64(___m, ___n, ___bias);			\
@@ -165,7 +131,7 @@
  * Semantic:  retval =3D ((bias ? m : 0) + m * n) >> 64
  *
  * The product is a 128-bit value, scaled down to 64 bits.
- * Assuming constant propagation to optimize away unused conditional cod=
e.
+ * Hoping for compile-time optimization of  conditional code.
  * Architectures may provide their own optimized assembly implementation=
.
  */
 static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, boo=
l bias)
@@ -174,38 +140,28 @@ static inline uint64_t __arch_xprod_64(const uint64=
_t m, uint64_t n, bool bias)
 	uint32_t m_hi =3D m >> 32;
 	uint32_t n_lo =3D n;
 	uint32_t n_hi =3D n >> 32;
-	uint64_t res;
-	uint32_t res_lo, res_hi, tmp;
-
-	if (!bias) {
-		res =3D ((uint64_t)m_lo * n_lo) >> 32;
-	} else if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
-		/* there can't be any overflow here */
-		res =3D (m + (uint64_t)m_lo * n_lo) >> 32;
-	} else {
-		res =3D m + (uint64_t)m_lo * n_lo;
-		res_lo =3D res >> 32;
-		res_hi =3D (res_lo < m_hi);
-		res =3D res_lo | ((uint64_t)res_hi << 32);
-	}
-
-	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
-		/* there can't be any overflow here */
-		res +=3D (uint64_t)m_lo * n_hi;
-		res +=3D (uint64_t)m_hi * n_lo;
-		res >>=3D 32;
+	uint64_t x, y;
+
+	/* Determine if overflow handling can be dispensed with. */
+	bool no_ovf =3D __builtin_constant_p(m) &&
+		      ((m >> 32) + (m & 0xffffffff) < 0x100000000);
+
+	if (no_ovf) {
+		x =3D (uint64_t)m_lo * n_lo + (bias ? m : 0);
+		x >>=3D 32;
+		x +=3D (uint64_t)m_lo * n_hi;
+		x +=3D (uint64_t)m_hi * n_lo;
+		x >>=3D 32;
+		x +=3D (uint64_t)m_hi * n_hi;
 	} else {
-		res +=3D (uint64_t)m_lo * n_hi;
-		tmp =3D res >> 32;
-		res +=3D (uint64_t)m_hi * n_lo;
-		res_lo =3D res >> 32;
-		res_hi =3D (res_lo < tmp);
-		res =3D res_lo | ((uint64_t)res_hi << 32);
+		x =3D (uint64_t)m_lo * n_lo + (bias ? m_lo : 0);
+		y =3D (uint64_t)m_lo * n_hi + (uint32_t)(x >> 32) + (bias ? m_hi : 0);
+		x =3D (uint64_t)m_hi * n_hi + (uint32_t)(y >> 32);
+		y =3D (uint64_t)m_hi * n_lo + (uint32_t)y;
+		x +=3D (uint32_t)(y >> 32);
 	}
=20
-	res +=3D (uint64_t)m_hi * n_hi;
-
-	return res;
+	return x;
 }
 #endif
=20
--=20
2.45.2


