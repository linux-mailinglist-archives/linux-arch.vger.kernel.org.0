Return-Path: <linux-arch+bounces-10497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0ECA4BDEF
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685CD188E924
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BA1F8ADD;
	Mon,  3 Mar 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1jkX2xc2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MrIpg7wj"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAA1F3BAD;
	Mon,  3 Mar 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000278; cv=none; b=S5atjGeptwinPNZDghM+ukMhmV5EmpvJOYLUdzihZ2rvUkJVE9DRj/qAvVbvQdH6xCAUymeO2aRP7o031pspNYwtzNtPykItrtP/Lnea/AZh13lhvgNLAw+AtT784uqAxJmU2ogSmiABz7UDZll3vg4xVhwTTZ/xq89WlloHcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000278; c=relaxed/simple;
	bh=KflmMff4h6RLyHPb7phmsSfp4/pXzu9RLHkWtyKEnAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qeqUt1bS2hODWRLah7XXkwIwlZEP2TkI8NR2IlrzF7JGb6qkALERGJukezqUWNocmkYB1KESxDm8CAX1p/eR0Bvjz+HC/dEmj+kl+2CFxwvyMsoY63JObO1ioTSNswX/fnWAEdu5JnwJ9wGrJqSReLvpIB8km8yRCGWydp8flPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1jkX2xc2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MrIpg7wj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr9JkpQD/EJDtjJ/SbcgjVylqUnYY78xk0lDKlXhM0w=;
	b=1jkX2xc2USYyAVaKA3S/OUrtvY2RcEpewvV903vx/WCEkI24THdZfXqweO1EoWZLpD6A4X
	DZXLWiRtTmw+u6w/EnUpGE8Nfb/lHSISkTdJ4jjJEKXZbwpJALXFXTcTyYlQ5xdz3I18ev
	ZweAb7a2ZMen44+qD3Z3qskbkr6rJN1540t8UHc/ftkF/ezKAYZMvpEk40nG3daTnZfWrr
	q/gzPfN17+a36mItfW8onrsRchta4RwL4yPH5mqPTNIeWpJ4Ev3ebBX6URWpyzl6o8b3lI
	pXKlViIwTVqn8dBeh5bQw8+rUFe2buemtHNGqlf5B+95jr7b+rDnYsxsjM++NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr9JkpQD/EJDtjJ/SbcgjVylqUnYY78xk0lDKlXhM0w=;
	b=MrIpg7wj0aDz+QOskd587OX+pxI3VaGZCuFwLTTiyZ8Qtz5fDhWN6DGrlNZ0NaPhXXqUhU
	gjp1WYXtYyPx+aAQ==
Date: Mon, 03 Mar 2025 12:11:11 +0100
Subject: [PATCH 09/19] vdso/gettimeofday: Prepare do_coarse() for
 introduction of struct vdso_clock
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-9-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=2706;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4/BaH4I6+0tHmgqZ+WQUoIr8V7gABIjPIKZPE3OAkPc=;
 b=n8/pYeVd8xAqWuFxtbQOVJ1JDPO6LbfKuv0hp91lyg/I3/WqXF/DTOVHYeTT9gNOl4sC92FND
 rYkHHuurgLwDVr8z+B90JdwYjQ0MjQ32+l9bQmHG+S1h0oUqkAsUzEp
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding struct vdso_clock
pointer argument to do_coarse(), and replace the struct vdso_time_data
pointer with the new pointer arugment whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index e8d4b02bcb616af19f1e794b14fb4419809408da..36ef7de097e6137832605928a155a0ff78123fb4 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -229,10 +229,11 @@ static __always_inline int do_coarse_timens(const struct vdso_time_data *vdns, c
 }
 #endif
 
-static __always_inline int do_coarse(const struct vdso_time_data *vd, clockid_t clk,
-				     struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	      clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	const struct vdso_timestamp *vdso_ts = &vc->basetime[clk];
 	u32 seq;
 
 	do {
@@ -240,17 +241,17 @@ static __always_inline int do_coarse(const struct vdso_time_data *vd, clockid_t
 		 * Open coded function vdso_read_begin() to handle
 		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
 		 */
-		while ((seq = READ_ONCE(vd->seq)) & 1) {
+		while ((seq = READ_ONCE(vc->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-				return do_coarse_timens(vd, clk, ts);
+			    vc->clock_mode == VDSO_CLOCKMODE_TIMENS)
+				return do_coarse_timens(vc, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();
 
 		ts->tv_sec = vdso_ts->sec;
 		ts->tv_nsec = vdso_ts->nsec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
 
 	return 0;
 }
@@ -274,7 +275,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 	if (likely(msk & VDSO_HRES))
 		vc = &vc[CS_HRES_COARSE];
 	else if (msk & VDSO_COARSE)
-		return do_coarse(&vc[CS_HRES_COARSE], clock, ts);
+		return do_coarse(vd, &vc[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
 		vc = &vc[CS_RAW];
 	else

-- 
2.48.1


