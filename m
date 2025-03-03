Return-Path: <linux-arch+bounces-10518-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F127A4E70E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B0423C23
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D935207A27;
	Tue,  4 Mar 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlR439wt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJe2RCd5"
X-Original-To: linux-arch@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E329AAF9
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105547; cv=fail; b=EAL+44rI6P4SgcRKew180cFZbXmQgAQcvtlZjf0GqJ7Nx8JIeZAaKtfSfUEIPdCmgsl8tdswCfqrrcZvh86vdExR9EcS/D9nrYPyvaNjfVBcwvlV6itIHY5ZgOoRakuLgjQErGr1Zo0EvTLyZq/RhuVaMbUFiI8Fu2Aea9FQyWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105547; c=relaxed/simple;
	bh=gs8JOJu6ZmaZVQx2GZk60ZIoFTXlhuRL01hkhVS9ceo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+Ah0OhPu/aJYRU5kDV4atl4e65aynA+LwWk+xp6HdWv7aFPLDXVevn9cF/xqwJgRaIj0XFhGW1Dob558D+JmilC/5xeeAN8iOHj+YZ1eFOz5fRIxjF6B2APOnJTkO+nePxYJVOJCXLp7nmPiAeggDVcZGxKAlKRWDp+cwMJ3yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlR439wt reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJe2RCd5; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id DEA3140D9761
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 19:25:42 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KlR439wt;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=OJe2RCd5
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gxk3nsfzG249
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 19:24:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 810164272D; Tue,  4 Mar 2025 19:24:25 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlR439wt;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJe2RCd5
X-Envelope-From: <linux-kernel+bounces-541536-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlR439wt;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJe2RCd5
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id CFDC142E10
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:19:57 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id A5E3E3063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:19:57 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4745F188DD35
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5051C1FECAC;
	Mon,  3 Mar 2025 11:11:24 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC81F872C;
	Mon,  3 Mar 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000279; cv=none; b=pvkbEyQPj7bYSPsoc/i2SMEBxJ6rU1FbQvW7b5jVRhZSkn2cf9CXIZh4Anc2d0jaJcQVOdlR32LHXTH4NMKLMI+K8KOmWiYAzrwHT+PeYMgOzC0bA0wopayasrWFmU2+Sbfoig58V/pLmQpyX9XCTSYtsDSg7TJ/GIydu76KF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000279; c=relaxed/simple;
	bh=XPyN17XUXAloEeVoiXWZIoznMOsHkO0Mpqb+yGaSUvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hbnpt1KETfqgczPeyvwSsVeqEzyxM0oazeg1EnYXKYGLPet6dc2JAYFLaoo9Tsa0ocy9WCNRFzkyVXzkQs567Mi0OOhEHVodXqgZ1w8tgojeCjzBUov+DbigsBgbQPoj+bHCmgv0yRt+aFq5YAwEWVig9uRqA84bOk1VPDCSbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlR439wt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJe2RCd5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUFBByn56mt9Jh1l7bqRrS+uh5r/Oj/pRKH3aZrKn6c=;
	b=KlR439wtCzp63opnm08CadoaqR8EQHOVNMecQAMDWoAhzDLh7N3HFaYn99kLzJu8c/87cj
	PcoK5OuK723FpyvA1wheJacC1EUReOItFr5w8LOb9w/sHZABa3hgKJlcuxaSr+CDU4uT+D
	/qn2O9wbsLkrc6XCAhqsgWL7fVrU+FM1vVAS/8nm3teVQ88wgepBI3arc2dnuMJWrbqyWj
	KC9OcwTcxlJ7E3AzrRjVe6rclqXONGygAdyACYuzkXcNZpM5MhSrWBwE2mLD8rejqUZw+t
	chZE/XpfsyKRUeAtMJM+OeoynYe/mThHbcJcTUYgdHbfzH1s2gaG2zEX8Na8ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUFBByn56mt9Jh1l7bqRrS+uh5r/Oj/pRKH3aZrKn6c=;
	b=OJe2RCd5u100FPp11ThFrMz2Ji9YSpds6cbr1c7c7JF8cnoqMnPMZDMIxaFlYM9gtX2jzU
	VQDwt7hl+t3MYeCw==
Date: Mon, 03 Mar 2025 12:11:13 +0100
Subject: [PATCH 11/19] vdso/gettimeofday: Prepare helper functions for
 introduction of struct vdso_clock
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20250303-vdso-clock-v1-11-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=2810;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=pm5bZvYeNAbEXTS39nRQ8eH42gMxWLNzUgPBgPezn1g=;
 b=FW8VbpGBDOc4gehZB0MHAgjqGugUx9jW+N8jr9fT+S+TPc15+FFXFF/O8gZIvxn8lSHVS+KUE
 MyHS7ULSmBsA61eJvARcZc9prIjVbV+Dg6xv1H+Y8KdITJ/pmkwkb9I
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gxk3nsfzG249
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710288.54547@xk26S5kg6ciV58k8q2gj4w
X-ITU-MailScanner-SpamCheck: not spam

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer argument of the helper functions with struct
vdso_clock pointer if applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 03fa0393645ac0f5ee465ddc19d84b330913da65..c6ff6934558658f9e280d5b84=
cfb034f4828893d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -17,12 +17,12 @@
 #endif
=20
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-static __always_inline bool vdso_delta_ok(const struct vdso_time_data *v=
d, u64 delta)
+static __always_inline bool vdso_delta_ok(const struct vdso_clock *vc, u=
64 delta)
 {
-	return delta < vd->max_cycles;
+	return delta < vc->max_cycles;
 }
 #else
-static __always_inline bool vdso_delta_ok(const struct vdso_time_data *v=
d, u64 delta)
+static __always_inline bool vdso_delta_ok(const struct vdso_clock *vc, u=
64 delta)
 {
 	return true;
 }
@@ -39,14 +39,14 @@ static __always_inline u64 vdso_shift_ns(u64 ns, u32 =
shift)
  * Default implementation which works for all sane clocksources. That
  * obviously excludes x86/TSC.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_time_data *vd,=
 u64 cycles, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_clock *vc, u64=
 cycles, u64 base)
 {
-	u64 delta =3D (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
+	u64 delta =3D (cycles - vc->cycle_last) & VDSO_DELTA_MASK(vc);
=20
-	if (likely(vdso_delta_ok(vd, delta)))
-		return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+	if (likely(vdso_delta_ok(vc, delta)))
+		return vdso_shift_ns((delta * vc->mult) + base, vc->shift);
=20
-	return mul_u64_u32_add_u64_shr(delta, vd->mult, base, vd->shift);
+	return mul_u64_u32_add_u64_shr(delta, vc->mult, base, vc->shift);
 }
 #endif /* vdso_calc_ns */
=20
@@ -58,9 +58,9 @@ static inline bool __arch_vdso_hres_capable(void)
 #endif
=20
 #ifndef vdso_clocksource_ok
-static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
-	return vd->clock_mode !=3D VDSO_CLOCKMODE_NONE;
+	return vc->clock_mode !=3D VDSO_CLOCKMODE_NONE;
 }
 #endif
=20

--=20
2.48.1



