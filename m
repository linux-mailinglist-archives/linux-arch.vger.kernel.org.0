Return-Path: <linux-arch+bounces-5297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8B92991E
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289BA1C208C9
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F341C89;
	Sun,  7 Jul 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F2L45G4C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="miDALl0+"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552941A8E;
	Sun,  7 Jul 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720372769; cv=none; b=ScOjA8B1IFf9qx9CHbrZ57P2U/pbUUWKoV5IfOA0B0Q+hbSyTHq3RGX8Fq+shSzhUlhhN3OU2Hn7721zpM2LBXHPLG7F5n8SVSgw7DT4TA8MjaWQFIEoMm7YOxDz+6BE18u6nzZJnkg3v0QGu13/Xl0BR1+FpT282IgZAzdKE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720372769; c=relaxed/simple;
	bh=hh73mRA6cREHc2Vf6iteyClTsDzET6cc5Qu0tN72rs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LibRGxU2sx7mX88qHo/RtvdpOLDZp/tr40+k29FNTZKQJYJXTHj2DQco41J91EajyeLfw0FveRAJURMuQkKdDjVKREG6wU5O3Rhj2fdAMH+CjIFtvmSB7j8EXDXzWx6juDkxRZcXHkMj6EglfVr9Vwoo9WhdCe5vEVvDX4Up70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F2L45G4C; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=miDALl0+ reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C1A81978A;
	Sun,  7 Jul 2024 13:19:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=hh73mRA6cREHc2Vf6iteyClTs
	DzET6cc5Qu0tN72rs0=; b=F2L45G4CZxTWuo1YGKfKfowtYLOAboZPdTxfCg9Dr
	QhGTOEE1DqxY6053EO5lnrgIda66lP5QaNZEDP5S69z3FVfthqvm2p4/dUDvg3XM
	KzhrnGsJnnAYv8gyLuQ5qMShDQw557Wzw+rwyCSHQFI2tYoRjzhJxG7vPZLMK2wb
	FM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 137A019789;
	Sun,  7 Jul 2024 13:19:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=DF+iFCNV9DX0zDm8YrVM8tgrxkkUwPAYjWZ2z/l8CeE=; b=miDALl0+C3dPkfutLI6H90Z/G8vLhL88FRo/lz4B7lVtRQdjTxB3R1oKcQtavPDt0x/l6Meb5iiH2Gd0uBE7mNRd938uInyq0hxQEy5blFfp1CUVX5/V0jrkQkSIZZlS2WON8tknLavatUNszCup1GKXUjT5he8e5dxVXXPNkZs=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7849119788;
	Sun,  7 Jul 2024 13:19:26 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 5F05DD3B28D;
	Sun,  7 Jul 2024 13:19:25 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: div64: improve __arch_xprod_64()
Date: Sun,  7 Jul 2024 13:17:35 -0400
Message-ID: <20240707171919.1951895-4-nico@fluxnic.net>
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
 0FCB80EC-3C85-11EF-86E7-965B910A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Let's use the same criteria for overflow handling necessity as the
generic code.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm/include/asm/div64.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 4b69cf8504..562d5376ae 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -56,6 +56,8 @@ static inline uint64_t __arch_xprod_64(uint64_t m, uint=
64_t n, bool bias)
 {
 	unsigned long long res;
 	register unsigned int tmp asm("ip") =3D 0;
+	bool no_ovf =3D __builtin_constant_p(m) &&
+		      ((m >> 32) + (m & 0xffffffff) < 0x100000000);
=20
 	if (!bias) {
 		asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"
@@ -63,7 +65,7 @@ static inline uint64_t __arch_xprod_64(uint64_t m, uint=
64_t n, bool bias)
 			: "=3D&r" (res)
 			: "r" (m), "r" (n)
 			: "cc");
-	} else if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
+	} else if (no_ovf) {
 		res =3D m;
 		asm (	"umlal	%Q0, %R0, %Q1, %Q2\n\t"
 			"mov	%Q0, #0"
@@ -80,7 +82,7 @@ static inline uint64_t __arch_xprod_64(uint64_t m, uint=
64_t n, bool bias)
 			: "cc");
 	}
=20
-	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
+	if (no_ovf) {
 		asm (	"umlal	%R0, %Q0, %R1, %Q2\n\t"
 			"umlal	%R0, %Q0, %Q1, %R2\n\t"
 			"mov	%R0, #0\n\t"
--=20
2.45.2


