Return-Path: <linux-arch+bounces-6265-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C3954C7F
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848821F23677
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DFE1BD027;
	Fri, 16 Aug 2024 14:37:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D41BD026;
	Fri, 16 Aug 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819039; cv=none; b=foEFz2X+WYP6W4twz2hNxowSMeGkHTutrtuMgNxWk9kRNyXdnJOPDQCNcgb50lMfvda67sugTZ8mKcy9PwY0jUWexbmQ5SRxuW7p0mntZAOlyoNcugnX9xoJDaLDvS1YLHfFtvxInen91Focc681koRi9Ijj0Dewh+uSMKZE4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819039; c=relaxed/simple;
	bh=HDpYFMxKyFSQNp1ED9l2KJtE8nHJLjdbcKdsJZlVrDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIz5dfBDoUDRmRFROAfBBlarN2o91HubVYxdO0akHsGBG5746GdQ8d4FfFnnrQuXdTh7GDg2kclf+944bGUBVOhL5i4hmmZNMlAXB4McIP/s0sv5DLMVZZri7Xb/bay27QOnDvnO6K4nmIvWZY4L88Lb/J71tzENFj3C7TUa+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1k32D7z9sSC;
	Fri, 16 Aug 2024 16:36:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTPzywU7GyLN; Fri, 16 Aug 2024 16:36:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1j6HNxz9rvV;
	Fri, 16 Aug 2024 16:36:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C4A0C8B776;
	Fri, 16 Aug 2024 16:36:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Kweo3eDSzfhe; Fri, 16 Aug 2024 16:36:57 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 037108B775;
	Fri, 16 Aug 2024 16:36:56 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 3/9] vdso: Add __arch_get_k_vdso_rng_data()
Date: Fri, 16 Aug 2024 16:36:50 +0200
Message-ID: <a7bdbbb14d8635c1e33ada7982cf2cd1a8321e5c.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819011; l=3092; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=HDpYFMxKyFSQNp1ED9l2KJtE8nHJLjdbcKdsJZlVrDs=; b=2M/fjHzyxYljs6mfOSqvlZx3E1n1R8eSkNJjLxXQit+LDCGGDfD+JqTMNOdrnKVDHdCRy374y R4PaYgn/QvJBHjhPeuOdx19w9E7nvHd51Hraaxab3bMvXjVWfZTJM2x
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

_vdso_data is specific to x86 and __arch_get_k_vdso_data() is provided
so that all architectures can provide the requested pointer.

Do the same with _vdso_rng_data, provide __arch_get_k_vdso_rng_data()
and don't use x86 _vdso_rng_data directly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/x86/include/asm/vdso/vsyscall.h | 7 +++++++
 drivers/char/random.c                | 5 +++--
 include/asm-generic/vdso/vsyscall.h  | 7 +++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 972415a8be31..92b85189b8fe 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -22,6 +22,13 @@ struct vdso_data *__x86_get_k_vdso_data(void)
 }
 #define __arch_get_k_vdso_data __x86_get_k_vdso_data
 
+static __always_inline
+struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
+{
+	return &_vdso_rng_data;
+}
+#define __arch_get_k_vdso_rng_data __x86_get_k_vdso_rng_data
+
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 87fe61295ea1..77968309e2c2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -59,6 +59,7 @@
 #ifdef CONFIG_VDSO_GETRANDOM
 #include <vdso/getrandom.h>
 #include <vdso/datapage.h>
+#include <vdso/vsyscall.h>
 #endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>
@@ -282,7 +283,7 @@ static void crng_reseed(struct work_struct *work)
 	 * is ordered with the write above to base_crng.generation. Pairs with
 	 * the smp_rmb() before the syscall in the vDSO code.
 	 */
-	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
+	smp_store_release(&__arch_get_k_vdso_rng_data()->generation, next_gen + 1);
 #endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
@@ -735,7 +736,7 @@ static void __cold _credit_init_bits(size_t bits)
 			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 #ifdef CONFIG_VDSO_GETRANDOM
-		WRITE_ONCE(_vdso_rng_data.is_ready, true);
+		WRITE_ONCE(__arch_get_k_vdso_rng_data()->is_ready, true);
 #endif
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index c835607f78ae..d44a828e34a4 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -11,6 +11,13 @@ static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
 }
 #endif /* __arch_get_k_vdso_data */
 
+#ifndef __arch_get_k_vdso_rng_data
+static __always_inline struct vdso_rng_data *__arch_get_k_vdso_rng_data(void)
+{
+	return NULL;
+}
+#endif /* __arch_get_k_vdso_rng_data */
+
 #ifndef __arch_update_vsyscall
 static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
 						   struct timekeeper *tk)
-- 
2.44.0


