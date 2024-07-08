Return-Path: <linux-arch+bounces-5310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948F929A87
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 03:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217081F20EC3
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 01:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345EB8C06;
	Mon,  8 Jul 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gvj0owoX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="x0OiMEcH"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D86FB6;
	Mon,  8 Jul 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720402080; cv=none; b=AIFPza1FFNX40shsalWVCw63IuSBBeMSAEl0saXHhlC4HJjiwQI84FWIR6pV5LFzhdycH6iqqvtyg3wGDmfvInED+NW8yGL2bJOLfFqZxZgzLG+osO8apDbfYnwufrQkJVdtCavuFA6msf5gYe4gLGHp1+uVXI+90GgdYyM3cJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720402080; c=relaxed/simple;
	bh=Iyvob8m8hAMZg2VcQl4+cqFXaOixCxGCDjPNS+xXtA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwDmnpMwxMZx0dFO0fyBtMCMnxQ/ixKOU5SYAzRrmE2lXlLvN0G5c8wtG+8eqUkjVP3zkojKlnLS6Rqt5SxiU8q2SpVaS0pJ2c/Gk+7VYAa4lafY3NMehvcj5EiivjjsJYeAuM9VNjLRHcYiXQKL9W8HeLLHuLaaPP432rp8/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gvj0owoX; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=x0OiMEcH reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E428305DB;
	Sun,  7 Jul 2024 21:27:58 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Iyvob8m8hAMZg2VcQl4+cqFXa
	OixCxGCDjPNS+xXtA0=; b=gvj0owoXvgJ/AWD9YLb5O6zh/aP34x2boQEKEr0fr
	e7fShveWOlCMLQXXd9XXRMNcZEQuaQdCAfv7Wnvd1ppEZ8/OV9KIXoRy743d8QBC
	a0+2ZE7n1ndxyYabI+sDzuHfPHw9YWMPiCuaxdrqxq3meFZgmBi9QpenYr8G+YWI
	Kc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 26B77305DA;
	Sun,  7 Jul 2024 21:27:58 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=KdayDt3ACE2onXUdriUt4N9A11pw6subhbTj7vBnMBM=; b=x0OiMEcHoWb9lyqZmA/bg8DZTtvYY11LUkLJRq8dvK2HV0+3zbSF0AyhFRc4HHT59qDN/gd2JNki+E0uBXszwVUU4ZVIecv5CBbQPVZdL/4nmANuDiubFQYkd8bCSKW4cnn/xLsiExCBhd1p9p/uTAuy2/n3uiU7ZHqvznCWp34=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1FA54305D7;
	Sun,  7 Jul 2024 21:27:54 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id CF290D3BD02;
	Sun,  7 Jul 2024 21:27:51 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] __arch_xprod64(): make __always_inline when optimizing for performance
Date: Sun,  7 Jul 2024 21:27:17 -0400
Message-ID: <20240708012749.2098373-5-nico@fluxnic.net>
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
 4C81F428-3CC9-11EF-B11A-C38742FD603B-78420484!pb-smtp20.pobox.com
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
index 562d5376ae..d3ef8e416b 100644
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
+uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
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


