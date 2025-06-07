Return-Path: <linux-arch+bounces-12269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4860AD0F50
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 22:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6392B3AE6FE
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3377218AC3;
	Sat,  7 Jun 2025 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1FhhuAi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7991218821;
	Sat,  7 Jun 2025 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749326849; cv=none; b=JIfWYoKCBddwnCEuc3Nd5eXeeCVVEvvCBcypij4hrjvUdfdyUotpaVCndBjjY7V0lZq+j4fpqV+Ig+7iUwT1TZXZcjl9dtSEMCgulDKHkACa67LC7+uOZVnT2Fq0gKkSwZCC51MObShiSLTdxi5lX5Wj568nlTm5rNLbYC8sEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749326849; c=relaxed/simple;
	bh=yLUp/jnRDPRJYe2ElHSUe7azlBkiNfeDfNdSKo75+q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8hITkiMIFeh3VJ0CX5/a8aSX/sTM88uyGYLWxtiKj9EMd5HAC3sBhueRemT8eekGoiYnYAlVqosbRVDmCt38JkZRoVo32v944YLl6U0oJOvdcRB33jIJCYXh53v+54wZ+kIgVjpAKjoBUXnq1tKDPk651uzobHsfgEXpwnespE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1FhhuAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B85C4CEF4;
	Sat,  7 Jun 2025 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749326849;
	bh=yLUp/jnRDPRJYe2ElHSUe7azlBkiNfeDfNdSKo75+q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1FhhuAiTrZ3n1+2RxOIsHAMGSJ/VjobP7NJfQNN0j/NBFbwNgGFUyusJmRjkKbXS
	 sqWh1Vqgcop8SjWbs6LXUgNLslH9vJAaJtRSlUYVblMBS0RiVdEhJomtVaMvtV8ZOa
	 PEHblLWQdMquqQZGguOsB3PGpaG1D6iMt3eqwjzhDYP/ljmb10RAveSRuslbu0TNpU
	 aXvLzJN+nKuiGXJjGUMUMH4iyFPeV5RkG3XLHj627tTQZ05KelNWJFE8NxxO5DTTAN
	 /pAmDXiq2dwYEPh4cjU29Xt59sFxxmxlJaZ8E/hzV8XcP6IZjjcVaxjEm3WyRFm4Z6
	 8pchieYF/5jfg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 02/12] lib/crc: prepare for arch-optimized code in subdirs of lib/crc/
Date: Sat,  7 Jun 2025 13:04:44 -0700
Message-ID: <20250607200454.73587-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607200454.73587-1-ebiggers@kernel.org>
References: <20250607200454.73587-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Rework how lib/crc/ supports arch-optimized code.  First, instead of the
arch-optimized CRC code being in arch/$(SRCARCH)/lib/, it will now be in
lib/crc/$(SRCARCH)/.  Second, the API functions (e.g. crc32c()),
arch-optimized functions (e.g. crc32c_arch()), and generic functions
(e.g. crc32c_base()) will now be part of a single module for each CRC
type, allowing better inlining and dead code elimination.  The second
change is made possible by the first.

As an example, consider CONFIG_CRC32=m on x86.  We'll now have just
crc32.ko instead of both crc32-x86.ko and crc32.ko.  The two modules
were already coupled together and always both got loaded together via
direct symbol dependency, so the separation provided no benefit.

Note: later I'd like to apply the same design to lib/crypto/ too, where
often the API functions are out-of-line so this will work even better.
In those cases, for each algorithm we currently have 3 modules all
coupled together, e.g. libsha256.ko, libsha256-generic.ko, and
sha256-x86.ko.  We should have just one, inline things properly, and
rely on the compiler's dead code elimination to decide the inclusion of
the generic code instead of manually setting it via kconfig.

