Return-Path: <linux-arch+bounces-10496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBD7A4BDEC
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411F61895555
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1127F1F8921;
	Mon,  3 Mar 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUwQeVEl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JFehfof/"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01C1F17E5;
	Mon,  3 Mar 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000277; cv=none; b=bbH2yiEc2DvAUkLwh0//Y403Wu+dssEq6Lg3QTYeqG8uOs6TaSEUsadcCJoOEE85I6o+B3MuXhsWnn6w+52p0sT7l6N2sIGwgce5TtiOjr/PgclOAr8qfq682GF0YOQFjMhP9ryTKrOFPV5MGGbzPSbroyCVQoZGzulROUmlO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000277; c=relaxed/simple;
	bh=nr7vXrUoWXpS/MGX4NFTJ1SvP7ZWGDzRpoGvN8eaF2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIYtz+edAV66W0kdDUoTVVdSfRtC9f/a9OFQISxl2A1Ehzu/0kDW79ywX/Dyr3EKrVbbJrGcj6ixyFTtuJ6q/77zSPRJtLpUdXqquZuaRfYpyRYHckzwUIGckz8L6WXTHbglvVJtcSqliK2X/HQdHzUgPiXw9kvGPkX7IZCcZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JUwQeVEl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JFehfof/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+wRJrxNM282C+g9kU4vuAnxbkq5JTq67GnYAzZiRLM=;
	b=JUwQeVElPmivru/iDcQB1jz+YU3YptqhV7tZ4A3UnPaaWYeSAC2TCcM2pqpn+dIL9PAgyk
	sPfcXUgqfJkEbk8VAD8WOKDIYt8v/OnirpZst3tsfsbKsHirTWyRbgA/qteqCw8bLp3qzX
	E27o5DUz6qOlyPbWz4aSrNhB/cJ/XGaDR2bWn2GHta4ISsKfYpF0+bUjg+UV5+fijn1iy0
	BUuHUpEz5hqc9QJO+D8s1ZFlTjw+QVyGZB5Z0+Ts7rbRxg/0tow2f3O9+CDi3sLpZlwMfV
	p9DlnJ9nc1DEwrwdqvFCr+kIVIHpVPrvOyj2RlpAQ/D6BJrqEix05sg28vGFCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+wRJrxNM282C+g9kU4vuAnxbkq5JTq67GnYAzZiRLM=;
	b=JFehfof/+9xh4U791YnEEwPlkllR+336Eu52CUZjWAHExQftHcUhWXamBtZ8GON03OCKxh
	dG9SR4cKmU8HscCw==
Date: Mon, 03 Mar 2025 12:11:12 +0100
Subject: [PATCH 10/19] vdso/gettimeofday: Prepare do_coarse_timens() for
 introduction of struct vdso_clock
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-10-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=2984;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0h40dglNs6fnGxl4dOAKT3F3JwW4lYavueIQgAMF8RA=;
 b=saBNnkL0hQl7QE2A8rxZyUXJ547QYmIUFk5PeduK03TEkTi2dCnoZyxi2BIrkwlfsuNb8NMCk
 mppnQ1fw1ryBsJhroXABnLZZZtKFH3L0kVqYPmVxl8UJSAKaW7w83eE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. At the moment, vdso_clock
is simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding struct vdso_clock
pointer argument to do_coarse_timens(), and replace the struct
vdso_time_data pointer with the new pointer arugment whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 36ef7de097e6137832605928a155a0ff78123fb4..03fa0393645ac0f5ee465ddc19d84b330913da65 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -193,21 +193,25 @@ int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 }
 
 #ifdef CONFIG_TIME_NS
-static __always_inline int do_coarse_timens(const struct vdso_time_data *vdns, clockid_t clk,
-					    struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
+		     clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
-	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
-	const struct timens_offset *offs = &vdns->offset[clk];
+	const struct timens_offset *offs = &vcns->offset[clk];
+	const struct vdso_timestamp *vdso_ts;
+	const struct vdso_clock *vc = vd;
 	u64 nsec;
 	s64 sec;
 	s32 seq;
 
+	vdso_ts = &vc->basetime[clk];
+
 	do {
-		seq = vdso_read_begin(vd);
+		seq = vdso_read_begin(vc);
 		sec = vdso_ts->sec;
 		nsec = vdso_ts->nsec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
 
 	/* Add the namespace offset */
 	sec += offs->sec;
@@ -222,8 +226,9 @@ static __always_inline int do_coarse_timens(const struct vdso_time_data *vdns, c
 	return 0;
 }
 #else
-static __always_inline int do_coarse_timens(const struct vdso_time_data *vdns, clockid_t clk,
-					    struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
+		     clockid_t clk, struct __kernel_timespec *ts)
 {
 	return -1;
 }
@@ -244,7 +249,7 @@ int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 		while ((seq = READ_ONCE(vc->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
 			    vc->clock_mode == VDSO_CLOCKMODE_TIMENS)
-				return do_coarse_timens(vc, clk, ts);
+				return do_coarse_timens(vd, vc, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();

-- 
2.48.1


