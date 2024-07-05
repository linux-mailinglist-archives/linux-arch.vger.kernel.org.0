Return-Path: <linux-arch+bounces-5276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AE5928065
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 04:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F4C2841F6
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD9D17995;
	Fri,  5 Jul 2024 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="blOwK4DO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Qup5kK99"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F268171BB;
	Fri,  5 Jul 2024 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146269; cv=none; b=BaPFJ62BfyeO0YRYR+2JWAgmzzsbAausLMSKnmh8Q3iDudTIxhQzY2PKnp8dJVKUkG/EqiKLDPFWWpbnxG9vs44JlU28VUHI4yeTuJ/bre4fxbhsIfHVgyysHppsJLn02RhcJCD+wYzKWUauvzGLISQh9HIxT5QefpYMIaN8y28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146269; c=relaxed/simple;
	bh=07LCEtp0Flmh6rOuWMY5fE00GlqWnZG1Ro+zSOWdKCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7rqq/KTCyj6kb9bb/fojugqB8Yr9G1Ghlb1X9dTZFweFrO1VhwzCtjZoLygwJUUZSYyKsd03IZV2QuUFvX0kma/FerLOyXgPx5+tjRBKsdASBXS55wl2o76eEpK17RFZcC0YOs/UZO2F5LchnsIrLvfF5xHzoOMRkf8y7oI33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=blOwK4DO; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Qup5kK99 reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0488C1DF53;
	Thu,  4 Jul 2024 22:24:22 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=07LCEtp0Flmh6rOuWMY5fE00G
	lqWnZG1Ro+zSOWdKCM=; b=blOwK4DOqZHdlSQcPG3Q2j2QpkBpYpLYwXspUr23T
	gE20GaCqHgq8Q/U21g0BiEB60htrceSgd3CV+aK684X/BsnRXGVoqCNVIlMULU6f
	XQMe+KfVuvOyFBPC1+Bt6nxh64SpUyhugFIRKvINHXi7OK1XCazksNOFBmGgN5St
	uI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F0AB41DF52;
	Thu,  4 Jul 2024 22:24:21 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=0Yw/pYnIc0k8ImJRiHZ7qTYic9zc+p3Q+HSBMVQGCiI=; b=Qup5kK998eq40TlTTSzKfXahTeEEutFl18f/ZtnkMVAv9kzO+YqwxTlGT0jHbx1vDo+nZKiKEQSFWrC2gPw9eyTWonmYz/pGq1R5kUCXw+AnGo0jW2pYaXtuePZ30lXT2AVtw95WYw3W67mfZTc+G9FBqOR12yY4v7wUqIA+gr0=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 088A31DF34;
	Thu,  4 Jul 2024 22:24:18 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C2707D35BC7;
	Thu,  4 Jul 2024 22:24:15 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: div64: remove custom __arch_xprod_64()
Date: Thu,  4 Jul 2024 22:20:28 -0400
Message-ID: <20240705022334.1378363-2-nico@fluxnic.net>
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
 AE3B9198-3A75-11EF-B426-DFF1FEA446E2-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Turns out that the compiler does a better job with the generic C version
these days. In any case, an even better generic implementation is
coming next, making this code doubly obsolete.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm/include/asm/div64.h | 52 ------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 4b69cf8504..99b80db595 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -52,58 +52,6 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_=
t base)
=20
 #else
=20
-static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias=
)
-{
-	unsigned long long res;
-	register unsigned int tmp asm("ip") =3D 0;
-
-	if (!bias) {
-		asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"
-			"mov	%Q0, #0"
-			: "=3D&r" (res)
-			: "r" (m), "r" (n)
-			: "cc");
-	} else if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
-		res =3D m;
-		asm (	"umlal	%Q0, %R0, %Q1, %Q2\n\t"
-			"mov	%Q0, #0"
-			: "+&r" (res)
-			: "r" (m), "r" (n)
-			: "cc");
-	} else {
-		asm (	"umull	%Q0, %R0, %Q2, %Q3\n\t"
-			"cmn	%Q0, %Q2\n\t"
-			"adcs	%R0, %R0, %R2\n\t"
-			"adc	%Q0, %1, #0"
-			: "=3D&r" (res), "+&r" (tmp)
-			: "r" (m), "r" (n)
-			: "cc");
-	}
-
-	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
-		asm (	"umlal	%R0, %Q0, %R1, %Q2\n\t"
-			"umlal	%R0, %Q0, %Q1, %R2\n\t"
-			"mov	%R0, #0\n\t"
-			"umlal	%Q0, %R0, %R1, %R2"
-			: "+&r" (res)
-			: "r" (m), "r" (n)
-			: "cc");
-	} else {
-		asm (	"umlal	%R0, %Q0, %R2, %Q3\n\t"
-			"umlal	%R0, %1, %Q2, %R3\n\t"
-			"mov	%R0, #0\n\t"
-			"adds	%Q0, %1, %Q0\n\t"
-			"adc	%R0, %R0, #0\n\t"
-			"umlal	%Q0, %R0, %R2, %R3"
-			: "+&r" (res), "+&r" (tmp)
-			: "r" (m), "r" (n)
-			: "cc");
-	}
-
-	return res;
-}
-#define __arch_xprod_64 __arch_xprod_64
-
 #include <asm-generic/div64.h>
=20
 #endif
--=20
2.45.2