Having arch-specific code outside arch/ was somewhat controversial when
Zinc proposed it back in 2018.  But I don't think the concerns are
warranted.  It's better from a technical perspective, as it enables the
improvements mentioned above.  This model is already successfully used
in other places in the kernel such as lib/raid6/.  The community of each
architecture still remains free to work on the code, even if it's not in
arch/.  At the time there was also a desire to put the library code in
the same files as the old-school crypto API, but that was a mistake; now
that the library is separate, that's no longer a constraint either.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/core-api/kernel-api.rst       |  2 +-
 MAINTAINERS                                 |  1 -
 include/linux/crc-t10dif.h                  | 10 +--
 include/linux/crc32.h                       | 30 +--------
 include/linux/crc64.h                       | 19 +-----
 lib/crc/Kconfig                             | 12 ++--
 lib/crc/Makefile                            | 20 +++++-
 lib/crc/{crc-t10dif.c => crc-t10dif-main.c} | 37 ++++++++---
 lib/crc/{crc32.c => crc32-main.c}           | 69 +++++++++++++++++----
 lib/crc/{crc64.c => crc64-main.c}           | 47 +++++++++++---
 10 files changed, 158 insertions(+), 89 deletions(-)
 rename lib/crc/{crc-t10dif.c => crc-t10dif-main.c} (78%)
 rename lib/crc/{crc32.c => crc32-main.c} (58%)
 rename lib/crc/{crc64.c => crc64-main.c} (66%)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index c4642d9f13a9c..9c8370891a39b 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -146,11 +146,11 @@ CRC Functions
    :export:
 
 .. kernel-doc:: lib/crc/crc16.c
    :export:
 
-.. kernel-doc:: lib/crc/crc32.c
+.. kernel-doc:: lib/crc/crc32-main.c
 
 .. kernel-doc:: lib/crc/crc-ccitt.c
    :export:
 
 .. kernel-doc:: lib/crc/crc-itu-t.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 05ff204b016c5..a729d80594557 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6356,11 +6356,10 @@ M:	Eric Biggers <ebiggers@kernel.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc-next
 F:	Documentation/staging/crc*
