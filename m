Return-Path: <linux-arch+bounces-13275-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BFB3540B
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D24202E3A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3052F5499;
	Tue, 26 Aug 2025 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ftFG8SBn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8mSoKdi"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20A243376;
	Tue, 26 Aug 2025 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189102; cv=none; b=UoyOogjj0Wreq0LnQ+8GQNV8lE7/rgm9+C52G/aTRrfk/zSbHYrnrHpYLyJJZXCL2LT/vwGF/axoJVQacMN8cnY9btaaDEt7ZBbUyQglU59nmtVjxd2DZERFCa0uED7tSGfEdQuY6TJnyuup5odyRJ89XlU+ZhtH2ENxcu9ynTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189102; c=relaxed/simple;
	bh=Xwfsdm0ZK9C/lpd9jqhqOkaZcVVPlOC5pvjRYhkmXtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YV8/rIMO3ieaNcS9OVssbQYxntu1PGV6KlS2xI0Dzf9GwtPdozCzOsPCimvBL1boVEkERjNbpNaPKIA6DOemJDMN2aLSUODYfux8y/u2weFq0WOQ6Om/mAa981KXentJmQdhBSltwIWrK98netkS9pjpefgU1n+1OSlaAkcCipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ftFG8SBn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8mSoKdi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkAC4wHTvttqFMA6WXB8e/iq2KZu43nm9iAolOlePoo=;
	b=ftFG8SBnHpOXRL9VAVhckxZYgwanzsVDNpjzugioUWi5H/xnB9LILcjisXIrzH2R+dazDg
	ZNjj2RdlNZx0OSz5vn6HERSvn8UwHlr7Q5cgeUXzSPD/sDRnQfG0ssQC5o9mys+jB6sDJk
	z4w6mODqzHiWZ8+UWGykNpJQh+5rXhZlF6+Sa6lPM1KttWeNNlu8lZXimTskuj80uPVBPS
	FopsXitSUPuUlbMt1Gw/VB/4vy9bj93+g1D7QgcBGF4K5Rs8Zjy0QPAnw0UCOBX5dxoxbz
	Afa6WIqDtpB2KnfHuFb7U8fOJqpiVBknxb225gAJVwnWK2Be0r1onSEP5TwAsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkAC4wHTvttqFMA6WXB8e/iq2KZu43nm9iAolOlePoo=;
	b=Q8mSoKdiRiKW506l9WVulESL+9134C7qwVPD/h56gDK4cLn2hQDvtAscD0+Y7vY2LhTQCC
	HHH6+qGbv0QACRBg==
Date: Tue, 26 Aug 2025 08:17:04 +0200
Subject: [PATCH 01/11] vdso/datastore: Gate time data behind
 CONFIG_GENERIC_GETTIMEOFDAY
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-1-d9b65750e49f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=1494;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Xwfsdm0ZK9C/lpd9jqhqOkaZcVVPlOC5pvjRYhkmXtE=;
 b=tlV3av9IKVXt0yWBFrF5Xv8jBNjjBxHO+JuqtOgaexNgBMaGIsCaUqqbuFYpe8hxCfE7QWU0D
 myFUv/1mGoXDr2ckk35aDR7U4NUTuoYXHLDHdqVI/Wbr6WCebWnlLLC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When the generic vDSO does not provide time functions, as for example on
riscv32, then the time data store is not necessary.

Avoid allocating these time data pages when not used.

Fixes: df7fcbefa710 ("vdso: Add generic time data storage")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/datastore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 3693c6caf2c4d41a526613d5fb746cb3a981ea2e..a565c30c71a04ff4116c14f43f4450210eba99c5 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -11,14 +11,14 @@
 /*
  * The vDSO data page.
  */
-#ifdef CONFIG_HAVE_GENERIC_VDSO
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static union {
 	struct vdso_time_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_time_data_store __page_aligned_data;
 struct vdso_time_data *vdso_k_time_data = &vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) == PAGE_SIZE);
-#endif /* CONFIG_HAVE_GENERIC_VDSO */
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 #ifdef CONFIG_VDSO_GETRANDOM
 static union {
@@ -46,7 +46,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
-		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))
+		if (!IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY))
 			return VM_FAULT_SIGBUS;
 		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
 		if (timens_page) {

-- 
2.50.1


