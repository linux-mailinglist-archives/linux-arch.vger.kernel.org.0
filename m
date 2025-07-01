Return-Path: <linux-arch+bounces-12535-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592DAEF233
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E74644512C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754ED271476;
	Tue,  1 Jul 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCdg9J/c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SODPMp3s"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91F26D4EB;
	Tue,  1 Jul 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360293; cv=none; b=poE1eVnr5ffYxd+fwJJfvLYTuFsiiAQNPeHaOUSN8varjZH975h0HtfheqNyhSloRCTpEW0TsIW+3qug2aMGgWMSZe2YO7iefHVo5mxjH+Q10AJk+7/sywEo7MV0Ky/j5PyYL718Thchk347JmA2ty99hcQGwC4dsgecQV9yBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360293; c=relaxed/simple;
	bh=dRtOLc0Ah0kuXXHJncEp4KlW6Rn2+hYOmoEn9rpo9FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N85NzJoW2HRLmO2bG32DywmK9GUKQj6XRmf8EGmPIf3qgLIYRuhu2FqrgvOWyov4X4j/XuPUYAPnDMPOu6ePnkECE37SzeARZl2JgyBhi/8lqB2EP98G6tF+O2PXUtuYMf2BULCSCtUqHD7NoUHqOMY0TBUTwiwUmNes0sysOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCdg9J/c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SODPMp3s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLGlXBLoHCl8iTZFGkpWl+4cLC4fbRbFQ1Cna6OA294=;
	b=hCdg9J/c9E6RT0wp6/DhGRc8l2ths+F2e0C3PVLM5LyMtcRgzSnaJkHkcQPPghkg/XeIpd
	LWGQ7lX3WJUFxu3ek2BvL8C6SIKdZZCnnfAazdnoDGestgjVmLWS7pp8l9vtfnfLKRJCbr
	XJXluEsSZP/mJ3JhmR2CxKsF1IugmZxvxhTTY235Ij3lq6ld4ULlPsfC9olhKlyxHYgWTC
	NEb5IBp538bTUXHNDpo7FJPd/m1D4oK/x4gPmt5lejA0NpMusHSEhEYSIkfUR9IhQqKnXh
	/5nUYmD7mc2ugRKGfjNgNfpa0roYwNLQgrs/CeQU6Hcca6RY3aKTm6HfPSUclw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLGlXBLoHCl8iTZFGkpWl+4cLC4fbRbFQ1Cna6OA294=;
	b=SODPMp3s/oAwW35AK1TnWm29pKng8GpRaNdGr9v2vbfuSLyfCFSWsbW6EBxgbSwh5NqAtV
	LeWbBp4VXN/84xCw==
Date: Tue, 01 Jul 2025 10:58:01 +0200
Subject: [PATCH 07/14] vdso/gettimeofday: Introduce vdso_clockid_valid()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-7-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=1538;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dRtOLc0Ah0kuXXHJncEp4KlW6Rn2+hYOmoEn9rpo9FQ=;
 b=HTm3jtAk7vagm4p603uxzJ6EQojuf/6O5qSR9JWQUCAE793nMRMynN0XVRWXyboEG1fCIAwoE
 4hpXQVIhcWLCO71c9GbNNfwf5IiU8zNqmXABKY3tM0pBQK7mnBSSfn1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With the upcoming addition of auxiliary clocks the clockid validation will
become more complicated. Split it into a dedicated function to keep the
code readable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c5266532a097c06f33d12e345c695357d75abf42..215151bd5a1320ee6edda8f334d47c739577f696 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -71,6 +71,12 @@ static inline bool vdso_cycles_ok(u64 cycles)
 }
 #endif
 
+static __always_inline bool vdso_clockid_valid(clockid_t clock)
+{
+	/* Check for negative values or invalid clocks */
+	return likely((u32) clock < MAX_CLOCKS);
+}
+
 #ifdef CONFIG_TIME_NS
 
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -268,8 +274,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 	const struct vdso_clock *vc = vd->clock_data;
 	u32 msk;
 
-	/* Check for negative values or invalid clocks */
-	if (unlikely((u32) clock >= MAX_CLOCKS))
+	if (!vdso_clockid_valid(clock))
 		return false;
 
 	/*
@@ -405,8 +410,7 @@ bool __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t cloc
 	u32 msk;
 	u64 ns;
 
-	/* Check for negative values or invalid clocks */
-	if (unlikely((u32) clock >= MAX_CLOCKS))
+	if (!vdso_clockid_valid(clock))
 		return false;
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&

-- 
2.50.0