-F:	arch/*/lib/crc*
 F:	include/linux/crc*
 F:	lib/crc/
 F:	scripts/gen-crc-consts.py
 
 CREATIVE SB0540
diff --git a/include/linux/crc-t10dif.h b/include/linux/crc-t10dif.h
index a559fdff3f7e2..ecc8bc2dd7f4c 100644
--- a/include/linux/crc-t10dif.h
+++ b/include/linux/crc-t10dif.h
@@ -2,19 +2,11 @@
 #ifndef _LINUX_CRC_T10DIF_H
 #define _LINUX_CRC_T10DIF_H
 
 #include <linux/types.h>
 
-u16 crc_t10dif_arch(u16 crc, const u8 *p, size_t len);
-u16 crc_t10dif_generic(u16 crc, const u8 *p, size_t len);
-
-static inline u16 crc_t10dif_update(u16 crc, const u8 *p, size_t len)
-{
-	if (IS_ENABLED(CONFIG_CRC_T10DIF_ARCH))
-		return crc_t10dif_arch(crc, p, len);
-	return crc_t10dif_generic(crc, p, len);
-}
+u16 crc_t10dif_update(u16 crc, const u8 *p, size_t len);
 
 static inline u16 crc_t10dif(const u8 *p, size_t len)
 {
 	return crc_t10dif_update(0, p, len);
 }
diff --git a/include/linux/crc32.h b/include/linux/crc32.h
index 36bbc0405aa04..22dbe7144eb44 100644
--- a/include/linux/crc32.h
+++ b/include/linux/crc32.h
@@ -3,37 +3,13 @@
 #define _LINUX_CRC32_H
 
 #include <linux/types.h>
 #include <linux/bitrev.h>
 
-u32 crc32_le_arch(u32 crc, const u8 *p, size_t len);
-u32 crc32_le_base(u32 crc, const u8 *p, size_t len);
-u32 crc32_be_arch(u32 crc, const u8 *p, size_t len);
-u32 crc32_be_base(u32 crc, const u8 *p, size_t len);
-u32 crc32c_arch(u32 crc, const u8 *p, size_t len);
-u32 crc32c_base(u32 crc, const u8 *p, size_t len);
-
-static inline u32 crc32_le(u32 crc, const void *p, size_t len)
-{
-	if (IS_ENABLED(CONFIG_CRC32_ARCH))
-		return crc32_le_arch(crc, p, len);
-	return crc32_le_base(crc, p, len);
-}
-
-static inline u32 crc32_be(u32 crc, const void *p, size_t len)
-{
-	if (IS_ENABLED(CONFIG_CRC32_ARCH))
-		return crc32_be_arch(crc, p, len);
-	return crc32_be_base(crc, p, len);
-}
-
-static inline u32 crc32c(u32 crc, const void *p, size_t len)
-{
-	if (IS_ENABLED(CONFIG_CRC32_ARCH))
-		return crc32c_arch(crc, p, len);
-	return crc32c_base(crc, p, len);
-}
+u32 crc32_le(u32 crc, const void *p, size_t len);
+u32 crc32_be(u32 crc, const void *p, size_t len);
+u32 crc32c(u32 crc, const void *p, size_t len);
 
 /*
  * crc32_optimizations() returns flags that indicate which CRC32 library
  * functions are using architecture-specific optimizations.  Unlike
  * IS_ENABLED(CONFIG_CRC32_ARCH) it takes into account the different CRC32
diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index b6aa290a79312..fc0c06ab1993c 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -2,28 +2,18 @@
 #ifndef _LINUX_CRC64_H
 #define _LINUX_CRC64_H
 
 #include <linux/types.h>
 
-u64 crc64_be_arch(u64 crc, const u8 *p, size_t len);
-u64 crc64_be_generic(u64 crc, const u8 *p, size_t len);
-u64 crc64_nvme_arch(u64 crc, const u8 *p, size_t len);
-u64 crc64_nvme_generic(u64 crc, const u8 *p, size_t len);
-
 /**
  * crc64_be - Calculate bitwise big-endian ECMA-182 CRC64
  * @crc: seed value for computation. 0 or (u64)~0 for a new CRC calculation,
  *       or the previous crc64 value if computing incrementally.
  * @p: pointer to buffer over which CRC64 is run
  * @len: length of buffer @p
  */
-static inline u64 crc64_be(u64 crc, const void *p, size_t len)
-{
-	if (IS_ENABLED(CONFIG_CRC64_ARCH))
-		return crc64_be_arch(crc, p, len);
-	return crc64_be_generic(crc, p, len);
-}
+u64 crc64_be(u64 crc, const void *p, size_t len);
 
 /**
  * crc64_nvme - Calculate CRC64-NVME
  * @crc: seed value for computation. 0 for a new CRC calculation, or the
  *	 previous crc64 value if computing incrementally.
@@ -31,13 +21,8 @@ static inline u64 crc64_be(u64 crc, const void *p, size_t len)
  * @len: length of buffer @p
  *
  * This computes the CRC64 defined in the NVME NVM Command Set Specification,
  * *including the bitwise inversion at the beginning and end*.
  */
-static inline u64 crc64_nvme(u64 crc, const void *p, size_t len)
-{
-	if (IS_ENABLED(CONFIG_CRC64_ARCH))
-		return ~crc64_nvme_arch(~crc, p, len);
-	return ~crc64_nvme_generic(~crc, p, len);
-}
+u64 crc64_nvme(u64 crc, const void *p, size_t len);
 
 #endif /* _LINUX_CRC64_H */
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index e0e7168b74c75..e049f01a4d2c8 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -46,12 +46,12 @@ config CRC_T10DIF
 
 config ARCH_HAS_CRC_T10DIF
 	bool
 
 config CRC_T10DIF_ARCH
