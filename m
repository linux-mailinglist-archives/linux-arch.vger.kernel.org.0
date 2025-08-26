Return-Path: <linux-arch+bounces-13276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F1B35413
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F41684A48
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2872F60CC;
	Tue, 26 Aug 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y7BA+StB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eX4ApMd4"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6173A2853E9;
	Tue, 26 Aug 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189103; cv=none; b=C0y6d5/RFxc3L6sBk3oYE+1JcDkauxir4Om/UAop0eGNcVucffRYLxaOP5iuk5qybBAK50sS1xwE07RnGGui+ZXvct7lTI+vLVHdqoumD9pY/6GR3MO8vhhe+tRR3lXBSlcGQlAYv3jKS3CtW5nPjWHbADiCkr7dGTVuWtjFthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189103; c=relaxed/simple;
	bh=EexCAO4ByrqWp36PwLc6Nuk8KsCI0mVA6scJ+GgAbLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6YRCFX1O+vdS5t/DeG9CDAKtIOR/LsASJkZziN3l2KLRLK72oGOzs9wg+Hgm1VJEAk+fS/BjWWJZjCcpNevrF79eL5IsH45ro6YnRtCSl3rZG91O4i3Gf0fM5HQ/cu6r3h48DQLJj6MODfrq+hutpamdFSBfu0mV50As3JUoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y7BA+StB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eX4ApMd4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uszkh3lqv/KNmuDmi3U8LEjAUFp6txufWN65uYpGjyY=;
	b=Y7BA+StBK859WKGDBThqNJzUURHkFFg61E0vffUNTCQF1VxCAHN6xIXKlyiHbm9eajvVvI
	Jt2GBaIF/pi7LvI0utN6sJQhfLqKDQPZOqDyCHKEfKrCO50+UW590sV1dM+eZn6te1RbF9
	PyeES+znaqYbX/ssIrN39kD3Kk09hoWNTLMrNZp3to3aZHXhrk/vJALCBcxIxdORkBp/am
	uLQaB0JAQI/GDq9oYJJEaiJmug7ASdO6OyB8IVh15jxqnnvzCkRVdctLGYZ4k8F1iN9Zvz
	muN/flVMNl5dCVqSsfywVPrbMq2Yg/EKUtf+JWnprwsvjdX/+lc9kWIeQ4TJsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uszkh3lqv/KNmuDmi3U8LEjAUFp6txufWN65uYpGjyY=;
	b=eX4ApMd4ziFJ+O7XtN9ONWYbWvF8LT00ruUQ8zsD0FgJE7m4FLwFuEe2Mo8xsi0CtiVh9r
	4pAcBkCmeL70n1BQ==
Date: Tue, 26 Aug 2025 08:17:05 +0200
Subject: [PATCH 02/11] ARM: VDSO: remove cntvct_ok global variable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-vdso-cleanups-v1-2-d9b65750e49f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=2467;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=SraZm0ID4pbqm566wM3v0Ccba0fElQJFwVMRPDgnQv0=;
 b=gZMwdBr81Gd7SfGI9zA49QzosCdIhBKgEYiZOU6oZRlEUfUXED78+TGCO1Aix2Xt9rw5NrYMT
 tA6ghwW+GTLCIiMiWaHkprmyw7TLEyHTqzP7iQQA/CqwF/kDQFk1ywg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

The cntvct_ok variable has not had any external user since commit
c7a18100bdff ("lib/vdso: Avoid highres update if clocksource is not
VDSO capable").

It also only has one user in vdso.c, once during init, so rather than
having the caller of patch_vdso() initialize cntvct_ok, just call
cntvct_functional() directly and avoid the global variable entirely.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm/include/asm/vdso/vsyscall.h |  2 --
 arch/arm/kernel/vdso.c               | 10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index 4e7226ad02ec4dcf88203c9046e1b320a10e7373..ff1c729af05f03ac5db86c28276db2e4a31c775c 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -7,8 +7,6 @@
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
 
-extern bool cntvct_ok;
-
 static __always_inline
 void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 325448ffbba0c29895ea5d97e60d6f51e552cb2e..e38a30477f3d70939f6d57c79fad52eed73c49b4 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -54,11 +54,9 @@ struct elfinfo {
 	char		*dynstr;	/* ptr to .dynstr section */
 };
 
-/* Cached result of boot-time check for whether the arch timer exists,
- * and if so, whether the virtual counter is useable.
+/* Boot-time check for whether the arch timer exists, and if so,
+ * whether the virtual counter is usable.
  */
-bool cntvct_ok __ro_after_init;
-
 static bool __init cntvct_functional(void)
 {
 	struct device_node *np;
@@ -159,7 +157,7 @@ static void __init patch_vdso(void *ehdr)
 	 * want programs to incur the slight additional overhead of
 	 * dispatching through the VDSO only to fall back to syscalls.
 	 */
-	if (!cntvct_ok) {
+	if (!cntvct_functional()) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
@@ -197,8 +195,6 @@ static int __init vdso_init(void)
 	vdso_total_pages = VDSO_NR_PAGES; /* for the data/vvar pages */
 	vdso_total_pages += text_pages;
 
-	cntvct_ok = cntvct_functional();
-
 	patch_vdso(vdso_start);
 
 	return 0;

-- 
2.50.1


