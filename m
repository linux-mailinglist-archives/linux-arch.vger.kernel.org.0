Return-Path: <linux-arch+bounces-5309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D41929A86
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 03:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD772810F9
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C608493;
	Mon,  8 Jul 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nr//5ujV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="07PyNHYO"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D16AAD;
	Mon,  8 Jul 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720402079; cv=none; b=aZf3ayDpO7vsqq9lFoGboLxAbQ8RGVzzUhHY0wrznKEy/CBoLSCx2pVNziGlKTo/kK68f9Cxh5G4zPFwC621xDo0S4xPtrjOJbcfNYWUqpdYP1miekxKzd8D7DlFCE3Ta33Y3Us0s6+GqA9hfWTAyBxUcPdon3tNE7Ac34MDawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720402079; c=relaxed/simple;
	bh=hh73mRA6cREHc2Vf6iteyClTsDzET6cc5Qu0tN72rs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+lPkMkVfz21oeHtWTc0yundxn7QKTqLJWdfX2xSdW2qGVcANhwXNDnpOxphnqJdmt/wj6Rt0k4VdX7DMb6LoSNF6stpyh9TQoFxLIRVWGTKiwMx2dB/ln2IvNOo5nJbTuRgTgKIBpGhxEPJ0jApAF743TdnGjuu78+LIKgiqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nr//5ujV; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=07PyNHYO reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B77C35315;
	Sun,  7 Jul 2024 21:27:58 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=hh73mRA6cREHc2Vf6iteyClTs
	DzET6cc5Qu0tN72rs0=; b=nr//5ujVi78/L3ehXFYkmKkQjz+5/N6QEm/nuNxC9
	BCIg/qzZwFgFXJyNKcKXEI/Hzt6sO6XJI4rYb6okAcxK1J7iTCHkvBE+LZ8elsHj
	TGeSnEc+jAuDJYzU6U0s+pqSyeb5i9h8jNBImIwaW39FHUtfQvq9LwT9WnAB1NiA
	0o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 13CA135314;
	Sun,  7 Jul 2024 21:27:58 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=DF+iFCNV9DX0zDm8YrVM8tgrxkkUwPAYjWZ2z/l8CeE=; b=07PyNHYO/+uriSTQJj65HV4f9hrSf76zUgiHPwbUMnBMjIRUW8hHnpvnwPF7WeX+WOwLxckxKh8Ez5wr1Rae9ONblNbBVeCLSawsVFJW9h5Ab2PMxS0OGm847s0YJtoZGs+/9z6wqul1onibCy1duV8Z2ppx/a6oMjhmbQ+IlXM=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 037F53530F;
	Sun,  7 Jul 2024 21:27:54 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id B35D1D3BD01;
	Sun,  7 Jul 2024 21:27:51 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] ARM: div64: improve __arch_xprod_64()
Date: Sun,  7 Jul 2024 21:27:16 -0400
Message-ID: <20240708012749.2098373-4-nico@fluxnic.net>
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
 4C705696-3CC9-11EF-83C3-DFF1FEA446E2-78420484!pb-smtp21.pobox.com
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


