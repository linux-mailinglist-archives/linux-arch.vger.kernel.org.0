Return-Path: <linux-arch+bounces-5308-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95072929A83
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 03:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73C91C209E8
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 01:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF2515A5;
	Mon,  8 Jul 2024 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="meTRqOFT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="SHjOl6cQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FCFEDC;
	Mon,  8 Jul 2024 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720402076; cv=none; b=rAkdrftkAG68MYDnpXnxrIwa0Pfp87k9h/uhBRtSrljF+Gi9i6Hnrvl5G1o5C3oV+F1+HR621ByIhhDbWYqL1a4xqPNY8A0yGktyTrbxKHWUbnIMgSC+zIhhmW4IPWh6vFZm9snIX+79yfc2xJl1GEnOZgK9F/8MlY913LrRNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720402076; c=relaxed/simple;
	bh=mMSq6t9G/IHT+FHiu7gS6S1bs9WXkhLQQHcvmvK3aeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FboHOIYJStjkdPVZoJxZcTjTzYdLflJ7olR8OL8KjbpGJuM/nfn0CjQmUTMUUZPQ/5/zgTRXmWmBxZs4vngAxmg2NN9mKLhKaAwgeCKoJ59iJ1nJ6/46GOrwHpJHcoGAEHl/qgKLy/ajjT82ToThf/omvcbwA8dCgr45tDLhoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=meTRqOFT; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=SHjOl6cQ reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 56EE81C32E;
	Sun,  7 Jul 2024 21:27:53 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=mMSq6t9G/IHT+FHiu7gS6S1bs
	9WXkhLQQHcvmvK3aeA=; b=meTRqOFTQ4adZjbf+aHnbgQ7DDQERO6fD3xwxwnjo
	Io0OBwzi7kmhMGJ/DucR0zxg+tJYn/AUv3hIm88gcwe+9UKa3D6/qyKn/2biXGoY
	PGixmrt6US0+XH1g1yVSF66f7XSnz25kcdq3u3jb1rxpwcizvwIlnBbGY6+TtBa2
	QQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F5741C32D;
	Sun,  7 Jul 2024 21:27:53 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=/DDnUJ29jmXhWLjJfdTuobMgv2bC3GfpHPNMc0mP3CQ=; b=SHjOl6cQuk0cT2/OlEobDKBbpLvkEwVXDn+OG9hf1NVAu1lw40HWjuPikig7xk1mCGi/nsxYC9X2OL6HKOXwAFNxdZgypvYRYkgwGPYIH447lYogJR+oiTLZ8h6ESwCOeuHnhDQAesmstf2c59w+KtQZLXh2jTnHkaESPGSMjHI=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE5EB1C32A;
	Sun,  7 Jul 2024 21:27:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 93E4ED3BCFF;
	Sun,  7 Jul 2024 21:27:51 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] asm-generic/div64: optimize/simplify __div64_const32()
Date: Sun,  7 Jul 2024 21:27:15 -0400
Message-ID: <20240708012749.2098373-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708012749.2098373-1-nico@fluxnic.net>
References: <20240708012749.2098373-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 4BAAA0C2-3CC9-11EF-B21F-965B910A682E-78420484!pb-smtp2.pobox.com
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