-	tristate
-	default CRC_T10DIF if ARCH_HAS_CRC_T10DIF && CRC_OPTIMIZATIONS
+	bool
+	depends on CRC_T10DIF && CRC_OPTIMIZATIONS
 
 config CRC32
 	tristate
 	select BITREVERSE
 	help
@@ -60,12 +60,12 @@ config CRC32
 
 config ARCH_HAS_CRC32
 	bool
 
 config CRC32_ARCH
-	tristate
-	default CRC32 if ARCH_HAS_CRC32 && CRC_OPTIMIZATIONS
+	bool
+	depends on CRC32 && CRC_OPTIMIZATIONS
 
 config CRC64
 	tristate
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
@@ -73,12 +73,12 @@ config CRC64
 
 config ARCH_HAS_CRC64
 	bool
 
 config CRC64_ARCH
-	tristate
-	default CRC64 if ARCH_HAS_CRC64 && CRC_OPTIMIZATIONS
+	bool
+	depends on CRC64 && CRC_OPTIMIZATIONS
 
 config CRC_OPTIMIZATIONS
 	bool "Enable optimized CRC implementations" if EXPERT
 	default y
 	help
diff --git a/lib/crc/Makefile b/lib/crc/Makefile
index ff4c30dda4528..926edc3b035f6 100644
--- a/lib/crc/Makefile
+++ b/lib/crc/Makefile
@@ -6,20 +6,36 @@ obj-$(CONFIG_CRC4) += crc4.o
 obj-$(CONFIG_CRC7) += crc7.o
 obj-$(CONFIG_CRC8) += crc8.o
 obj-$(CONFIG_CRC16) += crc16.o
 obj-$(CONFIG_CRC_CCITT) += crc-ccitt.o
 obj-$(CONFIG_CRC_ITU_T) += crc-itu-t.o
+
 obj-$(CONFIG_CRC_T10DIF) += crc-t10dif.o
+crc-t10dif-y := crc-t10dif-main.o
+ifeq ($(CONFIG_CRC_T10DIF_ARCH),y)
+CFLAGS_crc-t10dif-main.o += -I$(src)/$(SRCARCH)
+endif
+
 obj-$(CONFIG_CRC32) += crc32.o
+crc32-y := crc32-main.o
+ifeq ($(CONFIG_CRC32_ARCH),y)
+CFLAGS_crc32-main.o += -I$(src)/$(SRCARCH)
+endif
+
 obj-$(CONFIG_CRC64) += crc64.o
+crc64-y := crc64-main.o
+ifeq ($(CONFIG_CRC64_ARCH),y)
+CFLAGS_crc64-main.o += -I$(src)/$(SRCARCH)
+endif
+
 obj-y += tests/
 
 hostprogs := gen_crc32table gen_crc64table
 clean-files := crc32table.h crc64table.h
 
-$(obj)/crc32.o: $(obj)/crc32table.h
-$(obj)/crc64.o: $(obj)/crc64table.h
+$(obj)/crc32-main.o: $(obj)/crc32table.h
+$(obj)/crc64-main.o: $(obj)/crc64table.h
 
 quiet_cmd_crc32 = GEN     $@
       cmd_crc32 = $< > $@
 
 quiet_cmd_crc64 = GEN     $@
diff --git a/lib/crc/crc-t10dif.c b/lib/crc/crc-t10dif-main.c
similarity index 78%
rename from lib/crc/crc-t10dif.c
rename to lib/crc/crc-t10dif-main.c
index 311c2ab829f15..08f1f1042a712 100644
--- a/lib/crc/crc-t10dif.c
+++ b/lib/crc/crc-t10dif-main.c
@@ -48,18 +48,41 @@ static const u16 t10_dif_crc_table[256] = {
 	0xA415, 0x2FA2, 0x38CC, 0xB37B, 0x1610, 0x9DA7, 0x8AC9, 0x017E,
 	0x1F65, 0x94D2, 0x83BC, 0x080B, 0xAD60, 0x26D7, 0x31B9, 0xBA0E,
 	0xF0D8, 0x7B6F, 0x6C01, 0xE7B6, 0x42DD, 0xC96A, 0xDE04, 0x55B3
 };
 
