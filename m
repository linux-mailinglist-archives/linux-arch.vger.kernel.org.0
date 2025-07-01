Return-Path: <linux-arch+bounces-12531-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C901AEF21F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC02441F18
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06B26C3B6;
	Tue,  1 Jul 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="krhzk1D7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmufFQQ4"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23B26A0B3;
	Tue,  1 Jul 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360290; cv=none; b=U45tuArxaDw6vJtmIHmD6GYd4DCgAJcylUiIpyOGsmIvECxGcw8QJ6PFxMLQCfUGUkbXiOzngjzYW1TToZvLonnc3/ThiqruK7RUDHr2RpOVwAx4rYuW+4EhjNROQhdWP1hz9EN4akgf8WjLQWDxsmYbf3gc7GQVynX9xTc+D3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360290; c=relaxed/simple;
	bh=sd/v7cGkj/tjrSz2ZYvXIB3XB5Mae2DoLyqaD2YDD50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dtxwwjd2Rtjunz4+2jkUX6y/1+8YcXSXp5avR1rvTbPbEnVwNkQhv4lDXmWvh2eDivVtwRqiXdb7GzgmGYe6PzyxRyQc7rANsH2+iO7t4pUWNcqb21h2scklIGiTPN5VKNnQQ9UMebkeMJ/Wa1FjP569n+CNnosCLBw/xCgugu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=krhzk1D7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmufFQQ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joYJ/MT5CmKtbgnKXRG/YOnvLpHO2Kz90MtG4Gjijrg=;
	b=krhzk1D7lMKjKujXnkLtewos+ZEzFtnviygSNaOH81NLdcFvKN/5rDRHKcXOviJlF3+ScF
	sSILpbPEvg02UQ1tMXjR5TaSdR/FfpEQQqNmxduF9+Ik3MltL4gtmiTPuYMBbT6NeHj/05
	A3uixZ4X0oVqt3aL+jlBkOEGFbdSJvTlpGtuHIpX7MX93qQdlwlv1aQSBYGRWGbiXcqsmQ
	g2Dgs2/mnFTJpWcmNXUDJaA+lnr+OK6wH5Ml/yKwi7detYOtAGVs/lDEe9ZV8sPaucJVAh
	BBwMxWYo4/YRtsZk1pdnC/QcBBaBwHLByplJSYT7HkirgcFaobHSVwpbFaWTrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joYJ/MT5CmKtbgnKXRG/YOnvLpHO2Kz90MtG4Gjijrg=;
	b=xmufFQQ4bBO6kk1ikyfHdIQHNbO5pST5YTXQizxVBEE+zeJrwv081AC82PS6mNifoki68y
	WZNpjH/czo0tVLAg==
Date: Tue, 01 Jul 2025 10:57:58 +0200
Subject: [PATCH 04/14] vdso/helpers: Add helpers for seqlocks of single
 vdso_clock
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-4-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
In-Reply-To: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher Hall <christopher.s.hall@intel.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Werner Abt <werner.abt@meinberg-usa.com>, 
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=2571;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sd/v7cGkj/tjrSz2ZYvXIB3XB5Mae2DoLyqaD2YDD50=;
 b=xHNJy1mqucZQ/T+0vCZcI6A5yV4d5Wm2CvBT6moVq8zEmS9PmdFRxsLmxUq/vJzGB524dlpsL
 qipcU3XvOpkCtiYJVJhEl2zHKlPnzAMS3lIQiV9mGiAkdtMch9Ht/rp
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Auxiliary clocks will have their vDSO data in a dedicated 'struct vdso_clock',
which needs to be synchronized independently.

Add a helper to synchronize a single vDSO clock.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/helpers.h | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 0a98fed550ba66a84a620fbbd6aee3e3029b4772..a5679f5efdfdcaaf6efd5f4a317d1f132c3dc617 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -28,32 +28,46 @@ static __always_inline u32 vdso_read_retry(const struct vdso_clock *vc,
 	return seq != start;
 }
 
-static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
+static __always_inline void vdso_write_begin_clock(struct vdso_clock *vc, bool last)
 {
-	struct vdso_clock *vc = vd->clock_data;
-
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
-	 * updates to vd[x].seq and it is possible that the value seen by the
+	 * updates to vc->seq and it is possible that the value seen by the
 	 * reader is inconsistent.
 	 */
-	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
-	smp_wmb();
+	WRITE_ONCE(vc->seq, vc->seq + 1);
+
+	if (last)
+		smp_wmb();
 }
 
-static __always_inline void vdso_write_end(struct vdso_time_data *vd)
+static __always_inline void vdso_write_end_clock(struct vdso_clock *vc, bool first)
 {
-	struct vdso_clock *vc = vd->clock_data;
+	if (first)
+		smp_wmb();
 
-	smp_wmb();
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
-	 * updates to vd[x].seq and it is possible that the value seen by the
+	 * updates to vc->seq and it is possible that the value seen by the
 	 * reader is inconsistent.
 	 */
-	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
+	WRITE_ONCE(vc->seq, vc->seq + 1);
+}
+
+static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
+{
+	struct vdso_clock *vc = vd->clock_data;
+
+	vdso_write_begin_clock(&vc[CS_HRES_COARSE], false);
+	vdso_write_begin_clock(&vc[CS_RAW], true);
+}
+
+static __always_inline void vdso_write_end(struct vdso_time_data *vd)
+{
+	struct vdso_clock *vc = vd->clock_data;
+
+	vdso_write_end_clock(&vc[CS_HRES_COARSE], true);
+	vdso_write_end_clock(&vc[CS_RAW], false);
 }
 
 #endif /* !__ASSEMBLY__ */

-- 
2.50.0


