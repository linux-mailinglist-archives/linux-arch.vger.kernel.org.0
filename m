Return-Path: <linux-arch+bounces-6271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A8F954C8E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD6C288CD4
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018A1BE86A;
	Fri, 16 Aug 2024 14:37:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D01BE874;
	Fri, 16 Aug 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819068; cv=none; b=aNadJXsJ7GZ9UYXVhMeDZgs3C+8Nypab8Ths16NotH+4V4gSWEBx11GlTR5n30HEG8MEN30ZoWfMGrJW97bmbkYODqohFwdTl8AD2OupG+luIStrLQl97yAs8IJUnVTavsNLUEpD+ND8WfaQ6GyOGUf4BfRC7dGLdglmfQ6cba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819068; c=relaxed/simple;
	bh=Byt1zoXBB7tbRE1Z7pCXViKFciqFPibE+/C8OmNKnow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GivJRqfJ9ItaIf3UBWk9yjxtXr9FeHQRekU/ZVrjgU5IffU0RbYIHq0Oz0EO5ml0hRyp4tXnC/DV0qkdGUF6bhlRnZbH4tgR56PWuXrCDmgQQCpjvVF2Vmi8BpgzQAuuzFNub9j1Wl0L26TqzQ/Zfmn1v0Eqf/NVDO4lt+kSwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1r2rNSz9sSK;
	Fri, 16 Aug 2024 16:37:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CWmBAs4xDq_e; Fri, 16 Aug 2024 16:37:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1p434yz9rvV;
	Fri, 16 Aug 2024 16:37:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 77EF58B764;
	Fri, 16 Aug 2024 16:37:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id H7XpVLTItS-Q; Fri, 16 Aug 2024 16:37:02 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A71118B776;
	Fri, 16 Aug 2024 16:37:01 +0200 (CEST)
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
Subject: [PATCH 9/9] selftests: [NOT TO BE MERGED] Modifications for testing VDSO getrandom implementation on PPC32
Date: Fri, 16 Aug 2024 16:36:56 +0200
Message-ID: <376843e024ffa73793e8ed99b72d299c6b239799.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819012; l=4941; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Byt1zoXBB7tbRE1Z7pCXViKFciqFPibE+/C8OmNKnow=; b=0TkkqDKBkMMgL0ugpEAIOflzNK0D+cMm8lg8Wj+L/em3AddbhyydfpVg0Uc1yaCGhlbwMZx9z ux/X3n02YZGAOdDI+RT4hyUEpPrGZEF6i58grcim8hG8jyssOxRE0TY
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

arch/.../entry/vdso/ is specific to x86. Every architecture has a
different path. On powerpc it is in arch/.../kernel/vdso/

vdso_test_getrandom is a bit too long with 25000000.

Something is wrong with macros INT_MAX ... :

In file included from /home/chleroy/linux-powerpc/include/linux/limits.h:7,
                 from /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/local_lim.h:38,
                 from /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/posix1_lim.h:161,
                 from /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/limits.h:195,
                 from /opt/powerpc64-e5500--glibc--stable-2024.02-1/lib/gcc/powerpc64-buildroot-linux-gnu/12.3.0/include-fixed/limits.h:203,
                 from /opt/powerpc64-e5500--glibc--stable-2024.02-1/lib/gcc/powerpc64-buildroot-linux-gnu/12.3.0/include-fixed/syslimits.h:7,
                 from /opt/powerpc64-e5500--glibc--stable-2024.02-1/lib/gcc/powerpc64-buildroot-linux-gnu/12.3.0/include-fixed/limits.h:34,
                 from /tmp/sodium/usr/local/include/sodium/export.h:7,
                 from /tmp/sodium/usr/local/include/sodium/crypto_stream_chacha20.h:14,
                 from vdso_test_chacha.c:6:
/opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
   99 | # if INT_MAX == 32767
      |      ^~~~~~~
/opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
  102 | #  if INT_MAX == 2147483647
      |       ^~~~~~~
/opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
  126 | # if LONG_MAX == 2147483647
      |      ^~~~~~~~

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/vdso/limits.h                              | 4 ++--
 tools/testing/selftests/vDSO/Makefile              | 2 +-
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/vdso/limits.h b/include/vdso/limits.h
index 0197888ad0e0..b0459332e45f 100644
--- a/include/vdso/limits.h
+++ b/include/vdso/limits.h
@@ -5,10 +5,10 @@
 #define USHRT_MAX	((unsigned short)~0U)
 #define SHRT_MAX	((short)(USHRT_MAX >> 1))
 #define SHRT_MIN	((short)(-SHRT_MAX - 1))
-#define INT_MAX		((int)(~0U >> 1))
+#define INT_MAX		2147483647
 #define INT_MIN		(-INT_MAX - 1)
 #define UINT_MAX	(~0U)
-#define LONG_MAX	((long)(~0UL >> 1))
+#define LONG_MAX	2147483647
 #define LONG_MIN	(-LONG_MAX - 1)
 #define ULONG_MAX	(~0UL)
 #define LLONG_MAX	((long long)(~0ULL >> 1))
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 3de8e7e052ae..8010e7be66c6 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -40,7 +40,7 @@ $(OUTPUT)/vdso_test_getrandom: parse_vdso.c
 $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          -isystem $(top_srcdir)/include/uapi
 
-$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/arch/$(ARCH)/entry/vdso/vgetrandom-chacha.S
+$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/arch/$(ARCH)/kernel/vdso/vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -isystem $(top_srcdir)/arch/$(ARCH)/include \
                                       -isystem $(top_srcdir)/include \
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 05122425a873..f25301c9d46b 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -115,9 +115,9 @@ static void vgetrandom_init(void)
 		exit(KSFT_SKIP);
 	}
 	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
-	grnd_ctx.fn = (__typeof__(grnd_ctx.fn))vdso_sym("LINUX_2.6", "__vdso_getrandom");
+	grnd_ctx.fn = (__typeof__(grnd_ctx.fn))vdso_sym("LINUX_2.6.15", "__kernel_getrandom");
 	if (!grnd_ctx.fn) {
-		printf("__vdso_getrandom is missing!\n");
+		printf("__kernel_getrandom is missing!\n");
 		exit(KSFT_FAIL);
 	}
 	if (grnd_ctx.fn(NULL, 0, 0, &grnd_ctx.params, ~0UL) != 0) {
@@ -146,7 +146,7 @@ static ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
 	return grnd_ctx.fn(buf, len, flags, state, grnd_ctx.params.size_of_opaque_state);
 }
 
-enum { TRIALS = 25000000, THREADS = 256 };
+enum { TRIALS = 2500000, THREADS = 256 };
 
 static void *test_vdso_getrandom(void *)
 {
-- 
2.44.0


