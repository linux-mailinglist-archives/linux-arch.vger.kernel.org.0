Return-Path: <linux-arch+bounces-12542-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBFAEF252
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D473B2312
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EAE27467F;
	Tue,  1 Jul 2025 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJy4keyD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PlSEIyIg"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF432741D1;
	Tue,  1 Jul 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360299; cv=none; b=P5gts8mO2T05K1bxjm8YAyuOh3agMJA3YLcV5UCkGSRDdDCUyH0BcVfae7B4qB3pAPO/G3e6nFod/GbWGxZzD9EqZsLY4W2wHEN4hAYXM5QWLalGKIxI3/vPJsFW9kPQoU6gWCV0CT9/U6npqVjxH2TVykhDBJVaVP+sQAL6jsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360299; c=relaxed/simple;
	bh=x/PnXWFdRLfiD0A/OSKGxuIkOAxAGhB8JsdPBHMIAYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYWZIsO5ue9bSdqc0slhqb6h/Y5Fh3lTn8g/TOKi8SgTE0LwQzxyShyc7/oqfIV5KZS1bxIb4r2JjUrYhnwUtLd+Wz8v9XohFMDqrLSmmUHpnFz5FSepmAwX3RR1gu/4gVqtIg+HjlaEoBruZNzbfvMA8GPI1eFHLghuL3kCnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJy4keyD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PlSEIyIg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SK3l8BMMu95VGRUTPaxq3odjbGz7PFs+Kx3KugUm1Eo=;
	b=yJy4keyDvwMT/d9Iuu10ATzWX27er316R8MoS0J/wlG2ms9yMllswmbVSX7F0oNSwves1g
	4BHh6Q4jDj04y5tvLIG38Qesc8j4udGrpFb/JzMG0obIbHT6BDsnGHDR3DXhExTQldLZ6p
	TIasEskPYlMcM5UrKm56HckiWHr+AUvISU8YbBHWzgTK18tmfKhhbgxVDRSJKsCXwJJsdS
	unOL13ZIK+7PxGSejg9WpLpB+LqhcYWknE+Zk2SB60y6kV+IgHufR9RIF781J+pDe5CBBM
	+pMyGuApf62S98iO1hYC0KPj1CfUKMGbSZUeLlqo9p2OxoU2n3zbwq/MJ4zTEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SK3l8BMMu95VGRUTPaxq3odjbGz7PFs+Kx3KugUm1Eo=;
	b=PlSEIyIg2wzGfdV+P8vGns3fGgMZoJ8TdGRsj5fKXuwEfe7qrVEvJ9Z02lp1QogJ04DZst
	NVCqYmbA/AfuVkAg==
Date: Tue, 01 Jul 2025 10:58:08 +0200
Subject: [PATCH 14/14] selftests/timers/auxclock: Test vDSO functionality
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-14-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=4589;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=x/PnXWFdRLfiD0A/OSKGxuIkOAxAGhB8JsdPBHMIAYg=;
 b=OA+n1MSc80uZUXpqQjNbqDIekjmoLXtWUGfIg6qkJB8FJfSi1QgdUq+BefaVbWNSC/4NI7as+
 cDOwHVLSM6QABo3bS6VhO/hkfNIXLsquyPVrTFpjyRRleSToVAMh0A8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the auxclock test to also cover the vDSO.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/timers/auxclock.c | 95 +++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/timers/auxclock.c b/tools/testing/selftests/timers/auxclock.c
index 0ba2f9996114ade3147f0f3aec49904556a23cd4..314037839c1c7dd32ca32722231c67bc408a2ea3 100644
--- a/tools/testing/selftests/timers/auxclock.c
+++ b/tools/testing/selftests/timers/auxclock.c
@@ -10,11 +10,16 @@
 #include <linux/timex.h>
 #include <sched.h>
 #include <stdio.h>
+#include <sys/auxv.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
 
+#include "../vDSO/parse_vdso.c"
+#include "../vDSO/vdso_config.h"
+#include "../vDSO/vdso_call.h"
+
 #ifndef CLOCK_AUX
 #define	CLOCK_AUX	16
 #endif
@@ -133,7 +138,45 @@ static int sys_clock_adjtime64(__kernel_clockid_t clockid, struct __kernel_timex
 #endif
 }
 
