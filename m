Return-Path: <linux-arch+bounces-12540-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF3AEF231
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5674C1883E19
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6F2737F6;
	Tue,  1 Jul 2025 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZUEI+ZW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ffbGYJYD"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BB27146E;
	Tue,  1 Jul 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360295; cv=none; b=VovO7gw8XJ7H7LYELZBChMB4AxqQg31oZnFklh8h15sYHuZLEGZnYw9QuouMYz8dwAk+f7IwcwL/rKVO2eJwBISRQzL9XWzL7Ok8awQiYKmmGApmB/75+w9HYa16CrqJqUGhKkSIa2FfvT2+8USRavwejCPVVEYIdqk5h3kpH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360295; c=relaxed/simple;
	bh=xvjCYJ8mK4mm1osuZA69etc3l9N5nef3XUciIrrNCVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBvJvJQ91r8bYoKjORNXSWcK7FWZhN4BbJEd0x/wLotIYWUoJowtJrcCAm1GqtHuLjFB/pX2qORHuZgDRILH5Swpc+hXmEvPOtFtQM2oSaHQp7Uu+FvqJxTVC6yokRGUVKEbqByh69FA/0IhPuGAPgQC/PKQWb/f4On6qpxREII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZUEI+ZW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ffbGYJYD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRHvw41rR6k2CXfRNpVAkucpo+CGu/QUxPMlHxm0VFU=;
	b=cZUEI+ZWwrpIOUwpN59qkqfsHQ28OiVuU20/SMtS2hxUrw8aWnINnJ0ffpbNYHLJ/5UJXJ
	O/l6oUKRcdkWhfG41or2qOviq0jHjuXie8qblg4VoLc9NaI9eReM2nX4eb78wwJ40e3oZN
	YCDcbVu7zPg8Hl08XKGxNbwDDSxHz/1sU41hCYsUpiCxx+eV59bW8Rhsi8M8rWHsJsRJpC
	imw3KijpfVGsKmTdNRMY79NJo1mF9+RLw3BEMKAkbmkj1/WPaVhkAglbZf0DksmoveWuo1
	LH/hOXnMAjs6m6v4kTTHgTb5Z6U6IUh0NBzI/pT0NUgzc+orqQPhJCo5izyYUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRHvw41rR6k2CXfRNpVAkucpo+CGu/QUxPMlHxm0VFU=;
	b=ffbGYJYDgaQ3PocT43ygu+WEgcKUBnnhJ5s7syxm20zKVw/z/N3DLGAS7Q2fBccv1uQ+JB
	cJWrBrHgywPHeeBw==
Date: Tue, 01 Jul 2025 10:58:06 +0200
Subject: [PATCH 12/14] vdso/gettimeofday: Add support for auxiliary clocks
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=3709;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xvjCYJ8mK4mm1osuZA69etc3l9N5nef3XUciIrrNCVc=;
 b=8epmu6riVb6Cimt5TflcONcv5+2kAze7zj+/Y0LDsxXjd2AFyIPEUELEyZxVrZr4KCXHMwE5s
 FEIdtgRGwruATHKRhUUGmkAZG48gXneaw/JXe8VaXq32AIu2beiRXCH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Expose the auxiliary clocks through the vDSO.

Architectures not using the generic vDSO time framework,
namely SPARC64, are not supported.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/datapage.h |  2 ++
 lib/vdso/gettimeofday.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index f4c96d9ce674abb07ccd8703f1a04da7631c1677..02533038640e53c40291c7e09139e0f9b32f502a 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
+#include <uapi/linux/bits.h>
 #include <uapi/linux/time.h>
 #include <uapi/linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
@@ -46,6 +47,7 @@ struct vdso_arch_data {
 #define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
 			 BIT(CLOCK_MONOTONIC_COARSE))
 #define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
+#define VDSO_AUX	__GENMASK(CLOCK_AUX_LAST, CLOCK_AUX)
 
 #define CS_HRES_COARSE	0
 #define CS_RAW		1
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c383878bb5445a62d8fea6591e8550183852c2e6..3a54dbb8fe32849cd749e71ec2a8be44baf42816 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -2,6 +2,7 @@
 /*
  * Generic userspace implementations of gettimeofday() and similar.
  */
+#include <vdso/auxclock.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
@@ -74,7 +75,7 @@ static inline bool vdso_cycles_ok(u64 cycles)
 static __always_inline bool vdso_clockid_valid(clockid_t clock)
 {
 	/* Check for negative values or invalid clocks */
-	return likely((u32) clock < MAX_CLOCKS);
+	return likely((u32) clock < CLOCK_AUX_LAST);
 }
 
 /*
@@ -268,6 +269,48 @@ bool do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 	return true;
 }
 
+static __always_inline
+bool do_aux(const struct vdso_time_data *vd, clockid_t clock, struct __kernel_timespec *ts)
+{
+	const struct vdso_clock *vc;
+	u64 sec, ns;
+	u32 seq;
+	u8 idx;
+
+	if (!IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+		return false;
+
+	idx = clock - CLOCK_AUX;
+	vc = &vd->aux_clock_data[idx];
+
+	do {
+		/*
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
+		 */
+		while ((seq = READ_ONCE(vc->seq)) & 1) {
+			if (IS_ENABLED(CONFIG_TIME_NS) && vc->clock_mode == VDSO_CLOCKMODE_TIMENS) {
+				vd = __arch_get_vdso_u_timens_data(vd);
+				vc = &vd->aux_clock_data[idx];
+				break;
+			}
+			cpu_relax();
+		}
+		smp_rmb();
+
+		/* Auxclock disabled? */
+		if (vc->clock_mode == VDSO_CLOCKMODE_NONE)
+			return false;
+
+		if (!vdso_get_timestamp(vd, vc, VDSO_BASE_AUX, &sec, &ns))
+			return false;
+	} while (unlikely(vdso_read_retry(vc, seq)));
+
+	vdso_set_timespec(ts, sec, ns);
+
+	return true;
+}
+
 static __always_inline bool
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 			     struct __kernel_timespec *ts)
@@ -289,6 +332,8 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 		return do_coarse(vd, &vc[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
 		vc = &vc[CS_RAW];
+	else if (msk & VDSO_AUX)
+		return do_aux(vd, clock, ts);
 	else
 		return false;
 
@@ -433,6 +478,8 @@ bool __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t cloc
 		 * Preserves the behaviour of posix_get_coarse_res().
 		 */
 		ns = LOW_RES_NSEC;
+	} else if (msk & VDSO_AUX) {
+		ns = aux_clock_resolution_ns();
 	} else {
 		return false;
 	}

-- 
2.50.0


