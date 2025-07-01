Return-Path: <linux-arch+bounces-12538-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEE1AEF22C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2464A223D
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86644272816;
	Tue,  1 Jul 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bYXsA4Vm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUAZLmGC"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67709270EC5;
	Tue,  1 Jul 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360294; cv=none; b=SpTfuAiNB8p+3fXbpLoHk2mkZ+DlNnwf8DH8gMqiGe0OVqUKF3kJOaKyT4zCkgOJNnXl8fohfKCspxzYKrThX002jHUF31Of3gD7aS/gGSfmdpiGcaOIm4aKIsshOLUseKStWgwQ8geRzlT05KHXQgrzYRE6+qi93CEBGbhGTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360294; c=relaxed/simple;
	bh=0gcdrnEsMPGXM7V1cQMwcYqk1YZH4nLzPxPwfGW0xR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0UpsKZWRsx8jzADzOCkKoRpzthScC5VSxHwglhigtRNNZS3mnYkNKeCfXm2I3zCHJoNUfOSuq4HuDpyU3t8TXK6nb0IwMw3v+BO+AdC8ZlfUFS/2UsmAnJlPpwUqb+ynLxsghEZxoIVX34KSsRWzQt3dGg70Zizrqd2cS+Gfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bYXsA4Vm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUAZLmGC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppCsL5OVpZ0yuAtg6csvrRyWQ6LdTuXSpwMAtwV+V0Y=;
	b=bYXsA4VmsKOFmUrNashY+TPxEK36HHs4Y1/tS2ESFs1Sa90DCYM6pLwrbgoJjLO9Yshy+E
	cdk0CYyPuvhpLBR7Y0A+DlWZQHPQSlGG/J9v8CDbIplQiFtQfl69euvkbceuSZ6/gOyv3D
	LeqjJBv/x3eKsgi35z8qXD7dUsYUyRboPPfq07V+n5/u6MPqzpLvTOYNTzjaMkCWOOV3FK
	4wCX5/sLqv0t1UbLTMX6VPn6Is9LA1QB4JKytwxEP2A1fYNXPlqbsEVBOA58ednTEaW66I
	XC1RZs82INjio8hSj3u0el7uaWbzFkkzJ74lx5EDuRzdsUVXaXe8E9i1wked1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppCsL5OVpZ0yuAtg6csvrRyWQ6LdTuXSpwMAtwV+V0Y=;
	b=FUAZLmGC+2tmC8OKCBX9MqhPAG/d2/zbiiyE0dF93F/Iph1Ozm1GlEk02gT6NQSgN4PusN
	jI73TlfCOkkGPbCg==
Date: Tue, 01 Jul 2025 10:58:03 +0200
Subject: [PATCH 09/14] vdso/gettimeofday: Introduce vdso_get_timestamp()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-9-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=3113;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0gcdrnEsMPGXM7V1cQMwcYqk1YZH4nLzPxPwfGW0xR8=;
 b=IVyUepdPhAMRvqhjIat4Jqx5hEP07rmKNZAocQkuDF92onJqNyNB/RxoxLX8R4u71m9CiGGyF
 mM3B4kOZaFfA1deox2uLdBFZiKv83hAOc9ObMZimXUM26NGMOQTuH9L
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This code is duplicated and with the introduction of auxiliary clocks will
be duplicated even more.

Introduce a helper.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 50611ba28abfcfc7841616e8787101ea1ffcb7d8..c383878bb5445a62d8fea6591e8550183852c2e6 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -87,6 +87,26 @@ static __always_inline void vdso_set_timespec(struct __kernel_timespec *ts, u64
 	ts->tv_nsec = ns;
 }
 
+static __always_inline
+bool vdso_get_timestamp(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+			unsigned int clkidx, u64 *sec, u64 *ns)
+{
+	const struct vdso_timestamp *vdso_ts = &vc->basetime[clkidx];
+	u64 cycles;
+
+	if (unlikely(!vdso_clocksource_ok(vc)))
+		return false;
+
+	cycles = __arch_get_hw_counter(vc->clock_mode, vd);
+	if (unlikely(!vdso_cycles_ok(cycles)))
+		return false;
+
+	*ns = vdso_calc_ns(vc, cycles, vdso_ts->nsec);
+	*sec = vdso_ts->sec;
+
+	return true;
+}
+
 #ifdef CONFIG_TIME_NS
 
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -104,28 +124,20 @@ bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *
 	const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs = &vcns->offset[clk];
 	const struct vdso_clock *vc = vd->clock_data;
-	const struct vdso_timestamp *vdso_ts;
-	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
+	u64 ns;
 
 	if (clk != CLOCK_MONOTONIC_RAW)
 		vc = &vc[CS_HRES_COARSE];
 	else
 		vc = &vc[CS_RAW];
-	vdso_ts = &vc->basetime[clk];
 
 	do {
 		seq = vdso_read_begin(vc);
 
-		if (unlikely(!vdso_clocksource_ok(vc)))
-			return false;
-
-		cycles = __arch_get_hw_counter(vc->clock_mode, vd);
-		if (unlikely(!vdso_cycles_ok(cycles)))
+		if (!vdso_get_timestamp(vd, vc, clk, &sec, &ns))
 			return false;
-		ns = vdso_calc_ns(vc, cycles, vdso_ts->nsec);
-		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
 
 	/* Add the namespace offset */
@@ -155,8 +167,7 @@ static __always_inline
 bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 	     clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts = &vc->basetime[clk];
-	u64 cycles, sec, ns;
+	u64 sec, ns;
 	u32 seq;
 
 	/* Allows to compile the high resolution parts out */
@@ -183,14 +194,8 @@ bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 		}
 		smp_rmb();
 
-		if (unlikely(!vdso_clocksource_ok(vc)))
+		if (!vdso_get_timestamp(vd, vc, clk, &sec, &ns))
 			return false;
-
-		cycles = __arch_get_hw_counter(vc->clock_mode, vd);
-		if (unlikely(!vdso_cycles_ok(cycles)))
-			return false;
-		ns = vdso_calc_ns(vc, cycles, vdso_ts->nsec);
-		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
 
 	vdso_set_timespec(ts, sec, ns);

-- 
2.50.0