-FIXTURE(auxclock) {};
+FIXTURE(auxclock) {
+	int (*vdso_clock_gettime)(__kernel_clockid_t clockid, struct timespec *ts);
+	int (*vdso_clock_gettime64)(__kernel_clockid_t clockid, struct __kernel_timespec *ts);
+	int (*vdso_clock_getres)(__kernel_clockid_t clockid, struct timespec *ts);
+};
+
+static int vdso_clock_gettime64(FIXTURE_DATA(auxclock) *self, __kernel_clockid_t clockid,
+				struct __kernel_timespec *ts)
+{
+	struct timespec _ts;
+	int ret;
+
+	if (self->vdso_clock_gettime64) {
+		return VDSO_CALL(self->vdso_clock_gettime64, 2, clockid, ts);
+	} else if (self->vdso_clock_gettime) {
+		ret = VDSO_CALL(self->vdso_clock_gettime, 2, clockid, &_ts);
+		if (!ret)
+			timespec_to_kernel_timespec(&_ts, ts);
+		return ret;
+	} else {
+		return -ENOSYS;
+	}
+}
+
+static int vdso_clock_getres_time64(FIXTURE_DATA(auxclock) *self, __kernel_clockid_t clockid,
+				    struct __kernel_timespec *ts)
+{
+	struct timespec _ts;
+	int ret;
+
+	if (self->vdso_clock_getres) {
+		ret = VDSO_CALL(self->vdso_clock_getres, 2, clockid, &_ts);
+		if (!ret)
+			timespec_to_kernel_timespec(&_ts, ts);
+		return ret;
+	} else {
+		return -ENOSYS;
+	}
+}
 
 FIXTURE_VARIANT(auxclock) {
 	__kernel_clockid_t clock;
@@ -193,6 +236,18 @@ static void enter_timens(struct __test_metadata *_metadata)
 FIXTURE_SETUP(auxclock) {
 	int ret;
 
+#ifdef AT_SYSINFO_EHDR
+	unsigned long sysinfo_ehdr;
+
+	sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	if (sysinfo_ehdr)
+		vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
+
+	self->vdso_clock_gettime = vdso_sym(versions[VDSO_VERSION], names[VDSO_NAMES][1]);
+	self->vdso_clock_gettime64 = vdso_sym(versions[VDSO_VERSION], names[VDSO_NAMES][5]);
+	self->vdso_clock_getres = vdso_sym(versions[VDSO_VERSION], names[VDSO_NAMES][3]);
+#endif /* !AT_SYSINFO_EHDR */
+
 	ret = configure_auxclock(variant->clock, variant->clock_enabled);
 	if (ret == -ENOENT)
 		SKIP(return, "auxclocks not enabled");
@@ -220,6 +275,20 @@ TEST_F(auxclock, sys_clock_getres) {
 	ASSERT_EQ(1, ts.tv_nsec);
 }
 
+TEST_F(auxclock, vdso_clock_getres) {
+	struct __kernel_timespec ts;
+	int ret;
+
+	ret = vdso_clock_getres_time64(self, variant->clock, &ts);
+	if (ret == -ENOSYS) {
+		SKIP(return, "no clock_getres() in vDSO");
+	} else {
+		ASSERT_EQ(0, ret);
+		ASSERT_EQ(0, ts.tv_sec);
+		ASSERT_EQ(1, ts.tv_nsec);
+	}
+}
+
 TEST_F(auxclock, sys_clock_gettime) {
 	struct __kernel_timespec ts;
 	int ret;
@@ -233,6 +302,20 @@ TEST_F(auxclock, sys_clock_gettime) {
 	}
 }
 
+TEST_F(auxclock, vdso_clock_gettime) {
+	struct __kernel_timespec ts;
+	int ret;
+
+	ret = vdso_clock_gettime64(self, variant->clock, &ts);
+	if (ret == -ENOSYS) {
+		SKIP(return, "no clock_gettime() in vDSO");
+	} else if (variant->clock_enabled) {
+		ASSERT_EQ(0, ret);
+	} else {
+		ASSERT_EQ(-ENODEV, ret);
+	}
+}
+
 static void auxclock_validate_progression(struct __test_metadata *_metadata,
 					  const struct __kernel_timespec *a,
 					  const struct __kernel_timespec *b)
@@ -310,9 +393,13 @@ TEST_F(auxclock, progression) {
 		auxclock_validate_progression(_metadata, &a, &b);
 
 		memset(&a, 0, sizeof(a));
-		ret = sys_clock_gettime64(variant->clock, &a);
-		ASSERT_EQ(0, ret);
-		auxclock_validate_progression(_metadata, &b, &a);
+		ret = vdso_clock_gettime64(self, variant->clock, &a);
+		if (ret == -ENOSYS) {
+			a = b;
+		} else {
+			ASSERT_EQ(0, ret);
+			auxclock_validate_progression(_metadata, &b, &a);
+		}
 	}
 }
 

-- 
2.50.0