-u16 crc_t10dif_generic(u16 crc, const u8 *p, size_t len)
+static inline __maybe_unused u16
+crc_t10dif_generic(u16 crc, const u8 *p, size_t len)
 {
-	size_t i;
+	while (len--)
+		crc = (crc << 8) ^ t10_dif_crc_table[(crc >> 8) ^ *p++];
+	return crc;
+}
 
-	for (i = 0; i < len; i++)
-		crc = (crc << 8) ^ t10_dif_crc_table[(crc >> 8) ^ p[i]];
+#ifdef CONFIG_CRC_T10DIF_ARCH
+#include "crc-t10dif.h" /* $(SRCARCH)/crc-t10dif.h */
+#else
+#define crc_t10dif_arch crc_t10dif_generic
+#endif
 
-	return crc;
+u16 crc_t10dif_update(u16 crc, const u8 *p, size_t len)
+{
+	return crc_t10dif_arch(crc, p, len);
+}
+EXPORT_SYMBOL(crc_t10dif_update);
+
+#ifdef crc_t10dif_mod_init_arch
+static int __init crc_t10dif_mod_init(void)
+{
+	crc_t10dif_mod_init_arch();
+	return 0;
+}
+subsys_initcall(crc_t10dif_mod_init);
+
+static void __exit crc_t10dif_mod_exit(void)
+{
 }
-EXPORT_SYMBOL(crc_t10dif_generic);
+module_exit(crc_t10dif_mod_exit);
+#endif
 
-MODULE_DESCRIPTION("T10 DIF CRC calculation");
+MODULE_DESCRIPTION("CRC-T10DIF library functions");
 MODULE_LICENSE("GPL");
diff --git a/lib/crc/crc32.c b/lib/crc/crc32-main.c
similarity index 58%
rename from lib/crc/crc32.c
rename to lib/crc/crc32-main.c
index 6811b37df2aad..b86ee66075d0e 100644
--- a/lib/crc/crc32.c
+++ b/lib/crc/crc32-main.c
@@ -28,32 +28,77 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
 #include "crc32table.h"
 
-MODULE_AUTHOR("Matt Domsch <Matt_Domsch@dell.com>");
-MODULE_DESCRIPTION("Various CRC32 calculations");
-MODULE_LICENSE("GPL");
-
-u32 crc32_le_base(u32 crc, const u8 *p, size_t len)
+static inline __maybe_unused u32
+crc32_le_base(u32 crc, const u8 *p, size_t len)
 {
 	while (len--)
 		crc = (crc >> 8) ^ crc32table_le[(crc & 255) ^ *p++];
 	return crc;
 }
-EXPORT_SYMBOL(crc32_le_base);
 
-u32 crc32c_base(u32 crc, const u8 *p, size_t len)
+static inline __maybe_unused u32
+crc32_be_base(u32 crc, const u8 *p, size_t len)
 {
 	while (len--)
-		crc = (crc >> 8) ^ crc32ctable_le[(crc & 255) ^ *p++];
+		crc = (crc << 8) ^ crc32table_be[(crc >> 24) ^ *p++];
 	return crc;
 }
-EXPORT_SYMBOL(crc32c_base);
 
-u32 crc32_be_base(u32 crc, const u8 *p, size_t len)
+static inline __maybe_unused u32
+crc32c_base(u32 crc, const u8 *p, size_t len)
 {
 	while (len--)
-		crc = (crc << 8) ^ crc32table_be[(crc >> 24) ^ *p++];
+		crc = (crc >> 8) ^ crc32ctable_le[(crc & 255) ^ *p++];
 	return crc;
 }
