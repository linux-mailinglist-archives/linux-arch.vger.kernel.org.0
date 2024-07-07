Return-Path: <linux-arch+bounces-5300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CFB929924
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7461A2810CC
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6D6F312;
	Sun,  7 Jul 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ephEmCz0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="IHnMbrny"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A836BFCA;
	Sun,  7 Jul 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720372773; cv=none; b=ac8WPbzozcC7iPzNL0ecmslFFa6wn/7GcxCNbcFJ8z+/9OZIC1Emxd/h1R+jy2U0saWnSUcjr7Bb0akNThH0DNHVJsDIVaRlhucE4R09b7CzEK2zutyotCl1EnIl8ehbvQrFGq/ZJl4RFpjAVvxh9cYhi2/1IeTipTJ0JPJX2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720372773; c=relaxed/simple;
	bh=/QuuLJC1nxKgKxynXhnQImpEZwtp//wq0C11wSeUgwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QC4Ck94WArlCSkcVKcg2krNQ9vdsJ7p7QUsfV3wQ0ZSiFezGoFIre78L4hs62P4RKkIdB4JndeceMmDSlVVqSfQuxlwfHqaZtBuPRLdGl9MFAVLNoqfwCYqJf7pWeBLIPL3XDsyUp7Wn09JeXsRf+5vDyQjIazlkc2BkOhg50+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ephEmCz0; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=IHnMbrny reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B480E2D823;
	Sun,  7 Jul 2024 13:19:31 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=/QuuLJC1nxKgKxynXhnQImpEZ
	wtp//wq0C11wSeUgwM=; b=ephEmCz0LimOeexEBEfJAUlfodnujXcfDiiGRHBND
	jrRB51LeAr0Dwc1aK21Fb+h+fnxc9DouWRiq66h7yB3gdaBjiT8csqdinTcVFW6U
	iP8b9YHwRcgTK6z7Xz64pIYsKxY2idHM6wDbxA2480LLOe341pAgWpnRghQX1YoJ
	HU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AE2932D822;
	Sun,  7 Jul 2024 13:19:31 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=ywfxdQDukdfVWt5y0bqhjJ6Uf8FKCaBkrknbgBicBmY=; b=IHnMbrnypAD49U6KbEf93hV0EpjAokmpx/Rv8bVqlEeYyea94r17/SquSIRdLaPDmq9DMqVM5aCiMCgm14rHyMKb3SZ4iOWqnZbIVUTu+GBhvCEmd0bIbHdERFvan9pMNEUdMq1stvOa4kD1+q8SZCu5o1OVgD/mezofoKNn2Fc=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADD0F2D81F;
	Sun,  7 Jul 2024 13:19:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 79FAFD3B28E;
	Sun,  7 Jul 2024 13:19:25 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when optimizing for performance
Date: Sun,  7 Jul 2024 13:17:36 -0400
Message-ID: <20240707171919.1951895-5-nico@fluxnic.net>
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
 1085295C-3C85-11EF-858D-C38742FD603B-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Recent gcc versions started not systematically inline __arch_xprod64()
and that has performance implications. Give the compiler the freedom to
decide only when optimizing for size.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm/include/asm/div64.h | 7 ++++++-
 include/asm-generic/div64.h  | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 562d5376ae..3912bf4ce9 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -52,7 +52,12 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_=
t base)
=20
 #else
=20
-static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias=
)
+#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
+static __always_inline
+#else
+static inline
+#endif
+__arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 {
 	unsigned long long res;
 	register unsigned int tmp asm("ip") =3D 0;
diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 5d59cf7e73..25e7b4b58d 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -134,7 +134,12 @@
  * Hoping for compile-time optimization of  conditional code.
  * Architectures may provide their own optimized assembly implementation=
.
  */
-static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, boo=
l bias)
+#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
+static __always_inline
+#else
+static inline
+#endif
+uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
 {
 	uint32_t m_lo =3D m;
 	uint32_t m_hi =3D m >> 32;
--=20
2.45.2


