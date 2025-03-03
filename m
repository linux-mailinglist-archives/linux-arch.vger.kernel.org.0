Return-Path: <linux-arch+bounces-10493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C6A4BDEE
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B512C17328D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE5F1F76C0;
	Mon,  3 Mar 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTOvMpIM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3coPW8he"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BF1F4618;
	Mon,  3 Mar 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000276; cv=none; b=rXqwdZy3+B92AJ3bhmpwMdO6uAG++gnWnGJZAZID29tyhRE150OI1mULe6tx5B6W+T4PR+q+YkjA8bsuSa0zBo14U1JSdzvQSzIt1Z/uS9PSNtlLAtO+xmHONdPKjBoi3JCAt5UOxbEwaCgc396JidK8PZPgzeDMAdBEJwIxuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000276; c=relaxed/simple;
	bh=aAf2WMIoOnGC1C4ux5I/IYlfYgkhjEQdOMmHklgEwHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5Gt015wjCq+EDKoJUsfVHyvD+A/5FY0gj9nWeuyi60ZJR+LQFLRDJan0mlONY97vUzOGZ/ssKYAKbsw4xwxEqThCePzeXxR/YjRpJewmZY+1U72psy/DdmLspfjjaIsxFh3MmAN4yC7tUtW/9vUFzBxdLdMce40ZzO/yrlZxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTOvMpIM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3coPW8he; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5aCd4EMkjlNalFoR07yY3E582pKdgj75t6H7h3ol4lU=;
	b=eTOvMpIMxmyAd9LOliw0S+YruQOiVjmBeLzScbkioXmoTB1ynEytW3q3/oR/TOfPRsYz7n
	0UZTLzt1xJj/QxJotLsT5C+wKny2iVGSwJwsBdIH30OG7L0zwbQ6SnjyaLBuVoL1q9jqC7
	/ewuYnBMKcmQ2tpwJosDyjBi9QadoZhoV2EEQhXsyXr1IUNGADV72vx9lWS5UZv9oSXHPm
	/WgfnQzIq0SHtk9KWbQOub2UMHmHnFCKrpUw4jr5bNGOV/VWz8/O61QqzbxvvLAK/ZkDYc
	i5CmWss+MsJzI9fkG5gUQIRMwLJGr3VYC2a+KCvbx3kf7AMoz/CuCr2CekkcOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5aCd4EMkjlNalFoR07yY3E582pKdgj75t6H7h3ol4lU=;
	b=3coPW8heN6x2TMm5riaOgfCuNNyicJ0eoPWFUOkenchvU+tFhsoPFowfTEyEXZCJQna9RV
	IWQA8ohD+HuOgxDQ==
Date: Mon, 03 Mar 2025 12:11:10 +0100
Subject: [PATCH 08/19] vdso/gettimeofday: Prepare do_hres_timens() for
 introduction of struct vdso_clock
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=3635;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DD6TqSTT0n4lKxdBvYuWMMqzxVw/01dOoQIaUbeVuus=;
 b=ByURjHW0BXzpZLG3Q9Xizbjjjp5WZvUhrwy8shGeZwF08cAt5jmXQsOCnq5t/j798V8dxzaCG
 JkI07e3Haq+AG5dJh2BXfo7Uv+OjdM2UJuGE+s+TDCpSagjO4sUqlEH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding struct vdso_clock
pointer argument to do_hres_timens(), and replace the struct vdso_time_data
pointer with the new pointer arugment whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 15611ab650232f2e847b7de80c7293c4fb7f84f2..e8d4b02bcb616af19f1e794b14fb4419809408da 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -81,36 +81,36 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_tim
 }
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
-static __always_inline int do_hres_timens(const struct vdso_time_data *vdns, clockid_t clk,
-					  struct __kernel_timespec *ts)
+static __always_inline
+int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
+		   clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct timens_offset *offs = &vdns->offset[clk];
+	const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
+	const struct timens_offset *offs = &vcns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_time_data *vd;
+	const struct vdso_clock *vc = vd;
 	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
 
-	vd = vdns - (clk == CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
-	vd = __arch_get_vdso_u_timens_data(vd);
 	if (clk != CLOCK_MONOTONIC_RAW)
-		vd = &vd[CS_HRES_COARSE];
+		vc = &vc[CS_HRES_COARSE];
 	else
-		vd = &vd[CS_RAW];
-	vdso_ts = &vd->basetime[clk];
+		vc = &vc[CS_RAW];
+	vdso_ts = &vc->basetime[clk];
 
 	do {
-		seq = vdso_read_begin(vd);
+		seq = vdso_read_begin(vc);
 
-		if (unlikely(!vdso_clocksource_ok(vd)))
+		if (unlikely(!vdso_clocksource_ok(vc)))
 			return -1;
 
-		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
+		cycles = __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns = vdso_calc_ns(vd, cycles, vdso_ts->nsec);
+		ns = vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec = vdso_ts->sec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
 
 	/* Add the namespace offset */
 	sec += offs->sec;
@@ -132,8 +132,9 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_tim
 	return NULL;
 }
 
-static __always_inline int do_hres_timens(const struct vdso_time_data *vdns, clockid_t clk,
-					  struct __kernel_timespec *ts)
+static __always_inline
+int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
+		   clockid_t clk, struct __kernel_timespec *ts)
 {
 	return -EINVAL;
 }
@@ -166,7 +167,7 @@ int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 		while (unlikely((seq = READ_ONCE(vc->seq)) & 1)) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
 			    vc->clock_mode == VDSO_CLOCKMODE_TIMENS)
-				return do_hres_timens(vd, clk, ts);
+				return do_hres_timens(vd, vc, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();

-- 
2.48.1


