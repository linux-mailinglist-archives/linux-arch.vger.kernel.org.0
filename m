Return-Path: <linux-arch+bounces-13278-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC73B3541E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF83684A7A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E642F6576;
	Tue, 26 Aug 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SkRWsNvT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/AJx/Es"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13D2F60A2;
	Tue, 26 Aug 2025 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189104; cv=none; b=qTGtQUXZKlXSlCraGHcBxCtfRIhF1OBRguf+XzwRzhHuBB0sx5bcNOAUPklMM2gSMeX0ObajZB5pjaaHI1jzqV1zCYXIQimHUe0E/Gn7Aez2heqFWcFUauUHgcVFDKUkorVHpkVjkR4cFi+tb4CmgOg/rHyr+6gYKC0IUdwKSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189104; c=relaxed/simple;
	bh=tJipNBF1mCJkcHD6N5bfKjS9Ac/LEi0lcuk3Tu4AjoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqbMwQ4lmMvNV4kkNHOR4kr9W5vhQJkdlHF2+TV8bpEc7kTN52YozbO+3iRS7LmvN/AxxOYgI3gcWOXVgUJHNIkzy8AyzkTLjhwdasMdxjEe684gSfDu+pFUR/u8ZoiIAYY6dZn9eEuEe/LpER3Kose5TgwjxfCHe5kf92TtW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SkRWsNvT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/AJx/Es; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nO2JL615du1jOF72APE2zhJ94ZRmncTq0i3UGNr5c1I=;
	b=SkRWsNvTfHbckv53ywkAP2ElLQno6nL35GWoaL2ostie0fB8ZhIrtZ2GpuUn4Yog/ZqbRE
	7Ic6DelZ6GAsCv6r4UwjpNb7cBzSwuWnf7NOkczUv4NJuo6Lqe0iE9DBx6XOvzaIrOUWQo
	ZM0hBzR26cXTRvKvnkNUcchIelDhHzNqPoWVr5FtMu4Nudp2Z1D46OEL1XDCSKSmaZgXIQ
	GVPwi4kCLp7XohVVq/RWPsKA1Z9HMGn618o+O6/M1Ni8zE340s4Kit4LGTyA3C0Me8op4Y
	B3jPvpQhJwWgOn21qfbXuyhpqhYwaUwaTLAGms3NzzYcJcqF5v7lVsAOPnWVQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nO2JL615du1jOF72APE2zhJ94ZRmncTq0i3UGNr5c1I=;
	b=D/AJx/EsJAMGNOGXXQFrdYdT0ZJzLD/RNagxyHMRvN9hYL1zhSX7qy7lWuXYEwi6Dt8f0S
	27kxifT9iftB5EAA==
Date: Tue, 26 Aug 2025 08:17:07 +0200
Subject: [PATCH 04/11] vdso/gettimeofday: Remove !CONFIG_TIME_NS stubs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-4-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
In-Reply-To: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nam Cao <namcao@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=2241;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tJipNBF1mCJkcHD6N5bfKjS9Ac/LEi0lcuk3Tu4AjoE=;
 b=7HV/8pMpAQ+4eBDclWEwMfZrJXqv8psYox/k68u7tMzHASoMCDHXlEWrPcIR5Nm0+i+/zA6uc
 bGdBUfDn6tHATjO/gAnAN6QWWAGRNdzrTjLrH/04Nne7yZR3YZZBbeH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All calls of these functions are already gated behind CONFIG_TIME_NS. The
compiler will already optimize them away if time namespaces are disabled.

Drop the unnecessary stubs.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 02ea19f671647e9a1b8c3e7ea0cbff33b4024711..1e2a40b8d2c6c2356cfc678a1ea441ec1bad181a 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -108,8 +108,6 @@ bool vdso_get_timestamp(const struct vdso_time_data *vd, const struct vdso_clock
 	return true;
 }
 
-#ifdef CONFIG_TIME_NS
-
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 static __always_inline
 const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_time_data *vd)
@@ -149,20 +147,6 @@ bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *
 
 	return true;
 }
-#else
-static __always_inline
-const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_time_data *vd)
-{
-	return NULL;
-}
-
-static __always_inline
-bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
-		    clockid_t clk, struct __kernel_timespec *ts)
-{
-	return false;
-}
-#endif
 
 static __always_inline
 bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
@@ -204,7 +188,6 @@ bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 	return true;
 }
 
-#ifdef CONFIG_TIME_NS
 static __always_inline
 bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
 		      clockid_t clk, struct __kernel_timespec *ts)
@@ -233,14 +216,6 @@ bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock
 
 	return true;
 }
-#else
-static __always_inline
-bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
-		      clockid_t clk, struct __kernel_timespec *ts)
-{
-	return false;
-}
-#endif
 
 static __always_inline
 bool do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,

-- 
2.50.1


