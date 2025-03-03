Return-Path: <linux-arch+bounces-10512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BF2A4E1B8
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEEB3A6466
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5364B276042;
	Tue,  4 Mar 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2En2gryv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMJ9NStB"
X-Original-To: linux-arch@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683B271830
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098765; cv=fail; b=AZo+V+KtiFXstj6byg9cTJ7Y+mzJm8iyrduwHo2sgQS9NI63Gxk3OexsYOsv2kdlxoKtQQSYPZK33hHUEai9+1SuUR+btCaa8x249cYyZx9YufGVX4XlmTuZKAoCWdPwgaVo1ByiPPnz8nywvuPqWMLzIPePeMbgDQ7r8c6BQf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098765; c=relaxed/simple;
	bh=1jbKuDB2Sd1BY+GwAXdyPGIMXMlIICQZdnrS0z1FLfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SENL7nw03QNcvQWfHDxotwq8mT5+nNUm9INctr0GBE+s1SNBQ4P5NKpv06y42ODew21zap4Q5JGurlWMyX3Pextw9bZmnex0T4fvN3eTo5Sw5HYe6wpYlmrYTwdy6LsHaCRSlfKhGTN3y9hLWet7MFEPU2ut6UrUIOBTNnk3uFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2En2gryv reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMJ9NStB; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id D45AC40D91AE
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 17:32:41 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dPs2WLczFwDy
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 17:30:25 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B513642750; Tue,  4 Mar 2025 17:30:16 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2En2gryv;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMJ9NStB
X-Envelope-From: <linux-kernel+bounces-541526-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2En2gryv;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMJ9NStB
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1861A429F8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:17:47 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id BF6ED3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:17:46 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3D172BF1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734A1F754E;
	Mon,  3 Mar 2025 11:11:16 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F7C1EB192;
	Mon,  3 Mar 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000272; cv=none; b=ciaIpP8uZZcNP61b9gR72t7JBGGyQIvE1tlGEfG6NEATMrUiZT1NyE4eE3pPkTOmj2jRoAaTfo3IlIo4ik/HQtgA5RpVxteb8DaPf0IlwCiY+gQyKTYUvGVbDHoifJzIl2TEDynChiO69HdLQE/4UkuLwsSe+ok43mfXtFTPlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000272; c=relaxed/simple;
	bh=qO63nBGsfFZGS5UvPElZMjXJL0LBJQSO8+qHJeKx1PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEi24MOtMqnNn6mG7CnG3v7rYkMUlE+oJS4/ZHa75TcrEVkC+JEVHX43qtkJyg5pJP75kSlf+VU4scZ3bVlpe8mHAHRbAgh9mIZ1/ayFT2WvCpWBOsJIPjMwQbKWS9Ys5OmdQ0RuoR1P7bPSf3hQQQaBHecKxWUlW+nXw0HniWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2En2gryv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMJ9NStB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uY4A0H+/yXHEBsdmbGCdTr/QiTwADD1cYzSVXD6cRGg=;
	b=2En2gryv8KFjGlwpTPafhFfDRNSmhcpEmGQwq4W1X7xGPlQYEGfajgK4J23nkcTFzAsH3G
	nerhaf4T8jW/arCzkNVebRrc38yLVH5FsQp8gTCI0Y5Zz2yQdXK6bzfq18+x+qSd85H881
	yDFM0kX98uWCtQinDsrdW75dsCehjZahArgBH2ODjHERe7NpIfLTkdG8Y0ejPtI+cwbK5y
	wC2p9FgP76oe+11PqrzQAnJqsbZ1TUHoP8trE7DEXNSjW4L26zpyRlMOkzd1VhH8ocEiXE
	SH4zl5jNdRNhxKoz/EtsTDyC8/Im56SYE1emomuTD7+ZMWAVgSFPwAzMO9B1sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uY4A0H+/yXHEBsdmbGCdTr/QiTwADD1cYzSVXD6cRGg=;
	b=fMJ9NStByy0aoH300sXCDuvSmTKmPwN9oRCy+0LoPVQKid/pIMStDs5YY5V5hqyqvvSvkh
	RgcXpGDAy62Y4ZAQ==
Date: Mon, 03 Mar 2025 12:11:04 +0100
Subject: [PATCH 02/19] arm64: Make asm/cache.h compatible with vDSO
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20250303-vdso-clock-v1-2-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
In-Reply-To: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=1100;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qO63nBGsfFZGS5UvPElZMjXJL0LBJQSO8+qHJeKx1PI=;
 b=EaqHkujR1rhytCCyC8BgQ0toXrLScUCDuVyGkAIyqqU3O/xruMDXNDdz9/q3f+NSwc3DVeTt7
 ZebywgTu1j6Amvsjq9J9UOSZovWCSoRrcwqe8z8X/2EK+MCrQmt4c3V
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dPs2WLczFwDy
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703461.48796@wJDDR79H7BarJkzR0moD0Q
X-ITU-MailScanner-SpamCheck: not spam

asm/cache.h can be used during the vDSO build through vdso/cache.h.
Not all definitions in it are compatible with the vDSO, especially the
compat vDSO.
Hide the more complex definitions from the vDSO build.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cach=
e.h
index 06a4670bdb0b9b7552d553cee3cc70a6e15b2b93..99cd6546e72e35cfbceec7ce0=
a0f64498dfadd38 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -35,7 +35,7 @@
 #define ARCH_DMA_MINALIGN	(128)
 #define ARCH_KMALLOC_MINALIGN	(8)
=20
-#ifndef __ASSEMBLY__
+#if !defined(__ASSEMBLY__) && !defined(BUILD_VDSO)
=20
 #include <linux/bitops.h>
 #include <linux/kasan-enabled.h>
@@ -118,6 +118,6 @@ static inline u32 __attribute_const__ read_cpuid_effe=
ctive_cachetype(void)
 	return ctr;
 }
=20
-#endif	/* __ASSEMBLY__ */
+#endif /* !defined(__ASSEMBLY__) && !defined(BUILD_VDSO) */
=20
 #endif

--=20
2.48.1