-EXPORT_SYMBOL(crc32_be_base);
+
+#ifdef CONFIG_CRC32_ARCH
+#include "crc32.h" /* $(SRCARCH)/crc32.h */
+
+u32 crc32_optimizations(void)
+{
+	return crc32_optimizations_arch();
+}
+EXPORT_SYMBOL(crc32_optimizations);
+#else
+#define crc32_le_arch crc32_le_base
+#define crc32_be_arch crc32_be_base
+#define crc32c_arch crc32c_base
+#endif
+
+u32 crc32_le(u32 crc, const void *p, size_t len)
+{
+	return crc32_le_arch(crc, p, len);
+}
+EXPORT_SYMBOL(crc32_le);
+
+u32 crc32_be(u32 crc, const void *p, size_t len)
+{
+	return crc32_be_arch(crc, p, len);
+}
+EXPORT_SYMBOL(crc32_be);
+
+u32 crc32c(u32 crc, const void *p, size_t len)
+{
+	return crc32c_arch(crc, p, len);
+}
+EXPORT_SYMBOL(crc32c);
+
+#ifdef crc32_mod_init_arch
+static int __init crc32_mod_init(void)
+{
+	crc32_mod_init_arch();
+	return 0;
+}
+subsys_initcall(crc32_mod_init);
+
+static void __exit crc32_mod_exit(void)
+{
+}
+module_exit(crc32_mod_exit);
+#endif
+
+MODULE_DESCRIPTION("CRC32 library functions");
+MODULE_LICENSE("GPL");
diff --git a/lib/crc/crc64.c b/lib/crc/crc64-main.c
similarity index 66%
rename from lib/crc/crc64.c
rename to lib/crc/crc64-main.c
index 5b1b17057f0ae..e4a6d879e84c3 100644
--- a/lib/crc/crc64.c
+++ b/lib/crc/crc64-main.c
@@ -36,23 +36,56 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/crc64.h>
 #include "crc64table.h"
 
-MODULE_DESCRIPTION("CRC64 calculations");
-MODULE_LICENSE("GPL v2");
-
-u64 crc64_be_generic(u64 crc, const u8 *p, size_t len)
+static inline __maybe_unused u64
+crc64_be_generic(u64 crc, const u8 *p, size_t len)
 {
 	while (len--)
 		crc = (crc << 8) ^ crc64table[(crc >> 56) ^ *p++];
 	return crc;
 }
-EXPORT_SYMBOL_GPL(crc64_be_generic);
 
-u64 crc64_nvme_generic(u64 crc, const u8 *p, size_t len)
+static inline __maybe_unused u64
+crc64_nvme_generic(u64 crc, const u8 *p, size_t len)
 {
 	while (len--)
 		crc = (crc >> 8) ^ crc64nvmetable[(crc & 0xff) ^ *p++];
 	return crc;
 }
-EXPORT_SYMBOL_GPL(crc64_nvme_generic);
+
+#ifdef CONFIG_CRC64_ARCH
+#include "crc64.h" /* $(SRCARCH)/crc64.h */
+#else
+#define crc64_be_arch crc64_be_generic
+#define crc64_nvme_arch crc64_nvme_generic
+#endif
+
+u64 crc64_be(u64 crc, const void *p, size_t len)
+{
+	return crc64_be_arch(crc, p, len);
+}
+EXPORT_SYMBOL_GPL(crc64_be);
+
+u64 crc64_nvme(u64 crc, const void *p, size_t len)
+{
+	return ~crc64_nvme_arch(~crc, p, len);
+}
+EXPORT_SYMBOL_GPL(crc64_nvme);
+
+#ifdef crc64_mod_init_arch
+static int __init crc64_mod_init(void)
+{
+	crc64_mod_init_arch();
+	return 0;
+}
+subsys_initcall(crc64_mod_init);
+
+static void __exit crc64_mod_exit(void)
+{
+}
+module_exit(crc64_mod_exit);
+#endif
+
+MODULE_DESCRIPTION("CRC64 library functions");
+MODULE_LICENSE("GPL");
-- 
2.49.0


