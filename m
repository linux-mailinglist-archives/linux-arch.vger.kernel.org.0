Return-Path: <linux-arch+bounces-5275-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E09928063
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 04:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B630D1F213A2
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 02:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE301CFBD;
	Fri,  5 Jul 2024 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cTq1sDl2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="uyHaKsas"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63F1C6A0;
	Fri,  5 Jul 2024 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146265; cv=none; b=aHQycCrugsUKpMBTIAdypptTVeasC/fzuGTb9GRnJ7fptMyr/3+hCvmPSIwVdUEd63t8VmRMSsqB/gcwCMXh7cl6oV4Zz3haZC2jRBbeQKeUX1lEP1EHcVfDvpYo/YVHIXnRceq77qEYwH26iMR4gt/6V7Fa+XLUX9kRPcl7W24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146265; c=relaxed/simple;
	bh=BPtHtssKC+1i4DS8SCUATlxLEC97OIwXA/OFjIpxlA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGJO2ukZULw7Hg0+fQdlR9D8Xidy6U4ydQxMmOCtOOUT10P1A+pBTRMwSsNM9DwcaeVURLNQe5VET7bOQ8tp3RZHJ9bUmxDzo7XDM0Zhb44wK0jZi7Z1tO2dQVLL/2kqfIpAU838KckOCmks5IxAeud6Lvk4m30VO2whlvGlCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cTq1sDl2; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=uyHaKsas reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7895825C38;
	Thu,  4 Jul 2024 22:24:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=BPtHtssKC+1i4DS8SCUATlxLE
	C97OIwXA/OFjIpxlA0=; b=cTq1sDl2A7h7DhfwnrRsB5UXwpShOjZudi7uxQs4Z
	VRZcYBNHc2Y2tI/VSuKlpX79hE73C0NUlLKvUrjwVJlN0FItnBGGJcXSvNxkreDO
	QBN/jk160v7gj7ySrixBTbKjc5emqLzfQFH6LihJWhCsaqMRlh6JXSNDiFhf9SZS
	DE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70A4925C37;
	Thu,  4 Jul 2024 22:24:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=44C7JymEpRu1mhBgVxs4hSKFrsGMtYFB5SMzb/CkiN8=; b=uyHaKsas4INk5gmioWqSbOuzV5fe08iJKBvWhsKwbLUdnUu4MJOzuX1WyXW4r8UvXoHC1ez7oT96DytbhopcjHkp/nYX/WLq6JQEDLeV+0LAsP/+yQqFDLDlTD2kWMXi9gaXzh+1jmLNyNFTMPSrHhN06bY2Ml9wQtkL5OFq7bM=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8AEF25C36;
	Thu,  4 Jul 2024 22:24:16 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id D24F4D35BCA;
	Thu,  4 Jul 2024 22:24:15 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] asm-generic/div64: reimplement __arch_xprod64()
Date: Thu,  4 Jul 2024 22:20:29 -0400
Message-ID: <20240705022334.1378363-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705022334.1378363-1-nico@fluxnic.net>
References: <20240705022334.1378363-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 AD9680CC-3A75-11EF-A0F5-965B910A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Several years later I just realized that this code could be optimized
and more importantly simplified even further. With some reordering, it
is possible to dispense with overflow handling entirely and still have
optimal code.

There is also no longer a reason to have the possibility for
architectures to override the generic version. Only ARM did it and these
days the compiler does a better job than the hand-crafted assembly
version anyway.

Kernel binary gets slightly smaller as well. Using the ARM's
versatile_defconfig plus CONFIG_TEST_DIV64=3Dy:

Before this patch:

   text    data     bss     dec     hex filename
9644668 2743926  193424 12582018         bffc82 vmlinux

With this patch:

   text    data     bss     dec     hex filename
9643572 2743926  193424 12580922         bff83a vmlinux

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 include/asm-generic/div64.h | 105 +++++++++++-------------------------
 1 file changed, 31 insertions(+), 74 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 13f5aa68a4..0741c2b003 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -116,98 +116,55 @@
 		___m =3D (~0ULL / ___b) * ___p;				\
 		___m +=3D ((~0ULL % ___b + 1) * ___p) / ___b;		\
 	} else {							\
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
+		/* Reduce m / p */					\
+		___p /=3D (___m & -___m);					\
+		___m /=3D (___m & -___m);					\
 		/* No bias needed. */					\
 		___bias =3D 0;						\
 	}								\
 									\
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
-	___res =3D __arch_xprod_64(___m, ___n, ___bias);			\
+	___res =3D __xprod_64(___m, ___n, ___bias);			\
 									\
 	___res /=3D ___p;							\
 })
=20
-#ifndef __arch_xprod_64
 /*
- * Default C implementation for __arch_xprod_64()
- *
- * Prototype: uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, boo=
l bias)
  * Semantic:  retval =3D ((bias ? m : 0) + m * n) >> 64
  *
  * The product is a 128-bit value, scaled down to 64 bits.
- * Assuming constant propagation to optimize away unused conditional cod=
e.
- * Architectures may provide their own optimized assembly implementation=
.
  */
-static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, boo=
l bias)
+static inline uint64_t __xprod_64(const uint64_t m, uint64_t n, bool bia=
s)
 {
-	uint32_t m_lo =3D m;
-	uint32_t m_hi =3D m >> 32;
-	uint32_t n_lo =3D n;
-	uint32_t n_hi =3D n >> 32;
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
-	} else {
-		res +=3D (uint64_t)m_lo * n_hi;
-		tmp =3D res >> 32;
-		res +=3D (uint64_t)m_hi * n_lo;
-		res_lo =3D res >> 32;
-		res_hi =3D (res_lo < tmp);
-		res =3D res_lo | ((uint64_t)res_hi << 32);
-	}
-
-	res +=3D (uint64_t)m_hi * n_hi;
-
-	return res;
-}
+	union {
+		uint64_t v;
+		struct {
+#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
+			uint32_t l;
+			uint32_t h;
+#elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
+			uint32_t h;
+			uint32_t l;
+#else
+#error "unknown endianness"
 #endif
+		};
+	} A, B, X, Y, Z;
+
+	A.v =3D m;
+	B.v =3D n;
+
+	X.v =3D (uint64_t)A.l * B.l + (bias ? m : 0);
+	Y.v =3D (uint64_t)A.l * B.h + X.h;
+	Z.v =3D (uint64_t)A.h * B.h + Y.h;
+	Y.v =3D (uint64_t)A.h * B.l + Y.l;
+	Z.v +=3D Y.h;
+
+	return Z.v;
+}
=20
 #ifndef __div64_32
 extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
--=20
2.45.2


