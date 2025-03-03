Return-Path: <linux-arch+bounces-10502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62AA4BDFF
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CD1164FDB
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA71FCD00;
	Mon,  3 Mar 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbCusKeg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fOvo9r/"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855131F8BAA;
	Mon,  3 Mar 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000280; cv=none; b=S9cmjqW7FGyLKtiNhg1bX21xKFMV7JFXZJgcMedkMJsa7bj4uhmTrddtboPPIikCbsJLCk+kln3b+n9L18kLPyv7JIAxOoWeyh2p3QcoEUUxf+QSZBIldGBphA/V06fwT+MIlQJ3DK3ve255JAhC2/Sbb/69SpvroccYmfva76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000280; c=relaxed/simple;
	bh=ysgS01DaUNRNFmCyqFaIEAFFgwufR+E1yAt/1uNSO8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkhkJSkv9mw+HRllY+c3WSGlN2pBmAqllondoQKVk8gnOdWYJpa69y5vdswwjcBe6MinueK/kNunTHA0ATi11KYB7+BehbiOtJZLYNr6tzYEkVo6MN9ei4EaYvdg4iY8ceg66cKZ0vhrCG57aUNyWfknb0o9mBWLGjd+x3dSkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbCusKeg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fOvo9r/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgB3LhMqOZ+YBkO0ZZD/ZAGt3jgrVFlcoSgeSBFrG1A=;
	b=UbCusKegiY4htXtXb6cmiKpgLftrm8OW6HF0kY4SBA0xVA6X8uBoNc4HcYBYgf3qB7EKjy
	0vnRhbCV99EGmEO9CIOQU5AdcQcMfSuVz/5cfuOEsSLtkpmIdb9tmSJn0nh1ZOEYvHWBXd
	x5ohKq3YewG7wcBF2kCJNgLCwTZ1D8/+mkjUHVAlRsJkask5JVQkRUpUXvBwP5yhscXqaz
	XCh3Z8GjDsSWj8I/uJ8qzqf1Kvs1B2NRxSEdIpg0gcMkgu4ew/f79wpGOjeFlZX68JF+W3
	yzEpHQhM86wPsh+PyaBRXS68MAr6198hI5WbIhM1S9V/TuYtYWMg1LfvvT3P/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgB3LhMqOZ+YBkO0ZZD/ZAGt3jgrVFlcoSgeSBFrG1A=;
	b=1fOvo9r/qH+GjFBoFmV4Mq1GTv7uo31luHW62OlEVNNKdplS0DAqHgugpnuoBkmS+FSCDn
	OTxv7inUt8L/yyCQ==
Date: Mon, 03 Mar 2025 12:11:17 +0100
Subject: [PATCH 15/19] x86/vdso: Prepare introduction of struct vdso_clock
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-15-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=3053;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xyNISseLOTNZW4PPjUER0EQo8UUOOyYEKCLROc72ytc=;
 b=0qWgzjrxn8OGxXIBksBvp9I3CDmpmtrU83qA8jyzdK/S89J9zVZl5lnjSVCXoSYPOtqJjB5z6
 Eds45EkmeVCCIxtaR0ZY0XAX3AF9MFiqoAGHbKfXMXIBaSvGGgd69bM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/include/asm/vdso/gettimeofday.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index edec796832e08b73d6d58bda6408957048f4e80e..9e52cc46e1da99114312d85b34ae52e539dac9b6 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -261,7 +261,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
 	return U64_MAX;
 }
 
-static inline bool arch_vdso_clocksource_ok(const struct vdso_time_data *vd)
+static inline bool arch_vdso_clocksource_ok(const struct vdso_clock *vc)
 {
 	return true;
 }
@@ -300,34 +300,34 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * declares everything with the MSB/Sign-bit set as invalid. Therefore the
  * effective mask is S64_MAX.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_time_data *vd, u64 cycles, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_clock *vc, u64 cycles, u64 base)
 {
-	u64 delta = cycles - vd->cycle_last;
+	u64 delta = cycles - vc->cycle_last;
 
 	/*
 	 * Negative motion and deltas which can cause multiplication
 	 * overflow require special treatment. This check covers both as
-	 * negative motion is guaranteed to be greater than @vd::max_cycles
+	 * negative motion is guaranteed to be greater than @vc::max_cycles
 	 * due to unsigned comparison.
 	 *
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
 	 * arch_vdso_cycles_ok() above), the effective mask is S64_MAX, but that
 	 * case is also unlikely and will also take the unlikely path here.
 	 */
-	if (unlikely(delta > vd->max_cycles)) {
+	if (unlikely(delta > vc->max_cycles)) {
 		/*
 		 * Due to the above mentioned TSC wobbles, filter out
 		 * negative motion.  Per the above masking, the effective
 		 * sign bit is now bit 62.
 		 */
 		if (delta & (1ULL << 62))
-			return base >> vd->shift;
+			return base >> vc->shift;
 
 		/* Handle multiplication overflow gracefully */
-		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vd->mult, base, vd->shift);
+		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vc->mult, base, vc->shift);
 	}
 
-	return ((delta * vd->mult) + base) >> vd->shift;
+	return ((delta * vc->mult) + base) >> vc->shift;
 }
 #define vdso_calc_ns vdso_calc_ns
 

-- 
2.48.1


